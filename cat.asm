section .data
    buffer_size equ 4096 ; Increased buffer size for efficiency

section .bss
    read_buffer resb buffer_size

section .text
    global _start
_start:
    ; Check command line arguments to get the filename
    mov rdx, [rsp + 16]
    xor rcx, rcx

.count_loop:
    cmp byte [rdx + rcx], 0
    je .open_file
    inc rcx
    jmp .count_loop

.open_file:
    ; Syscall for opening a file
    mov rax, 2               ; syscall number for open
    mov rdi, [rsp + 16]      ; filename is the first argument
    mov rsi, 0               ; read-only flags
    mov rdx, 0               ; mode is ignored for read-only
    syscall

    mov r12, rax             ; Store the file descriptor in r12

    ; Check for open error
    cmp r12, 0
    jl .exit_error           ; If r12 < 0, it's an error code

.read_file_loop:
    ; Syscall for reading from the file
    mov rax, 0               ; syscall number for read
    mov rdi, r12             ; file descriptor
    mov rsi, read_buffer     ; buffer to read into
    mov rdx, buffer_size     ; number of bytes to read
    syscall

    mov rbx, rax             ; Store the number of bytes read in rbx

    ; Check if read returned 0 (end of file)
    cmp rbx, 0
    je .close_file           ; If rbx is 0, we've reached the end of the file

    ; Syscall to print to standard output
    mov rax, 1               ; syscall number for write
    mov rdi, 1               ; file descriptor for stdout
    mov rsi, read_buffer     ; buffer to write from
    mov rdx, rbx             ; number of bytes to write (what we just read)
    syscall

    jmp .read_file_loop      ; Loop back to read more data

.close_file:
    ; Syscall for closing the file
    mov rax, 3               ; syscall number for close
    mov rdi, r12             ; file descriptor
    syscall

.exit:
    ; Syscall to exit the program
    mov rax, 60              ; syscall number for exit
    mov rdi, 0               ; exit status
    syscall

.exit_error:
    mov rax, 60              ; syscall number for exit
    mov rdi, 1               ; exit status (error)
    syscall