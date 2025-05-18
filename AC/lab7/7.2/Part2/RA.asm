; Program 3: Random Capital Letter String Generator
; This program creates a procedure that generates a random string of length L,
; containing all capital letters. It calls the procedure 20 times and displays the strings.

section .data
    msg_intro db "Generating 20 random capital letter strings:", 10, 0
    msg_string_prefix db "String %d: ", 0
    format_newline db 10, 0
    
    string_length dd 10         ; Default length of each string
    iteration_count dd 20       ; Number of times to call the procedure

section .bss
    random_string resb 100      ; Buffer to hold the random string (max 100 chars)
    seed resd 1                 ; For random number generation

section .text
    global main
    extern printf, time

main:
    ; Initialize random seed using current time
    push 0
    call time
    add esp, 4
    mov [seed], eax
    
    ; Print intro message
    push msg_intro
    call printf
    add esp, 4
    
    ; Call the procedure 20 times
    mov ecx, 1              ; Start counter at 1 for display purposes
    
generate_loop:
    cmp ecx, [iteration_count]
    jg generate_done        ; Exit after generating all strings
    
    ; Print string number
    push ecx
    push msg_string_prefix
    call printf
    add esp, 8
    
    ; Set up parameters for generating random string
    mov eax, [string_length]    ; Length in EAX
    push random_string          ; Pointer to buffer
    
    ; Generate the random string
    call generate_random_string
    add esp, 4                  ; Clean up the stack
    
    ; Print the generated string
    push random_string
    call printf
    add esp, 4
    
    ; Print newline
    push format_newline
    call printf
    add esp, 4
    
    inc ecx                     ; Increment counter
    jmp generate_loop
    
generate_done:
    ; Exit program
    mov eax, 1      ; syscall number for exit
    xor ebx, ebx    ; exit code 0
    int 0x80        ; make syscall

; Procedure to generate a random string of capital letters
; Parameters:
;   EAX = length of string to generate
;   [ESP+4] = pointer to buffer where the string will be stored
generate_random_string:
    push ebp
    mov ebp, esp
    
    ; Save registers
    push ebx
    push ecx
    push edx
    push esi
    
    ; Get parameters
    mov ecx, eax                ; Length in ECX
    mov esi, [ebp+8]            ; Pointer to buffer in ESI
    
random_char_loop:
    cmp ecx, 0
    jle random_string_done      ; Exit if we've generated all characters
    
    ; Generate a random number
    mov eax, [seed]
    imul eax, 1103515245
    add eax, 12345
    mov [seed], eax
    
    ; Get a value between 0-25 (for A-Z)
    mov edx, 0
    mov ebx, 26
    div ebx                      ; EDX now contains remainder 0-25
    
    ; Convert to ASCII capital letter (A=65, B=66, etc.)
    add edx, 65                  ; 'A' is ASCII 65
    
    ; Store the character in the buffer
    mov byte [esi], dl           ; Store the character
    inc esi                      ; Move to next position in buffer
    
    dec ecx                      ; Decrement counter
    jmp random_char_loop
    
random_string_done:
    ; Add null terminator
    mov byte [esi], 0
    
    ; Restore registers
    pop esi
    pop edx
    pop ecx
    pop ebx
    
    mov esp, ebp
    pop ebp
    ret
