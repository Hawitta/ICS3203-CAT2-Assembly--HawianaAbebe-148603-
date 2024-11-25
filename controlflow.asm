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
    je .zero                   ; Jump if equal to zero
    jl .negative               ; Jump if less than zero
    jmp .positive              ; Unconditional jump

.positive:
    ; Write "POSITIVE"
    mov rax, 1
    mov rdi, 1
    mov rsi, positive_msg
    mov rdx, positive_msg_len
    syscall
    jmp .exit                  ; Exit

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
    jne .check_digit           ; If not, check if digit
    inc rsi                    ; Skip negative sign
    inc rbx                    ; Set sign flag
    jmp .convert_loop

.check_digit:
    cmp rcx, '0'               ; Check if less than '0'
    jl .done                   ; If not a digit, finish
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
