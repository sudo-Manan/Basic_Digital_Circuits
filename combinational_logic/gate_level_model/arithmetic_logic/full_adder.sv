module fa (carry_out, sum, carry_in, a, b);
    input logic a, b;
    input logic carry_in;
    output logic sum;
    output logic carry_out;
    
    logic carry_half_1, carry_half_2;
    logic wire_sum;

    ha half_adder_1 (.carry(carry_half_1), .sum(wire_sum), .a(a), .b(b));
    ha half_adder_2 (.carry(carry_half_2), .sum(sum), .a(wire_sum), .b(carry_in));
    or (carry_out, carry_half_1, carry_half_2);

endmodule