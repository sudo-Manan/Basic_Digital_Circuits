`timescale 1ns/1ps

module mux2to1 #(parameter WIDTH = 1) (
    output logic [WIDTH-1:0] y,
    input logic [WIDTH-1:0] a, b,
    input logic sel
);
    assign y = (a & ~sel) | (b & sel);

endmodule 