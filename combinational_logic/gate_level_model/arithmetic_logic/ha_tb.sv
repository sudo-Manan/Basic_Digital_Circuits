module ha_tb ();
    logic a, b;
    logic sum;
    logic carry;

    ha dut (.carry(carry), .sum(sum), .a(a), .b(b));
    initial begin 
        $monitor("a = %b, b = %b, sum = %b, carry = %b", a, b, sum, carry);
        #5;     a = 1'b0; b = 1'b0;
        #5;     a = 1'b0; b = 1'b1;
        #5;     a = 1'b1; b = 1'b0;
        #5;     a = 1'b1; b = 1'b1;
        #5;     $finish;
    end

endmodule