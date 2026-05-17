module cla_add (s, cout, a, b, cin);
    input logic [3:0] a, b;
    input logic cin;
    output logic [3:0] s;
    output logic cout;
    logic [3:0] w_p, w_g, w3; //propagate and generate signals, p=a^b, g=a&b
    logic [4:0] c;
    assign c[0] = cin;
    genvar i;
    generate
        for (i = 0; i < 4; i++) begin : gen_pg
            HA (.s(w_p[i]), .cout(w_g[i]), .a(a[i]), .b(b[i])); // Using half adder to generate propagate and generate signals
            HA (.s(s[i]), .cout(w3[i]), .a(w_p[i]), .b(c[i]));  // Using half adder to generate sum signal and calcultate pi.ci
            //my_nand_xor xor_sum (.y(s[i]), .a(w_p[i]), .b(c[i]));
            my_nand_or or_carry (.y(c[i+1]), .a(w_g[i]), .b(w3[i]));
        end
    endgenerate
    assign cout = c[4];
endmodule