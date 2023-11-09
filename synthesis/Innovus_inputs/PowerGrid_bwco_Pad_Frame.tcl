# ITESO University
# Cuauhtemoc Aguilera 2023
# Power-grid script for bwco with Pad Frame
# PowerGrid_bwco_Pad_Frame.tcl


# Defining process mode 
setDesignMode -process 45

# Defining floorplan
floorPlan -site CoreSite -b 0.0 0.0 800.0 800.0 250.0 250.0 550.0 550.0 290.0 290 510 509.41
fit

# Defining global nets
#	clearGlobalNets
#	globalNetConnect VDD -type pgpin -pin VDD -inst * -module {} -verbose
#	globalNetConnect VSS -type pgpin -pin VSS -inst * -module {} -verbose
# The correct syntax for TIEHI Y TIELO

#	globalNetConnect VDD -type tiehi -inst * -verbose
#	globalNetConnect VSS -type tielo -inst * -verbose

# Innovus Global Nets
clearGlobalNets
globalNetConnect VDD -type pgpin -pin VDD -instanceBasename * -hierarchicalInstance {} -verbose
globalNetConnect VSS -type pgpin -pin VSS -instanceBasename * -hierarchicalInstance {} -verbose
# Check Syntax  for TIEHI & TIELO
globalNetConnect VDD -type tiehi -pin VDD -instanceBasename * -hierarchicalInstance {} -verbose
globalNetConnect VSS -type tielo -pin VSS -instanceBasename * -hierarchicalInstance {} -verbose

# VDD_IO and VSS_IO
# The following line produces an error
#globalNetConnect VDD_IO -type pgpin -pin VDD150 -inst * -module {} -verbose
#globalNetConnect VSS_IO -type pgpin -pin VSS -inst * -module {} -verbose


# Creating Power Rins
setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer Metal11 -stacked_via_bottom_layer Metal1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }

addRing -nets {VDD VSS} -type core_rings -follow core -layer {top Metal1 bottom Metal1 left Metal2 right Metal2} -width {top 3 bottom 3 left 3 right 3} -spacing {top 2 bottom 2 left 2 right 2} -offset {top 0 bottom 0 left 0 right 0} -center 1 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None

# Adding horizontal stripes
setSrouteMode -viaConnectToShape { noshape }
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { Metal1(1) Metal11(11) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { Metal1(1) Metal11(11) } -nets { VDD VSS } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { Metal1(1) Metal11(11) }

# Adding vertical stripes
setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer Metal11 -stacked_via_bottom_layer Metal1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }

addStripe -nets {VDD VSS} -layer Metal6 -direction vertical -width 2 -spacing 1 -number_of_sets 3 -start_from left -start_offset 53 -stop_offset 53 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit Metal11 -padcore_ring_bottom_layer_limit Metal1 -block_ring_top_layer_limit Metal11 -block_ring_bottom_layer_limit Metal1 -use_wire_group 0 -snap_wire_center_to_grid None





