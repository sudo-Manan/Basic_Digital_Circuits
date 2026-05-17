module HS (d, bout, a, b);
    input logic a, b;
    output logic d, bout;
    logic not_a;
    my_nand_xor xor1 (.y(d), .a(a), .b(b));
    my_nand_not not1 (.y(not_a), .a(a));
    my_nand_and and1 (.y(bout), .a(not_a), .b(b)); 
endmodule