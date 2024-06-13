# System Software Lab Works Repository

Welcome to my repository for **Intel 8086 Assembly** source code, specifically designed for System Software lab works. I have used **Borland Turbo Assembler** as my dialect. This repository provides you with a variety of labs, detailed explanations, and resources to help you complete your assignments effectively.

## Repository structure

- `lab-x`: Each lab has its dedicated directory prefixed with `lab-x`, where `x` represents the specific lab number (e.g., `lab-1`, `lab-2`).
- `samples`: Folder that contains samples of 8086 assembly, inline assembly, and code written in `C` and translated to the x86-64 assembly.
- `src`: These folders contain the source code corresponding to each lab work.
- `.gitignore`: Files or folders that Git should ignore.

## Getting started

1. Clone the repository

   ```bash
   git clone https://github.com/smoklien/kpi-system-software.git
   ```

2. Navigate to the project directory:

    ```bash
    cd kpi-system-software
    ```

3. Explore my labs:

    - Visit individual lab directories within `lab-x` to access the corresponding source code.
    - Read instructions to understand the purpose of the code

## Launch Instructions

To run the 16-bit code in this repository, you'll need a virtual machine that supports 16-bit programming. Here are some options:

1. VSCode extension "xsro.masm-tasm": This extension allows you to run the code directly in VSCode. I also have [video guide](https://www.youtube.com/watch?v=D9JhAMaGgDo&t) *in Ukranian* to that extension.

2. Emulators: You can use emulators like "DOSBox", "MS-DOS" or "DOSbox-x". To run `.asm` code within these emulators, you'll need to install Turbo Assembler. This will allow you to assemble and execute your assembly programs within the emulator environment.

3. [GUI Turbo Assembler](https://sourceforge.net/projects/guitasm8086/) (TASM): This is a popular choice among university students.

Once you have installed either the VSCode extension or GUI TASM, you can launch and test the code. You might also find your own way to launch 16-bit code that I may not be aware of