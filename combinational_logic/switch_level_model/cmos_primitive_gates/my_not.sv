module my_not (y, a);
    input logic a; 
    output logic y;
    supply1 vdd; 
    supply0 vss;
    pmos p1(y,vdd,a);
    nmos n1(y,vss,a);
endmodule