`timescale 1ns/1ps

module demux1to4_tb;
    logic in;
    logic [3:0] y;
    logic [1:0] sel;

    demux1to4 uut (.y(y), .in(in), .sel(sel));

    //use with icarus verilog and terosHDL on vs code to generate output vvp and waveform
    // initial begin
    //     $dumpfile("demux1to4_tb.vcd");
    //     $dumpvars(0, uut_demux1to4_tb);
    // end

    initial begin
        $monitor("sel=%b, in=%b, y=%b",sel, in, y);
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