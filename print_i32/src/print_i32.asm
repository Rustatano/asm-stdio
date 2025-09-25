section .bss
    int_length: resb 4                              ; represents length of number, that will be printed (serves as counter)
    is_negative: resb 1                             ; represents negative sign

section .text
    global print_i32                                ; set global function for assembler

print_i32:                                          ; function to print 32-bit integers
    push    eax                                     ; push all four registers to stack to save them from overwriting
    push    ebx
    push    ecx
    push    edx

    mov     ebx, 10                                 ; store divisor in EBX

    cmp     eax, 0                                  ; set negative sign to 0/1
    jl      negative
    jge     positive


    negative:
        neg     eax
        mov     edx, 1
        jmp     next

    positive:
        mov     edx, 0                              ; set 'int_length' value to 0

    next:
        mov     [is_negative], edx
        mov     [int_length], edx

    digit_split_loop:                               ; loop to push each digit of the number to stack
        mov     edx, [int_length]                   ; increment 'int_length'
        inc     edx
        mov     [int_length], edx

        mov     edx, 0                              ; resets the value of EDX to 0
        div     ebx                                 ; n / 10 = whole number stored in EAX & remainder stored in EDX
        add     edx, 48                             ; add 48 to remainder (48 -> 0 in ASCII) (48 - 57 are digits in ASCII) 
        push    edx                                 ; push the digit to stack

        cmp     eax, 0                              ; compare EAX to 0, because one-digit number divided by 10 is 0 + remainder
        jg      digit_split_loop                    ; condition if greater -> jump

    mov     edx, [is_negative]                      ; if negative_sign = 1 -> push '-' to stack
    cmp     edx, 1
    je      negative_sign
    jg      print_stack_loop
    jl      print_stack_loop


    negative_sign:                                  ; push 45 ('-') to stack
        push    45

    print_stack_loop:
        mov     eax, 4                              ; set descriptors
        mov     ebx, 1

        mov     edx, 1                              ; print digit from stack
        mov     ecx, esp
        int     80h

        add     esp, 4                              ; move sp to next digit

        mov     edx, [int_length]                   ; decrement value of 'int_length'
        dec     edx
        mov     [int_length], edx

        mov     edx, [int_length]                   ; compare 'int_length' 
        cmp     edx, 0
        mov     [int_length], edx

        jg      print_stack_loop                    ; condition: if greater -> jump

    print_newline:
        push    10                                  ; 10 represents newline symbol in ASCII
        mov     eax, 4                              ; set descriptors
        mov     ebx, 1  

        mov     edx, 1                              ; print newline
        mov     ecx, esp    
        int     80h 

    add     esp, 4                                  ; move sp from '10' to original EDX value

    pop     edx                                     ; pop original register values from stack
    pop     ecx
    pop     ebx
    pop     eax

    ret                                             ; return value is value in EAX (original number to print)

