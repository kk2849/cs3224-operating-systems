
_date:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "date.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 28             	sub    $0x28,%esp
	struct rtcdate r;

	if (date(&r)) {
  14:	83 ec 0c             	sub    $0xc,%esp
  17:	8d 45 d0             	lea    -0x30(%ebp),%eax
  1a:	50                   	push   %eax
  1b:	e8 8d 03 00 00       	call   3ad <date>
  20:	83 c4 10             	add    $0x10,%esp
  23:	85 c0                	test   %eax,%eax
  25:	74 17                	je     3e <main+0x3e>
		printf(2, "date failed lolol\n");
  27:	83 ec 08             	sub    $0x8,%esp
  2a:	68 44 08 00 00       	push   $0x844
  2f:	6a 02                	push   $0x2
  31:	e8 56 04 00 00       	call   48c <printf>
  36:	83 c4 10             	add    $0x10,%esp
		exit();
  39:	e8 cf 02 00 00       	call   30d <exit>
	}

  // your code to print the time in any format you like...
	printf(2, "Date: %d-%d-%d Time:%d:%d:%d UTC\n", r.month, r.day, r.year,
  3e:	8b 7d d0             	mov    -0x30(%ebp),%edi
  41:	8b 75 d4             	mov    -0x2c(%ebp),%esi
  44:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  47:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  4a:	8b 55 dc             	mov    -0x24(%ebp),%edx
  4d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  50:	57                   	push   %edi
  51:	56                   	push   %esi
  52:	53                   	push   %ebx
  53:	51                   	push   %ecx
  54:	52                   	push   %edx
  55:	50                   	push   %eax
  56:	68 58 08 00 00       	push   $0x858
  5b:	6a 02                	push   $0x2
  5d:	e8 2a 04 00 00       	call   48c <printf>
  62:	83 c4 20             	add    $0x20,%esp
		r.hour, r.minute, r.second);

	// UTC is 4 hours ahead of EST
	// 0 to 4:59 UTC is previous day EST
	if (r.hour <= 4) { 
  65:	8b 45 d8             	mov    -0x28(%ebp),%eax
  68:	83 f8 04             	cmp    $0x4,%eax
  6b:	77 14                	ja     81 <main+0x81>
		r.hour = 8+r.hour;
  6d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  70:	83 c0 08             	add    $0x8,%eax
  73:	89 45 d8             	mov    %eax,-0x28(%ebp)
		r.day--;
  76:	8b 45 dc             	mov    -0x24(%ebp),%eax
  79:	83 e8 01             	sub    $0x1,%eax
  7c:	89 45 dc             	mov    %eax,-0x24(%ebp)
  7f:	eb 09                	jmp    8a <main+0x8a>
	}
	else {
		r.hour = r.hour-4;
  81:	8b 45 d8             	mov    -0x28(%ebp),%eax
  84:	83 e8 04             	sub    $0x4,%eax
  87:	89 45 d8             	mov    %eax,-0x28(%ebp)
	}
	printf(2, "Date: %d-%d-%d Time:%d:%d:%d EST\n", r.month, r.day, r.year,
  8a:	8b 7d d0             	mov    -0x30(%ebp),%edi
  8d:	8b 75 d4             	mov    -0x2c(%ebp),%esi
  90:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  93:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  96:	8b 55 dc             	mov    -0x24(%ebp),%edx
  99:	8b 45 e0             	mov    -0x20(%ebp),%eax
  9c:	57                   	push   %edi
  9d:	56                   	push   %esi
  9e:	53                   	push   %ebx
  9f:	51                   	push   %ecx
  a0:	52                   	push   %edx
  a1:	50                   	push   %eax
  a2:	68 7c 08 00 00       	push   $0x87c
  a7:	6a 02                	push   $0x2
  a9:	e8 de 03 00 00       	call   48c <printf>
  ae:	83 c4 20             	add    $0x20,%esp
		r.hour, r.minute, r.second);
	
	exit();
  b1:	e8 57 02 00 00       	call   30d <exit>

000000b6 <stosb>:
  b6:	55                   	push   %ebp
  b7:	89 e5                	mov    %esp,%ebp
  b9:	57                   	push   %edi
  ba:	53                   	push   %ebx
  bb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  be:	8b 55 10             	mov    0x10(%ebp),%edx
  c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  c4:	89 cb                	mov    %ecx,%ebx
  c6:	89 df                	mov    %ebx,%edi
  c8:	89 d1                	mov    %edx,%ecx
  ca:	fc                   	cld    
  cb:	f3 aa                	rep stos %al,%es:(%edi)
  cd:	89 ca                	mov    %ecx,%edx
  cf:	89 fb                	mov    %edi,%ebx
  d1:	89 5d 08             	mov    %ebx,0x8(%ebp)
  d4:	89 55 10             	mov    %edx,0x10(%ebp)
  d7:	90                   	nop
  d8:	5b                   	pop    %ebx
  d9:	5f                   	pop    %edi
  da:	5d                   	pop    %ebp
  db:	c3                   	ret    

