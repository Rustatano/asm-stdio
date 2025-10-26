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

    mov     eax, [ebp + 8]              ; move pointer to fmt string argument

    cmp     byte [eax], 25h             ; compare first byte to '%' char
    jne     exit

    inc     eax                         ; move pointer to next char in fmt string

    cmp     byte [eax], 64h             ; compare to 'd' char, decimal
    je      scan_decimal                ; TODO: scan decimal, parsing strin to number
    cmp     byte [eax], 63h             ; compare to 'c' char, char
    je      scan_string_char
    cmp     byte [eax], 73h             ; compare to 's' char, string
    je      scan_string_char

    scan_decimal:
    jmp     exit
    scan_string_char:
    mov     eax, 3                      ; sys_read
    mov     ebx, 0                      ; stdin
    ;mov     ecx, [ebp + 12]             ; address to save the input to
    mov     ecx, input                  ; load pointer to 'input' variable
    int     80h

    mov     ecx, [ecx]                  ; get value on 'input' address saved in ECX
    mov     eax, [ebp + 12]             ; load pointer to strin variable on stack
    mov     [eax], ecx                  ; set value on address in EAX to value in ECX


    ; TODO: remove newline char in scanned string

    exit:
    pop     edx                         ; retrive registers
    pop     ecx
    pop     ebx
    pop     eax
    pop     ebp

    ret                                 ; return value is in EAX

section .note.GNU-stack \
    noalloc noexec nowrite progbits