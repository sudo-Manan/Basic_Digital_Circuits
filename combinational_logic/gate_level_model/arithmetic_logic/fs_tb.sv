`timescale 1ns/1ps

module fs_tb ();
    logic a, b, bin;
    logic diff, bout;

    fs dut (.diff(diff), .borrow_out(bout), .borrow_in(bin), .a(a), .b(b));

    //use with icarus verilog and terosHDL on vs code to generate output vvp and waveform
    // initial begin
    //     $dumpfile("fs_tb.vcd");
    //     $dumpvars(0, fs_tb);
    // end

    initial begin
        $monitor("a = %b, b = %b, bin = %b, diff = %b, bout = %b", a, b, bin, diff, bout);
        #5;     a = 0; b = 0; bin = 0;
        #5;     a = 0; b = 0; bin = 1;
        #5;     a = 0; b = 1; bin = 0;
        #5;     a = 0; b = 1; bin = 1;
        #5;     a = 1; b = 0; bin = 0;
        #5;     a = 1; b = 0; bin = 1;
        #5;     a = 1; b = 1; bin = 0;
        #5;     a = 1; b = 1; bin = 1;
        #5;     $finish;
    end

endmodule