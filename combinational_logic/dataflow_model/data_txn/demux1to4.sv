`timescale 1ns/1ps

module demux1to4 (y3, y2, y1, y0, in, sel);
    input logic in;
    output logic y3, y2, y1, y0;
    input logic [1:0] sel;

    assign y0 = (sel == 2'b00) ? in : 1'b0;
    assign y1 = (sel == 2'b01) ? in : 1'b0;
    assign y2 = (sel == 2'b10) ? in : 1'b0;
    assign y3 = (sel == 2'b11) ? in : 1'b0;

endmodule