 ICANON      equ 1<<1
    ECHO        equ 1<<3

    sys_exit    equ 1
    sys_read    equ 3
    sys_write   equ 4
    stdin       equ 0
    stdout      equ 1
 
    global _start
   
    section     .data
    szAsterisk  db  "*"
    szLF        db  10
    pwd 	db "123"

    correct db " access granted",10
    correctlen equ $-correct

    incorrect db " access denied",10
    incorrectlen equ $-incorrect
 

    section     .bss
    lpBufIn     resb    2
    lpPassIn    resb    24
    termios     resb    36

    section .text
    _start:
       
        call    echo_off
        call    canonical_off

        xor     esi, esi
    .GetCode:   
        
       
        call    GetKeyCode
        mov     al, byte[lpBufIn]
       
        cmp     al, 10
        je      .Continue

        mov     byte [lpPassIn + esi], al
        call    PrintAsterisk
        inc     esi
        jmp     .GetCode
   
    .Continue:
         mov     byte [lpPassIn + esi], 0          
        ;~ Compare passowrds here!!!
	mov cx,3
	mov esi , lpPassIn
	mov edi , pwd
check:	mov al,[esi]
	mov bl,[edi]
	cmp al,bl
	jne disp_incorrect
	inc esi
	inc edi
	dec cx
	jnz check
       ; 
	;cld
	;repz	cmpsb
	;cmp cx,0
	;jne disp_incorrect

	mov rax,01
	mov rdi,01
	mov rsi,correct
	mov rdx,correctlen
	syscall
	 
        jmp     Done

disp_incorrect:

	mov rax,01
	mov rdi,01
	mov rsi,incorrect
	mov rdx,incorrectlen
	syscall
       
  
       
    Done:
        call    echo_on
        call    canonical_on

        mov     eax, sys_exit
        xor     ebx, ebx
        int     80H
       
    ;~ #########################################
    GetKeyCode:
        mov     eax, sys_read
        mov     ebx, stdin
        mov     ecx, lpBufIn
        mov     edx, 1
        int     80h
        ret
   
    ;~ #########################################
    PrintAsterisk:	
        mov     edx, 1
        mov     ecx, szAsterisk
        mov     eax, sys_write
        mov     ebx, stdout
        int     80H     
        ret		       
       
    ;~ #########################################
    canonical_off:
            call read_stdin_termios

            ; clear canonical bit in local mode flags
            mov eax, ICANON
            not eax
            and [termios+12], eax

            call write_stdin_termios
            ret
           
    ;~ #########################################
    echo_off:
            call read_stdin_termios

            ; clear echo bit in local mode flags
            mov eax, ECHO
            not eax
            and [termios+12], eax

            call write_stdin_termios
            ret

    ;~ #########################################
    canonical_on:
            call read_stdin_termios

            ; set canonical bit in local mode flags
            or dword [termios+12], ICANON

            call write_stdin_termios
            ret

    ;~ #########################################
    echo_on:
            call read_stdin_termios

            ; set echo bit in local mode flags
            or dword [termios+12], ECHO

            call write_stdin_termios
            ret

    ;~ #########################################
    read_stdin_termios:
            mov eax, 36h
            mov ebx, stdin
            mov ecx, 5401h
            mov edx, termios
            int 80h
            ret

    ;~ #########################################
    write_stdin_termios:
            mov eax, 36h
            mov ebx, stdin
            mov ecx, 5402h
            mov edx, termios
            int 80h
            ret
