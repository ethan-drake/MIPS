// Coder:           David Adrian Michel Torres
// Date:            16/03/23
// File:			     ALU.v
// Module name:	  ALU
// Project Name:	  risk_v_multicycle
// Description:	  ALU logic

module ALU #(parameter LENGTH=32) (
    //inputs
	 input [LENGTH-1:0] i_a,
    input [LENGTH-1:0] i_b,
    input [2:0] aluOp, funct3,
	 input [6:0] funct7, opcode,
	 //outputs
    output reg [LENGTH-1:0] alu_result,
	 output Zero
);

//Evaluate Zero condition
assign Zero = (alu_result == {LENGTH-1{1'b0}}) ? 1'b1 : 1'b0;

//Opcodes
localparam R_TYPE = 7'b0110011;
localparam I_TYPE = 7'b0010011;
localparam B_TYPE = 7'b1100011;
localparam J_TYPE = 7'b1101111;
localparam AUIPC_TYPE = 7'b0010111;

//ALU operation logic
always@(*) begin
	alu_result = {LENGTH-1{1'b0}};
	case(aluOp)
		3'h0: //ALU performs an add operation
			begin
				alu_result = i_a + i_b;
			end
		3'h1: //ALU performs ad substract operation
			begin
				alu_result = i_a + (~i_b + 1'b1);
			end
		3'h2: //Function field determines the ALU operation
			begin
				case(opcode)
					I_TYPE:
						begin
							case(funct3)
								3'h0: alu_result = i_a + i_b;
								3'h1: alu_result = i_a << i_b[4:0];
								3'h2: alu_result = (i_a < i_b) ? {LENGTH-1{1'b1}} : {LENGTH-1{1'b0}};
								3'h3: alu_result = (i_a < i_b) ? {LENGTH-1{1'b1}} : {LENGTH-1{1'b0}}; //Zero-extends
								3'h4: alu_result = i_a ^ i_b;
								3'h5: alu_result = i_a >> i_b[4:0];
								3'h6: alu_result = i_a | i_b;
								3'h7: alu_result = i_a & i_b;
								default: alu_result = {LENGTH-1{1'b0}}; //Shouldn't happen
							endcase
						end
					R_TYPE:
						begin
							case(funct3)
								3'h0:
									begin
										case(funct7)
											7'h0:  alu_result = i_a + i_b;
											7'h1:  alu_result = i_a * i_b;
											7'h20: alu_result = i_a + (~i_b + 1'b1);
											default: alu_result = i_a + i_b; //Default
										endcase
									end
								3'h1: alu_result = i_a << i_b;
								3'h2: alu_result = (i_a < i_b) ? {LENGTH-1{1'b1}} : {LENGTH-1{1'b0}};
								3'h3: alu_result = (i_a < i_b) ? {LENGTH-1{1'b1}} : {LENGTH-1{1'b0}}; //Zero-extends
								3'h4: alu_result = i_a ^ i_b;
								3'h5: alu_result = i_a >> i_b;
								3'h6: alu_result = i_a | i_b;
								3'h7: alu_result = i_a & i_b;
								default: alu_result = {LENGTH-1{1'b0}}; //Shouldn't happen
							endcase
						end
					AUIPC_TYPE:
						begin
							alu_result = (i_a - 3'h4) + i_b; //removing pc+4
						end
					B_TYPE:
						begin
							alu_result = (i_a - 3'h4) + i_b; //removing pc+4
						end
					J_TYPE:
						begin
							alu_result = (i_a - 3'h4) + i_b; //removing pc+4
						end
					default: alu_result = {LENGTH-1{1'b0}}; //Shouldn't happen
				endcase
			end
		default: alu_result = {LENGTH-1{1'b0}}; //Shouldn't happen
	endcase
end

endmodule