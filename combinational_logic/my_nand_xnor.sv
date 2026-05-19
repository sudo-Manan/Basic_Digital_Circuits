module my_nand_xnor (y, a, b);
    input logic a, b;
    output logic y;
   wire n1, n2, n3, w_out;
    my_nand nand1 (.y(n1), .a(a), .b(b));
    my_nand nand2 (.y(n2), .a(a), .b(n1));
    my_nand nand3 (.y(n3), .a(n1), .b(b));
    my_nand nand4 (.y(w_out), .a(n2), .b(n3));
    my_nand_not not1 (.y(y), .a(w_out));
endmodule