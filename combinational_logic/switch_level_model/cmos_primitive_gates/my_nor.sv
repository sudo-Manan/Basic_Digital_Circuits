module my_nor (y, a, b);
    input logic a,b; 
    output logic y;
    supply1 vdd; 
    supply0 vss;
    wire n_net;
    pmos p1(n_net,vdd,a);
    pmos p2(y,n_net,b);
    nmos n1(y,vss,a);
    nmos n2(y,vss,b);
endmodule
