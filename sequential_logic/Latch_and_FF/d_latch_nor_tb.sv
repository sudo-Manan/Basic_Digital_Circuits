module d_latch_tb ();
    logic d;
    logic q, q_inv; 

    d_latch_nor dut (.q(q), .q_bar(q_inv), .d(d)); 

    initial begin
        $dumpfile("d_latch_tb.vcd");
        $dumpvars(0, d_latch_tb);
    end

   initial begin 
        $monitor("d=%d|q=%d|q_inv=%d",d,q,q_inv);
        #10;    d=0;   //reset state
        #10;    d=1;   //set state
        #10;    d=0;   //reset
        #10;    d=1'bx;   
        #10;    d=0;   //reset state
        #10;    d=1;   //set
        #10;    d=1'bx;   
        #10;    $finish;
    end

endmodule