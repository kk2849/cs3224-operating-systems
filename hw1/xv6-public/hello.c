//Kevin Kim kk2849
//CS-3224 SPR-2018
//HW1 hello.c & sed.c

// basic user i/o as used in echo.c, cat.c, and wc.c 
#include "types.h"
#include "stat.h"
#include "user.h"

int main () {
	char string[] ="Hello World!";
	printf(1, "%s\n", string); //file descriptor 1 is output
	exit();
}
