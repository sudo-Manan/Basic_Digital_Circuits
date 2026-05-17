module FA(s, cout, a, b, cin);
    input logic a, b, cin;
    output logic s, cout;
    logic s1, c1, c2;
    HA ha1 (.a(a), .b(b), .s(s1), .cout(c1));
    HA ha2 (.a(s1), .b(cin), .s(s), .cout(c2));
    my_nand_or or1 (.y(cout), .a(c1), .b(c2));
endmodule