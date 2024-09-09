// Coder:           Eduardo Ethandrake Castillo Pulido
// Date:            09/09/24
// File:			     jump_detection_unit.v
// Module name:	  jump_detection_unit
// Project Name:	  risc_v_top
// Description:	  This is the jump detection unit located in decode stage

module jump_detection_unit(
    input [5:0] opcode,
    input [5:0] funct,
    output reg flush
);

//check if opcode relates to a jump and link or a jump and link reg
//if true, flush if_id pipe
localparam J_OP = 6'h2;
localparam JAL_OP = 6'h3;
localparam R_OP = 6'h0;
localparam JR_FUNC = 6'h8;

always @(*) begin
    if (opcode == J_OP)begin
        flush = 1'b1;
    end
    else if (opcode == JAL_OP)begin
        flush = 1'b1;
    end
    else if (opcode == R_OP && funct == JR_FUNC)begin
        flush = 1'b1;
    end
    else begin
        flush = 1'b0;
    end

end


endmodule