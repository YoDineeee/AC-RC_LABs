cmp ebx, eax
    jae else_case   ; If X >= 2Y, jump to else case

    ; If X < 2Y: Z = X/8 + 32 - Y
    mov eax, [x]    ; EAX = X
    mov edx, 0      ; Clear EDX for division
    mov ecx, 8      
    div ecx         ; EAX = X/8 (EDX contains remainder, which we ignore)
    add eax, 32     ; EAX = X/8 + 32
    sub eax, [y]    ; EAX = X/8 + 32 - Y
    mov [z], eax
    jmp print_result

else_case:
    ; If X >= 2Y: Z = 2Y - 60
    mov eax, [y]
    add eax, eax    ; EAX = 2Y
    sub eax, 60     ; EAX = 2Y - 60
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
