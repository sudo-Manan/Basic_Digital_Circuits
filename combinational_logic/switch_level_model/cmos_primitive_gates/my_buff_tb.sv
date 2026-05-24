module my_buff_tb;
    logic a;
    wire y;
    my_buff dut(.y(y), .a(a));

    //use with icarus verilog and terosHDL on vs code to generate output vvp and waveform
    // initial begin
    //     $dumpfile("my_buff_tb.vcd");
    //     $dumpvars(0, my_buff_tb);
    // end

    initial begin
        $monitor("a=%b, y=%b", a, y);
        #5;    a = 0;
        #5;    a = 1;
        #5;    $finish;
    end 
endmodule