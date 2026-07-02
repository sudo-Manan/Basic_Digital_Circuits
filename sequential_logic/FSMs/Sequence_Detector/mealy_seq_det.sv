`timescale 1ns/1ps

// Detect pattern 1011 using Mealy FSM
// Inclusive/overlapping: 1011011 → output high twice
module mealy_seq_det (
    input  logic clk, rst_n,
    input  logic a,
    output logic y
);
    typedef enum logic [1:0] {S0, S1, S2, S3} fsm_e;
    fsm_e reg_ps, reg_ns;

    // State register
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) reg_ps <= S0;
        else        reg_ps <= reg_ns;
    end

    // Next-state logic
    always_comb begin
        case (reg_ps)
            S0: if (a) reg_ns = S1; else reg_ns = S0;
            S1: if (a) reg_ns = S1; else reg_ns = S2;
            S2: if (a) reg_ns = S3; else reg_ns = S0;
            S3: if (a) reg_ns = S1; else reg_ns = S2;
            default:   reg_ns = S0;
        endcase
    end

    // Output logic (Mealy: depends on state AND input)
    always_comb begin
        y = (reg_ps == S3 && a == 1'b1) ? 1'b1 : 1'b0;
    end

endmodule