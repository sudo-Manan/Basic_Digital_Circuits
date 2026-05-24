module ripple_carry_add_sub #(parameter WIDTH = 4) (s, cout, m, a, b, cin);
  input logic m;
  input logic [WIDTH-1:0] a, b;
  input logic cin;
  output wire [WIDTH-1:0] s;
  output wire cout;

  wire [WIDTH-1:0] w_b, w_p, w_g, w3; //propagate and generate signals, p=a^b, g=a&b
  wire [WIDTH:0] c;

  or or_m (c[0], cin, m); // Using OR to generate c input, c = cin OR m, where m=0 for addition and m=1 for subtraction (inversion of b)

  genvar i;
  generate 
    for (i = 0; i < WIDTH; i=i+1) begin : gen_pg 
      xor xor_b (w_b[i], b[i], m); // Using XOR to generate modified b input, w_b = b XOR m
      xor xor_p (w_p[i], a[i], w_b[i]); // Using XOR to generate propagate signal, p = a XOR b
      and and_g (w_g[i], a[i], w_b[i]); // Using AND to generate generate signal, g = a & b
      and and_carry (w3[i], w_p[i], c[i]); // Using AND to calculate pi.ci
      or or_carry (c[i+1], w_g[i], w3[i]); // Using OR to calculate ci+1 = gi + pi.ci
      xor xor_sum (s[i], w_p[i], c[i]); // Using XOR to generate sum signal, si = pi XOR ci
    end
  endgenerate
  assign cout = c[WIDTH];
endmodule
