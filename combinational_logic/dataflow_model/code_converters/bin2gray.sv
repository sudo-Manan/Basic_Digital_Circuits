`timescale 1ns/1ps

module bin2gray #(parameter WIDTH = 4) (gray, bin);
    input logic [WIDTH-1:0] bin;
    output logic [WIDTH-1:0] gray;

    assign gray[WIDTH-1] = bin[WIDTH-1]; // MSB remains the same
    genvar i;
    generate 
        for (i = 0; i < WIDTH-1; i = i + 1) begin : gen_gray
            assign gray[i] = bin[i] ^ bin[i+1];
        end
    endgenerate

endmodule