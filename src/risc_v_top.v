// Coder:           Eduardo Ethandrake Castillo
// Date:            March 7th, 2023

// Description:		Main module for RISCV project

module risc_v_top(
	//Inputs - Platform
	input clk,
	input rst_n,
	//Input - RX
	input rx,
	//Output - Tx
	output tx
);


//Wires to interconnect modules
wire pc_write, iorD, MemWrite, irWrite, pc_src;
wire [1:0] mem2Reg,alu_SrcA;
wire regWrite, go_n_halt_mips;
wire [31:0] pc_prim, pc_out, alu_out, adr, rd1_data, rd2_data,pc_prime;
wire [31:0] memory_out, instr2perf, data2write, wd3_wire, mem_data_out, imm_gen_out; 
wire [31:0] rd1_ff, rd2_ff, SrcA, SrcB, alu_result;
wire [4:0] a3_wire;
wire [1:0] alu_SrcB;
wire [2:0] alu_control;
wire[3:0] alu_operation;
wire [31:0] data_memory_2_slave, address_memory_2_slave, data_return_rom, data_return_ram, data_return_uart;
wire we_memory_2_rom, re_memory_2_rom, we_memory_2_ram, re_memory_2_ram, we_memory_2_uart, re_memory_2_uart;

wire PCEnable;
wire PCWriteCond;
wire bne;
wire alu_zero;
wire MemRead;
wire alu_zero_bne;
wire [1:0] cs;
wire [31:0] decoded_address,ram_rom_data, gpio_data;
wire mem_select;
///////////////////////FETCH//////////////////////////////////////////////

assign PCEnable = (pc_write | (PCWriteCond & alu_zero_bne));

//Multiplexor to select between ZERO & NOT ZERO FOR BRANCHES
multiplexor_param #(.LENGTH(1)) mult_branch (
	.i_a(alu_zero),
	.i_b(~alu_zero),
	.i_selector(bne),
	.out(alu_zero_bne)
);

//PC
ffd_param_pc_risk #(.LENGTH(32)) ff_pc (
	.i_clk(clk), 
	.i_rst_n(rst_n), 
	.i_en(PCEnable),
	.d(pc_prim),
	.q(pc_out)
);

//PC
ffd_param_pc_risk #(.LENGTH(32)) ff_pc_prime (
	.i_clk(clk), 
	.i_rst_n(rst_n), 
	.i_en(PCEnable),
	.d(pc_out),
	.q(pc_prime)
);

//Multiplexor to select between PC and ALU_OUT
multiplexor_param #(.LENGTH(32)) mult_pc_memory (
	.i_a(pc_out),
	.i_b(alu_out),
	.i_selector(iorD),
	.out(adr)
);

//Memory map
master_memory_map #(.DATA_WIDTH(32), .ADDR_WIDTH(7)) memory_map (
	//CORES <--> Memory map
	.wd(rd2_ff),
	.address(adr),
	.we(MemWrite),
	.re(MemRead),
	.clk(clk),
	.rd(memory_out),
	//Memory_map <--> Slaves
	.map_Data(data_memory_2_slave),
	.map_Address(address_memory_2_slave),
	//Memory_map <--> ROM
	.HRData1(data_return_rom),
	.WSel_1(we_memory_2_rom),
	.HSel_1(re_memory_2_rom),
	//Memory_map <--> RAM
	.HRData2(data_return_ram),
	.WSel_2(we_memory_2_ram),
	.HSel_2(re_memory_2_ram),
	//Memory_map <--> UART
	.HRData3(data_return_uart),
	.WSel_3(we_memory_2_uart),
	.HSel_3(re_memory_2_uart)
);

//Memory ROM
instr_memory #(.DATA_WIDTH(32), .ADDR_WIDTH(6)) memory_rom (
	.wd(data_memory_2_slave),
	.address(address_memory_2_slave),
	.we(we_memory_2_rom),
	.re(re_memory_2_rom),
	.clk(clk),
	.rd(data_return_rom)
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


