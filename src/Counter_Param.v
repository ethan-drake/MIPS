// Coder:           Cuauhtemoc Aguilera
// Date:            09/09/22
// File:			     Counter_Param.v
// Module name:	  Counter_Param
// Project Name:	  risc_v_top
// Description:	  Counter param

module Counter_Param
 # (parameter n = 8)
(
    input clk,
    input rst,
    input enable,
    output reg [n-1:0] Q
    );

always @(posedge rst, posedge clk) 
    begin
        if (rst)
            Q <= {n{1'b0}};
        else
            if (enable)
                Q <= Q + 1'b1;
            else
                Q <= Q;
    end 
endmodule

