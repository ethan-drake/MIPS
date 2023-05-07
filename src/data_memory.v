// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            16/03/23
// File:			     instr_data_memory.v
// Module name:	  instr_data_memory
// Project Name:	  risc_v_top
// Description:	  Memory that contains instructions to perform

module data_memory #(parameter DATA_WIDTH = 32, parameter ADDR_WIDTH = 32) (
	//inputs
	input [(DATA_WIDTH-1):0] wd, address,
	input we, re, clk,
	//For signal tap debug
	output [31:0] reg1,
	output [31:0] reg2,
	output [31:0] reg3,
	output [31:0] reg4,
	output [31:0] reg5,
	output [31:0] reg6,
	output [31:0] reg7,
	output [31:0] reg8,
	output [31:0] reg9,
	output [31:0] reg10,
	output [31:0] reg11,
	output [31:0] reg12,
	output [31:0] reg13,
	output [31:0] reg14,
	output [31:0] reg15,
	output [31:0] reg16,
	output [31:0] reg17,
	output [31:0] reg18,
	output [31:0] reg19,
	output [31:0] reg20,
	//
	//outputs
	output [(DATA_WIDTH-1):0] rd
);

// Declare the RAM array
reg [DATA_WIDTH-1:0] ram[0:(ADDR_WIDTH*ADDR_WIDTH)-1];

integer i;
initial begin
	for(i=0;i<((ADDR_WIDTH*ADDR_WIDTH));i=i+1)
		ram[i] <= 32'h0;
end

/*
//Initial data with program to execute
initial begin
	// program
	$readmemh("../asm/vector_matrix_data.txt", ram);
end
*/

always @(posedge clk)
begin
	//Write
	if (we)
		ram[address] <= wd;
end
	
// Reading if memory read enable
assign rd = ram[address];

//For signal tap debug
assign reg1 = ram[20];
assign reg2 = ram[21];
assign reg3 = ram[22];
assign reg4 = ram[23];
assign reg5 = ram[24];
assign reg6 = ram[25];
assign reg7 = ram[26];
assign reg8 = ram[27];
assign reg9 = ram[28];
assign reg10 = ram[29];
assign reg11 = ram[30];
assign reg12 = ram[31];
assign reg13 = ram[32];
assign reg14 = ram[33];
assign reg15 = ram[34];
assign reg16 = ram[35];
assign reg17 = ram[36];
assign reg18 = ram[37];
assign reg19 = ram[38];
assign reg20 = ram[39];
//For signal tap debug

endmodule