// Coder:           Eduardo Ethandrake Castillo Pulido
// Date:            08/27/2024
// File:			     mips_top.v
// Module name:	  mips_top
// Project Name:	  mips_top
// Description:	  Main module for MIPS project

module mips_top (
	//Inputs - Platform
	input clk_50Mhz,
	input rst_n,
	//Input - RX
	input rx,
	//Output - Tx
	output tx
);

//Wires to interconnect modules
wire ALUSrcB, MemWrite, pc_src, jump, regWrite, clk, pll_lock, RegDst, mem2Reg;
wire [1:0] rd1_sel, rd2_sel;
wire [31:0] instr_shift_2, pc_out, rd1_data_reg, rd2_data, rf_rd1, rf_rd2, pc_next, pc_plus_4,pc_branch,branch_pc_out;
wire [31:0] wd3_wire, sign_extend_out, write_register_out,mem_data_write; 
wire [31:0] SrcB, alu_result;
wire [3:0] alu_control;
wire[3:0] alu_operation;
wire [31:0] data_memory_2_slave, address_memory_2_slave, data_return_rom, data_return_ram, data_return_uart;
wire we_memory_2_rom, re_memory_2_rom, we_memory_2_ram, re_memory_2_ram, we_memory_2_uart, re_memory_2_uart;
wire beq;
wire alu_zero,is_equal_output;
wire MemRead,mem_mux_sel;
wire stalling,stalling_hazard_unit,stalling_fw_fwd_unit, if_id_flush_jmp,if_id_flush_branch;
wire [169:0] id_ex_stall_mux_output,ex_mem_stall_mux_output;
wire [31:0] wb_mult_org_pipe_out;
wire [4:0] rd_first_mux_out;
wire mult_detected;

//***********************Structs for Mult Pipeline***********************//
typedef struct packed {
	logic [31:0] mult_result;
	logic [4:0] mult_rd;
    logic mult_ready;
} mult_bus;

mult_bus pipe_mult_result;


//***********************Structs for Pipeline***********************//
typedef struct packed {
	logic [31:0] pc;
	logic [31:0] pc_plus_4;
	logic [31:0] instr;
} if_data_bus;

typedef struct packed {
	logic [31:0] rd1;
	logic [31:0] rd2;
	logic [31:0] sign_extend;
	logic [31:0] opcode;
	logic [31:0] instr;
} id_data_bus;

typedef struct packed {
	logic [31:0] alu_result;
	logic [31:0] rd2;
	logic [31:0] instr;
} ex_data_bus;

typedef struct packed {
	logic [31:0] memory_out;
	logic [31:0] alu_result;
	logic [31:0] instr;
} mem_data_bus;

typedef struct packed {
	logic ALUSrcB;
	logic [3:0] ALUOp;
	logic MemRead;
	logic MemWrite;
	logic mem2Reg;
	logic regWrite;
	logic RegDst;
} id_ex_control_bus;

typedef struct packed {
	logic MemRead;
	logic MemWrite;
	logic mem2Reg;
	logic regWrite;
	logic RegDst;
} ex_mem_control_bus;

typedef struct packed {
	logic MemRead;
	logic MemWrite;
	logic mem2Reg;
	logic regWrite;
	logic RegDst;
} mem_wb_control_bus;

//`define SIMULATION
//`ifndef SIMULATION
//	pll_risc_v PLL_RISCV ( .refclk(clk_50Mhz), .rst(~rst_n), .outclk_0(clk), .locked(pll_lock) );
//`else
//	assign clk = clk_50Mhz;
//	assign pll_lock = 1'b1;
//`endif

assign clk = clk_50Mhz;
assign pll_lock = 1'b1;


//***********************FETCH***********************//
if_data_bus if_id_data_bus;
if_data_bus if_id_data_bus_next;

//PC
ffd_param_pc_risk #(.LENGTH(32)) ff_pc (
	.i_clk(clk), 
	.i_rst_n(rst_n), 
	.i_en(~stalling),
	.pll_lock(pll_lock), //start the program when PLL is lock
	.d(pc_next),
	.q(pc_out)
);

