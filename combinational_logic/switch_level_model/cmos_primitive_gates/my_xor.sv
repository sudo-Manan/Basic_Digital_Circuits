`timescale 1ns/1ps

module my_xor (y, a, b);
    input logic a,b; 
    output wire y;
    supply1 vdd; 
    supply0 vss;
    wire not_a, not_b, w1out, w1nmos, w2out, w2nmos, w3nmos;
    //not gates
    pmos p_not1(not_a,vdd,a);
    nmos n_not1(not_a,vss,a);
    pmos p_not2(not_b,vdd,b);
    nmos n_not2(not_b,vss,b);
    //and logic part
    pmos pmos1(w1out,vdd,a);
    pmos pmos2(w1out,vdd,not_b);
    nmos nmos1(w1out,w1nmos,a);
    nmos nmos2(w1nmos,vss,not_b);
    
    pmos pmos3(w2out,vdd,not_a);
    pmos pmos4(w2out,vdd,b);
    nmos nmos3(w2out,w2nmos,not_a);
    nmos nmos4(w2nmos,vss,b);
    //or logic part
    pmos pmos5(y,vdd,w1out);
    pmos pmos6(y,vdd,w2out);
    nmos nmos5(y,w3nmos,w1out);
    nmos nmos6(w3nmos,vss,w2out);
endmodule