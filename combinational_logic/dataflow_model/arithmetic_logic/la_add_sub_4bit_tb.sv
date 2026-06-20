`timescale 1ns/1ps

module la_add_sub_4bit_tb;
    parameter WIDTH = 4;
    logic m;
    logic [WIDTH-1:0] a, b;
    logic cin;
    logic [WIDTH-1:0] s;
    logic cout;

    la_add_sub_4bit dut (.s(s), .cout(cout), .m(m), .a(a), .b(b), .cin(cin));

    //use with icarus verilog and terosHDL on vs code to generate output vvp and waveform
    // initial begin 
    //     $dumpfile("cla_add_sub_4bit.vcd");
    //     $dumpvars(0, dut);
    // end

    integer i, j, k;
    initial begin 
        m = 0; a = 0; b = 0; cin = 0;
        $monitor("m: %b | a: %b | b: %b | cin: %b | s: %b | cout: %b", m, a, b, cin, s, cout);
        #10; 
        for (i = 0; i < 2**WIDTH; i = i + 1) begin
            m = 0; 
            a = i; 
            for (j = 0; j < 2**WIDTH; j = j + 1) begin
                b = j;
                for (k = 0; k < 2; k = k + 1) begin
                    cin = k; 
                    #10; 
                end
            end
        end
        for (i = 0; i < 2**WIDTH; i = i + 1) begin
            m = 1; 
            a = i; 
            for (j = 0; j < 2**WIDTH; j = j + 1) begin
                b = j;
                for (k = 0; k < 2; k = k + 1) begin
                    cin = k; 
                    #10; 
                end
            end
        end
        $finish;
    end

endmodule