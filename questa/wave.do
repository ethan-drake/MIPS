onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal -radixshowbase 0 /risk_v_singlecycle_TB/clk
add wave -noupdate -radix hexadecimal -radixshowbase 0 /risk_v_singlecycle_TB/rst
add wave -noupdate -radix hexadecimal -radixshowbase 0 /risk_v_singlecycle_TB/procesador/ALUSrcB
add wave -noupdate -radix hexadecimal -radixshowbase 0 /risk_v_singlecycle_TB/procesador/MemWrite
add wave -noupdate -radix hexadecimal -radixshowbase 0 /risk_v_singlecycle_TB/procesador/pc_src
add wave -noupdate -radix hexadecimal -radixshowbase 0 /risk_v_singlecycle_TB/procesador/jump
add wave -noupdate -radix hexadecimal -radixshowbase 0 /risk_v_singlecycle_TB/procesador/regWrite
add wave -noupdate -radix hexadecimal /risk_v_singlecycle_TB/procesador/reg_file/a1
add wave -noupdate -radix hexadecimal /risk_v_singlecycle_TB/procesador/reg_file/a2
add wave -noupdate -radix hexadecimal /risk_v_singlecycle_TB/procesador/reg_file/a3
add wave -noupdate -radix hexadecimal /risk_v_singlecycle_TB/procesador/reg_file/wd3
add wave -noupdate -radix hexadecimal -radixshowbase 0 /risk_v_singlecycle_TB/procesador/RegDst
add wave -noupdate -radix hexadecimal -radixshowbase 0 /risk_v_singlecycle_TB/procesador/mem2Reg
add wave -noupdate -color Pink -radix hexadecimal -childformat {{{/risk_v_singlecycle_TB/procesador/pc_out[31]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[30]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[29]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[28]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[27]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[26]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[25]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[24]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[23]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[22]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[21]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[20]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[19]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[18]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[17]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[16]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[15]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[14]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[13]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[12]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[11]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[10]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[9]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[8]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[7]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[6]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[5]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[4]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[3]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[2]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[1]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/pc_out[0]} -radix hexadecimal}} -radixshowbase 0 -subitemconfig {{/risk_v_singlecycle_TB/procesador/pc_out[31]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[30]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[29]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[28]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[27]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[26]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[25]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[24]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[23]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[22]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[21]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[20]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[19]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[18]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[17]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[16]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[15]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[14]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[13]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[12]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[11]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[10]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[9]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[8]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[7]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[6]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[5]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[4]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[3]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[2]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[1]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/pc_out[0]} {-color Pink -height 15 -radix hexadecimal -radixshowbase 0}} /risk_v_singlecycle_TB/procesador/pc_out
add wave -noupdate -radix hexadecimal -radixshowbase 0 /risk_v_singlecycle_TB/procesador/rd1_data_reg
add wave -noupdate -radix hexadecimal -radixshowbase 0 /risk_v_singlecycle_TB/procesador/rd2_data
add wave -noupdate -color Gold -radix hexadecimal -childformat {{{/risk_v_singlecycle_TB/procesador/instr2perf[31]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[30]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[29]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[28]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[27]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[26]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[25]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[24]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[23]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[22]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[21]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[20]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[19]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[18]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[17]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[16]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[15]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[14]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[13]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[12]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[11]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[10]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[9]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[8]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[7]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[6]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[5]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[4]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[3]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[2]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[1]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/instr2perf[0]} -radix hexadecimal}} -radixshowbase 0 -subitemconfig {{/risk_v_singlecycle_TB/procesador/instr2perf[31]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[30]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[29]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[28]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[27]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[26]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[25]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[24]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[23]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[22]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[21]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[20]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[19]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[18]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[17]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[16]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[15]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[14]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[13]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[12]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[11]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[10]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[9]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[8]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[7]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[6]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[5]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[4]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[3]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[2]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[1]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0} {/risk_v_singlecycle_TB/procesador/instr2perf[0]} {-color Gold -height 15 -radix hexadecimal -radixshowbase 0}} /risk_v_singlecycle_TB/procesador/instr2perf
add wave -noupdate -radix hexadecimal -radixshowbase 0 /risk_v_singlecycle_TB/procesador/sign_extend_out
add wave -noupdate -radix hexadecimal -radixshowbase 0 /risk_v_singlecycle_TB/procesador/alu_result
add wave -noupdate -radix hexadecimal -radixshowbase 0 /risk_v_singlecycle_TB/procesador/alu_control
add wave -noupdate -radix hexadecimal -radixshowbase 0 /risk_v_singlecycle_TB/procesador/alu_operation
add wave -noupdate -radix hexadecimal -radixshowbase 0 /risk_v_singlecycle_TB/procesador/alu_zero
add wave -noupdate -radix hexadecimal -radixshowbase 0 /risk_v_singlecycle_TB/procesador/MemRead
add wave -noupdate -radix hexadecimal -childformat {{{/risk_v_singlecycle_TB/procesador/reg_file/registers[0]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[1]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[2]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[3]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[4]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[5]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[6]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[7]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[8]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[9]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[10]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[11]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[12]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[13]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[14]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[15]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[16]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[17]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[18]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[19]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[20]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[21]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[22]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[23]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[24]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[25]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[26]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[27]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[28]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[29]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[30]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/reg_file/registers[31]} -radix hexadecimal}} -expand -subitemconfig {{/risk_v_singlecycle_TB/procesador/reg_file/registers[0]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[1]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[2]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[3]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[4]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[5]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[6]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[7]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[8]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[9]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[10]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[11]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[12]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[13]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[14]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[15]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[16]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[17]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[18]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[19]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[20]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[21]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[22]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[23]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[24]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[25]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[26]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[27]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[28]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[29]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[30]} {-height 15 -radix hexadecimal} {/risk_v_singlecycle_TB/procesador/reg_file/registers[31]} {-height 15 -radix hexadecimal}} /risk_v_singlecycle_TB/procesador/reg_file/registers
add wave -noupdate -radix hexadecimal /risk_v_singlecycle_TB/procesador/mux_jump_pc/i_a
add wave -noupdate -radix hexadecimal -childformat {{{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[31]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[30]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[29]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[28]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[27]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[26]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[25]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[24]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[23]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[22]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[21]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[20]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[19]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[18]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[17]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[16]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[15]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[14]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[13]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[12]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[11]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[10]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[9]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[8]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[7]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[6]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[5]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[4]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[3]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[2]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[1]} -radix hexadecimal} {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[0]} -radix hexadecimal}} -expand -subitemconfig {{/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[31]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[30]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[29]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[28]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[27]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[26]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[25]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[24]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[23]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[22]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[21]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[20]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[19]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[18]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[17]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[16]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[15]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[14]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[13]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[12]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[11]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[10]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[9]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[8]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[7]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[6]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[5]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[4]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[3]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[2]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[1]} {-radix hexadecimal} {/risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b[0]} {-radix hexadecimal}} /risk_v_singlecycle_TB/procesador/mux_jump_pc/i_b
add wave -noupdate -radix hexadecimal /risk_v_singlecycle_TB/procesador/mux_jump_pc/i_selector
add wave -noupdate -radix hexadecimal /risk_v_singlecycle_TB/procesador/mux_jump_pc/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2198 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 313
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {41120 ps}
