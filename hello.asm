section .data
    meaning_of_life db 0x2a
    msg db "The meaning of life is: ", 0
    buffer db "00", 0

section .text
    global _start

itoa:
    mov ecx, 10
    xor edi, edi
    xor edx, edx

    div_loop:
        xor edx, edx
        div ecx
        add dl, '0'
        push dx
        inc edi
        test eax, eax
        jnz div_loop

        mov ecx, edi
        lea edi, [buffer]
    
    pop_loop:
        pop dx
        mov [edi], dl
        inc edi
        loop pop_loop


    mov byte [edi], 0
    ret

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 24
    int 0x80

    mov eax, meaning_of_life
    lea ebx, [buffer]
    call itoa

    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, 2
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80