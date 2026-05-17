module my_nand_or (y, a, b);
    input logic a,b; 
    output logic y;
    wire not_a, not_b;
    my_nand_not not1 (.y(not_a), .a(a));
    my_nand_not not2 (.y(not_b), .a(b));
    my_nand nand1 (.y(y), .a(not_a), .b(not_b));
endmodule