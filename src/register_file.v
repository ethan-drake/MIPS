// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            16/03/23
// File:			     register_file.v
// Module name:	  register_file
// Project Name:	  risc_v_top
// Description:	  Register file that contains registers data

module register_file (
	//inputs
	input clk, we3,
	input [4:0] a1, a2, a3,
	input [31:0] wd3,
	input rst_n,
	//signal tap debug
	output [31:0] reg_t2, reg_t3, reg_t6,
	//signal tap debug
	//outputs
	output [31:0] rd1, rd2
);

//Declare our memory
reg [31:0] registers [0:31];

generate
	genvar i;
	for(i=0;i<32;i=i+1) begin : test
		if(i==2) begin
			always@(posedge clk, negedge rst_n) begin
				if(!rst_n)
					registers[i] <= 32'h7fffefe4;
				else if(we3 && a3!=5'h0 && a3==i)
					registers[i] <= wd3;
				else
					registers[i] <= registers[i];
			end
		end
		else begin
			always@(posedge clk, negedge rst_n) begin
				if(!rst_n)
					registers[i] <= 32'h0;
				else if(we3 && a3!=5'h0 && a3==i)
					registers[i] <= wd3;
				else
					registers[i] <= registers[i];
			end
		end
	end
endgenerate

//Initialize registers
initial begin
	registers[0] <= 32'h0;
	registers[1] <= 32'h0;
	registers[2] <= 32'h7fffefe4;
	registers[3] <= 32'h0;
	registers[4] <= 32'h0;
	registers[5] <= 32'h0;
	registers[6] <= 32'h0;
	registers[7] <= 32'h0;
	registers[8] <= 32'h0;
	registers[9] <= 32'h0;
	registers[10] <= 32'h0;
	registers[11] <= 32'h0;
	registers[12] <= 32'h0;
	registers[13] <= 32'h0;
	registers[14] <= 32'h0;
	registers[15] <= 32'h0;
	registers[16] <= 32'h0;
	registers[17] <= 32'h0;
	registers[18] <= 32'h0;
	registers[19] <= 32'h0;
	registers[20] <= 32'h0;
	registers[21] <= 32'h0;
	registers[22] <= 32'h0;
	registers[23] <= 32'h0;
	registers[24] <= 32'h0;
	registers[25] <= 32'h0;
	registers[26] <= 32'h0;
	registers[27] <= 32'h0;
	registers[28] <= 32'h0;
	registers[29] <= 32'h0;
	registers[30] <= 32'h0;
	registers[31] <= 32'h0;
end

//Asyncronus read to registers
assign rd1 = registers[a1];
assign rd2 = registers[a2];

//Signal tap debug
assign reg_t2 = registers[7];
assign reg_t3 = registers[28];
assign reg_t6 = registers[31];
//Signal tap debug

endmodule