///////////////////////DECODE/////////////////////////////////////////////
//FF instructions
ffd_param #(.LENGTH(32)) ff_instr (
	.i_clk(clk), 
	.i_rst_n(rst_n), 
	.i_en(irWrite),
	.d(memory_out),
	.q(instr2perf)
);
//Memory data register
ffd_param #(.LENGTH(32)) ff_mem_data (
	.i_clk(clk), 
	.i_rst_n(rst_n), 
	.i_en(1'b1),
	.d(memory_out),
	.q(mem_data_out)
);

//IMMEDIATE GENERATOR
imm_gen immediate_gen(
	.i_instruction(instr2perf),
	.o_immediate(imm_gen_out)
);

//Multiplexor to select Register file write data
double_multiplexor_param #(.LENGTH(32)) mult_write_Data (
	.i_a(alu_out),
	.i_b(mem_data_out),
	.i_c(pc_out),
	.i_d(imm_gen_out),
	.i_selector(mem2Reg),
	.out(wd3_wire)
);

///////////////////////EXECUTE////////////////////////////////////////////
//Register file
register_file reg_file (
	.clk(clk),
	.we3(regWrite),
	.a1(instr2perf[19:15]),
	.a2(instr2perf[24:20]),
	.a3(instr2perf[11:7]),
	.wd3(wd3_wire),
	.rd1(rd1_data),
	.rd2(rd2_data)
);

//FF to save RD1 (A)
ffd_param #(.LENGTH(32)) ff_rd1 (
	.i_clk(clk), 
	.i_rst_n(rst_n), 
	.i_en(1'b1),
	.d(rd1_data),
	.q(rd1_ff)
);

//Multiple multiplexor to select pc or rd1 or pcprime (A)
double_multiplexor_param #(.LENGTH(32)) double_mult_A (
	.i_a(pc_out),
	.i_b(rd1_ff),
	.i_c(pc_prime),
	.i_d(32'b0),
	.i_selector(alu_SrcA),
	.out(SrcA)
);

//FF to save RD2 (B)
ffd_param #(.LENGTH(32)) ff_rd2 (
	.i_clk(clk), 
	.i_rst_n(rst_n), 
	.i_en(1'b1),
	.d(rd2_data),
	.q(rd2_ff)
);

//Multiple multiplexor
double_multiplexor_param #(.LENGTH(32)) double_mult_B (
	.i_a(rd2_ff),
	.i_b(32'd4),
	.i_c(imm_gen_out),
	.i_d(32'b0),
	.i_selector(alu_SrcB),
	.out(SrcB)
);

ALU_control alu_ctrl(
    //inputs
	.i_opcode(instr2perf[6:0]),
	.i_funct7(instr2perf[31:25]),
	.i_funct3(instr2perf[14:12]),
	.i_aluop(alu_control),
	 //outputs
    .o_alu_operation(alu_operation)
);


//ALU
ALU #(.LENGTH(32)) alu_block (
	.i_a(SrcA),
	.i_b(SrcB),
	.i_control(alu_operation),
	.o_alu_zero(alu_zero),
	.alu_result(alu_result)
);

///////////////////////MEM////////////////////////////////////////////////
///////////////////////WB/////////////////////////////////////////////////


//FF to save alu_result (ALUOut)
ffd_param #(.LENGTH(32)) ff_alu_result (
	.i_clk(clk), 
	.i_rst_n(rst_n), 
	.i_en(1'b1),
	.d(alu_result),
	.q(alu_out)
);

//Multiplexor to select alu_result or alu_out
multiplexor_param #(.LENGTH(32)) mult_alu (
	.i_a(alu_result),
	.i_b(alu_out),
	.i_selector(pc_src),
	.out(pc_prim)
);


/////////////////////////////CONTROL PATH/////////////////////////////////////
//Control unit
control_unit cu (
	.clk(clk),
	.rst_n(rst_n),
	.opcode(instr2perf[6:0]),
	.func3(instr2perf[14:12]),
	.IorD(iorD),
	.ALUSrcA(alu_SrcA),
	.ALUSrcB(alu_SrcB),
	.PCSrc(pc_src),
	.ALUOp(alu_control),
	.IRWrite(irWrite),
	.MemWrite(MemWrite),
	.MemRead(MemRead),
	.PCWrite(pc_write),
	.RegWrite(regWrite),
	.MemtoReg(mem2Reg),
	.PCWriteCond(PCWriteCond),
	.BNE(bne)
);

endmodule