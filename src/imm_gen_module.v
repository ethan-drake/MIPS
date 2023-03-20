// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            16/03/23
// File:			     imm_gen_module.v
// Module name:	  imm_gen_module
// Project Name:	  risc_v_top
// Description:     Immediate generator for risk-v instructions

module imm_gen_module (
	//inputs
	input [31:0] instruction,
	//outputs
	output reg [31:0] imm_out
);

parameter I_TYPE       = 7'b0010011;
parameter S_TYPE       = 7'b0100011;
parameter B_TYPE       = 7'b1100011;
parameter J_TYPE       = 7'b1101111;
parameter LOAD_TYPE    = 7'b0000011;
parameter JALR_TYPE    = 7'b1100111;
parameter LUI_TYPE     = 7'b0110111;
parameter AUIPC_TYPE   = 7'b0010111;

wire [6:0] opcode;
assign opcode = instruction[6:0];

always @(opcode, instruction) begin
	case (opcode)
		I_TYPE:
			begin
				imm_out = {{21{instruction[31]}},instruction[30:20]};
			end
		S_TYPE:
			begin
				imm_out = {{21{instruction[31]}},instruction[30:25],instruction[11:7]};
			end
		B_TYPE:
			begin
				imm_out = {{20{instruction[31]}},instruction[7],instruction[30:25],instruction[11:8],1'b0};
			end
		LOAD_TYPE:
			begin
				imm_out = {{21{instruction[31]}},instruction[30:20]};
			end
		JALR_TYPE:
			begin
				imm_out = {{21{instruction[31]}},instruction[30:20]};
			end
		LUI_TYPE:
			begin
				imm_out = {instruction[31:12],12'h0};
			end
		AUIPC_TYPE:
			begin
				imm_out = {instruction[31:12],12'h0};
			end
		J_TYPE:
			begin
				imm_out = {{12{instruction[31]}},instruction[19:12],instruction[20],instruction[30:21],1'b0};
			end
		default: imm_out = 32'h0;
	endcase
end

endmodule