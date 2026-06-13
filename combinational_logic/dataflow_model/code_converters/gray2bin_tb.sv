`timescale 1ns/1ps

module gray2bin_tb;
    parameter WIDTH = 4;

    logic [WIDTH-1:0] gray_in;
    logic [WIDTH-1:0] bin_out;

    gray2bin #(WIDTH) dut1 (.bin(bin_out), .gray(gray_in));

    //use with icarus verilog and terosHDL on vs code to generate output vvp and waveform
    // initial begin
    //     $dumpfile("gray2bin_tb.vcd");
    //     $dumpvars(0, gray2bin_tb);
    // end

    initial begin
        // Test all possible Gray code inputs
        $monitor("Gray Input: %b | Binary Output: %b", gray_in, bin_out);
        #10;
        for (int i = 0; i < (1 << WIDTH); i=i+1) begin
            gray_in = i ^ (i >> 1); // Generate Gray code from binary index
            #10; // Wait for the output to stabilize
        end
        $finish;
    end

endmodule