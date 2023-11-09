################################################################################
#
# Init setup file
# Created by Genus(TM) Synthesis Solution on 11/09/2023 03:16:24
#
################################################################################

      if { ![is_common_ui_mode] } {
        error "This script must be loaded into an 'innovus -stylus' session."
      }
    


read_mmmc outputs_Nov09-03:11:57/risc_v_Pad_Frame_opt.mmmc.tcl

read_physical -lef {/CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/lef//gsclib045_tech.lef /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/lef//gsclib045_macro.lef /CMC/kits/cadence/GPDK045/gsclib045_all_v4.4/gsclib045/lef//gsclib045_multibitsDFF.lef /CMC/kits/cadence/GPDK045/giolib045_v3.3/lef/giolib045.lef}

read_netlist outputs_Nov09-03:11:57/risc_v_Pad_Frame_opt.v

init_design -skip_sdc_read
