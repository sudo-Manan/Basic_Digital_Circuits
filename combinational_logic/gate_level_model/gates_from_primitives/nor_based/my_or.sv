module my_or (y, a, b);
    input logic a,b; 
    output wire y;
    wire n1;

    nor nor_gate (n1, a, b);
    nor not1 (y, n1, n1);

endmodule