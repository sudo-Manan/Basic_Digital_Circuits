# Combinational Logic

Fundamental combinational circuits: adders, subtractors, and logic gates built from NAND primitives.

## Contents

### Adders
- **half_adder.sv** — 1-bit add without carry-in (Sum, Carry)
- **full_adder.sv** — 1-bit add with carry-in (Sum, Carry-out)
- **cla_adder.sv** — Carry Lookahead Adder, optimized for speed
- **cla_adder_parameterized.sv** — Configurable width CLA adder

### Subtractors
- **half_subtractor.sv** — 1-bit subtract without borrow-in
- **full_subtractor.sv** — 1-bit subtract with borrow-in

### Logic Gates (NAND-based)
- **my_nand.sv** — Primitive NAND gate using cmos logic (2 pmos and 2 nmos)
- **my_nand_not.sv** — NOT gate from NAND
- **my_nand_and.sv** — AND gate from NAND
- **my_nand_or.sv** — OR gate from NAND
- **my_nand_xor.sv** — XOR gate from NAND

## Design Notes
All circuits in this folder are **combinational**.
Logic gates are built from NAND primitives to demonstrate gate-level design.

## How to Use
1. Include the relevant `.sv` file in your Vivado project
2. Instantiate the module (see module definitions for I/O)
3. All modules follow standard naming: outputs lowercase (sum, cout), inputs lowercase (a, b, cin) 

## Testing
Each module has been simulated individually in Xilinx Vivado. **(Planned)**
*(Future: Unified testbench coming)*

## Next Steps
- [ ] Add testbench for all circuits
- [ ] Add timing/area analysis
- [ ] Add waveform screenshots