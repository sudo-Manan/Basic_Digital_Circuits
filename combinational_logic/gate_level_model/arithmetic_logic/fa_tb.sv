`timescale 1ns/1ps

module fa_tb ();
    logic a, b, cin;
    logic sum;
    logic carry;

    fa dut (.carry_out(carry), .sum(sum), .a(a), .b(b), .carry_in(cin));

    //use with icarus verilog and terosHDL on vs code to generate output vvp and waveform
    // initial begin
    //     $dumpfile("fa_tb.vcd");
    //     $dumpvars(0, fa_tb);
    // end
    
    initial begin 
        $monitor("a = %b, b = %b, cin = %b, sum = %b, carry = %b", a, b, cin, sum, carry);
        #5;     a = 1'b0; b = 1'b0; cin = 1'b0;
        #5;     a = 1'b0; b = 1'b0; cin = 1'b1;
        #5;     a = 1'b0; b = 1'b1; cin = 1'b0;
        #5;     a = 1'b0; b = 1'b1; cin = 1'b1;
        #5;     a = 1'b1; b = 1'b0; cin = 1'b0;
        #5;     a = 1'b1; b = 1'b0; cin = 1'b1;
        #5;     a = 1'b1; b = 1'b1; cin = 1'b0;
        #5;     a = 1'b1; b = 1'b1; cin = 1'b1;
        #5;     $finish;
    end

endmodule