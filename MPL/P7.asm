; 7.asm
; ALP Block Transfer - overlapped with String instruction.

section .data
    nline db 10,10
    nline_len equ $-nline
    space db " "
    ano db 10, "Block Transfer - overlapped without String instruction.", 10
    ano_len equ $-ano
    bmsg db 10, "Before Transfer::"
    bmsg_len equ $-bmsg
    amsg db 10, "After Transfer::"
    amsg_len equ $-amsg
    smsg db 10, " Source Block :"
    smsg_len equ $-smsg
    dmsg db 10, " Destination Block :"
    dmsg_len equ $-dmsg
    sblock db 11h, 22h, 33h, 44h, 55h
    blank times 5 db 0
    
section .bss
    char_ans resB 2 ; char_ans is of 2 bytes because we have 2-byte numbers
    
%macro Print 2
    MOV RAX, 1
    MOV RDI, 1
    MOV RSI, %1
    MOV RDX, %2
    syscall
%endmacro

%macro Read 2
    MOV RAX, 0
    MOV RDI, 0
    MOV RSI, %1
    MOV RDX, %2
    syscall
%endmacro

%macro Exit 0
    Print nline, nline_len
    MOV RAX, 60
    MOV RDI, 0
    syscall
%endmacro

section .text
global _start

_start:
    Print ano, ano_len
    Print bmsg, bmsg_len ; Block values before transfer
    Print smsg, smsg_len
    mov rsi, sblock ; As RSI is used to point to source as well as destination block
    call disp_block ; Assign source and destination block separately before the call
    Print dmsg, dmsg_len
    mov rsi, sblock+2 ; Destination block starts at 3rd location from the start of source block
    call disp_block
    call BT_NO ; Call for actual block transfer
    Print amsg, amsg_len ; Block values after transfer
    Print smsg, smsg_len
    mov rsi, sblock
    call disp_block
    Print dmsg, dmsg_len
    mov rsi, sblock+2 ; Destination block starts at 3rd location from the start of source block
    call disp_block
    Exit

;-----------------------------------------------------------------
BT_NO:
    mov rsi, sblock+4
    mov rdi, sblock+6
    mov rcx, 5
    std
    rep movsb
    ret

;-----------------------------------------------------------------
disp_block:
    mov rbp, 5 ; Counter as 5 values
next_num:
    mov al, [rsi] ; Moves 1 value to RSI
    push rsi ; Push RSI on the stack as it gets modified in Disp_8
    call Disp_8
    Print space, 1
    pop rsi ; Pop RSI that was pushed on the stack
    inc rsi
    dec rbp
    jnz next_num
    ret

;---------------------------------------------------------------
Disp_8:
    MOV RSI, char_ans+1
    MOV RCX, 2 ; Counter
    MOV RBX, 16 ; Hex number
next_digit:
    XOR RDX, RDX
    DIV RBX
    CMP DL,9
    JBE add30
    ADD DL,07H
add30 :
    ADD DL,30H
    MOV [RSI],DL
    DEC RSI
    DEC RCX
    JNZ next_digit
    Print char_ans,2
    ret