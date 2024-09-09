// Coder:           Eduardo Ethandrake Castillo Pulido
// Date:            07/09/2024
// File:			     mem_forward_unit.sv
// Module name:	  mem_forward_unit
// Project Name:	  mips_top
// Description:	  This module allows to forward mem data just read from WB pipeline
//                 into mem write data for a LW SW pair

module mem_fwd_unit(
    input ex_mem_write,
    input wb_mem_read,
    input [4:0] wb_rt,
    input [4:0] ex_rt,
    output reg mem_mux_sel
);

always@(*) begin
    if (( wb_rt == ex_rt) && ex_mem_write && wb_mem_read)begin
        mem_mux_sel = 1'b1;
    end
    else begin
        mem_mux_sel = 1'b0;
    end
end

endmodule