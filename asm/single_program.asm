.text
#Programa para probar pipeline sin hazards con dependencias de 2 ciclos de diferencia
main:
	addi a1, a1, 7
	addi a2, a2, 8
	addi a3, a3, 9
	addi a4, a4, 10
	xor s0, a1, a2
	add s1, a2, a3
	sub s3, a4, a3
	and s4, a2, a3
	or s5, s0, s1
	andi a4, a1, 1
	ori s3, a3, 0