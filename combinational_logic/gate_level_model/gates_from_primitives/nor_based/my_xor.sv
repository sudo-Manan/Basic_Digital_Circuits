module my_xor (y, a, b);
    input logic a,b; 
    output wire y;
    wire n1, n2, n3, n4;
    
    nor n1_gate(n1, a, b);
    nor n2_gate(n2, a, n1);
    nor n3_gate(n3, b, n1);
    nor n4_gate(n4, n2, n3);
    nor m5_gate(y, n4, n4);

endmodule