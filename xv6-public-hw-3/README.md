# Homework 3: xv6 System Calls

## Part 1: Call Tracing 
Modify the xv6 kernel to print out the name of the system call and its return value for each
system call invocation. You do not have to print the system call arguments.
Upon completion, when you first boot up xv6 you should see output similar to:
```
write->1
fork->2
exec->0
open->3
close->0
$write->1
write->1
```
Note that the output of the shell and the system call trace are intermixed (e.g. the $write ->
1). This is due to the fact that the shell utilized the write system call to print its output.

Hints:
1. You will primarily be working in syscall.c
2. Think about who is responsible for keep track of the return codes for the system
calls.

## Part 2: Date System Call
Now add a new system call to xv6 that will get the current UTC time and return the EST
(EASTERN STANDARD TIME) to the user program. You may use the cmosttime( ) help
function to read the real time clock. The struct rctdate struct is defined in the date.h file.
You will modify the give date.c file to create a user-level program call for the new data
system call. When done, typing date to the xv6 prompt should print the current EST time.

You may either have the system call return the UTC time, then convert to EST time or you
may have the system call return the EST time.

Hints:
1. When making your date system call, you should focus on mimicking all the pieces of
code that are specific for some existing system call, for example the “uptime” system
call. Or you can refer to the slides for the steps of how to add a system call.
2. Use grep for the uptime in all the source files using:
grep -n uptime *.[chS]
