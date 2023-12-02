# ITESO University
# Cuauhtemoc Aguilera 2023
# File Name: Placement_Create_bwco_Pad_Frame_CTSpec.tcl
# This script should be sourced affter power grid has been created.
#
Puts "Starting to do Design Placement..."

# Flooplan Mode for prototyping, runs quickly
#setPlaceMode -fp false
#setPlaceMode -placeIOPins 1
#placeDesign

#dbDeleteTrialRoute

#setPlaceMode -reset
setPlaceMode -congEffort high -timingDriven 1 -clkGateAware 1 -powerDriven 0 -ignoreScan 1 -reorderScan 1 -ignoreSpare 0 -placeIOPins 1 -moduleAwareSpare 0 -preserveRouting 1 -rmAffectedRouting 1 -checkRoute 1 -honorSoftBlockage true -swapEEQ 0

setPlaceMode -fp false

place_design

# Check is the tie cell are connected
globalNetConnect VDD -type tiehi -pin VDD -instanceBasename * -hierarchicalInstance {} -verbose
globalNetConnect VSS -type tielo -pin VSS -instanceBasename * -hierarchicalInstance {} -verbose

# checkPlace: checks FIXED and PLACED cells for violations, adds violation markers to the design display area, and generates a violation report
checkPlace

# checkPinAssignment: Checks the generated partition pins and I/O pins for several options. See man checkPinAssignment
checkPinAssignment -report_violating_pin

Puts "... finished Design Placement"

Puts "Timing the design before Clock Tree "
# Calculates the delays for paths based on max. opertating conditions (op) and min. op.
setAnalysisMode -analysisType onChipVariation

timeDesign -preCTS -prefix preCTS_setup
timeDesign -preCTS -prefix preCTS_hold  -hold

# Clock buffer and inversor cells definitions
# This command is used to set the values of various CCOpt object properties.
set_ccopt_property buffer_cells   {CLKBUFX2 CLKBUFX3 CLKBUFX4 CLKBUFX6 CLKBUFX8 CLKBUFX12 CLKBUFX16 CLKBUFX20}
set_ccopt_property inverter_cells {CLKINVX1 CLKINVX2     CLKINVX3 CLKINVX4 CLKINVX6 CLKINVX8 CLKINVX12 CLKINVX16 CLKINVX20}
#set_ccopt_property clock_gating_cells 	{PREICGX12 PREICG8 PREICGX6 PREICGX4}

# Configure the maximum transition target.
set_ccopt_property target_max_trans 100ps

# Create a clock tree specification by analyzing the timing graph structure of all active setup and hold analysis views.
# The clock tree specification contains clock_tree, skew_group, and property settings.
#	create_ccopt_clock_tree_spec
# Alternatively, the specification can be written to a file for inspection or debugging purposes and then loaded.
create_ccopt_clock_tree_spec -file risc_v_Pad_Frame_ccopt_CTS.spec

source risc_v_Pad_Frame_ccopt_CTS.spec

# Run CCOpt or CCOpt-CTS to Create Clock Tree
ccopt_design
	#ccopt_design -cts

Puts "Timing the design after CTS"
# Run timing analysis for setup by entering:
timeDesign -postCTS -prefix postCTS_setup
	# timeDesign -postCTS -expandedViews -outDir

# To run hold time analysis, enter:
timeDesign -postCTS -prefix postCTS_hold -hold



# If you have hold violations (negative slack), run optimization for hold by entering:
#	optDesign -postCTS -hold

# Report on clock trees to check area and other statistics.
report_ccopt_clock_trees -file clock_trees.rpt
# Report on skew groups to check insertion delay and, if applicable, skew.
report_ccopt_skew_groups -file skew_groups.rpt

