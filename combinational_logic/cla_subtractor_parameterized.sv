module cla_subtractor #(parameter WIDTH = 4) (d, bout, a, b, bin);
    input logic [WIDTH-1:0] a, b;
    input logic bin;
    output logic [WIDTH-1:0] d;
    output logic bout;
    logic [WIDTH-1:0] w_p, w_g, not_a, w3; //propagate and generate signals, p=a^b, g=a&b
    logic [WIDTH:0] borrow;
    assign borrow[0] = bin;
    genvar i;
    generate
        for (i = 0; i < WIDTH; i++) begin : gen_pg 
            my_nand_xor xor_p (.y(w_p[i]), .a(a[i]), .b(b[i])); // Using XOR to generate propagate signal, p = a XOR b
            my_nand_not not_a (.y(not_a[i]), .a(a[i])); // Using NOT to generate generate signal, g = ~a.b
            my_nand_and and_g (.y(w_g[i]), .a(not_a[i]), .b(b[i])); // Using AND to generate generate signal, g = ~a.b
            my_nand_and and_borrow (.y(w3[i]), .a(w_p[i]), .b(borrow[i])); // Using AND to calculate pi.bouti
            my_nand_or or_borrow (.y(borrow[i+1]), .a(w_g[i]), .b(w3[i])); // Using OR to calculate bouti+1 = gi + pi.bouti
            my_nand_xor xor_diff (.y(d[i]), .a(w_p[i]), .b(borrow[i])); // Using XOR to generate difference signal, di = pi XOR bouti
        end : gen_pg
    endgenerate
    assign bout = borrow[WIDTH];
endmodule 