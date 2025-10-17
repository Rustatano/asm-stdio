; A function to scan user input from console
; Can be variable length

section .bss
    input resb 8

section .text
    global scanf_s

scanf_s:
    push    ebp                         ; save registers
    mov     ebp, esp
    ;push    eax
    push    ebx
    ;push    ecx
    push    edx

    mov     eax, [ebp + 8]              ; move pointer to argument variable


    cmp     byte [eax], 25h             ; compare first byte to '%' char
    jne     exit

    inc     eax                         ; move pointer to next char in fmt string

    cmp     byte [eax], 64h             ; compare to 'd' char, decimal
    jne     exit;not_decimal
    ; incorrect: mov     edx, 11                     ; move max signed integer digit length to EDX + newline char
    not_decimal:

    mov     eax, 3                      ; sys_read
    mov     ebx, 0                      ; stdin
    mov     ecx, input                  ; address to save the input to
    ;mov     edx, 1                      ; maximum length of input
    int     80h

    exit:
    pop     edx                         ; retrive registers
    ;pop     ecx
    pop     ebx
    ;pop     eax
    pop     ebp

    ret                                 ; return value is in EAX

section .note.GNU-stack \
    noalloc noexec nowrite progbits