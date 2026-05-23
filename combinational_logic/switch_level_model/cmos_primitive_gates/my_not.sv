module my_not (y, a);
    input logic a; 
    output wire y;
    supply1 vdd; 
    supply0 vss;
    pmos pmos1(y,vdd,a);
    nmos nmos1(y,vss,a);
endmodule