// Coder:           Eduardo Ethandrake Castillo Pulido
// Date:            08/27/2024
// File:			     mips_singlecycle_TB.v
// Module name:	  mips_singlecycle_TB
// Project Name:	  mips_top
// Description:	  TB to test mips implementation

 `timescale 1ns / 1ps
module mips_singlecycle_TB();

reg clk, rst, rx;
wire tx;
reg [7:0] rx_val_array;

mips_top procesador (
	//Inputs - Platform
	.clk_50Mhz(clk),
	.rst_n(rst),
	//Input - RX
	.rx(rx),
	//Output - Tx
	.tx(tx)
);

initial begin
	clk = 0;
	rst = 1;
	rx = 1; //Initial value for Rx
	#1 rst = 0;
	#1 rst = 1;
	procesador.memory_ram.ram[0] = 32'h9;
	procesador.memory_ram.ram[1] = 32'h5;
	procesador.memory_ram.ram[2] = 32'h7;
	procesador.memory_ram.ram[3] = 32'h8;
	procesador.memory_ram.ram[4] = 32'h1;
	procesador.memory_ram.ram[5] = 32'h3;
	procesador.memory_ram.ram[6] = 32'h5;
	procesador.memory_ram.ram[7] = 32'h7;
	procesador.memory_ram.ram[8] = 32'h8;
	procesador.memory_ram.ram[9] = 32'h4;
end

always begin
	#1 clk = ~clk;
end

endmodule