assign if_id_data_bus.pc = pc_out;

adder #(.LENGTH(32)) adder_pc_4 (
	.i_a(32'h4),
	.i_b(pc_out),
	.q(pc_plus_4)
);

assign if_id_data_bus.pc_plus_4 = pc_plus_4;

//Memory ROM
instr_memory #(.DATA_WIDTH(32), .ADDR_WIDTH(6)) memory_rom (
	.address(pc_out),
	.rd(if_id_data_bus.instr),
	.clk(clk),
	.we(1'b0) //RO memory
);

//***********************FETCH -> DECODE***********************//


ffd_param_clear #(.LENGTH(96)) ffd_fetch_decode (
	.i_clk(clk),
	.i_rst_n(rst_n),
	.i_en(~stalling),
	.i_clear(if_id_flush_jmp | if_id_flush_branch),
	.d(if_id_data_bus),
	//outputs
	.q(if_id_data_bus_next)
);
//****************************** *******************************//
//****************************** DECODE *******************************//
id_ex_control_bus id_ex_control_bus_prev;
id_ex_control_bus id_ex_control_bus_next;
id_data_bus id_ex_data_bus_prev;
id_data_bus id_ex_data_bus_next;


adder #(.LENGTH(32)) adder_pc_branch (
	.i_a(if_id_data_bus_next.pc_plus_4),
	.i_b(sign_extend_out<<2),
	.q(pc_branch)
);

//PC multiplexor
multiplexor_param #(.LENGTH(32)) mux_branch_pc (
	.i_a(pc_plus_4),
	.i_b(pc_branch),
	.i_selector(pc_src),
	.out(branch_pc_out)
);

assign instr_shift_2 = if_id_data_bus_next.instr[25:0]<<2;
//PC multiplexor
multiplexor_param #(.LENGTH(32)) mux_jump_pc (
	.i_a(branch_pc_out),
	.i_b({if_id_data_bus_next.pc[31:28],instr_shift_2}),
	.i_selector(jump),
	.out(pc_next)
);

is_equal #(.LENGTH(32)) is_equal_module(
	.i_a(id_ex_data_bus_prev.rd1),
    .i_b(id_ex_data_bus_prev.rd2),
	.o_c(is_equal_output)
);

assign pc_src = is_equal_output & beq;


//Sign Extend
assign sign_extend_out = {{16{if_id_data_bus_next.instr[15]}},if_id_data_bus_next.instr[15:0]};

assign id_ex_data_bus_prev.sign_extend = sign_extend_out;
assign id_ex_data_bus_prev.opcode = if_id_data_bus_next.instr[5:0];

multiplexor_param #(.LENGTH(5)) mult_write_register (
	.i_a(mem_wb_data_bus_next.instr[20:16]),
	.i_b(mem_wb_data_bus_next.instr[15:11]),
	.i_selector(mem_wb_control_bus_next.RegDst),
	.out(rd_first_mux_out)
);


multiplexor_param #(.LENGTH(5)) mux_mult_write_rf (
	.i_a(rd_first_mux_out),
	.i_b(pipe_mult_result.mult_rd),
	.i_selector(pipe_mult_result.mult_ready),
	.out(write_register_out)
);

//Register file
register_file reg_file (
	.clk(clk),
	.we3(mem_wb_control_bus_next.regWrite | pipe_mult_result.mult_ready),
	.a1(if_id_data_bus_next.instr[25:21]),
	.a2(if_id_data_bus_next.instr[20:16]),
	.a3(write_register_out),
	.wd3(wd3_wire),
	.rd1(rf_rd1),
	.rd2(rf_rd2)
);

double_multiplexor_param #(.LENGTH(32)) mux_rd1 (
	.i_a(rf_rd1),
	.i_b(wd3_wire),
	.i_c(ex_mem_data_bus_next.alu_result),
	.i_selector(rd1_sel),
	.out(id_ex_data_bus_prev.rd1)
);