000000dc <strcpy>:
  dc:	55                   	push   %ebp
  dd:	89 e5                	mov    %esp,%ebp
  df:	83 ec 10             	sub    $0x10,%esp
  e2:	8b 45 08             	mov    0x8(%ebp),%eax
  e5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  e8:	90                   	nop
  e9:	8b 45 08             	mov    0x8(%ebp),%eax
  ec:	8d 50 01             	lea    0x1(%eax),%edx
  ef:	89 55 08             	mov    %edx,0x8(%ebp)
  f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  f5:	8d 4a 01             	lea    0x1(%edx),%ecx
  f8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  fb:	0f b6 12             	movzbl (%edx),%edx
  fe:	88 10                	mov    %dl,(%eax)
 100:	0f b6 00             	movzbl (%eax),%eax
 103:	84 c0                	test   %al,%al
 105:	75 e2                	jne    e9 <strcpy+0xd>
 107:	8b 45 fc             	mov    -0x4(%ebp),%eax
 10a:	c9                   	leave  
 10b:	c3                   	ret    

0000010c <strcmp>:
 10c:	55                   	push   %ebp
 10d:	89 e5                	mov    %esp,%ebp
 10f:	eb 08                	jmp    119 <strcmp+0xd>
 111:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 115:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 119:	8b 45 08             	mov    0x8(%ebp),%eax
 11c:	0f b6 00             	movzbl (%eax),%eax
 11f:	84 c0                	test   %al,%al
 121:	74 10                	je     133 <strcmp+0x27>
 123:	8b 45 08             	mov    0x8(%ebp),%eax
 126:	0f b6 10             	movzbl (%eax),%edx
 129:	8b 45 0c             	mov    0xc(%ebp),%eax
 12c:	0f b6 00             	movzbl (%eax),%eax
 12f:	38 c2                	cmp    %al,%dl
 131:	74 de                	je     111 <strcmp+0x5>
 133:	8b 45 08             	mov    0x8(%ebp),%eax
 136:	0f b6 00             	movzbl (%eax),%eax
 139:	0f b6 d0             	movzbl %al,%edx
 13c:	8b 45 0c             	mov    0xc(%ebp),%eax
 13f:	0f b6 00             	movzbl (%eax),%eax
 142:	0f b6 c0             	movzbl %al,%eax
 145:	29 c2                	sub    %eax,%edx
 147:	89 d0                	mov    %edx,%eax
 149:	5d                   	pop    %ebp
 14a:	c3                   	ret    

0000014b <strlen>:
 14b:	55                   	push   %ebp
 14c:	89 e5                	mov    %esp,%ebp
 14e:	83 ec 10             	sub    $0x10,%esp
 151:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 158:	eb 04                	jmp    15e <strlen+0x13>
 15a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 15e:	8b 55 fc             	mov    -0x4(%ebp),%edx
 161:	8b 45 08             	mov    0x8(%ebp),%eax
 164:	01 d0                	add    %edx,%eax
 166:	0f b6 00             	movzbl (%eax),%eax
 169:	84 c0                	test   %al,%al
 16b:	75 ed                	jne    15a <strlen+0xf>
 16d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 170:	c9                   	leave  
 171:	c3                   	ret    

00000172 <memset>:
 172:	55                   	push   %ebp
 173:	89 e5                	mov    %esp,%ebp
 175:	8b 45 10             	mov    0x10(%ebp),%eax
 178:	50                   	push   %eax
 179:	ff 75 0c             	pushl  0xc(%ebp)
 17c:	ff 75 08             	pushl  0x8(%ebp)
 17f:	e8 32 ff ff ff       	call   b6 <stosb>
 184:	83 c4 0c             	add    $0xc,%esp
 187:	8b 45 08             	mov    0x8(%ebp),%eax
 18a:	c9                   	leave  
 18b:	c3                   	ret    

0000018c <strchr>:
 18c:	55                   	push   %ebp
 18d:	89 e5                	mov    %esp,%ebp
 18f:	83 ec 04             	sub    $0x4,%esp
 192:	8b 45 0c             	mov    0xc(%ebp),%eax
 195:	88 45 fc             	mov    %al,-0x4(%ebp)
 198:	eb 14                	jmp    1ae <strchr+0x22>
 19a:	8b 45 08             	mov    0x8(%ebp),%eax
 19d:	0f b6 00             	movzbl (%eax),%eax
 1a0:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1a3:	75 05                	jne    1aa <strchr+0x1e>
 1a5:	8b 45 08             	mov    0x8(%ebp),%eax
 1a8:	eb 13                	jmp    1bd <strchr+0x31>
 1aa:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1ae:	8b 45 08             	mov    0x8(%ebp),%eax
 1b1:	0f b6 00             	movzbl (%eax),%eax
 1b4:	84 c0                	test   %al,%al
 1b6:	75 e2                	jne    19a <strchr+0xe>
 1b8:	b8 00 00 00 00       	mov    $0x0,%eax
 1bd:	c9                   	leave  
 1be:	c3                   	ret    

