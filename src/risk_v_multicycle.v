// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            16/03/23
// File:			     risk_v_multicycle.v
// Module name:	  risk_v_multicycle
// Project Name:	  risk_v_multicycle
// Description:	  Main project module

module risk_v_multicycle (
	//Inputs - Platform
	input clk,
	input rst_n,
	//Input - RX
	input rx,
	//Output - Tx
	output tx
);

//Wires to interconnect modules
wire pc_write, iorD, MemWrite, MemRead, irWrite, pc_src;
wire alu_SrcA, regWrite, Branch, Branch_NE, Zero, branch_equal, branch_not_equal, pc_enable;
wire [31:0] pc_prim, pc_out, alu_out, adr, rd1_data, rd2_data, ff_pc_save;
wire [31:0] memory_out, instr2perf, wd3_wire, addr_uart, rd_uart; 
wire [31:0] rd1_ff, rd2_ff, SrcA, SrcB, imm_gen, alu_result;
wire [1:0] alu_SrcB, mem2Reg;
wire [2:0] ALUOp;
wire [31:0] data_memory_2_slave, address_memory_2_slave, data_return_rom, data_return_ram, data_return_uart;
wire we_memory_2_rom, re_memory_2_rom, we_memory_2_ram, re_memory_2_ram, we_memory_2_uart, re_memory_2_uart;

//Branch & PC-write logic
assign branch_equal = (Branch & Zero);
assign branch_not_equal = (Branch_NE & ~Zero);
assign pc_enable = (pc_write | branch_equal | branch_not_equal);

//Control unit
control_unit cu (
	.clk(clk),
	.rst(rst_n),
	.opcode(instr2perf[6:0]),
	.IorD(iorD),
	.ALUSrcA(alu_SrcA),
	.ALUSrcB(alu_SrcB),
	.PCSrc(pc_src),
	.IRWrite(irWrite),
	.MemWrite(MemWrite),
	.MemRead(MemRead),
	.ALUOp(ALUOp),
	.PCWrite(pc_write),
	.RegWrite(regWrite),
	.MemtoReg(mem2Reg),
	.Branch(Branch),
	.Branch_NE(Branch_NE),
	.funct3(instr2perf[14:12])
);

//Program counter enable
ffd_param_pc_risk #(.LENGTH(32)) ff_pc (
	.i_clk(clk), 
	.i_rst_n(rst_n), 
	.i_en(pc_enable),
	.d(pc_prim),
	.q(pc_out)
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

//FF instructions
ffd_param #(.LENGTH(32)) ff_instr (
	.i_clk(clk), 
	.i_rst_n(rst_n), 
	.i_en(irWrite),
	.d(memory_out),
	.q(instr2perf)
);

//FF PC saver
ffd_param #(.LENGTH(32)) ff_saver (
	.i_clk(clk), 
	.i_rst_n(rst_n), 
	.i_en(1'b1),
	.d(memory_out),
	.q(ff_pc_save)
);

//Multiple multiplexor to WD3 (Register file)
double_multiplexor_param #(.LENGTH(32)) mult_write_Data (
	.i_a(alu_out),
	.i_b(ff_pc_save),
	.i_c(alu_result),
	.i_d(imm_gen),
	.i_selector(mem2Reg),
	.out(wd3_wire)
);

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

//FF to save RD1
ffd_param #(.LENGTH(32)) ff_rd1 (
	.i_clk(clk), 
	.i_rst_n(rst_n), 
	.i_en(1'b1),
	.d(rd1_data),
	.q(rd1_ff)
);

//FF to save RD2
ffd_param #(.LENGTH(32)) ff_rd2 (
	.i_clk(clk), 
	.i_rst_n(rst_n), 
	.i_en(1'b1),
	.d(rd2_data),
	.q(rd2_ff)
);

//Multiplexor to select pc or rd1
multiplexor_param #(.LENGTH(32)) mult_pc_or_data (
	.i_a(pc_out),
	.i_b(rd1_ff),
	.i_selector(alu_SrcA),
	.out(SrcA)
);

//Multiple multiplexor
double_multiplexor_param #(.LENGTH(32)) srcB_mult (
	.i_a(rd2_ff),
	.i_b(32'h4),
	.i_c(imm_gen),
	.i_d(32'h0),
	.i_selector(alu_SrcB),
	.out(SrcB)
);

//ALU
ALU #(.LENGTH(32)) alu_block (
	.i_a(SrcA),
	.i_b(SrcB),
	.funct3(instr2perf[14:12]),
	.funct7(instr2perf[31:25]),
	.opcode(instr2perf[6:0]),
	.aluOp(ALUOp),
	.alu_result(alu_result),
	.Zero(Zero)
);

//FF to save alu_result
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

//Immediate generator module 
imm_gen_module imm_module (
	.instruction(instr2perf),
	.imm_out(imm_gen)
);

endmodule