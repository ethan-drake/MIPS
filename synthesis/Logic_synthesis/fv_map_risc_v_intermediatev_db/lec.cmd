REAd IMplementation Information fv/risc_v_top -golden fv_map -revised risc_v_intermediatev
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
REAd DEsign -verilog95 -revised -lastmod -noelab Netlist/risc_v_intermediate.v
