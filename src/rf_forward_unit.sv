// Coder:           Eduardo Ethandrake Castillo Pulido
// Date:            07/09/2024
// File:			     rf_forward_unit.sv
// Module name:	  rf_forward_unit
// Project Name:	  mips_top
// Description:	  This module allows to forward register write data to register
//                read in the case the instruction tries to read at the same time previous tries to write



module rf_forward_unit(
    input [4:0] id_rs,
    input [4:0] id_rt,
    input [4:0] wb_rd,
    input [4:0] wb_rt,
    input wb_reg_write,
    output reg rd1_sel,
    output reg rd2_sel
);

assign rd1_sel = ((wb_rt == id_rs) & wb_reg_write) ? 1'b1 : ((wb_rd == id_rs) & wb_reg_write) ? 1'b1 : 1'b0;

assign rd2_sel = ((wb_rt == id_rt) & wb_reg_write) ? 1'b1 : ((wb_rd == id_rt) & wb_reg_write) ? 1'b1 : 1'b0;

endmodule