section .data
    prompt db "Enter 5 integers:", 0
    newline db 0xA, 0   ; Newline for output formatting

section .bss
    array resd 5        ; Reserve space for 5 integers

section .text
    global _start

_start:
    ; Print prompt message
    mov eax, 4          ; sys_write system call
    mov ebx, 1          ; file descriptor 1 (stdout)
    mov ecx, prompt     ; pointer to prompt string
    mov edx, 18         ; length of prompt string
    int 0x80            ; make system call

    ; Read input from user
    mov ecx, array      ; pointer to the array
    mov edx, 5          ; number of integers to read

input_loop:
    mov eax, 3          ; sys_read system call
    mov ebx, 0          ; file descriptor 0 (stdin)
    int 0x80            ; make system call
    add ecx, 4          ; move to the next integer in array
    dec edx             ; decrement the number of integers to read
    jnz input_loop      ; repeat until 5 integers are read

    ; Reverse the array in place using a loop
    mov esi, 0          ; start index (i = 0)
    mov edi, 4          ; end index (j = 4)
    lea ebx, [array]    ; load address of array into ebx

reverse_loop:
    ; Compare if the start index is less than the end index
    cmp esi, edi
    jge done_reversing

    ; Swap array[esi] and array[edi]
    mov eax, [ebx + esi*4]  ; load array[esi] into eax
    mov edx, [ebx + edi*4]  ; load array[edi] into edx
    mov [ebx + esi*4], edx  ; store value of array[edi] into array[esi]
    mov [ebx + edi*4], eax  ; store value of array[esi] into array[edi]

    ; Increment start index (esi) and decrement end index (edi)
    inc esi
    dec edi
    jmp reverse_loop

done_reversing:
    ; Output the reversed array
    mov eax, 4          ; sys_write system call
    mov ebx, 1          ; file descriptor 1 (stdout)
    mov edx, 5          ; number of integers to print
    lea ecx, [array]    ; load address of array into ecx

output_loop:
    mov eax, 4          ; sys_write system call
    mov ebx, 1          ; file descriptor 1 (stdout)
    mov edx, 4          ; print one integer (4 bytes)
    int 0x80            ; make system call
    add ecx, 4          ; move to the next integer in array
    dec edx             ; decrement the number of integers to print
    jnz output_loop     ; repeat until all integers are printed

    ; Print newline
    mov eax, 4          ; sys_write system call
    mov ebx, 1          ; file descriptor 1 (stdout)
    mov ecx, newline    ; pointer to newline
    mov edx, 1          ; length of newline
    int 0x80            ; make system call

    ; Exit the program
    mov eax, 1          ; sys_exit system call
    xor ebx, ebx        ; exit code 0
    int 0x80            ; make system call


