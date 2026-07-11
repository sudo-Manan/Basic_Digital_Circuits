`timescale 1ns/1ps

module alu8 (y, cout, a, b, sel);
    parameter WIDTH=8;      //Due to use of a 8bit adder, the alu needs to be set to be of 8 bits
    input logic [WIDTH-1:0] a, b;
    input logic [$clog2(WIDTH)-1:0] sel;
    output logic [WIDTH-1:0] y;
    output logic cout;

    logic [WIDTH-1:0] b_inv, b_sel, result_and, result_or, result_cla, result_slt;
    logic overflow, result_cout;

    assign b_inv = ~b;
    mux2to1_param #(WIDTH) mux_b_sel (.in0(b), .in1(b_inv), .y(b_sel), .sel(sel[$clog2(WIDTH)-1]));
    cla8 inst_cla8 (.a(a), .b(b_sel), .cin(sel[$clog2(WIDTH)-1]), .sum(result_cla), .cout(result_cout));
    assign result_and = a & b_sel;
    assign result_or = a | b_sel;
    assign result_slt = sel[$clog2(WIDTH)-1] ? {{(WIDTH-1){1'b0}}, ~result_cout} : {WIDTH{1'b0}};
    assign cout = result_cout;
    mux4to1_param #(WIDTH) mux_out (.in0(result_and), .in1(result_or), .in2(result_cla), .in3(result_slt), .y(y), .sel(sel[$clog2(WIDTH)-2:0]));

endmodule