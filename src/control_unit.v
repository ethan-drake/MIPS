// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            16/03/23
// File:			     control_unit.v
// Module name:	  control_unit
// Project Name:	  risc_v_top
// Description:	  RISC_V control unit

module control_unit(
    //Inputs FSM
    input[6:0] opcode,
    input clk,
    input rst_n,
    //Output FSM
    //Multiplexer Selects
    output reg [1:0] MemtoReg,
    output reg IorD, 
    output reg PCSrc,
    output reg [1:0] ALUSrcB,
    output reg [1:0] ALUSrcA,
    //Register Enables
    output reg IRWrite,
    output reg MemWrite,
    output reg MemRead,
    output reg PCWrite,
    output reg PCWriteCond,
    output reg BNE,
    output reg RegWrite,
    //Inputs ALU Decoder
    input[2:0] func3,
    //Outputs ALU Decoder
    output reg [2:0] ALUOp
);

//states
parameter FETCH		    = 4'h0;
parameter DECODE		    = 4'h1;
parameter MEMADR	        = 4'h2;
parameter MEMREAD		    = 4'h3;
parameter MEM_COMPLETION    = 4'h4;
parameter MEM_WRITE		    = 4'h5;
parameter EXECUTE_REG	     = 4'h6;
parameter R_I_AUIPC_COMPLETION    = 4'h7;
parameter BRANCH	        = 4'h8;
parameter EXECUTE_IMM	     = 4'h9;
parameter JALR_COMPLETION	     = 4'hA;
parameter BRANCH_NOT_EQUAL  = 4'hB;
parameter EXECUTE_JAL	     = 4'hC;
parameter EXECUTE_LUI	     = 4'hD;
parameter EXECUTE_AUIPC	     = 4'hE;

//opcodes
parameter R_TYPE = 7'b0110011;
parameter I_TYPE = 7'b0010011;
parameter S_TYPE = 7'b0100011;
parameter B_TYPE = 7'b1100011;
parameter LUI_INS = 7'b0110111;
parameter AUIPC_INS = 7'b0010111;
parameter JAL_INS = 7'b1101111;
parameter JALR_INS = 7'b1100111;
parameter LOAD_INS = 7'b0000011;

//ALU Control
//ADDITION 010, ALUOP 00

reg[3:0] FSM_state;

//For FSM changes
always @(negedge rst_n, posedge clk) begin
	if(!rst_n) begin
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
							S_TYPE,
                            LOAD_INS:
								 FSM_state <= MEMADR;
							R_TYPE:
								 FSM_state <= EXECUTE_REG;
							B_TYPE:
                                case(func3)
                                    3'h0:
                                    FSM_state <= BRANCH;
                                    3'h1:
                                    FSM_state <= BRANCH_NOT_EQUAL;
                                    default: FSM_state <= FETCH;
                                endcase
							I_TYPE:
								FSM_state <= EXECUTE_IMM;
                            JAL_INS:
                                FSM_state <= EXECUTE_JAL;
                            JALR_INS:
                                FSM_state <= EXECUTE_IMM;
                            LUI_INS:
                                FSM_state <= EXECUTE_LUI;
                            AUIPC_INS:
                                FSM_state <= EXECUTE_AUIPC;
							default:
                                FSM_state <= FETCH;
					  endcase
				  end
				 MEMADR:
				    begin
				        if(opcode == LOAD_INS)
							FSM_state <= MEMREAD;
					    else if(opcode == S_TYPE)
							FSM_state <= MEM_WRITE;
                        else
                            FSM_state <= FETCH;
				    end
				 MEMREAD:
					  FSM_state <= MEM_COMPLETION;
				 MEM_COMPLETION:
					  FSM_state <= FETCH;
				 MEM_WRITE:
					  FSM_state <= FETCH;
				 EXECUTE_REG:
					  FSM_state <= R_I_AUIPC_COMPLETION;
                EXECUTE_IMM:
                    begin
                        if(opcode == I_TYPE)
                            FSM_state <= R_I_AUIPC_COMPLETION;
                        else if(opcode == JALR_INS)
                            FSM_state <= JALR_COMPLETION;
                        else
                            FSM_state <= FETCH;
                    end
				 BRANCH:
					  FSM_state <= FETCH;
                 BRANCH_NOT_EQUAL:
                    FSM_state <= FETCH;
                EXECUTE_JAL:
                    FSM_state <= FETCH;
                JALR_COMPLETION:
                    FSM_state <= FETCH;
                EXECUTE_AUIPC:
                    FSM_state <= R_I_AUIPC_COMPLETION;
                R_I_AUIPC_COMPLETION:
                    FSM_state <= FETCH;
				 default:
					  FSM_state <= FETCH;
		endcase
	end
