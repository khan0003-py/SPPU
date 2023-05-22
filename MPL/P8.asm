;8.asm ALP for multiplication of two 8 bit numbers by successive addition & shift ADD methods
%macro dispmsg 2
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro

%macro accept 2
	mov rax,0
	mov rdi,0
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro


section .data

msg db 10,'Enter two digit Number::'
msg_len equ $-msg
res db 10,'Multiplication of elements is::'
res_len equ $-res
choice db 10,13,'Enter your Choice:'
       db 10,13,'1.Successive Addition'
       db 10,13,'2.Add and Shift method'
       db 10,13,'3.Exit'
choice_len equ $-choice


section .bss

	num resb 03
	num1 resb 01
	result resb 04
	cho resb 2


section .text

	global _start
_start:

	mov rax,00			; clear reuired registers & locations 					;to 0
	mov rbx,00
	mov rcx,00
	mov rdx,00
	mov byte[result],0
	mov byte[num],0
	mov byte[num1],0

 	dispmsg choice,choice_len  ; accept choic & call related 							;procedure
	accept cho,2

	cmp byte[cho],31h
	je a

	cmp byte[cho],32h
	je b
	
     jmp exit

a:	call Succe_addition

	jmp _start

b:   	call Add_shift

	jmp _start



exit:
	mov rax,60 
	mov rdi,0
	syscall

convert:				;convert accepted numbers from ASCII 						;to hex
	mov rbx,00
	mov rcx,00
	mov rax,00

	mov rcx,02
	mov rsi,num
up1:
	rol bl,04

	mov al,[rsi]
	cmp al,39h
	jg p1
	sub al,30h
	jmp p2
p1: 	sub al,37h
p2: 	add bl,al
	inc rsi
	loop up1
ret

display:				; convert result from hex to ASCII 						;before display
	mov rcx,4
	mov rdi,result
dup1:
	rol bx,4
	mov al,bl
	and al,0fh
	cmp al,09h
	jg p3
	add al,30h
	jmp p4
p3: 	add al,37h
p4:	mov [rdi],al
	inc rdi
	loop dup1

	dispmsg result,4
ret


Succe_addition:				;succesive addition method

	dispmsg msg,msg_len
	accept num,3

	call convert
	mov [num1],bl
	
	dispmsg msg,msg_len
	accept num,3
	call convert
	mov rcx,00
	mov rax,00
	mov rax,[num1]
	
repet:
	add rcx,rax
	dec bl
	jnz repet

	mov [result],rcx
	dispmsg res,res_len
	mov rbx,[result]

	call display
ret



Add_shift:					; shift & add method
 	

	dispmsg msg,msg_len
	accept num,3

	call convert
	mov [num1],bl
	
	dispmsg msg,msg_len
	accept num,3
	call convert

	mov [num],bl

	mov  rbx,00
	mov rcx,00
	mov rdx,00
	mov rax,00
	mov dl,08
	mov al,[num1]
	mov bl,[num]

p11:	shr bx,01
	jnc p
	add cx,ax
p:	shl ax,01
	dec dl
	jnz p11

	mov [result],rcx
	dispmsg res,res_len

	mov rbx,[result]
	call display

ret

