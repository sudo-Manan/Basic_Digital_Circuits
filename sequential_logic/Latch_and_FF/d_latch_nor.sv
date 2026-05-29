//behavioural logic for d latch using nor gate
module d_latch_nor (q, q_bar, d);
    output logic q, q_bar;
    input logic d;

    always_latch begin
        case (d)
            1'b0: begin
                q <= 1'b0;
                q_bar <= 1'b1;
            end
            1'b1: begin
                q <= 1'b1;
                q_bar <= 1'b0;
            end 
            default: begin
                q <= q;
                q_bar <= q_bar;
            end
        endcase
    end

endmodule

// module d_latch_nor (q, q_bar, d); 
//     output logic q, q_bar;
//     input logic d;

//     logic s, r;

//     assign s = d;
//     assign r = ~d;
//     assign q = ~(r | q_bar);
//     assign q_bar = ~(s | q);

// endmodule