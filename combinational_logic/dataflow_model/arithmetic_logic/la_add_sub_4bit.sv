`timescale 1ns/1ps

module la_add_sub_4bit (
    output logic [3:0] s,
    output logic cout,
    input logic m,    // mode: 0=add, 1=subtract
    input logic [3:0] a, b,
    input logic cin
);
    logic [3:0] b_inv;      // not b for subtraction
    logic [3:0] p;      // propagate signal (a XOR b)
    logic [3:0] g;      // generate signal (a AND b)
    logic [4:0] c;      // carry chain

    //Invert b if subtracting (m=1)
    assign b_inv = b ^ {4{m}};

    //Calculate propagate and generate
    assign p = a ^ b_inv;
    assign g = a & b_inv;

    //lookahead logic 
    assign c[0] = m ? 1'b1 : cin;
    assign c[1] = g[0] | (p[0] & c[0]);
    assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c[0]);
    assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c[0]);
    assign c[4] = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & c[0]);

    
    // Calculate sum
    assign s = p ^ c[3:0];
    //Calculate carry out or borrow out
    assign cout = c[4];

endmodule