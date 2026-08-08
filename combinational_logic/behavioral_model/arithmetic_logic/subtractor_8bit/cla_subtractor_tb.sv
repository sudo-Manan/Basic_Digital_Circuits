`timescale 1ns/1ps

module cla_subtractor_tb;
    logic [7:0] a, b;
    logic [7:0] diff;
    logic borrow;

    subtractor u_subtractor(.diff(diff), .borrow(borrow), .a(a), .b(b));

    initial begin
        $dumpfile("cla_subtractor_tb.vcd");
        $dumpvars(0, cla_subtractor_tb);
    end

    initial begin
        // Test case 1
        a = 8'b00001111; // 15
        b = 8'b00000101; // 5
        #10;
        $display("Test Case 1: a=%d, b=%d, diff=%d, borrow=%b", a, b, diff, borrow);

        // Test case 2
        a = 8'b00000101; // 5
        b = 8'b00001111; // 15
        #10;
        $display("Test Case 2: a=%d, b=%d, diff=%d, borrow=%b", a, b, diff, borrow);

        // Test case 3
        a = 8'b11111111; // -1 in two's complement
        b = 8'b00000001; // 1
        #10;
        $display("Test Case 3: a=%d, b=%d, diff=%d, borrow=%b", a, b, diff, borrow);

        // Test case 4
        a = 8'b00000000; // 0
        b = 8'b00000000; // 0
        #10;
        $display("Test Case 4: a=%d, b=%d, diff=%d, borrow=%b", a, b, diff, borrow);

        // Test case 5
        a = 8'd128; // -128 in two's complement
        b = 8'd127; // 127
        #10;
        $display("Test Case 5: a=%d, b=%d, diff=%d, borrow=%b", a, b, diff, borrow);

        // Test case 6
        a = 8'd127; // -128 in two's complement
        b = 8'd128; // 127
        #10;
        $display("Test Case 6: a=%d, b=%d, diff=%d, borrow=%b", a, b, diff, borrow);

        // Test case 7
        a = 8'd0; // -128 in two's complement
        b = 8'd255; // 127
        #10;
        $display("Test Case 7: a=%d, b=%d, diff=%d, borrow=%b", a, b, diff, borrow);

        $finish;
    end
endmodule