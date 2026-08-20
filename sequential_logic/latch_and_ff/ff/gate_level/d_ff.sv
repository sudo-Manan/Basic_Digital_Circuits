`timescale 1ns/1ps

module d_ff (q, d, clk, rst_n);
    output wire q;
    input logic d, clk, rst_n;

    wire clk_inv, d_inv, q_master, q_inv_master, q_inv_slave, s_wm, r_wm, s_ws, r_ws; 

    nand nand_clk_inv (clk_inv, clk, clk);
    nand nand_inv_d (d_inv, d, d);
    
    nand nand_m1 (s_wm, d, clk_inv, rst_n);
    nand nand_m2 (r_wm, d_inv, clk_inv);
    nand nand_m3 (q_master, s_wm, q_inv_master);
    nand nand_m4 (q_inv_master, r_wm, q_master, rst_n);

    nand nand_s1 (s_ws, clk, q_master);
    nand nand_s2 (r_ws, clk, q_inv_master);
    nand nand_s3 (q, s_ws, q_inv_slave);
    nand nand_s4 (q_inv_slave, r_ws, q);

endmodule

// nand based d flip flop without reset
// module gate_d_ff (q, d, clk);
//     output wire q;
//     input logic d;
//     input logic clk;

//     wire w1, w2, w3, w4, w5, w6, w7, w8;


//     nand nand1(w2, clk, w1);
//     nand nand2(w1, w2, w3);

//     nand nand3(w4, clk, w3);
//     nand nand3a(w7, w4, w4);
//     nand nand3b(w8, w2, w7);
//     nand nand4(w3, w8, d);

//     nand nand5(w6, w2, w5);
//     nand nand6(w5, w6, w8);

//     assign q = w6;
// endmodule