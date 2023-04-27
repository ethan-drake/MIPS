.text
main:
addi s2,s2,0x3
addi s5,s5,0x5
add s1,s2,s2
sub s4,s1,s5
and s6,s1,s4
or  s8,s1,s4
xor s4,s1,s5
addi s4,s8,0x9
addi s6,s8,0x2
addi s4,s8,0x4
add s5,s5,s2
slt s5,s5,s4
or s3,s1,s5
add s5,s5,s5
sll s7,s5,s3