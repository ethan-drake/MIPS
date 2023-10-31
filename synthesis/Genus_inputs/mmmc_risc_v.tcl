# ANALYSIS CONFIGURATION MMMC FILE 
# Adders MMMC FILE 2023
# ITESO
# Cuauhtemoc Aguilera


# LIBRARY SET DEFINITIONS 
create_library_set -name LS_slow -timing { 
/CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/timing/slow_vdd1v0_basicCells.lib  \ 
/CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/timing/slow_vdd1v0_multibitsDFF.lib }

create_library_set -name LS_fast -timing {
/CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/timing/fast_vdd1v2_basicCells.lib \
/CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/timing/fast_vdd1v2_multibitsDFF.lib }

# create_library_set -name LS_typ  -timing { }

# OPERATION CONDITIONS (PVT) 
create_opcond -name OP_risc_v_slow	-process 1 -voltage 0.9  -temperature 125
create_opcond -name OP_risc_v_fast	-process 1 -voltage 1.32 -temperature 0
# create_opcond -name OP_Adders_typ	-process 1 -voltage 1.2  -temperature 25

# TIMING CONDITIONS
create_timing_condition -name TC_risc_v_slow    -opcond OP_risc_v_slow  -library_sets { LS_slow }
create_timing_condition -name TC_risc_v_fast    -opcond OP_risc_v_fast  -library_sets { LS_fast }
#create_timing_condition -name TC_Adders_typ 	-opcond OP_Adders_typ 	-library_sets { LS_typ }



# RC CORNERS
# create_rc_corner -name RCC_Adders -qrc_tech $QRC_TECH_FILE
# create_rc_corner -name RCC_Adders -cap_table ../Captable/cln28hpl_1p10m+alrdl_5x2yu2yz_typ.capTbl


# DELAY CORNERS
#create_delay_corner -name DC_risc_v_slow -early_timing_condition TC_risc_v_slow \
#                    -late_timing_condition TC_risc_v_slow -early_rc_corner RCC_Adders \
#                    -late_rc_corner RCC_Adders

create_delay_corner -name DC_risc_v_slow -early_timing_condition TC_risc_v_slow \
                    -late_timing_condition TC_risc_v_slow 


#create_delay_corner -name DC_risc_v_fast -early_timing_condition TC_risc_v_fast \
#                    -late_timing_condition TC_risc_v_fast -early_rc_corner RCC_Adders \
#                    -late_rc_corner RCC_Adders

create_delay_corner -name DC_risc_v_fast -early_timing_condition TC_risc_v_fast \
                    -late_timing_condition TC_risc_v_fast

# create_delay_corner -name DC_Adders_typ -early_timing_condition TC_Adders_typ \
#                    -late_timing_condition TC_Adders_typ -early_rc_corner RCC_Adders \
#                    -late_rc_corner RCC_Adders

# CONSTRAINTS MODES 
create_constraint_mode -name CM_risc_v_slow -sdc_files { \
   ../Genus_inputs/constraints_risc_v_slow_sdc.tcl
}

create_constraint_mode -name CM_risc_v_fast -sdc_files { \
   ../Genus_inputs/constraints_risc_v_fast_sdc.tcl
}

#create_constraint_mode -name CM_Adders_typ -sdc_files { \
#   ../Genus_inputs/constraints_Adders_typ.sdc
#}

# ANALISIS VIEW DEFINITIONS
create_analysis_view -name view_risc_v_slow -constraint_mode CM_risc_v_slow -delay_corner  DC_risc_v_slow
create_analysis_view -name view_risc_v_fast -constraint_mode CM_risc_v_fast -delay_corner  DC_risc_v_fast
# create_analysis_view -name view_Adders_typ  -constraint_mode CM_Adders_typ  -delay_corner  DC_Adders_typ

# SETTING OF ANALYSIS VIEW
set_analysis_view -setup { view_risc_v_slow view_risc_v_fast }



