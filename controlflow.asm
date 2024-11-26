section .data
    prompt db "Enter a number: ", 0
    prompt_len equ $ - prompt
    positive_msg db "POSITIVE", 0xA, 0
    positive_msg_len equ $ - positive_msg
    negative_msg db "NEGATIVE", 0xA, 0
    negative_msg_len equ $ - negative_msg
    zero_msg db "ZERO", 0xA, 0
    zero_msg_len equ $ - zero_msg

section .bss
    input resb 10
    number resq 1

section .text
    global _start

_start:
    ; Write prompt
    mov rax, 1                 ; Syscall: write
    mov rdi, 1                 ; File descriptor: stdout
    mov rsi, prompt            ; Address of prompt
    mov rdx, prompt_len        ; Length of prompt
    syscall                    ; Kernel call

    ; Read user input
    mov rax, 0                 ; Syscall: read
    mov rdi, 0                 ; File descriptor: stdin
    mov rsi, input             ; Address of input buffer
    mov rdx, 10                ; Max bytes to read
    syscall                    ; Kernel call

    ; Convert input to number
    mov rsi, input             ; Address of input string
    call string_to_int         ; Convert input to number
    mov [number], rax          ; Store the result

    ; Classify number
    mov rax, [number]          ; Load number
    cmp rax, 0                 ; Compare with zero
    je .zero                   ; Executes if the comparison (cmp rax, 0) determines that rax is equal to zero.
    jl .negative               ; Executes if the comparison (cmp rax, 0) determines that rax is less than zero.Jump if less than zero, Directs execution to the .negative label, where the message "NEGATIVE" is printed. This allows the program to handle negative numbers distinctly.
    jmp .positive              ; Unconditional jump, Directly transitions to the .positive label, ensuring efficiency by bypassing unnecessary checks.

.positive:
    ; Write "POSITIVE"
    mov rax, 1
    mov rdi, 1
    mov rsi, positive_msg
    mov rdx, positive_msg_len
    syscall
    jmp .exit                  ;  Avoids executing subsequent labels or logic after completing a specific case (e.g., positive, negative, or zero).

.negative:
    ; Write "NEGATIVE"
    mov rax, 1
    mov rdi, 1
    mov rsi, negative_msg
    mov rdx, negative_msg_len
    syscall
    jmp .exit

.zero:
    ; Write "ZERO"
    mov rax, 1
    mov rdi, 1
    mov rsi, zero_msg
    mov rdx, zero_msg_len
    syscall

.exit:
    ; Exit
    mov rax, 60                ; Syscall: exit
    xor rdi, rdi               ; Exit code: 0
    syscall

; Function: string_to_int
string_to_int:
    xor rax, rax               ; Clear result
    xor rbx, rbx               ; Clear sign flag
.convert_loop:
    movzx rcx, byte [rsi]      ; Load next character
    cmp rcx, '-'               ; Check for negative sign
    jne .check_digit           ;Ensures that if the character isn't '-', the program continues to check if it is a valid digit. This prevents skipping over valid numeric input and correctly identifies the sign of the number.
    inc rsi                    ; Skip negative sign
    inc rbx                    ; Set sign flag
    jmp .convert_loop

.check_digit:
    cmp rcx, '0'               ; Check if less than '0'
    jl .done                   ; Used in the string_to_int function to check if a character is outside the range of valid ASCII digits ('0' to '9').
    cmp rcx, '9'               ; Check if greater than '9'
    jg .done                   ; If not a digit, finish
    sub rcx, '0'               ; Convert ASCII to integer
    imul rax, rax, 10          ; Multiply result by 10
    add rax, rcx               ; Add current digit
    inc rsi                    ; Move to next character
    jmp .convert_loop

.done:
    cmp rbx, 0                 ; Check if number is negative
    je .return
    neg rax                    ; Make result negative
.return:
    ret                        ; Return
