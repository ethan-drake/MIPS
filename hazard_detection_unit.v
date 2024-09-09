// Coder:           David Adrian Michel Torres, Eduardo Ethandrake Castillo Pulido
// Date:            03/05/23
// File:			     hazard_detection_unit.v
// Module name:	  hazard_detection_unit
// Project Name:	  risc_v_top
// Description:	  This is the hazard detection unit located in ID stage

module hazard_detection_unit (
    input id_ex_memread,
    input [4:0] id_ex_rt,
    input [4:0] if_id_rs1,
    input [4:0] if_id_rs2,
    input branch_taken,
    output reg pc_stall,
    output reg if_id_stall,
    output reg stall_mux
);

always@(*) begin
    pc_stall=1'b0;
    if_id_stall=1'b0;
    stall_mux=1'b0;
    //if((~branch_taken) && (id_ex_memread && ((id_ex_rt == if_id_rs1) || (id_ex_rt == if_id_rs2))))
    if(id_ex_memread && ((id_ex_rt == if_id_rs1) || (id_ex_rt == if_id_rs2)))
    begin
        pc_stall=1'b1;
        if_id_stall=1'b1;
        stall_mux=1'b1;
    end

end

endmodule