module HA(s, cout, a, b);
    input logic a, b;
    output logic s, cout;
    my_nand_xor xor1 (.y(s), .a(a), .b(b));
    my_nand_and and1 (.y(cout), .a(a), .b(b));
endmodule