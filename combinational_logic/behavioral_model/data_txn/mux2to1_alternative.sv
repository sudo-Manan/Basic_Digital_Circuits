`timescale 1ns/1ps

module mux2to1 (
    output logic y,
    input logic a, b,
    input logic sel
);
    assign y = sel ? b : a;

endmodule 