module my_and (y, a, b);
    input logic a,b; 
    output wire y;
    wire n1;
    
    nand n1_gate(n1, a, b);
    nand n2_gate(y, n1, n1);

endmodule