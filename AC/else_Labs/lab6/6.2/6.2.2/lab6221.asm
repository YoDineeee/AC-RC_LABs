
BITS 64                  ; enable 64-bit mode 
default rel              ; ensure PC-relative addresses on Mach-O 

section .data
A:      dq 10            ; reserve 8 bytes, initialize to 10 
B:      dq 20            ; reserve 8 bytes, initialize to 20 
C:      dq 5             ; reserve 8 bytes, initialize to 5  
D:      dq 3             ; reserve 8 bytes, initialize to 3 
Result: dq 0             ; storage for the result      

section .text
global _start

_start:
    mov rax, [A]         ; load A into RAX           
    mov rbx, [B]         ; load B into RBX           
    mov rcx, [C]         ; load C into RCX           
    mov rdx, [D]         ; load D into RDX           

    add rax, rbx         ; RAX = A + B              
    add rcx, rdx         ; RCX = C + D              
    sub rax, rcx         ; RAX = (A + B) − (C + D)  

    mov [Result], rax    ; store 64-bit result      

    mov edi, eax         ; exit code in EDI (low 32 bits) 
    mov eax, 60          ; syscall: sys_exit        
    syscall              ; invoke syscall           
