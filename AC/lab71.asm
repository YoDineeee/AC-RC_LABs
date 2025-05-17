section .data
    alfa    times 3 dw 0        ; Reserve 3 WORDs (16-bit) uninitiated

section .text
    global main
    extern exit                 ; Assuming exit is provided by the environment

main:
    mov ax, 17                  ; Decimal constant
    mov ax, 0b10101             ; Binary constant (NASM uses 0b prefix)
    mov ax, 0b11                ; Binary constant
    mov ax, 021o                ; Octal constant (NASM uses 'o' suffix)
    
    mov ebx, alfa               ; Offset of alfa
    mov [alfa], ax              ; Store ax in first WORD of alfa
    
    mov cx, ax                  ; Exchange registers using cx as temp
    mov ax, bx
    mov ax, cx
    
    xchg ax, bx                 ; Exchange ax and bx directly
    
    mov esi, 2                  ; Index for array access
    mov [alfa + esi], ax        ; Store ax in alfa[esi]
    
    mov ebx, alfa               ; Load address of alfa
    lea ebx, [alfa]             ; Load effective address of alfa
    
    mov esi, 2                  ; Index for array access
    mov cx, [ebx + esi]         ; Load value from ebx+esi into cx
    mov cx, [alfa + 2]          ; Load value from alfa+2 into cx
    mov cx, [alfa + 2]          ; Same as above, different syntax
    
    mov edi, 4                  ; Index for byte access
    mov byte [ebx + edi], 0x55  ; Store 55h at address ebx+edi
    
    mov esi, 2                  ; Combination of indexes
    mov ebx, 3
    mov word [alfa + ebx + esi], 0x33  ; Store 33h at alfa+ebx+esi
    mov word [alfa + ebx + esi], 0x33  ; Same as above, alternative syntax
    mov word [alfa + ebx + esi], 0x33  ; Same as above, another syntax
    mov word [alfa + ebx + esi], 0x33  ; Same as above, invalid MASM becomes valid NASM
    
    ; Call exit function
    push 0                      ; Exit code 0
    call exit                   ; Exit program
