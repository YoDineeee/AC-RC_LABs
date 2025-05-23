<p align="center">
  <img src="/home/mrdine/University/2nd/semester2/AC-RC_LABs/AC/lab7 " alt="UTM Logo" width="100"/>
</p>

<h3 align="center">
  MINISTERUL EDUCAȚIEI, CULTURII ȘI CERCETĂRII  
  <br>
  AL REPUBLICII MOLDOVA  
  <br>
  Universitatea Tehnică a Moldovei  
  <br>
  Facultatea Calculatoare, Informatică și Microelectronică  
  <br>
  Departamentul Inginerie Software și Automatică
</h3>

---

<h2 align="center">
  Mohamed Dhiaeddine Hassine  FAF-233  
  <br>
  <strong>Report</strong>  
  <br>
  <em>Laboratory work nr. 7</em>  
  <br>
  <strong><em>of Computer Architecture</em></strong>
</h2>

---

<p align="right">
  Checked by:  
  <br>
  <strong>Olga Grosu</strong>, <em>university assistant</em>  
  <br>
  <span style="color:red">DISA, FCIM, UTM</span>
</p>

---

<p align="center"><em>Chișinău – 2025</em></p>















































## 7.1 

**File:** `complex1.asm`

```nasm

section .data
    ; Define variables (using floating point for precision)
    a dd 2.0                      ; 32-bit float (adjust value as needed)
    b dd 3.0                      ; 32-bit float (adjust value as needed)
    c dd 4.0                      ; 32-bit float (adjust value as needed)
    z dd 0.0                      ; Result storage
    
    ; Constants used in calculation
    const_one dd 1.0              ; Float constant 1.0
    const_two dd 2.0              ; Float constant 2.0
    const_three dd 3.0            ; Float constant 3.0
    
    ; Format string for output (if you integrate with C printf)
    fmt_str db "Result z = %f", 10, 0

section .bss
    ; Temporary variables for calculation
    temp1 resd 1                  ; Temporary for 1/a
    temp2 resd 1                  ; Temporary for 2+1/a
    temp3 resd 1                  ; Temporary for b*b
    temp4 resd 1                  ; Temporary for 1/(b*b)
    temp5 resd 1                  ; Temporary for 3+1/(b*b)
    temp6 resd 1                  ; Temporary for numerator/(denominator)
    temp7 resd 1                  ; Temporary for c*c
    temp8 resd 1                  ; Temporary for 1/(c*c)

section .text
    global _start

_start:
    ; Step 1: Calculate 1/a and store in temp1
    fld dword [const_one]         ; ST(0) = 1.0
    fdiv dword [a]                ; ST(0) = 1.0 / a
    fstp dword [temp1]            ; temp1 = ST(0), pop stack
    
    ; Step 2: Calculate 2+1/a and store in temp2
    fld dword [const_two]         ; ST(0) = 2.0
    fadd dword [temp1]            ; ST(0) = 2.0 + 1/a
    fstp dword [temp2]            ; temp2 = ST(0), pop stack
    
    ; Step 3: Calculate b*b and store in temp3
    fld dword [b]                 ; ST(0) = b
    fmul dword [b]                ; ST(0) = b * b
    fstp dword [temp3]            ; temp3 = ST(0), pop stack
    
    ; Step 4: Calculate 1/(b*b) and store in temp4
    fld dword [const_one]         ; ST(0) = 1.0
    fdiv dword [temp3]            ; ST(0) = 1.0 / (b*b)
    fstp dword [temp4]            ; temp4 = ST(0), pop stack
    
    ; Step 5: Calculate 3+1/(b*b) and store in temp5
    fld dword [const_three]       ; ST(0) = 3.0
    fadd dword [temp4]            ; ST(0) = 3.0 + 1/(b*b)
    fstp dword [temp5]            ; temp5 = ST(0), pop stack
    
    ; Step 6: Calculate (2+1/a)/(3+1/(b*b)) and store in temp6
    fld dword [temp2]             ; ST(0) = (2+1/a)
    fdiv dword [temp5]            ; ST(0) = (2+1/a)/(3+1/(b*b))
    fstp dword [temp6]            ; temp6 = ST(0), pop stack
    
    ; Step 7: Calculate c*c and store in temp7
    fld dword [c]                 ; ST(0) = c
    fmul dword [c]                ; ST(0) = c * c
    fstp dword [temp7]            ; temp7 = ST(0), pop stack
    
    ; Step 8: Calculate 1/(c*c) and store in temp8
    fld dword [const_one]         ; ST(0) = 1.0
    fdiv dword [temp7]            ; ST(0) = 1.0 / (c*c)
    fstp dword [temp8]            ; temp8 = ST(0), pop stack
    
    ; Step 9: Calculate final result: (2+1/a)/(3+1/(b*b))-1/(c*c)
    fld dword [temp6]             ; ST(0) = (2+1/a)/(3+1/(b*b))
    fsub dword [temp8]            ; ST(0) = (2+1/a)/(3+1/(b*b)) - 1/(c*c)
    fstp dword [z]                ; z = ST(0), pop stack
    
    ; At this point, the result is stored in the 'z' variable
    ; For demonstration, let's load it one more time to see it in ST(0)
    fld dword [z]                 ; Load result into FPU stack top
    
    ; Program exit
    mov eax, 60                   ; syscall: exit
    xor edi, edi                  ; status = 0
    syscall

```


