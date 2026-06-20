`timescale 1ns/1ps

module mag_comp_tb;
    parameter WIDTH = 4;
    logic [WIDTH-1:0] a, b;
    logic a_gt_b, eq, a_lt_b;

    mag_comp #(WIDTH) uut (.a(a), .b(b), .a_gt_b(a_gt_b), .eq(eq), .a_lt_b(a_lt_b));

    initial begin
        // Test case 1: a > b
        a = 4'd10;   //1010; // 10 in decimal
        b = 4'd6;   //0110; // 6 in decimal
        #10; // Wait for 10 time units
        $display("Test case 1: a = %b, b = %b, a_gt_b = %b, eq = %b, a_lt_b = %b", a, b, a_gt_b, eq, a_lt_b);

        // Test case 2: a == b
        a = 4'b1100; // 12 in decimal
        b = 4'b1100; // 12 in decimal
        #10; // Wait for 10 time units
        $display("Test case 2: a = %b, b = %b, a_gt_b = %b, eq = %b, a_lt_b = %b", a, b, a_gt_b, eq, a_lt_b);

        // Test case 3: a < b
        a = 4'b0011; // 3 in decimal
        b = 4'b0101; // 5 in decimal
        #10; // Wait for 10 time units
        $display("Test case 3: a = %b, b = %b, a_gt_b = %b, eq = %b, a_lt_b = %b", a, b, a_gt_b, eq, a_lt_b);

        $finish; // End the simulation
    end

endmodule