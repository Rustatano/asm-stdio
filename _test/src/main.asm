section .data
    string db 'Hello World!', 0Ah, 0h ; declare string variable with new line character at the end and null char
    format_string db '%s', 0h
    num db 1538

section .text
    global  _start
    extern  printf

_start:
    push    format_string               ; push formating string to stack,
                                        ;   used to determine if string or number or something else will be printed,
                                        ;   first parameter of printf function
    push    string                      ; push address of string to stack as second function parameter`
    call    printf

    mov     eax, 1                      ; exit
    mov     ebx, 0
    int     80h