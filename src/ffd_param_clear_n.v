// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            16/03/23
// File:			     ffd_param_clear.v
// Module name:	  ffd_param_clear
// Project Name:	  risc_v_top
// Description:	  This is a flipflopD register module

module ffd_param_clear_n #(parameter LENGTH=1)(
	//inputs
	input i_clk,
	input i_rst_n,
	input i_en,
	input i_clear,
	input [LENGTH-1:0] d,
	//outputs
	output reg[LENGTH-1:0] q
);

//Parametrized flip flop with synchronous reset and enable signal
always@(negedge i_clk, negedge i_rst_n)
begin
	if(!i_rst_n)
		q <= 0;
	else if(i_clear)
		q <= 0;
	else if(i_en)
		q <= d;
	else
		q <= q;
end

endmodule