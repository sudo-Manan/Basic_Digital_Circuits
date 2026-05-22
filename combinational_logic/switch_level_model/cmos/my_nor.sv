module my_nor (y, a, b);
    input logic a,b; 
    output logic y;
    supply1 vdd; 
    supply0 vss;
    wire n_net;
    pmos #(0.5,0.5) p1(n_net,vdd,a);
    pmos #(0.5,0.5) p2(y,n_net,b);
    nmos #(0.5,0.5) n1(y,vss,a);
    nmos #(0.5,0.5) n2(y,vss,b);
endmodule