000001bf <gets>:
 1bf:	55                   	push   %ebp
 1c0:	89 e5                	mov    %esp,%ebp
 1c2:	83 ec 18             	sub    $0x18,%esp
 1c5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1cc:	eb 42                	jmp    210 <gets+0x51>
 1ce:	83 ec 04             	sub    $0x4,%esp
 1d1:	6a 01                	push   $0x1
 1d3:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1d6:	50                   	push   %eax
 1d7:	6a 00                	push   $0x0
 1d9:	e8 47 01 00 00       	call   325 <read>
 1de:	83 c4 10             	add    $0x10,%esp
 1e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
 1e4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1e8:	7e 33                	jle    21d <gets+0x5e>
 1ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ed:	8d 50 01             	lea    0x1(%eax),%edx
 1f0:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1f3:	89 c2                	mov    %eax,%edx
 1f5:	8b 45 08             	mov    0x8(%ebp),%eax
 1f8:	01 c2                	add    %eax,%edx
 1fa:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1fe:	88 02                	mov    %al,(%edx)
 200:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 204:	3c 0a                	cmp    $0xa,%al
 206:	74 16                	je     21e <gets+0x5f>
 208:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 20c:	3c 0d                	cmp    $0xd,%al
 20e:	74 0e                	je     21e <gets+0x5f>
 210:	8b 45 f4             	mov    -0xc(%ebp),%eax
 213:	83 c0 01             	add    $0x1,%eax
 216:	3b 45 0c             	cmp    0xc(%ebp),%eax
 219:	7c b3                	jl     1ce <gets+0xf>
 21b:	eb 01                	jmp    21e <gets+0x5f>
 21d:	90                   	nop
 21e:	8b 55 f4             	mov    -0xc(%ebp),%edx
 221:	8b 45 08             	mov    0x8(%ebp),%eax
 224:	01 d0                	add    %edx,%eax
 226:	c6 00 00             	movb   $0x0,(%eax)
 229:	8b 45 08             	mov    0x8(%ebp),%eax
 22c:	c9                   	leave  
 22d:	c3                   	ret    

0000022e <stat>:
 22e:	55                   	push   %ebp
 22f:	89 e5                	mov    %esp,%ebp
 231:	83 ec 18             	sub    $0x18,%esp
 234:	83 ec 08             	sub    $0x8,%esp
 237:	6a 00                	push   $0x0
 239:	ff 75 08             	pushl  0x8(%ebp)
 23c:	e8 0c 01 00 00       	call   34d <open>
 241:	83 c4 10             	add    $0x10,%esp
 244:	89 45 f4             	mov    %eax,-0xc(%ebp)
 247:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 24b:	79 07                	jns    254 <stat+0x26>
 24d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 252:	eb 25                	jmp    279 <stat+0x4b>
 254:	83 ec 08             	sub    $0x8,%esp
 257:	ff 75 0c             	pushl  0xc(%ebp)
 25a:	ff 75 f4             	pushl  -0xc(%ebp)
 25d:	e8 03 01 00 00       	call   365 <fstat>
 262:	83 c4 10             	add    $0x10,%esp
 265:	89 45 f0             	mov    %eax,-0x10(%ebp)
 268:	83 ec 0c             	sub    $0xc,%esp
 26b:	ff 75 f4             	pushl  -0xc(%ebp)
 26e:	e8 c2 00 00 00       	call   335 <close>
 273:	83 c4 10             	add    $0x10,%esp
 276:	8b 45 f0             	mov    -0x10(%ebp),%eax
 279:	c9                   	leave  
 27a:	c3                   	ret    

0000027b <atoi>:
 27b:	55                   	push   %ebp
 27c:	89 e5                	mov    %esp,%ebp
 27e:	83 ec 10             	sub    $0x10,%esp
 281:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 288:	eb 25                	jmp    2af <atoi+0x34>
 28a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 28d:	89 d0                	mov    %edx,%eax
 28f:	c1 e0 02             	shl    $0x2,%eax
 292:	01 d0                	add    %edx,%eax
 294:	01 c0                	add    %eax,%eax
 296:	89 c1                	mov    %eax,%ecx
 298:	8b 45 08             	mov    0x8(%ebp),%eax
 29b:	8d 50 01             	lea    0x1(%eax),%edx
 29e:	89 55 08             	mov    %edx,0x8(%ebp)
 2a1:	0f b6 00             	movzbl (%eax),%eax
 2a4:	0f be c0             	movsbl %al,%eax
 2a7:	01 c8                	add    %ecx,%eax
 2a9:	83 e8 30             	sub    $0x30,%eax
 2ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
 2af:	8b 45 08             	mov    0x8(%ebp),%eax
 2b2:	0f b6 00             	movzbl (%eax),%eax
 2b5:	3c 2f                	cmp    $0x2f,%al
 2b7:	7e 0a                	jle    2c3 <atoi+0x48>
 2b9:	8b 45 08             	mov    0x8(%ebp),%eax
 2bc:	0f b6 00             	movzbl (%eax),%eax
 2bf:	3c 39                	cmp    $0x39,%al
 2c1:	7e c7                	jle    28a <atoi+0xf>
 2c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2c6:	c9                   	leave  
 2c7:	c3                   	ret    

