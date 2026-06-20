`timescale 1ns/1ps

//logic based design of demux1to4: uses more logic gates
    //used yosys -p "read_verilog -sv demux1to4.sv; synth; opt -full; stat" to verify the number of logic gates used in the design, which is 4 AND gates and 4 NOT gates
module demux1to4_alt (y, in, sel);
    input logic in;
    output logic [3:0] y;
    input logic [1:0] sel;

    assign y[0] = (sel == 2'b00) ? in : 1'b0;
    assign y[1] = (sel == 2'b01) ? in : 1'b0;
    assign y[2] = (sel == 2'b10) ? in : 1'b0;
    assign y[3] = (sel == 2'b11) ? in : 1'b0;

endmodule