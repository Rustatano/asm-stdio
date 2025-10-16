; A function to scan user input from console
; Can be variable length

section .bss
    string resb 8

section .text
    global scanf_s

scanf_s:              
    mov     eax, 3                      ; sys_read
    mov     ebx, 0                      ; stdin
    mov     ecx, string                 ; address to save the input to
    mov     edx, 8                      ; maximum length of input
    int     80h

    mov     eax, ecx                    ; move ECX to EAX, EAX is return value

    ret

section .note.GNU-stack \
    noalloc noexec nowrite progbits