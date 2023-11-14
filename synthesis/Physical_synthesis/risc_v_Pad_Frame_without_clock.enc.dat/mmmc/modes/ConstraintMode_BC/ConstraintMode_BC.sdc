###############################################################
#  Generated by:      Cadence Innovus 21.12-s106_1
#  OS:                Linux x86_64(Host ID ip-172-31-46-123.us-east-2.compute.internal)
#  Generated on:      Thu Nov  9 21:59:26 2023
#  Design:            risc_v_Pad_Frame
#  Command:           routeDesign -globalDetail
###############################################################
current_design risc_v_Pad_Frame
set_clock_gating_check -rise -setup 0 
set_clock_gating_check -fall -setup 0 
create_clock [get_ports {clk}]  -name My_CLK -period 1.000000 -waveform {0.000000 0.500000}
set_clock_latency -source -early -min -rise 0.03 [get_clocks {My_CLK}]
set_clock_latency -source -early -min -fall 0.02 [get_clocks {My_CLK}]
set_clock_latency -source -early -max -rise 0.03 [get_clocks {My_CLK}]
set_clock_latency -source -early -max -fall 0.02 [get_clocks {My_CLK}]
set_clock_latency -source -late -min -rise 0.03 [get_clocks {My_CLK}]
set_clock_latency -source -late -min -fall 0.02 [get_clocks {My_CLK}]
set_clock_latency -source -late -max -rise 0.03 [get_clocks {My_CLK}]
set_clock_latency -source -late -max -fall 0.02 [get_clocks {My_CLK}]
set_clock_latency -rise 0.015  [get_clocks {My_CLK}]
set_clock_latency -fall 0.01  [get_clocks {My_CLK}]
set_clock_transition  -rise -min 0.04 [get_clocks {My_CLK}]
set_clock_transition  -rise -max 0.055 [get_clocks {My_CLK}]
set_clock_transition  -fall -min 0.03 [get_clocks {My_CLK}]
set_clock_transition  -fall -max 0.05 [get_clocks {My_CLK}]
set_load -pin_load -max  0.005  [get_ports {VDD1}]
set_load -pin_load -min  0.005  [get_ports {VDD1}]
set_load -pin_load -max  0.005  [get_ports {VSS1}]
set_load -pin_load -min  0.005  [get_ports {VSS1}]
set_load -pin_load -max  0.005  [get_ports {VDDIOR1}]
set_load -pin_load -min  0.005  [get_ports {VDDIOR1}]
set_load -pin_load -max  0.005  [get_ports {VSSIOR1}]
set_load -pin_load -min  0.005  [get_ports {VSSIOR1}]
set_load -pin_load -max  0.005  [get_ports {tx}]
set_load -pin_load -min  0.005  [get_ports {tx}]
set_max_capacitance 0.005  [get_ports {tx}]
set_max_fanout 15  [get_designs {risc_v_Pad_Frame}]
set_max_transition 0.02  [get_designs {risc_v_Pad_Frame}]
set_input_delay -add_delay 0.1 -clock [get_clocks {My_CLK}] [get_ports {rx}]
set_output_delay -add_delay 0.1 -clock [get_clocks {My_CLK}] [get_ports {tx}]
set_clock_uncertainty 0.004 -hold [get_clocks {My_CLK}]
set_clock_uncertainty 0.008 -setup [get_clocks {My_CLK}]
