`timescale 1ns/1ps

module bcd2bin (bcd, bin, invalid_input);
    input [3:0] bcd;
    output [3:0] bin;
    output invalid_input;

    always_comb begin
        if (bcd > 4'b1001) begin
            bin = 4'b0000;
            invalid_input = 1'b1;
        end
        else begin
            bin = bcd;
            invalid_input = 1'b0;
        end
    end
    
endmodule
