# Kevin Kim kk2849 CS3224 Spring 2018

.code16         # Use 16-bit assembly
.globl start    # This tells the linker where we want to start executing

start:
    	movw $guess, %si	# load the offset of our message into %si as seen in hello.s
    	movb $0x00, %ah		# 0x00 - set video mode
    	movb $0x03, %al		# 0x03 - 80x25 text mode
    	int $0x10       	# call into the BIOS
	movb $0x00, %al		# set register al to zero
    	outb %al, $0x70		# read from CMOS port
    	inb $0x71, %al		# store seconds 0-59 to al
    	and $0x0F, %al		# reset bits 5-8 to 0 to get seconds 0-9
    	add $0x30, %al		# add al to get hex
	movb %al, %bl # 	# store al into bl


print_guess:
    	lodsb           	 # loads single byte from (%si) into %al and increment %si as seen in hello.s
    	testb %al,%al  	 	 # check to see if the byte is 0
    	jz get_input 		 # if true, jump out (jz jumps if ZF in EFLAGS is set)
    	movb $0x0e,%ah 		 # 0x0E is the BIOS code to print the single character
    	int $0x10       	 # call into the BIOS using a software interrupt
    	jmp print_guess  	 # go back to the start of the loop


get_input:
	movb $0x00,%al		# set al to zero
	movb $0x00,%ah 		# read character
	int $0x16 		# switch to keyboard mode
	movb $0x0e,%ah 		# display character
	int $0x10 		# view screen of display
	movb %al, %cl 		# store al to cl 
	movb $0x0d,%al		# carriage return
	movb $0x0e,%ah		# 0x0E is the BIOS code to print the single character
	int $0x10		# call into the BIOS using a software interrupt
	movb $0x0a,%al		# line feed
	movb $0x0e,%ah		# 0x0E is the BIOS code to print the single character
	int $0x10		# call into the BIOS using a software interrupt
	jz check		# move to check

check:
	movw $correct, %si 	# load the offset of our message into %si as seen in hello.s
	cmp %bl, %cl		# compare bl and cl to check if it's correct
	je print_correct	# jump to print_correct
	movw $wrong, %si	# load the offset of our message into %si as seen in hello.s
	jne print_wrong		# jump to print_wrong

print_correct:
	lodsb			# load the offset of our message into %si as seen in hello.s
	testb %al,%al		# check to see if the byte is 0
	jz done			# if true, jump out to done
	movb $0x0e,%ah		# print character
	int $0x10		# call into BIOS to view display
	jmp print_correct	# go back to the start of the loop

print_wrong:
	lodsb			# load the offset of our message into %si as seen in hello.s
	testb %al, %al		# checks to see if the byte is 0
	je start_over		# jump to start_over
	movb $0x0e,%ah		# print character
	int $0x10		# call into BIOS to view display
	jmp print_wrong		# go back to the start of the loop

start_over:
	movb $0x0d,%al		# print new line
	movb $0x0e,%ah		# print character
	int $0x10		# call into BIOS to view display
	movw $guess, %si	# load the offset of our message into %si
   	cmpb %al, %al		# compare if they are equal
	je print_guess		# jump back to print_prompt

done:
    jmp done     		# loop forever


# The .string command inserts an ASCII string with a null terminator as seen in hello.s
guess:
	.string    "What number am I thinking of between 0-9? "

wrong:
	.string "Wrong! \n \n \r"

correct:
	.string "Correct! Congratulations."


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
