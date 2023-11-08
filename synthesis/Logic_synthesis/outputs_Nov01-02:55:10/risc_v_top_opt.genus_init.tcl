################################################################################
#
# Init setup file
# Created by Genus(TM) Synthesis Solution on 11/01/2023 03:00:05
#
################################################################################

      if { ![is_common_ui_mode] } {
        error "This script must be loaded into an 'innovus -stylus' session."
      }
    


read_mmmc outputs_Nov01-02:55:10/risc_v_top_opt.mmmc.tcl

read_physical -lef {/CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/lef//gsclib045_tech.lef /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/lef//gsclib045_macro.lef /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/lef//gsclib045_multibitsDFF.lef}

read_netlist outputs_Nov01-02:55:10/risc_v_top_opt.v

init_design -skip_sdc_read
