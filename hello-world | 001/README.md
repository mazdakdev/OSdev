# Theory

loading the os
--------------

when the computer boots the BIOS doesn't know how to load the os , so it needs a boot sector.
since there isn't any oprating systems , there isn't any path of boot sector.
so in order to load it ,  the BIOS must know the physical location of boot sector on the disk. (cylinder 0, head 0, sector 0) 
and it's 512 byte.

to make sure there is a bootable disk , bios needs to check a signature. 
the 511 and 512 bytes of boot sector must be `0xAA55`.

Interupts
---------
An interrupt is a signal emitted by a device attached to a computer or from a program within the computer. It requires the operating system (OS) to stop and figure out what to do next. An interrupt temporarily stops or terminates a service or a current process.

[TeachTarget](https://www.techtarget.com/whatis/definition/interrupt)

CPU Registers
-------------
To speed up the processor operations, the processor includes some internal memory storage locations, called registers. The registers store data elements for processing without having to access the memory. A limited number of registers are built into the processor chip.

[Tutorialspoint]([https://www.techtarget.com/whatis/definition/interrupt](https://www.tutorialspoint.com/assembly_programming/assembly_registers.htm)

- - - -

# Code 

Simple Boot Sector
------------------

```nasm

jmp $ ;Jump to the current address (Infinite loop)

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0

; and this is that bios signature 
dw 0xaa55 
```


Printing a Character
--------------------

in order to print a charcter we must:

1. switch to tty mode by setting the register ah to 0x0e
2. set the register al to the charcter we want to print
3. and finaly use interupt 0x10

Note: we can repeat this actions to print a string (of course there is a better way to do this)

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
