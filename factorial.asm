
section .bss
input resb 10            ; Reserve 10 bytes for user input
result resb 20           ; Reserve 20 bytes for factorial result as a string

section .text
global _start            ; Entry point for the program

_start:
    ; Prompt the user for input
    mov rax, 1           ; Syscall for write
    mov rdi, 1           ; File descriptor (stdout)
    mov rsi, prompt      ; Address of the prompt message
    mov rdx, prompt_len  ; Length of the message
    syscall

    ; Read input from the user
    mov rax, 0           ; Syscall for read
    mov rdi, 0           ; File descriptor (stdin)
    mov rsi, input       ; Address to store input
    mov rdx, 10          ; Maximum input size
    syscall

    ; Convert input from ASCII to integer
    xor rax, rax         ; Clear rax (result)
    xor rdi, rdi         ; Clear rdi (multiplier, initially 0)
    mov rsi, input       ; Address of input
.convert_to_int:
    movzx rbx, byte [rsi] ; Load a byte of input into rbx
    cmp rbx, 10          ; Check for newline (ASCII 10)
    je .conversion_done  ; End conversion if newline is encountered
    sub rbx, '0'         ; Convert ASCII to integer
    imul rax, rdi, 10    ; Multiply existing number by 10
    add rax, rbx         ; Add the new digit
    inc rsi              ; Move to the next byte
    jmp .convert_to_int

.conversion_done:
    mov rdi, rax         ; Move the input number to rdi for factorial calculation

    ; Call factorial subroutine
    call factorial

    ; Convert the result (rax) to ASCII for output
    mov rsi, result      ; Address to store ASCII result
    call int_to_ascii

    ; Display only the factorial result
    mov rax, 1           ; Syscall for write
    mov rdi, 1           ; File descriptor (stdout)
    mov rsi, result      ; Address of the factorial result string
    mov rdx, 20          ; Maximum output size
    syscall

    ; Display a newline character
    mov rax, 1           ; Syscall for write
    mov rdi, 1           ; File descriptor (stdout)
    mov rsi, newline     ; Address of the newline character
    mov rdx, 1           ; Length of the newline character
    syscall

    ; Exit the program
    mov rax, 60          ; Syscall for exit
    xor rdi, rdi         ; Exit code 0
    syscall

factorial:
    ; Save caller's registers
    push rbp             ; Save base pointer
    mov rbp, rsp         ; Set base pointer to current stack
    push rbx             ; Save rbx to preserve intermediate calculations

    ; Base case: if input is 0 or 1, return 1
    cmp rdi, 1           ; Compare input with 1
    jbe .factorial_end   ; Jump to end if input <= 1

    ; Recursive case: n * factorial(n-1)
    mov rbx, rdi         ; Save the current value of rdi (n) in rbx
    dec rdi              ; Decrement rdi (n-1)
    call factorial       ; Recursive call
    imul rax, rbx        ; Multiply rax (factorial(n-1)) with rbx (current n)
    jmp .done

.factorial_end:
    mov rax, 1           ; If input <= 1, result is 1 (base case)

.done:
    ; Restore caller's registers
    pop rbx              ; Restore rbx
    mov rsp, rbp         ; Restore stack pointer
    pop rbp              ; Restore base pointer
    ret                  ; Return to caller

int_to_ascii:
    ; Convert integer in rax to ASCII string
    xor rbx, rbx         ; Clear rbx (to hold digits)
    mov rcx, 10          ; Base 10 for division
    mov rdi, rsi         ; Destination for ASCII string
    add rdi, 19          ; Move pointer to the end of the buffer
    mov byte [rdi], 0    ; Null-terminate the string

.convert_loop:
    xor rdx, rdx         ; Clear rdx for division remainder
    div rcx              ; Divide rax by 10, remainder in rdx
    add dl, '0'          ; Convert remainder to ASCII
    dec rdi              ; Move pointer backwards
    mov [rdi], dl        ; Store ASCII character
    test rax, rax        ; Check if quotient is 0
    jnz .convert_loop    ; Continue if quotient is not zero

    ; Move pointer to the beginning of the string
    mov rsi, rdi         ; Adjust rsi to the beginning of the result string
    ret

section .data
prompt db "Enter a number: ", 0
prompt_len equ $ - prompt

newline db 10            ; Newline character '\n'
