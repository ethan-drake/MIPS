if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name Lib_Set_BC\
   -timing\
    [list ${::IMEX::libVar}/mmmc/fast_vdd1v2_basicCells.lib\
    ${::IMEX::libVar}/mmmc/fast_vdd1v2_multibitsDFF.lib]
create_library_set -name Lib_Set_WC\
   -timing\
    [list ${::IMEX::libVar}/mmmc/slow_vdd1v0_basicCells.lib\
    ${::IMEX::libVar}/mmmc/slow_vdd1v0_multibitsDFF.lib]
create_rc_corner -name RC_Extraction_WC\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -qx_tech_file ${::IMEX::libVar}/mmmc/RC_Extraction_WC/gpdk045.tch
create_rc_corner -name RC_Extraction_BC\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -qx_tech_file ${::IMEX::libVar}/mmmc/RC_Extraction_WC/gpdk045.tch
create_delay_corner -name DelayCorner_WC\
   -library_set Lib_Set_WC\
   -rc_corner RC_Extraction_WC
create_delay_corner -name DelayCorner_BC\
   -library_set Lib_Set_BC\
   -rc_corner RC_Extraction_BC
create_constraint_mode -name ConstraintMode_WC\
   -sdc_files\
    [list /dev/null]
create_constraint_mode -name ConstraintMode_BC\
   -sdc_files\
    [list /dev/null]
create_analysis_view -name AnalysisView_BC -constraint_mode ConstraintMode_BC -delay_corner DelayCorner_BC
create_analysis_view -name AnalysisView_WC -constraint_mode ConstraintMode_WC -delay_corner DelayCorner_WC
set_analysis_view -setup [list AnalysisView_WC AnalysisView_BC] -hold [list AnalysisView_WC AnalysisView_BC]
