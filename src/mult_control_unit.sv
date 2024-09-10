// Coder:           Eduardo Ethandrake Castillo Pulido
// Date:            09/10/24
// File:			     mult_control_unit.v
// Module name:	  mult_control_unit
// Project Name:	  mips
// Description:	  This is the multiplication control unit

module mult_control_unit(
    input [5:0] opcode,
    input [5:0] funct,
    output reg mult_enable,
    output reg store_values
);

localparam  R_OPCODE = 6'h0;
localparam MULT_FUNCT = 6'h18;
localparam MFLO_FUNCT = 6'h12;

always @(*) begin
    if(opcode == R_OPCODE)begin
        if(funct == MULT_FUNCT)begin
            store_values = 1'b1;
            mult_enable = 1'b0;
        end
        else if(funct == MFLO_FUNCT)begin
            mult_enable = 1'b1;
            store_values = 1'b0;
        end
        else begin
            store_values = 1'b0;
            mult_enable = 1'b0;
        end
    end
    else begin
        store_values = 1'b0;
        mult_enable = 1'b0;
    end
end

endmodule