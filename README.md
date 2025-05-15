# Hex to ASCII Translator

This program translates a buffer of hex values to their ASCII representation and displays them on the screen.

## Description

This program reads a series of hex values from an input buffer, converts each byte to two ASCII hex characters (representing the high and low nibbles), and prints them to the screen with spaces between each byte value, ending with a newline character.

## Compilation and Execution

### Prerequisites

- Linux environment
- NASM assembler
- 32-bit libraries (for 64-bit systems)

### Installing NASM (if not already installed)

```bash
sudo apt-get update
sudo apt-get install nasm
```

If you're on a 64-bit system, you'll need 32-bit libraries:

```bash
sudo apt-get install gcc-multilib
```

### Compiling the Program

Compile and link with these commands:

```bash
# Assemble the program
nasm -f elf32 hw11translate2Ascii.asm -o hw11translate2Ascii.o

# Link the object file
ld -m elf_i386 hw11translate2Ascii.o -o hw11translate2Ascii
```

### Running the Program

```bash
./hw11translate2Ascii
```

## Expected Output

Given the input buffer `0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A`, the program will output:

```
83 6A 88 DE 9A C3 54 9A
```

## Implementation Details

The program uses the following approach:

1. Processes each byte in the input buffer one by one
2. For each byte:
   - Extracts the high nibble (first hex digit) using a right shift operation
   - Converts the high nibble to its ASCII representation using a subroutine
   - Extracts the low nibble (second hex digit) using a bitwise AND operation
   - Converts the low nibble to its ASCII representation using the same subroutine
   - Adds a space after each byte
3. Adds a newline character at the end of the output
4. Prints the entire output buffer

The conversion subroutine handles the translation of hex digits (0-15) to their ASCII representations ('0'-'9', 'A'-'F').
