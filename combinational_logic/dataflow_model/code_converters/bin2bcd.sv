`timescale 1ns/1ps

module bin2bcd (bin, bcd, invalid_input);
    input  logic [3:0] bcd;
    output logic [3:0] bin;
    output logic invalid_input;

    assign invalid_input = bin[3] & (bin[2] | bin[1]);
    assign bcd = invalid_input ? 4'b0000 : bin;

endmodule