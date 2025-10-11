; A function to scan user input from console
; Can be variable length
section .data
    string: db 'Hello World', 0Ah     ; definning string with newline char at the end
    len: equ $-string                 ; get strin length and save it to variable

section .text
 ;   global scan_i32
    global _start

;scan_i32:              ; main function
_start:                 ; main function

    ; scan to eax, scan number until there's a whitespace/enter
    ; push chars to stack, count them, pop them, convert and add together, then move to eax and exit
    ; handle negative numbers with a switch variable

    ; divide and conquer:
    ; 1) get user input to one variable/register
    ; 2) do something with the input. make it printable
    ; mov     eax, 3
    ; mov     ebx, 0
    ; mov     ecx, str
    ; mov     edx, 4
    ; int     80h

    mov     eax, 4          ; print
    mov     ebx, 1
    mov     ecx, string
    mov     edx, len
    int     80h

    mov     eax, 1          ; exit sequence with return value 0
    mov     ebx, 0
    int     80h