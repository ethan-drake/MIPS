FAR:lui $1, 0x00001001
ori $1, $1, 0x0
add $1, $0, $1
lw $0, 0($1)
lw $2, 8($1)
lw $4, 12($1)
add $2, $2, $4
and $3, $2, $0
lw $5, 16($1)
or $7, $5, $0
lw $6, 4($1)
or $7,$7,$6
slt $10,$0,$7
slt $11,$7,$0
addi $31,$0,-1
beq $7,$0,FAR
j label1
label2: beq $0,$0,label2
label1: j label2