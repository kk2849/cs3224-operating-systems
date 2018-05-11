
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:
#define BUFSZ 512
char *buf;

void
cat(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  int n;

  while((n = read(fd, buf, BUFSZ)) > 0)
   6:	eb 16                	jmp    1e <cat+0x1e>
    write(1, buf, n);
   8:	a1 64 0b 00 00       	mov    0xb64,%eax
   d:	83 ec 04             	sub    $0x4,%esp
  10:	ff 75 f4             	pushl  -0xc(%ebp)
  13:	50                   	push   %eax
  14:	6a 01                	push   $0x1
  16:	e8 82 03 00 00       	call   39d <write>
  1b:	83 c4 10             	add    $0x10,%esp
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, BUFSZ)) > 0)
  1e:	a1 64 0b 00 00       	mov    0xb64,%eax
  23:	83 ec 04             	sub    $0x4,%esp
  26:	68 00 02 00 00       	push   $0x200
  2b:	50                   	push   %eax
  2c:	ff 75 08             	pushl  0x8(%ebp)
  2f:	e8 61 03 00 00       	call   395 <read>
  34:	83 c4 10             	add    $0x10,%esp
  37:	89 45 f4             	mov    %eax,-0xc(%ebp)
  3a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  3e:	7f c8                	jg     8 <cat+0x8>
    write(1, buf, n);
  if(n < 0){
  40:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  44:	79 17                	jns    5d <cat+0x5d>
    printf(1, "cat: read error\n");
  46:	83 ec 08             	sub    $0x8,%esp
  49:	68 aa 08 00 00       	push   $0x8aa
  4e:	6a 01                	push   $0x1
  50:	e8 9f 04 00 00       	call   4f4 <printf>
  55:	83 c4 10             	add    $0x10,%esp
    exit();
  58:	e8 20 03 00 00       	call   37d <exit>
  }
}
  5d:	90                   	nop
  5e:	c9                   	leave  
  5f:	c3                   	ret    

00000060 <main>:

