`timescale 1ns/1ps

module p_encoder8to3_tb;
    logic [7:0] in;
    logic [2:0] y;
    logic valid;

    // Instantiate the encoder
    p_encoder8to3 uut (.in(in), .y(y), .valid(valid));

    //use with icarus verilog and terosHDL on vs code to generate output vvp and waveform
    // initial begin
    //     $dumpfile("p_encoder8to3_tb.vcd");
    //     $dumpvars(0, p_encoder8to3_tb);
    // end

    initial begin
        $monitor("Input: %d, Output: %d, Valid: %b", in, y, valid);
        #10;
        for (int i = 0; i < 256; i=i+1) begin
            in = i;
            #10; // Wait for the output to stabilize
        end
        $finish;
    end

endmodule