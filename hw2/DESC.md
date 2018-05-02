# HW 2 - Guessing Game Description

Write an x86 boot sector that implements a simple guessing game. You should ask the user
for a number from 0 to 9, read their response, and then tell them if they got it right or
wrong. If they got it right, print a success message and then loop forever.

```assembly
 What number am I thinking of (0-9)? 4
 Wrong!
 What number am I thinking of (0-9)? 9
 Wrong!
 What number am I thinking of (0-9)? 2
 Wrong!
 What number am I thinking of (0-9)? 5
 Right! Congratulations.
```

## Bare Metal Assembly

When the computer first boots, the BIOS initializes the hardware, and then passes control
to the *bootloader*. At this point, the CPU is in what's called 16-bit real mode, meaning that
it's essentially compatible with the original 8086 PC. Generally, the OS bootloader will try
to get out of real mode as quickly as possible, but for now we'll write a small program to get
used to assembly programming and get a taste of how things work early on in boot.
Once the BIOS has done basic initialization of hardware, it will try to read a *boot sector*
off of the boot medium. This could be a floppy disk, a hard drive, or whatever else the BIOS
can figure out how to access (most modern BIOSes even allow booting off of the network).
The BIOS reads 512 bytes from this device, checks to make sure it ends with the two bytes
`0x55 0xAA`, loads it at address `0x7C00`, and then begins execution.
If we want to write a program that executes this early in boot, we will have to write it in 16-
bit assembly and then assemble it into a binary boot sector. We can do this with GNU as
(also known as `gas`; it's the standard open-source assembler, and is also used by xv6).
Here's an example program that just prints "Hello world" to the console and then waits
forever. It uses *BIOS interrupts* to set up the right video mode and then prints out a
message character by character.

```assembly
.code16 # Use 16-bit assembly
.globl start # This tells the linker where we want to start executing
start:
 movw $message, %si # load the offset of our message into %si
 movb $0x00,%ah # 0x00 - set video mode
 movb $0x03,%al # 0x03 - 80x25 text mode
 int $0x10 # call into the BIOS
print_char:
 lodsb # loads a single byte from (%si) into %al and increments %si
 testb %al,%al # checks to see if the byte is 0
 jz done # if so, jump out (jz jumps if ZF in EFLAGS is set)
 movb $0x0E,%ah # 0x0E is the BIOS code to print the single character
 int $0x10 # call into the BIOS using a software interrupt
 jmp print_char # go back to the start of the loop
done:
 jmp done # loop forever
# The .string command inserts an ASCII string with a null terminator
message:
 .string "Hello world"
# This pads out the rest of the boot sector and then puts
# the magic 0x55AA that the BIOS expects at the end, making sure
# we end up with 512 bytes in total.
#
# The somewhat cryptic "(. - start)" means "the current address
# minus the start of code", i.e. the size of the code we've written
# so far. So this will insert as many zeroes as are needed to make
# the boot sector 510 bytes log, and
.fill 510 - (. - start), 1, 0
.byte 0x55
.byte 0xAA
```

Make sure to read the comments (anything after a `#` symbol) and fully understand what
each statement does.
If you put that code into a file called `hello.s` in the same directory as the Makefile attached,
you can then create a boot sector named `hello` from it by typing `make hello`, which will
invoke the assembler and linker to produce the 512 byte boot sector:

```
 $ make hello
 i386-jos-elf-as hello.s -o hello.o
 i386-jos-elf-ld -N -e start -Ttext 0x7C00 hello.o -o hello.elf
 i386-jos-elf-objcopy -O binary hello.elf hello
 rm hello.o
```

You can see that it's 512 bytes using `ls`, and (if you like) look at the raw bytes that will be
loaded into memory with `xxd`:

```
 $ ls -l hello
 -rwxr-xr-x@ 1 moyix staff 512 Feb 9 12:59 hello
 $ xxd hello
 0000000: be16 7cb4 00b0 03cd 10ac 84c0 7406 b40e ..|.........t...
 0000010: cd10 ebf5 ebfe 4865 6c6c 6f20 776f 726c ......Hello worl
 0000020: 6400 0000 0000 0000 0000 0000 0000 0000 d...............
 0000030: 0000 0000 0000 0000 0000 0000 0000 0000 ................
 [...]
 00001f0: 0000 0000 0000 0000 0000 0000 0000 55aa ..............U.
```

Now, run your boot sector by telling QEMU to use it as the first hard drive:

```
1hello
```
