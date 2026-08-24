`timescale 1ns/1ps

module bcd2bin (
    input [3:0] bcd,
    output [3:0] bin,
    output invalid_input
);
    wire a, b, c, d;
    assign {a, b, c, d} = bcd[3:0];
    always_comb begin
        invalid_input = a & (b | c);
        if (invalid_input)
            bin = 4'b0000;
        else 
            bin = bcd;
    end

endmodule