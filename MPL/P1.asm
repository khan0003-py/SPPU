;ALP to accept 5 hex numbers of 64 bits & display the entered numbers
;assumption : user enters only valid hex numbers so program does not check for valid hex digits
section .data
	m1 db 'enter hex number ( max 16 digits)', 10
	lengthm1 equ $-m1
	m2 db ' you have entered numbers :' ,10
	lengthm2 equ $-m2

section .bss
	array resb 200			; reserve 200 bytes in memory
	counter resb 1			; reserve 1 byte to keep counter 

section .text
	
	global _start
	_start:
	
		
	mov rax, 1			;display message 'enter hex number'
	mov rdi,1
	mov rsi,m1
	mov rdx,lengthm1
	syscall
	
	mov byte[counter],5		; set counter to 5 
	mov rsi ,array			; point rsi to start of array
	
accept: mov rax,0			; accept a 16 digit number
	mov rdi,0
	mov rdx ,17
	syscall
	
	add rsi,17			; add 17 to rsi to store next number of 16 digits
	dec byte[counter]		
	
	jnz accept			; if counter is not zero , accept next number
	
; display entered numbers

	mov rax, 1			;display message 'you have entered numbers'
	mov rdi,1
	mov rsi,m2
	mov rdx,lengthm2
	syscall

	mov byte[counter],5		; set counter to 5 
	mov rsi ,array			; point rsi to start of array

display: mov rax,1			; display a 16 digit number
	mov rdi ,1
	mov rdx, 17
	syscall
	
	add rsi,17			;add 17 to rsi to point to next number of 16 digits
	dec byte[counter]
	
	jnz display			; if counter is not zero , display next number
	
	mov rax,60			; terminate the program
	syscall
	
	
	
	
	
	
	
	

