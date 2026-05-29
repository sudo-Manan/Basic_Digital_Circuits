# NOR-Based Gates

NOR is a **functionally complete** gate — every Boolean function can be expressed using only NOR gates. This folder implements NOT, AND, OR, and XOR entirely from NOR primitives, with no other gate types used.

This is the NOR counterpart to the NAND-based folder. Comparing both implementations side by side is useful for understanding De Morgan's duality.

---

## Files

| File | Module | Gates Used |
|---|---|---|
| `my_not.sv` | `my_not` | 1 NOR |
| `my_or.sv` | `my_or` | 2 NOR |
| `my_and.sv` | `my_and` | 3 NOR |
| `my_xor.sv` | `my_xor` | 5 NOR |
| `top_tb.sv` | `top_tb` | Testbench — all 4 gates, all input combinations |

---

## Implementations

### NOT — 1 NOR
Tie both inputs together. `NOR(a, a) = NOT(a OR a) = NOT a`.

```
y = NOR(a, a)
```

### OR — 2 NOR
NOR followed by NOT (which is itself a NOR). Double negation restores OR.

```
n1 = NOR(a, b)
y  = NOR(n1, n1)    ← NOT n1
```

### AND — 3 NOR
By De Morgan's theorem: `a AND b = NOT(NOT_a OR NOT_b)`. Invert each input with a NOR, then NOR the results.

```
n1 = NOR(a, a)      ← NOT a
n2 = NOR(b, b)      ← NOT b
y  = NOR(n1, n2)    ← NOT(NOT_a OR NOT_b) = a AND b
```

### XOR — 5 NOR
NOR-based XOR has no shared-intermediate shortcut equivalent to the 4-NAND version, requiring one extra gate.

```
n1 = NOR(a, b)          ← NOR(a,b)
n2 = NOR(a, n1)         ← NOR(a, NOR(a,b))
n3 = NOR(b, n1)         ← NOR(b, NOR(a,b))
n4 = NOR(n2, n3)        ← NOR of the two branches
y  = NOR(n4, n4)        ← NOT n4 (invert to get XOR)
```

---

## Simulation

```bash
iverilog -g2012 -o top_tb.vvp top_tb.sv my_and.sv my_or.sv my_not.sv my_xor.sv
vvp top_tb.vvp
```

To enable VCD waveform output, uncomment the `$dumpfile` / `$dumpvars` block in `top_tb.sv`.

---

## Gate Count Summary

| Function | NOR count | NAND equivalent |
|---|---|---|
| NOT | 1 | 1 |
| OR | 2 | 3 |
| AND | 3 | 2 |
| XOR | 5 | 4 |

NOR is more efficient than NAND for OR-heavy logic. For AND-heavy logic (which dominates most arithmetic), NAND is preferred — this is why real standard cell libraries are predominantly NAND-based.