`timescale 1ns/1ps

module jk_ff_tb;
    logic j, k;
    logic clk;
    logic q, q_bar;

    jk_ff uut (.q(q), .q_bar(q_bar), .j(j), .k(k), .clk(clk));

    always begin
        clk = 0;
        #10 clk = ~clk; // Clock generation with a period of 10 time units
    end

    initial begin
        $monitor(" j=%d | k=%d | q=%d | q_bar=%d ", j, k, q, q_bar);
        #10; j = 0; k = 0; // No change
        #10; j = 0; k = 1; // Reset
        #10; j = 1; k = 0; // Set
        #10; j = 1; k = 1; // Toggle
        #10; j = 0; k = 0; // No change
        #10; j = 1; k = 1; // Toggle
        #10; j = 0; k = 1; // Reset
        #10; j = 1; k = 0; // Set
        #10; j = 0; k = 0; // No change
        #10; $finish; // End simulation
    end

endmodule