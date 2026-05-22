module my_not (y, a);
    input logic a; 
    output logic y;
    supply1 vdd; 
    supply0 vss;
    pmos #(0.5,0.5) p1(y,vdd,a);
    nmos #(0.5,0.5) n1(y,vss,a);
endmodule