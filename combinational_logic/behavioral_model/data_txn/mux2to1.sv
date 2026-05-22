// module mux2to1 (
//     output logic y,
//     input logic a, b,
//     input logic sel
// );
//     assign y = sel ? b : a;
// endmodule 

module mux2to1 #(parameter WIDTH = 1) (
    output logic [WIDTH-1:0] y,
    input logic [WIDTH-1:0] a, b,
    input logic sel
);
    assign y = sel ? b : a;
endmodule