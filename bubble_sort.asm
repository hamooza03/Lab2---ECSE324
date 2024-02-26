.global _start


Stuff:		.byte 10,1,4 // input array
			.space 1	// to align next word
N: 			.word	3	// number of elements in Stuff
Sorted:		.space 3	// (optional) sorted output
			.space 1	// to align next word

_start:
	ldr		R1, =Stuff	// get the address of Stuff
	ldr		R2, N		// get the number of things in Stuff
	bl		sort		// go!
	
stop:
	b		stop

// Sorting algorithm
// pre-- A1: Address of array of signed bytes to be sorted
// pre-- A2: Number of elements in array
// post- A1: Address of sorted array
sort:
	PUSH {R3-R10, LR}
	MOV R3, #0 //R3 (i) =1
	MOV R4, #0 //R4 (j) =0

for:
	SUB R5, R2, #1 // n-1
	MOV R4, #0
	CMP R3, R5 // i < n-1
	BGE done // branch out
	
for2:
	SUB R6, R5, R3 // n-1-i
	CMP R4, R6 // j<n-1-i
	BGE end_for
	ADD R7, R4, #1 // j+1
	LDRSB R8, [R1, R4] //arr[j]
	LDRSB R9, [R1, R7] //arr[j+1]
	CMP R8, R9 // arr[j] > arr[j+1]
	ADDLE R4, R4, #1
	BLE for2
	MOV R10, R8
	STRB R9, [R1, R4] 
	STRB R10, [R1, R7] //swap
	ADD R4, R4, #1
	B for2 

end_for:
	ADD R3, R3, #1
	B for
	
done:
	POP {R3-R10, LR}
	BX LR