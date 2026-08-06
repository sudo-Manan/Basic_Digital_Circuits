# ALU — 8-bit Arithmetic Logic Unit

A compact 8-bit ALU built from a 2-level carry-lookahead adder, parameterized multiplexers, and combinational logic. Designed for unsigned arithmetic with 8 operations encoded in a single 3-bit select line.

Includes RTL, generic gate-level, ASIC (SkyWater 130nm), and FPGA (Xilinx UltraScale+) synthesis views — all generated from the same source files using an open-source toolchain.

---

## Module Hierarchy

```
alu8
├── mux2to1_param      (selects between b and ~b based on sel[2])
├── cla8               (8-bit carry-lookahead adder)
│   ├── cla4           (lower nibble [3:0] — exports group P, G)
│   └── cla4           (upper nibble [7:4] — uses group P, G from lower)
└── mux4to1_param      (selects final output based on sel[1:0])
```

---

## Port Description

| Port | Width | Direction | Description |
|---|---|---|---|
| `a` | 8-bit | Input | Operand A |
| `b` | 8-bit | Input | Operand B |
| `sel` | 3-bit | Input | Operation select |
| `y` | 8-bit | Output | Result |
| `cout` | 1-bit | Output | Carry/borrow from adder |

---

## Opcode Table

| `sel[2:0]` | Operation | Expression | Notes |
|---|---|---|---|
| `000` | AND | `a & b` | Bitwise AND |
| `001` | OR | `a \| b` | Bitwise OR |
| `010` | ADD | `a + b` | Unsigned addition; `cout=1` on overflow |
| `011` | CLR | `y = 0` | Forced zero output; use to clear a register or pass zero downstream |
| `100` | AND-NOT | `a & ~b` | Bitwise AND with complement of B |
| `101` | OR-NOT | `a \| ~b` | Bitwise OR with complement of B |
| `110` | SUB | `a - b` | Unsigned subtraction; `cout=0` means borrow occurred |
| `111` | SLT | `a < b ? 1 : 0` | Unsigned set-less-than; `y[0]=1` if `a < b`, `y[7:1]=0` always |

**Note on `cout` semantics:** follows ARM/standard 2's-complement convention — `cout=1` means no borrow (a ≥ b), `cout=0` means borrow occurred (a < b). This is the inverse of x86's carry/borrow flag.

---

## Key Design Decisions

### 1. Single control bit drives both b-inversion and carry-in

`sel[2]` simultaneously:
- Controls `mux2to1_param`: selects `b` (sel[2]=0) or `~b` (sel[2]=1) as the adder's second operand
- Drives `cin` of `cla8`: sets carry-in to 0 (addition) or 1 (subtraction)

This is the standard 2's complement trick — inverting `b` and forcing `cin=1` is mathematically equivalent to `a + (~b + 1) = a - b`. One bit of the select line handles both, with no extra control logic required.

A consequence of this encoding is that the opcode space splits cleanly along `sel[2]`:

```
sel[2]=0  →  ADD-mode group  (AND, OR, ADD, CLR)
sel[2]=1  →  SUB-mode group  (AND-NOT, OR-NOT, SUB, SLT)
```

### 2. CLA chaining via group P/G, not raw carry-out

`cla4` exports two group-level signals alongside the standard sum and carry:

```systemverilog
assign P = &p;   // group propagate: true when all bits propagate
assign G = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);
```

`cla8` uses these to compute the inter-nibble carry directly, without waiting for `cout` of the lower block to ripple:

```systemverilog
assign c4_u7to4 = g0 | (p0 & cin);
```

This is the correct two-level CLA structure. Chaining via raw `cout` and leaving each block's internal `cin` logic untouched would silently break subtraction whenever the lower nibble underflows, because the upper block would re-force its own carry-in instead of accepting the real borrow from below. The group P/G approach avoids this entirely.

### 3. SLT via ~cout

Unsigned less-than is equivalent to subtraction producing a borrow:

```
a < b  →  borrow occurs  →  cout = 0  →  ~cout = 1
a ≥ b  →  no borrow      →  cout = 1  →  ~cout = 0
```

The result is gated on `sel[2]` so it only appears in SUB mode:

```systemverilog
result_slt = sel[MSB] ? {{(WIDTH-1){1'b0}}, ~result_cout} : {WIDTH{1'b0}};
```

When `sel[2]=0`, this path forces zero — which also gives the CLR behavior for `sel=011`.

---

## Toolchain

This design was taken through the full open-source synthesis and schematic flow, from RTL to ASIC-mapped and FPGA-mapped netlists, using only open-source tools.

### 1. HDL — SystemVerilog

Files written manually: `cla4.sv`, `cla8.sv`, `mux2to1_param.sv`, `mux4to1_param.sv`, `alu8.sv`

### 2. Yosys — Synthesis, Optimization, Netlist Export

**RTL schematic (pre-synthesis):**
```bash
yosys -p "
  read_verilog -sv cla4.sv cla8.sv mux2to1_param.sv mux4to1_param.sv alu8.sv;
  hierarchy -top alu8;
  proc; opt -full; flatten;
  show -format svg -prefix alu8_schematic
"
```

