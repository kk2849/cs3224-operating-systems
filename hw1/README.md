# Homework 1
## Part 1: Hello World (20 points)
Write a program for xv6 that, when run, prints "Hello world" to the xv6 console. This can be
broken up into a few steps:
1. Create a file in the xv6 directory named hello.c
2. Put code you need to implement printing "Hello world" into hello.c
3. Edit the file Makefile, find the section UPROGS (which contains a list of programs to be
built), and add a line to tell it to build your Hello World program. When you're done that
portion of the Makefile should look like:
```
UPROGS=\
_cat\
_echo\
_forktest\
_grep\
_init\
_kill\
_ln\
_ls\
_mkdir\
_rm\
_sh\
_stressfs\
_usertests\
_wc\
_zombie\
_hello\
```
4. Run make to build xv6, including your new program (repeating steps 2 and 4 until you have compiling code)
5. Run make qemu to launch xv6, and then type hello in the QEMU window. You should see "Hello world" be printed out.
Of course step 2 is where the bulk of the work lies. You will find that many things are subtly different from the programming environments you've used before; for example, the printf function takes an extra argument that specifies where it should print to. This is because you're writing programs for a new operating system, and it doesn't have to follow the conventions of anything you've used before. To get a feel for how programs look in xv6, and how various APIs should be called, you can look at the source code for other utilities: echo.c, cat.c, wc.c, ls.c.

Hints:
1. In places where something asks for a file descriptor, you can use either an actual file descriptor (i.e., the return value of the open function), or one of the standard I/O descriptors: 0 is "standard input", 1 is "standard output", and 2 is "standard error". Writing to either 1 or 2 will result in something being printed to the screen.
2. The standard header files used by xv6 programs are "types.h" (to define some standard data types) and "user.h" (to declare some common functions). You can look at these files to see what code they contain and what functions they define.
How to edit and compile code
As discussed in class, I do not have strong preferences as to how you create source code. I prefer and IDE but in some cases a traditional text editor that can be run at the command line such as pico, vim or emacs works fine. As long as you get a plain text file out of it with valid C syntax, you can choose whatever you like.
How you compile the code is another matter. The xv6 OS is set up to be built using make, which uses the rules defined in Makefile to compile the various pieces of xv6, and to allow you to run the code. The simplest way to build and run it is to use this system. Trying to coerce an IDE such as XCode into building xv6 is far more trouble than it's worth.

## Part 2: Implementing a simple ‘sed’ utility (20 points)
In the following parts of the assignment you will write a very simple version of ‘sed’. ‘sed’ is a stream editor for filtering and transforming text that comes installed with most version of Unix. A stream editor performs basic text transformations on an input stream. You can read more about ‘sed’ by typing ‘man sed’.

In part 2 you will write a version of sed that only does one thing: It counts the number of occurrences of the word “the” and then prints this count.
For example if you type the following it will print what follows the ‘>>’
```
$ sed README
>> 9
```
You should also be able to invoke it without a file, and have it read from standard input. For example, you can use a pipe to direct the output of another xv6 command into sed and it should print the same thing as before:
```
$ grep the README | sed
>> 9
```
The above command searches for all instances of the word the in the file README, and then prints them.
Hints:
1. Many aspects of this are similar to the wc program in XV6: both can read from standard input if no arguments are passed or read from a file if one is given on the command line. Reading its code will help you if you get stuck.

## Part 3: Extending sed (30 points)
Now take this program to not only find all occurrences of the word “the” and print that number to standard output, but also now replace the word “the” with “xyz”. If a filename is provided on the command line (i.e. swap FILENAME) then swap should open it, read and replace all occurrences of “the” with “xyz” and then close it. Afterwards it would then print the lines that would be modified as well as well as the number of occurrences. If no filename is provided, swap should read from standard input, print the input with the change and also the number of occurrences to standard output.
```
$ sed README
>> Found and Replaced 9 occurrences
```

## Part 4: Final Extension to sed (30 points)
Extend the program to accept both the word/string/character to be replaced with its replacement via a command line argument as
“swap –TOBEREPLACED -REPLACEWITH FILENAME”,
for example:
```
swap –xv6 –x86 README
```
Would swap all occurrences of xv6 with x86 in the file README and print them out. Note that in this case both the string to be replaced and the replace with string are the same size.

## Part 5: Extra Credit Extension to sed (10 points)
Extend part 4 to accept strings of different sizes. This way you can call sed the following way:
```
swap –xv6 –UNIX README
```
