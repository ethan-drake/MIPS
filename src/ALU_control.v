// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            16/03/23
// File:			     ALU_control.v
// Module name:	  ALU_control
// Project Name:	  risc_v_top
// Description:	  ALU control module

module ALU_control (
    //inputs
	input [6:0] i_opcode, i_funct7,
	input [2:0] i_funct3, i_aluop,
	 //outputs
    output reg [3:0] o_alu_operation
);

parameter R_TYPE = 7'b0110011;
parameter I_TYPE = 7'b0010011;

//add 0
//subs 1
//mult 2
//shift left 3
//set less than 4
//xor 5
//shift right 6
//or 7
//and 8
//shift left imm 9
//shift right imm A

always@(*) begin
	o_alu_operation = {4'b0};
	case(i_aluop)
		3'h0 : //Add operation 
			begin
				o_alu_operation = 4'h0;
			end
		3'h1 : //Substract operation 
			begin
				o_alu_operation = 4'h1;
			end
		3'h2 : //Operation determined by function
			case(i_opcode)
				R_TYPE:
					begin
						case(i_funct3)
							3'h0:
								begin
									case(i_funct7)
										7'h0:
											o_alu_operation = 4'h0;
										7'h20:
											o_alu_operation = 4'h1;
										7'h1:
											o_alu_operation = 4'h2;
										default: o_alu_operation = {4'b0}; 
									endcase
								end
							3'h1:
								o_alu_operation = 4'h3;
							3'h2,
							3'h3:
								o_alu_operation = 4'h4;
							3'h4:
								o_alu_operation = 4'h5;
							3'h5:
								o_alu_operation = 4'h6;
							3'h6:
								o_alu_operation = 4'h7;
							3'h7:
								o_alu_operation = 4'h8;
							default: o_alu_operation = {4'b0}; 
						endcase
					end
				I_TYPE:
					begin
						case(i_funct3)
							3'h0:
								o_alu_operation = 4'h0;
							3'h1:
								o_alu_operation = 4'h9;
							3'h2,
							3'h3:
								o_alu_operation = 4'h4;
							3'h4:
								o_alu_operation = 4'h5;
							3'h5:
								o_alu_operation = 4'hA;
							3'h6:
								o_alu_operation = 4'h7;
							3'h7:
								o_alu_operation = 4'h8;
							default: o_alu_operation = {4'b0};
						endcase
					end
				default: o_alu_operation = {4'b0}; 
			endcase
			
		default: o_alu_operation = {4'b0}; 
	endcase
end

endmodule