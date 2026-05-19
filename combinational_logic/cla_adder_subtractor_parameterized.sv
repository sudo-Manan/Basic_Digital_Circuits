module cla_add_sub #(parameter WIDTH = 4) (s, cout, m, a, b, cin);
    input logic m;
    input logic [WIDTH-1:0] a, b;
    input logic cin;
    output logic [WIDTH-1:0] s;
    output logic cout;
    logic [WIDTH-1:0] w_b, w_p, w_g, w3; //propagate and generate signals, p=a^b, g=a&b
    logic [WIDTH:0] c;
    my_nand_or or_m (.y(c[0]), .a(cin), .b(m)); // Using OR to generate c input, c = cin OR m, where m=0 for addition and m=1 for subtraction (inversion of b)

    genvar i;
    generate
        for (i = 0; i < WIDTH; i++) begin : gen_pg
            my_nand_xor xor_b (.y(w_b[x]), .a(b[x]), .b(m)); // Using XOR to generate modified b input, w_b = b XOR m
            my_nand_xor xor_p (.y(w_p[i]), .a(a[i]), .b(w_b[i])); // Using XOR to generate propagate signal, p = a XOR b
            my_nand_and and_g (.y(w_g[i]), .a(a[i]), .b(w_b[i])); // Using AND to generate generate signal, g = a & b
            my_nand_and and_carry (.y(w3[i]), .a(w_p[i]), .b(c[i])); // Using AND to calculate pi.ci
            my_nand_or or_carry (.y(c[i+1]), .a(w_g[i]), .b(w3[i])); // Using OR to calculate ci+1 = gi + pi.ci
            my_nand_xor xor_sum (.y(s[i]), .a(w_p[i]), .b(c[i])); // Using XOR to generate sum signal, si = pi XOR ci
        end
    endgenerate
    assign cout = c[WIDTH];
endmodule 