`timescale 1ns/1ps

module mux4to1_param #(parameter WIDTH = 1) (
    output logic [WIDTH-1:0] y,
    input logic [WIDTH-1:0] in0, in1, in2, in3,
    input logic [1:0] sel
);

    always_comb begin
        case (sel)
            2'b00: y = in0;
            2'b01: y = in1;
            2'b10: y = in2;
            2'b11: y = in3;
            default: y = {WIDTH{1'b0}}; // default case to avoid latches
        endcase
    end

endmodule