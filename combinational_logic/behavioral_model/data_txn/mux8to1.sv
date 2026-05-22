
module mux8to1 #(parameter WIDTH = 1) (
    output logic [WIDTH-1:0] y,
    input logic [WIDTH-1:0] in_sig [7:0],
    input logic [2:0] sel
);
    assign y = in_sig[sel]; 
endmodule 

module mux8to1_behavioral #(parameter WIDTH = 1) (
    output logic [WIDTH-1:0] y,
    input logic [WIDTH-1:0] in_sig [7:0],
    input logic [2:0] sel
);
    always_comb begin
        case (sel)
            3'b000: assign y = in_sig[0];
            3'b001: assign y = in_sig[1];
            3'b010: assign y = in_sig[2];
            3'b011: assign y = in_sig[3];
            3'b100: assign y = in_sig[4];
            3'b101: assign y = in_sig[5];
            3'b110: assign y = in_sig[6];
            3'b111: assign y = in_sig[7];
            default: assign y = {WIDTH{1'b0}}; // default case 
        endcase
    end 
endmodule