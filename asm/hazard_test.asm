.text
main:
lw s1, 4(s2)
add s4,s1,s5
and s6,s1,s4
lw s1, 4(s6)
lw s2, 4(s1)
addi s9,s2,0x9
addi s4,s9,0x4
add s5,s9,s2
lw s5, 4(s5)
add s5,s1,s5
add s5,s5,s5
