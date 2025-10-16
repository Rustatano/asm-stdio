section .data
    string db "ello", 0h                ; declare string variable with new line character at the end and null char
    char db 'H'                         ; declare char variable
    char_new_line db 0Ah
    fmt_str_s db "%s", 0h               ; declare formatting string, char - '%c', deciaml - '%d', string - '%s'
    fmt_str_c db "%c", 0h
    fmt_str_d db "%d", 0h
    fmt_str_f db "%f", 0h
    fmt_str_c_s_d db \
    "%c%s, World! %r %d %[]", 0h        ; able to print complex formatting string

    neg_num dd -1538                    ; dd instead of db, important
    pos_num dd 4229
    fl dd 1.234567e20                ; floating-point constant 

section .text
    global  _start
    extern  printf_s

_start:
    ;push    string                      ; push address of string to stack as second function parameter`
    ;push    fmt_str_s                   ; push formating string to stack,
    ;                                    ;   used to determine if string or number or something else will be printed,
    ;                                    ;   first parameter of printf_s function
    ;call    printf_s
;
    ;mov     eax, [char]                 ; dereference it because it is a pointer to char
    ;push    eax
    ;push    fmt_str_c
    ;call    printf_s
;
    ;mov     eax, [char_new_line]
    ;push    eax
    ;push    fmt_str_c                   ; print newline
    ;call    printf_s
    ;
    ;mov     eax, [pos_num]
    ;push    eax
    ;push    fmt_str_d
    ;call    printf_s
;
    ;mov     eax, [char_new_line]
    ;push    eax
    ;push    fmt_str_c                   ; print newline
    ;call    printf_s
;
    ;mov     eax, [neg_num]
    ;push    eax
    ;push    fmt_str_d
    ;call    printf_s
;
    ;mov     eax, [char_new_line]
    ;push    eax
    ;push    fmt_str_c                   ; print newline
    ;call    printf_s
;
    ;                                    ; arguments are pushed in reverse order, stack if LIFO
    ;mov     eax, [pos_num]
    ;push    eax                         ; arg3, %d
    ;push    string                      ; arg2, %s
    ;mov     eax, [char]
    ;push    eax                         ; arg1, %c
    ;push    fmt_str_c_s_d               ; print complex formatting string
    ;call    printf_s
;
    ;mov     eax, [char_new_line]
    ;push    eax
    ;push    fmt_str_c                   ; print newline
    ;call    printf_s

    mov     eax, [fl]
    push    eax
    push    fmt_str_f                   ; print newline
    call    printf_s

    mov     eax, 1                      ; exit
    mov     ebx, 0
    int     80h

