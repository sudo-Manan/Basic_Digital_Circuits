`timescale 1ns/1ps

module mux8to1_tb;
    parameter WIDTH = 4; // Example width
    logic [WIDTH-1:0] y;
    logic [WIDTH-1:0] in_sig [7:0]; // 8 input signals
    logic [2:0] sel;

    // Instantiate the mux8to1 module
    mux8to1_behavioral #(WIDTH) uut (
        .y(y),
        .in_sig(in_sig),
        .sel(sel)
    );

    initial begin
        // Initialize input signals
        in_sig[0] = 4'b0001; // a
        in_sig[1] = 4'b0010; // b
        in_sig[2] = 4'b0011; // c
        in_sig[3] = 4'b0100; // d
        in_sig[4] = 4'b0101; // e
        in_sig[5] = 4'b0110; // f
        in_sig[6] = 4'b0111; // g
        in_sig[7] = 4'b1000; // h

        // Test all select lines
        $monitor("sel: %b, y: %b", sel, y);
        #10;
        for (int i = 0; i < 8; i++) begin
            sel = i;
            #10; // Wait for some time to observe the output
        end

        $finish;
    end
endmodule