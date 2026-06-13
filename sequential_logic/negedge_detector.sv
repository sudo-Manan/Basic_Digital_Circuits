`timescale 1ns/1ps

module negedge_detector (falledge, signal, clk, rst_n);
    output logic faledge;
    input logic signal;
    input logic clk;
    input logic rst;

    logic ff1, ff2;
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            ff1 <= 1'b0;
            ff2 <= 1'b0;
        end 
        else begin
            ff1 <= signal;
            ff2 <= ff1;
        end
    end
    
    //assign risedge = ff1 & ~ff2;   // Rising edge only
    assign falledge = ~ff1 & ff2; // Falling edge only
    // assign risedge = ff1 ^ ff2;  // Both edges
endmodule