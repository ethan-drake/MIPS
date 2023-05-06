#0x10010024 dato a transmitir
#0x10010028 seÃ±al start tx
#0x1001002C seÃ±al que la uart ya termino de transmitir
#0x10010030 dato a recibir de uart
#0x10010034 seÃ±al que la uart ya recibio un dato
#0x10010038 seÃ±al para limpiar el rx uart

#Inicio programa para recibir datos de UART
main:
	auipc a3,    0x0000fc10 #cargar valor base de 10010000
	addi a4, a3, 0x50 #cargar base de las matrices
	addi a3, a3, 0x24 #direccion inicial 10010024
	addi t5, zero, 0x10 #contador de iteracion para recorrer elemento por elemento
	addi t2, zero, 0x1 #bit para cargar a registros de seÃ±ales
	addi t3, zero, 0x4 #matrix of 4 elements 
	addi t6, zero, 0x1 #vector of 1 element
	addi a5, a4, 0x0 #guardar el valor en a5 de la base
wait_for_row:
	addi t3, t3, -1 #reduce iteracion 1
	addi a5, a5, 0x10 #se a�ade 0x10 al offset
	j init_ctt
wait_for_matrix:
	addi t3, zero, 0x0 #candado para no entrar de nuevo a recorrer matriz
	addi t6, t6, -1  #reduce iteracion 1
	addi a5, a4, 0x0 #se guarda el valor en a5 de la base
init_ctt:
	addi s1, zero, 0x0 #inicializa contador
get_uart_data:
	lw t1, 0x10(a3) #obtener la seÃ±al de 0x10010034 para ver si ya recibimos un dato
	beq t1, zero, get_uart_data #checar si es un valor distinto de cero, sino seguir esperando
	lw a2, 0xC(a3) #loading number from address
	sw t2, 0x14(a3) #levantar seÃ±al para limpiar la bandera de rx
	sw zero, 0x14(a3) #bajar seÃ±al para limpiar la bandera de rx
	add t4, a5, s1 #calcular el offset a escribir
	sw a2, 0(t4) #load vaue based in matrix base + offset
	addi s1, s1, 4	#contador 
	bne s1, t5, get_uart_data #poll until 4 times happen
	bne t3, zero, wait_for_row #iteraciones para recorrer los rows
	bne t6, zero, wait_for_matrix #iteraciones para recorrer los vectores

#Inicio de programa para calcular matriz x vector
start_calculation:
	addi s0, zero, 4 #matrix size
	addi s1, zero, 0 #int i = 0
	addi s3, zero, 0 #int resultado = 0
	addi s4, zero, 4 #word size
	mul s7, s4, s0 #row size
	auipc a1,    0x0000fc10
	addi a1, a1, -0x1c
	auipc a2,    0x0000fc10
	addi a2, a2, 0x1c
Column_loop:
	#for(i=0;i<4;i++)
	slti t1, s1, 0x4 
	beqz t1, uart_start #exit when calculation is done
	auipc a0,    0x0000fc10
	addi a0, a0, -0x44
	addi s2, zero, 0 #int j = 0
	addi t3, zero, 0#resetear la variable temporal t3
Row_loop:
	#for(j=0;j<4;j++)
	slti t1, s2, 0x4 
	beqz t1, Row_loop_done #exit for if condition is not met
	lw t2, 0(a0)#get a from vector 1
	sw t2, -4(sp)#load a to 4(sp)
	lw t2, 0(a1)#get b from vector 2
	sw t2, -8(sp)#load b to 8(sp)
	jal ra, ProductFunction #ProductFunction(Vector_1[i], Vector_2[i])
	lw t2, -12(sp)#get result from 12(sp)
	add t3, t3, t2 # result = result + ProductFunction(Vector_1[i], Vector_2[i]);
	addi a0, a0, 4 #move vector1 base address
	addi a1, a1, 4 #move vector2 base address
	addi s2, s2, 0x1 #j++
	jal zero, Row_loop #next for iteration
Row_loop_done:
	sw t3, 0(a2)#guardar el resultado en el result vector
	addi a2, a2, 4#mover el apuntador del vector
	addi s1, s1, 1#add i++
	jal zero, Column_loop #jump to column loop
ProductFunction:
	sw ra, 0(sp) #save ra in 0(sp)
	lw s4, -4(sp) #get a from 4(sp)
	lw s5, -8(sp) #get b from 8(sp)
	mul t0, s4, s5 # a*b
	sw t0, -12(sp) #save result to 12(sp)
	lw ra, 0(sp) #load ra
	jalr zero, ra, 0

#Programa para enviar los resultados al UART
uart_start:
	addi a4, a3, 0x7c #obtiene la direccion del resultado
	addi t0, zero, 0x0 #se inicializa la base
	addi t6, zero, 0x4 #se va a relaizar 4 veces el envio de datos
send_uart_data:
	addi s0, zero, 0x20 #contador i para el loop
	add t5, a4, t0 #se realiza suma para saber el offset de los datos
	lw a0, 0(t5) #se carga el valor a enviar
send_loop:
	addi s0, s0, -0x8 #decrease counter
	srl t3, a0, s0 #shift right register factorial number to get 8 bits to send
	sw t3, 0(a3) #cargar el factorial en la direccion de memoria de dato UART
	sw t2, 4(a3) #cargar el bit 1 a la seÃ±al de enviar tx de uart
	sw zero, 4(a3) #cargar el bit 0 a la seÃ±al de enviar tx de uart tipo one shot
wait_uart_working:
	lw t4, 0x18(a3) #obtener que UART ya empezo nuestra solicitud Tx
	beq t4, zero, wait_uart_working #checar si es un valor distinto de cero, sino seguir esperando que empiece solicitud
wait_to_send:
	lw t1, 8(a3) #obtener el valor de la bandera que termino de enviar la transmision
	beq t1, zero, wait_to_send #checar si es un valor distinto de cero, sino seguir esperando que termine de enviarse
	bne s0, zero, send_loop #check if al bytes have been sent
next_iteration:
	addi t6, t6, -0x1 #reduce el contador
	addi t0, t0, 0x4 #aumenta el offset por 4
	bne t6, zero, send_uart_data #si no ha acabado de enviar 4 veces, repite el proceso
finish_program:
	j main #regresa al inicio del prgrama
nop
nop