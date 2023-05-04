.text
main:
addi s1,zero,0x1
jal ra,jumphere
addi s2,zero,0x2
jumphere:
addi s3,zero,0x3
jalr t0,ra,0x0
addi s4,zero,0x4