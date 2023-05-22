;4 ALP to count positive & negative numbers in given set of numbers
; assumption : the total count of both positive & negative numbers is less than 10
section .data
	m1 db ' total postive numbers: ',10 
	m1length equ $-m1
	m2 db 10,10,' total negative numbers: ',10,10
	m2length equ $-m2
	
	array db 1 ,-2 ,-3 , 4,5,6
	
section .bss
	pos1 resb 1 	;
	neg1 resb 1	;
	pos1ascii resb 2
	neg1ascii resb 2
	
section .text
	global _start
	_start:
	 mov byte[pos1],0
	 mov byte[neg1],0
	mov rsi, array
	mov cx,6
	
back:	mov al, [rsi]
	cbw 
	bt ax,15
	jc incneg
	inc byte[pos1]
	jmp next
	
incneg:	inc byte[neg1]
next:	inc rsi
	dec cx
	jnz back
	
	mov rax,1
	mov edi,1
	mov rsi,m1
	mov rdx, m1length
	syscall
		
	
        mov bl,byte[pos1] ;store number in bl
        mov rdi, pos1ascii ;point rdi to result variable
        mov cx,02 ;load count of rotation in cl
up1:
        rol bl,04 ;rotate number left by four bits
        mov al,bl ;move lower byte in dl
        and al,0fh ; get only LSB
        add al,30h
       
	  mov [rdi],al ;store ascii code in result variable
        inc rdi ;point to next byte
        dec cx ;decrement the count of digits to display
        jnz up1 ;if not zero jump to repeat
        
        mov rax,1
	mov edi,1
	mov rsi,pos1ascii
	mov rdx, 2
	syscall
        
     mov bl,byte[neg1] ;store number in bl
        mov rdi, neg1ascii ;point rdi to result variable
        mov cx,02 ;load count of rotation in cl
up2:
        rol bl,04 ;rotate number left by four bits
        mov al,bl ;move lower byte in dl
        and al,0fh ; get only LSB
        add al,30h
       
	  mov [rdi],al ;store ascii code in result variable
        inc rdi ;point to next byte
        dec cx ;decrement the count of digits to display
        jnz up2 ;if not zero jump to repeat
        
        mov rax,1
	mov edi,1
	mov rsi,m1
	mov rdx, m1length
	syscall
	
        mov rax,1
	mov edi,1
	mov rsi,neg1ascii
	mov rdx, 2
	syscall
       
       mov rax,60
       mov rdi,1
       syscall


