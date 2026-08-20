`timescale 1ns/1ps

//behavioural logic for d flip flop 
module d_ff (q, q_bar, d, clk);
    output logic q, q_bar;
    input logic d, clk;

    always_ff @(posedge clk) begin
        q <= d;
    end
    
    assign q_bar = ~q;

endmodule

//dataflow logic for d flip flop
// module d_ff (q, q_bar, d, clk);
//     output logic q, q_bar;
//     input logic d, clk;

//     logic d_inv, wm1, wm2, ws1, ws2, wo, wo_inv, clk_inv;

//     assign clk_inv = ~clk;
//     assign d_inv = ~d;

//     assign wm1 = ~(clk_inv & d);
//     assign wm2 = ~(clk_inv & d_inv);
//     assign wo = ~(wm1 & wo_inv);
//     assign wo_inv = ~(wm2 & wo);

//     assign ws1 = ~(clk & wo);
//     assign ws2 = ~(clk & wo_inv);
//     assign q = ~(ws1 & q_bar);
//     assign q_bar = ~(ws2 & q);

// endmodule

