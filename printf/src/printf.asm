section .text
    global printf

printf:
    mov     ecx, [esp + 4]              ; load string address to ecx
    
    call    get_string_len

    mov     eax, 4                      ; sys_write
    mov     ebx, 1                      ; stdout
    int     80h                         ; print

    mov     eax, 1                      ; sys_exit
    mov     ebx, 0                      ; return value 0
    int     80h                         ; exit

get_string_len:
    mov     edx, 0                      ; counter set to 0
    count_loop:
        inc     edx                     ; counter += 1
        inc     ecx                     ; move pointer to next char
        cmp     byte[ecx], 0            ; 
        jnz     count_loop              ; jump if not zero
    sub     ecx, edx                    ; move string pointer back to start of the string
    dec     edx                         ; remove null char
    ret