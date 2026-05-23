module ha (carry, sum, a, b);
    input logic  a, b;
    output logic sum;
    output logic carry;

    xor (sum, a, b);
    and (carry, a, b); 

endmodule