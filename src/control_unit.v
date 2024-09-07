// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            16/03/23
// File:			     control_unit.v
// Module name:	  control_unit
// Project Name:	  risc_v_top
// Description:	  RISC_V control unit single cycle

module control_unit(
    //Inputs control unit
    input[5:0] opcode,
    //Inputs ALU Decoder
    input[5:0] func,
    //Output control unit
    //Multiplexer Selects
    output reg MemtoReg,
    output reg ALUSrcB,
    //Register Enables
    output reg MemWrite,
    output reg MemRead,
    output reg BEQ,
    output reg RegWrite,
    output reg RegDst,
    output reg jump,
    //Outputs ALU Decoder
    output reg [3:0] ALUOP
);


//opcodes
parameter JUMP_OP      = 6'b000010;
parameter ADDI_OP      = 6'b001000;
parameter BEQ_OP       = 6'b000100;
parameter R_TYPE_OP    = 6'b000000;
parameter LW_OP        = 6'b100011;
parameter SW_OP        = 6'b101011;
parameter ANDI_OP      = 6'b001100;
parameter ORI_OP       = 6'b001101;
parameter LUI_OP       = 6'b001111;

//ALU Control
//ADDITION 010, ALUOP 00

//OUTPUT DEFINITION
always @(*)
	begin
        MemtoReg = 1'b0;
        ALUSrcB = 1'b0;
        MemWrite = 1'b0;
        MemRead = 1'b0;
        RegDst = 1'b0;
        BEQ = 1'b0;
        RegWrite = 1'b0;
        jump = 1'b0;
        ALUOP = 3'b00;
        if (opcode | func !=0)
            begin
            case(opcode)
                JUMP_OP:
                begin
                    MemtoReg = 1'b0;
                    ALUSrcB = 1'b0;
                    MemWrite = 1'b0;
                    MemRead = 1'b0;
                    RegDst = 1'b0;
                    BEQ = 1'b0;
                    RegWrite = 1'b0;
                    jump = 1'b1;
                    ALUOP = 3'b00;
                end
                BEQ_OP:
                begin
                    MemtoReg = 1'b0;
                    ALUSrcB = 1'b0;
                    MemWrite = 1'b0;
                    MemRead = 1'b0;
                    RegDst = 1'b0;
                    BEQ = 1'b1;
                    RegWrite = 1'b0;
                    jump = 1'b0;
                    ALUOP = 3'b01;
                end
                LW_OP:
                begin
                    MemtoReg = 1'b1;
                    ALUSrcB = 1'b1;
                    MemWrite = 1'b0;
                    MemRead = 1'b1;
                    RegDst = 1'b0;
                    BEQ = 1'b0;
                    RegWrite = 1'b1;
                    jump = 1'b0;
                    ALUOP = 3'b00;
                end
                R_TYPE_OP:
                begin
                    MemtoReg = 1'b0;
                    ALUSrcB = 1'b0;
                    MemWrite = 1'b0;
                    MemRead = 1'b0;
                    RegDst = 1'b1;
                    BEQ = 1'b0;
                    RegWrite = 1'b1;
                    jump = 1'b0;
                    ALUOP = 3'b10;
                end
                ADDI_OP:
                begin
                    MemtoReg = 1'b0;
                    ALUSrcB = 1'b1;
                    MemWrite = 1'b0;
                    MemRead = 1'b0;
                    RegDst = 1'b0;
                    BEQ = 1'b0;
                    RegWrite = 1'b1;
                    jump = 1'b0;
                    ALUOP = 3'b00;
                end
                SW_OP:
                begin
                    MemtoReg = 1'b0;
                    ALUSrcB = 1'b1;
                    MemWrite = 1'b1;
                    MemRead = 1'b0;
                    RegDst = 1'b0;
                    BEQ = 1'b0;
                    RegWrite = 1'b0;
                    jump = 1'b0;
                    ALUOP = 3'b00;
                end
                ANDI_OP:
                begin
                    MemtoReg = 1'b0;
                    ALUSrcB = 1'b1;
                    MemWrite = 1'b0;
                    MemRead = 1'b0;
                    RegDst = 1'b0;
                    BEQ = 1'b0;
                    RegWrite = 1'b1;
                    jump = 1'b0;
                    ALUOP = 3'b011;
                end
                ORI_OP:
                begin
                    MemtoReg = 1'b0;
                    ALUSrcB = 1'b1;
                    MemWrite = 1'b0;
                    MemRead = 1'b0;
                    RegDst = 1'b0;
                    BEQ = 1'b0;
                    RegWrite = 1'b1;
                    jump = 1'b0;
                    ALUOP = 3'b100;
                end
                LUI_OP:
                begin
                    MemtoReg = 1'b0;
                    ALUSrcB = 1'b1;
                    MemWrite = 1'b0;
                    MemRead = 1'b0;
                    RegDst = 1'b0;
                    BEQ = 1'b0;
                    RegWrite = 1'b1;
                    jump = 1'b0;
                    ALUOP = 3'b101;
                end
                default:
                begin
                    MemtoReg = 1'b0;
                    ALUSrcB = 1'b0;
                    MemWrite = 1'b0;
                    MemRead = 1'b0;
                    RegDst = 1'b0;
                    BEQ = 1'b0;
                    RegWrite = 1'b0;
                    jump = 1'b0;
                    ALUOP = 3'b00;
                end
                endcase
            end
	end

endmodule
