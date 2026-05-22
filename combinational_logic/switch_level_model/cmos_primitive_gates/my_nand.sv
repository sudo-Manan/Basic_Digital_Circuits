module my_nand (y, a, b);
    input logic a,b; 
    output logic y;
    supply1 vdd; 
    supply0 vss;
    wire n_net;
    pmos p1(y,vdd,a);
    pmos p2(y,vdd,b);
    nmos n1(y,n_net,a);
    nmos n2(n_net,vss,b);
endmodule 
