;3 ALP to find maximum numbers in given numbers
; assumption : maximum numbers to be checked are 5
;	     : all numbers are less than 100 ( i.e. they have two digits)
;	     : all numbers are positive 		

section .data

	m1 db 'maximum number is: ' ,10
	m1length equ $-m1
	array db 11h,89h,34h,56h,23h
	
section  .bss
	
	maxnumascii resb 2	; two digits of namximum number after converted to ASCII 
				;  will be stored here
section .text

	global _start
	_start:

	mov rsi, array		; point rsi to array
	mov cx,5		; counter for 5 numbers 
	mov al,byte[rsi]	; take first number from array in al and assume it as max

next:	cmp al , byte[rsi]	; compare it with each number in array
	Ja nochange		; if al > number in array , keep al as max

	mov al, byte[rsi]	; else set that number as max & store in al

nochange: inc si		; take next number in array
	dec cx			; check if all 5 numbers are compared
	jnz next

	mov bl , al		; max number is in al , save it in bl

	mov rax,1		; display message 'maximum number is:'
	mov rdi,1
	mov rsi,m1
	mov rdx , m1length
	syscall

	mov rsi, maxnumascii	; point rsi to maxnumascii tosave digits of max after 	
				;converting to ASCII
	
	mov al, bl		; take max number which was saved in bl
	ror al ,4		; take its first digit to lower nibble
	and al,0fh		; mask upper nibble
	add al,30h		; convert to ascii by adding 30h
	mov byte[rsi] ,al	; & save it

	

	inc rsi			;point rsi to next location to save next ascii digit
	mov al, bl		; again take max number which was saved in bl
	and al,0fh		;mask upper digit 
	add al,30h		; convert digit in lower nibble to ASCII by adding 30h
	mov byte[rsi] ,al	; & save it

	
	mov rax,1		; display the two digits of max number saved at maxnumascii
	mov rdi,1
	mov rsi,maxnumascii
	mov rdx ,2
	syscall

	mov rax, 60		;exit the program
	syscall

	
	

	


