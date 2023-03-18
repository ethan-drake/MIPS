// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            16/03/23
// File:			     control_unit.v
// Module name:	  control_unit
// Project Name:	  risk_v_multicycle
// Description:	  FSM that controls MIPS

module control_unit(
    //Inputs FSM
    input [6:0] opcode,
	 input [2:0] funct3,
    input clk,
    input rst,
    //Output FSM
	 output reg [1:0] MemtoReg,
	 output reg RegWrite,
	 output reg IorD, 
	 output reg MemWrite,
	 output reg IRWrite,
	 output reg MemRead,
	 output reg PCWrite,
	 output reg Branch,
	 output reg Branch_NE,
	 output reg PCSrc,
	 output reg [2:0] ALUOp,
	 output reg ALUSrcA,
	 output reg [1:0] ALUSrcB 
);

//States
parameter FETCH		      = 4'h0;
parameter DECODE		      = 4'h1;
parameter MEMADR	         = 4'h2;
parameter MEMREAD		      = 4'h3;
parameter MEMREAD_COMP     = 4'h4;
parameter EXECUTE_R        = 4'h5;
parameter COMPLETION       = 4'h6;
parameter BRANCH   		   = 4'h7;
parameter EXECUTE_J        = 4'h8;
parameter EXECUTE_I        = 4'h9;
parameter COMPLETION_JALR  = 4'ha;
parameter EXECUTE_LUI      = 4'hb;
parameter EXECUTE_AUIPC    = 4'hc;
parameter MEMWRITE         = 4'hd;
parameter BRANCH_NE        = 4'he;

//Opcodes
parameter R_TYPE       = 7'b0110011;
parameter I_TYPE       = 7'b0010011;
parameter LOAD_TYPE    = 7'b0000011;
parameter STORE_TYPE   = 7'b0100011;
parameter B_TYPE       = 7'b1100011;
parameter J_TYPE       = 7'b1101111;
parameter JALR_TYPE    = 7'b1100111;
parameter LUI_TYPE     = 7'b0110111;
parameter AUIPC_TYPE   = 7'b0010111;

//FSM state
reg[3:0] FSM_state;

//For FSM changes
always @(negedge rst, posedge clk) begin
	if(!rst) begin
		FSM_state <= FETCH;
	end else begin
		case (FSM_state)
				 FETCH:
					begin
						FSM_state <= DECODE;
					end
				 DECODE:
					begin
						case (opcode)
							LOAD_TYPE:  FSM_state <= MEMADR;
							STORE_TYPE: FSM_state <= MEMADR;
							R_TYPE:     FSM_state <= EXECUTE_R;
							B_TYPE:     
								case(funct3)
									3'h0: FSM_state <= BRANCH;
									3'h1: FSM_state <= BRANCH_NE;
									default: FSM_state <= BRANCH_NE;
								endcase
							I_TYPE:     FSM_state <= EXECUTE_I;
							J_TYPE:     FSM_state <= EXECUTE_J;
							JALR_TYPE:  FSM_state <= EXECUTE_I;
							LUI_TYPE:   FSM_state <= EXECUTE_LUI;
							AUIPC_TYPE: FSM_state <= EXECUTE_AUIPC;
							default:    FSM_state <= FETCH; //Not a valid opcode
						endcase
					end
				MEMADR:
					begin
						case (opcode)
							LOAD_TYPE:  FSM_state <= MEMREAD;
							STORE_TYPE: FSM_state <= MEMWRITE;
							default:    FSM_state <= MEMREAD; //Shouldn't happen
						endcase
					end
				MEMREAD:
					begin
						FSM_state <= MEMREAD_COMP;
					end
				MEMWRITE:
					begin
						FSM_state <= FETCH;
					end
				MEMREAD_COMP:
					begin
						FSM_state <= FETCH;
					end
				EXECUTE_R:
					begin
						FSM_state <= COMPLETION;
					end
				COMPLETION:
					begin
						FSM_state <= FETCH;
					end
				BRANCH:
					begin
						FSM_state <= FETCH;
					end
				BRANCH_NE:
					begin
						FSM_state <= FETCH;
					end
				EXECUTE_J:
					begin
						FSM_state <= FETCH;
					end
				EXECUTE_I:
					begin
						case (opcode)
							I_TYPE:    FSM_state <= COMPLETION;
							JALR_TYPE: FSM_state <= COMPLETION_JALR;
							default:   FSM_state <= COMPLETION; //Shouldn't happen
						endcase
					end
				COMPLETION_JALR:
					begin
						FSM_state <= FETCH;
					end
				EXECUTE_LUI:
					begin
						FSM_state <= FETCH;
					end
				EXECUTE_AUIPC:
					begin
						FSM_state <= COMPLETION;
					end
				default: FSM_state <= FETCH;
		endcase
	end
