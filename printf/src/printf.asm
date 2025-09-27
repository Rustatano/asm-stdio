;section .data

section .text
    global printf

printf:
    mov     eax, 1
    mov     ebx, 0
    int     80h