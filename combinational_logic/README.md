
# Combinational Logic

## Folder Overview

``` bash
combinational_logic\
|----behavioral_model\
|   |----arithmetic_logic\
|   |   |----ALU\
|   |   |   |----Design_8bit\
|   |   |   |   |----images\    #contains images of schematics for reference
|   |   |   |   |---- cla4.sv
|   |   |   |   |---- cla8.sv
|   |   |   |   |---- mux2to1_param.sv
|   |   |   |   |---- mux4to1_param.sv
|   |   |   |   |---- alu8.sv
|   |   |----subtractor_8bit\
|   |   |   |---- cla4.sv
|   |   |   |---- cla8.sv
|   |   |   |---- cla_subtractor.sv
|   |   |   |---- cla_subtractor_tb.sv
|   |   |---- mag_comp.sv
|   |   |---- mag_comp_tb.sv
|   |   |---- mag_comp_alt.sv
|   |----data_txn\
|   |   |---- mux2to1.sv
|   |   |---- mux2to1_tb.sv
|   |   |---- mux2to1_alt.sv
|   |   |---- mux4to1.sv
|   |   |---- mux4to1_tb.sv
|   |   |---- mux8to1.sv
|   |   |---- mux8to1_tb.sv
|   |   |---- demux1to8.sv
|   |   |---- demux1to8_tb.sv
|   |   |---- demux1to8_alt.sv
|   |   |---- p_encoder8to3.sv
|   |   |---- p_encoder8to3_tb.sv
|----dataflow_model\
|   |----arithmetic_logic\
|   |   |---- la_add_sun_4bit.sv
|   |   |---- la_add_su_4bit_tb.sv
|   |   |---- mag_comp.sv
|   |   |---- mag_comp_tb.sv
|   |----code_converters\
|   |   |---- bin2gray.sv
|   |   |---- bin2gray_tb.sv
|   |   |---- gray2bin.sv
|   |   |---- gray2bin_tb.sv
|   |   |---- bcd2bin.sv
|   |   |---- rtl_bcd2bin.sv
|   |   |---- bin2bcd.sv
|   |----data_txn\
|   |   |---- mux2to1.sv
|   |   |---- mux2to1_tb.sv
|   |   |---- mux4to1.sv
|   |   |---- mux4to1_tb.sv
|   |   |---- mux8to1.sv
|   |   |---- mux8to1_tb.sv
|   |   |---- demux1to4.sv
|   |   |---- demux1to4_tb.sv
|   |   |---- demux1to4_alt.sv
|   |   |---- decoder3to8.sv
|   |   |---- decoder3to8_tb.sv
|   |   |---- decoder3to8_alt.sv
|----gate_level_model\
|   |----arithmetic_logic\
|   |   |---- ha.sv
|   |   |---- ha_tb.sv
|   |   |---- hs.sv
|   |   |---- hs_tb.sv
|   |   |---- fa.sv
|   |   |---- fa_tb.sv
|   |   |---- fs.sv
|   |   |---- fs_tb.sv
|   |   |---- ripple_carry_adder_subtractor_parameterized.sv
|   |   |---- ripple_adder_subtractor_tb.sv
|   |----data_txn\
|   |   |---- mux2to1.sv
|   |   |---- mux2to1_tb.sv
|   |   |---- demux1to2.sv
|   |   |---- demux2to1_tb.sv
|   |----gates_from_primitives\
|   |   |----nand_based\
|   |   |   |---- my_and.sv
|   |   |   |---- my_or.sv
|   |   |   |---- my_not.sv
|   |   |   |---- my_xor.sv
|   |   |   |---- top_tb.sv
|   |   |----nor_based\
|   |   |   |---- my_and.sv
|   |   |   |---- my_or.sv
|   |   |   |---- my_not.sv
|   |   |   |---- my_xor.sv
|   |   |   |---- top_tb.sv
|----switch_level_model\
|   |----cmos_primitive_gates\
|   |   |---- my_and.sv
|   |   |---- my_or.sv
|   |   |---- my_not.sv
|   |   |---- my_nand.sv
|   |   |---- my_nand_tb.sv
|   |   |---- my_nor.sv
|   |   |---- my_nor_tb.sv
|   |   |---- my_buff.sv
|   |   |---- my_buff_tb.sv
|   |   |---- my_xor.sv
|   |   |---- my_xor_tb.sv
|   |   |---- my_xnor.sv
|   |   |---- top_tb.sv
|   |---- mux2to1.sv
|   |---- mux2to1_tb.sv
```