module mux4to1 #(parameter WIDTH = 1) (
    output logic [WIDTH-1:0] y,
    input logic [WIDTH-1:0] a, b, c, d,
    input logic [1:0] sel
);
    always_comb begin
        case (sel)
            2'b00: assign y = a;
            2'b01: assign y = b;
            2'b10: assign y = c;
            2'b11: assign y = d;
            default: assign y = {WIDTH{1'b0}}; // default case to avoid latches
        endcase
    end
endmodule