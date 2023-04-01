// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            16/03/23
// File:			     control_unit.v
// Module name:	  control_unit
// Project Name:	  risc_v_top
// Description:	  RISC_V control unit single cycle

module control_unit(
    //Inputs control unit
    input[6:0] opcode,
    //Inputs ALU Decoder
    input[2:0] func3,
    //Output control unit
    //Multiplexer Selects
    output reg [1:0] MemtoReg,
    output reg IorD, 
    output reg PCSrc,
    output reg [1:0] ALUSrcB,
    output reg [1:0] ALUSrcA,
    //Register Enables
    output reg MemWrite,
    output reg MemRead,
    output reg PCWrite,
    output reg PCWriteCond,
    output reg BNE,
    output reg RegWrite,
    //Outputs ALU Decoder
    output reg [2:0] ALUOp
);

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

//OUTPUT DEFINITION
always @(opcode)
	begin
		ALUOp = 2'b00;
		case(opcode)
            LOAD_INS:
            begin
                MemtoReg = 2'b00; //no care
                IorD = 1'b0;
                PCSrc = 1'b0;
                ALUSrcB = 2'b01;
                ALUSrcA = 2'b00;
                MemWrite = 1'b0; //no care
                MemRead = 1'b1;
                PCWrite = 1'b1;
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b0; //no care
                ALUOp = 2'b00;
            end
            S_TYPE:
            begin
                MemtoReg = 2'b00; //no care
                IorD = 1'b0; //no care
                PCSrc = 1'b0; //no care
                ALUSrcB = 2'b10;
                ALUSrcA = 2'b10;
                MemWrite = 1'b0; //no care
                MemRead = 1'b0; //no care
                PCWrite = 1'b0; //no care
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b0; //no care
                ALUOp = 2'b00;
            end
            R_TYPE:
            begin
                MemtoReg = 2'b00; //no care
                IorD = 1'b0; //no care
                PCSrc = 1'b0; //no care
                ALUSrcB = 2'b10;
                ALUSrcA = 2'b01;
                MemWrite = 1'b0; //no care
                MemRead = 1'b0; //no care
                PCWrite = 1'b0; //no care
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b0; //no care
                ALUOp = 2'b00;
            end
            I_TYPE:
            begin
                MemtoReg  = 2'b00; //no care
                IorD = 1'b1;
                PCSrc = 1'b0; //no care
                ALUSrcB = 2'b00; //no care
                ALUSrcA = 2'b00; //no care
                MemWrite = 1'b0; //no care
                MemRead = 1'b1;
                PCWrite = 1'b0; //no care
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b0; //no care
                ALUOp = 2'b00; //no care
            end
            JALR_INS:
            begin
                MemtoReg  = 2'b01;
                IorD = 1'b0; //no care
                PCSrc = 1'b0; //no care
                ALUSrcB = 2'b00; //no care
                ALUSrcA = 2'b00; //no care
                MemWrite = 1'b0; //no care
                MemRead = 1'b0; // no care
                PCWrite = 1'b0; //no care
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b1;
                ALUOp = 2'b00; //no care
            end
            B_TYPE:
            begin
                if(func3 == 3'b000) //BEQ
                begin
                    MemtoReg  = 2'b00;//no care
                    IorD = 1'b1;
                    PCSrc = 1'b0; //no care
                    ALUSrcB = 2'b00; //no care
                    ALUSrcA = 2'b00; //no care
                    MemWrite = 1'b1;
                    MemRead = 1'b0; // no care
                    PCWrite = 1'b0; //no care
                    PCWriteCond = 1'b0; //no care
                    BNE = 1'b0; //no care
                    RegWrite = 1'b0;//no care
                    ALUOp = 2'b00; //no care
                end
                else if(func3 == 3'b000) //BNE
                begin
                    MemtoReg  = 2'b00;//no care
                    IorD = 1'b1;
                    PCSrc = 1'b0; //no care
                    ALUSrcB = 2'b00; //no care
                    ALUSrcA = 2'b00; //no care
                    MemWrite = 1'b1;
                    MemRead = 1'b0; // no care
                    PCWrite = 1'b0; //no care
                    PCWriteCond = 1'b0; //no care
                    BNE = 1'b0; //no care
                    RegWrite = 1'b0;//no care
                    ALUOp = 2'b00; //no care
                end

            end
            LUI_INS:
            begin
                MemtoReg  = 2'b00;//no care
                IorD = 1'b0; //no care
                PCSrc = 1'b0; //no care
                ALUSrcB = 2'b00;
                ALUSrcA = 2'b01;
                MemWrite = 1'b0; //no care
                MemRead = 1'b0; // no care
                PCWrite = 1'b0; //no care
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b0;//no care
                ALUOp = 2'b10;
            end
            AUIPC_INS:
            begin
                MemtoReg  = 2'b00;
                IorD = 1'b0; //no care
                PCSrc = 1'b0; //no care
                ALUSrcB = 2'b00; //no care
                ALUSrcA = 2'b00; //no care
                MemWrite = 1'b0; //no care
                MemRead = 1'b0; // no care
                PCWrite = 1'b0; //no care
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b1;
                ALUOp = 2'b00; //no care
            end
            JAL_INS:
            begin
                MemtoReg  = 2'b00; //no care
                IorD = 1'b0; //no care
                PCSrc = 1'b0; //no care
                ALUSrcB = 2'b10;
                ALUSrcA = 2'b01;
                MemWrite = 1'b0; //no care
                MemRead = 1'b0; // no care
                PCWrite = 1'b0; //no care
                PCWriteCond = 1'b0; //no care
                BNE = 1'b0; //no care
                RegWrite = 1'b0;//no care
                ALUOp = 2'b10;
            end
            default:
            begin
                MemtoReg  = 2'b00; //no care
                IorD = 1'b0; //no care
                PCSrc = 1'b0; //no care
                ALUSrcB = 2'b00; //no care
                ALUSrcA = 2'b00; //no care
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
