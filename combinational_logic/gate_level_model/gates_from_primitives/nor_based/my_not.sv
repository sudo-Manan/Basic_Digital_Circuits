module my_not (y, a);
    input logic a; 
    output wire y; 

    nor not_gate (y, a, a);

endmodule