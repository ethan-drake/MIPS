// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            16/03/23
// File:			     register_file.v
// Module name:	  register_file
// Project Name:	  risc_v_top
// Description:	  Register file that contains registers data

module register_file (
	//inputs
	input clk, we3,
	input [4:0] a1, a2, a3,
	input [31:0] wd3,
	//Just used for signal tap
	output [31:0] register_s1, register_t3, register_t6, register_t5,
	//Finish 
	//outputs
	output [31:0] rd1, rd2
);

//Declare our memory
reg [31:0] registers [0:31];

//Syncronus write to registers
always @(posedge clk) begin
	if(we3 && a3!=5'h0) begin
		registers[a3] <= wd3;
	end
end

//Initialize registers
initial begin
	registers[0] <= 32'h0;
	registers[1] <= 32'h0;
	registers[2] <= 32'h7fffefe4;
	registers[3] <= 32'h0;
	registers[4] <= 32'h0;
	registers[5] <= 32'h0;
	registers[6] <= 32'h0;
	registers[7] <= 32'h0;
	registers[8] <= 32'h0;
	registers[9] <= 32'h0;
	registers[10] <= 32'h0;
	registers[11] <= 32'h0;
	registers[12] <= 32'h0;
	registers[13] <= 32'h0;
	registers[14] <= 32'h0;
	registers[15] <= 32'h0;
	registers[16] <= 32'h0;
	registers[17] <= 32'h0;
	registers[18] <= 32'h0;
	registers[19] <= 32'h0;
	registers[20] <= 32'h0;
	registers[21] <= 32'h0;
	registers[22] <= 32'h0;
	registers[23] <= 32'h0;
	registers[24] <= 32'h0;
	registers[25] <= 32'h0;
	registers[26] <= 32'h0;
	registers[27] <= 32'h0;
	registers[28] <= 32'h0;
	registers[29] <= 32'h0;
	registers[30] <= 32'h0;
	registers[31] <= 32'h0;
end

//Asyncronus read to registers
assign rd1 = registers[a1];
assign rd2 = registers[a2];

//Just used for signal tap
assign register_s1 = registers[9];
assign register_t3 = registers[28];
assign register_t5 = registers[30];
assign register_t6 = registers[31];
//finish

endmodule