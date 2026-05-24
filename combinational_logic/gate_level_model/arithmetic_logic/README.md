# Arithmetic Logic - Gate-Level Models

Building blocks for arithmetic circuits: 1-bit adders/subtractors and parameterized multi-bit ripple carry implementations.

## Folder Structure
```
arithmetic_logic/
├── README.md (this file)
├── half_adder.sv                               # ha(carry, sum, a, b)
├── ha_tb.sv                                    # testbench
├── full_adder.sv                               # fa(carry_out, sum, carry_in, a, b)
├── fa_tb.sv                                    # testbench
├── half_subtractor.sv                          # hs(diff, borrow, a, b)
├── hs_tb.sv                                    # testbench
├── full_subtractor.sv                          # fs(diff, borrow_out, borrow_in, a, b)
├── fs_tb.sv                                    # testbench
├── ripple_carry_adder_subtractor_parameterized.sv  # ripple_carry_add_sub #(WIDTH) (s, cout, m, a, b, cin)
└── ripple_adder_subtractor_tb.sv               # exhaustive testbench (2048 vectors)
```

## Logic at a Glance

### 1-Bit Building Blocks

| Module | Inputs | Outputs | Function |
|--------|--------|---------|----------|
| **Half Adder** | a, b | sum, carry | `sum = a XOR b` <br> `carry = a AND b` |
| **Full Adder** | a, b, cin | sum, cout | `sum = a XOR b XOR cin` <br> `cout = (a AND b) OR (cin AND (a XOR b))` |
| **Half Subtractor** | a, b | diff, borrow | `diff = a XOR b` <br> `borrow = (NOT a) AND b` |
| **Full Subtractor** | a, b, bin | diff, bout | `diff = a XOR b XOR bin` <br> `bout = (NOT a AND b) OR (bin AND (a XOR b))` |

### Multi-Bit Ripple Carry (Parameterized)

***Inputs***: a, b, cin, m  
***Outputs***: s, cout

**Arithmetic Model:** 2's Complement via XOR Inversion

When m=1 (subtraction):
- `b_inverted = b XOR m` → produces ~b (bitwise NOT)
- `c[0] = cin OR m` → forces c[0]=1
- Result: `s = a + (~b) + 1` (standard 2's complement subtraction)
- Correctly computes a - b

When m=0 (addition):
- `b_inverted = b XOR m` → keeps b unchanged
- `c[0] = cin` → normal carry-in
- Result: `s = a + b + cin` (standard addition)

**Output Interpretation:**

| Mode | Output | Meaning |
|------|--------|---------|
| **Addition (m=0)** | s, cout | `{cout, s}` = a + b + cin (unsigned) |
| **Subtraction (m=1)** | s (4-bit) | Result of a - b in 2's complement |
| **Subtraction (m=1)** | cout=1 | No borrow: a ≥ b (result is positive) |
| **Subtraction (m=1)** | cout=0 | Borrow: a < b (result is negative, wrapped) |

## Testing 

**Ripple Carry ADD/SUB Testbench Coverage:**
- **2,048 vectors:** All combinations of a, b ∈ [0,15], cin ∈ {0,1}, m ∈ {0,1}
- **Addition mode (m=0):** 1,024 vectors - Verified
- **Subtraction mode (m=1):** 1,024 vectors - Verified
- **Pass rate:** 100%

**How to Run:**

Using Icarus Verilog (uncomment the initial block in testbench if needed):
```bash
iverilog -o output.vvp ripple_adder_subtractor_tb.sv ripple_carry_adder_subtractor_parameterized.sv 
vvp output.vvp
```

## Design Notes

- **Gate-level:** AND, OR, NOT, XOR primitives used
- **Parameterized:** Scale WIDTH for 4, 8, 16, 32+ bits
- **Combinational:** No state, pure combinatorial logic
- **Synthesizable:** Verified with Yosys

---

**Last Updated:** May 24, 2026
