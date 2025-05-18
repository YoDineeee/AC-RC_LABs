; Arithmetic expression example in NASM for Linux
; e = ((a + b * c - d) / f + g * h) / i

section .data
    a dw 5                ; 16-bit word
    b db 6                ; 8-bit byte
    c db 10               ; 8-bit byte
    d dw 5                ; 16-bit word
    f dw 6                ; 16-bit word
    g db 10               ; 8-bit byte
    h db 11               ; 8-bit byte
    i db 10               ; 8-bit byte
    interm dw 0           ; Intermediate result
    e db 0                ; Final result

section .text
    global _start

_start:
    ; Calculate b * c
    xor eax, eax          ; Clear EAX
    mov al, [b]           ; AL = b
    imul byte [c]         ; AX = AL * c

    ; Add a to the result: a + b * c
    add ax, [a]           ; AX = a + b*c

    ; Subtract d: (a + b * c - d)
    sub ax, [d]           ; AX = (a + b*c - d)

    ; Divide by f: (a + b*c - d) / f
    cwd                   ; Sign extend AX to DX:AX for division
    idiv word [f]         ; AX = (a + b*c - d) / f
    
    ; Store intermediate result
    mov [interm], ax

    ; Calculate g * h
    xor eax, eax
    mov al, [g]
    imul byte [h]         ; AX = g * h

    ; Add intermediate result: (a + b*c - d) / f + g*h
    add ax, [interm]      ; AX = prev + g*h

    ; Final division by i
    cbw                   ; Sign extend AL to AX if result fits in byte
    idiv byte [i]         ; AL = result / i
    mov [e], al           ; Store final result

    ; Exit syscall
    mov eax, 60
    xor edi, edi
    syscall