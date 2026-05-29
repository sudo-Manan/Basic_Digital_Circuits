# Switch-Level Model

Switch-level modelling is the lowest abstraction level in digital design — below gate-level. Instead of using logic primitives like `and` or `or`, circuits are built directly from PMOS and NMOS transistors using Verilog's `pmos` and `nmos` primitives. This directly mirrors how CMOS circuits are physically implemented in silicon.

This folder contains switch-level implementations of standard logic gates and a 2-to-1 multiplexer, built entirely from transistor primitives.

---

## CMOS Transistor Primitives

Verilog provides two switch primitives:

```
nmos (drain, source, gate)   // conducts when gate = 1
pmos (drain, source, gate)   // conducts when gate = 0
```

Every CMOS gate follows the same structural pattern:
- A **pull-up network** (PMOS) connects the output to `vdd` — conducts when output should be logic 1
- A **pull-down network** (NMOS) connects the output to `vss` — conducts when output should be logic 0
- The two networks are **complementary** — exactly one conducts for any valid input combination

`supply1 vdd` and `supply0 vss` are used to model power and ground rails.

---

## Files

### `cmos_primitive_gates/`

| File | Module | Description |
|---|---|---|
| `my_not.sv` | `my_not` | Inverter — single PMOS + single NMOS |
| `my_nand.sv` | `my_nand` | NAND — parallel PMOS, series NMOS |
| `my_nor.sv` | `my_nor` | NOR — series PMOS, parallel NMOS |
| `my_and.sv` | `my_and` | AND — NAND followed by inverter |
| `my_or.sv` | `my_or` | OR — NOR followed by inverter |
| `my_buff.sv` | `my_buff` | Buffer — two cascaded inverters |
| `my_xor.sv` | `my_xor` | XOR — implemented as `(a AND NOT_b) OR (NOT_a AND b)` |
| `my_xnor.sv` | `my_xnor` | XNOR — implemented as `(a AND b) OR (NOT_a AND NOT_b)` |
| `my_nand_tb.sv` | `my_nand_tb` | Testbench for NAND gate |
| `my_xor_tb.sv` | `my_xor_tb` | Testbench for XOR gate |
| `my_buff_tb.sv` | `my_buff_tb` | Testbench for buffer |
| `top_tb.sv` | `top_tb` | Combined testbench — instantiates all 8 gates and tests all input combinations |

### Root level

| File | Module | Description |
|---|---|---|
| `mux2to1.sv` | `mux2to1` | 2-to-1 mux — implemented as `NAND(i0, NOT_sel)` NAND `NAND(i1, sel)` |
| `mux2to1_tb.sv` | `mux2to1_tb` | Testbench — exhaustive test of all 8 input combinations |

---

## Gate Implementations

### NOT (Inverter)
The simplest CMOS gate. One PMOS pulls output high when input is low; one NMOS pulls output low when input is high.

```
PMOS: gate=a, source=vdd, drain=y   → y=1 when a=0
NMOS: gate=a, source=vss, drain=y   → y=0 when a=1
```

### NAND
PMOS in **parallel** (either can pull up), NMOS in **series** (both must conduct to pull down). Output is low only when both inputs are high.

### NOR
PMOS in **series** (both must conduct to pull up), NMOS in **parallel** (either can pull down). Output is high only when both inputs are low.

### AND / OR
CMOS cannot implement AND or OR directly with a single transistor stage — the pull-up and pull-down networks would not be complementary. AND is implemented as NAND followed by an inverter; OR as NOR followed by an inverter.

### XOR
Implemented structurally as two AND terms OR-ed together:
```
y = (a AND NOT_b) OR (NOT_a AND b)
```
Requires inverters for `not_a` and `not_b`, two NAND-topology AND blocks, and a NOR-topology OR output stage.

### XNOR
Implemented as:
```
y = (a AND b) OR (NOT_a AND NOT_b)
```
Same structure as XOR with the AND terms swapped.

### Buffer
Two cascaded inverters. Output equals input with drive strength restoration.

### MUX 2-to-1
Implemented using the NAND-NAND equivalent of `(i0 AND NOT_sel) OR (i1 AND sel)`:
- First NAND: `w1 = NAND(i0, NOT_sel)`
- Second NAND: `w2 = NAND(i1, sel)`
- Output NAND: `y = NAND(w1, w2)`

All three NAND stages are built from transistor primitives directly — no gate-level primitives used.

---

## Simulation

All files include `` `timescale 1ns/1ps ``. Testbenches are written for [Icarus Verilog](https://steveicarus.github.io/iverilog/) and compatible with [TerosHDL](https://terostechnology.github.io/terosHDLdoc/) on VS Code for waveform viewing.

To enable VCD waveform output, uncomment the `$dumpfile` / `$dumpvars` block in the relevant testbench.

**Run all gates (top-level testbench):**
```bash
iverilog -g2012 -o top_tb.vvp top_tb.sv my_and.sv my_or.sv my_not.sv my_xor.sv my_nand.sv my_nor.sv my_xnor.sv my_buff.sv
vvp top_tb.vvp
```

**Run MUX testbench:**
```bash
iverilog -g2012 -o mux2to1_tb.vvp mux2to1_tb.sv mux2to1.sv
vvp mux2to1_tb.vvp
```

---

## Key Concept: Why Switch-Level?

Gate-level modelling abstracts away transistors. Switch-level removes that abstraction — you are specifying exactly which transistors turn on and off. This is relevant for:
- Understanding how CMOS logic physically works
- Implementing transmission gates and other circuits that have no direct gate-level primitive
- Low-level custom cell design