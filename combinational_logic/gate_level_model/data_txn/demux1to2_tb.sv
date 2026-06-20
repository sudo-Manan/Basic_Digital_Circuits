`timescale 1ns/1ps

module demux1to2_tb;
    logic in, sel;
    logic y0, y1;

    demux1to2 dut (.y0(y0), .y1(y1), .in(in), .sel(sel));

    //use with icarus verilog and terosHDL on vs code to generate output vvp and waveform
    // initial begin
    //     $dumpfile("demux2to1_tb.vcd");
    //     $dumpvars(0, demux2to1_tb);
    // end

    initial begin
        $monitor("sel=%b, in=%b, y0=%b, y1=%b",sel, in, y0, y1);
        #10;    sel = 0; in = 0;
        #10;    sel = 0; in = 1;
        #10;    sel = 1; in = 0;
        #10;    sel = 1; in = 1;
        #10;    $finish;
    end

endmodule