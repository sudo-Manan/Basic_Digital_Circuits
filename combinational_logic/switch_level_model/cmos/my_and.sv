module my_and (y, a, b);
    input logic a,b; 
    output logic y;
    supply1 vdd; 
    supply0 vss;
    wire n1, n2;
    pmos #(0.5,0.5) p1(n2,vdd,a);
    pmos #(0.5,0.5) p2(n2,vdd,b);
    nmos #(0.5,0.5) n1(n2,n1,a);
    nmos #(0.5,0.5) n2(n1,vss,b);
    pmos #(0.5,0.5) p3(y,vdd,n2);
    nmos #(0.5,0.5) n3(y,vss,n2);
endmodule