end

//OUTPUT DEFINITION
always @(FSM_state)
	begin
		case(FSM_state)
            FETCH:
					begin
						 MemRead = 1'b1;
						 MemWrite = 1'b0;
						 ALUSrcA = 1'b0;
						 ALUSrcB = 2'b01;
						 ALUOp = 2'b00;
						 IorD = 1'b0;
						 IRWrite = 1'b1;
						 PCWrite = 1'b1;
						 PCSrc = 1'b0;					 
						 MemtoReg = 2'b00; 
						 Branch = 1'b0;
						 Branch_NE = 1'b0; 
						 RegWrite = 1'b0;
					end
            DECODE:
					begin
						 MemRead = 1'b1;
						 MemWrite = 1'b0;
						 ALUSrcA = 1'b0;
						 ALUSrcB = 2'b10;
						 ALUOp = 2'b10; //proposal previous 00
						 IorD = 1'b1;
						 IRWrite = 1'b0;
						 PCWrite = 1'b0;
						 PCSrc = 1'b0;
						 MemtoReg = 2'b00;
						 Branch = 1'b0;
						 Branch_NE = 1'b0; 
						 RegWrite = 1'b0;
					end
            MEMADR:
					begin
						 MemRead = 1'b1;
						 MemWrite = 1'b0;
						 ALUSrcA = 1'b1;
						 ALUSrcB = 2'b10;
						 ALUOp = 2'b00;
						 IorD = 1'b0;
						 IRWrite = 1'b0;
						 PCWrite = 1'b0;
						 PCSrc = 1'b0;
						 MemtoReg = 2'b00;
						 Branch = 1'b0;
						 Branch_NE = 1'b0; 
						 RegWrite = 1'b0;
					end
            MEMREAD:
					begin
						 MemRead = 1'b1;
						 MemWrite = 1'b0;
						 ALUSrcA = 1'b1;
						 ALUSrcB = 2'b10;
						 ALUOp = 2'b00;
						 IorD = 1'b1;
						 IRWrite = 1'b0;
						 PCWrite = 1'b0;
						 PCSrc = 1'b0;
						 MemtoReg = 2'b00;
						 Branch = 1'b0;
						 Branch_NE = 1'b0; 
						 RegWrite = 1'b0; 
					end
            MEMWRITE:
					begin
						 MemRead = 1'b0;
						 MemWrite = 1'b1;
						 ALUSrcA = 1'b1;
						 ALUSrcB = 2'b10;
						 ALUOp = 2'b00;
						 IorD = 1'b1;
						 IRWrite = 1'b0;
						 PCWrite = 1'b0;
						 PCSrc = 1'b0;
						 MemtoReg = 2'b00;
						 Branch = 1'b0;
						 Branch_NE = 1'b0; 
						 RegWrite = 1'b0;
					end
				MEMREAD_COMP:
					begin
						 MemRead = 1'b1;
						 MemWrite = 1'b0;
						 ALUSrcA = 1'b1;
						 ALUSrcB = 2'b10;
						 ALUOp = 2'b00;
						 IorD = 1'b1;
						 IRWrite = 1'b0;
						 PCWrite = 1'b0;
						 PCSrc = 1'b0;
						 MemtoReg = 2'b01;
						 Branch = 1'b0;
						 Branch_NE = 1'b0; 
						 RegWrite = 1'b1; //Porposal previous 1'b0
					end
            EXECUTE_R:
					begin
						 MemRead = 1'b1;
						 MemWrite = 1'b0;
						 ALUSrcA = 1'b1;
						 ALUSrcB = 2'b00;
						 ALUOp = 2'b10;
						 IorD = 1'b0;
						 IRWrite = 1'b0;
						 PCWrite = 1'b0;
						 PCSrc = 1'b0;
						 MemtoReg = 2'b00;
						 Branch = 1'b0;
						 Branch_NE = 1'b0; 
						 RegWrite = 1'b0;
					end
				COMPLETION:
					begin
						 MemRead = 1'b1;
						 MemWrite = 1'b0;
						 ALUSrcA = 1'b1;
						 ALUSrcB = 2'b00;
						 ALUOp = 2'b10;
						 IorD = 1'b0;
						 IRWrite = 1'b0;
						 PCWrite = 1'b0;
						 PCSrc = 1'b0;
						 MemtoReg = 2'b00;
						 Branch = 1'b0;
						 Branch_NE = 1'b0; 
						 RegWrite = 1'b1;
					end
            BRANCH:
					begin
						 MemRead = 1'b1;
						 MemWrite = 1'b0;
						 ALUSrcA = 1'b1;
						 ALUSrcB = 2'b00;
						 ALUOp = 2'b01;
						 IorD = 1'b0;
						 IRWrite = 1'b0;
						 PCWrite = 1'b0;
						 PCSrc = 1'b1;
						 MemtoReg = 2'b00;
						 Branch = 1'b1;
						 Branch_NE = 1'b0; 
						 RegWrite = 1'b0;
					end
				BRANCH_NE:
					begin
						 MemRead = 1'b1;
						 MemWrite = 1'b0;
						 ALUSrcA = 1'b1;
						 ALUSrcB = 2'b00;
						 ALUOp = 2'b01;
						 IorD = 1'b0;
						 IRWrite = 1'b0;
						 PCWrite = 1'b0;
						 PCSrc = 1'b1;
						 MemtoReg = 2'b00;
						 Branch = 1'b0;
						 Branch_NE = 1'b1; 
						 RegWrite = 1'b0;
					end
				EXECUTE_J:
					begin
						 MemRead = 1'b1;
						 MemWrite = 1'b0;
						 ALUSrcA = 1'b0;
						 ALUSrcB = 2'b10;
						 ALUOp = 2'b00;
						 IorD = 1'b0;
						 IRWrite = 1'b0;
						 PCWrite = 1'b1;
						 PCSrc = 1'b1;
						 MemtoReg = 2'b10;
						 Branch = 1'b0;
						 Branch_NE = 1'b0; 
						 RegWrite = 1'b1;
					end
				EXECUTE_I:
					begin
						 MemRead = 1'b1;
						 MemWrite = 1'b0;
						 ALUSrcA = 1'b1;
						 ALUSrcB = 2'b10;
						 ALUOp = 2'b10;
						 IorD = 1'b0;
						 IRWrite = 1'b0;
						 PCWrite = 1'b0;
						 PCSrc = 1'b0;
						 MemtoReg = 2'b00;
						 Branch = 1'b0;
						 Branch_NE = 1'b0; 
						 RegWrite = 1'b0;
					end
				COMPLETION_JALR:
					begin
						 MemRead = 1'b1;
						 MemWrite = 1'b0;
						 ALUSrcA = 1'b1;
						 ALUSrcB = 2'b10;
						 ALUOp = 2'b10;
						 IorD = 1'b0;
						 IRWrite = 1'b0;
						 PCWrite = 1'b1;
						 PCSrc = 1'b1;
						 MemtoReg = 2'b10;
						 Branch = 1'b0;
						 Branch_NE = 1'b0; 
						 RegWrite = 1'b1;
					end
				EXECUTE_LUI:
					begin
						 MemRead = 1'b1;
						 MemWrite = 1'b0;
						 ALUSrcA = 1'b0;
						 ALUSrcB = 2'b10;
						 ALUOp = 2'b00;
						 IorD = 1'b0;
						 IRWrite = 1'b0;
						 PCWrite = 1'b0;
						 PCSrc = 1'b0;
						 MemtoReg = 2'b11;
						 Branch = 1'b0;
						 Branch_NE = 1'b0; 
						 RegWrite = 1'b1;
					end
				EXECUTE_AUIPC:
					begin
						 MemRead = 1'b1;
						 MemWrite = 1'b0;
						 ALUSrcA = 1'b0;
						 ALUSrcB = 2'b10;
						 ALUOp = 2'b10; //proposal previous 00
						 IorD = 1'b0;
						 IRWrite = 1'b0;
						 PCWrite = 1'b0;
						 PCSrc = 1'b0;
						 MemtoReg = 2'b00;
						 Branch = 1'b0;
						 Branch_NE = 1'b0; 
						 RegWrite = 1'b0;
					end
				default:
					begin
						 MemRead = 1'b1;
						 MemWrite = 1'b0;
						 ALUSrcA = 1'b0;
						 ALUSrcB = 2'b01;
						 ALUOp = 2'b00;
						 IorD = 1'b0;
						 IRWrite = 1'b0;
						 PCWrite = 1'b0;
						 PCSrc = 1'b0;					 
						 MemtoReg = 2'b00; 
						 Branch = 1'b0; 
						 Branch_NE = 1'b0; 
						 RegWrite = 1'b0;
					end
		endcase
	end

endmodule