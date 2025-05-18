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
