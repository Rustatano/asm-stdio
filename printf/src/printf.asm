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
    mov     ecx, [esp + 8]              ; load format_string to ecx

    call    get_print_type
    
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
    
    ret

print_string:
    mov     ecx, [esp + 8]              ; the arg is on esp + 4, but calling function pushes 
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

print_decimal:
    

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