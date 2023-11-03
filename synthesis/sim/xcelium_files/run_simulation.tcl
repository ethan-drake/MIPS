#Apply xcelium libraries
source /CMC/scripts/cadence.xceliummain21.09.003.csh

#Run command
xrun -clean -file ../src/xcelium/build.opts -input ../src/xcelium/probes.tcl
