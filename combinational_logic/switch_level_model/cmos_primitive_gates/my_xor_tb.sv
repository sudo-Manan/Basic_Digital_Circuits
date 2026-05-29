`timescale 1ns/1ps

module my_xor_tb;
    logic a, b;
    wire y;

    my_xor dut(.y(y), .a(a), .b(b));

    //use with icarus verilog and terosHDL on vs code to generate output vvp and waveform vcd files
    // initial begin
    //     $dumpfile("my_xor_tb.vcd");
    //     $dumpvars(0, my_xor_tb);
    // end

    initial begin
        $monitor("a=%b, b=%b, y=%b", a, b, y);
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        $finish;
    end

endmodule