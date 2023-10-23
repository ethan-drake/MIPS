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
create_opcond -name OP_Adders_slow	-process 1 -voltage 0.9  -temperature 125
create_opcond -name OP_Adders_fast	-process 1 -voltage 1.32 -temperature 0
# create_opcond -name OP_Adders_typ	-process 1 -voltage 1.2  -temperature 25

# TIMING CONDITIONS
create_timing_condition -name TC_Adders_slow    -opcond OP_Adders_slow  -library_sets { LS_slow }
create_timing_condition -name TC_Adders_fast    -opcond OP_Adders_fast  -library_sets { LS_fast }
#create_timing_condition -name TC_Adders_typ 	-opcond OP_Adders_typ 	-library_sets { LS_typ }



# RC CORNERS
# create_rc_corner -name RCC_Adders -qrc_tech $QRC_TECH_FILE
# create_rc_corner -name RCC_Adders -cap_table ../Captable/cln28hpl_1p10m+alrdl_5x2yu2yz_typ.capTbl


# DELAY CORNERS
#create_delay_corner -name DC_Adders_slow -early_timing_condition TC_Adders_slow \
#                    -late_timing_condition TC_Adders_slow -early_rc_corner RCC_Adders \
#                    -late_rc_corner RCC_Adders

create_delay_corner -name DC_Adders_slow -early_timing_condition TC_Adders_slow \
                    -late_timing_condition TC_Adders_slow 


#create_delay_corner -name DC_Adders_fast -early_timing_condition TC_Adders_fast \
#                    -late_timing_condition TC_Adders_fast -early_rc_corner RCC_Adders \
#                    -late_rc_corner RCC_Adders

create_delay_corner -name DC_Adders_fast -early_timing_condition TC_Adders_fast \
                    -late_timing_condition TC_Adders_fast

# create_delay_corner -name DC_Adders_typ -early_timing_condition TC_Adders_typ \
#                    -late_timing_condition TC_Adders_typ -early_rc_corner RCC_Adders \
#                    -late_rc_corner RCC_Adders

# CONSTRAINTS MODES 
create_constraint_mode -name CM_Adders_slow -sdc_files { \
   ../Genus_inputs/constraints_Adders_slow_sdc.tcl
}

create_constraint_mode -name CM_Adders_fast -sdc_files { \
   ../Genus_inputs/constraints_Adders_fast_sdc.tcl
}

#create_constraint_mode -name CM_Adders_typ -sdc_files { \
#   ../Genus_inputs/constraints_Adders_typ.sdc
#}

# ANALISIS VIEW DEFINITIONS
create_analysis_view -name view_Adders_slow -constraint_mode CM_Adders_slow -delay_corner  DC_Adders_slow
create_analysis_view -name view_Adders_fast -constraint_mode CM_Adders_fast -delay_corner  DC_Adders_fast
# create_analysis_view -name view_Adders_typ  -constraint_mode CM_Adders_typ  -delay_corner  DC_Adders_typ

# SETTING OF ANALYSIS VIEW
set_analysis_view -setup { view_Adders_slow view_Adders_fast }



