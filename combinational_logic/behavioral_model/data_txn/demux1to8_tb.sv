`timescale 1ns/1ps

module demux1to8_tb;
    logic in;
    logic [7:0] y;
    logic [2:0] sel;

    demux1to8 uut (.y(y), .in(in), .sel(sel));

    //use with icarus verilog and terosHDL on vs code to generate output vvp and waveform
    // initial begin
    //     $dumpfile("demux1to8_tb.vcd");
    //     $dumpvars(0, uut_demux1to8_tb);
    // end

    initial begin
        $monitor("sel=%d, in=%b, y[0]=%b, y[1]=%b, y[2]=%b, y[3]=%b, y[4]=%b, y[5]=%b, y[6]=%b, y[7]=%b",sel, in, y[0], y[1], y[2], y[3], y[4], y[5], y[6], y[7]);
        for (int i = 0; i < 8; i++) begin
            sel = i;
            in = 0;
            #10;
            in = 1;
            #10;
        end
        #10;    $finish;
    end

endmodule