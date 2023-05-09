// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            03/05/23
// File:			     branch_control_unit.v
// Module name:	  branch_control_unit
// Project Name:	  risc_v_top
// Description:	  This is the branch unit located in mem stage

module branch_control_unit (
    input take_branch,
    input[6:0] opcode,
    output clear
);

// check if opcode is beq or bne, and if take branch is set
// if so, clear the IF, ID, EX and jump delay flops
parameter B_TYPE = 7'b1100011;

assign clear = (opcode ==B_TYPE) && (take_branch == 1'b1);

endmodule