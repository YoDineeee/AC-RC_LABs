; AddAllTypes64.asm — define each intrinsic data type in NASM (x86_64)
BITS 64                       ; 64-bit mode for x86_64 ELFs

section .data

    ; 8-bit integers
    byte_var    db  255       ; BYTE  =  8-bit unsigned max (0–255)
    sbyte_var   db  -128      ; SBYTE =  8-bit signed min (–128–127)

    ; 16-bit integers
    word_var    dw  65535     ; WORD  = 16-bit unsigned max (0–65 535)
    sword_var   dw  -32768    ; SWORD = 16-bit signed min (–32 768–32 767)

    ; 32-bit integers and REAL4
    dword_var   dd  4294967295    ; DWORD  = 32-bit unsigned max
    sdword_var  dd  -2147483648   ; SDWORD = 32-bit signed min
    real4_var   dd  3.14159       ; REAL4  = 32-bit IEEE float

    ; 48-bit integer (far pointer size)
    fword_var   df  0x112233445566    ; FWORD = 48-bit integer

    ; 64-bit integer and REAL8
    qword_var   dq  1234567890123456789  ; QWORD = 64-bit integer
    real8_var   dq  2.718281828459045      ; REAL8 = 64-bit IEEE double

    ; 80-bit integer and REAL10
    tbyte_var   dt  0x112233445566778899AA      ; TBYTE  = 80-bit integer
    real10_var  dt  1.4142135623730950488       ; REAL10 = 80-bit IEEE extended real

section .text
global _start

_start:
    ; No runtime logic—data definitions only
    mov     eax, 60    ; syscall: sys_exit (x86_64)
    xor     edi, edi   ; exit code = 0
    syscall
