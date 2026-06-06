`timescale 1ns/1ps

module sr_ff (q, q_bar, clk, s, r);
    output logic q, q_bar;
    input logic clk, s, r;
    
    always_ff @(posedge clk) begin
        case ({s, r})
            //2'b00: q <= q;      // hold
            2'b01: q <= 1'b0;   // reset
            2'b10: q <= 1'b1;   // set
            2'b11: q <= 1'bx;   // invalid
        endcase
    end
    
    assign q_bar = ~q;

endmodule
