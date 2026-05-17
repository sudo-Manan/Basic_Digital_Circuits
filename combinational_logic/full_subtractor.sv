module FS (d, bout, a, b, bin);
    input logic a, b, bin;
    output logic d, bout;
    logic d1, c1, c2;
    HS hs1 (.a(a), .b(b), .d(d1), .bout(c1));
    HS hs2 (.a(d1), .b(bin), .d(d), .bout(c2));
    my_nand_or or1 (.y(bout), .a(c1), .b(c2));
endmodule