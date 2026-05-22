module my_not (y, a);
    input logic a; 
    output logic y;
    supply1 vdd; 
    supply0 vss;
    logic not_a;
    pmos p1(not_a,vdd,a);
    nmos n1(not_a,vss,a);
    pmos p2(y,vdd,not_a);
    nmos n2(y,vss,not_a);
endmodule