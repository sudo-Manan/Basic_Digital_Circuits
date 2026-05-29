`timescale 1ns / 1ps

module sr_latch_nand (q, q_bar, s, r);
    input logic s, r;
    output logic q, q_bar;

    always_latch begin : latch
        case ({s, r}) 
            2'b11: begin 
                //Hold
            end 
            2'b10: begin 
                q = 1'b0;     // Reset at active low
                q_bar = 1'b1;
            end 
            2'b01: begin 
                q = 1'b1; 
                q_bar = 1'b0; // Set at active low
            end
            2'b00: begin
                q = 1'bx; // Invalid state
                q_bar = 1'bx;
            end
            default: begin 
                q = 1'bx; // Undefined state
                q_bar = 1'bx;
            end
        endcase
    end

endmodule


// Cross-coupled NAND gates
// module sr_latch_nand (
//     output logic q, q_bar,
//     input logic s, r  // Active-LOW
// );
//     assign q = ~(s & q_bar);     // NAND(s, q_bar)
//     assign q_bar = ~(r & q);     // NAND(r, q)
// endmodule