double_multiplexor_param #(.LENGTH(32)) mux_rd2 (
	.i_a(rf_rd2),
	.i_b(wd3_wire),
	.i_c(ex_mem_data_bus_next.alu_result),
	.i_selector(rd2_sel),
	.out(id_ex_data_bus_prev.rd2)
);


assign id_ex_data_bus_prev.instr = if_id_data_bus_next.instr;

control_unit cu (
	.opcode(if_id_data_bus_next.instr[31:26]),
	.func(if_id_data_bus_next.instr[5:0]),
	.ALUSrcB(id_ex_control_bus_prev.ALUSrcB),
	.ALUOP(id_ex_control_bus_prev.ALUOp),
	.MemWrite(id_ex_control_bus_prev.MemWrite),
	.MemRead(id_ex_control_bus_prev.MemRead),
	.RegWrite(id_ex_control_bus_prev.regWrite),
	.MemtoReg(id_ex_control_bus_prev.mem2Reg),
	.jump(jump),
	.RegDst(id_ex_control_bus_prev.RegDst),
	.BEQ(beq)
);

rf_forward_unit rf_fwd_unit(
	.i_clk(clk),
	.i_rst_n(rst_n),
    .id_rs(if_id_data_bus_next.instr[25:21]),
    .id_rt(if_id_data_bus_next.instr[20:16]),
	.wb_opcode(mem_wb_data_bus_next.instr[31:26]),
    .wb_rd(mem_wb_data_bus_next.instr[15:11]),
	.wb_rt(mem_wb_data_bus_next.instr[20:16]),
    .wb_reg_write(mem_wb_control_bus_next.regWrite),
	.mem_opcode(ex_mem_data_bus_next.instr[31:26]),
	.mem_rd(ex_mem_data_bus_next.instr[15:11]),
    .mem_rt(ex_mem_data_bus_next.instr[20:16]),
    .mem_reg_write(ex_mem_control_bus_next.regWrite),
	.ex_opcode(id_ex_data_bus_next.instr[31:26]),
	.ex_funct(id_ex_data_bus_next.instr[5:0]),
	.ex_rd(id_ex_data_bus_next.instr[15:11]),
    .ex_rt(id_ex_data_bus_next.instr[20:16]),
    .ex_reg_write(id_ex_control_bus_next.regWrite),
	.mult_ready(pipe_mult_result.mult_ready),
	.mult_rd(pipe_mult_result.mult_rd),
    .rd1_sel(rd1_sel),
    .rd2_sel(rd2_sel),
	.stalling(stalling_fw_fwd_unit)
);

hazard_detection_unit hazard_unit(
	.i_clk(clk),
	.i_rst_n(rst_n),
	.id_ex_memread(id_ex_control_bus_next.MemRead),
    .id_ex_rt(id_ex_data_bus_next.instr[20:16]),
    .if_id_rs(if_id_data_bus_next.instr[25:21]),
    .if_id_rt(if_id_data_bus_next.instr[20:16]),
	.if_id_memwrite(id_ex_control_bus_prev.MemWrite),
    //.branch_taken(),
    .stalling(stalling_hazard_unit)
);


multiplexor_param #(.LENGTH(170)) id_ex_stall_mux (
	.i_a({id_ex_control_bus_prev,id_ex_data_bus_prev}),
	.i_b(170'h0),
	.i_selector(stalling),
	.out(id_ex_stall_mux_output)
);

assign stalling = stalling_fw_fwd_unit | stalling_hazard_unit;

jump_detection_unit jmp_detect(
    .opcode(if_id_data_bus_next.instr[31:26]),
    .funct(if_id_data_bus_next.instr[5:0]),
	.stalling(stalling_fw_fwd_unit),
    .flush(if_id_flush_jmp)
);

branch_control_unit branch_detect(
    .opcode(if_id_data_bus_next.instr[31:26]),
    .PCSrc(pc_src),
	.stalling(stalling_fw_fwd_unit),
    .flush(if_id_flush_branch)
);

