`timescale 1ns/1ps

module mux2to1 (
    output logic y,
    input logic i0, i1,
    input logic sel
);
    logic sel_inv, w1, w2; 
    
    not not_sel (sel_inv, sel);
    and and0 (w1, i0, sel_inv);
    and and1 (w2, i1, sel);
    or or0 (y, w1, w2);
endmodule 