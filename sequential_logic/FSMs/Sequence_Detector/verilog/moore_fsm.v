`timescale 1ns/1ps

module moore_fsm(
    input clk,
    input rst_n,
    input in_bit,
    output reg y
);

    // State encoding
    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;
    reg [2:0] present_state, next_state;


    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            present_state <= S0;
        else
            present_state <= next_state;
    end

    always @(*) begin
        next_state = present_state;
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
                else 
                    next_state = S0; // Move to S0 on '0'
            end
            S3: begin
                if (in_bit)
                    next_state = S4; // Move to S4 on '1'
                else
                    next_state = S2; // Move to S2 on '0'
            end
            S4: begin
                if (in_bit)
                    next_state = S1; // Move to S1 on '1'
                else
                    next_state = S2; // Move to S2 on '0'
            end
        endcase
    end

    always @(*) begin
        // Default output
        y = 1'b0;
        case (present_state)
            S4: y = 1'b1; // Output '1' when in state S4 (sequence '1011' detected)
            default: begin
                y = 1'b0; // Output '0' for all other states
            end
        endcase
    end

endmodule