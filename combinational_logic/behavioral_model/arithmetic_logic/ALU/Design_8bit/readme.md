# ALU — 8-bit Arithmetic Logic Unit

A compact 8-bit ALU built from a 2-level carry-lookahead adder, parameterized multiplexers, and combinational logic. Designed for unsigned arithmetic with 8 operations encoded in a single 3-bit select line.

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
| `cout` | 1-bit | Output | Carry/borrow output from adder |

---

## Opcode Table

| `sel[2:0]` | Operation | Expression | Notes |
|---|---|---|---|
| `000` | AND | `a & b` | Bitwise AND |
| `001` | OR | `a \| b` | Bitwise OR |
| `010` | ADD | `a + b` | Unsigned addition, `cout=1` on overflow |
| `011` | CLR | `y = 0` | Output forced to zero; use to clear a register or pass zero downstream |
| `100` | AND-NOT | `a & ~b` | Bitwise AND with complement of B |
| `101` | OR-NOT | `a \| ~b` | Bitwise OR with complement of B |
| `110` | SUB | `a - b` | Unsigned subtraction via 2's complement; `cout=0` means borrow occurred |
| `111` | SLT | `a < b ? 1 : 0` | Unsigned set-less-than; `y[0]=1` if `a < b`, `y[7:1]=0` always |

**Note on `cout` semantics:** `cout` follows ARM/standard 2's-complement convention — `cout=1` means no borrow (a ≥ b), `cout=0` means borrow occurred (a < b). This is the inverse of x86's carry/borrow convention.

---

## Key Design Decisions

### 1. Single control bit drives both b-inversion and carry-in

`sel[2]` simultaneously:
- Controls `mux2to1_param`: selects `b` (sel[2]=0) or `~b` (sel[2]=1) as the adder's second operand
- Drives `cin` of `cla8`: sets carry-in to 0 (addition) or 1 (subtraction)

This is the standard 2's complement trick — inverting `b` and forcing `cin=1` is mathematically equivalent to computing `a + (~b + 1) = a - b`. One bit of the select line handles both, with no extra logic required.

A consequence of this encoding is that `sel[1:0]` selects the output operation, while `sel[2]` implicitly sets the arithmetic mode. The opcode space is therefore partitioned as:

```
sel[2]=0  →  ADD-mode group  (AND, OR, ADD, CLR)
sel[2]=1  →  SUB-mode group  (AND-NOT, OR-NOT, SUB, SLT)
```

### 2. CLA chaining via group P/G, not raw carry-out

`cla4` exports two group-level signals:

```systemverilog
assign P = &p;           // group propagate: all bits propagate
assign G = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);  // group generate
```

`cla8` uses these to compute the inter-nibble carry directly:

```systemverilog
assign c4_u7to4 = g0 | (p0 & cin);
```

This is the correct two-level CLA structure. The alternative — feeding `cout` of the lower block directly into `cin` of the upper block and leaving both blocks' internal `cin` logic untouched — breaks subtraction silently when the lower nibble underflows, because the upper block re-forces its carry-in rather than accepting the real inter-nibble borrow. Using group P/G avoids this entirely.

### 3. SLT via ~cout

Unsigned less-than is equivalent to the subtraction `a - b` producing a borrow:

```
a < b  →  borrow occurs  →  cout = 0  →  ~cout = 1
a ≥ b  →  no borrow       →  cout = 1  →  ~cout = 0
```

SLT is only meaningful when `sel[2]=1` (SUB mode), so the result is gated:

```systemverilog
result_slt = sel[MSB] ? {{(WIDTH-1){1'b0}}, ~result_cout} : {WIDTH{1'b0}};
```

When `sel[2]=0`, SLT output is forced to zero (CLR behavior for `sel=011`).

---

## Schematics

Three synthesis views are included in this folder, generated at different abstraction levels:

| File | Tool | Description |
|---|---|---|
| `alu8_schematic.svg` | Yosys (generic) | RTL/gate-level schematic using abstract primitives |
| `alu8_asic_schematic.svg` | Yosys + SkyWater 130nm | Technology-mapped to sky130 standard cells |
| `alu8_fpga_schematic.svg` | Yosys (`synth_xilinx`) | Mapped to Xilinx LUT primitives (Spartan-7 target) |

The FPGA view is the most practically relevant for simulation and verification on the Spartan-7 development board.

**FPGA resource utilization (Xilinx 7-series):**

| Resource | Count |
|---|---|
| LUT2 | 12 |
| LUT3 | 1 |
| Total LUTs | 13 (local, excluding CLA submodules) |

Full hierarchy (including `cla8` and `cla4`): ~25 LUTs total. Under 0.2% of available resources on a Spartan-7 XC7S25.

---

## Known Gaps

- **No testbench yet.** Functional verification is pending. Priority test cases once written: exhaustive ADD and SUB sweeps (all 256×256 input combinations), SLT boundary conditions (a=b, a=b-1, a=b+1), CLR opcode confirmation.
- **SLT is unsigned only.** Signed set-less-than requires `y = N ^ V` (negative flag XOR overflow flag) rather than `~cout`. This is a future addition if signed arithmetic support is needed.
- **No flag outputs (N, Z, C, V).** Only `cout` is exposed. A flag register wrapping this ALU would add N (sign bit of result), Z (result == 0), C (`cout`), and V (signed overflow) — straightforward extensions for a future version.
- **`generic_alu.sv` in the parent folder** is a superseded draft and will be deleted before this branch is merged.

---

## Files in This Folder

| File | Description |
|---|---|
| `alu8.sv` | Top-level ALU module |
| `cla4.sv` | 4-bit carry-lookahead adder with group P/G outputs |
| `cla8.sv` | 8-bit CLA built from two `cla4` instances |
| `mux2to1_param.sv` | Parameterized 2:1 mux (used for b/~b selection) |
| `mux4to1_param.sv` | Parameterized 4:1 mux (used for output selection) |
| `alu8_schematic.svg` | Generic gate-level schematic |
| `alu8_asic_schematic.svg` | SkyWater 130nm technology-mapped schematic |
| `alu8_fpga_schematic.svg` | Xilinx 7-series LUT-mapped schematic |