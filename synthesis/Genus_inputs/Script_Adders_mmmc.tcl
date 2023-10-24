# ITESO
# Cuauhtemoc Aguilera
# File: Script_Adders_mmmc.tcl
#### Template Script for RTL->Gate-Level Flow (generated from GENUS 20.11-s111_1) 
## The Genus Simple Template was adapted to the Adders design.

if {[file exists /proc/cpuinfo]} {
  sh grep "model name" /proc/cpuinfo
  sh grep "cpu MHz"    /proc/cpuinfo
}

puts "Hostname : [info hostname]"

##############################################################################
## Preset global variables and attributes
##############################################################################
set DESIGN risc_v_top
set Timing_Libs_Path /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/timing/
set LEF_Libs_Path /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/lef/ 

# The following line is commented because MMMC synthesis is performed.
#set Liberty_List {slow_vdd1v0_basicCells.lib}

set LEF_List {gsclib045_tech.lef gsclib045_macro.lef gsclib045_multibitsDFF.lef}

set GEN_EFF medium
set MAP_OPT_EFF high
set DATE [clock format [clock seconds] -format "%b%d-%T"] 

set RELEASE [lindex [get_db program_version] end]

set _OUTPUTS_PATH outputs_${DATE}
set _NETLIST_PATH Netlist
set _REPORTS_PATH reports_${DATE}
set _LOG_PATH logs_${DATE}


# Variables used by Cadence training
set RTL_LIST {Counter_02Limit_ovf.v risc_v_top.v multiplexor_param.v ffd_param_pc_risk.v adder.v branch_prediction.v instr_memory.v ffd_param_clear_n.v imm_gen.v register_file.v jump_detection_unit.v control_unit.v hazard_detection_unit.v ALU_control.v double_multiplexor_param.v ALU.v forward_unit.v master_memory_map.v data_memory.v uart_IP.v branch_control_unit.v uart_full_duplex.v UART_Rx.v uart_tx.v uart_tx_fsm.v ffd_param_clear.v Delayer.v Bit_Rate_Pulse.v ffd_param.v parallel2serial.v Shift_Register_R_Param.v FSM_UART_Rx.v Counter_Param.v}
set QRC_TECH_FILE {/CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/qrc/qx/gpdk045.tch}

##set MODUS_WORKDIR <MODUS work directory>

set_db init_lib_search_path "$Timing_Libs_Path $LEF_Libs_Path"
set_db / .script_search_path {../Genus_inputs} 
set_db / .init_hdl_search_path {../../src} 
set_db qos_report_power true

##Uncomment and specify machine names to enable super-threading.
##set_db / .super_thread_servers {<machine names>} 
##For design size of 1.5M - 5M gates, use 8 to 16 CPUs. For designs > 5M gates, use 16 to 32 CPUs
##set_db / .max_cpus_per_server 8

##Default undriven/unconnected setting is 'none'.  
##set_db / .hdl_unconnected_value 0 | 1 | x | none

set_db / .information_level 11 

set_db hdl_track_filename_row_col true 

set_db lp_power_unit mW 


###############################################################
## Library setup
###############################################################

# PVT SLOW: 1; 0.9 V; 125 oC	
#	/CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/timing/slow_vdd1v0_basicCells.lib

# Reading Timing Libraries (Liberty format, .lib)
# read_libs $Liberty_List

## Reading in MMMC definition file
read_mmmc ../Genus_inputs/mmmc_Adders.tcl

puts "REVIEW LOG FILE FOR EXECUTION RESULTS OF read_mmmc command"
suspend




# Reading LEF Libraries
read_physical -lef $LEF_List

puts "REVIEW LOG FILE FOR EXECUTION RESULTS OF read_physical command"
suspend
## Provide either cap_table_file or the qrc_tech_file
#	set_db / .cap_table_file <file> 
#	read_qrc <qrcTechFile name>


