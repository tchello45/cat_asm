# A minimal implementation of the cat command in NASM

This project provides a simple implementation of the Unix `cat` command using NASM (Netwide Assembler) for Linux. The program reads the contents of a file and outputs it to the standard output (stdout).

## Building the Project

To build the project, you need to have NASM installed. You can assemble the program using the following command:

```bash
nasm -f elf64 -o cat.o cat.asm
```

Then, link the object file to create the final executable:

```bash
ld -o cat.out cat.o
```

## Usage

To use the program, simply run it with the name of the file you want to read as an argument:

```bash
./cat.out <filename>
```

## Required Syscalls

| Syscall Name | Purpose                                   | Syscall Number |
| ------------ | ----------------------------------------- | :------------: |
| `sys_read`   | Read the contents of the input file       |       0        |
| `sys_write`  | Write the contents to the standard output |       1        |
| `sys_open`   | Open the input file                       |       2        |
| `sys_close`  | Close the file descriptors                |       3        |
| `sys_exit`   | Exit the program                          |       60       |

## Implementation Details

The program follows these steps:

1. Open the input file using `sys_open`.
2. Read the contents of the file using `sys_read`.
3. Write the contents to the standard output using `sys_write`.
4. Close the file descriptors using `sys_close`.
5. Exit the program using `sys_exit`.
