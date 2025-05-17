# MASM & Irvine32 Compatibility Issue on Linux

## ❓ Problem Overview

This lab is written using **MASM (Microsoft Macro Assembler)** and depends on the **Irvine32 library**, which is:

- Designed to work with **Microsoft Visual Studio**
- **Only compatible with Windows**
- Provides convenient macros, procedures (`Exit`, `WriteString`, etc.), and debug tools (like register/memory views)

If you're trying to complete this lab using **Linux** (Ubuntu, Arch, etc.) or a **code editor like VS Code**, you'll run into the following problems:

- MASM **cannot run natively** on Linux
- Irvine32-related features like `INCLUDE Irvine32.inc` or `Irvine32.lib` **do not work**
- Visual Studio-style debugging (F10, memory windows, register views) is **not available**

---

##  Why This Happens

MASM and the Irvine32 library are based on:

- Windows APIs and tools
- `.lib` files and `.inc` files only recognized by Microsoft's linker and assembler
- Visual Studio-specific debugging and project integration

These are **not supported in cross-platform assemblers like NASM**, nor are they compatible with Linux's ELF binary format.

---

## ✅ Solution Options

### Option 1: Use a Windows Environment (Recommended for MASM Labs)
To fully support MASM and Irvine32-based labs:

1. Install a **Windows virtual machine** (e.g. with VirtualBox or VMware)
2. Install **Visual Studio (Community Edition)**
3. Download and configure the **Irvine32 library**
4. Run the lab and debug using Visual Studio's built-in tools (F10, Registers, Memory, etc.)

---

### Option 2: Rewrite the Lab Using NASM for Linux

If you prefer to stay on Linux:

- Use **NASM (Netwide Assembler)** and write standard Linux x86_64 assembly
- Replace MASM/Irvine functions with **Linux system calls** (e.g., `syscall`)
- Debug using **GDB** (GNU Debugger) in the terminal

You can still:
- Step through instructions: `stepi` in GDB
- View registers: `info registers`
- Inspect memory: `x/4xw &label`

> ⚠️ Requires more manual setup  
> 🧰 Tools: NASM, `ld`, `gdb`, Linux system calls




