// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            16/03/23
// File:			     risk_v_multicycle_TB.v
// Module name:	  risk_v_multicycle_TB
// Project Name:	  risk_v_multicycle
// Description:	  TB to test risk-v implementation

 `timescale 1ns / 1ps
module risk_v_multicycle_TB();

reg clk, rst;
reg [7:0] gpio_port_in;
wire [7:0] gpio_port_out;

risk_v_multicycle procesador (
	.clk_50Mhz(clk),
	.rst_n(rst),
	.gpio_port_in(gpio_port_in),
	.gpio_port_out(gpio_port_out)
);

initial begin
	clk = 0;
	rst = 1;
	gpio_port_in = 3;
	#1 rst = 0;
	#1 rst = 1;
end

always begin
	#2 clk = ~clk;
end

endmodule