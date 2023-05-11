// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            03/05/23
// File:			     branch_control_unit.v
// Module name:	  branch_control_unit
// Project Name:	  risc_v_top
// Description:	  This is the branch unit located in mem stage

module branch_control_unit (
    input take_branch,
    input[6:0] opcode,
    input prediction_checkout_ex_mem,
    input[31:0] prediction_target_ex_mem,
    input[31:0] real_target,
    output clear,
    output PC_restore
);

// check if opcode is beq or bne, and if take branch is set
// if so, clear the IF, ID, EX and jump delay flops
parameter B_TYPE = 7'b1100011;

assign clear = (opcode ==B_TYPE) && ( (take_branch != prediction_checkout_ex_mem) || ( (take_branch == 1'b1) && (take_branch == prediction_checkout_ex_mem) && (prediction_target_ex_mem != real_target)) );

assign PC_restore = ((opcode ==B_TYPE) && (prediction_checkout_ex_mem == 1'b1) && (take_branch == 1'b0)) ? 1'b1 : ((opcode ==B_TYPE) && (prediction_checkout_ex_mem == 1'b0) && (take_branch == 1'b1)) ? 1'b0:1'b0;

//assign = (opcode == B_TYPE) && (take_branch == prediction_checkout_ex_mem) && (prediction_target_ex_mem != real_target)

endmodule