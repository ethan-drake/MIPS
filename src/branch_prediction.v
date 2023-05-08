// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            07/05/23
// File:			     branch_prediction.v
// Module name:	  branch_prediction
// Project Name:	  risc_v_top
// Description:	  This is a branch predictor module using one bit

module branch_prediction #(parameter DATA_WIDTH = 32,parameter BRANCH_NO=8)(
    input i_clk,
    input i_rst_n,
    input[6:0] ex_mem_opcode,
    input[6:0] if_id_opcode,
    input ex_mem_branch_taken,
    input[31:0] ex_mem_branch_target,
    input[2:0] if_pc,
    input[2:0] ex_mem_pc,
    output prediction,
    output[31:0] branch_target
);

reg [DATA_WIDTH-1:0] BHB [(BRANCH_NO)-1:0];
reg [BRANCH_NO-1:0] BHT = {BRANCH_NO{1'b0}};
parameter B_TYPE = 7'b1100011;

integer i;
initial begin
	for(i=0;i<(BRANCH_NO);i=i+1)
		BHB[i] <= 32'h0;
end

always @(posedge i_clk)
begin
	//Write
	if (ex_mem_opcode==B_TYPE) begin
		BHT[ex_mem_pc] <= ex_mem_branch_taken;
        BHB[ex_mem_pc] <= ex_mem_branch_target;
    end
end
	
// Reading if memory read enable
assign prediction = (if_id_opcode == B_TYPE) ? BHT[if_pc] : 1'b0;
assign branch_target = (if_id_opcode == B_TYPE) ? BHB[if_pc] : 32'b0;


endmodule