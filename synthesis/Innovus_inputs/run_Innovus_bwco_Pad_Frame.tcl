source /CMC/scripts/cadence.genus20.11.000.csh
source /CMC/scripts/cadence.innovus21.12.000.csh
# To run with file option
innovus -log bwco_Pad_Frame_log.log



# To run in test mode
# genus -log log_Adders_constraints.log






#genus -legacy_ui -f ../Genus_inputs/Adders_Genus_LEC_GPDK045.tcl -log Adders_Genus_log.log
#genus -legacy_ui -legacy_gui -f ../Genus_inputs/Adders_Genus_LEC_GPDK045.tcl -log Adders_Genus_log.log
#genus -gui -f ../Genus_inputs/Adders_Genus_LEC_GPDK045.tcl -log Adders_Genus_log.log

#genus -set_db/get_db -gui -f ../Genus_inputs/Adders_Genus_LEC_GPDK045.tcl -log Adders_Genus_log.log
#genus set_db common_ui false -gui -f ../Genus_inputs/Adders_Genus_LEC_GPDK045.tcl -log Adders_Genus_log.log

# How to run Genus for test of commands
# genus -gui -log Test_Genus_log.log

