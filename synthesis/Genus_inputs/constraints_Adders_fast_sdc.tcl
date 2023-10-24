# ITESO University
# Cuauhtemoc Aguilera
# User Constraint File: constraints_Adders_fast.tcl

# Set the current design
current_design risc_v_top

# Genus COMMANDS TO SET UNITS
set_time_unit -picoseconds
set_load_unit -femtofarads

# COMMON VARIABLES 
set EXTCLK "My_CLK"
set EXTCLK_PERIOD 10000
set SKEW 40.0
set MINRISE 40.0
set MAXRISE 55.0
set MINFALL 30.0
set MAXFALL 50.0


# Clock definition
#define_clock -name $EXTCLK -period 2000 -rise 50 -fall 50 [clock_ports]

#create_clock -name "refclk" -add -period 8.0 -waveform {0.0 4.0} [get_ports refclk]
create_clock -name $EXTCLK  -add -period $EXTCLK_PERIOD [get_ports clk]

# Clock Definition using SDC format 50% Duty Cycle
#	create_clock -period 2000 -name my_clock [clock_ports]

# Clock Definition using SDC format 50% Duty Cycle
#	create_clock -period 2000 -name my_clock -waveform {1250 2000} [clock_ports] 


# slew attribute: Specifies the minimum rise, minimum fall, maximum rise, and
# maximum fall slew values, respectively, in picoseconds.
# The following sentence define the (min rise, min fall, max rise, max fall).

set_clock_transition -rise -min $MINRISE [get_clocks $EXTCLK]
set_clock_transition -rise -max $MAXRISE [get_clocks $EXTCLK]
set_clock_transition -fall -min $MINFALL [get_clocks $EXTCLK]
set_clock_transition -fall -max $MAXFALL [get_clocks $EXTCLK]


# TO DEFINE CLOCK SOURCE AND NETWORK LATENCY IN GENUS
# Define waveform settings for Source Latency
set_clock_latency -rise -source 30 -early -late $EXTCLK  	
set_clock_latency -fall -source 20 -early -late $EXTCLK  	
# Define waveform settings for Network Latency
set_clock_latency -rise 15 $EXTCLK
set_clock_latency -fall 10 $EXTCLK


# CLOCK UNCERTAINTY
set_clock_uncertainty -setup 8 [get_clocks $EXTCLK]
set_clock_uncertainty -hold  4 [get_clocks $EXTCLK]

# Input delay definition: This is the delay coming from outside the design
# for this design it's defined at 10% the period of the clock.
## external_delay -clock [find / -clock 500MHz_CLK] -input 200 -name IDelay [find /des* -port ports_in/*]
## SDC FORMAT
set_input_delay -clock [get_clocks $EXTCLK] -add_delay 1000 -name I_DELAY [get_ports {rst_n rx}]

# Output delay definition: This is the delay going outside the design
# for this design it's defined at 10% the period of the clock.
##external_delay -clock [find / -clock 500MHz_CLK] -output 200 -name ODelay [find /des* -port ports_out/*]
## SDC FORMAT
set_output_delay -clock [get_clocks $EXTCLK] -add_delay 1000 -name O_DELAY [get_ports {tx}]

# Driving cell definition
## BUFx2 is a buffer of 2 drive strength of the slow_vdd1v0_basicCells library
#set_db external_driver [find [find / -libcell BUFX2] -libpin Y] { /designs/Adders/ports_in/* }

# does not is applied [get_db ports {X Y A B cin nrst}]
#set_driving_cell -lib_cell BUFX2 [get_db ports {X Y A B cin nrst}]
# Genus tested
set_driving_cell -lib_cell BUFX2 [get_ports {rst_n rx}]

### SDC FORMAT

set_max_capacitance 5 [all_outputs]

##set_max_fanout 5  [get_ports {SUM sum_struct}]
set_max_fanout 15.000 [current_design]

# set_max_transition

set_max_transition 20 [current_design]

# Alternative to external_pin_cap
set_load 5 -pin_load [all_outputs]

