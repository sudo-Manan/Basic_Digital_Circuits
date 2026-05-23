module hs (diff, borrow, a, b);
    input logic a, b;
    output logic diff;
    output logic borrow;

    logic not_a;

    xor (diff, a, b);
    not (not_a, a);
    and (borrow, not_a, b);
    
endmodule