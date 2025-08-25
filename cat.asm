section .data
    file_path db "README.md", 0
    buffer_size equ 256

section .bss
    read_buffer resb buffer_size

section .text
    global _start
_start:

    mov rdx, [rsp + 16]
    xor rcx, rcx

    .count_loop:
        cmp byte [rdx + rcx], 0
        je .done
        inc rcx
        jmp .count_loop
    
    .done:
        mov rax, 1
        mov rdi, 1 
        mov rsi, rdx
        mov rdx, rcx
        syscall

        mov rax, 2
        mov rdi, file_path
        mov rsi, 0
        mov rdx, 0
        syscall

        mov r12, rax

        mov rax, 0
        mov rdi, r12
        mov rsi, read_buffer
        mov rdx, buffer_size
        syscall

        mov rbx, rax

        mov rax, 1
        mov rdi, 1
        mov rsi, read_buffer
        mov rdx, rbx
        syscall


        mov rax, 60
        mov rdi, 0
        syscall