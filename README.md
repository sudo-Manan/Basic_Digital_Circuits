# Basic Digital Circuits

A structured library of digital logic circuits implemented in SystemVerilog, built from first principles across all abstraction levels — from CMOS transistor switch-level up to behavioral RTL.

Built for learning, interview preparation, and as a foundation for larger RTL projects.

**Author:** Manan Jain  
**License:** CERN-OHL-W-2.0 (Weakly Reciprocal) — See [LICENSE](./LICENSE)

---

## Tools

| Purpose | Tool |
|---|---|
| Primary simulation & synthesis | AMD Vivado (Xilinx) |
| Open-source simulation | Icarus Verilog (`iverilog` + `vvp`) |
| Open-source synthesis | Yosys |
| Waveform viewer (open-source) | Surfer (VS Code extension) |
| HDL editing | VS Code + TerosHDL extension |
| Version control | Git + GitHub |

> **Note on `$dumpfile`/`$dumpvars`:** All testbenches have these commented out by default (Vivado workflow). Uncomment them if using Icarus Verilog or any open-source simulator that requires VCD generation.

---

## Repository Structure

```
Basic_Digital_Circuits/
│
├── combinational_logic/
│   ├── switch_level_model/          # CMOS transistor-level (pmos/nmos primitives)
│   │   ├── cmos_primitive_gates/    # NOT, NAND, NOR, AND, OR, XOR, XNOR, BUFF
│   │   └── mux2to1.sv               # 2:1 MUX using CMOS switch network
│   │
│   ├── gate_level_model/            # Built using Verilog gate primitives
│   │   ├── gates_from_primitives/
│   │   │   ├── nand_based/          # AND, OR, NOT, XOR from NAND gates
│   │   │   └── nor_based/           # AND, OR, NOT, XOR from NOR gates
│   │   ├── arithmetic_logic/        # Half/Full adder, Half/Full subtractor, RCA
│   │   └── data_txn/                # 2:1 MUX, 1:2 DEMUX
│   │
│   ├── dataflow_model/              # assign-based combinational logic
│   │   ├── arithmetic_logic/        # 4-bit CLA adder-subtractor, magnitude comparator
│   │   ├── code_converters/         # Binary <-> Gray code
│   │   └── data_txn/                # 2:1, 4:1, 8:1 MUX, 1:4 DEMUX, 3:8 Decoder
│   │
│   └── behavioral_model/            # always_comb / case-based
│       ├── arithmetic_logic/        # Magnitude comparator
│       └── data_txn/                # 2:1, 4:1, 8:1 MUX, 1:8 DEMUX, 8:3 Priority Encoder
│
└── sequential_logic/
    ├── Latch_and_FF/
    │   ├── Latches/                 # SR latch (NAND/NOR), D latch
    │   └── FF/                      # SR FF, D FF, JK FF, T FF
    ├── Registers/                   # N-bit register (genvar-built from D-FFs)
    └── edge_detectors/              # Rising, falling, and dual-edge detectors
```

---

## What's Implemented

### Combinational Logic

#### Switch Level (CMOS)
- [x] NOT, NAND, NOR, AND, OR, XOR, XNOR, Buffer — full CMOS topology using `pmos`/`nmos` primitives
- [x] 2:1 MUX — CMOS transmission gate based

#### Gate Level
- [x] AND, OR, NOT, XOR — from NAND primitives only
- [x] AND, OR, NOT, XOR — from NOR primitives only
- [x] Half Adder, Full Adder
- [x] Half Subtractor, Full Subtractor
- [x] Ripple Carry Adder-Subtractor (parameterized, N-bit)
- [x] 2:1 MUX, 1:2 DEMUX

