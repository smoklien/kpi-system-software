# Lab 2: Turbo Assembler for DOS

This README provides an overview of Lab 1 and instructions for assembling, linking, running, and debugging your Turbo Assembler program for DOS.

## Project structure:

- `src`: This folder contains the source code (`*.asm`) and any associated files for your Lab 2 project.

## Building and Running the Program:

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