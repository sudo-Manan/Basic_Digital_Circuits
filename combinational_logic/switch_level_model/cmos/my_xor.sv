module my_xor (y, a, b);
    input logic a,b; 
    output logic y;
    supply1 vdd; 
    supply0 vss;
    wire not_a, not_b, w1out, w1nmos, w2out, w2nmos, w3nmos;
    //not gates
    pmos #(0.5,0.5) p_not1(not_a,vdd,a);
    nmos #(0.5,0.5) n_not1(not_a,vss,a);
    pmos #(0.5,0.5) p_not2(not_b,vdd,b);
    nmos #(0.5,0.5) n_not2(not_b,vss,b);
    //and logic part
    pmos #(0.5,0.5) p1(w1out,vdd,a);
    pmos #(0.5,0.5) p2(w1out,vdd,not_b);
    nmos #(0.5,0.5) n1(w1out,w1nmos,a);
    nmos #(0.5,0.5) n2(w1nmos,vss,not_b);
    
    pmos #(0.5,0.5) p3(w2out,vdd,not_a);
    pmos #(0.5,0.5) p4(w2out,vdd,b);
    nmos #(0.5,0.5) n3(w2out,w2nmos,not_a);
    nmos #(0.5,0.5) n4(w2nmos,vss,b);
    //or logic part
    pmos #(0.5,0.5) p5(y,vdd,w1out);
    pmos #(0.5,0.5) p6(y,vdd,w2out);
    nmos #(0.5,0.5) n5(y,w3nmos,w1out);
    nmos #(0.5,0.5) n6(w3nmos,vss,w2out);
endmodule