000002c8 <memmove>:
 2c8:	55                   	push   %ebp
 2c9:	89 e5                	mov    %esp,%ebp
 2cb:	83 ec 10             	sub    $0x10,%esp
 2ce:	8b 45 08             	mov    0x8(%ebp),%eax
 2d1:	89 45 fc             	mov    %eax,-0x4(%ebp)
 2d4:	8b 45 0c             	mov    0xc(%ebp),%eax
 2d7:	89 45 f8             	mov    %eax,-0x8(%ebp)
 2da:	eb 17                	jmp    2f3 <memmove+0x2b>
 2dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2df:	8d 50 01             	lea    0x1(%eax),%edx
 2e2:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2e5:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2e8:	8d 4a 01             	lea    0x1(%edx),%ecx
 2eb:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2ee:	0f b6 12             	movzbl (%edx),%edx
 2f1:	88 10                	mov    %dl,(%eax)
 2f3:	8b 45 10             	mov    0x10(%ebp),%eax
 2f6:	8d 50 ff             	lea    -0x1(%eax),%edx
 2f9:	89 55 10             	mov    %edx,0x10(%ebp)
 2fc:	85 c0                	test   %eax,%eax
 2fe:	7f dc                	jg     2dc <memmove+0x14>
 300:	8b 45 08             	mov    0x8(%ebp),%eax
 303:	c9                   	leave  
 304:	c3                   	ret    

00000305 <fork>:
 305:	b8 01 00 00 00       	mov    $0x1,%eax
 30a:	cd 40                	int    $0x40
 30c:	c3                   	ret    

0000030d <exit>:
 30d:	b8 02 00 00 00       	mov    $0x2,%eax
 312:	cd 40                	int    $0x40
 314:	c3                   	ret    

00000315 <wait>:
 315:	b8 03 00 00 00       	mov    $0x3,%eax
 31a:	cd 40                	int    $0x40
 31c:	c3                   	ret    

0000031d <pipe>:
 31d:	b8 04 00 00 00       	mov    $0x4,%eax
 322:	cd 40                	int    $0x40
 324:	c3                   	ret    

00000325 <read>:
 325:	b8 05 00 00 00       	mov    $0x5,%eax
 32a:	cd 40                	int    $0x40
 32c:	c3                   	ret    

0000032d <write>:
 32d:	b8 10 00 00 00       	mov    $0x10,%eax
 332:	cd 40                	int    $0x40
 334:	c3                   	ret    

00000335 <close>:
 335:	b8 15 00 00 00       	mov    $0x15,%eax
 33a:	cd 40                	int    $0x40
 33c:	c3                   	ret    

0000033d <kill>:
 33d:	b8 06 00 00 00       	mov    $0x6,%eax
 342:	cd 40                	int    $0x40
 344:	c3                   	ret    

00000345 <exec>:
 345:	b8 07 00 00 00       	mov    $0x7,%eax
 34a:	cd 40                	int    $0x40
 34c:	c3                   	ret    

0000034d <open>:
 34d:	b8 0f 00 00 00       	mov    $0xf,%eax
 352:	cd 40                	int    $0x40
 354:	c3                   	ret    

00000355 <mknod>:
 355:	b8 11 00 00 00       	mov    $0x11,%eax
 35a:	cd 40                	int    $0x40
 35c:	c3                   	ret    

0000035d <unlink>:
 35d:	b8 12 00 00 00       	mov    $0x12,%eax
 362:	cd 40                	int    $0x40
 364:	c3                   	ret    

00000365 <fstat>:
 365:	b8 08 00 00 00       	mov    $0x8,%eax
 36a:	cd 40                	int    $0x40
 36c:	c3                   	ret    

0000036d <link>:
 36d:	b8 13 00 00 00       	mov    $0x13,%eax
 372:	cd 40                	int    $0x40
 374:	c3                   	ret    

00000375 <mkdir>:
 375:	b8 14 00 00 00       	mov    $0x14,%eax
 37a:	cd 40                	int    $0x40
 37c:	c3                   	ret    

0000037d <chdir>:
 37d:	b8 09 00 00 00       	mov    $0x9,%eax
 382:	cd 40                	int    $0x40
 384:	c3                   	ret    

00000385 <dup>:
 385:	b8 0a 00 00 00       	mov    $0xa,%eax
 38a:	cd 40                	int    $0x40
 38c:	c3                   	ret    

0000038d <getpid>:
 38d:	b8 0b 00 00 00       	mov    $0xb,%eax
 392:	cd 40                	int    $0x40
 394:	c3                   	ret    

