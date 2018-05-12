# cs3224-operating-systems
Classwork for CS 3224 Operating Systems

## Course Description
This course is an introduction to operating system design and implementation. We
study operating systems because they are examples of mature and elegant solutions
to a difficult design problem: how to safely and efficiently share system resources
and provide abstractions useful to applications.

For the processor, memory, and disks, we discuss how the operating system
allocates each resource and explore the design and implementation of related
abstractions.

We also establish techniques for testing and improving system performance and
introduce the idea of hardware virtualization. Programming assignments provide
hands-on experience with implementing core operating system components in a
realistic development environment. 

We will examine in detail the design and implementation of a UNIX-like operating system, 
and cover general operating systems concepts, such as processes, threads, device drivers, 
filesystems, scheduling, and concurrency.

## xv6
xv6 is a re−implementation of Dennis Ritchie’s and Ken Thompson’s Unix
Version 6 (v6). xv6 loosely follows the structure and style of v6,
but is implemented for a modern x86−based multiprocessor using ANSI C.

xv6 is a trimmed down, simplified UNIX-like operating system that was used to learn operating system concepts.
In order to use xv6 on Windows 10, I installed Bash Ubuntu which allows me to run a LINUX environment shell.  The xv6 shell provides an emulator called QEMU which was used to run xv6 with the command:
```
make qemu
```

xv6 can be installed by following the directions in:
```
xv6_installation_instructions.pdf
```

A full textbook writeup can be found in:
```
xv6-textbook-rev8.pdf
```

xv6 documentation can be found in:
```
xv6-rev8.pdf
```
