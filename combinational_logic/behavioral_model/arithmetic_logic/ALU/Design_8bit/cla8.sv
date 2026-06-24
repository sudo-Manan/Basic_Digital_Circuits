`timescale 1ns/1ps

module cla8 (sum, cout, a, b, cin);
    input logic [7:0] a,b;
    input logic cin;
    output logic [7:0] sum;
    output logic cout;
    logic p0, g0;
    logic p1, g1;
    logic c4_u3to0, c4_u7to4;

    cla4 u3to0 (.sum(sum[3:0]), .cout(c4_u3to0), .a(a[3:0]), .b(b[3:0]), .cin(cin), .P(p0), .G(g0));
    assign c4_u7to4 = g0 | (p0 & cin);
    cla4 u7to4 (.sum(sum[7:4]), .cout(cout), .a(a[7:4]), .b(b[7:4]), .cin(c4_u7to4), .P(p1), .G(g1));

endmodule