//****************************** DECODE->EXECUTE *******************************//
ffd_param_clear #(.LENGTH(170)) ffd_decode_execute (
	.i_clk(clk),
	.i_rst_n(rst_n),
	.i_en(1'b1),
	.i_clear(1'b0),
	.d(id_ex_stall_mux_output),
	//outputs
	.q({id_ex_control_bus_next,id_ex_data_bus_next})
);
//****************************** *******************************//
//****************************** EXECUTE *******************************//
ex_mem_control_bus ex_mem_control_bus_prev;
ex_mem_control_bus ex_mem_control_bus_next;
ex_data_bus ex_mem_data_bus_prev;
ex_data_bus ex_mem_data_bus_next;

ALU_control alu_ctrl(
    //inputs
	.i_opcode(id_ex_data_bus_next.opcode),
	.i_aluop(id_ex_control_bus_next.ALUOp),
	 //outputs
    .o_alu_operation(alu_operation)
);

multiplexor_param #(.LENGTH(32)) mult_alu_srcB (
	.i_a(id_ex_data_bus_next.rd2),
	.i_b(id_ex_data_bus_next.sign_extend),
	.i_selector(id_ex_control_bus_next.ALUSrcB),
	.out(rd2_data)
);


assign ex_mem_data_bus_prev.rd2 = id_ex_data_bus_next.rd2;
assign ex_mem_control_bus_prev.MemRead = id_ex_control_bus_next.MemRead;
assign ex_mem_control_bus_prev.MemWrite = id_ex_control_bus_next.MemWrite;
assign ex_mem_control_bus_prev.mem2Reg = id_ex_control_bus_next.mem2Reg;
assign ex_mem_control_bus_prev.regWrite = id_ex_control_bus_next.regWrite;
assign ex_mem_control_bus_prev.RegDst = id_ex_control_bus_next.RegDst;
assign ex_mem_data_bus_prev.instr = id_ex_data_bus_next.instr;


ALU #(.LENGTH(32)) alu_block (
	.i_a(id_ex_data_bus_next.rd1),
	.i_b(rd2_data),
	.i_control(alu_operation),
	.o_alu_zero(alu_zero),
	.alu_result(ex_mem_data_bus_prev.alu_result)
);

pipeline_multiplier_top pipe_mult(
    .i_clk(clk),
    .i_rst_n(rst_n),
    .i_opcode(id_ex_data_bus_next.instr[31:26]),
    .i_funct(id_ex_data_bus_next.instr[5:0]),
    .i_a(id_ex_data_bus_next.rd1),
    .i_b(rd2_data),
	.i_instr_rd(id_ex_data_bus_next.instr[15:11]),
	.o_mult_detected(mult_detected),
    .o_result(pipe_mult_result.mult_result),
	.o_ready(pipe_mult_result.mult_ready),
	.o_rd(pipe_mult_result.mult_rd)

);

multiplexor_param #(.LENGTH(170)) ex_mem_stall_mux (
	.i_a({ex_mem_control_bus_prev,ex_mem_data_bus_prev}),
	.i_b(170'h0),
	.i_selector(mult_detected),
	.out(ex_mem_stall_mux_output)
);

//****************************** *******************************//
//****************************** EXECUTE->MEM *******************************//
ffd_param_clear #(.LENGTH(170)) ffd_execute_mem (
	.i_clk(clk),
	.i_rst_n(rst_n),
	.i_en(1'b1),
	.i_clear(1'b0),
	.d(ex_mem_stall_mux_output),
	//outputs
	.q({ex_mem_control_bus_next,ex_mem_data_bus_next})
);
//****************************** *******************************//
//****************************** MEM *******************************//
mem_wb_control_bus mem_wb_control_bus_prev;
mem_wb_control_bus mem_wb_control_bus_next;
mem_data_bus mem_wb_data_bus_prev;
mem_data_bus mem_wb_data_bus_next;

assign mem_wb_control_bus_prev.RegDst = ex_mem_control_bus_next.RegDst;
assign mem_wb_data_bus_prev.instr = ex_mem_data_bus_next.instr;

multiplexor_param #(.LENGTH(32)) mult_mem_sel (
	.i_a(ex_mem_data_bus_next.rd2),
	.i_b(mem_wb_data_bus_next.memory_out),
	.i_selector(mem_mux_sel),
	.out(mem_data_write)
);

