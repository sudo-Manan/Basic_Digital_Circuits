`timescale 1ns/10ps 

module moore_fsm_tb;

    reg clk, rst_n, in_bit; 
    wire y;

    moore_fsm dut (
        .clk(clk),
        .rst_n(rst_n),
        .in_bit(in_bit),
        .y(y)
    );

    initial begin
        $dumpfile("moore_fsm_tb.vcd");
        $dumpvars(0, moore_fsm_tb);
    end

    always begin
        #5 clk = ~clk; // Clock generation with a period of 10 time units
    end

    initial begin
        clk = 0;
        rst_n = 1;
        in_bit = 0;

        // Apply Reset
        #10;
        rst_n = 0;
        $monitor("Time: %0t | clk: %b | rst_n: %b | in_bit: %b | y: %b", $time, clk, rst_n, in_bit, y);
        #10; rst_n = 0; in_bit = 0; // Reset the FSM
        #10; rst_n = 1; in_bit = 1; // Start sequence
        #10; in_bit = 0;
        #10; in_bit = 1;
        #10; in_bit = 1; // Sequence "1011" detected, y should be 1
        #10; in_bit = 0;
        #10; in_bit = 1;
        #10; in_bit = 0;
        #10; in_bit = 1;
        #10; in_bit = 1; // Sequence "1011" detected again, y should be 1
        #10; $finish;
    end
endmodule