00000395 <sbrk>:
 395:	b8 0c 00 00 00       	mov    $0xc,%eax
 39a:	cd 40                	int    $0x40
 39c:	c3                   	ret    

0000039d <sleep>:
 39d:	b8 0d 00 00 00       	mov    $0xd,%eax
 3a2:	cd 40                	int    $0x40
 3a4:	c3                   	ret    

000003a5 <uptime>:
 3a5:	b8 0e 00 00 00       	mov    $0xe,%eax
 3aa:	cd 40                	int    $0x40
 3ac:	c3                   	ret    

000003ad <date>:
 3ad:	b8 16 00 00 00       	mov    $0x16,%eax
 3b2:	cd 40                	int    $0x40
 3b4:	c3                   	ret    

000003b5 <putc>:
 3b5:	55                   	push   %ebp
 3b6:	89 e5                	mov    %esp,%ebp
 3b8:	83 ec 18             	sub    $0x18,%esp
 3bb:	8b 45 0c             	mov    0xc(%ebp),%eax
 3be:	88 45 f4             	mov    %al,-0xc(%ebp)
 3c1:	83 ec 04             	sub    $0x4,%esp
 3c4:	6a 01                	push   $0x1
 3c6:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3c9:	50                   	push   %eax
 3ca:	ff 75 08             	pushl  0x8(%ebp)
 3cd:	e8 5b ff ff ff       	call   32d <write>
 3d2:	83 c4 10             	add    $0x10,%esp
 3d5:	90                   	nop
 3d6:	c9                   	leave  
 3d7:	c3                   	ret    

000003d8 <printint>:
 3d8:	55                   	push   %ebp
 3d9:	89 e5                	mov    %esp,%ebp
 3db:	53                   	push   %ebx
 3dc:	83 ec 24             	sub    $0x24,%esp
 3df:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 3e6:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3ea:	74 17                	je     403 <printint+0x2b>
 3ec:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3f0:	79 11                	jns    403 <printint+0x2b>
 3f2:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 3f9:	8b 45 0c             	mov    0xc(%ebp),%eax
 3fc:	f7 d8                	neg    %eax
 3fe:	89 45 ec             	mov    %eax,-0x14(%ebp)
 401:	eb 06                	jmp    409 <printint+0x31>
 403:	8b 45 0c             	mov    0xc(%ebp),%eax
 406:	89 45 ec             	mov    %eax,-0x14(%ebp)
 409:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 410:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 413:	8d 41 01             	lea    0x1(%ecx),%eax
 416:	89 45 f4             	mov    %eax,-0xc(%ebp)
 419:	8b 5d 10             	mov    0x10(%ebp),%ebx
 41c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 41f:	ba 00 00 00 00       	mov    $0x0,%edx
 424:	f7 f3                	div    %ebx
 426:	89 d0                	mov    %edx,%eax
 428:	0f b6 80 fc 0a 00 00 	movzbl 0xafc(%eax),%eax
 42f:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 433:	8b 5d 10             	mov    0x10(%ebp),%ebx
 436:	8b 45 ec             	mov    -0x14(%ebp),%eax
 439:	ba 00 00 00 00       	mov    $0x0,%edx
 43e:	f7 f3                	div    %ebx
 440:	89 45 ec             	mov    %eax,-0x14(%ebp)
 443:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 447:	75 c7                	jne    410 <printint+0x38>
 449:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 44d:	74 2d                	je     47c <printint+0xa4>
 44f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 452:	8d 50 01             	lea    0x1(%eax),%edx
 455:	89 55 f4             	mov    %edx,-0xc(%ebp)
 458:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 45d:	eb 1d                	jmp    47c <printint+0xa4>
 45f:	8d 55 dc             	lea    -0x24(%ebp),%edx
 462:	8b 45 f4             	mov    -0xc(%ebp),%eax
 465:	01 d0                	add    %edx,%eax
 467:	0f b6 00             	movzbl (%eax),%eax
 46a:	0f be c0             	movsbl %al,%eax
 46d:	83 ec 08             	sub    $0x8,%esp
 470:	50                   	push   %eax
 471:	ff 75 08             	pushl  0x8(%ebp)
 474:	e8 3c ff ff ff       	call   3b5 <putc>
 479:	83 c4 10             	add    $0x10,%esp
 47c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 480:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 484:	79 d9                	jns    45f <printint+0x87>
 486:	90                   	nop
 487:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 48a:	c9                   	leave  
 48b:	c3                   	ret    

