`timescale 1ns/1ps

module fs (diff, borrow_out, borrow_in, a, b);
    input logic a, b;
    input logic borrow_in;
    output logic diff;
    output logic borrow_out;

    logic borrow_half_1, borrow_half_2;
    logic wire_diff;

    hs half_subtractor_1 (.diff(wire_diff), .borrow(borrow_half_1), .a(a), .b(b));
    hs half_subtractor_2 (.diff(diff), .borrow(borrow_half_2), .a(wire_diff), .b(borrow_in));
    or (borrow_out, borrow_half_1, borrow_half_2);
    
endmodule