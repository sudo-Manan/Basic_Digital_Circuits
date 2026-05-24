module my_nand_tb;
    logic a, b;
    wire y;

    my_nand dut (.y(y), .a(a), .b(b));

    //use with icarus verilog and terosHDL on vs code to generate output vvp and waveform
    // initial begin
    //     $dumpfile("my_nand_tb.vcd");
    //     $dumpvars(0, my_nand_tb);
    // end

    initial begin
        $monitor("a=%b, b=%b, y=%b", a, b, y);
        #5;     a = 0; b = 0;
        #5;     a = 0; b = 1;
        #5;     a = 1; b = 0;
        #5;     a = 1; b = 1;
        #5;     $finish;
    end

endmodule