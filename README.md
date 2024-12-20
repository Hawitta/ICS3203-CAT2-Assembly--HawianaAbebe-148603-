# ICS3203-CAT2-Assembly--HawianaAbebe-148603-

# Assembly Language Programs

This repository contains assembly language programs for various tasks. Below is a guide on how to run the assembly files using `nasm` (Netwide Assembler) and `ld` (GNU Linker) on a Linux system.

## Requirements

- **nasm** (Netwide Assembler): To assemble `.asm` files.
- **ld** (GNU Linker): To link the object files into executables.
- **Linux-based OS** (or a compatible environment like WSL on Windows).

You can install `nasm` and `ld` via your package manager if they are not already installed:

### For Ubuntu/Debian-based systems:
```bash
sudo apt update

sudo apt install nasm

sudo apt install binutils
```

### For RedHat/CentOS-based systems:
```bash
sudo yum install nasm

sudo yum install binutils
```



# Steps to Run Each Program

## Task 1 (controlflow.asm)

Description:
This program takes user input and classifies it as positive, negative, or zero. It uses basic control flow constructs.

Steps to Run:
### 1. Assemble the controlflow.asm file:

```bash
nasm -f elf64 -o controlflow.o controlflow.asm
```

This will create an object file controlflow.o.

### 2. Link the object file to create an executable:

```bash
ld -o controlflow controlflow.o
```
This will create an executable file controlflow.

### 3. Run the executable:

```bash
./controlflow
```
You will be prompted to enter a number. The program will print "POSITIVE", "NEGATIVE", or "ZERO" based on the input number.

### Relevance of the jump instructions

In the control flow program, specific jump instructions like `jg`, `jge`, and `jmp` were chosen to manage the flow of execution based on the sensor value effectively. The conditional jump instructions (`jg` and `jge`) allow the program to evaluate specific ranges of sensor input without redundant or unnecessary checks. For instance, `jg` (jump if greater) is used to handle the high water level scenario when the sensor value exceeds 80, bypassing lower-priority checks. Similarly, `jge` (jump if greater or equal) is applied to determine if the sensor value falls within the moderate water level range (50–80). These conditional jumps ensure efficient decision-making by only executing the relevant code block, reducing unnecessary branching.

The unconditional jump (`jmp`) is used to redirect the program flow to a common section or skip over irrelevant instructions once a specific condition has been addressed. For example, after taking the appropriate actions for high or moderate water levels, the program jumps to the `normal_state` label to finalize its operations. This simplifies the logic, avoids repeated checks, and consolidates exit handling. These choices of jump instructions contribute to a structured and efficient program flow by ensuring that each condition leads to the intended actions without overlapping or redundant processing.

## Task 2
Description:
This program takes an array of integers as input, reverses it in place, and outputs the reversed array.

Steps to Run:

### 1. Assemble the array.asm file:

```bash
nasm -f elf64 -o array.o array.asm
```
This will create an object file array.o.

### 2. Link the object file to create an executable:

```bash
ld -o array array.o
```
This will create an executable file array.

### 3. Run the executable:

```bash
./array
```

You will be prompted to enter 5 integers. The program will output the reversed array.

### Explanation of Reversal Process and Memory Handling Challenges

Each step of the reversal process is carefully designed to directly manipulate the memory locations of the array, as the integers are stored in contiguous memory slots. The process begins by comparing the start index (`esi`) with the end index (`edi`) to determine when the loop should terminate. Inside the loop, swapping is performed using registers (`eax` and `edx`) to temporarily hold the values of `array[esi]` and `array[edi]`. These values are then exchanged directly in memory through indexed addressing. Incrementing `esi` and decrementing `edi` ensures that the swap operation gradually progresses from both ends of the array toward the center. The use of indexed addressing (`[ebx + esi*4]` and `[ebx + edi*4]`) allows efficient and precise access to memory locations in the array.

Handling memory directly introduces challenges, particularly in managing indexed addressing and ensuring proper alignment of data. Since the array elements are 4 bytes each (32-bit integers), calculations for memory offsets (`esi*4` and `edi*4`) must be accurate to avoid accessing unintended data or causing segmentation faults. Additionally, care must be taken to avoid overwriting or corrupting data during the swap process, as improper use of registers or addressing modes can lead to unexpected results. Debugging such issues can be challenging, as memory manipulation errors may not always produce immediate visible failures, making careful use of comments and step-by-step verification essential.


## 3. Task 3

Description:
This program calculates the factorial of a given number.

Steps to Run:
### 1. Assemble the factorial.asm file:

