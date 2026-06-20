`timescale 1ns/1ps

module demux1to2 (y0, y1, in, sel);
    output wire y0, y1;
    input logic in, sel;

    wire sel_inv;

    not not_sel (sel_inv, sel);
    and and0 (y0, in, sel_inv);
    and and1 (y1, in, sel);

endmodule