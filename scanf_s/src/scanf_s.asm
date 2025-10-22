; A function to scan user input from console
; Can be variable length

section .bss
    input resb 8

section .text
    global scanf_s

scanf_s:
    push    ebp                         ; save registers
    mov     ebp, esp
    push    eax
    push    ebx
    push    ecx
    push    edx

    mov     eax, [ebp + 8]              ; move pointer to argument variable

    cmp     byte [eax], 25h             ; compare first byte to '%' char
    jne     exit

    inc     eax                         ; move pointer to next char in fmt string

    cmp     byte [eax], 64h             ; compare to 'd' char, decimal
    je      scan_value    
    cmp     byte [eax], 63h             ; compare to 'c' char, char
    je      scan_value
    cmp     byte [eax], 73h             ; compare to 's' char, string
    jne     exit

    scan_value:

    mov     eax, 3                      ; sys_read
    mov     ebx, 0                      ; stdin
    mov     ecx, input                  ; address to save the input to
    int     80h



    exit:
    pop     edx                         ; retrive registers
    pop     ecx
    pop     ebx
    pop     eax
    pop     ebp

    ret                                 ; return value is in EAX

section .note.GNU-stack \
    noalloc noexec nowrite progbits