`timescale 1ns/1ps

module t_ff_tb;
    logic t;
    logic clk;
    logic q, q_bar;

    t_ff uut (.q(q), .q_bar(q_bar), .t(t), .clk(clk));

    always begin
        clk = 0;
        #10 clk = ~clk; // Clock generation with a period of 10 time units
    end

    initial begin
        $monitor(" t=%d | q=%d | q_bar=%d ", t, q, q_bar);
        #10; t = 0; // No change
        #10; t = 1; // Toggle
        #10; t = 0; // No change
        #10; t = 1; // Toggle
        #10; t = 0; // No change
        #10; t = 1; // Toggle
        #10; t = 0; // No change
        #10; t = 0; // No change
        #10; t = 0; // No change
        #10; t = 1; // Toggle
        #10; t = 1; // Toggle
        #10; $finish; // End simulation
    end

endmodule