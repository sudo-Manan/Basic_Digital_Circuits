`timescale 1ns/1ps

module t_ff (q, q_bar, t, clk);
    output logic q, q_bar;
    input logic t;
    input logic clk;

    always_ff @(posedge clk) begin
        q <= t ^ q;         //uses xor gate
        //q <= t ? ~q : q;      //uses mux
    end

    assign q_bar = ~q;

endmodule