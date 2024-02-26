.global _start

N: 			.word	1	// input parameter n
P:			.space 4	// Pell number result

_start:
	ldr		R3, N		// get the input parameter
	bl		pell		// go!
	str		R3, P		// save the result
	
stop:
	b		stop

// Pell number calculation
// pre-- A1: Pell number index i to calculate, n >= 0
// post- A1: Pell number P = pell(n)
pell:
	PUSH {R4, LR}
	CMP R3, #1 // n==1
	MOVEQ R2, R3
	BEQ _end // 
	CMP R3, #0
	MOVEQ R2, R3
	BEQ _end
	
	MOV R0, #0 // pell0
	MOV R1, #1 // pell1
	MOV R2, #0 // pell_n
	MOV R4, #2 // i

forloop:
	LSL R2, R1, #1 // pell_n = 2*pell1
	ADD R2, R2, R0 // pell_n = 2*pell1 + pell0
	
	MOV R0, R1 // pell0=pell1
	MOV R1, R2 // pell1=pelln
	ADD R4, R4, #1 
	CMP R4, R3 // i <= n
	BGT _end // if i>n 
	
	B forloop
	

_end:
	MOV R3, R2
	POP {R4, LR}
	BX LR
