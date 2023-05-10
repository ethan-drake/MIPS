
module branch_control_unit(
    input take_branch,
    input[6:0] opcode,
    input prediction_checkout_ex_mem,
    output clear,
    output PC_restore
);

// check if opcode is beq or bne, and if take branch is set
// if so, clear the IF, ID, EX and jump delay flops
parameter B_TYPE = 7'b1100011;

assign clear = (opcode ==B_TYPE) && (take_branch != prediction_checkout_ex_mem);

assign PC_restore = ((prediction_checkout_ex_mem == 1'b1) && (take_branch == 1'b0)) ? 1'b1 : ((prediction_checkout_ex_mem == 1'b0) && (take_branch == 1'b1)) ? 1'b0:1'b0;

endmodule