**Generic gate-level synthesis + netlist:**
```bash
yosys -p "
  read_verilog -sv cla4.sv cla8.sv mux2to1_param.sv mux4to1_param.sv alu8.sv;
  hierarchy -top alu8;
  proc; opt;
  synth -top alu8;
  flatten;
  show -format svg -prefix alu8_asic_schematic;
  write_verilog -noattr synth_alu8.v
"
```

**ASIC synthesis with SkyWater 130nm PDK:**
```bash
yosys -p "
  read_verilog -sv cla4.sv cla8.sv mux2to1_param.sv mux4to1_param.sv alu8.sv;
  hierarchy -top alu8;
  proc; opt;
  synth -top alu8;
  abc -liberty sky130_fd_sc_hd__tt_025C_1v80.lib;
  flatten;
  write_verilog -noattr synth_alu8.v
"
```

**FPGA synthesis for UltraScale+ (aup_zu3 target):**
```bash
yosys -p "
  read_verilog -sv cla4.sv cla8.sv mux2to1_param.sv mux4to1_param.sv alu8.sv;
  hierarchy -top alu8;
  proc; opt;
  synth_xilinx -arch xcup -top alu8 -flatten;
  write_verilog -noattr synth_alu8_xilinx.v
"
```

**JSON netlist export (input for netlistsvg):**
```bash
yosys -p "
  read_verilog -sv cla4.sv cla8.sv mux2to1_param.sv mux4to1_param.sv alu8.sv;
  hierarchy -top alu8;
  proc; opt; flatten;
  write_json alu8.json
"
```

### 3. netlistsvg — Book-style Schematic Rendering

Converts the Yosys JSON netlist to a clean, readable SVG schematic in the style used by digital design textbooks.

**Install:**
```bash
npm install --prefix ~/.npm-global netlistsvg
echo 'export PATH="$HOME/.npm-global/node_modules/.bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

**Render:**
```bash
netlistsvg alu8.json -o alu8_schematic.svg
```

### 4. Tool Summary

| Tool | Purpose |
|---|---|
| SystemVerilog | HDL source |
| Yosys | Synthesis, optimization, netlist and schematic export |
| SkyWater 130nm PDK (`.lib`) | ASIC standard cell library for `abc` technology mapping |
| `synth_xilinx` | FPGA-targeted synthesis for Xilinx UltraScale+ |
| netlistsvg | Clean SVG schematic rendering from JSON netlist |
| npm | Package manager for netlistsvg |
| Git | Version control |

---

## Schematics

Three synthesis views are included, generated at different abstraction levels from the same source:

| File | Generated by | What it shows |
|---|---|---|
| `alu8_schematic.svg` | Yosys `show` (pre-synthesis) | RTL structure — module hierarchy visible |
| `alu8_asic_schematic.svg` | Yosys `synth` + netlistsvg | Generic gate-level (AND/OR/NOT/MUX primitives) |
| `alu8_fpga_schematic.svg` | `synth_xilinx` | Xilinx LUT-mapped for UltraScale+ fabric |

**FPGA resource utilization (Xilinx UltraScale+, local to `alu8` excluding submodules):**

| Resource | Count |
|---|---|
| LUT2 | 12 |
| LUT3 | 1 |
| **Total (full hierarchy)** | **~25 LUTs** |

Under 0.2% of available resources on the AUP-ZU3 board target.

---

## Files in This Folder

| File | Description |
|---|---|
| `alu8.sv` | Top-level ALU module |
| `cla4.sv` | 4-bit CLA adder with group P/G outputs for chaining |
| `cla8.sv` | 8-bit CLA built from two `cla4` instances via group P/G |
| `mux2to1_param.sv` | Parameterized 2:1 mux (b / ~b selection) |
| `mux4to1_param.sv` | Parameterized 4:1 mux (final output selection) |
| `alu8_schematic.svg` | RTL-level schematic (pre-synthesis) |
| `alu8_asic_schematic.svg` | Generic gate-level schematic |
| `alu8_fpga_schematic.svg` | Xilinx UltraScale+ LUT-mapped schematic |

**Not tracked in this repo (added to `.gitignore`):**
- `sky130_fd_sc_hd__tt_025C_1v80.lib` — SkyWater 130nm PDK standard cell library; not original work, too large to track. Download from the [SkyWater PDK repository](https://github.com/google/skywater-pdk) if needed.
- `synth_alu8.v`, `synth_alu8_xilinx.v` — synthesized netlists generated by Yosys; reproducible from source, not tracked.
- `alu8.json` — Yosys JSON netlist intermediate; reproducible from source, not tracked.

---

## Known Gaps

- **No testbench yet.** Priority once written: exhaustive ADD and SUB sweeps across all 256×256 input combinations, SLT boundary conditions (a=b, a=b-1, a=b+1), CLR opcode confirmation.
- **SLT is unsigned only.** Signed set-less-than requires `y = (N ^ V)` (negative flag XOR overflow flag) rather than `~cout`. A future version with flag outputs would support this naturally.
- **No N/Z/C/V flag outputs.** Only `cout` is currently exposed. A flag register wrapping this ALU would add N (MSB of result), Z (result==0), C (cout), and V (signed overflow) — straightforward extensions.