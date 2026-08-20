`timescale 1ns/1ps

module d_ff_tb;
    logic clk, d, rst_n;
    wire q;

    d_ff uut (.q(q), .d(d), .clk(clk), .rst_n(rst_n));

    initial begin
        $dumpfile("tb_d_ff.vcd");
        $dumpvars(0, d_ff_tb);
    end

    initial begin
        clk = 0;
        rst_n = 0;
    end

    always #5 clk = ~clk; // Clock generation

    initial begin
        // Initialize inputs
        d = 0;

        $monitor("Time: %0t | clk: %b | rst_n = %b | d: %b | q: %b", $time, clk, rst_n, d, q);
        // Test sequence
        #1; rst_n = 1; d = 1;
        #6; d = 0;
        #4; d = 1;
        #3; d = 0;
        #2; d = 1;
        #2; d = 0;
        #3; d = 1;
        #1; d = 0;
        #4; d = 1;
        #3; d = 0;
        #5; d = 1;
        #9; d = 0;
        #10; d = 1; // Reset the flip-flop
        #4; rst_n = 0; 
        #10; rst_n = 1;
        #10; d = 0;
        #10; d=0;
        // Finish simulation
        #10; $finish;
    end

endmodule