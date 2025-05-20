

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