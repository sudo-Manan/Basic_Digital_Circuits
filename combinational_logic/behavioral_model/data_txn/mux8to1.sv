`timescale 1ns/1ps

module mux8to1_behavioral #(parameter WIDTH = 1) (
    output logic [WIDTH-1:0] y,
    input logic [WIDTH-1:0] in_sig [7:0], //a,b,c,d,e,f,g,h,
    input logic [2:0] sel
);
    //logic [WIDTH-1:0] in_sig [7:0] = {a, b, c, d, e, f, g, h};
    always_comb begin
        case (sel)
            3'b000: y = in_sig[0];
            3'b001: y = in_sig[1];
            3'b010: y = in_sig[2];
            3'b011: y = in_sig[3];
            3'b100: y = in_sig[4];
            3'b101: y = in_sig[5];
            3'b110: y = in_sig[6];
            3'b111: y = in_sig[7];
            default: y = {WIDTH{1'b0}}; // default case 
        endcase
    end 
endmodule