## 7.2 Assembly Instructions Reference

| **Instruction** | **Description** |
|------------------|-----------------|
| `ADD`    | Adds two operands, stores the result in the second operand. |
| `ADC`    | Adds two operands and the carry flag. |
| `SUB`    | Subtracts the first operand from the second and stores result in the second. |
| `SBB`    | Subtracts source from destination including the carry flag. |
| `CBW`    | Copies sign bit (bit 7) into all bits of AH. |
| `CWD`    | Extends the sign of AX into DX for a signed doubleword in DX:AX. |
| `CDQ`    | Extends the sign of EAX into EDX for a signed 64-bit int in EDX:EAX. |
| `MUL`    | Unsigned multiply using AL, AX, or EAX; result in AX, DX:AX, or EDX:EAX. |
| `IMUL`   | Signed multiply with same operand/result rules as `MUL`. |
| `DIV`    | Performs unsigned division. |
| `IDIV`   | Performs signed division. |
| `MOV`    | Copies second operand's data into the first operand. |
| `MOVZX`  | Moves word/byte to a register with zero-extension. |
| `MOVSX`  | Moves word/byte to a register with sign-extension. |
| `XCHG`   | Exchanges values between two operands. |
| `XLAT`   | Translates byte in AL using lookup table indexed by BX. |
| `IN`     | Reads data from an I/O port. |
| `OUT`    | Writes data to an I/O port. |
| `LEA`    | Loads the effective address of operand into register. |
| `LAHF`   | Loads status flags into AH from EFLAGS. |
| `SAHF`   | Stores AH into the Flags register. |
| `PUSH`   | Pushes a constant or register onto the stack. |
| `POP`    | Pops the top of the stack into a register. |
| `PUSHFD` | Pushes EFLAGS register onto the stack. |
| `POPFD`  | Pops value from stack into EFLAGS. |
| `PUSHA`  | Pushes all 16-bit general-purpose registers onto the stack. |
| `POPA`   | Pops general-purpose registers from the stack. |
| `POPAD`  | Pops EDI, ESI, EBP, EBX, EDX, ECX, and EAX from stack. |
| `INC`    | Increments operand by one. |
| `DEC`    | Decrements operand by one. |
| `NEG`    | Negates operand (two's complement). |
| `CMP`    | Compares two operands (like subtraction, result discarded). |
| `JMP`    | Unconditional jump to another instruction. |
| `JE`     | Jump if equal (Zero flag is set). |
| `JZ`     | Jump if zero (same as `JE`). |
| `JNE`    | Jump if not equal (Zero flag is clear). |
| `JNZ`    | Jump if not zero (same as `JNE`). |
| `JL/JNGE`| Jump if less (signed) / not greater or equal. |
| `JLE/JNG`| Jump if less or equal / not greater. |
| `JG/JNLE`| Jump if greater / not less or equal. |
| `JGE/JNL`| Jump if greater or equal / not less. |
| `JB/JNAE`| Jump if below / not above or equal (unsigned). |
| `JBE/JNA`| Jump if below or equal / not above (unsigned). |
| `JA/JNBE`| Jump if above / not below or equal (unsigned). |
| `JAE/JNB`| Jump if above or equal / not below (unsigned). |
| `JCXZ`   | Jump if CX or ECX is zero. |
| `AAA`    | Adjusts AL after BCD addition to unpacked BCD. |
| `AAS`    | Adjusts AL after subtracting ASCII characters. |
| `DAS`    | Decimal adjust AL after subtraction (BCD). |
| `AAM`    | Adjusts result of BCD multiplication and stores in AX. |





**File:** `Key2.asm`

```nasm
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

```

**File:** `RI2.asm`

```nasm
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

```

## 7.2 Part2


**File:** `CA.asm`

```nasm
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


```


**File:** `EA.asm`
```nasm
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

```

**File:** `RA.asm`
```nasm
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

```