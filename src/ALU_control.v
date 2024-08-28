// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            16/03/23
// File:			     ALU_control.v
// Module name:	  ALU_control
// Project Name:	  risc_v_top
// Description:	  ALU control module

module ALU_control (
    //inputs
	input [5:0] i_opcode,
	input [3:0] i_aluop,
	 //outputs
    output reg [3:0] o_alu_operation
);

parameter ADD = 6'h20;
parameter SUB = 6'h22;
parameter SLL = 6'h00;
parameter SLT = 6'h2A;
parameter SRL = 6'h02;
parameter OR  = 6'h25;
parameter AND = 6'h24;

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
//load upper imm B

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
				ADD:
					begin
						o_alu_operation = 4'h0;
					end
				SUB:
					begin
						o_alu_operation = 4'h1;
					end
				SLL:
					begin
						o_alu_operation = 4'h3;
					end
				SLT:
					begin
						o_alu_operation = 4'h4;
					end
				SRL:
					begin
						o_alu_operation = 4'h6;
					end
				OR:
					begin
						o_alu_operation = 4'h7;
					end
				AND:
					begin
						o_alu_operation = 4'h8;
					end
			endcase
		3'h3 : //And operation 
			begin
				o_alu_operation = 4'h8;
			end
		3'h4: //Or operation 
			begin
				o_alu_operation = 4'h7;
			end
		3'h5: //LUI operation
			begin
				o_alu_operation = 4'hB;
			end
		default: 
			begin
				o_alu_operation = 4'h0; 
			end
	endcase
end

endmodule