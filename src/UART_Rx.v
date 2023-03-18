// ITESO
// Cuauhtemoc Aguilera
// This the uart rx top module, as part of the full duplex uart project
module UART_Rx #(parameter baud_rate=5210) (
	input clk,
	input n_rst,
	input rx,
	input rx_flag_clr,
	output parity_error,
	output [7:0] Rx_Data_w,
	output rx_flag,
	output parity
);

wire rst_bit_counter_w, rst_BR_w, n_rst_BR_w;
wire sample_bit_w, parity_received, parity_calc;
wire end_bit_time_w, end_half_time_w;
wire bit_count_enable_w, enable_out_reg_w;
wire [3:0] count_bits_w;
wire [8:0] Q_SR_w /* synthesis keep */;

//Negedge rst module
assign n_rst_BR_w = ~rst_BR_w;
//Even parity calculate
assign parity_calc = ^Rx_Data_w[7:0];
//Parity error checker, both need to match
assign parity_error = parity_received ^ parity_calc;
assign parity = parity_received;

Shift_Register_R_Param #(.width(9) ) shift_reg (
	.clk(clk), 
	.rst(n_rst), 
	.enable(sample_bit_w),
   .d(rx), 
	.Q(Q_SR_w) 
);

// Output Reg
ffd_param #(.LENGTH(8) ) rx_Data_Reg_i (
	.i_rst_n(n_rst), 
	.d(Q_SR_w[7:0]),
	.i_clk(clk),
	.i_en(enable_out_reg_w), 
	.q(Rx_Data_w)
);

//Save parity received
ffd_param #(.LENGTH(1) ) ff_par (
	.i_rst_n(n_rst), 
	.d(Q_SR_w[8]),
	.i_clk(clk),
	.i_en(enable_out_reg_w), 
	.q(parity_received)
);	

//RX-flag 
ffd_param #(.LENGTH(1) ) ff_rx_flag (
	.i_rst_n(rx_flag_clr), 
	.d(1'b1),
	.i_clk(clk),
	.i_en(enable_out_reg_w), 
	.q(rx_flag)
);		

// For a baud rate of 9600 baudios: bit time 104.2 us, half time 52.1 us
// For a clock frequency of 50 MHz bit time = 5210 T50MHz;
Bit_Rate_Pulse # (.delay_counts(baud_rate) ) BR_pulse (
	.clk(clk), 
	.rst_n(n_rst_BR_w), 
	.enable(1'b1), 
	.end_bit_time(end_bit_time_w), 
	.end_half_time (end_half_time_w)
);
			   
FSM_UART_Rx FSM_Rx (
	.rx(rx), 
	.clk(clk), 
	.rst(n_rst), 
	.end_half_time_i(end_half_time_w),
	.end_bit_time_i(end_bit_time_w), 
	.Rx_bit_Count(count_bits_w), 
	.sample_o(sample_bit_w), 
	.bit_count_enable(bit_count_enable_w),
	.rst_BR(rst_BR_w),
	.rst_bit_counter(rst_bit_counter_w), 
	.enable_out_reg(enable_out_reg_w)
);			   
		
Counter_Param # (.n(4) ) Counter_bits (
	.clk(clk), 
	.rst(rst_bit_counter_w), 
	.enable(bit_count_enable_w), 
	.Q(count_bits_w)
);
												
endmodule		