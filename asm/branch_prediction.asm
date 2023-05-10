.text
main:
addi s0, zero, 1
addi s1, zero, 1
beq s0,s1,e1
addi s0, zero, 2
addi s2, zero, 3
e1:
addi s3, zero, 5
addi s4, zero, 5
bne s3, s4, e2
addi s5, zero, 6
addi s6, zero, 7
e2:
addi s7, zero, 7
addi s8, zero, 8
beq s3,s4,e3
addi s9, zero, 9
addi s10, zero, 10
e3:
jal main