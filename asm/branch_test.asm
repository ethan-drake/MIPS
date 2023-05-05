.text
main:
addi s0, zero, 0x1
addi s2, zero, 0x1
beq s0,s2,step1
jal ra, main
jal ra,step1
addi s2, zero, 0x10
step1:
addi s1, zero, 0x2
bne s0,s1,step2
addi s2, zero, 0x10
step2:
beq s0,s1,main
bne s0,s2,main
addi s3,zero,0x4
addi s3,zero,0x5
addi s3,zero,0x6