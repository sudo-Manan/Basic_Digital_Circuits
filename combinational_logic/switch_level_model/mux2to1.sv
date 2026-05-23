module mux2to1 (y, sel, i1, i0);
    output wire y;
    input logic sel, i1, i0;
    
    supply1 vdd;
    supply0 vss;

    wire not_sel, w1, w1n, w2, w2n, w3n;

    pmos p_not (not_sel, vdd, sel);
    nmos n_not (not_sel, vss, sel);

    pmos p1nand1 (w1, vdd, i0);
    pmos p1nand2 (w1, vdd, not_sel);
    nmos n1nand1 (w1, w1n, i0);
    nmos n1nand2 (w1n, vss, not_sel);

    pmos p2nand1 (w2, vdd, i1);
    pmos p2nand2 (w2, vdd, sel);
    nmos n2nand1 (w2, w2n, i1);
    nmos n2nand2 (w2n, vss, sel);

    pmos p3nand1 (y, vdd, w1);
    pmos p3nand2 (y, vdd, w2);
    nmos n3nand1 (y, w3n, w1);
    nmos n3nand2 (w3n, vss, w2);
endmodule