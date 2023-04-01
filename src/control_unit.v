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
    output reg PCSrc,
    output reg ALUSrcA,
    output reg ALUSrcB,
    //Register Enables
    output reg MemWrite,
    output reg MemRead,
    output reg PCWriteCond,
    output reg BNE,
    output reg RegWrite,
    //Outputs ALU Decoder
    output reg [2:0] ALUOP
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
always @(*)
	begin
		 BNE = 1'b0;
		 PCWriteCond = 1'b0;
		 MemRead = 1'b0;
		 MemWrite = 1'b0;
		 MemtoReg = 2'b00;
		 PCSrc = 1'b0;
		 ALUOP = 2'b00;
         ALUSrcA = 1'b0;
		 ALUSrcB = 1'b0;
		 RegWrite = 1'b0;
		case(opcode)
            LOAD_INS:
            begin
                BNE = 1'b0;
                PCWriteCond = 1'b0;
                MemRead = 1'b1;
                MemWrite = 1'b0;
                MemtoReg = 2'b01;
                PCSrc = 1'b0;
                ALUOP = 2'b00;
                ALUSrcA = 1'b1;
                ALUSrcB = 1'b1;
                RegWrite = 1'b1;
            end
            S_TYPE:
            begin
                BNE = 1'b0;
                PCWriteCond = 1'b0;
                MemRead = 1'b1;
                MemWrite = 1'b1;
                MemtoReg = 2'b00;
                PCSrc = 1'b0;
                ALUOP = 2'b00;
                ALUSrcA = 1'b1;
                ALUSrcB = 1'b1;
                RegWrite = 1'b0;
            end
            R_TYPE:
            begin
                BNE = 1'b0;
                PCWriteCond = 1'b0;
                MemRead = 1'b1;
                MemWrite = 1'b0;
                MemtoReg = 2'b00;
                PCSrc = 1'b0;
                ALUOP = 2'b10;
                ALUSrcA = 1'b1;
                ALUSrcB = 1'b0;
                RegWrite = 1'b1;
            end
            I_TYPE:
            begin
                BNE = 1'b0;
                PCWriteCond = 1'b0;
                MemRead = 1'b1;
                MemWrite = 1'b0;
                MemtoReg = 2'b00;
                PCSrc = 1'b0;
                ALUOP = 2'b10;
                ALUSrcA = 1'b1;
                ALUSrcB = 1'b1;
                RegWrite = 1'b1;
            end
            JALR_INS:
            begin
                BNE = 1'b0;
                PCWriteCond = 1'b0;
                MemRead = 1'b1;
                MemWrite = 1'b0;
                MemtoReg = 2'b10;
                PCSrc = 1'b1;
                ALUOP = 2'b10;
                ALUSrcA = 1'b1;
                ALUSrcB = 1'b1;
                RegWrite = 1'b1;
            end
            B_TYPE:
            begin
                if(func3 == 3'b000) //BEQ
                begin
                    BNE = 1'b0;
                    PCWriteCond = 1'b1;
                    MemRead = 1'b1;
                    MemWrite = 1'b0;
                    MemtoReg = 2'b00;
                    PCSrc = 1'b0;
                    ALUOP = 2'b01;
                    ALUSrcA = 1'b1;
                    ALUSrcB = 1'b0;
                    RegWrite = 1'b0;
                end
                else if(func3 == 3'b000) //BNE
                begin
                    BNE = 1'b1;
                    PCWriteCond = 1'b1;
                    MemRead = 1'b1;
                    MemWrite = 1'b0;
                    MemtoReg = 2'b00;
                    PCSrc = 1'b0;
                    ALUOP = 2'b01;
                    ALUSrcA = 1'b1;
                    ALUSrcB = 1'b0;
                    RegWrite = 1'b0;
                end
            end
            LUI_INS:
            begin
                BNE = 1'b0;
                PCWriteCond = 1'b0;
                MemRead = 1'b1;
                MemWrite = 1'b0;
                MemtoReg = 2'b11;
                PCSrc = 1'b0;
                ALUOP = 2'b00;
                ALUSrcA = 1'b1;
                ALUSrcB = 1'b1;
                RegWrite = 1'b1;
            end
            AUIPC_INS:
            begin
                BNE = 1'b0;
                PCWriteCond = 1'b0;
                MemRead = 1'b1;
                MemWrite = 1'b0;
                MemtoReg = 2'b00;
                PCSrc = 1'b0;
                ALUOP = 2'b00;
                ALUSrcA = 1'b0;
                ALUSrcB = 1'b1;
                RegWrite = 1'b1;
            end
            JAL_INS:
            begin
                BNE = 1'b0;
                PCWriteCond = 1'b0;
                MemRead = 1'b1;
                MemWrite = 1'b0;
                MemtoReg = 2'b10;
                PCSrc = 1'b1;
                ALUOP = 2'b00;
                ALUSrcA = 1'b1;
                ALUSrcB = 1'b1;
                RegWrite = 1'b1;
            end
            default:
            begin
                BNE = 1'b0;
                PCWriteCond = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'b00;
                PCSrc = 1'b0;
                ALUOP = 2'b00;
                ALUSrcA = 1'b1;
                ALUSrcB = 1'b0;
                RegWrite = 1'b0;
            end
			endcase
	end

endmodule
