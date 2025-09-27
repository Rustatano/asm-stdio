section .bss                ; .bss for uninitialized variables
    string_len: resb 1

section .text
    global printf

printf:
    mov     ecx, [esp + 4]
    call    get_string_len

    mov     eax, 4                      ; sys_write
    mov     ebx, 1                      ; stdout
    mov     edx, [string_len]
    int     80h

    mov     eax, 1
    mov     ebx, 0
    int     80h

get_string_len:
    mov     eax, 0
    count_loop:
        inc     eax
        inc     ecx
        cmp     byte[ecx], 0
        jnz     count_loop
    sub     ecx, eax
    dec     eax
    mov     [string_len], eax
    ret