int
main(int argc, char *argv[])
{
  60:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  64:	83 e4 f0             	and    $0xfffffff0,%esp
  67:	ff 71 fc             	pushl  -0x4(%ecx)
  6a:	55                   	push   %ebp
  6b:	89 e5                	mov    %esp,%ebp
  6d:	53                   	push   %ebx
  6e:	51                   	push   %ecx
  6f:	83 ec 10             	sub    $0x10,%esp
  72:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  buf = sbrk(BUFSZ);
  74:	83 ec 0c             	sub    $0xc,%esp
  77:	68 00 02 00 00       	push   $0x200
  7c:	e8 84 03 00 00       	call   405 <sbrk>
  81:	83 c4 10             	add    $0x10,%esp
  84:	a3 64 0b 00 00       	mov    %eax,0xb64

  if(argc <= 1){
  89:	83 3b 01             	cmpl   $0x1,(%ebx)
  8c:	7f 12                	jg     a0 <main+0x40>
    cat(0);
  8e:	83 ec 0c             	sub    $0xc,%esp
  91:	6a 00                	push   $0x0
  93:	e8 68 ff ff ff       	call   0 <cat>
  98:	83 c4 10             	add    $0x10,%esp
    exit();
  9b:	e8 dd 02 00 00       	call   37d <exit>
  }
  
  for(i = 1; i < argc; i++){
  a0:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  a7:	eb 71                	jmp    11a <main+0xba>
    if((fd = open(argv[i], 0)) < 0){
  a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  ac:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  b3:	8b 43 04             	mov    0x4(%ebx),%eax
  b6:	01 d0                	add    %edx,%eax
  b8:	8b 00                	mov    (%eax),%eax
  ba:	83 ec 08             	sub    $0x8,%esp
  bd:	6a 00                	push   $0x0
  bf:	50                   	push   %eax
  c0:	e8 f8 02 00 00       	call   3bd <open>
  c5:	83 c4 10             	add    $0x10,%esp
  c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  cf:	79 29                	jns    fa <main+0x9a>
      printf(1, "cat: cannot open %s\n", argv[i]);
  d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  d4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  db:	8b 43 04             	mov    0x4(%ebx),%eax
  de:	01 d0                	add    %edx,%eax
  e0:	8b 00                	mov    (%eax),%eax
  e2:	83 ec 04             	sub    $0x4,%esp
  e5:	50                   	push   %eax
  e6:	68 bb 08 00 00       	push   $0x8bb
  eb:	6a 01                	push   $0x1
  ed:	e8 02 04 00 00       	call   4f4 <printf>
  f2:	83 c4 10             	add    $0x10,%esp
      exit();
  f5:	e8 83 02 00 00       	call   37d <exit>
    }
    cat(fd);
  fa:	83 ec 0c             	sub    $0xc,%esp
  fd:	ff 75 f0             	pushl  -0x10(%ebp)
 100:	e8 fb fe ff ff       	call   0 <cat>
 105:	83 c4 10             	add    $0x10,%esp
    close(fd);
 108:	83 ec 0c             	sub    $0xc,%esp
 10b:	ff 75 f0             	pushl  -0x10(%ebp)
 10e:	e8 92 02 00 00       	call   3a5 <close>
 113:	83 c4 10             	add    $0x10,%esp
  if(argc <= 1){
    cat(0);
    exit();
  }
  
  for(i = 1; i < argc; i++){
 116:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 11a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 11d:	3b 03                	cmp    (%ebx),%eax
 11f:	7c 88                	jl     a9 <main+0x49>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
 121:	e8 57 02 00 00       	call   37d <exit>

00000126 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 126:	55                   	push   %ebp
 127:	89 e5                	mov    %esp,%ebp
 129:	57                   	push   %edi
 12a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 12b:	8b 4d 08             	mov    0x8(%ebp),%ecx
 12e:	8b 55 10             	mov    0x10(%ebp),%edx
 131:	8b 45 0c             	mov    0xc(%ebp),%eax
 134:	89 cb                	mov    %ecx,%ebx
 136:	89 df                	mov    %ebx,%edi
 138:	89 d1                	mov    %edx,%ecx
 13a:	fc                   	cld    
 13b:	f3 aa                	rep stos %al,%es:(%edi)
 13d:	89 ca                	mov    %ecx,%edx
 13f:	89 fb                	mov    %edi,%ebx
 141:	89 5d 08             	mov    %ebx,0x8(%ebp)
 144:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 147:	90                   	nop
 148:	5b                   	pop    %ebx
 149:	5f                   	pop    %edi
 14a:	5d                   	pop    %ebp
 14b:	c3                   	ret    

0000014c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 14c:	55                   	push   %ebp
 14d:	89 e5                	mov    %esp,%ebp
 14f:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 152:	8b 45 08             	mov    0x8(%ebp),%eax
 155:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 158:	90                   	nop
 159:	8b 45 08             	mov    0x8(%ebp),%eax
 15c:	8d 50 01             	lea    0x1(%eax),%edx
 15f:	89 55 08             	mov    %edx,0x8(%ebp)
 162:	8b 55 0c             	mov    0xc(%ebp),%edx
 165:	8d 4a 01             	lea    0x1(%edx),%ecx
 168:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 16b:	0f b6 12             	movzbl (%edx),%edx
 16e:	88 10                	mov    %dl,(%eax)
 170:	0f b6 00             	movzbl (%eax),%eax
 173:	84 c0                	test   %al,%al
 175:	75 e2                	jne    159 <strcpy+0xd>
    ;
  return os;
 177:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 17a:	c9                   	leave  
 17b:	c3                   	ret    

0000017c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 17c:	55                   	push   %ebp
 17d:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 17f:	eb 08                	jmp    189 <strcmp+0xd>
    p++, q++;
 181:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 185:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 189:	8b 45 08             	mov    0x8(%ebp),%eax
 18c:	0f b6 00             	movzbl (%eax),%eax
 18f:	84 c0                	test   %al,%al
 191:	74 10                	je     1a3 <strcmp+0x27>
 193:	8b 45 08             	mov    0x8(%ebp),%eax
 196:	0f b6 10             	movzbl (%eax),%edx
 199:	8b 45 0c             	mov    0xc(%ebp),%eax
 19c:	0f b6 00             	movzbl (%eax),%eax
 19f:	38 c2                	cmp    %al,%dl
 1a1:	74 de                	je     181 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1a3:	8b 45 08             	mov    0x8(%ebp),%eax
 1a6:	0f b6 00             	movzbl (%eax),%eax
 1a9:	0f b6 d0             	movzbl %al,%edx
 1ac:	8b 45 0c             	mov    0xc(%ebp),%eax
 1af:	0f b6 00             	movzbl (%eax),%eax
 1b2:	0f b6 c0             	movzbl %al,%eax
 1b5:	29 c2                	sub    %eax,%edx
 1b7:	89 d0                	mov    %edx,%eax
}
 1b9:	5d                   	pop    %ebp
 1ba:	c3                   	ret    

000001bb <strlen>:

uint
strlen(char *s)
{
 1bb:	55                   	push   %ebp
 1bc:	89 e5                	mov    %esp,%ebp
 1be:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1c8:	eb 04                	jmp    1ce <strlen+0x13>
 1ca:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1ce:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1d1:	8b 45 08             	mov    0x8(%ebp),%eax
 1d4:	01 d0                	add    %edx,%eax
 1d6:	0f b6 00             	movzbl (%eax),%eax
 1d9:	84 c0                	test   %al,%al
 1db:	75 ed                	jne    1ca <strlen+0xf>
    ;
  return n;
 1dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1e0:	c9                   	leave  
 1e1:	c3                   	ret    

000001e2 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1e2:	55                   	push   %ebp
 1e3:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1e5:	8b 45 10             	mov    0x10(%ebp),%eax
 1e8:	50                   	push   %eax
 1e9:	ff 75 0c             	pushl  0xc(%ebp)
 1ec:	ff 75 08             	pushl  0x8(%ebp)
 1ef:	e8 32 ff ff ff       	call   126 <stosb>
 1f4:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1f7:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1fa:	c9                   	leave  
 1fb:	c3                   	ret    

000001fc <strchr>:

char*
strchr(const char *s, char c)
{
 1fc:	55                   	push   %ebp
 1fd:	89 e5                	mov    %esp,%ebp
 1ff:	83 ec 04             	sub    $0x4,%esp
 202:	8b 45 0c             	mov    0xc(%ebp),%eax
 205:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 208:	eb 14                	jmp    21e <strchr+0x22>
    if(*s == c)
 20a:	8b 45 08             	mov    0x8(%ebp),%eax
 20d:	0f b6 00             	movzbl (%eax),%eax
 210:	3a 45 fc             	cmp    -0x4(%ebp),%al
 213:	75 05                	jne    21a <strchr+0x1e>
      return (char*)s;
 215:	8b 45 08             	mov    0x8(%ebp),%eax
 218:	eb 13                	jmp    22d <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 21a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 21e:	8b 45 08             	mov    0x8(%ebp),%eax
 221:	0f b6 00             	movzbl (%eax),%eax
 224:	84 c0                	test   %al,%al
 226:	75 e2                	jne    20a <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 228:	b8 00 00 00 00       	mov    $0x0,%eax
}
 22d:	c9                   	leave  
 22e:	c3                   	ret    

0000022f <gets>:

char*
gets(char *buf, int max)
{
 22f:	55                   	push   %ebp
 230:	89 e5                	mov    %esp,%ebp
 232:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 235:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 23c:	eb 42                	jmp    280 <gets+0x51>
    cc = read(0, &c, 1);
 23e:	83 ec 04             	sub    $0x4,%esp
 241:	6a 01                	push   $0x1
 243:	8d 45 ef             	lea    -0x11(%ebp),%eax
 246:	50                   	push   %eax
 247:	6a 00                	push   $0x0
 249:	e8 47 01 00 00       	call   395 <read>
 24e:	83 c4 10             	add    $0x10,%esp
 251:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 254:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 258:	7e 33                	jle    28d <gets+0x5e>
      break;
    buf[i++] = c;
 25a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 25d:	8d 50 01             	lea    0x1(%eax),%edx
 260:	89 55 f4             	mov    %edx,-0xc(%ebp)
 263:	89 c2                	mov    %eax,%edx
 265:	8b 45 08             	mov    0x8(%ebp),%eax
 268:	01 c2                	add    %eax,%edx
 26a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 26e:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 270:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 274:	3c 0a                	cmp    $0xa,%al
 276:	74 16                	je     28e <gets+0x5f>
 278:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 27c:	3c 0d                	cmp    $0xd,%al
 27e:	74 0e                	je     28e <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 280:	8b 45 f4             	mov    -0xc(%ebp),%eax
 283:	83 c0 01             	add    $0x1,%eax
 286:	3b 45 0c             	cmp    0xc(%ebp),%eax
 289:	7c b3                	jl     23e <gets+0xf>
 28b:	eb 01                	jmp    28e <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 28d:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 28e:	8b 55 f4             	mov    -0xc(%ebp),%edx
 291:	8b 45 08             	mov    0x8(%ebp),%eax
 294:	01 d0                	add    %edx,%eax
 296:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 299:	8b 45 08             	mov    0x8(%ebp),%eax
}
 29c:	c9                   	leave  
 29d:	c3                   	ret    

0000029e <stat>:

int
stat(char *n, struct stat *st)
{
 29e:	55                   	push   %ebp
 29f:	89 e5                	mov    %esp,%ebp
 2a1:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a4:	83 ec 08             	sub    $0x8,%esp
 2a7:	6a 00                	push   $0x0
 2a9:	ff 75 08             	pushl  0x8(%ebp)
 2ac:	e8 0c 01 00 00       	call   3bd <open>
 2b1:	83 c4 10             	add    $0x10,%esp
 2b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2bb:	79 07                	jns    2c4 <stat+0x26>
    return -1;
 2bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2c2:	eb 25                	jmp    2e9 <stat+0x4b>
  r = fstat(fd, st);
 2c4:	83 ec 08             	sub    $0x8,%esp
 2c7:	ff 75 0c             	pushl  0xc(%ebp)
 2ca:	ff 75 f4             	pushl  -0xc(%ebp)
 2cd:	e8 03 01 00 00       	call   3d5 <fstat>
 2d2:	83 c4 10             	add    $0x10,%esp
 2d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2d8:	83 ec 0c             	sub    $0xc,%esp
 2db:	ff 75 f4             	pushl  -0xc(%ebp)
 2de:	e8 c2 00 00 00       	call   3a5 <close>
 2e3:	83 c4 10             	add    $0x10,%esp
  return r;
 2e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2e9:	c9                   	leave  
 2ea:	c3                   	ret    

000002eb <atoi>:

int
atoi(const char *s)
{
 2eb:	55                   	push   %ebp
 2ec:	89 e5                	mov    %esp,%ebp
 2ee:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2f1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2f8:	eb 25                	jmp    31f <atoi+0x34>
    n = n*10 + *s++ - '0';
 2fa:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2fd:	89 d0                	mov    %edx,%eax
 2ff:	c1 e0 02             	shl    $0x2,%eax
 302:	01 d0                	add    %edx,%eax
 304:	01 c0                	add    %eax,%eax
 306:	89 c1                	mov    %eax,%ecx
 308:	8b 45 08             	mov    0x8(%ebp),%eax
 30b:	8d 50 01             	lea    0x1(%eax),%edx
 30e:	89 55 08             	mov    %edx,0x8(%ebp)
 311:	0f b6 00             	movzbl (%eax),%eax
 314:	0f be c0             	movsbl %al,%eax
 317:	01 c8                	add    %ecx,%eax
 319:	83 e8 30             	sub    $0x30,%eax
 31c:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 31f:	8b 45 08             	mov    0x8(%ebp),%eax
 322:	0f b6 00             	movzbl (%eax),%eax
 325:	3c 2f                	cmp    $0x2f,%al
 327:	7e 0a                	jle    333 <atoi+0x48>
 329:	8b 45 08             	mov    0x8(%ebp),%eax
 32c:	0f b6 00             	movzbl (%eax),%eax
 32f:	3c 39                	cmp    $0x39,%al
 331:	7e c7                	jle    2fa <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 333:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 336:	c9                   	leave  
 337:	c3                   	ret    

00000338 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 338:	55                   	push   %ebp
 339:	89 e5                	mov    %esp,%ebp
 33b:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 33e:	8b 45 08             	mov    0x8(%ebp),%eax
 341:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 344:	8b 45 0c             	mov    0xc(%ebp),%eax
 347:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 34a:	eb 17                	jmp    363 <memmove+0x2b>
    *dst++ = *src++;
 34c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 34f:	8d 50 01             	lea    0x1(%eax),%edx
 352:	89 55 fc             	mov    %edx,-0x4(%ebp)
 355:	8b 55 f8             	mov    -0x8(%ebp),%edx
 358:	8d 4a 01             	lea    0x1(%edx),%ecx
 35b:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 35e:	0f b6 12             	movzbl (%edx),%edx
 361:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 363:	8b 45 10             	mov    0x10(%ebp),%eax
 366:	8d 50 ff             	lea    -0x1(%eax),%edx
 369:	89 55 10             	mov    %edx,0x10(%ebp)
 36c:	85 c0                	test   %eax,%eax
 36e:	7f dc                	jg     34c <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 370:	8b 45 08             	mov    0x8(%ebp),%eax
}
 373:	c9                   	leave  
 374:	c3                   	ret    

00000375 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 375:	b8 01 00 00 00       	mov    $0x1,%eax
 37a:	cd 40                	int    $0x40
 37c:	c3                   	ret    

0000037d <exit>:
SYSCALL(exit)
 37d:	b8 02 00 00 00       	mov    $0x2,%eax
 382:	cd 40                	int    $0x40
 384:	c3                   	ret    

00000385 <wait>:
SYSCALL(wait)
 385:	b8 03 00 00 00       	mov    $0x3,%eax
 38a:	cd 40                	int    $0x40
 38c:	c3                   	ret    

0000038d <pipe>:
SYSCALL(pipe)
 38d:	b8 04 00 00 00       	mov    $0x4,%eax
 392:	cd 40                	int    $0x40
 394:	c3                   	ret    

00000395 <read>:
SYSCALL(read)
 395:	b8 05 00 00 00       	mov    $0x5,%eax
 39a:	cd 40                	int    $0x40
 39c:	c3                   	ret    

0000039d <write>:
SYSCALL(write)
 39d:	b8 10 00 00 00       	mov    $0x10,%eax
 3a2:	cd 40                	int    $0x40
 3a4:	c3                   	ret    

000003a5 <close>:
SYSCALL(close)
 3a5:	b8 15 00 00 00       	mov    $0x15,%eax
 3aa:	cd 40                	int    $0x40
 3ac:	c3                   	ret    

000003ad <kill>:
SYSCALL(kill)
 3ad:	b8 06 00 00 00       	mov    $0x6,%eax
 3b2:	cd 40                	int    $0x40
 3b4:	c3                   	ret    

000003b5 <exec>:
SYSCALL(exec)
 3b5:	b8 07 00 00 00       	mov    $0x7,%eax
 3ba:	cd 40                	int    $0x40
 3bc:	c3                   	ret    

000003bd <open>:
SYSCALL(open)
 3bd:	b8 0f 00 00 00       	mov    $0xf,%eax
 3c2:	cd 40                	int    $0x40
 3c4:	c3                   	ret    

000003c5 <mknod>:
SYSCALL(mknod)
 3c5:	b8 11 00 00 00       	mov    $0x11,%eax
 3ca:	cd 40                	int    $0x40
 3cc:	c3                   	ret    

000003cd <unlink>:
SYSCALL(unlink)
 3cd:	b8 12 00 00 00       	mov    $0x12,%eax
 3d2:	cd 40                	int    $0x40
 3d4:	c3                   	ret    

000003d5 <fstat>:
SYSCALL(fstat)
 3d5:	b8 08 00 00 00       	mov    $0x8,%eax
 3da:	cd 40                	int    $0x40
 3dc:	c3                   	ret    

000003dd <link>:
SYSCALL(link)
 3dd:	b8 13 00 00 00       	mov    $0x13,%eax
 3e2:	cd 40                	int    $0x40
 3e4:	c3                   	ret    

000003e5 <mkdir>:
SYSCALL(mkdir)
 3e5:	b8 14 00 00 00       	mov    $0x14,%eax
 3ea:	cd 40                	int    $0x40
 3ec:	c3                   	ret    

000003ed <chdir>:
SYSCALL(chdir)
 3ed:	b8 09 00 00 00       	mov    $0x9,%eax
 3f2:	cd 40                	int    $0x40
 3f4:	c3                   	ret    

000003f5 <dup>:
SYSCALL(dup)
 3f5:	b8 0a 00 00 00       	mov    $0xa,%eax
 3fa:	cd 40                	int    $0x40
 3fc:	c3                   	ret    

000003fd <getpid>:
SYSCALL(getpid)
 3fd:	b8 0b 00 00 00       	mov    $0xb,%eax
 402:	cd 40                	int    $0x40
 404:	c3                   	ret    

00000405 <sbrk>:
SYSCALL(sbrk)
 405:	b8 0c 00 00 00       	mov    $0xc,%eax
 40a:	cd 40                	int    $0x40
 40c:	c3                   	ret    

0000040d <sleep>:
SYSCALL(sleep)
 40d:	b8 0d 00 00 00       	mov    $0xd,%eax
 412:	cd 40                	int    $0x40
 414:	c3                   	ret    

00000415 <uptime>:
SYSCALL(uptime)
 415:	b8 0e 00 00 00       	mov    $0xe,%eax
 41a:	cd 40                	int    $0x40
 41c:	c3                   	ret    

0000041d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 41d:	55                   	push   %ebp
 41e:	89 e5                	mov    %esp,%ebp
 420:	83 ec 18             	sub    $0x18,%esp
 423:	8b 45 0c             	mov    0xc(%ebp),%eax
 426:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 429:	83 ec 04             	sub    $0x4,%esp
 42c:	6a 01                	push   $0x1
 42e:	8d 45 f4             	lea    -0xc(%ebp),%eax
 431:	50                   	push   %eax
 432:	ff 75 08             	pushl  0x8(%ebp)
 435:	e8 63 ff ff ff       	call   39d <write>
 43a:	83 c4 10             	add    $0x10,%esp
}
 43d:	90                   	nop
 43e:	c9                   	leave  
 43f:	c3                   	ret    

00000440 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	53                   	push   %ebx
 444:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 447:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 44e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 452:	74 17                	je     46b <printint+0x2b>
 454:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 458:	79 11                	jns    46b <printint+0x2b>
    neg = 1;
 45a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 461:	8b 45 0c             	mov    0xc(%ebp),%eax
 464:	f7 d8                	neg    %eax
 466:	89 45 ec             	mov    %eax,-0x14(%ebp)
 469:	eb 06                	jmp    471 <printint+0x31>
  } else {
    x = xx;
 46b:	8b 45 0c             	mov    0xc(%ebp),%eax
 46e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 471:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 478:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 47b:	8d 41 01             	lea    0x1(%ecx),%eax
 47e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 481:	8b 5d 10             	mov    0x10(%ebp),%ebx
 484:	8b 45 ec             	mov    -0x14(%ebp),%eax
 487:	ba 00 00 00 00       	mov    $0x0,%edx
 48c:	f7 f3                	div    %ebx
 48e:	89 d0                	mov    %edx,%eax
 490:	0f b6 80 44 0b 00 00 	movzbl 0xb44(%eax),%eax
 497:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 49b:	8b 5d 10             	mov    0x10(%ebp),%ebx
 49e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4a1:	ba 00 00 00 00       	mov    $0x0,%edx
 4a6:	f7 f3                	div    %ebx
 4a8:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4ab:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4af:	75 c7                	jne    478 <printint+0x38>
  if(neg)
 4b1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4b5:	74 2d                	je     4e4 <printint+0xa4>
    buf[i++] = '-';
 4b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4ba:	8d 50 01             	lea    0x1(%eax),%edx
 4bd:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4c0:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4c5:	eb 1d                	jmp    4e4 <printint+0xa4>
    putc(fd, buf[i]);
 4c7:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4cd:	01 d0                	add    %edx,%eax
 4cf:	0f b6 00             	movzbl (%eax),%eax
 4d2:	0f be c0             	movsbl %al,%eax
 4d5:	83 ec 08             	sub    $0x8,%esp
 4d8:	50                   	push   %eax
 4d9:	ff 75 08             	pushl  0x8(%ebp)
 4dc:	e8 3c ff ff ff       	call   41d <putc>
 4e1:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4e4:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4e8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4ec:	79 d9                	jns    4c7 <printint+0x87>
    putc(fd, buf[i]);
}
 4ee:	90                   	nop
 4ef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4f2:	c9                   	leave  
 4f3:	c3                   	ret    

000004f4 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4f4:	55                   	push   %ebp
 4f5:	89 e5                	mov    %esp,%ebp
 4f7:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4fa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 501:	8d 45 0c             	lea    0xc(%ebp),%eax
 504:	83 c0 04             	add    $0x4,%eax
 507:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 50a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 511:	e9 59 01 00 00       	jmp    66f <printf+0x17b>
    c = fmt[i] & 0xff;
 516:	8b 55 0c             	mov    0xc(%ebp),%edx
 519:	8b 45 f0             	mov    -0x10(%ebp),%eax
 51c:	01 d0                	add    %edx,%eax
 51e:	0f b6 00             	movzbl (%eax),%eax
 521:	0f be c0             	movsbl %al,%eax
 524:	25 ff 00 00 00       	and    $0xff,%eax
 529:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 52c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 530:	75 2c                	jne    55e <printf+0x6a>
      if(c == '%'){
 532:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 536:	75 0c                	jne    544 <printf+0x50>
        state = '%';
 538:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 53f:	e9 27 01 00 00       	jmp    66b <printf+0x177>
      } else {
        putc(fd, c);
 544:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 547:	0f be c0             	movsbl %al,%eax
 54a:	83 ec 08             	sub    $0x8,%esp
 54d:	50                   	push   %eax
 54e:	ff 75 08             	pushl  0x8(%ebp)
 551:	e8 c7 fe ff ff       	call   41d <putc>
 556:	83 c4 10             	add    $0x10,%esp
 559:	e9 0d 01 00 00       	jmp    66b <printf+0x177>
      }
    } else if(state == '%'){
 55e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 562:	0f 85 03 01 00 00    	jne    66b <printf+0x177>
      if(c == 'd'){
 568:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 56c:	75 1e                	jne    58c <printf+0x98>
        printint(fd, *ap, 10, 1);
 56e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 571:	8b 00                	mov    (%eax),%eax
 573:	6a 01                	push   $0x1
 575:	6a 0a                	push   $0xa
 577:	50                   	push   %eax
 578:	ff 75 08             	pushl  0x8(%ebp)
 57b:	e8 c0 fe ff ff       	call   440 <printint>
 580:	83 c4 10             	add    $0x10,%esp
        ap++;
 583:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 587:	e9 d8 00 00 00       	jmp    664 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 58c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 590:	74 06                	je     598 <printf+0xa4>
 592:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 596:	75 1e                	jne    5b6 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 598:	8b 45 e8             	mov    -0x18(%ebp),%eax
 59b:	8b 00                	mov    (%eax),%eax
 59d:	6a 00                	push   $0x0
 59f:	6a 10                	push   $0x10
 5a1:	50                   	push   %eax
 5a2:	ff 75 08             	pushl  0x8(%ebp)
 5a5:	e8 96 fe ff ff       	call   440 <printint>
 5aa:	83 c4 10             	add    $0x10,%esp
        ap++;
 5ad:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5b1:	e9 ae 00 00 00       	jmp    664 <printf+0x170>
      } else if(c == 's'){
 5b6:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5ba:	75 43                	jne    5ff <printf+0x10b>
        s = (char*)*ap;
 5bc:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5bf:	8b 00                	mov    (%eax),%eax
 5c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5c4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5c8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5cc:	75 25                	jne    5f3 <printf+0xff>
          s = "(null)";
 5ce:	c7 45 f4 d0 08 00 00 	movl   $0x8d0,-0xc(%ebp)
        while(*s != 0){
 5d5:	eb 1c                	jmp    5f3 <printf+0xff>
          putc(fd, *s);
 5d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5da:	0f b6 00             	movzbl (%eax),%eax
 5dd:	0f be c0             	movsbl %al,%eax
 5e0:	83 ec 08             	sub    $0x8,%esp
 5e3:	50                   	push   %eax
 5e4:	ff 75 08             	pushl  0x8(%ebp)
 5e7:	e8 31 fe ff ff       	call   41d <putc>
 5ec:	83 c4 10             	add    $0x10,%esp
          s++;
 5ef:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5f6:	0f b6 00             	movzbl (%eax),%eax
 5f9:	84 c0                	test   %al,%al
 5fb:	75 da                	jne    5d7 <printf+0xe3>
 5fd:	eb 65                	jmp    664 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ff:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 603:	75 1d                	jne    622 <printf+0x12e>
        putc(fd, *ap);
 605:	8b 45 e8             	mov    -0x18(%ebp),%eax
 608:	8b 00                	mov    (%eax),%eax
 60a:	0f be c0             	movsbl %al,%eax
 60d:	83 ec 08             	sub    $0x8,%esp
 610:	50                   	push   %eax
 611:	ff 75 08             	pushl  0x8(%ebp)
 614:	e8 04 fe ff ff       	call   41d <putc>
 619:	83 c4 10             	add    $0x10,%esp
        ap++;
 61c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 620:	eb 42                	jmp    664 <printf+0x170>
      } else if(c == '%'){
 622:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 626:	75 17                	jne    63f <printf+0x14b>
        putc(fd, c);
 628:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 62b:	0f be c0             	movsbl %al,%eax
 62e:	83 ec 08             	sub    $0x8,%esp
 631:	50                   	push   %eax
 632:	ff 75 08             	pushl  0x8(%ebp)
 635:	e8 e3 fd ff ff       	call   41d <putc>
 63a:	83 c4 10             	add    $0x10,%esp
 63d:	eb 25                	jmp    664 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 63f:	83 ec 08             	sub    $0x8,%esp
 642:	6a 25                	push   $0x25
 644:	ff 75 08             	pushl  0x8(%ebp)
 647:	e8 d1 fd ff ff       	call   41d <putc>
 64c:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 64f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 652:	0f be c0             	movsbl %al,%eax
 655:	83 ec 08             	sub    $0x8,%esp
 658:	50                   	push   %eax
 659:	ff 75 08             	pushl  0x8(%ebp)
 65c:	e8 bc fd ff ff       	call   41d <putc>
 661:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 664:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 66b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 66f:	8b 55 0c             	mov    0xc(%ebp),%edx
 672:	8b 45 f0             	mov    -0x10(%ebp),%eax
 675:	01 d0                	add    %edx,%eax
 677:	0f b6 00             	movzbl (%eax),%eax
 67a:	84 c0                	test   %al,%al
 67c:	0f 85 94 fe ff ff    	jne    516 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 682:	90                   	nop
 683:	c9                   	leave  
 684:	c3                   	ret    

00000685 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 685:	55                   	push   %ebp
 686:	89 e5                	mov    %esp,%ebp
 688:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 68b:	8b 45 08             	mov    0x8(%ebp),%eax
 68e:	83 e8 08             	sub    $0x8,%eax
 691:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 694:	a1 60 0b 00 00       	mov    0xb60,%eax
 699:	89 45 fc             	mov    %eax,-0x4(%ebp)
 69c:	eb 24                	jmp    6c2 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 69e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a1:	8b 00                	mov    (%eax),%eax
 6a3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6a6:	77 12                	ja     6ba <free+0x35>
 6a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ab:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6ae:	77 24                	ja     6d4 <free+0x4f>
 6b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b3:	8b 00                	mov    (%eax),%eax
 6b5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6b8:	77 1a                	ja     6d4 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bd:	8b 00                	mov    (%eax),%eax
 6bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6c8:	76 d4                	jbe    69e <free+0x19>
 6ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cd:	8b 00                	mov    (%eax),%eax
 6cf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6d2:	76 ca                	jbe    69e <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d7:	8b 40 04             	mov    0x4(%eax),%eax
 6da:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e4:	01 c2                	add    %eax,%edx
 6e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e9:	8b 00                	mov    (%eax),%eax
 6eb:	39 c2                	cmp    %eax,%edx
 6ed:	75 24                	jne    713 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f2:	8b 50 04             	mov    0x4(%eax),%edx
 6f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f8:	8b 00                	mov    (%eax),%eax
 6fa:	8b 40 04             	mov    0x4(%eax),%eax
 6fd:	01 c2                	add    %eax,%edx
 6ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
 702:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 705:	8b 45 fc             	mov    -0x4(%ebp),%eax
 708:	8b 00                	mov    (%eax),%eax
 70a:	8b 10                	mov    (%eax),%edx
 70c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70f:	89 10                	mov    %edx,(%eax)
 711:	eb 0a                	jmp    71d <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 713:	8b 45 fc             	mov    -0x4(%ebp),%eax
 716:	8b 10                	mov    (%eax),%edx
 718:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71b:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 71d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 720:	8b 40 04             	mov    0x4(%eax),%eax
 723:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 72a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72d:	01 d0                	add    %edx,%eax
 72f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 732:	75 20                	jne    754 <free+0xcf>
    p->s.size += bp->s.size;
 734:	8b 45 fc             	mov    -0x4(%ebp),%eax
 737:	8b 50 04             	mov    0x4(%eax),%edx
 73a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73d:	8b 40 04             	mov    0x4(%eax),%eax
 740:	01 c2                	add    %eax,%edx
 742:	8b 45 fc             	mov    -0x4(%ebp),%eax
 745:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 748:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74b:	8b 10                	mov    (%eax),%edx
 74d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 750:	89 10                	mov    %edx,(%eax)
 752:	eb 08                	jmp    75c <free+0xd7>
  } else
    p->s.ptr = bp;
 754:	8b 45 fc             	mov    -0x4(%ebp),%eax
 757:	8b 55 f8             	mov    -0x8(%ebp),%edx
 75a:	89 10                	mov    %edx,(%eax)
  freep = p;
 75c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75f:	a3 60 0b 00 00       	mov    %eax,0xb60
}
 764:	90                   	nop
 765:	c9                   	leave  
 766:	c3                   	ret    

00000767 <morecore>:

static Header*
morecore(uint nu)
{
 767:	55                   	push   %ebp
 768:	89 e5                	mov    %esp,%ebp
 76a:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 76d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 774:	77 07                	ja     77d <morecore+0x16>
    nu = 4096;
 776:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 77d:	8b 45 08             	mov    0x8(%ebp),%eax
 780:	c1 e0 03             	shl    $0x3,%eax
 783:	83 ec 0c             	sub    $0xc,%esp
 786:	50                   	push   %eax
 787:	e8 79 fc ff ff       	call   405 <sbrk>
 78c:	83 c4 10             	add    $0x10,%esp
 78f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 792:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 796:	75 07                	jne    79f <morecore+0x38>
    return 0;
 798:	b8 00 00 00 00       	mov    $0x0,%eax
 79d:	eb 26                	jmp    7c5 <morecore+0x5e>
  hp = (Header*)p;
 79f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a8:	8b 55 08             	mov    0x8(%ebp),%edx
 7ab:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b1:	83 c0 08             	add    $0x8,%eax
 7b4:	83 ec 0c             	sub    $0xc,%esp
 7b7:	50                   	push   %eax
 7b8:	e8 c8 fe ff ff       	call   685 <free>
 7bd:	83 c4 10             	add    $0x10,%esp
  return freep;
 7c0:	a1 60 0b 00 00       	mov    0xb60,%eax
}
 7c5:	c9                   	leave  
 7c6:	c3                   	ret    

000007c7 <malloc>:

void*
malloc(uint nbytes)
{
 7c7:	55                   	push   %ebp
 7c8:	89 e5                	mov    %esp,%ebp
 7ca:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7cd:	8b 45 08             	mov    0x8(%ebp),%eax
 7d0:	83 c0 07             	add    $0x7,%eax
 7d3:	c1 e8 03             	shr    $0x3,%eax
 7d6:	83 c0 01             	add    $0x1,%eax
 7d9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7dc:	a1 60 0b 00 00       	mov    0xb60,%eax
 7e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7e4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7e8:	75 23                	jne    80d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7ea:	c7 45 f0 58 0b 00 00 	movl   $0xb58,-0x10(%ebp)
 7f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f4:	a3 60 0b 00 00       	mov    %eax,0xb60
 7f9:	a1 60 0b 00 00       	mov    0xb60,%eax
 7fe:	a3 58 0b 00 00       	mov    %eax,0xb58
    base.s.size = 0;
 803:	c7 05 5c 0b 00 00 00 	movl   $0x0,0xb5c
 80a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 80d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 810:	8b 00                	mov    (%eax),%eax
 812:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 815:	8b 45 f4             	mov    -0xc(%ebp),%eax
 818:	8b 40 04             	mov    0x4(%eax),%eax
 81b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 81e:	72 4d                	jb     86d <malloc+0xa6>
      if(p->s.size == nunits)
 820:	8b 45 f4             	mov    -0xc(%ebp),%eax
 823:	8b 40 04             	mov    0x4(%eax),%eax
 826:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 829:	75 0c                	jne    837 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 82b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82e:	8b 10                	mov    (%eax),%edx
 830:	8b 45 f0             	mov    -0x10(%ebp),%eax
 833:	89 10                	mov    %edx,(%eax)
 835:	eb 26                	jmp    85d <malloc+0x96>
      else {
        p->s.size -= nunits;
 837:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83a:	8b 40 04             	mov    0x4(%eax),%eax
 83d:	2b 45 ec             	sub    -0x14(%ebp),%eax
 840:	89 c2                	mov    %eax,%edx
 842:	8b 45 f4             	mov    -0xc(%ebp),%eax
 845:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 848:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84b:	8b 40 04             	mov    0x4(%eax),%eax
 84e:	c1 e0 03             	shl    $0x3,%eax
 851:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 854:	8b 45 f4             	mov    -0xc(%ebp),%eax
 857:	8b 55 ec             	mov    -0x14(%ebp),%edx
 85a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 85d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 860:	a3 60 0b 00 00       	mov    %eax,0xb60
      return (void*)(p + 1);
 865:	8b 45 f4             	mov    -0xc(%ebp),%eax
 868:	83 c0 08             	add    $0x8,%eax
 86b:	eb 3b                	jmp    8a8 <malloc+0xe1>
    }
    if(p == freep)
 86d:	a1 60 0b 00 00       	mov    0xb60,%eax
 872:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 875:	75 1e                	jne    895 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 877:	83 ec 0c             	sub    $0xc,%esp
 87a:	ff 75 ec             	pushl  -0x14(%ebp)
 87d:	e8 e5 fe ff ff       	call   767 <morecore>
 882:	83 c4 10             	add    $0x10,%esp
 885:	89 45 f4             	mov    %eax,-0xc(%ebp)
 888:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 88c:	75 07                	jne    895 <malloc+0xce>
        return 0;
 88e:	b8 00 00 00 00       	mov    $0x0,%eax
 893:	eb 13                	jmp    8a8 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 895:	8b 45 f4             	mov    -0xc(%ebp),%eax
 898:	89 45 f0             	mov    %eax,-0x10(%ebp)
 89b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89e:	8b 00                	mov    (%eax),%eax
 8a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8a3:	e9 6d ff ff ff       	jmp    815 <malloc+0x4e>
}
 8a8:	c9                   	leave  
 8a9:	c3                   	ret    
