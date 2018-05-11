
_hello:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
// basic user i/o as used in echo.c, cat.c, and wc.c 
#include "types.h"
#include "stat.h"
#include "user.h"

int main () {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 14             	sub    $0x14,%esp
	char string[] ="Hello World!";
  11:	c7 45 eb 48 65 6c 6c 	movl   $0x6c6c6548,-0x15(%ebp)
  18:	c7 45 ef 6f 20 57 6f 	movl   $0x6f57206f,-0x11(%ebp)
  1f:	c7 45 f3 72 6c 64 21 	movl   $0x21646c72,-0xd(%ebp)
  26:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
	printf(1, "%s\n", string); //file descriptor 1 is output
  2a:	83 ec 04             	sub    $0x4,%esp
  2d:	8d 45 eb             	lea    -0x15(%ebp),%eax
  30:	50                   	push   %eax
  31:	68 c9 07 00 00       	push   $0x7c9
  36:	6a 01                	push   $0x1
  38:	e8 d6 03 00 00       	call   413 <printf>
  3d:	83 c4 10             	add    $0x10,%esp
	exit();
  40:	e8 57 02 00 00       	call   29c <exit>

00000045 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  45:	55                   	push   %ebp
  46:	89 e5                	mov    %esp,%ebp
  48:	57                   	push   %edi
  49:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  4a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  4d:	8b 55 10             	mov    0x10(%ebp),%edx
  50:	8b 45 0c             	mov    0xc(%ebp),%eax
  53:	89 cb                	mov    %ecx,%ebx
  55:	89 df                	mov    %ebx,%edi
  57:	89 d1                	mov    %edx,%ecx
  59:	fc                   	cld    
  5a:	f3 aa                	rep stos %al,%es:(%edi)
  5c:	89 ca                	mov    %ecx,%edx
  5e:	89 fb                	mov    %edi,%ebx
  60:	89 5d 08             	mov    %ebx,0x8(%ebp)
  63:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  66:	90                   	nop
  67:	5b                   	pop    %ebx
  68:	5f                   	pop    %edi
  69:	5d                   	pop    %ebp
  6a:	c3                   	ret    

0000006b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  6b:	55                   	push   %ebp
  6c:	89 e5                	mov    %esp,%ebp
  6e:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  71:	8b 45 08             	mov    0x8(%ebp),%eax
  74:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  77:	90                   	nop
  78:	8b 45 08             	mov    0x8(%ebp),%eax
  7b:	8d 50 01             	lea    0x1(%eax),%edx
  7e:	89 55 08             	mov    %edx,0x8(%ebp)
  81:	8b 55 0c             	mov    0xc(%ebp),%edx
  84:	8d 4a 01             	lea    0x1(%edx),%ecx
  87:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8a:	0f b6 12             	movzbl (%edx),%edx
  8d:	88 10                	mov    %dl,(%eax)
  8f:	0f b6 00             	movzbl (%eax),%eax
  92:	84 c0                	test   %al,%al
  94:	75 e2                	jne    78 <strcpy+0xd>
    ;
  return os;
  96:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  99:	c9                   	leave  
  9a:	c3                   	ret    

0000009b <strcmp>:

int
strcmp(const char *p, const char *q)
{
  9b:	55                   	push   %ebp
  9c:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  9e:	eb 08                	jmp    a8 <strcmp+0xd>
    p++, q++;
  a0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  a4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  a8:	8b 45 08             	mov    0x8(%ebp),%eax
  ab:	0f b6 00             	movzbl (%eax),%eax
  ae:	84 c0                	test   %al,%al
  b0:	74 10                	je     c2 <strcmp+0x27>
  b2:	8b 45 08             	mov    0x8(%ebp),%eax
  b5:	0f b6 10             	movzbl (%eax),%edx
  b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  bb:	0f b6 00             	movzbl (%eax),%eax
  be:	38 c2                	cmp    %al,%dl
  c0:	74 de                	je     a0 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  c2:	8b 45 08             	mov    0x8(%ebp),%eax
  c5:	0f b6 00             	movzbl (%eax),%eax
  c8:	0f b6 d0             	movzbl %al,%edx
  cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  ce:	0f b6 00             	movzbl (%eax),%eax
  d1:	0f b6 c0             	movzbl %al,%eax
  d4:	29 c2                	sub    %eax,%edx
  d6:	89 d0                	mov    %edx,%eax
}
  d8:	5d                   	pop    %ebp
  d9:	c3                   	ret    

000000da <strlen>:

uint
strlen(char *s)
{
  da:	55                   	push   %ebp
  db:	89 e5                	mov    %esp,%ebp
  dd:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  e0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  e7:	eb 04                	jmp    ed <strlen+0x13>
  e9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  ed:	8b 55 fc             	mov    -0x4(%ebp),%edx
  f0:	8b 45 08             	mov    0x8(%ebp),%eax
  f3:	01 d0                	add    %edx,%eax
  f5:	0f b6 00             	movzbl (%eax),%eax
  f8:	84 c0                	test   %al,%al
  fa:	75 ed                	jne    e9 <strlen+0xf>
    ;
  return n;
  fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  ff:	c9                   	leave  
 100:	c3                   	ret    

00000101 <memset>:

void*
memset(void *dst, int c, uint n)
{
 101:	55                   	push   %ebp
 102:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 104:	8b 45 10             	mov    0x10(%ebp),%eax
 107:	50                   	push   %eax
 108:	ff 75 0c             	pushl  0xc(%ebp)
 10b:	ff 75 08             	pushl  0x8(%ebp)
 10e:	e8 32 ff ff ff       	call   45 <stosb>
 113:	83 c4 0c             	add    $0xc,%esp
  return dst;
 116:	8b 45 08             	mov    0x8(%ebp),%eax
}
 119:	c9                   	leave  
 11a:	c3                   	ret    

0000011b <strchr>:

char*
strchr(const char *s, char c)
{
 11b:	55                   	push   %ebp
 11c:	89 e5                	mov    %esp,%ebp
 11e:	83 ec 04             	sub    $0x4,%esp
 121:	8b 45 0c             	mov    0xc(%ebp),%eax
 124:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 127:	eb 14                	jmp    13d <strchr+0x22>
    if(*s == c)
 129:	8b 45 08             	mov    0x8(%ebp),%eax
 12c:	0f b6 00             	movzbl (%eax),%eax
 12f:	3a 45 fc             	cmp    -0x4(%ebp),%al
 132:	75 05                	jne    139 <strchr+0x1e>
      return (char*)s;
 134:	8b 45 08             	mov    0x8(%ebp),%eax
 137:	eb 13                	jmp    14c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 139:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 13d:	8b 45 08             	mov    0x8(%ebp),%eax
 140:	0f b6 00             	movzbl (%eax),%eax
 143:	84 c0                	test   %al,%al
 145:	75 e2                	jne    129 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 147:	b8 00 00 00 00       	mov    $0x0,%eax
}
 14c:	c9                   	leave  
 14d:	c3                   	ret    

0000014e <gets>:

char*
gets(char *buf, int max)
{
 14e:	55                   	push   %ebp
 14f:	89 e5                	mov    %esp,%ebp
 151:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 154:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 15b:	eb 42                	jmp    19f <gets+0x51>
    cc = read(0, &c, 1);
 15d:	83 ec 04             	sub    $0x4,%esp
 160:	6a 01                	push   $0x1
 162:	8d 45 ef             	lea    -0x11(%ebp),%eax
 165:	50                   	push   %eax
 166:	6a 00                	push   $0x0
 168:	e8 47 01 00 00       	call   2b4 <read>
 16d:	83 c4 10             	add    $0x10,%esp
 170:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 173:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 177:	7e 33                	jle    1ac <gets+0x5e>
      break;
    buf[i++] = c;
 179:	8b 45 f4             	mov    -0xc(%ebp),%eax
 17c:	8d 50 01             	lea    0x1(%eax),%edx
 17f:	89 55 f4             	mov    %edx,-0xc(%ebp)
 182:	89 c2                	mov    %eax,%edx
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	01 c2                	add    %eax,%edx
 189:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 18d:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 18f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 193:	3c 0a                	cmp    $0xa,%al
 195:	74 16                	je     1ad <gets+0x5f>
 197:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 19b:	3c 0d                	cmp    $0xd,%al
 19d:	74 0e                	je     1ad <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 19f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1a2:	83 c0 01             	add    $0x1,%eax
 1a5:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1a8:	7c b3                	jl     15d <gets+0xf>
 1aa:	eb 01                	jmp    1ad <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1ac:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1b0:	8b 45 08             	mov    0x8(%ebp),%eax
 1b3:	01 d0                	add    %edx,%eax
 1b5:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1b8:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1bb:	c9                   	leave  
 1bc:	c3                   	ret    

000001bd <stat>:

int
stat(char *n, struct stat *st)
{
 1bd:	55                   	push   %ebp
 1be:	89 e5                	mov    %esp,%ebp
 1c0:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c3:	83 ec 08             	sub    $0x8,%esp
 1c6:	6a 00                	push   $0x0
 1c8:	ff 75 08             	pushl  0x8(%ebp)
 1cb:	e8 0c 01 00 00       	call   2dc <open>
 1d0:	83 c4 10             	add    $0x10,%esp
 1d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1d6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1da:	79 07                	jns    1e3 <stat+0x26>
    return -1;
 1dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1e1:	eb 25                	jmp    208 <stat+0x4b>
  r = fstat(fd, st);
 1e3:	83 ec 08             	sub    $0x8,%esp
 1e6:	ff 75 0c             	pushl  0xc(%ebp)
 1e9:	ff 75 f4             	pushl  -0xc(%ebp)
 1ec:	e8 03 01 00 00       	call   2f4 <fstat>
 1f1:	83 c4 10             	add    $0x10,%esp
 1f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1f7:	83 ec 0c             	sub    $0xc,%esp
 1fa:	ff 75 f4             	pushl  -0xc(%ebp)
 1fd:	e8 c2 00 00 00       	call   2c4 <close>
 202:	83 c4 10             	add    $0x10,%esp
  return r;
 205:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 208:	c9                   	leave  
 209:	c3                   	ret    

0000020a <atoi>:

int
atoi(const char *s)
{
 20a:	55                   	push   %ebp
 20b:	89 e5                	mov    %esp,%ebp
 20d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 210:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 217:	eb 25                	jmp    23e <atoi+0x34>
    n = n*10 + *s++ - '0';
 219:	8b 55 fc             	mov    -0x4(%ebp),%edx
 21c:	89 d0                	mov    %edx,%eax
 21e:	c1 e0 02             	shl    $0x2,%eax
 221:	01 d0                	add    %edx,%eax
 223:	01 c0                	add    %eax,%eax
 225:	89 c1                	mov    %eax,%ecx
 227:	8b 45 08             	mov    0x8(%ebp),%eax
 22a:	8d 50 01             	lea    0x1(%eax),%edx
 22d:	89 55 08             	mov    %edx,0x8(%ebp)
 230:	0f b6 00             	movzbl (%eax),%eax
 233:	0f be c0             	movsbl %al,%eax
 236:	01 c8                	add    %ecx,%eax
 238:	83 e8 30             	sub    $0x30,%eax
 23b:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 23e:	8b 45 08             	mov    0x8(%ebp),%eax
 241:	0f b6 00             	movzbl (%eax),%eax
 244:	3c 2f                	cmp    $0x2f,%al
 246:	7e 0a                	jle    252 <atoi+0x48>
 248:	8b 45 08             	mov    0x8(%ebp),%eax
 24b:	0f b6 00             	movzbl (%eax),%eax
 24e:	3c 39                	cmp    $0x39,%al
 250:	7e c7                	jle    219 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 252:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 255:	c9                   	leave  
 256:	c3                   	ret    

00000257 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 257:	55                   	push   %ebp
 258:	89 e5                	mov    %esp,%ebp
 25a:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 25d:	8b 45 08             	mov    0x8(%ebp),%eax
 260:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 263:	8b 45 0c             	mov    0xc(%ebp),%eax
 266:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 269:	eb 17                	jmp    282 <memmove+0x2b>
    *dst++ = *src++;
 26b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 26e:	8d 50 01             	lea    0x1(%eax),%edx
 271:	89 55 fc             	mov    %edx,-0x4(%ebp)
 274:	8b 55 f8             	mov    -0x8(%ebp),%edx
 277:	8d 4a 01             	lea    0x1(%edx),%ecx
 27a:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 27d:	0f b6 12             	movzbl (%edx),%edx
 280:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 282:	8b 45 10             	mov    0x10(%ebp),%eax
 285:	8d 50 ff             	lea    -0x1(%eax),%edx
 288:	89 55 10             	mov    %edx,0x10(%ebp)
 28b:	85 c0                	test   %eax,%eax
 28d:	7f dc                	jg     26b <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 28f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 292:	c9                   	leave  
 293:	c3                   	ret    

00000294 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 294:	b8 01 00 00 00       	mov    $0x1,%eax
 299:	cd 40                	int    $0x40
 29b:	c3                   	ret    

0000029c <exit>:
SYSCALL(exit)
 29c:	b8 02 00 00 00       	mov    $0x2,%eax
 2a1:	cd 40                	int    $0x40
 2a3:	c3                   	ret    

000002a4 <wait>:
SYSCALL(wait)
 2a4:	b8 03 00 00 00       	mov    $0x3,%eax
 2a9:	cd 40                	int    $0x40
 2ab:	c3                   	ret    

000002ac <pipe>:
SYSCALL(pipe)
 2ac:	b8 04 00 00 00       	mov    $0x4,%eax
 2b1:	cd 40                	int    $0x40
 2b3:	c3                   	ret    

000002b4 <read>:
SYSCALL(read)
 2b4:	b8 05 00 00 00       	mov    $0x5,%eax
 2b9:	cd 40                	int    $0x40
 2bb:	c3                   	ret    

000002bc <write>:
SYSCALL(write)
 2bc:	b8 10 00 00 00       	mov    $0x10,%eax
 2c1:	cd 40                	int    $0x40
 2c3:	c3                   	ret    

000002c4 <close>:
SYSCALL(close)
 2c4:	b8 15 00 00 00       	mov    $0x15,%eax
 2c9:	cd 40                	int    $0x40
 2cb:	c3                   	ret    

000002cc <kill>:
SYSCALL(kill)
 2cc:	b8 06 00 00 00       	mov    $0x6,%eax
 2d1:	cd 40                	int    $0x40
 2d3:	c3                   	ret    

000002d4 <exec>:
SYSCALL(exec)
 2d4:	b8 07 00 00 00       	mov    $0x7,%eax
 2d9:	cd 40                	int    $0x40
 2db:	c3                   	ret    

000002dc <open>:
SYSCALL(open)
 2dc:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret    

000002e4 <mknod>:
SYSCALL(mknod)
 2e4:	b8 11 00 00 00       	mov    $0x11,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret    

000002ec <unlink>:
SYSCALL(unlink)
 2ec:	b8 12 00 00 00       	mov    $0x12,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret    

000002f4 <fstat>:
SYSCALL(fstat)
 2f4:	b8 08 00 00 00       	mov    $0x8,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <link>:
SYSCALL(link)
 2fc:	b8 13 00 00 00       	mov    $0x13,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <mkdir>:
SYSCALL(mkdir)
 304:	b8 14 00 00 00       	mov    $0x14,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <chdir>:
SYSCALL(chdir)
 30c:	b8 09 00 00 00       	mov    $0x9,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <dup>:
SYSCALL(dup)
 314:	b8 0a 00 00 00       	mov    $0xa,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <getpid>:
SYSCALL(getpid)
 31c:	b8 0b 00 00 00       	mov    $0xb,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <sbrk>:
SYSCALL(sbrk)
 324:	b8 0c 00 00 00       	mov    $0xc,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <sleep>:
SYSCALL(sleep)
 32c:	b8 0d 00 00 00       	mov    $0xd,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <uptime>:
SYSCALL(uptime)
 334:	b8 0e 00 00 00       	mov    $0xe,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 33c:	55                   	push   %ebp
 33d:	89 e5                	mov    %esp,%ebp
 33f:	83 ec 18             	sub    $0x18,%esp
 342:	8b 45 0c             	mov    0xc(%ebp),%eax
 345:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 348:	83 ec 04             	sub    $0x4,%esp
 34b:	6a 01                	push   $0x1
 34d:	8d 45 f4             	lea    -0xc(%ebp),%eax
 350:	50                   	push   %eax
 351:	ff 75 08             	pushl  0x8(%ebp)
 354:	e8 63 ff ff ff       	call   2bc <write>
 359:	83 c4 10             	add    $0x10,%esp
}
 35c:	90                   	nop
 35d:	c9                   	leave  
 35e:	c3                   	ret    

0000035f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 35f:	55                   	push   %ebp
 360:	89 e5                	mov    %esp,%ebp
 362:	53                   	push   %ebx
 363:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 366:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 36d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 371:	74 17                	je     38a <printint+0x2b>
 373:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 377:	79 11                	jns    38a <printint+0x2b>
    neg = 1;
 379:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 380:	8b 45 0c             	mov    0xc(%ebp),%eax
 383:	f7 d8                	neg    %eax
 385:	89 45 ec             	mov    %eax,-0x14(%ebp)
 388:	eb 06                	jmp    390 <printint+0x31>
  } else {
    x = xx;
 38a:	8b 45 0c             	mov    0xc(%ebp),%eax
 38d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 390:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 397:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 39a:	8d 41 01             	lea    0x1(%ecx),%eax
 39d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3a0:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3a6:	ba 00 00 00 00       	mov    $0x0,%edx
 3ab:	f7 f3                	div    %ebx
 3ad:	89 d0                	mov    %edx,%eax
 3af:	0f b6 80 1c 0a 00 00 	movzbl 0xa1c(%eax),%eax
 3b6:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3ba:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3c0:	ba 00 00 00 00       	mov    $0x0,%edx
 3c5:	f7 f3                	div    %ebx
 3c7:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3ca:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3ce:	75 c7                	jne    397 <printint+0x38>
  if(neg)
 3d0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3d4:	74 2d                	je     403 <printint+0xa4>
    buf[i++] = '-';
 3d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3d9:	8d 50 01             	lea    0x1(%eax),%edx
 3dc:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3df:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3e4:	eb 1d                	jmp    403 <printint+0xa4>
    putc(fd, buf[i]);
 3e6:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3ec:	01 d0                	add    %edx,%eax
 3ee:	0f b6 00             	movzbl (%eax),%eax
 3f1:	0f be c0             	movsbl %al,%eax
 3f4:	83 ec 08             	sub    $0x8,%esp
 3f7:	50                   	push   %eax
 3f8:	ff 75 08             	pushl  0x8(%ebp)
 3fb:	e8 3c ff ff ff       	call   33c <putc>
 400:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 403:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 407:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 40b:	79 d9                	jns    3e6 <printint+0x87>
    putc(fd, buf[i]);
}
 40d:	90                   	nop
 40e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 411:	c9                   	leave  
 412:	c3                   	ret    

00000413 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 413:	55                   	push   %ebp
 414:	89 e5                	mov    %esp,%ebp
 416:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 419:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 420:	8d 45 0c             	lea    0xc(%ebp),%eax
 423:	83 c0 04             	add    $0x4,%eax
 426:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 429:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 430:	e9 59 01 00 00       	jmp    58e <printf+0x17b>
    c = fmt[i] & 0xff;
 435:	8b 55 0c             	mov    0xc(%ebp),%edx
 438:	8b 45 f0             	mov    -0x10(%ebp),%eax
 43b:	01 d0                	add    %edx,%eax
 43d:	0f b6 00             	movzbl (%eax),%eax
 440:	0f be c0             	movsbl %al,%eax
 443:	25 ff 00 00 00       	and    $0xff,%eax
 448:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 44b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 44f:	75 2c                	jne    47d <printf+0x6a>
      if(c == '%'){
 451:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 455:	75 0c                	jne    463 <printf+0x50>
        state = '%';
 457:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 45e:	e9 27 01 00 00       	jmp    58a <printf+0x177>
      } else {
        putc(fd, c);
 463:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 466:	0f be c0             	movsbl %al,%eax
 469:	83 ec 08             	sub    $0x8,%esp
 46c:	50                   	push   %eax
 46d:	ff 75 08             	pushl  0x8(%ebp)
 470:	e8 c7 fe ff ff       	call   33c <putc>
 475:	83 c4 10             	add    $0x10,%esp
 478:	e9 0d 01 00 00       	jmp    58a <printf+0x177>
      }
    } else if(state == '%'){
 47d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 481:	0f 85 03 01 00 00    	jne    58a <printf+0x177>
      if(c == 'd'){
 487:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 48b:	75 1e                	jne    4ab <printf+0x98>
        printint(fd, *ap, 10, 1);
 48d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 490:	8b 00                	mov    (%eax),%eax
 492:	6a 01                	push   $0x1
 494:	6a 0a                	push   $0xa
 496:	50                   	push   %eax
 497:	ff 75 08             	pushl  0x8(%ebp)
 49a:	e8 c0 fe ff ff       	call   35f <printint>
 49f:	83 c4 10             	add    $0x10,%esp
        ap++;
 4a2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4a6:	e9 d8 00 00 00       	jmp    583 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4ab:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4af:	74 06                	je     4b7 <printf+0xa4>
 4b1:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4b5:	75 1e                	jne    4d5 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4b7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ba:	8b 00                	mov    (%eax),%eax
 4bc:	6a 00                	push   $0x0
 4be:	6a 10                	push   $0x10
 4c0:	50                   	push   %eax
 4c1:	ff 75 08             	pushl  0x8(%ebp)
 4c4:	e8 96 fe ff ff       	call   35f <printint>
 4c9:	83 c4 10             	add    $0x10,%esp
        ap++;
 4cc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4d0:	e9 ae 00 00 00       	jmp    583 <printf+0x170>
      } else if(c == 's'){
 4d5:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4d9:	75 43                	jne    51e <printf+0x10b>
        s = (char*)*ap;
 4db:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4de:	8b 00                	mov    (%eax),%eax
 4e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4e3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4e7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4eb:	75 25                	jne    512 <printf+0xff>
          s = "(null)";
 4ed:	c7 45 f4 cd 07 00 00 	movl   $0x7cd,-0xc(%ebp)
        while(*s != 0){
 4f4:	eb 1c                	jmp    512 <printf+0xff>
          putc(fd, *s);
 4f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4f9:	0f b6 00             	movzbl (%eax),%eax
 4fc:	0f be c0             	movsbl %al,%eax
 4ff:	83 ec 08             	sub    $0x8,%esp
 502:	50                   	push   %eax
 503:	ff 75 08             	pushl  0x8(%ebp)
 506:	e8 31 fe ff ff       	call   33c <putc>
 50b:	83 c4 10             	add    $0x10,%esp
          s++;
 50e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 512:	8b 45 f4             	mov    -0xc(%ebp),%eax
 515:	0f b6 00             	movzbl (%eax),%eax
 518:	84 c0                	test   %al,%al
 51a:	75 da                	jne    4f6 <printf+0xe3>
 51c:	eb 65                	jmp    583 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 51e:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 522:	75 1d                	jne    541 <printf+0x12e>
        putc(fd, *ap);
 524:	8b 45 e8             	mov    -0x18(%ebp),%eax
 527:	8b 00                	mov    (%eax),%eax
 529:	0f be c0             	movsbl %al,%eax
 52c:	83 ec 08             	sub    $0x8,%esp
 52f:	50                   	push   %eax
 530:	ff 75 08             	pushl  0x8(%ebp)
 533:	e8 04 fe ff ff       	call   33c <putc>
 538:	83 c4 10             	add    $0x10,%esp
        ap++;
 53b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 53f:	eb 42                	jmp    583 <printf+0x170>
      } else if(c == '%'){
 541:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 545:	75 17                	jne    55e <printf+0x14b>
        putc(fd, c);
 547:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 54a:	0f be c0             	movsbl %al,%eax
 54d:	83 ec 08             	sub    $0x8,%esp
 550:	50                   	push   %eax
 551:	ff 75 08             	pushl  0x8(%ebp)
 554:	e8 e3 fd ff ff       	call   33c <putc>
 559:	83 c4 10             	add    $0x10,%esp
 55c:	eb 25                	jmp    583 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 55e:	83 ec 08             	sub    $0x8,%esp
 561:	6a 25                	push   $0x25
 563:	ff 75 08             	pushl  0x8(%ebp)
 566:	e8 d1 fd ff ff       	call   33c <putc>
 56b:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 56e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 571:	0f be c0             	movsbl %al,%eax
 574:	83 ec 08             	sub    $0x8,%esp
 577:	50                   	push   %eax
 578:	ff 75 08             	pushl  0x8(%ebp)
 57b:	e8 bc fd ff ff       	call   33c <putc>
 580:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 583:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 58a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 58e:	8b 55 0c             	mov    0xc(%ebp),%edx
 591:	8b 45 f0             	mov    -0x10(%ebp),%eax
 594:	01 d0                	add    %edx,%eax
 596:	0f b6 00             	movzbl (%eax),%eax
 599:	84 c0                	test   %al,%al
 59b:	0f 85 94 fe ff ff    	jne    435 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5a1:	90                   	nop
 5a2:	c9                   	leave  
 5a3:	c3                   	ret    

000005a4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5a4:	55                   	push   %ebp
 5a5:	89 e5                	mov    %esp,%ebp
 5a7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5aa:	8b 45 08             	mov    0x8(%ebp),%eax
 5ad:	83 e8 08             	sub    $0x8,%eax
 5b0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5b3:	a1 38 0a 00 00       	mov    0xa38,%eax
 5b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5bb:	eb 24                	jmp    5e1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5c0:	8b 00                	mov    (%eax),%eax
 5c2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5c5:	77 12                	ja     5d9 <free+0x35>
 5c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5ca:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5cd:	77 24                	ja     5f3 <free+0x4f>
 5cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5d2:	8b 00                	mov    (%eax),%eax
 5d4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5d7:	77 1a                	ja     5f3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5dc:	8b 00                	mov    (%eax),%eax
 5de:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5e4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5e7:	76 d4                	jbe    5bd <free+0x19>
 5e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5ec:	8b 00                	mov    (%eax),%eax
 5ee:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5f1:	76 ca                	jbe    5bd <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f6:	8b 40 04             	mov    0x4(%eax),%eax
 5f9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 600:	8b 45 f8             	mov    -0x8(%ebp),%eax
 603:	01 c2                	add    %eax,%edx
 605:	8b 45 fc             	mov    -0x4(%ebp),%eax
 608:	8b 00                	mov    (%eax),%eax
 60a:	39 c2                	cmp    %eax,%edx
 60c:	75 24                	jne    632 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 60e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 611:	8b 50 04             	mov    0x4(%eax),%edx
 614:	8b 45 fc             	mov    -0x4(%ebp),%eax
 617:	8b 00                	mov    (%eax),%eax
 619:	8b 40 04             	mov    0x4(%eax),%eax
 61c:	01 c2                	add    %eax,%edx
 61e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 621:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 624:	8b 45 fc             	mov    -0x4(%ebp),%eax
 627:	8b 00                	mov    (%eax),%eax
 629:	8b 10                	mov    (%eax),%edx
 62b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62e:	89 10                	mov    %edx,(%eax)
 630:	eb 0a                	jmp    63c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 632:	8b 45 fc             	mov    -0x4(%ebp),%eax
 635:	8b 10                	mov    (%eax),%edx
 637:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 63c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63f:	8b 40 04             	mov    0x4(%eax),%eax
 642:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 649:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64c:	01 d0                	add    %edx,%eax
 64e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 651:	75 20                	jne    673 <free+0xcf>
    p->s.size += bp->s.size;
 653:	8b 45 fc             	mov    -0x4(%ebp),%eax
 656:	8b 50 04             	mov    0x4(%eax),%edx
 659:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65c:	8b 40 04             	mov    0x4(%eax),%eax
 65f:	01 c2                	add    %eax,%edx
 661:	8b 45 fc             	mov    -0x4(%ebp),%eax
 664:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 667:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66a:	8b 10                	mov    (%eax),%edx
 66c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66f:	89 10                	mov    %edx,(%eax)
 671:	eb 08                	jmp    67b <free+0xd7>
  } else
    p->s.ptr = bp;
 673:	8b 45 fc             	mov    -0x4(%ebp),%eax
 676:	8b 55 f8             	mov    -0x8(%ebp),%edx
 679:	89 10                	mov    %edx,(%eax)
  freep = p;
 67b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67e:	a3 38 0a 00 00       	mov    %eax,0xa38
}
 683:	90                   	nop
 684:	c9                   	leave  
 685:	c3                   	ret    

00000686 <morecore>:

static Header*
morecore(uint nu)
{
 686:	55                   	push   %ebp
 687:	89 e5                	mov    %esp,%ebp
 689:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 68c:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 693:	77 07                	ja     69c <morecore+0x16>
    nu = 4096;
 695:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 69c:	8b 45 08             	mov    0x8(%ebp),%eax
 69f:	c1 e0 03             	shl    $0x3,%eax
 6a2:	83 ec 0c             	sub    $0xc,%esp
 6a5:	50                   	push   %eax
 6a6:	e8 79 fc ff ff       	call   324 <sbrk>
 6ab:	83 c4 10             	add    $0x10,%esp
 6ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6b1:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6b5:	75 07                	jne    6be <morecore+0x38>
    return 0;
 6b7:	b8 00 00 00 00       	mov    $0x0,%eax
 6bc:	eb 26                	jmp    6e4 <morecore+0x5e>
  hp = (Header*)p;
 6be:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6c7:	8b 55 08             	mov    0x8(%ebp),%edx
 6ca:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d0:	83 c0 08             	add    $0x8,%eax
 6d3:	83 ec 0c             	sub    $0xc,%esp
 6d6:	50                   	push   %eax
 6d7:	e8 c8 fe ff ff       	call   5a4 <free>
 6dc:	83 c4 10             	add    $0x10,%esp
  return freep;
 6df:	a1 38 0a 00 00       	mov    0xa38,%eax
}
 6e4:	c9                   	leave  
 6e5:	c3                   	ret    

000006e6 <malloc>:

void*
malloc(uint nbytes)
{
 6e6:	55                   	push   %ebp
 6e7:	89 e5                	mov    %esp,%ebp
 6e9:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6ec:	8b 45 08             	mov    0x8(%ebp),%eax
 6ef:	83 c0 07             	add    $0x7,%eax
 6f2:	c1 e8 03             	shr    $0x3,%eax
 6f5:	83 c0 01             	add    $0x1,%eax
 6f8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 6fb:	a1 38 0a 00 00       	mov    0xa38,%eax
 700:	89 45 f0             	mov    %eax,-0x10(%ebp)
 703:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 707:	75 23                	jne    72c <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 709:	c7 45 f0 30 0a 00 00 	movl   $0xa30,-0x10(%ebp)
 710:	8b 45 f0             	mov    -0x10(%ebp),%eax
 713:	a3 38 0a 00 00       	mov    %eax,0xa38
 718:	a1 38 0a 00 00       	mov    0xa38,%eax
 71d:	a3 30 0a 00 00       	mov    %eax,0xa30
    base.s.size = 0;
 722:	c7 05 34 0a 00 00 00 	movl   $0x0,0xa34
 729:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 72c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 72f:	8b 00                	mov    (%eax),%eax
 731:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 734:	8b 45 f4             	mov    -0xc(%ebp),%eax
 737:	8b 40 04             	mov    0x4(%eax),%eax
 73a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 73d:	72 4d                	jb     78c <malloc+0xa6>
      if(p->s.size == nunits)
 73f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 742:	8b 40 04             	mov    0x4(%eax),%eax
 745:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 748:	75 0c                	jne    756 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 74a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74d:	8b 10                	mov    (%eax),%edx
 74f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 752:	89 10                	mov    %edx,(%eax)
 754:	eb 26                	jmp    77c <malloc+0x96>
      else {
        p->s.size -= nunits;
 756:	8b 45 f4             	mov    -0xc(%ebp),%eax
 759:	8b 40 04             	mov    0x4(%eax),%eax
 75c:	2b 45 ec             	sub    -0x14(%ebp),%eax
 75f:	89 c2                	mov    %eax,%edx
 761:	8b 45 f4             	mov    -0xc(%ebp),%eax
 764:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 767:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76a:	8b 40 04             	mov    0x4(%eax),%eax
 76d:	c1 e0 03             	shl    $0x3,%eax
 770:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 773:	8b 45 f4             	mov    -0xc(%ebp),%eax
 776:	8b 55 ec             	mov    -0x14(%ebp),%edx
 779:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 77c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77f:	a3 38 0a 00 00       	mov    %eax,0xa38
      return (void*)(p + 1);
 784:	8b 45 f4             	mov    -0xc(%ebp),%eax
 787:	83 c0 08             	add    $0x8,%eax
 78a:	eb 3b                	jmp    7c7 <malloc+0xe1>
    }
    if(p == freep)
 78c:	a1 38 0a 00 00       	mov    0xa38,%eax
 791:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 794:	75 1e                	jne    7b4 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 796:	83 ec 0c             	sub    $0xc,%esp
 799:	ff 75 ec             	pushl  -0x14(%ebp)
 79c:	e8 e5 fe ff ff       	call   686 <morecore>
 7a1:	83 c4 10             	add    $0x10,%esp
 7a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7a7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7ab:	75 07                	jne    7b4 <malloc+0xce>
        return 0;
 7ad:	b8 00 00 00 00       	mov    $0x0,%eax
 7b2:	eb 13                	jmp    7c7 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7bd:	8b 00                	mov    (%eax),%eax
 7bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7c2:	e9 6d ff ff ff       	jmp    734 <malloc+0x4e>
}
 7c7:	c9                   	leave  
 7c8:	c3                   	ret    
