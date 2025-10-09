section .data
    string db 'Hello World!', 0Ah, 0h   ; declare string variable with new line character at the end and null char
    char db 'H'                         ; declare char variable
    char_new_line db 0Ah
    format_string_s db '%s', 0h         ; declare formatting string, char - '%c', deciaml - '%d', string - '%s'
    format_string_c db '%c', 0h
    format_string_d db '%d', 0h
    num dd 1538                         ; dd instead of db, important

section .text
    global  _start
    extern  printf

_start:
    push    format_string_s             ; push formating string to stack,
                                        ;   used to determine if string or number or something else will be printed,
                                        ;   first parameter of printf function
    push    string                      ; push address of string to stack as second function parameter`
    call    printf
    
    push    format_string_c
    push    char
    call    printf

    push    format_string_c             ; print newline
    push    char_new_line               ; |
    call    printf                      ; |

    push    format_string_d
    push    num
    call    printf

    push    format_string_c             ; print newline
    push    char_new_line               ; |
    call    printf                      ; |

    mov     eax, 1                      ; exit
    mov     ebx, 0
    int     80h

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