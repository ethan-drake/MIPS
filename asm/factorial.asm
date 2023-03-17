.text
#0x10010024 dato a transmitir
#0x10010028 señal start tx
#0x1001002C señal que la uart ya termino de transmitir
#0x10010030 dato a recibir de uart
#0x10010034 señal que la uart ya recibio un dato
main:
	addi a2,zero,5 #loading factorial
	jal ra,factorial #calling procedure
	jal zero,exit # jump to exit label

factorial:
	slti t0, a2, 1, #if n<1
	beq t0, zero, loop #branch to loop
	addi a0, zero, 1 #loading 1
	jalr zero,ra,0 #return to the caler
loop:
	addi sp, sp, -8 #decreasing stack pointer
	sw ra, 4(sp) #storing n
	sw a2, 0(sp) #storing return addres
	addi a2, a2, -1 #Decreasing n
	jal ra,factorial #recursive function
	lw a2, 0(sp) #load value from stack
	lw ra, 4(sp) # load ra from stack
	addi sp, sp, 8 #increase stack pointer
	mul a0, a2, a0 # n*factorial(n-1)
	jalr zero,ra,0 #return to caller
exit:
