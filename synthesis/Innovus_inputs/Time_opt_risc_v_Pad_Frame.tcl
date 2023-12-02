# ITESO University
# Cuauhtemoc Aguilera 2023
# This script should be sourced affter the
# Clock Tree has been created.


Puts "Setting Optimization Mode Option for DRV fixing"
setOptMode -fixFanoutLoad true
setOptMode -addInstancePrefix postCTSdrv

Puts "Optimizing for DRV"
optDesign -postCTS -drv

Puts "Timing design after DRV fixes"
timeDesign -postCTS -prefix postCTS_setup_DRVfix
timeDesign -postCTS -prefix postCTS_hold_DRVfix -hold

Puts "Setting Optimization Mode Option for Setup fixing"
setOptMode -addInstancePrefix postCTSsetup

Puts "Optimizing for Setup"
optDesign -postCTS

Puts  "Timing design after Setup fixes"
timeDesign -postCTS -prefix postCTS_setup_Setupfix
timeDesign -postCTS -prefix postCTS_hold_Setupfix  -hold

setOptMode -addInstancePrefix postCTShold
optDesign -postCTS -hold
Puts  "Timing design after Hold fixes"
timeDesign -postCTS -prefix postCTS_setup_Holdfix
timeDesign -postCTS -prefix postCTS_hold_Holdfix  -hold

Puts "Routing the Design"
setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeWithSiPostRouteFix 0
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven true
setNanoRouteMode -quiet -routeWithSiDriven true
routeDesign -globalDetail

Puts "Timing the design after Route"
timeDesign -postRoute -prefix postRoute_setup
timeDesign -postRoute -prefix postRoute_hold  -hold

#### Exportar hacia Virtuoso
#set nameGDS "bwco_frame_BiCMOS_p2019.gds";  #Editar nombre de ser necesario  

#streamOut ../GDS/${nameGDS} -mapFile /media/Ext/libs/IBM_PDK/bicmos8hp/v.20171220/lef/bicmos8hp_soce2gds.map -libName DesignLib -merge { /media/Ext/libs/8HP_IP_CELL_AND_IO_Libs/BiCMOS8HP_Digital_Kit/ibm_cmos8hp/sc_1p2v_12t_rvt/v.20171220/gds2/BICMOS8HP_SC_1P2V_12T_RVT.gds /opt/libs/IBM_PDK/bicmos8hp/v.20160727/gds2/CMOS8HP_BASE_WB_IO_7LM.gds } -outputMacros -units 1000 -mode ALL
