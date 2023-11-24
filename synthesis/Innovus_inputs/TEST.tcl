# ITESO University
# David Michel , Ethan Castillo 2023
# Power-grid script for bwco with Pad Frame
# PowerGrid_bwco_Pad_Frame.tcl

#Floorplan

floorPlan -site CoreSite -b 0.0 0.0 800.0 800.0 250.0 250.0 550.0 550.0 290.0 290 510 509.41

#Voltages

clearGlobalNets
globalNetConnect VDD -type pgpin -pin VDD -instanceBasename * -hierarchicalInstance {} -verbose
globalNetConnect VSS -type pgpin -pin VSS -instanceBasename * -hierarchicalInstance {} -verbose
globalNetConnect VDD -type tiehi -pin VDD -instanceBasename * -hierarchicalInstance {} -verbose
globalNetConnect VSS -type tielo -pin VSS -instanceBasename * -hierarchicalInstance {} -verbose
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0

#Power ring

setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer Metal11 -stacked_via_bottom_layer Metal1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {VDD VSS} -type core_rings -follow core -layer {top Metal1 bottom Metal1 left Metal2 right Metal2} -width {top 10 bottom 10 left 10 right 10} -spacing {top 5 bottom 5 left 5 right 5} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 1 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None

#Routing

setSrouteMode -viaConnectToShape { noshape }
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { Metal1(1) Metal3(3) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { Metal1(1) Metal11(11) } -nets { VDD VSS } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { Metal1(1) Metal11(11) }

#Stripemode

setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer Metal11 -stacked_via_bottom_layer Metal1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets {VDD VSS} -layer Metal2 -direction vertical -width 0.3 -spacing 0.16 -number_of_sets 6 -start_from left -start_offset 15 -stop_offset 15 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit Metal11 -padcore_ring_bottom_layer_limit Metal1 -block_ring_top_layer_limit Metal11 -block_ring_bottom_layer_limit Metal1 -use_wire_group 0 -snap_wire_center_to_grid None

#Route mode


setRouteMode -earlyGlobalHonorMsvRouteConstraint false -earlyGlobalRoutePartitionPinGuide true
setEndCapMode -reset
setEndCapMode -boundary_tap false
setNanoRouteMode -quiet -droutePostRouteSpreadWire 1
setNanoRouteMode -quiet -droutePostRouteWidenWireRule LEFSpecialRouteSpec
setNanoRouteMode -quiet -timingEngine {}
setUsefulSkewMode -noBoundary false -maxAllowedDelay 1
setPlaceMode -fp false

#PLace design

place_design
setDrawView place
checkPlace
checkPinAssignment -report_violating_pin

#CLocks 

setAnalysisMode -analysisType onChipVariation
timeDesign -preCTS -prefix preCTS_setup
timeDesign -preCTS -prefix preCTS_hold -hold
set_ccopt_property buffer_cells {CLKBUFX2 CLKBUFX3 CLKBUFX4 CLKBUFX6 CLKBUFX8 CLKBUFX12 CLKBUFX16 CLKBUFX20}
set_ccopt_property inverter_cells {CLKINVX1 CLKINVX2     CLKINVX3 CLKINVX4 CLKINVX6 CLKINVX8 CLKINVX12 CLKINVX16 CLKINVX20}
set_ccopt_property target_max_trans 100ps
create_ccopt_clock_tree_spec -file bwco_Pad_Frame_ccopt_CTS.spec
get_ccopt_clock_trees
ccopt_check_and_flatten_ilms_no_restore
set_ccopt_property cts_is_sdc_clock_root -pin clk true
set_ccopt_property timing_connectivity_info {}
check_ccopt_clock_tree_convergence
get_ccopt_property auto_design_state_for_ilms

#CCOPT design

ccopt_design
timeDesign -postCTS -prefix postCTS_setup
timeDesign -postCTS -prefix postCTS_hold -hold
report_ccopt_clock_trees -file clock_trees.rpt
report_ccopt_skew_groups -file skew_groups.rpt



#end






