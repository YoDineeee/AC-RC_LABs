section .data
    prompt_x db "Enter the value of X: ", 0
    prompt_y db "Enter the value of Y: ", 0
    result_msg db "Result Z = ", 0
    newline db 10, 0    ; newline character

    format_input db "%d", 0    ; format string for scanf
    format_output db "%d", 10, 0    ; format string for printf with newline

section .bss
    x resd 1    ; reserve space for X (32-bit integer)
    y resd 1    ; reserve space for Y (32-bit integer)
    z resd 1    ; reserve space for Z (result)

section .text
    global main
    extern printf, scanf

main:
    ; Display prompt for X
    push prompt_x
    call printf
    add esp, 4

    ; Read X from user
    push x
    push format_input
    call scanf
    add esp, 8

    ; Display prompt for Y
    push prompt_y
    call printf
    add esp, 4

    ; Read Y from user
    push y
    push format_input
    call scanf
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

