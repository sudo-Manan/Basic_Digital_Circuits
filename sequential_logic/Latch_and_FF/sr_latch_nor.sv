module sr_latch_nor (q, q_bar, s, r);
    input logic s, r;
    output logic q, q_bar;

    always_latch begin : latch
        case ({s, r}) 
            2'b00: begin 
                //Hold
            end 
            2'b01: begin 
                q <= 1'b0;     // Reset
                q_bar <= 1'b1;
            end 
            2'b10: begin 
                q <= 1'b1; 
                q_bar = 1'b0;// Set 
            end
            2'b11: begin
                q <= 1'bx; // Invalid state
                q_bar <= 1'bx;
            end
            default: begin 
                q <= 1'bx; // Undefined state
                q_bar <= 1'bx;
            end
        endcase
    end

endmodule


// Cross-coupled NOR gates
// module sr_latch_nor (
//     output logic q, q_bar,
//     input logic s, r
// );
//     assign q = ~(r | q_bar);      // NOR(r, q_bar)
//     assign q_bar = ~(s | q);      // NOR(s, q)
// endmodule
