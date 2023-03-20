// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            16/03/23
// File:			     Shift_Register_R_Param.v
// Module name:	  Shift_Register_R_Param
// Project Name:	  risc_v_top
// Description:	  Shifter for UART rx

module Shift_Register_R_Param #(parameter width = 9)
    (
    input clk,
    input rst,
    input enable,
    input d,
    output reg [width-1:0] Q
    );

always @(negedge rst, posedge clk)
	begin
		if (!rst)
			Q <= {width{1'b0}};
		else
			if (enable)
				Q <= {d,Q[width-1:1]};
	end
endmodule
