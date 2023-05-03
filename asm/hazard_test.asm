.text
main:
auipc s2,    0x0000fc10 #cargar valor base de 10010024
addi s2, s2, 4
lw s1, 4(s2)
add s4,s1,s5
and s6,s1,s4
addi s7, s7, 7
or s7, s7, s6
add s7, s6, s7
add s7, s7, s7
add s6, zero, s2
lw s7, 4(s2)
sw s7, 4(s6)
lw s1, 4(s6)
lw s2, 4(s1)
addi s9,s2,0x9
addi s4,s9,0x4
add s5,s9,s2
lw s5, 4(s2)
add s5,s1,s5
add s5,s5,s5
sw s5, 4(s2)
lw s8, 4(s2)
add s5, s8, s5
sw s5, 8(s2)
sw s8, 12(s2)
addi s2, s2, -4
sw s7, 4(s2)
lw s10, 8(s2)
add s1, s10, s7