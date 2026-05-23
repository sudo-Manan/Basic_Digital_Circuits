module mux8to1 #(parameter WIDTH = 1) (
    output logic [WIDTH-1:0] y,
    input logic [WIDTH-1:0] in_sig [7:0],
    input logic [2:0] sel
);
    assign y = in_sig[sel]; 
endmodule 
