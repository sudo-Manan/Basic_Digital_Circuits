`timescale 1ns/1ps

module decoder3to8 (
    input  logic [2:0] sel,
    output logic [7:0] y
);
    assign y = (8'b1 << sel);
endmodule

// module decoder3to8 (
//     input  logic [2:0] a,
//     output wire [7:0] y
// ); 

//     assign y[0] = ~a[2] & ~a[1] & ~a[0];
//     assign y[1] = ~a[2] & ~a[1] &  a[0];
//     assign y[2] = ~a[2] &  a[1] & ~a[0];
//     assign y[3] = ~a[2] &  a[1] &  a[0];
//     assign y[4] = a[2] & ~a[1] & ~a[0];
//     assign y[5] = a[2] & ~a[1] &  a[0];
//     assign y[6] = a[2] &  a[1] & ~a[0];
//     assign y[7] = a[2] &  a[1] &  a[0];

// endmodule