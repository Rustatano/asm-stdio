; Printf allows printing variables with different types located on stack to console.
; Syntax:
;   *in the file, where the printf function is being called*
;   ///
;   push    format_string   - 1st parameter
;   push    variable        - 2nd parameter
;   call    printf          - function call, prints the variable
;   ///


section .text
    global printf

printf:
    ;mov     ecx, [esp + 8]              ; load format_string to ecx

    pop     ebx                         ; function address
    pop     eax                         ; load value to print to EAX
    pop     ecx                         ; load formattingn string to ECX
    push    ebx                         ; push afunction address back

    call    get_print_type

    ret

get_print_type:
    cmp     byte [ecx], 25h             ; compare first byte to '%' char
    jne     exit                        ; exit program if doesn't equal
    inc     ecx                         ; move to next char

    cmp     byte [ecx], 73h             ; compare to 's' char, string
    je      print_string                ; jump to print_string if fmt_str = "%s"

    cmp     byte [ecx], 64h             ; compare to 'd' char, decimal
    je      print_decimal               ; jump to print_decimal if fmt_str = "%d"

    cmp     byte [ecx], 63h             ; compare to 'c' char, decimal
    je      print_char                  ; jump to print_char if fmt_str = "%c"
    
    ret

print_string:
    mov     ecx, eax                    ; move value to print from EAX, to ECX 
                                        ;   it's address to stack and ret pops it back, so it 
                                        ;   needs to be 4 bytes more,
                                        ;   jump instruction doesn't push anything to stack
    xor     edx, edx                    ; counter set to 0, xor should be faster than mov
    count_chars:
        mov     eax, ecx                ; print_char arg1
        call    print_char

        inc     ecx                     ; move pointer to next char
        cmp     byte [ecx], 0           ; compares byte at mem address pointing to ECX with 0 (null byte)
        jnz     count_chars             ; jump if not zero

    ret

print_char:
    mov     ecx, eax                    ; move char to ECX

    mov     eax, 4                      ; sys_write
    mov     ebx, 1                      ; stdout
    mov     edx, 1                      ; set output length to one
    int     80h                         ; print

    ret

print_decimal:
    mov     eax, [eax]                  ; dereference the pointer to value
    mov     ebx, 10                     ; divisor
    xor     ecx, ecx
    xor     esi, esi
    save_digit_loop:
        xor     edx, edx                ; nullifies EDX, it's above 'cmp eax, 0' so it doesn't messes with 'jne', because 'xor' creates flag tahat messes with jump
        
        div     ebx                     ; EAX = EAX / ebx, remainder -> EDX

        add     edx, 48                 ; ASCII move
        push    edx                     ; push remainder character to stack
        mov     ecx, esp                ; pointer to digit character on stack, so it can be printed
        mov     edx, 1                  ; set printing length

        inc     esi

        cmp     eax, 0                  ; compare if there is any number left to save, quotient of division
        jne     save_digit_loop         ; jump if not equals 0

    mov     edx, 1                      ; applies to the whole 'print_digit_loop'
    print_digit_loop:
        mov     ecx, esp                ; load to ECX pointer to digit

        mov     eax, ecx                ; print_char arg1
        call    print_char              ; print the digit

        pop     ecx                     ; waste, remove the printed character from stack
        cmp     esi, 0                  ; compare if there are any digits left to be printed, digit count

        dec     esi                     ; decrement digit count by 1

        jne     print_digit_loop        ; jump if not equals 0
    ret

exit:                                   ; exit program with return value 1
    mov     eax, 1
    mov     ebx, 1
    int     80h

; TODO: print negative numbers