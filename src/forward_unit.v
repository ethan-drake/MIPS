// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            20/04/23
// File:			     forward_unit.v
// Module name:	  forward_unit
// Project Name:	  risc_v_top
// Description:	  Forwarding unit

module forward_unit (
	//Inputs
	input ex_mem_regWrite,
	input [4:0] ex_mem_rd, id_ex_reg_rs1, id_ex_reg_rs2,
	//Outputs
	output reg [1:0] forwardA, forwardB
);

//EX Forward Unit
always @(*) begin
	//EX forward UNIT 1st
	if ((ex_mem_regWrite) && (ex_mem_rd != 0) && (ex_mem_rd == id_ex_reg_rs1)) begin
		assign forwardA = 2'b10;
	end
	if ((ex_mem_regWrite) && (ex_mem_rd != 0) && (ex_mem_rd == id_ex_reg_rs2)) begin
		assign forwardB = 2'b10;
	end
end
	
endmodule