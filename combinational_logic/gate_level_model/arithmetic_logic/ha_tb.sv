`timescale 1ns/1ps

module ha_tb ();
    logic a, b;
    logic sum;
    logic carry;

    ha dut (.carry(carry), .sum(sum), .a(a), .b(b));

    // Use with Icarus Verilog and TerosHDL on VS Code to generate output vvp and waveform vcd files
    // initial begin
    //     $dumpfile("ha_tb.vcd");
    //     $dumpvars(0, ha_tb);
    // end

    initial begin 
        $monitor("a = %b, b = %b, sum = %b, carry = %b", a, b, sum, carry);
        #5;     a = 1'b0; b = 1'b0;
        #5;     a = 1'b0; b = 1'b1;
        #5;     a = 1'b1; b = 1'b0;
        #5;     a = 1'b1; b = 1'b1;
        #5;     $finish;
    end

endmodule