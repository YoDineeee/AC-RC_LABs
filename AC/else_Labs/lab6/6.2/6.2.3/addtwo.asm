
BITS 32
section .data
A:    dd 10      ; 0x0A
B:    dd 20      ; 0x14
Sum:  dd 0

section .text
global _start
_start:
    mov   eax, [A]
    add   eax, [B]
    mov   [Sum], eax
    mov   ebx, eax
    mov   eax, 1
    int   0x80
