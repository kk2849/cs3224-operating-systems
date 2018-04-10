.code16 	# Use 16-bit assembly
.globl start 	# This tells the linker where we want to start executing

start:
	movw $message, %si 	# load the offset of our message into %si
	movb $0x00,%ah 		# 0x00 - set video mode
	movb $0x03,%al 		# 0x03 - 80x25 text mode
	int $0x10 		# call into the BIOS

print_char:
	lodsb 		# loads a single byte from (%si) into %al and increments %si
	testb %al,%al 	# checks to see if the byte is 0
	jz done 	#if so, jump out (jz jumps if ZF in EFLAGS is set)
	movb $0x0E,%ah 	# 0x0E is the BIOS code to print the single character
	int $0x10 	# call into the BIOS using a software interrupt
	jmp print_char 	# go back to the start of the loop

done:
	jmp done 	# loop forever

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
