// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            16/03/23
// File:			     ALU.v
// Module name:	  ALU
// Project Name:	  risc_v_top
// Description:	  ALU logic

module ALU #(parameter LENGTH=32) (
    //inputs
	input [LENGTH-1:0] i_a,
    input [LENGTH-1:0] i_b,
    input [3:0] i_control,
	//outputs
	output o_alu_zero,
    output [LENGTH-1:0] alu_result
);


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

reg [LENGTH-1:0] temp_result;

always@(*) begin
	temp_result= {LENGTH-1{1'b0}};
	case(i_control)
		4'h0 : //Add operation 
			begin
				temp_result= i_a + i_b;
			end
		4'h1 : //Substract operation 
			begin
				temp_result= i_a + (~i_b + 1'b1);
			end
		4'h2 : //Mult operation 
			begin
				temp_result= i_a * i_b;
			end
		4'h3 : //shift left 
			begin
				temp_result= i_a << i_b;
			end
		4'h4 : //set less than
			begin
				temp_result = (i_a < i_b) ? {{LENGTH-2{1'b0}},1'b1} : {LENGTH-1{1'b0}};
			end
		4'h5 : //xor
			begin
				temp_result= i_a ^ i_b;
			end
		4'h6 : //shift right
			begin
				temp_result= i_a >> i_b;
			end
		4'h7 : //or
			begin
				temp_result= i_a | i_b;
			end
		4'h8: //and
			begin
				temp_result= i_a & i_b;
			end
		4'h9: //shift left imm
			begin
				temp_result= i_a << i_b[4:0];
			end
		4'hA: //shift right imm
			begin
				temp_result= i_a >> i_b[4:0];
			end
		default: temp_result= 0; //Not specified which is the default value
	endcase
end

assign o_alu_zero = (temp_result == {(LENGTH-1){1'b0}}) ? 1'b1 : 1'b0;
assign alu_result = temp_result;


endmodule