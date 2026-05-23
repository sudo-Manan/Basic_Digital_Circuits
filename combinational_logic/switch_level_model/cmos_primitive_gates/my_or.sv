module my_or (y, a, b);
    input logic a,b; 
    output wire y;
    supply1 vdd; 
    supply0 vss;
    wire n1, n2;
    pmos pmos1(n1,vdd,a);
    pmos pmos2(n2,n1,b);
    nmos nmos1(n2,vss,a);
    nmos nmos2(n2,vss,b);
    pmos pmos3(y,vdd,n2);
    nmos nmos3(y,vss,n2);
endmodule