```bash
nasm -f elf64 -o factorial.o factorial.asm
```
This will create an object file factorial.o.

### 2. Link the object file to create an executable:

```bash
ld -o factorial factorial.o
```
This will create an executable file factorial.

### 3. Run the executable:

```bash
./factorial
```

###In the factorial Subroutine

The factorial function modifies the stack to preserve and restore registers used for intermediate calculations.

Saving Registers at the Start:

```bash
push rbp       ; Save the base pointer of the caller
mov rbp, rsp   ; Set the current stack pointer as the new base pointer
push rbx       ; Save rbx to preserve the current state for intermediate calculations
```

rbp is saved because it is used to manage the stack frame within the subroutine.
rbx is saved because it holds the current value of rdi (n) for multiplication after the recursive call.
Restoring Registers at the End:

```bash
pop rbx        ; Restore rbx to its previous state
mov rsp, rbp   ; Restore the stack pointer to the previous base pointer
pop rbp        ; Restore the base pointer of the caller
ret            ; Return to the caller
```

This ensures the calling function’s state is not corrupted by the factorial logic.


You will be prompted to enter a number. The program will output the factorial of that number.



## 4. Task 4

Description:
This program simulates sensor readings and performs actions based on input values (e.g., if the value is above a threshold, it prints "ALERT").

Steps to Run:
### 1. Assemble the sensor.asm file:

```bash
nasm -f elf64 -o sensor.o sensor.asm
```
This will create an object file sensor.o.

### 2. Link the object file to create an executable:

```bash
ld -o sensor sensor.o
```
This will create an executable file sensor.

### 3. Run the executable:

```bash
./sensor
```
Simulated Sensor Value:
The sensor_value variable in the .data section represents the sensor reading. Its value (e.g., 65) is loaded into the AL register for evaluation.

Decision-Making Process:

The sensor value is compared against predefined thresholds using cmp and jg/jge instructions:
High Water Level (Value > 80):
  If the sensor value exceeds 80, the program sets:
    alarm_control = 1 (to trigger the alarm).
    motor_control = 1 (to turn the motor ON).
    Messages are printed for both the alarm and the motor status.
    
Moderate Water Level (50 ≤ Value ≤ 80):
  If the sensor value is between 50 and 80 inclusive, the program sets:
    motor_control = 0 (to turn the motor OFF).
    A message is printed indicating the motor is OFF.
    
Low Water Level (Value < 50):
    If the sensor value is below 50, no actions are taken for the motor or alarm. The program proceeds to the normal state.    
The program will print a sensor reading value, and based on this value, it will trigger different actions (e.g., if the reading is above a threshold, it will print "ALERT").

# Troubleshooting

While debugging the array.asm program, one of the key challenges was ensuring that the array reversal was done in place, as no additional memory could be used to store the reversed array. The logic required careful manipulation of the array indices and register values to swap elements in-place. Additionally, there were issues with properly handling the user input and ensuring that the array was correctly populated. Debugging was also tricky when verifying that the program correctly printed the reversed array, especially when handling output formatting to avoid misinterpretations in the displayed results, such as no space between the numbers.

Debugging factorial.asm presented a different set of challenges, primarily with correctly implementing the factorial calculation logic using a loop. Ensuring that the loop iterated the correct number of times and that the result was accurately calculated required careful attention to register management and proper initialization. Another challenge was managing the data type overflow when working with large factorial values, especially for numbers greater than 20. Debugging also required verifying that the correct output was displayed after the calculation, as issues often arose with the format of the output or with incorrect handling of edge cases like factorial(0).

Debugging sensor.asm was relatively straightforward compared to other programs. The primary challenge lay in ensuring the correct handling of sensor readings and their corresponding actions based on user input. The program required minimal changes in the logic itself but did need some adjustments in how the messages were displayed to the user. Initially, there were issues with the clarity and format of the output, but after refining the way messages were shown to the user, the program worked as expected. The focus was primarily on improving user interaction rather than troubleshooting complex logic.

Debugging controlflow.asm involved addressing several nuances related to the control flow structure. One of the main challenges was ensuring that the program correctly classified input as "POSITIVE", "NEGATIVE", or "ZERO" based on the number entered by the user. This required precise comparisons and jumps in assembly code, which was crucial for proper program execution. Another challenge was handling edge cases like zero input and ensuring the output displayed the correct classification without errors. After several iterations, the logic was fine-tuned, and the program successfully classified numbers based on the input, but it required careful testing and validation to handle all possible scenarios correctly.
