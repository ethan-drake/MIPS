// Coder:           Eduardo Ethandrake Castillo Pulido
// Date:            09/09/24
// File:			     pipeline_multiplier_top.v
// Module name:	  pipeline_multiplier_top
// Project Name:	  mips_top
// Description:	  This is the top module for the pipeline multiplier

module pipeline_multiplier_top(
    input i_clk,
    input i_rst_n,
    input [5:0] i_opcode,
    input [5:0] i_funct,
    input [31:0] i_a,
    input [31:0] i_b,
    input [4:0] i_instr_rd,
    output o_mult_detected,
    output [31:0] o_result,
    output o_ready,
    output [4:0] o_rd

);
typedef struct packed {
	logic [31:0] mult_result;
	logic [4:0] mult_rd;
    logic mult_ready;
} mult_bus;

wire [31:0] operand_a;
wire [31:0] operand_b;

mult_bus p1_result;
mult_bus p2_result;
mult_bus p3_result;
mult_bus p4_result;
mult_bus p2_input;
mult_bus p3_input;
mult_bus p4_input;
mult_bus p_result;

wire mult_enable;
wire store_values;

//mips multiplications put in HI/LO registers the value calculated from multiplication
//for this implementation we'll use just the LO register
//after mult_detected we should wait for mflo with the destination register
//(in later implementation could be separated, for now the must  be coded one after the other)

ffd_param_clear #(.LENGTH(32)) mult_a(
	//inputs
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_en(store_values),
	.i_clear(1'b0),
	.d(i_a),
	.q(operand_a)
);
ffd_param_clear #(.LENGTH(32)) mult_b(
	//inputs
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_en(store_values),
	.i_clear(1'b0),
	.d(i_b),
	.q(operand_b)
);

mult_control_unit mult_cu(
    .opcode(i_opcode),
    .funct(i_funct),
    .mult_enable(mult_enable),
    .store_values(store_values)
);


assign o_mult_detected = mult_enable | store_values;

assign p1_result.mult_rd = mult_enable ? i_instr_rd : 5'h0;
assign p1_result.mult_ready = mult_enable;

multiplier mult(
    .i_a(operand_a),
    .i_b(operand_b),
    .i_enable(mult_enable),
    .o_c(p1_result.mult_result)
);

ffd_param_clear #(.LENGTH(32)) p1(
	//inputs
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_en(1'b1),
	.i_clear(1'b0),
	.d(p1_result),
	.q(p2_input)
);

assign p2_result = p2_input;

ffd_param_clear #(.LENGTH(32)) p2(
	//inputs
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_en(1'b1),
	.i_clear(1'b0),
	.d(p2_result),
	.q(p3_input)
);

assign p3_result = p3_input;

ffd_param_clear #(.LENGTH(32)) p3(
	//inputs
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_en(1'b1),
	.i_clear(1'b0),
	.d(p3_result),
	.q(p4_input)
);

assign p4_result = p4_input;

ffd_param_clear #(.LENGTH(32)) p4(
	//inputs
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_en(1'b1),
	.i_clear(1'b0),
	.d(p4_result),
	.q(p_result)
);

assign o_result = p_result.mult_result;
assign o_ready = p_result.mult_ready;
assign o_rd = p_result.mult_rd;

endmodule