##### check the following command
#read_qrc $QRC_TECH_FILE

puts "REVIEW LOG FILE FOR EXECUTION RESULTS OF read_qrc command"
suspend


# Attribute for low power design
# set_db / .lp_insert_clock_gating true 

# set_db pbs_mmmc_flow true

set_db tns_opto true 

####################################################################
## Load Design
####################################################################
read_hdl -v2001 $RTL_LIST
elaborate $DESIGN
#read_def ../DEF/dtmf.def

puts "Runtime & Memory after 'read_hdl'"
time_info Elaboration
#check_design -unresolved
check_design

puts "REVIEW LOG FILE FOR EXECUTION RESULTS OF check_design COMMAND & REVIEW RTL SCHEMATIC"
suspend

# MMMC Command
init_design
time_info init_design

puts "REVIEW LOG FILE FOR EXECUTION RESULTS OF init_design command"
suspend


#check_design -unresolved
check_design

puts "REVIEW LOG FILE FOR EXECUTION RESULTS OF check_design command"
suspend

## Set the innovus executable to be used for placement and routing
## set_db innovus_executable  <Innovus Executables>

####################################################################
## Constraints Setup
####################################################################
# Constraints were read using the read_mmmc command

#read_sdc {../Genus_inputs/Adders_Results_SDC.tcl}

# To print the failed constraints 
puts "$::dc::sdc_failed_commands > failed.sdc"

puts "CHECK FOR NO-APPLIED CONSTRAINTS"
suspend

# Timing Lint
check_timing_intent -verbose

puts "REVIEW LOG FILE FOR EXECUTION RESULTS OF check_timing_intent command"
suspend

report clocks
puts "Review Timing Lint Reporte and Clock reports"
suspend


puts "The number of exceptions is [llength [vfind "design:$DESIGN" -exception *]]"
puts "REVIEW EXCEPTIONS"
suspend

if {![file exists ${_OUTPUTS_PATH}]} {
  file mkdir ${_OUTPUTS_PATH}
  puts "Creating directory ${_OUTPUTS_PATH}"
}

if {![file exists ${_REPORTS_PATH}]} {
  file mkdir ${_REPORTS_PATH}
  puts "Creating directory ${_REPORTS_PATH}"
}

if {![file exists ${_LOG_PATH}]} {
  file mkdir ${_LOG_PATH}
  puts "Creating directory ${_LOG_PATH}"
}

#### To turn off sequential merging on the design 
#### uncomment & use the following attributes.
##set_db / .optimize_merge_flops false 
##set_db / .optimize_merge_latches false 
#### For a particular instance use attribute 'optimize_merge_seqs' to turn off sequential merging. 

####################################################################################################
## Synthesizing to generic 
####################################################################################################
set_db / .syn_generic_effort $GEN_EFF
syn_generic
puts "Runtime & Memory after 'syn_generic'"
time_info GENERIC
report_dp > $_REPORTS_PATH/generic/${DESIGN}_datapath.rpt
write_snapshot -outdir $_REPORTS_PATH -tag generic
report_summary -directory $_REPORTS_PATH

# Generate Generic Netlist
write_hdl -generic > ${_OUTPUTS_PATH}/${DESIGN}_generic.v

puts "VIEW GENERIC SCHEMATIC"
suspend

####################################################################################################
## Synthesizing to Gates (Maped)
####################################################################################################
set_db / .syn_map_effort $MAP_OPT_EFF
syn_map
puts "Runtime & Memory after 'syn_map'"
time_info MAPPED
write_snapshot -outdir $_REPORTS_PATH -tag map

# QoS Summary report final.rpt
report_summary -directory $_REPORTS_PATH
report_dp > $_REPORTS_PATH/map/${DESIGN}_datapath.rpt

# Generate Mapped Netlist
write_hdl -lec > ${_OUTPUTS_PATH}/${DESIGN}_intermediate.v


