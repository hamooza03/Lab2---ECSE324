.global _start


Stuff:		.byte 2,1,0 // input array
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
	PUSH {R3-R8, LR}
	MOV R3, #1 //R3 (i) =1
	MOV R4, #0 //R4 (j) =0
	MOV R5, #1 //R5 (key) =0

for:
	CMP R3, R2 // i < n
	BGE done // branch out
	// ADD R6, R3, #1
	LDRSB R5, [R1, R3] // key=arr[i]
	SUB R4, R3, #1 // j=i-1
	
while:
	CMP R4, #0
	BLT offset
	LDRSB R6, [R1, R4] //arr[j]
	CMP R6, R5 // arr[j] > key
	BLE offset
	ADD R8, R4, #1 // j+1
	STRB R6, [R1, R8]
	SUB R4, R4, #1
	B while
	
offset:
	ADD R8, R4, #1 // j+1
	STRB R5, [R1, R8] // arr[j+1] = key
	ADD R3, R3, #1
	B for
	
	
done:
	POP {R3-R8, LR}
	BX LR