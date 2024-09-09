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
    input [5:0] wb_opcode,
    input [4:0] wb_rd,
    input [4:0] wb_rt,
    input wb_reg_write,
    input [5:0] mem_opcode,
    input [4:0] mem_rd,
    input [4:0] mem_rt,
    input mem_reg_write,
    input [5:0] ex_opcode,
    input [4:0] ex_rd,
    input [4:0] ex_rt,
    input ex_reg_write,
    output reg [1:0] rd1_sel,
    output reg [1:0] rd2_sel
);

//assign rd1_sel = ((wb_rt == id_rs) & wb_reg_write) ? 1'b1 : ((wb_rd == id_rs) & wb_reg_write) ? 1'b1 : 1'b0;

//assign rd2_sel = ((wb_rt == id_rt) & wb_reg_write) ? 1'b1 : ((wb_rd == id_rt) & wb_reg_write) ? 1'b1 : 1'b0;

always @(*) begin
    //FORWARD RD1 FROM EX
    //  FOR IMMEDIATE INSTRUCTIONS                                      FOR REG INSTRUCTIONS 
    if (((ex_rt == id_rs) && ex_reg_write && (ex_opcode != 0)) || ((ex_rd == id_rs) && ex_reg_write && (ex_opcode == 0))) begin
        rd1_sel = 2'b11;
    end
    //FORWARD RD1 FROM MEM
    else if (((mem_rt == id_rs) && mem_reg_write && (mem_opcode != 0)) || ((mem_rd == id_rs) && mem_reg_write && (mem_opcode == 0)))begin
        rd1_sel = 2'b10;
    end
    //FORWARD RD1 FROM WB
    else if (((wb_rt == id_rs) && wb_reg_write && (wb_opcode != 0)) || ((wb_rd == id_rs) && wb_reg_write && (wb_opcode == 0)))begin
        rd1_sel = 2'b01;
    end
    else begin
        rd1_sel = 2'b00;
    end

    //FORWARD RD2 FROM EX
    if (((ex_rt == id_rt) && ex_reg_write && (ex_opcode != 0)) || ((ex_rd == id_rt) && ex_reg_write && (ex_opcode == 0))) begin
        rd2_sel = 2'b11;
    end
    //FORWARD RD2 FROM MEM
    else if (((mem_rt == id_rt) && mem_reg_write && (mem_opcode != 0)) || ((mem_rd == id_rt) & mem_reg_write && (mem_opcode == 0)))begin
        rd2_sel = 2'b10;
    end
    //FORWARD RD2 FROM WB
    else if (((wb_rt == id_rt) & wb_reg_write && (wb_opcode != 0)) || ((wb_rd == id_rt) & wb_reg_write && (wb_opcode == 0)))begin
        rd2_sel = 2'b01;
    end
    else begin
        rd2_sel = 2'b00;
    end

    /*if (((wb_rt == id_rs) & wb_reg_write) || ((wb_rd == id_rs) & wb_reg_write)) begin
        rd1_sel = 2'b01;
    end
    else if (((mem_rt == id_rs) & mem_reg_write) || ((mem_rd == id_rs) & mem_reg_write)) begin
        rd1_sel = 2'b10;
    end
    else if (((ex_rt == id_rs) & ex_reg_write) || ((ex_rd == id_rs) & ex_reg_write)) begin
        rd1_sel = 2'b11;
    end
    else begin
        rd1_sel = 2'b00;
    end

    //FORWARDING RD2 FROM MEM
    if (((wb_rt == id_rt) & wb_reg_write) || ((wb_rd == id_rt) & wb_reg_write)) begin
       rd2_sel = 2'b01; 
    end
    else if (((mem_rt == id_rt) & mem_reg_write) || ((mem_rd == id_rt) & mem_reg_write)) begin
        rd2_sel = 2'b10; 
    end
    else if (((ex_rt == id_rt) & ex_reg_write) || ((ex_rd == id_rt) & ex_reg_write)) begin
        rd2_sel = 2'b11; 
    end
    else begin
        rd2_sel = 2'b00;
    end*/
end

endmodule