#### Dataflow
- [x] 4-bit Carry-Lookahead Adder-Subtractor (`m=0` add, `m=1` subtract, 2's complement)
- [x] Magnitude Comparator (parameterized width)
- [x] Binary-to-Gray converter
- [x] Gray-to-Binary converter
- [x] 2:1, 4:1, 8:1 MUX (parameterized width) - with an alternate implementation for gate-count comparison
- [x] 1:4 DEMUX - shift-based and comparison-based variants
- [x] 3:8 Decoder - shift-based and explicit Boolean variants

#### Behavioral
- [x] Magnitude Comparator (`case (1'b1)`)
- [x] 2:1, 4:1, 8:1 MUX (parameterized width, `always_comb` + `case`)
- [x] 1:8 DEMUX - array-index and case-based variants
- [x] 8:3 Priority Encoder (`if-else` priority chain)

### Sequential Logic

#### Latches
- [x] SR Latch — NOR-based (active high)
- [x] SR Latch — NAND-based (active low)
- [x] D Latch

#### Flip-Flops
- [x] D Flip-Flop
- [x] SR Flip-Flop
- [x] JK Flip-Flop
- [x] T Flip-Flop

#### Registers
- [x] N-bit Register (parameterized, built from D-FFs via `generate`/`genvar`)
- [ ] Universal Shift Register

#### Edge Detector
- [x] Edge Detector (both rising and falling edges)
- [x] Positive Edge Detector
- [x] Negative Edge Detector

### Next Steps
- [ ] Universal Shift Register
- [ ] Counters
- [ ] FSM (Moore / Mealy example)
- [ ] Tri-state buffer
- [ ] Per-folder README files for remaining combinational/sequential subfolders
- [ ] Missing testbenches (all three edge detectors, d_ff, t_ff)

---

## How to Simulate

### Vivado (Primary)
1. Create a new project, add source files from the relevant folder
2. Add the corresponding `_tb.sv` as simulation source
3. Run Behavioral Simulation

### Icarus Verilog (Open-Source)
```bash
# Uncomment $dumpfile/$dumpvars in the testbench first, then:
iverilog -g2023 -o sim.vvp <module>.sv <module>_tb.sv
vvp sim.vvp
# Open the generated .vcd in Surfer or GTKWave
```

### Yosys (Synthesis / Schematic / Gate-Count Verification)
```bash
yosys -p "read_verilog -sv <module>.sv; synth; stat"
```
Used in this repo to empirically compare gate counts between alternate implementations of the same function (see Debugging & Verification Highlights below).

---

## Design Notes

- All sequential logic uses `always_ff` (FFs), `always_latch` (latches), `always_comb` (combinational) — never plain `always`
- `assign` is used strictly at module scope, never inside procedural blocks
- Non-blocking `<=` inside `always_ff`; blocking `=` inside `always_latch` and `always_comb`
- Switch-level models use `supply1`/`supply0` for VDD/VSS
- Parameterized modules use `#(parameter WIDTH = N)` for easy width scaling
- Each abstraction level is kept isolated - modules of the same name in different *abstraction-level* folders (switch/gate/dataflow/behavioral) are intentionally separate implementations of the same logical function, not meant to be compiled together. `mux2to1` and `mag_comp` in particular are implemented at every abstraction level deliberately, to demonstrate the same function expressed across the full design hierarchy from transistors to behavioral RTL.
- Within a single folder, alternate implementations of the same function are kept separate as `*_alt.sv` files with distinct module names (e.g. `mux2to1` vs `mux2to1_alt`), so the primary and alternate versions can be compiled and compared side by side without name collisions.

---

## Debugging & Verification Highlights

A few non-trivial issues found and resolved during development - kept here as a record of debugging methodology, not just final working code:

- **CLA carry-lookahead operator precedence bug**: the original carry equations (`c[2]`, `c[3]`, `c[4]`) were written with nested parentheses that caused `&` to bind incorrectly, silently dropping a `propagate` term from each carry stage. The bug only manifested for specific input patterns (even `b` values with certain bit combinations during subtraction), passing all "obvious" test cases while failing an exhaustive sweep. Found via systematic back-solving from incorrect testbench output, then fixed by flattening the equations into their canonical sum-of-products form.
- **Yosys unpacked vs. packed port rejection**: `output logic y [7:0]` (unpacked array) is accepted by Vivado but rejected by Yosys's SystemVerilog frontend (`ERROR: input/output/inout ports cannot have unpacked dimensions`). Switching to `output logic [7:0] y` (packed vector) resolved schematic generation across both toolchains.
- **Shift-based vs. case-based decoder/demux gate-count comparison**: empirically verified via `yosys ... stat` that `assign y = 1 << sel` and an explicit per-output `case`/comparison-based description are not always logically equivalent after synthesis - RTL partitioning (one vector expression vs. several independent scalar `assign` statements) affects how much common sub-logic the optimizer can find and share, even when the underlying Boolean function is identical.
- **Module name collisions across alternate implementations**: early versions of `mag_comp_alt`, `demux1to8_alt`, `mux2to1_alt`, `decoder3to8_alt`, and `demux1to4_alt` reused the same module name as their primary-version counterpart in the same folder. This compiles fine in isolation but throws a duplicate-module error the moment both files are read together (e.g. by Yosys batch-reading a directory). Fixed by giving every alternate implementation a distinct `_alt` module name.