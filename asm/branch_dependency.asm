#testing program for branch dependencies
.text
main:
	addi t0, t0, 0x1
	addi t2, zero, 0x5
	bne t0, t2, main
	nop
	nop
	nop
other:
	addi t2, t2, -0x1
	bne t2, zero, other
	nop
	nop
exit:
	addi t3, t3, 0x7 