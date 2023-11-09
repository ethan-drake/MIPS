`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer: Cuauhtemoc Aguilera
//////////////////////////////////////////////////////////////////////////////////
module risc_v_Pad_Frame(
    inout VDD1,
    inout VSS1,
    inout VDDIOR1,
    inout VSSIOR1,
    input clk,
    input reset_n,
    input rx,
    output tx
    );

wire clk_w, reset_n_w, rx_w, tx_w;


risc_v_top risc_v_top_i (
	//Inputs - Platform
	.clk(clk_w),
	.rst_n(reset_n_w),
	//Input - RX
	.rx(rx_w),
	//Output - Tx
	.tx(tx_w)
);

// Input PADs
PADDI pad_clk  (.PAD(clk),  .Y(clk_w));

PADDI pad_nrst (.PAD(reset_n), .Y(reset_n_w));

PADDI pad_rx (.PAD(rx), .Y(rx_w));

// Output PADs
PADDO pad_tx (.A(tx_w), .PAD(tx));

// CORE POWER PADS

//PADVDD: Bond Pad for Digital Power
PADVDD pad_vdd_i1 ( .VDD(VDD1) );


//PADVSS: Bond Pad for Digital Ground 
PADVSS pad_vss_i1 ( .VSS(VSS1) );

// I/O Frame POWER PADS
// PADVDDIOR: Bond Pad for IO Ring Power 
PADVDDIOR pad_vdd_ior ( .VDDIOR(VDDIOR1) );

// PADVSSIOR: A Bond Pad for IO Ring ground.
PADVSSIOR pad_vss_ior ( .VSSIOR(VSSIOR1) );

// CORNER PAD: This cell provides I/O-cell and power-distribution continuity around a chip corner.
padIORINGCORNER NE(); 
padIORINGCORNER NW();
padIORINGCORNER SE();
padIORINGCORNER SW();

endmodule
