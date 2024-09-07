// Coder:           Eduardo Ethandrake Castillo Pulido
// Date:            07/09/2024
// File:			     is_equal.sv
// Module name:	  is_equal
// Project Name:	  mips_top
// Description:	  This is module to see if two signals are the same

module is_equal #(parameter LENGTH=1)(
	//inputs
	input [LENGTH-1:0] i_a,
    input [LENGTH-1:0] i_b,
	//outputs
	output reg o_c
);

assign o_c = (i_a == i_b) ? 1'b1 : 1'b0;

endmodule