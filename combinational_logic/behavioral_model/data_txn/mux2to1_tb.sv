`timescale 1ns/1ps

module mux2to1_tb;
    parameter WIDTH = 1;
    logic [WIDTH-1:0] a, b;
    logic sel;
    logic [WIDTH-1:0] y;

    mux2to1 #(WIDTH)dut (.y(y), .a(a), .b(b), .sel(sel));

    //use with icarus verilog and terosHDL on vs code to generate output vvp and waveform
    // initial begin
    //     $dumpfile("mux2to1_tb.vcd");
    //     $dumpvars(0, mux2to1_tb);
    // end
    
    initial begin
        $monitor("sel=%b, a=%b, b=%b => y=%b", sel, a, b, y);
        #10;    sel = 0; a = 0; b = 0;
        #10;    sel = 0; a = 0; b = 1;
        #10;    sel = 0; a = 1; b = 0;
        #10;    sel = 0; a = 1; b = 1;
        #10;    sel = 1; a = 0; b = 0;
        #10;    sel = 1; a = 0; b = 1;
        #10;    sel = 1; a = 1; b = 0;
        #10;    sel = 1; a = 1; b = 1; 
        #10;    $finish;
    end 

endmodule