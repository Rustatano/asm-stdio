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

    call    print_irq

    ret

print_irq:
    mov     eax, 4                      ; sys_write
    mov     ebx, 1                      ; stdout
    int     80h                         ; print

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
    mov     ecx, eax                    ; move value to print from EAX, to ecx 
                                        ;   it's address to stack and ret pops it back, so it 
                                        ;   needs to be 4 bytes more,
                                        ;   jump instruction doesn't push anything to stack
    mov     edx, 0                      ; counter set to 0
    count_chars:
        inc     edx                     ; counter += 1
        inc     ecx                     ; move pointer to next char
        cmp     byte [ecx], 0           ; compares byte at mem address pointing to ecx with 0 (null byte)
        jnz     count_chars             ; jump if not zero
    sub     ecx, edx                    ; move string pointer back to start of the string
    
    ret

print_char:
    mov     ecx, eax                    ; move char to ECX
    mov     edx, 1                      ; set output length to one

    ret

print_decimal:
    ; 10 ** 1       |   10 ** 2             |   10 ** 3                 | 10 ** 4               | 
    ; 1530 z 8      |   1500 z 30 / 10 ** 1 |   1000 z 500 / 10 ** 2    | 0 z 1000 / 10 ** 3    | end of loop if quotient == 0
    
    ; loop
    ; ecx = 10
    ; 
    ; eax / ecx ** esi = eax, z edx
    ; 
    ; eax = char edx
    ; edx = 1
    ; push ebx
    ; print
    ; jmp loop

    ; edx - remainder
    ; mov     eax, 102
    ; mov     edx, 0
    ; mov     ecx, 10
    ; div     ecx
    ; eax -> 10
    ; edx -> 2
        
    mov     ecx, 10 ; divisor
    mov     esi, 10 ; exponent
    
    div     esi

    add     edx, 48
    push    edx
    pop     ecx
    mov     edx, 1

    call    print_irq

    mul     esi     ; power +1
    


    ; 1538 -> 1000, 500, 30, 8
    ; get num size
    ; num / 1000 = d1
    ; push d1
    ; num / 100 = d2
    ; push d2
    ; .
    ; .
    ; .
    ; for digit in stack, push digit + 48 to make it char to ecx
    ret

exit:                                   ; exit program with return value 1
    mov     eax, 1
    mov     ebx, 1
    int     80h