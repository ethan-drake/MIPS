# ####################################################################

#  Created by Genus(TM) Synthesis Solution 20.11-s111_1 on Wed Nov 08 02:32:11 UTC 2023

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design risc_v_Pad_Frame

create_clock -name "My_CLK" -period 1.0 -waveform {0.0 0.5} [get_ports clk]
set_clock_transition -rise -min 0.04 [get_clocks My_CLK]
set_clock_transition -rise -max 0.055 [get_clocks My_CLK]
set_clock_transition -fall -min 0.03 [get_clocks My_CLK]
set_clock_transition -fall -max 0.05 [get_clocks My_CLK]
set_load -pin_load 0.005 [get_ports tx]
set_load -pin_load 0.005 [get_ports VDD1]
set_load -pin_load 0.005 [get_ports VSS1]
set_load -pin_load 0.005 [get_ports VDDIOR1]
set_load -pin_load 0.005 [get_ports VSSIOR1]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks My_CLK] -add_delay 0.1 [get_ports rx]
set_output_delay -clock [get_clocks My_CLK] -add_delay 0.1 [get_ports tx]
set_max_fanout 15.000 [current_design]
set_max_transition 0.02 [current_design]
set_max_capacitance 0.005 [get_ports tx]
set_max_capacitance 0.005 [get_ports VDD1]
set_max_capacitance 0.005 [get_ports VSS1]
set_max_capacitance 0.005 [get_ports VDDIOR1]
set_max_capacitance 0.005 [get_ports VSSIOR1]
set_clock_latency  -rise 0.015 [get_clocks My_CLK]
set_clock_latency  -fall 0.01 [get_clocks My_CLK]
set_clock_latency -source -rise 0.03 [get_clocks My_CLK]
set_clock_latency -source -fall 0.02 [get_clocks My_CLK]
set_clock_uncertainty -setup 0.008 [get_clocks My_CLK]
set_clock_uncertainty -hold 0.004 [get_clocks My_CLK]
