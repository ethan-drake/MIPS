/*
###############################################################
#  Generated by:      Cadence Innovus 21.12-s106_1
#  OS:                Linux x86_64(Host ID ip-172-31-46-123.us-east-2.compute.internal)
#  Generated on:      Fri Nov 10 03:32:38 2023
#  Design:            risc_v_Pad_Frame
#  Command:           saveNetlist risc_v_Pad_Frame_netlist
###############################################################
*/
module risc_v_Pad_Frame (
	VDD1, 
	VSS1, 
	VDDIOR1, 
	VSSIOR1, 
	clk, 
	reset_n, 
	rx, 
	tx);
   inout VDD1;
   inout VSS1;
   inout VDDIOR1;
   inout VSSIOR1;
   input clk;
   input reset_n;
   input rx;
   output tx;

   // Internal wires
   wire FE_DBTN0_n_3223;
   wire [205:0] risc_v_top_i_ex_mem_datapath_out;
   wire [63:0] risc_v_top_i_if_id_datapath_out;
   wire [192:0] risc_v_top_i_id_ex_datapath_out;
   wire [31:0] risc_v_top_i_pc_out;
   wire [132:0] risc_v_top_i_mem_wb_datapath_out;
   wire [31:0] \risc_v_top_i_uart_IP_module_uart_val[3] ;
   wire [7:0] risc_v_top_i_uart_IP_module_rx_data;
   wire [31:0] \risc_v_top_i_uart_IP_module_uart_val[4] ;
   wire [31:0] \risc_v_top_i_uart_IP_module_uart_val[5] ;
   wire [31:0] \risc_v_top_i_uart_IP_module_uart_val[7] ;
   wire [12:0] risc_v_top_i_uart_IP_module_UART_full_duplex_rx_uart_BR_pulse_count;
   wire [3:0] risc_v_top_i_uart_IP_module_UART_full_duplex_rx_uart_count_bits_w;
   wire [2:0] risc_v_top_i_uart_IP_module_UART_full_duplex_rx_uart_FSM_Rx_Rx_state;
   wire [8:0] risc_v_top_i_uart_IP_module_UART_full_duplex_rx_uart_Q_SR_w;
   wire [17:0] risc_v_top_i_uart_IP_module_UART_full_duplex_tx_uart_delay_5ms_cuenta;
   wire clk_w;
   wire n_9;
   wire n_10;
   wire n_12;
   wire n_13;
   wire n_14;
   wire n_15;
   wire n_16;
   wire n_17;
   wire n_18;
   wire n_19;
   wire n_20;
   wire n_21;
   wire n_23;
   wire n_24;
   wire n_25;
   wire n_28;
   wire n_29;
   wire n_30;
   wire n_31;
   wire n_32;
   wire n_33;
   wire n_34;
   wire n_35;
   wire n_36;
   wire n_37;
   wire n_38;
   wire n_39;
   wire n_40;
   wire n_115;
   wire n_188;
   wire n_192;
   wire n_1445;
   wire n_1447;
   wire n_1611;
   wire n_1612;
   wire n_1614;
   wire n_3223;
   wire n_3252;
   wire n_3253;
   wire n_3254;
   wire n_3255;
   wire n_3257;
   wire n_3258;
   wire n_3259;
   wire n_3260;
   wire n_3277;
   wire n_3278;
   wire n_3279;
   wire n_3280;
   wire n_3282;
   wire n_3283;
   wire n_3284;
   wire n_3285;
   wire n_3302;
   wire n_3303;
   wire n_3304;
   wire n_3305;
   wire n_3307;
   wire n_3308;
   wire n_3309;
   wire n_3310;
   wire n_3346;
   wire n_3347;
   wire n_3348;
   wire n_3349;
   wire n_3351;
   wire n_3352;
   wire n_3353;
   wire n_3680;
   wire n_3681;
   wire n_3700;
   wire n_3701;
   wire n_3703;
   wire n_4752;
   wire n_4948;
   wire n_4951;
   wire n_5540;
   wire n_6371;
   wire n_6373;
   wire n_8137;
   wire n_8138;
   wire n_8139;
   wire reset_n_w;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_169;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_171;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_173;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_175;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_177;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_179;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_181;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_183;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_185;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_187;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_189;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_191;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_193;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_195;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_200;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_205;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_210;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_215;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_220;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_225;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_230;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_235;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_240;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_245;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_250;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_255;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_260;
   wire risc_v_top_i_adder_pc_4_add_15_16_n_266;
   wire risc_v_top_i_n_100;
   wire risc_v_top_i_n_13240;
   wire risc_v_top_i_n_13241;
   wire risc_v_top_i_n_13242;
   wire risc_v_top_i_n_13243;
   wire risc_v_top_i_n_13244;
   wire risc_v_top_i_n_13245;
   wire risc_v_top_i_n_13246;
   wire risc_v_top_i_n_13247;
   wire risc_v_top_i_n_13248;
   wire risc_v_top_i_n_13249;
   wire risc_v_top_i_n_13250;
   wire risc_v_top_i_n_13251;
   wire risc_v_top_i_n_13252;
   wire risc_v_top_i_n_13253;
   wire risc_v_top_i_n_13254;
   wire risc_v_top_i_n_13255;
   wire risc_v_top_i_n_13256;
   wire risc_v_top_i_n_13257;
   wire risc_v_top_i_n_13258;
   wire risc_v_top_i_n_13259;
   wire risc_v_top_i_n_13260;
   wire risc_v_top_i_n_13261;
   wire risc_v_top_i_n_13262;
   wire risc_v_top_i_n_13263;
   wire risc_v_top_i_n_13264;
   wire risc_v_top_i_n_13265;
   wire risc_v_top_i_n_13266;
   wire risc_v_top_i_n_13267;
   wire risc_v_top_i_n_83485;
   wire risc_v_top_i_n_83486;
   wire risc_v_top_i_n_83488;
   wire risc_v_top_i_n_83489;
   wire risc_v_top_i_n_83490;
   wire risc_v_top_i_n_83491;
   wire risc_v_top_i_n_83492;
   wire risc_v_top_i_n_83493;
   wire risc_v_top_i_n_83494;
   wire risc_v_top_i_n_83496;
   wire risc_v_top_i_n_83501;
   wire risc_v_top_i_n_83503;
   wire risc_v_top_i_n_83505;
   wire risc_v_top_i_n_83507;
   wire risc_v_top_i_n_83508;
   wire risc_v_top_i_n_83514;
   wire risc_v_top_i_n_83515;
   wire risc_v_top_i_n_83516;
   wire risc_v_top_i_n_83517;
   wire risc_v_top_i_n_83518;
   wire risc_v_top_i_n_83549;
   wire risc_v_top_i_n_83550;
   wire risc_v_top_i_n_83551;
   wire risc_v_top_i_n_83554;
   wire risc_v_top_i_n_83555;
   wire risc_v_top_i_n_83556;
   wire risc_v_top_i_n_83557;
   wire risc_v_top_i_n_83558;
   wire risc_v_top_i_n_83559;
   wire risc_v_top_i_n_83560;
   wire risc_v_top_i_n_83561;
   wire risc_v_top_i_n_83562;
   wire risc_v_top_i_n_83569;
   wire risc_v_top_i_n_83577;
   wire risc_v_top_i_n_83607;
   wire risc_v_top_i_n_83624;
   wire risc_v_top_i_n_83628;
   wire risc_v_top_i_n_83631;
   wire risc_v_top_i_n_83636;
   wire risc_v_top_i_n_83642;
   wire risc_v_top_i_n_83643;
   wire risc_v_top_i_n_83644;
   wire risc_v_top_i_n_83648;
   wire risc_v_top_i_n_83649;
   wire risc_v_top_i_n_83650;
   wire risc_v_top_i_n_83700;
   wire risc_v_top_i_n_83701;
   wire risc_v_top_i_n_83704;
   wire risc_v_top_i_n_83705;
   wire risc_v_top_i_n_83708;
   wire risc_v_top_i_n_83709;
   wire risc_v_top_i_n_83710;
   wire risc_v_top_i_n_83711;
   wire risc_v_top_i_n_83712;
   wire risc_v_top_i_n_83713;
   wire risc_v_top_i_n_83714;
   wire risc_v_top_i_n_83715;
   wire risc_v_top_i_n_83716;
   wire risc_v_top_i_n_83717;
   wire risc_v_top_i_n_83718;
   wire risc_v_top_i_n_83719;
   wire risc_v_top_i_n_83720;
   wire risc_v_top_i_n_83722;
   wire risc_v_top_i_n_83723;
   wire risc_v_top_i_n_83724;
   wire risc_v_top_i_n_83726;
   wire risc_v_top_i_n_83730;
   wire risc_v_top_i_n_83732;
   wire risc_v_top_i_n_83733;
   wire risc_v_top_i_n_83755;
   wire risc_v_top_i_n_83757;
   wire risc_v_top_i_n_83762;
   wire risc_v_top_i_n_83774;
   wire risc_v_top_i_n_83775;
   wire risc_v_top_i_n_83777;
   wire risc_v_top_i_n_83780;
   wire risc_v_top_i_n_83783;
   wire risc_v_top_i_n_83784;
   wire risc_v_top_i_n_83786;
   wire risc_v_top_i_n_83789;
   wire risc_v_top_i_n_83792;
   wire risc_v_top_i_n_83795;
   wire risc_v_top_i_n_83796;
   wire risc_v_top_i_n_83798;
   wire risc_v_top_i_n_83801;
   wire risc_v_top_i_n_83802;
   wire risc_v_top_i_n_83804;
   wire risc_v_top_i_n_83805;
   wire risc_v_top_i_n_83807;
   wire risc_v_top_i_n_83810;
   wire risc_v_top_i_n_83813;
   wire risc_v_top_i_n_83814;
   wire risc_v_top_i_n_83816;
   wire risc_v_top_i_n_83819;
   wire risc_v_top_i_n_83822;
   wire risc_v_top_i_n_83825;
   wire risc_v_top_i_n_83828;
   wire risc_v_top_i_n_83831;
   wire risc_v_top_i_n_83834;
   wire risc_v_top_i_n_83837;
   wire risc_v_top_i_n_83840;
   wire risc_v_top_i_n_83843;
   wire risc_v_top_i_n_83846;
   wire risc_v_top_i_n_83849;
   wire risc_v_top_i_n_83852;
   wire risc_v_top_i_n_83855;
   wire risc_v_top_i_n_83858;
   wire risc_v_top_i_n_83861;
   wire risc_v_top_i_n_83863;
   wire risc_v_top_i_n_83881;
   wire risc_v_top_i_n_83998;
   wire risc_v_top_i_n_83999;
   wire risc_v_top_i_n_84001;
   wire risc_v_top_i_n_84002;
   wire risc_v_top_i_n_84003;
   wire risc_v_top_i_n_84008;
   wire risc_v_top_i_n_84009;
   wire risc_v_top_i_n_84010;
   wire risc_v_top_i_n_84011;
   wire risc_v_top_i_n_84013;
   wire risc_v_top_i_n_84016;
   wire risc_v_top_i_n_84017;
   wire risc_v_top_i_n_84018;
   wire risc_v_top_i_n_84019;
   wire risc_v_top_i_n_84020;
   wire risc_v_top_i_n_84021;
   wire risc_v_top_i_n_84027;
   wire risc_v_top_i_n_84030;
   wire risc_v_top_i_n_84040;
   wire risc_v_top_i_n_84041;
   wire risc_v_top_i_n_84042;
   wire risc_v_top_i_n_84043;
   wire risc_v_top_i_n_85510;
   wire risc_v_top_i_n_85511;
   wire risc_v_top_i_n_85512;
   wire risc_v_top_i_n_85516;
   wire risc_v_top_i_n_85517;
   wire risc_v_top_i_n_87122;
   wire risc_v_top_i_n_87123;
   wire risc_v_top_i_n_87127;
   wire risc_v_top_i_n_87133;
   wire risc_v_top_i_n_87135;
   wire risc_v_top_i_n_87136;
   wire risc_v_top_i_n_87141;
   wire risc_v_top_i_n_87148;
   wire risc_v_top_i_n_87156;
   wire risc_v_top_i_n_87174;
   wire risc_v_top_i_n_87177;
   wire risc_v_top_i_n_87186;
   wire risc_v_top_i_uart_IP_module_UART_full_duplex_rx_uart_parity_received;
   wire risc_v_top_i_uart_IP_module_UART_full_duplex_tx_uart_inc_delay_5ms_add_32_42_n_236;
   wire risc_v_top_i_uart_IP_module_UART_full_duplex_tx_uart_inc_delay_5ms_add_32_42_n_243;
   wire risc_v_top_i_uart_IP_module_UART_full_duplex_tx_uart_inc_delay_5ms_add_32_42_n_245;
   wire risc_v_top_i_uart_IP_module_UART_full_duplex_tx_uart_inc_delay_5ms_add_32_42_n_248;
   wire risc_v_top_i_uart_IP_module_UART_full_duplex_tx_uart_inc_delay_5ms_add_32_42_n_254;
   wire risc_v_top_i_uart_IP_module_UART_full_duplex_tx_uart_inc_delay_5ms_add_32_42_n_255;
   wire risc_v_top_i_uart_IP_module_UART_full_duplex_tx_uart_inc_delay_5ms_add_32_42_n_261;
   wire risc_v_top_i_uart_IP_module_UART_full_duplex_tx_uart_inc_delay_5ms_add_32_42_n_265;
   wire risc_v_top_i_uart_IP_module_UART_full_duplex_tx_uart_inc_delay_5ms_add_32_42_n_269;
   wire risc_v_top_i_uart_IP_module_UART_full_duplex_tx_uart_inc_delay_5ms_add_32_42_n_273;
   wire risc_v_top_i_uart_IP_module_UART_full_duplex_tx_uart_inc_delay_5ms_add_32_42_n_275;
   wire risc_v_top_i_uart_IP_module_UART_full_duplex_tx_uart_inc_delay_5ms_add_32_42_n_278;
   wire risc_v_top_i_uart_IP_module_UART_full_duplex_tx_uart_n_181;
   wire risc_v_top_i_uart_IP_module_UART_full_duplex_tx_uart_n_182;
   wire risc_v_top_i_uart_IP_module_UART_full_duplex_tx_uart_n_183;
   wire risc_v_top_i_uart_IP_module_UART_full_duplex_tx_uart_n_184;
   wire risc_v_top_i_uart_IP_module_UART_full_duplex_tx_uart_n_186;
   wire risc_v_top_i_uart_IP_module_UART_full_duplex_tx_uart_n_191;
   wire risc_v_top_i_uart_IP_module_UART_full_duplex_tx_uart_n_194;
   wire risc_v_top_i_uart_IP_module_UART_full_duplex_tx_uart_n_197;
   wire risc_v_top_i_uart_IP_module_rx_flag;
   wire risc_v_top_i_uart_IP_module_uart_tx_finish;
   wire rx_w;

   PADDI pad_clk (.Y(clk_w),
	.PAD(clk));
   PADDI pad_nrst (.Y(reset_n_w),
	.PAD(reset_n));
   PADDI pad_rx (.Y(rx_w),
	.PAD(rx));
   PADDO pad_tx (.PAD(tx),
	.A(1'b1));
   PADVDD pad_vdd_i1 (.VSSIOR(),
	.VDD(VDD1));
   PADVDDIOR pad_vdd_ior (.VSS(),
	.VDDIOR(VDDIOR1));
   PADVSS pad_vss_i1 (.VSS(VSS1),
	.VDDIOR());
   PADVSSIOR pad_vss_ior (.VSSIOR(VSSIOR1),
	.VDD());
   padIORINGCORNER NE ();
   padIORINGCORNER NW ();
   padIORINGCORNER SE ();
   padIORINGCORNER SW ();
   PADVDD pad_vdd_dummy ();
   PADVDD pad_vdd_dummy2 ();
   PADVDD pad_vdd_dummy3 ();
   PADVSS pad_vss_dummy ();
   PADVSS pad_vss_dummy2 ();
   PADVSS pad_vss_dummy3 ();
   PADVDDIOR pad_vdd_ior_dummy ();
   PADVDDIOR pad_vdd_ior_dummy2 ();
   PADVDDIOR pad_vdd_ior_dummy3 ();
   PADVSSIOR pad_vss_ior_dummy ();
   PADVSSIOR pad_vss_ior_dummy2 ();
   PADVDDIOR pad_vss_ior_dummy3 ();
endmodule

