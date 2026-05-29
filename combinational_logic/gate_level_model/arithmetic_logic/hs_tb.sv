`timescale 1ns/1ps

module hs_tb ();
    logic a, b;
    logic diff;
    logic borrow;

    hs dut (.diff(diff), .borrow(borrow), .a(a), .b(b));

    // Use with Icarus Verilog and TerosHDL on VS Code to generate output vvp and waveform vcd files
    // initial begin
    //     $dumpfile("hs_tb.vcd");
    //     $dumpvars(0, hs_tb);
    // end
    
    initial begin 
        $monitor("a = %b, b = %b, diff = %b, borrow = %b", a, b, diff, borrow);
        #5;     a = 1'b0; b = 1'b0;
        #5;     a = 1'b0; b = 1'b1;
        #5;     a = 1'b1; b = 1'b0;
        #5;     a = 1'b1; b = 1'b1;
        #5;     $finish;
    end

endmodule 
