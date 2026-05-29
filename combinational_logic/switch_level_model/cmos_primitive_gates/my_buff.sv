`timescale 1ns/1ps

module my_buff (y, a);
    input logic a; 
    output wire y;

    supply1 vdd; 
    supply0 vss;
    wire not_a;

    pmos pmos1(not_a,vdd,a);
    nmos nmos1(not_a,vss,a);
    pmos pmos2(y,vdd,not_a);
    nmos nmos2(y,vss,not_a);
    
endmodule