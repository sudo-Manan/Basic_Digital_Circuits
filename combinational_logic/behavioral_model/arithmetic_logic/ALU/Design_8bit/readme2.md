Here's the full toolchain used:

---

## Toolchain Summary — ALU8 Design

### 1. HDL — SystemVerilog
Files written manually: `cla4.sv`, `cla8.sv`, `mux2to1_param.sv`, `mux4to1_param.sv`, `alu8.sv`

---

### 2. Yosys — Synthesis & Netlist Generation

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

**ASIC synthesis with Sky130 PDK:**
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

**FPGA synthesis for UltraScale+ (aup_zu3):**
```bash
yosys -p "
  read_verilog -sv cla4.sv cla8.sv mux2to1_param.sv mux4to1_param.sv alu8.sv;
  hierarchy -top alu8;
  proc; opt;
  synth_xilinx -arch xcup -top alu8 -flatten;
  write_verilog -noattr synth_alu8_xilinx.v
"
```

**JSON netlist export (for netlistsvg):**
```bash
yosys -p "
  read_verilog -sv cla4.sv cla8.sv mux2to1_param.sv mux4to1_param.sv alu8.sv;
  hierarchy -top alu8;
  proc; opt; flatten;
  write_json alu8.json
"
```

---

### 3. netlistsvg — Book-style Schematic Rendering

**Install:**
```bash
npm install --prefix ~/.npm-global netlistsvg
echo 'export PATH="$HOME/.npm-global/node_modules/.bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

**Render:**
```bash
netlistsvg alu8.json -o alu8_schematic.svg
~/.npm-global/node_modules/.bin/netlistsvg alu8.json -o alu8_schematic.svg 
```

---

### 4. Git — Version Control

```bash
# Branch before cleanup
git checkout -b schematic-cleanup
git add .
git commit -m "WIP: add schematic output and netlistsvg setup before cleanup"
git push -u origin schematic-cleanup

# After cleanup, merge back to main
git checkout main
git merge schematic-cleanup
git push origin main
git push origin --delete schematic-cleanup  # optional
```

---

### Tool Summary Table

| Tool | Purpose |
|------|---------|
| SystemVerilog | HDL source files |
| Yosys | Synthesis, optimization, netlist export |
| Sky130 PDK `.lib` | ASIC standard cell library for `abc` mapping |
| `synth_xilinx` | FPGA-targeted synthesis for UltraScale+ |
| netlistsvg | Clean SVG schematic from JSON netlist |
| npm | Package manager for netlistsvg |
| Git | Version control and remote backup |