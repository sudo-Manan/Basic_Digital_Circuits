`timescale 1ns/1ps

module my_nor (y, a, b);
    input logic a,b; 
    output wire y;
    supply1 vdd; 
    supply0 vss;
    wire n_net;
    pmos pmos1(n_net,vdd,a);
    pmos pmos2(y,n_net,b);
    nmos nmos1(y,vss,a);
    nmos nmos2(y,vss,b);
endmodule
