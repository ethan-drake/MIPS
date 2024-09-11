// Coder:           Eduardo Ethandrake Castillo Pulido
// Date:            07/09/2024
// File:			     rf_forward_unit.sv
// Module name:	  rf_forward_unit
// Project Name:	  mips_top
// Description:	  This module allows to forward register write data to register
//                read in the case the instruction tries to read at the same time previous tries to write



module rf_forward_unit(
    input i_clk,
    input i_rst_n,
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
    input [5:0] ex_funct,
    input [4:0] ex_rd,
    input [4:0] ex_rt,
    input ex_reg_write,
    input mult_ready,
    input [4:0] mult_rd,
    input [4:0] p1_mult_rd,
    input [4:0] p2_mult_rd,
    input [4:0] p3_mult_rd,
    output reg [1:0] rd1_sel,
    output reg [1:0] rd2_sel,
    output reg stalling
);
typedef struct packed {
	logic rd1;
    logic rd2;
} fwd_stalling;

localparam MFLO_FUNCT = 6'h12;
reg fwd_stalling_rd1;
reg fwd_stalling_rd2;

fwd_stalling mult_stalling;
fwd_stalling fwd_stalling_0;
fwd_stalling fwd_stalling_1;
fwd_stalling fwd_stalling_2;
fwd_stalling fwd_stalling_3;
fwd_stalling fwd_stalling_4;
fwd_stalling stall_from_mult;

always @(*) begin
    //STALLING FROM DEPENDENCIES ON MULT PIPELINE for RS
    if (id_rs != 0)begin
        if ((id_rs == p1_mult_rd) || (p1_mult_rd != 0))begin
            stall_from_mult.rd1 = 1'b1;
        end
        else if (id_rs == p2_mult_rd)begin
            stall_from_mult.rd1 = 1'b1;
        end
        else if (id_rs == p3_mult_rd)begin
            stall_from_mult.rd1 = 1'b1;
        end
        else begin
            stall_from_mult.rd1 = 1'b0;
        end
    end
    else begin
        stall_from_mult.rd1 = 1'b0;
    end
    //STALLING FROM DEPENDENCIES ON MULT PIPELINE for RT
    if (id_rt != 0)begin
        if ((id_rt == p1_mult_rd) || (p1_mult_rd != 0))begin
            stall_from_mult.rd2 = 1'b1;
        end
        else if (id_rt == p2_mult_rd)begin
            stall_from_mult.rd2 = 1'b1;
        end
        else if (id_rt == p3_mult_rd)begin
            stall_from_mult.rd2 = 1'b1;
        end
        else begin
            stall_from_mult.rd2 = 1'b0;
        end
    end
    else begin
        stall_from_mult.rd2 = 1'b0;
    end
    //FORWARD RD1 FROM EX
    //  FOR IMMEDIATE INSTRUCTIONS                                      FOR REG INSTRUCTIONS 
    if (((ex_rt == id_rs) && ex_reg_write && (ex_opcode != 0)) || ((id_rs != 0) && (ex_rd == id_rs) && ex_reg_write && (ex_opcode == 0))) begin
        if((ex_opcode == 0) && (ex_funct == MFLO_FUNCT))begin
            fwd_stalling_0.rd1 = 1'b1;
            rd1_sel = 2'b00;
            mult_stalling.rd1 = 1'b1;
        end
        else begin
            fwd_stalling_0.rd1 = 1'b1;
            rd1_sel = 2'b00;
            mult_stalling.rd1 = 1'b0;
        end
    end
    //FORWARD RD1 FROM MEM
    else if (((mem_rt == id_rs) && mem_reg_write && (mem_opcode != 0)) || ((mem_rd == id_rs) && mem_reg_write && (mem_opcode == 0)))begin
        rd1_sel = 2'b10;
        fwd_stalling_0.rd1 = 1'b0;
        mult_stalling.rd1 = 1'b0;
    end
    //FORWARD RD1 FROM WB
    //|| (mult_rd == id_rs) && mult_ready
    else if (((wb_rt == id_rs) && wb_reg_write && (wb_opcode != 0)) || ((wb_rd == id_rs) && wb_reg_write && (wb_opcode == 0)) || ((mult_rd == id_rs) && mult_ready))begin
        rd1_sel = 2'b01;
        fwd_stalling_0.rd1 = 1'b0;
        mult_stalling.rd1 = 1'b0;
    end
    else begin
        rd1_sel = 2'b00;
        fwd_stalling_0.rd1 = 1'b0;
        mult_stalling.rd1 = 1'b0;
    end

    //FORWARD RD2 FROM EX
    if (((ex_rt == id_rt) && ex_reg_write && (ex_opcode != 0)) || ((id_rt != 0) && (ex_rd == id_rt) && ex_reg_write && (ex_opcode == 0))) begin
        if((ex_opcode == 0) && (ex_funct == MFLO_FUNCT))begin
            fwd_stalling_0.rd2 = 1'b1;
            rd2_sel = 2'b00;
            mult_stalling.rd2 = 1'b1;
        end
        else begin
            fwd_stalling_0.rd2 = 1'b1;
            rd2_sel = 2'b00;
            mult_stalling.rd2 = 1'b0;
        end
    end
    //FORWARD RD2 FROM MEM
    else if (((mem_rt == id_rt) && mem_reg_write && (mem_opcode != 0)) || ((mem_rd == id_rt) & mem_reg_write && (mem_opcode == 0)))begin
        rd2_sel = 2'b10;
        fwd_stalling_0.rd2 = 1'b0;
        mult_stalling.rd2 = 1'b0;
    end
    //FORWARD RD2 FROM WB
    else if (((wb_rt == id_rt) & wb_reg_write && (wb_opcode != 0)) || ((wb_rd == id_rt) & wb_reg_write && (wb_opcode == 0)) || ((mult_rd == id_rt) && mult_ready))begin
        rd2_sel = 2'b01;
        fwd_stalling_0.rd2 = 1'b0;
        mult_stalling.rd2 = 1'b0;
    end
    else begin
        rd2_sel = 2'b00;
        fwd_stalling_0.rd2 = 1'b0;
        mult_stalling.rd2 = 1'b0;
    end

    fwd_stalling_rd1 = fwd_stalling_0.rd1 | fwd_stalling_1.rd1 | fwd_stalling_2.rd1 | fwd_stalling_3.rd1 | fwd_stalling_4.rd1 | stall_from_mult.rd1;

    fwd_stalling_rd2 = fwd_stalling_0.rd2 | fwd_stalling_1.rd2 | fwd_stalling_2.rd2 | fwd_stalling_3.rd2 | fwd_stalling_4.rd2 | stall_from_mult.rd2;

    stalling = fwd_stalling_rd1 | fwd_stalling_rd2;


end

ffd_param #(.LENGTH(2)) ffd_stall_1(
	//inputs
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_en(1'b1),
	.d(fwd_stalling_0 & mult_stalling),
	//outputs
	.q(fwd_stalling_1)
);

ffd_param #(.LENGTH(2)) ffd_stall_2(
	//inputs
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_en(1'b1),
	.d(fwd_stalling_1),
	//outputs
	.q(fwd_stalling_2)
);

ffd_param #(.LENGTH(2)) ffd_stall_3(
	//inputs
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_en(1'b1),
	.d(fwd_stalling_2),
	//outputs
	.q(fwd_stalling_3)
);

ffd_param #(.LENGTH(2)) ffd_stall4(
	//inputs
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_en(1'b1),
	.d(fwd_stalling_3|stall_from_mult),
	//outputs
	.q(fwd_stalling_4)
);


endmodule