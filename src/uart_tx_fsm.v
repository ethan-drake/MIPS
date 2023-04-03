// Coder:           Eduardo Ethandrake Castillo, David Adrian Michel Torres
// Date:            October 20, 2022
// File:			     uart_tx_fsm.v
// Module name:	  uart_tx_fsm
// Project Name:	  risc_v_top
// Description:	  This is the state machine used for UART TX control

module uart_tx_fsm(
    //inputs
    input i_clk,
    input i_rst_n,
    input i_baud_rate_overflow,
    input i_tx_send,
    input i_bit_counter_overflow,
	 input fin_delay_w,
    //outputs
    output reg o_tx_mux,
    output reg o_tx_control,
    output reg o_tx_reg_enable,
    output reg o_bit_counter_enable,
    output reg o_load_serializer,
    output reg o_clear_bit_counter,
	 output reg reset_delayer,
	 output reg enable_finish_ff,
	 output reg clear_finish_ff
);

reg [2:0] current_state;

localparam [2:0]
IDLE               = 3'h0,
REGISTER_DATA      = 3'h1,
LOAD_SERIALIZER    = 3'h2,
START_TRANSMISSION = 3'h3,
TRANSMIT_DATA      = 3'h4,
STOP_TRANSMISSION  = 3'h5,
DELAY_TRANSMISSION = 3'h6,
CLEAR_FLAGS        = 3'h7;

reg[2:0] next_state/*synthesis keep*/;

//always dedicated to assign current state from next state
always@(posedge i_clk, negedge i_rst_n)
begin
    if(!i_rst_n)
    begin
        current_state <= IDLE;
    end
    else
    begin
        current_state <= next_state;
    end
end

//always dedicated to selecting the next state depending on current state and input flags
always @(*) begin 
	next_state = current_state;
	 case(current_state)
        IDLE:
        begin
            if(i_tx_send)
            begin
                next_state = REGISTER_DATA;
            end
        end
        REGISTER_DATA:
        begin
			next_state = LOAD_SERIALIZER;
        end
        LOAD_SERIALIZER:
        begin
            next_state = START_TRANSMISSION;
        end
        START_TRANSMISSION:
        begin
                if(i_baud_rate_overflow)
                begin
                    next_state = TRANSMIT_DATA;
                end			
		  end
        TRANSMIT_DATA:
        begin
            if(i_bit_counter_overflow)
            begin
                next_state = STOP_TRANSMISSION;
            end
        end
        STOP_TRANSMISSION:
        begin
            next_state = DELAY_TRANSMISSION;
        end
		  DELAY_TRANSMISSION:
		  begin
					if(fin_delay_w)
					begin
						next_state = CLEAR_FLAGS;
					end
		  end
		  CLEAR_FLAGS:
        begin
            next_state = IDLE;
        end
        default:
        begin
            next_state = IDLE;
        end
    endcase
end

//always dedicated to assigning the output flags
always @(current_state)begin
    case(current_state)
        IDLE:
        begin
            o_tx_mux <= 1'b0; 
            o_tx_control <= 1'b1; 
            o_tx_reg_enable <= 1'b0; 
            o_bit_counter_enable <= 1'b0; 
            o_load_serializer <= 1'b0;
            o_clear_bit_counter <= 1'b1;
				reset_delayer <= 1'b0;
				enable_finish_ff <= 1'b1;
				clear_finish_ff <= 1'b0;
        end
        REGISTER_DATA:
        begin
            o_tx_mux <= 1'b0; 
            o_tx_control <= 1'b1; 
            o_tx_reg_enable <= 1'b1; 
            o_bit_counter_enable <= 1'b0; 
            o_load_serializer <= 1'b0;
            o_clear_bit_counter <= 1'b0;
				reset_delayer <= 1'b0;
				enable_finish_ff <= 1'b0;
				clear_finish_ff <= 1'b1;
        end
        LOAD_SERIALIZER:
        begin
            o_tx_mux <= 1'b0; 
            o_tx_control <= 1'b1; 
            o_tx_reg_enable <= 1'b0; 
            o_bit_counter_enable <= 1'b0; 
            o_load_serializer <= 1'b1;
            o_clear_bit_counter <= 1'b0;
				reset_delayer <= 1'b0;
				enable_finish_ff <= 1'b0;
				clear_finish_ff <= 1'b0;
        end
        START_TRANSMISSION:
        begin
            o_tx_mux <= 1'b0; 
            o_tx_control <= 1'b0; 
            o_tx_reg_enable <= 1'b0; 
            o_bit_counter_enable <= 1'b1; 
            o_load_serializer <= 1'b0;
            o_clear_bit_counter <= 1'b0;
				reset_delayer <= 1'b0;
				enable_finish_ff <= 1'b0;
				clear_finish_ff <= 1'b0;
        end
        TRANSMIT_DATA:
        begin
            o_tx_mux <= 1'b1;
            o_tx_control <= 1'b0; 
            o_tx_reg_enable <= 1'b0; 
            o_bit_counter_enable <= 1'b1; 
            o_load_serializer <= 1'b0;
            o_clear_bit_counter <= 1'b0;
				reset_delayer <= 1'b0;
				enable_finish_ff <= 1'b0;
				clear_finish_ff <= 1'b0;
        end
        STOP_TRANSMISSION:
        begin
            o_tx_mux <= 1'b0;
            o_tx_control <= 1'b1;
            o_tx_reg_enable <= 1'b0;
            o_bit_counter_enable <= 1'b0;
            o_load_serializer <= 1'b0;
            o_clear_bit_counter <= 1'b0;
				reset_delayer <= 1'b1;
				enable_finish_ff <= 1'b0;
				clear_finish_ff <= 1'b0;
        end
		  DELAY_TRANSMISSION:
        begin
            o_tx_mux <= 1'b0;
            o_tx_control <= 1'b1;
            o_tx_reg_enable <= 1'b0;
            o_bit_counter_enable <= 1'b0;
            o_load_serializer <= 1'b0;
            o_clear_bit_counter <= 1'b0;
				reset_delayer <= 1'b0;
				enable_finish_ff <= 1'b0;
				clear_finish_ff <= 1'b0;
        end
		  CLEAR_FLAGS:
        begin
            o_tx_mux <= 1'b0;
            o_tx_control <= 1'b1;
            o_tx_reg_enable <= 1'b0;
            o_bit_counter_enable <= 1'b0;
            o_load_serializer <= 1'b0;
            o_clear_bit_counter <= 1'b0;
				reset_delayer <= 1'b0;
				enable_finish_ff <= 1'b0;
				clear_finish_ff <= 1'b0;
        end
        default:
        begin
            o_tx_mux <= 1'b0; 
            o_tx_control <= 1'b1; 
            o_tx_reg_enable <= 1'b0; 
            o_bit_counter_enable <= 1'b0; 
            o_load_serializer <= 1'b0;
            o_clear_bit_counter <= 1'b1;
				reset_delayer <= 1'b0;
				enable_finish_ff <= 1'b0;
				clear_finish_ff <= 1'b0;
        end
    endcase
end

endmodule