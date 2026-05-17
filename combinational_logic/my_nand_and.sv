module my_nand_and (y, a, b);
    input logic a,b; 
    output logic y;
    wire n1;
    my_nand nand1 (.y(n1), .a(a), .b(b));
    my_nand_not not1 (.y(y), .a(n1));
endmodule