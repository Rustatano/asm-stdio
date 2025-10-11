section .data
    string db "ello", 0h                ; declare string variable with new line character at the end and null char
    char db 'H'                         ; declare char variable
    char_new_line db 0Ah
    fmt_str_s db "%s", 0h               ; declare formatting string, char - '%c', deciaml - '%d', string - '%s'
    fmt_str_c db "%c", 0h
    fmt_str_d db "%d", 0h
    fmt_str_c_s_d db \
    "%c%s, World! %r %d %[]", 0h        ; able to print complex formatting string

    neg_num dd -1538                    ; dd instead of db, important
    pos_num dd 4229

section .text
    global  _start
    extern  printf_s

_start:
    push    string                      ; push address of string to stack as second function parameter`
    push    fmt_str_s                   ; push formating string to stack,
                                        ;   used to determine if string or number or something else will be printed,
                                        ;   first parameter of printf_s function
    call    printf_s
    
    push    char
    push    fmt_str_c
    call    printf_s

    push    char_new_line               ; |
    push    fmt_str_c                   ; print newline
    call    printf_s                    ; |

    push    pos_num
    push    fmt_str_d
    call    printf_s

    push    char_new_line               ; |
    push    fmt_str_c                   ; print newline
    call    printf_s                    ; |

    push    neg_num
    push    fmt_str_d
    call    printf_s

    push    char_new_line               ; |
    push    fmt_str_c                   ; print newline
    call    printf_s                    ; |

                                        ; arguments are pushed in reverse order, stack if LIFO
    push    pos_num                     ; arg3, %d
    push    string                      ; arg2, %s
    push    char                        ; arg1, %c
    push    fmt_str_c_s_d               ; print complex formatting string
    call    printf_s

    push    char_new_line               ; |
    push    fmt_str_c                   ; print newline
    call    printf_s                      ; |

    mov     eax, 1                      ; exit
    mov     ebx, 0
    int     80h
