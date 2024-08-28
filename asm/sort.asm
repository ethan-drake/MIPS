lui $1, $0, 0x00001001
ori $1, $1, 0x0
add $1, $0, $1
addi $2, $1, 36
lw $3, 0($1)
loop:addi $1, $1, 4
lw $4, 0($1)
slt $5, $4, $3
beq $5, $0, keep_value
add $3, $4, $0
keep_value:beq $1, $2, save_lowest
j loop
save_lowest:sw $3, 4($1)
end:j end