0000048c <printf>:
 48c:	55                   	push   %ebp
 48d:	89 e5                	mov    %esp,%ebp
 48f:	83 ec 28             	sub    $0x28,%esp
 492:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 499:	8d 45 0c             	lea    0xc(%ebp),%eax
 49c:	83 c0 04             	add    $0x4,%eax
 49f:	89 45 e8             	mov    %eax,-0x18(%ebp)
 4a2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4a9:	e9 59 01 00 00       	jmp    607 <printf+0x17b>
 4ae:	8b 55 0c             	mov    0xc(%ebp),%edx
 4b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4b4:	01 d0                	add    %edx,%eax
 4b6:	0f b6 00             	movzbl (%eax),%eax
 4b9:	0f be c0             	movsbl %al,%eax
 4bc:	25 ff 00 00 00       	and    $0xff,%eax
 4c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 4c4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4c8:	75 2c                	jne    4f6 <printf+0x6a>
 4ca:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4ce:	75 0c                	jne    4dc <printf+0x50>
 4d0:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4d7:	e9 27 01 00 00       	jmp    603 <printf+0x177>
 4dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4df:	0f be c0             	movsbl %al,%eax
 4e2:	83 ec 08             	sub    $0x8,%esp
 4e5:	50                   	push   %eax
 4e6:	ff 75 08             	pushl  0x8(%ebp)
 4e9:	e8 c7 fe ff ff       	call   3b5 <putc>
 4ee:	83 c4 10             	add    $0x10,%esp
 4f1:	e9 0d 01 00 00       	jmp    603 <printf+0x177>
 4f6:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4fa:	0f 85 03 01 00 00    	jne    603 <printf+0x177>
 500:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 504:	75 1e                	jne    524 <printf+0x98>
 506:	8b 45 e8             	mov    -0x18(%ebp),%eax
 509:	8b 00                	mov    (%eax),%eax
 50b:	6a 01                	push   $0x1
 50d:	6a 0a                	push   $0xa
 50f:	50                   	push   %eax
 510:	ff 75 08             	pushl  0x8(%ebp)
 513:	e8 c0 fe ff ff       	call   3d8 <printint>
 518:	83 c4 10             	add    $0x10,%esp
 51b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 51f:	e9 d8 00 00 00       	jmp    5fc <printf+0x170>
 524:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 528:	74 06                	je     530 <printf+0xa4>
 52a:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 52e:	75 1e                	jne    54e <printf+0xc2>
 530:	8b 45 e8             	mov    -0x18(%ebp),%eax
 533:	8b 00                	mov    (%eax),%eax
 535:	6a 00                	push   $0x0
 537:	6a 10                	push   $0x10
 539:	50                   	push   %eax
 53a:	ff 75 08             	pushl  0x8(%ebp)
 53d:	e8 96 fe ff ff       	call   3d8 <printint>
 542:	83 c4 10             	add    $0x10,%esp
 545:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 549:	e9 ae 00 00 00       	jmp    5fc <printf+0x170>
 54e:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 552:	75 43                	jne    597 <printf+0x10b>
 554:	8b 45 e8             	mov    -0x18(%ebp),%eax
 557:	8b 00                	mov    (%eax),%eax
 559:	89 45 f4             	mov    %eax,-0xc(%ebp)
 55c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 560:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 564:	75 25                	jne    58b <printf+0xff>
 566:	c7 45 f4 9e 08 00 00 	movl   $0x89e,-0xc(%ebp)
 56d:	eb 1c                	jmp    58b <printf+0xff>
 56f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 572:	0f b6 00             	movzbl (%eax),%eax
 575:	0f be c0             	movsbl %al,%eax
 578:	83 ec 08             	sub    $0x8,%esp
 57b:	50                   	push   %eax
 57c:	ff 75 08             	pushl  0x8(%ebp)
 57f:	e8 31 fe ff ff       	call   3b5 <putc>
 584:	83 c4 10             	add    $0x10,%esp
 587:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 58b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 58e:	0f b6 00             	movzbl (%eax),%eax
 591:	84 c0                	test   %al,%al
 593:	75 da                	jne    56f <printf+0xe3>
 595:	eb 65                	jmp    5fc <printf+0x170>
 597:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 59b:	75 1d                	jne    5ba <printf+0x12e>
 59d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5a0:	8b 00                	mov    (%eax),%eax
 5a2:	0f be c0             	movsbl %al,%eax
 5a5:	83 ec 08             	sub    $0x8,%esp
 5a8:	50                   	push   %eax
 5a9:	ff 75 08             	pushl  0x8(%ebp)
 5ac:	e8 04 fe ff ff       	call   3b5 <putc>
 5b1:	83 c4 10             	add    $0x10,%esp
 5b4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5b8:	eb 42                	jmp    5fc <printf+0x170>
 5ba:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5be:	75 17                	jne    5d7 <printf+0x14b>
 5c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5c3:	0f be c0             	movsbl %al,%eax
 5c6:	83 ec 08             	sub    $0x8,%esp
 5c9:	50                   	push   %eax
 5ca:	ff 75 08             	pushl  0x8(%ebp)
 5cd:	e8 e3 fd ff ff       	call   3b5 <putc>
 5d2:	83 c4 10             	add    $0x10,%esp
 5d5:	eb 25                	jmp    5fc <printf+0x170>
 5d7:	83 ec 08             	sub    $0x8,%esp
 5da:	6a 25                	push   $0x25
 5dc:	ff 75 08             	pushl  0x8(%ebp)
 5df:	e8 d1 fd ff ff       	call   3b5 <putc>
 5e4:	83 c4 10             	add    $0x10,%esp
 5e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5ea:	0f be c0             	movsbl %al,%eax
 5ed:	83 ec 08             	sub    $0x8,%esp
 5f0:	50                   	push   %eax
 5f1:	ff 75 08             	pushl  0x8(%ebp)
 5f4:	e8 bc fd ff ff       	call   3b5 <putc>
 5f9:	83 c4 10             	add    $0x10,%esp
 5fc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 603:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 607:	8b 55 0c             	mov    0xc(%ebp),%edx
 60a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 60d:	01 d0                	add    %edx,%eax
 60f:	0f b6 00             	movzbl (%eax),%eax
 612:	84 c0                	test   %al,%al
 614:	0f 85 94 fe ff ff    	jne    4ae <printf+0x22>
 61a:	90                   	nop
 61b:	c9                   	leave  
 61c:	c3                   	ret    

