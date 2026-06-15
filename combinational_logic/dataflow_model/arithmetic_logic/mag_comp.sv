`timescale 1ns/1ps

module mag_comp #(parameter WIDTH = 4) (a, b, a_gt_b, eq, a_lt_b);
    input logic [WIDTH-1:0] a, b;
    output wire a_gt_b, eq, a_lt_b;

    assign a_gt_b = (a > b) ? 1 : 0;
    assign eq = (a == b) ? 1 : 0;
    assign a_lt_b = (a < b) ? 1 : 0;

endmodule