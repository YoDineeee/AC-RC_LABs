; Program 2: Copy 16-bit array to 32-bit array
; This program uses a loop to copy all elements from an unsigned Word (16-bit) array
; into an unsigned doubleword (32-bit) array

section .data
    ; Sample 16-bit array with 8 elements
    word_array dw 100, 200, 300, 400, 500, 600, 700, 800
    word_array_size dd 8                              ; Size of the 16-bit array
    
    msg_word db "16-bit array elements: ", 0
    msg_dword db "32-bit array after copy: ", 0
    format_word db "%u ", 0                           ; Format for printing unsigned 16-bit value
    format_dword db "%u ", 0                          ; Format for printing unsigned 32-bit value
    format_newline db 10, 0                           ; Just a newline

section .bss
    ; Define 32-bit array to hold the copied values
    dword_array resd 8                                ; Reserve space for 8 doublewords

section .text
    global main
    extern printf

main:
    ; Print original 16-bit array
    push msg_word
    call printf
    add esp, 4
    
    call print_word_array
    
    ; Copy elements from 16-bit array to 32-bit array
    call copy_array
    
    ; Print the 32-bit array
    push msg_dword
    call printf
    add esp, 4
    
    call print_dword_array
    
    ; Exit program
    mov eax, 1      ; syscall number for exit
    xor ebx, ebx    ; exit code 0
    int 0x80        ; make syscall

; Procedure to copy elements from 16-bit array to 32-bit array
copy_array:
    push ebp
    mov ebp, esp
    
    mov ecx, 0              ; Initialize counter
    
copy_loop:
    cmp ecx, [word_array_size]
    jge copy_done           ; Exit if we've processed all elements
    
    ; Load value from 16-bit array (with zero extension to 32 bits)
    movzx eax, word [word_array + ecx*2]  ; Zero-extend 16-bit value to 32 bits
    
    ; Store value in the 32-bit array
    mov [dword_array + ecx*4], eax
    
    inc ecx                 ; Increment counter
    jmp copy_loop
    
copy_done:
    mov esp, ebp
    pop ebp
    ret

; Procedure to print the 16-bit array
print_word_array:
    push ebp
    mov ebp, esp
    
    mov ecx, 0              ; Initialize counter
    
print_word_loop:
    cmp ecx, [word_array_size]
    jge print_word_done     ; Exit if we've printed all elements
    
    ; Print current element (zero-extend to 32 bits for printf)
    movzx eax, word [word_array + ecx*2]
    push eax
    push format_word
    call printf
    add esp, 8
    
    inc ecx                 ; Increment counter
    jmp print_word_loop
    
print_word_done:
    ; Print newline
    push format_newline
    call printf
    add esp, 4
    
    mov esp, ebp
    pop ebp
    ret

; Procedure to print the 32-bit array
print_dword_array:
    push ebp
    mov ebp, esp
    
    mov ecx, 0              ; Initialize counter
    
print_dword_loop:
    cmp ecx, [word_array_size]  ; Use same size as word array
    jge print_dword_done    ; Exit if we've printed all elements
    
    ; Print current element
    push dword [dword_array + ecx*4]
    push format_dword
    call printf
    add esp, 8
    
    inc ecx                 ; Increment counter
    jmp print_dword_loop
    
print_dword_done:
    ; Print newline
    push format_newline
    call printf
    add esp, 4
    
    mov esp, ebp
    pop ebp
    ret