0000061d <free>:
 61d:	55                   	push   %ebp
 61e:	89 e5                	mov    %esp,%ebp
 620:	83 ec 10             	sub    $0x10,%esp
 623:	8b 45 08             	mov    0x8(%ebp),%eax
 626:	83 e8 08             	sub    $0x8,%eax
 629:	89 45 f8             	mov    %eax,-0x8(%ebp)
 62c:	a1 18 0b 00 00       	mov    0xb18,%eax
 631:	89 45 fc             	mov    %eax,-0x4(%ebp)
 634:	eb 24                	jmp    65a <free+0x3d>
 636:	8b 45 fc             	mov    -0x4(%ebp),%eax
 639:	8b 00                	mov    (%eax),%eax
 63b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 63e:	77 12                	ja     652 <free+0x35>
 640:	8b 45 f8             	mov    -0x8(%ebp),%eax
 643:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 646:	77 24                	ja     66c <free+0x4f>
 648:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64b:	8b 00                	mov    (%eax),%eax
 64d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 650:	77 1a                	ja     66c <free+0x4f>
 652:	8b 45 fc             	mov    -0x4(%ebp),%eax
 655:	8b 00                	mov    (%eax),%eax
 657:	89 45 fc             	mov    %eax,-0x4(%ebp)
 65a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 660:	76 d4                	jbe    636 <free+0x19>
 662:	8b 45 fc             	mov    -0x4(%ebp),%eax
 665:	8b 00                	mov    (%eax),%eax
 667:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 66a:	76 ca                	jbe    636 <free+0x19>
 66c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66f:	8b 40 04             	mov    0x4(%eax),%eax
 672:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 679:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67c:	01 c2                	add    %eax,%edx
 67e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 681:	8b 00                	mov    (%eax),%eax
 683:	39 c2                	cmp    %eax,%edx
 685:	75 24                	jne    6ab <free+0x8e>
 687:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68a:	8b 50 04             	mov    0x4(%eax),%edx
 68d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 690:	8b 00                	mov    (%eax),%eax
 692:	8b 40 04             	mov    0x4(%eax),%eax
 695:	01 c2                	add    %eax,%edx
 697:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69a:	89 50 04             	mov    %edx,0x4(%eax)
 69d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a0:	8b 00                	mov    (%eax),%eax
 6a2:	8b 10                	mov    (%eax),%edx
 6a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a7:	89 10                	mov    %edx,(%eax)
 6a9:	eb 0a                	jmp    6b5 <free+0x98>
 6ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ae:	8b 10                	mov    (%eax),%edx
 6b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b3:	89 10                	mov    %edx,(%eax)
 6b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b8:	8b 40 04             	mov    0x4(%eax),%eax
 6bb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c5:	01 d0                	add    %edx,%eax
 6c7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6ca:	75 20                	jne    6ec <free+0xcf>
 6cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cf:	8b 50 04             	mov    0x4(%eax),%edx
 6d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d5:	8b 40 04             	mov    0x4(%eax),%eax
 6d8:	01 c2                	add    %eax,%edx
 6da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6dd:	89 50 04             	mov    %edx,0x4(%eax)
 6e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e3:	8b 10                	mov    (%eax),%edx
 6e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e8:	89 10                	mov    %edx,(%eax)
 6ea:	eb 08                	jmp    6f4 <free+0xd7>
 6ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ef:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6f2:	89 10                	mov    %edx,(%eax)
 6f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f7:	a3 18 0b 00 00       	mov    %eax,0xb18
 6fc:	90                   	nop
 6fd:	c9                   	leave  
 6fe:	c3                   	ret    

