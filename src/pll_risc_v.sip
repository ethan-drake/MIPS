set_global_assignment -entity "pll_risc_v" -library "lib_pll_risc_v" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "pll_risc_v" -library "lib_pll_risc_v" -name IP_TOOL_VERSION "21.1"
set_global_assignment -entity "pll_risc_v" -library "lib_pll_risc_v" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_pll_risc_v" -name SPD_FILE [file join $::quartus(sip_path) "pll_risc_v.spd"]

set_global_assignment -library "lib_pll_risc_v" -name MISC_FILE [file join $::quartus(sip_path) "pll_risc_v_sim/pll_risc_v.vo"]
