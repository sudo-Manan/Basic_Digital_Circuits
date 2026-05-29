`timescale 1ns/1ps

module mux4to1 #(parameter WIDTH = 1) (
    output logic [WIDTH-1:0] y,
    input logic [WIDTH-1:0] a, b, c, d,
    input logic [1:0] sel
);
    always_comb begin
        case (sel)
            2'b00: y = a;
            2'b01: y = b;
            2'b10: y = c;
            2'b11: y = d;
            default: y = {WIDTH{1'b0}}; // default case to avoid latches
        endcase
    end
endmodule