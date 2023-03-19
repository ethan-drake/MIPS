// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            16/03/23
// File:			     instr_data_memory.v
// Module name:	  instr_data_memory
// Project Name:	  risk_v_multicycle
// Description:	  Memory that contains instructions to perform

module data_memory #(parameter DATA_WIDTH = 32, parameter ADDR_WIDTH = 32) (
	//inputs
	input [(DATA_WIDTH-1):0] wd, address,
	input we, re, clk,
	//outputs
	output [(DATA_WIDTH-1):0] rd
);

// Declare the RAM array
reg [DATA_WIDTH-1:0] rom[0:(ADDR_WIDTH*ADDR_WIDTH)-1];

//Initial data with program to execute
//initial begin
//	//UART program
//	$readmemb("../assembly_code/Tarea_GPIO.txt", rom);
//end

always @(posedge clk)
begin
	//Write
	if (we)
		rom[address] <= wd;
end
	
// Reading if memory read enable
assign rd = rom[address];

endmodule