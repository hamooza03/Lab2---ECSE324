.global _start

N: 		.word 12
Numbers: 	.short 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13
Primes: 	.space 24

_start:
// your code starts here
	LDR R1, =Numbers //Nums array
	LDR R2, =Primes // Primes array
	LDR R3, N // Length of array
	MOV R4, #0 // Nums indice
	MOV R5,	#0 // Pri indice
	MOV R6, #1 // prime
	MOV R7, #0// Done 0 is false
	
while:
	CMP R7, #1 // if done
	BEQ done // branch to done
	SUB R4, R6, #1 //num = prime - 1

while2:
	CMP R4, R3 // R4-R3=3 // num < n
	BGE mark_divisible // branch to if statement
	LSL R10, R4, #1 //Calculate address, shift by 1 since it is like multiply by 2
	ADD R10, R10, R1 // Adds to address, R10 = intermediate address
	LDRH R11, [R10] // Load half-word (since short)
	CMP R11, #0 // Compares to 0
	BNE mark_divisible // Increments
	ADD R4, R4, #1
	B while2
	
mark_divisible:
	CMP R4, R3 // num < n
	BGE done
	
	LSL R10, R4, #1 //Calculate address, shift by 1 since it is like multiply by 2
	ADD R10, R10, R1 // Adds to address
	LDRH R6, [R10]
	LSL R10, R5, #1
	ADD R10, R10, R2
	STRH R6, [R10]
	ADD R5, R5, #1
	
while3:
	CMP R4, R3
	BGE while
	MOV R8, #0
	LSL R10, R4, #1 //Calcualte address, shift by 1
	ADD R10, R1, R10 //Add to find next element
	STRH R8, [R10] //Store value from address
	ADD R4, R4, R6 
	B while3

set_done:
	MOV R7, #1
	B while

done:
	B done