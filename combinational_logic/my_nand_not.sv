module my_nand_not (y, a);
    input logic a; 
    output logic y;
    my_nand nand1 (.y(y), .a(a), .b(a));
endmodule
