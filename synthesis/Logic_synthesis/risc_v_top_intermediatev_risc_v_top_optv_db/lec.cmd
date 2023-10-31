REAd IMplementation Information fv/risc_v_top -golden risc_v_top_intermediatev -revised risc_v_top_optv
SET PARAllel Option -threads 1,4 -norelease_license
SET COmpare Options -threads 1,4
SET UNDEfined Cell black_box -noascend -both
ADD SEarch Path /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/timing/ /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/lef/\
   -library -both
REAd LIbrary -liberty -both /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/timing/slow_vdd1v0_basicCells.lib\
   /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/timing/slow_vdd1v0_multibitsDFF.lib\
   /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/timing/fast_vdd1v2_basicCells.lib\
   /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/timing/fast_vdd1v2_multibitsDFF.lib
REAd DEsign -verilog95 -golden -lastmod -noelab Netlist/risc_v_top_intermediate.v
ELAborate DEsign -golden -root risc_v_top
REAd DEsign -verilog95 -revised -lastmod -noelab Netlist/risc_v_top_opt.v
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
WRIte VErification Information
REPort VErification Information
REPort IMplementation Information
ANAlyze RESults -logfiles logs_Oct26-04:22:58/intermediate2final.lec.log
