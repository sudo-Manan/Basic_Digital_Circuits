`timescale 1ns/1ps

module demux1to4_tb;
    logic in;
    logic y3, y2, y1, y0;
    logic [1:0] sel;

    demux1to4 uut (.y3(y3), .y2(y2), .y1(y1), .y0(y0), .in(in), .sel(sel));

    //use with icarus verilog and terosHDL on vs code to generate output vvp and waveform
    // initial begin
    //     $dumpfile("demux1to4_tb.vcd");
    //     $dumpvars(0, uut_demux1to4_tb);
    // end

    initial begin
        $monitor("sel=%b, in=%b, y0=%b, y1=%b, y2=%b, y3=%b",sel, in, y0, y1, y2, y3);
        for (int i = 0; i < 4; i++) begin
            sel = i;
            in = 0;
            #10;
            in = 1;
            #10;
        end
        #10;    $finish;
    end

endmodule