`timescale 1ns/1ps

module gray2bin #(parameter WIDTH=4) (bin, gray);
    input logic [WIDTH-1:0] gray;
    output logic [WIDTH-1:0] bin;

    assign bin[WIDTH-1] = gray[WIDTH-1]; // MSB remains the same
    genvar i;
    generate 
        for (i = WIDTH-2; i >= 0; i = i - 1) begin : gen_bin
            assign bin[i] = gray[i] ^ bin[i+1];
        end
    endgenerate
    
endmodule