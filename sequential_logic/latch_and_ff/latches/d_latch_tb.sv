`timescale 1ns/1ps

module d_latch_tb ();
    logic d, en;
    logic q, q_inv; 

    d_latch dut (.q(q), .q_bar(q_inv), .d(d), .en(en)); 

    // initial begin
    //     $dumpfile("d_latch_tb.vcd");
    //     $dumpvars(0, d_latch_tb);
    // end

   initial begin 
        $monitor("en=%d|d=%d|q=%d|q_inv=%d",en,d,q,q_inv);
        #10;    en=0;   d=0;   //disable
        #10;    en=0;   d=1;   //disable
        #10;    en=1;   d=0;   //enable reset
        #10;    en=1;   d=1;   //enable set
        #10;    en=0;   d=1'bx;   //disable
        #10;    en=1;   d=0;   //enable reset
        #10;    en=1;   d=1;   //enable set
        #10;    en=0;   d=1'bx;   
        #10;    $finish;
    end

endmodule