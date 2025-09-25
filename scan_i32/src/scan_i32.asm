; A function to scan user input from console
; Can be variable length

section .text
 ;   global scan_i32
    global _start

;scan_i32:               ; main function
_start:               ; main function

    ; scan to eax, scan number until there's a whitespace/enter
    ; push chars to stack, count them, pop them, convert and add together, then move to eax and exit
    ; handle negative numbers with a switch variable
    mov     eax, 3
    mov     ebx, 0
    mov     ecx, 0      ; TODO: lea instruction
    mov     edx, 4
    int     80h



    mov     eax, 1      ; exit sequence with return value 0
    mov     ebx, 0
    int     0x80