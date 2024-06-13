# Lab 1: Introduction to the 8086 and TASM

This `README.md` provides an overview of Lab 1 and instructions for assembling, linking, running, and debugging this Turbo Assembler code.

## Overview

This code was given to me by my professor. The goal was to understand the principes of Borland Turbo Assembler (*debugger, linker, assembler*) and structure of the Intel 8086 architecture (*registers, dump, stack*). Program created an array of numbers and then reverse its order 

## Running the Program:

**Warning**: If you use VSCode extension than all files in the emulator will be named `test`.

1. Assemble code:

   ```bash
   tasm main.asm /l /zi
   ```

   - `/l` option: Generates a standard listing file.
   - `/zi` option: Includes full debugging information in the object file.

2. Link the object file:

    ```bash
    tlink main.obj /v /n
    ```

    - `/v` option: Includes full symbolic debug information in the executable file.
    - `/n` option: Ignores default libraries, linking only the provided object file.
    
3. Run the program:
    
    ```bash
    main.exe
    ```

4. Debug the program (optional):

    ```bash
    td main.exe
    ```

    - This command launches Turbo Debugger for step-by-step debugging.