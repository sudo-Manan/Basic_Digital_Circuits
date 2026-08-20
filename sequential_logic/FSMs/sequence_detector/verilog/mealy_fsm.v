`timescale 1ns/1ps

module mealy_fsm(
    input clk,
    input rst_n,
    input in_bit,
    output reg y
);

    // State encoding
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    reg [1:0] present_state, next_state;


    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            present_state <= S0;
        else
            present_state <= next_state;
    end

    always @(present_state, in_bit) begin
        // Default values
        next_state = present_state;
        y = 1'b0;

        case (present_state)
            S0: begin
                if (in_bit)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                if (!in_bit)
                    next_state = S2;
                else
                    next_state = S1;
            end
            S2: begin
                if (in_bit)
                    next_state = S3; 
                else begin
                    next_state = S0; // Move to S0 on '0'
                end
            end
            S3: begin
                if (in_bit) begin
                    next_state = S1; // Move to S1 on '1'
                    y = 1'b1; // Output '1' when the sequence is detected
                end
                else
                    next_state = S2; // Move to S2 on '0'
            end
        endcase
    end

    // always @(present_state, in_bit) begin
    //     case (present_state)
    //         S3: y = in_bit ? 1'b0 : 1'b1; // Output '0' in state S3 unless the sequence is detected
    //         default: y = 1'b0; // Output '0' in all other states
    //     endcase
    // end

endmodule