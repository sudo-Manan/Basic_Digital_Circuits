module my_not (y, a);
    input logic a; 
    output wire y;
    
    nand n1_gate(y, a, a); 

endmodule