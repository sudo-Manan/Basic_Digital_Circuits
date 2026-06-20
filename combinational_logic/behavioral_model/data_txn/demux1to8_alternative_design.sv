`timescale 1ns/1ps

//case based design
module demux1to8 (y, in, sel);
    output logic [7:0] y;
    input logic in;
    input logic [2:0] sel;

     always_comb begin
        y =8'b0;
        case (sel)
            0: y[0]=in;
            1: y[1]=in;
            2: y[2]=in;
            3: y[3]=in;
            4: y[4]=in;
            5: y[5]=in;
            6: y[6]=in;
            7: y[7]=in;
            default: y=8'b0; // Default case to ensure all outputs are defined
        endcase
     end

endmodule