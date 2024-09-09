// Coder:           Eduardo Ethandrake Castillo Pulido
// Date:            09/09/24
// File:			     branch_control_unit.v
// Module name:	  branch_control_unit
// Project Name:	  mips_top
// Description:	  This is the branch unit located in decode stage

module branch_control_unit (
    input [5:0] opcode,
    input PCSrc,
    output reg flush
);

localparam BEQ_OP = 6'h4;
localparam BNE_OP = 6'h5;

always @(*) begin
    if(opcode == BEQ_OP && PCSrc)begin
        flush = 1'b1;
    end    
    else begin
        flush = 1'b0;
    end
end

endmodule