`timescale 1ns/1ps

module mux2to1_param #(parameter WIDTH = 1) (y, in0, in1, sel);
    input logic [WIDTH-1:0] in0, in1;
    input logic sel;
    output logic [WIDTH-1:0] y;

    always_comb begin : mux_param
        case (sel)
            1'b0: y = in0;
            1'b1: y = in1;
            default: y = {WIDTH{1'b0}};
        endcase
    end

endmodule