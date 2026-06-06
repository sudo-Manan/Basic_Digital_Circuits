`timescale 1ns/1ps

module sr_ff_tb;
    logic s, r;
    logic q, q_inv; 
    logic clk=0;
    
    sr_ff dut (.q(q), .q_bar(q_inv), .s(s), .r(r), .clk(clk)); 

    //use with icarus verilog and terosHDL on vs code to generate output vvp and waveform
    //    initial begin
    //        $dumpfile("sr_latch_nand_tb.vcd");
    //        $dumpvars(0, sr_latch_nand_tb);
    //    end
    always begin
        #10 clk = ~clk;
    end    

    initial begin 
        $monitor("s=%d|r=%d|q=%d|q_inv=%d",s,r,q,q_inv);
        #10;    s=0; r=1;   
        #10;    s=0; r=1;   
        #10;    s=1; r=0;   
        #10;    s=0; r=0;   
        #10;    s=1; r=1;
        #10;    s=1; r=0;
        #10;    s=1; r=0;
        #10;    s=0; r=0;
        #10;    s=0; r=1;
        #10;    $finish;
    end

endmodule