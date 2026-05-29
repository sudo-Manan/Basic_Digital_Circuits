`timescale 1ns/1ps

module mux4to1 #(parameter WIDTH = 1) (
    output logic [WIDTH-1:0] y,
    input logic [WIDTH-1:0] in_sig [3:0],
    input logic [1:0] sel
);
    assign y = in_sig[sel];
endmodule 