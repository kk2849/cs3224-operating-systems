#include "types.h"
#include "stat.h"
#include "user.h"

#define BUFSZ 512
char *buf;

void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, BUFSZ)) > 0)
    write(1, buf, n);
  if(n < 0){
    printf(1, "cat: read error\n");
    exit();
  }
}

int
main(int argc, char *argv[])
{
  int fd, i;

  buf = sbrk(BUFSZ);

  if(argc <= 1){
    cat(0);
    exit();
  }
  
  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
}
