module hs_tb ();
    logic a, b;
    logic diff;
    logic borrow;

    hs dut (.diff(diff), .borrow(borrow), .a(a), .b(b));
    initial begin 
        $monitor("a = %b, b = %b, diff = %b, borrow = %b", a, b, diff, borrow);
        #5;     a = 1'b0; b = 1'b0;
        #5;     a = 1'b0; b = 1'b1;
        #5;     a = 1'b1; b = 1'b0;
        #5;     a = 1'b1; b = 1'b1;
        #5;     $finish;
    end

endmodule 
