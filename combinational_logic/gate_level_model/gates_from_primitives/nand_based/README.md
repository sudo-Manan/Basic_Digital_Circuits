# NAND-Based Gates

NAND is a **functionally complete** gate — every Boolean function can be expressed using only NAND gates. This folder implements NOT, AND, OR, and XOR entirely from NAND primitives, with no other gate types used.

This is a gate-level modelling exercise. Verilog's built-in `nand` primitive is used directly; no transistors, no `assign` statements.

---

## Files

| File | Module | Gates Used |
|---|---|---|
| `my_not.sv` | `my_not` | 1 NAND |
| `my_and.sv` | `my_and` | 2 NAND |
| `my_or.sv` | `my_or` | 3 NAND |
| `my_xor.sv` | `my_xor` | 4 NAND |
| `top_tb.sv` | `top_tb` | Testbench — all 4 gates, all input combinations |

---

## Implementations

### NOT — 1 NAND
Tie both inputs together. `NAND(a, a) = NOT(a AND a) = NOT a`.

```
y = NAND(a, a)
```

### AND — 2 NAND
NAND followed by NOT (which is itself a NAND). Double negation restores AND.

```
n1 = NAND(a, b)
y  = NAND(n1, n1)   ← NOT n1
```

### OR — 3 NAND
By De Morgan's theorem: `a OR b = NOT(NOT_a AND NOT_b)`. Invert each input with a NAND, then NAND the results.

```
n1 = NAND(a, a)     ← NOT a
n2 = NAND(b, b)     ← NOT b
y  = NAND(n1, n2)   ← NOT(NOT_a AND NOT_b) = a OR b
```

### XOR — 4 NAND
Uses the identity `a XOR b = (a NAND (a NAND b)) NAND (b NAND (a NAND b))`.

```
n1 = NAND(a, b)
n2 = NAND(a, n1)
n3 = NAND(n1, b)
y  = NAND(n2, n3)
```

The shared `n1 = NAND(a,b)` is reused in both branches — this is the minimum 4-NAND XOR implementation.

---

## Simulation

```bash
iverilog -g2012 -o top_tb.vvp top_tb.sv my_and.sv my_or.sv my_not.sv my_xor.sv
vvp top_tb.vvp
```

To enable VCD waveform output, uncomment the `$dumpfile` / `$dumpvars` block in `top_tb.sv`.

---

## Gate Count Summary

| Function | NAND count | NOR equivalent |
|---|---|---|
| NOT | 1 | 1 |
| AND | 2 | 3 |
| OR | 3 | 2 |
| XOR | 4 | 5 |

NAND is more efficient than NOR for AND-heavy logic. NOR is more efficient for OR-heavy logic.