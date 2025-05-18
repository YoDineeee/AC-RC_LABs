section .data
    alfa times 6 db 0       ; simulate WORD 3 DUP(?) - 6 bytes (3 words)

section .text
    global _start

_start:
    mov ax, 17              ; AX = 17 decimal (0x11)
    mov ax, 0b10101         ; AX = binary 10101 (0x15) - note 0b prefix in NASM
    mov ax, 0b11            ; AX = 3 (binary 11)
    mov ax, 021o            ; AX = octal 21 = 17 decimal - note 'o' suffix in NASM

    mov ebx, alfa           ; EBX points to array alfa
    mov [alfa], ax          ; Store AX into alfa[0] (first word)

    mov cx, ax              ; Copy AX to CX

    mov ax, ebx             ; AX = EBX (pointer)
    mov ax, cx              ; AX = original AX again

    xchg ax, bx             ; Swap AX and BX

    mov esi, 2              ; ESI = 2 (offset)
    mov [alfa + esi], ax    ; Store AX at alfa[2] (3rd byte of alfa)

    mov ebx, alfa           ; EBX = &alfa
    lea ebx, [alfa]         ; Equivalent: EBX = &alfa

    mov esi, 2
    mov cx, word [ebx + esi]    ; Load word from EBX + 2 into CX
    mov cx, word [alfa + 2]     ; Same as above
    
    mov edi, 4
    mov byte [ebx + edi], 0x55  ; Store 0x55 at alfa[4]

    mov esi, 2
    mov ebx, 3
    mov byte [alfa + ebx + esi], 0x33  ; Same as alfa[5] = 0x33

    ; Exit syscall
    mov eax, 60             ; syscall: exit
    xor edi, edi            ; status = 0
    syscall