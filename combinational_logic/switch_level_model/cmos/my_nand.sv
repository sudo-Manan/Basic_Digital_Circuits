module my_nand (y, a, b);
    input logic a,b; 
    output logic y;
    supply1 vdd; 
    supply0 vss;
    wire n_net;
    pmos #(0.5,0.5) p1(y,vdd,a);
    pmos #(0.5,0.5) p2(y,vdd,b);
    nmos #(0.5,0.5) n1(y,n_net,a);
    nmos #(0.5,0.5) n2(n_net,vss,b);
endmodule 
