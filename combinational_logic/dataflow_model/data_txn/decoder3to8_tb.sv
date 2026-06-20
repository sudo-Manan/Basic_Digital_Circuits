`timescale 1ns/1ps

module decoder3to8_tb;
    logic [2:0] sel;
    logic [7:0] y;

    decoder3to8 dut (.sel(sel), .y(y));

    //use with icarus verilog and terosHDL on vs code to generate output vvp and waveform
    // initial begin
    //     $dumpfile("decoder3to8_tb.vcd");
    //     $dumpvars(0, decoder3to8_tb);
    // end

    initial begin
        $monitor("sel: %b | y: %d", sel, y);
        #10;
        for (int i = 0; i < 8; i++) begin
            sel = i;
            #10; // Wait for the output to stabilize
        end
        $finish;
    end

endmodule