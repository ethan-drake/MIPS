// Coder:           Eduardo Ethandrake Castillo, David Adrian Michel Torres
// Date:            October 21, 2022
// File:			uart_full_duplex.v
// Module name:		uart_full_duplex
// Project Name:	P3_uart_full_duplex
// Description:		This is the top module for the uart full duplex

module uart_full_duplex #(parameter baud_rate=5210) (
	 //UART - Inputs
	 input clk,
    input rst_n,
    input [7:0] tx_data,
    input tx_send,
	 input rx,
	 input rx_flag_clr,
	 //UART - Outputs
    output tx,
	 output rx_flag,
	 output [7:0] Rx_Data
);

// For a baud rate of 9600 baudios: bit time 104.2 us, half time 52.1 us
// For a clock frequency of 50 MHz bit time = 5210 T50MHz;
// For a baud rate of 115200 baudios: bit time 8.68 us, half time 4.34 us
// For a clock frequency of 50 MHz bit time = 434 T50MHz;

//uart rx instantiation
UART_Rx #(.baud_rate(baud_rate)) rx_uart(
	.clk(clk),
	.n_rst(rst_n),
	.rx(rx), 
	.Rx_Data_w(Rx_Data),
	.rx_flag_clr(rx_flag_clr),
	.rx_flag(rx_flag)
);

//uart tx instantiation
uart_tx #(.baud_rate(baud_rate)) tx_uart(
	.clk(clk),
	.rst_n(rst_n),
	.tx_data(tx_data),
	.tx_send(tx_send),
	.transmit_data(tx)
);

endmodule
