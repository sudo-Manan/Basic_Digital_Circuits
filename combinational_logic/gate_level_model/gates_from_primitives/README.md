# Gates from Primitives

This folder demonstrates **functional completeness** in digital logic — the property that a single gate type is sufficient to implement any Boolean function.

Both NAND and NOR are functionally complete. Every standard logic gate (NOT, AND, OR, XOR, and by extension any combinational circuit) can be built using only one of them. This is a gate-level modelling exercise using Verilog's built-in `nand` and `nor` primitives.

---

## Structure

```
gates_from_primitives/
├── nand_based/         # NOT, AND, OR, XOR built from NAND only
│   ├── my_not.sv
│   ├── my_and.sv
│   ├── my_or.sv
│   ├── my_xor.sv
│   └── top_tb.sv
└── nor_based/          # NOT, AND, OR, XOR built from NOR only
    ├── my_not.sv
    ├── my_and.sv
    ├── my_or.sv
    ├── my_xor.sv
    └── top_tb.sv
```

Each subfolder is self-contained. See the README inside each for implementation details and gate counts.

---

## NAND vs NOR — Key Differences

| Property | NAND | NOR |
|---|---|---|
| NOT | 1 gate | 1 gate |
| AND | 2 gates | 3 gates |
| OR | 3 gates | 2 gates |
| XOR | 4 gates | 5 gates |
| Natural fit | AND-heavy logic | OR-heavy logic |
| Industry preference | Dominant in standard cells | Less common |

NAND is the more practical universal gate. Most arithmetic and control logic is AND-heavy, so NAND implementations are smaller. Real ASIC standard cell libraries are predominantly NAND-based for this reason.

---

## Why This Matters

**In interviews:** Understanding functional completeness shows you know logic goes deeper than textbook gates. Being able to derive any gate from NAND or NOR from first principles — using De Morgan's theorem — is a fundamental skill.

**In design:** Synthesis tools reduce logic to NAND/NOR networks automatically. Knowing how that works helps you reason about gate counts, critical paths, and what the synthesizer is actually doing with your RTL.

**In CMOS:** NAND and NOR map directly to efficient transistor topologies (see `switch_level_model/`). AND and OR require an extra inverter stage, making them inherently slower and larger. This is why logic synthesis targets NAND/NOR, not AND/OR.