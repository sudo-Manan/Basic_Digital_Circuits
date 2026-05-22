module my_not (y, a);
    input logic a; 
    output logic y;
    supply1 vdd; 
    supply0 vss;
    logic not_a;
    pmos #(0.5,0.5) p1(not_a,vdd,a);
    nmos #(0.5,0.5) n1(not_a,vss,a);
    pmos #(0.5,0.5) p2(y,vdd,not_a);
    nmos #(0.5,0.5) n2(y,vss,not_a);
endmodule