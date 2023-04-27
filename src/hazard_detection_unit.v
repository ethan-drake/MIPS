module hazard_detection_unit(
    input id_ex_memread,
    input [4:0] id_ex_rd,
    input [4:0] if_id_rs1,
    input [4:0] if_id_rs2,
    output reg pc_stall,
    output reg if_id_stall,
    output reg stall_mux
);

always@(*) begin
    pc_stall=1'b0;
    if_id_stall=1'b0;
    stall_mux=1'b0;
    if(id_ex_memread && ((id_ex_rd == if_id_rs1) || (id_ex_rd == if_id_rs2)))
    begin
        pc_stall=1'b1;
        if_id_stall=1'b1;
        stall_mux=1'b1;
    end

end






endmodule