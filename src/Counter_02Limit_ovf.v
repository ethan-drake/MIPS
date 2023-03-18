`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer: Cuauhtemoc Aguilera
//////////////////////////////////////////////////////////////////////////
module Counter_02Limit_ovf #(parameter N=3, parameter Limit = 4)(
    input rst_n,
    input enable,
    input clk,
    input clear,
    output reg [N-1:0] Q,
    output overflow,
    output pre_overflow
 );
assign overflow = (Q==Limit)? 1'b1 : 1'b0;
assign pre_overflow = (Q==(Limit-1'b1))? 1'b1 : 1'b0;

 always @(negedge rst_n, posedge clk)
  begin
    if(!rst_n)
        Q <= {N{1'b0}};
    else
        if(clear)
            Q <= {N{1'b0}};
        else if (enable)
            if (Q==Limit)
                Q <= {N{1'b0}};
            else
                Q <= Q + 1'b1;
        else
            Q <= Q;
  end 
endmodule
