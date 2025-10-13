; Printf_s allows printing variables with different types located on stack to console.
; Syntax:
;   *in the file, where the printf_s function is being called*
;   ///
;   push    variable        - 1st argument
;   push    variable        - nth argument, optional
;   push    format_string   - last argument
;   call    printf_s          - function call, prints the variable
;   ///

section .bss
    buffer resb 1

section .data
    negative_sign db 2Dh                ; '-' minus character

section .text
    global printf_s

printf_s:
    xor     edi, edi                    ; nullify EDI
    xor     esi, esi                    ; nullify ESI

    pop     ebx                         ; function address
    pop     edi                         ; load formatting string to EDI, preserved through the entire program, not optimal
                                        ;   TODO: optimalize
    push    ebx                         ; push function address back
    
    print_arg:
        cmp     byte [edi], 25h         ; compare first byte to '%' char
        je      print_arg_continue      ; if it's formatting string
        cmp     byte [edi], 0
        je      exit

        mov     [buffer], edi           ; move pointer to fmt string to EAX
        call    print_char
        jmp     next_arg

        print_arg_continue:
        inc     edi                     ; move to next char, should be s, d, c..., if input is correct

        pop     ebx                     ; function address
        pop     eax                     ; load value to print to EAX
        mov     [buffer], eax
        push    ebx                     ; push function address back

        cmp     byte [edi], 73h         ; compare to 's' char, string
        jne     not_string
        call    print_string            ; jump to print_string if fmt_str = "%s"
        jmp     next_arg
        not_string:

        cmp     byte [edi], 64h         ; compare to 'd' char, decimal
        jne     not_decimal
        call    print_decimal           ; jump to print_decimal if fmt_str = "%d"
        jmp     next_arg
        not_decimal:
        
        cmp     byte [edi], 63h         ; compare to 'c' char, char
        jne     print_percent_char      ; if nothing matches, print it as a character
        call    print_char              ; jump to print_char if fmt_str = "%c"

        next_arg:
        inc     edi                     ; increment pointer to next argument, should be '\0' or '%', if input is correct
        jmp     print_arg

    exit:
        ret

    print_percent_char:
        pop     ebx                     ; function address
        push    eax                     ; save value to print back to stack, it will be popped afterwards
        push    ebx                     ; push function address back
        dec     edi                     ; move pointer to '%' char
        mov     eax, edi                ; move the pointer to eax
        call    print_char
        jmp     next_arg

print_string:
    mov     ecx, eax                    ; move value to print from EAX, to ECX 

    print_chars_loop:
        mov     eax, ecx                ; print_char arg1
        call    print_char

        inc     ecx                     ; move pointer to next char
        cmp     byte [ecx], 0           ; compares byte at mem address pointing to ECX with 0 (null byte)
        jnz     print_chars_loop        ; jump if not zero

    ret

print_char:
    mov     ecx, buffer                 ; move char to ECX

    mov     eax, 4                      ; sys_write
    mov     ebx, 1                      ; stdout
    mov     edx, 1                      ; set output length to one
    int     80h                         ; print

    ret

print_decimal:
    xor     ecx, ecx                    ; nullify ECX
    xor     esi, esi                    ; nullify ESI

    mov     [buffer], eax

    cmp     eax, 0                      ; check if integer is greater or equal to 0
    jge     save_digit_loop                    

    mov     esi, eax                    ; temporarily save EAX to ESI, ESI isn't used for a while
    mov     eax, negative_sign          ; relative load negative sign character to print it

    call    print_char
    mov     eax, esi                    ; load temporarily saved EAX
    mov     esi, -1                     ; absolute value of integer
    mul     esi


    save_digit_loop:
        xor     edx, edx                ; nullifies EDX, it's above 'cmp eax, 0' so it doesn't messes with 'jne', because 'xor' creates flag tahat messes with jump
        
        mov     ebx, 10
        div     ebx                     ; EAX = EAX / EBX, remainder -> EDX

        add     edx, 48                 ; ASCII move
        push    edx                     ; move value of char to be printed to buffer
        inc     esi

        cmp     eax, 0                  ; compare if there is any number left to save, quotient of division
        jne     save_digit_loop         ; jump if not equals 0

    mov     edx, 1                      ; applies to the whole 'print_digit_loop'
    print_digit_loop:                   ; second loop, because it's pushed to stack in reverse order
        pop     eax                     ; load to ECX pointer to digit

        mov     [buffer], eax           ; print_char arg1
        call    print_char              ; print the digit

        dec     esi                     ; decrement digit count by 1
        cmp     esi, 0                  ; compare if there are any digits left to be printed, digit count -> ESI

        jne     print_digit_loop        ; jump if not equals 0

    ret

section .note.GNU-stack \
    noalloc noexec nowrite progbits

; TODO: multiple args printed, multiple formatting chars in formatting string
; loop