end

//OUTPUT DEFINITION
always @(FSM_state)
	begin
		ALUOp = 2'b00;
		case(FSM_state)
            FETCH:
            begin
                MemtoReg = 2'b00; //no care
                IorD = 1'b0;
                PCSrc = 1'b0;
                ALUSrcB = 2'b01;
                ALUSrcA = 2'b00;
                IRWrite = 1'b1;
                MemWrite = 1'b0; //no care
                MemRead = 1'b1;
                PCWrite = 1'b1;
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b0; //no care
                ALUOp = 2'b00;
            end
            DECODE:
            begin
                MemtoReg = 2'b00; //no care
                IorD = 1'b0; //no care
                PCSrc = 1'b0; //no care
                ALUSrcB = 2'b10;
                ALUSrcA = 2'b10;
                IRWrite = 1'b0; //no care
                MemWrite = 1'b0; //no care
                MemRead = 1'b0; //no care
                PCWrite = 1'b0; //no care
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b0; //no care
                ALUOp = 2'b00;
            end
            MEMADR:
            begin
                MemtoReg = 2'b00; //no care
                IorD = 1'b0; //no care
                PCSrc = 1'b0; //no care
                ALUSrcB = 2'b10;
                ALUSrcA = 2'b01;
                IRWrite = 1'b0; //no care
                MemWrite = 1'b0; //no care
                MemRead = 1'b0; //no care
                PCWrite = 1'b0; //no care
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b0; //no care
                ALUOp = 2'b00;
            end
            MEMREAD:
            begin
                MemtoReg  = 2'b00; //no care
                IorD = 1'b1;
                PCSrc = 1'b0; //no care
                ALUSrcB = 2'b00; //no care
                ALUSrcA = 2'b00; //no care
                IRWrite = 1'b0; //no care
                MemWrite = 1'b0; //no care
                MemRead = 1'b1;
                PCWrite = 1'b0; //no care
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b0; //no care
                ALUOp = 2'b00; //no care
            end
            MEM_COMPLETION:
            begin
                MemtoReg  = 2'b01;
                IorD = 1'b0; //no care
                PCSrc = 1'b0; //no care
                ALUSrcB = 2'b00; //no care
                ALUSrcA = 2'b00; //no care
                IRWrite = 1'b0; //no care
                MemWrite = 1'b0; //no care
                MemRead = 1'b0; // no care
                PCWrite = 1'b0; //no care
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b1;
                ALUOp = 2'b00; //no care
            end
            MEM_WRITE:
            begin
                MemtoReg  = 2'b00;//no care
                IorD = 1'b1;
                PCSrc = 1'b0; //no care
                ALUSrcB = 2'b00; //no care
                ALUSrcA = 2'b00; //no care
                IRWrite = 1'b0; //no care
                MemWrite = 1'b1;
                MemRead = 1'b0; // no care
                PCWrite = 1'b0; //no care
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b0;//no care
                ALUOp = 2'b00; //no care
            end
            EXECUTE_REG:
            begin
                MemtoReg  = 2'b00;//no care
                IorD = 1'b0; //no care
                PCSrc = 1'b0; //no care
                ALUSrcB = 2'b00;
                ALUSrcA = 2'b01;
                IRWrite = 1'b0; //no care
                MemWrite = 1'b0; //no care
                MemRead = 1'b0; // no care
                PCWrite = 1'b0; //no care
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b0;//no care
                ALUOp = 2'b10;
            end
            R_I_AUIPC_COMPLETION:
            begin
                MemtoReg  = 2'b00;
                IorD = 1'b0; //no care
                PCSrc = 1'b0; //no care
                ALUSrcB = 2'b00; //no care
                ALUSrcA = 2'b00; //no care
                IRWrite = 1'b0; //no care
                MemWrite = 1'b0; //no care
                MemRead = 1'b0; // no care
                PCWrite = 1'b0; //no care
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b1;
                ALUOp = 2'b00; //no care
            end
            EXECUTE_IMM:
            begin
                MemtoReg  = 2'b00; //no care
                IorD = 1'b0; //no care
                PCSrc = 1'b0; //no care
                ALUSrcB = 2'b10;
                ALUSrcA = 2'b01;
                IRWrite = 1'b0; //no care
                MemWrite = 1'b0; //no care
                MemRead = 1'b0; // no care
                PCWrite = 1'b0; //no care
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b0;//no care
                ALUOp = 2'b10;
            end
            JALR_COMPLETION:
            begin
                MemtoReg  = 2'b10;
                IorD = 1'b0; //no care
                PCSrc = 1'b1;
                ALUSrcB = 2'b00; //no care
                ALUSrcA = 2'b00; //no care
                IRWrite = 1'b0; //no care
                MemWrite = 1'b0; //no care
                MemRead = 1'b0; // no care
                PCWrite = 1'b1;
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b1;
                ALUOp = 2'b00;//no care
            end
            BRANCH:
            begin
                MemtoReg  = 2'b00;//no care
                IorD = 1'b0; //no care
                PCSrc = 1'b1;
                ALUSrcB = 2'b00;
                ALUSrcA = 2'b01;
                IRWrite = 1'b0; //no care
                MemWrite = 1'b0; //no care
                MemRead = 1'b0; // no care
                PCWrite = 1'b0; //no care
                PCWriteCond = 1'b1;
                BNE = 1'b0;
                RegWrite = 1'b0;//no care
                ALUOp = 2'b01;
            end
            BRANCH_NOT_EQUAL:
            begin
                MemtoReg  = 2'b00;//no care
                IorD = 1'b0; //no care
                PCSrc = 1'b1;
                ALUSrcB = 2'b00;
                ALUSrcA = 2'b01;
                IRWrite = 1'b0; //no care
                MemWrite = 1'b0; //no care
                MemRead = 1'b0; // no care
                PCWrite = 1'b0; //no care
                PCWriteCond = 1'b1;
                BNE = 1'b1;
                RegWrite = 1'b0;//no care
                ALUOp = 2'b01;
            end
            EXECUTE_JAL:
            begin
                MemtoReg  = 2'b10;
                IorD = 1'b0; //no care
                PCSrc = 1'b1;
                ALUSrcB = 2'b00; //no care
                ALUSrcA = 2'b00; //no care
                IRWrite = 1'b0; //no care
                MemWrite = 1'b0; //no care
                MemRead = 1'b0; // no care
                PCWrite = 1'b1;
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b1;
                ALUOp = 2'b00; //no care
            end
            EXECUTE_LUI:
            begin
                MemtoReg  = 2'b11;
                IorD = 1'b0; //no care
                PCSrc = 1'b0; //no care
                ALUSrcB = 2'b00; //no care
                ALUSrcA = 2'b00; //no care
                IRWrite = 1'b0; //no care
                MemWrite = 1'b0; //no care
                MemRead = 1'b0; // no care
                PCWrite = 1'b0; //no care
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b1;
                ALUOp = 2'b00; //no care
            end
            EXECUTE_AUIPC:
            begin
                MemtoReg  = 2'b00; //no care
                IorD = 1'b0; //no care
                PCSrc = 1'b0; //no care
                ALUSrcB = 2'b10;
                ALUSrcA = 2'b10;
                IRWrite = 1'b0; //no care
                MemWrite = 1'b0; //no care
                MemRead = 1'b0; // no care
                PCWrite = 1'b0; //no care
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b0;//no care
                ALUOp = 2'b00;
            end
            default:
            begin
                MemtoReg  = 2'b00; //no care
                IorD = 1'b0; //no care
                PCSrc = 1'b0; //no care
                ALUSrcB = 2'b00; //no care
                ALUSrcA = 2'b00; //no care
                IRWrite = 1'b0; //no care
                MemWrite = 1'b0; //no care
                MemRead = 1'b0; // no care
                PCWrite = 1'b0; //no care
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b0;//no care
                ALUOp = 2'b00; //no care
            end
			endcase
	end

endmodule
