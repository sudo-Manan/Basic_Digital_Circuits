`timescale 1ns/1ps

module jk_ff (q, q_bar, j, k, clk); 
    input logic clk, j, k;
    output logic q, q_bar;

    always_ff @(posedge clk) begin
        case ({j,k})
            2'b00: q <= q; //no change
            2'b01: q <= 1'b0; //reset
            2'b10: q <= 1'b1; //set
            2'b11: q <= ~q; //toggle
        endcase
    end
    assign q_bar = ~q; //complement of q

endmodule