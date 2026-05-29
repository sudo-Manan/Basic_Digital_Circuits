module my_and (y, a, b);
    output wire y;
    input logic a, b;
    wire n1, n2;

    nor not1 (n1, a, a);
    nor not2 (n2, b, b);
    nor and_gate (y, n1, n2);

endmodule