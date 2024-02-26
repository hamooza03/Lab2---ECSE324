.global _start

N: 			.word	10	// input parameter n
P:			.space 4	// Pell number result

_start:
	ldr		R1, N		// get the input parameter
	bl		pell		// go!
	str		R1, P		// save the result
	
stop:
	b		stop

// Pell number calculation
// pre-- A1: Pell number index i to calculate, n >= 0
// post- A1: Pell number P = pell(n)
pell:
	CMP R1, #1 // n==1, return 1
	BEQ case1
	
	CMP R1, #0 // n==0, return 0
	BEQ case2
	
	// Recursion
	PUSH {R1} // Save n
	SUB R2, R1, #1 // for n-1
	MOV R1, R2 // Move to R1, if the program stops
	BL pell // call for n-1
	MOV R3, R1 // Program continued, store R3
	LSL R3, R3, #1 // shift by 1 therefore 2*(pell(n-1))
	POP {R1} // get original n value
	SUB R1, R1, #2 // for n-2
	BL pell // call for n-2
	ADD R1, R1, R3 // Total addition in R1
	BX LR
	
      // your code starts here


case1:
	MOV R1, #1
	B end_func

case2:
	MOV R1, #0
	B end_func

end_func:
	BX LR