//Memory map
master_memory_map #(.DATA_WIDTH(32), .ADDR_WIDTH(7)) memory_map (
	//CORES <--> Memory map
	.wd(mem_data_write),
	.address(ex_mem_data_bus_next.alu_result),
	.we(ex_mem_control_bus_next.MemWrite),
	.re(ex_mem_control_bus_next.MemRead),
	.clk(clk),
	.rd(mem_wb_data_bus_prev.memory_out),
	//Memory_map <--> Slaves
	.map_Data(data_memory_2_slave),
	.map_Address(address_memory_2_slave),
	//Memory_map <--> RAM
	.HRData1(data_return_ram),
	.WSel_1(we_memory_2_ram),
	.HSel_1(re_memory_2_ram),
	//Memory_map <--> UART
	.HRData2(data_return_uart),
	.WSel_2(we_memory_2_uart),
	.HSel_2(re_memory_2_uart)
);

//Memory RAM
data_memory #(.DATA_WIDTH(32), .ADDR_WIDTH(7)) memory_ram (
	.wd(data_memory_2_slave),
	.address(address_memory_2_slave),
	.we(we_memory_2_ram),
	.re(re_memory_2_ram),
	.clk(clk),
	.rd(data_return_ram)
);

//UART
uart_IP #(.DATA_WIDTH(32)) uart_IP_module (
	.wd(data_memory_2_slave),
	.address(address_memory_2_slave),
	.we(we_memory_2_uart),
	.rst_n(rst_n),
	.clk(clk),
	.rd(data_return_uart),
	.rx(rx),
	.tx(tx)
);


mem_fwd_unit mem_forward_unit(
    .ex_mem_write(ex_mem_control_bus_next.MemWrite),
    .wb_mem_read(mem_wb_control_bus_next.MemRead),
    .wb_rt(mem_wb_data_bus_next.instr[20:16]),
    .ex_rt(ex_mem_data_bus_next.instr[20:16]),
    .mem_mux_sel(mem_mux_sel)
);


assign mem_wb_data_bus_prev.alu_result = ex_mem_data_bus_next.alu_result;

assign mem_wb_control_bus_prev.MemRead = ex_mem_control_bus_next.MemRead;
assign mem_wb_control_bus_prev.MemWrite = ex_mem_control_bus_next.MemWrite;
assign mem_wb_control_bus_prev.mem2Reg = ex_mem_control_bus_next.mem2Reg;
assign mem_wb_control_bus_prev.regWrite = ex_mem_control_bus_next.regWrite;

//****************************** *******************************//
//****************************** MEM->WB *******************************//

ffd_param_clear #(.LENGTH(101)) ffd_mem_wb (
	.i_clk(clk),
	.i_rst_n(rst_n),
	.i_en(1'b1),
	.i_clear(1'b0),
	.d({mem_wb_control_bus_prev,mem_wb_data_bus_prev}),
	//outputs
	.q({mem_wb_control_bus_next,mem_wb_data_bus_next})
);

//****************************** *******************************//
//****************************** WB *******************************//

multiplexor_param #(.LENGTH(32)) mult_alu_param (
	.i_a(mem_wb_data_bus_next.alu_result),
	.i_b(mem_wb_data_bus_next.memory_out),
	.i_selector(mem_wb_control_bus_next.mem2Reg),
	.out(wb_mult_org_pipe_out)
);


multiplexor_param #(.LENGTH(32)) mux_mult_alu (
	.i_a(wb_mult_org_pipe_out),
	.i_b(pipe_mult_result.mult_result),
	.i_selector(pipe_mult_result.mult_ready),
	.out(wd3_wire)
);


endmodule