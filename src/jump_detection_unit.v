// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            03/05/23
// File:			     jump_detection_unit.v
// Module name:	  jump_detection_unit
// Project Name:	  risc_v_top
// Description:	  This is the jump detection unit located in decode stage

module jump_detection_unit(
    input [6:0] opcode,
    output nop_inject
);

//check if opcode relates to a jump and link or a jump and link reg
//if true, set nop inject
localparam JAL_INS = 7'b1101111;
localparam JALR_INS = 7'b1100111;

assign nop_inject = (opcode == JAL_INS) ? 1'b1 : (opcode == JALR_INS) ? 1'b1 : 1'b0;

endmodule