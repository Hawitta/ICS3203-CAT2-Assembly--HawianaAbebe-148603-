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
The program will print a sensor reading value, and based on this value, it will trigger different actions (e.g., if the reading is above a threshold, it will print "ALERT").

# Troubleshooting

While debugging the array.asm program, one of the key challenges was ensuring that the array reversal was done in place, as no additional memory could be used to store the reversed array. The logic required careful manipulation of the array indices and register values to swap elements in-place. Additionally, there were issues with properly handling the user input and ensuring that the array was correctly populated. Debugging was also tricky when verifying that the program correctly printed the reversed array, especially when handling output formatting to avoid misinterpretations in the displayed results, such as no space between the numbers.

Debugging factorial.asm presented a different set of challenges, primarily with correctly implementing the factorial calculation logic using a loop. Ensuring that the loop iterated the correct number of times and that the result was accurately calculated required careful attention to register management and proper initialization. Another challenge was managing the data type overflow when working with large factorial values, especially for numbers greater than 20. Debugging also required verifying that the correct output was displayed after the calculation, as issues often arose with the format of the output or with incorrect handling of edge cases like factorial(0).

Debugging sensor.asm was relatively straightforward compared to other programs. The primary challenge lay in ensuring the correct handling of sensor readings and their corresponding actions based on user input. The program required minimal changes in the logic itself but did need some adjustments in how the messages were displayed to the user. Initially, there were issues with the clarity and format of the output, but after refining the way messages were shown to the user, the program worked as expected. The focus was primarily on improving user interaction rather than troubleshooting complex logic.

Debugging controlflow.asm involved addressing several nuances related to the control flow structure. One of the main challenges was ensuring that the program correctly classified input as "POSITIVE", "NEGATIVE", or "ZERO" based on the number entered by the user. This required precise comparisons and jumps in assembly code, which was crucial for proper program execution. Another challenge was handling edge cases like zero input and ensuring the output displayed the correct classification without errors. After several iterations, the logic was fine-tuned, and the program successfully classified numbers based on the input, but it required careful testing and validation to handle all possible scenarios correctly.
