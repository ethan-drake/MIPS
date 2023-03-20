// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            16/03/23
// File:			     register_file.v
// Module name:	  register_file
// Project Name:	  risk_v_multicycle
// Description:	  Register file risk-v

module register_file (
	//inputs
	input clk, we3,
	input [4:0] a1, a2, a3,
	input [31:0] wd3,
	//outputs
	output [31:0] rd1, rd2
);

//Declare our memory
reg [31:0] registers [0:31];

//Syncronus write to registers
always @(posedge clk) begin
	if(we3 && a3 != 5'h0) begin
		registers[a3] <= wd3;
	end
end

//Initialize registers
integer i;
initial begin
	registers[0] <= 32'h0;
	registers[1] <= 32'h0;
	registers[2] <= 32'h7fff_efe4;
	for(i=3;i<32;i=i+1)
		registers[i] <= 32'h0;
end

//Asyncronus read to registers
assign rd1 = registers[a1];
assign rd2 = registers[a2];

endmodule