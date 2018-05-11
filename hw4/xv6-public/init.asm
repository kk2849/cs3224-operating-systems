
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 14             	sub    $0x14,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
  11:	83 ec 08             	sub    $0x8,%esp
  14:	6a 02                	push   $0x2
  16:	68 aa 08 00 00       	push   $0x8aa
  1b:	e8 8a 03 00 00       	call   3aa <open>
  20:	83 c4 10             	add    $0x10,%esp
  23:	85 c0                	test   %eax,%eax
  25:	79 26                	jns    4d <main+0x4d>
    mknod("console", 1, 1);
  27:	83 ec 04             	sub    $0x4,%esp
  2a:	6a 01                	push   $0x1
  2c:	6a 01                	push   $0x1
  2e:	68 aa 08 00 00       	push   $0x8aa
  33:	e8 7a 03 00 00       	call   3b2 <mknod>
  38:	83 c4 10             	add    $0x10,%esp
    open("console", O_RDWR);
  3b:	83 ec 08             	sub    $0x8,%esp
  3e:	6a 02                	push   $0x2
  40:	68 aa 08 00 00       	push   $0x8aa
  45:	e8 60 03 00 00       	call   3aa <open>
  4a:	83 c4 10             	add    $0x10,%esp
  }
  dup(0);  // stdout
  4d:	83 ec 0c             	sub    $0xc,%esp
  50:	6a 00                	push   $0x0
  52:	e8 8b 03 00 00       	call   3e2 <dup>
  57:	83 c4 10             	add    $0x10,%esp
  dup(0);  // stderr
  5a:	83 ec 0c             	sub    $0xc,%esp
  5d:	6a 00                	push   $0x0
  5f:	e8 7e 03 00 00       	call   3e2 <dup>
  64:	83 c4 10             	add    $0x10,%esp

  #ifdef DEFAULT
    printf(1, "Scheduler policy: DEFAULT\n");
  67:	83 ec 08             	sub    $0x8,%esp
  6a:	68 b2 08 00 00       	push   $0x8b2
  6f:	6a 01                	push   $0x1
  71:	e8 7b 04 00 00       	call   4f1 <printf>
  76:	83 c4 10             	add    $0x10,%esp
    printf(1, "Scheduler policy: FCFS\n");
  #endif


  for(;;){
    printf(1, "init: starting sh\n");
  79:	83 ec 08             	sub    $0x8,%esp
  7c:	68 cd 08 00 00       	push   $0x8cd
  81:	6a 01                	push   $0x1
  83:	e8 69 04 00 00       	call   4f1 <printf>
  88:	83 c4 10             	add    $0x10,%esp
    pid = fork();
  8b:	e8 d2 02 00 00       	call   362 <fork>
  90:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(pid < 0){
  93:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  97:	79 17                	jns    b0 <main+0xb0>
      printf(1, "init: fork failed\n");
  99:	83 ec 08             	sub    $0x8,%esp
  9c:	68 e0 08 00 00       	push   $0x8e0
  a1:	6a 01                	push   $0x1
  a3:	e8 49 04 00 00       	call   4f1 <printf>
  a8:	83 c4 10             	add    $0x10,%esp
      exit();
  ab:	e8 ba 02 00 00       	call   36a <exit>
    }
    if(pid == 0){
  b0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  b4:	75 3e                	jne    f4 <main+0xf4>
      exec("sh", argv);
  b6:	83 ec 08             	sub    $0x8,%esp
  b9:	68 64 0b 00 00       	push   $0xb64
  be:	68 a7 08 00 00       	push   $0x8a7
  c3:	e8 da 02 00 00       	call   3a2 <exec>
  c8:	83 c4 10             	add    $0x10,%esp
      printf(1, "init: exec sh failed\n");
  cb:	83 ec 08             	sub    $0x8,%esp
  ce:	68 f3 08 00 00       	push   $0x8f3
  d3:	6a 01                	push   $0x1
  d5:	e8 17 04 00 00       	call   4f1 <printf>
  da:	83 c4 10             	add    $0x10,%esp
      exit();
  dd:	e8 88 02 00 00       	call   36a <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  e2:	83 ec 08             	sub    $0x8,%esp
  e5:	68 09 09 00 00       	push   $0x909
  ea:	6a 01                	push   $0x1
  ec:	e8 00 04 00 00       	call   4f1 <printf>
  f1:	83 c4 10             	add    $0x10,%esp
    if(pid == 0){
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  f4:	e8 79 02 00 00       	call   372 <wait>
  f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  fc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 100:	0f 88 73 ff ff ff    	js     79 <main+0x79>
 106:	8b 45 f0             	mov    -0x10(%ebp),%eax
 109:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 10c:	75 d4                	jne    e2 <main+0xe2>
      printf(1, "zombie!\n");
  }
 10e:	e9 66 ff ff ff       	jmp    79 <main+0x79>

00000113 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 113:	55                   	push   %ebp
 114:	89 e5                	mov    %esp,%ebp
 116:	57                   	push   %edi
 117:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 118:	8b 4d 08             	mov    0x8(%ebp),%ecx
 11b:	8b 55 10             	mov    0x10(%ebp),%edx
 11e:	8b 45 0c             	mov    0xc(%ebp),%eax
 121:	89 cb                	mov    %ecx,%ebx
 123:	89 df                	mov    %ebx,%edi
 125:	89 d1                	mov    %edx,%ecx
 127:	fc                   	cld    
 128:	f3 aa                	rep stos %al,%es:(%edi)
 12a:	89 ca                	mov    %ecx,%edx
 12c:	89 fb                	mov    %edi,%ebx
 12e:	89 5d 08             	mov    %ebx,0x8(%ebp)
 131:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 134:	90                   	nop
 135:	5b                   	pop    %ebx
 136:	5f                   	pop    %edi
 137:	5d                   	pop    %ebp
 138:	c3                   	ret    

00000139 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 139:	55                   	push   %ebp
 13a:	89 e5                	mov    %esp,%ebp
 13c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 13f:	8b 45 08             	mov    0x8(%ebp),%eax
 142:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 145:	90                   	nop
 146:	8b 45 08             	mov    0x8(%ebp),%eax
 149:	8d 50 01             	lea    0x1(%eax),%edx
 14c:	89 55 08             	mov    %edx,0x8(%ebp)
 14f:	8b 55 0c             	mov    0xc(%ebp),%edx
 152:	8d 4a 01             	lea    0x1(%edx),%ecx
 155:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 158:	0f b6 12             	movzbl (%edx),%edx
 15b:	88 10                	mov    %dl,(%eax)
 15d:	0f b6 00             	movzbl (%eax),%eax
 160:	84 c0                	test   %al,%al
 162:	75 e2                	jne    146 <strcpy+0xd>
    ;
  return os;
 164:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 167:	c9                   	leave  
 168:	c3                   	ret    

00000169 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 169:	55                   	push   %ebp
 16a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 16c:	eb 08                	jmp    176 <strcmp+0xd>
    p++, q++;
 16e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 172:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 176:	8b 45 08             	mov    0x8(%ebp),%eax
 179:	0f b6 00             	movzbl (%eax),%eax
 17c:	84 c0                	test   %al,%al
 17e:	74 10                	je     190 <strcmp+0x27>
 180:	8b 45 08             	mov    0x8(%ebp),%eax
 183:	0f b6 10             	movzbl (%eax),%edx
 186:	8b 45 0c             	mov    0xc(%ebp),%eax
 189:	0f b6 00             	movzbl (%eax),%eax
 18c:	38 c2                	cmp    %al,%dl
 18e:	74 de                	je     16e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 190:	8b 45 08             	mov    0x8(%ebp),%eax
 193:	0f b6 00             	movzbl (%eax),%eax
 196:	0f b6 d0             	movzbl %al,%edx
 199:	8b 45 0c             	mov    0xc(%ebp),%eax
 19c:	0f b6 00             	movzbl (%eax),%eax
 19f:	0f b6 c0             	movzbl %al,%eax
 1a2:	29 c2                	sub    %eax,%edx
 1a4:	89 d0                	mov    %edx,%eax
}
 1a6:	5d                   	pop    %ebp
 1a7:	c3                   	ret    

000001a8 <strlen>:

uint
strlen(char *s)
{
 1a8:	55                   	push   %ebp
 1a9:	89 e5                	mov    %esp,%ebp
 1ab:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1ae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1b5:	eb 04                	jmp    1bb <strlen+0x13>
 1b7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1bb:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1be:	8b 45 08             	mov    0x8(%ebp),%eax
 1c1:	01 d0                	add    %edx,%eax
 1c3:	0f b6 00             	movzbl (%eax),%eax
 1c6:	84 c0                	test   %al,%al
 1c8:	75 ed                	jne    1b7 <strlen+0xf>
    ;
  return n;
 1ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1cd:	c9                   	leave  
 1ce:	c3                   	ret    

000001cf <memset>:

void*
memset(void *dst, int c, uint n)
{
 1cf:	55                   	push   %ebp
 1d0:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1d2:	8b 45 10             	mov    0x10(%ebp),%eax
 1d5:	50                   	push   %eax
 1d6:	ff 75 0c             	pushl  0xc(%ebp)
 1d9:	ff 75 08             	pushl  0x8(%ebp)
 1dc:	e8 32 ff ff ff       	call   113 <stosb>
 1e1:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1e4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1e7:	c9                   	leave  
 1e8:	c3                   	ret    

000001e9 <strchr>:

char*
strchr(const char *s, char c)
{
 1e9:	55                   	push   %ebp
 1ea:	89 e5                	mov    %esp,%ebp
 1ec:	83 ec 04             	sub    $0x4,%esp
 1ef:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f2:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1f5:	eb 14                	jmp    20b <strchr+0x22>
    if(*s == c)
 1f7:	8b 45 08             	mov    0x8(%ebp),%eax
 1fa:	0f b6 00             	movzbl (%eax),%eax
 1fd:	3a 45 fc             	cmp    -0x4(%ebp),%al
 200:	75 05                	jne    207 <strchr+0x1e>
      return (char*)s;
 202:	8b 45 08             	mov    0x8(%ebp),%eax
 205:	eb 13                	jmp    21a <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 207:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 20b:	8b 45 08             	mov    0x8(%ebp),%eax
 20e:	0f b6 00             	movzbl (%eax),%eax
 211:	84 c0                	test   %al,%al
 213:	75 e2                	jne    1f7 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 215:	b8 00 00 00 00       	mov    $0x0,%eax
}
 21a:	c9                   	leave  
 21b:	c3                   	ret    

0000021c <gets>:

char*
gets(char *buf, int max)
{
 21c:	55                   	push   %ebp
 21d:	89 e5                	mov    %esp,%ebp
 21f:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 222:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 229:	eb 42                	jmp    26d <gets+0x51>
    cc = read(0, &c, 1);
 22b:	83 ec 04             	sub    $0x4,%esp
 22e:	6a 01                	push   $0x1
 230:	8d 45 ef             	lea    -0x11(%ebp),%eax
 233:	50                   	push   %eax
 234:	6a 00                	push   $0x0
 236:	e8 47 01 00 00       	call   382 <read>
 23b:	83 c4 10             	add    $0x10,%esp
 23e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 241:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 245:	7e 33                	jle    27a <gets+0x5e>
      break;
    buf[i++] = c;
 247:	8b 45 f4             	mov    -0xc(%ebp),%eax
 24a:	8d 50 01             	lea    0x1(%eax),%edx
 24d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 250:	89 c2                	mov    %eax,%edx
 252:	8b 45 08             	mov    0x8(%ebp),%eax
 255:	01 c2                	add    %eax,%edx
 257:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 25b:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 25d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 261:	3c 0a                	cmp    $0xa,%al
 263:	74 16                	je     27b <gets+0x5f>
 265:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 269:	3c 0d                	cmp    $0xd,%al
 26b:	74 0e                	je     27b <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 26d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 270:	83 c0 01             	add    $0x1,%eax
 273:	3b 45 0c             	cmp    0xc(%ebp),%eax
 276:	7c b3                	jl     22b <gets+0xf>
 278:	eb 01                	jmp    27b <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 27a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 27b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 27e:	8b 45 08             	mov    0x8(%ebp),%eax
 281:	01 d0                	add    %edx,%eax
 283:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 286:	8b 45 08             	mov    0x8(%ebp),%eax
}
 289:	c9                   	leave  
 28a:	c3                   	ret    

0000028b <stat>:

int
stat(char *n, struct stat *st)
{
 28b:	55                   	push   %ebp
 28c:	89 e5                	mov    %esp,%ebp
 28e:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 291:	83 ec 08             	sub    $0x8,%esp
 294:	6a 00                	push   $0x0
 296:	ff 75 08             	pushl  0x8(%ebp)
 299:	e8 0c 01 00 00       	call   3aa <open>
 29e:	83 c4 10             	add    $0x10,%esp
 2a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2a4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2a8:	79 07                	jns    2b1 <stat+0x26>
    return -1;
 2aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2af:	eb 25                	jmp    2d6 <stat+0x4b>
  r = fstat(fd, st);
 2b1:	83 ec 08             	sub    $0x8,%esp
 2b4:	ff 75 0c             	pushl  0xc(%ebp)
 2b7:	ff 75 f4             	pushl  -0xc(%ebp)
 2ba:	e8 03 01 00 00       	call   3c2 <fstat>
 2bf:	83 c4 10             	add    $0x10,%esp
 2c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2c5:	83 ec 0c             	sub    $0xc,%esp
 2c8:	ff 75 f4             	pushl  -0xc(%ebp)
 2cb:	e8 c2 00 00 00       	call   392 <close>
 2d0:	83 c4 10             	add    $0x10,%esp
  return r;
 2d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2d6:	c9                   	leave  
 2d7:	c3                   	ret    

000002d8 <atoi>:

int
atoi(const char *s)
{
 2d8:	55                   	push   %ebp
 2d9:	89 e5                	mov    %esp,%ebp
 2db:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2e5:	eb 25                	jmp    30c <atoi+0x34>
    n = n*10 + *s++ - '0';
 2e7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2ea:	89 d0                	mov    %edx,%eax
 2ec:	c1 e0 02             	shl    $0x2,%eax
 2ef:	01 d0                	add    %edx,%eax
 2f1:	01 c0                	add    %eax,%eax
 2f3:	89 c1                	mov    %eax,%ecx
 2f5:	8b 45 08             	mov    0x8(%ebp),%eax
 2f8:	8d 50 01             	lea    0x1(%eax),%edx
 2fb:	89 55 08             	mov    %edx,0x8(%ebp)
 2fe:	0f b6 00             	movzbl (%eax),%eax
 301:	0f be c0             	movsbl %al,%eax
 304:	01 c8                	add    %ecx,%eax
 306:	83 e8 30             	sub    $0x30,%eax
 309:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 30c:	8b 45 08             	mov    0x8(%ebp),%eax
 30f:	0f b6 00             	movzbl (%eax),%eax
 312:	3c 2f                	cmp    $0x2f,%al
 314:	7e 0a                	jle    320 <atoi+0x48>
 316:	8b 45 08             	mov    0x8(%ebp),%eax
 319:	0f b6 00             	movzbl (%eax),%eax
 31c:	3c 39                	cmp    $0x39,%al
 31e:	7e c7                	jle    2e7 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 320:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 323:	c9                   	leave  
 324:	c3                   	ret    

00000325 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 325:	55                   	push   %ebp
 326:	89 e5                	mov    %esp,%ebp
 328:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 32b:	8b 45 08             	mov    0x8(%ebp),%eax
 32e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 331:	8b 45 0c             	mov    0xc(%ebp),%eax
 334:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 337:	eb 17                	jmp    350 <memmove+0x2b>
    *dst++ = *src++;
 339:	8b 45 fc             	mov    -0x4(%ebp),%eax
 33c:	8d 50 01             	lea    0x1(%eax),%edx
 33f:	89 55 fc             	mov    %edx,-0x4(%ebp)
 342:	8b 55 f8             	mov    -0x8(%ebp),%edx
 345:	8d 4a 01             	lea    0x1(%edx),%ecx
 348:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 34b:	0f b6 12             	movzbl (%edx),%edx
 34e:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 350:	8b 45 10             	mov    0x10(%ebp),%eax
 353:	8d 50 ff             	lea    -0x1(%eax),%edx
 356:	89 55 10             	mov    %edx,0x10(%ebp)
 359:	85 c0                	test   %eax,%eax
 35b:	7f dc                	jg     339 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 35d:	8b 45 08             	mov    0x8(%ebp),%eax
}
 360:	c9                   	leave  
 361:	c3                   	ret    

00000362 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 362:	b8 01 00 00 00       	mov    $0x1,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <exit>:
SYSCALL(exit)
 36a:	b8 02 00 00 00       	mov    $0x2,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <wait>:
SYSCALL(wait)
 372:	b8 03 00 00 00       	mov    $0x3,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <pipe>:
SYSCALL(pipe)
 37a:	b8 04 00 00 00       	mov    $0x4,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <read>:
SYSCALL(read)
 382:	b8 05 00 00 00       	mov    $0x5,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <write>:
SYSCALL(write)
 38a:	b8 10 00 00 00       	mov    $0x10,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <close>:
SYSCALL(close)
 392:	b8 15 00 00 00       	mov    $0x15,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <kill>:
SYSCALL(kill)
 39a:	b8 06 00 00 00       	mov    $0x6,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <exec>:
SYSCALL(exec)
 3a2:	b8 07 00 00 00       	mov    $0x7,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <open>:
SYSCALL(open)
 3aa:	b8 0f 00 00 00       	mov    $0xf,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <mknod>:
SYSCALL(mknod)
 3b2:	b8 11 00 00 00       	mov    $0x11,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <unlink>:
SYSCALL(unlink)
 3ba:	b8 12 00 00 00       	mov    $0x12,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <fstat>:
SYSCALL(fstat)
 3c2:	b8 08 00 00 00       	mov    $0x8,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <link>:
SYSCALL(link)
 3ca:	b8 13 00 00 00       	mov    $0x13,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <mkdir>:
SYSCALL(mkdir)
 3d2:	b8 14 00 00 00       	mov    $0x14,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <chdir>:
SYSCALL(chdir)
 3da:	b8 09 00 00 00       	mov    $0x9,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <dup>:
SYSCALL(dup)
 3e2:	b8 0a 00 00 00       	mov    $0xa,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <getpid>:
SYSCALL(getpid)
 3ea:	b8 0b 00 00 00       	mov    $0xb,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <sbrk>:
SYSCALL(sbrk)
 3f2:	b8 0c 00 00 00       	mov    $0xc,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <sleep>:
SYSCALL(sleep)
 3fa:	b8 0d 00 00 00       	mov    $0xd,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <uptime>:
SYSCALL(uptime)
 402:	b8 0e 00 00 00       	mov    $0xe,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <wait_stat>:
SYSCALL(wait_stat)
 40a:	b8 16 00 00 00       	mov    $0x16,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <yield>:
SYSCALL(yield)
 412:	b8 17 00 00 00       	mov    $0x17,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 41a:	55                   	push   %ebp
 41b:	89 e5                	mov    %esp,%ebp
 41d:	83 ec 18             	sub    $0x18,%esp
 420:	8b 45 0c             	mov    0xc(%ebp),%eax
 423:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 426:	83 ec 04             	sub    $0x4,%esp
 429:	6a 01                	push   $0x1
 42b:	8d 45 f4             	lea    -0xc(%ebp),%eax
 42e:	50                   	push   %eax
 42f:	ff 75 08             	pushl  0x8(%ebp)
 432:	e8 53 ff ff ff       	call   38a <write>
 437:	83 c4 10             	add    $0x10,%esp
}
 43a:	90                   	nop
 43b:	c9                   	leave  
 43c:	c3                   	ret    

0000043d <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 43d:	55                   	push   %ebp
 43e:	89 e5                	mov    %esp,%ebp
 440:	53                   	push   %ebx
 441:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 444:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 44b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 44f:	74 17                	je     468 <printint+0x2b>
 451:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 455:	79 11                	jns    468 <printint+0x2b>
    neg = 1;
 457:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 45e:	8b 45 0c             	mov    0xc(%ebp),%eax
 461:	f7 d8                	neg    %eax
 463:	89 45 ec             	mov    %eax,-0x14(%ebp)
 466:	eb 06                	jmp    46e <printint+0x31>
  } else {
    x = xx;
 468:	8b 45 0c             	mov    0xc(%ebp),%eax
 46b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 46e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 475:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 478:	8d 41 01             	lea    0x1(%ecx),%eax
 47b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 47e:	8b 5d 10             	mov    0x10(%ebp),%ebx
 481:	8b 45 ec             	mov    -0x14(%ebp),%eax
 484:	ba 00 00 00 00       	mov    $0x0,%edx
 489:	f7 f3                	div    %ebx
 48b:	89 d0                	mov    %edx,%eax
 48d:	0f b6 80 6c 0b 00 00 	movzbl 0xb6c(%eax),%eax
 494:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 498:	8b 5d 10             	mov    0x10(%ebp),%ebx
 49b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 49e:	ba 00 00 00 00       	mov    $0x0,%edx
 4a3:	f7 f3                	div    %ebx
 4a5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4a8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4ac:	75 c7                	jne    475 <printint+0x38>
  if(neg)
 4ae:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4b2:	74 2d                	je     4e1 <printint+0xa4>
    buf[i++] = '-';
 4b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4b7:	8d 50 01             	lea    0x1(%eax),%edx
 4ba:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4bd:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4c2:	eb 1d                	jmp    4e1 <printint+0xa4>
    putc(fd, buf[i]);
 4c4:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4ca:	01 d0                	add    %edx,%eax
 4cc:	0f b6 00             	movzbl (%eax),%eax
 4cf:	0f be c0             	movsbl %al,%eax
 4d2:	83 ec 08             	sub    $0x8,%esp
 4d5:	50                   	push   %eax
 4d6:	ff 75 08             	pushl  0x8(%ebp)
 4d9:	e8 3c ff ff ff       	call   41a <putc>
 4de:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4e1:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4e5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4e9:	79 d9                	jns    4c4 <printint+0x87>
    putc(fd, buf[i]);
}
 4eb:	90                   	nop
 4ec:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4ef:	c9                   	leave  
 4f0:	c3                   	ret    

000004f1 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4f1:	55                   	push   %ebp
 4f2:	89 e5                	mov    %esp,%ebp
 4f4:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4f7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4fe:	8d 45 0c             	lea    0xc(%ebp),%eax
 501:	83 c0 04             	add    $0x4,%eax
 504:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 507:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 50e:	e9 59 01 00 00       	jmp    66c <printf+0x17b>
    c = fmt[i] & 0xff;
 513:	8b 55 0c             	mov    0xc(%ebp),%edx
 516:	8b 45 f0             	mov    -0x10(%ebp),%eax
 519:	01 d0                	add    %edx,%eax
 51b:	0f b6 00             	movzbl (%eax),%eax
 51e:	0f be c0             	movsbl %al,%eax
 521:	25 ff 00 00 00       	and    $0xff,%eax
 526:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 529:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 52d:	75 2c                	jne    55b <printf+0x6a>
      if(c == '%'){
 52f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 533:	75 0c                	jne    541 <printf+0x50>
        state = '%';
 535:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 53c:	e9 27 01 00 00       	jmp    668 <printf+0x177>
      } else {
        putc(fd, c);
 541:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 544:	0f be c0             	movsbl %al,%eax
 547:	83 ec 08             	sub    $0x8,%esp
 54a:	50                   	push   %eax
 54b:	ff 75 08             	pushl  0x8(%ebp)
 54e:	e8 c7 fe ff ff       	call   41a <putc>
 553:	83 c4 10             	add    $0x10,%esp
 556:	e9 0d 01 00 00       	jmp    668 <printf+0x177>
      }
    } else if(state == '%'){
 55b:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 55f:	0f 85 03 01 00 00    	jne    668 <printf+0x177>
      if(c == 'd'){
 565:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 569:	75 1e                	jne    589 <printf+0x98>
        printint(fd, *ap, 10, 1);
 56b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 56e:	8b 00                	mov    (%eax),%eax
 570:	6a 01                	push   $0x1
 572:	6a 0a                	push   $0xa
 574:	50                   	push   %eax
 575:	ff 75 08             	pushl  0x8(%ebp)
 578:	e8 c0 fe ff ff       	call   43d <printint>
 57d:	83 c4 10             	add    $0x10,%esp
        ap++;
 580:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 584:	e9 d8 00 00 00       	jmp    661 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 589:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 58d:	74 06                	je     595 <printf+0xa4>
 58f:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 593:	75 1e                	jne    5b3 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 595:	8b 45 e8             	mov    -0x18(%ebp),%eax
 598:	8b 00                	mov    (%eax),%eax
 59a:	6a 00                	push   $0x0
 59c:	6a 10                	push   $0x10
 59e:	50                   	push   %eax
 59f:	ff 75 08             	pushl  0x8(%ebp)
 5a2:	e8 96 fe ff ff       	call   43d <printint>
 5a7:	83 c4 10             	add    $0x10,%esp
        ap++;
 5aa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5ae:	e9 ae 00 00 00       	jmp    661 <printf+0x170>
      } else if(c == 's'){
 5b3:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5b7:	75 43                	jne    5fc <printf+0x10b>
        s = (char*)*ap;
 5b9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5bc:	8b 00                	mov    (%eax),%eax
 5be:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5c1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5c5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5c9:	75 25                	jne    5f0 <printf+0xff>
          s = "(null)";
 5cb:	c7 45 f4 12 09 00 00 	movl   $0x912,-0xc(%ebp)
        while(*s != 0){
 5d2:	eb 1c                	jmp    5f0 <printf+0xff>
          putc(fd, *s);
 5d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5d7:	0f b6 00             	movzbl (%eax),%eax
 5da:	0f be c0             	movsbl %al,%eax
 5dd:	83 ec 08             	sub    $0x8,%esp
 5e0:	50                   	push   %eax
 5e1:	ff 75 08             	pushl  0x8(%ebp)
 5e4:	e8 31 fe ff ff       	call   41a <putc>
 5e9:	83 c4 10             	add    $0x10,%esp
          s++;
 5ec:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5f3:	0f b6 00             	movzbl (%eax),%eax
 5f6:	84 c0                	test   %al,%al
 5f8:	75 da                	jne    5d4 <printf+0xe3>
 5fa:	eb 65                	jmp    661 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5fc:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 600:	75 1d                	jne    61f <printf+0x12e>
        putc(fd, *ap);
 602:	8b 45 e8             	mov    -0x18(%ebp),%eax
 605:	8b 00                	mov    (%eax),%eax
 607:	0f be c0             	movsbl %al,%eax
 60a:	83 ec 08             	sub    $0x8,%esp
 60d:	50                   	push   %eax
 60e:	ff 75 08             	pushl  0x8(%ebp)
 611:	e8 04 fe ff ff       	call   41a <putc>
 616:	83 c4 10             	add    $0x10,%esp
        ap++;
 619:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 61d:	eb 42                	jmp    661 <printf+0x170>
      } else if(c == '%'){
 61f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 623:	75 17                	jne    63c <printf+0x14b>
        putc(fd, c);
 625:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 628:	0f be c0             	movsbl %al,%eax
 62b:	83 ec 08             	sub    $0x8,%esp
 62e:	50                   	push   %eax
 62f:	ff 75 08             	pushl  0x8(%ebp)
 632:	e8 e3 fd ff ff       	call   41a <putc>
 637:	83 c4 10             	add    $0x10,%esp
 63a:	eb 25                	jmp    661 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 63c:	83 ec 08             	sub    $0x8,%esp
 63f:	6a 25                	push   $0x25
 641:	ff 75 08             	pushl  0x8(%ebp)
 644:	e8 d1 fd ff ff       	call   41a <putc>
 649:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 64c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 64f:	0f be c0             	movsbl %al,%eax
 652:	83 ec 08             	sub    $0x8,%esp
 655:	50                   	push   %eax
 656:	ff 75 08             	pushl  0x8(%ebp)
 659:	e8 bc fd ff ff       	call   41a <putc>
 65e:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 661:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 668:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 66c:	8b 55 0c             	mov    0xc(%ebp),%edx
 66f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 672:	01 d0                	add    %edx,%eax
 674:	0f b6 00             	movzbl (%eax),%eax
 677:	84 c0                	test   %al,%al
 679:	0f 85 94 fe ff ff    	jne    513 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 67f:	90                   	nop
 680:	c9                   	leave  
 681:	c3                   	ret    

00000682 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 682:	55                   	push   %ebp
 683:	89 e5                	mov    %esp,%ebp
 685:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 688:	8b 45 08             	mov    0x8(%ebp),%eax
 68b:	83 e8 08             	sub    $0x8,%eax
 68e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 691:	a1 88 0b 00 00       	mov    0xb88,%eax
 696:	89 45 fc             	mov    %eax,-0x4(%ebp)
 699:	eb 24                	jmp    6bf <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 69b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69e:	8b 00                	mov    (%eax),%eax
 6a0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6a3:	77 12                	ja     6b7 <free+0x35>
 6a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6ab:	77 24                	ja     6d1 <free+0x4f>
 6ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b0:	8b 00                	mov    (%eax),%eax
 6b2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6b5:	77 1a                	ja     6d1 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ba:	8b 00                	mov    (%eax),%eax
 6bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6c5:	76 d4                	jbe    69b <free+0x19>
 6c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ca:	8b 00                	mov    (%eax),%eax
 6cc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6cf:	76 ca                	jbe    69b <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d4:	8b 40 04             	mov    0x4(%eax),%eax
 6d7:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6de:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e1:	01 c2                	add    %eax,%edx
 6e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e6:	8b 00                	mov    (%eax),%eax
 6e8:	39 c2                	cmp    %eax,%edx
 6ea:	75 24                	jne    710 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ef:	8b 50 04             	mov    0x4(%eax),%edx
 6f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f5:	8b 00                	mov    (%eax),%eax
 6f7:	8b 40 04             	mov    0x4(%eax),%eax
 6fa:	01 c2                	add    %eax,%edx
 6fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ff:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 702:	8b 45 fc             	mov    -0x4(%ebp),%eax
 705:	8b 00                	mov    (%eax),%eax
 707:	8b 10                	mov    (%eax),%edx
 709:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70c:	89 10                	mov    %edx,(%eax)
 70e:	eb 0a                	jmp    71a <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 710:	8b 45 fc             	mov    -0x4(%ebp),%eax
 713:	8b 10                	mov    (%eax),%edx
 715:	8b 45 f8             	mov    -0x8(%ebp),%eax
 718:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 71a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71d:	8b 40 04             	mov    0x4(%eax),%eax
 720:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 727:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72a:	01 d0                	add    %edx,%eax
 72c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 72f:	75 20                	jne    751 <free+0xcf>
    p->s.size += bp->s.size;
 731:	8b 45 fc             	mov    -0x4(%ebp),%eax
 734:	8b 50 04             	mov    0x4(%eax),%edx
 737:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73a:	8b 40 04             	mov    0x4(%eax),%eax
 73d:	01 c2                	add    %eax,%edx
 73f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 742:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 745:	8b 45 f8             	mov    -0x8(%ebp),%eax
 748:	8b 10                	mov    (%eax),%edx
 74a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74d:	89 10                	mov    %edx,(%eax)
 74f:	eb 08                	jmp    759 <free+0xd7>
  } else
    p->s.ptr = bp;
 751:	8b 45 fc             	mov    -0x4(%ebp),%eax
 754:	8b 55 f8             	mov    -0x8(%ebp),%edx
 757:	89 10                	mov    %edx,(%eax)
  freep = p;
 759:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75c:	a3 88 0b 00 00       	mov    %eax,0xb88
}
 761:	90                   	nop
 762:	c9                   	leave  
 763:	c3                   	ret    

00000764 <morecore>:

static Header*
morecore(uint nu)
{
 764:	55                   	push   %ebp
 765:	89 e5                	mov    %esp,%ebp
 767:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 76a:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 771:	77 07                	ja     77a <morecore+0x16>
    nu = 4096;
 773:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 77a:	8b 45 08             	mov    0x8(%ebp),%eax
 77d:	c1 e0 03             	shl    $0x3,%eax
 780:	83 ec 0c             	sub    $0xc,%esp
 783:	50                   	push   %eax
 784:	e8 69 fc ff ff       	call   3f2 <sbrk>
 789:	83 c4 10             	add    $0x10,%esp
 78c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 78f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 793:	75 07                	jne    79c <morecore+0x38>
    return 0;
 795:	b8 00 00 00 00       	mov    $0x0,%eax
 79a:	eb 26                	jmp    7c2 <morecore+0x5e>
  hp = (Header*)p;
 79c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a5:	8b 55 08             	mov    0x8(%ebp),%edx
 7a8:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ae:	83 c0 08             	add    $0x8,%eax
 7b1:	83 ec 0c             	sub    $0xc,%esp
 7b4:	50                   	push   %eax
 7b5:	e8 c8 fe ff ff       	call   682 <free>
 7ba:	83 c4 10             	add    $0x10,%esp
  return freep;
 7bd:	a1 88 0b 00 00       	mov    0xb88,%eax
}
 7c2:	c9                   	leave  
 7c3:	c3                   	ret    

000007c4 <malloc>:

void*
malloc(uint nbytes)
{
 7c4:	55                   	push   %ebp
 7c5:	89 e5                	mov    %esp,%ebp
 7c7:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7ca:	8b 45 08             	mov    0x8(%ebp),%eax
 7cd:	83 c0 07             	add    $0x7,%eax
 7d0:	c1 e8 03             	shr    $0x3,%eax
 7d3:	83 c0 01             	add    $0x1,%eax
 7d6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7d9:	a1 88 0b 00 00       	mov    0xb88,%eax
 7de:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7e1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7e5:	75 23                	jne    80a <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7e7:	c7 45 f0 80 0b 00 00 	movl   $0xb80,-0x10(%ebp)
 7ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f1:	a3 88 0b 00 00       	mov    %eax,0xb88
 7f6:	a1 88 0b 00 00       	mov    0xb88,%eax
 7fb:	a3 80 0b 00 00       	mov    %eax,0xb80
    base.s.size = 0;
 800:	c7 05 84 0b 00 00 00 	movl   $0x0,0xb84
 807:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 80a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80d:	8b 00                	mov    (%eax),%eax
 80f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 812:	8b 45 f4             	mov    -0xc(%ebp),%eax
 815:	8b 40 04             	mov    0x4(%eax),%eax
 818:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 81b:	72 4d                	jb     86a <malloc+0xa6>
      if(p->s.size == nunits)
 81d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 820:	8b 40 04             	mov    0x4(%eax),%eax
 823:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 826:	75 0c                	jne    834 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 828:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82b:	8b 10                	mov    (%eax),%edx
 82d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 830:	89 10                	mov    %edx,(%eax)
 832:	eb 26                	jmp    85a <malloc+0x96>
      else {
        p->s.size -= nunits;
 834:	8b 45 f4             	mov    -0xc(%ebp),%eax
 837:	8b 40 04             	mov    0x4(%eax),%eax
 83a:	2b 45 ec             	sub    -0x14(%ebp),%eax
 83d:	89 c2                	mov    %eax,%edx
 83f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 842:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 845:	8b 45 f4             	mov    -0xc(%ebp),%eax
 848:	8b 40 04             	mov    0x4(%eax),%eax
 84b:	c1 e0 03             	shl    $0x3,%eax
 84e:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 851:	8b 45 f4             	mov    -0xc(%ebp),%eax
 854:	8b 55 ec             	mov    -0x14(%ebp),%edx
 857:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 85a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 85d:	a3 88 0b 00 00       	mov    %eax,0xb88
      return (void*)(p + 1);
 862:	8b 45 f4             	mov    -0xc(%ebp),%eax
 865:	83 c0 08             	add    $0x8,%eax
 868:	eb 3b                	jmp    8a5 <malloc+0xe1>
    }
    if(p == freep)
 86a:	a1 88 0b 00 00       	mov    0xb88,%eax
 86f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 872:	75 1e                	jne    892 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 874:	83 ec 0c             	sub    $0xc,%esp
 877:	ff 75 ec             	pushl  -0x14(%ebp)
 87a:	e8 e5 fe ff ff       	call   764 <morecore>
 87f:	83 c4 10             	add    $0x10,%esp
 882:	89 45 f4             	mov    %eax,-0xc(%ebp)
 885:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 889:	75 07                	jne    892 <malloc+0xce>
        return 0;
 88b:	b8 00 00 00 00       	mov    $0x0,%eax
 890:	eb 13                	jmp    8a5 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 892:	8b 45 f4             	mov    -0xc(%ebp),%eax
 895:	89 45 f0             	mov    %eax,-0x10(%ebp)
 898:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89b:	8b 00                	mov    (%eax),%eax
 89d:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8a0:	e9 6d ff ff ff       	jmp    812 <malloc+0x4e>
}
 8a5:	c9                   	leave  
 8a6:	c3                   	ret    
