section .data
    val1 dd 0x87654321  ; Define a doubleword with the value 0x87654321

section .text
    global _start

_start:
    ; Load the address of val1 into ESI
    lea esi, [val1]

    ; Load each byte of val1 into the AL register
    mov al, byte [esi]       ; Load least significant byte (LSB)
    mov al, byte [esi + 1]
    mov al, byte [esi + 2]
    mov al, byte [esi + 3]   ; Load most significant byte (MSB)

    ; Exit the program
    mov eax, 60              ; syscall: exit
    xor edi, edi             ; status: 0
    syscall
