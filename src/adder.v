// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            16/03/23
// File:			     adder.v
// Module name:	  adder
// Project Name:	  risc_v_top
// Description:	  Perform add operation

module adder #(parameter LENGTH=1)(
	//inputs
	input [LENGTH-1:0] i_a, i_b,
	//outputs
	output [LENGTH-1:0] q
);

assign q = i_a + i_b;

endmodule