// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            16/03/23
// File:			     master_memory_map.v
// Module name:	  master_memory_map
// Project Name:	  risk_v_multicycle
// Description:	  Master that constrolls the memory mapping

module master_memory_map #(parameter DATA_WIDTH = 32, parameter ADDR_WIDTH = 32) (
	//inputs from core
	input [(DATA_WIDTH-1):0] wd, address,
	input we, re, clk,
	//outputs to core
	output [(DATA_WIDTH-1):0] rd,
	//--------------------------------
	//Inputs from slaves
	input [(DATA_WIDTH-1):0] HRData1, HRData2,
	//Outputs to slaves data & address
	output reg [(DATA_WIDTH-1):0] map_Data, map_Address,
	//Outputs to slaves write control
	output reg WSel_1, WSel_2,
	//Outputs to slaves read control
	output reg HSel_1, HSel_2
); 

//To select address
reg [1:0] mult_map, add_val;
//To evaluate address mapping conditions
always @(address) begin
	//ROM
	if (address >= 32'h400_000 && address < 32'h10_010_020) begin
		add_val = 2'b01;
	//UART
	end else if (address >= 32'h10_010_020 && address < 32'h10_010_040) begin
		add_val = 2'b10;
	end else begin
		add_val = 2'b00;
	end
end

//Decoder mapping
always @(add_val, we, wd, address) begin
	case(add_val)
		2'b01:
			begin  //ROM
				mult_map = 2'b01;
				HSel_1 = 1'b1;
				HSel_2 = 1'b0;
				WSel_1 = we;
				WSel_2 = 1'b0;
				map_Address = (address + (~32'h400_000 + 1'b1)) >> 2'h2; //400_000
				map_Data = wd;
			end
		2'b10:
			begin //UART
				mult_map = 2'b10;
				HSel_1 = 1'b0;
				HSel_2 = 1'b1;
				WSel_1 = 1'b0;
				WSel_2 = we;
				map_Address = address + (~32'h10_010_020 + 1'b1) >> 2'h2; //to UART
				map_Data = wd;
			end
		default: //Reserved
			begin
				mult_map = 2'b00;
				HSel_1 = 1'b0;
				HSel_2 = 1'b0;
				WSel_1 = 1'b0;
				WSel_2 = 1'b0;
				map_Address = address;
				map_Data = wd;
			end
	endcase
end

double_multiplexor_param #(.LENGTH(DATA_WIDTH)) memory_map_mult (
	.i_a(32'h0),
	.i_b(HRData1),
	.i_c(HRData2),
	.i_d(32'h0),
	.i_selector(mult_map),
	.out(rd)
);

endmodule
