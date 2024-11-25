section .data
    sensor_value db 65      ; Simulated sensor value (in range 0-100)
    motor_control db 0      ; Motor control bit (0 = off, 1 = on)
    alarm_control db 0      ; Alarm control bit (0 = off, 1 = triggered)
    message_motor_on db "Motor is ON", 0
    message_motor_off db "Motor is OFF", 0
    message_alarm_on db "ALARM! Water level too high", 0
    newline db 10, 0        ; Newline character

section .bss
    buffer resb 32          ; Temporary buffer for printing messages

section .text
    global _start

_start:
    ; Step 1: Read the sensor value (simulated from the sensor_value byte)
    mov al, [sensor_value]  ; Load the sensor value into AL

    ; Step 2: Evaluate the sensor value
    cmp al, 80              ; Check if the sensor value is greater than 80
    jg high_water_level     ; If greater, jump to high_water_level

    cmp al, 50              ; Check if the sensor value is greater than 50
    jge moderate_water_level ; If between 50 and 80, jump to moderate_water_level

    ; If the sensor value is below 50, it's a low water level
    ; No action is needed for low water level
    jmp normal_state

high_water_level:
    ; High water level: Trigger alarm and turn on motor
    mov byte [alarm_control], 1  ; Set alarm_control bit to 1 (turn alarm on)
    mov byte [motor_control], 1  ; Set motor_control bit to 1 (turn motor on)

    ; Print alarm message
    mov rsi, message_alarm_on    ; Message to print
    call print_string

    ; Print motor on message
    mov rsi, message_motor_on    ; Message to print
    call print_string
    jmp normal_state

moderate_water_level:
    ; Moderate water level: Turn off motor and do nothing with the alarm
    mov byte [motor_control], 0  ; Set motor_control bit to 0 (turn motor off)

    ; Print motor off message
    mov rsi, message_motor_off   ; Message to print
    call print_string
    jmp normal_state

normal_state:
    ; Wait or exit program (no actions taken for low water level)
    mov rax, 60                  ; sys_exit system call
    xor rdi, rdi                 ; Return code 0
    syscall

; Function to print a null-terminated string
print_string:
    ; Write to stdout (file descriptor 1)
    mov rax, 1           ; sys_write system call
    mov rdi, 1           ; file descriptor 1 (stdout)
    mov rdx, 255         ; maximum size for message (arbitrary large number)
    syscall
    ret
