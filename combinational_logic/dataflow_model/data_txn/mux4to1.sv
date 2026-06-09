`timescale 1ns/1ps

module mux4to1 #(parameter WIDTH = 1) (
    output logic [WIDTH-1:0] y,
    input logic [WIDTH-1:0] in_sig [3:0],
    input logic [1:0] sel
);
    //dynamically indexed - may not syntesize properly
    // assign y = in_sig[sel];

    assign y = (in_sig[0] & ~sel[1] & ~sel[0]) | 
               (in_sig[1] & ~sel[1] & sel[0]) | 
               (in_sig[2] & sel[1] & ~sel[0]) | 
               (in_sig[3] & sel[1] & sel[0]);
endmodule 