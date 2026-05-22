module my_or (y, a, b);
    input logic a,b; 
    output logic y;
    supply1 vdd; 
    supply0 vss;
    wire n1, n2;
    pmos #(0.5,0.5) p1(n1,vdd,a);
    pmos #(0.5,0.5) p2(n2,n1,b);
    nmos #(0.5,0.5) n1(n2,vss,a);
    nmos #(0.5,0.5) n2(n2,vss,b);
    pmos #(0.5,0.5) p3(y,vdd,n2);
    nmos #(0.5,0.5) n3(y,vss,n2);
endmodule
