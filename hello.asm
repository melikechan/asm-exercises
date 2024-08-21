section .data
    meaning_of_life db 0x2a
    msg db "The meaning of life is: ", 0
    buffer db "00", 0

section .text
    global _start

itoa:
    mov rcx, 10
    xor rdx, rdx
    xor r8, r8

    div_loop:
        xor rdx, rdx
        div rcx
        add dl, '0'
        push dx
        inc r8
        test rax, rax
        jnz div_loop

        lea rsi, [buffer]
        
    pop_loop:
        pop dx
        mov [rsi], dl
        inc rsi
        dec r8
        jnz pop_loop

    mov byte [rsi], 0
    ret

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, 24
    syscall

    movzx rax, byte [meaning_of_life]
    call itoa

    mov rax, 1
    mov rdi, 1
    lea rsi, [buffer]
    mov rdx, 2
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall