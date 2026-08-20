`timescale 1ns/1ps

module n_register_tb;
    parameter WIDTH = 4;

    logic clk, rst_n, en;
    logic [WIDTH-1:0] d, q;

    n_register #(.WIDTH(WIDTH)) dut (.q(q), .d(d), .clk(clk), .rst_n(rst_n), .en(en));

    // Clock generation
    initial clk = 0;
    always begin 
        #5 clk = ~clk;
    end

    // VCD dump
    initial begin
        $dumpfile("n_register.vcd");
        $dumpvars(0, dut);
    end

    initial begin
        $monitor("time=%0t | rst_n=%b | en=%b | d=%d | q=%d |", $time, rst_n, en, d, q);
        #10; rst_n = 0; en = 0; d = 4'b0101;
        #10; rst_n = 0; en = 1; d = 4'b1010;
        #10; rst_n = 1; en = 1;
        for (int i=0; i<2**WIDTH; i++) begin
            d = i;
            @(posedge clk); #10;
        end
        #10; $finish;
    end

endmodule