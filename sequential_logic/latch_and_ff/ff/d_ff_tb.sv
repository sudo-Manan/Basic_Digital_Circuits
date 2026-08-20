`timescale 1ns/1ps

module d_ff_tb;
    logic d;
    logic clk;
    logic q, q_bar;

    d_ff uut (.q(q), .q_bar(q_bar), .d(d), .clk(clk));

    always begin
        clk = 0;
        #10 clk = ~clk; // Clock generation with a period of 10 time units
    end

    initial begin
        $monitor(" d=%d | q=%d | q_bar=%d ", d, q, q_bar);
        #10; d = 0; // No change
        #10; d = 1; // Set
        #10; d = 0; // Reset
        #10; d = 1; // Set
        #10; d = 0; // Reset
        #10; d = 1; // Set
        #10; d = 0; // Reset
        #10; d = 0; // Reset
        #10; d = 0; // Reset
        #10; d = 1; // Set
        #10; d = 1; // Set
        #10; $finish; // End simulation
    end

endmodule