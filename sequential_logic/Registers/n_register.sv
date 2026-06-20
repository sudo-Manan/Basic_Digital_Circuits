`timescale 1ns/1ps

module n_register #(parameter WIDTH = 4) (q, d, clk, rst_n, en);
    input logic clk, rst_n, en;
    input logic [WIDTH-1:0] d;
    output logic [WIDTH-1:0] q;

    generate
        for(genvar i=0; i<WIDTH; i++) begin
            d_ff dff_inst (.clk(clk), .rst_n(rst_n), .en(en), .d(d[i]), .q(q[i]));
        end
    endgenerate

endmodule