section .data
    string db 'Hello World!', 0Ah, 0h   ; declare string variable with new line character at the end and null char
    char db 'H',                        ; declare char variable
    format_string db '%d', 0h           ; declare formatting string, char - '%c', deciaml - '%d', string - '%s'
    num dd 9                            ; dd instead of db, important

section .text
    global  _start
    extern  printf

_start:
    push    format_string               ; push formating string to stack,
                                        ;   used to determine if string or number or something else will be printed,
                                        ;   first parameter of printf function
    ;push    string                      ; push address of string to stack as second function parameter`
    push    num
    ;push    char
    call    printf



    ; -----int printing principle ---------
    ;mov     ecx, [num]      ; load from variable
    ;add     ecx, 4          ; here do something with the number
    ;add     ecx, 48         ; make it char, from ascii table
    ;mov     [num], ecx      ; save to variable
    ;push    num             

    ;mov     eax, 4
    ;mov     ebx, 1
    ;pop     ecx
    ;mov     edx, 1
    ;int     80h
    ; -------------------------------------

    mov     eax, 1                      ; exit
    mov     ebx, 0
    int     80h