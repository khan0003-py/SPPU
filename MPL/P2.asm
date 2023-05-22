;2.asm
;ALP to accept a string & display its length in hex
;assumptions : 1) user enters string of maximum 255 characters
;             2) length displayed in hex format
section .data
	m1 db 'enter string ( max 255 characters)', 10
	lengthm1 equ $-m1
	m2 db ' lenght of string is : ' ,10
	lengthm2 equ $-m2

section .bss
	array 	      resb 200		; reserve 200 bytes in memory
	lengthinascii resb 2		; reserve 2 bytes to store two digits of length converted to ASCII
section .text
	
	global _start
	_start:
	
		
	mov rax, 1			;display message 'enter string ( max 255 characters)'
	mov rdi,1
	mov rsi,m1
	mov rdx,lengthm1
	syscall
	
	
accept: mov rax,0			; accept a string
	mov rdi,0
	mov rsi ,array
	mov rdx ,255
	syscall
	
	dec rax				;the length of string is stored in rax by syscall 
					; deccrement it , because it includes enter key also
	mov rbx,rax 			; save it in rbx 
					
	mov rax, 1			;display message 'length of string is'
	mov rdi,1
	mov rsi,m2
	mov rdx,lengthm2
	syscall

; display the length of string

	mov rdi,lengthinascii		;point rdi to lengthinascii where digits converted to ASCII
					; are strored
	
	mov al,bl			; take length in to al , which was saved in rbx
	rol al,4			; take first digit( which is in higher nibble)into lower nibble
	and al,0fh			; mask the higher nibble 
	cmp al,9h			; check if it is between 0 to 9
	ja add37h1			; if it is more than 9 ( i.e. between A to F) then add 37h
	add al,30h			; else add 30h
	jmp skip1
	
add37h1:add al,37h
skip1:	mov [rdi],al			;save the ASCII digit in location pointed by rdl i.e.lengthinascii 
	inc rdi				; point rdi to next location to save second ASCII digit
	
	mov rax,rbx			; again take the length saved in rbx in to rax 
	and al,0fh			; mask higher nibble
	cmp al,9h			; check if it is between 0 to 9
	ja add37h2			;if it is more than 9 ( i.e. between A to F) then add 37h
	add al,30h			; else add 30h
	jmp skip2
	
add37h2:add al,37h
skip2:	mov [rdi],al			;save the ASCII digit in location pointed by rdl i.e.lengthinascii 

	mov rax,1			;display the length stored in lengthascii
	mov rdi,1
	mov rsi,lengthinascii
	mov rdx,2
	syscall

	mov rax,60			; terminate the program
	syscall
	
	
	
	
	
	
	
	

