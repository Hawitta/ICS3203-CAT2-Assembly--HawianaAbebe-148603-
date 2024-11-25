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


## Steps to Run Each Program

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
Permissions Issue: If you encounter issues running the executables, make sure the file has executable permissions:

```bash
chmod +x <executable_name>
```
Missing Tools: If nasm or ld is not found, ensure they are installed correctly:

For nasm: You can install it using sudo apt-get install nasm on Debian-based distributions like Ubuntu.
For ld (GNU Linker): It’s typically pre-installed on most Linux distributions. If not found, you may need to install binutils.
Errors During Compilation:

Undefined Symbols: If you see errors like undefined reference, check if there are any syntax errors in the assembly code.
Syntax Issues: Ensure correct syntax (e.g., register usage, operand size, etc.) according to the NASM documentation.
