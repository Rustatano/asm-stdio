section .data
    string: db 'Hello World!', 0Ah          ; declare string variable with new line character at the end
    string_len: equ $-string                ; get length of stringand save it to variable
    num: db 153

section .text
    global  _start
    extern  printf

_start:
    push    string          ; push address of string to stack
    call    printf

    mov     eax, 1          ; exit
    mov     ebx, 0
    int     80h