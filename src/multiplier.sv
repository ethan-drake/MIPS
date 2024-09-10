// Coder:           Eduardo Ethandrake Castillo Pulido
// Date:            09/10/24
// File:			     multiplier.v
// Module name:	  multiplier
// Project Name:	  mips_top
// Description:	  This is the multiplier module

module multiplier(
    input [31:0] i_a,
    input [31:0] i_b,
    input i_enable,
    output reg [31:0] o_c

);

always @(*) begin
    if (i_enable) begin
        o_c = i_a * i_b;
    end
    else begin
        o_c = 32'h0;
    end
end

endmodule