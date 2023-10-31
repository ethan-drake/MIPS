REAd IMplementation Information fv/risc_v_top -golden fv_map -revised Adders_intermediate_BUGv
SET PARAllel Option -threads 1,4 -norelease_license
SET COmpare Options -threads 1,4
SET UNDEfined Cell black_box -noascend -both
ADD SEarch Path /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/timing/ /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/lef/\
   -library -both
REAd LIbrary -liberty -both /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/timing/slow_vdd1v0_basicCells.lib\
   /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/timing/slow_vdd1v0_multibitsDFF.lib\
   /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/timing/fast_vdd1v2_basicCells.lib\
   /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/timing/fast_vdd1v2_multibitsDFF.lib
REAd DEsign -verilog95 -golden -lastmod -noelab fv/risc_v_top/fv_map.v.gz
ELAborate DEsign -golden -root risc_v_top
REAd DEsign -verilog95 -revised -lastmod -noelab Netlist/risc_v_top_intermediate.v
ELAborate DEsign -revised -root risc_v_top
REPort DEsign Data
REPort BLack Box
SET FLatten Model -seq_constant
SET FLatten Model -seq_constant_x_to 0
SET FLatten Model -nodff_to_dlat_zero
SET FLatten Model -nodff_to_dlat_feedback
SET FLatten Model -hier_seq_merge
CHEck VErification Information
SET ANalyze Option -auto -report_map
SET SYstem Mode lec
REPort UNmapped Points -summary
REPort UNmapped Points -notmapped
ADD COmpared Points -all
COMpare
REPort COmpare Data -class nonequivalent -class abort -class notcompared
REPort VErification -verbose
REPort STatistics
REPort VErification
WRIte VErification Information
REPort VErification Information
REPort IMplementation Information
RESET
SET VErification Information rtl_fv_map_db
REAd IMplementation Information fv/risc_v_top -revised fv_map
SET PARAllel Option -threads 1,4 -norelease_license
SET COmpare Options -threads 1,4
SET UNDEfined Cell black_box -noascend -both
ADD SEarch Path /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/timing/ /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/lef/\
   -library -both
REAd LIbrary -liberty -both /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/timing/slow_vdd1v0_basicCells.lib\
   /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/timing/slow_vdd1v0_multibitsDFF.lib\
   /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/timing/fast_vdd1v2_basicCells.lib\
   /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/timing/fast_vdd1v2_multibitsDFF.lib
SET UNDRiven Signal 0 -golden
SET NAming Style genus -golden
SET NAming Rule %s[%d] -instance_array -golden
SET NAming Rule %s_reg -register -golden
SET NAming Rule %L.%s %L[%d].%s %s -instance -golden
SET NAming Rule %L.%s %L[%d].%s %s -variable -golden
SET NAming Rule -ungroup_separator _ -golden
SET HDl Options -const_port_extend
SET HDl Options -VERILOG_INCLUDE_DIR sep:src:cwd
DELete SEarch Path -all -design -golden
ADD SEarch Path ../../src -design -golden
REAd DEsign -define SYNTHESIS -merge bbox -golden -lastmod -noelab -verilog2k ../../src/Counter_02Limit_ovf.v\
   ../../src/risc_v_top.v ../../src/multiplexor_param.v ../../src/ffd_param_pc_risk.v ../../src/adder.v\
   ../../src/branch_prediction.v ../../src/instr_memory.v ../../src/ffd_param_clear_n.v\
   ../../src/imm_gen.v ../../src/register_file.v ../../src/jump_detection_unit.v ../../src/control_unit.v\
   ../../src/hazard_detection_unit.v ../../src/ALU_control.v ../../src/double_multiplexor_param.v\
   ../../src/ALU.v ../../src/forward_unit.v ../../src/master_memory_map.v ../../src/data_memory.v\
   ../../src/uart_IP.v ../../src/branch_control_unit.v ../../src/uart_full_duplex.v ../../src/UART_Rx.v\
   ../../src/uart_tx.v ../../src/uart_tx_fsm.v ../../src/ffd_param_clear.v ../../src/Delayer.v\
   ../../src/Bit_Rate_Pulse.v ../../src/ffd_param.v ../../src/parallel2serial.v ../../src/Shift_Register_R_Param.v\
   ../../src/FSM_UART_Rx.v ../../src/Counter_Param.v
ELAborate DEsign -golden -root risc_v_top -rootonly
REAd DEsign -verilog95 -revised -lastmod -noelab fv/risc_v_top/fv_map.v.gz
ELAborate DEsign -revised -root risc_v_top
UNIQuify -all -nolib -golden
REPort DEsign Data
REPort BLack Box
SET FLatten Model -seq_constant
SET FLatten Model -seq_constant_x_to 0
SET FLatten Model -nodff_to_dlat_zero
SET FLatten Model -nodff_to_dlat_feedback
SET FLatten Model -hier_seq_merge
SET FLatten Model -balanced_modeling
CHEck VErification Information
SET ANalyze Option -auto -report_map
WRIte HIer_compare Dofile hier_tmp2.lec.do -verbose -noexact_pin_match -constraint -usage -replace -balanced_extraction\
   -input_output_pin_equivalence -prepend_string "report_design_data; report_unmapped_points -summary; report_unmapped_points -notmapped; analyze_datapath -module -verbose; eval analyze_datapath -flowgraph -verbose"
RUN HIer_compare hier_tmp2.lec.do -dynamic_hierarchy
REPort HIer_compare Result -dynamicflattened
REPort VErification -hier -verbose
WRIte VErification Information
REPort VErification Information
REPort IMplementation Information
SET SYstem Mode lec
ANAlyze RESults -logfiles logs_Oct26-01:10:36/rtl2intermediate_bug.lec.log
