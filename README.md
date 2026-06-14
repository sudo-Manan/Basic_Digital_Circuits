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
│   │   └── mux2to1.sv              # 2:1 MUX using CMOS switch network
│   │
│   ├── gate_level_model/            # Built using Verilog gate primitives
│   │   ├── gates_from_primitives/
│   │   │   ├── nand_based/          # AND, OR, NOT, XOR from NAND gates
│   │   │   └── nor_based/           # AND, OR, NOT, XOR from NOR gates
│   │   ├── arithmetic_logic/        # Half/Full adder, Half/Full subtractor, RCA
│   │   └── data_txn/               # 2:1 MUX
│   │
│   ├── dataflow_model/              # assign-based combinational logic
│   │   ├── arithmetic_logic/        # 4-bit CLA adder-subtractor
│   │   ├── code_converters/         # Binary ↔ Gray code
│   │   └── data_txn/               # 2:1, 4:1, 8:1 MUX
│   │
│   └── behavioral_model/            # always_comb / case-based
│       └── data_txn/               # Parameterized 2:1, 4:1, 8:1 MUX
│
└── sequential_logic/
    └── Latch_and_FF/
        ├── Latches/                 # SR latch (NAND/NOR), D latch
        └── FF/                      # SR FF, D FF
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
- [x] 2:1 MUX

#### Dataflow
- [x] 4-bit CLA Adder-Subtractor (`m=0` add, `m=1` subtract, 2's complement)
- [x] Binary-to-Gray converter
- [x] Gray-to-Binary converter
- [x] 2:1, 4:1, 8:1 MUX (parameterized width)

#### Behavioral
- [x] 2:1, 4:1, 8:1 MUX (parameterized width, `always_comb` + `case`)

### Sequential Logic

#### Latches
- [x] SR Latch — NOR-based (active high)
- [x] SR Latch — NAND-based (active low)
- [x] D Latch

#### Flip-Flops
- [x] D Flip-Flop
- [x] SR Flip-Flop
- [x] JK Flip-Flop
- [ ] T Flip-Flop

### Next Steps
- [x] Gray-to-Binary converter
- [x] Missing testbenches (mux2to1, mux4to1 behavioral and dataflow)
- [x] Edge Detectors
- [ ] Update resets to active low
- [ ] Start building Registers
- [ ] Start building Counters 
- [ ] FSM (Moore / Mealy example)
- [ ] Tri-state buffer
- [ ] Missing testbenches (mux8to1 behavioral and dataflow)

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

---

## Design Notes

- All sequential logic uses `always_ff` (FFs), `always_latch` (latches), `always_comb` (combinational) — never plain `always`
- `assign` is used strictly at module scope, never inside procedural blocks
- Non-blocking `<=` inside `always_ff`; blocking `=` inside `always_latch` and `always_comb`
- Switch-level models use `supply1`/`supply0` for VDD/VSS
- Parameterized modules use `#(parameter WIDTH = N)` for easy width scaling
- Each abstraction level is kept isolated - modules of the same name in different folders are intentionally separate implementations, not meant to be compiled together