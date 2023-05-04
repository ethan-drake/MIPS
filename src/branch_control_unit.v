
module branch_control_unit(
    input take_branch,
    input[6:0] opcode,
    output clear
);

// check if opcode is beq or bne, and if take branch is set
// if so, clear the IF, ID, EX and jump delay flops
parameter B_TYPE = 7'b1100011;

assign clear = (opcode ==B_TYPE) && (take_branch == 1'b1);

endmodule