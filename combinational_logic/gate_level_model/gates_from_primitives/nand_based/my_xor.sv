module my_xor (y, a, b);
    input logic a,b; 
    output wire y;

    wire n1, n2, n3;

    nand nand1 (n1, a, b);
    nand nand2 (n2, a, n1);
    nand nand3 (n3, n1, b);
    nand nand4 (y, n2, n3);

endmodule