`timescale 1ns/1ps

//behavioural logic for d latch 
module d_latch (q, q_bar, d, en);
    output logic q, q_bar;
    input logic d, en;

    always_latch begin
        case ({en,d})
            2'b10: begin
                q = 1'b0;
                q_bar = 1'b1;
            end
            2'b11: begin
                q = 1'b1;
                q_bar = 1'b0;
            end 
            default: begin
                q = q;
                q_bar = q_bar;
            end
        endcase
    end

endmodule


//dataflow logic for d latch 
// module d_latch (q, q_bar, d, en); 
//     output logic q, q_bar;
//     input logic d, en;

//     logic d_inv, s, r;

//     //d latch using nor based sr latch
//     assign d_inv = ~d;
//     assign s = en & d;
//     assign r = en & d_inv;
//     assign q = ~(r | q_bar);
//     assign q_bar = ~(s | q);

//     //d latch using nand based sr latch
//     // assign d_inv = ~d;
//     // assign s = ~(en & d);
//     // assign r = ~(en & d_inv);
//     // assign q = ~(s & q_bar);
//     // assign q_bar = ~(r & q);

// endmodule