module my_and (y, a, b);
    input logic a,b; 
    output logic y;
    supply1 vdd; 
    supply0 vss;
    wire n1, n2;
    pmos p1(n2,vdd,a);
    pmos p2(n2,vdd,b);
    nmos n1(n2,n1,a);
    nmos n2(n1,vss,b);
    pmos p3(y,vdd,n2);
    nmos n3(y,vss,n2);
endmodule