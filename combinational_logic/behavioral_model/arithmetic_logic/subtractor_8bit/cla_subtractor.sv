`timescale 1ns/1ps

module subtractor(diff, borrow, a, b);
    input logic [7:0] a,b;
    output logic [7:0] diff;
    output logic borrow;

    logic [7:0] b_comp;
    logic bin = 1'b1; // initial borrow-in for subtraction
    logic cout;

    assign b_comp = ~b; // 1's complement of b
    cla8 u_cla8 (.sum(diff), .cout(cout), .a(a), .b(b_comp), .cin(bin));
    assign borrow = ~cout; // borrow is the inverse of cout
    
endmodule