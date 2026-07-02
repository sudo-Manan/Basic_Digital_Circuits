`timescale 1ns/1ps

module mealy_seq_det_tb;
    logic clk = 0, rst_n, x, y;

    // Test vector: feed MSB first
    // Contains "1011" at positions [15:12] and overlapping at [12:9]
    // 0011_0110_1011_0110 — has one clear "1011" to verify
    logic [15:0] data = 16'b1011_0110_1011_0110;

    mealy_seq_det dut (.clk(clk), .rst_n(rst_n), .a(x), .y(y));

    always #5 clk = ~clk;   // 10ns period

    initial begin
        //$monitor("rst=%b | x=%b | state→y=%b", rst_n, x, y);

        // Reset
        x = 0; rst_n = 0;
        @(posedge clk); #1;
        rst_n = 1;

        // Shift in data MSB first, aligned to clock
        for (int i = 15; i >= 0; i--) begin
            $display("rst=%b | x=%b | state→y=%b | data=%b", rst_n, x, y, data[i]);
            @(posedge clk); #1;
            x = data[i];
        end

        @(posedge clk); #1;
        $finish;
    end
endmodule