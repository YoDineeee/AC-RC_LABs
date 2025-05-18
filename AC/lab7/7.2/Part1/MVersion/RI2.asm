; Version 2: Z calculation with random input generation
; Formula: If X > 2Y ⇒ Z = 2(X − Y) + 81, Else ⇒ Z = 2Y + X / 4

section .data
    x_msg db "Random X = ", 0
    y_msg db "Random Y = ", 0
    result_msg db "Result Z = ", 0
    newline db 10, 0
    
    format_output db "%d", 10, 0    ; format string for printf with newline

section .bss
    x resd 1    ; reserve space for X (32-bit integer)
    y resd 1    ; reserve space for Y (32-bit integer)
    z resd 1    ; reserve space for Z (result)
    seed resd 1 ; for random number generation

section .text
    global main
    extern printf, time

main:
    ; Initialize random seed using current time
    push 0
    call time
    add esp, 4
    mov [seed], eax

    ; Generate random X (using a simple linear congruential generator)
    mov eax, [seed]
    imul eax, 1103515245
    add eax, 12345
    mov [seed], eax
    
    ; Get a value between 0-100
    mov edx, 0
    mov ebx, 101
    div ebx       ; EDX now contains remainder 0-100
    mov [x], edx

    ; Display X value
    push x_msg
    call printf
    add esp, 4
    
    push dword [x]
    push format_output
    call printf
    add esp, 8

    ; Generate random Y
    mov eax, [seed]
    imul eax, 1103515245
    add eax, 12345
    mov [seed], eax
    
    ; Get a value between 0-50
    mov edx, 0
    mov ebx, 51
    div ebx       ; EDX now contains remainder 0-50
    mov [y], edx

    ; Display Y value
    push y_msg
    call printf
    add esp, 4
    
    push dword [y]
    push format_output
    call printf
    add esp, 8

    ; Calculate Z based on the formula
    mov eax, [y]    ; EAX = Y
    add eax, eax    ; EAX = 2Y
    mov ebx, [x]    ; EBX = X
    
    ; Compare X with 2Y
    cmp ebx, eax
    jle else_case   ; If X <= 2Y, jump to else case

    ; If X > 2Y: Z = 2(X - Y) + 81
    mov eax, [x]
    sub eax, [y]    ; EAX = X - Y
    add eax, eax    ; EAX = 2(X - Y)
    add eax, 81     ; EAX = 2(X - Y) + 81
    mov [z], eax
    jmp print_result

else_case:
    ; If X <= 2Y: Z = 2Y + X/4
    mov eax, [y]
    add eax, eax    ; EAX = 2Y
    
    mov ebx, [x]
    shr ebx, 2      ; EBX = X/4 (shift right by 2 bits = divide by 4)
    
    add eax, ebx    ; EAX = 2Y + X/4
    mov [z], eax

print_result:
    ; Display result message
    push result_msg
    call printf
    add esp, 4

    ; Display the value of Z
    push dword [z]
    push format_output
    call printf
    add esp, 8

    ; Exit program
    mov eax, 1      ; syscall number for exit
    xor ebx, ebx    ; exit code 0
    int 0x80        ; make syscall
