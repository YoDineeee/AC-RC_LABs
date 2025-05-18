; Program 1: Exchange Pairs in an Array
; This program exchanges every pair of values in an array with an even number of elements
; Item i exchanges with item i+1, item i+2 exchanges with item i+3, and so on

section .data
    array dd 10, 20, 30, 40, 50, 60, 70, 80, 90, 100    ; Sample array with 10 elements (even number)
    array_size dd 10                                    ; Size of the array
    
    msg_before db "Array before exchange: ", 0
    msg_after db "Array after exchange: ", 0
    format_element db "%d ", 0                          ; Format for printing each element
    format_newline db 10, 0                             ; Just a newline

section .text
    global main
    extern printf

main:
    ; Print original array
    push msg_before
    call printf
    add esp, 4
    
    call print_array
    
    ; Exchange pairs in the array
    call exchange_pairs
    
    ; Print the modified array
    push msg_after
    call printf
    add esp, 4
    
    call print_array
    
    ; Exit program
    mov eax, 1      ; syscall number for exit
    xor ebx, ebx    ; exit code 0
    int 0x80        ; make syscall

; Procedure to exchange pairs in the array
exchange_pairs:
    push ebp
    mov ebp, esp
    
    mov ecx, 0              ; Initialize counter
    mov eax, [array_size]   
    shr eax, 1              ; Divide by 2 to get number of pairs
    mov edx, eax            ; Store number of pairs in EDX
    
exchange_loop:
    cmp ecx, edx
    jge exchange_done       ; Exit if we've processed all pairs
    
    ; Calculate the index for the current pair
    mov eax, ecx
    shl eax, 1              ; Multiply by 2 to get starting index of pair
    
    ; Load the pair of values
    mov ebx, [array + eax*4]        ; First value of pair (i)
    mov esi, [array + eax*4 + 4]    ; Second value of pair (i+1)
    
    ; Exchange the values
    mov [array + eax*4], esi        ; Store second value in first position
    mov [array + eax*4 + 4], ebx    ; Store first value in second position
    
    inc ecx                 ; Increment pair counter
    jmp exchange_loop
    
exchange_done:
    mov esp, ebp
    pop ebp
    ret

; Procedure to print the array
print_array:
    push ebp
    mov ebp, esp
    
    mov ecx, 0              ; Initialize counter
    
print_loop:
    cmp ecx, [array_size]
    jge print_done          ; Exit if we've printed all elements
    
    ; Print current element
    push dword [array + ecx*4]
    push format_element
    call printf
    add esp, 8
    
    inc ecx                 ; Increment counter
    jmp print_loop
    
print_done:
    ; Print newline
    push format_newline
    call printf
    add esp, 4
    
    mov esp, ebp
    pop ebp
    ret
