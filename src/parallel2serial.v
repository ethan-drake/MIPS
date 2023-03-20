// Coder:           Eduardo Ethandrake Castillo, David Adrian Michel Torres
// Date:            October 20, 2022
// File:			     parallel2serial.v
// Module name:	  parallel2serial
// Project Name:	  risc_v_top
// Description:	  Module that converts parallel2serial that is used in uart_tx

module parallel2serial #(parameter N=9) (
    input i_clk,
    input i_rst_n,
    input i_enable,
    input i_load_serializer,
    input [N-1:0] i_data,
    output reg o_tx_data
);

reg [N-1:0] temp_data;

always @(negedge i_rst_n, posedge i_clk)
    begin
        if (!i_rst_n) begin
            temp_data <= {N{1'b0}};
            o_tx_data <= 1'b0;
        end else begin
            if (i_enable) begin
                temp_data <= {1'b0, temp_data[N-1:1]};
                o_tx_data <= temp_data[0];
            end else if (i_load_serializer) begin
                temp_data <= i_data;
            end
        end
    end
	 
endmodule