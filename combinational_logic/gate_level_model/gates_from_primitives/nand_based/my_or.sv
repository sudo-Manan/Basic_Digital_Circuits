module my_or (y, a, b);
    input logic a,b; 
    output wire y;
    wire n1, n2;
    
    nand n1_gate(n1, a, a);
    nand n2_gate(n2, b, b);
    nand n3_gate(y, n1, n2);

endmodule