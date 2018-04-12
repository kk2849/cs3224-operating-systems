#include "types.h"
#include "user.h"
#include "date.h"

int
main(int argc, char *argv[])
{
	struct rtcdate r;

	if (date(&r)) {
		printf(2, "date failed lolol\n");
		exit();
	}

  // your code to print the time in any format you like...
	printf(2, "Date: %d-%d-%d Time:%d:%d:%d UTC\n", r.month, r.day, r.year,
		r.hour, r.minute, r.second);

	// UTC is 4 hours ahead of EST
	// 0 to 4:59 UTC is previous day EST
	if (r.hour <= 4) { 
		r.hour = 8+r.hour;
		r.day--;
	}
	else {
		r.hour = r.hour-4;
	}
	printf(2, "Date: %d-%d-%d Time:%d:%d:%d EST\n", r.month, r.day, r.year,
		r.hour, r.minute, r.second);
	
	exit();
}
