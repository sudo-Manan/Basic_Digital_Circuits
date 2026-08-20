`timescale 1ns/1ps

module d_ff (q, d, clk, rst_n, en);
    output logic q;
    input logic d, clk, rst_n, en;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin 
            q<=0;
        end
        else if (en) begin
            q <= d;
        end
    end

endmodule