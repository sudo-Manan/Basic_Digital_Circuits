`timescale 1ns/1ps

module mux4to1_tb;
    parameter WIDTH = 1;
    logic [WIDTH-1:0] a, b, c, d;   //d is msb and a is lsb
    logic [1:0] sel;
    logic [WIDTH-1:0] y;

    mux4to1 #(WIDTH)dut (.y(y), .a(a), .b(b), .c(c), .d(d), .sel(sel));

    //use with icarus verilog and terosHDL on vs code to generate output vvp and waveform
    //this doesn't work in iverilog, but works in vivado
    // initial begin
    //     $dumpfile("mux4to1_tb.vcd");
    //     $dumpvars(0, mux4to1_tb);
    // end 

    initial begin
        $monitor("sel=%d | d=%d | c=%d | b=%d | a=%d | y=%d", sel, d, c, b, a, y);
        #10; sel=2'b0;
        for(int i=0; i<16; i++) begin
            {d, c, b, a} = i; #10;
            //$display("sel=%d | d=%d | y=%d", sel, d, y);
        end
        #10; sel=2'b1;
        for(int i=0; i<16; i++) begin
            {d, c, b, a} = i; #10;
            //$display("sel=%d | c=%d | y=%d", sel, c, y);
        end
        #10; sel=2'b10;
        for(int i=0; i<16; i++) begin
            {d, c, b, a} = i; #10;
            //$display("sel=%d | b=%d | y=%d", sel, b, y);
        end
        #10; sel=2'b11;
        for(int i=0; i<16; i++) begin
            {d, c, b, a} = i; #10;
            //$display("sel=%d | a=%d | y=%d", sel, a, y);
        end
        #10; $finish;
    end

endmodule