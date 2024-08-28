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
wire ALUSrcB, ALUSrcA, MemWrite, pc_src, jump, regWrite, clk, pll_lock, RegDst, mem2Reg;
wire [31:0] instr_shift_2, pc_out, rd1_data_reg, rd2_data, rd2_data_reg, pc_next, pc_plus_4, pc_target,pc_branch,branch_pc_out;
wire [31:0] memory_out, instr2perf, wd3_wire, sign_extend_out, write_register_out; 
wire [31:0] SrcA, SrcB, alu_result, pc_jal;
wire [3:0] alu_control;
wire[3:0] alu_operation;
wire [31:0] data_memory_2_slave, address_memory_2_slave, data_return_rom, data_return_ram, data_return_uart;
wire we_memory_2_rom, re_memory_2_rom, we_memory_2_ram, re_memory_2_ram, we_memory_2_uart, re_memory_2_uart;
wire PCWriteCond;
wire beq;
wire alu_zero;
wire MemRead;
wire alu_zero_bne;
wire [1:0] cs;
wire [31:0] decoded_address,ram_rom_data, gpio_data;
wire mem_select;
///////////////////////FETCH//////////////////////////////////////////////


//`define SIMULATION
//`ifndef SIMULATION
//	pll_risc_v PLL_RISCV ( .refclk(clk_50Mhz), .rst(~rst_n), .outclk_0(clk), .locked(pll_lock) );
//`else
//	assign clk = clk_50Mhz;
//	assign pll_lock = 1'b1;
//`endif

assign clk = clk_50Mhz;
assign pll_lock = 1'b1;


adder #(.LENGTH(32)) adder_pc_branch (
	.i_a(pc_plus_4),
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

assign instr_shift_2 = instr2perf[25:0]<<2;
//PC multiplexor
multiplexor_param #(.LENGTH(32)) mux_jump_pc (
	.i_a(branch_pc_out),
	.i_b({pc_out[31:28],instr_shift_2}),
	.i_selector(jump),
	.out(pc_next)
);

//PC
ffd_param_pc_risk #(.LENGTH(32)) ff_pc (
	.i_clk(clk), 
	.i_rst_n(rst_n), 
	.i_en(1'b1),
	.pll_lock(pll_lock), //start the program when PLL is lock
	.d(pc_next),
	.q(pc_out)
);


adder #(.LENGTH(32)) adder_pc_4 (
	.i_a(32'h4),
	.i_b(pc_out),
	.q(pc_plus_4)
);


//Memory ROM
instr_memory #(.DATA_WIDTH(32), .ADDR_WIDTH(6)) memory_rom (
	.address(pc_out),
	.rd(instr2perf),
	.clk(clk),
	.we(1'b0) //RO memory
);

//Sign Extend
assign sign_extend_out = {{16{instr2perf[15]}},instr2perf[15:0]};


multiplexor_param #(.LENGTH(5)) mult_write_register (
	.i_a(instr2perf[20:16]),
	.i_b(instr2perf[15:11]),
	.i_selector(RegDst),
	.out(write_register_out)
);

//Register file
register_file reg_file (
	.clk(clk),
	.we3(regWrite),
	.a1(instr2perf[25:21]),
	.a2(instr2perf[20:16]),
	.a3(write_register_out),
	.wd3(wd3_wire),
	.rd1(rd1_data_reg),
	.rd2(rd2_data_reg)
);

ALU_control alu_ctrl(
    //inputs
	.i_opcode(instr2perf[5:0]),
	.i_aluop(alu_control),
	 //outputs
    .o_alu_operation(alu_operation)
);

multiplexor_param #(.LENGTH(32)) mult_alu_srcB (
	.i_a(rd2_data_reg),
	.i_b(sign_extend_out),
	.i_selector(ALUSrcB),
	.out(rd2_data)
);


ALU #(.LENGTH(32)) alu_block (
	.i_a(rd1_data_reg),
	.i_b(rd2_data),
	.i_control(alu_operation),
	.o_alu_zero(alu_zero),
	.alu_result(alu_result)
);

assign pc_src = alu_zero & beq;

//Memory map
master_memory_map #(.DATA_WIDTH(32), .ADDR_WIDTH(7)) memory_map (
	//CORES <--> Memory map
	.wd(rd2_data_reg),
	.address(alu_result),
	.we(MemWrite),
	.re(MemRead),
	.clk(clk),
	.rd(memory_out),
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


multiplexor_param #(.LENGTH(32)) mult_alu_param (
	.i_a(alu_result),
	.i_b(memory_out),
	.i_selector(mem2Reg),
	.out(wd3_wire)
);

control_unit cu (
	.opcode(instr2perf[31:26]),
	.func3(instr2perf[5:0]),
	.ALUSrcB(ALUSrcB),
	.ALUOP(alu_control),
	.MemWrite(MemWrite),
	.MemRead(MemRead),
	.RegWrite(regWrite),
	.MemtoReg(mem2Reg),
	.jump(jump),
	.RegDst(RegDst),
	.BEQ(beq)
);

endmodule