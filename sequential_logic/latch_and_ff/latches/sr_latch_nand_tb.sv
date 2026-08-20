`timescale 1ns / 1ps

module sr_latch_nand_tb;
    logic s, r;
    logic q, q_inv; 

    sr_latch_nand dut (.q(q), .q_bar(q_inv), .s(s), .r(r)); 

    //use with icarus verilog and terosHDL on vs code to generate output vvp and waveform
    // initial begin
    //     $dumpfile("sr_latch_nand_tb.vcd");
    //     $dumpvars(0, sr_latch_nand_tb);
    // end

    initial begin 
        $monitor("s=%d|r=%d|q=%d|q_inv=%d",s,r,q,q_inv);
        #10;    s=1; r=1;   //hold the initial/ default state
        #10;    s=0; r=1;   //set state
        #10;    s=1; r=1;   //hold state
        #10;    s=1; r=0;   //reset state
        #10;    s=0; r=1;   //set state
        #10;    s=0; r=0;   //invalid state
        #10;    $finish;
    end

endmodule