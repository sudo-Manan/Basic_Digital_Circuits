`timescale 1ns/1ps

module cla4 (sum, cout, a, b, cin, P, G);
    input logic [3:0] a, b;
    input logic cin;
    output logic [3:0] sum;
    output logic cout;
    output logic P, G;      //for daisy chaining multiple clas

    logic [3:0] p;
    logic [3:0] g;
    logic [4:0] c;

    // Bit propagate and generate
    assign p = a ^ b;
    assign g = a & b;

    assign c[0] = cin;

    // Carry Lookahead Logic
    assign c[1] = g[0] |
                  (p[0] & c[0]);

    assign c[2] = g[1] |
                  (p[1] & g[0]) |
                  (p[1] & p[0] & c[0]);

    assign c[3] = g[2] |
                  (p[2] & g[1]) |
                  (p[2] & p[1] & g[0]) |
                  (p[2] & p[1] & p[0] & c[0]);

    assign c[4] = g[3] |
                  (p[3] & g[2]) |
                  (p[3] & p[2] & g[1]) |
                  (p[3] & p[2] & p[1] & g[0]) |
                  (p[3] & p[2] & p[1] & p[0] & c[0]);

    // Sum bits
    assign sum = p ^ c[3:0];

    assign cout = c[4];

    // Group Propagate
    assign P = &p;

    // Group Generate
    assign G = g[3] |
               (p[3] & g[2]) |
               (p[3] & p[2] & g[1]) |
               (p[3] & p[2] & p[1] & g[0]);

endmodule