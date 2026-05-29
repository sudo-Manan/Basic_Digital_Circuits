`timescale 1ns/1ps

module bin2gray_tb;
    parameter WIDTH = 4;
    logic [WIDTH-1:0] bin_in;
    logic [WIDTH-1:0] gray_out;

    bin2gray #(WIDTH) dut1 (.gray(gray_out), .bin(bin_in));

    //use with icarus verilog and terosHDL on vs code to generate output vvp and waveform
    // initial begin
    //     $dumpfile("bin2gray_tb.vcd");
    //     $dumpvars(0, bin2gray_tb);
    // end

    initial begin
        // Test all possible binary inputs
        $monitor("Binary Input: %b | Gray Output: %b", bin_in, gray_out);
        #10;
        for (int i = 0; i < (1 << WIDTH); i=i+1) begin
            bin_in = i;
            #10; // Wait for the output to stabilize
        end
        $finish;
    end
endmodule