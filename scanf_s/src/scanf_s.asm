; A function to scan user input from console
; Can be variable length

section .bss
input resb 256

section .text
global scanf_s

scanf_s:
push    ebp                             ; save registers
mov     ebp, esp
push    eax
push    ebx
push    ecx
push    edx

mov     eax, [ebp + 8]                  ; load pointer to fmt string argument to EAX

cmp     byte [eax], 25h                 ; compare first byte to '%' char
jne     exit

inc     eax                             ; move pointer to next char in fmt string

cmp     byte [eax], 64h                 ; compare to 'd' char, decimal
je      scan_decimal                    ; TODO: scan decimal, parsing strin to number
cmp     byte [eax], 63h                 ; compare to 'c' char, char
je      scan_char
cmp     byte [eax], 73h                 ; compare to 's' char, string
je      scan_string

scan_decimal:
jmp     exit

scan_char:
mov     eax, 3                          ; sys_read
mov     ebx, 0                          ; stdin
mov     ecx, input                      ; load pointer to 'input' variable
int     80h

mov     ecx, [ecx]                      ; get value on 'input' address saved in ECX
mov     eax, [ebp + 12]                 ; load pointer to string variable on stack
mov     [eax], ecx                      ; set value on address in EAX to value in ECX

jmp exit

scan_string:
mov     eax, 3                          ; sys_read
mov     ebx, 0                          ; stdin
mov     ecx, input                      ; load pointer to 'input' variable
int     80h

mov     ecx, [ecx]                      ; get value on 'input' address saved in ECX
mov     eax, [ebp + 12]                 ; load pointer to string variable on stack
mov     [eax], ecx                      ; set value on address in EAX to value in ECX

l1:
cmp     byte [eax], 64h                 ; compare string char to newline char
inc     eax                             ; move to next char in string
jne     l1                              ; jump to next loop iteration

dec     eax                             ; move back to newline char
mov     ebx, 0h                         ; load nul char to EBX
mov     [eax], ebx                      ; move nul char to newline char position

; TODO: remove newline char in scanned string

exit:
pop     edx                             ; retrive registers
pop     ecx
pop     ebx
pop     eax
pop     ebp

ret                                     ; return value is in EAX


section .note.GNU-stack \
    noalloc noexec nowrite progbits