000006ff <morecore>:
 6ff:	55                   	push   %ebp
 700:	89 e5                	mov    %esp,%ebp
 702:	83 ec 18             	sub    $0x18,%esp
 705:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 70c:	77 07                	ja     715 <morecore+0x16>
 70e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 715:	8b 45 08             	mov    0x8(%ebp),%eax
 718:	c1 e0 03             	shl    $0x3,%eax
 71b:	83 ec 0c             	sub    $0xc,%esp
 71e:	50                   	push   %eax
 71f:	e8 71 fc ff ff       	call   395 <sbrk>
 724:	83 c4 10             	add    $0x10,%esp
 727:	89 45 f4             	mov    %eax,-0xc(%ebp)
 72a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 72e:	75 07                	jne    737 <morecore+0x38>
 730:	b8 00 00 00 00       	mov    $0x0,%eax
 735:	eb 26                	jmp    75d <morecore+0x5e>
 737:	8b 45 f4             	mov    -0xc(%ebp),%eax
 73a:	89 45 f0             	mov    %eax,-0x10(%ebp)
 73d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 740:	8b 55 08             	mov    0x8(%ebp),%edx
 743:	89 50 04             	mov    %edx,0x4(%eax)
 746:	8b 45 f0             	mov    -0x10(%ebp),%eax
 749:	83 c0 08             	add    $0x8,%eax
 74c:	83 ec 0c             	sub    $0xc,%esp
 74f:	50                   	push   %eax
 750:	e8 c8 fe ff ff       	call   61d <free>
 755:	83 c4 10             	add    $0x10,%esp
 758:	a1 18 0b 00 00       	mov    0xb18,%eax
 75d:	c9                   	leave  
 75e:	c3                   	ret    

0000075f <malloc>:
 75f:	55                   	push   %ebp
 760:	89 e5                	mov    %esp,%ebp
 762:	83 ec 18             	sub    $0x18,%esp
 765:	8b 45 08             	mov    0x8(%ebp),%eax
 768:	83 c0 07             	add    $0x7,%eax
 76b:	c1 e8 03             	shr    $0x3,%eax
 76e:	83 c0 01             	add    $0x1,%eax
 771:	89 45 ec             	mov    %eax,-0x14(%ebp)
 774:	a1 18 0b 00 00       	mov    0xb18,%eax
 779:	89 45 f0             	mov    %eax,-0x10(%ebp)
 77c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 780:	75 23                	jne    7a5 <malloc+0x46>
 782:	c7 45 f0 10 0b 00 00 	movl   $0xb10,-0x10(%ebp)
 789:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78c:	a3 18 0b 00 00       	mov    %eax,0xb18
 791:	a1 18 0b 00 00       	mov    0xb18,%eax
 796:	a3 10 0b 00 00       	mov    %eax,0xb10
 79b:	c7 05 14 0b 00 00 00 	movl   $0x0,0xb14
 7a2:	00 00 00 
 7a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a8:	8b 00                	mov    (%eax),%eax
 7aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b0:	8b 40 04             	mov    0x4(%eax),%eax
 7b3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7b6:	72 4d                	jb     805 <malloc+0xa6>
 7b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7bb:	8b 40 04             	mov    0x4(%eax),%eax
 7be:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7c1:	75 0c                	jne    7cf <malloc+0x70>
 7c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c6:	8b 10                	mov    (%eax),%edx
 7c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7cb:	89 10                	mov    %edx,(%eax)
 7cd:	eb 26                	jmp    7f5 <malloc+0x96>
 7cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d2:	8b 40 04             	mov    0x4(%eax),%eax
 7d5:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7d8:	89 c2                	mov    %eax,%edx
 7da:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7dd:	89 50 04             	mov    %edx,0x4(%eax)
 7e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e3:	8b 40 04             	mov    0x4(%eax),%eax
 7e6:	c1 e0 03             	shl    $0x3,%eax
 7e9:	01 45 f4             	add    %eax,-0xc(%ebp)
 7ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ef:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7f2:	89 50 04             	mov    %edx,0x4(%eax)
 7f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f8:	a3 18 0b 00 00       	mov    %eax,0xb18
 7fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 800:	83 c0 08             	add    $0x8,%eax
 803:	eb 3b                	jmp    840 <malloc+0xe1>
 805:	a1 18 0b 00 00       	mov    0xb18,%eax
 80a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 80d:	75 1e                	jne    82d <malloc+0xce>
 80f:	83 ec 0c             	sub    $0xc,%esp
 812:	ff 75 ec             	pushl  -0x14(%ebp)
 815:	e8 e5 fe ff ff       	call   6ff <morecore>
 81a:	83 c4 10             	add    $0x10,%esp
 81d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 820:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 824:	75 07                	jne    82d <malloc+0xce>
 826:	b8 00 00 00 00       	mov    $0x0,%eax
 82b:	eb 13                	jmp    840 <malloc+0xe1>
 82d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 830:	89 45 f0             	mov    %eax,-0x10(%ebp)
 833:	8b 45 f4             	mov    -0xc(%ebp),%eax
 836:	8b 00                	mov    (%eax),%eax
 838:	89 45 f4             	mov    %eax,-0xc(%ebp)
 83b:	e9 6d ff ff ff       	jmp    7ad <malloc+0x4e>
 840:	c9                   	leave  
 841:	c3                   	ret    
