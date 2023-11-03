// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            16/03/23
// File:			     risk_v_pipeline_TB.v
// Module name:	  risk_v_pipeline_TB
// Project Name:	  risc_v_top
// Description:	  TB to test risk-v implementation

 `timescale 1ns / 1ps
module risc_v_top_TB();

reg clk, rst, rx;
wire tx;
//reg [7:0] rx_val_array;

risc_v_top procesador (
	//Inputs - Platform
	.clk(clk),
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
	
	/// ### Send matrix 4x1 ###
	//Data 0x1
	#100 rx = 1'b0;   //start
	#10420 rx = 1'b1; //bit0
	#10420 rx = 1'b0; //bit1
	#10420 rx = 1'b0; //bit2
	#10420 rx = 1'b0; //bit3
	#10420 rx = 1'b0; //bit4
	#10420 rx = 1'b0; //bit5
	#10420 rx = 1'b0; //bit6
	#10420 rx = 1'b0; //bit7
	#10420 rx = 1'b1; //parity
	#10420 rx = 1'b1; //up again
	#10420;  //Delay to send the other data
	//Data 0x2
	#100 rx = 1'b0;   //start
	#10420 rx = 1'b0; //bit0
	#10420 rx = 1'b1; //bit1
	#10420 rx = 1'b0; //bit2
	#10420 rx = 1'b0; //bit3
	#10420 rx = 1'b0; //bit4
	#10420 rx = 1'b0; //bit5
	#10420 rx = 1'b0; //bit6
	#10420 rx = 1'b0; //bit7
	#10420 rx = 1'b1; //parity
	#10420 rx = 1'b1; //up again
	#10420;  //Delay to send the other data
	//Data 0x3
	#100 rx = 1'b0;   //start
	#10420 rx = 1'b1; //bit0
	#10420 rx = 1'b1; //bit1
	#10420 rx = 1'b0; //bit2
	#10420 rx = 1'b0; //bit3
	#10420 rx = 1'b0; //bit4
	#10420 rx = 1'b0; //bit5
	#10420 rx = 1'b0; //bit6
	#10420 rx = 1'b0; //bit7
	#10420 rx = 1'b0; //parity
	#10420 rx = 1'b1; //up again
	#10420;  //Delay to send the other data
	//Data 0x4
	#100 rx = 1'b0;   //start
	#10420 rx = 1'b0; //bit0
	#10420 rx = 1'b0; //bit1
	#10420 rx = 1'b1; //bit2
	#10420 rx = 1'b0; //bit3
	#10420 rx = 1'b0; //bit4
	#10420 rx = 1'b0; //bit5
	#10420 rx = 1'b0; //bit6
	#10420 rx = 1'b0; //bit7
	#10420 rx = 1'b1; //parity
	#10420 rx = 1'b1; //up again
	#10420;  //Delay to send the other data
	//Data 0x5
	#100 rx = 1'b0;   //start
	#10420 rx = 1'b1; //bit0
	#10420 rx = 1'b0; //bit1
	#10420 rx = 1'b1; //bit2
	#10420 rx = 1'b0; //bit3
	#10420 rx = 1'b0; //bit4
	#10420 rx = 1'b0; //bit5
	#10420 rx = 1'b0; //bit6
	#10420 rx = 1'b0; //bit7
	#10420 rx = 1'b0; //parity
	#10420 rx = 1'b1; //up again
	#10420;  //Delay to send the other data
	//Data 0x6
	#100 rx = 1'b0;   //start
	#10420 rx = 1'b0; //bit0
	#10420 rx = 1'b1; //bit1
	#10420 rx = 1'b1; //bit2
	#10420 rx = 1'b0; //bit3
	#10420 rx = 1'b0; //bit4
	#10420 rx = 1'b0; //bit5
	#10420 rx = 1'b0; //bit6
	#10420 rx = 1'b0; //bit7
	#10420 rx = 1'b0; //parity
	#10420 rx = 1'b1; //up again
	#10420;  //Delay to send the other data
	//Data 0x7
	#100 rx = 1'b0;   //start
	#10420 rx = 1'b1; //bit0
	#10420 rx = 1'b1; //bit1
	#10420 rx = 1'b1; //bit2
	#10420 rx = 1'b0; //bit3
	#10420 rx = 1'b0; //bit4
	#10420 rx = 1'b0; //bit5
	#10420 rx = 1'b0; //bit6
	#10420 rx = 1'b0; //bit7
	#10420 rx = 1'b1; //parity
	#10420 rx = 1'b1; //up again
	#10420;  //Delay to send the other data
	//Data 0x8
	#100 rx = 1'b0;   //start
	#10420 rx = 1'b0; //bit0
	#10420 rx = 1'b0; //bit1
	#10420 rx = 1'b0; //bit2
	#10420 rx = 1'b1; //bit3
	#10420 rx = 1'b0; //bit4
	#10420 rx = 1'b0; //bit5
	#10420 rx = 1'b0; //bit6
	#10420 rx = 1'b0; //bit7
	#10420 rx = 1'b1; //parity
	#10420 rx = 1'b1; //up again
	#10420;  //Delay to send the other data
	//Data 0x9
	#100 rx = 1'b0;   //start
	#10420 rx = 1'b1; //bit0
	#10420 rx = 1'b0; //bit1
	#10420 rx = 1'b0; //bit2
	#10420 rx = 1'b1; //bit3
	#10420 rx = 1'b0; //bit4
	#10420 rx = 1'b0; //bit5
	#10420 rx = 1'b0; //bit6
	#10420 rx = 1'b0; //bit7
	#10420 rx = 1'b0; //parity
	#10420 rx = 1'b1; //up again
	#10420;  //Delay to send the other data
	//Data 0xa
	#100 rx = 1'b0;   //start
	#10420 rx = 1'b0; //bit0
	#10420 rx = 1'b1; //bit1
	#10420 rx = 1'b0; //bit2
	#10420 rx = 1'b1; //bit3
	#10420 rx = 1'b0; //bit4
	#10420 rx = 1'b0; //bit5
	#10420 rx = 1'b0; //bit6
	#10420 rx = 1'b0; //bit7
	#10420 rx = 1'b0; //parity
	#10420 rx = 1'b1; //up again
	#10420;  //Delay to send the other data
	//Data 0xb
	#100 rx = 1'b0;   //start
	#10420 rx = 1'b1; //bit0
	#10420 rx = 1'b1; //bit1
	#10420 rx = 1'b0; //bit2
	#10420 rx = 1'b1; //bit3
	#10420 rx = 1'b0; //bit4
	#10420 rx = 1'b0; //bit5
	#10420 rx = 1'b0; //bit6
	#10420 rx = 1'b0; //bit7
	#10420 rx = 1'b1; //parity
	#10420 rx = 1'b1; //up again
	#10420;  //Delay to send the other data
	//Data 0xc
	#100 rx = 1'b0;   //start
	#10420 rx = 1'b0; //bit0
	#10420 rx = 1'b0; //bit1
	#10420 rx = 1'b1; //bit2
	#10420 rx = 1'b1; //bit3
	#10420 rx = 1'b0; //bit4
	#10420 rx = 1'b0; //bit5
	#10420 rx = 1'b0; //bit6
	#10420 rx = 1'b0; //bit7
	#10420 rx = 1'b0; //parity
	#10420 rx = 1'b1; //up again
	#10420;  //Delay to send the other data
	//Data 0xd
	#100 rx = 1'b0;   //start
	#10420 rx = 1'b1; //bit0
	#10420 rx = 1'b0; //bit1
	#10420 rx = 1'b1; //bit2
	#10420 rx = 1'b1; //bit3
	#10420 rx = 1'b0; //bit4
	#10420 rx = 1'b0; //bit5
	#10420 rx = 1'b0; //bit6
	#10420 rx = 1'b0; //bit7
	#10420 rx = 1'b1; //parity
	#10420 rx = 1'b1; //up again
	#10420;  //Delay to send the other data
	//Data 0xe
	#100 rx = 1'b0;   //start
	#10420 rx = 1'b0; //bit0
	#10420 rx = 1'b1; //bit1
	#10420 rx = 1'b1; //bit2
	#10420 rx = 1'b1; //bit3
	#10420 rx = 1'b0; //bit4
	#10420 rx = 1'b0; //bit5
	#10420 rx = 1'b0; //bit6
	#10420 rx = 1'b0; //bit7
	#10420 rx = 1'b1; //parity
	#10420 rx = 1'b1; //up again
	#10420;  //Delay to send the other data
	//Data 0xf
	#100 rx = 1'b0;   //start
	#10420 rx = 1'b1; //bit0
	#10420 rx = 1'b1; //bit1
	#10420 rx = 1'b1; //bit2
	#10420 rx = 1'b1; //bit3
	#10420 rx = 1'b0; //bit4
	#10420 rx = 1'b0; //bit5
	#10420 rx = 1'b0; //bit6
	#10420 rx = 1'b0; //bit7
	#10420 rx = 1'b0; //parity
	#10420 rx = 1'b1; //up again
	#10420;  //Delay to send the other data
	//Data 0x10
	#100 rx = 1'b0;   //start
	#10420 rx = 1'b0; //bit0
	#10420 rx = 1'b0; //bit1
	#10420 rx = 1'b0; //bit2
	#10420 rx = 1'b0; //bit3
	#10420 rx = 1'b1; //bit4
	#10420 rx = 1'b0; //bit5
	#10420 rx = 1'b0; //bit6
	#10420 rx = 1'b0; //bit7
	#10420 rx = 1'b1; //parity
	#10420 rx = 1'b1; //up again
	#10420;  //Delay to send the other data
	
	/// ### Send vector 1x4 ###
	//Data 0x1
	#100 rx = 1'b0;   //start
	#10420 rx = 1'b1; //bit0
	#10420 rx = 1'b0; //bit1
	#10420 rx = 1'b0; //bit2
	#10420 rx = 1'b0; //bit3
	#10420 rx = 1'b0; //bit4
	#10420 rx = 1'b0; //bit5
	#10420 rx = 1'b0; //bit6
	#10420 rx = 1'b0; //bit7
	#10420 rx = 1'b1; //parity
	#10420 rx = 1'b1; //up again
	#10420;  //Delay to send the other data
	//Data 0x2
	#100 rx = 1'b0;   //start
	#10420 rx = 1'b0; //bit0
	#10420 rx = 1'b1; //bit1
	#10420 rx = 1'b0; //bit2
	#10420 rx = 1'b0; //bit3
	#10420 rx = 1'b0; //bit4
	#10420 rx = 1'b0; //bit5
	#10420 rx = 1'b0; //bit6
	#10420 rx = 1'b0; //bit7
	#10420 rx = 1'b1; //parity
	#10420 rx = 1'b1; //up again
	#10420;  //Delay to send the other data
	//Data 0x3
	#100 rx = 1'b0;   //start
	#10420 rx = 1'b1; //bit0
	#10420 rx = 1'b1; //bit1
	#10420 rx = 1'b0; //bit2
	#10420 rx = 1'b0; //bit3
	#10420 rx = 1'b0; //bit4
	#10420 rx = 1'b0; //bit5
	#10420 rx = 1'b0; //bit6
	#10420 rx = 1'b0; //bit7
	#10420 rx = 1'b0; //parity
	#10420 rx = 1'b1; //up again
	#10420;  //Delay to send the other data
	//Data 0x4
	#100 rx = 1'b0;   //start
	#10420 rx = 1'b0; //bit0
	#10420 rx = 1'b0; //bit1
	#10420 rx = 1'b1; //bit2
	#10420 rx = 1'b0; //bit3
	#10420 rx = 1'b0; //bit4
	#10420 rx = 1'b0; //bit5
	#10420 rx = 1'b0; //bit6
	#10420 rx = 1'b0; //bit7
	#10420 rx = 1'b1; //parity
	#10420 rx = 1'b1; //up again
	#10420;  //Delay to send the other data
end

always begin
	#1 clk = ~clk;
end

endmodule
