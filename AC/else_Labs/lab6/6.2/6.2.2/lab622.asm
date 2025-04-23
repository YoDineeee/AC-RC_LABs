
BITS 64
section .text
global _start

_start:
    mov eax, 10        ; A = 10
    mov ebx, 20        ; B = 20
    mov ecx, 5         ; C = 5
    mov edx, 3         ; D = 3

    add eax, ebx       ; EAX = A + B
    add ecx, edx       ; ECX = C + D
    sub eax, ecx       ; EAX = (A + B) - (C + D)

    mov edi, eax       ; syscall arg1 = result
    mov eax, 60        ; sys_exit (x86_64)
    syscall            ; invoke syscall
