`timescale 1ns/1ps

//detect pattern 1011 (input moves from msb to lsb) using Moore FSM
module moore_seq_det (clk, rst_n, a, y); 
    input logic clk, rst_n;
    input logic a;
    output logic y;

    typedef enum logic [2:0] {
        S0 = 3'b000, 
        S1 = 3'b001, 
        S2 = 3'b010, 
        S3 = 3'b011
    } fsm_e;

    fsm_e reg_ps, reg_ns;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            reg_ps <= S0;
        else
            reg_ps <= reg_ns;
    end

    always_comb begin
        case (reg_ps)
            S0: reg_ns = (a) ? S1 : S0;
            S1: reg_ns = (a) ? S1 : S2;
            S2: reg_ns = (a) ? S3 : S0;     //we are assuming inclusivisty,i.e, for input pattern 1011011, we get output 1 twice ("101-1-011")
            S3: reg_ns = (a) ? S1 : S2;
            default: reg_ns = S0;
        endcase
    end

    always_comb begin
        case (reg_ps)
            S3: y = 1'b1;
            default: y = 1'b0;
        endcase
    end

endmodule