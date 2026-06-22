`timescale 1ns/1ps

//import generic_alu_pkg::*;
package generic_alu_pkg;

    // Fixed width to 3 bits to match 0-7 values
    typedef enum logic [2:0] {
        OP_AND      = 3'd0,
        OP_OR       = 3'd1,
        OP_ADD      = 3'd2,
        OP_RST      = 3'd3,
        OP_COND_AND = 3'd4,
        OP_COND_OR  = 3'd5,
        OP_SUB      = 3'd6,
        OP_SLT      = 3'd7
    } alu_opcode;

endpackage

module generic_alu #(parameter WIDTH = 16) (
    input  logic [WIDTH-1:0] a, b,
    input  generic_alu_pkg::alu_opcode op,       // Removed incorrect [3:0] array definition
    input  logic [3:0] flag_in,  // Uses bit positions for standard flag manipulation
    output logic [WIDTH-1:0] y,
    output logic [3:0] flag_out // 4-bit output flag bus [N, Z, C, V]
);

    // Local constants for MSB sizing
    localparam MSB = WIDTH - 1;

    // Bit index positions for flags to allow clean array indexing
    localparam int N = 3;
    localparam int Z = 2;
    localparam int C = 1;
    localparam int V = 0;
    
    // Internal signals for intermediate calculations
    logic [WIDTH:0] sub_res; 
    logic cin;

    always_comb begin 
        // Default assignments to prevent latch generation
        y = '0;
        flag_out = '0;
        cin = flag_in[C];
        case (op) 
            generic_alu_pkg::OP_AND: begin
                y = a & b;
            end
            generic_alu_pkg::OP_OR: begin
                y = a | b;
            end
            generic_alu_pkg::OP_ADD: begin
                // Carry-in added to the sum
                {flag_out[C], y} = a + b + cin;
                // Overflow flag logic for addition
                flag_out[V] = (a[MSB] == b[MSB]) && (y[MSB] != a[MSB]);
            end
            generic_alu_pkg::OP_SUB: begin
                // Subtraction with borrow-in handling
                {flag_out[C], y} = a - b - cin;
                // Overflow flag logic for subtraction
                flag_out[V] = (a[MSB] != b[MSB]) && (y[MSB] != a[MSB]);
            end
            generic_alu_pkg::OP_COND_AND: begin
                // and -> A AND NOT(B)
                y = a & ~b;
            end
            generic_alu_pkg::OP_COND_OR: begin
                // or -> A OR NOT(B)
                y = a | ~b;
            end
            generic_alu_pkg::OP_SLT: begin
                // Set Less Than (signed comparison)
                y = {{(WIDTH-1){1'b0}}, ($signed(a) < $signed(b))};
            end
            generic_alu_pkg::OP_RST: begin
                y = '0;
            end
            default: begin
                y = '0;
            end
        endcase
        // Global Flag Generations (Sign and Zero)
        flag_out[N] = y[MSB];  // Negative flag follows the MSB bit
        flag_out[Z] = (y == 0); // Zero flag set if all output bits are zero
    end

endmodule