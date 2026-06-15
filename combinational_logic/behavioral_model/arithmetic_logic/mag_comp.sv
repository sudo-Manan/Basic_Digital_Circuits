`timescale 1ns/1ps

module mag_comp #(parameter WIDTH = 4) (a, b, a_gt_b, eq, a_lt_b);
    input logic [WIDTH-1:0] a, b;
    output logic a_gt_b, eq, a_lt_b;

    always_comb begin
        case (1'b1)
            (a > b): begin
                a_gt_b = 1;
                eq = 0;
                a_lt_b = 0;
            end
            (a == b): begin
                a_gt_b = 0;
                eq = 1;
                a_lt_b = 0;
            end
            default: begin          //(a < b): begin
                a_gt_b = 0;
                eq = 0;
                a_lt_b = 1;
            end
            // default: begin
            //     a_gt_b = 0;
            //     eq = 0;
            //     a_lt_b = 0;
            // end
        endcase
    end

    //used default to cover a<b case, but can also be done with an explicit case statement for a<b


endmodule