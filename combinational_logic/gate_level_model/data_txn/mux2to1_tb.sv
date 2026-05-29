`timescale 1ns/1ps

module mux2to1_tb ();
    logic i0, i1, sel;
    logic y;
    
    mux2to1 dut (.y(y), .i0(i0), .i1(i1), .sel(sel));

    //use with icarus verilog and terosHDL on vs code to generate output vvp and waveform
    // initial begin
    //     $dumpfile("mux2to1_tb.vcd");
    //     $dumpvars(0, mux2to1_tb);
    // end
    
    initial begin
        $monitor("At time %t: sel=%b, i0=%b, i1=%b => y=%b", $time, sel, i0, i1, y);
        #10;    sel = 0; i0 = 0; i1 = 0;
        #10;    sel = 0; i0 = 0; i1 = 1;
        #10;    sel = 0; i0 = 1; i1 = 0;
        #10;    sel = 0; i0 = 1; i1 = 1;
        #10;    sel = 1; i0 = 0; i1 = 0;
        #10;    sel = 1; i0 = 0; i1 = 1;
        #10;    sel = 1; i0 = 1; i1 = 0;
        #10;    sel = 1; i0 = 1; i1 = 1; 
        #10;    $finish;
    end 

endmodule