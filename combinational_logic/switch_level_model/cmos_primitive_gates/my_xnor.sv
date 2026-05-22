module my_xnor (y, a, b);
    input logic a,b; 
    output logic y;
    supply1 vdd; 
    supply0 vss;
    wire not_a, not_b, w1out, w1nmos, w2out, w2nmos, w3nmos;
    //not gates
    pmos p_not1(not_a,vdd,a);
    nmos n_not1(not_a,vss,a);
    pmos p_not2(not_b,vdd,b);
    nmos n_not2(not_b,vss,b);
    //and logic part
    pmos p1(w1out,vdd,a);
    pmos p2(w1out,vdd,b);
    nmos n1(w1out,w1nmos,a);
    nmos n2(w1nmos,vss,b);
    
    pmos p3(w2out,vdd,not_a);
    pmos p4(w2out,vdd,not_b);
    nmos n3(w2out,w2nmos,not_a);
    nmos n4(w2nmos,vss,not_b);
    //or logic part
    pmos p5(y,vdd,w1out);
    pmos p6(y,vdd,w2out);
    nmos n5(y,w3nmos,w1out);
    nmos n6(w3nmos,vss,w2out);
endmodule