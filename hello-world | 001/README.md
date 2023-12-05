## What is Boot Sectors

A boot sector is a physical sector on a hard drive that includes information about how to start the boot process in order to load an operating system.

Note: A sector on a hard drive is a section of the disk that can be read or written to. It is typically 512 bytes in size and contains data such as file information or boot instructions.

## The BIOS

BIOS stands for Basic Input/Output System, which is a program that runs on a computer's motherboard. It is responsible for initializing hardware components during the boot process and providing a basic set of instructions to the operating system to enable it to start. It also provides a low-level interface for communicating with hardware components, such as hard drives and keyboards.

## Basically How

When a computer starts up, the BIOS doesn't know how to load the operating system and requires a boot sector to do so. However, since there is no operating system, there is no path to the boot sector. To load it, the BIOS must know the physical location of the boot sector on the disk, which is cylinder 0, head 0, sector 0, and it's 512 bytes in size.

To ensure that a disk is bootable, the BIOS checks for a specific signature. Specifically, the 511th and 512th bytes of the boot sector must be `0xAA55`.

![](https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fqph.fs.quoracdn.net%2Fmain-qimg-4c2c19e8f68405c99d125c58414f6359&f=1&nofb=1&ipt=c72bdb62d557c3762a309d11c657982b5ea040ea4ca2ce33607b7f207d3e1fd0&ipo=images)

## The BIOS **Interrupts**

BIOS interrupts are software interrupts that are triggered by the BIOS during the boot process. These interrupts provide a way for the BIOS to communicate with the operating system and other software running on the computer. They can be used to perform tasks such as reading from or writing to disk, initializing hardware components, or performing low-level system functions. When an interrupt is triggered, the processor stops executing the current program and switches to the interrupt handler, which is a special routine that performs the required task before returning control to the main program.

## The CPU Registers

CPU registers are small, high-speed storage locations within the CPU that are used to hold data that is being processed or manipulated. They are typically measured in bits, such as 8-bit or 32-bit registers, and can be used to store things like memory addresses, data being processed, and status information. Registers are an important component of a computer's architecture, as they allow for fast access to frequently used data and can greatly improve performance.

---

# The Code

### A Simple Boot Sector

```nasm
jmp $ ;Jump to the current address (Infinite loop)****

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0

; the previously mentioned bios signature
dw 0xaa55
```

### Hello World !

In order to print a single character we use the BIOS interrupt `0x10` which is responsible for various video services.

with `AH` set to `0x0E` (tty mode) and `AL` set to the ASCII value of the character to be displayed will display a single character on the screen.

Basically the interrupt `0x10` reads the `AX` register which is 16-bit register consisted of `AH:AL`

```nasm
mov ah, 0x0e ; tty mode
mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10 ; 'l' is still on al, remember?
mov al, 'o'
int 0x10

jmp $ ; jump to current address (infinite loop)

times 510 - ($-$$) db 0
dw 0xaa55
```

## Runing the os

1. Install the compiler and emulator

```console
user@host:~$ sudo apt/dnf/brew/ nasm qemu -y
```

2. Compile the assembly file

```console
user@host:~$ nasm -f bin file.asm -o output.bin
```

3. Run the compiled bin file

```console
user@host:~$ qemu-system-x86_64 output.bin
```
