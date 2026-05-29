`timescale 1ns/1ps

module mux2to1 #(parameter WIDTH = 1) (
    output logic [WIDTH-1:0] y,
    input logic [WIDTH-1:0] a, b,
    input logic sel
);
    always_comb begin
        case (sel)
            1'b0: y = a;
            1'b1: y = b;
            default: y = {WIDTH{1'bX}};
        endcase
    end
    
endmodule

// module mux2to1 (
//     output logic y,
//     input logic a, b,
//     input logic sel
// );
//     assign y = sel ? b : a;
//
// endmodule 