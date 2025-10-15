; Printf_s allows printing variables with different types located on stack to console.
; Syntax (old):
;   *in the file, where the printf_s function is being called*
;   ///
;   push    variable        - 1st argument
;   push    variable        - nth argument, optional
;   push    format_string   - last argument
;   call    printf_s          - function call, prints the variable
;   ///

section .text
    global printf_s

printf_s:
    push    ebp                         ; save base pointer
    mov     ebp, esp                    ; set up stack frame
    push    edi                         ; save callee-saved registers
    push    esi
    push    ebx

    xor     edi, edi                    ; nullify EDI
    xor     esi, esi                    ; nullify ESI

    mov     edi, [ebp + 8]              ; load formatting string to EDI

    lea     esi, [ebp + 12]             ; load stack pointer and move pointer to 1st argument
    
    print_arg:
        cmp     byte [edi], 25h         ; compare first byte to '%' char
        je      print_arg_continue      ; if it's formatting string
        cmp     byte [edi], 0           ; check if  it's '\0' char
        je      exit

        mov     eax, edi                ; move pointer to fmt string char to EAX
        call    print_string_char       ; print non fmt character

        jmp     next_arg

        print_arg_continue:
        inc     edi                     ; move to next char, should be s, d, c..., if input is correct

        cmp     byte [edi], 73h         ; compare to 's' char, string
        jne     not_string
        mov     eax, [esi]              ; load value to print, dereference -> string
        call    print_string            ; jump to print_string if fmt_str = "%s"
        jmp     add4_to_esi
        not_string:

        cmp     byte [edi], 64h         ; compare to 'd' char, decimal
        jne     not_decimal
        mov     eax, [esi]              ; load value to print -> pointer to integer
        call    print_decimal           ; jump to print_decimal if fmt_str = "%d"
        jmp     add4_to_esi
        not_decimal:
        
        cmp     byte [edi], 63h         ; compare to 'c' char, char
        jne     print_percent_char      ; if nothing matches, print it as a character
        mov     eax, esi                ; load value to print -> pointer to char
        call    print_char              ; jump to print_char if fmt_str = "%c"

        add4_to_esi:
        add     esi, 4                  ; move pointer to next argument

        next_arg:
        inc     edi                     ; increment pointer to next argument, should be '\0' or '%', if input is correct
        jmp     print_arg

    exit:
        pop     ebx                     ; restore callee-saved registers
        pop     esi
        pop     edi
        pop     ebp                     ; restore base pointer
        ret

    print_percent_char:
        dec     edi                     ; move pointer to '%'
        mov     eax, edi                ; move the pointer to EAX

        call    print_string_char       ; print '%'

        jmp     next_arg

print_string:
    call    print_string_char           ; print char
    
    inc     eax                         ; move pointer to next char
    cmp     byte [eax], 0               ; compares byte at mem address pointing to ECX with 0 (null byte)
    jnz     print_string                ; jump if not zero

    ret

print_string_char:
    push    eax                         ; save values of EAX and ECX registers
    push    ecx

    mov     ecx,  eax                   ; load pointer to character to ECX

    mov     eax, 4                      ; print sequence
    mov     ebx, 1
    mov     edx, 1
    int     80h

    pop     ecx                         ; load back saved values
    pop     eax

    ret

print_char:
    mov     ecx, eax

    mov     eax, 4                      ; sys_write
    mov     ebx, 1                      ; stdout
    mov     edx, 1                      ; set output length to one
    int     80h                         ; print

    ret

print_decimal:
    push    esi                         ; save value of ESI

    xor     ecx, ecx                    ; nullify ECX
    xor     esi, esi                    ; nullify ESI

    cmp     eax, 0                      ; check if integer is greater or equal to 0
    jge     save_digit_loop                    

    mov     esi, eax                    ; temporarily save EAX to ESI, ESI isn't used for a while

    mov     eax, 2Dh                    ; load '-' char to EAX
    push    eax                         ; push '-' to stack to print it
    mov     eax, esp                    ; move pointer to '-' to EAX
    call    print_char                  ; print '-'
    pop     eax                         ; delete '-'

    mov     eax, esi                    ; load temporarily saved EAX
    mov     esi, -1                     ; absolute value of integer
    mul     esi

    xor     esi, esi

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
        mov     eax, esp                ; argument for printing char

        call    print_char              ; print the digit

        dec     esi                     ; decrement digit count by 1
        cmp     esi, 0                  ; compare if there are any digits left to be printed, digit count -> ESI

        pop     eax                     ; delete digit
        jne     print_digit_loop        ; jump if not equals 0

    pop     esi                         ; retrieve value of ESI
    ret

section .note.GNU-stack \
    noalloc noexec nowrite progbits

