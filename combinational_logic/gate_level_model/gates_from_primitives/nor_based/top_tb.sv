module top_tb;
    logic a, b;
    logic and_out, or_out, not_out, xor_out;

    my_and and_gate(.y(and_out), .a(a), .b(b));
    my_or or_gate(.y(or_out), .a(a), .b(b));
    my_not not_gate(.y(not_out), .a(a));
    my_xor xor_gate(.y(xor_out), .a(a), .b(b));

    //use with icarus verilog and terosHDL on vs code to generate output vvp and waveform
    // initial begin
    //     $dumpfile("top_tb.vcd");
    //     $dumpvars(0, top_tb);
    // end

    initial begin
        $monitor("Time: %0t | a: %b, b: %b | AND: %b, OR: %b, XOR: %b | a: %b, NOT: %b", $time, a, b, and_out, or_out, xor_out, a, not_out);
        #10; a = 0; b = 0;
        #10; a = 0; b = 1;
        #10; a = 1; b = 0;
        #10; a = 1; b = 1;
        #10; $finish;
    end

endmodule