# LEC Do File RTL to Intermediate
#write_do_lec -revised_design fv_map -logfile ${_LOG_PATH}/rtl2intermediate.lec.log > $_OUTPUTS_PATH}/rtl2intermediate.lec.do
#write_do_lec -no_exit -revised_design ${_OUTPUTS_PATH}/${DESIGN}_intermediate.v -logfile ${_LOG_PATH}/rtl2intermediate.lec.log > ${_OUTPUTS_PATH}/rtl2intermediate.lec.do
write_do_lec -no_exit -revised_design ${_NETLIST_PATH}/Adders_intermediate_BUG.v -logfile ${_LOG_PATH}/rtl2intermediate_bug.lec.log > ${_OUTPUTS_PATH}/rtl2intermediate_bug.lec.do



## ungroup -threshold <value>
puts "VIEW MAPPED SCHEMATIC"
suspend

#######################################################################################################
## Optimize Netlist
#######################################################################################################

## Uncomment to remove assigns & insert tiehilo cells during Incremental synthesis
##set_db / .remove_assigns true 
##set_remove_assign_options -buffer_or_inverter <libcell> -design <design|subdesign> 
##set_db / .use_tiehilo_for_const <none|duplicate|unique> 
set_db / .syn_opt_effort $MAP_OPT_EFF
syn_opt
write_snapshot -outdir $_REPORTS_PATH -tag syn_opt
report_summary -directory $_REPORTS_PATH
puts "Runtime & Memory after 'syn_opt'"
time_info OPT
#write_snapshot -outdir $_REPORTS_PATH -tag final

report_summary -directory $_REPORTS_PATH
write_hdl  > ${_OUTPUTS_PATH}/${DESIGN}_hdl_opt.v
write_design -basename ${_OUTPUTS_PATH}/${DESIGN}_opt
## write_script > ${_OUTPUTS_PATH}/${DESIGN}_m.script

#write_sdc > ${_OUTPUTS_PATH}/${DESIGN}_opt.sdc
#write_sdc -version 1.1 -view analysis_view -constraint_mode constraint_mode design > ${_OUTPUTS_PATH}/${DESIGN}_opt.sdc
write_sdc -version 1.1 -view view_Adders_slow $DESIGN > ${_OUTPUTS_PATH}/${DESIGN}_opt_slow.sdc

puts "REVIEW OPTIMIZED REPORTS AND SCHEMATIC DIAGRAM"
suspend

#################################
### write_do_lec
#################################
#write_do_lec -no_exit -golden_design ${_OUTPUTS_PATH}/${DESIGN}_intermediate.v -revised_design ${_OUTPUTS_PATH}/${DESIGN}_opt.v -logfile  ${_LOG_PATH}/intermediate2final.lec.log > ${_OUTPUTS_PATH}/intermediate2final.lec.do

write_do_lec -no_exit -golden_design ${_NETLIST_PATH}/Adders_intermediate_BUG.v -revised_design ${_NETLIST_PATH}/Adders_opt_BUG.v -logfile  ${_LOG_PATH}/intermediate2final_bug.lec.log > ${_OUTPUTS_PATH}/intermediate2final_bug.lec.do

##Uncomment if the RTL is to be compared with the final netlist..
#write_do_lec -no_exit -revised_design ${_OUTPUTS_PATH}/${DESIGN}_opt.v -logfile ${_LOG_PATH}/rtl2final.lec.log > ${_OUTPUTS_PATH}/rtl2final.lec.do
write_do_lec -no_exit -revised_design ${_NETLIST_PATH}/Adders_opt_BUG.v -logfile ${_LOG_PATH}/rtl2final_bug.lec.log > ${_OUTPUTS_PATH}/rtl2final_bug.lec.do

puts "Final Runtime & Memory."
time_info FINAL

file copy [get_db / .stdout_log] ${_LOG_PATH}/.

puts "============================"
puts "Synthesis Finished ........."
puts "============================"

##quit
