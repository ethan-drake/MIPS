// Coder:           Eduardo Ethandrake Castillo, David Adrian Michel Torres
// Date:            October 19, 2022
// File:			uart_tx.v
// Module name:		uart_tx
// Project Name:	P3_uart_full_duplex
// Description:		This the uart tx top module, as part of the full duplex uart project
module uart_tx #(parameter baud_rate=5210) (
    //inputs
    input clk,
    input rst_n,
    input[7:0] tx_data,
    input tx_send,
    //outputs
    output transmit_data
	);

wire baud_rate_overflow;
wire bit_counter_overflow;
wire tx_mux;
wire tx_control;
wire tx_reg_enable;
wire bit_counter_enable;
wire [7:0] tx_data_reg;
wire parity_bit;
wire shift_register_enable;
wire tx_data_shifted;
wire load_serializer;
wire pre_overflow;
wire clear_bit_counter;
wire reset_delayer;
wire fin_delay_w;

//uart tx state machine
uart_tx_fsm tx_fsm(
    .i_clk(clk),
    .i_rst_n(rst_n),
    .i_baud_rate_overflow(baud_rate_overflow),
    .i_tx_send(tx_send),
    .i_bit_counter_overflow(bit_counter_overflow),
    .o_tx_mux(tx_mux),
    .o_tx_control(tx_control),
    .o_tx_reg_enable(tx_reg_enable),
    .o_bit_counter_enable(bit_counter_enable),
    .o_load_serializer(load_serializer),
    .o_clear_bit_counter(clear_bit_counter),
	 .reset_delayer(reset_delayer),
	 .fin_delay_w(fin_delay_w)
);

//Delayer for UART 5ms because of 50Mhz clock 250_000
Delayer # (.YY(250_000)) delay_5ms (
	.clk(clk), 
	.rst(reset_delayer), 
	.enable(1'b1), 
	.iguales(fin_delay_w)
);

//bits sent counter
Counter_02Limit_ovf #(.N($clog2(10)), .Limit(10)) bit_counter(
    .rst_n(rst_n),
    .enable(shift_register_enable),
    .clk(clk),
    .Q(),
    .overflow(bit_counter_overflow),
    .pre_overflow(pre_overflow),
    .clear(clear_bit_counter)
);

// For a baud rate of 9600 baudios: bit time 104.2 us, half time 52.1 us
// For a clock frequency of 50 MHz bit time = 5210 T50MHz;
// For a baud rate of 115200 baudios: bit time 8.68 us, half time 4.34 us
// For a clock frequency of 50 MHz bit time = 434 T50MHz;

Bit_Rate_Pulse #(.delay_counts(baud_rate)) baudrate_counter(
    .clk(clk),
    .rst_n(rst_n),
    .enable(~tx_control),
    .end_bit_time(baud_rate_overflow),
    .end_half_time()
);

//8 bit data
ffd_param #(.LENGTH(8))tx_reg(
	.i_clk(clk),
	.i_rst_n(rst_n),
	.i_en(tx_reg_enable),
	.d(tx_data),
	.q(tx_data_reg)
);

assign parity_bit = ^tx_data;
assign shift_register_enable = baud_rate_overflow & bit_counter_enable;

//parallel to serial converter
parallel2serial #(.N(10))shift_right_reg(
    .i_clk(clk),
    .i_rst_n(rst_n),
    .i_enable(shift_register_enable & (~pre_overflow)),
    .i_load_serializer(load_serializer),
    .i_data({parity_bit,tx_data_reg,1'b0}), 
    .o_tx_data(tx_data_shifted)
);

multiplexor_param #(.LENGTH(1)) tx_data_mux(
    .i_a(1'b1),
    .i_b(tx_data_shifted),
    .i_selector(tx_mux),
    .out(transmit_data)
);

endmodule