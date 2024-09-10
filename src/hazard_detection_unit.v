// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            03/05/23
// File:			     hazard_detection_unit.v
// Module name:	  hazard_detection_unit
// Project Name:	  risc_v_top
// Description:	  This is the hazard detection unit located in ID stage

module hazard_detection_unit (
    input i_clk,
    input i_rst_n,
    input id_ex_memread,
    input [4:0] id_ex_rt,
    input [4:0] if_id_rs,
    input [4:0] if_id_rt,
    input if_id_memwrite,
    input branch_taken,
    //output reg pc_stall,
    //output reg if_id_stall,
    //output reg stall_mux
    output reg stalling
);

reg stalling_n;
wire stalling_n1;

always@(*) begin
    //pc_stall=1'b0;
    //if_id_stall=1'b0;
    //stall_mux=1'b0;
    //if((~branch_taken) && (id_ex_memread && ((id_ex_rt == if_id_rs1) || (id_ex_rt == if_id_rs2))))
    stalling_n = 1'b0;
    if(id_ex_memread && (if_id_memwrite != 1) && ((id_ex_rt == if_id_rs) || (id_ex_rt == if_id_rt)))
    begin
        //pc_stall=1'b1;
        //if_id_stall=1'b1;
        //stall_mux=1'b1;
        stalling_n = 1'b1;
    end
    stalling = stalling_n | stalling_n1;
end

ffd_param #(.LENGTH(1)) ffd_stall(
	//inputs
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_en(1'b1),
	.d(stalling_n),
	//outputs
	.q(stalling_n1)
);



endmodule