`timescale 1ns/1ps

module top_tb;
    logic a, b;
    wire and_out, or_out, not_out, xor_out, nand_out, nor_out, xnor_out, buff_out;

    my_and and_gate(.y(and_out), .a(a), .b(b));
    my_or or_gate(.y(or_out), .a(a), .b(b));
    my_not not_gate(.y(not_out), .a(a));
    my_xor xor_gate(.y(xor_out), .a(a), .b(b));
    my_nand nand_gate(.y(nand_out), .a(a), .b(b));
    my_nor nor_gate(.y(nor_out), .a(a), .b(b));
    my_xnor xnor_gate(.y(xnor_out), .a(a), .b(b));
    my_buff buff_gate(.y(buff_out), .a(a));
    //use with icarus verilog and terosHDL on vs code to generate output vvp and waveform
    // initial begin
    //     $dumpfile("top_tb.vcd");
    //     $dumpvars(0, top_tb);
    // end

    initial begin
        $monitor("Time: %0t | a: %b, b: %b | AND: %b, OR: %b, XOR: %b, NAND: %b, NOR: %b, XNOR: %b | a: %b, NOT: %b, BUFF: %b", $time, a, b, and_out, or_out, xor_out, nand_out, nor_out, xnor_out, a, not_out, buff_out);
        #10; a = 0; b = 0;
        #10; a = 0; b = 1;
        #10; a = 1; b = 0;
        #10; a = 1; b = 1;
        #10; $finish;
    end

endmodule