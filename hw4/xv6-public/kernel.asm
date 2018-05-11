
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 b0 10 00       	mov    $0x10b000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 50 d6 10 80       	mov    $0x8010d650,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 8f 38 10 80       	mov    $0x8010388f,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	83 ec 18             	sub    $0x18,%esp
8010003a:	83 ec 08             	sub    $0x8,%esp
8010003d:	68 20 8b 10 80       	push   $0x80108b20
80100042:	68 60 d6 10 80       	push   $0x8010d660
80100047:	e8 dd 54 00 00       	call   80105529 <initlock>
8010004c:	83 c4 10             	add    $0x10,%esp
8010004f:	c7 05 70 15 11 80 64 	movl   $0x80111564,0x80111570
80100056:	15 11 80 
80100059:	c7 05 74 15 11 80 64 	movl   $0x80111564,0x80111574
80100060:	15 11 80 
80100063:	c7 45 f4 94 d6 10 80 	movl   $0x8010d694,-0xc(%ebp)
8010006a:	eb 3a                	jmp    801000a6 <binit+0x72>
8010006c:	8b 15 74 15 11 80    	mov    0x80111574,%edx
80100072:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100075:	89 50 10             	mov    %edx,0x10(%eax)
80100078:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007b:	c7 40 0c 64 15 11 80 	movl   $0x80111564,0xc(%eax)
80100082:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100085:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
8010008c:	a1 74 15 11 80       	mov    0x80111574,%eax
80100091:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100094:	89 50 0c             	mov    %edx,0xc(%eax)
80100097:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010009a:	a3 74 15 11 80       	mov    %eax,0x80111574
8010009f:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000a6:	b8 64 15 11 80       	mov    $0x80111564,%eax
801000ab:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801000ae:	72 bc                	jb     8010006c <binit+0x38>
801000b0:	90                   	nop
801000b1:	c9                   	leave  
801000b2:	c3                   	ret    

801000b3 <bget>:
801000b3:	55                   	push   %ebp
801000b4:	89 e5                	mov    %esp,%ebp
801000b6:	83 ec 18             	sub    $0x18,%esp
801000b9:	83 ec 0c             	sub    $0xc,%esp
801000bc:	68 60 d6 10 80       	push   $0x8010d660
801000c1:	e8 85 54 00 00       	call   8010554b <acquire>
801000c6:	83 c4 10             	add    $0x10,%esp
801000c9:	a1 74 15 11 80       	mov    0x80111574,%eax
801000ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000d1:	eb 67                	jmp    8010013a <bget+0x87>
801000d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000d6:	8b 40 04             	mov    0x4(%eax),%eax
801000d9:	3b 45 08             	cmp    0x8(%ebp),%eax
801000dc:	75 53                	jne    80100131 <bget+0x7e>
801000de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000e1:	8b 40 08             	mov    0x8(%eax),%eax
801000e4:	3b 45 0c             	cmp    0xc(%ebp),%eax
801000e7:	75 48                	jne    80100131 <bget+0x7e>
801000e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000ec:	8b 00                	mov    (%eax),%eax
801000ee:	83 e0 01             	and    $0x1,%eax
801000f1:	85 c0                	test   %eax,%eax
801000f3:	75 27                	jne    8010011c <bget+0x69>
801000f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f8:	8b 00                	mov    (%eax),%eax
801000fa:	83 c8 01             	or     $0x1,%eax
801000fd:	89 c2                	mov    %eax,%edx
801000ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100102:	89 10                	mov    %edx,(%eax)
80100104:	83 ec 0c             	sub    $0xc,%esp
80100107:	68 60 d6 10 80       	push   $0x8010d660
8010010c:	e8 a1 54 00 00       	call   801055b2 <release>
80100111:	83 c4 10             	add    $0x10,%esp
80100114:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100117:	e9 98 00 00 00       	jmp    801001b4 <bget+0x101>
8010011c:	83 ec 08             	sub    $0x8,%esp
8010011f:	68 60 d6 10 80       	push   $0x8010d660
80100124:	ff 75 f4             	pushl  -0xc(%ebp)
80100127:	e8 fb 4c 00 00       	call   80104e27 <sleep>
8010012c:	83 c4 10             	add    $0x10,%esp
8010012f:	eb 98                	jmp    801000c9 <bget+0x16>
80100131:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100134:	8b 40 10             	mov    0x10(%eax),%eax
80100137:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010013a:	81 7d f4 64 15 11 80 	cmpl   $0x80111564,-0xc(%ebp)
80100141:	75 90                	jne    801000d3 <bget+0x20>
80100143:	a1 70 15 11 80       	mov    0x80111570,%eax
80100148:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010014b:	eb 51                	jmp    8010019e <bget+0xeb>
8010014d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100150:	8b 00                	mov    (%eax),%eax
80100152:	83 e0 01             	and    $0x1,%eax
80100155:	85 c0                	test   %eax,%eax
80100157:	75 3c                	jne    80100195 <bget+0xe2>
80100159:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010015c:	8b 00                	mov    (%eax),%eax
8010015e:	83 e0 04             	and    $0x4,%eax
80100161:	85 c0                	test   %eax,%eax
80100163:	75 30                	jne    80100195 <bget+0xe2>
80100165:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100168:	8b 55 08             	mov    0x8(%ebp),%edx
8010016b:	89 50 04             	mov    %edx,0x4(%eax)
8010016e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100171:	8b 55 0c             	mov    0xc(%ebp),%edx
80100174:	89 50 08             	mov    %edx,0x8(%eax)
80100177:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010017a:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
80100180:	83 ec 0c             	sub    $0xc,%esp
80100183:	68 60 d6 10 80       	push   $0x8010d660
80100188:	e8 25 54 00 00       	call   801055b2 <release>
8010018d:	83 c4 10             	add    $0x10,%esp
80100190:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100193:	eb 1f                	jmp    801001b4 <bget+0x101>
80100195:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100198:	8b 40 0c             	mov    0xc(%eax),%eax
8010019b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010019e:	81 7d f4 64 15 11 80 	cmpl   $0x80111564,-0xc(%ebp)
801001a5:	75 a6                	jne    8010014d <bget+0x9a>
801001a7:	83 ec 0c             	sub    $0xc,%esp
801001aa:	68 27 8b 10 80       	push   $0x80108b27
801001af:	e8 b2 03 00 00       	call   80100566 <panic>
801001b4:	c9                   	leave  
801001b5:	c3                   	ret    

801001b6 <bread>:
801001b6:	55                   	push   %ebp
801001b7:	89 e5                	mov    %esp,%ebp
801001b9:	83 ec 18             	sub    $0x18,%esp
801001bc:	83 ec 08             	sub    $0x8,%esp
801001bf:	ff 75 0c             	pushl  0xc(%ebp)
801001c2:	ff 75 08             	pushl  0x8(%ebp)
801001c5:	e8 e9 fe ff ff       	call   801000b3 <bget>
801001ca:	83 c4 10             	add    $0x10,%esp
801001cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
801001d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001d3:	8b 00                	mov    (%eax),%eax
801001d5:	83 e0 02             	and    $0x2,%eax
801001d8:	85 c0                	test   %eax,%eax
801001da:	75 0e                	jne    801001ea <bread+0x34>
801001dc:	83 ec 0c             	sub    $0xc,%esp
801001df:	ff 75 f4             	pushl  -0xc(%ebp)
801001e2:	e8 26 27 00 00       	call   8010290d <iderw>
801001e7:	83 c4 10             	add    $0x10,%esp
801001ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001ed:	c9                   	leave  
801001ee:	c3                   	ret    

801001ef <bwrite>:
801001ef:	55                   	push   %ebp
801001f0:	89 e5                	mov    %esp,%ebp
801001f2:	83 ec 08             	sub    $0x8,%esp
801001f5:	8b 45 08             	mov    0x8(%ebp),%eax
801001f8:	8b 00                	mov    (%eax),%eax
801001fa:	83 e0 01             	and    $0x1,%eax
801001fd:	85 c0                	test   %eax,%eax
801001ff:	75 0d                	jne    8010020e <bwrite+0x1f>
80100201:	83 ec 0c             	sub    $0xc,%esp
80100204:	68 38 8b 10 80       	push   $0x80108b38
80100209:	e8 58 03 00 00       	call   80100566 <panic>
8010020e:	8b 45 08             	mov    0x8(%ebp),%eax
80100211:	8b 00                	mov    (%eax),%eax
80100213:	83 c8 04             	or     $0x4,%eax
80100216:	89 c2                	mov    %eax,%edx
80100218:	8b 45 08             	mov    0x8(%ebp),%eax
8010021b:	89 10                	mov    %edx,(%eax)
8010021d:	83 ec 0c             	sub    $0xc,%esp
80100220:	ff 75 08             	pushl  0x8(%ebp)
80100223:	e8 e5 26 00 00       	call   8010290d <iderw>
80100228:	83 c4 10             	add    $0x10,%esp
8010022b:	90                   	nop
8010022c:	c9                   	leave  
8010022d:	c3                   	ret    

8010022e <brelse>:
8010022e:	55                   	push   %ebp
8010022f:	89 e5                	mov    %esp,%ebp
80100231:	83 ec 08             	sub    $0x8,%esp
80100234:	8b 45 08             	mov    0x8(%ebp),%eax
80100237:	8b 00                	mov    (%eax),%eax
80100239:	83 e0 01             	and    $0x1,%eax
8010023c:	85 c0                	test   %eax,%eax
8010023e:	75 0d                	jne    8010024d <brelse+0x1f>
80100240:	83 ec 0c             	sub    $0xc,%esp
80100243:	68 3f 8b 10 80       	push   $0x80108b3f
80100248:	e8 19 03 00 00       	call   80100566 <panic>
8010024d:	83 ec 0c             	sub    $0xc,%esp
80100250:	68 60 d6 10 80       	push   $0x8010d660
80100255:	e8 f1 52 00 00       	call   8010554b <acquire>
8010025a:	83 c4 10             	add    $0x10,%esp
8010025d:	8b 45 08             	mov    0x8(%ebp),%eax
80100260:	8b 40 10             	mov    0x10(%eax),%eax
80100263:	8b 55 08             	mov    0x8(%ebp),%edx
80100266:	8b 52 0c             	mov    0xc(%edx),%edx
80100269:	89 50 0c             	mov    %edx,0xc(%eax)
8010026c:	8b 45 08             	mov    0x8(%ebp),%eax
8010026f:	8b 40 0c             	mov    0xc(%eax),%eax
80100272:	8b 55 08             	mov    0x8(%ebp),%edx
80100275:	8b 52 10             	mov    0x10(%edx),%edx
80100278:	89 50 10             	mov    %edx,0x10(%eax)
8010027b:	8b 15 74 15 11 80    	mov    0x80111574,%edx
80100281:	8b 45 08             	mov    0x8(%ebp),%eax
80100284:	89 50 10             	mov    %edx,0x10(%eax)
80100287:	8b 45 08             	mov    0x8(%ebp),%eax
8010028a:	c7 40 0c 64 15 11 80 	movl   $0x80111564,0xc(%eax)
80100291:	a1 74 15 11 80       	mov    0x80111574,%eax
80100296:	8b 55 08             	mov    0x8(%ebp),%edx
80100299:	89 50 0c             	mov    %edx,0xc(%eax)
8010029c:	8b 45 08             	mov    0x8(%ebp),%eax
8010029f:	a3 74 15 11 80       	mov    %eax,0x80111574
801002a4:	8b 45 08             	mov    0x8(%ebp),%eax
801002a7:	8b 00                	mov    (%eax),%eax
801002a9:	83 e0 fe             	and    $0xfffffffe,%eax
801002ac:	89 c2                	mov    %eax,%edx
801002ae:	8b 45 08             	mov    0x8(%ebp),%eax
801002b1:	89 10                	mov    %edx,(%eax)
801002b3:	83 ec 0c             	sub    $0xc,%esp
801002b6:	ff 75 08             	pushl  0x8(%ebp)
801002b9:	e8 57 4c 00 00       	call   80104f15 <wakeup>
801002be:	83 c4 10             	add    $0x10,%esp
801002c1:	83 ec 0c             	sub    $0xc,%esp
801002c4:	68 60 d6 10 80       	push   $0x8010d660
801002c9:	e8 e4 52 00 00       	call   801055b2 <release>
801002ce:	83 c4 10             	add    $0x10,%esp
801002d1:	90                   	nop
801002d2:	c9                   	leave  
801002d3:	c3                   	ret    

801002d4 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801002d4:	55                   	push   %ebp
801002d5:	89 e5                	mov    %esp,%ebp
801002d7:	83 ec 14             	sub    $0x14,%esp
801002da:	8b 45 08             	mov    0x8(%ebp),%eax
801002dd:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801002e1:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801002e5:	89 c2                	mov    %eax,%edx
801002e7:	ec                   	in     (%dx),%al
801002e8:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801002eb:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801002ef:	c9                   	leave  
801002f0:	c3                   	ret    

801002f1 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801002f1:	55                   	push   %ebp
801002f2:	89 e5                	mov    %esp,%ebp
801002f4:	83 ec 08             	sub    $0x8,%esp
801002f7:	8b 55 08             	mov    0x8(%ebp),%edx
801002fa:	8b 45 0c             	mov    0xc(%ebp),%eax
801002fd:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80100301:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100304:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80100308:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010030c:	ee                   	out    %al,(%dx)
}
8010030d:	90                   	nop
8010030e:	c9                   	leave  
8010030f:	c3                   	ret    

80100310 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80100310:	55                   	push   %ebp
80100311:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80100313:	fa                   	cli    
}
80100314:	90                   	nop
80100315:	5d                   	pop    %ebp
80100316:	c3                   	ret    

80100317 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100317:	55                   	push   %ebp
80100318:	89 e5                	mov    %esp,%ebp
8010031a:	53                   	push   %ebx
8010031b:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010031e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100322:	74 1c                	je     80100340 <printint+0x29>
80100324:	8b 45 08             	mov    0x8(%ebp),%eax
80100327:	c1 e8 1f             	shr    $0x1f,%eax
8010032a:	0f b6 c0             	movzbl %al,%eax
8010032d:	89 45 10             	mov    %eax,0x10(%ebp)
80100330:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100334:	74 0a                	je     80100340 <printint+0x29>
    x = -xx;
80100336:	8b 45 08             	mov    0x8(%ebp),%eax
80100339:	f7 d8                	neg    %eax
8010033b:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010033e:	eb 06                	jmp    80100346 <printint+0x2f>
  else
    x = xx;
80100340:	8b 45 08             	mov    0x8(%ebp),%eax
80100343:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
80100346:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
8010034d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100350:	8d 41 01             	lea    0x1(%ecx),%eax
80100353:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100356:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100359:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010035c:	ba 00 00 00 00       	mov    $0x0,%edx
80100361:	f7 f3                	div    %ebx
80100363:	89 d0                	mov    %edx,%eax
80100365:	0f b6 80 04 a0 10 80 	movzbl -0x7fef5ffc(%eax),%eax
8010036c:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
  }while((x /= base) != 0);
80100370:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100373:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100376:	ba 00 00 00 00       	mov    $0x0,%edx
8010037b:	f7 f3                	div    %ebx
8010037d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100380:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100384:	75 c7                	jne    8010034d <printint+0x36>

  if(sign)
80100386:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010038a:	74 2a                	je     801003b6 <printint+0x9f>
    buf[i++] = '-';
8010038c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010038f:	8d 50 01             	lea    0x1(%eax),%edx
80100392:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100395:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
8010039a:	eb 1a                	jmp    801003b6 <printint+0x9f>
    consputc(buf[i]);
8010039c:	8d 55 e0             	lea    -0x20(%ebp),%edx
8010039f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003a2:	01 d0                	add    %edx,%eax
801003a4:	0f b6 00             	movzbl (%eax),%eax
801003a7:	0f be c0             	movsbl %al,%eax
801003aa:	83 ec 0c             	sub    $0xc,%esp
801003ad:	50                   	push   %eax
801003ae:	e8 df 03 00 00       	call   80100792 <consputc>
801003b3:	83 c4 10             	add    $0x10,%esp
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801003b6:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801003ba:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801003be:	79 dc                	jns    8010039c <printint+0x85>
    consputc(buf[i]);
}
801003c0:	90                   	nop
801003c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801003c4:	c9                   	leave  
801003c5:	c3                   	ret    

801003c6 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801003c6:	55                   	push   %ebp
801003c7:	89 e5                	mov    %esp,%ebp
801003c9:	83 ec 28             	sub    $0x28,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801003cc:	a1 f4 c5 10 80       	mov    0x8010c5f4,%eax
801003d1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801003d4:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801003d8:	74 10                	je     801003ea <cprintf+0x24>
    acquire(&cons.lock);
801003da:	83 ec 0c             	sub    $0xc,%esp
801003dd:	68 c0 c5 10 80       	push   $0x8010c5c0
801003e2:	e8 64 51 00 00       	call   8010554b <acquire>
801003e7:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
801003ea:	8b 45 08             	mov    0x8(%ebp),%eax
801003ed:	85 c0                	test   %eax,%eax
801003ef:	75 0d                	jne    801003fe <cprintf+0x38>
    panic("null fmt");
801003f1:	83 ec 0c             	sub    $0xc,%esp
801003f4:	68 46 8b 10 80       	push   $0x80108b46
801003f9:	e8 68 01 00 00       	call   80100566 <panic>

  argp = (uint*)(void*)(&fmt + 1);
801003fe:	8d 45 0c             	lea    0xc(%ebp),%eax
80100401:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100404:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010040b:	e9 1a 01 00 00       	jmp    8010052a <cprintf+0x164>
    if(c != '%'){
80100410:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
80100414:	74 13                	je     80100429 <cprintf+0x63>
      consputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	ff 75 e4             	pushl  -0x1c(%ebp)
8010041c:	e8 71 03 00 00       	call   80100792 <consputc>
80100421:	83 c4 10             	add    $0x10,%esp
      continue;
80100424:	e9 fd 00 00 00       	jmp    80100526 <cprintf+0x160>
    }
    c = fmt[++i] & 0xff;
80100429:	8b 55 08             	mov    0x8(%ebp),%edx
8010042c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100430:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100433:	01 d0                	add    %edx,%eax
80100435:	0f b6 00             	movzbl (%eax),%eax
80100438:	0f be c0             	movsbl %al,%eax
8010043b:	25 ff 00 00 00       	and    $0xff,%eax
80100440:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
80100443:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100447:	0f 84 ff 00 00 00    	je     8010054c <cprintf+0x186>
      break;
    switch(c){
8010044d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100450:	83 f8 70             	cmp    $0x70,%eax
80100453:	74 47                	je     8010049c <cprintf+0xd6>
80100455:	83 f8 70             	cmp    $0x70,%eax
80100458:	7f 13                	jg     8010046d <cprintf+0xa7>
8010045a:	83 f8 25             	cmp    $0x25,%eax
8010045d:	0f 84 98 00 00 00    	je     801004fb <cprintf+0x135>
80100463:	83 f8 64             	cmp    $0x64,%eax
80100466:	74 14                	je     8010047c <cprintf+0xb6>
80100468:	e9 9d 00 00 00       	jmp    8010050a <cprintf+0x144>
8010046d:	83 f8 73             	cmp    $0x73,%eax
80100470:	74 47                	je     801004b9 <cprintf+0xf3>
80100472:	83 f8 78             	cmp    $0x78,%eax
80100475:	74 25                	je     8010049c <cprintf+0xd6>
80100477:	e9 8e 00 00 00       	jmp    8010050a <cprintf+0x144>
    case 'd':
      printint(*argp++, 10, 1);
8010047c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010047f:	8d 50 04             	lea    0x4(%eax),%edx
80100482:	89 55 f0             	mov    %edx,-0x10(%ebp)
80100485:	8b 00                	mov    (%eax),%eax
80100487:	83 ec 04             	sub    $0x4,%esp
8010048a:	6a 01                	push   $0x1
8010048c:	6a 0a                	push   $0xa
8010048e:	50                   	push   %eax
8010048f:	e8 83 fe ff ff       	call   80100317 <printint>
80100494:	83 c4 10             	add    $0x10,%esp
      break;
80100497:	e9 8a 00 00 00       	jmp    80100526 <cprintf+0x160>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010049c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010049f:	8d 50 04             	lea    0x4(%eax),%edx
801004a2:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004a5:	8b 00                	mov    (%eax),%eax
801004a7:	83 ec 04             	sub    $0x4,%esp
801004aa:	6a 00                	push   $0x0
801004ac:	6a 10                	push   $0x10
801004ae:	50                   	push   %eax
801004af:	e8 63 fe ff ff       	call   80100317 <printint>
801004b4:	83 c4 10             	add    $0x10,%esp
      break;
801004b7:	eb 6d                	jmp    80100526 <cprintf+0x160>
    case 's':
      if((s = (char*)*argp++) == 0)
801004b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004bc:	8d 50 04             	lea    0x4(%eax),%edx
801004bf:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004c2:	8b 00                	mov    (%eax),%eax
801004c4:	89 45 ec             	mov    %eax,-0x14(%ebp)
801004c7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801004cb:	75 22                	jne    801004ef <cprintf+0x129>
        s = "(null)";
801004cd:	c7 45 ec 4f 8b 10 80 	movl   $0x80108b4f,-0x14(%ebp)
      for(; *s; s++)
801004d4:	eb 19                	jmp    801004ef <cprintf+0x129>
        consputc(*s);
801004d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004d9:	0f b6 00             	movzbl (%eax),%eax
801004dc:	0f be c0             	movsbl %al,%eax
801004df:	83 ec 0c             	sub    $0xc,%esp
801004e2:	50                   	push   %eax
801004e3:	e8 aa 02 00 00       	call   80100792 <consputc>
801004e8:	83 c4 10             	add    $0x10,%esp
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801004eb:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801004ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004f2:	0f b6 00             	movzbl (%eax),%eax
801004f5:	84 c0                	test   %al,%al
801004f7:	75 dd                	jne    801004d6 <cprintf+0x110>
        consputc(*s);
      break;
801004f9:	eb 2b                	jmp    80100526 <cprintf+0x160>
    case '%':
      consputc('%');
801004fb:	83 ec 0c             	sub    $0xc,%esp
801004fe:	6a 25                	push   $0x25
80100500:	e8 8d 02 00 00       	call   80100792 <consputc>
80100505:	83 c4 10             	add    $0x10,%esp
      break;
80100508:	eb 1c                	jmp    80100526 <cprintf+0x160>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
8010050a:	83 ec 0c             	sub    $0xc,%esp
8010050d:	6a 25                	push   $0x25
8010050f:	e8 7e 02 00 00       	call   80100792 <consputc>
80100514:	83 c4 10             	add    $0x10,%esp
      consputc(c);
80100517:	83 ec 0c             	sub    $0xc,%esp
8010051a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010051d:	e8 70 02 00 00       	call   80100792 <consputc>
80100522:	83 c4 10             	add    $0x10,%esp
      break;
80100525:	90                   	nop

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100526:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010052a:	8b 55 08             	mov    0x8(%ebp),%edx
8010052d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100530:	01 d0                	add    %edx,%eax
80100532:	0f b6 00             	movzbl (%eax),%eax
80100535:	0f be c0             	movsbl %al,%eax
80100538:	25 ff 00 00 00       	and    $0xff,%eax
8010053d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100540:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100544:	0f 85 c6 fe ff ff    	jne    80100410 <cprintf+0x4a>
8010054a:	eb 01                	jmp    8010054d <cprintf+0x187>
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
8010054c:	90                   	nop
      consputc(c);
      break;
    }
  }

  if(locking)
8010054d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100551:	74 10                	je     80100563 <cprintf+0x19d>
    release(&cons.lock);
80100553:	83 ec 0c             	sub    $0xc,%esp
80100556:	68 c0 c5 10 80       	push   $0x8010c5c0
8010055b:	e8 52 50 00 00       	call   801055b2 <release>
80100560:	83 c4 10             	add    $0x10,%esp
}
80100563:	90                   	nop
80100564:	c9                   	leave  
80100565:	c3                   	ret    

80100566 <panic>:

void
panic(char *s)
{
80100566:	55                   	push   %ebp
80100567:	89 e5                	mov    %esp,%ebp
80100569:	83 ec 38             	sub    $0x38,%esp
  int i;
  uint pcs[10];
  
  cli();
8010056c:	e8 9f fd ff ff       	call   80100310 <cli>
  cons.locking = 0;
80100571:	c7 05 f4 c5 10 80 00 	movl   $0x0,0x8010c5f4
80100578:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
8010057b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80100581:	0f b6 00             	movzbl (%eax),%eax
80100584:	0f b6 c0             	movzbl %al,%eax
80100587:	83 ec 08             	sub    $0x8,%esp
8010058a:	50                   	push   %eax
8010058b:	68 56 8b 10 80       	push   $0x80108b56
80100590:	e8 31 fe ff ff       	call   801003c6 <cprintf>
80100595:	83 c4 10             	add    $0x10,%esp
  cprintf(s);
80100598:	8b 45 08             	mov    0x8(%ebp),%eax
8010059b:	83 ec 0c             	sub    $0xc,%esp
8010059e:	50                   	push   %eax
8010059f:	e8 22 fe ff ff       	call   801003c6 <cprintf>
801005a4:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
801005a7:	83 ec 0c             	sub    $0xc,%esp
801005aa:	68 65 8b 10 80       	push   $0x80108b65
801005af:	e8 12 fe ff ff       	call   801003c6 <cprintf>
801005b4:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
801005b7:	83 ec 08             	sub    $0x8,%esp
801005ba:	8d 45 cc             	lea    -0x34(%ebp),%eax
801005bd:	50                   	push   %eax
801005be:	8d 45 08             	lea    0x8(%ebp),%eax
801005c1:	50                   	push   %eax
801005c2:	e8 3d 50 00 00       	call   80105604 <getcallerpcs>
801005c7:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
801005ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801005d1:	eb 1c                	jmp    801005ef <panic+0x89>
    cprintf(" %p", pcs[i]);
801005d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005d6:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005da:	83 ec 08             	sub    $0x8,%esp
801005dd:	50                   	push   %eax
801005de:	68 67 8b 10 80       	push   $0x80108b67
801005e3:	e8 de fd ff ff       	call   801003c6 <cprintf>
801005e8:	83 c4 10             	add    $0x10,%esp
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801005eb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801005ef:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801005f3:	7e de                	jle    801005d3 <panic+0x6d>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801005f5:	c7 05 a0 c5 10 80 01 	movl   $0x1,0x8010c5a0
801005fc:	00 00 00 
  for(;;)
    ;
801005ff:	eb fe                	jmp    801005ff <panic+0x99>

80100601 <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
80100601:	55                   	push   %ebp
80100602:	89 e5                	mov    %esp,%ebp
80100604:	83 ec 18             	sub    $0x18,%esp
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
80100607:	6a 0e                	push   $0xe
80100609:	68 d4 03 00 00       	push   $0x3d4
8010060e:	e8 de fc ff ff       	call   801002f1 <outb>
80100613:	83 c4 08             	add    $0x8,%esp
  pos = inb(CRTPORT+1) << 8;
80100616:	68 d5 03 00 00       	push   $0x3d5
8010061b:	e8 b4 fc ff ff       	call   801002d4 <inb>
80100620:	83 c4 04             	add    $0x4,%esp
80100623:	0f b6 c0             	movzbl %al,%eax
80100626:	c1 e0 08             	shl    $0x8,%eax
80100629:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
8010062c:	6a 0f                	push   $0xf
8010062e:	68 d4 03 00 00       	push   $0x3d4
80100633:	e8 b9 fc ff ff       	call   801002f1 <outb>
80100638:	83 c4 08             	add    $0x8,%esp
  pos |= inb(CRTPORT+1);
8010063b:	68 d5 03 00 00       	push   $0x3d5
80100640:	e8 8f fc ff ff       	call   801002d4 <inb>
80100645:	83 c4 04             	add    $0x4,%esp
80100648:	0f b6 c0             	movzbl %al,%eax
8010064b:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
8010064e:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
80100652:	75 30                	jne    80100684 <cgaputc+0x83>
    pos += 80 - pos%80;
80100654:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100657:	ba 67 66 66 66       	mov    $0x66666667,%edx
8010065c:	89 c8                	mov    %ecx,%eax
8010065e:	f7 ea                	imul   %edx
80100660:	c1 fa 05             	sar    $0x5,%edx
80100663:	89 c8                	mov    %ecx,%eax
80100665:	c1 f8 1f             	sar    $0x1f,%eax
80100668:	29 c2                	sub    %eax,%edx
8010066a:	89 d0                	mov    %edx,%eax
8010066c:	c1 e0 02             	shl    $0x2,%eax
8010066f:	01 d0                	add    %edx,%eax
80100671:	c1 e0 04             	shl    $0x4,%eax
80100674:	29 c1                	sub    %eax,%ecx
80100676:	89 ca                	mov    %ecx,%edx
80100678:	b8 50 00 00 00       	mov    $0x50,%eax
8010067d:	29 d0                	sub    %edx,%eax
8010067f:	01 45 f4             	add    %eax,-0xc(%ebp)
80100682:	eb 34                	jmp    801006b8 <cgaputc+0xb7>
  else if(c == BACKSPACE){
80100684:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
8010068b:	75 0c                	jne    80100699 <cgaputc+0x98>
    if(pos > 0) --pos;
8010068d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100691:	7e 25                	jle    801006b8 <cgaputc+0xb7>
80100693:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100697:	eb 1f                	jmp    801006b8 <cgaputc+0xb7>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100699:	8b 0d 00 a0 10 80    	mov    0x8010a000,%ecx
8010069f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801006a2:	8d 50 01             	lea    0x1(%eax),%edx
801006a5:	89 55 f4             	mov    %edx,-0xc(%ebp)
801006a8:	01 c0                	add    %eax,%eax
801006aa:	01 c8                	add    %ecx,%eax
801006ac:	8b 55 08             	mov    0x8(%ebp),%edx
801006af:	0f b6 d2             	movzbl %dl,%edx
801006b2:	80 ce 07             	or     $0x7,%dh
801006b5:	66 89 10             	mov    %dx,(%eax)

  if(pos < 0 || pos > 25*80)
801006b8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801006bc:	78 09                	js     801006c7 <cgaputc+0xc6>
801006be:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
801006c5:	7e 0d                	jle    801006d4 <cgaputc+0xd3>
    panic("pos under/overflow");
801006c7:	83 ec 0c             	sub    $0xc,%esp
801006ca:	68 6b 8b 10 80       	push   $0x80108b6b
801006cf:	e8 92 fe ff ff       	call   80100566 <panic>
  
  if((pos/80) >= 24){  // Scroll up.
801006d4:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
801006db:	7e 4c                	jle    80100729 <cgaputc+0x128>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801006dd:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801006e2:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
801006e8:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801006ed:	83 ec 04             	sub    $0x4,%esp
801006f0:	68 60 0e 00 00       	push   $0xe60
801006f5:	52                   	push   %edx
801006f6:	50                   	push   %eax
801006f7:	e8 71 51 00 00       	call   8010586d <memmove>
801006fc:	83 c4 10             	add    $0x10,%esp
    pos -= 80;
801006ff:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100703:	b8 80 07 00 00       	mov    $0x780,%eax
80100708:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010070b:	8d 14 00             	lea    (%eax,%eax,1),%edx
8010070e:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80100713:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100716:	01 c9                	add    %ecx,%ecx
80100718:	01 c8                	add    %ecx,%eax
8010071a:	83 ec 04             	sub    $0x4,%esp
8010071d:	52                   	push   %edx
8010071e:	6a 00                	push   $0x0
80100720:	50                   	push   %eax
80100721:	e8 88 50 00 00       	call   801057ae <memset>
80100726:	83 c4 10             	add    $0x10,%esp
  }
  
  outb(CRTPORT, 14);
80100729:	83 ec 08             	sub    $0x8,%esp
8010072c:	6a 0e                	push   $0xe
8010072e:	68 d4 03 00 00       	push   $0x3d4
80100733:	e8 b9 fb ff ff       	call   801002f1 <outb>
80100738:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos>>8);
8010073b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010073e:	c1 f8 08             	sar    $0x8,%eax
80100741:	0f b6 c0             	movzbl %al,%eax
80100744:	83 ec 08             	sub    $0x8,%esp
80100747:	50                   	push   %eax
80100748:	68 d5 03 00 00       	push   $0x3d5
8010074d:	e8 9f fb ff ff       	call   801002f1 <outb>
80100752:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT, 15);
80100755:	83 ec 08             	sub    $0x8,%esp
80100758:	6a 0f                	push   $0xf
8010075a:	68 d4 03 00 00       	push   $0x3d4
8010075f:	e8 8d fb ff ff       	call   801002f1 <outb>
80100764:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos);
80100767:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010076a:	0f b6 c0             	movzbl %al,%eax
8010076d:	83 ec 08             	sub    $0x8,%esp
80100770:	50                   	push   %eax
80100771:	68 d5 03 00 00       	push   $0x3d5
80100776:	e8 76 fb ff ff       	call   801002f1 <outb>
8010077b:	83 c4 10             	add    $0x10,%esp
  crt[pos] = ' ' | 0x0700;
8010077e:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80100783:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100786:	01 d2                	add    %edx,%edx
80100788:	01 d0                	add    %edx,%eax
8010078a:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
8010078f:	90                   	nop
80100790:	c9                   	leave  
80100791:	c3                   	ret    

80100792 <consputc>:

void
consputc(int c)
{
80100792:	55                   	push   %ebp
80100793:	89 e5                	mov    %esp,%ebp
80100795:	83 ec 08             	sub    $0x8,%esp
  if(panicked){
80100798:	a1 a0 c5 10 80       	mov    0x8010c5a0,%eax
8010079d:	85 c0                	test   %eax,%eax
8010079f:	74 07                	je     801007a8 <consputc+0x16>
    cli();
801007a1:	e8 6a fb ff ff       	call   80100310 <cli>
    for(;;)
      ;
801007a6:	eb fe                	jmp    801007a6 <consputc+0x14>
  }

  if(c == BACKSPACE){
801007a8:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
801007af:	75 29                	jne    801007da <consputc+0x48>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801007b1:	83 ec 0c             	sub    $0xc,%esp
801007b4:	6a 08                	push   $0x8
801007b6:	e8 eb 69 00 00       	call   801071a6 <uartputc>
801007bb:	83 c4 10             	add    $0x10,%esp
801007be:	83 ec 0c             	sub    $0xc,%esp
801007c1:	6a 20                	push   $0x20
801007c3:	e8 de 69 00 00       	call   801071a6 <uartputc>
801007c8:	83 c4 10             	add    $0x10,%esp
801007cb:	83 ec 0c             	sub    $0xc,%esp
801007ce:	6a 08                	push   $0x8
801007d0:	e8 d1 69 00 00       	call   801071a6 <uartputc>
801007d5:	83 c4 10             	add    $0x10,%esp
801007d8:	eb 0e                	jmp    801007e8 <consputc+0x56>
  } else
    uartputc(c);
801007da:	83 ec 0c             	sub    $0xc,%esp
801007dd:	ff 75 08             	pushl  0x8(%ebp)
801007e0:	e8 c1 69 00 00       	call   801071a6 <uartputc>
801007e5:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	ff 75 08             	pushl  0x8(%ebp)
801007ee:	e8 0e fe ff ff       	call   80100601 <cgaputc>
801007f3:	83 c4 10             	add    $0x10,%esp
}
801007f6:	90                   	nop
801007f7:	c9                   	leave  
801007f8:	c3                   	ret    

801007f9 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007f9:	55                   	push   %ebp
801007fa:	89 e5                	mov    %esp,%ebp
801007fc:	83 ec 18             	sub    $0x18,%esp
  int c, doprocdump = 0;
801007ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&cons.lock);
80100806:	83 ec 0c             	sub    $0xc,%esp
80100809:	68 c0 c5 10 80       	push   $0x8010c5c0
8010080e:	e8 38 4d 00 00       	call   8010554b <acquire>
80100813:	83 c4 10             	add    $0x10,%esp
  while((c = getc()) >= 0){
80100816:	e9 44 01 00 00       	jmp    8010095f <consoleintr+0x166>
    switch(c){
8010081b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010081e:	83 f8 10             	cmp    $0x10,%eax
80100821:	74 1e                	je     80100841 <consoleintr+0x48>
80100823:	83 f8 10             	cmp    $0x10,%eax
80100826:	7f 0a                	jg     80100832 <consoleintr+0x39>
80100828:	83 f8 08             	cmp    $0x8,%eax
8010082b:	74 6b                	je     80100898 <consoleintr+0x9f>
8010082d:	e9 9b 00 00 00       	jmp    801008cd <consoleintr+0xd4>
80100832:	83 f8 15             	cmp    $0x15,%eax
80100835:	74 33                	je     8010086a <consoleintr+0x71>
80100837:	83 f8 7f             	cmp    $0x7f,%eax
8010083a:	74 5c                	je     80100898 <consoleintr+0x9f>
8010083c:	e9 8c 00 00 00       	jmp    801008cd <consoleintr+0xd4>
    case C('P'):  // Process listing.
      doprocdump = 1;   // procdump() locks cons.lock indirectly; invoke later
80100841:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      break;
80100848:	e9 12 01 00 00       	jmp    8010095f <consoleintr+0x166>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
8010084d:	a1 08 18 11 80       	mov    0x80111808,%eax
80100852:	83 e8 01             	sub    $0x1,%eax
80100855:	a3 08 18 11 80       	mov    %eax,0x80111808
        consputc(BACKSPACE);
8010085a:	83 ec 0c             	sub    $0xc,%esp
8010085d:	68 00 01 00 00       	push   $0x100
80100862:	e8 2b ff ff ff       	call   80100792 <consputc>
80100867:	83 c4 10             	add    $0x10,%esp
    switch(c){
    case C('P'):  // Process listing.
      doprocdump = 1;   // procdump() locks cons.lock indirectly; invoke later
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010086a:	8b 15 08 18 11 80    	mov    0x80111808,%edx
80100870:	a1 04 18 11 80       	mov    0x80111804,%eax
80100875:	39 c2                	cmp    %eax,%edx
80100877:	0f 84 e2 00 00 00    	je     8010095f <consoleintr+0x166>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
8010087d:	a1 08 18 11 80       	mov    0x80111808,%eax
80100882:	83 e8 01             	sub    $0x1,%eax
80100885:	83 e0 7f             	and    $0x7f,%eax
80100888:	0f b6 80 80 17 11 80 	movzbl -0x7feee880(%eax),%eax
    switch(c){
    case C('P'):  // Process listing.
      doprocdump = 1;   // procdump() locks cons.lock indirectly; invoke later
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010088f:	3c 0a                	cmp    $0xa,%al
80100891:	75 ba                	jne    8010084d <consoleintr+0x54>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
80100893:	e9 c7 00 00 00       	jmp    8010095f <consoleintr+0x166>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100898:	8b 15 08 18 11 80    	mov    0x80111808,%edx
8010089e:	a1 04 18 11 80       	mov    0x80111804,%eax
801008a3:	39 c2                	cmp    %eax,%edx
801008a5:	0f 84 b4 00 00 00    	je     8010095f <consoleintr+0x166>
        input.e--;
801008ab:	a1 08 18 11 80       	mov    0x80111808,%eax
801008b0:	83 e8 01             	sub    $0x1,%eax
801008b3:	a3 08 18 11 80       	mov    %eax,0x80111808
        consputc(BACKSPACE);
801008b8:	83 ec 0c             	sub    $0xc,%esp
801008bb:	68 00 01 00 00       	push   $0x100
801008c0:	e8 cd fe ff ff       	call   80100792 <consputc>
801008c5:	83 c4 10             	add    $0x10,%esp
      }
      break;
801008c8:	e9 92 00 00 00       	jmp    8010095f <consoleintr+0x166>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008cd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801008d1:	0f 84 87 00 00 00    	je     8010095e <consoleintr+0x165>
801008d7:	8b 15 08 18 11 80    	mov    0x80111808,%edx
801008dd:	a1 00 18 11 80       	mov    0x80111800,%eax
801008e2:	29 c2                	sub    %eax,%edx
801008e4:	89 d0                	mov    %edx,%eax
801008e6:	83 f8 7f             	cmp    $0x7f,%eax
801008e9:	77 73                	ja     8010095e <consoleintr+0x165>
        c = (c == '\r') ? '\n' : c;
801008eb:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
801008ef:	74 05                	je     801008f6 <consoleintr+0xfd>
801008f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801008f4:	eb 05                	jmp    801008fb <consoleintr+0x102>
801008f6:	b8 0a 00 00 00       	mov    $0xa,%eax
801008fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
801008fe:	a1 08 18 11 80       	mov    0x80111808,%eax
80100903:	8d 50 01             	lea    0x1(%eax),%edx
80100906:	89 15 08 18 11 80    	mov    %edx,0x80111808
8010090c:	83 e0 7f             	and    $0x7f,%eax
8010090f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100912:	88 90 80 17 11 80    	mov    %dl,-0x7feee880(%eax)
        consputc(c);
80100918:	83 ec 0c             	sub    $0xc,%esp
8010091b:	ff 75 f0             	pushl  -0x10(%ebp)
8010091e:	e8 6f fe ff ff       	call   80100792 <consputc>
80100923:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100926:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
8010092a:	74 18                	je     80100944 <consoleintr+0x14b>
8010092c:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100930:	74 12                	je     80100944 <consoleintr+0x14b>
80100932:	a1 08 18 11 80       	mov    0x80111808,%eax
80100937:	8b 15 00 18 11 80    	mov    0x80111800,%edx
8010093d:	83 ea 80             	sub    $0xffffff80,%edx
80100940:	39 d0                	cmp    %edx,%eax
80100942:	75 1a                	jne    8010095e <consoleintr+0x165>
          input.w = input.e;
80100944:	a1 08 18 11 80       	mov    0x80111808,%eax
80100949:	a3 04 18 11 80       	mov    %eax,0x80111804
          wakeup(&input.r);
8010094e:	83 ec 0c             	sub    $0xc,%esp
80100951:	68 00 18 11 80       	push   $0x80111800
80100956:	e8 ba 45 00 00       	call   80104f15 <wakeup>
8010095b:	83 c4 10             	add    $0x10,%esp
        }
      }
      break;
8010095e:	90                   	nop
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
8010095f:	8b 45 08             	mov    0x8(%ebp),%eax
80100962:	ff d0                	call   *%eax
80100964:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100967:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010096b:	0f 89 aa fe ff ff    	jns    8010081b <consoleintr+0x22>
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100971:	83 ec 0c             	sub    $0xc,%esp
80100974:	68 c0 c5 10 80       	push   $0x8010c5c0
80100979:	e8 34 4c 00 00       	call   801055b2 <release>
8010097e:	83 c4 10             	add    $0x10,%esp
  if(doprocdump) {
80100981:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100985:	74 05                	je     8010098c <consoleintr+0x193>
    procdump();  // now call procdump() wo. cons.lock held
80100987:	e8 47 46 00 00       	call   80104fd3 <procdump>
  }
}
8010098c:	90                   	nop
8010098d:	c9                   	leave  
8010098e:	c3                   	ret    

8010098f <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
8010098f:	55                   	push   %ebp
80100990:	89 e5                	mov    %esp,%ebp
80100992:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
80100995:	83 ec 0c             	sub    $0xc,%esp
80100998:	ff 75 08             	pushl  0x8(%ebp)
8010099b:	e8 28 11 00 00       	call   80101ac8 <iunlock>
801009a0:	83 c4 10             	add    $0x10,%esp
  target = n;
801009a3:	8b 45 10             	mov    0x10(%ebp),%eax
801009a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&cons.lock);
801009a9:	83 ec 0c             	sub    $0xc,%esp
801009ac:	68 c0 c5 10 80       	push   $0x8010c5c0
801009b1:	e8 95 4b 00 00       	call   8010554b <acquire>
801009b6:	83 c4 10             	add    $0x10,%esp
  while(n > 0){
801009b9:	e9 ac 00 00 00       	jmp    80100a6a <consoleread+0xdb>
    while(input.r == input.w){
      if(proc->killed){
801009be:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801009c4:	8b 40 24             	mov    0x24(%eax),%eax
801009c7:	85 c0                	test   %eax,%eax
801009c9:	74 28                	je     801009f3 <consoleread+0x64>
        release(&cons.lock);
801009cb:	83 ec 0c             	sub    $0xc,%esp
801009ce:	68 c0 c5 10 80       	push   $0x8010c5c0
801009d3:	e8 da 4b 00 00       	call   801055b2 <release>
801009d8:	83 c4 10             	add    $0x10,%esp
        ilock(ip);
801009db:	83 ec 0c             	sub    $0xc,%esp
801009de:	ff 75 08             	pushl  0x8(%ebp)
801009e1:	e8 84 0f 00 00       	call   8010196a <ilock>
801009e6:	83 c4 10             	add    $0x10,%esp
        return -1;
801009e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801009ee:	e9 ab 00 00 00       	jmp    80100a9e <consoleread+0x10f>
      }
      sleep(&input.r, &cons.lock);
801009f3:	83 ec 08             	sub    $0x8,%esp
801009f6:	68 c0 c5 10 80       	push   $0x8010c5c0
801009fb:	68 00 18 11 80       	push   $0x80111800
80100a00:	e8 22 44 00 00       	call   80104e27 <sleep>
80100a05:	83 c4 10             	add    $0x10,%esp

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
80100a08:	8b 15 00 18 11 80    	mov    0x80111800,%edx
80100a0e:	a1 04 18 11 80       	mov    0x80111804,%eax
80100a13:	39 c2                	cmp    %eax,%edx
80100a15:	74 a7                	je     801009be <consoleread+0x2f>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100a17:	a1 00 18 11 80       	mov    0x80111800,%eax
80100a1c:	8d 50 01             	lea    0x1(%eax),%edx
80100a1f:	89 15 00 18 11 80    	mov    %edx,0x80111800
80100a25:	83 e0 7f             	and    $0x7f,%eax
80100a28:	0f b6 80 80 17 11 80 	movzbl -0x7feee880(%eax),%eax
80100a2f:	0f be c0             	movsbl %al,%eax
80100a32:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
80100a35:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100a39:	75 17                	jne    80100a52 <consoleread+0xc3>
      if(n < target){
80100a3b:	8b 45 10             	mov    0x10(%ebp),%eax
80100a3e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80100a41:	73 2f                	jae    80100a72 <consoleread+0xe3>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100a43:	a1 00 18 11 80       	mov    0x80111800,%eax
80100a48:	83 e8 01             	sub    $0x1,%eax
80100a4b:	a3 00 18 11 80       	mov    %eax,0x80111800
      }
      break;
80100a50:	eb 20                	jmp    80100a72 <consoleread+0xe3>
    }
    *dst++ = c;
80100a52:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a55:	8d 50 01             	lea    0x1(%eax),%edx
80100a58:	89 55 0c             	mov    %edx,0xc(%ebp)
80100a5b:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100a5e:	88 10                	mov    %dl,(%eax)
    --n;
80100a60:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
80100a64:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100a68:	74 0b                	je     80100a75 <consoleread+0xe6>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100a6a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100a6e:	7f 98                	jg     80100a08 <consoleread+0x79>
80100a70:	eb 04                	jmp    80100a76 <consoleread+0xe7>
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
80100a72:	90                   	nop
80100a73:	eb 01                	jmp    80100a76 <consoleread+0xe7>
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
80100a75:	90                   	nop
  }
  release(&cons.lock);
80100a76:	83 ec 0c             	sub    $0xc,%esp
80100a79:	68 c0 c5 10 80       	push   $0x8010c5c0
80100a7e:	e8 2f 4b 00 00       	call   801055b2 <release>
80100a83:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100a86:	83 ec 0c             	sub    $0xc,%esp
80100a89:	ff 75 08             	pushl  0x8(%ebp)
80100a8c:	e8 d9 0e 00 00       	call   8010196a <ilock>
80100a91:	83 c4 10             	add    $0x10,%esp

  return target - n;
80100a94:	8b 45 10             	mov    0x10(%ebp),%eax
80100a97:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a9a:	29 c2                	sub    %eax,%edx
80100a9c:	89 d0                	mov    %edx,%eax
}
80100a9e:	c9                   	leave  
80100a9f:	c3                   	ret    

80100aa0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100aa0:	55                   	push   %ebp
80100aa1:	89 e5                	mov    %esp,%ebp
80100aa3:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100aa6:	83 ec 0c             	sub    $0xc,%esp
80100aa9:	ff 75 08             	pushl  0x8(%ebp)
80100aac:	e8 17 10 00 00       	call   80101ac8 <iunlock>
80100ab1:	83 c4 10             	add    $0x10,%esp
  acquire(&cons.lock);
80100ab4:	83 ec 0c             	sub    $0xc,%esp
80100ab7:	68 c0 c5 10 80       	push   $0x8010c5c0
80100abc:	e8 8a 4a 00 00       	call   8010554b <acquire>
80100ac1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100ac4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100acb:	eb 21                	jmp    80100aee <consolewrite+0x4e>
    consputc(buf[i] & 0xff);
80100acd:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100ad0:	8b 45 0c             	mov    0xc(%ebp),%eax
80100ad3:	01 d0                	add    %edx,%eax
80100ad5:	0f b6 00             	movzbl (%eax),%eax
80100ad8:	0f be c0             	movsbl %al,%eax
80100adb:	0f b6 c0             	movzbl %al,%eax
80100ade:	83 ec 0c             	sub    $0xc,%esp
80100ae1:	50                   	push   %eax
80100ae2:	e8 ab fc ff ff       	call   80100792 <consputc>
80100ae7:	83 c4 10             	add    $0x10,%esp
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100aea:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100aee:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100af1:	3b 45 10             	cmp    0x10(%ebp),%eax
80100af4:	7c d7                	jl     80100acd <consolewrite+0x2d>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100af6:	83 ec 0c             	sub    $0xc,%esp
80100af9:	68 c0 c5 10 80       	push   $0x8010c5c0
80100afe:	e8 af 4a 00 00       	call   801055b2 <release>
80100b03:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100b06:	83 ec 0c             	sub    $0xc,%esp
80100b09:	ff 75 08             	pushl  0x8(%ebp)
80100b0c:	e8 59 0e 00 00       	call   8010196a <ilock>
80100b11:	83 c4 10             	add    $0x10,%esp

  return n;
80100b14:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100b17:	c9                   	leave  
80100b18:	c3                   	ret    

80100b19 <consoleinit>:

void
consoleinit(void)
{
80100b19:	55                   	push   %ebp
80100b1a:	89 e5                	mov    %esp,%ebp
80100b1c:	83 ec 08             	sub    $0x8,%esp
  initlock(&cons.lock, "console");
80100b1f:	83 ec 08             	sub    $0x8,%esp
80100b22:	68 7e 8b 10 80       	push   $0x80108b7e
80100b27:	68 c0 c5 10 80       	push   $0x8010c5c0
80100b2c:	e8 f8 49 00 00       	call   80105529 <initlock>
80100b31:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
80100b34:	c7 05 cc 21 11 80 a0 	movl   $0x80100aa0,0x801121cc
80100b3b:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100b3e:	c7 05 c8 21 11 80 8f 	movl   $0x8010098f,0x801121c8
80100b45:	09 10 80 
  cons.locking = 1;
80100b48:	c7 05 f4 c5 10 80 01 	movl   $0x1,0x8010c5f4
80100b4f:	00 00 00 

  picenable(IRQ_KBD);
80100b52:	83 ec 0c             	sub    $0xc,%esp
80100b55:	6a 01                	push   $0x1
80100b57:	e8 cf 33 00 00       	call   80103f2b <picenable>
80100b5c:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_KBD, 0);
80100b5f:	83 ec 08             	sub    $0x8,%esp
80100b62:	6a 00                	push   $0x0
80100b64:	6a 01                	push   $0x1
80100b66:	e8 6f 1f 00 00       	call   80102ada <ioapicenable>
80100b6b:	83 c4 10             	add    $0x10,%esp
}
80100b6e:	90                   	nop
80100b6f:	c9                   	leave  
80100b70:	c3                   	ret    

80100b71 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100b71:	55                   	push   %ebp
80100b72:	89 e5                	mov    %esp,%ebp
80100b74:	81 ec 18 01 00 00    	sub    $0x118,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
80100b7a:	e8 ce 29 00 00       	call   8010354d <begin_op>
  if((ip = namei(path)) == 0){
80100b7f:	83 ec 0c             	sub    $0xc,%esp
80100b82:	ff 75 08             	pushl  0x8(%ebp)
80100b85:	e8 9e 19 00 00       	call   80102528 <namei>
80100b8a:	83 c4 10             	add    $0x10,%esp
80100b8d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100b90:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100b94:	75 0f                	jne    80100ba5 <exec+0x34>
    end_op();
80100b96:	e8 3e 2a 00 00       	call   801035d9 <end_op>
    return -1;
80100b9b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ba0:	e9 ce 03 00 00       	jmp    80100f73 <exec+0x402>
  }
  ilock(ip);
80100ba5:	83 ec 0c             	sub    $0xc,%esp
80100ba8:	ff 75 d8             	pushl  -0x28(%ebp)
80100bab:	e8 ba 0d 00 00       	call   8010196a <ilock>
80100bb0:	83 c4 10             	add    $0x10,%esp
  pgdir = 0;
80100bb3:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100bba:	6a 34                	push   $0x34
80100bbc:	6a 00                	push   $0x0
80100bbe:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80100bc4:	50                   	push   %eax
80100bc5:	ff 75 d8             	pushl  -0x28(%ebp)
80100bc8:	e8 0b 13 00 00       	call   80101ed8 <readi>
80100bcd:	83 c4 10             	add    $0x10,%esp
80100bd0:	83 f8 33             	cmp    $0x33,%eax
80100bd3:	0f 86 49 03 00 00    	jbe    80100f22 <exec+0x3b1>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100bd9:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bdf:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100be4:	0f 85 3b 03 00 00    	jne    80100f25 <exec+0x3b4>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100bea:	e8 0c 77 00 00       	call   801082fb <setupkvm>
80100bef:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100bf2:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100bf6:	0f 84 2c 03 00 00    	je     80100f28 <exec+0x3b7>
    goto bad;

  // Load program into memory.
  sz = 0;
80100bfc:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c03:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100c0a:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
80100c10:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100c13:	e9 ab 00 00 00       	jmp    80100cc3 <exec+0x152>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100c18:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100c1b:	6a 20                	push   $0x20
80100c1d:	50                   	push   %eax
80100c1e:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80100c24:	50                   	push   %eax
80100c25:	ff 75 d8             	pushl  -0x28(%ebp)
80100c28:	e8 ab 12 00 00       	call   80101ed8 <readi>
80100c2d:	83 c4 10             	add    $0x10,%esp
80100c30:	83 f8 20             	cmp    $0x20,%eax
80100c33:	0f 85 f2 02 00 00    	jne    80100f2b <exec+0x3ba>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100c39:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100c3f:	83 f8 01             	cmp    $0x1,%eax
80100c42:	75 71                	jne    80100cb5 <exec+0x144>
      continue;
    if(ph.memsz < ph.filesz)
80100c44:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80100c4a:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100c50:	39 c2                	cmp    %eax,%edx
80100c52:	0f 82 d6 02 00 00    	jb     80100f2e <exec+0x3bd>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100c58:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100c5e:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100c64:	01 d0                	add    %edx,%eax
80100c66:	83 ec 04             	sub    $0x4,%esp
80100c69:	50                   	push   %eax
80100c6a:	ff 75 e0             	pushl  -0x20(%ebp)
80100c6d:	ff 75 d4             	pushl  -0x2c(%ebp)
80100c70:	e8 2d 7a 00 00       	call   801086a2 <allocuvm>
80100c75:	83 c4 10             	add    $0x10,%esp
80100c78:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100c7b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100c7f:	0f 84 ac 02 00 00    	je     80100f31 <exec+0x3c0>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c85:	8b 95 fc fe ff ff    	mov    -0x104(%ebp),%edx
80100c8b:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c91:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100c97:	83 ec 0c             	sub    $0xc,%esp
80100c9a:	52                   	push   %edx
80100c9b:	50                   	push   %eax
80100c9c:	ff 75 d8             	pushl  -0x28(%ebp)
80100c9f:	51                   	push   %ecx
80100ca0:	ff 75 d4             	pushl  -0x2c(%ebp)
80100ca3:	e8 23 79 00 00       	call   801085cb <loaduvm>
80100ca8:	83 c4 20             	add    $0x20,%esp
80100cab:	85 c0                	test   %eax,%eax
80100cad:	0f 88 81 02 00 00    	js     80100f34 <exec+0x3c3>
80100cb3:	eb 01                	jmp    80100cb6 <exec+0x145>
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
      continue;
80100cb5:	90                   	nop
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100cb6:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100cba:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100cbd:	83 c0 20             	add    $0x20,%eax
80100cc0:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100cc3:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80100cca:	0f b7 c0             	movzwl %ax,%eax
80100ccd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80100cd0:	0f 8f 42 ff ff ff    	jg     80100c18 <exec+0xa7>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100cd6:	83 ec 0c             	sub    $0xc,%esp
80100cd9:	ff 75 d8             	pushl  -0x28(%ebp)
80100cdc:	e8 49 0f 00 00       	call   80101c2a <iunlockput>
80100ce1:	83 c4 10             	add    $0x10,%esp
  end_op();
80100ce4:	e8 f0 28 00 00       	call   801035d9 <end_op>
  ip = 0;
80100ce9:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100cf0:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cf3:	05 ff 0f 00 00       	add    $0xfff,%eax
80100cf8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100cfd:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d00:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d03:	05 00 20 00 00       	add    $0x2000,%eax
80100d08:	83 ec 04             	sub    $0x4,%esp
80100d0b:	50                   	push   %eax
80100d0c:	ff 75 e0             	pushl  -0x20(%ebp)
80100d0f:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d12:	e8 8b 79 00 00       	call   801086a2 <allocuvm>
80100d17:	83 c4 10             	add    $0x10,%esp
80100d1a:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100d1d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100d21:	0f 84 10 02 00 00    	je     80100f37 <exec+0x3c6>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d27:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d2a:	2d 00 20 00 00       	sub    $0x2000,%eax
80100d2f:	83 ec 08             	sub    $0x8,%esp
80100d32:	50                   	push   %eax
80100d33:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d36:	e8 8d 7b 00 00       	call   801088c8 <clearpteu>
80100d3b:	83 c4 10             	add    $0x10,%esp
  sp = sz;
80100d3e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d41:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d44:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100d4b:	e9 96 00 00 00       	jmp    80100de6 <exec+0x275>
    if(argc >= MAXARG)
80100d50:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80100d54:	0f 87 e0 01 00 00    	ja     80100f3a <exec+0x3c9>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d5a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d5d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d64:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d67:	01 d0                	add    %edx,%eax
80100d69:	8b 00                	mov    (%eax),%eax
80100d6b:	83 ec 0c             	sub    $0xc,%esp
80100d6e:	50                   	push   %eax
80100d6f:	e8 87 4c 00 00       	call   801059fb <strlen>
80100d74:	83 c4 10             	add    $0x10,%esp
80100d77:	89 c2                	mov    %eax,%edx
80100d79:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100d7c:	29 d0                	sub    %edx,%eax
80100d7e:	83 e8 01             	sub    $0x1,%eax
80100d81:	83 e0 fc             	and    $0xfffffffc,%eax
80100d84:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d87:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d8a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d91:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d94:	01 d0                	add    %edx,%eax
80100d96:	8b 00                	mov    (%eax),%eax
80100d98:	83 ec 0c             	sub    $0xc,%esp
80100d9b:	50                   	push   %eax
80100d9c:	e8 5a 4c 00 00       	call   801059fb <strlen>
80100da1:	83 c4 10             	add    $0x10,%esp
80100da4:	83 c0 01             	add    $0x1,%eax
80100da7:	89 c1                	mov    %eax,%ecx
80100da9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dac:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100db3:	8b 45 0c             	mov    0xc(%ebp),%eax
80100db6:	01 d0                	add    %edx,%eax
80100db8:	8b 00                	mov    (%eax),%eax
80100dba:	51                   	push   %ecx
80100dbb:	50                   	push   %eax
80100dbc:	ff 75 dc             	pushl  -0x24(%ebp)
80100dbf:	ff 75 d4             	pushl  -0x2c(%ebp)
80100dc2:	e8 b8 7c 00 00       	call   80108a7f <copyout>
80100dc7:	83 c4 10             	add    $0x10,%esp
80100dca:	85 c0                	test   %eax,%eax
80100dcc:	0f 88 6b 01 00 00    	js     80100f3d <exec+0x3cc>
      goto bad;
    ustack[3+argc] = sp;
80100dd2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dd5:	8d 50 03             	lea    0x3(%eax),%edx
80100dd8:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100ddb:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100de2:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80100de6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100de9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100df0:	8b 45 0c             	mov    0xc(%ebp),%eax
80100df3:	01 d0                	add    %edx,%eax
80100df5:	8b 00                	mov    (%eax),%eax
80100df7:	85 c0                	test   %eax,%eax
80100df9:	0f 85 51 ff ff ff    	jne    80100d50 <exec+0x1df>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100dff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e02:	83 c0 03             	add    $0x3,%eax
80100e05:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80100e0c:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100e10:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
80100e17:	ff ff ff 
  ustack[1] = argc;
80100e1a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e1d:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e23:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e26:	83 c0 01             	add    $0x1,%eax
80100e29:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e30:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e33:	29 d0                	sub    %edx,%eax
80100e35:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
80100e3b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e3e:	83 c0 04             	add    $0x4,%eax
80100e41:	c1 e0 02             	shl    $0x2,%eax
80100e44:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e47:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e4a:	83 c0 04             	add    $0x4,%eax
80100e4d:	c1 e0 02             	shl    $0x2,%eax
80100e50:	50                   	push   %eax
80100e51:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
80100e57:	50                   	push   %eax
80100e58:	ff 75 dc             	pushl  -0x24(%ebp)
80100e5b:	ff 75 d4             	pushl  -0x2c(%ebp)
80100e5e:	e8 1c 7c 00 00       	call   80108a7f <copyout>
80100e63:	83 c4 10             	add    $0x10,%esp
80100e66:	85 c0                	test   %eax,%eax
80100e68:	0f 88 d2 00 00 00    	js     80100f40 <exec+0x3cf>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e6e:	8b 45 08             	mov    0x8(%ebp),%eax
80100e71:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100e74:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e77:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100e7a:	eb 17                	jmp    80100e93 <exec+0x322>
    if(*s == '/')
80100e7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e7f:	0f b6 00             	movzbl (%eax),%eax
80100e82:	3c 2f                	cmp    $0x2f,%al
80100e84:	75 09                	jne    80100e8f <exec+0x31e>
      last = s+1;
80100e86:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e89:	83 c0 01             	add    $0x1,%eax
80100e8c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e8f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100e93:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e96:	0f b6 00             	movzbl (%eax),%eax
80100e99:	84 c0                	test   %al,%al
80100e9b:	75 df                	jne    80100e7c <exec+0x30b>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100e9d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ea3:	83 c0 6c             	add    $0x6c,%eax
80100ea6:	83 ec 04             	sub    $0x4,%esp
80100ea9:	6a 10                	push   $0x10
80100eab:	ff 75 f0             	pushl  -0x10(%ebp)
80100eae:	50                   	push   %eax
80100eaf:	e8 fd 4a 00 00       	call   801059b1 <safestrcpy>
80100eb4:	83 c4 10             	add    $0x10,%esp

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100eb7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ebd:	8b 40 04             	mov    0x4(%eax),%eax
80100ec0:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
80100ec3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ec9:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100ecc:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80100ecf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ed5:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100ed8:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80100eda:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ee0:	8b 40 18             	mov    0x18(%eax),%eax
80100ee3:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80100ee9:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80100eec:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ef2:	8b 40 18             	mov    0x18(%eax),%eax
80100ef5:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100ef8:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
80100efb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f01:	83 ec 0c             	sub    $0xc,%esp
80100f04:	50                   	push   %eax
80100f05:	e8 d8 74 00 00       	call   801083e2 <switchuvm>
80100f0a:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80100f0d:	83 ec 0c             	sub    $0xc,%esp
80100f10:	ff 75 d0             	pushl  -0x30(%ebp)
80100f13:	e8 10 79 00 00       	call   80108828 <freevm>
80100f18:	83 c4 10             	add    $0x10,%esp
  return 0;
80100f1b:	b8 00 00 00 00       	mov    $0x0,%eax
80100f20:	eb 51                	jmp    80100f73 <exec+0x402>
  ilock(ip);
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
80100f22:	90                   	nop
80100f23:	eb 1c                	jmp    80100f41 <exec+0x3d0>
  if(elf.magic != ELF_MAGIC)
    goto bad;
80100f25:	90                   	nop
80100f26:	eb 19                	jmp    80100f41 <exec+0x3d0>

  if((pgdir = setupkvm()) == 0)
    goto bad;
80100f28:	90                   	nop
80100f29:	eb 16                	jmp    80100f41 <exec+0x3d0>

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
80100f2b:	90                   	nop
80100f2c:	eb 13                	jmp    80100f41 <exec+0x3d0>
    if(ph.type != ELF_PROG_LOAD)
      continue;
    if(ph.memsz < ph.filesz)
      goto bad;
80100f2e:	90                   	nop
80100f2f:	eb 10                	jmp    80100f41 <exec+0x3d0>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
80100f31:	90                   	nop
80100f32:	eb 0d                	jmp    80100f41 <exec+0x3d0>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
80100f34:	90                   	nop
80100f35:	eb 0a                	jmp    80100f41 <exec+0x3d0>

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
80100f37:	90                   	nop
80100f38:	eb 07                	jmp    80100f41 <exec+0x3d0>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
80100f3a:	90                   	nop
80100f3b:	eb 04                	jmp    80100f41 <exec+0x3d0>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
80100f3d:	90                   	nop
80100f3e:	eb 01                	jmp    80100f41 <exec+0x3d0>
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;
80100f40:	90                   	nop
  switchuvm(proc);
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
80100f41:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100f45:	74 0e                	je     80100f55 <exec+0x3e4>
    freevm(pgdir);
80100f47:	83 ec 0c             	sub    $0xc,%esp
80100f4a:	ff 75 d4             	pushl  -0x2c(%ebp)
80100f4d:	e8 d6 78 00 00       	call   80108828 <freevm>
80100f52:	83 c4 10             	add    $0x10,%esp
  if(ip){
80100f55:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100f59:	74 13                	je     80100f6e <exec+0x3fd>
    iunlockput(ip);
80100f5b:	83 ec 0c             	sub    $0xc,%esp
80100f5e:	ff 75 d8             	pushl  -0x28(%ebp)
80100f61:	e8 c4 0c 00 00       	call   80101c2a <iunlockput>
80100f66:	83 c4 10             	add    $0x10,%esp
    end_op();
80100f69:	e8 6b 26 00 00       	call   801035d9 <end_op>
  }
  return -1;
80100f6e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f73:	c9                   	leave  
80100f74:	c3                   	ret    

80100f75 <fileinit>:
80100f75:	55                   	push   %ebp
80100f76:	89 e5                	mov    %esp,%ebp
80100f78:	83 ec 08             	sub    $0x8,%esp
80100f7b:	83 ec 08             	sub    $0x8,%esp
80100f7e:	68 86 8b 10 80       	push   $0x80108b86
80100f83:	68 20 18 11 80       	push   $0x80111820
80100f88:	e8 9c 45 00 00       	call   80105529 <initlock>
80100f8d:	83 c4 10             	add    $0x10,%esp
80100f90:	90                   	nop
80100f91:	c9                   	leave  
80100f92:	c3                   	ret    

80100f93 <filealloc>:
80100f93:	55                   	push   %ebp
80100f94:	89 e5                	mov    %esp,%ebp
80100f96:	83 ec 18             	sub    $0x18,%esp
80100f99:	83 ec 0c             	sub    $0xc,%esp
80100f9c:	68 20 18 11 80       	push   $0x80111820
80100fa1:	e8 a5 45 00 00       	call   8010554b <acquire>
80100fa6:	83 c4 10             	add    $0x10,%esp
80100fa9:	c7 45 f4 54 18 11 80 	movl   $0x80111854,-0xc(%ebp)
80100fb0:	eb 2d                	jmp    80100fdf <filealloc+0x4c>
80100fb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100fb5:	8b 40 04             	mov    0x4(%eax),%eax
80100fb8:	85 c0                	test   %eax,%eax
80100fba:	75 1f                	jne    80100fdb <filealloc+0x48>
80100fbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100fbf:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
80100fc6:	83 ec 0c             	sub    $0xc,%esp
80100fc9:	68 20 18 11 80       	push   $0x80111820
80100fce:	e8 df 45 00 00       	call   801055b2 <release>
80100fd3:	83 c4 10             	add    $0x10,%esp
80100fd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100fd9:	eb 23                	jmp    80100ffe <filealloc+0x6b>
80100fdb:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80100fdf:	b8 b4 21 11 80       	mov    $0x801121b4,%eax
80100fe4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80100fe7:	72 c9                	jb     80100fb2 <filealloc+0x1f>
80100fe9:	83 ec 0c             	sub    $0xc,%esp
80100fec:	68 20 18 11 80       	push   $0x80111820
80100ff1:	e8 bc 45 00 00       	call   801055b2 <release>
80100ff6:	83 c4 10             	add    $0x10,%esp
80100ff9:	b8 00 00 00 00       	mov    $0x0,%eax
80100ffe:	c9                   	leave  
80100fff:	c3                   	ret    

80101000 <filedup>:
80101000:	55                   	push   %ebp
80101001:	89 e5                	mov    %esp,%ebp
80101003:	83 ec 08             	sub    $0x8,%esp
80101006:	83 ec 0c             	sub    $0xc,%esp
80101009:	68 20 18 11 80       	push   $0x80111820
8010100e:	e8 38 45 00 00       	call   8010554b <acquire>
80101013:	83 c4 10             	add    $0x10,%esp
80101016:	8b 45 08             	mov    0x8(%ebp),%eax
80101019:	8b 40 04             	mov    0x4(%eax),%eax
8010101c:	85 c0                	test   %eax,%eax
8010101e:	7f 0d                	jg     8010102d <filedup+0x2d>
80101020:	83 ec 0c             	sub    $0xc,%esp
80101023:	68 8d 8b 10 80       	push   $0x80108b8d
80101028:	e8 39 f5 ff ff       	call   80100566 <panic>
8010102d:	8b 45 08             	mov    0x8(%ebp),%eax
80101030:	8b 40 04             	mov    0x4(%eax),%eax
80101033:	8d 50 01             	lea    0x1(%eax),%edx
80101036:	8b 45 08             	mov    0x8(%ebp),%eax
80101039:	89 50 04             	mov    %edx,0x4(%eax)
8010103c:	83 ec 0c             	sub    $0xc,%esp
8010103f:	68 20 18 11 80       	push   $0x80111820
80101044:	e8 69 45 00 00       	call   801055b2 <release>
80101049:	83 c4 10             	add    $0x10,%esp
8010104c:	8b 45 08             	mov    0x8(%ebp),%eax
8010104f:	c9                   	leave  
80101050:	c3                   	ret    

80101051 <fileclose>:
80101051:	55                   	push   %ebp
80101052:	89 e5                	mov    %esp,%ebp
80101054:	83 ec 28             	sub    $0x28,%esp
80101057:	83 ec 0c             	sub    $0xc,%esp
8010105a:	68 20 18 11 80       	push   $0x80111820
8010105f:	e8 e7 44 00 00       	call   8010554b <acquire>
80101064:	83 c4 10             	add    $0x10,%esp
80101067:	8b 45 08             	mov    0x8(%ebp),%eax
8010106a:	8b 40 04             	mov    0x4(%eax),%eax
8010106d:	85 c0                	test   %eax,%eax
8010106f:	7f 0d                	jg     8010107e <fileclose+0x2d>
80101071:	83 ec 0c             	sub    $0xc,%esp
80101074:	68 95 8b 10 80       	push   $0x80108b95
80101079:	e8 e8 f4 ff ff       	call   80100566 <panic>
8010107e:	8b 45 08             	mov    0x8(%ebp),%eax
80101081:	8b 40 04             	mov    0x4(%eax),%eax
80101084:	8d 50 ff             	lea    -0x1(%eax),%edx
80101087:	8b 45 08             	mov    0x8(%ebp),%eax
8010108a:	89 50 04             	mov    %edx,0x4(%eax)
8010108d:	8b 45 08             	mov    0x8(%ebp),%eax
80101090:	8b 40 04             	mov    0x4(%eax),%eax
80101093:	85 c0                	test   %eax,%eax
80101095:	7e 15                	jle    801010ac <fileclose+0x5b>
80101097:	83 ec 0c             	sub    $0xc,%esp
8010109a:	68 20 18 11 80       	push   $0x80111820
8010109f:	e8 0e 45 00 00       	call   801055b2 <release>
801010a4:	83 c4 10             	add    $0x10,%esp
801010a7:	e9 8b 00 00 00       	jmp    80101137 <fileclose+0xe6>
801010ac:	8b 45 08             	mov    0x8(%ebp),%eax
801010af:	8b 10                	mov    (%eax),%edx
801010b1:	89 55 e0             	mov    %edx,-0x20(%ebp)
801010b4:	8b 50 04             	mov    0x4(%eax),%edx
801010b7:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801010ba:	8b 50 08             	mov    0x8(%eax),%edx
801010bd:	89 55 e8             	mov    %edx,-0x18(%ebp)
801010c0:	8b 50 0c             	mov    0xc(%eax),%edx
801010c3:	89 55 ec             	mov    %edx,-0x14(%ebp)
801010c6:	8b 50 10             	mov    0x10(%eax),%edx
801010c9:	89 55 f0             	mov    %edx,-0x10(%ebp)
801010cc:	8b 40 14             	mov    0x14(%eax),%eax
801010cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
801010d2:	8b 45 08             	mov    0x8(%ebp),%eax
801010d5:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
801010dc:	8b 45 08             	mov    0x8(%ebp),%eax
801010df:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801010e5:	83 ec 0c             	sub    $0xc,%esp
801010e8:	68 20 18 11 80       	push   $0x80111820
801010ed:	e8 c0 44 00 00       	call   801055b2 <release>
801010f2:	83 c4 10             	add    $0x10,%esp
801010f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010f8:	83 f8 01             	cmp    $0x1,%eax
801010fb:	75 19                	jne    80101116 <fileclose+0xc5>
801010fd:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
80101101:	0f be d0             	movsbl %al,%edx
80101104:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101107:	83 ec 08             	sub    $0x8,%esp
8010110a:	52                   	push   %edx
8010110b:	50                   	push   %eax
8010110c:	e8 83 30 00 00       	call   80104194 <pipeclose>
80101111:	83 c4 10             	add    $0x10,%esp
80101114:	eb 21                	jmp    80101137 <fileclose+0xe6>
80101116:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101119:	83 f8 02             	cmp    $0x2,%eax
8010111c:	75 19                	jne    80101137 <fileclose+0xe6>
8010111e:	e8 2a 24 00 00       	call   8010354d <begin_op>
80101123:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101126:	83 ec 0c             	sub    $0xc,%esp
80101129:	50                   	push   %eax
8010112a:	e8 0b 0a 00 00       	call   80101b3a <iput>
8010112f:	83 c4 10             	add    $0x10,%esp
80101132:	e8 a2 24 00 00       	call   801035d9 <end_op>
80101137:	c9                   	leave  
80101138:	c3                   	ret    

80101139 <filestat>:
80101139:	55                   	push   %ebp
8010113a:	89 e5                	mov    %esp,%ebp
8010113c:	83 ec 08             	sub    $0x8,%esp
8010113f:	8b 45 08             	mov    0x8(%ebp),%eax
80101142:	8b 00                	mov    (%eax),%eax
80101144:	83 f8 02             	cmp    $0x2,%eax
80101147:	75 40                	jne    80101189 <filestat+0x50>
80101149:	8b 45 08             	mov    0x8(%ebp),%eax
8010114c:	8b 40 10             	mov    0x10(%eax),%eax
8010114f:	83 ec 0c             	sub    $0xc,%esp
80101152:	50                   	push   %eax
80101153:	e8 12 08 00 00       	call   8010196a <ilock>
80101158:	83 c4 10             	add    $0x10,%esp
8010115b:	8b 45 08             	mov    0x8(%ebp),%eax
8010115e:	8b 40 10             	mov    0x10(%eax),%eax
80101161:	83 ec 08             	sub    $0x8,%esp
80101164:	ff 75 0c             	pushl  0xc(%ebp)
80101167:	50                   	push   %eax
80101168:	e8 25 0d 00 00       	call   80101e92 <stati>
8010116d:	83 c4 10             	add    $0x10,%esp
80101170:	8b 45 08             	mov    0x8(%ebp),%eax
80101173:	8b 40 10             	mov    0x10(%eax),%eax
80101176:	83 ec 0c             	sub    $0xc,%esp
80101179:	50                   	push   %eax
8010117a:	e8 49 09 00 00       	call   80101ac8 <iunlock>
8010117f:	83 c4 10             	add    $0x10,%esp
80101182:	b8 00 00 00 00       	mov    $0x0,%eax
80101187:	eb 05                	jmp    8010118e <filestat+0x55>
80101189:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010118e:	c9                   	leave  
8010118f:	c3                   	ret    

80101190 <fileread>:
80101190:	55                   	push   %ebp
80101191:	89 e5                	mov    %esp,%ebp
80101193:	83 ec 18             	sub    $0x18,%esp
80101196:	8b 45 08             	mov    0x8(%ebp),%eax
80101199:	0f b6 40 08          	movzbl 0x8(%eax),%eax
8010119d:	84 c0                	test   %al,%al
8010119f:	75 0a                	jne    801011ab <fileread+0x1b>
801011a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801011a6:	e9 9b 00 00 00       	jmp    80101246 <fileread+0xb6>
801011ab:	8b 45 08             	mov    0x8(%ebp),%eax
801011ae:	8b 00                	mov    (%eax),%eax
801011b0:	83 f8 01             	cmp    $0x1,%eax
801011b3:	75 1a                	jne    801011cf <fileread+0x3f>
801011b5:	8b 45 08             	mov    0x8(%ebp),%eax
801011b8:	8b 40 0c             	mov    0xc(%eax),%eax
801011bb:	83 ec 04             	sub    $0x4,%esp
801011be:	ff 75 10             	pushl  0x10(%ebp)
801011c1:	ff 75 0c             	pushl  0xc(%ebp)
801011c4:	50                   	push   %eax
801011c5:	e8 72 31 00 00       	call   8010433c <piperead>
801011ca:	83 c4 10             	add    $0x10,%esp
801011cd:	eb 77                	jmp    80101246 <fileread+0xb6>
801011cf:	8b 45 08             	mov    0x8(%ebp),%eax
801011d2:	8b 00                	mov    (%eax),%eax
801011d4:	83 f8 02             	cmp    $0x2,%eax
801011d7:	75 60                	jne    80101239 <fileread+0xa9>
801011d9:	8b 45 08             	mov    0x8(%ebp),%eax
801011dc:	8b 40 10             	mov    0x10(%eax),%eax
801011df:	83 ec 0c             	sub    $0xc,%esp
801011e2:	50                   	push   %eax
801011e3:	e8 82 07 00 00       	call   8010196a <ilock>
801011e8:	83 c4 10             	add    $0x10,%esp
801011eb:	8b 4d 10             	mov    0x10(%ebp),%ecx
801011ee:	8b 45 08             	mov    0x8(%ebp),%eax
801011f1:	8b 50 14             	mov    0x14(%eax),%edx
801011f4:	8b 45 08             	mov    0x8(%ebp),%eax
801011f7:	8b 40 10             	mov    0x10(%eax),%eax
801011fa:	51                   	push   %ecx
801011fb:	52                   	push   %edx
801011fc:	ff 75 0c             	pushl  0xc(%ebp)
801011ff:	50                   	push   %eax
80101200:	e8 d3 0c 00 00       	call   80101ed8 <readi>
80101205:	83 c4 10             	add    $0x10,%esp
80101208:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010120b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010120f:	7e 11                	jle    80101222 <fileread+0x92>
80101211:	8b 45 08             	mov    0x8(%ebp),%eax
80101214:	8b 50 14             	mov    0x14(%eax),%edx
80101217:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010121a:	01 c2                	add    %eax,%edx
8010121c:	8b 45 08             	mov    0x8(%ebp),%eax
8010121f:	89 50 14             	mov    %edx,0x14(%eax)
80101222:	8b 45 08             	mov    0x8(%ebp),%eax
80101225:	8b 40 10             	mov    0x10(%eax),%eax
80101228:	83 ec 0c             	sub    $0xc,%esp
8010122b:	50                   	push   %eax
8010122c:	e8 97 08 00 00       	call   80101ac8 <iunlock>
80101231:	83 c4 10             	add    $0x10,%esp
80101234:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101237:	eb 0d                	jmp    80101246 <fileread+0xb6>
80101239:	83 ec 0c             	sub    $0xc,%esp
8010123c:	68 9f 8b 10 80       	push   $0x80108b9f
80101241:	e8 20 f3 ff ff       	call   80100566 <panic>
80101246:	c9                   	leave  
80101247:	c3                   	ret    

80101248 <filewrite>:
80101248:	55                   	push   %ebp
80101249:	89 e5                	mov    %esp,%ebp
8010124b:	53                   	push   %ebx
8010124c:	83 ec 14             	sub    $0x14,%esp
8010124f:	8b 45 08             	mov    0x8(%ebp),%eax
80101252:	0f b6 40 09          	movzbl 0x9(%eax),%eax
80101256:	84 c0                	test   %al,%al
80101258:	75 0a                	jne    80101264 <filewrite+0x1c>
8010125a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010125f:	e9 1b 01 00 00       	jmp    8010137f <filewrite+0x137>
80101264:	8b 45 08             	mov    0x8(%ebp),%eax
80101267:	8b 00                	mov    (%eax),%eax
80101269:	83 f8 01             	cmp    $0x1,%eax
8010126c:	75 1d                	jne    8010128b <filewrite+0x43>
8010126e:	8b 45 08             	mov    0x8(%ebp),%eax
80101271:	8b 40 0c             	mov    0xc(%eax),%eax
80101274:	83 ec 04             	sub    $0x4,%esp
80101277:	ff 75 10             	pushl  0x10(%ebp)
8010127a:	ff 75 0c             	pushl  0xc(%ebp)
8010127d:	50                   	push   %eax
8010127e:	e8 bb 2f 00 00       	call   8010423e <pipewrite>
80101283:	83 c4 10             	add    $0x10,%esp
80101286:	e9 f4 00 00 00       	jmp    8010137f <filewrite+0x137>
8010128b:	8b 45 08             	mov    0x8(%ebp),%eax
8010128e:	8b 00                	mov    (%eax),%eax
80101290:	83 f8 02             	cmp    $0x2,%eax
80101293:	0f 85 d9 00 00 00    	jne    80101372 <filewrite+0x12a>
80101299:	c7 45 ec 00 1a 00 00 	movl   $0x1a00,-0x14(%ebp)
801012a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801012a7:	e9 a3 00 00 00       	jmp    8010134f <filewrite+0x107>
801012ac:	8b 45 10             	mov    0x10(%ebp),%eax
801012af:	2b 45 f4             	sub    -0xc(%ebp),%eax
801012b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
801012b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801012b8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801012bb:	7e 06                	jle    801012c3 <filewrite+0x7b>
801012bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
801012c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
801012c3:	e8 85 22 00 00       	call   8010354d <begin_op>
801012c8:	8b 45 08             	mov    0x8(%ebp),%eax
801012cb:	8b 40 10             	mov    0x10(%eax),%eax
801012ce:	83 ec 0c             	sub    $0xc,%esp
801012d1:	50                   	push   %eax
801012d2:	e8 93 06 00 00       	call   8010196a <ilock>
801012d7:	83 c4 10             	add    $0x10,%esp
801012da:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801012dd:	8b 45 08             	mov    0x8(%ebp),%eax
801012e0:	8b 50 14             	mov    0x14(%eax),%edx
801012e3:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801012e6:	8b 45 0c             	mov    0xc(%ebp),%eax
801012e9:	01 c3                	add    %eax,%ebx
801012eb:	8b 45 08             	mov    0x8(%ebp),%eax
801012ee:	8b 40 10             	mov    0x10(%eax),%eax
801012f1:	51                   	push   %ecx
801012f2:	52                   	push   %edx
801012f3:	53                   	push   %ebx
801012f4:	50                   	push   %eax
801012f5:	e8 35 0d 00 00       	call   8010202f <writei>
801012fa:	83 c4 10             	add    $0x10,%esp
801012fd:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101300:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101304:	7e 11                	jle    80101317 <filewrite+0xcf>
80101306:	8b 45 08             	mov    0x8(%ebp),%eax
80101309:	8b 50 14             	mov    0x14(%eax),%edx
8010130c:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010130f:	01 c2                	add    %eax,%edx
80101311:	8b 45 08             	mov    0x8(%ebp),%eax
80101314:	89 50 14             	mov    %edx,0x14(%eax)
80101317:	8b 45 08             	mov    0x8(%ebp),%eax
8010131a:	8b 40 10             	mov    0x10(%eax),%eax
8010131d:	83 ec 0c             	sub    $0xc,%esp
80101320:	50                   	push   %eax
80101321:	e8 a2 07 00 00       	call   80101ac8 <iunlock>
80101326:	83 c4 10             	add    $0x10,%esp
80101329:	e8 ab 22 00 00       	call   801035d9 <end_op>
8010132e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101332:	78 29                	js     8010135d <filewrite+0x115>
80101334:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101337:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010133a:	74 0d                	je     80101349 <filewrite+0x101>
8010133c:	83 ec 0c             	sub    $0xc,%esp
8010133f:	68 a8 8b 10 80       	push   $0x80108ba8
80101344:	e8 1d f2 ff ff       	call   80100566 <panic>
80101349:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010134c:	01 45 f4             	add    %eax,-0xc(%ebp)
8010134f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101352:	3b 45 10             	cmp    0x10(%ebp),%eax
80101355:	0f 8c 51 ff ff ff    	jl     801012ac <filewrite+0x64>
8010135b:	eb 01                	jmp    8010135e <filewrite+0x116>
8010135d:	90                   	nop
8010135e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101361:	3b 45 10             	cmp    0x10(%ebp),%eax
80101364:	75 05                	jne    8010136b <filewrite+0x123>
80101366:	8b 45 10             	mov    0x10(%ebp),%eax
80101369:	eb 14                	jmp    8010137f <filewrite+0x137>
8010136b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101370:	eb 0d                	jmp    8010137f <filewrite+0x137>
80101372:	83 ec 0c             	sub    $0xc,%esp
80101375:	68 b8 8b 10 80       	push   $0x80108bb8
8010137a:	e8 e7 f1 ff ff       	call   80100566 <panic>
8010137f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101382:	c9                   	leave  
80101383:	c3                   	ret    

80101384 <readsb>:
struct superblock sb;   // there should be one per dev, but we run with one dev

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101384:	55                   	push   %ebp
80101385:	89 e5                	mov    %esp,%ebp
80101387:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
8010138a:	8b 45 08             	mov    0x8(%ebp),%eax
8010138d:	83 ec 08             	sub    $0x8,%esp
80101390:	6a 01                	push   $0x1
80101392:	50                   	push   %eax
80101393:	e8 1e ee ff ff       	call   801001b6 <bread>
80101398:	83 c4 10             	add    $0x10,%esp
8010139b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
8010139e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013a1:	83 c0 18             	add    $0x18,%eax
801013a4:	83 ec 04             	sub    $0x4,%esp
801013a7:	6a 1c                	push   $0x1c
801013a9:	50                   	push   %eax
801013aa:	ff 75 0c             	pushl  0xc(%ebp)
801013ad:	e8 bb 44 00 00       	call   8010586d <memmove>
801013b2:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801013b5:	83 ec 0c             	sub    $0xc,%esp
801013b8:	ff 75 f4             	pushl  -0xc(%ebp)
801013bb:	e8 6e ee ff ff       	call   8010022e <brelse>
801013c0:	83 c4 10             	add    $0x10,%esp
}
801013c3:	90                   	nop
801013c4:	c9                   	leave  
801013c5:	c3                   	ret    

801013c6 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
801013c6:	55                   	push   %ebp
801013c7:	89 e5                	mov    %esp,%ebp
801013c9:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, bno);
801013cc:	8b 55 0c             	mov    0xc(%ebp),%edx
801013cf:	8b 45 08             	mov    0x8(%ebp),%eax
801013d2:	83 ec 08             	sub    $0x8,%esp
801013d5:	52                   	push   %edx
801013d6:	50                   	push   %eax
801013d7:	e8 da ed ff ff       	call   801001b6 <bread>
801013dc:	83 c4 10             	add    $0x10,%esp
801013df:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
801013e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013e5:	83 c0 18             	add    $0x18,%eax
801013e8:	83 ec 04             	sub    $0x4,%esp
801013eb:	68 00 02 00 00       	push   $0x200
801013f0:	6a 00                	push   $0x0
801013f2:	50                   	push   %eax
801013f3:	e8 b6 43 00 00       	call   801057ae <memset>
801013f8:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801013fb:	83 ec 0c             	sub    $0xc,%esp
801013fe:	ff 75 f4             	pushl  -0xc(%ebp)
80101401:	e8 7f 23 00 00       	call   80103785 <log_write>
80101406:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101409:	83 ec 0c             	sub    $0xc,%esp
8010140c:	ff 75 f4             	pushl  -0xc(%ebp)
8010140f:	e8 1a ee ff ff       	call   8010022e <brelse>
80101414:	83 c4 10             	add    $0x10,%esp
}
80101417:	90                   	nop
80101418:	c9                   	leave  
80101419:	c3                   	ret    

8010141a <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010141a:	55                   	push   %ebp
8010141b:	89 e5                	mov    %esp,%ebp
8010141d:	83 ec 18             	sub    $0x18,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
80101420:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101427:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010142e:	e9 13 01 00 00       	jmp    80101546 <balloc+0x12c>
    bp = bread(dev, BBLOCK(b, sb));
80101433:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101436:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
8010143c:	85 c0                	test   %eax,%eax
8010143e:	0f 48 c2             	cmovs  %edx,%eax
80101441:	c1 f8 0c             	sar    $0xc,%eax
80101444:	89 c2                	mov    %eax,%edx
80101446:	a1 38 22 11 80       	mov    0x80112238,%eax
8010144b:	01 d0                	add    %edx,%eax
8010144d:	83 ec 08             	sub    $0x8,%esp
80101450:	50                   	push   %eax
80101451:	ff 75 08             	pushl  0x8(%ebp)
80101454:	e8 5d ed ff ff       	call   801001b6 <bread>
80101459:	83 c4 10             	add    $0x10,%esp
8010145c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010145f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101466:	e9 a6 00 00 00       	jmp    80101511 <balloc+0xf7>
      m = 1 << (bi % 8);
8010146b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010146e:	99                   	cltd   
8010146f:	c1 ea 1d             	shr    $0x1d,%edx
80101472:	01 d0                	add    %edx,%eax
80101474:	83 e0 07             	and    $0x7,%eax
80101477:	29 d0                	sub    %edx,%eax
80101479:	ba 01 00 00 00       	mov    $0x1,%edx
8010147e:	89 c1                	mov    %eax,%ecx
80101480:	d3 e2                	shl    %cl,%edx
80101482:	89 d0                	mov    %edx,%eax
80101484:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101487:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010148a:	8d 50 07             	lea    0x7(%eax),%edx
8010148d:	85 c0                	test   %eax,%eax
8010148f:	0f 48 c2             	cmovs  %edx,%eax
80101492:	c1 f8 03             	sar    $0x3,%eax
80101495:	89 c2                	mov    %eax,%edx
80101497:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010149a:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
8010149f:	0f b6 c0             	movzbl %al,%eax
801014a2:	23 45 e8             	and    -0x18(%ebp),%eax
801014a5:	85 c0                	test   %eax,%eax
801014a7:	75 64                	jne    8010150d <balloc+0xf3>
        bp->data[bi/8] |= m;  // Mark block in use.
801014a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014ac:	8d 50 07             	lea    0x7(%eax),%edx
801014af:	85 c0                	test   %eax,%eax
801014b1:	0f 48 c2             	cmovs  %edx,%eax
801014b4:	c1 f8 03             	sar    $0x3,%eax
801014b7:	8b 55 ec             	mov    -0x14(%ebp),%edx
801014ba:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
801014bf:	89 d1                	mov    %edx,%ecx
801014c1:	8b 55 e8             	mov    -0x18(%ebp),%edx
801014c4:	09 ca                	or     %ecx,%edx
801014c6:	89 d1                	mov    %edx,%ecx
801014c8:	8b 55 ec             	mov    -0x14(%ebp),%edx
801014cb:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
        log_write(bp);
801014cf:	83 ec 0c             	sub    $0xc,%esp
801014d2:	ff 75 ec             	pushl  -0x14(%ebp)
801014d5:	e8 ab 22 00 00       	call   80103785 <log_write>
801014da:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
801014dd:	83 ec 0c             	sub    $0xc,%esp
801014e0:	ff 75 ec             	pushl  -0x14(%ebp)
801014e3:	e8 46 ed ff ff       	call   8010022e <brelse>
801014e8:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
801014eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014f1:	01 c2                	add    %eax,%edx
801014f3:	8b 45 08             	mov    0x8(%ebp),%eax
801014f6:	83 ec 08             	sub    $0x8,%esp
801014f9:	52                   	push   %edx
801014fa:	50                   	push   %eax
801014fb:	e8 c6 fe ff ff       	call   801013c6 <bzero>
80101500:	83 c4 10             	add    $0x10,%esp
        return b + bi;
80101503:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101506:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101509:	01 d0                	add    %edx,%eax
8010150b:	eb 57                	jmp    80101564 <balloc+0x14a>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010150d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101511:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
80101518:	7f 17                	jg     80101531 <balloc+0x117>
8010151a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010151d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101520:	01 d0                	add    %edx,%eax
80101522:	89 c2                	mov    %eax,%edx
80101524:	a1 20 22 11 80       	mov    0x80112220,%eax
80101529:	39 c2                	cmp    %eax,%edx
8010152b:	0f 82 3a ff ff ff    	jb     8010146b <balloc+0x51>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101531:	83 ec 0c             	sub    $0xc,%esp
80101534:	ff 75 ec             	pushl  -0x14(%ebp)
80101537:	e8 f2 ec ff ff       	call   8010022e <brelse>
8010153c:	83 c4 10             	add    $0x10,%esp
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010153f:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80101546:	8b 15 20 22 11 80    	mov    0x80112220,%edx
8010154c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010154f:	39 c2                	cmp    %eax,%edx
80101551:	0f 87 dc fe ff ff    	ja     80101433 <balloc+0x19>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
80101557:	83 ec 0c             	sub    $0xc,%esp
8010155a:	68 c4 8b 10 80       	push   $0x80108bc4
8010155f:	e8 02 f0 ff ff       	call   80100566 <panic>
}
80101564:	c9                   	leave  
80101565:	c3                   	ret    

80101566 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101566:	55                   	push   %ebp
80101567:	89 e5                	mov    %esp,%ebp
80101569:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
8010156c:	83 ec 08             	sub    $0x8,%esp
8010156f:	68 20 22 11 80       	push   $0x80112220
80101574:	ff 75 08             	pushl  0x8(%ebp)
80101577:	e8 08 fe ff ff       	call   80101384 <readsb>
8010157c:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
8010157f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101582:	c1 e8 0c             	shr    $0xc,%eax
80101585:	89 c2                	mov    %eax,%edx
80101587:	a1 38 22 11 80       	mov    0x80112238,%eax
8010158c:	01 c2                	add    %eax,%edx
8010158e:	8b 45 08             	mov    0x8(%ebp),%eax
80101591:	83 ec 08             	sub    $0x8,%esp
80101594:	52                   	push   %edx
80101595:	50                   	push   %eax
80101596:	e8 1b ec ff ff       	call   801001b6 <bread>
8010159b:	83 c4 10             	add    $0x10,%esp
8010159e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
801015a1:	8b 45 0c             	mov    0xc(%ebp),%eax
801015a4:	25 ff 0f 00 00       	and    $0xfff,%eax
801015a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
801015ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015af:	99                   	cltd   
801015b0:	c1 ea 1d             	shr    $0x1d,%edx
801015b3:	01 d0                	add    %edx,%eax
801015b5:	83 e0 07             	and    $0x7,%eax
801015b8:	29 d0                	sub    %edx,%eax
801015ba:	ba 01 00 00 00       	mov    $0x1,%edx
801015bf:	89 c1                	mov    %eax,%ecx
801015c1:	d3 e2                	shl    %cl,%edx
801015c3:	89 d0                	mov    %edx,%eax
801015c5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
801015c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015cb:	8d 50 07             	lea    0x7(%eax),%edx
801015ce:	85 c0                	test   %eax,%eax
801015d0:	0f 48 c2             	cmovs  %edx,%eax
801015d3:	c1 f8 03             	sar    $0x3,%eax
801015d6:	89 c2                	mov    %eax,%edx
801015d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015db:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
801015e0:	0f b6 c0             	movzbl %al,%eax
801015e3:	23 45 ec             	and    -0x14(%ebp),%eax
801015e6:	85 c0                	test   %eax,%eax
801015e8:	75 0d                	jne    801015f7 <bfree+0x91>
    panic("freeing free block");
801015ea:	83 ec 0c             	sub    $0xc,%esp
801015ed:	68 da 8b 10 80       	push   $0x80108bda
801015f2:	e8 6f ef ff ff       	call   80100566 <panic>
  bp->data[bi/8] &= ~m;
801015f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015fa:	8d 50 07             	lea    0x7(%eax),%edx
801015fd:	85 c0                	test   %eax,%eax
801015ff:	0f 48 c2             	cmovs  %edx,%eax
80101602:	c1 f8 03             	sar    $0x3,%eax
80101605:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101608:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
8010160d:	89 d1                	mov    %edx,%ecx
8010160f:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101612:	f7 d2                	not    %edx
80101614:	21 ca                	and    %ecx,%edx
80101616:	89 d1                	mov    %edx,%ecx
80101618:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010161b:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
  log_write(bp);
8010161f:	83 ec 0c             	sub    $0xc,%esp
80101622:	ff 75 f4             	pushl  -0xc(%ebp)
80101625:	e8 5b 21 00 00       	call   80103785 <log_write>
8010162a:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
8010162d:	83 ec 0c             	sub    $0xc,%esp
80101630:	ff 75 f4             	pushl  -0xc(%ebp)
80101633:	e8 f6 eb ff ff       	call   8010022e <brelse>
80101638:	83 c4 10             	add    $0x10,%esp
}
8010163b:	90                   	nop
8010163c:	c9                   	leave  
8010163d:	c3                   	ret    

8010163e <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
8010163e:	55                   	push   %ebp
8010163f:	89 e5                	mov    %esp,%ebp
80101641:	57                   	push   %edi
80101642:	56                   	push   %esi
80101643:	53                   	push   %ebx
80101644:	83 ec 1c             	sub    $0x1c,%esp
  initlock(&icache.lock, "icache");
80101647:	83 ec 08             	sub    $0x8,%esp
8010164a:	68 ed 8b 10 80       	push   $0x80108bed
8010164f:	68 40 22 11 80       	push   $0x80112240
80101654:	e8 d0 3e 00 00       	call   80105529 <initlock>
80101659:	83 c4 10             	add    $0x10,%esp
  readsb(dev, &sb);
8010165c:	83 ec 08             	sub    $0x8,%esp
8010165f:	68 20 22 11 80       	push   $0x80112220
80101664:	ff 75 08             	pushl  0x8(%ebp)
80101667:	e8 18 fd ff ff       	call   80101384 <readsb>
8010166c:	83 c4 10             	add    $0x10,%esp
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d inodestart %d bmap start %d\n", sb.size,
8010166f:	a1 38 22 11 80       	mov    0x80112238,%eax
80101674:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101677:	8b 3d 34 22 11 80    	mov    0x80112234,%edi
8010167d:	8b 35 30 22 11 80    	mov    0x80112230,%esi
80101683:	8b 1d 2c 22 11 80    	mov    0x8011222c,%ebx
80101689:	8b 0d 28 22 11 80    	mov    0x80112228,%ecx
8010168f:	8b 15 24 22 11 80    	mov    0x80112224,%edx
80101695:	a1 20 22 11 80       	mov    0x80112220,%eax
8010169a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010169d:	57                   	push   %edi
8010169e:	56                   	push   %esi
8010169f:	53                   	push   %ebx
801016a0:	51                   	push   %ecx
801016a1:	52                   	push   %edx
801016a2:	50                   	push   %eax
801016a3:	68 f4 8b 10 80       	push   $0x80108bf4
801016a8:	e8 19 ed ff ff       	call   801003c6 <cprintf>
801016ad:	83 c4 20             	add    $0x20,%esp
          sb.nblocks, sb.ninodes, sb.nlog, sb.logstart, sb.inodestart, sb.bmapstart);
}
801016b0:	90                   	nop
801016b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016b4:	5b                   	pop    %ebx
801016b5:	5e                   	pop    %esi
801016b6:	5f                   	pop    %edi
801016b7:	5d                   	pop    %ebp
801016b8:	c3                   	ret    

801016b9 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
801016b9:	55                   	push   %ebp
801016ba:	89 e5                	mov    %esp,%ebp
801016bc:	83 ec 28             	sub    $0x28,%esp
801016bf:	8b 45 0c             	mov    0xc(%ebp),%eax
801016c2:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801016c6:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
801016cd:	e9 9e 00 00 00       	jmp    80101770 <ialloc+0xb7>
    bp = bread(dev, IBLOCK(inum, sb));
801016d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016d5:	c1 e8 03             	shr    $0x3,%eax
801016d8:	89 c2                	mov    %eax,%edx
801016da:	a1 34 22 11 80       	mov    0x80112234,%eax
801016df:	01 d0                	add    %edx,%eax
801016e1:	83 ec 08             	sub    $0x8,%esp
801016e4:	50                   	push   %eax
801016e5:	ff 75 08             	pushl  0x8(%ebp)
801016e8:	e8 c9 ea ff ff       	call   801001b6 <bread>
801016ed:	83 c4 10             	add    $0x10,%esp
801016f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
801016f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801016f6:	8d 50 18             	lea    0x18(%eax),%edx
801016f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016fc:	83 e0 07             	and    $0x7,%eax
801016ff:	c1 e0 06             	shl    $0x6,%eax
80101702:	01 d0                	add    %edx,%eax
80101704:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
80101707:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010170a:	0f b7 00             	movzwl (%eax),%eax
8010170d:	66 85 c0             	test   %ax,%ax
80101710:	75 4c                	jne    8010175e <ialloc+0xa5>
      memset(dip, 0, sizeof(*dip));
80101712:	83 ec 04             	sub    $0x4,%esp
80101715:	6a 40                	push   $0x40
80101717:	6a 00                	push   $0x0
80101719:	ff 75 ec             	pushl  -0x14(%ebp)
8010171c:	e8 8d 40 00 00       	call   801057ae <memset>
80101721:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
80101724:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101727:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
8010172b:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
8010172e:	83 ec 0c             	sub    $0xc,%esp
80101731:	ff 75 f0             	pushl  -0x10(%ebp)
80101734:	e8 4c 20 00 00       	call   80103785 <log_write>
80101739:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
8010173c:	83 ec 0c             	sub    $0xc,%esp
8010173f:	ff 75 f0             	pushl  -0x10(%ebp)
80101742:	e8 e7 ea ff ff       	call   8010022e <brelse>
80101747:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
8010174a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010174d:	83 ec 08             	sub    $0x8,%esp
80101750:	50                   	push   %eax
80101751:	ff 75 08             	pushl  0x8(%ebp)
80101754:	e8 f8 00 00 00       	call   80101851 <iget>
80101759:	83 c4 10             	add    $0x10,%esp
8010175c:	eb 30                	jmp    8010178e <ialloc+0xd5>
    }
    brelse(bp);
8010175e:	83 ec 0c             	sub    $0xc,%esp
80101761:	ff 75 f0             	pushl  -0x10(%ebp)
80101764:	e8 c5 ea ff ff       	call   8010022e <brelse>
80101769:	83 c4 10             	add    $0x10,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010176c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101770:	8b 15 28 22 11 80    	mov    0x80112228,%edx
80101776:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101779:	39 c2                	cmp    %eax,%edx
8010177b:	0f 87 51 ff ff ff    	ja     801016d2 <ialloc+0x19>
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101781:	83 ec 0c             	sub    $0xc,%esp
80101784:	68 47 8c 10 80       	push   $0x80108c47
80101789:	e8 d8 ed ff ff       	call   80100566 <panic>
}
8010178e:	c9                   	leave  
8010178f:	c3                   	ret    

80101790 <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
80101790:	55                   	push   %ebp
80101791:	89 e5                	mov    %esp,%ebp
80101793:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101796:	8b 45 08             	mov    0x8(%ebp),%eax
80101799:	8b 40 04             	mov    0x4(%eax),%eax
8010179c:	c1 e8 03             	shr    $0x3,%eax
8010179f:	89 c2                	mov    %eax,%edx
801017a1:	a1 34 22 11 80       	mov    0x80112234,%eax
801017a6:	01 c2                	add    %eax,%edx
801017a8:	8b 45 08             	mov    0x8(%ebp),%eax
801017ab:	8b 00                	mov    (%eax),%eax
801017ad:	83 ec 08             	sub    $0x8,%esp
801017b0:	52                   	push   %edx
801017b1:	50                   	push   %eax
801017b2:	e8 ff e9 ff ff       	call   801001b6 <bread>
801017b7:	83 c4 10             	add    $0x10,%esp
801017ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801017bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017c0:	8d 50 18             	lea    0x18(%eax),%edx
801017c3:	8b 45 08             	mov    0x8(%ebp),%eax
801017c6:	8b 40 04             	mov    0x4(%eax),%eax
801017c9:	83 e0 07             	and    $0x7,%eax
801017cc:	c1 e0 06             	shl    $0x6,%eax
801017cf:	01 d0                	add    %edx,%eax
801017d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
801017d4:	8b 45 08             	mov    0x8(%ebp),%eax
801017d7:	0f b7 50 10          	movzwl 0x10(%eax),%edx
801017db:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017de:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801017e1:	8b 45 08             	mov    0x8(%ebp),%eax
801017e4:	0f b7 50 12          	movzwl 0x12(%eax),%edx
801017e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017eb:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
801017ef:	8b 45 08             	mov    0x8(%ebp),%eax
801017f2:	0f b7 50 14          	movzwl 0x14(%eax),%edx
801017f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017f9:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
801017fd:	8b 45 08             	mov    0x8(%ebp),%eax
80101800:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101804:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101807:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
8010180b:	8b 45 08             	mov    0x8(%ebp),%eax
8010180e:	8b 50 18             	mov    0x18(%eax),%edx
80101811:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101814:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101817:	8b 45 08             	mov    0x8(%ebp),%eax
8010181a:	8d 50 1c             	lea    0x1c(%eax),%edx
8010181d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101820:	83 c0 0c             	add    $0xc,%eax
80101823:	83 ec 04             	sub    $0x4,%esp
80101826:	6a 34                	push   $0x34
80101828:	52                   	push   %edx
80101829:	50                   	push   %eax
8010182a:	e8 3e 40 00 00       	call   8010586d <memmove>
8010182f:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
80101832:	83 ec 0c             	sub    $0xc,%esp
80101835:	ff 75 f4             	pushl  -0xc(%ebp)
80101838:	e8 48 1f 00 00       	call   80103785 <log_write>
8010183d:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101840:	83 ec 0c             	sub    $0xc,%esp
80101843:	ff 75 f4             	pushl  -0xc(%ebp)
80101846:	e8 e3 e9 ff ff       	call   8010022e <brelse>
8010184b:	83 c4 10             	add    $0x10,%esp
}
8010184e:	90                   	nop
8010184f:	c9                   	leave  
80101850:	c3                   	ret    

80101851 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101851:	55                   	push   %ebp
80101852:	89 e5                	mov    %esp,%ebp
80101854:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101857:	83 ec 0c             	sub    $0xc,%esp
8010185a:	68 40 22 11 80       	push   $0x80112240
8010185f:	e8 e7 3c 00 00       	call   8010554b <acquire>
80101864:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
80101867:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010186e:	c7 45 f4 74 22 11 80 	movl   $0x80112274,-0xc(%ebp)
80101875:	eb 5d                	jmp    801018d4 <iget+0x83>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101877:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010187a:	8b 40 08             	mov    0x8(%eax),%eax
8010187d:	85 c0                	test   %eax,%eax
8010187f:	7e 39                	jle    801018ba <iget+0x69>
80101881:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101884:	8b 00                	mov    (%eax),%eax
80101886:	3b 45 08             	cmp    0x8(%ebp),%eax
80101889:	75 2f                	jne    801018ba <iget+0x69>
8010188b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010188e:	8b 40 04             	mov    0x4(%eax),%eax
80101891:	3b 45 0c             	cmp    0xc(%ebp),%eax
80101894:	75 24                	jne    801018ba <iget+0x69>
      ip->ref++;
80101896:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101899:	8b 40 08             	mov    0x8(%eax),%eax
8010189c:	8d 50 01             	lea    0x1(%eax),%edx
8010189f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018a2:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
801018a5:	83 ec 0c             	sub    $0xc,%esp
801018a8:	68 40 22 11 80       	push   $0x80112240
801018ad:	e8 00 3d 00 00       	call   801055b2 <release>
801018b2:	83 c4 10             	add    $0x10,%esp
      return ip;
801018b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018b8:	eb 74                	jmp    8010192e <iget+0xdd>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801018ba:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801018be:	75 10                	jne    801018d0 <iget+0x7f>
801018c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018c3:	8b 40 08             	mov    0x8(%eax),%eax
801018c6:	85 c0                	test   %eax,%eax
801018c8:	75 06                	jne    801018d0 <iget+0x7f>
      empty = ip;
801018ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018cd:	89 45 f0             	mov    %eax,-0x10(%ebp)

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801018d0:	83 45 f4 50          	addl   $0x50,-0xc(%ebp)
801018d4:	81 7d f4 14 32 11 80 	cmpl   $0x80113214,-0xc(%ebp)
801018db:	72 9a                	jb     80101877 <iget+0x26>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801018dd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801018e1:	75 0d                	jne    801018f0 <iget+0x9f>
    panic("iget: no inodes");
801018e3:	83 ec 0c             	sub    $0xc,%esp
801018e6:	68 59 8c 10 80       	push   $0x80108c59
801018eb:	e8 76 ec ff ff       	call   80100566 <panic>

  ip = empty;
801018f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
801018f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018f9:	8b 55 08             	mov    0x8(%ebp),%edx
801018fc:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
801018fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101901:	8b 55 0c             	mov    0xc(%ebp),%edx
80101904:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
80101907:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010190a:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
80101911:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101914:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  release(&icache.lock);
8010191b:	83 ec 0c             	sub    $0xc,%esp
8010191e:	68 40 22 11 80       	push   $0x80112240
80101923:	e8 8a 3c 00 00       	call   801055b2 <release>
80101928:	83 c4 10             	add    $0x10,%esp

  return ip;
8010192b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010192e:	c9                   	leave  
8010192f:	c3                   	ret    

80101930 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101930:	55                   	push   %ebp
80101931:	89 e5                	mov    %esp,%ebp
80101933:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101936:	83 ec 0c             	sub    $0xc,%esp
80101939:	68 40 22 11 80       	push   $0x80112240
8010193e:	e8 08 3c 00 00       	call   8010554b <acquire>
80101943:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
80101946:	8b 45 08             	mov    0x8(%ebp),%eax
80101949:	8b 40 08             	mov    0x8(%eax),%eax
8010194c:	8d 50 01             	lea    0x1(%eax),%edx
8010194f:	8b 45 08             	mov    0x8(%ebp),%eax
80101952:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101955:	83 ec 0c             	sub    $0xc,%esp
80101958:	68 40 22 11 80       	push   $0x80112240
8010195d:	e8 50 3c 00 00       	call   801055b2 <release>
80101962:	83 c4 10             	add    $0x10,%esp
  return ip;
80101965:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101968:	c9                   	leave  
80101969:	c3                   	ret    

8010196a <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
8010196a:	55                   	push   %ebp
8010196b:	89 e5                	mov    %esp,%ebp
8010196d:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101970:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101974:	74 0a                	je     80101980 <ilock+0x16>
80101976:	8b 45 08             	mov    0x8(%ebp),%eax
80101979:	8b 40 08             	mov    0x8(%eax),%eax
8010197c:	85 c0                	test   %eax,%eax
8010197e:	7f 0d                	jg     8010198d <ilock+0x23>
    panic("ilock");
80101980:	83 ec 0c             	sub    $0xc,%esp
80101983:	68 69 8c 10 80       	push   $0x80108c69
80101988:	e8 d9 eb ff ff       	call   80100566 <panic>

  acquire(&icache.lock);
8010198d:	83 ec 0c             	sub    $0xc,%esp
80101990:	68 40 22 11 80       	push   $0x80112240
80101995:	e8 b1 3b 00 00       	call   8010554b <acquire>
8010199a:	83 c4 10             	add    $0x10,%esp
  while(ip->flags & I_BUSY)
8010199d:	eb 13                	jmp    801019b2 <ilock+0x48>
    sleep(ip, &icache.lock);
8010199f:	83 ec 08             	sub    $0x8,%esp
801019a2:	68 40 22 11 80       	push   $0x80112240
801019a7:	ff 75 08             	pushl  0x8(%ebp)
801019aa:	e8 78 34 00 00       	call   80104e27 <sleep>
801019af:	83 c4 10             	add    $0x10,%esp

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
801019b2:	8b 45 08             	mov    0x8(%ebp),%eax
801019b5:	8b 40 0c             	mov    0xc(%eax),%eax
801019b8:	83 e0 01             	and    $0x1,%eax
801019bb:	85 c0                	test   %eax,%eax
801019bd:	75 e0                	jne    8010199f <ilock+0x35>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
801019bf:	8b 45 08             	mov    0x8(%ebp),%eax
801019c2:	8b 40 0c             	mov    0xc(%eax),%eax
801019c5:	83 c8 01             	or     $0x1,%eax
801019c8:	89 c2                	mov    %eax,%edx
801019ca:	8b 45 08             	mov    0x8(%ebp),%eax
801019cd:	89 50 0c             	mov    %edx,0xc(%eax)
  release(&icache.lock);
801019d0:	83 ec 0c             	sub    $0xc,%esp
801019d3:	68 40 22 11 80       	push   $0x80112240
801019d8:	e8 d5 3b 00 00       	call   801055b2 <release>
801019dd:	83 c4 10             	add    $0x10,%esp

  if(!(ip->flags & I_VALID)){
801019e0:	8b 45 08             	mov    0x8(%ebp),%eax
801019e3:	8b 40 0c             	mov    0xc(%eax),%eax
801019e6:	83 e0 02             	and    $0x2,%eax
801019e9:	85 c0                	test   %eax,%eax
801019eb:	0f 85 d4 00 00 00    	jne    80101ac5 <ilock+0x15b>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801019f1:	8b 45 08             	mov    0x8(%ebp),%eax
801019f4:	8b 40 04             	mov    0x4(%eax),%eax
801019f7:	c1 e8 03             	shr    $0x3,%eax
801019fa:	89 c2                	mov    %eax,%edx
801019fc:	a1 34 22 11 80       	mov    0x80112234,%eax
80101a01:	01 c2                	add    %eax,%edx
80101a03:	8b 45 08             	mov    0x8(%ebp),%eax
80101a06:	8b 00                	mov    (%eax),%eax
80101a08:	83 ec 08             	sub    $0x8,%esp
80101a0b:	52                   	push   %edx
80101a0c:	50                   	push   %eax
80101a0d:	e8 a4 e7 ff ff       	call   801001b6 <bread>
80101a12:	83 c4 10             	add    $0x10,%esp
80101a15:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101a18:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a1b:	8d 50 18             	lea    0x18(%eax),%edx
80101a1e:	8b 45 08             	mov    0x8(%ebp),%eax
80101a21:	8b 40 04             	mov    0x4(%eax),%eax
80101a24:	83 e0 07             	and    $0x7,%eax
80101a27:	c1 e0 06             	shl    $0x6,%eax
80101a2a:	01 d0                	add    %edx,%eax
80101a2c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
80101a2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a32:	0f b7 10             	movzwl (%eax),%edx
80101a35:	8b 45 08             	mov    0x8(%ebp),%eax
80101a38:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
80101a3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a3f:	0f b7 50 02          	movzwl 0x2(%eax),%edx
80101a43:	8b 45 08             	mov    0x8(%ebp),%eax
80101a46:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
80101a4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a4d:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80101a51:	8b 45 08             	mov    0x8(%ebp),%eax
80101a54:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
80101a58:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a5b:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80101a5f:	8b 45 08             	mov    0x8(%ebp),%eax
80101a62:	66 89 50 16          	mov    %dx,0x16(%eax)
    ip->size = dip->size;
80101a66:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a69:	8b 50 08             	mov    0x8(%eax),%edx
80101a6c:	8b 45 08             	mov    0x8(%ebp),%eax
80101a6f:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a72:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a75:	8d 50 0c             	lea    0xc(%eax),%edx
80101a78:	8b 45 08             	mov    0x8(%ebp),%eax
80101a7b:	83 c0 1c             	add    $0x1c,%eax
80101a7e:	83 ec 04             	sub    $0x4,%esp
80101a81:	6a 34                	push   $0x34
80101a83:	52                   	push   %edx
80101a84:	50                   	push   %eax
80101a85:	e8 e3 3d 00 00       	call   8010586d <memmove>
80101a8a:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101a8d:	83 ec 0c             	sub    $0xc,%esp
80101a90:	ff 75 f4             	pushl  -0xc(%ebp)
80101a93:	e8 96 e7 ff ff       	call   8010022e <brelse>
80101a98:	83 c4 10             	add    $0x10,%esp
    ip->flags |= I_VALID;
80101a9b:	8b 45 08             	mov    0x8(%ebp),%eax
80101a9e:	8b 40 0c             	mov    0xc(%eax),%eax
80101aa1:	83 c8 02             	or     $0x2,%eax
80101aa4:	89 c2                	mov    %eax,%edx
80101aa6:	8b 45 08             	mov    0x8(%ebp),%eax
80101aa9:	89 50 0c             	mov    %edx,0xc(%eax)
    if(ip->type == 0)
80101aac:	8b 45 08             	mov    0x8(%ebp),%eax
80101aaf:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101ab3:	66 85 c0             	test   %ax,%ax
80101ab6:	75 0d                	jne    80101ac5 <ilock+0x15b>
      panic("ilock: no type");
80101ab8:	83 ec 0c             	sub    $0xc,%esp
80101abb:	68 6f 8c 10 80       	push   $0x80108c6f
80101ac0:	e8 a1 ea ff ff       	call   80100566 <panic>
  }
}
80101ac5:	90                   	nop
80101ac6:	c9                   	leave  
80101ac7:	c3                   	ret    

80101ac8 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101ac8:	55                   	push   %ebp
80101ac9:	89 e5                	mov    %esp,%ebp
80101acb:	83 ec 08             	sub    $0x8,%esp
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
80101ace:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101ad2:	74 17                	je     80101aeb <iunlock+0x23>
80101ad4:	8b 45 08             	mov    0x8(%ebp),%eax
80101ad7:	8b 40 0c             	mov    0xc(%eax),%eax
80101ada:	83 e0 01             	and    $0x1,%eax
80101add:	85 c0                	test   %eax,%eax
80101adf:	74 0a                	je     80101aeb <iunlock+0x23>
80101ae1:	8b 45 08             	mov    0x8(%ebp),%eax
80101ae4:	8b 40 08             	mov    0x8(%eax),%eax
80101ae7:	85 c0                	test   %eax,%eax
80101ae9:	7f 0d                	jg     80101af8 <iunlock+0x30>
    panic("iunlock");
80101aeb:	83 ec 0c             	sub    $0xc,%esp
80101aee:	68 7e 8c 10 80       	push   $0x80108c7e
80101af3:	e8 6e ea ff ff       	call   80100566 <panic>

  acquire(&icache.lock);
80101af8:	83 ec 0c             	sub    $0xc,%esp
80101afb:	68 40 22 11 80       	push   $0x80112240
80101b00:	e8 46 3a 00 00       	call   8010554b <acquire>
80101b05:	83 c4 10             	add    $0x10,%esp
  ip->flags &= ~I_BUSY;
80101b08:	8b 45 08             	mov    0x8(%ebp),%eax
80101b0b:	8b 40 0c             	mov    0xc(%eax),%eax
80101b0e:	83 e0 fe             	and    $0xfffffffe,%eax
80101b11:	89 c2                	mov    %eax,%edx
80101b13:	8b 45 08             	mov    0x8(%ebp),%eax
80101b16:	89 50 0c             	mov    %edx,0xc(%eax)
  wakeup(ip);
80101b19:	83 ec 0c             	sub    $0xc,%esp
80101b1c:	ff 75 08             	pushl  0x8(%ebp)
80101b1f:	e8 f1 33 00 00       	call   80104f15 <wakeup>
80101b24:	83 c4 10             	add    $0x10,%esp
  release(&icache.lock);
80101b27:	83 ec 0c             	sub    $0xc,%esp
80101b2a:	68 40 22 11 80       	push   $0x80112240
80101b2f:	e8 7e 3a 00 00       	call   801055b2 <release>
80101b34:	83 c4 10             	add    $0x10,%esp
}
80101b37:	90                   	nop
80101b38:	c9                   	leave  
80101b39:	c3                   	ret    

80101b3a <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101b3a:	55                   	push   %ebp
80101b3b:	89 e5                	mov    %esp,%ebp
80101b3d:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101b40:	83 ec 0c             	sub    $0xc,%esp
80101b43:	68 40 22 11 80       	push   $0x80112240
80101b48:	e8 fe 39 00 00       	call   8010554b <acquire>
80101b4d:	83 c4 10             	add    $0x10,%esp
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101b50:	8b 45 08             	mov    0x8(%ebp),%eax
80101b53:	8b 40 08             	mov    0x8(%eax),%eax
80101b56:	83 f8 01             	cmp    $0x1,%eax
80101b59:	0f 85 a9 00 00 00    	jne    80101c08 <iput+0xce>
80101b5f:	8b 45 08             	mov    0x8(%ebp),%eax
80101b62:	8b 40 0c             	mov    0xc(%eax),%eax
80101b65:	83 e0 02             	and    $0x2,%eax
80101b68:	85 c0                	test   %eax,%eax
80101b6a:	0f 84 98 00 00 00    	je     80101c08 <iput+0xce>
80101b70:	8b 45 08             	mov    0x8(%ebp),%eax
80101b73:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80101b77:	66 85 c0             	test   %ax,%ax
80101b7a:	0f 85 88 00 00 00    	jne    80101c08 <iput+0xce>
    // inode has no links and no other references: truncate and free.
    if(ip->flags & I_BUSY)
80101b80:	8b 45 08             	mov    0x8(%ebp),%eax
80101b83:	8b 40 0c             	mov    0xc(%eax),%eax
80101b86:	83 e0 01             	and    $0x1,%eax
80101b89:	85 c0                	test   %eax,%eax
80101b8b:	74 0d                	je     80101b9a <iput+0x60>
      panic("iput busy");
80101b8d:	83 ec 0c             	sub    $0xc,%esp
80101b90:	68 86 8c 10 80       	push   $0x80108c86
80101b95:	e8 cc e9 ff ff       	call   80100566 <panic>
    ip->flags |= I_BUSY;
80101b9a:	8b 45 08             	mov    0x8(%ebp),%eax
80101b9d:	8b 40 0c             	mov    0xc(%eax),%eax
80101ba0:	83 c8 01             	or     $0x1,%eax
80101ba3:	89 c2                	mov    %eax,%edx
80101ba5:	8b 45 08             	mov    0x8(%ebp),%eax
80101ba8:	89 50 0c             	mov    %edx,0xc(%eax)
    release(&icache.lock);
80101bab:	83 ec 0c             	sub    $0xc,%esp
80101bae:	68 40 22 11 80       	push   $0x80112240
80101bb3:	e8 fa 39 00 00       	call   801055b2 <release>
80101bb8:	83 c4 10             	add    $0x10,%esp
    itrunc(ip);
80101bbb:	83 ec 0c             	sub    $0xc,%esp
80101bbe:	ff 75 08             	pushl  0x8(%ebp)
80101bc1:	e8 a8 01 00 00       	call   80101d6e <itrunc>
80101bc6:	83 c4 10             	add    $0x10,%esp
    ip->type = 0;
80101bc9:	8b 45 08             	mov    0x8(%ebp),%eax
80101bcc:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
    iupdate(ip);
80101bd2:	83 ec 0c             	sub    $0xc,%esp
80101bd5:	ff 75 08             	pushl  0x8(%ebp)
80101bd8:	e8 b3 fb ff ff       	call   80101790 <iupdate>
80101bdd:	83 c4 10             	add    $0x10,%esp
    acquire(&icache.lock);
80101be0:	83 ec 0c             	sub    $0xc,%esp
80101be3:	68 40 22 11 80       	push   $0x80112240
80101be8:	e8 5e 39 00 00       	call   8010554b <acquire>
80101bed:	83 c4 10             	add    $0x10,%esp
    ip->flags = 0;
80101bf0:	8b 45 08             	mov    0x8(%ebp),%eax
80101bf3:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101bfa:	83 ec 0c             	sub    $0xc,%esp
80101bfd:	ff 75 08             	pushl  0x8(%ebp)
80101c00:	e8 10 33 00 00       	call   80104f15 <wakeup>
80101c05:	83 c4 10             	add    $0x10,%esp
  }
  ip->ref--;
80101c08:	8b 45 08             	mov    0x8(%ebp),%eax
80101c0b:	8b 40 08             	mov    0x8(%eax),%eax
80101c0e:	8d 50 ff             	lea    -0x1(%eax),%edx
80101c11:	8b 45 08             	mov    0x8(%ebp),%eax
80101c14:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101c17:	83 ec 0c             	sub    $0xc,%esp
80101c1a:	68 40 22 11 80       	push   $0x80112240
80101c1f:	e8 8e 39 00 00       	call   801055b2 <release>
80101c24:	83 c4 10             	add    $0x10,%esp
}
80101c27:	90                   	nop
80101c28:	c9                   	leave  
80101c29:	c3                   	ret    

80101c2a <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101c2a:	55                   	push   %ebp
80101c2b:	89 e5                	mov    %esp,%ebp
80101c2d:	83 ec 08             	sub    $0x8,%esp
  iunlock(ip);
80101c30:	83 ec 0c             	sub    $0xc,%esp
80101c33:	ff 75 08             	pushl  0x8(%ebp)
80101c36:	e8 8d fe ff ff       	call   80101ac8 <iunlock>
80101c3b:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80101c3e:	83 ec 0c             	sub    $0xc,%esp
80101c41:	ff 75 08             	pushl  0x8(%ebp)
80101c44:	e8 f1 fe ff ff       	call   80101b3a <iput>
80101c49:	83 c4 10             	add    $0x10,%esp
}
80101c4c:	90                   	nop
80101c4d:	c9                   	leave  
80101c4e:	c3                   	ret    

80101c4f <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101c4f:	55                   	push   %ebp
80101c50:	89 e5                	mov    %esp,%ebp
80101c52:	53                   	push   %ebx
80101c53:	83 ec 14             	sub    $0x14,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101c56:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101c5a:	77 42                	ja     80101c9e <bmap+0x4f>
    if((addr = ip->addrs[bn]) == 0)
80101c5c:	8b 45 08             	mov    0x8(%ebp),%eax
80101c5f:	8b 55 0c             	mov    0xc(%ebp),%edx
80101c62:	83 c2 04             	add    $0x4,%edx
80101c65:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101c69:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c6c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c70:	75 24                	jne    80101c96 <bmap+0x47>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101c72:	8b 45 08             	mov    0x8(%ebp),%eax
80101c75:	8b 00                	mov    (%eax),%eax
80101c77:	83 ec 0c             	sub    $0xc,%esp
80101c7a:	50                   	push   %eax
80101c7b:	e8 9a f7 ff ff       	call   8010141a <balloc>
80101c80:	83 c4 10             	add    $0x10,%esp
80101c83:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c86:	8b 45 08             	mov    0x8(%ebp),%eax
80101c89:	8b 55 0c             	mov    0xc(%ebp),%edx
80101c8c:	8d 4a 04             	lea    0x4(%edx),%ecx
80101c8f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c92:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101c96:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c99:	e9 cb 00 00 00       	jmp    80101d69 <bmap+0x11a>
  }
  bn -= NDIRECT;
80101c9e:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101ca2:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101ca6:	0f 87 b0 00 00 00    	ja     80101d5c <bmap+0x10d>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101cac:	8b 45 08             	mov    0x8(%ebp),%eax
80101caf:	8b 40 4c             	mov    0x4c(%eax),%eax
80101cb2:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101cb5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101cb9:	75 1d                	jne    80101cd8 <bmap+0x89>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101cbb:	8b 45 08             	mov    0x8(%ebp),%eax
80101cbe:	8b 00                	mov    (%eax),%eax
80101cc0:	83 ec 0c             	sub    $0xc,%esp
80101cc3:	50                   	push   %eax
80101cc4:	e8 51 f7 ff ff       	call   8010141a <balloc>
80101cc9:	83 c4 10             	add    $0x10,%esp
80101ccc:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101ccf:	8b 45 08             	mov    0x8(%ebp),%eax
80101cd2:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101cd5:	89 50 4c             	mov    %edx,0x4c(%eax)
    bp = bread(ip->dev, addr);
80101cd8:	8b 45 08             	mov    0x8(%ebp),%eax
80101cdb:	8b 00                	mov    (%eax),%eax
80101cdd:	83 ec 08             	sub    $0x8,%esp
80101ce0:	ff 75 f4             	pushl  -0xc(%ebp)
80101ce3:	50                   	push   %eax
80101ce4:	e8 cd e4 ff ff       	call   801001b6 <bread>
80101ce9:	83 c4 10             	add    $0x10,%esp
80101cec:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101cef:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101cf2:	83 c0 18             	add    $0x18,%eax
80101cf5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
80101cf8:	8b 45 0c             	mov    0xc(%ebp),%eax
80101cfb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d02:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d05:	01 d0                	add    %edx,%eax
80101d07:	8b 00                	mov    (%eax),%eax
80101d09:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d0c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101d10:	75 37                	jne    80101d49 <bmap+0xfa>
      a[bn] = addr = balloc(ip->dev);
80101d12:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d15:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d1c:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d1f:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80101d22:	8b 45 08             	mov    0x8(%ebp),%eax
80101d25:	8b 00                	mov    (%eax),%eax
80101d27:	83 ec 0c             	sub    $0xc,%esp
80101d2a:	50                   	push   %eax
80101d2b:	e8 ea f6 ff ff       	call   8010141a <balloc>
80101d30:	83 c4 10             	add    $0x10,%esp
80101d33:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d39:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
80101d3b:	83 ec 0c             	sub    $0xc,%esp
80101d3e:	ff 75 f0             	pushl  -0x10(%ebp)
80101d41:	e8 3f 1a 00 00       	call   80103785 <log_write>
80101d46:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101d49:	83 ec 0c             	sub    $0xc,%esp
80101d4c:	ff 75 f0             	pushl  -0x10(%ebp)
80101d4f:	e8 da e4 ff ff       	call   8010022e <brelse>
80101d54:	83 c4 10             	add    $0x10,%esp
    return addr;
80101d57:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d5a:	eb 0d                	jmp    80101d69 <bmap+0x11a>
  }

  panic("bmap: out of range");
80101d5c:	83 ec 0c             	sub    $0xc,%esp
80101d5f:	68 90 8c 10 80       	push   $0x80108c90
80101d64:	e8 fd e7 ff ff       	call   80100566 <panic>
}
80101d69:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101d6c:	c9                   	leave  
80101d6d:	c3                   	ret    

80101d6e <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101d6e:	55                   	push   %ebp
80101d6f:	89 e5                	mov    %esp,%ebp
80101d71:	83 ec 18             	sub    $0x18,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101d74:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101d7b:	eb 45                	jmp    80101dc2 <itrunc+0x54>
    if(ip->addrs[i]){
80101d7d:	8b 45 08             	mov    0x8(%ebp),%eax
80101d80:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d83:	83 c2 04             	add    $0x4,%edx
80101d86:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101d8a:	85 c0                	test   %eax,%eax
80101d8c:	74 30                	je     80101dbe <itrunc+0x50>
      bfree(ip->dev, ip->addrs[i]);
80101d8e:	8b 45 08             	mov    0x8(%ebp),%eax
80101d91:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d94:	83 c2 04             	add    $0x4,%edx
80101d97:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101d9b:	8b 55 08             	mov    0x8(%ebp),%edx
80101d9e:	8b 12                	mov    (%edx),%edx
80101da0:	83 ec 08             	sub    $0x8,%esp
80101da3:	50                   	push   %eax
80101da4:	52                   	push   %edx
80101da5:	e8 bc f7 ff ff       	call   80101566 <bfree>
80101daa:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
80101dad:	8b 45 08             	mov    0x8(%ebp),%eax
80101db0:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101db3:	83 c2 04             	add    $0x4,%edx
80101db6:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101dbd:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101dbe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101dc2:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80101dc6:	7e b5                	jle    80101d7d <itrunc+0xf>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
80101dc8:	8b 45 08             	mov    0x8(%ebp),%eax
80101dcb:	8b 40 4c             	mov    0x4c(%eax),%eax
80101dce:	85 c0                	test   %eax,%eax
80101dd0:	0f 84 a1 00 00 00    	je     80101e77 <itrunc+0x109>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101dd6:	8b 45 08             	mov    0x8(%ebp),%eax
80101dd9:	8b 50 4c             	mov    0x4c(%eax),%edx
80101ddc:	8b 45 08             	mov    0x8(%ebp),%eax
80101ddf:	8b 00                	mov    (%eax),%eax
80101de1:	83 ec 08             	sub    $0x8,%esp
80101de4:	52                   	push   %edx
80101de5:	50                   	push   %eax
80101de6:	e8 cb e3 ff ff       	call   801001b6 <bread>
80101deb:	83 c4 10             	add    $0x10,%esp
80101dee:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
80101df1:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101df4:	83 c0 18             	add    $0x18,%eax
80101df7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101dfa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101e01:	eb 3c                	jmp    80101e3f <itrunc+0xd1>
      if(a[j])
80101e03:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e06:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101e0d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101e10:	01 d0                	add    %edx,%eax
80101e12:	8b 00                	mov    (%eax),%eax
80101e14:	85 c0                	test   %eax,%eax
80101e16:	74 23                	je     80101e3b <itrunc+0xcd>
        bfree(ip->dev, a[j]);
80101e18:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e1b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101e22:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101e25:	01 d0                	add    %edx,%eax
80101e27:	8b 00                	mov    (%eax),%eax
80101e29:	8b 55 08             	mov    0x8(%ebp),%edx
80101e2c:	8b 12                	mov    (%edx),%edx
80101e2e:	83 ec 08             	sub    $0x8,%esp
80101e31:	50                   	push   %eax
80101e32:	52                   	push   %edx
80101e33:	e8 2e f7 ff ff       	call   80101566 <bfree>
80101e38:	83 c4 10             	add    $0x10,%esp
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101e3b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101e3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e42:	83 f8 7f             	cmp    $0x7f,%eax
80101e45:	76 bc                	jbe    80101e03 <itrunc+0x95>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
80101e47:	83 ec 0c             	sub    $0xc,%esp
80101e4a:	ff 75 ec             	pushl  -0x14(%ebp)
80101e4d:	e8 dc e3 ff ff       	call   8010022e <brelse>
80101e52:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101e55:	8b 45 08             	mov    0x8(%ebp),%eax
80101e58:	8b 40 4c             	mov    0x4c(%eax),%eax
80101e5b:	8b 55 08             	mov    0x8(%ebp),%edx
80101e5e:	8b 12                	mov    (%edx),%edx
80101e60:	83 ec 08             	sub    $0x8,%esp
80101e63:	50                   	push   %eax
80101e64:	52                   	push   %edx
80101e65:	e8 fc f6 ff ff       	call   80101566 <bfree>
80101e6a:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
80101e6d:	8b 45 08             	mov    0x8(%ebp),%eax
80101e70:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
80101e77:	8b 45 08             	mov    0x8(%ebp),%eax
80101e7a:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
80101e81:	83 ec 0c             	sub    $0xc,%esp
80101e84:	ff 75 08             	pushl  0x8(%ebp)
80101e87:	e8 04 f9 ff ff       	call   80101790 <iupdate>
80101e8c:	83 c4 10             	add    $0x10,%esp
}
80101e8f:	90                   	nop
80101e90:	c9                   	leave  
80101e91:	c3                   	ret    

80101e92 <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101e92:	55                   	push   %ebp
80101e93:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101e95:	8b 45 08             	mov    0x8(%ebp),%eax
80101e98:	8b 00                	mov    (%eax),%eax
80101e9a:	89 c2                	mov    %eax,%edx
80101e9c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e9f:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101ea2:	8b 45 08             	mov    0x8(%ebp),%eax
80101ea5:	8b 50 04             	mov    0x4(%eax),%edx
80101ea8:	8b 45 0c             	mov    0xc(%ebp),%eax
80101eab:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101eae:	8b 45 08             	mov    0x8(%ebp),%eax
80101eb1:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101eb5:	8b 45 0c             	mov    0xc(%ebp),%eax
80101eb8:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80101ebb:	8b 45 08             	mov    0x8(%ebp),%eax
80101ebe:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101ec2:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ec5:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80101ec9:	8b 45 08             	mov    0x8(%ebp),%eax
80101ecc:	8b 50 18             	mov    0x18(%eax),%edx
80101ecf:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ed2:	89 50 10             	mov    %edx,0x10(%eax)
}
80101ed5:	90                   	nop
80101ed6:	5d                   	pop    %ebp
80101ed7:	c3                   	ret    

80101ed8 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101ed8:	55                   	push   %ebp
80101ed9:	89 e5                	mov    %esp,%ebp
80101edb:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ede:	8b 45 08             	mov    0x8(%ebp),%eax
80101ee1:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101ee5:	66 83 f8 03          	cmp    $0x3,%ax
80101ee9:	75 5c                	jne    80101f47 <readi+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101eeb:	8b 45 08             	mov    0x8(%ebp),%eax
80101eee:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101ef2:	66 85 c0             	test   %ax,%ax
80101ef5:	78 20                	js     80101f17 <readi+0x3f>
80101ef7:	8b 45 08             	mov    0x8(%ebp),%eax
80101efa:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101efe:	66 83 f8 09          	cmp    $0x9,%ax
80101f02:	7f 13                	jg     80101f17 <readi+0x3f>
80101f04:	8b 45 08             	mov    0x8(%ebp),%eax
80101f07:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101f0b:	98                   	cwtl   
80101f0c:	8b 04 c5 c0 21 11 80 	mov    -0x7feede40(,%eax,8),%eax
80101f13:	85 c0                	test   %eax,%eax
80101f15:	75 0a                	jne    80101f21 <readi+0x49>
      return -1;
80101f17:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f1c:	e9 0c 01 00 00       	jmp    8010202d <readi+0x155>
    return devsw[ip->major].read(ip, dst, n);
80101f21:	8b 45 08             	mov    0x8(%ebp),%eax
80101f24:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101f28:	98                   	cwtl   
80101f29:	8b 04 c5 c0 21 11 80 	mov    -0x7feede40(,%eax,8),%eax
80101f30:	8b 55 14             	mov    0x14(%ebp),%edx
80101f33:	83 ec 04             	sub    $0x4,%esp
80101f36:	52                   	push   %edx
80101f37:	ff 75 0c             	pushl  0xc(%ebp)
80101f3a:	ff 75 08             	pushl  0x8(%ebp)
80101f3d:	ff d0                	call   *%eax
80101f3f:	83 c4 10             	add    $0x10,%esp
80101f42:	e9 e6 00 00 00       	jmp    8010202d <readi+0x155>
  }

  if(off > ip->size || off + n < off)
80101f47:	8b 45 08             	mov    0x8(%ebp),%eax
80101f4a:	8b 40 18             	mov    0x18(%eax),%eax
80101f4d:	3b 45 10             	cmp    0x10(%ebp),%eax
80101f50:	72 0d                	jb     80101f5f <readi+0x87>
80101f52:	8b 55 10             	mov    0x10(%ebp),%edx
80101f55:	8b 45 14             	mov    0x14(%ebp),%eax
80101f58:	01 d0                	add    %edx,%eax
80101f5a:	3b 45 10             	cmp    0x10(%ebp),%eax
80101f5d:	73 0a                	jae    80101f69 <readi+0x91>
    return -1;
80101f5f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f64:	e9 c4 00 00 00       	jmp    8010202d <readi+0x155>
  if(off + n > ip->size)
80101f69:	8b 55 10             	mov    0x10(%ebp),%edx
80101f6c:	8b 45 14             	mov    0x14(%ebp),%eax
80101f6f:	01 c2                	add    %eax,%edx
80101f71:	8b 45 08             	mov    0x8(%ebp),%eax
80101f74:	8b 40 18             	mov    0x18(%eax),%eax
80101f77:	39 c2                	cmp    %eax,%edx
80101f79:	76 0c                	jbe    80101f87 <readi+0xaf>
    n = ip->size - off;
80101f7b:	8b 45 08             	mov    0x8(%ebp),%eax
80101f7e:	8b 40 18             	mov    0x18(%eax),%eax
80101f81:	2b 45 10             	sub    0x10(%ebp),%eax
80101f84:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101f87:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101f8e:	e9 8b 00 00 00       	jmp    8010201e <readi+0x146>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f93:	8b 45 10             	mov    0x10(%ebp),%eax
80101f96:	c1 e8 09             	shr    $0x9,%eax
80101f99:	83 ec 08             	sub    $0x8,%esp
80101f9c:	50                   	push   %eax
80101f9d:	ff 75 08             	pushl  0x8(%ebp)
80101fa0:	e8 aa fc ff ff       	call   80101c4f <bmap>
80101fa5:	83 c4 10             	add    $0x10,%esp
80101fa8:	89 c2                	mov    %eax,%edx
80101faa:	8b 45 08             	mov    0x8(%ebp),%eax
80101fad:	8b 00                	mov    (%eax),%eax
80101faf:	83 ec 08             	sub    $0x8,%esp
80101fb2:	52                   	push   %edx
80101fb3:	50                   	push   %eax
80101fb4:	e8 fd e1 ff ff       	call   801001b6 <bread>
80101fb9:	83 c4 10             	add    $0x10,%esp
80101fbc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101fbf:	8b 45 10             	mov    0x10(%ebp),%eax
80101fc2:	25 ff 01 00 00       	and    $0x1ff,%eax
80101fc7:	ba 00 02 00 00       	mov    $0x200,%edx
80101fcc:	29 c2                	sub    %eax,%edx
80101fce:	8b 45 14             	mov    0x14(%ebp),%eax
80101fd1:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101fd4:	39 c2                	cmp    %eax,%edx
80101fd6:	0f 46 c2             	cmovbe %edx,%eax
80101fd9:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
80101fdc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101fdf:	8d 50 18             	lea    0x18(%eax),%edx
80101fe2:	8b 45 10             	mov    0x10(%ebp),%eax
80101fe5:	25 ff 01 00 00       	and    $0x1ff,%eax
80101fea:	01 d0                	add    %edx,%eax
80101fec:	83 ec 04             	sub    $0x4,%esp
80101fef:	ff 75 ec             	pushl  -0x14(%ebp)
80101ff2:	50                   	push   %eax
80101ff3:	ff 75 0c             	pushl  0xc(%ebp)
80101ff6:	e8 72 38 00 00       	call   8010586d <memmove>
80101ffb:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101ffe:	83 ec 0c             	sub    $0xc,%esp
80102001:	ff 75 f0             	pushl  -0x10(%ebp)
80102004:	e8 25 e2 ff ff       	call   8010022e <brelse>
80102009:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010200c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010200f:	01 45 f4             	add    %eax,-0xc(%ebp)
80102012:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102015:	01 45 10             	add    %eax,0x10(%ebp)
80102018:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010201b:	01 45 0c             	add    %eax,0xc(%ebp)
8010201e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102021:	3b 45 14             	cmp    0x14(%ebp),%eax
80102024:	0f 82 69 ff ff ff    	jb     80101f93 <readi+0xbb>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
8010202a:	8b 45 14             	mov    0x14(%ebp),%eax
}
8010202d:	c9                   	leave  
8010202e:	c3                   	ret    

8010202f <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
8010202f:	55                   	push   %ebp
80102030:	89 e5                	mov    %esp,%ebp
80102032:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102035:	8b 45 08             	mov    0x8(%ebp),%eax
80102038:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010203c:	66 83 f8 03          	cmp    $0x3,%ax
80102040:	75 5c                	jne    8010209e <writei+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102042:	8b 45 08             	mov    0x8(%ebp),%eax
80102045:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102049:	66 85 c0             	test   %ax,%ax
8010204c:	78 20                	js     8010206e <writei+0x3f>
8010204e:	8b 45 08             	mov    0x8(%ebp),%eax
80102051:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102055:	66 83 f8 09          	cmp    $0x9,%ax
80102059:	7f 13                	jg     8010206e <writei+0x3f>
8010205b:	8b 45 08             	mov    0x8(%ebp),%eax
8010205e:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102062:	98                   	cwtl   
80102063:	8b 04 c5 c4 21 11 80 	mov    -0x7feede3c(,%eax,8),%eax
8010206a:	85 c0                	test   %eax,%eax
8010206c:	75 0a                	jne    80102078 <writei+0x49>
      return -1;
8010206e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102073:	e9 3d 01 00 00       	jmp    801021b5 <writei+0x186>
    return devsw[ip->major].write(ip, src, n);
80102078:	8b 45 08             	mov    0x8(%ebp),%eax
8010207b:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010207f:	98                   	cwtl   
80102080:	8b 04 c5 c4 21 11 80 	mov    -0x7feede3c(,%eax,8),%eax
80102087:	8b 55 14             	mov    0x14(%ebp),%edx
8010208a:	83 ec 04             	sub    $0x4,%esp
8010208d:	52                   	push   %edx
8010208e:	ff 75 0c             	pushl  0xc(%ebp)
80102091:	ff 75 08             	pushl  0x8(%ebp)
80102094:	ff d0                	call   *%eax
80102096:	83 c4 10             	add    $0x10,%esp
80102099:	e9 17 01 00 00       	jmp    801021b5 <writei+0x186>
  }

  if(off > ip->size || off + n < off)
8010209e:	8b 45 08             	mov    0x8(%ebp),%eax
801020a1:	8b 40 18             	mov    0x18(%eax),%eax
801020a4:	3b 45 10             	cmp    0x10(%ebp),%eax
801020a7:	72 0d                	jb     801020b6 <writei+0x87>
801020a9:	8b 55 10             	mov    0x10(%ebp),%edx
801020ac:	8b 45 14             	mov    0x14(%ebp),%eax
801020af:	01 d0                	add    %edx,%eax
801020b1:	3b 45 10             	cmp    0x10(%ebp),%eax
801020b4:	73 0a                	jae    801020c0 <writei+0x91>
    return -1;
801020b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801020bb:	e9 f5 00 00 00       	jmp    801021b5 <writei+0x186>
  if(off + n > MAXFILE*BSIZE)
801020c0:	8b 55 10             	mov    0x10(%ebp),%edx
801020c3:	8b 45 14             	mov    0x14(%ebp),%eax
801020c6:	01 d0                	add    %edx,%eax
801020c8:	3d 00 18 01 00       	cmp    $0x11800,%eax
801020cd:	76 0a                	jbe    801020d9 <writei+0xaa>
    return -1;
801020cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801020d4:	e9 dc 00 00 00       	jmp    801021b5 <writei+0x186>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801020d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801020e0:	e9 99 00 00 00       	jmp    8010217e <writei+0x14f>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801020e5:	8b 45 10             	mov    0x10(%ebp),%eax
801020e8:	c1 e8 09             	shr    $0x9,%eax
801020eb:	83 ec 08             	sub    $0x8,%esp
801020ee:	50                   	push   %eax
801020ef:	ff 75 08             	pushl  0x8(%ebp)
801020f2:	e8 58 fb ff ff       	call   80101c4f <bmap>
801020f7:	83 c4 10             	add    $0x10,%esp
801020fa:	89 c2                	mov    %eax,%edx
801020fc:	8b 45 08             	mov    0x8(%ebp),%eax
801020ff:	8b 00                	mov    (%eax),%eax
80102101:	83 ec 08             	sub    $0x8,%esp
80102104:	52                   	push   %edx
80102105:	50                   	push   %eax
80102106:	e8 ab e0 ff ff       	call   801001b6 <bread>
8010210b:	83 c4 10             	add    $0x10,%esp
8010210e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102111:	8b 45 10             	mov    0x10(%ebp),%eax
80102114:	25 ff 01 00 00       	and    $0x1ff,%eax
80102119:	ba 00 02 00 00       	mov    $0x200,%edx
8010211e:	29 c2                	sub    %eax,%edx
80102120:	8b 45 14             	mov    0x14(%ebp),%eax
80102123:	2b 45 f4             	sub    -0xc(%ebp),%eax
80102126:	39 c2                	cmp    %eax,%edx
80102128:	0f 46 c2             	cmovbe %edx,%eax
8010212b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
8010212e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102131:	8d 50 18             	lea    0x18(%eax),%edx
80102134:	8b 45 10             	mov    0x10(%ebp),%eax
80102137:	25 ff 01 00 00       	and    $0x1ff,%eax
8010213c:	01 d0                	add    %edx,%eax
8010213e:	83 ec 04             	sub    $0x4,%esp
80102141:	ff 75 ec             	pushl  -0x14(%ebp)
80102144:	ff 75 0c             	pushl  0xc(%ebp)
80102147:	50                   	push   %eax
80102148:	e8 20 37 00 00       	call   8010586d <memmove>
8010214d:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
80102150:	83 ec 0c             	sub    $0xc,%esp
80102153:	ff 75 f0             	pushl  -0x10(%ebp)
80102156:	e8 2a 16 00 00       	call   80103785 <log_write>
8010215b:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
8010215e:	83 ec 0c             	sub    $0xc,%esp
80102161:	ff 75 f0             	pushl  -0x10(%ebp)
80102164:	e8 c5 e0 ff ff       	call   8010022e <brelse>
80102169:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010216c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010216f:	01 45 f4             	add    %eax,-0xc(%ebp)
80102172:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102175:	01 45 10             	add    %eax,0x10(%ebp)
80102178:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010217b:	01 45 0c             	add    %eax,0xc(%ebp)
8010217e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102181:	3b 45 14             	cmp    0x14(%ebp),%eax
80102184:	0f 82 5b ff ff ff    	jb     801020e5 <writei+0xb6>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
8010218a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
8010218e:	74 22                	je     801021b2 <writei+0x183>
80102190:	8b 45 08             	mov    0x8(%ebp),%eax
80102193:	8b 40 18             	mov    0x18(%eax),%eax
80102196:	3b 45 10             	cmp    0x10(%ebp),%eax
80102199:	73 17                	jae    801021b2 <writei+0x183>
    ip->size = off;
8010219b:	8b 45 08             	mov    0x8(%ebp),%eax
8010219e:	8b 55 10             	mov    0x10(%ebp),%edx
801021a1:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
801021a4:	83 ec 0c             	sub    $0xc,%esp
801021a7:	ff 75 08             	pushl  0x8(%ebp)
801021aa:	e8 e1 f5 ff ff       	call   80101790 <iupdate>
801021af:	83 c4 10             	add    $0x10,%esp
  }
  return n;
801021b2:	8b 45 14             	mov    0x14(%ebp),%eax
}
801021b5:	c9                   	leave  
801021b6:	c3                   	ret    

801021b7 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
801021b7:	55                   	push   %ebp
801021b8:	89 e5                	mov    %esp,%ebp
801021ba:	83 ec 08             	sub    $0x8,%esp
  return strncmp(s, t, DIRSIZ);
801021bd:	83 ec 04             	sub    $0x4,%esp
801021c0:	6a 0e                	push   $0xe
801021c2:	ff 75 0c             	pushl  0xc(%ebp)
801021c5:	ff 75 08             	pushl  0x8(%ebp)
801021c8:	e8 36 37 00 00       	call   80105903 <strncmp>
801021cd:	83 c4 10             	add    $0x10,%esp
}
801021d0:	c9                   	leave  
801021d1:	c3                   	ret    

801021d2 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
801021d2:	55                   	push   %ebp
801021d3:	89 e5                	mov    %esp,%ebp
801021d5:	83 ec 28             	sub    $0x28,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
801021d8:	8b 45 08             	mov    0x8(%ebp),%eax
801021db:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801021df:	66 83 f8 01          	cmp    $0x1,%ax
801021e3:	74 0d                	je     801021f2 <dirlookup+0x20>
    panic("dirlookup not DIR");
801021e5:	83 ec 0c             	sub    $0xc,%esp
801021e8:	68 a3 8c 10 80       	push   $0x80108ca3
801021ed:	e8 74 e3 ff ff       	call   80100566 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
801021f2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801021f9:	eb 7b                	jmp    80102276 <dirlookup+0xa4>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021fb:	6a 10                	push   $0x10
801021fd:	ff 75 f4             	pushl  -0xc(%ebp)
80102200:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102203:	50                   	push   %eax
80102204:	ff 75 08             	pushl  0x8(%ebp)
80102207:	e8 cc fc ff ff       	call   80101ed8 <readi>
8010220c:	83 c4 10             	add    $0x10,%esp
8010220f:	83 f8 10             	cmp    $0x10,%eax
80102212:	74 0d                	je     80102221 <dirlookup+0x4f>
      panic("dirlink read");
80102214:	83 ec 0c             	sub    $0xc,%esp
80102217:	68 b5 8c 10 80       	push   $0x80108cb5
8010221c:	e8 45 e3 ff ff       	call   80100566 <panic>
    if(de.inum == 0)
80102221:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102225:	66 85 c0             	test   %ax,%ax
80102228:	74 47                	je     80102271 <dirlookup+0x9f>
      continue;
    if(namecmp(name, de.name) == 0){
8010222a:	83 ec 08             	sub    $0x8,%esp
8010222d:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102230:	83 c0 02             	add    $0x2,%eax
80102233:	50                   	push   %eax
80102234:	ff 75 0c             	pushl  0xc(%ebp)
80102237:	e8 7b ff ff ff       	call   801021b7 <namecmp>
8010223c:	83 c4 10             	add    $0x10,%esp
8010223f:	85 c0                	test   %eax,%eax
80102241:	75 2f                	jne    80102272 <dirlookup+0xa0>
      // entry matches path element
      if(poff)
80102243:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80102247:	74 08                	je     80102251 <dirlookup+0x7f>
        *poff = off;
80102249:	8b 45 10             	mov    0x10(%ebp),%eax
8010224c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010224f:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
80102251:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102255:	0f b7 c0             	movzwl %ax,%eax
80102258:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
8010225b:	8b 45 08             	mov    0x8(%ebp),%eax
8010225e:	8b 00                	mov    (%eax),%eax
80102260:	83 ec 08             	sub    $0x8,%esp
80102263:	ff 75 f0             	pushl  -0x10(%ebp)
80102266:	50                   	push   %eax
80102267:	e8 e5 f5 ff ff       	call   80101851 <iget>
8010226c:	83 c4 10             	add    $0x10,%esp
8010226f:	eb 19                	jmp    8010228a <dirlookup+0xb8>

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      continue;
80102271:	90                   	nop
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102272:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80102276:	8b 45 08             	mov    0x8(%ebp),%eax
80102279:	8b 40 18             	mov    0x18(%eax),%eax
8010227c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010227f:	0f 87 76 ff ff ff    	ja     801021fb <dirlookup+0x29>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80102285:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010228a:	c9                   	leave  
8010228b:	c3                   	ret    

8010228c <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
8010228c:	55                   	push   %ebp
8010228d:	89 e5                	mov    %esp,%ebp
8010228f:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80102292:	83 ec 04             	sub    $0x4,%esp
80102295:	6a 00                	push   $0x0
80102297:	ff 75 0c             	pushl  0xc(%ebp)
8010229a:	ff 75 08             	pushl  0x8(%ebp)
8010229d:	e8 30 ff ff ff       	call   801021d2 <dirlookup>
801022a2:	83 c4 10             	add    $0x10,%esp
801022a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
801022a8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801022ac:	74 18                	je     801022c6 <dirlink+0x3a>
    iput(ip);
801022ae:	83 ec 0c             	sub    $0xc,%esp
801022b1:	ff 75 f0             	pushl  -0x10(%ebp)
801022b4:	e8 81 f8 ff ff       	call   80101b3a <iput>
801022b9:	83 c4 10             	add    $0x10,%esp
    return -1;
801022bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801022c1:	e9 9c 00 00 00       	jmp    80102362 <dirlink+0xd6>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801022c6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801022cd:	eb 39                	jmp    80102308 <dirlink+0x7c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801022cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022d2:	6a 10                	push   $0x10
801022d4:	50                   	push   %eax
801022d5:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022d8:	50                   	push   %eax
801022d9:	ff 75 08             	pushl  0x8(%ebp)
801022dc:	e8 f7 fb ff ff       	call   80101ed8 <readi>
801022e1:	83 c4 10             	add    $0x10,%esp
801022e4:	83 f8 10             	cmp    $0x10,%eax
801022e7:	74 0d                	je     801022f6 <dirlink+0x6a>
      panic("dirlink read");
801022e9:	83 ec 0c             	sub    $0xc,%esp
801022ec:	68 b5 8c 10 80       	push   $0x80108cb5
801022f1:	e8 70 e2 ff ff       	call   80100566 <panic>
    if(de.inum == 0)
801022f6:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801022fa:	66 85 c0             	test   %ax,%ax
801022fd:	74 18                	je     80102317 <dirlink+0x8b>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801022ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102302:	83 c0 10             	add    $0x10,%eax
80102305:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102308:	8b 45 08             	mov    0x8(%ebp),%eax
8010230b:	8b 50 18             	mov    0x18(%eax),%edx
8010230e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102311:	39 c2                	cmp    %eax,%edx
80102313:	77 ba                	ja     801022cf <dirlink+0x43>
80102315:	eb 01                	jmp    80102318 <dirlink+0x8c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      break;
80102317:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
80102318:	83 ec 04             	sub    $0x4,%esp
8010231b:	6a 0e                	push   $0xe
8010231d:	ff 75 0c             	pushl  0xc(%ebp)
80102320:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102323:	83 c0 02             	add    $0x2,%eax
80102326:	50                   	push   %eax
80102327:	e8 2d 36 00 00       	call   80105959 <strncpy>
8010232c:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
8010232f:	8b 45 10             	mov    0x10(%ebp),%eax
80102332:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102336:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102339:	6a 10                	push   $0x10
8010233b:	50                   	push   %eax
8010233c:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010233f:	50                   	push   %eax
80102340:	ff 75 08             	pushl  0x8(%ebp)
80102343:	e8 e7 fc ff ff       	call   8010202f <writei>
80102348:	83 c4 10             	add    $0x10,%esp
8010234b:	83 f8 10             	cmp    $0x10,%eax
8010234e:	74 0d                	je     8010235d <dirlink+0xd1>
    panic("dirlink");
80102350:	83 ec 0c             	sub    $0xc,%esp
80102353:	68 c2 8c 10 80       	push   $0x80108cc2
80102358:	e8 09 e2 ff ff       	call   80100566 <panic>
  
  return 0;
8010235d:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102362:	c9                   	leave  
80102363:	c3                   	ret    

80102364 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
80102364:	55                   	push   %ebp
80102365:	89 e5                	mov    %esp,%ebp
80102367:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int len;

  while(*path == '/')
8010236a:	eb 04                	jmp    80102370 <skipelem+0xc>
    path++;
8010236c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80102370:	8b 45 08             	mov    0x8(%ebp),%eax
80102373:	0f b6 00             	movzbl (%eax),%eax
80102376:	3c 2f                	cmp    $0x2f,%al
80102378:	74 f2                	je     8010236c <skipelem+0x8>
    path++;
  if(*path == 0)
8010237a:	8b 45 08             	mov    0x8(%ebp),%eax
8010237d:	0f b6 00             	movzbl (%eax),%eax
80102380:	84 c0                	test   %al,%al
80102382:	75 07                	jne    8010238b <skipelem+0x27>
    return 0;
80102384:	b8 00 00 00 00       	mov    $0x0,%eax
80102389:	eb 7b                	jmp    80102406 <skipelem+0xa2>
  s = path;
8010238b:	8b 45 08             	mov    0x8(%ebp),%eax
8010238e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
80102391:	eb 04                	jmp    80102397 <skipelem+0x33>
    path++;
80102393:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102397:	8b 45 08             	mov    0x8(%ebp),%eax
8010239a:	0f b6 00             	movzbl (%eax),%eax
8010239d:	3c 2f                	cmp    $0x2f,%al
8010239f:	74 0a                	je     801023ab <skipelem+0x47>
801023a1:	8b 45 08             	mov    0x8(%ebp),%eax
801023a4:	0f b6 00             	movzbl (%eax),%eax
801023a7:	84 c0                	test   %al,%al
801023a9:	75 e8                	jne    80102393 <skipelem+0x2f>
    path++;
  len = path - s;
801023ab:	8b 55 08             	mov    0x8(%ebp),%edx
801023ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023b1:	29 c2                	sub    %eax,%edx
801023b3:	89 d0                	mov    %edx,%eax
801023b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
801023b8:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
801023bc:	7e 15                	jle    801023d3 <skipelem+0x6f>
    memmove(name, s, DIRSIZ);
801023be:	83 ec 04             	sub    $0x4,%esp
801023c1:	6a 0e                	push   $0xe
801023c3:	ff 75 f4             	pushl  -0xc(%ebp)
801023c6:	ff 75 0c             	pushl  0xc(%ebp)
801023c9:	e8 9f 34 00 00       	call   8010586d <memmove>
801023ce:	83 c4 10             	add    $0x10,%esp
801023d1:	eb 26                	jmp    801023f9 <skipelem+0x95>
  else {
    memmove(name, s, len);
801023d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023d6:	83 ec 04             	sub    $0x4,%esp
801023d9:	50                   	push   %eax
801023da:	ff 75 f4             	pushl  -0xc(%ebp)
801023dd:	ff 75 0c             	pushl  0xc(%ebp)
801023e0:	e8 88 34 00 00       	call   8010586d <memmove>
801023e5:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
801023e8:	8b 55 f0             	mov    -0x10(%ebp),%edx
801023eb:	8b 45 0c             	mov    0xc(%ebp),%eax
801023ee:	01 d0                	add    %edx,%eax
801023f0:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
801023f3:	eb 04                	jmp    801023f9 <skipelem+0x95>
    path++;
801023f5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
801023f9:	8b 45 08             	mov    0x8(%ebp),%eax
801023fc:	0f b6 00             	movzbl (%eax),%eax
801023ff:	3c 2f                	cmp    $0x2f,%al
80102401:	74 f2                	je     801023f5 <skipelem+0x91>
    path++;
  return path;
80102403:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102406:	c9                   	leave  
80102407:	c3                   	ret    

80102408 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102408:	55                   	push   %ebp
80102409:	89 e5                	mov    %esp,%ebp
8010240b:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *next;

  if(*path == '/')
8010240e:	8b 45 08             	mov    0x8(%ebp),%eax
80102411:	0f b6 00             	movzbl (%eax),%eax
80102414:	3c 2f                	cmp    $0x2f,%al
80102416:	75 17                	jne    8010242f <namex+0x27>
    ip = iget(ROOTDEV, ROOTINO);
80102418:	83 ec 08             	sub    $0x8,%esp
8010241b:	6a 01                	push   $0x1
8010241d:	6a 01                	push   $0x1
8010241f:	e8 2d f4 ff ff       	call   80101851 <iget>
80102424:	83 c4 10             	add    $0x10,%esp
80102427:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010242a:	e9 bb 00 00 00       	jmp    801024ea <namex+0xe2>
  else
    ip = idup(proc->cwd);
8010242f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80102435:	8b 40 68             	mov    0x68(%eax),%eax
80102438:	83 ec 0c             	sub    $0xc,%esp
8010243b:	50                   	push   %eax
8010243c:	e8 ef f4 ff ff       	call   80101930 <idup>
80102441:	83 c4 10             	add    $0x10,%esp
80102444:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
80102447:	e9 9e 00 00 00       	jmp    801024ea <namex+0xe2>
    ilock(ip);
8010244c:	83 ec 0c             	sub    $0xc,%esp
8010244f:	ff 75 f4             	pushl  -0xc(%ebp)
80102452:	e8 13 f5 ff ff       	call   8010196a <ilock>
80102457:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
8010245a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010245d:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102461:	66 83 f8 01          	cmp    $0x1,%ax
80102465:	74 18                	je     8010247f <namex+0x77>
      iunlockput(ip);
80102467:	83 ec 0c             	sub    $0xc,%esp
8010246a:	ff 75 f4             	pushl  -0xc(%ebp)
8010246d:	e8 b8 f7 ff ff       	call   80101c2a <iunlockput>
80102472:	83 c4 10             	add    $0x10,%esp
      return 0;
80102475:	b8 00 00 00 00       	mov    $0x0,%eax
8010247a:	e9 a7 00 00 00       	jmp    80102526 <namex+0x11e>
    }
    if(nameiparent && *path == '\0'){
8010247f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102483:	74 20                	je     801024a5 <namex+0x9d>
80102485:	8b 45 08             	mov    0x8(%ebp),%eax
80102488:	0f b6 00             	movzbl (%eax),%eax
8010248b:	84 c0                	test   %al,%al
8010248d:	75 16                	jne    801024a5 <namex+0x9d>
      // Stop one level early.
      iunlock(ip);
8010248f:	83 ec 0c             	sub    $0xc,%esp
80102492:	ff 75 f4             	pushl  -0xc(%ebp)
80102495:	e8 2e f6 ff ff       	call   80101ac8 <iunlock>
8010249a:	83 c4 10             	add    $0x10,%esp
      return ip;
8010249d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801024a0:	e9 81 00 00 00       	jmp    80102526 <namex+0x11e>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
801024a5:	83 ec 04             	sub    $0x4,%esp
801024a8:	6a 00                	push   $0x0
801024aa:	ff 75 10             	pushl  0x10(%ebp)
801024ad:	ff 75 f4             	pushl  -0xc(%ebp)
801024b0:	e8 1d fd ff ff       	call   801021d2 <dirlookup>
801024b5:	83 c4 10             	add    $0x10,%esp
801024b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
801024bb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801024bf:	75 15                	jne    801024d6 <namex+0xce>
      iunlockput(ip);
801024c1:	83 ec 0c             	sub    $0xc,%esp
801024c4:	ff 75 f4             	pushl  -0xc(%ebp)
801024c7:	e8 5e f7 ff ff       	call   80101c2a <iunlockput>
801024cc:	83 c4 10             	add    $0x10,%esp
      return 0;
801024cf:	b8 00 00 00 00       	mov    $0x0,%eax
801024d4:	eb 50                	jmp    80102526 <namex+0x11e>
    }
    iunlockput(ip);
801024d6:	83 ec 0c             	sub    $0xc,%esp
801024d9:	ff 75 f4             	pushl  -0xc(%ebp)
801024dc:	e8 49 f7 ff ff       	call   80101c2a <iunlockput>
801024e1:	83 c4 10             	add    $0x10,%esp
    ip = next;
801024e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801024e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
801024ea:	83 ec 08             	sub    $0x8,%esp
801024ed:	ff 75 10             	pushl  0x10(%ebp)
801024f0:	ff 75 08             	pushl  0x8(%ebp)
801024f3:	e8 6c fe ff ff       	call   80102364 <skipelem>
801024f8:	83 c4 10             	add    $0x10,%esp
801024fb:	89 45 08             	mov    %eax,0x8(%ebp)
801024fe:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102502:	0f 85 44 ff ff ff    	jne    8010244c <namex+0x44>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102508:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010250c:	74 15                	je     80102523 <namex+0x11b>
    iput(ip);
8010250e:	83 ec 0c             	sub    $0xc,%esp
80102511:	ff 75 f4             	pushl  -0xc(%ebp)
80102514:	e8 21 f6 ff ff       	call   80101b3a <iput>
80102519:	83 c4 10             	add    $0x10,%esp
    return 0;
8010251c:	b8 00 00 00 00       	mov    $0x0,%eax
80102521:	eb 03                	jmp    80102526 <namex+0x11e>
  }
  return ip;
80102523:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102526:	c9                   	leave  
80102527:	c3                   	ret    

80102528 <namei>:

struct inode*
namei(char *path)
{
80102528:	55                   	push   %ebp
80102529:	89 e5                	mov    %esp,%ebp
8010252b:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
8010252e:	83 ec 04             	sub    $0x4,%esp
80102531:	8d 45 ea             	lea    -0x16(%ebp),%eax
80102534:	50                   	push   %eax
80102535:	6a 00                	push   $0x0
80102537:	ff 75 08             	pushl  0x8(%ebp)
8010253a:	e8 c9 fe ff ff       	call   80102408 <namex>
8010253f:	83 c4 10             	add    $0x10,%esp
}
80102542:	c9                   	leave  
80102543:	c3                   	ret    

80102544 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102544:	55                   	push   %ebp
80102545:	89 e5                	mov    %esp,%ebp
80102547:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
8010254a:	83 ec 04             	sub    $0x4,%esp
8010254d:	ff 75 0c             	pushl  0xc(%ebp)
80102550:	6a 01                	push   $0x1
80102552:	ff 75 08             	pushl  0x8(%ebp)
80102555:	e8 ae fe ff ff       	call   80102408 <namex>
8010255a:	83 c4 10             	add    $0x10,%esp
}
8010255d:	c9                   	leave  
8010255e:	c3                   	ret    

8010255f <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
8010255f:	55                   	push   %ebp
80102560:	89 e5                	mov    %esp,%ebp
80102562:	83 ec 14             	sub    $0x14,%esp
80102565:	8b 45 08             	mov    0x8(%ebp),%eax
80102568:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010256c:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102570:	89 c2                	mov    %eax,%edx
80102572:	ec                   	in     (%dx),%al
80102573:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102576:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
8010257a:	c9                   	leave  
8010257b:	c3                   	ret    

8010257c <insl>:

static inline void
insl(int port, void *addr, int cnt)
{
8010257c:	55                   	push   %ebp
8010257d:	89 e5                	mov    %esp,%ebp
8010257f:	57                   	push   %edi
80102580:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
80102581:	8b 55 08             	mov    0x8(%ebp),%edx
80102584:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102587:	8b 45 10             	mov    0x10(%ebp),%eax
8010258a:	89 cb                	mov    %ecx,%ebx
8010258c:	89 df                	mov    %ebx,%edi
8010258e:	89 c1                	mov    %eax,%ecx
80102590:	fc                   	cld    
80102591:	f3 6d                	rep insl (%dx),%es:(%edi)
80102593:	89 c8                	mov    %ecx,%eax
80102595:	89 fb                	mov    %edi,%ebx
80102597:	89 5d 0c             	mov    %ebx,0xc(%ebp)
8010259a:	89 45 10             	mov    %eax,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "memory", "cc");
}
8010259d:	90                   	nop
8010259e:	5b                   	pop    %ebx
8010259f:	5f                   	pop    %edi
801025a0:	5d                   	pop    %ebp
801025a1:	c3                   	ret    

801025a2 <outb>:

static inline void
outb(ushort port, uchar data)
{
801025a2:	55                   	push   %ebp
801025a3:	89 e5                	mov    %esp,%ebp
801025a5:	83 ec 08             	sub    $0x8,%esp
801025a8:	8b 55 08             	mov    0x8(%ebp),%edx
801025ab:	8b 45 0c             	mov    0xc(%ebp),%eax
801025ae:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801025b2:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801025b5:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801025b9:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801025bd:	ee                   	out    %al,(%dx)
}
801025be:	90                   	nop
801025bf:	c9                   	leave  
801025c0:	c3                   	ret    

801025c1 <outsl>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
outsl(int port, const void *addr, int cnt)
{
801025c1:	55                   	push   %ebp
801025c2:	89 e5                	mov    %esp,%ebp
801025c4:	56                   	push   %esi
801025c5:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
801025c6:	8b 55 08             	mov    0x8(%ebp),%edx
801025c9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801025cc:	8b 45 10             	mov    0x10(%ebp),%eax
801025cf:	89 cb                	mov    %ecx,%ebx
801025d1:	89 de                	mov    %ebx,%esi
801025d3:	89 c1                	mov    %eax,%ecx
801025d5:	fc                   	cld    
801025d6:	f3 6f                	rep outsl %ds:(%esi),(%dx)
801025d8:	89 c8                	mov    %ecx,%eax
801025da:	89 f3                	mov    %esi,%ebx
801025dc:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801025df:	89 45 10             	mov    %eax,0x10(%ebp)
               "=S" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "cc");
}
801025e2:	90                   	nop
801025e3:	5b                   	pop    %ebx
801025e4:	5e                   	pop    %esi
801025e5:	5d                   	pop    %ebp
801025e6:	c3                   	ret    

801025e7 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
801025e7:	55                   	push   %ebp
801025e8:	89 e5                	mov    %esp,%ebp
801025ea:	83 ec 10             	sub    $0x10,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
801025ed:	90                   	nop
801025ee:	68 f7 01 00 00       	push   $0x1f7
801025f3:	e8 67 ff ff ff       	call   8010255f <inb>
801025f8:	83 c4 04             	add    $0x4,%esp
801025fb:	0f b6 c0             	movzbl %al,%eax
801025fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102601:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102604:	25 c0 00 00 00       	and    $0xc0,%eax
80102609:	83 f8 40             	cmp    $0x40,%eax
8010260c:	75 e0                	jne    801025ee <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010260e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102612:	74 11                	je     80102625 <idewait+0x3e>
80102614:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102617:	83 e0 21             	and    $0x21,%eax
8010261a:	85 c0                	test   %eax,%eax
8010261c:	74 07                	je     80102625 <idewait+0x3e>
    return -1;
8010261e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102623:	eb 05                	jmp    8010262a <idewait+0x43>
  return 0;
80102625:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010262a:	c9                   	leave  
8010262b:	c3                   	ret    

8010262c <ideinit>:

void
ideinit(void)
{
8010262c:	55                   	push   %ebp
8010262d:	89 e5                	mov    %esp,%ebp
8010262f:	83 ec 18             	sub    $0x18,%esp
  int i;
  
  initlock(&idelock, "ide");
80102632:	83 ec 08             	sub    $0x8,%esp
80102635:	68 ca 8c 10 80       	push   $0x80108cca
8010263a:	68 00 c6 10 80       	push   $0x8010c600
8010263f:	e8 e5 2e 00 00       	call   80105529 <initlock>
80102644:	83 c4 10             	add    $0x10,%esp
  picenable(IRQ_IDE);
80102647:	83 ec 0c             	sub    $0xc,%esp
8010264a:	6a 0e                	push   $0xe
8010264c:	e8 da 18 00 00       	call   80103f2b <picenable>
80102651:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
80102654:	a1 40 39 11 80       	mov    0x80113940,%eax
80102659:	83 e8 01             	sub    $0x1,%eax
8010265c:	83 ec 08             	sub    $0x8,%esp
8010265f:	50                   	push   %eax
80102660:	6a 0e                	push   $0xe
80102662:	e8 73 04 00 00       	call   80102ada <ioapicenable>
80102667:	83 c4 10             	add    $0x10,%esp
  idewait(0);
8010266a:	83 ec 0c             	sub    $0xc,%esp
8010266d:	6a 00                	push   $0x0
8010266f:	e8 73 ff ff ff       	call   801025e7 <idewait>
80102674:	83 c4 10             	add    $0x10,%esp
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
80102677:	83 ec 08             	sub    $0x8,%esp
8010267a:	68 f0 00 00 00       	push   $0xf0
8010267f:	68 f6 01 00 00       	push   $0x1f6
80102684:	e8 19 ff ff ff       	call   801025a2 <outb>
80102689:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<1000; i++){
8010268c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102693:	eb 24                	jmp    801026b9 <ideinit+0x8d>
    if(inb(0x1f7) != 0){
80102695:	83 ec 0c             	sub    $0xc,%esp
80102698:	68 f7 01 00 00       	push   $0x1f7
8010269d:	e8 bd fe ff ff       	call   8010255f <inb>
801026a2:	83 c4 10             	add    $0x10,%esp
801026a5:	84 c0                	test   %al,%al
801026a7:	74 0c                	je     801026b5 <ideinit+0x89>
      havedisk1 = 1;
801026a9:	c7 05 38 c6 10 80 01 	movl   $0x1,0x8010c638
801026b0:	00 00 00 
      break;
801026b3:	eb 0d                	jmp    801026c2 <ideinit+0x96>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
801026b5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801026b9:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
801026c0:	7e d3                	jle    80102695 <ideinit+0x69>
      break;
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
801026c2:	83 ec 08             	sub    $0x8,%esp
801026c5:	68 e0 00 00 00       	push   $0xe0
801026ca:	68 f6 01 00 00       	push   $0x1f6
801026cf:	e8 ce fe ff ff       	call   801025a2 <outb>
801026d4:	83 c4 10             	add    $0x10,%esp
}
801026d7:	90                   	nop
801026d8:	c9                   	leave  
801026d9:	c3                   	ret    

801026da <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801026da:	55                   	push   %ebp
801026db:	89 e5                	mov    %esp,%ebp
801026dd:	83 ec 18             	sub    $0x18,%esp
  if(b == 0)
801026e0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801026e4:	75 0d                	jne    801026f3 <idestart+0x19>
    panic("idestart");
801026e6:	83 ec 0c             	sub    $0xc,%esp
801026e9:	68 ce 8c 10 80       	push   $0x80108cce
801026ee:	e8 73 de ff ff       	call   80100566 <panic>
  if(b->blockno >= FSSIZE)
801026f3:	8b 45 08             	mov    0x8(%ebp),%eax
801026f6:	8b 40 08             	mov    0x8(%eax),%eax
801026f9:	3d e7 03 00 00       	cmp    $0x3e7,%eax
801026fe:	76 0d                	jbe    8010270d <idestart+0x33>
    panic("incorrect blockno");
80102700:	83 ec 0c             	sub    $0xc,%esp
80102703:	68 d7 8c 10 80       	push   $0x80108cd7
80102708:	e8 59 de ff ff       	call   80100566 <panic>
  int sector_per_block =  BSIZE/SECTOR_SIZE;
8010270d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  int sector = b->blockno * sector_per_block;
80102714:	8b 45 08             	mov    0x8(%ebp),%eax
80102717:	8b 50 08             	mov    0x8(%eax),%edx
8010271a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010271d:	0f af c2             	imul   %edx,%eax
80102720:	89 45 f0             	mov    %eax,-0x10(%ebp)

  if (sector_per_block > 7) panic("idestart");
80102723:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
80102727:	7e 0d                	jle    80102736 <idestart+0x5c>
80102729:	83 ec 0c             	sub    $0xc,%esp
8010272c:	68 ce 8c 10 80       	push   $0x80108cce
80102731:	e8 30 de ff ff       	call   80100566 <panic>
  
  idewait(0);
80102736:	83 ec 0c             	sub    $0xc,%esp
80102739:	6a 00                	push   $0x0
8010273b:	e8 a7 fe ff ff       	call   801025e7 <idewait>
80102740:	83 c4 10             	add    $0x10,%esp
  outb(0x3f6, 0);  // generate interrupt
80102743:	83 ec 08             	sub    $0x8,%esp
80102746:	6a 00                	push   $0x0
80102748:	68 f6 03 00 00       	push   $0x3f6
8010274d:	e8 50 fe ff ff       	call   801025a2 <outb>
80102752:	83 c4 10             	add    $0x10,%esp
  outb(0x1f2, sector_per_block);  // number of sectors
80102755:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102758:	0f b6 c0             	movzbl %al,%eax
8010275b:	83 ec 08             	sub    $0x8,%esp
8010275e:	50                   	push   %eax
8010275f:	68 f2 01 00 00       	push   $0x1f2
80102764:	e8 39 fe ff ff       	call   801025a2 <outb>
80102769:	83 c4 10             	add    $0x10,%esp
  outb(0x1f3, sector & 0xff);
8010276c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010276f:	0f b6 c0             	movzbl %al,%eax
80102772:	83 ec 08             	sub    $0x8,%esp
80102775:	50                   	push   %eax
80102776:	68 f3 01 00 00       	push   $0x1f3
8010277b:	e8 22 fe ff ff       	call   801025a2 <outb>
80102780:	83 c4 10             	add    $0x10,%esp
  outb(0x1f4, (sector >> 8) & 0xff);
80102783:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102786:	c1 f8 08             	sar    $0x8,%eax
80102789:	0f b6 c0             	movzbl %al,%eax
8010278c:	83 ec 08             	sub    $0x8,%esp
8010278f:	50                   	push   %eax
80102790:	68 f4 01 00 00       	push   $0x1f4
80102795:	e8 08 fe ff ff       	call   801025a2 <outb>
8010279a:	83 c4 10             	add    $0x10,%esp
  outb(0x1f5, (sector >> 16) & 0xff);
8010279d:	8b 45 f0             	mov    -0x10(%ebp),%eax
801027a0:	c1 f8 10             	sar    $0x10,%eax
801027a3:	0f b6 c0             	movzbl %al,%eax
801027a6:	83 ec 08             	sub    $0x8,%esp
801027a9:	50                   	push   %eax
801027aa:	68 f5 01 00 00       	push   $0x1f5
801027af:	e8 ee fd ff ff       	call   801025a2 <outb>
801027b4:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801027b7:	8b 45 08             	mov    0x8(%ebp),%eax
801027ba:	8b 40 04             	mov    0x4(%eax),%eax
801027bd:	83 e0 01             	and    $0x1,%eax
801027c0:	c1 e0 04             	shl    $0x4,%eax
801027c3:	89 c2                	mov    %eax,%edx
801027c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801027c8:	c1 f8 18             	sar    $0x18,%eax
801027cb:	83 e0 0f             	and    $0xf,%eax
801027ce:	09 d0                	or     %edx,%eax
801027d0:	83 c8 e0             	or     $0xffffffe0,%eax
801027d3:	0f b6 c0             	movzbl %al,%eax
801027d6:	83 ec 08             	sub    $0x8,%esp
801027d9:	50                   	push   %eax
801027da:	68 f6 01 00 00       	push   $0x1f6
801027df:	e8 be fd ff ff       	call   801025a2 <outb>
801027e4:	83 c4 10             	add    $0x10,%esp
  if(b->flags & B_DIRTY){
801027e7:	8b 45 08             	mov    0x8(%ebp),%eax
801027ea:	8b 00                	mov    (%eax),%eax
801027ec:	83 e0 04             	and    $0x4,%eax
801027ef:	85 c0                	test   %eax,%eax
801027f1:	74 30                	je     80102823 <idestart+0x149>
    outb(0x1f7, IDE_CMD_WRITE);
801027f3:	83 ec 08             	sub    $0x8,%esp
801027f6:	6a 30                	push   $0x30
801027f8:	68 f7 01 00 00       	push   $0x1f7
801027fd:	e8 a0 fd ff ff       	call   801025a2 <outb>
80102802:	83 c4 10             	add    $0x10,%esp
    outsl(0x1f0, b->data, BSIZE/4);
80102805:	8b 45 08             	mov    0x8(%ebp),%eax
80102808:	83 c0 18             	add    $0x18,%eax
8010280b:	83 ec 04             	sub    $0x4,%esp
8010280e:	68 80 00 00 00       	push   $0x80
80102813:	50                   	push   %eax
80102814:	68 f0 01 00 00       	push   $0x1f0
80102819:	e8 a3 fd ff ff       	call   801025c1 <outsl>
8010281e:	83 c4 10             	add    $0x10,%esp
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
80102821:	eb 12                	jmp    80102835 <idestart+0x15b>
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, IDE_CMD_WRITE);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, IDE_CMD_READ);
80102823:	83 ec 08             	sub    $0x8,%esp
80102826:	6a 20                	push   $0x20
80102828:	68 f7 01 00 00       	push   $0x1f7
8010282d:	e8 70 fd ff ff       	call   801025a2 <outb>
80102832:	83 c4 10             	add    $0x10,%esp
  }
}
80102835:	90                   	nop
80102836:	c9                   	leave  
80102837:	c3                   	ret    

80102838 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102838:	55                   	push   %ebp
80102839:	89 e5                	mov    %esp,%ebp
8010283b:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
8010283e:	83 ec 0c             	sub    $0xc,%esp
80102841:	68 00 c6 10 80       	push   $0x8010c600
80102846:	e8 00 2d 00 00       	call   8010554b <acquire>
8010284b:	83 c4 10             	add    $0x10,%esp
  if((b = idequeue) == 0){
8010284e:	a1 34 c6 10 80       	mov    0x8010c634,%eax
80102853:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102856:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010285a:	75 15                	jne    80102871 <ideintr+0x39>
    release(&idelock);
8010285c:	83 ec 0c             	sub    $0xc,%esp
8010285f:	68 00 c6 10 80       	push   $0x8010c600
80102864:	e8 49 2d 00 00       	call   801055b2 <release>
80102869:	83 c4 10             	add    $0x10,%esp
    // cprintf("spurious IDE interrupt\n");
    return;
8010286c:	e9 9a 00 00 00       	jmp    8010290b <ideintr+0xd3>
  }
  idequeue = b->qnext;
80102871:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102874:	8b 40 14             	mov    0x14(%eax),%eax
80102877:	a3 34 c6 10 80       	mov    %eax,0x8010c634

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
8010287c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010287f:	8b 00                	mov    (%eax),%eax
80102881:	83 e0 04             	and    $0x4,%eax
80102884:	85 c0                	test   %eax,%eax
80102886:	75 2d                	jne    801028b5 <ideintr+0x7d>
80102888:	83 ec 0c             	sub    $0xc,%esp
8010288b:	6a 01                	push   $0x1
8010288d:	e8 55 fd ff ff       	call   801025e7 <idewait>
80102892:	83 c4 10             	add    $0x10,%esp
80102895:	85 c0                	test   %eax,%eax
80102897:	78 1c                	js     801028b5 <ideintr+0x7d>
    insl(0x1f0, b->data, BSIZE/4);
80102899:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010289c:	83 c0 18             	add    $0x18,%eax
8010289f:	83 ec 04             	sub    $0x4,%esp
801028a2:	68 80 00 00 00       	push   $0x80
801028a7:	50                   	push   %eax
801028a8:	68 f0 01 00 00       	push   $0x1f0
801028ad:	e8 ca fc ff ff       	call   8010257c <insl>
801028b2:	83 c4 10             	add    $0x10,%esp
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
801028b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028b8:	8b 00                	mov    (%eax),%eax
801028ba:	83 c8 02             	or     $0x2,%eax
801028bd:	89 c2                	mov    %eax,%edx
801028bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028c2:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
801028c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028c7:	8b 00                	mov    (%eax),%eax
801028c9:	83 e0 fb             	and    $0xfffffffb,%eax
801028cc:	89 c2                	mov    %eax,%edx
801028ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028d1:	89 10                	mov    %edx,(%eax)
  wakeup(b);
801028d3:	83 ec 0c             	sub    $0xc,%esp
801028d6:	ff 75 f4             	pushl  -0xc(%ebp)
801028d9:	e8 37 26 00 00       	call   80104f15 <wakeup>
801028de:	83 c4 10             	add    $0x10,%esp
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
801028e1:	a1 34 c6 10 80       	mov    0x8010c634,%eax
801028e6:	85 c0                	test   %eax,%eax
801028e8:	74 11                	je     801028fb <ideintr+0xc3>
    idestart(idequeue);
801028ea:	a1 34 c6 10 80       	mov    0x8010c634,%eax
801028ef:	83 ec 0c             	sub    $0xc,%esp
801028f2:	50                   	push   %eax
801028f3:	e8 e2 fd ff ff       	call   801026da <idestart>
801028f8:	83 c4 10             	add    $0x10,%esp

  release(&idelock);
801028fb:	83 ec 0c             	sub    $0xc,%esp
801028fe:	68 00 c6 10 80       	push   $0x8010c600
80102903:	e8 aa 2c 00 00       	call   801055b2 <release>
80102908:	83 c4 10             	add    $0x10,%esp
}
8010290b:	c9                   	leave  
8010290c:	c3                   	ret    

8010290d <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
8010290d:	55                   	push   %ebp
8010290e:	89 e5                	mov    %esp,%ebp
80102910:	83 ec 18             	sub    $0x18,%esp
  struct buf **pp;

  if(!(b->flags & B_BUSY))
80102913:	8b 45 08             	mov    0x8(%ebp),%eax
80102916:	8b 00                	mov    (%eax),%eax
80102918:	83 e0 01             	and    $0x1,%eax
8010291b:	85 c0                	test   %eax,%eax
8010291d:	75 0d                	jne    8010292c <iderw+0x1f>
    panic("iderw: buf not busy");
8010291f:	83 ec 0c             	sub    $0xc,%esp
80102922:	68 e9 8c 10 80       	push   $0x80108ce9
80102927:	e8 3a dc ff ff       	call   80100566 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010292c:	8b 45 08             	mov    0x8(%ebp),%eax
8010292f:	8b 00                	mov    (%eax),%eax
80102931:	83 e0 06             	and    $0x6,%eax
80102934:	83 f8 02             	cmp    $0x2,%eax
80102937:	75 0d                	jne    80102946 <iderw+0x39>
    panic("iderw: nothing to do");
80102939:	83 ec 0c             	sub    $0xc,%esp
8010293c:	68 fd 8c 10 80       	push   $0x80108cfd
80102941:	e8 20 dc ff ff       	call   80100566 <panic>
  if(b->dev != 0 && !havedisk1)
80102946:	8b 45 08             	mov    0x8(%ebp),%eax
80102949:	8b 40 04             	mov    0x4(%eax),%eax
8010294c:	85 c0                	test   %eax,%eax
8010294e:	74 16                	je     80102966 <iderw+0x59>
80102950:	a1 38 c6 10 80       	mov    0x8010c638,%eax
80102955:	85 c0                	test   %eax,%eax
80102957:	75 0d                	jne    80102966 <iderw+0x59>
    panic("iderw: ide disk 1 not present");
80102959:	83 ec 0c             	sub    $0xc,%esp
8010295c:	68 12 8d 10 80       	push   $0x80108d12
80102961:	e8 00 dc ff ff       	call   80100566 <panic>

  acquire(&idelock);  //DOC:acquire-lock
80102966:	83 ec 0c             	sub    $0xc,%esp
80102969:	68 00 c6 10 80       	push   $0x8010c600
8010296e:	e8 d8 2b 00 00       	call   8010554b <acquire>
80102973:	83 c4 10             	add    $0x10,%esp

  // Append b to idequeue.
  b->qnext = 0;
80102976:	8b 45 08             	mov    0x8(%ebp),%eax
80102979:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102980:	c7 45 f4 34 c6 10 80 	movl   $0x8010c634,-0xc(%ebp)
80102987:	eb 0b                	jmp    80102994 <iderw+0x87>
80102989:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010298c:	8b 00                	mov    (%eax),%eax
8010298e:	83 c0 14             	add    $0x14,%eax
80102991:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102994:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102997:	8b 00                	mov    (%eax),%eax
80102999:	85 c0                	test   %eax,%eax
8010299b:	75 ec                	jne    80102989 <iderw+0x7c>
    ;
  *pp = b;
8010299d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029a0:	8b 55 08             	mov    0x8(%ebp),%edx
801029a3:	89 10                	mov    %edx,(%eax)
  
  // Start disk if necessary.
  if(idequeue == b)
801029a5:	a1 34 c6 10 80       	mov    0x8010c634,%eax
801029aa:	3b 45 08             	cmp    0x8(%ebp),%eax
801029ad:	75 23                	jne    801029d2 <iderw+0xc5>
    idestart(b);
801029af:	83 ec 0c             	sub    $0xc,%esp
801029b2:	ff 75 08             	pushl  0x8(%ebp)
801029b5:	e8 20 fd ff ff       	call   801026da <idestart>
801029ba:	83 c4 10             	add    $0x10,%esp
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801029bd:	eb 13                	jmp    801029d2 <iderw+0xc5>
    sleep(b, &idelock);
801029bf:	83 ec 08             	sub    $0x8,%esp
801029c2:	68 00 c6 10 80       	push   $0x8010c600
801029c7:	ff 75 08             	pushl  0x8(%ebp)
801029ca:	e8 58 24 00 00       	call   80104e27 <sleep>
801029cf:	83 c4 10             	add    $0x10,%esp
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801029d2:	8b 45 08             	mov    0x8(%ebp),%eax
801029d5:	8b 00                	mov    (%eax),%eax
801029d7:	83 e0 06             	and    $0x6,%eax
801029da:	83 f8 02             	cmp    $0x2,%eax
801029dd:	75 e0                	jne    801029bf <iderw+0xb2>
    sleep(b, &idelock);
  }

  release(&idelock);
801029df:	83 ec 0c             	sub    $0xc,%esp
801029e2:	68 00 c6 10 80       	push   $0x8010c600
801029e7:	e8 c6 2b 00 00       	call   801055b2 <release>
801029ec:	83 c4 10             	add    $0x10,%esp
}
801029ef:	90                   	nop
801029f0:	c9                   	leave  
801029f1:	c3                   	ret    

801029f2 <ioapicread>:
801029f2:	55                   	push   %ebp
801029f3:	89 e5                	mov    %esp,%ebp
801029f5:	a1 14 32 11 80       	mov    0x80113214,%eax
801029fa:	8b 55 08             	mov    0x8(%ebp),%edx
801029fd:	89 10                	mov    %edx,(%eax)
801029ff:	a1 14 32 11 80       	mov    0x80113214,%eax
80102a04:	8b 40 10             	mov    0x10(%eax),%eax
80102a07:	5d                   	pop    %ebp
80102a08:	c3                   	ret    

80102a09 <ioapicwrite>:
80102a09:	55                   	push   %ebp
80102a0a:	89 e5                	mov    %esp,%ebp
80102a0c:	a1 14 32 11 80       	mov    0x80113214,%eax
80102a11:	8b 55 08             	mov    0x8(%ebp),%edx
80102a14:	89 10                	mov    %edx,(%eax)
80102a16:	a1 14 32 11 80       	mov    0x80113214,%eax
80102a1b:	8b 55 0c             	mov    0xc(%ebp),%edx
80102a1e:	89 50 10             	mov    %edx,0x10(%eax)
80102a21:	90                   	nop
80102a22:	5d                   	pop    %ebp
80102a23:	c3                   	ret    

80102a24 <ioapicinit>:
80102a24:	55                   	push   %ebp
80102a25:	89 e5                	mov    %esp,%ebp
80102a27:	83 ec 18             	sub    $0x18,%esp
80102a2a:	a1 44 33 11 80       	mov    0x80113344,%eax
80102a2f:	85 c0                	test   %eax,%eax
80102a31:	0f 84 a0 00 00 00    	je     80102ad7 <ioapicinit+0xb3>
80102a37:	c7 05 14 32 11 80 00 	movl   $0xfec00000,0x80113214
80102a3e:	00 c0 fe 
80102a41:	6a 01                	push   $0x1
80102a43:	e8 aa ff ff ff       	call   801029f2 <ioapicread>
80102a48:	83 c4 04             	add    $0x4,%esp
80102a4b:	c1 e8 10             	shr    $0x10,%eax
80102a4e:	25 ff 00 00 00       	and    $0xff,%eax
80102a53:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102a56:	6a 00                	push   $0x0
80102a58:	e8 95 ff ff ff       	call   801029f2 <ioapicread>
80102a5d:	83 c4 04             	add    $0x4,%esp
80102a60:	c1 e8 18             	shr    $0x18,%eax
80102a63:	89 45 ec             	mov    %eax,-0x14(%ebp)
80102a66:	0f b6 05 40 33 11 80 	movzbl 0x80113340,%eax
80102a6d:	0f b6 c0             	movzbl %al,%eax
80102a70:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80102a73:	74 10                	je     80102a85 <ioapicinit+0x61>
80102a75:	83 ec 0c             	sub    $0xc,%esp
80102a78:	68 30 8d 10 80       	push   $0x80108d30
80102a7d:	e8 44 d9 ff ff       	call   801003c6 <cprintf>
80102a82:	83 c4 10             	add    $0x10,%esp
80102a85:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102a8c:	eb 3f                	jmp    80102acd <ioapicinit+0xa9>
80102a8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a91:	83 c0 20             	add    $0x20,%eax
80102a94:	0d 00 00 01 00       	or     $0x10000,%eax
80102a99:	89 c2                	mov    %eax,%edx
80102a9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a9e:	83 c0 08             	add    $0x8,%eax
80102aa1:	01 c0                	add    %eax,%eax
80102aa3:	83 ec 08             	sub    $0x8,%esp
80102aa6:	52                   	push   %edx
80102aa7:	50                   	push   %eax
80102aa8:	e8 5c ff ff ff       	call   80102a09 <ioapicwrite>
80102aad:	83 c4 10             	add    $0x10,%esp
80102ab0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ab3:	83 c0 08             	add    $0x8,%eax
80102ab6:	01 c0                	add    %eax,%eax
80102ab8:	83 c0 01             	add    $0x1,%eax
80102abb:	83 ec 08             	sub    $0x8,%esp
80102abe:	6a 00                	push   $0x0
80102ac0:	50                   	push   %eax
80102ac1:	e8 43 ff ff ff       	call   80102a09 <ioapicwrite>
80102ac6:	83 c4 10             	add    $0x10,%esp
80102ac9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102acd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ad0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102ad3:	7e b9                	jle    80102a8e <ioapicinit+0x6a>
80102ad5:	eb 01                	jmp    80102ad8 <ioapicinit+0xb4>
80102ad7:	90                   	nop
80102ad8:	c9                   	leave  
80102ad9:	c3                   	ret    

80102ada <ioapicenable>:
80102ada:	55                   	push   %ebp
80102adb:	89 e5                	mov    %esp,%ebp
80102add:	a1 44 33 11 80       	mov    0x80113344,%eax
80102ae2:	85 c0                	test   %eax,%eax
80102ae4:	74 39                	je     80102b1f <ioapicenable+0x45>
80102ae6:	8b 45 08             	mov    0x8(%ebp),%eax
80102ae9:	83 c0 20             	add    $0x20,%eax
80102aec:	89 c2                	mov    %eax,%edx
80102aee:	8b 45 08             	mov    0x8(%ebp),%eax
80102af1:	83 c0 08             	add    $0x8,%eax
80102af4:	01 c0                	add    %eax,%eax
80102af6:	52                   	push   %edx
80102af7:	50                   	push   %eax
80102af8:	e8 0c ff ff ff       	call   80102a09 <ioapicwrite>
80102afd:	83 c4 08             	add    $0x8,%esp
80102b00:	8b 45 0c             	mov    0xc(%ebp),%eax
80102b03:	c1 e0 18             	shl    $0x18,%eax
80102b06:	89 c2                	mov    %eax,%edx
80102b08:	8b 45 08             	mov    0x8(%ebp),%eax
80102b0b:	83 c0 08             	add    $0x8,%eax
80102b0e:	01 c0                	add    %eax,%eax
80102b10:	83 c0 01             	add    $0x1,%eax
80102b13:	52                   	push   %edx
80102b14:	50                   	push   %eax
80102b15:	e8 ef fe ff ff       	call   80102a09 <ioapicwrite>
80102b1a:	83 c4 08             	add    $0x8,%esp
80102b1d:	eb 01                	jmp    80102b20 <ioapicenable+0x46>
80102b1f:	90                   	nop
80102b20:	c9                   	leave  
80102b21:	c3                   	ret    

80102b22 <v2p>:
80102b22:	55                   	push   %ebp
80102b23:	89 e5                	mov    %esp,%ebp
80102b25:	8b 45 08             	mov    0x8(%ebp),%eax
80102b28:	05 00 00 00 80       	add    $0x80000000,%eax
80102b2d:	5d                   	pop    %ebp
80102b2e:	c3                   	ret    

80102b2f <kinit1>:
80102b2f:	55                   	push   %ebp
80102b30:	89 e5                	mov    %esp,%ebp
80102b32:	83 ec 08             	sub    $0x8,%esp
80102b35:	83 ec 08             	sub    $0x8,%esp
80102b38:	68 62 8d 10 80       	push   $0x80108d62
80102b3d:	68 20 32 11 80       	push   $0x80113220
80102b42:	e8 e2 29 00 00       	call   80105529 <initlock>
80102b47:	83 c4 10             	add    $0x10,%esp
80102b4a:	c7 05 54 32 11 80 00 	movl   $0x0,0x80113254
80102b51:	00 00 00 
80102b54:	83 ec 08             	sub    $0x8,%esp
80102b57:	ff 75 0c             	pushl  0xc(%ebp)
80102b5a:	ff 75 08             	pushl  0x8(%ebp)
80102b5d:	e8 2a 00 00 00       	call   80102b8c <freerange>
80102b62:	83 c4 10             	add    $0x10,%esp
80102b65:	90                   	nop
80102b66:	c9                   	leave  
80102b67:	c3                   	ret    

80102b68 <kinit2>:
80102b68:	55                   	push   %ebp
80102b69:	89 e5                	mov    %esp,%ebp
80102b6b:	83 ec 08             	sub    $0x8,%esp
80102b6e:	83 ec 08             	sub    $0x8,%esp
80102b71:	ff 75 0c             	pushl  0xc(%ebp)
80102b74:	ff 75 08             	pushl  0x8(%ebp)
80102b77:	e8 10 00 00 00       	call   80102b8c <freerange>
80102b7c:	83 c4 10             	add    $0x10,%esp
80102b7f:	c7 05 54 32 11 80 01 	movl   $0x1,0x80113254
80102b86:	00 00 00 
80102b89:	90                   	nop
80102b8a:	c9                   	leave  
80102b8b:	c3                   	ret    

80102b8c <freerange>:
80102b8c:	55                   	push   %ebp
80102b8d:	89 e5                	mov    %esp,%ebp
80102b8f:	83 ec 18             	sub    $0x18,%esp
80102b92:	8b 45 08             	mov    0x8(%ebp),%eax
80102b95:	05 ff 0f 00 00       	add    $0xfff,%eax
80102b9a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102b9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102ba2:	eb 15                	jmp    80102bb9 <freerange+0x2d>
80102ba4:	83 ec 0c             	sub    $0xc,%esp
80102ba7:	ff 75 f4             	pushl  -0xc(%ebp)
80102baa:	e8 1a 00 00 00       	call   80102bc9 <kfree>
80102baf:	83 c4 10             	add    $0x10,%esp
80102bb2:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102bb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102bbc:	05 00 10 00 00       	add    $0x1000,%eax
80102bc1:	3b 45 0c             	cmp    0xc(%ebp),%eax
80102bc4:	76 de                	jbe    80102ba4 <freerange+0x18>
80102bc6:	90                   	nop
80102bc7:	c9                   	leave  
80102bc8:	c3                   	ret    

80102bc9 <kfree>:
80102bc9:	55                   	push   %ebp
80102bca:	89 e5                	mov    %esp,%ebp
80102bcc:	83 ec 18             	sub    $0x18,%esp
80102bcf:	8b 45 08             	mov    0x8(%ebp),%eax
80102bd2:	25 ff 0f 00 00       	and    $0xfff,%eax
80102bd7:	85 c0                	test   %eax,%eax
80102bd9:	75 1b                	jne    80102bf6 <kfree+0x2d>
80102bdb:	81 7d 08 7c 68 11 80 	cmpl   $0x8011687c,0x8(%ebp)
80102be2:	72 12                	jb     80102bf6 <kfree+0x2d>
80102be4:	ff 75 08             	pushl  0x8(%ebp)
80102be7:	e8 36 ff ff ff       	call   80102b22 <v2p>
80102bec:	83 c4 04             	add    $0x4,%esp
80102bef:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102bf4:	76 0d                	jbe    80102c03 <kfree+0x3a>
80102bf6:	83 ec 0c             	sub    $0xc,%esp
80102bf9:	68 67 8d 10 80       	push   $0x80108d67
80102bfe:	e8 63 d9 ff ff       	call   80100566 <panic>
80102c03:	83 ec 04             	sub    $0x4,%esp
80102c06:	68 00 10 00 00       	push   $0x1000
80102c0b:	6a 01                	push   $0x1
80102c0d:	ff 75 08             	pushl  0x8(%ebp)
80102c10:	e8 99 2b 00 00       	call   801057ae <memset>
80102c15:	83 c4 10             	add    $0x10,%esp
80102c18:	a1 54 32 11 80       	mov    0x80113254,%eax
80102c1d:	85 c0                	test   %eax,%eax
80102c1f:	74 10                	je     80102c31 <kfree+0x68>
80102c21:	83 ec 0c             	sub    $0xc,%esp
80102c24:	68 20 32 11 80       	push   $0x80113220
80102c29:	e8 1d 29 00 00       	call   8010554b <acquire>
80102c2e:	83 c4 10             	add    $0x10,%esp
80102c31:	8b 45 08             	mov    0x8(%ebp),%eax
80102c34:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102c37:	8b 15 58 32 11 80    	mov    0x80113258,%edx
80102c3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c40:	89 10                	mov    %edx,(%eax)
80102c42:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c45:	a3 58 32 11 80       	mov    %eax,0x80113258
80102c4a:	a1 54 32 11 80       	mov    0x80113254,%eax
80102c4f:	85 c0                	test   %eax,%eax
80102c51:	74 10                	je     80102c63 <kfree+0x9a>
80102c53:	83 ec 0c             	sub    $0xc,%esp
80102c56:	68 20 32 11 80       	push   $0x80113220
80102c5b:	e8 52 29 00 00       	call   801055b2 <release>
80102c60:	83 c4 10             	add    $0x10,%esp
80102c63:	90                   	nop
80102c64:	c9                   	leave  
80102c65:	c3                   	ret    

80102c66 <kalloc>:
80102c66:	55                   	push   %ebp
80102c67:	89 e5                	mov    %esp,%ebp
80102c69:	83 ec 18             	sub    $0x18,%esp
80102c6c:	a1 54 32 11 80       	mov    0x80113254,%eax
80102c71:	85 c0                	test   %eax,%eax
80102c73:	74 10                	je     80102c85 <kalloc+0x1f>
80102c75:	83 ec 0c             	sub    $0xc,%esp
80102c78:	68 20 32 11 80       	push   $0x80113220
80102c7d:	e8 c9 28 00 00       	call   8010554b <acquire>
80102c82:	83 c4 10             	add    $0x10,%esp
80102c85:	a1 58 32 11 80       	mov    0x80113258,%eax
80102c8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102c8d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102c91:	74 0a                	je     80102c9d <kalloc+0x37>
80102c93:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c96:	8b 00                	mov    (%eax),%eax
80102c98:	a3 58 32 11 80       	mov    %eax,0x80113258
80102c9d:	a1 54 32 11 80       	mov    0x80113254,%eax
80102ca2:	85 c0                	test   %eax,%eax
80102ca4:	74 10                	je     80102cb6 <kalloc+0x50>
80102ca6:	83 ec 0c             	sub    $0xc,%esp
80102ca9:	68 20 32 11 80       	push   $0x80113220
80102cae:	e8 ff 28 00 00       	call   801055b2 <release>
80102cb3:	83 c4 10             	add    $0x10,%esp
80102cb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102cb9:	c9                   	leave  
80102cba:	c3                   	ret    

80102cbb <inb>:
80102cbb:	55                   	push   %ebp
80102cbc:	89 e5                	mov    %esp,%ebp
80102cbe:	83 ec 14             	sub    $0x14,%esp
80102cc1:	8b 45 08             	mov    0x8(%ebp),%eax
80102cc4:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
80102cc8:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102ccc:	89 c2                	mov    %eax,%edx
80102cce:	ec                   	in     (%dx),%al
80102ccf:	88 45 ff             	mov    %al,-0x1(%ebp)
80102cd2:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
80102cd6:	c9                   	leave  
80102cd7:	c3                   	ret    

80102cd8 <kbdgetc>:
80102cd8:	55                   	push   %ebp
80102cd9:	89 e5                	mov    %esp,%ebp
80102cdb:	83 ec 10             	sub    $0x10,%esp
80102cde:	6a 64                	push   $0x64
80102ce0:	e8 d6 ff ff ff       	call   80102cbb <inb>
80102ce5:	83 c4 04             	add    $0x4,%esp
80102ce8:	0f b6 c0             	movzbl %al,%eax
80102ceb:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102cee:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102cf1:	83 e0 01             	and    $0x1,%eax
80102cf4:	85 c0                	test   %eax,%eax
80102cf6:	75 0a                	jne    80102d02 <kbdgetc+0x2a>
80102cf8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102cfd:	e9 23 01 00 00       	jmp    80102e25 <kbdgetc+0x14d>
80102d02:	6a 60                	push   $0x60
80102d04:	e8 b2 ff ff ff       	call   80102cbb <inb>
80102d09:	83 c4 04             	add    $0x4,%esp
80102d0c:	0f b6 c0             	movzbl %al,%eax
80102d0f:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102d12:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102d19:	75 17                	jne    80102d32 <kbdgetc+0x5a>
80102d1b:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102d20:	83 c8 40             	or     $0x40,%eax
80102d23:	a3 3c c6 10 80       	mov    %eax,0x8010c63c
80102d28:	b8 00 00 00 00       	mov    $0x0,%eax
80102d2d:	e9 f3 00 00 00       	jmp    80102e25 <kbdgetc+0x14d>
80102d32:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d35:	25 80 00 00 00       	and    $0x80,%eax
80102d3a:	85 c0                	test   %eax,%eax
80102d3c:	74 45                	je     80102d83 <kbdgetc+0xab>
80102d3e:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102d43:	83 e0 40             	and    $0x40,%eax
80102d46:	85 c0                	test   %eax,%eax
80102d48:	75 08                	jne    80102d52 <kbdgetc+0x7a>
80102d4a:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d4d:	83 e0 7f             	and    $0x7f,%eax
80102d50:	eb 03                	jmp    80102d55 <kbdgetc+0x7d>
80102d52:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d55:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102d58:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d5b:	05 20 a0 10 80       	add    $0x8010a020,%eax
80102d60:	0f b6 00             	movzbl (%eax),%eax
80102d63:	83 c8 40             	or     $0x40,%eax
80102d66:	0f b6 c0             	movzbl %al,%eax
80102d69:	f7 d0                	not    %eax
80102d6b:	89 c2                	mov    %eax,%edx
80102d6d:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102d72:	21 d0                	and    %edx,%eax
80102d74:	a3 3c c6 10 80       	mov    %eax,0x8010c63c
80102d79:	b8 00 00 00 00       	mov    $0x0,%eax
80102d7e:	e9 a2 00 00 00       	jmp    80102e25 <kbdgetc+0x14d>
80102d83:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102d88:	83 e0 40             	and    $0x40,%eax
80102d8b:	85 c0                	test   %eax,%eax
80102d8d:	74 14                	je     80102da3 <kbdgetc+0xcb>
80102d8f:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
80102d96:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102d9b:	83 e0 bf             	and    $0xffffffbf,%eax
80102d9e:	a3 3c c6 10 80       	mov    %eax,0x8010c63c
80102da3:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102da6:	05 20 a0 10 80       	add    $0x8010a020,%eax
80102dab:	0f b6 00             	movzbl (%eax),%eax
80102dae:	0f b6 d0             	movzbl %al,%edx
80102db1:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102db6:	09 d0                	or     %edx,%eax
80102db8:	a3 3c c6 10 80       	mov    %eax,0x8010c63c
80102dbd:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102dc0:	05 20 a1 10 80       	add    $0x8010a120,%eax
80102dc5:	0f b6 00             	movzbl (%eax),%eax
80102dc8:	0f b6 d0             	movzbl %al,%edx
80102dcb:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102dd0:	31 d0                	xor    %edx,%eax
80102dd2:	a3 3c c6 10 80       	mov    %eax,0x8010c63c
80102dd7:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102ddc:	83 e0 03             	and    $0x3,%eax
80102ddf:	8b 14 85 20 a5 10 80 	mov    -0x7fef5ae0(,%eax,4),%edx
80102de6:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102de9:	01 d0                	add    %edx,%eax
80102deb:	0f b6 00             	movzbl (%eax),%eax
80102dee:	0f b6 c0             	movzbl %al,%eax
80102df1:	89 45 f8             	mov    %eax,-0x8(%ebp)
80102df4:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102df9:	83 e0 08             	and    $0x8,%eax
80102dfc:	85 c0                	test   %eax,%eax
80102dfe:	74 22                	je     80102e22 <kbdgetc+0x14a>
80102e00:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102e04:	76 0c                	jbe    80102e12 <kbdgetc+0x13a>
80102e06:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102e0a:	77 06                	ja     80102e12 <kbdgetc+0x13a>
80102e0c:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80102e10:	eb 10                	jmp    80102e22 <kbdgetc+0x14a>
80102e12:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80102e16:	76 0a                	jbe    80102e22 <kbdgetc+0x14a>
80102e18:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80102e1c:	77 04                	ja     80102e22 <kbdgetc+0x14a>
80102e1e:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
80102e22:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102e25:	c9                   	leave  
80102e26:	c3                   	ret    

80102e27 <kbdintr>:
80102e27:	55                   	push   %ebp
80102e28:	89 e5                	mov    %esp,%ebp
80102e2a:	83 ec 08             	sub    $0x8,%esp
80102e2d:	83 ec 0c             	sub    $0xc,%esp
80102e30:	68 d8 2c 10 80       	push   $0x80102cd8
80102e35:	e8 bf d9 ff ff       	call   801007f9 <consoleintr>
80102e3a:	83 c4 10             	add    $0x10,%esp
80102e3d:	90                   	nop
80102e3e:	c9                   	leave  
80102e3f:	c3                   	ret    

80102e40 <inb>:
80102e40:	55                   	push   %ebp
80102e41:	89 e5                	mov    %esp,%ebp
80102e43:	83 ec 14             	sub    $0x14,%esp
80102e46:	8b 45 08             	mov    0x8(%ebp),%eax
80102e49:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
80102e4d:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102e51:	89 c2                	mov    %eax,%edx
80102e53:	ec                   	in     (%dx),%al
80102e54:	88 45 ff             	mov    %al,-0x1(%ebp)
80102e57:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
80102e5b:	c9                   	leave  
80102e5c:	c3                   	ret    

80102e5d <outb>:
80102e5d:	55                   	push   %ebp
80102e5e:	89 e5                	mov    %esp,%ebp
80102e60:	83 ec 08             	sub    $0x8,%esp
80102e63:	8b 55 08             	mov    0x8(%ebp),%edx
80102e66:	8b 45 0c             	mov    0xc(%ebp),%eax
80102e69:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102e6d:	88 45 f8             	mov    %al,-0x8(%ebp)
80102e70:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102e74:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102e78:	ee                   	out    %al,(%dx)
80102e79:	90                   	nop
80102e7a:	c9                   	leave  
80102e7b:	c3                   	ret    

80102e7c <readeflags>:
80102e7c:	55                   	push   %ebp
80102e7d:	89 e5                	mov    %esp,%ebp
80102e7f:	83 ec 10             	sub    $0x10,%esp
80102e82:	9c                   	pushf  
80102e83:	58                   	pop    %eax
80102e84:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102e87:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102e8a:	c9                   	leave  
80102e8b:	c3                   	ret    

80102e8c <lapicw>:
80102e8c:	55                   	push   %ebp
80102e8d:	89 e5                	mov    %esp,%ebp
80102e8f:	a1 5c 32 11 80       	mov    0x8011325c,%eax
80102e94:	8b 55 08             	mov    0x8(%ebp),%edx
80102e97:	c1 e2 02             	shl    $0x2,%edx
80102e9a:	01 c2                	add    %eax,%edx
80102e9c:	8b 45 0c             	mov    0xc(%ebp),%eax
80102e9f:	89 02                	mov    %eax,(%edx)
80102ea1:	a1 5c 32 11 80       	mov    0x8011325c,%eax
80102ea6:	83 c0 20             	add    $0x20,%eax
80102ea9:	8b 00                	mov    (%eax),%eax
80102eab:	90                   	nop
80102eac:	5d                   	pop    %ebp
80102ead:	c3                   	ret    

80102eae <lapicinit>:
80102eae:	55                   	push   %ebp
80102eaf:	89 e5                	mov    %esp,%ebp
80102eb1:	a1 5c 32 11 80       	mov    0x8011325c,%eax
80102eb6:	85 c0                	test   %eax,%eax
80102eb8:	0f 84 0b 01 00 00    	je     80102fc9 <lapicinit+0x11b>
80102ebe:	68 3f 01 00 00       	push   $0x13f
80102ec3:	6a 3c                	push   $0x3c
80102ec5:	e8 c2 ff ff ff       	call   80102e8c <lapicw>
80102eca:	83 c4 08             	add    $0x8,%esp
80102ecd:	6a 0b                	push   $0xb
80102ecf:	68 f8 00 00 00       	push   $0xf8
80102ed4:	e8 b3 ff ff ff       	call   80102e8c <lapicw>
80102ed9:	83 c4 08             	add    $0x8,%esp
80102edc:	68 20 00 02 00       	push   $0x20020
80102ee1:	68 c8 00 00 00       	push   $0xc8
80102ee6:	e8 a1 ff ff ff       	call   80102e8c <lapicw>
80102eeb:	83 c4 08             	add    $0x8,%esp
80102eee:	68 80 96 98 00       	push   $0x989680
80102ef3:	68 e0 00 00 00       	push   $0xe0
80102ef8:	e8 8f ff ff ff       	call   80102e8c <lapicw>
80102efd:	83 c4 08             	add    $0x8,%esp
80102f00:	68 00 00 01 00       	push   $0x10000
80102f05:	68 d4 00 00 00       	push   $0xd4
80102f0a:	e8 7d ff ff ff       	call   80102e8c <lapicw>
80102f0f:	83 c4 08             	add    $0x8,%esp
80102f12:	68 00 00 01 00       	push   $0x10000
80102f17:	68 d8 00 00 00       	push   $0xd8
80102f1c:	e8 6b ff ff ff       	call   80102e8c <lapicw>
80102f21:	83 c4 08             	add    $0x8,%esp
80102f24:	a1 5c 32 11 80       	mov    0x8011325c,%eax
80102f29:	83 c0 30             	add    $0x30,%eax
80102f2c:	8b 00                	mov    (%eax),%eax
80102f2e:	c1 e8 10             	shr    $0x10,%eax
80102f31:	0f b6 c0             	movzbl %al,%eax
80102f34:	83 f8 03             	cmp    $0x3,%eax
80102f37:	76 12                	jbe    80102f4b <lapicinit+0x9d>
80102f39:	68 00 00 01 00       	push   $0x10000
80102f3e:	68 d0 00 00 00       	push   $0xd0
80102f43:	e8 44 ff ff ff       	call   80102e8c <lapicw>
80102f48:	83 c4 08             	add    $0x8,%esp
80102f4b:	6a 33                	push   $0x33
80102f4d:	68 dc 00 00 00       	push   $0xdc
80102f52:	e8 35 ff ff ff       	call   80102e8c <lapicw>
80102f57:	83 c4 08             	add    $0x8,%esp
80102f5a:	6a 00                	push   $0x0
80102f5c:	68 a0 00 00 00       	push   $0xa0
80102f61:	e8 26 ff ff ff       	call   80102e8c <lapicw>
80102f66:	83 c4 08             	add    $0x8,%esp
80102f69:	6a 00                	push   $0x0
80102f6b:	68 a0 00 00 00       	push   $0xa0
80102f70:	e8 17 ff ff ff       	call   80102e8c <lapicw>
80102f75:	83 c4 08             	add    $0x8,%esp
80102f78:	6a 00                	push   $0x0
80102f7a:	6a 2c                	push   $0x2c
80102f7c:	e8 0b ff ff ff       	call   80102e8c <lapicw>
80102f81:	83 c4 08             	add    $0x8,%esp
80102f84:	6a 00                	push   $0x0
80102f86:	68 c4 00 00 00       	push   $0xc4
80102f8b:	e8 fc fe ff ff       	call   80102e8c <lapicw>
80102f90:	83 c4 08             	add    $0x8,%esp
80102f93:	68 00 85 08 00       	push   $0x88500
80102f98:	68 c0 00 00 00       	push   $0xc0
80102f9d:	e8 ea fe ff ff       	call   80102e8c <lapicw>
80102fa2:	83 c4 08             	add    $0x8,%esp
80102fa5:	90                   	nop
80102fa6:	a1 5c 32 11 80       	mov    0x8011325c,%eax
80102fab:	05 00 03 00 00       	add    $0x300,%eax
80102fb0:	8b 00                	mov    (%eax),%eax
80102fb2:	25 00 10 00 00       	and    $0x1000,%eax
80102fb7:	85 c0                	test   %eax,%eax
80102fb9:	75 eb                	jne    80102fa6 <lapicinit+0xf8>
80102fbb:	6a 00                	push   $0x0
80102fbd:	6a 20                	push   $0x20
80102fbf:	e8 c8 fe ff ff       	call   80102e8c <lapicw>
80102fc4:	83 c4 08             	add    $0x8,%esp
80102fc7:	eb 01                	jmp    80102fca <lapicinit+0x11c>
80102fc9:	90                   	nop
80102fca:	c9                   	leave  
80102fcb:	c3                   	ret    

80102fcc <cpunum>:
80102fcc:	55                   	push   %ebp
80102fcd:	89 e5                	mov    %esp,%ebp
80102fcf:	83 ec 08             	sub    $0x8,%esp
80102fd2:	e8 a5 fe ff ff       	call   80102e7c <readeflags>
80102fd7:	25 00 02 00 00       	and    $0x200,%eax
80102fdc:	85 c0                	test   %eax,%eax
80102fde:	74 26                	je     80103006 <cpunum+0x3a>
80102fe0:	a1 40 c6 10 80       	mov    0x8010c640,%eax
80102fe5:	8d 50 01             	lea    0x1(%eax),%edx
80102fe8:	89 15 40 c6 10 80    	mov    %edx,0x8010c640
80102fee:	85 c0                	test   %eax,%eax
80102ff0:	75 14                	jne    80103006 <cpunum+0x3a>
80102ff2:	8b 45 04             	mov    0x4(%ebp),%eax
80102ff5:	83 ec 08             	sub    $0x8,%esp
80102ff8:	50                   	push   %eax
80102ff9:	68 70 8d 10 80       	push   $0x80108d70
80102ffe:	e8 c3 d3 ff ff       	call   801003c6 <cprintf>
80103003:	83 c4 10             	add    $0x10,%esp
80103006:	a1 5c 32 11 80       	mov    0x8011325c,%eax
8010300b:	85 c0                	test   %eax,%eax
8010300d:	74 0f                	je     8010301e <cpunum+0x52>
8010300f:	a1 5c 32 11 80       	mov    0x8011325c,%eax
80103014:	83 c0 20             	add    $0x20,%eax
80103017:	8b 00                	mov    (%eax),%eax
80103019:	c1 e8 18             	shr    $0x18,%eax
8010301c:	eb 05                	jmp    80103023 <cpunum+0x57>
8010301e:	b8 00 00 00 00       	mov    $0x0,%eax
80103023:	c9                   	leave  
80103024:	c3                   	ret    

80103025 <lapiceoi>:
80103025:	55                   	push   %ebp
80103026:	89 e5                	mov    %esp,%ebp
80103028:	a1 5c 32 11 80       	mov    0x8011325c,%eax
8010302d:	85 c0                	test   %eax,%eax
8010302f:	74 0c                	je     8010303d <lapiceoi+0x18>
80103031:	6a 00                	push   $0x0
80103033:	6a 2c                	push   $0x2c
80103035:	e8 52 fe ff ff       	call   80102e8c <lapicw>
8010303a:	83 c4 08             	add    $0x8,%esp
8010303d:	90                   	nop
8010303e:	c9                   	leave  
8010303f:	c3                   	ret    

80103040 <microdelay>:
80103040:	55                   	push   %ebp
80103041:	89 e5                	mov    %esp,%ebp
80103043:	90                   	nop
80103044:	5d                   	pop    %ebp
80103045:	c3                   	ret    

80103046 <lapicstartap>:
80103046:	55                   	push   %ebp
80103047:	89 e5                	mov    %esp,%ebp
80103049:	83 ec 14             	sub    $0x14,%esp
8010304c:	8b 45 08             	mov    0x8(%ebp),%eax
8010304f:	88 45 ec             	mov    %al,-0x14(%ebp)
80103052:	6a 0f                	push   $0xf
80103054:	6a 70                	push   $0x70
80103056:	e8 02 fe ff ff       	call   80102e5d <outb>
8010305b:	83 c4 08             	add    $0x8,%esp
8010305e:	6a 0a                	push   $0xa
80103060:	6a 71                	push   $0x71
80103062:	e8 f6 fd ff ff       	call   80102e5d <outb>
80103067:	83 c4 08             	add    $0x8,%esp
8010306a:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
80103071:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103074:	66 c7 00 00 00       	movw   $0x0,(%eax)
80103079:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010307c:	83 c0 02             	add    $0x2,%eax
8010307f:	8b 55 0c             	mov    0xc(%ebp),%edx
80103082:	c1 ea 04             	shr    $0x4,%edx
80103085:	66 89 10             	mov    %dx,(%eax)
80103088:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
8010308c:	c1 e0 18             	shl    $0x18,%eax
8010308f:	50                   	push   %eax
80103090:	68 c4 00 00 00       	push   $0xc4
80103095:	e8 f2 fd ff ff       	call   80102e8c <lapicw>
8010309a:	83 c4 08             	add    $0x8,%esp
8010309d:	68 00 c5 00 00       	push   $0xc500
801030a2:	68 c0 00 00 00       	push   $0xc0
801030a7:	e8 e0 fd ff ff       	call   80102e8c <lapicw>
801030ac:	83 c4 08             	add    $0x8,%esp
801030af:	68 c8 00 00 00       	push   $0xc8
801030b4:	e8 87 ff ff ff       	call   80103040 <microdelay>
801030b9:	83 c4 04             	add    $0x4,%esp
801030bc:	68 00 85 00 00       	push   $0x8500
801030c1:	68 c0 00 00 00       	push   $0xc0
801030c6:	e8 c1 fd ff ff       	call   80102e8c <lapicw>
801030cb:	83 c4 08             	add    $0x8,%esp
801030ce:	6a 64                	push   $0x64
801030d0:	e8 6b ff ff ff       	call   80103040 <microdelay>
801030d5:	83 c4 04             	add    $0x4,%esp
801030d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801030df:	eb 3d                	jmp    8010311e <lapicstartap+0xd8>
801030e1:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
801030e5:	c1 e0 18             	shl    $0x18,%eax
801030e8:	50                   	push   %eax
801030e9:	68 c4 00 00 00       	push   $0xc4
801030ee:	e8 99 fd ff ff       	call   80102e8c <lapicw>
801030f3:	83 c4 08             	add    $0x8,%esp
801030f6:	8b 45 0c             	mov    0xc(%ebp),%eax
801030f9:	c1 e8 0c             	shr    $0xc,%eax
801030fc:	80 cc 06             	or     $0x6,%ah
801030ff:	50                   	push   %eax
80103100:	68 c0 00 00 00       	push   $0xc0
80103105:	e8 82 fd ff ff       	call   80102e8c <lapicw>
8010310a:	83 c4 08             	add    $0x8,%esp
8010310d:	68 c8 00 00 00       	push   $0xc8
80103112:	e8 29 ff ff ff       	call   80103040 <microdelay>
80103117:	83 c4 04             	add    $0x4,%esp
8010311a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010311e:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
80103122:	7e bd                	jle    801030e1 <lapicstartap+0x9b>
80103124:	90                   	nop
80103125:	c9                   	leave  
80103126:	c3                   	ret    

80103127 <cmos_read>:
80103127:	55                   	push   %ebp
80103128:	89 e5                	mov    %esp,%ebp
8010312a:	8b 45 08             	mov    0x8(%ebp),%eax
8010312d:	0f b6 c0             	movzbl %al,%eax
80103130:	50                   	push   %eax
80103131:	6a 70                	push   $0x70
80103133:	e8 25 fd ff ff       	call   80102e5d <outb>
80103138:	83 c4 08             	add    $0x8,%esp
8010313b:	68 c8 00 00 00       	push   $0xc8
80103140:	e8 fb fe ff ff       	call   80103040 <microdelay>
80103145:	83 c4 04             	add    $0x4,%esp
80103148:	6a 71                	push   $0x71
8010314a:	e8 f1 fc ff ff       	call   80102e40 <inb>
8010314f:	83 c4 04             	add    $0x4,%esp
80103152:	0f b6 c0             	movzbl %al,%eax
80103155:	c9                   	leave  
80103156:	c3                   	ret    

80103157 <fill_rtcdate>:
80103157:	55                   	push   %ebp
80103158:	89 e5                	mov    %esp,%ebp
8010315a:	6a 00                	push   $0x0
8010315c:	e8 c6 ff ff ff       	call   80103127 <cmos_read>
80103161:	83 c4 04             	add    $0x4,%esp
80103164:	89 c2                	mov    %eax,%edx
80103166:	8b 45 08             	mov    0x8(%ebp),%eax
80103169:	89 10                	mov    %edx,(%eax)
8010316b:	6a 02                	push   $0x2
8010316d:	e8 b5 ff ff ff       	call   80103127 <cmos_read>
80103172:	83 c4 04             	add    $0x4,%esp
80103175:	89 c2                	mov    %eax,%edx
80103177:	8b 45 08             	mov    0x8(%ebp),%eax
8010317a:	89 50 04             	mov    %edx,0x4(%eax)
8010317d:	6a 04                	push   $0x4
8010317f:	e8 a3 ff ff ff       	call   80103127 <cmos_read>
80103184:	83 c4 04             	add    $0x4,%esp
80103187:	89 c2                	mov    %eax,%edx
80103189:	8b 45 08             	mov    0x8(%ebp),%eax
8010318c:	89 50 08             	mov    %edx,0x8(%eax)
8010318f:	6a 07                	push   $0x7
80103191:	e8 91 ff ff ff       	call   80103127 <cmos_read>
80103196:	83 c4 04             	add    $0x4,%esp
80103199:	89 c2                	mov    %eax,%edx
8010319b:	8b 45 08             	mov    0x8(%ebp),%eax
8010319e:	89 50 0c             	mov    %edx,0xc(%eax)
801031a1:	6a 08                	push   $0x8
801031a3:	e8 7f ff ff ff       	call   80103127 <cmos_read>
801031a8:	83 c4 04             	add    $0x4,%esp
801031ab:	89 c2                	mov    %eax,%edx
801031ad:	8b 45 08             	mov    0x8(%ebp),%eax
801031b0:	89 50 10             	mov    %edx,0x10(%eax)
801031b3:	6a 09                	push   $0x9
801031b5:	e8 6d ff ff ff       	call   80103127 <cmos_read>
801031ba:	83 c4 04             	add    $0x4,%esp
801031bd:	89 c2                	mov    %eax,%edx
801031bf:	8b 45 08             	mov    0x8(%ebp),%eax
801031c2:	89 50 14             	mov    %edx,0x14(%eax)
801031c5:	90                   	nop
801031c6:	c9                   	leave  
801031c7:	c3                   	ret    

801031c8 <cmostime>:
801031c8:	55                   	push   %ebp
801031c9:	89 e5                	mov    %esp,%ebp
801031cb:	83 ec 48             	sub    $0x48,%esp
801031ce:	6a 0b                	push   $0xb
801031d0:	e8 52 ff ff ff       	call   80103127 <cmos_read>
801031d5:	83 c4 04             	add    $0x4,%esp
801031d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
801031db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801031de:	83 e0 04             	and    $0x4,%eax
801031e1:	85 c0                	test   %eax,%eax
801031e3:	0f 94 c0             	sete   %al
801031e6:	0f b6 c0             	movzbl %al,%eax
801031e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
801031ec:	8d 45 d8             	lea    -0x28(%ebp),%eax
801031ef:	50                   	push   %eax
801031f0:	e8 62 ff ff ff       	call   80103157 <fill_rtcdate>
801031f5:	83 c4 04             	add    $0x4,%esp
801031f8:	6a 0a                	push   $0xa
801031fa:	e8 28 ff ff ff       	call   80103127 <cmos_read>
801031ff:	83 c4 04             	add    $0x4,%esp
80103202:	25 80 00 00 00       	and    $0x80,%eax
80103207:	85 c0                	test   %eax,%eax
80103209:	75 27                	jne    80103232 <cmostime+0x6a>
8010320b:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010320e:	50                   	push   %eax
8010320f:	e8 43 ff ff ff       	call   80103157 <fill_rtcdate>
80103214:	83 c4 04             	add    $0x4,%esp
80103217:	83 ec 04             	sub    $0x4,%esp
8010321a:	6a 18                	push   $0x18
8010321c:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010321f:	50                   	push   %eax
80103220:	8d 45 d8             	lea    -0x28(%ebp),%eax
80103223:	50                   	push   %eax
80103224:	e8 ec 25 00 00       	call   80105815 <memcmp>
80103229:	83 c4 10             	add    $0x10,%esp
8010322c:	85 c0                	test   %eax,%eax
8010322e:	74 05                	je     80103235 <cmostime+0x6d>
80103230:	eb ba                	jmp    801031ec <cmostime+0x24>
80103232:	90                   	nop
80103233:	eb b7                	jmp    801031ec <cmostime+0x24>
80103235:	90                   	nop
80103236:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010323a:	0f 84 b4 00 00 00    	je     801032f4 <cmostime+0x12c>
80103240:	8b 45 d8             	mov    -0x28(%ebp),%eax
80103243:	c1 e8 04             	shr    $0x4,%eax
80103246:	89 c2                	mov    %eax,%edx
80103248:	89 d0                	mov    %edx,%eax
8010324a:	c1 e0 02             	shl    $0x2,%eax
8010324d:	01 d0                	add    %edx,%eax
8010324f:	01 c0                	add    %eax,%eax
80103251:	89 c2                	mov    %eax,%edx
80103253:	8b 45 d8             	mov    -0x28(%ebp),%eax
80103256:	83 e0 0f             	and    $0xf,%eax
80103259:	01 d0                	add    %edx,%eax
8010325b:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010325e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103261:	c1 e8 04             	shr    $0x4,%eax
80103264:	89 c2                	mov    %eax,%edx
80103266:	89 d0                	mov    %edx,%eax
80103268:	c1 e0 02             	shl    $0x2,%eax
8010326b:	01 d0                	add    %edx,%eax
8010326d:	01 c0                	add    %eax,%eax
8010326f:	89 c2                	mov    %eax,%edx
80103271:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103274:	83 e0 0f             	and    $0xf,%eax
80103277:	01 d0                	add    %edx,%eax
80103279:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010327c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010327f:	c1 e8 04             	shr    $0x4,%eax
80103282:	89 c2                	mov    %eax,%edx
80103284:	89 d0                	mov    %edx,%eax
80103286:	c1 e0 02             	shl    $0x2,%eax
80103289:	01 d0                	add    %edx,%eax
8010328b:	01 c0                	add    %eax,%eax
8010328d:	89 c2                	mov    %eax,%edx
8010328f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103292:	83 e0 0f             	and    $0xf,%eax
80103295:	01 d0                	add    %edx,%eax
80103297:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010329a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010329d:	c1 e8 04             	shr    $0x4,%eax
801032a0:	89 c2                	mov    %eax,%edx
801032a2:	89 d0                	mov    %edx,%eax
801032a4:	c1 e0 02             	shl    $0x2,%eax
801032a7:	01 d0                	add    %edx,%eax
801032a9:	01 c0                	add    %eax,%eax
801032ab:	89 c2                	mov    %eax,%edx
801032ad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801032b0:	83 e0 0f             	and    $0xf,%eax
801032b3:	01 d0                	add    %edx,%eax
801032b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801032b8:	8b 45 e8             	mov    -0x18(%ebp),%eax
801032bb:	c1 e8 04             	shr    $0x4,%eax
801032be:	89 c2                	mov    %eax,%edx
801032c0:	89 d0                	mov    %edx,%eax
801032c2:	c1 e0 02             	shl    $0x2,%eax
801032c5:	01 d0                	add    %edx,%eax
801032c7:	01 c0                	add    %eax,%eax
801032c9:	89 c2                	mov    %eax,%edx
801032cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
801032ce:	83 e0 0f             	and    $0xf,%eax
801032d1:	01 d0                	add    %edx,%eax
801032d3:	89 45 e8             	mov    %eax,-0x18(%ebp)
801032d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801032d9:	c1 e8 04             	shr    $0x4,%eax
801032dc:	89 c2                	mov    %eax,%edx
801032de:	89 d0                	mov    %edx,%eax
801032e0:	c1 e0 02             	shl    $0x2,%eax
801032e3:	01 d0                	add    %edx,%eax
801032e5:	01 c0                	add    %eax,%eax
801032e7:	89 c2                	mov    %eax,%edx
801032e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801032ec:	83 e0 0f             	and    $0xf,%eax
801032ef:	01 d0                	add    %edx,%eax
801032f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
801032f4:	8b 45 08             	mov    0x8(%ebp),%eax
801032f7:	8b 55 d8             	mov    -0x28(%ebp),%edx
801032fa:	89 10                	mov    %edx,(%eax)
801032fc:	8b 55 dc             	mov    -0x24(%ebp),%edx
801032ff:	89 50 04             	mov    %edx,0x4(%eax)
80103302:	8b 55 e0             	mov    -0x20(%ebp),%edx
80103305:	89 50 08             	mov    %edx,0x8(%eax)
80103308:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010330b:	89 50 0c             	mov    %edx,0xc(%eax)
8010330e:	8b 55 e8             	mov    -0x18(%ebp),%edx
80103311:	89 50 10             	mov    %edx,0x10(%eax)
80103314:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103317:	89 50 14             	mov    %edx,0x14(%eax)
8010331a:	8b 45 08             	mov    0x8(%ebp),%eax
8010331d:	8b 40 14             	mov    0x14(%eax),%eax
80103320:	8d 90 d0 07 00 00    	lea    0x7d0(%eax),%edx
80103326:	8b 45 08             	mov    0x8(%ebp),%eax
80103329:	89 50 14             	mov    %edx,0x14(%eax)
8010332c:	90                   	nop
8010332d:	c9                   	leave  
8010332e:	c3                   	ret    

8010332f <initlog>:
8010332f:	55                   	push   %ebp
80103330:	89 e5                	mov    %esp,%ebp
80103332:	83 ec 28             	sub    $0x28,%esp
80103335:	83 ec 08             	sub    $0x8,%esp
80103338:	68 9c 8d 10 80       	push   $0x80108d9c
8010333d:	68 60 32 11 80       	push   $0x80113260
80103342:	e8 e2 21 00 00       	call   80105529 <initlock>
80103347:	83 c4 10             	add    $0x10,%esp
8010334a:	83 ec 08             	sub    $0x8,%esp
8010334d:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103350:	50                   	push   %eax
80103351:	ff 75 08             	pushl  0x8(%ebp)
80103354:	e8 2b e0 ff ff       	call   80101384 <readsb>
80103359:	83 c4 10             	add    $0x10,%esp
8010335c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010335f:	a3 94 32 11 80       	mov    %eax,0x80113294
80103364:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103367:	a3 98 32 11 80       	mov    %eax,0x80113298
8010336c:	8b 45 08             	mov    0x8(%ebp),%eax
8010336f:	a3 a4 32 11 80       	mov    %eax,0x801132a4
80103374:	e8 b2 01 00 00       	call   8010352b <recover_from_log>
80103379:	90                   	nop
8010337a:	c9                   	leave  
8010337b:	c3                   	ret    

8010337c <install_trans>:
8010337c:	55                   	push   %ebp
8010337d:	89 e5                	mov    %esp,%ebp
8010337f:	83 ec 18             	sub    $0x18,%esp
80103382:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103389:	e9 95 00 00 00       	jmp    80103423 <install_trans+0xa7>
8010338e:	8b 15 94 32 11 80    	mov    0x80113294,%edx
80103394:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103397:	01 d0                	add    %edx,%eax
80103399:	83 c0 01             	add    $0x1,%eax
8010339c:	89 c2                	mov    %eax,%edx
8010339e:	a1 a4 32 11 80       	mov    0x801132a4,%eax
801033a3:	83 ec 08             	sub    $0x8,%esp
801033a6:	52                   	push   %edx
801033a7:	50                   	push   %eax
801033a8:	e8 09 ce ff ff       	call   801001b6 <bread>
801033ad:	83 c4 10             	add    $0x10,%esp
801033b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
801033b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801033b6:	83 c0 10             	add    $0x10,%eax
801033b9:	8b 04 85 6c 32 11 80 	mov    -0x7feecd94(,%eax,4),%eax
801033c0:	89 c2                	mov    %eax,%edx
801033c2:	a1 a4 32 11 80       	mov    0x801132a4,%eax
801033c7:	83 ec 08             	sub    $0x8,%esp
801033ca:	52                   	push   %edx
801033cb:	50                   	push   %eax
801033cc:	e8 e5 cd ff ff       	call   801001b6 <bread>
801033d1:	83 c4 10             	add    $0x10,%esp
801033d4:	89 45 ec             	mov    %eax,-0x14(%ebp)
801033d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801033da:	8d 50 18             	lea    0x18(%eax),%edx
801033dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
801033e0:	83 c0 18             	add    $0x18,%eax
801033e3:	83 ec 04             	sub    $0x4,%esp
801033e6:	68 00 02 00 00       	push   $0x200
801033eb:	52                   	push   %edx
801033ec:	50                   	push   %eax
801033ed:	e8 7b 24 00 00       	call   8010586d <memmove>
801033f2:	83 c4 10             	add    $0x10,%esp
801033f5:	83 ec 0c             	sub    $0xc,%esp
801033f8:	ff 75 ec             	pushl  -0x14(%ebp)
801033fb:	e8 ef cd ff ff       	call   801001ef <bwrite>
80103400:	83 c4 10             	add    $0x10,%esp
80103403:	83 ec 0c             	sub    $0xc,%esp
80103406:	ff 75 f0             	pushl  -0x10(%ebp)
80103409:	e8 20 ce ff ff       	call   8010022e <brelse>
8010340e:	83 c4 10             	add    $0x10,%esp
80103411:	83 ec 0c             	sub    $0xc,%esp
80103414:	ff 75 ec             	pushl  -0x14(%ebp)
80103417:	e8 12 ce ff ff       	call   8010022e <brelse>
8010341c:	83 c4 10             	add    $0x10,%esp
8010341f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103423:	a1 a8 32 11 80       	mov    0x801132a8,%eax
80103428:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010342b:	0f 8f 5d ff ff ff    	jg     8010338e <install_trans+0x12>
80103431:	90                   	nop
80103432:	c9                   	leave  
80103433:	c3                   	ret    

80103434 <read_head>:
80103434:	55                   	push   %ebp
80103435:	89 e5                	mov    %esp,%ebp
80103437:	83 ec 18             	sub    $0x18,%esp
8010343a:	a1 94 32 11 80       	mov    0x80113294,%eax
8010343f:	89 c2                	mov    %eax,%edx
80103441:	a1 a4 32 11 80       	mov    0x801132a4,%eax
80103446:	83 ec 08             	sub    $0x8,%esp
80103449:	52                   	push   %edx
8010344a:	50                   	push   %eax
8010344b:	e8 66 cd ff ff       	call   801001b6 <bread>
80103450:	83 c4 10             	add    $0x10,%esp
80103453:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103456:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103459:	83 c0 18             	add    $0x18,%eax
8010345c:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010345f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103462:	8b 00                	mov    (%eax),%eax
80103464:	a3 a8 32 11 80       	mov    %eax,0x801132a8
80103469:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103470:	eb 1b                	jmp    8010348d <read_head+0x59>
80103472:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103475:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103478:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
8010347c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010347f:	83 c2 10             	add    $0x10,%edx
80103482:	89 04 95 6c 32 11 80 	mov    %eax,-0x7feecd94(,%edx,4)
80103489:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010348d:	a1 a8 32 11 80       	mov    0x801132a8,%eax
80103492:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103495:	7f db                	jg     80103472 <read_head+0x3e>
80103497:	83 ec 0c             	sub    $0xc,%esp
8010349a:	ff 75 f0             	pushl  -0x10(%ebp)
8010349d:	e8 8c cd ff ff       	call   8010022e <brelse>
801034a2:	83 c4 10             	add    $0x10,%esp
801034a5:	90                   	nop
801034a6:	c9                   	leave  
801034a7:	c3                   	ret    

801034a8 <write_head>:
801034a8:	55                   	push   %ebp
801034a9:	89 e5                	mov    %esp,%ebp
801034ab:	83 ec 18             	sub    $0x18,%esp
801034ae:	a1 94 32 11 80       	mov    0x80113294,%eax
801034b3:	89 c2                	mov    %eax,%edx
801034b5:	a1 a4 32 11 80       	mov    0x801132a4,%eax
801034ba:	83 ec 08             	sub    $0x8,%esp
801034bd:	52                   	push   %edx
801034be:	50                   	push   %eax
801034bf:	e8 f2 cc ff ff       	call   801001b6 <bread>
801034c4:	83 c4 10             	add    $0x10,%esp
801034c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
801034ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
801034cd:	83 c0 18             	add    $0x18,%eax
801034d0:	89 45 ec             	mov    %eax,-0x14(%ebp)
801034d3:	8b 15 a8 32 11 80    	mov    0x801132a8,%edx
801034d9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034dc:	89 10                	mov    %edx,(%eax)
801034de:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801034e5:	eb 1b                	jmp    80103502 <write_head+0x5a>
801034e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801034ea:	83 c0 10             	add    $0x10,%eax
801034ed:	8b 0c 85 6c 32 11 80 	mov    -0x7feecd94(,%eax,4),%ecx
801034f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034f7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801034fa:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
801034fe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103502:	a1 a8 32 11 80       	mov    0x801132a8,%eax
80103507:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010350a:	7f db                	jg     801034e7 <write_head+0x3f>
8010350c:	83 ec 0c             	sub    $0xc,%esp
8010350f:	ff 75 f0             	pushl  -0x10(%ebp)
80103512:	e8 d8 cc ff ff       	call   801001ef <bwrite>
80103517:	83 c4 10             	add    $0x10,%esp
8010351a:	83 ec 0c             	sub    $0xc,%esp
8010351d:	ff 75 f0             	pushl  -0x10(%ebp)
80103520:	e8 09 cd ff ff       	call   8010022e <brelse>
80103525:	83 c4 10             	add    $0x10,%esp
80103528:	90                   	nop
80103529:	c9                   	leave  
8010352a:	c3                   	ret    

8010352b <recover_from_log>:
8010352b:	55                   	push   %ebp
8010352c:	89 e5                	mov    %esp,%ebp
8010352e:	83 ec 08             	sub    $0x8,%esp
80103531:	e8 fe fe ff ff       	call   80103434 <read_head>
80103536:	e8 41 fe ff ff       	call   8010337c <install_trans>
8010353b:	c7 05 a8 32 11 80 00 	movl   $0x0,0x801132a8
80103542:	00 00 00 
80103545:	e8 5e ff ff ff       	call   801034a8 <write_head>
8010354a:	90                   	nop
8010354b:	c9                   	leave  
8010354c:	c3                   	ret    

8010354d <begin_op>:
8010354d:	55                   	push   %ebp
8010354e:	89 e5                	mov    %esp,%ebp
80103550:	83 ec 08             	sub    $0x8,%esp
80103553:	83 ec 0c             	sub    $0xc,%esp
80103556:	68 60 32 11 80       	push   $0x80113260
8010355b:	e8 eb 1f 00 00       	call   8010554b <acquire>
80103560:	83 c4 10             	add    $0x10,%esp
80103563:	a1 a0 32 11 80       	mov    0x801132a0,%eax
80103568:	85 c0                	test   %eax,%eax
8010356a:	74 17                	je     80103583 <begin_op+0x36>
8010356c:	83 ec 08             	sub    $0x8,%esp
8010356f:	68 60 32 11 80       	push   $0x80113260
80103574:	68 60 32 11 80       	push   $0x80113260
80103579:	e8 a9 18 00 00       	call   80104e27 <sleep>
8010357e:	83 c4 10             	add    $0x10,%esp
80103581:	eb e0                	jmp    80103563 <begin_op+0x16>
80103583:	8b 0d a8 32 11 80    	mov    0x801132a8,%ecx
80103589:	a1 9c 32 11 80       	mov    0x8011329c,%eax
8010358e:	8d 50 01             	lea    0x1(%eax),%edx
80103591:	89 d0                	mov    %edx,%eax
80103593:	c1 e0 02             	shl    $0x2,%eax
80103596:	01 d0                	add    %edx,%eax
80103598:	01 c0                	add    %eax,%eax
8010359a:	01 c8                	add    %ecx,%eax
8010359c:	83 f8 1e             	cmp    $0x1e,%eax
8010359f:	7e 17                	jle    801035b8 <begin_op+0x6b>
801035a1:	83 ec 08             	sub    $0x8,%esp
801035a4:	68 60 32 11 80       	push   $0x80113260
801035a9:	68 60 32 11 80       	push   $0x80113260
801035ae:	e8 74 18 00 00       	call   80104e27 <sleep>
801035b3:	83 c4 10             	add    $0x10,%esp
801035b6:	eb ab                	jmp    80103563 <begin_op+0x16>
801035b8:	a1 9c 32 11 80       	mov    0x8011329c,%eax
801035bd:	83 c0 01             	add    $0x1,%eax
801035c0:	a3 9c 32 11 80       	mov    %eax,0x8011329c
801035c5:	83 ec 0c             	sub    $0xc,%esp
801035c8:	68 60 32 11 80       	push   $0x80113260
801035cd:	e8 e0 1f 00 00       	call   801055b2 <release>
801035d2:	83 c4 10             	add    $0x10,%esp
801035d5:	90                   	nop
801035d6:	90                   	nop
801035d7:	c9                   	leave  
801035d8:	c3                   	ret    

801035d9 <end_op>:
801035d9:	55                   	push   %ebp
801035da:	89 e5                	mov    %esp,%ebp
801035dc:	83 ec 18             	sub    $0x18,%esp
801035df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801035e6:	83 ec 0c             	sub    $0xc,%esp
801035e9:	68 60 32 11 80       	push   $0x80113260
801035ee:	e8 58 1f 00 00       	call   8010554b <acquire>
801035f3:	83 c4 10             	add    $0x10,%esp
801035f6:	a1 9c 32 11 80       	mov    0x8011329c,%eax
801035fb:	83 e8 01             	sub    $0x1,%eax
801035fe:	a3 9c 32 11 80       	mov    %eax,0x8011329c
80103603:	a1 a0 32 11 80       	mov    0x801132a0,%eax
80103608:	85 c0                	test   %eax,%eax
8010360a:	74 0d                	je     80103619 <end_op+0x40>
8010360c:	83 ec 0c             	sub    $0xc,%esp
8010360f:	68 a0 8d 10 80       	push   $0x80108da0
80103614:	e8 4d cf ff ff       	call   80100566 <panic>
80103619:	a1 9c 32 11 80       	mov    0x8011329c,%eax
8010361e:	85 c0                	test   %eax,%eax
80103620:	75 13                	jne    80103635 <end_op+0x5c>
80103622:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
80103629:	c7 05 a0 32 11 80 01 	movl   $0x1,0x801132a0
80103630:	00 00 00 
80103633:	eb 10                	jmp    80103645 <end_op+0x6c>
80103635:	83 ec 0c             	sub    $0xc,%esp
80103638:	68 60 32 11 80       	push   $0x80113260
8010363d:	e8 d3 18 00 00       	call   80104f15 <wakeup>
80103642:	83 c4 10             	add    $0x10,%esp
80103645:	83 ec 0c             	sub    $0xc,%esp
80103648:	68 60 32 11 80       	push   $0x80113260
8010364d:	e8 60 1f 00 00       	call   801055b2 <release>
80103652:	83 c4 10             	add    $0x10,%esp
80103655:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103659:	74 3f                	je     8010369a <end_op+0xc1>
8010365b:	e8 f5 00 00 00       	call   80103755 <commit>
80103660:	83 ec 0c             	sub    $0xc,%esp
80103663:	68 60 32 11 80       	push   $0x80113260
80103668:	e8 de 1e 00 00       	call   8010554b <acquire>
8010366d:	83 c4 10             	add    $0x10,%esp
80103670:	c7 05 a0 32 11 80 00 	movl   $0x0,0x801132a0
80103677:	00 00 00 
8010367a:	83 ec 0c             	sub    $0xc,%esp
8010367d:	68 60 32 11 80       	push   $0x80113260
80103682:	e8 8e 18 00 00       	call   80104f15 <wakeup>
80103687:	83 c4 10             	add    $0x10,%esp
8010368a:	83 ec 0c             	sub    $0xc,%esp
8010368d:	68 60 32 11 80       	push   $0x80113260
80103692:	e8 1b 1f 00 00       	call   801055b2 <release>
80103697:	83 c4 10             	add    $0x10,%esp
8010369a:	90                   	nop
8010369b:	c9                   	leave  
8010369c:	c3                   	ret    

8010369d <write_log>:
8010369d:	55                   	push   %ebp
8010369e:	89 e5                	mov    %esp,%ebp
801036a0:	83 ec 18             	sub    $0x18,%esp
801036a3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801036aa:	e9 95 00 00 00       	jmp    80103744 <write_log+0xa7>
801036af:	8b 15 94 32 11 80    	mov    0x80113294,%edx
801036b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036b8:	01 d0                	add    %edx,%eax
801036ba:	83 c0 01             	add    $0x1,%eax
801036bd:	89 c2                	mov    %eax,%edx
801036bf:	a1 a4 32 11 80       	mov    0x801132a4,%eax
801036c4:	83 ec 08             	sub    $0x8,%esp
801036c7:	52                   	push   %edx
801036c8:	50                   	push   %eax
801036c9:	e8 e8 ca ff ff       	call   801001b6 <bread>
801036ce:	83 c4 10             	add    $0x10,%esp
801036d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
801036d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036d7:	83 c0 10             	add    $0x10,%eax
801036da:	8b 04 85 6c 32 11 80 	mov    -0x7feecd94(,%eax,4),%eax
801036e1:	89 c2                	mov    %eax,%edx
801036e3:	a1 a4 32 11 80       	mov    0x801132a4,%eax
801036e8:	83 ec 08             	sub    $0x8,%esp
801036eb:	52                   	push   %edx
801036ec:	50                   	push   %eax
801036ed:	e8 c4 ca ff ff       	call   801001b6 <bread>
801036f2:	83 c4 10             	add    $0x10,%esp
801036f5:	89 45 ec             	mov    %eax,-0x14(%ebp)
801036f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801036fb:	8d 50 18             	lea    0x18(%eax),%edx
801036fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103701:	83 c0 18             	add    $0x18,%eax
80103704:	83 ec 04             	sub    $0x4,%esp
80103707:	68 00 02 00 00       	push   $0x200
8010370c:	52                   	push   %edx
8010370d:	50                   	push   %eax
8010370e:	e8 5a 21 00 00       	call   8010586d <memmove>
80103713:	83 c4 10             	add    $0x10,%esp
80103716:	83 ec 0c             	sub    $0xc,%esp
80103719:	ff 75 f0             	pushl  -0x10(%ebp)
8010371c:	e8 ce ca ff ff       	call   801001ef <bwrite>
80103721:	83 c4 10             	add    $0x10,%esp
80103724:	83 ec 0c             	sub    $0xc,%esp
80103727:	ff 75 ec             	pushl  -0x14(%ebp)
8010372a:	e8 ff ca ff ff       	call   8010022e <brelse>
8010372f:	83 c4 10             	add    $0x10,%esp
80103732:	83 ec 0c             	sub    $0xc,%esp
80103735:	ff 75 f0             	pushl  -0x10(%ebp)
80103738:	e8 f1 ca ff ff       	call   8010022e <brelse>
8010373d:	83 c4 10             	add    $0x10,%esp
80103740:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103744:	a1 a8 32 11 80       	mov    0x801132a8,%eax
80103749:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010374c:	0f 8f 5d ff ff ff    	jg     801036af <write_log+0x12>
80103752:	90                   	nop
80103753:	c9                   	leave  
80103754:	c3                   	ret    

80103755 <commit>:
80103755:	55                   	push   %ebp
80103756:	89 e5                	mov    %esp,%ebp
80103758:	83 ec 08             	sub    $0x8,%esp
8010375b:	a1 a8 32 11 80       	mov    0x801132a8,%eax
80103760:	85 c0                	test   %eax,%eax
80103762:	7e 1e                	jle    80103782 <commit+0x2d>
80103764:	e8 34 ff ff ff       	call   8010369d <write_log>
80103769:	e8 3a fd ff ff       	call   801034a8 <write_head>
8010376e:	e8 09 fc ff ff       	call   8010337c <install_trans>
80103773:	c7 05 a8 32 11 80 00 	movl   $0x0,0x801132a8
8010377a:	00 00 00 
8010377d:	e8 26 fd ff ff       	call   801034a8 <write_head>
80103782:	90                   	nop
80103783:	c9                   	leave  
80103784:	c3                   	ret    

80103785 <log_write>:
80103785:	55                   	push   %ebp
80103786:	89 e5                	mov    %esp,%ebp
80103788:	83 ec 18             	sub    $0x18,%esp
8010378b:	a1 a8 32 11 80       	mov    0x801132a8,%eax
80103790:	83 f8 1d             	cmp    $0x1d,%eax
80103793:	7f 12                	jg     801037a7 <log_write+0x22>
80103795:	a1 a8 32 11 80       	mov    0x801132a8,%eax
8010379a:	8b 15 98 32 11 80    	mov    0x80113298,%edx
801037a0:	83 ea 01             	sub    $0x1,%edx
801037a3:	39 d0                	cmp    %edx,%eax
801037a5:	7c 0d                	jl     801037b4 <log_write+0x2f>
801037a7:	83 ec 0c             	sub    $0xc,%esp
801037aa:	68 af 8d 10 80       	push   $0x80108daf
801037af:	e8 b2 cd ff ff       	call   80100566 <panic>
801037b4:	a1 9c 32 11 80       	mov    0x8011329c,%eax
801037b9:	85 c0                	test   %eax,%eax
801037bb:	7f 0d                	jg     801037ca <log_write+0x45>
801037bd:	83 ec 0c             	sub    $0xc,%esp
801037c0:	68 c5 8d 10 80       	push   $0x80108dc5
801037c5:	e8 9c cd ff ff       	call   80100566 <panic>
801037ca:	83 ec 0c             	sub    $0xc,%esp
801037cd:	68 60 32 11 80       	push   $0x80113260
801037d2:	e8 74 1d 00 00       	call   8010554b <acquire>
801037d7:	83 c4 10             	add    $0x10,%esp
801037da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801037e1:	eb 1d                	jmp    80103800 <log_write+0x7b>
801037e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037e6:	83 c0 10             	add    $0x10,%eax
801037e9:	8b 04 85 6c 32 11 80 	mov    -0x7feecd94(,%eax,4),%eax
801037f0:	89 c2                	mov    %eax,%edx
801037f2:	8b 45 08             	mov    0x8(%ebp),%eax
801037f5:	8b 40 08             	mov    0x8(%eax),%eax
801037f8:	39 c2                	cmp    %eax,%edx
801037fa:	74 10                	je     8010380c <log_write+0x87>
801037fc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103800:	a1 a8 32 11 80       	mov    0x801132a8,%eax
80103805:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103808:	7f d9                	jg     801037e3 <log_write+0x5e>
8010380a:	eb 01                	jmp    8010380d <log_write+0x88>
8010380c:	90                   	nop
8010380d:	8b 45 08             	mov    0x8(%ebp),%eax
80103810:	8b 40 08             	mov    0x8(%eax),%eax
80103813:	89 c2                	mov    %eax,%edx
80103815:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103818:	83 c0 10             	add    $0x10,%eax
8010381b:	89 14 85 6c 32 11 80 	mov    %edx,-0x7feecd94(,%eax,4)
80103822:	a1 a8 32 11 80       	mov    0x801132a8,%eax
80103827:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010382a:	75 0d                	jne    80103839 <log_write+0xb4>
8010382c:	a1 a8 32 11 80       	mov    0x801132a8,%eax
80103831:	83 c0 01             	add    $0x1,%eax
80103834:	a3 a8 32 11 80       	mov    %eax,0x801132a8
80103839:	8b 45 08             	mov    0x8(%ebp),%eax
8010383c:	8b 00                	mov    (%eax),%eax
8010383e:	83 c8 04             	or     $0x4,%eax
80103841:	89 c2                	mov    %eax,%edx
80103843:	8b 45 08             	mov    0x8(%ebp),%eax
80103846:	89 10                	mov    %edx,(%eax)
80103848:	83 ec 0c             	sub    $0xc,%esp
8010384b:	68 60 32 11 80       	push   $0x80113260
80103850:	e8 5d 1d 00 00       	call   801055b2 <release>
80103855:	83 c4 10             	add    $0x10,%esp
80103858:	90                   	nop
80103859:	c9                   	leave  
8010385a:	c3                   	ret    

8010385b <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
8010385b:	55                   	push   %ebp
8010385c:	89 e5                	mov    %esp,%ebp
8010385e:	8b 45 08             	mov    0x8(%ebp),%eax
80103861:	05 00 00 00 80       	add    $0x80000000,%eax
80103866:	5d                   	pop    %ebp
80103867:	c3                   	ret    

80103868 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80103868:	55                   	push   %ebp
80103869:	89 e5                	mov    %esp,%ebp
8010386b:	8b 45 08             	mov    0x8(%ebp),%eax
8010386e:	05 00 00 00 80       	add    $0x80000000,%eax
80103873:	5d                   	pop    %ebp
80103874:	c3                   	ret    

80103875 <xchg>:
  asm volatile("hlt");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
80103875:	55                   	push   %ebp
80103876:	89 e5                	mov    %esp,%ebp
80103878:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010387b:	8b 55 08             	mov    0x8(%ebp),%edx
8010387e:	8b 45 0c             	mov    0xc(%ebp),%eax
80103881:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103884:	f0 87 02             	lock xchg %eax,(%edx)
80103887:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
8010388a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010388d:	c9                   	leave  
8010388e:	c3                   	ret    

8010388f <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
8010388f:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103893:	83 e4 f0             	and    $0xfffffff0,%esp
80103896:	ff 71 fc             	pushl  -0x4(%ecx)
80103899:	55                   	push   %ebp
8010389a:	89 e5                	mov    %esp,%ebp
8010389c:	51                   	push   %ecx
8010389d:	83 ec 04             	sub    $0x4,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801038a0:	83 ec 08             	sub    $0x8,%esp
801038a3:	68 00 00 40 80       	push   $0x80400000
801038a8:	68 7c 68 11 80       	push   $0x8011687c
801038ad:	e8 7d f2 ff ff       	call   80102b2f <kinit1>
801038b2:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
801038b5:	e8 f3 4a 00 00       	call   801083ad <kvmalloc>
  mpinit();        // collect info about this machine
801038ba:	e8 43 04 00 00       	call   80103d02 <mpinit>
  lapicinit();
801038bf:	e8 ea f5 ff ff       	call   80102eae <lapicinit>
  seginit();       // set up segments
801038c4:	e8 8d 44 00 00       	call   80107d56 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
801038c9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801038cf:	0f b6 00             	movzbl (%eax),%eax
801038d2:	0f b6 c0             	movzbl %al,%eax
801038d5:	83 ec 08             	sub    $0x8,%esp
801038d8:	50                   	push   %eax
801038d9:	68 e0 8d 10 80       	push   $0x80108de0
801038de:	e8 e3 ca ff ff       	call   801003c6 <cprintf>
801038e3:	83 c4 10             	add    $0x10,%esp
  picinit();       // interrupt controller
801038e6:	e8 6d 06 00 00       	call   80103f58 <picinit>
  ioapicinit();    // another interrupt controller
801038eb:	e8 34 f1 ff ff       	call   80102a24 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
801038f0:	e8 24 d2 ff ff       	call   80100b19 <consoleinit>
  uartinit();      // serial port
801038f5:	e8 b8 37 00 00       	call   801070b2 <uartinit>
  pinit();         // process table
801038fa:	e8 56 0b 00 00       	call   80104455 <pinit>
  tvinit();        // trap vectors
801038ff:	e8 78 33 00 00       	call   80106c7c <tvinit>
  binit();         // buffer cache
80103904:	e8 2b c7 ff ff       	call   80100034 <binit>
  fileinit();      // file table
80103909:	e8 67 d6 ff ff       	call   80100f75 <fileinit>
  ideinit();       // disk
8010390e:	e8 19 ed ff ff       	call   8010262c <ideinit>
  if(!ismp)
80103913:	a1 44 33 11 80       	mov    0x80113344,%eax
80103918:	85 c0                	test   %eax,%eax
8010391a:	75 05                	jne    80103921 <main+0x92>
    timerinit();   // uniprocessor timer
8010391c:	e8 b8 32 00 00       	call   80106bd9 <timerinit>
  startothers();   // start other processors
80103921:	e8 7f 00 00 00       	call   801039a5 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103926:	83 ec 08             	sub    $0x8,%esp
80103929:	68 00 00 00 8e       	push   $0x8e000000
8010392e:	68 00 00 40 80       	push   $0x80400000
80103933:	e8 30 f2 ff ff       	call   80102b68 <kinit2>
80103938:	83 c4 10             	add    $0x10,%esp
  userinit();      // first user process
8010393b:	e8 76 0c 00 00       	call   801045b6 <userinit>
  // Finish setting up this processor in mpmain.
  mpmain();
80103940:	e8 1a 00 00 00       	call   8010395f <mpmain>

80103945 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80103945:	55                   	push   %ebp
80103946:	89 e5                	mov    %esp,%ebp
80103948:	83 ec 08             	sub    $0x8,%esp
  switchkvm(); 
8010394b:	e8 75 4a 00 00       	call   801083c5 <switchkvm>
  seginit();
80103950:	e8 01 44 00 00       	call   80107d56 <seginit>
  lapicinit();
80103955:	e8 54 f5 ff ff       	call   80102eae <lapicinit>
  mpmain();
8010395a:	e8 00 00 00 00       	call   8010395f <mpmain>

8010395f <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
8010395f:	55                   	push   %ebp
80103960:	89 e5                	mov    %esp,%ebp
80103962:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpu->id);
80103965:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010396b:	0f b6 00             	movzbl (%eax),%eax
8010396e:	0f b6 c0             	movzbl %al,%eax
80103971:	83 ec 08             	sub    $0x8,%esp
80103974:	50                   	push   %eax
80103975:	68 f7 8d 10 80       	push   $0x80108df7
8010397a:	e8 47 ca ff ff       	call   801003c6 <cprintf>
8010397f:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
80103982:	e8 6b 34 00 00       	call   80106df2 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80103987:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010398d:	05 a8 00 00 00       	add    $0xa8,%eax
80103992:	83 ec 08             	sub    $0x8,%esp
80103995:	6a 01                	push   $0x1
80103997:	50                   	push   %eax
80103998:	e8 d8 fe ff ff       	call   80103875 <xchg>
8010399d:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
801039a0:	e8 28 13 00 00       	call   80104ccd <scheduler>

801039a5 <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
801039a5:	55                   	push   %ebp
801039a6:	89 e5                	mov    %esp,%ebp
801039a8:	53                   	push   %ebx
801039a9:	83 ec 14             	sub    $0x14,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
801039ac:	68 00 70 00 00       	push   $0x7000
801039b1:	e8 b2 fe ff ff       	call   80103868 <p2v>
801039b6:	83 c4 04             	add    $0x4,%esp
801039b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801039bc:	b8 8a 00 00 00       	mov    $0x8a,%eax
801039c1:	83 ec 04             	sub    $0x4,%esp
801039c4:	50                   	push   %eax
801039c5:	68 0c c5 10 80       	push   $0x8010c50c
801039ca:	ff 75 f0             	pushl  -0x10(%ebp)
801039cd:	e8 9b 1e 00 00       	call   8010586d <memmove>
801039d2:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
801039d5:	c7 45 f4 60 33 11 80 	movl   $0x80113360,-0xc(%ebp)
801039dc:	e9 90 00 00 00       	jmp    80103a71 <startothers+0xcc>
    if(c == cpus+cpunum())  // We've started already.
801039e1:	e8 e6 f5 ff ff       	call   80102fcc <cpunum>
801039e6:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801039ec:	05 60 33 11 80       	add    $0x80113360,%eax
801039f1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801039f4:	74 73                	je     80103a69 <startothers+0xc4>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801039f6:	e8 6b f2 ff ff       	call   80102c66 <kalloc>
801039fb:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
801039fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a01:	83 e8 04             	sub    $0x4,%eax
80103a04:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103a07:	81 c2 00 10 00 00    	add    $0x1000,%edx
80103a0d:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
80103a0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a12:	83 e8 08             	sub    $0x8,%eax
80103a15:	c7 00 45 39 10 80    	movl   $0x80103945,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
80103a1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a1e:	8d 58 f4             	lea    -0xc(%eax),%ebx
80103a21:	83 ec 0c             	sub    $0xc,%esp
80103a24:	68 00 b0 10 80       	push   $0x8010b000
80103a29:	e8 2d fe ff ff       	call   8010385b <v2p>
80103a2e:	83 c4 10             	add    $0x10,%esp
80103a31:	89 03                	mov    %eax,(%ebx)

    lapicstartap(c->id, v2p(code));
80103a33:	83 ec 0c             	sub    $0xc,%esp
80103a36:	ff 75 f0             	pushl  -0x10(%ebp)
80103a39:	e8 1d fe ff ff       	call   8010385b <v2p>
80103a3e:	83 c4 10             	add    $0x10,%esp
80103a41:	89 c2                	mov    %eax,%edx
80103a43:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a46:	0f b6 00             	movzbl (%eax),%eax
80103a49:	0f b6 c0             	movzbl %al,%eax
80103a4c:	83 ec 08             	sub    $0x8,%esp
80103a4f:	52                   	push   %edx
80103a50:	50                   	push   %eax
80103a51:	e8 f0 f5 ff ff       	call   80103046 <lapicstartap>
80103a56:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103a59:	90                   	nop
80103a5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a5d:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103a63:	85 c0                	test   %eax,%eax
80103a65:	74 f3                	je     80103a5a <startothers+0xb5>
80103a67:	eb 01                	jmp    80103a6a <startothers+0xc5>
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
    if(c == cpus+cpunum())  // We've started already.
      continue;
80103a69:	90                   	nop
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80103a6a:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
80103a71:	a1 40 39 11 80       	mov    0x80113940,%eax
80103a76:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103a7c:	05 60 33 11 80       	add    $0x80113360,%eax
80103a81:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103a84:	0f 87 57 ff ff ff    	ja     801039e1 <startothers+0x3c>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
80103a8a:	90                   	nop
80103a8b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a8e:	c9                   	leave  
80103a8f:	c3                   	ret    

80103a90 <p2v>:
80103a90:	55                   	push   %ebp
80103a91:	89 e5                	mov    %esp,%ebp
80103a93:	8b 45 08             	mov    0x8(%ebp),%eax
80103a96:	05 00 00 00 80       	add    $0x80000000,%eax
80103a9b:	5d                   	pop    %ebp
80103a9c:	c3                   	ret    

80103a9d <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80103a9d:	55                   	push   %ebp
80103a9e:	89 e5                	mov    %esp,%ebp
80103aa0:	83 ec 14             	sub    $0x14,%esp
80103aa3:	8b 45 08             	mov    0x8(%ebp),%eax
80103aa6:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103aaa:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80103aae:	89 c2                	mov    %eax,%edx
80103ab0:	ec                   	in     (%dx),%al
80103ab1:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103ab4:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80103ab8:	c9                   	leave  
80103ab9:	c3                   	ret    

80103aba <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103aba:	55                   	push   %ebp
80103abb:	89 e5                	mov    %esp,%ebp
80103abd:	83 ec 08             	sub    $0x8,%esp
80103ac0:	8b 55 08             	mov    0x8(%ebp),%edx
80103ac3:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ac6:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103aca:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103acd:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103ad1:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103ad5:	ee                   	out    %al,(%dx)
}
80103ad6:	90                   	nop
80103ad7:	c9                   	leave  
80103ad8:	c3                   	ret    

80103ad9 <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
80103ad9:	55                   	push   %ebp
80103ada:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
80103adc:	a1 44 c6 10 80       	mov    0x8010c644,%eax
80103ae1:	89 c2                	mov    %eax,%edx
80103ae3:	b8 60 33 11 80       	mov    $0x80113360,%eax
80103ae8:	29 c2                	sub    %eax,%edx
80103aea:	89 d0                	mov    %edx,%eax
80103aec:	c1 f8 02             	sar    $0x2,%eax
80103aef:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
80103af5:	5d                   	pop    %ebp
80103af6:	c3                   	ret    

80103af7 <sum>:

static uchar
sum(uchar *addr, int len)
{
80103af7:	55                   	push   %ebp
80103af8:	89 e5                	mov    %esp,%ebp
80103afa:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
80103afd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
80103b04:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103b0b:	eb 15                	jmp    80103b22 <sum+0x2b>
    sum += addr[i];
80103b0d:	8b 55 fc             	mov    -0x4(%ebp),%edx
80103b10:	8b 45 08             	mov    0x8(%ebp),%eax
80103b13:	01 d0                	add    %edx,%eax
80103b15:	0f b6 00             	movzbl (%eax),%eax
80103b18:	0f b6 c0             	movzbl %al,%eax
80103b1b:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
80103b1e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103b22:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103b25:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103b28:	7c e3                	jl     80103b0d <sum+0x16>
    sum += addr[i];
  return sum;
80103b2a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103b2d:	c9                   	leave  
80103b2e:	c3                   	ret    

80103b2f <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103b2f:	55                   	push   %ebp
80103b30:	89 e5                	mov    %esp,%ebp
80103b32:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
80103b35:	ff 75 08             	pushl  0x8(%ebp)
80103b38:	e8 53 ff ff ff       	call   80103a90 <p2v>
80103b3d:	83 c4 04             	add    $0x4,%esp
80103b40:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
80103b43:	8b 55 0c             	mov    0xc(%ebp),%edx
80103b46:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b49:	01 d0                	add    %edx,%eax
80103b4b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
80103b4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b51:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103b54:	eb 36                	jmp    80103b8c <mpsearch1+0x5d>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103b56:	83 ec 04             	sub    $0x4,%esp
80103b59:	6a 04                	push   $0x4
80103b5b:	68 08 8e 10 80       	push   $0x80108e08
80103b60:	ff 75 f4             	pushl  -0xc(%ebp)
80103b63:	e8 ad 1c 00 00       	call   80105815 <memcmp>
80103b68:	83 c4 10             	add    $0x10,%esp
80103b6b:	85 c0                	test   %eax,%eax
80103b6d:	75 19                	jne    80103b88 <mpsearch1+0x59>
80103b6f:	83 ec 08             	sub    $0x8,%esp
80103b72:	6a 10                	push   $0x10
80103b74:	ff 75 f4             	pushl  -0xc(%ebp)
80103b77:	e8 7b ff ff ff       	call   80103af7 <sum>
80103b7c:	83 c4 10             	add    $0x10,%esp
80103b7f:	84 c0                	test   %al,%al
80103b81:	75 05                	jne    80103b88 <mpsearch1+0x59>
      return (struct mp*)p;
80103b83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b86:	eb 11                	jmp    80103b99 <mpsearch1+0x6a>
{
  uchar *e, *p, *addr;

  addr = p2v(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103b88:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103b8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b8f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103b92:	72 c2                	jb     80103b56 <mpsearch1+0x27>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103b94:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103b99:	c9                   	leave  
80103b9a:	c3                   	ret    

80103b9b <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103b9b:	55                   	push   %ebp
80103b9c:	89 e5                	mov    %esp,%ebp
80103b9e:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103ba1:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103ba8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bab:	83 c0 0f             	add    $0xf,%eax
80103bae:	0f b6 00             	movzbl (%eax),%eax
80103bb1:	0f b6 c0             	movzbl %al,%eax
80103bb4:	c1 e0 08             	shl    $0x8,%eax
80103bb7:	89 c2                	mov    %eax,%edx
80103bb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bbc:	83 c0 0e             	add    $0xe,%eax
80103bbf:	0f b6 00             	movzbl (%eax),%eax
80103bc2:	0f b6 c0             	movzbl %al,%eax
80103bc5:	09 d0                	or     %edx,%eax
80103bc7:	c1 e0 04             	shl    $0x4,%eax
80103bca:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103bcd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103bd1:	74 21                	je     80103bf4 <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
80103bd3:	83 ec 08             	sub    $0x8,%esp
80103bd6:	68 00 04 00 00       	push   $0x400
80103bdb:	ff 75 f0             	pushl  -0x10(%ebp)
80103bde:	e8 4c ff ff ff       	call   80103b2f <mpsearch1>
80103be3:	83 c4 10             	add    $0x10,%esp
80103be6:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103be9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103bed:	74 51                	je     80103c40 <mpsearch+0xa5>
      return mp;
80103bef:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103bf2:	eb 61                	jmp    80103c55 <mpsearch+0xba>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103bf4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bf7:	83 c0 14             	add    $0x14,%eax
80103bfa:	0f b6 00             	movzbl (%eax),%eax
80103bfd:	0f b6 c0             	movzbl %al,%eax
80103c00:	c1 e0 08             	shl    $0x8,%eax
80103c03:	89 c2                	mov    %eax,%edx
80103c05:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c08:	83 c0 13             	add    $0x13,%eax
80103c0b:	0f b6 00             	movzbl (%eax),%eax
80103c0e:	0f b6 c0             	movzbl %al,%eax
80103c11:	09 d0                	or     %edx,%eax
80103c13:	c1 e0 0a             	shl    $0xa,%eax
80103c16:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103c19:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c1c:	2d 00 04 00 00       	sub    $0x400,%eax
80103c21:	83 ec 08             	sub    $0x8,%esp
80103c24:	68 00 04 00 00       	push   $0x400
80103c29:	50                   	push   %eax
80103c2a:	e8 00 ff ff ff       	call   80103b2f <mpsearch1>
80103c2f:	83 c4 10             	add    $0x10,%esp
80103c32:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103c35:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103c39:	74 05                	je     80103c40 <mpsearch+0xa5>
      return mp;
80103c3b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103c3e:	eb 15                	jmp    80103c55 <mpsearch+0xba>
  }
  return mpsearch1(0xF0000, 0x10000);
80103c40:	83 ec 08             	sub    $0x8,%esp
80103c43:	68 00 00 01 00       	push   $0x10000
80103c48:	68 00 00 0f 00       	push   $0xf0000
80103c4d:	e8 dd fe ff ff       	call   80103b2f <mpsearch1>
80103c52:	83 c4 10             	add    $0x10,%esp
}
80103c55:	c9                   	leave  
80103c56:	c3                   	ret    

80103c57 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103c57:	55                   	push   %ebp
80103c58:	89 e5                	mov    %esp,%ebp
80103c5a:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103c5d:	e8 39 ff ff ff       	call   80103b9b <mpsearch>
80103c62:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103c65:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103c69:	74 0a                	je     80103c75 <mpconfig+0x1e>
80103c6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c6e:	8b 40 04             	mov    0x4(%eax),%eax
80103c71:	85 c0                	test   %eax,%eax
80103c73:	75 0a                	jne    80103c7f <mpconfig+0x28>
    return 0;
80103c75:	b8 00 00 00 00       	mov    $0x0,%eax
80103c7a:	e9 81 00 00 00       	jmp    80103d00 <mpconfig+0xa9>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
80103c7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c82:	8b 40 04             	mov    0x4(%eax),%eax
80103c85:	83 ec 0c             	sub    $0xc,%esp
80103c88:	50                   	push   %eax
80103c89:	e8 02 fe ff ff       	call   80103a90 <p2v>
80103c8e:	83 c4 10             	add    $0x10,%esp
80103c91:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103c94:	83 ec 04             	sub    $0x4,%esp
80103c97:	6a 04                	push   $0x4
80103c99:	68 0d 8e 10 80       	push   $0x80108e0d
80103c9e:	ff 75 f0             	pushl  -0x10(%ebp)
80103ca1:	e8 6f 1b 00 00       	call   80105815 <memcmp>
80103ca6:	83 c4 10             	add    $0x10,%esp
80103ca9:	85 c0                	test   %eax,%eax
80103cab:	74 07                	je     80103cb4 <mpconfig+0x5d>
    return 0;
80103cad:	b8 00 00 00 00       	mov    $0x0,%eax
80103cb2:	eb 4c                	jmp    80103d00 <mpconfig+0xa9>
  if(conf->version != 1 && conf->version != 4)
80103cb4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cb7:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103cbb:	3c 01                	cmp    $0x1,%al
80103cbd:	74 12                	je     80103cd1 <mpconfig+0x7a>
80103cbf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cc2:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103cc6:	3c 04                	cmp    $0x4,%al
80103cc8:	74 07                	je     80103cd1 <mpconfig+0x7a>
    return 0;
80103cca:	b8 00 00 00 00       	mov    $0x0,%eax
80103ccf:	eb 2f                	jmp    80103d00 <mpconfig+0xa9>
  if(sum((uchar*)conf, conf->length) != 0)
80103cd1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cd4:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103cd8:	0f b7 c0             	movzwl %ax,%eax
80103cdb:	83 ec 08             	sub    $0x8,%esp
80103cde:	50                   	push   %eax
80103cdf:	ff 75 f0             	pushl  -0x10(%ebp)
80103ce2:	e8 10 fe ff ff       	call   80103af7 <sum>
80103ce7:	83 c4 10             	add    $0x10,%esp
80103cea:	84 c0                	test   %al,%al
80103cec:	74 07                	je     80103cf5 <mpconfig+0x9e>
    return 0;
80103cee:	b8 00 00 00 00       	mov    $0x0,%eax
80103cf3:	eb 0b                	jmp    80103d00 <mpconfig+0xa9>
  *pmp = mp;
80103cf5:	8b 45 08             	mov    0x8(%ebp),%eax
80103cf8:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103cfb:	89 10                	mov    %edx,(%eax)
  return conf;
80103cfd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103d00:	c9                   	leave  
80103d01:	c3                   	ret    

80103d02 <mpinit>:

void
mpinit(void)
{
80103d02:	55                   	push   %ebp
80103d03:	89 e5                	mov    %esp,%ebp
80103d05:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
80103d08:	c7 05 44 c6 10 80 60 	movl   $0x80113360,0x8010c644
80103d0f:	33 11 80 
  if((conf = mpconfig(&mp)) == 0)
80103d12:	83 ec 0c             	sub    $0xc,%esp
80103d15:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103d18:	50                   	push   %eax
80103d19:	e8 39 ff ff ff       	call   80103c57 <mpconfig>
80103d1e:	83 c4 10             	add    $0x10,%esp
80103d21:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103d24:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103d28:	0f 84 96 01 00 00    	je     80103ec4 <mpinit+0x1c2>
    return;
  ismp = 1;
80103d2e:	c7 05 44 33 11 80 01 	movl   $0x1,0x80113344
80103d35:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103d38:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d3b:	8b 40 24             	mov    0x24(%eax),%eax
80103d3e:	a3 5c 32 11 80       	mov    %eax,0x8011325c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103d43:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d46:	83 c0 2c             	add    $0x2c,%eax
80103d49:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103d4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d4f:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103d53:	0f b7 d0             	movzwl %ax,%edx
80103d56:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d59:	01 d0                	add    %edx,%eax
80103d5b:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103d5e:	e9 f2 00 00 00       	jmp    80103e55 <mpinit+0x153>
    switch(*p){
80103d63:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d66:	0f b6 00             	movzbl (%eax),%eax
80103d69:	0f b6 c0             	movzbl %al,%eax
80103d6c:	83 f8 04             	cmp    $0x4,%eax
80103d6f:	0f 87 bc 00 00 00    	ja     80103e31 <mpinit+0x12f>
80103d75:	8b 04 85 50 8e 10 80 	mov    -0x7fef71b0(,%eax,4),%eax
80103d7c:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
80103d7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d81:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu != proc->apicid){
80103d84:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103d87:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103d8b:	0f b6 d0             	movzbl %al,%edx
80103d8e:	a1 40 39 11 80       	mov    0x80113940,%eax
80103d93:	39 c2                	cmp    %eax,%edx
80103d95:	74 2b                	je     80103dc2 <mpinit+0xc0>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
80103d97:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103d9a:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103d9e:	0f b6 d0             	movzbl %al,%edx
80103da1:	a1 40 39 11 80       	mov    0x80113940,%eax
80103da6:	83 ec 04             	sub    $0x4,%esp
80103da9:	52                   	push   %edx
80103daa:	50                   	push   %eax
80103dab:	68 12 8e 10 80       	push   $0x80108e12
80103db0:	e8 11 c6 ff ff       	call   801003c6 <cprintf>
80103db5:	83 c4 10             	add    $0x10,%esp
        ismp = 0;
80103db8:	c7 05 44 33 11 80 00 	movl   $0x0,0x80113344
80103dbf:	00 00 00 
      }
      if(proc->flags & MPBOOT)
80103dc2:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103dc5:	0f b6 40 03          	movzbl 0x3(%eax),%eax
80103dc9:	0f b6 c0             	movzbl %al,%eax
80103dcc:	83 e0 02             	and    $0x2,%eax
80103dcf:	85 c0                	test   %eax,%eax
80103dd1:	74 15                	je     80103de8 <mpinit+0xe6>
        bcpu = &cpus[ncpu];
80103dd3:	a1 40 39 11 80       	mov    0x80113940,%eax
80103dd8:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103dde:	05 60 33 11 80       	add    $0x80113360,%eax
80103de3:	a3 44 c6 10 80       	mov    %eax,0x8010c644
      cpus[ncpu].id = ncpu;
80103de8:	a1 40 39 11 80       	mov    0x80113940,%eax
80103ded:	8b 15 40 39 11 80    	mov    0x80113940,%edx
80103df3:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103df9:	05 60 33 11 80       	add    $0x80113360,%eax
80103dfe:	88 10                	mov    %dl,(%eax)
      ncpu++;
80103e00:	a1 40 39 11 80       	mov    0x80113940,%eax
80103e05:	83 c0 01             	add    $0x1,%eax
80103e08:	a3 40 39 11 80       	mov    %eax,0x80113940
      p += sizeof(struct mpproc);
80103e0d:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103e11:	eb 42                	jmp    80103e55 <mpinit+0x153>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103e13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e16:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80103e19:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103e1c:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103e20:	a2 40 33 11 80       	mov    %al,0x80113340
      p += sizeof(struct mpioapic);
80103e25:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103e29:	eb 2a                	jmp    80103e55 <mpinit+0x153>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103e2b:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103e2f:	eb 24                	jmp    80103e55 <mpinit+0x153>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80103e31:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e34:	0f b6 00             	movzbl (%eax),%eax
80103e37:	0f b6 c0             	movzbl %al,%eax
80103e3a:	83 ec 08             	sub    $0x8,%esp
80103e3d:	50                   	push   %eax
80103e3e:	68 30 8e 10 80       	push   $0x80108e30
80103e43:	e8 7e c5 ff ff       	call   801003c6 <cprintf>
80103e48:	83 c4 10             	add    $0x10,%esp
      ismp = 0;
80103e4b:	c7 05 44 33 11 80 00 	movl   $0x0,0x80113344
80103e52:	00 00 00 
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103e55:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e58:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103e5b:	0f 82 02 ff ff ff    	jb     80103d63 <mpinit+0x61>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      ismp = 0;
    }
  }
  if(!ismp){
80103e61:	a1 44 33 11 80       	mov    0x80113344,%eax
80103e66:	85 c0                	test   %eax,%eax
80103e68:	75 1d                	jne    80103e87 <mpinit+0x185>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103e6a:	c7 05 40 39 11 80 01 	movl   $0x1,0x80113940
80103e71:	00 00 00 
    lapic = 0;
80103e74:	c7 05 5c 32 11 80 00 	movl   $0x0,0x8011325c
80103e7b:	00 00 00 
    ioapicid = 0;
80103e7e:	c6 05 40 33 11 80 00 	movb   $0x0,0x80113340
    return;
80103e85:	eb 3e                	jmp    80103ec5 <mpinit+0x1c3>
  }

  if(mp->imcrp){
80103e87:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103e8a:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103e8e:	84 c0                	test   %al,%al
80103e90:	74 33                	je     80103ec5 <mpinit+0x1c3>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103e92:	83 ec 08             	sub    $0x8,%esp
80103e95:	6a 70                	push   $0x70
80103e97:	6a 22                	push   $0x22
80103e99:	e8 1c fc ff ff       	call   80103aba <outb>
80103e9e:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103ea1:	83 ec 0c             	sub    $0xc,%esp
80103ea4:	6a 23                	push   $0x23
80103ea6:	e8 f2 fb ff ff       	call   80103a9d <inb>
80103eab:	83 c4 10             	add    $0x10,%esp
80103eae:	83 c8 01             	or     $0x1,%eax
80103eb1:	0f b6 c0             	movzbl %al,%eax
80103eb4:	83 ec 08             	sub    $0x8,%esp
80103eb7:	50                   	push   %eax
80103eb8:	6a 23                	push   $0x23
80103eba:	e8 fb fb ff ff       	call   80103aba <outb>
80103ebf:	83 c4 10             	add    $0x10,%esp
80103ec2:	eb 01                	jmp    80103ec5 <mpinit+0x1c3>
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
80103ec4:	90                   	nop
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103ec5:	c9                   	leave  
80103ec6:	c3                   	ret    

80103ec7 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103ec7:	55                   	push   %ebp
80103ec8:	89 e5                	mov    %esp,%ebp
80103eca:	83 ec 08             	sub    $0x8,%esp
80103ecd:	8b 55 08             	mov    0x8(%ebp),%edx
80103ed0:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ed3:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103ed7:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103eda:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103ede:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103ee2:	ee                   	out    %al,(%dx)
}
80103ee3:	90                   	nop
80103ee4:	c9                   	leave  
80103ee5:	c3                   	ret    

80103ee6 <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
80103ee6:	55                   	push   %ebp
80103ee7:	89 e5                	mov    %esp,%ebp
80103ee9:	83 ec 04             	sub    $0x4,%esp
80103eec:	8b 45 08             	mov    0x8(%ebp),%eax
80103eef:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
80103ef3:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103ef7:	66 a3 00 c0 10 80    	mov    %ax,0x8010c000
  outb(IO_PIC1+1, mask);
80103efd:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103f01:	0f b6 c0             	movzbl %al,%eax
80103f04:	50                   	push   %eax
80103f05:	6a 21                	push   $0x21
80103f07:	e8 bb ff ff ff       	call   80103ec7 <outb>
80103f0c:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, mask >> 8);
80103f0f:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103f13:	66 c1 e8 08          	shr    $0x8,%ax
80103f17:	0f b6 c0             	movzbl %al,%eax
80103f1a:	50                   	push   %eax
80103f1b:	68 a1 00 00 00       	push   $0xa1
80103f20:	e8 a2 ff ff ff       	call   80103ec7 <outb>
80103f25:	83 c4 08             	add    $0x8,%esp
}
80103f28:	90                   	nop
80103f29:	c9                   	leave  
80103f2a:	c3                   	ret    

80103f2b <picenable>:

void
picenable(int irq)
{
80103f2b:	55                   	push   %ebp
80103f2c:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
80103f2e:	8b 45 08             	mov    0x8(%ebp),%eax
80103f31:	ba 01 00 00 00       	mov    $0x1,%edx
80103f36:	89 c1                	mov    %eax,%ecx
80103f38:	d3 e2                	shl    %cl,%edx
80103f3a:	89 d0                	mov    %edx,%eax
80103f3c:	f7 d0                	not    %eax
80103f3e:	89 c2                	mov    %eax,%edx
80103f40:	0f b7 05 00 c0 10 80 	movzwl 0x8010c000,%eax
80103f47:	21 d0                	and    %edx,%eax
80103f49:	0f b7 c0             	movzwl %ax,%eax
80103f4c:	50                   	push   %eax
80103f4d:	e8 94 ff ff ff       	call   80103ee6 <picsetmask>
80103f52:	83 c4 04             	add    $0x4,%esp
}
80103f55:	90                   	nop
80103f56:	c9                   	leave  
80103f57:	c3                   	ret    

80103f58 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103f58:	55                   	push   %ebp
80103f59:	89 e5                	mov    %esp,%ebp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103f5b:	68 ff 00 00 00       	push   $0xff
80103f60:	6a 21                	push   $0x21
80103f62:	e8 60 ff ff ff       	call   80103ec7 <outb>
80103f67:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
80103f6a:	68 ff 00 00 00       	push   $0xff
80103f6f:	68 a1 00 00 00       	push   $0xa1
80103f74:	e8 4e ff ff ff       	call   80103ec7 <outb>
80103f79:	83 c4 08             	add    $0x8,%esp

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
80103f7c:	6a 11                	push   $0x11
80103f7e:	6a 20                	push   $0x20
80103f80:	e8 42 ff ff ff       	call   80103ec7 <outb>
80103f85:	83 c4 08             	add    $0x8,%esp

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
80103f88:	6a 20                	push   $0x20
80103f8a:	6a 21                	push   $0x21
80103f8c:	e8 36 ff ff ff       	call   80103ec7 <outb>
80103f91:	83 c4 08             	add    $0x8,%esp

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
80103f94:	6a 04                	push   $0x4
80103f96:	6a 21                	push   $0x21
80103f98:	e8 2a ff ff ff       	call   80103ec7 <outb>
80103f9d:	83 c4 08             	add    $0x8,%esp
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
80103fa0:	6a 03                	push   $0x3
80103fa2:	6a 21                	push   $0x21
80103fa4:	e8 1e ff ff ff       	call   80103ec7 <outb>
80103fa9:	83 c4 08             	add    $0x8,%esp

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
80103fac:	6a 11                	push   $0x11
80103fae:	68 a0 00 00 00       	push   $0xa0
80103fb3:	e8 0f ff ff ff       	call   80103ec7 <outb>
80103fb8:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
80103fbb:	6a 28                	push   $0x28
80103fbd:	68 a1 00 00 00       	push   $0xa1
80103fc2:	e8 00 ff ff ff       	call   80103ec7 <outb>
80103fc7:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
80103fca:	6a 02                	push   $0x2
80103fcc:	68 a1 00 00 00       	push   $0xa1
80103fd1:	e8 f1 fe ff ff       	call   80103ec7 <outb>
80103fd6:	83 c4 08             	add    $0x8,%esp
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
80103fd9:	6a 03                	push   $0x3
80103fdb:	68 a1 00 00 00       	push   $0xa1
80103fe0:	e8 e2 fe ff ff       	call   80103ec7 <outb>
80103fe5:	83 c4 08             	add    $0x8,%esp

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
80103fe8:	6a 68                	push   $0x68
80103fea:	6a 20                	push   $0x20
80103fec:	e8 d6 fe ff ff       	call   80103ec7 <outb>
80103ff1:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC1, 0x0a);             // read IRR by default
80103ff4:	6a 0a                	push   $0xa
80103ff6:	6a 20                	push   $0x20
80103ff8:	e8 ca fe ff ff       	call   80103ec7 <outb>
80103ffd:	83 c4 08             	add    $0x8,%esp

  outb(IO_PIC2, 0x68);             // OCW3
80104000:	6a 68                	push   $0x68
80104002:	68 a0 00 00 00       	push   $0xa0
80104007:	e8 bb fe ff ff       	call   80103ec7 <outb>
8010400c:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2, 0x0a);             // OCW3
8010400f:	6a 0a                	push   $0xa
80104011:	68 a0 00 00 00       	push   $0xa0
80104016:	e8 ac fe ff ff       	call   80103ec7 <outb>
8010401b:	83 c4 08             	add    $0x8,%esp

  if(irqmask != 0xFFFF)
8010401e:	0f b7 05 00 c0 10 80 	movzwl 0x8010c000,%eax
80104025:	66 83 f8 ff          	cmp    $0xffff,%ax
80104029:	74 13                	je     8010403e <picinit+0xe6>
    picsetmask(irqmask);
8010402b:	0f b7 05 00 c0 10 80 	movzwl 0x8010c000,%eax
80104032:	0f b7 c0             	movzwl %ax,%eax
80104035:	50                   	push   %eax
80104036:	e8 ab fe ff ff       	call   80103ee6 <picsetmask>
8010403b:	83 c4 04             	add    $0x4,%esp
}
8010403e:	90                   	nop
8010403f:	c9                   	leave  
80104040:	c3                   	ret    

80104041 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80104041:	55                   	push   %ebp
80104042:	89 e5                	mov    %esp,%ebp
80104044:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
80104047:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
8010404e:	8b 45 0c             	mov    0xc(%ebp),%eax
80104051:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104057:	8b 45 0c             	mov    0xc(%ebp),%eax
8010405a:	8b 10                	mov    (%eax),%edx
8010405c:	8b 45 08             	mov    0x8(%ebp),%eax
8010405f:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80104061:	e8 2d cf ff ff       	call   80100f93 <filealloc>
80104066:	89 c2                	mov    %eax,%edx
80104068:	8b 45 08             	mov    0x8(%ebp),%eax
8010406b:	89 10                	mov    %edx,(%eax)
8010406d:	8b 45 08             	mov    0x8(%ebp),%eax
80104070:	8b 00                	mov    (%eax),%eax
80104072:	85 c0                	test   %eax,%eax
80104074:	0f 84 cb 00 00 00    	je     80104145 <pipealloc+0x104>
8010407a:	e8 14 cf ff ff       	call   80100f93 <filealloc>
8010407f:	89 c2                	mov    %eax,%edx
80104081:	8b 45 0c             	mov    0xc(%ebp),%eax
80104084:	89 10                	mov    %edx,(%eax)
80104086:	8b 45 0c             	mov    0xc(%ebp),%eax
80104089:	8b 00                	mov    (%eax),%eax
8010408b:	85 c0                	test   %eax,%eax
8010408d:	0f 84 b2 00 00 00    	je     80104145 <pipealloc+0x104>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80104093:	e8 ce eb ff ff       	call   80102c66 <kalloc>
80104098:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010409b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010409f:	0f 84 9f 00 00 00    	je     80104144 <pipealloc+0x103>
    goto bad;
  p->readopen = 1;
801040a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040a8:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801040af:	00 00 00 
  p->writeopen = 1;
801040b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040b5:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801040bc:	00 00 00 
  p->nwrite = 0;
801040bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040c2:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801040c9:	00 00 00 
  p->nread = 0;
801040cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040cf:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801040d6:	00 00 00 
  initlock(&p->lock, "pipe");
801040d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040dc:	83 ec 08             	sub    $0x8,%esp
801040df:	68 64 8e 10 80       	push   $0x80108e64
801040e4:	50                   	push   %eax
801040e5:	e8 3f 14 00 00       	call   80105529 <initlock>
801040ea:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801040ed:	8b 45 08             	mov    0x8(%ebp),%eax
801040f0:	8b 00                	mov    (%eax),%eax
801040f2:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801040f8:	8b 45 08             	mov    0x8(%ebp),%eax
801040fb:	8b 00                	mov    (%eax),%eax
801040fd:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80104101:	8b 45 08             	mov    0x8(%ebp),%eax
80104104:	8b 00                	mov    (%eax),%eax
80104106:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010410a:	8b 45 08             	mov    0x8(%ebp),%eax
8010410d:	8b 00                	mov    (%eax),%eax
8010410f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104112:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80104115:	8b 45 0c             	mov    0xc(%ebp),%eax
80104118:	8b 00                	mov    (%eax),%eax
8010411a:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80104120:	8b 45 0c             	mov    0xc(%ebp),%eax
80104123:	8b 00                	mov    (%eax),%eax
80104125:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80104129:	8b 45 0c             	mov    0xc(%ebp),%eax
8010412c:	8b 00                	mov    (%eax),%eax
8010412e:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80104132:	8b 45 0c             	mov    0xc(%ebp),%eax
80104135:	8b 00                	mov    (%eax),%eax
80104137:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010413a:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
8010413d:	b8 00 00 00 00       	mov    $0x0,%eax
80104142:	eb 4e                	jmp    80104192 <pipealloc+0x151>
  p = 0;
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
80104144:	90                   	nop
  (*f1)->pipe = p;
  return 0;

//PAGEBREAK: 20
 bad:
  if(p)
80104145:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104149:	74 0e                	je     80104159 <pipealloc+0x118>
    kfree((char*)p);
8010414b:	83 ec 0c             	sub    $0xc,%esp
8010414e:	ff 75 f4             	pushl  -0xc(%ebp)
80104151:	e8 73 ea ff ff       	call   80102bc9 <kfree>
80104156:	83 c4 10             	add    $0x10,%esp
  if(*f0)
80104159:	8b 45 08             	mov    0x8(%ebp),%eax
8010415c:	8b 00                	mov    (%eax),%eax
8010415e:	85 c0                	test   %eax,%eax
80104160:	74 11                	je     80104173 <pipealloc+0x132>
    fileclose(*f0);
80104162:	8b 45 08             	mov    0x8(%ebp),%eax
80104165:	8b 00                	mov    (%eax),%eax
80104167:	83 ec 0c             	sub    $0xc,%esp
8010416a:	50                   	push   %eax
8010416b:	e8 e1 ce ff ff       	call   80101051 <fileclose>
80104170:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80104173:	8b 45 0c             	mov    0xc(%ebp),%eax
80104176:	8b 00                	mov    (%eax),%eax
80104178:	85 c0                	test   %eax,%eax
8010417a:	74 11                	je     8010418d <pipealloc+0x14c>
    fileclose(*f1);
8010417c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010417f:	8b 00                	mov    (%eax),%eax
80104181:	83 ec 0c             	sub    $0xc,%esp
80104184:	50                   	push   %eax
80104185:	e8 c7 ce ff ff       	call   80101051 <fileclose>
8010418a:	83 c4 10             	add    $0x10,%esp
  return -1;
8010418d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104192:	c9                   	leave  
80104193:	c3                   	ret    

80104194 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80104194:	55                   	push   %ebp
80104195:	89 e5                	mov    %esp,%ebp
80104197:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
8010419a:	8b 45 08             	mov    0x8(%ebp),%eax
8010419d:	83 ec 0c             	sub    $0xc,%esp
801041a0:	50                   	push   %eax
801041a1:	e8 a5 13 00 00       	call   8010554b <acquire>
801041a6:	83 c4 10             	add    $0x10,%esp
  if(writable){
801041a9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801041ad:	74 23                	je     801041d2 <pipeclose+0x3e>
    p->writeopen = 0;
801041af:	8b 45 08             	mov    0x8(%ebp),%eax
801041b2:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
801041b9:	00 00 00 
    wakeup(&p->nread);
801041bc:	8b 45 08             	mov    0x8(%ebp),%eax
801041bf:	05 34 02 00 00       	add    $0x234,%eax
801041c4:	83 ec 0c             	sub    $0xc,%esp
801041c7:	50                   	push   %eax
801041c8:	e8 48 0d 00 00       	call   80104f15 <wakeup>
801041cd:	83 c4 10             	add    $0x10,%esp
801041d0:	eb 21                	jmp    801041f3 <pipeclose+0x5f>
  } else {
    p->readopen = 0;
801041d2:	8b 45 08             	mov    0x8(%ebp),%eax
801041d5:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
801041dc:	00 00 00 
    wakeup(&p->nwrite);
801041df:	8b 45 08             	mov    0x8(%ebp),%eax
801041e2:	05 38 02 00 00       	add    $0x238,%eax
801041e7:	83 ec 0c             	sub    $0xc,%esp
801041ea:	50                   	push   %eax
801041eb:	e8 25 0d 00 00       	call   80104f15 <wakeup>
801041f0:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
801041f3:	8b 45 08             	mov    0x8(%ebp),%eax
801041f6:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
801041fc:	85 c0                	test   %eax,%eax
801041fe:	75 2c                	jne    8010422c <pipeclose+0x98>
80104200:	8b 45 08             	mov    0x8(%ebp),%eax
80104203:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80104209:	85 c0                	test   %eax,%eax
8010420b:	75 1f                	jne    8010422c <pipeclose+0x98>
    release(&p->lock);
8010420d:	8b 45 08             	mov    0x8(%ebp),%eax
80104210:	83 ec 0c             	sub    $0xc,%esp
80104213:	50                   	push   %eax
80104214:	e8 99 13 00 00       	call   801055b2 <release>
80104219:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
8010421c:	83 ec 0c             	sub    $0xc,%esp
8010421f:	ff 75 08             	pushl  0x8(%ebp)
80104222:	e8 a2 e9 ff ff       	call   80102bc9 <kfree>
80104227:	83 c4 10             	add    $0x10,%esp
8010422a:	eb 0f                	jmp    8010423b <pipeclose+0xa7>
  } else
    release(&p->lock);
8010422c:	8b 45 08             	mov    0x8(%ebp),%eax
8010422f:	83 ec 0c             	sub    $0xc,%esp
80104232:	50                   	push   %eax
80104233:	e8 7a 13 00 00       	call   801055b2 <release>
80104238:	83 c4 10             	add    $0x10,%esp
}
8010423b:	90                   	nop
8010423c:	c9                   	leave  
8010423d:	c3                   	ret    

8010423e <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
8010423e:	55                   	push   %ebp
8010423f:	89 e5                	mov    %esp,%ebp
80104241:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
80104244:	8b 45 08             	mov    0x8(%ebp),%eax
80104247:	83 ec 0c             	sub    $0xc,%esp
8010424a:	50                   	push   %eax
8010424b:	e8 fb 12 00 00       	call   8010554b <acquire>
80104250:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
80104253:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010425a:	e9 ad 00 00 00       	jmp    8010430c <pipewrite+0xce>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
8010425f:	8b 45 08             	mov    0x8(%ebp),%eax
80104262:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104268:	85 c0                	test   %eax,%eax
8010426a:	74 0d                	je     80104279 <pipewrite+0x3b>
8010426c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104272:	8b 40 24             	mov    0x24(%eax),%eax
80104275:	85 c0                	test   %eax,%eax
80104277:	74 19                	je     80104292 <pipewrite+0x54>
        release(&p->lock);
80104279:	8b 45 08             	mov    0x8(%ebp),%eax
8010427c:	83 ec 0c             	sub    $0xc,%esp
8010427f:	50                   	push   %eax
80104280:	e8 2d 13 00 00       	call   801055b2 <release>
80104285:	83 c4 10             	add    $0x10,%esp
        return -1;
80104288:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010428d:	e9 a8 00 00 00       	jmp    8010433a <pipewrite+0xfc>
      }
      wakeup(&p->nread);
80104292:	8b 45 08             	mov    0x8(%ebp),%eax
80104295:	05 34 02 00 00       	add    $0x234,%eax
8010429a:	83 ec 0c             	sub    $0xc,%esp
8010429d:	50                   	push   %eax
8010429e:	e8 72 0c 00 00       	call   80104f15 <wakeup>
801042a3:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801042a6:	8b 45 08             	mov    0x8(%ebp),%eax
801042a9:	8b 55 08             	mov    0x8(%ebp),%edx
801042ac:	81 c2 38 02 00 00    	add    $0x238,%edx
801042b2:	83 ec 08             	sub    $0x8,%esp
801042b5:	50                   	push   %eax
801042b6:	52                   	push   %edx
801042b7:	e8 6b 0b 00 00       	call   80104e27 <sleep>
801042bc:	83 c4 10             	add    $0x10,%esp
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801042bf:	8b 45 08             	mov    0x8(%ebp),%eax
801042c2:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
801042c8:	8b 45 08             	mov    0x8(%ebp),%eax
801042cb:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
801042d1:	05 00 02 00 00       	add    $0x200,%eax
801042d6:	39 c2                	cmp    %eax,%edx
801042d8:	74 85                	je     8010425f <pipewrite+0x21>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801042da:	8b 45 08             	mov    0x8(%ebp),%eax
801042dd:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801042e3:	8d 48 01             	lea    0x1(%eax),%ecx
801042e6:	8b 55 08             	mov    0x8(%ebp),%edx
801042e9:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
801042ef:	25 ff 01 00 00       	and    $0x1ff,%eax
801042f4:	89 c1                	mov    %eax,%ecx
801042f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801042f9:	8b 45 0c             	mov    0xc(%ebp),%eax
801042fc:	01 d0                	add    %edx,%eax
801042fe:	0f b6 10             	movzbl (%eax),%edx
80104301:	8b 45 08             	mov    0x8(%ebp),%eax
80104304:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80104308:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010430c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010430f:	3b 45 10             	cmp    0x10(%ebp),%eax
80104312:	7c ab                	jl     801042bf <pipewrite+0x81>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80104314:	8b 45 08             	mov    0x8(%ebp),%eax
80104317:	05 34 02 00 00       	add    $0x234,%eax
8010431c:	83 ec 0c             	sub    $0xc,%esp
8010431f:	50                   	push   %eax
80104320:	e8 f0 0b 00 00       	call   80104f15 <wakeup>
80104325:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
80104328:	8b 45 08             	mov    0x8(%ebp),%eax
8010432b:	83 ec 0c             	sub    $0xc,%esp
8010432e:	50                   	push   %eax
8010432f:	e8 7e 12 00 00       	call   801055b2 <release>
80104334:	83 c4 10             	add    $0x10,%esp
  return n;
80104337:	8b 45 10             	mov    0x10(%ebp),%eax
}
8010433a:	c9                   	leave  
8010433b:	c3                   	ret    

8010433c <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
8010433c:	55                   	push   %ebp
8010433d:	89 e5                	mov    %esp,%ebp
8010433f:	53                   	push   %ebx
80104340:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
80104343:	8b 45 08             	mov    0x8(%ebp),%eax
80104346:	83 ec 0c             	sub    $0xc,%esp
80104349:	50                   	push   %eax
8010434a:	e8 fc 11 00 00       	call   8010554b <acquire>
8010434f:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104352:	eb 3f                	jmp    80104393 <piperead+0x57>
    if(proc->killed){
80104354:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010435a:	8b 40 24             	mov    0x24(%eax),%eax
8010435d:	85 c0                	test   %eax,%eax
8010435f:	74 19                	je     8010437a <piperead+0x3e>
      release(&p->lock);
80104361:	8b 45 08             	mov    0x8(%ebp),%eax
80104364:	83 ec 0c             	sub    $0xc,%esp
80104367:	50                   	push   %eax
80104368:	e8 45 12 00 00       	call   801055b2 <release>
8010436d:	83 c4 10             	add    $0x10,%esp
      return -1;
80104370:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104375:	e9 bf 00 00 00       	jmp    80104439 <piperead+0xfd>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
8010437a:	8b 45 08             	mov    0x8(%ebp),%eax
8010437d:	8b 55 08             	mov    0x8(%ebp),%edx
80104380:	81 c2 34 02 00 00    	add    $0x234,%edx
80104386:	83 ec 08             	sub    $0x8,%esp
80104389:	50                   	push   %eax
8010438a:	52                   	push   %edx
8010438b:	e8 97 0a 00 00       	call   80104e27 <sleep>
80104390:	83 c4 10             	add    $0x10,%esp
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104393:	8b 45 08             	mov    0x8(%ebp),%eax
80104396:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
8010439c:	8b 45 08             	mov    0x8(%ebp),%eax
8010439f:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801043a5:	39 c2                	cmp    %eax,%edx
801043a7:	75 0d                	jne    801043b6 <piperead+0x7a>
801043a9:	8b 45 08             	mov    0x8(%ebp),%eax
801043ac:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
801043b2:	85 c0                	test   %eax,%eax
801043b4:	75 9e                	jne    80104354 <piperead+0x18>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801043b6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801043bd:	eb 49                	jmp    80104408 <piperead+0xcc>
    if(p->nread == p->nwrite)
801043bf:	8b 45 08             	mov    0x8(%ebp),%eax
801043c2:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
801043c8:	8b 45 08             	mov    0x8(%ebp),%eax
801043cb:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801043d1:	39 c2                	cmp    %eax,%edx
801043d3:	74 3d                	je     80104412 <piperead+0xd6>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801043d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801043d8:	8b 45 0c             	mov    0xc(%ebp),%eax
801043db:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
801043de:	8b 45 08             	mov    0x8(%ebp),%eax
801043e1:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
801043e7:	8d 48 01             	lea    0x1(%eax),%ecx
801043ea:	8b 55 08             	mov    0x8(%ebp),%edx
801043ed:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
801043f3:	25 ff 01 00 00       	and    $0x1ff,%eax
801043f8:	89 c2                	mov    %eax,%edx
801043fa:	8b 45 08             	mov    0x8(%ebp),%eax
801043fd:	0f b6 44 10 34       	movzbl 0x34(%eax,%edx,1),%eax
80104402:	88 03                	mov    %al,(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104404:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104408:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010440b:	3b 45 10             	cmp    0x10(%ebp),%eax
8010440e:	7c af                	jl     801043bf <piperead+0x83>
80104410:	eb 01                	jmp    80104413 <piperead+0xd7>
    if(p->nread == p->nwrite)
      break;
80104412:	90                   	nop
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80104413:	8b 45 08             	mov    0x8(%ebp),%eax
80104416:	05 38 02 00 00       	add    $0x238,%eax
8010441b:	83 ec 0c             	sub    $0xc,%esp
8010441e:	50                   	push   %eax
8010441f:	e8 f1 0a 00 00       	call   80104f15 <wakeup>
80104424:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
80104427:	8b 45 08             	mov    0x8(%ebp),%eax
8010442a:	83 ec 0c             	sub    $0xc,%esp
8010442d:	50                   	push   %eax
8010442e:	e8 7f 11 00 00       	call   801055b2 <release>
80104433:	83 c4 10             	add    $0x10,%esp
  return i;
80104436:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104439:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010443c:	c9                   	leave  
8010443d:	c3                   	ret    

8010443e <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
8010443e:	55                   	push   %ebp
8010443f:	89 e5                	mov    %esp,%ebp
80104441:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104444:	9c                   	pushf  
80104445:	58                   	pop    %eax
80104446:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80104449:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010444c:	c9                   	leave  
8010444d:	c3                   	ret    

8010444e <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
8010444e:	55                   	push   %ebp
8010444f:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104451:	fb                   	sti    
}
80104452:	90                   	nop
80104453:	5d                   	pop    %ebp
80104454:	c3                   	ret    

80104455 <pinit>:
void scheduler_frr(void) __attribute__((noreturn));
void scheduler_fcfs(void) __attribute__((noreturn));

void
pinit(void)
{
80104455:	55                   	push   %ebp
80104456:	89 e5                	mov    %esp,%ebp
80104458:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
8010445b:	83 ec 08             	sub    $0x8,%esp
8010445e:	68 69 8e 10 80       	push   $0x80108e69
80104463:	68 a0 3a 11 80       	push   $0x80113aa0
80104468:	e8 bc 10 00 00       	call   80105529 <initlock>
8010446d:	83 c4 10             	add    $0x10,%esp
}
80104470:	90                   	nop
80104471:	c9                   	leave  
80104472:	c3                   	ret    

80104473 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80104473:	55                   	push   %ebp
80104474:	89 e5                	mov    %esp,%ebp
80104476:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
80104479:	83 ec 0c             	sub    $0xc,%esp
8010447c:	68 a0 3a 11 80       	push   $0x80113aa0
80104481:	e8 c5 10 00 00       	call   8010554b <acquire>
80104486:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104489:	c7 45 f4 d4 3a 11 80 	movl   $0x80113ad4,-0xc(%ebp)
80104490:	eb 11                	jmp    801044a3 <allocproc+0x30>
    if(p->state == UNUSED)
80104492:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104495:	8b 40 0c             	mov    0xc(%eax),%eax
80104498:	85 c0                	test   %eax,%eax
8010449a:	74 2a                	je     801044c6 <allocproc+0x53>
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010449c:	81 45 f4 94 00 00 00 	addl   $0x94,-0xc(%ebp)
801044a3:	81 7d f4 d4 5f 11 80 	cmpl   $0x80115fd4,-0xc(%ebp)
801044aa:	72 e6                	jb     80104492 <allocproc+0x1f>
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
801044ac:	83 ec 0c             	sub    $0xc,%esp
801044af:	68 a0 3a 11 80       	push   $0x80113aa0
801044b4:	e8 f9 10 00 00       	call   801055b2 <release>
801044b9:	83 c4 10             	add    $0x10,%esp
  return 0;
801044bc:	b8 00 00 00 00       	mov    $0x0,%eax
801044c1:	e9 ee 00 00 00       	jmp    801045b4 <allocproc+0x141>
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
801044c6:	90                   	nop
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801044c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044ca:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
801044d1:	a1 04 c0 10 80       	mov    0x8010c004,%eax
801044d6:	8d 50 01             	lea    0x1(%eax),%edx
801044d9:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
801044df:	8b 55 f4             	mov    -0xc(%ebp),%edx
801044e2:	89 42 10             	mov    %eax,0x10(%edx)
  release(&ptable.lock);
801044e5:	83 ec 0c             	sub    $0xc,%esp
801044e8:	68 a0 3a 11 80       	push   $0x80113aa0
801044ed:	e8 c0 10 00 00       	call   801055b2 <release>
801044f2:	83 c4 10             	add    $0x10,%esp

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801044f5:	e8 6c e7 ff ff       	call   80102c66 <kalloc>
801044fa:	89 c2                	mov    %eax,%edx
801044fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044ff:	89 50 08             	mov    %edx,0x8(%eax)
80104502:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104505:	8b 40 08             	mov    0x8(%eax),%eax
80104508:	85 c0                	test   %eax,%eax
8010450a:	75 14                	jne    80104520 <allocproc+0xad>
    p->state = UNUSED;
8010450c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010450f:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
80104516:	b8 00 00 00 00       	mov    $0x0,%eax
8010451b:	e9 94 00 00 00       	jmp    801045b4 <allocproc+0x141>
  }
  sp = p->kstack + KSTACKSIZE;
80104520:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104523:	8b 40 08             	mov    0x8(%eax),%eax
80104526:	05 00 10 00 00       	add    $0x1000,%eax
8010452b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010452e:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
80104532:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104535:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104538:	89 50 18             	mov    %edx,0x18(%eax)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
8010453b:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
8010453f:	ba 36 6c 10 80       	mov    $0x80106c36,%edx
80104544:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104547:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
80104549:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
8010454d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104550:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104553:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
80104556:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104559:	8b 40 1c             	mov    0x1c(%eax),%eax
8010455c:	83 ec 04             	sub    $0x4,%esp
8010455f:	6a 14                	push   $0x14
80104561:	6a 00                	push   $0x0
80104563:	50                   	push   %eax
80104564:	e8 45 12 00 00       	call   801057ae <memset>
80104569:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
8010456c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010456f:	8b 40 1c             	mov    0x1c(%eax),%eax
80104572:	ba e1 4d 10 80       	mov    $0x80104de1,%edx
80104577:	89 50 10             	mov    %edx,0x10(%eax)

	p->ctime = ticks;
8010457a:	a1 20 68 11 80       	mov    0x80116820,%eax
8010457f:	89 c2                	mov    %eax,%edx
80104581:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104584:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
	p->stime = 0;
8010458a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010458d:	c7 80 88 00 00 00 00 	movl   $0x0,0x88(%eax)
80104594:	00 00 00 
	p->retime = 0;
80104597:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010459a:	c7 80 8c 00 00 00 00 	movl   $0x0,0x8c(%eax)
801045a1:	00 00 00 
	p->rutime = 0;
801045a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045a7:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
801045ae:	00 00 00 

  return p;
801045b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801045b4:	c9                   	leave  
801045b5:	c3                   	ret    

801045b6 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801045b6:	55                   	push   %ebp
801045b7:	89 e5                	mov    %esp,%ebp
801045b9:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
801045bc:	e8 b2 fe ff ff       	call   80104473 <allocproc>
801045c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  initproc = p;
801045c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045c7:	a3 48 c6 10 80       	mov    %eax,0x8010c648
  if((p->pgdir = setupkvm()) == 0)
801045cc:	e8 2a 3d 00 00       	call   801082fb <setupkvm>
801045d1:	89 c2                	mov    %eax,%edx
801045d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045d6:	89 50 04             	mov    %edx,0x4(%eax)
801045d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045dc:	8b 40 04             	mov    0x4(%eax),%eax
801045df:	85 c0                	test   %eax,%eax
801045e1:	75 0d                	jne    801045f0 <userinit+0x3a>
    panic("userinit: out of memory?");
801045e3:	83 ec 0c             	sub    $0xc,%esp
801045e6:	68 70 8e 10 80       	push   $0x80108e70
801045eb:	e8 76 bf ff ff       	call   80100566 <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801045f0:	ba 2c 00 00 00       	mov    $0x2c,%edx
801045f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045f8:	8b 40 04             	mov    0x4(%eax),%eax
801045fb:	83 ec 04             	sub    $0x4,%esp
801045fe:	52                   	push   %edx
801045ff:	68 e0 c4 10 80       	push   $0x8010c4e0
80104604:	50                   	push   %eax
80104605:	e8 4b 3f 00 00       	call   80108555 <inituvm>
8010460a:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
8010460d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104610:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
80104616:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104619:	8b 40 18             	mov    0x18(%eax),%eax
8010461c:	83 ec 04             	sub    $0x4,%esp
8010461f:	6a 4c                	push   $0x4c
80104621:	6a 00                	push   $0x0
80104623:	50                   	push   %eax
80104624:	e8 85 11 00 00       	call   801057ae <memset>
80104629:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010462c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010462f:	8b 40 18             	mov    0x18(%eax),%eax
80104632:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104638:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010463b:	8b 40 18             	mov    0x18(%eax),%eax
8010463e:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104644:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104647:	8b 40 18             	mov    0x18(%eax),%eax
8010464a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010464d:	8b 52 18             	mov    0x18(%edx),%edx
80104650:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104654:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104658:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010465b:	8b 40 18             	mov    0x18(%eax),%eax
8010465e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104661:	8b 52 18             	mov    0x18(%edx),%edx
80104664:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104668:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010466c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010466f:	8b 40 18             	mov    0x18(%eax),%eax
80104672:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104679:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010467c:	8b 40 18             	mov    0x18(%eax),%eax
8010467f:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104686:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104689:	8b 40 18             	mov    0x18(%eax),%eax
8010468c:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80104693:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104696:	83 c0 6c             	add    $0x6c,%eax
80104699:	83 ec 04             	sub    $0x4,%esp
8010469c:	6a 10                	push   $0x10
8010469e:	68 89 8e 10 80       	push   $0x80108e89
801046a3:	50                   	push   %eax
801046a4:	e8 08 13 00 00       	call   801059b1 <safestrcpy>
801046a9:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
801046ac:	83 ec 0c             	sub    $0xc,%esp
801046af:	68 92 8e 10 80       	push   $0x80108e92
801046b4:	e8 6f de ff ff       	call   80102528 <namei>
801046b9:	83 c4 10             	add    $0x10,%esp
801046bc:	89 c2                	mov    %eax,%edx
801046be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046c1:	89 50 68             	mov    %edx,0x68(%eax)

  p->state = RUNNABLE;
801046c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046c7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
}
801046ce:	90                   	nop
801046cf:	c9                   	leave  
801046d0:	c3                   	ret    

801046d1 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
801046d1:	55                   	push   %ebp
801046d2:	89 e5                	mov    %esp,%ebp
801046d4:	83 ec 18             	sub    $0x18,%esp
  uint sz;
  
  sz = proc->sz;
801046d7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046dd:	8b 00                	mov    (%eax),%eax
801046df:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
801046e2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801046e6:	7e 31                	jle    80104719 <growproc+0x48>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
801046e8:	8b 55 08             	mov    0x8(%ebp),%edx
801046eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046ee:	01 c2                	add    %eax,%edx
801046f0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046f6:	8b 40 04             	mov    0x4(%eax),%eax
801046f9:	83 ec 04             	sub    $0x4,%esp
801046fc:	52                   	push   %edx
801046fd:	ff 75 f4             	pushl  -0xc(%ebp)
80104700:	50                   	push   %eax
80104701:	e8 9c 3f 00 00       	call   801086a2 <allocuvm>
80104706:	83 c4 10             	add    $0x10,%esp
80104709:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010470c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104710:	75 3e                	jne    80104750 <growproc+0x7f>
      return -1;
80104712:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104717:	eb 59                	jmp    80104772 <growproc+0xa1>
  } else if(n < 0){
80104719:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010471d:	79 31                	jns    80104750 <growproc+0x7f>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
8010471f:	8b 55 08             	mov    0x8(%ebp),%edx
80104722:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104725:	01 c2                	add    %eax,%edx
80104727:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010472d:	8b 40 04             	mov    0x4(%eax),%eax
80104730:	83 ec 04             	sub    $0x4,%esp
80104733:	52                   	push   %edx
80104734:	ff 75 f4             	pushl  -0xc(%ebp)
80104737:	50                   	push   %eax
80104738:	e8 2e 40 00 00       	call   8010876b <deallocuvm>
8010473d:	83 c4 10             	add    $0x10,%esp
80104740:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104743:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104747:	75 07                	jne    80104750 <growproc+0x7f>
      return -1;
80104749:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010474e:	eb 22                	jmp    80104772 <growproc+0xa1>
  }
  proc->sz = sz;
80104750:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104756:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104759:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
8010475b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104761:	83 ec 0c             	sub    $0xc,%esp
80104764:	50                   	push   %eax
80104765:	e8 78 3c 00 00       	call   801083e2 <switchuvm>
8010476a:	83 c4 10             	add    $0x10,%esp
  return 0;
8010476d:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104772:	c9                   	leave  
80104773:	c3                   	ret    

80104774 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80104774:	55                   	push   %ebp
80104775:	89 e5                	mov    %esp,%ebp
80104777:	57                   	push   %edi
80104778:	56                   	push   %esi
80104779:	53                   	push   %ebx
8010477a:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
8010477d:	e8 f1 fc ff ff       	call   80104473 <allocproc>
80104782:	89 45 e0             	mov    %eax,-0x20(%ebp)
80104785:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80104789:	75 0a                	jne    80104795 <fork+0x21>
    return -1;
8010478b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104790:	e9 68 01 00 00       	jmp    801048fd <fork+0x189>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80104795:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010479b:	8b 10                	mov    (%eax),%edx
8010479d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047a3:	8b 40 04             	mov    0x4(%eax),%eax
801047a6:	83 ec 08             	sub    $0x8,%esp
801047a9:	52                   	push   %edx
801047aa:	50                   	push   %eax
801047ab:	e8 59 41 00 00       	call   80108909 <copyuvm>
801047b0:	83 c4 10             	add    $0x10,%esp
801047b3:	89 c2                	mov    %eax,%edx
801047b5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047b8:	89 50 04             	mov    %edx,0x4(%eax)
801047bb:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047be:	8b 40 04             	mov    0x4(%eax),%eax
801047c1:	85 c0                	test   %eax,%eax
801047c3:	75 30                	jne    801047f5 <fork+0x81>
    kfree(np->kstack);
801047c5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047c8:	8b 40 08             	mov    0x8(%eax),%eax
801047cb:	83 ec 0c             	sub    $0xc,%esp
801047ce:	50                   	push   %eax
801047cf:	e8 f5 e3 ff ff       	call   80102bc9 <kfree>
801047d4:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
801047d7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047da:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
801047e1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047e4:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
801047eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801047f0:	e9 08 01 00 00       	jmp    801048fd <fork+0x189>
  }
  np->sz = proc->sz;
801047f5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047fb:	8b 10                	mov    (%eax),%edx
801047fd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104800:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
80104802:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104809:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010480c:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
8010480f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104812:	8b 50 18             	mov    0x18(%eax),%edx
80104815:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010481b:	8b 40 18             	mov    0x18(%eax),%eax
8010481e:	89 c3                	mov    %eax,%ebx
80104820:	b8 13 00 00 00       	mov    $0x13,%eax
80104825:	89 d7                	mov    %edx,%edi
80104827:	89 de                	mov    %ebx,%esi
80104829:	89 c1                	mov    %eax,%ecx
8010482b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
8010482d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104830:	8b 40 18             	mov    0x18(%eax),%eax
80104833:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
8010483a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80104841:	eb 43                	jmp    80104886 <fork+0x112>
    if(proc->ofile[i])
80104843:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104849:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010484c:	83 c2 08             	add    $0x8,%edx
8010484f:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104853:	85 c0                	test   %eax,%eax
80104855:	74 2b                	je     80104882 <fork+0x10e>
      np->ofile[i] = filedup(proc->ofile[i]);
80104857:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010485d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104860:	83 c2 08             	add    $0x8,%edx
80104863:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104867:	83 ec 0c             	sub    $0xc,%esp
8010486a:	50                   	push   %eax
8010486b:	e8 90 c7 ff ff       	call   80101000 <filedup>
80104870:	83 c4 10             	add    $0x10,%esp
80104873:	89 c1                	mov    %eax,%ecx
80104875:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104878:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010487b:	83 c2 08             	add    $0x8,%edx
8010487e:	89 4c 90 08          	mov    %ecx,0x8(%eax,%edx,4)
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80104882:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80104886:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
8010488a:	7e b7                	jle    80104843 <fork+0xcf>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
8010488c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104892:	8b 40 68             	mov    0x68(%eax),%eax
80104895:	83 ec 0c             	sub    $0xc,%esp
80104898:	50                   	push   %eax
80104899:	e8 92 d0 ff ff       	call   80101930 <idup>
8010489e:	83 c4 10             	add    $0x10,%esp
801048a1:	89 c2                	mov    %eax,%edx
801048a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048a6:	89 50 68             	mov    %edx,0x68(%eax)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
801048a9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048af:	8d 50 6c             	lea    0x6c(%eax),%edx
801048b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048b5:	83 c0 6c             	add    $0x6c,%eax
801048b8:	83 ec 04             	sub    $0x4,%esp
801048bb:	6a 10                	push   $0x10
801048bd:	52                   	push   %edx
801048be:	50                   	push   %eax
801048bf:	e8 ed 10 00 00       	call   801059b1 <safestrcpy>
801048c4:	83 c4 10             	add    $0x10,%esp
 
  pid = np->pid;
801048c7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048ca:	8b 40 10             	mov    0x10(%eax),%eax
801048cd:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // lock to force the compiler to emit the np->state write last.
  acquire(&ptable.lock);
801048d0:	83 ec 0c             	sub    $0xc,%esp
801048d3:	68 a0 3a 11 80       	push   $0x80113aa0
801048d8:	e8 6e 0c 00 00       	call   8010554b <acquire>
801048dd:	83 c4 10             	add    $0x10,%esp
  np->state = RUNNABLE;
801048e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048e3:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  release(&ptable.lock);
801048ea:	83 ec 0c             	sub    $0xc,%esp
801048ed:	68 a0 3a 11 80       	push   $0x80113aa0
801048f2:	e8 bb 0c 00 00       	call   801055b2 <release>
801048f7:	83 c4 10             	add    $0x10,%esp
  
  return pid;
801048fa:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
801048fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104900:	5b                   	pop    %ebx
80104901:	5e                   	pop    %esi
80104902:	5f                   	pop    %edi
80104903:	5d                   	pop    %ebp
80104904:	c3                   	ret    

80104905 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80104905:	55                   	push   %ebp
80104906:	89 e5                	mov    %esp,%ebp
80104908:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
8010490b:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104912:	a1 48 c6 10 80       	mov    0x8010c648,%eax
80104917:	39 c2                	cmp    %eax,%edx
80104919:	75 0d                	jne    80104928 <exit+0x23>
    panic("init exiting");
8010491b:	83 ec 0c             	sub    $0xc,%esp
8010491e:	68 94 8e 10 80       	push   $0x80108e94
80104923:	e8 3e bc ff ff       	call   80100566 <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104928:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010492f:	eb 48                	jmp    80104979 <exit+0x74>
    if(proc->ofile[fd]){
80104931:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104937:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010493a:	83 c2 08             	add    $0x8,%edx
8010493d:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104941:	85 c0                	test   %eax,%eax
80104943:	74 30                	je     80104975 <exit+0x70>
      fileclose(proc->ofile[fd]);
80104945:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010494b:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010494e:	83 c2 08             	add    $0x8,%edx
80104951:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104955:	83 ec 0c             	sub    $0xc,%esp
80104958:	50                   	push   %eax
80104959:	e8 f3 c6 ff ff       	call   80101051 <fileclose>
8010495e:	83 c4 10             	add    $0x10,%esp
      proc->ofile[fd] = 0;
80104961:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104967:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010496a:	83 c2 08             	add    $0x8,%edx
8010496d:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80104974:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104975:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80104979:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
8010497d:	7e b2                	jle    80104931 <exit+0x2c>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
8010497f:	e8 c9 eb ff ff       	call   8010354d <begin_op>
  iput(proc->cwd);
80104984:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010498a:	8b 40 68             	mov    0x68(%eax),%eax
8010498d:	83 ec 0c             	sub    $0xc,%esp
80104990:	50                   	push   %eax
80104991:	e8 a4 d1 ff ff       	call   80101b3a <iput>
80104996:	83 c4 10             	add    $0x10,%esp
  end_op();
80104999:	e8 3b ec ff ff       	call   801035d9 <end_op>
  proc->cwd = 0;
8010499e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049a4:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
801049ab:	83 ec 0c             	sub    $0xc,%esp
801049ae:	68 a0 3a 11 80       	push   $0x80113aa0
801049b3:	e8 93 0b 00 00       	call   8010554b <acquire>
801049b8:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
801049bb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049c1:	8b 40 14             	mov    0x14(%eax),%eax
801049c4:	83 ec 0c             	sub    $0xc,%esp
801049c7:	50                   	push   %eax
801049c8:	e8 06 05 00 00       	call   80104ed3 <wakeup1>
801049cd:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049d0:	c7 45 f4 d4 3a 11 80 	movl   $0x80113ad4,-0xc(%ebp)
801049d7:	eb 3f                	jmp    80104a18 <exit+0x113>
    if(p->parent == proc){
801049d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049dc:	8b 50 14             	mov    0x14(%eax),%edx
801049df:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049e5:	39 c2                	cmp    %eax,%edx
801049e7:	75 28                	jne    80104a11 <exit+0x10c>
      p->parent = initproc;
801049e9:	8b 15 48 c6 10 80    	mov    0x8010c648,%edx
801049ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049f2:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
801049f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049f8:	8b 40 0c             	mov    0xc(%eax),%eax
801049fb:	83 f8 05             	cmp    $0x5,%eax
801049fe:	75 11                	jne    80104a11 <exit+0x10c>
        wakeup1(initproc);
80104a00:	a1 48 c6 10 80       	mov    0x8010c648,%eax
80104a05:	83 ec 0c             	sub    $0xc,%esp
80104a08:	50                   	push   %eax
80104a09:	e8 c5 04 00 00       	call   80104ed3 <wakeup1>
80104a0e:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a11:	81 45 f4 94 00 00 00 	addl   $0x94,-0xc(%ebp)
80104a18:	81 7d f4 d4 5f 11 80 	cmpl   $0x80115fd4,-0xc(%ebp)
80104a1f:	72 b8                	jb     801049d9 <exit+0xd4>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
80104a21:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a27:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
80104a2e:	e8 a5 02 00 00       	call   80104cd8 <sched>
  panic("zombie exit");
80104a33:	83 ec 0c             	sub    $0xc,%esp
80104a36:	68 a1 8e 10 80       	push   $0x80108ea1
80104a3b:	e8 26 bb ff ff       	call   80100566 <panic>

80104a40 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80104a40:	55                   	push   %ebp
80104a41:	89 e5                	mov    %esp,%ebp
80104a43:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80104a46:	83 ec 0c             	sub    $0xc,%esp
80104a49:	68 a0 3a 11 80       	push   $0x80113aa0
80104a4e:	e8 f8 0a 00 00       	call   8010554b <acquire>
80104a53:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
80104a56:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a5d:	c7 45 f4 d4 3a 11 80 	movl   $0x80113ad4,-0xc(%ebp)
80104a64:	e9 a9 00 00 00       	jmp    80104b12 <wait+0xd2>
      if(p->parent != proc)
80104a69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a6c:	8b 50 14             	mov    0x14(%eax),%edx
80104a6f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a75:	39 c2                	cmp    %eax,%edx
80104a77:	0f 85 8d 00 00 00    	jne    80104b0a <wait+0xca>
        continue;
      havekids = 1;
80104a7d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
80104a84:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a87:	8b 40 0c             	mov    0xc(%eax),%eax
80104a8a:	83 f8 05             	cmp    $0x5,%eax
80104a8d:	75 7c                	jne    80104b0b <wait+0xcb>
        // Found one.
        pid = p->pid;
80104a8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a92:	8b 40 10             	mov    0x10(%eax),%eax
80104a95:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
80104a98:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a9b:	8b 40 08             	mov    0x8(%eax),%eax
80104a9e:	83 ec 0c             	sub    $0xc,%esp
80104aa1:	50                   	push   %eax
80104aa2:	e8 22 e1 ff ff       	call   80102bc9 <kfree>
80104aa7:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
80104aaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104aad:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
80104ab4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ab7:	8b 40 04             	mov    0x4(%eax),%eax
80104aba:	83 ec 0c             	sub    $0xc,%esp
80104abd:	50                   	push   %eax
80104abe:	e8 65 3d 00 00       	call   80108828 <freevm>
80104ac3:	83 c4 10             	add    $0x10,%esp
        p->state = UNUSED;
80104ac6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ac9:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        p->pid = 0;
80104ad0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ad3:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80104ada:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104add:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
80104ae4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ae7:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
80104aeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104aee:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        release(&ptable.lock);
80104af5:	83 ec 0c             	sub    $0xc,%esp
80104af8:	68 a0 3a 11 80       	push   $0x80113aa0
80104afd:	e8 b0 0a 00 00       	call   801055b2 <release>
80104b02:	83 c4 10             	add    $0x10,%esp
        return pid;
80104b05:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104b08:	eb 5b                	jmp    80104b65 <wait+0x125>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
80104b0a:	90                   	nop

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b0b:	81 45 f4 94 00 00 00 	addl   $0x94,-0xc(%ebp)
80104b12:	81 7d f4 d4 5f 11 80 	cmpl   $0x80115fd4,-0xc(%ebp)
80104b19:	0f 82 4a ff ff ff    	jb     80104a69 <wait+0x29>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80104b1f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104b23:	74 0d                	je     80104b32 <wait+0xf2>
80104b25:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b2b:	8b 40 24             	mov    0x24(%eax),%eax
80104b2e:	85 c0                	test   %eax,%eax
80104b30:	74 17                	je     80104b49 <wait+0x109>
      release(&ptable.lock);
80104b32:	83 ec 0c             	sub    $0xc,%esp
80104b35:	68 a0 3a 11 80       	push   $0x80113aa0
80104b3a:	e8 73 0a 00 00       	call   801055b2 <release>
80104b3f:	83 c4 10             	add    $0x10,%esp
      return -1;
80104b42:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b47:	eb 1c                	jmp    80104b65 <wait+0x125>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80104b49:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b4f:	83 ec 08             	sub    $0x8,%esp
80104b52:	68 a0 3a 11 80       	push   $0x80113aa0
80104b57:	50                   	push   %eax
80104b58:	e8 ca 02 00 00       	call   80104e27 <sleep>
80104b5d:	83 c4 10             	add    $0x10,%esp
  }
80104b60:	e9 f1 fe ff ff       	jmp    80104a56 <wait+0x16>
}
80104b65:	c9                   	leave  
80104b66:	c3                   	ret    

80104b67 <wait_stat>:

int wait_stat(int *wtime, int *rtime, int *iotime, int *status)
{
80104b67:	55                   	push   %ebp
80104b68:	89 e5                	mov    %esp,%ebp
80104b6a:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;     //initalize  struct to use for the son procces
  int havekids, pid;

  acquire(&ptable.lock);
80104b6d:	83 ec 0c             	sub    $0xc,%esp
80104b70:	68 a0 3a 11 80       	push   $0x80113aa0
80104b75:	e8 d1 09 00 00       	call   8010554b <acquire>
80104b7a:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
80104b7d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b84:	c7 45 f4 d4 3a 11 80 	movl   $0x80113ad4,-0xc(%ebp)
80104b8b:	e9 e8 00 00 00       	jmp    80104c78 <wait_stat+0x111>
      if(p->parent != proc)
80104b90:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b93:	8b 50 14             	mov    0x14(%eax),%edx
80104b96:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b9c:	39 c2                	cmp    %eax,%edx
80104b9e:	0f 85 cc 00 00 00    	jne    80104c70 <wait_stat+0x109>
        continue;
      havekids = 1;
80104ba4:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)

      if(p->state == ZOMBIE){
80104bab:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bae:	8b 40 0c             	mov    0xc(%eax),%eax
80104bb1:	83 f8 05             	cmp    $0x5,%eax
80104bb4:	0f 85 b7 00 00 00    	jne    80104c71 <wait_stat+0x10a>

        // Found one.
        pid = p->pid;
80104bba:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bbd:	8b 40 10             	mov    0x10(%eax),%eax
80104bc0:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
80104bc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bc6:	8b 40 08             	mov    0x8(%eax),%eax
80104bc9:	83 ec 0c             	sub    $0xc,%esp
80104bcc:	50                   	push   %eax
80104bcd:	e8 f7 df ff ff       	call   80102bc9 <kfree>
80104bd2:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
80104bd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bd8:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
80104bdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104be2:	8b 40 04             	mov    0x4(%eax),%eax
80104be5:	83 ec 0c             	sub    $0xc,%esp
80104be8:	50                   	push   %eax
80104be9:	e8 3a 3c 00 00       	call   80108828 <freevm>
80104bee:	83 c4 10             	add    $0x10,%esp
        p->state = UNUSED;
80104bf1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bf4:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        p->pid = 0;
80104bfb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bfe:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80104c05:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c08:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
80104c0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c12:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
80104c16:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c19:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)

        *iotime = p->stime;
80104c20:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c23:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
80104c29:	8b 45 10             	mov    0x10(%ebp),%eax
80104c2c:	89 10                	mov    %edx,(%eax)
        *rtime = p->rutime;
80104c2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c31:	8b 90 90 00 00 00    	mov    0x90(%eax),%edx
80104c37:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c3a:	89 10                	mov    %edx,(%eax)
        *wtime = p->retime;
80104c3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c3f:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80104c45:	8b 45 08             	mov    0x8(%ebp),%eax
80104c48:	89 10                	mov    %edx,(%eax)
        if (status != NULL)
80104c4a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80104c4e:	74 0b                	je     80104c5b <wait_stat+0xf4>
          *status= p->exit_status;
80104c50:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c53:	8b 50 7c             	mov    0x7c(%eax),%edx
80104c56:	8b 45 14             	mov    0x14(%ebp),%eax
80104c59:	89 10                	mov    %edx,(%eax)
        release(&ptable.lock);
80104c5b:	83 ec 0c             	sub    $0xc,%esp
80104c5e:	68 a0 3a 11 80       	push   $0x80113aa0
80104c63:	e8 4a 09 00 00       	call   801055b2 <release>
80104c68:	83 c4 10             	add    $0x10,%esp
        return pid;
80104c6b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104c6e:	eb 5b                	jmp    80104ccb <wait_stat+0x164>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
80104c70:	90                   	nop

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c71:	81 45 f4 94 00 00 00 	addl   $0x94,-0xc(%ebp)
80104c78:	81 7d f4 d4 5f 11 80 	cmpl   $0x80115fd4,-0xc(%ebp)
80104c7f:	0f 82 0b ff ff ff    	jb     80104b90 <wait_stat+0x29>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80104c85:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104c89:	74 0d                	je     80104c98 <wait_stat+0x131>
80104c8b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c91:	8b 40 24             	mov    0x24(%eax),%eax
80104c94:	85 c0                	test   %eax,%eax
80104c96:	74 17                	je     80104caf <wait_stat+0x148>
      release(&ptable.lock);
80104c98:	83 ec 0c             	sub    $0xc,%esp
80104c9b:	68 a0 3a 11 80       	push   $0x80113aa0
80104ca0:	e8 0d 09 00 00       	call   801055b2 <release>
80104ca5:	83 c4 10             	add    $0x10,%esp
      return -1;
80104ca8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104cad:	eb 1c                	jmp    80104ccb <wait_stat+0x164>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80104caf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cb5:	83 ec 08             	sub    $0x8,%esp
80104cb8:	68 a0 3a 11 80       	push   $0x80113aa0
80104cbd:	50                   	push   %eax
80104cbe:	e8 64 01 00 00       	call   80104e27 <sleep>
80104cc3:	83 c4 10             	add    $0x10,%esp
  }
80104cc6:	e9 b2 fe ff ff       	jmp    80104b7d <wait_stat+0x16>
}
80104ccb:	c9                   	leave  
80104ccc:	c3                   	ret    

80104ccd <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80104ccd:	55                   	push   %ebp
80104cce:	89 e5                	mov    %esp,%ebp
80104cd0:	83 ec 08             	sub    $0x8,%esp
  #ifdef DEFAULT
    scheduler_default();
80104cd3:	e8 f7 03 00 00       	call   801050cf <scheduler_default>

80104cd8 <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
80104cd8:	55                   	push   %ebp
80104cd9:	89 e5                	mov    %esp,%ebp
80104cdb:	83 ec 18             	sub    $0x18,%esp
  int intena;

  if(!holding(&ptable.lock))
80104cde:	83 ec 0c             	sub    $0xc,%esp
80104ce1:	68 a0 3a 11 80       	push   $0x80113aa0
80104ce6:	e8 93 09 00 00       	call   8010567e <holding>
80104ceb:	83 c4 10             	add    $0x10,%esp
80104cee:	85 c0                	test   %eax,%eax
80104cf0:	75 0d                	jne    80104cff <sched+0x27>
    panic("sched ptable.lock");
80104cf2:	83 ec 0c             	sub    $0xc,%esp
80104cf5:	68 ad 8e 10 80       	push   $0x80108ead
80104cfa:	e8 67 b8 ff ff       	call   80100566 <panic>
  if(cpu->ncli != 1)
80104cff:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104d05:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104d0b:	83 f8 01             	cmp    $0x1,%eax
80104d0e:	74 0d                	je     80104d1d <sched+0x45>
    panic("sched locks");
80104d10:	83 ec 0c             	sub    $0xc,%esp
80104d13:	68 bf 8e 10 80       	push   $0x80108ebf
80104d18:	e8 49 b8 ff ff       	call   80100566 <panic>
  if(proc->state == RUNNING)
80104d1d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d23:	8b 40 0c             	mov    0xc(%eax),%eax
80104d26:	83 f8 04             	cmp    $0x4,%eax
80104d29:	75 0d                	jne    80104d38 <sched+0x60>
    panic("sched running");
80104d2b:	83 ec 0c             	sub    $0xc,%esp
80104d2e:	68 cb 8e 10 80       	push   $0x80108ecb
80104d33:	e8 2e b8 ff ff       	call   80100566 <panic>
  if(readeflags()&FL_IF)
80104d38:	e8 01 f7 ff ff       	call   8010443e <readeflags>
80104d3d:	25 00 02 00 00       	and    $0x200,%eax
80104d42:	85 c0                	test   %eax,%eax
80104d44:	74 0d                	je     80104d53 <sched+0x7b>
    panic("sched interruptible");
80104d46:	83 ec 0c             	sub    $0xc,%esp
80104d49:	68 d9 8e 10 80       	push   $0x80108ed9
80104d4e:	e8 13 b8 ff ff       	call   80100566 <panic>
  intena = cpu->intena;
80104d53:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104d59:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104d5f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
80104d62:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104d68:	8b 40 04             	mov    0x4(%eax),%eax
80104d6b:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104d72:	83 c2 1c             	add    $0x1c,%edx
80104d75:	83 ec 08             	sub    $0x8,%esp
80104d78:	50                   	push   %eax
80104d79:	52                   	push   %edx
80104d7a:	e8 a3 0c 00 00       	call   80105a22 <swtch>
80104d7f:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80104d82:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104d88:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104d8b:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104d91:	90                   	nop
80104d92:	c9                   	leave  
80104d93:	c3                   	ret    

80104d94 <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104d94:	55                   	push   %ebp
80104d95:	89 e5                	mov    %esp,%ebp
80104d97:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104d9a:	83 ec 0c             	sub    $0xc,%esp
80104d9d:	68 a0 3a 11 80       	push   $0x80113aa0
80104da2:	e8 a4 07 00 00       	call   8010554b <acquire>
80104da7:	83 c4 10             	add    $0x10,%esp
  proc->state = RUNNABLE;
80104daa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104db0:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  proc->retime = ticks;
80104db7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104dbd:	8b 15 20 68 11 80    	mov    0x80116820,%edx
80104dc3:	89 90 8c 00 00 00    	mov    %edx,0x8c(%eax)
  sched();
80104dc9:	e8 0a ff ff ff       	call   80104cd8 <sched>
  release(&ptable.lock);
80104dce:	83 ec 0c             	sub    $0xc,%esp
80104dd1:	68 a0 3a 11 80       	push   $0x80113aa0
80104dd6:	e8 d7 07 00 00       	call   801055b2 <release>
80104ddb:	83 c4 10             	add    $0x10,%esp
}
80104dde:	90                   	nop
80104ddf:	c9                   	leave  
80104de0:	c3                   	ret    

80104de1 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104de1:	55                   	push   %ebp
80104de2:	89 e5                	mov    %esp,%ebp
80104de4:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104de7:	83 ec 0c             	sub    $0xc,%esp
80104dea:	68 a0 3a 11 80       	push   $0x80113aa0
80104def:	e8 be 07 00 00       	call   801055b2 <release>
80104df4:	83 c4 10             	add    $0x10,%esp

  if (first) {
80104df7:	a1 08 c0 10 80       	mov    0x8010c008,%eax
80104dfc:	85 c0                	test   %eax,%eax
80104dfe:	74 24                	je     80104e24 <forkret+0x43>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
80104e00:	c7 05 08 c0 10 80 00 	movl   $0x0,0x8010c008
80104e07:	00 00 00 
    iinit(ROOTDEV);
80104e0a:	83 ec 0c             	sub    $0xc,%esp
80104e0d:	6a 01                	push   $0x1
80104e0f:	e8 2a c8 ff ff       	call   8010163e <iinit>
80104e14:	83 c4 10             	add    $0x10,%esp
    initlog(ROOTDEV);
80104e17:	83 ec 0c             	sub    $0xc,%esp
80104e1a:	6a 01                	push   $0x1
80104e1c:	e8 0e e5 ff ff       	call   8010332f <initlog>
80104e21:	83 c4 10             	add    $0x10,%esp
  }
  
  // Return to "caller", actually trapret (see allocproc).
}
80104e24:	90                   	nop
80104e25:	c9                   	leave  
80104e26:	c3                   	ret    

80104e27 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104e27:	55                   	push   %ebp
80104e28:	89 e5                	mov    %esp,%ebp
80104e2a:	83 ec 08             	sub    $0x8,%esp
  if(proc == 0)
80104e2d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e33:	85 c0                	test   %eax,%eax
80104e35:	75 0d                	jne    80104e44 <sleep+0x1d>
    panic("sleep");
80104e37:	83 ec 0c             	sub    $0xc,%esp
80104e3a:	68 ed 8e 10 80       	push   $0x80108eed
80104e3f:	e8 22 b7 ff ff       	call   80100566 <panic>

  if(lk == 0)
80104e44:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104e48:	75 0d                	jne    80104e57 <sleep+0x30>
    panic("sleep without lk");
80104e4a:	83 ec 0c             	sub    $0xc,%esp
80104e4d:	68 f3 8e 10 80       	push   $0x80108ef3
80104e52:	e8 0f b7 ff ff       	call   80100566 <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104e57:	81 7d 0c a0 3a 11 80 	cmpl   $0x80113aa0,0xc(%ebp)
80104e5e:	74 1e                	je     80104e7e <sleep+0x57>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104e60:	83 ec 0c             	sub    $0xc,%esp
80104e63:	68 a0 3a 11 80       	push   $0x80113aa0
80104e68:	e8 de 06 00 00       	call   8010554b <acquire>
80104e6d:	83 c4 10             	add    $0x10,%esp
    release(lk);
80104e70:	83 ec 0c             	sub    $0xc,%esp
80104e73:	ff 75 0c             	pushl  0xc(%ebp)
80104e76:	e8 37 07 00 00       	call   801055b2 <release>
80104e7b:	83 c4 10             	add    $0x10,%esp
  }

  // Go to sleep.
  proc->chan = chan;
80104e7e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e84:	8b 55 08             	mov    0x8(%ebp),%edx
80104e87:	89 50 20             	mov    %edx,0x20(%eax)
  proc->state = SLEEPING;
80104e8a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e90:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80104e97:	e8 3c fe ff ff       	call   80104cd8 <sched>

  // Tidy up.
  proc->chan = 0;
80104e9c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ea2:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
80104ea9:	81 7d 0c a0 3a 11 80 	cmpl   $0x80113aa0,0xc(%ebp)
80104eb0:	74 1e                	je     80104ed0 <sleep+0xa9>
    release(&ptable.lock);
80104eb2:	83 ec 0c             	sub    $0xc,%esp
80104eb5:	68 a0 3a 11 80       	push   $0x80113aa0
80104eba:	e8 f3 06 00 00       	call   801055b2 <release>
80104ebf:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
80104ec2:	83 ec 0c             	sub    $0xc,%esp
80104ec5:	ff 75 0c             	pushl  0xc(%ebp)
80104ec8:	e8 7e 06 00 00       	call   8010554b <acquire>
80104ecd:	83 c4 10             	add    $0x10,%esp
  }
}
80104ed0:	90                   	nop
80104ed1:	c9                   	leave  
80104ed2:	c3                   	ret    

80104ed3 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104ed3:	55                   	push   %ebp
80104ed4:	89 e5                	mov    %esp,%ebp
80104ed6:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104ed9:	c7 45 fc d4 3a 11 80 	movl   $0x80113ad4,-0x4(%ebp)
80104ee0:	eb 27                	jmp    80104f09 <wakeup1+0x36>
    if(p->state == SLEEPING && p->chan == chan)
80104ee2:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104ee5:	8b 40 0c             	mov    0xc(%eax),%eax
80104ee8:	83 f8 02             	cmp    $0x2,%eax
80104eeb:	75 15                	jne    80104f02 <wakeup1+0x2f>
80104eed:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104ef0:	8b 40 20             	mov    0x20(%eax),%eax
80104ef3:	3b 45 08             	cmp    0x8(%ebp),%eax
80104ef6:	75 0a                	jne    80104f02 <wakeup1+0x2f>
      p->state = RUNNABLE;
80104ef8:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104efb:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104f02:	81 45 fc 94 00 00 00 	addl   $0x94,-0x4(%ebp)
80104f09:	81 7d fc d4 5f 11 80 	cmpl   $0x80115fd4,-0x4(%ebp)
80104f10:	72 d0                	jb     80104ee2 <wakeup1+0xf>
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
80104f12:	90                   	nop
80104f13:	c9                   	leave  
80104f14:	c3                   	ret    

80104f15 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104f15:	55                   	push   %ebp
80104f16:	89 e5                	mov    %esp,%ebp
80104f18:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
80104f1b:	83 ec 0c             	sub    $0xc,%esp
80104f1e:	68 a0 3a 11 80       	push   $0x80113aa0
80104f23:	e8 23 06 00 00       	call   8010554b <acquire>
80104f28:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
80104f2b:	83 ec 0c             	sub    $0xc,%esp
80104f2e:	ff 75 08             	pushl  0x8(%ebp)
80104f31:	e8 9d ff ff ff       	call   80104ed3 <wakeup1>
80104f36:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
80104f39:	83 ec 0c             	sub    $0xc,%esp
80104f3c:	68 a0 3a 11 80       	push   $0x80113aa0
80104f41:	e8 6c 06 00 00       	call   801055b2 <release>
80104f46:	83 c4 10             	add    $0x10,%esp
}
80104f49:	90                   	nop
80104f4a:	c9                   	leave  
80104f4b:	c3                   	ret    

80104f4c <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104f4c:	55                   	push   %ebp
80104f4d:	89 e5                	mov    %esp,%ebp
80104f4f:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104f52:	83 ec 0c             	sub    $0xc,%esp
80104f55:	68 a0 3a 11 80       	push   $0x80113aa0
80104f5a:	e8 ec 05 00 00       	call   8010554b <acquire>
80104f5f:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104f62:	c7 45 f4 d4 3a 11 80 	movl   $0x80113ad4,-0xc(%ebp)
80104f69:	eb 48                	jmp    80104fb3 <kill+0x67>
    if(p->pid == pid){
80104f6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f6e:	8b 40 10             	mov    0x10(%eax),%eax
80104f71:	3b 45 08             	cmp    0x8(%ebp),%eax
80104f74:	75 36                	jne    80104fac <kill+0x60>
      p->killed = 1;
80104f76:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f79:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104f80:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f83:	8b 40 0c             	mov    0xc(%eax),%eax
80104f86:	83 f8 02             	cmp    $0x2,%eax
80104f89:	75 0a                	jne    80104f95 <kill+0x49>
        p->state = RUNNABLE;
80104f8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f8e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104f95:	83 ec 0c             	sub    $0xc,%esp
80104f98:	68 a0 3a 11 80       	push   $0x80113aa0
80104f9d:	e8 10 06 00 00       	call   801055b2 <release>
80104fa2:	83 c4 10             	add    $0x10,%esp
      return 0;
80104fa5:	b8 00 00 00 00       	mov    $0x0,%eax
80104faa:	eb 25                	jmp    80104fd1 <kill+0x85>
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104fac:	81 45 f4 94 00 00 00 	addl   $0x94,-0xc(%ebp)
80104fb3:	81 7d f4 d4 5f 11 80 	cmpl   $0x80115fd4,-0xc(%ebp)
80104fba:	72 af                	jb     80104f6b <kill+0x1f>
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104fbc:	83 ec 0c             	sub    $0xc,%esp
80104fbf:	68 a0 3a 11 80       	push   $0x80113aa0
80104fc4:	e8 e9 05 00 00       	call   801055b2 <release>
80104fc9:	83 c4 10             	add    $0x10,%esp
  return -1;
80104fcc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fd1:	c9                   	leave  
80104fd2:	c3                   	ret    

80104fd3 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104fd3:	55                   	push   %ebp
80104fd4:	89 e5                	mov    %esp,%ebp
80104fd6:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104fd9:	c7 45 f0 d4 3a 11 80 	movl   $0x80113ad4,-0x10(%ebp)
80104fe0:	e9 da 00 00 00       	jmp    801050bf <procdump+0xec>
    if(p->state == UNUSED)
80104fe5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104fe8:	8b 40 0c             	mov    0xc(%eax),%eax
80104feb:	85 c0                	test   %eax,%eax
80104fed:	0f 84 c4 00 00 00    	je     801050b7 <procdump+0xe4>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104ff3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ff6:	8b 40 0c             	mov    0xc(%eax),%eax
80104ff9:	83 f8 05             	cmp    $0x5,%eax
80104ffc:	77 23                	ja     80105021 <procdump+0x4e>
80104ffe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105001:	8b 40 0c             	mov    0xc(%eax),%eax
80105004:	8b 04 85 0c c0 10 80 	mov    -0x7fef3ff4(,%eax,4),%eax
8010500b:	85 c0                	test   %eax,%eax
8010500d:	74 12                	je     80105021 <procdump+0x4e>
      state = states[p->state];
8010500f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105012:	8b 40 0c             	mov    0xc(%eax),%eax
80105015:	8b 04 85 0c c0 10 80 	mov    -0x7fef3ff4(,%eax,4),%eax
8010501c:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010501f:	eb 07                	jmp    80105028 <procdump+0x55>
    else
      state = "???";
80105021:	c7 45 ec 04 8f 10 80 	movl   $0x80108f04,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80105028:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010502b:	8d 50 6c             	lea    0x6c(%eax),%edx
8010502e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105031:	8b 40 10             	mov    0x10(%eax),%eax
80105034:	52                   	push   %edx
80105035:	ff 75 ec             	pushl  -0x14(%ebp)
80105038:	50                   	push   %eax
80105039:	68 08 8f 10 80       	push   $0x80108f08
8010503e:	e8 83 b3 ff ff       	call   801003c6 <cprintf>
80105043:	83 c4 10             	add    $0x10,%esp
    if(p->state == SLEEPING){
80105046:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105049:	8b 40 0c             	mov    0xc(%eax),%eax
8010504c:	83 f8 02             	cmp    $0x2,%eax
8010504f:	75 54                	jne    801050a5 <procdump+0xd2>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80105051:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105054:	8b 40 1c             	mov    0x1c(%eax),%eax
80105057:	8b 40 0c             	mov    0xc(%eax),%eax
8010505a:	83 c0 08             	add    $0x8,%eax
8010505d:	89 c2                	mov    %eax,%edx
8010505f:	83 ec 08             	sub    $0x8,%esp
80105062:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105065:	50                   	push   %eax
80105066:	52                   	push   %edx
80105067:	e8 98 05 00 00       	call   80105604 <getcallerpcs>
8010506c:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
8010506f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80105076:	eb 1c                	jmp    80105094 <procdump+0xc1>
        cprintf(" %p", pc[i]);
80105078:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010507b:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
8010507f:	83 ec 08             	sub    $0x8,%esp
80105082:	50                   	push   %eax
80105083:	68 11 8f 10 80       	push   $0x80108f11
80105088:	e8 39 b3 ff ff       	call   801003c6 <cprintf>
8010508d:	83 c4 10             	add    $0x10,%esp
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80105090:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80105094:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80105098:	7f 0b                	jg     801050a5 <procdump+0xd2>
8010509a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010509d:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
801050a1:	85 c0                	test   %eax,%eax
801050a3:	75 d3                	jne    80105078 <procdump+0xa5>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801050a5:	83 ec 0c             	sub    $0xc,%esp
801050a8:	68 15 8f 10 80       	push   $0x80108f15
801050ad:	e8 14 b3 ff ff       	call   801003c6 <cprintf>
801050b2:	83 c4 10             	add    $0x10,%esp
801050b5:	eb 01                	jmp    801050b8 <procdump+0xe5>
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
801050b7:	90                   	nop
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801050b8:	81 45 f0 94 00 00 00 	addl   $0x94,-0x10(%ebp)
801050bf:	81 7d f0 d4 5f 11 80 	cmpl   $0x80115fd4,-0x10(%ebp)
801050c6:	0f 82 19 ff ff ff    	jb     80104fe5 <procdump+0x12>
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
801050cc:	90                   	nop
801050cd:	c9                   	leave  
801050ce:	c3                   	ret    

801050cf <scheduler_default>:

// SCHEDULER POLICY 3.1
void scheduler_default(void)
{
801050cf:	55                   	push   %ebp
801050d0:	89 e5                	mov    %esp,%ebp
801050d2:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  for (; ;) {
    // Enable interrupts on this processor.
    sti();
801050d5:	e8 74 f3 ff ff       	call   8010444e <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
801050da:	83 ec 0c             	sub    $0xc,%esp
801050dd:	68 a0 3a 11 80       	push   $0x80113aa0
801050e2:	e8 64 04 00 00       	call   8010554b <acquire>
801050e7:	83 c4 10             	add    $0x10,%esp
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801050ea:	c7 45 f4 d4 3a 11 80 	movl   $0x80113ad4,-0xc(%ebp)
801050f1:	e9 b5 00 00 00       	jmp    801051ab <scheduler_default+0xdc>
      if (p->state != RUNNABLE)
801050f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050f9:	8b 40 0c             	mov    0xc(%eax),%eax
801050fc:	83 f8 03             	cmp    $0x3,%eax
801050ff:	0f 85 9e 00 00 00    	jne    801051a3 <scheduler_default+0xd4>
        continue;

      runtime=ticks;
80105105:	a1 20 68 11 80       	mov    0x80116820,%eax
8010510a:	a3 0c 18 11 80       	mov    %eax,0x8011180c
      findtime=ticks;
8010510f:	a1 20 68 11 80       	mov    0x80116820,%eax
80105114:	a3 10 18 11 80       	mov    %eax,0x80111810
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
80105119:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010511c:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
      while (runtime-findtime <= QUANTA)
80105122:	eb 5b                	jmp    8010517f <scheduler_default+0xb0>
      {
        switchuvm(p);
80105124:	83 ec 0c             	sub    $0xc,%esp
80105127:	ff 75 f4             	pushl  -0xc(%ebp)
8010512a:	e8 b3 32 00 00       	call   801083e2 <switchuvm>
8010512f:	83 c4 10             	add    $0x10,%esp
        p->state = RUNNING;
80105132:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105135:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
	p->rutime = ticks;
8010513c:	a1 20 68 11 80       	mov    0x80116820,%eax
80105141:	89 c2                	mov    %eax,%edx
80105143:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105146:	89 90 90 00 00 00    	mov    %edx,0x90(%eax)
        swtch(&cpu->scheduler, proc->context);
8010514c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105152:	8b 40 1c             	mov    0x1c(%eax),%eax
80105155:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010515c:	83 c2 04             	add    $0x4,%edx
8010515f:	83 ec 08             	sub    $0x8,%esp
80105162:	50                   	push   %eax
80105163:	52                   	push   %edx
80105164:	e8 b9 08 00 00       	call   80105a22 <swtch>
80105169:	83 c4 10             	add    $0x10,%esp
        switchkvm();
8010516c:	e8 54 32 00 00       	call   801083c5 <switchkvm>
        if (proc->state != RUNNABLE)
80105171:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105177:	8b 40 0c             	mov    0xc(%eax),%eax
8010517a:	83 f8 03             	cmp    $0x3,%eax
8010517d:	75 16                	jne    80105195 <scheduler_default+0xc6>
      findtime=ticks;
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      while (runtime-findtime <= QUANTA)
8010517f:	8b 15 0c 18 11 80    	mov    0x8011180c,%edx
80105185:	a1 10 18 11 80       	mov    0x80111810,%eax
8010518a:	29 c2                	sub    %eax,%edx
8010518c:	89 d0                	mov    %edx,%eax
8010518e:	83 f8 05             	cmp    $0x5,%eax
80105191:	7e 91                	jle    80105124 <scheduler_default+0x55>
80105193:	eb 01                	jmp    80105196 <scheduler_default+0xc7>
        p->state = RUNNING;
	p->rutime = ticks;
        swtch(&cpu->scheduler, proc->context);
        switchkvm();
        if (proc->state != RUNNABLE)
          break;
80105195:	90                   	nop
      }

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80105196:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
8010519d:	00 00 00 00 
801051a1:	eb 01                	jmp    801051a4 <scheduler_default+0xd5>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
      if (p->state != RUNNABLE)
        continue;
801051a3:	90                   	nop
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801051a4:	81 45 f4 94 00 00 00 	addl   $0x94,-0xc(%ebp)
801051ab:	81 7d f4 d4 5f 11 80 	cmpl   $0x80115fd4,-0xc(%ebp)
801051b2:	0f 82 3e ff ff ff    	jb     801050f6 <scheduler_default+0x27>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
801051b8:	83 ec 0c             	sub    $0xc,%esp
801051bb:	68 a0 3a 11 80       	push   $0x80113aa0
801051c0:	e8 ed 03 00 00       	call   801055b2 <release>
801051c5:	83 c4 10             	add    $0x10,%esp
  }
801051c8:	e9 08 ff ff ff       	jmp    801050d5 <scheduler_default+0x6>

801051cd <scheduler_frr>:
}

// SCHEDULER POLICY 3.2
void scheduler_frr(void)
{
801051cd:	55                   	push   %ebp
801051ce:	89 e5                	mov    %esp,%ebp
801051d0:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  for (; ;)
  {
    // Enable interrupts on this processor.
    sti();
801051d3:	e8 76 f2 ff ff       	call   8010444e <sti>
    acquire(&ptable.lock);
801051d8:	83 ec 0c             	sub    $0xc,%esp
801051db:	68 a0 3a 11 80       	push   $0x80113aa0
801051e0:	e8 66 03 00 00       	call   8010554b <acquire>
801051e5:	83 c4 10             	add    $0x10,%esp
    if (get_size(&proc_queue)==0)
801051e8:	83 ec 0c             	sub    $0xc,%esp
801051eb:	68 60 39 11 80       	push   $0x80113960
801051f0:	e8 ee 01 00 00       	call   801053e3 <get_size>
801051f5:	83 c4 10             	add    $0x10,%esp
801051f8:	85 c0                	test   %eax,%eax
801051fa:	75 15                	jne    80105211 <scheduler_frr+0x44>
    {
      release(&ptable.lock);
801051fc:	83 ec 0c             	sub    $0xc,%esp
801051ff:	68 a0 3a 11 80       	push   $0x80113aa0
80105204:	e8 a9 03 00 00       	call   801055b2 <release>
80105209:	83 c4 10             	add    $0x10,%esp
      continue;
8010520c:	e9 cd 00 00 00       	jmp    801052de <scheduler_frr+0x111>
    }
    p = deq(&proc_queue);
80105211:	83 ec 0c             	sub    $0xc,%esp
80105214:	68 60 39 11 80       	push   $0x80113960
80105219:	e8 31 02 00 00       	call   8010544f <deq>
8010521e:	83 c4 10             	add    $0x10,%esp
80105221:	89 45 f4             	mov    %eax,-0xc(%ebp)
    //timers for quanta
    runtime = ticks;
80105224:	a1 20 68 11 80       	mov    0x80116820,%eax
80105229:	a3 0c 18 11 80       	mov    %eax,0x8011180c
    findtime = runtime;
8010522e:	a1 0c 18 11 80       	mov    0x8011180c,%eax
80105233:	a3 10 18 11 80       	mov    %eax,0x80111810

    proc = p;
80105238:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010523b:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
    while (runtime - findtime <= QUANTA)
80105241:	eb 4b                	jmp    8010528e <scheduler_frr+0xc1>
    {
      switchuvm(p);
80105243:	83 ec 0c             	sub    $0xc,%esp
80105246:	ff 75 f4             	pushl  -0xc(%ebp)
80105249:	e8 94 31 00 00       	call   801083e2 <switchuvm>
8010524e:	83 c4 10             	add    $0x10,%esp
      p->state = RUNNING;
80105251:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105254:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&cpu->scheduler, proc->context);
8010525b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105261:	8b 40 1c             	mov    0x1c(%eax),%eax
80105264:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010526b:	83 c2 04             	add    $0x4,%edx
8010526e:	83 ec 08             	sub    $0x8,%esp
80105271:	50                   	push   %eax
80105272:	52                   	push   %edx
80105273:	e8 aa 07 00 00       	call   80105a22 <swtch>
80105278:	83 c4 10             	add    $0x10,%esp
      switchkvm();
8010527b:	e8 45 31 00 00       	call   801083c5 <switchkvm>
      if (proc->state != RUNNABLE)
80105280:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105286:	8b 40 0c             	mov    0xc(%eax),%eax
80105289:	83 f8 03             	cmp    $0x3,%eax
8010528c:	75 16                	jne    801052a4 <scheduler_frr+0xd7>
    //timers for quanta
    runtime = ticks;
    findtime = runtime;

    proc = p;
    while (runtime - findtime <= QUANTA)
8010528e:	8b 15 0c 18 11 80    	mov    0x8011180c,%edx
80105294:	a1 10 18 11 80       	mov    0x80111810,%eax
80105299:	29 c2                	sub    %eax,%edx
8010529b:	89 d0                	mov    %edx,%eax
8010529d:	83 f8 05             	cmp    $0x5,%eax
801052a0:	7e a1                	jle    80105243 <scheduler_frr+0x76>
801052a2:	eb 01                	jmp    801052a5 <scheduler_frr+0xd8>
      switchuvm(p);
      p->state = RUNNING;
      swtch(&cpu->scheduler, proc->context);
      switchkvm();
      if (proc->state != RUNNABLE)
        break;
801052a4:	90                   	nop
    }

    if (p->state==RUNNABLE)
801052a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052a8:	8b 40 0c             	mov    0xc(%eax),%eax
801052ab:	83 f8 03             	cmp    $0x3,%eax
801052ae:	75 13                	jne    801052c3 <scheduler_frr+0xf6>
      enq(&proc_queue,p);
801052b0:	83 ec 08             	sub    $0x8,%esp
801052b3:	ff 75 f4             	pushl  -0xc(%ebp)
801052b6:	68 60 39 11 80       	push   $0x80113960
801052bb:	e8 67 01 00 00       	call   80105427 <enq>
801052c0:	83 c4 10             	add    $0x10,%esp
    // Process is done running for now.
    // It should have changed its p->state before coming back.
    proc = 0;
801052c3:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
801052ca:	00 00 00 00 
    release(&ptable.lock);
801052ce:	83 ec 0c             	sub    $0xc,%esp
801052d1:	68 a0 3a 11 80       	push   $0x80113aa0
801052d6:	e8 d7 02 00 00       	call   801055b2 <release>
801052db:	83 c4 10             	add    $0x10,%esp
  }
801052de:	e9 f0 fe ff ff       	jmp    801051d3 <scheduler_frr+0x6>

801052e3 <scheduler_fcfs>:
}

// SCHEDULER POLICY 3.3
void scheduler_fcfs(void)
{
801052e3:	55                   	push   %ebp
801052e4:	89 e5                	mov    %esp,%ebp
801052e6:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  //init the queue
  for (; ;)
  {
    // Enable interrupts on this processor.
    sti();
801052e9:	e8 60 f1 ff ff       	call   8010444e <sti>
    acquire(&ptable.lock);
801052ee:	83 ec 0c             	sub    $0xc,%esp
801052f1:	68 a0 3a 11 80       	push   $0x80113aa0
801052f6:	e8 50 02 00 00       	call   8010554b <acquire>
801052fb:	83 c4 10             	add    $0x10,%esp
    if (get_size(&proc_queue)==0)
801052fe:	83 ec 0c             	sub    $0xc,%esp
80105301:	68 60 39 11 80       	push   $0x80113960
80105306:	e8 d8 00 00 00       	call   801053e3 <get_size>
8010530b:	83 c4 10             	add    $0x10,%esp
8010530e:	85 c0                	test   %eax,%eax
80105310:	75 15                	jne    80105327 <scheduler_fcfs+0x44>
    {
      release(&ptable.lock);
80105312:	83 ec 0c             	sub    $0xc,%esp
80105315:	68 a0 3a 11 80       	push   $0x80113aa0
8010531a:	e8 93 02 00 00       	call   801055b2 <release>
8010531f:	83 c4 10             	add    $0x10,%esp
      continue;
80105322:	e9 b7 00 00 00       	jmp    801053de <scheduler_fcfs+0xfb>
    }
    p = deq(&proc_queue);
80105327:	83 ec 0c             	sub    $0xc,%esp
8010532a:	68 60 39 11 80       	push   $0x80113960
8010532f:	e8 1b 01 00 00       	call   8010544f <deq>
80105334:	83 c4 10             	add    $0x10,%esp
80105337:	89 45 f4             	mov    %eax,-0xc(%ebp)
    //timers for quanta
    runtime = ticks;
8010533a:	a1 20 68 11 80       	mov    0x80116820,%eax
8010533f:	a3 0c 18 11 80       	mov    %eax,0x8011180c
    findtime = runtime;
80105344:	a1 0c 18 11 80       	mov    0x8011180c,%eax
80105349:	a3 10 18 11 80       	mov    %eax,0x80111810

    proc = p;
8010534e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105351:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
    while (1)
    {
      switchuvm(p);
80105357:	83 ec 0c             	sub    $0xc,%esp
8010535a:	ff 75 f4             	pushl  -0xc(%ebp)
8010535d:	e8 80 30 00 00       	call   801083e2 <switchuvm>
80105362:	83 c4 10             	add    $0x10,%esp
      p->state = RUNNING;
80105365:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105368:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&cpu->scheduler, proc->context);
8010536f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105375:	8b 40 1c             	mov    0x1c(%eax),%eax
80105378:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010537f:	83 c2 04             	add    $0x4,%edx
80105382:	83 ec 08             	sub    $0x8,%esp
80105385:	50                   	push   %eax
80105386:	52                   	push   %edx
80105387:	e8 96 06 00 00       	call   80105a22 <swtch>
8010538c:	83 c4 10             	add    $0x10,%esp
      switchkvm();
8010538f:	e8 31 30 00 00       	call   801083c5 <switchkvm>
      if (proc->state != RUNNABLE)
80105394:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010539a:	8b 40 0c             	mov    0xc(%eax),%eax
8010539d:	83 f8 03             	cmp    $0x3,%eax
801053a0:	75 02                	jne    801053a4 <scheduler_fcfs+0xc1>
        break;
    }
801053a2:	eb b3                	jmp    80105357 <scheduler_fcfs+0x74>
      switchuvm(p);
      p->state = RUNNING;
      swtch(&cpu->scheduler, proc->context);
      switchkvm();
      if (proc->state != RUNNABLE)
        break;
801053a4:	90                   	nop
    }
    if (p->state==RUNNABLE)
801053a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053a8:	8b 40 0c             	mov    0xc(%eax),%eax
801053ab:	83 f8 03             	cmp    $0x3,%eax
801053ae:	75 13                	jne    801053c3 <scheduler_fcfs+0xe0>
      enq(&proc_queue,p);
801053b0:	83 ec 08             	sub    $0x8,%esp
801053b3:	ff 75 f4             	pushl  -0xc(%ebp)
801053b6:	68 60 39 11 80       	push   $0x80113960
801053bb:	e8 67 00 00 00       	call   80105427 <enq>
801053c0:	83 c4 10             	add    $0x10,%esp
    // Process is done running for now.
    // It should have changed its p->state before coming back.
    proc = 0;
801053c3:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
801053ca:	00 00 00 00 
    release(&ptable.lock);
801053ce:	83 ec 0c             	sub    $0xc,%esp
801053d1:	68 a0 3a 11 80       	push   $0x80113aa0
801053d6:	e8 d7 01 00 00       	call   801055b2 <release>
801053db:	83 c4 10             	add    $0x10,%esp
  }
801053de:	e9 06 ff ff ff       	jmp    801052e9 <scheduler_fcfs+0x6>

801053e3 <get_size>:
}

//getter for q->count
int get_size(struct queue *q)
{
801053e3:	55                   	push   %ebp
801053e4:	89 e5                	mov    %esp,%ebp
  return q->count;
801053e6:	8b 45 08             	mov    0x8(%ebp),%eax
801053e9:	8b 80 34 01 00 00    	mov    0x134(%eax),%eax
}
801053ef:	5d                   	pop    %ebp
801053f0:	c3                   	ret    

801053f1 <inc_size>:

//increment count
void inc_size(struct queue *q)
{
801053f1:	55                   	push   %ebp
801053f2:	89 e5                	mov    %esp,%ebp
  q->count += 1;
801053f4:	8b 45 08             	mov    0x8(%ebp),%eax
801053f7:	8b 80 34 01 00 00    	mov    0x134(%eax),%eax
801053fd:	8d 50 01             	lea    0x1(%eax),%edx
80105400:	8b 45 08             	mov    0x8(%ebp),%eax
80105403:	89 90 34 01 00 00    	mov    %edx,0x134(%eax)
}
80105409:	90                   	nop
8010540a:	5d                   	pop    %ebp
8010540b:	c3                   	ret    

8010540c <dec_size>:

//decrease count
void dec_size(struct queue *q)
{
8010540c:	55                   	push   %ebp
8010540d:	89 e5                	mov    %esp,%ebp
  q->count -= 1;
8010540f:	8b 45 08             	mov    0x8(%ebp),%eax
80105412:	8b 80 34 01 00 00    	mov    0x134(%eax),%eax
80105418:	8d 50 ff             	lea    -0x1(%eax),%edx
8010541b:	8b 45 08             	mov    0x8(%ebp),%eax
8010541e:	89 90 34 01 00 00    	mov    %edx,0x134(%eax)
}
80105424:	90                   	nop
80105425:	5d                   	pop    %ebp
80105426:	c3                   	ret    

80105427 <enq>:

/* Enqueing into the queue */
void enq(struct queue *q, struct proc *p)
{
80105427:	55                   	push   %ebp
80105428:	89 e5                	mov    %esp,%ebp
  q->queue[q->count++] = p;
8010542a:	8b 45 08             	mov    0x8(%ebp),%eax
8010542d:	8b 80 34 01 00 00    	mov    0x134(%eax),%eax
80105433:	8d 48 01             	lea    0x1(%eax),%ecx
80105436:	8b 55 08             	mov    0x8(%ebp),%edx
80105439:	89 8a 34 01 00 00    	mov    %ecx,0x134(%edx)
8010543f:	8b 55 08             	mov    0x8(%ebp),%edx
80105442:	8d 48 0c             	lea    0xc(%eax),%ecx
80105445:	8b 45 0c             	mov    0xc(%ebp),%eax
80105448:	89 44 8a 04          	mov    %eax,0x4(%edx,%ecx,4)
}
8010544c:	90                   	nop
8010544d:	5d                   	pop    %ebp
8010544e:	c3                   	ret    

8010544f <deq>:

/* Dequeing the queue */
struct proc *deq(struct queue *q)
{
8010544f:	55                   	push   %ebp
80105450:	89 e5                	mov    %esp,%ebp
80105452:	83 ec 10             	sub    $0x10,%esp
  int i;
  struct proc *ans;
  if (q->count == 0)
80105455:	8b 45 08             	mov    0x8(%ebp),%eax
80105458:	8b 80 34 01 00 00    	mov    0x134(%eax),%eax
8010545e:	85 c0                	test   %eax,%eax
80105460:	75 07                	jne    80105469 <deq+0x1a>
    return 0;
80105462:	b8 00 00 00 00       	mov    $0x0,%eax
80105467:	eb 5c                	jmp    801054c5 <deq+0x76>
  ans = q->queue[0];
80105469:	8b 45 08             	mov    0x8(%ebp),%eax
8010546c:	8b 40 34             	mov    0x34(%eax),%eax
8010546f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for (i = 0; i < q->count - 1 ; i++)
80105472:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105479:	eb 21                	jmp    8010549c <deq+0x4d>
      q->queue[i] = q->queue[i+1];
8010547b:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010547e:	8d 50 01             	lea    0x1(%eax),%edx
80105481:	8b 45 08             	mov    0x8(%ebp),%eax
80105484:	83 c2 0c             	add    $0xc,%edx
80105487:	8b 54 90 04          	mov    0x4(%eax,%edx,4),%edx
8010548b:	8b 45 08             	mov    0x8(%ebp),%eax
8010548e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
80105491:	83 c1 0c             	add    $0xc,%ecx
80105494:	89 54 88 04          	mov    %edx,0x4(%eax,%ecx,4)
  int i;
  struct proc *ans;
  if (q->count == 0)
    return 0;
  ans = q->queue[0];
  for (i = 0; i < q->count - 1 ; i++)
80105498:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010549c:	8b 45 08             	mov    0x8(%ebp),%eax
8010549f:	8b 80 34 01 00 00    	mov    0x134(%eax),%eax
801054a5:	83 e8 01             	sub    $0x1,%eax
801054a8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
801054ab:	7f ce                	jg     8010547b <deq+0x2c>
      q->queue[i] = q->queue[i+1];
  q->count--;
801054ad:	8b 45 08             	mov    0x8(%ebp),%eax
801054b0:	8b 80 34 01 00 00    	mov    0x134(%eax),%eax
801054b6:	8d 50 ff             	lea    -0x1(%eax),%edx
801054b9:	8b 45 08             	mov    0x8(%ebp),%eax
801054bc:	89 90 34 01 00 00    	mov    %edx,0x134(%eax)
  return ans;
801054c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
801054c5:	c9                   	leave  
801054c6:	c3                   	ret    

801054c7 <queue_init>:

void queue_init(struct queue *q)
{
801054c7:	55                   	push   %ebp
801054c8:	89 e5                	mov    %esp,%ebp
801054ca:	83 ec 08             	sub    $0x8,%esp
  q->count=0;
801054cd:	8b 45 08             	mov    0x8(%ebp),%eax
801054d0:	c7 80 34 01 00 00 00 	movl   $0x0,0x134(%eax)
801054d7:	00 00 00 
  initlock(&q->queue_lock, "proc_queue");
801054da:	8b 45 08             	mov    0x8(%ebp),%eax
801054dd:	83 ec 08             	sub    $0x8,%esp
801054e0:	68 17 8f 10 80       	push   $0x80108f17
801054e5:	50                   	push   %eax
801054e6:	e8 3e 00 00 00       	call   80105529 <initlock>
801054eb:	83 c4 10             	add    $0x10,%esp
}
801054ee:	90                   	nop
801054ef:	c9                   	leave  
801054f0:	c3                   	ret    

801054f1 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
801054f1:	55                   	push   %ebp
801054f2:	89 e5                	mov    %esp,%ebp
801054f4:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801054f7:	9c                   	pushf  
801054f8:	58                   	pop    %eax
801054f9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
801054fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801054ff:	c9                   	leave  
80105500:	c3                   	ret    

80105501 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80105501:	55                   	push   %ebp
80105502:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80105504:	fa                   	cli    
}
80105505:	90                   	nop
80105506:	5d                   	pop    %ebp
80105507:	c3                   	ret    

80105508 <sti>:

static inline void
sti(void)
{
80105508:	55                   	push   %ebp
80105509:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
8010550b:	fb                   	sti    
}
8010550c:	90                   	nop
8010550d:	5d                   	pop    %ebp
8010550e:	c3                   	ret    

8010550f <xchg>:
  asm volatile("hlt");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
8010550f:	55                   	push   %ebp
80105510:	89 e5                	mov    %esp,%ebp
80105512:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80105515:	8b 55 08             	mov    0x8(%ebp),%edx
80105518:	8b 45 0c             	mov    0xc(%ebp),%eax
8010551b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010551e:	f0 87 02             	lock xchg %eax,(%edx)
80105521:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80105524:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105527:	c9                   	leave  
80105528:	c3                   	ret    

80105529 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105529:	55                   	push   %ebp
8010552a:	89 e5                	mov    %esp,%ebp
  lk->name = name;
8010552c:	8b 45 08             	mov    0x8(%ebp),%eax
8010552f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105532:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80105535:	8b 45 08             	mov    0x8(%ebp),%eax
80105538:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
8010553e:	8b 45 08             	mov    0x8(%ebp),%eax
80105541:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105548:	90                   	nop
80105549:	5d                   	pop    %ebp
8010554a:	c3                   	ret    

8010554b <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
8010554b:	55                   	push   %ebp
8010554c:	89 e5                	mov    %esp,%ebp
8010554e:	83 ec 08             	sub    $0x8,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105551:	e8 52 01 00 00       	call   801056a8 <pushcli>
  if(holding(lk))
80105556:	8b 45 08             	mov    0x8(%ebp),%eax
80105559:	83 ec 0c             	sub    $0xc,%esp
8010555c:	50                   	push   %eax
8010555d:	e8 1c 01 00 00       	call   8010567e <holding>
80105562:	83 c4 10             	add    $0x10,%esp
80105565:	85 c0                	test   %eax,%eax
80105567:	74 0d                	je     80105576 <acquire+0x2b>
    panic("acquire");
80105569:	83 ec 0c             	sub    $0xc,%esp
8010556c:	68 4c 8f 10 80       	push   $0x80108f4c
80105571:	e8 f0 af ff ff       	call   80100566 <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80105576:	90                   	nop
80105577:	8b 45 08             	mov    0x8(%ebp),%eax
8010557a:	83 ec 08             	sub    $0x8,%esp
8010557d:	6a 01                	push   $0x1
8010557f:	50                   	push   %eax
80105580:	e8 8a ff ff ff       	call   8010550f <xchg>
80105585:	83 c4 10             	add    $0x10,%esp
80105588:	85 c0                	test   %eax,%eax
8010558a:	75 eb                	jne    80105577 <acquire+0x2c>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
8010558c:	8b 45 08             	mov    0x8(%ebp),%eax
8010558f:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80105596:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80105599:	8b 45 08             	mov    0x8(%ebp),%eax
8010559c:	83 c0 0c             	add    $0xc,%eax
8010559f:	83 ec 08             	sub    $0x8,%esp
801055a2:	50                   	push   %eax
801055a3:	8d 45 08             	lea    0x8(%ebp),%eax
801055a6:	50                   	push   %eax
801055a7:	e8 58 00 00 00       	call   80105604 <getcallerpcs>
801055ac:	83 c4 10             	add    $0x10,%esp
}
801055af:	90                   	nop
801055b0:	c9                   	leave  
801055b1:	c3                   	ret    

801055b2 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
801055b2:	55                   	push   %ebp
801055b3:	89 e5                	mov    %esp,%ebp
801055b5:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
801055b8:	83 ec 0c             	sub    $0xc,%esp
801055bb:	ff 75 08             	pushl  0x8(%ebp)
801055be:	e8 bb 00 00 00       	call   8010567e <holding>
801055c3:	83 c4 10             	add    $0x10,%esp
801055c6:	85 c0                	test   %eax,%eax
801055c8:	75 0d                	jne    801055d7 <release+0x25>
    panic("release");
801055ca:	83 ec 0c             	sub    $0xc,%esp
801055cd:	68 54 8f 10 80       	push   $0x80108f54
801055d2:	e8 8f af ff ff       	call   80100566 <panic>

  lk->pcs[0] = 0;
801055d7:	8b 45 08             	mov    0x8(%ebp),%eax
801055da:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
801055e1:	8b 45 08             	mov    0x8(%ebp),%eax
801055e4:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
801055eb:	8b 45 08             	mov    0x8(%ebp),%eax
801055ee:	83 ec 08             	sub    $0x8,%esp
801055f1:	6a 00                	push   $0x0
801055f3:	50                   	push   %eax
801055f4:	e8 16 ff ff ff       	call   8010550f <xchg>
801055f9:	83 c4 10             	add    $0x10,%esp

  popcli();
801055fc:	e8 ec 00 00 00       	call   801056ed <popcli>
}
80105601:	90                   	nop
80105602:	c9                   	leave  
80105603:	c3                   	ret    

80105604 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105604:	55                   	push   %ebp
80105605:	89 e5                	mov    %esp,%ebp
80105607:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
8010560a:	8b 45 08             	mov    0x8(%ebp),%eax
8010560d:	83 e8 08             	sub    $0x8,%eax
80105610:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80105613:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
8010561a:	eb 38                	jmp    80105654 <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010561c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
80105620:	74 53                	je     80105675 <getcallerpcs+0x71>
80105622:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
80105629:	76 4a                	jbe    80105675 <getcallerpcs+0x71>
8010562b:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
8010562f:	74 44                	je     80105675 <getcallerpcs+0x71>
      break;
    pcs[i] = ebp[1];     // saved %eip
80105631:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105634:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010563b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010563e:	01 c2                	add    %eax,%edx
80105640:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105643:	8b 40 04             	mov    0x4(%eax),%eax
80105646:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
80105648:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010564b:	8b 00                	mov    (%eax),%eax
8010564d:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105650:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105654:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105658:	7e c2                	jle    8010561c <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010565a:	eb 19                	jmp    80105675 <getcallerpcs+0x71>
    pcs[i] = 0;
8010565c:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010565f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80105666:	8b 45 0c             	mov    0xc(%ebp),%eax
80105669:	01 d0                	add    %edx,%eax
8010566b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105671:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105675:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105679:	7e e1                	jle    8010565c <getcallerpcs+0x58>
    pcs[i] = 0;
}
8010567b:	90                   	nop
8010567c:	c9                   	leave  
8010567d:	c3                   	ret    

8010567e <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
8010567e:	55                   	push   %ebp
8010567f:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80105681:	8b 45 08             	mov    0x8(%ebp),%eax
80105684:	8b 00                	mov    (%eax),%eax
80105686:	85 c0                	test   %eax,%eax
80105688:	74 17                	je     801056a1 <holding+0x23>
8010568a:	8b 45 08             	mov    0x8(%ebp),%eax
8010568d:	8b 50 08             	mov    0x8(%eax),%edx
80105690:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105696:	39 c2                	cmp    %eax,%edx
80105698:	75 07                	jne    801056a1 <holding+0x23>
8010569a:	b8 01 00 00 00       	mov    $0x1,%eax
8010569f:	eb 05                	jmp    801056a6 <holding+0x28>
801056a1:	b8 00 00 00 00       	mov    $0x0,%eax
}
801056a6:	5d                   	pop    %ebp
801056a7:	c3                   	ret    

801056a8 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801056a8:	55                   	push   %ebp
801056a9:	89 e5                	mov    %esp,%ebp
801056ab:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
801056ae:	e8 3e fe ff ff       	call   801054f1 <readeflags>
801056b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
801056b6:	e8 46 fe ff ff       	call   80105501 <cli>
  if(cpu->ncli++ == 0)
801056bb:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801056c2:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
801056c8:	8d 48 01             	lea    0x1(%eax),%ecx
801056cb:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
801056d1:	85 c0                	test   %eax,%eax
801056d3:	75 15                	jne    801056ea <pushcli+0x42>
    cpu->intena = eflags & FL_IF;
801056d5:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801056db:	8b 55 fc             	mov    -0x4(%ebp),%edx
801056de:	81 e2 00 02 00 00    	and    $0x200,%edx
801056e4:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
801056ea:	90                   	nop
801056eb:	c9                   	leave  
801056ec:	c3                   	ret    

801056ed <popcli>:

void
popcli(void)
{
801056ed:	55                   	push   %ebp
801056ee:	89 e5                	mov    %esp,%ebp
801056f0:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
801056f3:	e8 f9 fd ff ff       	call   801054f1 <readeflags>
801056f8:	25 00 02 00 00       	and    $0x200,%eax
801056fd:	85 c0                	test   %eax,%eax
801056ff:	74 0d                	je     8010570e <popcli+0x21>
    panic("popcli - interruptible");
80105701:	83 ec 0c             	sub    $0xc,%esp
80105704:	68 5c 8f 10 80       	push   $0x80108f5c
80105709:	e8 58 ae ff ff       	call   80100566 <panic>
  if(--cpu->ncli < 0)
8010570e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105714:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
8010571a:	83 ea 01             	sub    $0x1,%edx
8010571d:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80105723:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80105729:	85 c0                	test   %eax,%eax
8010572b:	79 0d                	jns    8010573a <popcli+0x4d>
    panic("popcli");
8010572d:	83 ec 0c             	sub    $0xc,%esp
80105730:	68 73 8f 10 80       	push   $0x80108f73
80105735:	e8 2c ae ff ff       	call   80100566 <panic>
  if(cpu->ncli == 0 && cpu->intena)
8010573a:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105740:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80105746:	85 c0                	test   %eax,%eax
80105748:	75 15                	jne    8010575f <popcli+0x72>
8010574a:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105750:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80105756:	85 c0                	test   %eax,%eax
80105758:	74 05                	je     8010575f <popcli+0x72>
    sti();
8010575a:	e8 a9 fd ff ff       	call   80105508 <sti>
}
8010575f:	90                   	nop
80105760:	c9                   	leave  
80105761:	c3                   	ret    

80105762 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
80105762:	55                   	push   %ebp
80105763:	89 e5                	mov    %esp,%ebp
80105765:	57                   	push   %edi
80105766:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
80105767:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010576a:	8b 55 10             	mov    0x10(%ebp),%edx
8010576d:	8b 45 0c             	mov    0xc(%ebp),%eax
80105770:	89 cb                	mov    %ecx,%ebx
80105772:	89 df                	mov    %ebx,%edi
80105774:	89 d1                	mov    %edx,%ecx
80105776:	fc                   	cld    
80105777:	f3 aa                	rep stos %al,%es:(%edi)
80105779:	89 ca                	mov    %ecx,%edx
8010577b:	89 fb                	mov    %edi,%ebx
8010577d:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105780:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80105783:	90                   	nop
80105784:	5b                   	pop    %ebx
80105785:	5f                   	pop    %edi
80105786:	5d                   	pop    %ebp
80105787:	c3                   	ret    

80105788 <stosl>:

static inline void
stosl(void *addr, int data, int cnt)
{
80105788:	55                   	push   %ebp
80105789:	89 e5                	mov    %esp,%ebp
8010578b:	57                   	push   %edi
8010578c:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
8010578d:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105790:	8b 55 10             	mov    0x10(%ebp),%edx
80105793:	8b 45 0c             	mov    0xc(%ebp),%eax
80105796:	89 cb                	mov    %ecx,%ebx
80105798:	89 df                	mov    %ebx,%edi
8010579a:	89 d1                	mov    %edx,%ecx
8010579c:	fc                   	cld    
8010579d:	f3 ab                	rep stos %eax,%es:(%edi)
8010579f:	89 ca                	mov    %ecx,%edx
801057a1:	89 fb                	mov    %edi,%ebx
801057a3:	89 5d 08             	mov    %ebx,0x8(%ebp)
801057a6:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
801057a9:	90                   	nop
801057aa:	5b                   	pop    %ebx
801057ab:	5f                   	pop    %edi
801057ac:	5d                   	pop    %ebp
801057ad:	c3                   	ret    

801057ae <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801057ae:	55                   	push   %ebp
801057af:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
801057b1:	8b 45 08             	mov    0x8(%ebp),%eax
801057b4:	83 e0 03             	and    $0x3,%eax
801057b7:	85 c0                	test   %eax,%eax
801057b9:	75 43                	jne    801057fe <memset+0x50>
801057bb:	8b 45 10             	mov    0x10(%ebp),%eax
801057be:	83 e0 03             	and    $0x3,%eax
801057c1:	85 c0                	test   %eax,%eax
801057c3:	75 39                	jne    801057fe <memset+0x50>
    c &= 0xFF;
801057c5:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801057cc:	8b 45 10             	mov    0x10(%ebp),%eax
801057cf:	c1 e8 02             	shr    $0x2,%eax
801057d2:	89 c1                	mov    %eax,%ecx
801057d4:	8b 45 0c             	mov    0xc(%ebp),%eax
801057d7:	c1 e0 18             	shl    $0x18,%eax
801057da:	89 c2                	mov    %eax,%edx
801057dc:	8b 45 0c             	mov    0xc(%ebp),%eax
801057df:	c1 e0 10             	shl    $0x10,%eax
801057e2:	09 c2                	or     %eax,%edx
801057e4:	8b 45 0c             	mov    0xc(%ebp),%eax
801057e7:	c1 e0 08             	shl    $0x8,%eax
801057ea:	09 d0                	or     %edx,%eax
801057ec:	0b 45 0c             	or     0xc(%ebp),%eax
801057ef:	51                   	push   %ecx
801057f0:	50                   	push   %eax
801057f1:	ff 75 08             	pushl  0x8(%ebp)
801057f4:	e8 8f ff ff ff       	call   80105788 <stosl>
801057f9:	83 c4 0c             	add    $0xc,%esp
801057fc:	eb 12                	jmp    80105810 <memset+0x62>
  } else
    stosb(dst, c, n);
801057fe:	8b 45 10             	mov    0x10(%ebp),%eax
80105801:	50                   	push   %eax
80105802:	ff 75 0c             	pushl  0xc(%ebp)
80105805:	ff 75 08             	pushl  0x8(%ebp)
80105808:	e8 55 ff ff ff       	call   80105762 <stosb>
8010580d:	83 c4 0c             	add    $0xc,%esp
  return dst;
80105810:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105813:	c9                   	leave  
80105814:	c3                   	ret    

80105815 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105815:	55                   	push   %ebp
80105816:	89 e5                	mov    %esp,%ebp
80105818:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
8010581b:	8b 45 08             	mov    0x8(%ebp),%eax
8010581e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
80105821:	8b 45 0c             	mov    0xc(%ebp),%eax
80105824:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
80105827:	eb 30                	jmp    80105859 <memcmp+0x44>
    if(*s1 != *s2)
80105829:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010582c:	0f b6 10             	movzbl (%eax),%edx
8010582f:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105832:	0f b6 00             	movzbl (%eax),%eax
80105835:	38 c2                	cmp    %al,%dl
80105837:	74 18                	je     80105851 <memcmp+0x3c>
      return *s1 - *s2;
80105839:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010583c:	0f b6 00             	movzbl (%eax),%eax
8010583f:	0f b6 d0             	movzbl %al,%edx
80105842:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105845:	0f b6 00             	movzbl (%eax),%eax
80105848:	0f b6 c0             	movzbl %al,%eax
8010584b:	29 c2                	sub    %eax,%edx
8010584d:	89 d0                	mov    %edx,%eax
8010584f:	eb 1a                	jmp    8010586b <memcmp+0x56>
    s1++, s2++;
80105851:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105855:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105859:	8b 45 10             	mov    0x10(%ebp),%eax
8010585c:	8d 50 ff             	lea    -0x1(%eax),%edx
8010585f:	89 55 10             	mov    %edx,0x10(%ebp)
80105862:	85 c0                	test   %eax,%eax
80105864:	75 c3                	jne    80105829 <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80105866:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010586b:	c9                   	leave  
8010586c:	c3                   	ret    

8010586d <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
8010586d:	55                   	push   %ebp
8010586e:	89 e5                	mov    %esp,%ebp
80105870:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
80105873:	8b 45 0c             	mov    0xc(%ebp),%eax
80105876:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
80105879:	8b 45 08             	mov    0x8(%ebp),%eax
8010587c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
8010587f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105882:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105885:	73 54                	jae    801058db <memmove+0x6e>
80105887:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010588a:	8b 45 10             	mov    0x10(%ebp),%eax
8010588d:	01 d0                	add    %edx,%eax
8010588f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105892:	76 47                	jbe    801058db <memmove+0x6e>
    s += n;
80105894:	8b 45 10             	mov    0x10(%ebp),%eax
80105897:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
8010589a:	8b 45 10             	mov    0x10(%ebp),%eax
8010589d:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
801058a0:	eb 13                	jmp    801058b5 <memmove+0x48>
      *--d = *--s;
801058a2:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
801058a6:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
801058aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
801058ad:	0f b6 10             	movzbl (%eax),%edx
801058b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
801058b3:	88 10                	mov    %dl,(%eax)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801058b5:	8b 45 10             	mov    0x10(%ebp),%eax
801058b8:	8d 50 ff             	lea    -0x1(%eax),%edx
801058bb:	89 55 10             	mov    %edx,0x10(%ebp)
801058be:	85 c0                	test   %eax,%eax
801058c0:	75 e0                	jne    801058a2 <memmove+0x35>
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801058c2:	eb 24                	jmp    801058e8 <memmove+0x7b>
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
      *d++ = *s++;
801058c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
801058c7:	8d 50 01             	lea    0x1(%eax),%edx
801058ca:	89 55 f8             	mov    %edx,-0x8(%ebp)
801058cd:	8b 55 fc             	mov    -0x4(%ebp),%edx
801058d0:	8d 4a 01             	lea    0x1(%edx),%ecx
801058d3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
801058d6:	0f b6 12             	movzbl (%edx),%edx
801058d9:	88 10                	mov    %dl,(%eax)
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801058db:	8b 45 10             	mov    0x10(%ebp),%eax
801058de:	8d 50 ff             	lea    -0x1(%eax),%edx
801058e1:	89 55 10             	mov    %edx,0x10(%ebp)
801058e4:	85 c0                	test   %eax,%eax
801058e6:	75 dc                	jne    801058c4 <memmove+0x57>
      *d++ = *s++;

  return dst;
801058e8:	8b 45 08             	mov    0x8(%ebp),%eax
}
801058eb:	c9                   	leave  
801058ec:	c3                   	ret    

801058ed <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801058ed:	55                   	push   %ebp
801058ee:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
801058f0:	ff 75 10             	pushl  0x10(%ebp)
801058f3:	ff 75 0c             	pushl  0xc(%ebp)
801058f6:	ff 75 08             	pushl  0x8(%ebp)
801058f9:	e8 6f ff ff ff       	call   8010586d <memmove>
801058fe:	83 c4 0c             	add    $0xc,%esp
}
80105901:	c9                   	leave  
80105902:	c3                   	ret    

80105903 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105903:	55                   	push   %ebp
80105904:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
80105906:	eb 0c                	jmp    80105914 <strncmp+0x11>
    n--, p++, q++;
80105908:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
8010590c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105910:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80105914:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105918:	74 1a                	je     80105934 <strncmp+0x31>
8010591a:	8b 45 08             	mov    0x8(%ebp),%eax
8010591d:	0f b6 00             	movzbl (%eax),%eax
80105920:	84 c0                	test   %al,%al
80105922:	74 10                	je     80105934 <strncmp+0x31>
80105924:	8b 45 08             	mov    0x8(%ebp),%eax
80105927:	0f b6 10             	movzbl (%eax),%edx
8010592a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010592d:	0f b6 00             	movzbl (%eax),%eax
80105930:	38 c2                	cmp    %al,%dl
80105932:	74 d4                	je     80105908 <strncmp+0x5>
    n--, p++, q++;
  if(n == 0)
80105934:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105938:	75 07                	jne    80105941 <strncmp+0x3e>
    return 0;
8010593a:	b8 00 00 00 00       	mov    $0x0,%eax
8010593f:	eb 16                	jmp    80105957 <strncmp+0x54>
  return (uchar)*p - (uchar)*q;
80105941:	8b 45 08             	mov    0x8(%ebp),%eax
80105944:	0f b6 00             	movzbl (%eax),%eax
80105947:	0f b6 d0             	movzbl %al,%edx
8010594a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010594d:	0f b6 00             	movzbl (%eax),%eax
80105950:	0f b6 c0             	movzbl %al,%eax
80105953:	29 c2                	sub    %eax,%edx
80105955:	89 d0                	mov    %edx,%eax
}
80105957:	5d                   	pop    %ebp
80105958:	c3                   	ret    

80105959 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105959:	55                   	push   %ebp
8010595a:	89 e5                	mov    %esp,%ebp
8010595c:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
8010595f:	8b 45 08             	mov    0x8(%ebp),%eax
80105962:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
80105965:	90                   	nop
80105966:	8b 45 10             	mov    0x10(%ebp),%eax
80105969:	8d 50 ff             	lea    -0x1(%eax),%edx
8010596c:	89 55 10             	mov    %edx,0x10(%ebp)
8010596f:	85 c0                	test   %eax,%eax
80105971:	7e 2c                	jle    8010599f <strncpy+0x46>
80105973:	8b 45 08             	mov    0x8(%ebp),%eax
80105976:	8d 50 01             	lea    0x1(%eax),%edx
80105979:	89 55 08             	mov    %edx,0x8(%ebp)
8010597c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010597f:	8d 4a 01             	lea    0x1(%edx),%ecx
80105982:	89 4d 0c             	mov    %ecx,0xc(%ebp)
80105985:	0f b6 12             	movzbl (%edx),%edx
80105988:	88 10                	mov    %dl,(%eax)
8010598a:	0f b6 00             	movzbl (%eax),%eax
8010598d:	84 c0                	test   %al,%al
8010598f:	75 d5                	jne    80105966 <strncpy+0xd>
    ;
  while(n-- > 0)
80105991:	eb 0c                	jmp    8010599f <strncpy+0x46>
    *s++ = 0;
80105993:	8b 45 08             	mov    0x8(%ebp),%eax
80105996:	8d 50 01             	lea    0x1(%eax),%edx
80105999:	89 55 08             	mov    %edx,0x8(%ebp)
8010599c:	c6 00 00             	movb   $0x0,(%eax)
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
8010599f:	8b 45 10             	mov    0x10(%ebp),%eax
801059a2:	8d 50 ff             	lea    -0x1(%eax),%edx
801059a5:	89 55 10             	mov    %edx,0x10(%ebp)
801059a8:	85 c0                	test   %eax,%eax
801059aa:	7f e7                	jg     80105993 <strncpy+0x3a>
    *s++ = 0;
  return os;
801059ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801059af:	c9                   	leave  
801059b0:	c3                   	ret    

801059b1 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801059b1:	55                   	push   %ebp
801059b2:	89 e5                	mov    %esp,%ebp
801059b4:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
801059b7:	8b 45 08             	mov    0x8(%ebp),%eax
801059ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
801059bd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801059c1:	7f 05                	jg     801059c8 <safestrcpy+0x17>
    return os;
801059c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
801059c6:	eb 31                	jmp    801059f9 <safestrcpy+0x48>
  while(--n > 0 && (*s++ = *t++) != 0)
801059c8:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801059cc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801059d0:	7e 1e                	jle    801059f0 <safestrcpy+0x3f>
801059d2:	8b 45 08             	mov    0x8(%ebp),%eax
801059d5:	8d 50 01             	lea    0x1(%eax),%edx
801059d8:	89 55 08             	mov    %edx,0x8(%ebp)
801059db:	8b 55 0c             	mov    0xc(%ebp),%edx
801059de:	8d 4a 01             	lea    0x1(%edx),%ecx
801059e1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
801059e4:	0f b6 12             	movzbl (%edx),%edx
801059e7:	88 10                	mov    %dl,(%eax)
801059e9:	0f b6 00             	movzbl (%eax),%eax
801059ec:	84 c0                	test   %al,%al
801059ee:	75 d8                	jne    801059c8 <safestrcpy+0x17>
    ;
  *s = 0;
801059f0:	8b 45 08             	mov    0x8(%ebp),%eax
801059f3:	c6 00 00             	movb   $0x0,(%eax)
  return os;
801059f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801059f9:	c9                   	leave  
801059fa:	c3                   	ret    

801059fb <strlen>:

int
strlen(const char *s)
{
801059fb:	55                   	push   %ebp
801059fc:	89 e5                	mov    %esp,%ebp
801059fe:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
80105a01:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105a08:	eb 04                	jmp    80105a0e <strlen+0x13>
80105a0a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105a0e:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105a11:	8b 45 08             	mov    0x8(%ebp),%eax
80105a14:	01 d0                	add    %edx,%eax
80105a16:	0f b6 00             	movzbl (%eax),%eax
80105a19:	84 c0                	test   %al,%al
80105a1b:	75 ed                	jne    80105a0a <strlen+0xf>
    ;
  return n;
80105a1d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105a20:	c9                   	leave  
80105a21:	c3                   	ret    

80105a22 <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105a22:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80105a26:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80105a2a:	55                   	push   %ebp
  pushl %ebx
80105a2b:	53                   	push   %ebx
  pushl %esi
80105a2c:	56                   	push   %esi
  pushl %edi
80105a2d:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105a2e:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105a30:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
80105a32:	5f                   	pop    %edi
  popl %esi
80105a33:	5e                   	pop    %esi
  popl %ebx
80105a34:	5b                   	pop    %ebx
  popl %ebp
80105a35:	5d                   	pop    %ebp
  ret
80105a36:	c3                   	ret    

80105a37 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105a37:	55                   	push   %ebp
80105a38:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80105a3a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105a40:	8b 00                	mov    (%eax),%eax
80105a42:	3b 45 08             	cmp    0x8(%ebp),%eax
80105a45:	76 12                	jbe    80105a59 <fetchint+0x22>
80105a47:	8b 45 08             	mov    0x8(%ebp),%eax
80105a4a:	8d 50 04             	lea    0x4(%eax),%edx
80105a4d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105a53:	8b 00                	mov    (%eax),%eax
80105a55:	39 c2                	cmp    %eax,%edx
80105a57:	76 07                	jbe    80105a60 <fetchint+0x29>
    return -1;
80105a59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a5e:	eb 0f                	jmp    80105a6f <fetchint+0x38>
  *ip = *(int*)(addr);
80105a60:	8b 45 08             	mov    0x8(%ebp),%eax
80105a63:	8b 10                	mov    (%eax),%edx
80105a65:	8b 45 0c             	mov    0xc(%ebp),%eax
80105a68:	89 10                	mov    %edx,(%eax)
  return 0;
80105a6a:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105a6f:	5d                   	pop    %ebp
80105a70:	c3                   	ret    

80105a71 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105a71:	55                   	push   %ebp
80105a72:	89 e5                	mov    %esp,%ebp
80105a74:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
80105a77:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105a7d:	8b 00                	mov    (%eax),%eax
80105a7f:	3b 45 08             	cmp    0x8(%ebp),%eax
80105a82:	77 07                	ja     80105a8b <fetchstr+0x1a>
    return -1;
80105a84:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a89:	eb 46                	jmp    80105ad1 <fetchstr+0x60>
  *pp = (char*)addr;
80105a8b:	8b 55 08             	mov    0x8(%ebp),%edx
80105a8e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105a91:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
80105a93:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105a99:	8b 00                	mov    (%eax),%eax
80105a9b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
80105a9e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105aa1:	8b 00                	mov    (%eax),%eax
80105aa3:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105aa6:	eb 1c                	jmp    80105ac4 <fetchstr+0x53>
    if(*s == 0)
80105aa8:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105aab:	0f b6 00             	movzbl (%eax),%eax
80105aae:	84 c0                	test   %al,%al
80105ab0:	75 0e                	jne    80105ac0 <fetchstr+0x4f>
      return s - *pp;
80105ab2:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105ab5:	8b 45 0c             	mov    0xc(%ebp),%eax
80105ab8:	8b 00                	mov    (%eax),%eax
80105aba:	29 c2                	sub    %eax,%edx
80105abc:	89 d0                	mov    %edx,%eax
80105abe:	eb 11                	jmp    80105ad1 <fetchstr+0x60>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
80105ac0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105ac4:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105ac7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105aca:	72 dc                	jb     80105aa8 <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
80105acc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ad1:	c9                   	leave  
80105ad2:	c3                   	ret    

80105ad3 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105ad3:	55                   	push   %ebp
80105ad4:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80105ad6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105adc:	8b 40 18             	mov    0x18(%eax),%eax
80105adf:	8b 40 44             	mov    0x44(%eax),%eax
80105ae2:	8b 55 08             	mov    0x8(%ebp),%edx
80105ae5:	c1 e2 02             	shl    $0x2,%edx
80105ae8:	01 d0                	add    %edx,%eax
80105aea:	83 c0 04             	add    $0x4,%eax
80105aed:	ff 75 0c             	pushl  0xc(%ebp)
80105af0:	50                   	push   %eax
80105af1:	e8 41 ff ff ff       	call   80105a37 <fetchint>
80105af6:	83 c4 08             	add    $0x8,%esp
}
80105af9:	c9                   	leave  
80105afa:	c3                   	ret    

80105afb <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105afb:	55                   	push   %ebp
80105afc:	89 e5                	mov    %esp,%ebp
80105afe:	83 ec 10             	sub    $0x10,%esp
  int i;
  
  if(argint(n, &i) < 0)
80105b01:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105b04:	50                   	push   %eax
80105b05:	ff 75 08             	pushl  0x8(%ebp)
80105b08:	e8 c6 ff ff ff       	call   80105ad3 <argint>
80105b0d:	83 c4 08             	add    $0x8,%esp
80105b10:	85 c0                	test   %eax,%eax
80105b12:	79 07                	jns    80105b1b <argptr+0x20>
    return -1;
80105b14:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b19:	eb 3b                	jmp    80105b56 <argptr+0x5b>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
80105b1b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105b21:	8b 00                	mov    (%eax),%eax
80105b23:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105b26:	39 d0                	cmp    %edx,%eax
80105b28:	76 16                	jbe    80105b40 <argptr+0x45>
80105b2a:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105b2d:	89 c2                	mov    %eax,%edx
80105b2f:	8b 45 10             	mov    0x10(%ebp),%eax
80105b32:	01 c2                	add    %eax,%edx
80105b34:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105b3a:	8b 00                	mov    (%eax),%eax
80105b3c:	39 c2                	cmp    %eax,%edx
80105b3e:	76 07                	jbe    80105b47 <argptr+0x4c>
    return -1;
80105b40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b45:	eb 0f                	jmp    80105b56 <argptr+0x5b>
  *pp = (char*)i;
80105b47:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105b4a:	89 c2                	mov    %eax,%edx
80105b4c:	8b 45 0c             	mov    0xc(%ebp),%eax
80105b4f:	89 10                	mov    %edx,(%eax)
  return 0;
80105b51:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105b56:	c9                   	leave  
80105b57:	c3                   	ret    

80105b58 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105b58:	55                   	push   %ebp
80105b59:	89 e5                	mov    %esp,%ebp
80105b5b:	83 ec 10             	sub    $0x10,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105b5e:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105b61:	50                   	push   %eax
80105b62:	ff 75 08             	pushl  0x8(%ebp)
80105b65:	e8 69 ff ff ff       	call   80105ad3 <argint>
80105b6a:	83 c4 08             	add    $0x8,%esp
80105b6d:	85 c0                	test   %eax,%eax
80105b6f:	79 07                	jns    80105b78 <argstr+0x20>
    return -1;
80105b71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b76:	eb 0f                	jmp    80105b87 <argstr+0x2f>
  return fetchstr(addr, pp);
80105b78:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105b7b:	ff 75 0c             	pushl  0xc(%ebp)
80105b7e:	50                   	push   %eax
80105b7f:	e8 ed fe ff ff       	call   80105a71 <fetchstr>
80105b84:	83 c4 08             	add    $0x8,%esp
}
80105b87:	c9                   	leave  
80105b88:	c3                   	ret    

80105b89 <syscall>:
[SYS_yield]    sys_yield,
};

void
syscall(void)
{
80105b89:	55                   	push   %ebp
80105b8a:	89 e5                	mov    %esp,%ebp
80105b8c:	53                   	push   %ebx
80105b8d:	83 ec 14             	sub    $0x14,%esp
  int num;

  num = proc->tf->eax;
80105b90:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105b96:	8b 40 18             	mov    0x18(%eax),%eax
80105b99:	8b 40 1c             	mov    0x1c(%eax),%eax
80105b9c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105b9f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105ba3:	7e 30                	jle    80105bd5 <syscall+0x4c>
80105ba5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ba8:	83 f8 17             	cmp    $0x17,%eax
80105bab:	77 28                	ja     80105bd5 <syscall+0x4c>
80105bad:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bb0:	8b 04 85 40 c0 10 80 	mov    -0x7fef3fc0(,%eax,4),%eax
80105bb7:	85 c0                	test   %eax,%eax
80105bb9:	74 1a                	je     80105bd5 <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
80105bbb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105bc1:	8b 58 18             	mov    0x18(%eax),%ebx
80105bc4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bc7:	8b 04 85 40 c0 10 80 	mov    -0x7fef3fc0(,%eax,4),%eax
80105bce:	ff d0                	call   *%eax
80105bd0:	89 43 1c             	mov    %eax,0x1c(%ebx)
80105bd3:	eb 34                	jmp    80105c09 <syscall+0x80>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
80105bd5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105bdb:	8d 50 6c             	lea    0x6c(%eax),%edx
80105bde:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80105be4:	8b 40 10             	mov    0x10(%eax),%eax
80105be7:	ff 75 f4             	pushl  -0xc(%ebp)
80105bea:	52                   	push   %edx
80105beb:	50                   	push   %eax
80105bec:	68 7a 8f 10 80       	push   $0x80108f7a
80105bf1:	e8 d0 a7 ff ff       	call   801003c6 <cprintf>
80105bf6:	83 c4 10             	add    $0x10,%esp
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
80105bf9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105bff:	8b 40 18             	mov    0x18(%eax),%eax
80105c02:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80105c09:	90                   	nop
80105c0a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c0d:	c9                   	leave  
80105c0e:	c3                   	ret    

80105c0f <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
80105c0f:	55                   	push   %ebp
80105c10:	89 e5                	mov    %esp,%ebp
80105c12:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80105c15:	83 ec 08             	sub    $0x8,%esp
80105c18:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105c1b:	50                   	push   %eax
80105c1c:	ff 75 08             	pushl  0x8(%ebp)
80105c1f:	e8 af fe ff ff       	call   80105ad3 <argint>
80105c24:	83 c4 10             	add    $0x10,%esp
80105c27:	85 c0                	test   %eax,%eax
80105c29:	79 07                	jns    80105c32 <argfd+0x23>
    return -1;
80105c2b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c30:	eb 50                	jmp    80105c82 <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80105c32:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c35:	85 c0                	test   %eax,%eax
80105c37:	78 21                	js     80105c5a <argfd+0x4b>
80105c39:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c3c:	83 f8 0f             	cmp    $0xf,%eax
80105c3f:	7f 19                	jg     80105c5a <argfd+0x4b>
80105c41:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c47:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105c4a:	83 c2 08             	add    $0x8,%edx
80105c4d:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105c51:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105c54:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105c58:	75 07                	jne    80105c61 <argfd+0x52>
    return -1;
80105c5a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c5f:	eb 21                	jmp    80105c82 <argfd+0x73>
  if(pfd)
80105c61:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80105c65:	74 08                	je     80105c6f <argfd+0x60>
    *pfd = fd;
80105c67:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105c6a:	8b 45 0c             	mov    0xc(%ebp),%eax
80105c6d:	89 10                	mov    %edx,(%eax)
  if(pf)
80105c6f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105c73:	74 08                	je     80105c7d <argfd+0x6e>
    *pf = f;
80105c75:	8b 45 10             	mov    0x10(%ebp),%eax
80105c78:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105c7b:	89 10                	mov    %edx,(%eax)
  return 0;
80105c7d:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105c82:	c9                   	leave  
80105c83:	c3                   	ret    

80105c84 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80105c84:	55                   	push   %ebp
80105c85:	89 e5                	mov    %esp,%ebp
80105c87:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105c8a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105c91:	eb 30                	jmp    80105cc3 <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
80105c93:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c99:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105c9c:	83 c2 08             	add    $0x8,%edx
80105c9f:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105ca3:	85 c0                	test   %eax,%eax
80105ca5:	75 18                	jne    80105cbf <fdalloc+0x3b>
      proc->ofile[fd] = f;
80105ca7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105cad:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105cb0:	8d 4a 08             	lea    0x8(%edx),%ecx
80105cb3:	8b 55 08             	mov    0x8(%ebp),%edx
80105cb6:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
80105cba:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105cbd:	eb 0f                	jmp    80105cce <fdalloc+0x4a>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105cbf:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105cc3:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
80105cc7:	7e ca                	jle    80105c93 <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
80105cc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105cce:	c9                   	leave  
80105ccf:	c3                   	ret    

80105cd0 <sys_dup>:

int
sys_dup(void)
{
80105cd0:	55                   	push   %ebp
80105cd1:	89 e5                	mov    %esp,%ebp
80105cd3:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
80105cd6:	83 ec 04             	sub    $0x4,%esp
80105cd9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105cdc:	50                   	push   %eax
80105cdd:	6a 00                	push   $0x0
80105cdf:	6a 00                	push   $0x0
80105ce1:	e8 29 ff ff ff       	call   80105c0f <argfd>
80105ce6:	83 c4 10             	add    $0x10,%esp
80105ce9:	85 c0                	test   %eax,%eax
80105ceb:	79 07                	jns    80105cf4 <sys_dup+0x24>
    return -1;
80105ced:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cf2:	eb 31                	jmp    80105d25 <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
80105cf4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105cf7:	83 ec 0c             	sub    $0xc,%esp
80105cfa:	50                   	push   %eax
80105cfb:	e8 84 ff ff ff       	call   80105c84 <fdalloc>
80105d00:	83 c4 10             	add    $0x10,%esp
80105d03:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105d06:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105d0a:	79 07                	jns    80105d13 <sys_dup+0x43>
    return -1;
80105d0c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d11:	eb 12                	jmp    80105d25 <sys_dup+0x55>
  filedup(f);
80105d13:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d16:	83 ec 0c             	sub    $0xc,%esp
80105d19:	50                   	push   %eax
80105d1a:	e8 e1 b2 ff ff       	call   80101000 <filedup>
80105d1f:	83 c4 10             	add    $0x10,%esp
  return fd;
80105d22:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80105d25:	c9                   	leave  
80105d26:	c3                   	ret    

80105d27 <sys_read>:

int
sys_read(void)
{
80105d27:	55                   	push   %ebp
80105d28:	89 e5                	mov    %esp,%ebp
80105d2a:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105d2d:	83 ec 04             	sub    $0x4,%esp
80105d30:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d33:	50                   	push   %eax
80105d34:	6a 00                	push   $0x0
80105d36:	6a 00                	push   $0x0
80105d38:	e8 d2 fe ff ff       	call   80105c0f <argfd>
80105d3d:	83 c4 10             	add    $0x10,%esp
80105d40:	85 c0                	test   %eax,%eax
80105d42:	78 2e                	js     80105d72 <sys_read+0x4b>
80105d44:	83 ec 08             	sub    $0x8,%esp
80105d47:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105d4a:	50                   	push   %eax
80105d4b:	6a 02                	push   $0x2
80105d4d:	e8 81 fd ff ff       	call   80105ad3 <argint>
80105d52:	83 c4 10             	add    $0x10,%esp
80105d55:	85 c0                	test   %eax,%eax
80105d57:	78 19                	js     80105d72 <sys_read+0x4b>
80105d59:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d5c:	83 ec 04             	sub    $0x4,%esp
80105d5f:	50                   	push   %eax
80105d60:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105d63:	50                   	push   %eax
80105d64:	6a 01                	push   $0x1
80105d66:	e8 90 fd ff ff       	call   80105afb <argptr>
80105d6b:	83 c4 10             	add    $0x10,%esp
80105d6e:	85 c0                	test   %eax,%eax
80105d70:	79 07                	jns    80105d79 <sys_read+0x52>
    return -1;
80105d72:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d77:	eb 17                	jmp    80105d90 <sys_read+0x69>
  return fileread(f, p, n);
80105d79:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105d7c:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105d7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d82:	83 ec 04             	sub    $0x4,%esp
80105d85:	51                   	push   %ecx
80105d86:	52                   	push   %edx
80105d87:	50                   	push   %eax
80105d88:	e8 03 b4 ff ff       	call   80101190 <fileread>
80105d8d:	83 c4 10             	add    $0x10,%esp
}
80105d90:	c9                   	leave  
80105d91:	c3                   	ret    

80105d92 <sys_write>:

int
sys_write(void)
{
80105d92:	55                   	push   %ebp
80105d93:	89 e5                	mov    %esp,%ebp
80105d95:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105d98:	83 ec 04             	sub    $0x4,%esp
80105d9b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d9e:	50                   	push   %eax
80105d9f:	6a 00                	push   $0x0
80105da1:	6a 00                	push   $0x0
80105da3:	e8 67 fe ff ff       	call   80105c0f <argfd>
80105da8:	83 c4 10             	add    $0x10,%esp
80105dab:	85 c0                	test   %eax,%eax
80105dad:	78 2e                	js     80105ddd <sys_write+0x4b>
80105daf:	83 ec 08             	sub    $0x8,%esp
80105db2:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105db5:	50                   	push   %eax
80105db6:	6a 02                	push   $0x2
80105db8:	e8 16 fd ff ff       	call   80105ad3 <argint>
80105dbd:	83 c4 10             	add    $0x10,%esp
80105dc0:	85 c0                	test   %eax,%eax
80105dc2:	78 19                	js     80105ddd <sys_write+0x4b>
80105dc4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dc7:	83 ec 04             	sub    $0x4,%esp
80105dca:	50                   	push   %eax
80105dcb:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105dce:	50                   	push   %eax
80105dcf:	6a 01                	push   $0x1
80105dd1:	e8 25 fd ff ff       	call   80105afb <argptr>
80105dd6:	83 c4 10             	add    $0x10,%esp
80105dd9:	85 c0                	test   %eax,%eax
80105ddb:	79 07                	jns    80105de4 <sys_write+0x52>
    return -1;
80105ddd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105de2:	eb 17                	jmp    80105dfb <sys_write+0x69>
  return filewrite(f, p, n);
80105de4:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105de7:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105dea:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ded:	83 ec 04             	sub    $0x4,%esp
80105df0:	51                   	push   %ecx
80105df1:	52                   	push   %edx
80105df2:	50                   	push   %eax
80105df3:	e8 50 b4 ff ff       	call   80101248 <filewrite>
80105df8:	83 c4 10             	add    $0x10,%esp
}
80105dfb:	c9                   	leave  
80105dfc:	c3                   	ret    

80105dfd <sys_close>:

int
sys_close(void)
{
80105dfd:	55                   	push   %ebp
80105dfe:	89 e5                	mov    %esp,%ebp
80105e00:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
80105e03:	83 ec 04             	sub    $0x4,%esp
80105e06:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105e09:	50                   	push   %eax
80105e0a:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e0d:	50                   	push   %eax
80105e0e:	6a 00                	push   $0x0
80105e10:	e8 fa fd ff ff       	call   80105c0f <argfd>
80105e15:	83 c4 10             	add    $0x10,%esp
80105e18:	85 c0                	test   %eax,%eax
80105e1a:	79 07                	jns    80105e23 <sys_close+0x26>
    return -1;
80105e1c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e21:	eb 28                	jmp    80105e4b <sys_close+0x4e>
  proc->ofile[fd] = 0;
80105e23:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105e29:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105e2c:	83 c2 08             	add    $0x8,%edx
80105e2f:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80105e36:	00 
  fileclose(f);
80105e37:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e3a:	83 ec 0c             	sub    $0xc,%esp
80105e3d:	50                   	push   %eax
80105e3e:	e8 0e b2 ff ff       	call   80101051 <fileclose>
80105e43:	83 c4 10             	add    $0x10,%esp
  return 0;
80105e46:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105e4b:	c9                   	leave  
80105e4c:	c3                   	ret    

80105e4d <sys_fstat>:

int
sys_fstat(void)
{
80105e4d:	55                   	push   %ebp
80105e4e:	89 e5                	mov    %esp,%ebp
80105e50:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105e53:	83 ec 04             	sub    $0x4,%esp
80105e56:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e59:	50                   	push   %eax
80105e5a:	6a 00                	push   $0x0
80105e5c:	6a 00                	push   $0x0
80105e5e:	e8 ac fd ff ff       	call   80105c0f <argfd>
80105e63:	83 c4 10             	add    $0x10,%esp
80105e66:	85 c0                	test   %eax,%eax
80105e68:	78 17                	js     80105e81 <sys_fstat+0x34>
80105e6a:	83 ec 04             	sub    $0x4,%esp
80105e6d:	6a 14                	push   $0x14
80105e6f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105e72:	50                   	push   %eax
80105e73:	6a 01                	push   $0x1
80105e75:	e8 81 fc ff ff       	call   80105afb <argptr>
80105e7a:	83 c4 10             	add    $0x10,%esp
80105e7d:	85 c0                	test   %eax,%eax
80105e7f:	79 07                	jns    80105e88 <sys_fstat+0x3b>
    return -1;
80105e81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e86:	eb 13                	jmp    80105e9b <sys_fstat+0x4e>
  return filestat(f, st);
80105e88:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105e8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e8e:	83 ec 08             	sub    $0x8,%esp
80105e91:	52                   	push   %edx
80105e92:	50                   	push   %eax
80105e93:	e8 a1 b2 ff ff       	call   80101139 <filestat>
80105e98:	83 c4 10             	add    $0x10,%esp
}
80105e9b:	c9                   	leave  
80105e9c:	c3                   	ret    

80105e9d <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105e9d:	55                   	push   %ebp
80105e9e:	89 e5                	mov    %esp,%ebp
80105ea0:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105ea3:	83 ec 08             	sub    $0x8,%esp
80105ea6:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105ea9:	50                   	push   %eax
80105eaa:	6a 00                	push   $0x0
80105eac:	e8 a7 fc ff ff       	call   80105b58 <argstr>
80105eb1:	83 c4 10             	add    $0x10,%esp
80105eb4:	85 c0                	test   %eax,%eax
80105eb6:	78 15                	js     80105ecd <sys_link+0x30>
80105eb8:	83 ec 08             	sub    $0x8,%esp
80105ebb:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105ebe:	50                   	push   %eax
80105ebf:	6a 01                	push   $0x1
80105ec1:	e8 92 fc ff ff       	call   80105b58 <argstr>
80105ec6:	83 c4 10             	add    $0x10,%esp
80105ec9:	85 c0                	test   %eax,%eax
80105ecb:	79 0a                	jns    80105ed7 <sys_link+0x3a>
    return -1;
80105ecd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ed2:	e9 68 01 00 00       	jmp    8010603f <sys_link+0x1a2>

  begin_op();
80105ed7:	e8 71 d6 ff ff       	call   8010354d <begin_op>
  if((ip = namei(old)) == 0){
80105edc:	8b 45 d8             	mov    -0x28(%ebp),%eax
80105edf:	83 ec 0c             	sub    $0xc,%esp
80105ee2:	50                   	push   %eax
80105ee3:	e8 40 c6 ff ff       	call   80102528 <namei>
80105ee8:	83 c4 10             	add    $0x10,%esp
80105eeb:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105eee:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105ef2:	75 0f                	jne    80105f03 <sys_link+0x66>
    end_op();
80105ef4:	e8 e0 d6 ff ff       	call   801035d9 <end_op>
    return -1;
80105ef9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105efe:	e9 3c 01 00 00       	jmp    8010603f <sys_link+0x1a2>
  }

  ilock(ip);
80105f03:	83 ec 0c             	sub    $0xc,%esp
80105f06:	ff 75 f4             	pushl  -0xc(%ebp)
80105f09:	e8 5c ba ff ff       	call   8010196a <ilock>
80105f0e:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
80105f11:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f14:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105f18:	66 83 f8 01          	cmp    $0x1,%ax
80105f1c:	75 1d                	jne    80105f3b <sys_link+0x9e>
    iunlockput(ip);
80105f1e:	83 ec 0c             	sub    $0xc,%esp
80105f21:	ff 75 f4             	pushl  -0xc(%ebp)
80105f24:	e8 01 bd ff ff       	call   80101c2a <iunlockput>
80105f29:	83 c4 10             	add    $0x10,%esp
    end_op();
80105f2c:	e8 a8 d6 ff ff       	call   801035d9 <end_op>
    return -1;
80105f31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f36:	e9 04 01 00 00       	jmp    8010603f <sys_link+0x1a2>
  }

  ip->nlink++;
80105f3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f3e:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105f42:	83 c0 01             	add    $0x1,%eax
80105f45:	89 c2                	mov    %eax,%edx
80105f47:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f4a:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105f4e:	83 ec 0c             	sub    $0xc,%esp
80105f51:	ff 75 f4             	pushl  -0xc(%ebp)
80105f54:	e8 37 b8 ff ff       	call   80101790 <iupdate>
80105f59:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
80105f5c:	83 ec 0c             	sub    $0xc,%esp
80105f5f:	ff 75 f4             	pushl  -0xc(%ebp)
80105f62:	e8 61 bb ff ff       	call   80101ac8 <iunlock>
80105f67:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
80105f6a:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105f6d:	83 ec 08             	sub    $0x8,%esp
80105f70:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80105f73:	52                   	push   %edx
80105f74:	50                   	push   %eax
80105f75:	e8 ca c5 ff ff       	call   80102544 <nameiparent>
80105f7a:	83 c4 10             	add    $0x10,%esp
80105f7d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105f80:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105f84:	74 71                	je     80105ff7 <sys_link+0x15a>
    goto bad;
  ilock(dp);
80105f86:	83 ec 0c             	sub    $0xc,%esp
80105f89:	ff 75 f0             	pushl  -0x10(%ebp)
80105f8c:	e8 d9 b9 ff ff       	call   8010196a <ilock>
80105f91:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105f94:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f97:	8b 10                	mov    (%eax),%edx
80105f99:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f9c:	8b 00                	mov    (%eax),%eax
80105f9e:	39 c2                	cmp    %eax,%edx
80105fa0:	75 1d                	jne    80105fbf <sys_link+0x122>
80105fa2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105fa5:	8b 40 04             	mov    0x4(%eax),%eax
80105fa8:	83 ec 04             	sub    $0x4,%esp
80105fab:	50                   	push   %eax
80105fac:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80105faf:	50                   	push   %eax
80105fb0:	ff 75 f0             	pushl  -0x10(%ebp)
80105fb3:	e8 d4 c2 ff ff       	call   8010228c <dirlink>
80105fb8:	83 c4 10             	add    $0x10,%esp
80105fbb:	85 c0                	test   %eax,%eax
80105fbd:	79 10                	jns    80105fcf <sys_link+0x132>
    iunlockput(dp);
80105fbf:	83 ec 0c             	sub    $0xc,%esp
80105fc2:	ff 75 f0             	pushl  -0x10(%ebp)
80105fc5:	e8 60 bc ff ff       	call   80101c2a <iunlockput>
80105fca:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105fcd:	eb 29                	jmp    80105ff8 <sys_link+0x15b>
  }
  iunlockput(dp);
80105fcf:	83 ec 0c             	sub    $0xc,%esp
80105fd2:	ff 75 f0             	pushl  -0x10(%ebp)
80105fd5:	e8 50 bc ff ff       	call   80101c2a <iunlockput>
80105fda:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80105fdd:	83 ec 0c             	sub    $0xc,%esp
80105fe0:	ff 75 f4             	pushl  -0xc(%ebp)
80105fe3:	e8 52 bb ff ff       	call   80101b3a <iput>
80105fe8:	83 c4 10             	add    $0x10,%esp

  end_op();
80105feb:	e8 e9 d5 ff ff       	call   801035d9 <end_op>

  return 0;
80105ff0:	b8 00 00 00 00       	mov    $0x0,%eax
80105ff5:	eb 48                	jmp    8010603f <sys_link+0x1a2>
  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
80105ff7:	90                   	nop
  end_op();

  return 0;

bad:
  ilock(ip);
80105ff8:	83 ec 0c             	sub    $0xc,%esp
80105ffb:	ff 75 f4             	pushl  -0xc(%ebp)
80105ffe:	e8 67 b9 ff ff       	call   8010196a <ilock>
80106003:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
80106006:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106009:	0f b7 40 16          	movzwl 0x16(%eax),%eax
8010600d:	83 e8 01             	sub    $0x1,%eax
80106010:	89 c2                	mov    %eax,%edx
80106012:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106015:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80106019:	83 ec 0c             	sub    $0xc,%esp
8010601c:	ff 75 f4             	pushl  -0xc(%ebp)
8010601f:	e8 6c b7 ff ff       	call   80101790 <iupdate>
80106024:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80106027:	83 ec 0c             	sub    $0xc,%esp
8010602a:	ff 75 f4             	pushl  -0xc(%ebp)
8010602d:	e8 f8 bb ff ff       	call   80101c2a <iunlockput>
80106032:	83 c4 10             	add    $0x10,%esp
  end_op();
80106035:	e8 9f d5 ff ff       	call   801035d9 <end_op>
  return -1;
8010603a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010603f:	c9                   	leave  
80106040:	c3                   	ret    

80106041 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80106041:	55                   	push   %ebp
80106042:	89 e5                	mov    %esp,%ebp
80106044:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106047:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
8010604e:	eb 40                	jmp    80106090 <isdirempty+0x4f>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106050:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106053:	6a 10                	push   $0x10
80106055:	50                   	push   %eax
80106056:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106059:	50                   	push   %eax
8010605a:	ff 75 08             	pushl  0x8(%ebp)
8010605d:	e8 76 be ff ff       	call   80101ed8 <readi>
80106062:	83 c4 10             	add    $0x10,%esp
80106065:	83 f8 10             	cmp    $0x10,%eax
80106068:	74 0d                	je     80106077 <isdirempty+0x36>
      panic("isdirempty: readi");
8010606a:	83 ec 0c             	sub    $0xc,%esp
8010606d:	68 96 8f 10 80       	push   $0x80108f96
80106072:	e8 ef a4 ff ff       	call   80100566 <panic>
    if(de.inum != 0)
80106077:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
8010607b:	66 85 c0             	test   %ax,%ax
8010607e:	74 07                	je     80106087 <isdirempty+0x46>
      return 0;
80106080:	b8 00 00 00 00       	mov    $0x0,%eax
80106085:	eb 1b                	jmp    801060a2 <isdirempty+0x61>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106087:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010608a:	83 c0 10             	add    $0x10,%eax
8010608d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106090:	8b 45 08             	mov    0x8(%ebp),%eax
80106093:	8b 50 18             	mov    0x18(%eax),%edx
80106096:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106099:	39 c2                	cmp    %eax,%edx
8010609b:	77 b3                	ja     80106050 <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
8010609d:	b8 01 00 00 00       	mov    $0x1,%eax
}
801060a2:	c9                   	leave  
801060a3:	c3                   	ret    

801060a4 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
801060a4:	55                   	push   %ebp
801060a5:	89 e5                	mov    %esp,%ebp
801060a7:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801060aa:	83 ec 08             	sub    $0x8,%esp
801060ad:	8d 45 cc             	lea    -0x34(%ebp),%eax
801060b0:	50                   	push   %eax
801060b1:	6a 00                	push   $0x0
801060b3:	e8 a0 fa ff ff       	call   80105b58 <argstr>
801060b8:	83 c4 10             	add    $0x10,%esp
801060bb:	85 c0                	test   %eax,%eax
801060bd:	79 0a                	jns    801060c9 <sys_unlink+0x25>
    return -1;
801060bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060c4:	e9 bc 01 00 00       	jmp    80106285 <sys_unlink+0x1e1>

  begin_op();
801060c9:	e8 7f d4 ff ff       	call   8010354d <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801060ce:	8b 45 cc             	mov    -0x34(%ebp),%eax
801060d1:	83 ec 08             	sub    $0x8,%esp
801060d4:	8d 55 d2             	lea    -0x2e(%ebp),%edx
801060d7:	52                   	push   %edx
801060d8:	50                   	push   %eax
801060d9:	e8 66 c4 ff ff       	call   80102544 <nameiparent>
801060de:	83 c4 10             	add    $0x10,%esp
801060e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
801060e4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801060e8:	75 0f                	jne    801060f9 <sys_unlink+0x55>
    end_op();
801060ea:	e8 ea d4 ff ff       	call   801035d9 <end_op>
    return -1;
801060ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060f4:	e9 8c 01 00 00       	jmp    80106285 <sys_unlink+0x1e1>
  }

  ilock(dp);
801060f9:	83 ec 0c             	sub    $0xc,%esp
801060fc:	ff 75 f4             	pushl  -0xc(%ebp)
801060ff:	e8 66 b8 ff ff       	call   8010196a <ilock>
80106104:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80106107:	83 ec 08             	sub    $0x8,%esp
8010610a:	68 a8 8f 10 80       	push   $0x80108fa8
8010610f:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80106112:	50                   	push   %eax
80106113:	e8 9f c0 ff ff       	call   801021b7 <namecmp>
80106118:	83 c4 10             	add    $0x10,%esp
8010611b:	85 c0                	test   %eax,%eax
8010611d:	0f 84 4a 01 00 00    	je     8010626d <sys_unlink+0x1c9>
80106123:	83 ec 08             	sub    $0x8,%esp
80106126:	68 aa 8f 10 80       	push   $0x80108faa
8010612b:	8d 45 d2             	lea    -0x2e(%ebp),%eax
8010612e:	50                   	push   %eax
8010612f:	e8 83 c0 ff ff       	call   801021b7 <namecmp>
80106134:	83 c4 10             	add    $0x10,%esp
80106137:	85 c0                	test   %eax,%eax
80106139:	0f 84 2e 01 00 00    	je     8010626d <sys_unlink+0x1c9>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
8010613f:	83 ec 04             	sub    $0x4,%esp
80106142:	8d 45 c8             	lea    -0x38(%ebp),%eax
80106145:	50                   	push   %eax
80106146:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80106149:	50                   	push   %eax
8010614a:	ff 75 f4             	pushl  -0xc(%ebp)
8010614d:	e8 80 c0 ff ff       	call   801021d2 <dirlookup>
80106152:	83 c4 10             	add    $0x10,%esp
80106155:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106158:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010615c:	0f 84 0a 01 00 00    	je     8010626c <sys_unlink+0x1c8>
    goto bad;
  ilock(ip);
80106162:	83 ec 0c             	sub    $0xc,%esp
80106165:	ff 75 f0             	pushl  -0x10(%ebp)
80106168:	e8 fd b7 ff ff       	call   8010196a <ilock>
8010616d:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
80106170:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106173:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80106177:	66 85 c0             	test   %ax,%ax
8010617a:	7f 0d                	jg     80106189 <sys_unlink+0xe5>
    panic("unlink: nlink < 1");
8010617c:	83 ec 0c             	sub    $0xc,%esp
8010617f:	68 ad 8f 10 80       	push   $0x80108fad
80106184:	e8 dd a3 ff ff       	call   80100566 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80106189:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010618c:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80106190:	66 83 f8 01          	cmp    $0x1,%ax
80106194:	75 25                	jne    801061bb <sys_unlink+0x117>
80106196:	83 ec 0c             	sub    $0xc,%esp
80106199:	ff 75 f0             	pushl  -0x10(%ebp)
8010619c:	e8 a0 fe ff ff       	call   80106041 <isdirempty>
801061a1:	83 c4 10             	add    $0x10,%esp
801061a4:	85 c0                	test   %eax,%eax
801061a6:	75 13                	jne    801061bb <sys_unlink+0x117>
    iunlockput(ip);
801061a8:	83 ec 0c             	sub    $0xc,%esp
801061ab:	ff 75 f0             	pushl  -0x10(%ebp)
801061ae:	e8 77 ba ff ff       	call   80101c2a <iunlockput>
801061b3:	83 c4 10             	add    $0x10,%esp
    goto bad;
801061b6:	e9 b2 00 00 00       	jmp    8010626d <sys_unlink+0x1c9>
  }

  memset(&de, 0, sizeof(de));
801061bb:	83 ec 04             	sub    $0x4,%esp
801061be:	6a 10                	push   $0x10
801061c0:	6a 00                	push   $0x0
801061c2:	8d 45 e0             	lea    -0x20(%ebp),%eax
801061c5:	50                   	push   %eax
801061c6:	e8 e3 f5 ff ff       	call   801057ae <memset>
801061cb:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801061ce:	8b 45 c8             	mov    -0x38(%ebp),%eax
801061d1:	6a 10                	push   $0x10
801061d3:	50                   	push   %eax
801061d4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801061d7:	50                   	push   %eax
801061d8:	ff 75 f4             	pushl  -0xc(%ebp)
801061db:	e8 4f be ff ff       	call   8010202f <writei>
801061e0:	83 c4 10             	add    $0x10,%esp
801061e3:	83 f8 10             	cmp    $0x10,%eax
801061e6:	74 0d                	je     801061f5 <sys_unlink+0x151>
    panic("unlink: writei");
801061e8:	83 ec 0c             	sub    $0xc,%esp
801061eb:	68 bf 8f 10 80       	push   $0x80108fbf
801061f0:	e8 71 a3 ff ff       	call   80100566 <panic>
  if(ip->type == T_DIR){
801061f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061f8:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801061fc:	66 83 f8 01          	cmp    $0x1,%ax
80106200:	75 21                	jne    80106223 <sys_unlink+0x17f>
    dp->nlink--;
80106202:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106205:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80106209:	83 e8 01             	sub    $0x1,%eax
8010620c:	89 c2                	mov    %eax,%edx
8010620e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106211:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80106215:	83 ec 0c             	sub    $0xc,%esp
80106218:	ff 75 f4             	pushl  -0xc(%ebp)
8010621b:	e8 70 b5 ff ff       	call   80101790 <iupdate>
80106220:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
80106223:	83 ec 0c             	sub    $0xc,%esp
80106226:	ff 75 f4             	pushl  -0xc(%ebp)
80106229:	e8 fc b9 ff ff       	call   80101c2a <iunlockput>
8010622e:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
80106231:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106234:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80106238:	83 e8 01             	sub    $0x1,%eax
8010623b:	89 c2                	mov    %eax,%edx
8010623d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106240:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80106244:	83 ec 0c             	sub    $0xc,%esp
80106247:	ff 75 f0             	pushl  -0x10(%ebp)
8010624a:	e8 41 b5 ff ff       	call   80101790 <iupdate>
8010624f:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80106252:	83 ec 0c             	sub    $0xc,%esp
80106255:	ff 75 f0             	pushl  -0x10(%ebp)
80106258:	e8 cd b9 ff ff       	call   80101c2a <iunlockput>
8010625d:	83 c4 10             	add    $0x10,%esp

  end_op();
80106260:	e8 74 d3 ff ff       	call   801035d9 <end_op>

  return 0;
80106265:	b8 00 00 00 00       	mov    $0x0,%eax
8010626a:	eb 19                	jmp    80106285 <sys_unlink+0x1e1>
  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
8010626c:	90                   	nop
  end_op();

  return 0;

bad:
  iunlockput(dp);
8010626d:	83 ec 0c             	sub    $0xc,%esp
80106270:	ff 75 f4             	pushl  -0xc(%ebp)
80106273:	e8 b2 b9 ff ff       	call   80101c2a <iunlockput>
80106278:	83 c4 10             	add    $0x10,%esp
  end_op();
8010627b:	e8 59 d3 ff ff       	call   801035d9 <end_op>
  return -1;
80106280:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106285:	c9                   	leave  
80106286:	c3                   	ret    

80106287 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80106287:	55                   	push   %ebp
80106288:	89 e5                	mov    %esp,%ebp
8010628a:	83 ec 38             	sub    $0x38,%esp
8010628d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106290:	8b 55 10             	mov    0x10(%ebp),%edx
80106293:	8b 45 14             	mov    0x14(%ebp),%eax
80106296:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
8010629a:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
8010629e:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801062a2:	83 ec 08             	sub    $0x8,%esp
801062a5:	8d 45 de             	lea    -0x22(%ebp),%eax
801062a8:	50                   	push   %eax
801062a9:	ff 75 08             	pushl  0x8(%ebp)
801062ac:	e8 93 c2 ff ff       	call   80102544 <nameiparent>
801062b1:	83 c4 10             	add    $0x10,%esp
801062b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
801062b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801062bb:	75 0a                	jne    801062c7 <create+0x40>
    return 0;
801062bd:	b8 00 00 00 00       	mov    $0x0,%eax
801062c2:	e9 90 01 00 00       	jmp    80106457 <create+0x1d0>
  ilock(dp);
801062c7:	83 ec 0c             	sub    $0xc,%esp
801062ca:	ff 75 f4             	pushl  -0xc(%ebp)
801062cd:	e8 98 b6 ff ff       	call   8010196a <ilock>
801062d2:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, &off)) != 0){
801062d5:	83 ec 04             	sub    $0x4,%esp
801062d8:	8d 45 ec             	lea    -0x14(%ebp),%eax
801062db:	50                   	push   %eax
801062dc:	8d 45 de             	lea    -0x22(%ebp),%eax
801062df:	50                   	push   %eax
801062e0:	ff 75 f4             	pushl  -0xc(%ebp)
801062e3:	e8 ea be ff ff       	call   801021d2 <dirlookup>
801062e8:	83 c4 10             	add    $0x10,%esp
801062eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
801062ee:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801062f2:	74 50                	je     80106344 <create+0xbd>
    iunlockput(dp);
801062f4:	83 ec 0c             	sub    $0xc,%esp
801062f7:	ff 75 f4             	pushl  -0xc(%ebp)
801062fa:	e8 2b b9 ff ff       	call   80101c2a <iunlockput>
801062ff:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
80106302:	83 ec 0c             	sub    $0xc,%esp
80106305:	ff 75 f0             	pushl  -0x10(%ebp)
80106308:	e8 5d b6 ff ff       	call   8010196a <ilock>
8010630d:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
80106310:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80106315:	75 15                	jne    8010632c <create+0xa5>
80106317:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010631a:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010631e:	66 83 f8 02          	cmp    $0x2,%ax
80106322:	75 08                	jne    8010632c <create+0xa5>
      return ip;
80106324:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106327:	e9 2b 01 00 00       	jmp    80106457 <create+0x1d0>
    iunlockput(ip);
8010632c:	83 ec 0c             	sub    $0xc,%esp
8010632f:	ff 75 f0             	pushl  -0x10(%ebp)
80106332:	e8 f3 b8 ff ff       	call   80101c2a <iunlockput>
80106337:	83 c4 10             	add    $0x10,%esp
    return 0;
8010633a:	b8 00 00 00 00       	mov    $0x0,%eax
8010633f:	e9 13 01 00 00       	jmp    80106457 <create+0x1d0>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80106344:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80106348:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010634b:	8b 00                	mov    (%eax),%eax
8010634d:	83 ec 08             	sub    $0x8,%esp
80106350:	52                   	push   %edx
80106351:	50                   	push   %eax
80106352:	e8 62 b3 ff ff       	call   801016b9 <ialloc>
80106357:	83 c4 10             	add    $0x10,%esp
8010635a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010635d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106361:	75 0d                	jne    80106370 <create+0xe9>
    panic("create: ialloc");
80106363:	83 ec 0c             	sub    $0xc,%esp
80106366:	68 ce 8f 10 80       	push   $0x80108fce
8010636b:	e8 f6 a1 ff ff       	call   80100566 <panic>

  ilock(ip);
80106370:	83 ec 0c             	sub    $0xc,%esp
80106373:	ff 75 f0             	pushl  -0x10(%ebp)
80106376:	e8 ef b5 ff ff       	call   8010196a <ilock>
8010637b:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
8010637e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106381:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80106385:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
80106389:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010638c:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80106390:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
80106394:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106397:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
8010639d:	83 ec 0c             	sub    $0xc,%esp
801063a0:	ff 75 f0             	pushl  -0x10(%ebp)
801063a3:	e8 e8 b3 ff ff       	call   80101790 <iupdate>
801063a8:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
801063ab:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801063b0:	75 6a                	jne    8010641c <create+0x195>
    dp->nlink++;  // for ".."
801063b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063b5:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801063b9:	83 c0 01             	add    $0x1,%eax
801063bc:	89 c2                	mov    %eax,%edx
801063be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063c1:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
801063c5:	83 ec 0c             	sub    $0xc,%esp
801063c8:	ff 75 f4             	pushl  -0xc(%ebp)
801063cb:	e8 c0 b3 ff ff       	call   80101790 <iupdate>
801063d0:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801063d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063d6:	8b 40 04             	mov    0x4(%eax),%eax
801063d9:	83 ec 04             	sub    $0x4,%esp
801063dc:	50                   	push   %eax
801063dd:	68 a8 8f 10 80       	push   $0x80108fa8
801063e2:	ff 75 f0             	pushl  -0x10(%ebp)
801063e5:	e8 a2 be ff ff       	call   8010228c <dirlink>
801063ea:	83 c4 10             	add    $0x10,%esp
801063ed:	85 c0                	test   %eax,%eax
801063ef:	78 1e                	js     8010640f <create+0x188>
801063f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063f4:	8b 40 04             	mov    0x4(%eax),%eax
801063f7:	83 ec 04             	sub    $0x4,%esp
801063fa:	50                   	push   %eax
801063fb:	68 aa 8f 10 80       	push   $0x80108faa
80106400:	ff 75 f0             	pushl  -0x10(%ebp)
80106403:	e8 84 be ff ff       	call   8010228c <dirlink>
80106408:	83 c4 10             	add    $0x10,%esp
8010640b:	85 c0                	test   %eax,%eax
8010640d:	79 0d                	jns    8010641c <create+0x195>
      panic("create dots");
8010640f:	83 ec 0c             	sub    $0xc,%esp
80106412:	68 dd 8f 10 80       	push   $0x80108fdd
80106417:	e8 4a a1 ff ff       	call   80100566 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
8010641c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010641f:	8b 40 04             	mov    0x4(%eax),%eax
80106422:	83 ec 04             	sub    $0x4,%esp
80106425:	50                   	push   %eax
80106426:	8d 45 de             	lea    -0x22(%ebp),%eax
80106429:	50                   	push   %eax
8010642a:	ff 75 f4             	pushl  -0xc(%ebp)
8010642d:	e8 5a be ff ff       	call   8010228c <dirlink>
80106432:	83 c4 10             	add    $0x10,%esp
80106435:	85 c0                	test   %eax,%eax
80106437:	79 0d                	jns    80106446 <create+0x1bf>
    panic("create: dirlink");
80106439:	83 ec 0c             	sub    $0xc,%esp
8010643c:	68 e9 8f 10 80       	push   $0x80108fe9
80106441:	e8 20 a1 ff ff       	call   80100566 <panic>

  iunlockput(dp);
80106446:	83 ec 0c             	sub    $0xc,%esp
80106449:	ff 75 f4             	pushl  -0xc(%ebp)
8010644c:	e8 d9 b7 ff ff       	call   80101c2a <iunlockput>
80106451:	83 c4 10             	add    $0x10,%esp

  return ip;
80106454:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80106457:	c9                   	leave  
80106458:	c3                   	ret    

80106459 <sys_open>:

int
sys_open(void)
{
80106459:	55                   	push   %ebp
8010645a:	89 e5                	mov    %esp,%ebp
8010645c:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010645f:	83 ec 08             	sub    $0x8,%esp
80106462:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106465:	50                   	push   %eax
80106466:	6a 00                	push   $0x0
80106468:	e8 eb f6 ff ff       	call   80105b58 <argstr>
8010646d:	83 c4 10             	add    $0x10,%esp
80106470:	85 c0                	test   %eax,%eax
80106472:	78 15                	js     80106489 <sys_open+0x30>
80106474:	83 ec 08             	sub    $0x8,%esp
80106477:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010647a:	50                   	push   %eax
8010647b:	6a 01                	push   $0x1
8010647d:	e8 51 f6 ff ff       	call   80105ad3 <argint>
80106482:	83 c4 10             	add    $0x10,%esp
80106485:	85 c0                	test   %eax,%eax
80106487:	79 0a                	jns    80106493 <sys_open+0x3a>
    return -1;
80106489:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010648e:	e9 61 01 00 00       	jmp    801065f4 <sys_open+0x19b>

  begin_op();
80106493:	e8 b5 d0 ff ff       	call   8010354d <begin_op>

  if(omode & O_CREATE){
80106498:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010649b:	25 00 02 00 00       	and    $0x200,%eax
801064a0:	85 c0                	test   %eax,%eax
801064a2:	74 2a                	je     801064ce <sys_open+0x75>
    ip = create(path, T_FILE, 0, 0);
801064a4:	8b 45 e8             	mov    -0x18(%ebp),%eax
801064a7:	6a 00                	push   $0x0
801064a9:	6a 00                	push   $0x0
801064ab:	6a 02                	push   $0x2
801064ad:	50                   	push   %eax
801064ae:	e8 d4 fd ff ff       	call   80106287 <create>
801064b3:	83 c4 10             	add    $0x10,%esp
801064b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ip == 0){
801064b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801064bd:	75 75                	jne    80106534 <sys_open+0xdb>
      end_op();
801064bf:	e8 15 d1 ff ff       	call   801035d9 <end_op>
      return -1;
801064c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064c9:	e9 26 01 00 00       	jmp    801065f4 <sys_open+0x19b>
    }
  } else {
    if((ip = namei(path)) == 0){
801064ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
801064d1:	83 ec 0c             	sub    $0xc,%esp
801064d4:	50                   	push   %eax
801064d5:	e8 4e c0 ff ff       	call   80102528 <namei>
801064da:	83 c4 10             	add    $0x10,%esp
801064dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
801064e0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801064e4:	75 0f                	jne    801064f5 <sys_open+0x9c>
      end_op();
801064e6:	e8 ee d0 ff ff       	call   801035d9 <end_op>
      return -1;
801064eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064f0:	e9 ff 00 00 00       	jmp    801065f4 <sys_open+0x19b>
    }
    ilock(ip);
801064f5:	83 ec 0c             	sub    $0xc,%esp
801064f8:	ff 75 f4             	pushl  -0xc(%ebp)
801064fb:	e8 6a b4 ff ff       	call   8010196a <ilock>
80106500:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
80106503:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106506:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010650a:	66 83 f8 01          	cmp    $0x1,%ax
8010650e:	75 24                	jne    80106534 <sys_open+0xdb>
80106510:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106513:	85 c0                	test   %eax,%eax
80106515:	74 1d                	je     80106534 <sys_open+0xdb>
      iunlockput(ip);
80106517:	83 ec 0c             	sub    $0xc,%esp
8010651a:	ff 75 f4             	pushl  -0xc(%ebp)
8010651d:	e8 08 b7 ff ff       	call   80101c2a <iunlockput>
80106522:	83 c4 10             	add    $0x10,%esp
      end_op();
80106525:	e8 af d0 ff ff       	call   801035d9 <end_op>
      return -1;
8010652a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010652f:	e9 c0 00 00 00       	jmp    801065f4 <sys_open+0x19b>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106534:	e8 5a aa ff ff       	call   80100f93 <filealloc>
80106539:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010653c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106540:	74 17                	je     80106559 <sys_open+0x100>
80106542:	83 ec 0c             	sub    $0xc,%esp
80106545:	ff 75 f0             	pushl  -0x10(%ebp)
80106548:	e8 37 f7 ff ff       	call   80105c84 <fdalloc>
8010654d:	83 c4 10             	add    $0x10,%esp
80106550:	89 45 ec             	mov    %eax,-0x14(%ebp)
80106553:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80106557:	79 2e                	jns    80106587 <sys_open+0x12e>
    if(f)
80106559:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010655d:	74 0e                	je     8010656d <sys_open+0x114>
      fileclose(f);
8010655f:	83 ec 0c             	sub    $0xc,%esp
80106562:	ff 75 f0             	pushl  -0x10(%ebp)
80106565:	e8 e7 aa ff ff       	call   80101051 <fileclose>
8010656a:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010656d:	83 ec 0c             	sub    $0xc,%esp
80106570:	ff 75 f4             	pushl  -0xc(%ebp)
80106573:	e8 b2 b6 ff ff       	call   80101c2a <iunlockput>
80106578:	83 c4 10             	add    $0x10,%esp
    end_op();
8010657b:	e8 59 d0 ff ff       	call   801035d9 <end_op>
    return -1;
80106580:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106585:	eb 6d                	jmp    801065f4 <sys_open+0x19b>
  }
  iunlock(ip);
80106587:	83 ec 0c             	sub    $0xc,%esp
8010658a:	ff 75 f4             	pushl  -0xc(%ebp)
8010658d:	e8 36 b5 ff ff       	call   80101ac8 <iunlock>
80106592:	83 c4 10             	add    $0x10,%esp
  end_op();
80106595:	e8 3f d0 ff ff       	call   801035d9 <end_op>

  f->type = FD_INODE;
8010659a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010659d:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
801065a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065a6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801065a9:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
801065ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065af:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
801065b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801065b9:	83 e0 01             	and    $0x1,%eax
801065bc:	85 c0                	test   %eax,%eax
801065be:	0f 94 c0             	sete   %al
801065c1:	89 c2                	mov    %eax,%edx
801065c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065c6:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801065c9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801065cc:	83 e0 01             	and    $0x1,%eax
801065cf:	85 c0                	test   %eax,%eax
801065d1:	75 0a                	jne    801065dd <sys_open+0x184>
801065d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801065d6:	83 e0 02             	and    $0x2,%eax
801065d9:	85 c0                	test   %eax,%eax
801065db:	74 07                	je     801065e4 <sys_open+0x18b>
801065dd:	b8 01 00 00 00       	mov    $0x1,%eax
801065e2:	eb 05                	jmp    801065e9 <sys_open+0x190>
801065e4:	b8 00 00 00 00       	mov    $0x0,%eax
801065e9:	89 c2                	mov    %eax,%edx
801065eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065ee:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
801065f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
801065f4:	c9                   	leave  
801065f5:	c3                   	ret    

801065f6 <sys_mkdir>:

int
sys_mkdir(void)
{
801065f6:	55                   	push   %ebp
801065f7:	89 e5                	mov    %esp,%ebp
801065f9:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801065fc:	e8 4c cf ff ff       	call   8010354d <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80106601:	83 ec 08             	sub    $0x8,%esp
80106604:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106607:	50                   	push   %eax
80106608:	6a 00                	push   $0x0
8010660a:	e8 49 f5 ff ff       	call   80105b58 <argstr>
8010660f:	83 c4 10             	add    $0x10,%esp
80106612:	85 c0                	test   %eax,%eax
80106614:	78 1b                	js     80106631 <sys_mkdir+0x3b>
80106616:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106619:	6a 00                	push   $0x0
8010661b:	6a 00                	push   $0x0
8010661d:	6a 01                	push   $0x1
8010661f:	50                   	push   %eax
80106620:	e8 62 fc ff ff       	call   80106287 <create>
80106625:	83 c4 10             	add    $0x10,%esp
80106628:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010662b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010662f:	75 0c                	jne    8010663d <sys_mkdir+0x47>
    end_op();
80106631:	e8 a3 cf ff ff       	call   801035d9 <end_op>
    return -1;
80106636:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010663b:	eb 18                	jmp    80106655 <sys_mkdir+0x5f>
  }
  iunlockput(ip);
8010663d:	83 ec 0c             	sub    $0xc,%esp
80106640:	ff 75 f4             	pushl  -0xc(%ebp)
80106643:	e8 e2 b5 ff ff       	call   80101c2a <iunlockput>
80106648:	83 c4 10             	add    $0x10,%esp
  end_op();
8010664b:	e8 89 cf ff ff       	call   801035d9 <end_op>
  return 0;
80106650:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106655:	c9                   	leave  
80106656:	c3                   	ret    

80106657 <sys_mknod>:

int
sys_mknod(void)
{
80106657:	55                   	push   %ebp
80106658:	89 e5                	mov    %esp,%ebp
8010665a:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_op();
8010665d:	e8 eb ce ff ff       	call   8010354d <begin_op>
  if((len=argstr(0, &path)) < 0 ||
80106662:	83 ec 08             	sub    $0x8,%esp
80106665:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106668:	50                   	push   %eax
80106669:	6a 00                	push   $0x0
8010666b:	e8 e8 f4 ff ff       	call   80105b58 <argstr>
80106670:	83 c4 10             	add    $0x10,%esp
80106673:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106676:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010667a:	78 4f                	js     801066cb <sys_mknod+0x74>
     argint(1, &major) < 0 ||
8010667c:	83 ec 08             	sub    $0x8,%esp
8010667f:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106682:	50                   	push   %eax
80106683:	6a 01                	push   $0x1
80106685:	e8 49 f4 ff ff       	call   80105ad3 <argint>
8010668a:	83 c4 10             	add    $0x10,%esp
  char *path;
  int len;
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
8010668d:	85 c0                	test   %eax,%eax
8010668f:	78 3a                	js     801066cb <sys_mknod+0x74>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80106691:	83 ec 08             	sub    $0x8,%esp
80106694:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106697:	50                   	push   %eax
80106698:	6a 02                	push   $0x2
8010669a:	e8 34 f4 ff ff       	call   80105ad3 <argint>
8010669f:	83 c4 10             	add    $0x10,%esp
  int len;
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
801066a2:	85 c0                	test   %eax,%eax
801066a4:	78 25                	js     801066cb <sys_mknod+0x74>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
801066a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801066a9:	0f bf c8             	movswl %ax,%ecx
801066ac:	8b 45 e8             	mov    -0x18(%ebp),%eax
801066af:	0f bf d0             	movswl %ax,%edx
801066b2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801066b5:	51                   	push   %ecx
801066b6:	52                   	push   %edx
801066b7:	6a 03                	push   $0x3
801066b9:	50                   	push   %eax
801066ba:	e8 c8 fb ff ff       	call   80106287 <create>
801066bf:	83 c4 10             	add    $0x10,%esp
801066c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
801066c5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801066c9:	75 0c                	jne    801066d7 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
801066cb:	e8 09 cf ff ff       	call   801035d9 <end_op>
    return -1;
801066d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801066d5:	eb 18                	jmp    801066ef <sys_mknod+0x98>
  }
  iunlockput(ip);
801066d7:	83 ec 0c             	sub    $0xc,%esp
801066da:	ff 75 f0             	pushl  -0x10(%ebp)
801066dd:	e8 48 b5 ff ff       	call   80101c2a <iunlockput>
801066e2:	83 c4 10             	add    $0x10,%esp
  end_op();
801066e5:	e8 ef ce ff ff       	call   801035d9 <end_op>
  return 0;
801066ea:	b8 00 00 00 00       	mov    $0x0,%eax
}
801066ef:	c9                   	leave  
801066f0:	c3                   	ret    

801066f1 <sys_chdir>:

int
sys_chdir(void)
{
801066f1:	55                   	push   %ebp
801066f2:	89 e5                	mov    %esp,%ebp
801066f4:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801066f7:	e8 51 ce ff ff       	call   8010354d <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801066fc:	83 ec 08             	sub    $0x8,%esp
801066ff:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106702:	50                   	push   %eax
80106703:	6a 00                	push   $0x0
80106705:	e8 4e f4 ff ff       	call   80105b58 <argstr>
8010670a:	83 c4 10             	add    $0x10,%esp
8010670d:	85 c0                	test   %eax,%eax
8010670f:	78 18                	js     80106729 <sys_chdir+0x38>
80106711:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106714:	83 ec 0c             	sub    $0xc,%esp
80106717:	50                   	push   %eax
80106718:	e8 0b be ff ff       	call   80102528 <namei>
8010671d:	83 c4 10             	add    $0x10,%esp
80106720:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106723:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106727:	75 0c                	jne    80106735 <sys_chdir+0x44>
    end_op();
80106729:	e8 ab ce ff ff       	call   801035d9 <end_op>
    return -1;
8010672e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106733:	eb 6e                	jmp    801067a3 <sys_chdir+0xb2>
  }
  ilock(ip);
80106735:	83 ec 0c             	sub    $0xc,%esp
80106738:	ff 75 f4             	pushl  -0xc(%ebp)
8010673b:	e8 2a b2 ff ff       	call   8010196a <ilock>
80106740:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
80106743:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106746:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010674a:	66 83 f8 01          	cmp    $0x1,%ax
8010674e:	74 1a                	je     8010676a <sys_chdir+0x79>
    iunlockput(ip);
80106750:	83 ec 0c             	sub    $0xc,%esp
80106753:	ff 75 f4             	pushl  -0xc(%ebp)
80106756:	e8 cf b4 ff ff       	call   80101c2a <iunlockput>
8010675b:	83 c4 10             	add    $0x10,%esp
    end_op();
8010675e:	e8 76 ce ff ff       	call   801035d9 <end_op>
    return -1;
80106763:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106768:	eb 39                	jmp    801067a3 <sys_chdir+0xb2>
  }
  iunlock(ip);
8010676a:	83 ec 0c             	sub    $0xc,%esp
8010676d:	ff 75 f4             	pushl  -0xc(%ebp)
80106770:	e8 53 b3 ff ff       	call   80101ac8 <iunlock>
80106775:	83 c4 10             	add    $0x10,%esp
  iput(proc->cwd);
80106778:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010677e:	8b 40 68             	mov    0x68(%eax),%eax
80106781:	83 ec 0c             	sub    $0xc,%esp
80106784:	50                   	push   %eax
80106785:	e8 b0 b3 ff ff       	call   80101b3a <iput>
8010678a:	83 c4 10             	add    $0x10,%esp
  end_op();
8010678d:	e8 47 ce ff ff       	call   801035d9 <end_op>
  proc->cwd = ip;
80106792:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106798:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010679b:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
8010679e:	b8 00 00 00 00       	mov    $0x0,%eax
}
801067a3:	c9                   	leave  
801067a4:	c3                   	ret    

801067a5 <sys_exec>:

int
sys_exec(void)
{
801067a5:	55                   	push   %ebp
801067a6:	89 e5                	mov    %esp,%ebp
801067a8:	81 ec 98 00 00 00    	sub    $0x98,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801067ae:	83 ec 08             	sub    $0x8,%esp
801067b1:	8d 45 f0             	lea    -0x10(%ebp),%eax
801067b4:	50                   	push   %eax
801067b5:	6a 00                	push   $0x0
801067b7:	e8 9c f3 ff ff       	call   80105b58 <argstr>
801067bc:	83 c4 10             	add    $0x10,%esp
801067bf:	85 c0                	test   %eax,%eax
801067c1:	78 18                	js     801067db <sys_exec+0x36>
801067c3:	83 ec 08             	sub    $0x8,%esp
801067c6:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
801067cc:	50                   	push   %eax
801067cd:	6a 01                	push   $0x1
801067cf:	e8 ff f2 ff ff       	call   80105ad3 <argint>
801067d4:	83 c4 10             	add    $0x10,%esp
801067d7:	85 c0                	test   %eax,%eax
801067d9:	79 0a                	jns    801067e5 <sys_exec+0x40>
    return -1;
801067db:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801067e0:	e9 c6 00 00 00       	jmp    801068ab <sys_exec+0x106>
  }
  memset(argv, 0, sizeof(argv));
801067e5:	83 ec 04             	sub    $0x4,%esp
801067e8:	68 80 00 00 00       	push   $0x80
801067ed:	6a 00                	push   $0x0
801067ef:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
801067f5:	50                   	push   %eax
801067f6:	e8 b3 ef ff ff       	call   801057ae <memset>
801067fb:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
801067fe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
80106805:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106808:	83 f8 1f             	cmp    $0x1f,%eax
8010680b:	76 0a                	jbe    80106817 <sys_exec+0x72>
      return -1;
8010680d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106812:	e9 94 00 00 00       	jmp    801068ab <sys_exec+0x106>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106817:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010681a:	c1 e0 02             	shl    $0x2,%eax
8010681d:	89 c2                	mov    %eax,%edx
8010681f:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
80106825:	01 c2                	add    %eax,%edx
80106827:	83 ec 08             	sub    $0x8,%esp
8010682a:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106830:	50                   	push   %eax
80106831:	52                   	push   %edx
80106832:	e8 00 f2 ff ff       	call   80105a37 <fetchint>
80106837:	83 c4 10             	add    $0x10,%esp
8010683a:	85 c0                	test   %eax,%eax
8010683c:	79 07                	jns    80106845 <sys_exec+0xa0>
      return -1;
8010683e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106843:	eb 66                	jmp    801068ab <sys_exec+0x106>
    if(uarg == 0){
80106845:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
8010684b:	85 c0                	test   %eax,%eax
8010684d:	75 27                	jne    80106876 <sys_exec+0xd1>
      argv[i] = 0;
8010684f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106852:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
80106859:	00 00 00 00 
      break;
8010685d:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
8010685e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106861:	83 ec 08             	sub    $0x8,%esp
80106864:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
8010686a:	52                   	push   %edx
8010686b:	50                   	push   %eax
8010686c:	e8 00 a3 ff ff       	call   80100b71 <exec>
80106871:	83 c4 10             	add    $0x10,%esp
80106874:	eb 35                	jmp    801068ab <sys_exec+0x106>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106876:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
8010687c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010687f:	c1 e2 02             	shl    $0x2,%edx
80106882:	01 c2                	add    %eax,%edx
80106884:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
8010688a:	83 ec 08             	sub    $0x8,%esp
8010688d:	52                   	push   %edx
8010688e:	50                   	push   %eax
8010688f:	e8 dd f1 ff ff       	call   80105a71 <fetchstr>
80106894:	83 c4 10             	add    $0x10,%esp
80106897:	85 c0                	test   %eax,%eax
80106899:	79 07                	jns    801068a2 <sys_exec+0xfd>
      return -1;
8010689b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801068a0:	eb 09                	jmp    801068ab <sys_exec+0x106>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
801068a2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
801068a6:	e9 5a ff ff ff       	jmp    80106805 <sys_exec+0x60>
  return exec(path, argv);
}
801068ab:	c9                   	leave  
801068ac:	c3                   	ret    

801068ad <sys_pipe>:

int
sys_pipe(void)
{
801068ad:	55                   	push   %ebp
801068ae:	89 e5                	mov    %esp,%ebp
801068b0:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801068b3:	83 ec 04             	sub    $0x4,%esp
801068b6:	6a 08                	push   $0x8
801068b8:	8d 45 ec             	lea    -0x14(%ebp),%eax
801068bb:	50                   	push   %eax
801068bc:	6a 00                	push   $0x0
801068be:	e8 38 f2 ff ff       	call   80105afb <argptr>
801068c3:	83 c4 10             	add    $0x10,%esp
801068c6:	85 c0                	test   %eax,%eax
801068c8:	79 0a                	jns    801068d4 <sys_pipe+0x27>
    return -1;
801068ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801068cf:	e9 af 00 00 00       	jmp    80106983 <sys_pipe+0xd6>
  if(pipealloc(&rf, &wf) < 0)
801068d4:	83 ec 08             	sub    $0x8,%esp
801068d7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801068da:	50                   	push   %eax
801068db:	8d 45 e8             	lea    -0x18(%ebp),%eax
801068de:	50                   	push   %eax
801068df:	e8 5d d7 ff ff       	call   80104041 <pipealloc>
801068e4:	83 c4 10             	add    $0x10,%esp
801068e7:	85 c0                	test   %eax,%eax
801068e9:	79 0a                	jns    801068f5 <sys_pipe+0x48>
    return -1;
801068eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801068f0:	e9 8e 00 00 00       	jmp    80106983 <sys_pipe+0xd6>
  fd0 = -1;
801068f5:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801068fc:	8b 45 e8             	mov    -0x18(%ebp),%eax
801068ff:	83 ec 0c             	sub    $0xc,%esp
80106902:	50                   	push   %eax
80106903:	e8 7c f3 ff ff       	call   80105c84 <fdalloc>
80106908:	83 c4 10             	add    $0x10,%esp
8010690b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010690e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106912:	78 18                	js     8010692c <sys_pipe+0x7f>
80106914:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106917:	83 ec 0c             	sub    $0xc,%esp
8010691a:	50                   	push   %eax
8010691b:	e8 64 f3 ff ff       	call   80105c84 <fdalloc>
80106920:	83 c4 10             	add    $0x10,%esp
80106923:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106926:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010692a:	79 3f                	jns    8010696b <sys_pipe+0xbe>
    if(fd0 >= 0)
8010692c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106930:	78 14                	js     80106946 <sys_pipe+0x99>
      proc->ofile[fd0] = 0;
80106932:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106938:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010693b:	83 c2 08             	add    $0x8,%edx
8010693e:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80106945:	00 
    fileclose(rf);
80106946:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106949:	83 ec 0c             	sub    $0xc,%esp
8010694c:	50                   	push   %eax
8010694d:	e8 ff a6 ff ff       	call   80101051 <fileclose>
80106952:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
80106955:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106958:	83 ec 0c             	sub    $0xc,%esp
8010695b:	50                   	push   %eax
8010695c:	e8 f0 a6 ff ff       	call   80101051 <fileclose>
80106961:	83 c4 10             	add    $0x10,%esp
    return -1;
80106964:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106969:	eb 18                	jmp    80106983 <sys_pipe+0xd6>
  }
  fd[0] = fd0;
8010696b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010696e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106971:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
80106973:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106976:	8d 50 04             	lea    0x4(%eax),%edx
80106979:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010697c:	89 02                	mov    %eax,(%edx)
  return 0;
8010697e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106983:	c9                   	leave  
80106984:	c3                   	ret    

80106985 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106985:	55                   	push   %ebp
80106986:	89 e5                	mov    %esp,%ebp
80106988:	83 ec 08             	sub    $0x8,%esp
  return fork();
8010698b:	e8 e4 dd ff ff       	call   80104774 <fork>
}
80106990:	c9                   	leave  
80106991:	c3                   	ret    

80106992 <sys_exit>:

int
sys_exit(void)
{
80106992:	55                   	push   %ebp
80106993:	89 e5                	mov    %esp,%ebp
80106995:	83 ec 08             	sub    $0x8,%esp
  exit();
80106998:	e8 68 df ff ff       	call   80104905 <exit>
  return 0;  // not reached
8010699d:	b8 00 00 00 00       	mov    $0x0,%eax
}
801069a2:	c9                   	leave  
801069a3:	c3                   	ret    

801069a4 <sys_wait>:

int
sys_wait(void)
{
801069a4:	55                   	push   %ebp
801069a5:	89 e5                	mov    %esp,%ebp
801069a7:	83 ec 08             	sub    $0x8,%esp
  return wait();
801069aa:	e8 91 e0 ff ff       	call   80104a40 <wait>
}
801069af:	c9                   	leave  
801069b0:	c3                   	ret    

801069b1 <sys_kill>:

int
sys_kill(void)
{
801069b1:	55                   	push   %ebp
801069b2:	89 e5                	mov    %esp,%ebp
801069b4:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
801069b7:	83 ec 08             	sub    $0x8,%esp
801069ba:	8d 45 f4             	lea    -0xc(%ebp),%eax
801069bd:	50                   	push   %eax
801069be:	6a 00                	push   $0x0
801069c0:	e8 0e f1 ff ff       	call   80105ad3 <argint>
801069c5:	83 c4 10             	add    $0x10,%esp
801069c8:	85 c0                	test   %eax,%eax
801069ca:	79 07                	jns    801069d3 <sys_kill+0x22>
    return -1;
801069cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801069d1:	eb 0f                	jmp    801069e2 <sys_kill+0x31>
  return kill(pid);
801069d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069d6:	83 ec 0c             	sub    $0xc,%esp
801069d9:	50                   	push   %eax
801069da:	e8 6d e5 ff ff       	call   80104f4c <kill>
801069df:	83 c4 10             	add    $0x10,%esp
}
801069e2:	c9                   	leave  
801069e3:	c3                   	ret    

801069e4 <sys_getpid>:

int
sys_getpid(void)
{
801069e4:	55                   	push   %ebp
801069e5:	89 e5                	mov    %esp,%ebp
  return proc->pid;
801069e7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801069ed:	8b 40 10             	mov    0x10(%eax),%eax
}
801069f0:	5d                   	pop    %ebp
801069f1:	c3                   	ret    

801069f2 <sys_sbrk>:

int
sys_sbrk(void)
{
801069f2:	55                   	push   %ebp
801069f3:	89 e5                	mov    %esp,%ebp
801069f5:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801069f8:	83 ec 08             	sub    $0x8,%esp
801069fb:	8d 45 f0             	lea    -0x10(%ebp),%eax
801069fe:	50                   	push   %eax
801069ff:	6a 00                	push   $0x0
80106a01:	e8 cd f0 ff ff       	call   80105ad3 <argint>
80106a06:	83 c4 10             	add    $0x10,%esp
80106a09:	85 c0                	test   %eax,%eax
80106a0b:	79 07                	jns    80106a14 <sys_sbrk+0x22>
    return -1;
80106a0d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a12:	eb 28                	jmp    80106a3c <sys_sbrk+0x4a>
  addr = proc->sz;
80106a14:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a1a:	8b 00                	mov    (%eax),%eax
80106a1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
80106a1f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106a22:	83 ec 0c             	sub    $0xc,%esp
80106a25:	50                   	push   %eax
80106a26:	e8 a6 dc ff ff       	call   801046d1 <growproc>
80106a2b:	83 c4 10             	add    $0x10,%esp
80106a2e:	85 c0                	test   %eax,%eax
80106a30:	79 07                	jns    80106a39 <sys_sbrk+0x47>
    return -1;
80106a32:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a37:	eb 03                	jmp    80106a3c <sys_sbrk+0x4a>
  return addr;
80106a39:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106a3c:	c9                   	leave  
80106a3d:	c3                   	ret    

80106a3e <sys_sleep>:

int
sys_sleep(void)
{
80106a3e:	55                   	push   %ebp
80106a3f:	89 e5                	mov    %esp,%ebp
80106a41:	83 ec 18             	sub    $0x18,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
80106a44:	83 ec 08             	sub    $0x8,%esp
80106a47:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106a4a:	50                   	push   %eax
80106a4b:	6a 00                	push   $0x0
80106a4d:	e8 81 f0 ff ff       	call   80105ad3 <argint>
80106a52:	83 c4 10             	add    $0x10,%esp
80106a55:	85 c0                	test   %eax,%eax
80106a57:	79 07                	jns    80106a60 <sys_sleep+0x22>
    return -1;
80106a59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a5e:	eb 77                	jmp    80106ad7 <sys_sleep+0x99>
  acquire(&tickslock);
80106a60:	83 ec 0c             	sub    $0xc,%esp
80106a63:	68 e0 5f 11 80       	push   $0x80115fe0
80106a68:	e8 de ea ff ff       	call   8010554b <acquire>
80106a6d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80106a70:	a1 20 68 11 80       	mov    0x80116820,%eax
80106a75:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
80106a78:	eb 39                	jmp    80106ab3 <sys_sleep+0x75>
    if(proc->killed){
80106a7a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a80:	8b 40 24             	mov    0x24(%eax),%eax
80106a83:	85 c0                	test   %eax,%eax
80106a85:	74 17                	je     80106a9e <sys_sleep+0x60>
      release(&tickslock);
80106a87:	83 ec 0c             	sub    $0xc,%esp
80106a8a:	68 e0 5f 11 80       	push   $0x80115fe0
80106a8f:	e8 1e eb ff ff       	call   801055b2 <release>
80106a94:	83 c4 10             	add    $0x10,%esp
      return -1;
80106a97:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a9c:	eb 39                	jmp    80106ad7 <sys_sleep+0x99>
    }
    sleep(&ticks, &tickslock);
80106a9e:	83 ec 08             	sub    $0x8,%esp
80106aa1:	68 e0 5f 11 80       	push   $0x80115fe0
80106aa6:	68 20 68 11 80       	push   $0x80116820
80106aab:	e8 77 e3 ff ff       	call   80104e27 <sleep>
80106ab0:	83 c4 10             	add    $0x10,%esp
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106ab3:	a1 20 68 11 80       	mov    0x80116820,%eax
80106ab8:	2b 45 f4             	sub    -0xc(%ebp),%eax
80106abb:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106abe:	39 d0                	cmp    %edx,%eax
80106ac0:	72 b8                	jb     80106a7a <sys_sleep+0x3c>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80106ac2:	83 ec 0c             	sub    $0xc,%esp
80106ac5:	68 e0 5f 11 80       	push   $0x80115fe0
80106aca:	e8 e3 ea ff ff       	call   801055b2 <release>
80106acf:	83 c4 10             	add    $0x10,%esp
  return 0;
80106ad2:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106ad7:	c9                   	leave  
80106ad8:	c3                   	ret    

80106ad9 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106ad9:	55                   	push   %ebp
80106ada:	89 e5                	mov    %esp,%ebp
80106adc:	83 ec 18             	sub    $0x18,%esp
  uint xticks;
  
  acquire(&tickslock);
80106adf:	83 ec 0c             	sub    $0xc,%esp
80106ae2:	68 e0 5f 11 80       	push   $0x80115fe0
80106ae7:	e8 5f ea ff ff       	call   8010554b <acquire>
80106aec:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
80106aef:	a1 20 68 11 80       	mov    0x80116820,%eax
80106af4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
80106af7:	83 ec 0c             	sub    $0xc,%esp
80106afa:	68 e0 5f 11 80       	push   $0x80115fe0
80106aff:	e8 ae ea ff ff       	call   801055b2 <release>
80106b04:	83 c4 10             	add    $0x10,%esp
  return xticks;
80106b07:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106b0a:	c9                   	leave  
80106b0b:	c3                   	ret    

80106b0c <sys_wait_stat>:

int
sys_wait_stat(void)
{
80106b0c:	55                   	push   %ebp
80106b0d:	89 e5                	mov    %esp,%ebp
80106b0f:	53                   	push   %ebx
80106b10:	83 ec 14             	sub    $0x14,%esp
  int *wtime;
  int *iotime;
  int *rtime;
  int *status;

  if (argptr(0,(char **) &wtime, sizeof(wtime)) < 0)
80106b13:	83 ec 04             	sub    $0x4,%esp
80106b16:	6a 04                	push   $0x4
80106b18:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106b1b:	50                   	push   %eax
80106b1c:	6a 00                	push   $0x0
80106b1e:	e8 d8 ef ff ff       	call   80105afb <argptr>
80106b23:	83 c4 10             	add    $0x10,%esp
80106b26:	85 c0                	test   %eax,%eax
80106b28:	79 07                	jns    80106b31 <sys_wait_stat+0x25>
    return -1;
80106b2a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b2f:	eb 72                	jmp    80106ba3 <sys_wait_stat+0x97>
  if (argptr(1,(char **) &rtime, sizeof(rtime)) < 0)
80106b31:	83 ec 04             	sub    $0x4,%esp
80106b34:	6a 04                	push   $0x4
80106b36:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106b39:	50                   	push   %eax
80106b3a:	6a 01                	push   $0x1
80106b3c:	e8 ba ef ff ff       	call   80105afb <argptr>
80106b41:	83 c4 10             	add    $0x10,%esp
80106b44:	85 c0                	test   %eax,%eax
80106b46:	79 07                	jns    80106b4f <sys_wait_stat+0x43>
    return -1;
80106b48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b4d:	eb 54                	jmp    80106ba3 <sys_wait_stat+0x97>
  if (argptr(2,(char **) &iotime, sizeof(iotime)) < 0)
80106b4f:	83 ec 04             	sub    $0x4,%esp
80106b52:	6a 04                	push   $0x4
80106b54:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106b57:	50                   	push   %eax
80106b58:	6a 02                	push   $0x2
80106b5a:	e8 9c ef ff ff       	call   80105afb <argptr>
80106b5f:	83 c4 10             	add    $0x10,%esp
80106b62:	85 c0                	test   %eax,%eax
80106b64:	79 07                	jns    80106b6d <sys_wait_stat+0x61>
    return -1;
80106b66:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b6b:	eb 36                	jmp    80106ba3 <sys_wait_stat+0x97>
  if (argptr(3,(char **) &status, sizeof(status)) < 0)
80106b6d:	83 ec 04             	sub    $0x4,%esp
80106b70:	6a 04                	push   $0x4
80106b72:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106b75:	50                   	push   %eax
80106b76:	6a 03                	push   $0x3
80106b78:	e8 7e ef ff ff       	call   80105afb <argptr>
80106b7d:	83 c4 10             	add    $0x10,%esp
80106b80:	85 c0                	test   %eax,%eax
80106b82:	79 07                	jns    80106b8b <sys_wait_stat+0x7f>
    return -1;
80106b84:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b89:	eb 18                	jmp    80106ba3 <sys_wait_stat+0x97>

  return wait_stat(wtime,rtime,iotime,status);
80106b8b:	8b 5d e8             	mov    -0x18(%ebp),%ebx
80106b8e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80106b91:	8b 55 ec             	mov    -0x14(%ebp),%edx
80106b94:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b97:	53                   	push   %ebx
80106b98:	51                   	push   %ecx
80106b99:	52                   	push   %edx
80106b9a:	50                   	push   %eax
80106b9b:	e8 c7 df ff ff       	call   80104b67 <wait_stat>
80106ba0:	83 c4 10             	add    $0x10,%esp
}
80106ba3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106ba6:	c9                   	leave  
80106ba7:	c3                   	ret    

80106ba8 <sys_yield>:

int sys_yield(void) {
80106ba8:	55                   	push   %ebp
80106ba9:	89 e5                	mov    %esp,%ebp
80106bab:	83 ec 08             	sub    $0x8,%esp
  yield();
80106bae:	e8 e1 e1 ff ff       	call   80104d94 <yield>
  return 0;
80106bb3:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106bb8:	c9                   	leave  
80106bb9:	c3                   	ret    

80106bba <outb>:
80106bba:	55                   	push   %ebp
80106bbb:	89 e5                	mov    %esp,%ebp
80106bbd:	83 ec 08             	sub    $0x8,%esp
80106bc0:	8b 55 08             	mov    0x8(%ebp),%edx
80106bc3:	8b 45 0c             	mov    0xc(%ebp),%eax
80106bc6:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106bca:	88 45 f8             	mov    %al,-0x8(%ebp)
80106bcd:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106bd1:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106bd5:	ee                   	out    %al,(%dx)
80106bd6:	90                   	nop
80106bd7:	c9                   	leave  
80106bd8:	c3                   	ret    

80106bd9 <timerinit>:
80106bd9:	55                   	push   %ebp
80106bda:	89 e5                	mov    %esp,%ebp
80106bdc:	83 ec 08             	sub    $0x8,%esp
80106bdf:	6a 34                	push   $0x34
80106be1:	6a 43                	push   $0x43
80106be3:	e8 d2 ff ff ff       	call   80106bba <outb>
80106be8:	83 c4 08             	add    $0x8,%esp
80106beb:	68 9c 00 00 00       	push   $0x9c
80106bf0:	6a 40                	push   $0x40
80106bf2:	e8 c3 ff ff ff       	call   80106bba <outb>
80106bf7:	83 c4 08             	add    $0x8,%esp
80106bfa:	6a 2e                	push   $0x2e
80106bfc:	6a 40                	push   $0x40
80106bfe:	e8 b7 ff ff ff       	call   80106bba <outb>
80106c03:	83 c4 08             	add    $0x8,%esp
80106c06:	83 ec 0c             	sub    $0xc,%esp
80106c09:	6a 00                	push   $0x0
80106c0b:	e8 1b d3 ff ff       	call   80103f2b <picenable>
80106c10:	83 c4 10             	add    $0x10,%esp
80106c13:	90                   	nop
80106c14:	c9                   	leave  
80106c15:	c3                   	ret    

80106c16 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106c16:	1e                   	push   %ds
  pushl %es
80106c17:	06                   	push   %es
  pushl %fs
80106c18:	0f a0                	push   %fs
  pushl %gs
80106c1a:	0f a8                	push   %gs
  pushal
80106c1c:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80106c1d:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106c21:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106c23:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
80106c25:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
80106c29:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80106c2b:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
80106c2d:	54                   	push   %esp
  call trap
80106c2e:	e8 d7 01 00 00       	call   80106e0a <trap>
  addl $4, %esp
80106c33:	83 c4 04             	add    $0x4,%esp

80106c36 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106c36:	61                   	popa   
  popl %gs
80106c37:	0f a9                	pop    %gs
  popl %fs
80106c39:	0f a1                	pop    %fs
  popl %es
80106c3b:	07                   	pop    %es
  popl %ds
80106c3c:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106c3d:	83 c4 08             	add    $0x8,%esp
  iret
80106c40:	cf                   	iret   

80106c41 <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
80106c41:	55                   	push   %ebp
80106c42:	89 e5                	mov    %esp,%ebp
80106c44:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80106c47:	8b 45 0c             	mov    0xc(%ebp),%eax
80106c4a:	83 e8 01             	sub    $0x1,%eax
80106c4d:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106c51:	8b 45 08             	mov    0x8(%ebp),%eax
80106c54:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106c58:	8b 45 08             	mov    0x8(%ebp),%eax
80106c5b:	c1 e8 10             	shr    $0x10,%eax
80106c5e:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80106c62:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106c65:	0f 01 18             	lidtl  (%eax)
}
80106c68:	90                   	nop
80106c69:	c9                   	leave  
80106c6a:	c3                   	ret    

80106c6b <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
80106c6b:	55                   	push   %ebp
80106c6c:	89 e5                	mov    %esp,%ebp
80106c6e:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106c71:	0f 20 d0             	mov    %cr2,%eax
80106c74:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
80106c77:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106c7a:	c9                   	leave  
80106c7b:	c3                   	ret    

80106c7c <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106c7c:	55                   	push   %ebp
80106c7d:	89 e5                	mov    %esp,%ebp
80106c7f:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
80106c82:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106c89:	e9 c3 00 00 00       	jmp    80106d51 <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106c8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106c91:	8b 04 85 a0 c0 10 80 	mov    -0x7fef3f60(,%eax,4),%eax
80106c98:	89 c2                	mov    %eax,%edx
80106c9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106c9d:	66 89 14 c5 20 60 11 	mov    %dx,-0x7fee9fe0(,%eax,8)
80106ca4:	80 
80106ca5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ca8:	66 c7 04 c5 22 60 11 	movw   $0x8,-0x7fee9fde(,%eax,8)
80106caf:	80 08 00 
80106cb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106cb5:	0f b6 14 c5 24 60 11 	movzbl -0x7fee9fdc(,%eax,8),%edx
80106cbc:	80 
80106cbd:	83 e2 e0             	and    $0xffffffe0,%edx
80106cc0:	88 14 c5 24 60 11 80 	mov    %dl,-0x7fee9fdc(,%eax,8)
80106cc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106cca:	0f b6 14 c5 24 60 11 	movzbl -0x7fee9fdc(,%eax,8),%edx
80106cd1:	80 
80106cd2:	83 e2 1f             	and    $0x1f,%edx
80106cd5:	88 14 c5 24 60 11 80 	mov    %dl,-0x7fee9fdc(,%eax,8)
80106cdc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106cdf:	0f b6 14 c5 25 60 11 	movzbl -0x7fee9fdb(,%eax,8),%edx
80106ce6:	80 
80106ce7:	83 e2 f0             	and    $0xfffffff0,%edx
80106cea:	83 ca 0e             	or     $0xe,%edx
80106ced:	88 14 c5 25 60 11 80 	mov    %dl,-0x7fee9fdb(,%eax,8)
80106cf4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106cf7:	0f b6 14 c5 25 60 11 	movzbl -0x7fee9fdb(,%eax,8),%edx
80106cfe:	80 
80106cff:	83 e2 ef             	and    $0xffffffef,%edx
80106d02:	88 14 c5 25 60 11 80 	mov    %dl,-0x7fee9fdb(,%eax,8)
80106d09:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d0c:	0f b6 14 c5 25 60 11 	movzbl -0x7fee9fdb(,%eax,8),%edx
80106d13:	80 
80106d14:	83 e2 9f             	and    $0xffffff9f,%edx
80106d17:	88 14 c5 25 60 11 80 	mov    %dl,-0x7fee9fdb(,%eax,8)
80106d1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d21:	0f b6 14 c5 25 60 11 	movzbl -0x7fee9fdb(,%eax,8),%edx
80106d28:	80 
80106d29:	83 ca 80             	or     $0xffffff80,%edx
80106d2c:	88 14 c5 25 60 11 80 	mov    %dl,-0x7fee9fdb(,%eax,8)
80106d33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d36:	8b 04 85 a0 c0 10 80 	mov    -0x7fef3f60(,%eax,4),%eax
80106d3d:	c1 e8 10             	shr    $0x10,%eax
80106d40:	89 c2                	mov    %eax,%edx
80106d42:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d45:	66 89 14 c5 26 60 11 	mov    %dx,-0x7fee9fda(,%eax,8)
80106d4c:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80106d4d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106d51:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
80106d58:	0f 8e 30 ff ff ff    	jle    80106c8e <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106d5e:	a1 a0 c1 10 80       	mov    0x8010c1a0,%eax
80106d63:	66 a3 20 62 11 80    	mov    %ax,0x80116220
80106d69:	66 c7 05 22 62 11 80 	movw   $0x8,0x80116222
80106d70:	08 00 
80106d72:	0f b6 05 24 62 11 80 	movzbl 0x80116224,%eax
80106d79:	83 e0 e0             	and    $0xffffffe0,%eax
80106d7c:	a2 24 62 11 80       	mov    %al,0x80116224
80106d81:	0f b6 05 24 62 11 80 	movzbl 0x80116224,%eax
80106d88:	83 e0 1f             	and    $0x1f,%eax
80106d8b:	a2 24 62 11 80       	mov    %al,0x80116224
80106d90:	0f b6 05 25 62 11 80 	movzbl 0x80116225,%eax
80106d97:	83 c8 0f             	or     $0xf,%eax
80106d9a:	a2 25 62 11 80       	mov    %al,0x80116225
80106d9f:	0f b6 05 25 62 11 80 	movzbl 0x80116225,%eax
80106da6:	83 e0 ef             	and    $0xffffffef,%eax
80106da9:	a2 25 62 11 80       	mov    %al,0x80116225
80106dae:	0f b6 05 25 62 11 80 	movzbl 0x80116225,%eax
80106db5:	83 c8 60             	or     $0x60,%eax
80106db8:	a2 25 62 11 80       	mov    %al,0x80116225
80106dbd:	0f b6 05 25 62 11 80 	movzbl 0x80116225,%eax
80106dc4:	83 c8 80             	or     $0xffffff80,%eax
80106dc7:	a2 25 62 11 80       	mov    %al,0x80116225
80106dcc:	a1 a0 c1 10 80       	mov    0x8010c1a0,%eax
80106dd1:	c1 e8 10             	shr    $0x10,%eax
80106dd4:	66 a3 26 62 11 80    	mov    %ax,0x80116226
  
  initlock(&tickslock, "time");
80106dda:	83 ec 08             	sub    $0x8,%esp
80106ddd:	68 fc 8f 10 80       	push   $0x80108ffc
80106de2:	68 e0 5f 11 80       	push   $0x80115fe0
80106de7:	e8 3d e7 ff ff       	call   80105529 <initlock>
80106dec:	83 c4 10             	add    $0x10,%esp
}
80106def:	90                   	nop
80106df0:	c9                   	leave  
80106df1:	c3                   	ret    

80106df2 <idtinit>:

void
idtinit(void)
{
80106df2:	55                   	push   %ebp
80106df3:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
80106df5:	68 00 08 00 00       	push   $0x800
80106dfa:	68 20 60 11 80       	push   $0x80116020
80106dff:	e8 3d fe ff ff       	call   80106c41 <lidt>
80106e04:	83 c4 08             	add    $0x8,%esp
}
80106e07:	90                   	nop
80106e08:	c9                   	leave  
80106e09:	c3                   	ret    

80106e0a <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106e0a:	55                   	push   %ebp
80106e0b:	89 e5                	mov    %esp,%ebp
80106e0d:	57                   	push   %edi
80106e0e:	56                   	push   %esi
80106e0f:	53                   	push   %ebx
80106e10:	83 ec 1c             	sub    $0x1c,%esp
  if(tf->trapno == T_SYSCALL){
80106e13:	8b 45 08             	mov    0x8(%ebp),%eax
80106e16:	8b 40 30             	mov    0x30(%eax),%eax
80106e19:	83 f8 40             	cmp    $0x40,%eax
80106e1c:	75 3e                	jne    80106e5c <trap+0x52>
    if(proc->killed)
80106e1e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106e24:	8b 40 24             	mov    0x24(%eax),%eax
80106e27:	85 c0                	test   %eax,%eax
80106e29:	74 05                	je     80106e30 <trap+0x26>
      exit();
80106e2b:	e8 d5 da ff ff       	call   80104905 <exit>
    proc->tf = tf;
80106e30:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106e36:	8b 55 08             	mov    0x8(%ebp),%edx
80106e39:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
80106e3c:	e8 48 ed ff ff       	call   80105b89 <syscall>
    if(proc->killed)
80106e41:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106e47:	8b 40 24             	mov    0x24(%eax),%eax
80106e4a:	85 c0                	test   %eax,%eax
80106e4c:	0f 84 1b 02 00 00    	je     8010706d <trap+0x263>
      exit();
80106e52:	e8 ae da ff ff       	call   80104905 <exit>
    return;
80106e57:	e9 11 02 00 00       	jmp    8010706d <trap+0x263>
  }

  switch(tf->trapno){
80106e5c:	8b 45 08             	mov    0x8(%ebp),%eax
80106e5f:	8b 40 30             	mov    0x30(%eax),%eax
80106e62:	83 e8 20             	sub    $0x20,%eax
80106e65:	83 f8 1f             	cmp    $0x1f,%eax
80106e68:	0f 87 c0 00 00 00    	ja     80106f2e <trap+0x124>
80106e6e:	8b 04 85 a4 90 10 80 	mov    -0x7fef6f5c(,%eax,4),%eax
80106e75:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
80106e77:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106e7d:	0f b6 00             	movzbl (%eax),%eax
80106e80:	84 c0                	test   %al,%al
80106e82:	75 3d                	jne    80106ec1 <trap+0xb7>
      acquire(&tickslock);
80106e84:	83 ec 0c             	sub    $0xc,%esp
80106e87:	68 e0 5f 11 80       	push   $0x80115fe0
80106e8c:	e8 ba e6 ff ff       	call   8010554b <acquire>
80106e91:	83 c4 10             	add    $0x10,%esp
      ticks++;
80106e94:	a1 20 68 11 80       	mov    0x80116820,%eax
80106e99:	83 c0 01             	add    $0x1,%eax
80106e9c:	a3 20 68 11 80       	mov    %eax,0x80116820
      wakeup(&ticks);
80106ea1:	83 ec 0c             	sub    $0xc,%esp
80106ea4:	68 20 68 11 80       	push   $0x80116820
80106ea9:	e8 67 e0 ff ff       	call   80104f15 <wakeup>
80106eae:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
80106eb1:	83 ec 0c             	sub    $0xc,%esp
80106eb4:	68 e0 5f 11 80       	push   $0x80115fe0
80106eb9:	e8 f4 e6 ff ff       	call   801055b2 <release>
80106ebe:	83 c4 10             	add    $0x10,%esp
    }
    lapiceoi();
80106ec1:	e8 5f c1 ff ff       	call   80103025 <lapiceoi>
    break;
80106ec6:	e9 1c 01 00 00       	jmp    80106fe7 <trap+0x1dd>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106ecb:	e8 68 b9 ff ff       	call   80102838 <ideintr>
    lapiceoi();
80106ed0:	e8 50 c1 ff ff       	call   80103025 <lapiceoi>
    break;
80106ed5:	e9 0d 01 00 00       	jmp    80106fe7 <trap+0x1dd>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80106eda:	e8 48 bf ff ff       	call   80102e27 <kbdintr>
    lapiceoi();
80106edf:	e8 41 c1 ff ff       	call   80103025 <lapiceoi>
    break;
80106ee4:	e9 fe 00 00 00       	jmp    80106fe7 <trap+0x1dd>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106ee9:	e8 60 03 00 00       	call   8010724e <uartintr>
    lapiceoi();
80106eee:	e8 32 c1 ff ff       	call   80103025 <lapiceoi>
    break;
80106ef3:	e9 ef 00 00 00       	jmp    80106fe7 <trap+0x1dd>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106ef8:	8b 45 08             	mov    0x8(%ebp),%eax
80106efb:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
80106efe:	8b 45 08             	mov    0x8(%ebp),%eax
80106f01:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106f05:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
80106f08:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106f0e:	0f b6 00             	movzbl (%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106f11:	0f b6 c0             	movzbl %al,%eax
80106f14:	51                   	push   %ecx
80106f15:	52                   	push   %edx
80106f16:	50                   	push   %eax
80106f17:	68 04 90 10 80       	push   $0x80109004
80106f1c:	e8 a5 94 ff ff       	call   801003c6 <cprintf>
80106f21:	83 c4 10             	add    $0x10,%esp
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
80106f24:	e8 fc c0 ff ff       	call   80103025 <lapiceoi>
    break;
80106f29:	e9 b9 00 00 00       	jmp    80106fe7 <trap+0x1dd>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80106f2e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106f34:	85 c0                	test   %eax,%eax
80106f36:	74 11                	je     80106f49 <trap+0x13f>
80106f38:	8b 45 08             	mov    0x8(%ebp),%eax
80106f3b:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106f3f:	0f b7 c0             	movzwl %ax,%eax
80106f42:	83 e0 03             	and    $0x3,%eax
80106f45:	85 c0                	test   %eax,%eax
80106f47:	75 40                	jne    80106f89 <trap+0x17f>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106f49:	e8 1d fd ff ff       	call   80106c6b <rcr2>
80106f4e:	89 c3                	mov    %eax,%ebx
80106f50:	8b 45 08             	mov    0x8(%ebp),%eax
80106f53:	8b 48 38             	mov    0x38(%eax),%ecx
              tf->trapno, cpu->id, tf->eip, rcr2());
80106f56:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106f5c:	0f b6 00             	movzbl (%eax),%eax
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106f5f:	0f b6 d0             	movzbl %al,%edx
80106f62:	8b 45 08             	mov    0x8(%ebp),%eax
80106f65:	8b 40 30             	mov    0x30(%eax),%eax
80106f68:	83 ec 0c             	sub    $0xc,%esp
80106f6b:	53                   	push   %ebx
80106f6c:	51                   	push   %ecx
80106f6d:	52                   	push   %edx
80106f6e:	50                   	push   %eax
80106f6f:	68 28 90 10 80       	push   $0x80109028
80106f74:	e8 4d 94 ff ff       	call   801003c6 <cprintf>
80106f79:	83 c4 20             	add    $0x20,%esp
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
80106f7c:	83 ec 0c             	sub    $0xc,%esp
80106f7f:	68 5a 90 10 80       	push   $0x8010905a
80106f84:	e8 dd 95 ff ff       	call   80100566 <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106f89:	e8 dd fc ff ff       	call   80106c6b <rcr2>
80106f8e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106f91:	8b 45 08             	mov    0x8(%ebp),%eax
80106f94:	8b 70 38             	mov    0x38(%eax),%esi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106f97:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106f9d:	0f b6 00             	movzbl (%eax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106fa0:	0f b6 d8             	movzbl %al,%ebx
80106fa3:	8b 45 08             	mov    0x8(%ebp),%eax
80106fa6:	8b 48 34             	mov    0x34(%eax),%ecx
80106fa9:	8b 45 08             	mov    0x8(%ebp),%eax
80106fac:	8b 50 30             	mov    0x30(%eax),%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106faf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106fb5:	8d 78 6c             	lea    0x6c(%eax),%edi
80106fb8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106fbe:	8b 40 10             	mov    0x10(%eax),%eax
80106fc1:	ff 75 e4             	pushl  -0x1c(%ebp)
80106fc4:	56                   	push   %esi
80106fc5:	53                   	push   %ebx
80106fc6:	51                   	push   %ecx
80106fc7:	52                   	push   %edx
80106fc8:	57                   	push   %edi
80106fc9:	50                   	push   %eax
80106fca:	68 60 90 10 80       	push   $0x80109060
80106fcf:	e8 f2 93 ff ff       	call   801003c6 <cprintf>
80106fd4:	83 c4 20             	add    $0x20,%esp
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
80106fd7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106fdd:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106fe4:	eb 01                	jmp    80106fe7 <trap+0x1dd>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
80106fe6:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106fe7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106fed:	85 c0                	test   %eax,%eax
80106fef:	74 24                	je     80107015 <trap+0x20b>
80106ff1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106ff7:	8b 40 24             	mov    0x24(%eax),%eax
80106ffa:	85 c0                	test   %eax,%eax
80106ffc:	74 17                	je     80107015 <trap+0x20b>
80106ffe:	8b 45 08             	mov    0x8(%ebp),%eax
80107001:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80107005:	0f b7 c0             	movzwl %ax,%eax
80107008:	83 e0 03             	and    $0x3,%eax
8010700b:	83 f8 03             	cmp    $0x3,%eax
8010700e:	75 05                	jne    80107015 <trap+0x20b>
    exit();
80107010:	e8 f0 d8 ff ff       	call   80104905 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80107015:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010701b:	85 c0                	test   %eax,%eax
8010701d:	74 1e                	je     8010703d <trap+0x233>
8010701f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107025:	8b 40 0c             	mov    0xc(%eax),%eax
80107028:	83 f8 04             	cmp    $0x4,%eax
8010702b:	75 10                	jne    8010703d <trap+0x233>
8010702d:	8b 45 08             	mov    0x8(%ebp),%eax
80107030:	8b 40 30             	mov    0x30(%eax),%eax
80107033:	83 f8 20             	cmp    $0x20,%eax
80107036:	75 05                	jne    8010703d <trap+0x233>
    yield();
80107038:	e8 57 dd ff ff       	call   80104d94 <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
8010703d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107043:	85 c0                	test   %eax,%eax
80107045:	74 27                	je     8010706e <trap+0x264>
80107047:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010704d:	8b 40 24             	mov    0x24(%eax),%eax
80107050:	85 c0                	test   %eax,%eax
80107052:	74 1a                	je     8010706e <trap+0x264>
80107054:	8b 45 08             	mov    0x8(%ebp),%eax
80107057:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
8010705b:	0f b7 c0             	movzwl %ax,%eax
8010705e:	83 e0 03             	and    $0x3,%eax
80107061:	83 f8 03             	cmp    $0x3,%eax
80107064:	75 08                	jne    8010706e <trap+0x264>
    exit();
80107066:	e8 9a d8 ff ff       	call   80104905 <exit>
8010706b:	eb 01                	jmp    8010706e <trap+0x264>
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
    return;
8010706d:	90                   	nop
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
8010706e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107071:	5b                   	pop    %ebx
80107072:	5e                   	pop    %esi
80107073:	5f                   	pop    %edi
80107074:	5d                   	pop    %ebp
80107075:	c3                   	ret    

80107076 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80107076:	55                   	push   %ebp
80107077:	89 e5                	mov    %esp,%ebp
80107079:	83 ec 14             	sub    $0x14,%esp
8010707c:	8b 45 08             	mov    0x8(%ebp),%eax
8010707f:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80107083:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80107087:	89 c2                	mov    %eax,%edx
80107089:	ec                   	in     (%dx),%al
8010708a:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
8010708d:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80107091:	c9                   	leave  
80107092:	c3                   	ret    

80107093 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80107093:	55                   	push   %ebp
80107094:	89 e5                	mov    %esp,%ebp
80107096:	83 ec 08             	sub    $0x8,%esp
80107099:	8b 55 08             	mov    0x8(%ebp),%edx
8010709c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010709f:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801070a3:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801070a6:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801070aa:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801070ae:	ee                   	out    %al,(%dx)
}
801070af:	90                   	nop
801070b0:	c9                   	leave  
801070b1:	c3                   	ret    

801070b2 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
801070b2:	55                   	push   %ebp
801070b3:	89 e5                	mov    %esp,%ebp
801070b5:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
801070b8:	6a 00                	push   $0x0
801070ba:	68 fa 03 00 00       	push   $0x3fa
801070bf:	e8 cf ff ff ff       	call   80107093 <outb>
801070c4:	83 c4 08             	add    $0x8,%esp
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
801070c7:	68 80 00 00 00       	push   $0x80
801070cc:	68 fb 03 00 00       	push   $0x3fb
801070d1:	e8 bd ff ff ff       	call   80107093 <outb>
801070d6:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
801070d9:	6a 0c                	push   $0xc
801070db:	68 f8 03 00 00       	push   $0x3f8
801070e0:	e8 ae ff ff ff       	call   80107093 <outb>
801070e5:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
801070e8:	6a 00                	push   $0x0
801070ea:	68 f9 03 00 00       	push   $0x3f9
801070ef:	e8 9f ff ff ff       	call   80107093 <outb>
801070f4:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
801070f7:	6a 03                	push   $0x3
801070f9:	68 fb 03 00 00       	push   $0x3fb
801070fe:	e8 90 ff ff ff       	call   80107093 <outb>
80107103:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
80107106:	6a 00                	push   $0x0
80107108:	68 fc 03 00 00       	push   $0x3fc
8010710d:	e8 81 ff ff ff       	call   80107093 <outb>
80107112:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80107115:	6a 01                	push   $0x1
80107117:	68 f9 03 00 00       	push   $0x3f9
8010711c:	e8 72 ff ff ff       	call   80107093 <outb>
80107121:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80107124:	68 fd 03 00 00       	push   $0x3fd
80107129:	e8 48 ff ff ff       	call   80107076 <inb>
8010712e:	83 c4 04             	add    $0x4,%esp
80107131:	3c ff                	cmp    $0xff,%al
80107133:	74 6e                	je     801071a3 <uartinit+0xf1>
    return;
  uart = 1;
80107135:	c7 05 4c c6 10 80 01 	movl   $0x1,0x8010c64c
8010713c:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
8010713f:	68 fa 03 00 00       	push   $0x3fa
80107144:	e8 2d ff ff ff       	call   80107076 <inb>
80107149:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
8010714c:	68 f8 03 00 00       	push   $0x3f8
80107151:	e8 20 ff ff ff       	call   80107076 <inb>
80107156:	83 c4 04             	add    $0x4,%esp
  picenable(IRQ_COM1);
80107159:	83 ec 0c             	sub    $0xc,%esp
8010715c:	6a 04                	push   $0x4
8010715e:	e8 c8 cd ff ff       	call   80103f2b <picenable>
80107163:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_COM1, 0);
80107166:	83 ec 08             	sub    $0x8,%esp
80107169:	6a 00                	push   $0x0
8010716b:	6a 04                	push   $0x4
8010716d:	e8 68 b9 ff ff       	call   80102ada <ioapicenable>
80107172:	83 c4 10             	add    $0x10,%esp
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80107175:	c7 45 f4 24 91 10 80 	movl   $0x80109124,-0xc(%ebp)
8010717c:	eb 19                	jmp    80107197 <uartinit+0xe5>
    uartputc(*p);
8010717e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107181:	0f b6 00             	movzbl (%eax),%eax
80107184:	0f be c0             	movsbl %al,%eax
80107187:	83 ec 0c             	sub    $0xc,%esp
8010718a:	50                   	push   %eax
8010718b:	e8 16 00 00 00       	call   801071a6 <uartputc>
80107190:	83 c4 10             	add    $0x10,%esp
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80107193:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80107197:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010719a:	0f b6 00             	movzbl (%eax),%eax
8010719d:	84 c0                	test   %al,%al
8010719f:	75 dd                	jne    8010717e <uartinit+0xcc>
801071a1:	eb 01                	jmp    801071a4 <uartinit+0xf2>
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
    return;
801071a3:	90                   	nop
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}
801071a4:	c9                   	leave  
801071a5:	c3                   	ret    

801071a6 <uartputc>:

void
uartputc(int c)
{
801071a6:	55                   	push   %ebp
801071a7:	89 e5                	mov    %esp,%ebp
801071a9:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
801071ac:	a1 4c c6 10 80       	mov    0x8010c64c,%eax
801071b1:	85 c0                	test   %eax,%eax
801071b3:	74 53                	je     80107208 <uartputc+0x62>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801071b5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801071bc:	eb 11                	jmp    801071cf <uartputc+0x29>
    microdelay(10);
801071be:	83 ec 0c             	sub    $0xc,%esp
801071c1:	6a 0a                	push   $0xa
801071c3:	e8 78 be ff ff       	call   80103040 <microdelay>
801071c8:	83 c4 10             	add    $0x10,%esp
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801071cb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801071cf:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
801071d3:	7f 1a                	jg     801071ef <uartputc+0x49>
801071d5:	83 ec 0c             	sub    $0xc,%esp
801071d8:	68 fd 03 00 00       	push   $0x3fd
801071dd:	e8 94 fe ff ff       	call   80107076 <inb>
801071e2:	83 c4 10             	add    $0x10,%esp
801071e5:	0f b6 c0             	movzbl %al,%eax
801071e8:	83 e0 20             	and    $0x20,%eax
801071eb:	85 c0                	test   %eax,%eax
801071ed:	74 cf                	je     801071be <uartputc+0x18>
    microdelay(10);
  outb(COM1+0, c);
801071ef:	8b 45 08             	mov    0x8(%ebp),%eax
801071f2:	0f b6 c0             	movzbl %al,%eax
801071f5:	83 ec 08             	sub    $0x8,%esp
801071f8:	50                   	push   %eax
801071f9:	68 f8 03 00 00       	push   $0x3f8
801071fe:	e8 90 fe ff ff       	call   80107093 <outb>
80107203:	83 c4 10             	add    $0x10,%esp
80107206:	eb 01                	jmp    80107209 <uartputc+0x63>
uartputc(int c)
{
  int i;

  if(!uart)
    return;
80107208:	90                   	nop
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80107209:	c9                   	leave  
8010720a:	c3                   	ret    

8010720b <uartgetc>:

static int
uartgetc(void)
{
8010720b:	55                   	push   %ebp
8010720c:	89 e5                	mov    %esp,%ebp
  if(!uart)
8010720e:	a1 4c c6 10 80       	mov    0x8010c64c,%eax
80107213:	85 c0                	test   %eax,%eax
80107215:	75 07                	jne    8010721e <uartgetc+0x13>
    return -1;
80107217:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010721c:	eb 2e                	jmp    8010724c <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
8010721e:	68 fd 03 00 00       	push   $0x3fd
80107223:	e8 4e fe ff ff       	call   80107076 <inb>
80107228:	83 c4 04             	add    $0x4,%esp
8010722b:	0f b6 c0             	movzbl %al,%eax
8010722e:	83 e0 01             	and    $0x1,%eax
80107231:	85 c0                	test   %eax,%eax
80107233:	75 07                	jne    8010723c <uartgetc+0x31>
    return -1;
80107235:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010723a:	eb 10                	jmp    8010724c <uartgetc+0x41>
  return inb(COM1+0);
8010723c:	68 f8 03 00 00       	push   $0x3f8
80107241:	e8 30 fe ff ff       	call   80107076 <inb>
80107246:	83 c4 04             	add    $0x4,%esp
80107249:	0f b6 c0             	movzbl %al,%eax
}
8010724c:	c9                   	leave  
8010724d:	c3                   	ret    

8010724e <uartintr>:

void
uartintr(void)
{
8010724e:	55                   	push   %ebp
8010724f:	89 e5                	mov    %esp,%ebp
80107251:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
80107254:	83 ec 0c             	sub    $0xc,%esp
80107257:	68 0b 72 10 80       	push   $0x8010720b
8010725c:	e8 98 95 ff ff       	call   801007f9 <consoleintr>
80107261:	83 c4 10             	add    $0x10,%esp
}
80107264:	90                   	nop
80107265:	c9                   	leave  
80107266:	c3                   	ret    

80107267 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107267:	6a 00                	push   $0x0
  pushl $0
80107269:	6a 00                	push   $0x0
  jmp alltraps
8010726b:	e9 a6 f9 ff ff       	jmp    80106c16 <alltraps>

80107270 <vector1>:
.globl vector1
vector1:
  pushl $0
80107270:	6a 00                	push   $0x0
  pushl $1
80107272:	6a 01                	push   $0x1
  jmp alltraps
80107274:	e9 9d f9 ff ff       	jmp    80106c16 <alltraps>

80107279 <vector2>:
.globl vector2
vector2:
  pushl $0
80107279:	6a 00                	push   $0x0
  pushl $2
8010727b:	6a 02                	push   $0x2
  jmp alltraps
8010727d:	e9 94 f9 ff ff       	jmp    80106c16 <alltraps>

80107282 <vector3>:
.globl vector3
vector3:
  pushl $0
80107282:	6a 00                	push   $0x0
  pushl $3
80107284:	6a 03                	push   $0x3
  jmp alltraps
80107286:	e9 8b f9 ff ff       	jmp    80106c16 <alltraps>

8010728b <vector4>:
.globl vector4
vector4:
  pushl $0
8010728b:	6a 00                	push   $0x0
  pushl $4
8010728d:	6a 04                	push   $0x4
  jmp alltraps
8010728f:	e9 82 f9 ff ff       	jmp    80106c16 <alltraps>

80107294 <vector5>:
.globl vector5
vector5:
  pushl $0
80107294:	6a 00                	push   $0x0
  pushl $5
80107296:	6a 05                	push   $0x5
  jmp alltraps
80107298:	e9 79 f9 ff ff       	jmp    80106c16 <alltraps>

8010729d <vector6>:
.globl vector6
vector6:
  pushl $0
8010729d:	6a 00                	push   $0x0
  pushl $6
8010729f:	6a 06                	push   $0x6
  jmp alltraps
801072a1:	e9 70 f9 ff ff       	jmp    80106c16 <alltraps>

801072a6 <vector7>:
.globl vector7
vector7:
  pushl $0
801072a6:	6a 00                	push   $0x0
  pushl $7
801072a8:	6a 07                	push   $0x7
  jmp alltraps
801072aa:	e9 67 f9 ff ff       	jmp    80106c16 <alltraps>

801072af <vector8>:
.globl vector8
vector8:
  pushl $8
801072af:	6a 08                	push   $0x8
  jmp alltraps
801072b1:	e9 60 f9 ff ff       	jmp    80106c16 <alltraps>

801072b6 <vector9>:
.globl vector9
vector9:
  pushl $0
801072b6:	6a 00                	push   $0x0
  pushl $9
801072b8:	6a 09                	push   $0x9
  jmp alltraps
801072ba:	e9 57 f9 ff ff       	jmp    80106c16 <alltraps>

801072bf <vector10>:
.globl vector10
vector10:
  pushl $10
801072bf:	6a 0a                	push   $0xa
  jmp alltraps
801072c1:	e9 50 f9 ff ff       	jmp    80106c16 <alltraps>

801072c6 <vector11>:
.globl vector11
vector11:
  pushl $11
801072c6:	6a 0b                	push   $0xb
  jmp alltraps
801072c8:	e9 49 f9 ff ff       	jmp    80106c16 <alltraps>

801072cd <vector12>:
.globl vector12
vector12:
  pushl $12
801072cd:	6a 0c                	push   $0xc
  jmp alltraps
801072cf:	e9 42 f9 ff ff       	jmp    80106c16 <alltraps>

801072d4 <vector13>:
.globl vector13
vector13:
  pushl $13
801072d4:	6a 0d                	push   $0xd
  jmp alltraps
801072d6:	e9 3b f9 ff ff       	jmp    80106c16 <alltraps>

801072db <vector14>:
.globl vector14
vector14:
  pushl $14
801072db:	6a 0e                	push   $0xe
  jmp alltraps
801072dd:	e9 34 f9 ff ff       	jmp    80106c16 <alltraps>

801072e2 <vector15>:
.globl vector15
vector15:
  pushl $0
801072e2:	6a 00                	push   $0x0
  pushl $15
801072e4:	6a 0f                	push   $0xf
  jmp alltraps
801072e6:	e9 2b f9 ff ff       	jmp    80106c16 <alltraps>

801072eb <vector16>:
.globl vector16
vector16:
  pushl $0
801072eb:	6a 00                	push   $0x0
  pushl $16
801072ed:	6a 10                	push   $0x10
  jmp alltraps
801072ef:	e9 22 f9 ff ff       	jmp    80106c16 <alltraps>

801072f4 <vector17>:
.globl vector17
vector17:
  pushl $17
801072f4:	6a 11                	push   $0x11
  jmp alltraps
801072f6:	e9 1b f9 ff ff       	jmp    80106c16 <alltraps>

801072fb <vector18>:
.globl vector18
vector18:
  pushl $0
801072fb:	6a 00                	push   $0x0
  pushl $18
801072fd:	6a 12                	push   $0x12
  jmp alltraps
801072ff:	e9 12 f9 ff ff       	jmp    80106c16 <alltraps>

80107304 <vector19>:
.globl vector19
vector19:
  pushl $0
80107304:	6a 00                	push   $0x0
  pushl $19
80107306:	6a 13                	push   $0x13
  jmp alltraps
80107308:	e9 09 f9 ff ff       	jmp    80106c16 <alltraps>

8010730d <vector20>:
.globl vector20
vector20:
  pushl $0
8010730d:	6a 00                	push   $0x0
  pushl $20
8010730f:	6a 14                	push   $0x14
  jmp alltraps
80107311:	e9 00 f9 ff ff       	jmp    80106c16 <alltraps>

80107316 <vector21>:
.globl vector21
vector21:
  pushl $0
80107316:	6a 00                	push   $0x0
  pushl $21
80107318:	6a 15                	push   $0x15
  jmp alltraps
8010731a:	e9 f7 f8 ff ff       	jmp    80106c16 <alltraps>

8010731f <vector22>:
.globl vector22
vector22:
  pushl $0
8010731f:	6a 00                	push   $0x0
  pushl $22
80107321:	6a 16                	push   $0x16
  jmp alltraps
80107323:	e9 ee f8 ff ff       	jmp    80106c16 <alltraps>

80107328 <vector23>:
.globl vector23
vector23:
  pushl $0
80107328:	6a 00                	push   $0x0
  pushl $23
8010732a:	6a 17                	push   $0x17
  jmp alltraps
8010732c:	e9 e5 f8 ff ff       	jmp    80106c16 <alltraps>

80107331 <vector24>:
.globl vector24
vector24:
  pushl $0
80107331:	6a 00                	push   $0x0
  pushl $24
80107333:	6a 18                	push   $0x18
  jmp alltraps
80107335:	e9 dc f8 ff ff       	jmp    80106c16 <alltraps>

8010733a <vector25>:
.globl vector25
vector25:
  pushl $0
8010733a:	6a 00                	push   $0x0
  pushl $25
8010733c:	6a 19                	push   $0x19
  jmp alltraps
8010733e:	e9 d3 f8 ff ff       	jmp    80106c16 <alltraps>

80107343 <vector26>:
.globl vector26
vector26:
  pushl $0
80107343:	6a 00                	push   $0x0
  pushl $26
80107345:	6a 1a                	push   $0x1a
  jmp alltraps
80107347:	e9 ca f8 ff ff       	jmp    80106c16 <alltraps>

8010734c <vector27>:
.globl vector27
vector27:
  pushl $0
8010734c:	6a 00                	push   $0x0
  pushl $27
8010734e:	6a 1b                	push   $0x1b
  jmp alltraps
80107350:	e9 c1 f8 ff ff       	jmp    80106c16 <alltraps>

80107355 <vector28>:
.globl vector28
vector28:
  pushl $0
80107355:	6a 00                	push   $0x0
  pushl $28
80107357:	6a 1c                	push   $0x1c
  jmp alltraps
80107359:	e9 b8 f8 ff ff       	jmp    80106c16 <alltraps>

8010735e <vector29>:
.globl vector29
vector29:
  pushl $0
8010735e:	6a 00                	push   $0x0
  pushl $29
80107360:	6a 1d                	push   $0x1d
  jmp alltraps
80107362:	e9 af f8 ff ff       	jmp    80106c16 <alltraps>

80107367 <vector30>:
.globl vector30
vector30:
  pushl $0
80107367:	6a 00                	push   $0x0
  pushl $30
80107369:	6a 1e                	push   $0x1e
  jmp alltraps
8010736b:	e9 a6 f8 ff ff       	jmp    80106c16 <alltraps>

80107370 <vector31>:
.globl vector31
vector31:
  pushl $0
80107370:	6a 00                	push   $0x0
  pushl $31
80107372:	6a 1f                	push   $0x1f
  jmp alltraps
80107374:	e9 9d f8 ff ff       	jmp    80106c16 <alltraps>

80107379 <vector32>:
.globl vector32
vector32:
  pushl $0
80107379:	6a 00                	push   $0x0
  pushl $32
8010737b:	6a 20                	push   $0x20
  jmp alltraps
8010737d:	e9 94 f8 ff ff       	jmp    80106c16 <alltraps>

80107382 <vector33>:
.globl vector33
vector33:
  pushl $0
80107382:	6a 00                	push   $0x0
  pushl $33
80107384:	6a 21                	push   $0x21
  jmp alltraps
80107386:	e9 8b f8 ff ff       	jmp    80106c16 <alltraps>

8010738b <vector34>:
.globl vector34
vector34:
  pushl $0
8010738b:	6a 00                	push   $0x0
  pushl $34
8010738d:	6a 22                	push   $0x22
  jmp alltraps
8010738f:	e9 82 f8 ff ff       	jmp    80106c16 <alltraps>

80107394 <vector35>:
.globl vector35
vector35:
  pushl $0
80107394:	6a 00                	push   $0x0
  pushl $35
80107396:	6a 23                	push   $0x23
  jmp alltraps
80107398:	e9 79 f8 ff ff       	jmp    80106c16 <alltraps>

8010739d <vector36>:
.globl vector36
vector36:
  pushl $0
8010739d:	6a 00                	push   $0x0
  pushl $36
8010739f:	6a 24                	push   $0x24
  jmp alltraps
801073a1:	e9 70 f8 ff ff       	jmp    80106c16 <alltraps>

801073a6 <vector37>:
.globl vector37
vector37:
  pushl $0
801073a6:	6a 00                	push   $0x0
  pushl $37
801073a8:	6a 25                	push   $0x25
  jmp alltraps
801073aa:	e9 67 f8 ff ff       	jmp    80106c16 <alltraps>

801073af <vector38>:
.globl vector38
vector38:
  pushl $0
801073af:	6a 00                	push   $0x0
  pushl $38
801073b1:	6a 26                	push   $0x26
  jmp alltraps
801073b3:	e9 5e f8 ff ff       	jmp    80106c16 <alltraps>

801073b8 <vector39>:
.globl vector39
vector39:
  pushl $0
801073b8:	6a 00                	push   $0x0
  pushl $39
801073ba:	6a 27                	push   $0x27
  jmp alltraps
801073bc:	e9 55 f8 ff ff       	jmp    80106c16 <alltraps>

801073c1 <vector40>:
.globl vector40
vector40:
  pushl $0
801073c1:	6a 00                	push   $0x0
  pushl $40
801073c3:	6a 28                	push   $0x28
  jmp alltraps
801073c5:	e9 4c f8 ff ff       	jmp    80106c16 <alltraps>

801073ca <vector41>:
.globl vector41
vector41:
  pushl $0
801073ca:	6a 00                	push   $0x0
  pushl $41
801073cc:	6a 29                	push   $0x29
  jmp alltraps
801073ce:	e9 43 f8 ff ff       	jmp    80106c16 <alltraps>

801073d3 <vector42>:
.globl vector42
vector42:
  pushl $0
801073d3:	6a 00                	push   $0x0
  pushl $42
801073d5:	6a 2a                	push   $0x2a
  jmp alltraps
801073d7:	e9 3a f8 ff ff       	jmp    80106c16 <alltraps>

801073dc <vector43>:
.globl vector43
vector43:
  pushl $0
801073dc:	6a 00                	push   $0x0
  pushl $43
801073de:	6a 2b                	push   $0x2b
  jmp alltraps
801073e0:	e9 31 f8 ff ff       	jmp    80106c16 <alltraps>

801073e5 <vector44>:
.globl vector44
vector44:
  pushl $0
801073e5:	6a 00                	push   $0x0
  pushl $44
801073e7:	6a 2c                	push   $0x2c
  jmp alltraps
801073e9:	e9 28 f8 ff ff       	jmp    80106c16 <alltraps>

801073ee <vector45>:
.globl vector45
vector45:
  pushl $0
801073ee:	6a 00                	push   $0x0
  pushl $45
801073f0:	6a 2d                	push   $0x2d
  jmp alltraps
801073f2:	e9 1f f8 ff ff       	jmp    80106c16 <alltraps>

801073f7 <vector46>:
.globl vector46
vector46:
  pushl $0
801073f7:	6a 00                	push   $0x0
  pushl $46
801073f9:	6a 2e                	push   $0x2e
  jmp alltraps
801073fb:	e9 16 f8 ff ff       	jmp    80106c16 <alltraps>

80107400 <vector47>:
.globl vector47
vector47:
  pushl $0
80107400:	6a 00                	push   $0x0
  pushl $47
80107402:	6a 2f                	push   $0x2f
  jmp alltraps
80107404:	e9 0d f8 ff ff       	jmp    80106c16 <alltraps>

80107409 <vector48>:
.globl vector48
vector48:
  pushl $0
80107409:	6a 00                	push   $0x0
  pushl $48
8010740b:	6a 30                	push   $0x30
  jmp alltraps
8010740d:	e9 04 f8 ff ff       	jmp    80106c16 <alltraps>

80107412 <vector49>:
.globl vector49
vector49:
  pushl $0
80107412:	6a 00                	push   $0x0
  pushl $49
80107414:	6a 31                	push   $0x31
  jmp alltraps
80107416:	e9 fb f7 ff ff       	jmp    80106c16 <alltraps>

8010741b <vector50>:
.globl vector50
vector50:
  pushl $0
8010741b:	6a 00                	push   $0x0
  pushl $50
8010741d:	6a 32                	push   $0x32
  jmp alltraps
8010741f:	e9 f2 f7 ff ff       	jmp    80106c16 <alltraps>

80107424 <vector51>:
.globl vector51
vector51:
  pushl $0
80107424:	6a 00                	push   $0x0
  pushl $51
80107426:	6a 33                	push   $0x33
  jmp alltraps
80107428:	e9 e9 f7 ff ff       	jmp    80106c16 <alltraps>

8010742d <vector52>:
.globl vector52
vector52:
  pushl $0
8010742d:	6a 00                	push   $0x0
  pushl $52
8010742f:	6a 34                	push   $0x34
  jmp alltraps
80107431:	e9 e0 f7 ff ff       	jmp    80106c16 <alltraps>

80107436 <vector53>:
.globl vector53
vector53:
  pushl $0
80107436:	6a 00                	push   $0x0
  pushl $53
80107438:	6a 35                	push   $0x35
  jmp alltraps
8010743a:	e9 d7 f7 ff ff       	jmp    80106c16 <alltraps>

8010743f <vector54>:
.globl vector54
vector54:
  pushl $0
8010743f:	6a 00                	push   $0x0
  pushl $54
80107441:	6a 36                	push   $0x36
  jmp alltraps
80107443:	e9 ce f7 ff ff       	jmp    80106c16 <alltraps>

80107448 <vector55>:
.globl vector55
vector55:
  pushl $0
80107448:	6a 00                	push   $0x0
  pushl $55
8010744a:	6a 37                	push   $0x37
  jmp alltraps
8010744c:	e9 c5 f7 ff ff       	jmp    80106c16 <alltraps>

80107451 <vector56>:
.globl vector56
vector56:
  pushl $0
80107451:	6a 00                	push   $0x0
  pushl $56
80107453:	6a 38                	push   $0x38
  jmp alltraps
80107455:	e9 bc f7 ff ff       	jmp    80106c16 <alltraps>

8010745a <vector57>:
.globl vector57
vector57:
  pushl $0
8010745a:	6a 00                	push   $0x0
  pushl $57
8010745c:	6a 39                	push   $0x39
  jmp alltraps
8010745e:	e9 b3 f7 ff ff       	jmp    80106c16 <alltraps>

80107463 <vector58>:
.globl vector58
vector58:
  pushl $0
80107463:	6a 00                	push   $0x0
  pushl $58
80107465:	6a 3a                	push   $0x3a
  jmp alltraps
80107467:	e9 aa f7 ff ff       	jmp    80106c16 <alltraps>

8010746c <vector59>:
.globl vector59
vector59:
  pushl $0
8010746c:	6a 00                	push   $0x0
  pushl $59
8010746e:	6a 3b                	push   $0x3b
  jmp alltraps
80107470:	e9 a1 f7 ff ff       	jmp    80106c16 <alltraps>

80107475 <vector60>:
.globl vector60
vector60:
  pushl $0
80107475:	6a 00                	push   $0x0
  pushl $60
80107477:	6a 3c                	push   $0x3c
  jmp alltraps
80107479:	e9 98 f7 ff ff       	jmp    80106c16 <alltraps>

8010747e <vector61>:
.globl vector61
vector61:
  pushl $0
8010747e:	6a 00                	push   $0x0
  pushl $61
80107480:	6a 3d                	push   $0x3d
  jmp alltraps
80107482:	e9 8f f7 ff ff       	jmp    80106c16 <alltraps>

80107487 <vector62>:
.globl vector62
vector62:
  pushl $0
80107487:	6a 00                	push   $0x0
  pushl $62
80107489:	6a 3e                	push   $0x3e
  jmp alltraps
8010748b:	e9 86 f7 ff ff       	jmp    80106c16 <alltraps>

80107490 <vector63>:
.globl vector63
vector63:
  pushl $0
80107490:	6a 00                	push   $0x0
  pushl $63
80107492:	6a 3f                	push   $0x3f
  jmp alltraps
80107494:	e9 7d f7 ff ff       	jmp    80106c16 <alltraps>

80107499 <vector64>:
.globl vector64
vector64:
  pushl $0
80107499:	6a 00                	push   $0x0
  pushl $64
8010749b:	6a 40                	push   $0x40
  jmp alltraps
8010749d:	e9 74 f7 ff ff       	jmp    80106c16 <alltraps>

801074a2 <vector65>:
.globl vector65
vector65:
  pushl $0
801074a2:	6a 00                	push   $0x0
  pushl $65
801074a4:	6a 41                	push   $0x41
  jmp alltraps
801074a6:	e9 6b f7 ff ff       	jmp    80106c16 <alltraps>

801074ab <vector66>:
.globl vector66
vector66:
  pushl $0
801074ab:	6a 00                	push   $0x0
  pushl $66
801074ad:	6a 42                	push   $0x42
  jmp alltraps
801074af:	e9 62 f7 ff ff       	jmp    80106c16 <alltraps>

801074b4 <vector67>:
.globl vector67
vector67:
  pushl $0
801074b4:	6a 00                	push   $0x0
  pushl $67
801074b6:	6a 43                	push   $0x43
  jmp alltraps
801074b8:	e9 59 f7 ff ff       	jmp    80106c16 <alltraps>

801074bd <vector68>:
.globl vector68
vector68:
  pushl $0
801074bd:	6a 00                	push   $0x0
  pushl $68
801074bf:	6a 44                	push   $0x44
  jmp alltraps
801074c1:	e9 50 f7 ff ff       	jmp    80106c16 <alltraps>

801074c6 <vector69>:
.globl vector69
vector69:
  pushl $0
801074c6:	6a 00                	push   $0x0
  pushl $69
801074c8:	6a 45                	push   $0x45
  jmp alltraps
801074ca:	e9 47 f7 ff ff       	jmp    80106c16 <alltraps>

801074cf <vector70>:
.globl vector70
vector70:
  pushl $0
801074cf:	6a 00                	push   $0x0
  pushl $70
801074d1:	6a 46                	push   $0x46
  jmp alltraps
801074d3:	e9 3e f7 ff ff       	jmp    80106c16 <alltraps>

801074d8 <vector71>:
.globl vector71
vector71:
  pushl $0
801074d8:	6a 00                	push   $0x0
  pushl $71
801074da:	6a 47                	push   $0x47
  jmp alltraps
801074dc:	e9 35 f7 ff ff       	jmp    80106c16 <alltraps>

801074e1 <vector72>:
.globl vector72
vector72:
  pushl $0
801074e1:	6a 00                	push   $0x0
  pushl $72
801074e3:	6a 48                	push   $0x48
  jmp alltraps
801074e5:	e9 2c f7 ff ff       	jmp    80106c16 <alltraps>

801074ea <vector73>:
.globl vector73
vector73:
  pushl $0
801074ea:	6a 00                	push   $0x0
  pushl $73
801074ec:	6a 49                	push   $0x49
  jmp alltraps
801074ee:	e9 23 f7 ff ff       	jmp    80106c16 <alltraps>

801074f3 <vector74>:
.globl vector74
vector74:
  pushl $0
801074f3:	6a 00                	push   $0x0
  pushl $74
801074f5:	6a 4a                	push   $0x4a
  jmp alltraps
801074f7:	e9 1a f7 ff ff       	jmp    80106c16 <alltraps>

801074fc <vector75>:
.globl vector75
vector75:
  pushl $0
801074fc:	6a 00                	push   $0x0
  pushl $75
801074fe:	6a 4b                	push   $0x4b
  jmp alltraps
80107500:	e9 11 f7 ff ff       	jmp    80106c16 <alltraps>

80107505 <vector76>:
.globl vector76
vector76:
  pushl $0
80107505:	6a 00                	push   $0x0
  pushl $76
80107507:	6a 4c                	push   $0x4c
  jmp alltraps
80107509:	e9 08 f7 ff ff       	jmp    80106c16 <alltraps>

8010750e <vector77>:
.globl vector77
vector77:
  pushl $0
8010750e:	6a 00                	push   $0x0
  pushl $77
80107510:	6a 4d                	push   $0x4d
  jmp alltraps
80107512:	e9 ff f6 ff ff       	jmp    80106c16 <alltraps>

80107517 <vector78>:
.globl vector78
vector78:
  pushl $0
80107517:	6a 00                	push   $0x0
  pushl $78
80107519:	6a 4e                	push   $0x4e
  jmp alltraps
8010751b:	e9 f6 f6 ff ff       	jmp    80106c16 <alltraps>

80107520 <vector79>:
.globl vector79
vector79:
  pushl $0
80107520:	6a 00                	push   $0x0
  pushl $79
80107522:	6a 4f                	push   $0x4f
  jmp alltraps
80107524:	e9 ed f6 ff ff       	jmp    80106c16 <alltraps>

80107529 <vector80>:
.globl vector80
vector80:
  pushl $0
80107529:	6a 00                	push   $0x0
  pushl $80
8010752b:	6a 50                	push   $0x50
  jmp alltraps
8010752d:	e9 e4 f6 ff ff       	jmp    80106c16 <alltraps>

80107532 <vector81>:
.globl vector81
vector81:
  pushl $0
80107532:	6a 00                	push   $0x0
  pushl $81
80107534:	6a 51                	push   $0x51
  jmp alltraps
80107536:	e9 db f6 ff ff       	jmp    80106c16 <alltraps>

8010753b <vector82>:
.globl vector82
vector82:
  pushl $0
8010753b:	6a 00                	push   $0x0
  pushl $82
8010753d:	6a 52                	push   $0x52
  jmp alltraps
8010753f:	e9 d2 f6 ff ff       	jmp    80106c16 <alltraps>

80107544 <vector83>:
.globl vector83
vector83:
  pushl $0
80107544:	6a 00                	push   $0x0
  pushl $83
80107546:	6a 53                	push   $0x53
  jmp alltraps
80107548:	e9 c9 f6 ff ff       	jmp    80106c16 <alltraps>

8010754d <vector84>:
.globl vector84
vector84:
  pushl $0
8010754d:	6a 00                	push   $0x0
  pushl $84
8010754f:	6a 54                	push   $0x54
  jmp alltraps
80107551:	e9 c0 f6 ff ff       	jmp    80106c16 <alltraps>

80107556 <vector85>:
.globl vector85
vector85:
  pushl $0
80107556:	6a 00                	push   $0x0
  pushl $85
80107558:	6a 55                	push   $0x55
  jmp alltraps
8010755a:	e9 b7 f6 ff ff       	jmp    80106c16 <alltraps>

8010755f <vector86>:
.globl vector86
vector86:
  pushl $0
8010755f:	6a 00                	push   $0x0
  pushl $86
80107561:	6a 56                	push   $0x56
  jmp alltraps
80107563:	e9 ae f6 ff ff       	jmp    80106c16 <alltraps>

80107568 <vector87>:
.globl vector87
vector87:
  pushl $0
80107568:	6a 00                	push   $0x0
  pushl $87
8010756a:	6a 57                	push   $0x57
  jmp alltraps
8010756c:	e9 a5 f6 ff ff       	jmp    80106c16 <alltraps>

80107571 <vector88>:
.globl vector88
vector88:
  pushl $0
80107571:	6a 00                	push   $0x0
  pushl $88
80107573:	6a 58                	push   $0x58
  jmp alltraps
80107575:	e9 9c f6 ff ff       	jmp    80106c16 <alltraps>

8010757a <vector89>:
.globl vector89
vector89:
  pushl $0
8010757a:	6a 00                	push   $0x0
  pushl $89
8010757c:	6a 59                	push   $0x59
  jmp alltraps
8010757e:	e9 93 f6 ff ff       	jmp    80106c16 <alltraps>

80107583 <vector90>:
.globl vector90
vector90:
  pushl $0
80107583:	6a 00                	push   $0x0
  pushl $90
80107585:	6a 5a                	push   $0x5a
  jmp alltraps
80107587:	e9 8a f6 ff ff       	jmp    80106c16 <alltraps>

8010758c <vector91>:
.globl vector91
vector91:
  pushl $0
8010758c:	6a 00                	push   $0x0
  pushl $91
8010758e:	6a 5b                	push   $0x5b
  jmp alltraps
80107590:	e9 81 f6 ff ff       	jmp    80106c16 <alltraps>

80107595 <vector92>:
.globl vector92
vector92:
  pushl $0
80107595:	6a 00                	push   $0x0
  pushl $92
80107597:	6a 5c                	push   $0x5c
  jmp alltraps
80107599:	e9 78 f6 ff ff       	jmp    80106c16 <alltraps>

8010759e <vector93>:
.globl vector93
vector93:
  pushl $0
8010759e:	6a 00                	push   $0x0
  pushl $93
801075a0:	6a 5d                	push   $0x5d
  jmp alltraps
801075a2:	e9 6f f6 ff ff       	jmp    80106c16 <alltraps>

801075a7 <vector94>:
.globl vector94
vector94:
  pushl $0
801075a7:	6a 00                	push   $0x0
  pushl $94
801075a9:	6a 5e                	push   $0x5e
  jmp alltraps
801075ab:	e9 66 f6 ff ff       	jmp    80106c16 <alltraps>

801075b0 <vector95>:
.globl vector95
vector95:
  pushl $0
801075b0:	6a 00                	push   $0x0
  pushl $95
801075b2:	6a 5f                	push   $0x5f
  jmp alltraps
801075b4:	e9 5d f6 ff ff       	jmp    80106c16 <alltraps>

801075b9 <vector96>:
.globl vector96
vector96:
  pushl $0
801075b9:	6a 00                	push   $0x0
  pushl $96
801075bb:	6a 60                	push   $0x60
  jmp alltraps
801075bd:	e9 54 f6 ff ff       	jmp    80106c16 <alltraps>

801075c2 <vector97>:
.globl vector97
vector97:
  pushl $0
801075c2:	6a 00                	push   $0x0
  pushl $97
801075c4:	6a 61                	push   $0x61
  jmp alltraps
801075c6:	e9 4b f6 ff ff       	jmp    80106c16 <alltraps>

801075cb <vector98>:
.globl vector98
vector98:
  pushl $0
801075cb:	6a 00                	push   $0x0
  pushl $98
801075cd:	6a 62                	push   $0x62
  jmp alltraps
801075cf:	e9 42 f6 ff ff       	jmp    80106c16 <alltraps>

801075d4 <vector99>:
.globl vector99
vector99:
  pushl $0
801075d4:	6a 00                	push   $0x0
  pushl $99
801075d6:	6a 63                	push   $0x63
  jmp alltraps
801075d8:	e9 39 f6 ff ff       	jmp    80106c16 <alltraps>

801075dd <vector100>:
.globl vector100
vector100:
  pushl $0
801075dd:	6a 00                	push   $0x0
  pushl $100
801075df:	6a 64                	push   $0x64
  jmp alltraps
801075e1:	e9 30 f6 ff ff       	jmp    80106c16 <alltraps>

801075e6 <vector101>:
.globl vector101
vector101:
  pushl $0
801075e6:	6a 00                	push   $0x0
  pushl $101
801075e8:	6a 65                	push   $0x65
  jmp alltraps
801075ea:	e9 27 f6 ff ff       	jmp    80106c16 <alltraps>

801075ef <vector102>:
.globl vector102
vector102:
  pushl $0
801075ef:	6a 00                	push   $0x0
  pushl $102
801075f1:	6a 66                	push   $0x66
  jmp alltraps
801075f3:	e9 1e f6 ff ff       	jmp    80106c16 <alltraps>

801075f8 <vector103>:
.globl vector103
vector103:
  pushl $0
801075f8:	6a 00                	push   $0x0
  pushl $103
801075fa:	6a 67                	push   $0x67
  jmp alltraps
801075fc:	e9 15 f6 ff ff       	jmp    80106c16 <alltraps>

80107601 <vector104>:
.globl vector104
vector104:
  pushl $0
80107601:	6a 00                	push   $0x0
  pushl $104
80107603:	6a 68                	push   $0x68
  jmp alltraps
80107605:	e9 0c f6 ff ff       	jmp    80106c16 <alltraps>

8010760a <vector105>:
.globl vector105
vector105:
  pushl $0
8010760a:	6a 00                	push   $0x0
  pushl $105
8010760c:	6a 69                	push   $0x69
  jmp alltraps
8010760e:	e9 03 f6 ff ff       	jmp    80106c16 <alltraps>

80107613 <vector106>:
.globl vector106
vector106:
  pushl $0
80107613:	6a 00                	push   $0x0
  pushl $106
80107615:	6a 6a                	push   $0x6a
  jmp alltraps
80107617:	e9 fa f5 ff ff       	jmp    80106c16 <alltraps>

8010761c <vector107>:
.globl vector107
vector107:
  pushl $0
8010761c:	6a 00                	push   $0x0
  pushl $107
8010761e:	6a 6b                	push   $0x6b
  jmp alltraps
80107620:	e9 f1 f5 ff ff       	jmp    80106c16 <alltraps>

80107625 <vector108>:
.globl vector108
vector108:
  pushl $0
80107625:	6a 00                	push   $0x0
  pushl $108
80107627:	6a 6c                	push   $0x6c
  jmp alltraps
80107629:	e9 e8 f5 ff ff       	jmp    80106c16 <alltraps>

8010762e <vector109>:
.globl vector109
vector109:
  pushl $0
8010762e:	6a 00                	push   $0x0
  pushl $109
80107630:	6a 6d                	push   $0x6d
  jmp alltraps
80107632:	e9 df f5 ff ff       	jmp    80106c16 <alltraps>

80107637 <vector110>:
.globl vector110
vector110:
  pushl $0
80107637:	6a 00                	push   $0x0
  pushl $110
80107639:	6a 6e                	push   $0x6e
  jmp alltraps
8010763b:	e9 d6 f5 ff ff       	jmp    80106c16 <alltraps>

80107640 <vector111>:
.globl vector111
vector111:
  pushl $0
80107640:	6a 00                	push   $0x0
  pushl $111
80107642:	6a 6f                	push   $0x6f
  jmp alltraps
80107644:	e9 cd f5 ff ff       	jmp    80106c16 <alltraps>

80107649 <vector112>:
.globl vector112
vector112:
  pushl $0
80107649:	6a 00                	push   $0x0
  pushl $112
8010764b:	6a 70                	push   $0x70
  jmp alltraps
8010764d:	e9 c4 f5 ff ff       	jmp    80106c16 <alltraps>

80107652 <vector113>:
.globl vector113
vector113:
  pushl $0
80107652:	6a 00                	push   $0x0
  pushl $113
80107654:	6a 71                	push   $0x71
  jmp alltraps
80107656:	e9 bb f5 ff ff       	jmp    80106c16 <alltraps>

8010765b <vector114>:
.globl vector114
vector114:
  pushl $0
8010765b:	6a 00                	push   $0x0
  pushl $114
8010765d:	6a 72                	push   $0x72
  jmp alltraps
8010765f:	e9 b2 f5 ff ff       	jmp    80106c16 <alltraps>

80107664 <vector115>:
.globl vector115
vector115:
  pushl $0
80107664:	6a 00                	push   $0x0
  pushl $115
80107666:	6a 73                	push   $0x73
  jmp alltraps
80107668:	e9 a9 f5 ff ff       	jmp    80106c16 <alltraps>

8010766d <vector116>:
.globl vector116
vector116:
  pushl $0
8010766d:	6a 00                	push   $0x0
  pushl $116
8010766f:	6a 74                	push   $0x74
  jmp alltraps
80107671:	e9 a0 f5 ff ff       	jmp    80106c16 <alltraps>

80107676 <vector117>:
.globl vector117
vector117:
  pushl $0
80107676:	6a 00                	push   $0x0
  pushl $117
80107678:	6a 75                	push   $0x75
  jmp alltraps
8010767a:	e9 97 f5 ff ff       	jmp    80106c16 <alltraps>

8010767f <vector118>:
.globl vector118
vector118:
  pushl $0
8010767f:	6a 00                	push   $0x0
  pushl $118
80107681:	6a 76                	push   $0x76
  jmp alltraps
80107683:	e9 8e f5 ff ff       	jmp    80106c16 <alltraps>

80107688 <vector119>:
.globl vector119
vector119:
  pushl $0
80107688:	6a 00                	push   $0x0
  pushl $119
8010768a:	6a 77                	push   $0x77
  jmp alltraps
8010768c:	e9 85 f5 ff ff       	jmp    80106c16 <alltraps>

80107691 <vector120>:
.globl vector120
vector120:
  pushl $0
80107691:	6a 00                	push   $0x0
  pushl $120
80107693:	6a 78                	push   $0x78
  jmp alltraps
80107695:	e9 7c f5 ff ff       	jmp    80106c16 <alltraps>

8010769a <vector121>:
.globl vector121
vector121:
  pushl $0
8010769a:	6a 00                	push   $0x0
  pushl $121
8010769c:	6a 79                	push   $0x79
  jmp alltraps
8010769e:	e9 73 f5 ff ff       	jmp    80106c16 <alltraps>

801076a3 <vector122>:
.globl vector122
vector122:
  pushl $0
801076a3:	6a 00                	push   $0x0
  pushl $122
801076a5:	6a 7a                	push   $0x7a
  jmp alltraps
801076a7:	e9 6a f5 ff ff       	jmp    80106c16 <alltraps>

801076ac <vector123>:
.globl vector123
vector123:
  pushl $0
801076ac:	6a 00                	push   $0x0
  pushl $123
801076ae:	6a 7b                	push   $0x7b
  jmp alltraps
801076b0:	e9 61 f5 ff ff       	jmp    80106c16 <alltraps>

801076b5 <vector124>:
.globl vector124
vector124:
  pushl $0
801076b5:	6a 00                	push   $0x0
  pushl $124
801076b7:	6a 7c                	push   $0x7c
  jmp alltraps
801076b9:	e9 58 f5 ff ff       	jmp    80106c16 <alltraps>

801076be <vector125>:
.globl vector125
vector125:
  pushl $0
801076be:	6a 00                	push   $0x0
  pushl $125
801076c0:	6a 7d                	push   $0x7d
  jmp alltraps
801076c2:	e9 4f f5 ff ff       	jmp    80106c16 <alltraps>

801076c7 <vector126>:
.globl vector126
vector126:
  pushl $0
801076c7:	6a 00                	push   $0x0
  pushl $126
801076c9:	6a 7e                	push   $0x7e
  jmp alltraps
801076cb:	e9 46 f5 ff ff       	jmp    80106c16 <alltraps>

801076d0 <vector127>:
.globl vector127
vector127:
  pushl $0
801076d0:	6a 00                	push   $0x0
  pushl $127
801076d2:	6a 7f                	push   $0x7f
  jmp alltraps
801076d4:	e9 3d f5 ff ff       	jmp    80106c16 <alltraps>

801076d9 <vector128>:
.globl vector128
vector128:
  pushl $0
801076d9:	6a 00                	push   $0x0
  pushl $128
801076db:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801076e0:	e9 31 f5 ff ff       	jmp    80106c16 <alltraps>

801076e5 <vector129>:
.globl vector129
vector129:
  pushl $0
801076e5:	6a 00                	push   $0x0
  pushl $129
801076e7:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801076ec:	e9 25 f5 ff ff       	jmp    80106c16 <alltraps>

801076f1 <vector130>:
.globl vector130
vector130:
  pushl $0
801076f1:	6a 00                	push   $0x0
  pushl $130
801076f3:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801076f8:	e9 19 f5 ff ff       	jmp    80106c16 <alltraps>

801076fd <vector131>:
.globl vector131
vector131:
  pushl $0
801076fd:	6a 00                	push   $0x0
  pushl $131
801076ff:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107704:	e9 0d f5 ff ff       	jmp    80106c16 <alltraps>

80107709 <vector132>:
.globl vector132
vector132:
  pushl $0
80107709:	6a 00                	push   $0x0
  pushl $132
8010770b:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80107710:	e9 01 f5 ff ff       	jmp    80106c16 <alltraps>

80107715 <vector133>:
.globl vector133
vector133:
  pushl $0
80107715:	6a 00                	push   $0x0
  pushl $133
80107717:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010771c:	e9 f5 f4 ff ff       	jmp    80106c16 <alltraps>

80107721 <vector134>:
.globl vector134
vector134:
  pushl $0
80107721:	6a 00                	push   $0x0
  pushl $134
80107723:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107728:	e9 e9 f4 ff ff       	jmp    80106c16 <alltraps>

8010772d <vector135>:
.globl vector135
vector135:
  pushl $0
8010772d:	6a 00                	push   $0x0
  pushl $135
8010772f:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107734:	e9 dd f4 ff ff       	jmp    80106c16 <alltraps>

80107739 <vector136>:
.globl vector136
vector136:
  pushl $0
80107739:	6a 00                	push   $0x0
  pushl $136
8010773b:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80107740:	e9 d1 f4 ff ff       	jmp    80106c16 <alltraps>

80107745 <vector137>:
.globl vector137
vector137:
  pushl $0
80107745:	6a 00                	push   $0x0
  pushl $137
80107747:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010774c:	e9 c5 f4 ff ff       	jmp    80106c16 <alltraps>

80107751 <vector138>:
.globl vector138
vector138:
  pushl $0
80107751:	6a 00                	push   $0x0
  pushl $138
80107753:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107758:	e9 b9 f4 ff ff       	jmp    80106c16 <alltraps>

8010775d <vector139>:
.globl vector139
vector139:
  pushl $0
8010775d:	6a 00                	push   $0x0
  pushl $139
8010775f:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107764:	e9 ad f4 ff ff       	jmp    80106c16 <alltraps>

80107769 <vector140>:
.globl vector140
vector140:
  pushl $0
80107769:	6a 00                	push   $0x0
  pushl $140
8010776b:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80107770:	e9 a1 f4 ff ff       	jmp    80106c16 <alltraps>

80107775 <vector141>:
.globl vector141
vector141:
  pushl $0
80107775:	6a 00                	push   $0x0
  pushl $141
80107777:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010777c:	e9 95 f4 ff ff       	jmp    80106c16 <alltraps>

80107781 <vector142>:
.globl vector142
vector142:
  pushl $0
80107781:	6a 00                	push   $0x0
  pushl $142
80107783:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107788:	e9 89 f4 ff ff       	jmp    80106c16 <alltraps>

8010778d <vector143>:
.globl vector143
vector143:
  pushl $0
8010778d:	6a 00                	push   $0x0
  pushl $143
8010778f:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107794:	e9 7d f4 ff ff       	jmp    80106c16 <alltraps>

80107799 <vector144>:
.globl vector144
vector144:
  pushl $0
80107799:	6a 00                	push   $0x0
  pushl $144
8010779b:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801077a0:	e9 71 f4 ff ff       	jmp    80106c16 <alltraps>

801077a5 <vector145>:
.globl vector145
vector145:
  pushl $0
801077a5:	6a 00                	push   $0x0
  pushl $145
801077a7:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801077ac:	e9 65 f4 ff ff       	jmp    80106c16 <alltraps>

801077b1 <vector146>:
.globl vector146
vector146:
  pushl $0
801077b1:	6a 00                	push   $0x0
  pushl $146
801077b3:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801077b8:	e9 59 f4 ff ff       	jmp    80106c16 <alltraps>

801077bd <vector147>:
.globl vector147
vector147:
  pushl $0
801077bd:	6a 00                	push   $0x0
  pushl $147
801077bf:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801077c4:	e9 4d f4 ff ff       	jmp    80106c16 <alltraps>

801077c9 <vector148>:
.globl vector148
vector148:
  pushl $0
801077c9:	6a 00                	push   $0x0
  pushl $148
801077cb:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801077d0:	e9 41 f4 ff ff       	jmp    80106c16 <alltraps>

801077d5 <vector149>:
.globl vector149
vector149:
  pushl $0
801077d5:	6a 00                	push   $0x0
  pushl $149
801077d7:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801077dc:	e9 35 f4 ff ff       	jmp    80106c16 <alltraps>

801077e1 <vector150>:
.globl vector150
vector150:
  pushl $0
801077e1:	6a 00                	push   $0x0
  pushl $150
801077e3:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801077e8:	e9 29 f4 ff ff       	jmp    80106c16 <alltraps>

801077ed <vector151>:
.globl vector151
vector151:
  pushl $0
801077ed:	6a 00                	push   $0x0
  pushl $151
801077ef:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801077f4:	e9 1d f4 ff ff       	jmp    80106c16 <alltraps>

801077f9 <vector152>:
.globl vector152
vector152:
  pushl $0
801077f9:	6a 00                	push   $0x0
  pushl $152
801077fb:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80107800:	e9 11 f4 ff ff       	jmp    80106c16 <alltraps>

80107805 <vector153>:
.globl vector153
vector153:
  pushl $0
80107805:	6a 00                	push   $0x0
  pushl $153
80107807:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010780c:	e9 05 f4 ff ff       	jmp    80106c16 <alltraps>

80107811 <vector154>:
.globl vector154
vector154:
  pushl $0
80107811:	6a 00                	push   $0x0
  pushl $154
80107813:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107818:	e9 f9 f3 ff ff       	jmp    80106c16 <alltraps>

8010781d <vector155>:
.globl vector155
vector155:
  pushl $0
8010781d:	6a 00                	push   $0x0
  pushl $155
8010781f:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107824:	e9 ed f3 ff ff       	jmp    80106c16 <alltraps>

80107829 <vector156>:
.globl vector156
vector156:
  pushl $0
80107829:	6a 00                	push   $0x0
  pushl $156
8010782b:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80107830:	e9 e1 f3 ff ff       	jmp    80106c16 <alltraps>

80107835 <vector157>:
.globl vector157
vector157:
  pushl $0
80107835:	6a 00                	push   $0x0
  pushl $157
80107837:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010783c:	e9 d5 f3 ff ff       	jmp    80106c16 <alltraps>

80107841 <vector158>:
.globl vector158
vector158:
  pushl $0
80107841:	6a 00                	push   $0x0
  pushl $158
80107843:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107848:	e9 c9 f3 ff ff       	jmp    80106c16 <alltraps>

8010784d <vector159>:
.globl vector159
vector159:
  pushl $0
8010784d:	6a 00                	push   $0x0
  pushl $159
8010784f:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107854:	e9 bd f3 ff ff       	jmp    80106c16 <alltraps>

80107859 <vector160>:
.globl vector160
vector160:
  pushl $0
80107859:	6a 00                	push   $0x0
  pushl $160
8010785b:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80107860:	e9 b1 f3 ff ff       	jmp    80106c16 <alltraps>

80107865 <vector161>:
.globl vector161
vector161:
  pushl $0
80107865:	6a 00                	push   $0x0
  pushl $161
80107867:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010786c:	e9 a5 f3 ff ff       	jmp    80106c16 <alltraps>

80107871 <vector162>:
.globl vector162
vector162:
  pushl $0
80107871:	6a 00                	push   $0x0
  pushl $162
80107873:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107878:	e9 99 f3 ff ff       	jmp    80106c16 <alltraps>

8010787d <vector163>:
.globl vector163
vector163:
  pushl $0
8010787d:	6a 00                	push   $0x0
  pushl $163
8010787f:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107884:	e9 8d f3 ff ff       	jmp    80106c16 <alltraps>

80107889 <vector164>:
.globl vector164
vector164:
  pushl $0
80107889:	6a 00                	push   $0x0
  pushl $164
8010788b:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80107890:	e9 81 f3 ff ff       	jmp    80106c16 <alltraps>

80107895 <vector165>:
.globl vector165
vector165:
  pushl $0
80107895:	6a 00                	push   $0x0
  pushl $165
80107897:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010789c:	e9 75 f3 ff ff       	jmp    80106c16 <alltraps>

801078a1 <vector166>:
.globl vector166
vector166:
  pushl $0
801078a1:	6a 00                	push   $0x0
  pushl $166
801078a3:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801078a8:	e9 69 f3 ff ff       	jmp    80106c16 <alltraps>

801078ad <vector167>:
.globl vector167
vector167:
  pushl $0
801078ad:	6a 00                	push   $0x0
  pushl $167
801078af:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801078b4:	e9 5d f3 ff ff       	jmp    80106c16 <alltraps>

801078b9 <vector168>:
.globl vector168
vector168:
  pushl $0
801078b9:	6a 00                	push   $0x0
  pushl $168
801078bb:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801078c0:	e9 51 f3 ff ff       	jmp    80106c16 <alltraps>

801078c5 <vector169>:
.globl vector169
vector169:
  pushl $0
801078c5:	6a 00                	push   $0x0
  pushl $169
801078c7:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801078cc:	e9 45 f3 ff ff       	jmp    80106c16 <alltraps>

801078d1 <vector170>:
.globl vector170
vector170:
  pushl $0
801078d1:	6a 00                	push   $0x0
  pushl $170
801078d3:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801078d8:	e9 39 f3 ff ff       	jmp    80106c16 <alltraps>

801078dd <vector171>:
.globl vector171
vector171:
  pushl $0
801078dd:	6a 00                	push   $0x0
  pushl $171
801078df:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801078e4:	e9 2d f3 ff ff       	jmp    80106c16 <alltraps>

801078e9 <vector172>:
.globl vector172
vector172:
  pushl $0
801078e9:	6a 00                	push   $0x0
  pushl $172
801078eb:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801078f0:	e9 21 f3 ff ff       	jmp    80106c16 <alltraps>

801078f5 <vector173>:
.globl vector173
vector173:
  pushl $0
801078f5:	6a 00                	push   $0x0
  pushl $173
801078f7:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801078fc:	e9 15 f3 ff ff       	jmp    80106c16 <alltraps>

80107901 <vector174>:
.globl vector174
vector174:
  pushl $0
80107901:	6a 00                	push   $0x0
  pushl $174
80107903:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107908:	e9 09 f3 ff ff       	jmp    80106c16 <alltraps>

8010790d <vector175>:
.globl vector175
vector175:
  pushl $0
8010790d:	6a 00                	push   $0x0
  pushl $175
8010790f:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107914:	e9 fd f2 ff ff       	jmp    80106c16 <alltraps>

80107919 <vector176>:
.globl vector176
vector176:
  pushl $0
80107919:	6a 00                	push   $0x0
  pushl $176
8010791b:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80107920:	e9 f1 f2 ff ff       	jmp    80106c16 <alltraps>

80107925 <vector177>:
.globl vector177
vector177:
  pushl $0
80107925:	6a 00                	push   $0x0
  pushl $177
80107927:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010792c:	e9 e5 f2 ff ff       	jmp    80106c16 <alltraps>

80107931 <vector178>:
.globl vector178
vector178:
  pushl $0
80107931:	6a 00                	push   $0x0
  pushl $178
80107933:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107938:	e9 d9 f2 ff ff       	jmp    80106c16 <alltraps>

8010793d <vector179>:
.globl vector179
vector179:
  pushl $0
8010793d:	6a 00                	push   $0x0
  pushl $179
8010793f:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107944:	e9 cd f2 ff ff       	jmp    80106c16 <alltraps>

80107949 <vector180>:
.globl vector180
vector180:
  pushl $0
80107949:	6a 00                	push   $0x0
  pushl $180
8010794b:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80107950:	e9 c1 f2 ff ff       	jmp    80106c16 <alltraps>

80107955 <vector181>:
.globl vector181
vector181:
  pushl $0
80107955:	6a 00                	push   $0x0
  pushl $181
80107957:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010795c:	e9 b5 f2 ff ff       	jmp    80106c16 <alltraps>

80107961 <vector182>:
.globl vector182
vector182:
  pushl $0
80107961:	6a 00                	push   $0x0
  pushl $182
80107963:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107968:	e9 a9 f2 ff ff       	jmp    80106c16 <alltraps>

8010796d <vector183>:
.globl vector183
vector183:
  pushl $0
8010796d:	6a 00                	push   $0x0
  pushl $183
8010796f:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107974:	e9 9d f2 ff ff       	jmp    80106c16 <alltraps>

80107979 <vector184>:
.globl vector184
vector184:
  pushl $0
80107979:	6a 00                	push   $0x0
  pushl $184
8010797b:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80107980:	e9 91 f2 ff ff       	jmp    80106c16 <alltraps>

80107985 <vector185>:
.globl vector185
vector185:
  pushl $0
80107985:	6a 00                	push   $0x0
  pushl $185
80107987:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010798c:	e9 85 f2 ff ff       	jmp    80106c16 <alltraps>

80107991 <vector186>:
.globl vector186
vector186:
  pushl $0
80107991:	6a 00                	push   $0x0
  pushl $186
80107993:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107998:	e9 79 f2 ff ff       	jmp    80106c16 <alltraps>

8010799d <vector187>:
.globl vector187
vector187:
  pushl $0
8010799d:	6a 00                	push   $0x0
  pushl $187
8010799f:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801079a4:	e9 6d f2 ff ff       	jmp    80106c16 <alltraps>

801079a9 <vector188>:
.globl vector188
vector188:
  pushl $0
801079a9:	6a 00                	push   $0x0
  pushl $188
801079ab:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801079b0:	e9 61 f2 ff ff       	jmp    80106c16 <alltraps>

801079b5 <vector189>:
.globl vector189
vector189:
  pushl $0
801079b5:	6a 00                	push   $0x0
  pushl $189
801079b7:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801079bc:	e9 55 f2 ff ff       	jmp    80106c16 <alltraps>

801079c1 <vector190>:
.globl vector190
vector190:
  pushl $0
801079c1:	6a 00                	push   $0x0
  pushl $190
801079c3:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801079c8:	e9 49 f2 ff ff       	jmp    80106c16 <alltraps>

801079cd <vector191>:
.globl vector191
vector191:
  pushl $0
801079cd:	6a 00                	push   $0x0
  pushl $191
801079cf:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801079d4:	e9 3d f2 ff ff       	jmp    80106c16 <alltraps>

801079d9 <vector192>:
.globl vector192
vector192:
  pushl $0
801079d9:	6a 00                	push   $0x0
  pushl $192
801079db:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801079e0:	e9 31 f2 ff ff       	jmp    80106c16 <alltraps>

801079e5 <vector193>:
.globl vector193
vector193:
  pushl $0
801079e5:	6a 00                	push   $0x0
  pushl $193
801079e7:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801079ec:	e9 25 f2 ff ff       	jmp    80106c16 <alltraps>

801079f1 <vector194>:
.globl vector194
vector194:
  pushl $0
801079f1:	6a 00                	push   $0x0
  pushl $194
801079f3:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801079f8:	e9 19 f2 ff ff       	jmp    80106c16 <alltraps>

801079fd <vector195>:
.globl vector195
vector195:
  pushl $0
801079fd:	6a 00                	push   $0x0
  pushl $195
801079ff:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107a04:	e9 0d f2 ff ff       	jmp    80106c16 <alltraps>

80107a09 <vector196>:
.globl vector196
vector196:
  pushl $0
80107a09:	6a 00                	push   $0x0
  pushl $196
80107a0b:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80107a10:	e9 01 f2 ff ff       	jmp    80106c16 <alltraps>

80107a15 <vector197>:
.globl vector197
vector197:
  pushl $0
80107a15:	6a 00                	push   $0x0
  pushl $197
80107a17:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80107a1c:	e9 f5 f1 ff ff       	jmp    80106c16 <alltraps>

80107a21 <vector198>:
.globl vector198
vector198:
  pushl $0
80107a21:	6a 00                	push   $0x0
  pushl $198
80107a23:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107a28:	e9 e9 f1 ff ff       	jmp    80106c16 <alltraps>

80107a2d <vector199>:
.globl vector199
vector199:
  pushl $0
80107a2d:	6a 00                	push   $0x0
  pushl $199
80107a2f:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107a34:	e9 dd f1 ff ff       	jmp    80106c16 <alltraps>

80107a39 <vector200>:
.globl vector200
vector200:
  pushl $0
80107a39:	6a 00                	push   $0x0
  pushl $200
80107a3b:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80107a40:	e9 d1 f1 ff ff       	jmp    80106c16 <alltraps>

80107a45 <vector201>:
.globl vector201
vector201:
  pushl $0
80107a45:	6a 00                	push   $0x0
  pushl $201
80107a47:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107a4c:	e9 c5 f1 ff ff       	jmp    80106c16 <alltraps>

80107a51 <vector202>:
.globl vector202
vector202:
  pushl $0
80107a51:	6a 00                	push   $0x0
  pushl $202
80107a53:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107a58:	e9 b9 f1 ff ff       	jmp    80106c16 <alltraps>

80107a5d <vector203>:
.globl vector203
vector203:
  pushl $0
80107a5d:	6a 00                	push   $0x0
  pushl $203
80107a5f:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107a64:	e9 ad f1 ff ff       	jmp    80106c16 <alltraps>

80107a69 <vector204>:
.globl vector204
vector204:
  pushl $0
80107a69:	6a 00                	push   $0x0
  pushl $204
80107a6b:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80107a70:	e9 a1 f1 ff ff       	jmp    80106c16 <alltraps>

80107a75 <vector205>:
.globl vector205
vector205:
  pushl $0
80107a75:	6a 00                	push   $0x0
  pushl $205
80107a77:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107a7c:	e9 95 f1 ff ff       	jmp    80106c16 <alltraps>

80107a81 <vector206>:
.globl vector206
vector206:
  pushl $0
80107a81:	6a 00                	push   $0x0
  pushl $206
80107a83:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107a88:	e9 89 f1 ff ff       	jmp    80106c16 <alltraps>

80107a8d <vector207>:
.globl vector207
vector207:
  pushl $0
80107a8d:	6a 00                	push   $0x0
  pushl $207
80107a8f:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107a94:	e9 7d f1 ff ff       	jmp    80106c16 <alltraps>

80107a99 <vector208>:
.globl vector208
vector208:
  pushl $0
80107a99:	6a 00                	push   $0x0
  pushl $208
80107a9b:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107aa0:	e9 71 f1 ff ff       	jmp    80106c16 <alltraps>

80107aa5 <vector209>:
.globl vector209
vector209:
  pushl $0
80107aa5:	6a 00                	push   $0x0
  pushl $209
80107aa7:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107aac:	e9 65 f1 ff ff       	jmp    80106c16 <alltraps>

80107ab1 <vector210>:
.globl vector210
vector210:
  pushl $0
80107ab1:	6a 00                	push   $0x0
  pushl $210
80107ab3:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107ab8:	e9 59 f1 ff ff       	jmp    80106c16 <alltraps>

80107abd <vector211>:
.globl vector211
vector211:
  pushl $0
80107abd:	6a 00                	push   $0x0
  pushl $211
80107abf:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107ac4:	e9 4d f1 ff ff       	jmp    80106c16 <alltraps>

80107ac9 <vector212>:
.globl vector212
vector212:
  pushl $0
80107ac9:	6a 00                	push   $0x0
  pushl $212
80107acb:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107ad0:	e9 41 f1 ff ff       	jmp    80106c16 <alltraps>

80107ad5 <vector213>:
.globl vector213
vector213:
  pushl $0
80107ad5:	6a 00                	push   $0x0
  pushl $213
80107ad7:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107adc:	e9 35 f1 ff ff       	jmp    80106c16 <alltraps>

80107ae1 <vector214>:
.globl vector214
vector214:
  pushl $0
80107ae1:	6a 00                	push   $0x0
  pushl $214
80107ae3:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107ae8:	e9 29 f1 ff ff       	jmp    80106c16 <alltraps>

80107aed <vector215>:
.globl vector215
vector215:
  pushl $0
80107aed:	6a 00                	push   $0x0
  pushl $215
80107aef:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107af4:	e9 1d f1 ff ff       	jmp    80106c16 <alltraps>

80107af9 <vector216>:
.globl vector216
vector216:
  pushl $0
80107af9:	6a 00                	push   $0x0
  pushl $216
80107afb:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107b00:	e9 11 f1 ff ff       	jmp    80106c16 <alltraps>

80107b05 <vector217>:
.globl vector217
vector217:
  pushl $0
80107b05:	6a 00                	push   $0x0
  pushl $217
80107b07:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80107b0c:	e9 05 f1 ff ff       	jmp    80106c16 <alltraps>

80107b11 <vector218>:
.globl vector218
vector218:
  pushl $0
80107b11:	6a 00                	push   $0x0
  pushl $218
80107b13:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107b18:	e9 f9 f0 ff ff       	jmp    80106c16 <alltraps>

80107b1d <vector219>:
.globl vector219
vector219:
  pushl $0
80107b1d:	6a 00                	push   $0x0
  pushl $219
80107b1f:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107b24:	e9 ed f0 ff ff       	jmp    80106c16 <alltraps>

80107b29 <vector220>:
.globl vector220
vector220:
  pushl $0
80107b29:	6a 00                	push   $0x0
  pushl $220
80107b2b:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107b30:	e9 e1 f0 ff ff       	jmp    80106c16 <alltraps>

80107b35 <vector221>:
.globl vector221
vector221:
  pushl $0
80107b35:	6a 00                	push   $0x0
  pushl $221
80107b37:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107b3c:	e9 d5 f0 ff ff       	jmp    80106c16 <alltraps>

80107b41 <vector222>:
.globl vector222
vector222:
  pushl $0
80107b41:	6a 00                	push   $0x0
  pushl $222
80107b43:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107b48:	e9 c9 f0 ff ff       	jmp    80106c16 <alltraps>

80107b4d <vector223>:
.globl vector223
vector223:
  pushl $0
80107b4d:	6a 00                	push   $0x0
  pushl $223
80107b4f:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107b54:	e9 bd f0 ff ff       	jmp    80106c16 <alltraps>

80107b59 <vector224>:
.globl vector224
vector224:
  pushl $0
80107b59:	6a 00                	push   $0x0
  pushl $224
80107b5b:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80107b60:	e9 b1 f0 ff ff       	jmp    80106c16 <alltraps>

80107b65 <vector225>:
.globl vector225
vector225:
  pushl $0
80107b65:	6a 00                	push   $0x0
  pushl $225
80107b67:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107b6c:	e9 a5 f0 ff ff       	jmp    80106c16 <alltraps>

80107b71 <vector226>:
.globl vector226
vector226:
  pushl $0
80107b71:	6a 00                	push   $0x0
  pushl $226
80107b73:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107b78:	e9 99 f0 ff ff       	jmp    80106c16 <alltraps>

80107b7d <vector227>:
.globl vector227
vector227:
  pushl $0
80107b7d:	6a 00                	push   $0x0
  pushl $227
80107b7f:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107b84:	e9 8d f0 ff ff       	jmp    80106c16 <alltraps>

80107b89 <vector228>:
.globl vector228
vector228:
  pushl $0
80107b89:	6a 00                	push   $0x0
  pushl $228
80107b8b:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107b90:	e9 81 f0 ff ff       	jmp    80106c16 <alltraps>

80107b95 <vector229>:
.globl vector229
vector229:
  pushl $0
80107b95:	6a 00                	push   $0x0
  pushl $229
80107b97:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107b9c:	e9 75 f0 ff ff       	jmp    80106c16 <alltraps>

80107ba1 <vector230>:
.globl vector230
vector230:
  pushl $0
80107ba1:	6a 00                	push   $0x0
  pushl $230
80107ba3:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107ba8:	e9 69 f0 ff ff       	jmp    80106c16 <alltraps>

80107bad <vector231>:
.globl vector231
vector231:
  pushl $0
80107bad:	6a 00                	push   $0x0
  pushl $231
80107baf:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107bb4:	e9 5d f0 ff ff       	jmp    80106c16 <alltraps>

80107bb9 <vector232>:
.globl vector232
vector232:
  pushl $0
80107bb9:	6a 00                	push   $0x0
  pushl $232
80107bbb:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107bc0:	e9 51 f0 ff ff       	jmp    80106c16 <alltraps>

80107bc5 <vector233>:
.globl vector233
vector233:
  pushl $0
80107bc5:	6a 00                	push   $0x0
  pushl $233
80107bc7:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107bcc:	e9 45 f0 ff ff       	jmp    80106c16 <alltraps>

80107bd1 <vector234>:
.globl vector234
vector234:
  pushl $0
80107bd1:	6a 00                	push   $0x0
  pushl $234
80107bd3:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107bd8:	e9 39 f0 ff ff       	jmp    80106c16 <alltraps>

80107bdd <vector235>:
.globl vector235
vector235:
  pushl $0
80107bdd:	6a 00                	push   $0x0
  pushl $235
80107bdf:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107be4:	e9 2d f0 ff ff       	jmp    80106c16 <alltraps>

80107be9 <vector236>:
.globl vector236
vector236:
  pushl $0
80107be9:	6a 00                	push   $0x0
  pushl $236
80107beb:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107bf0:	e9 21 f0 ff ff       	jmp    80106c16 <alltraps>

80107bf5 <vector237>:
.globl vector237
vector237:
  pushl $0
80107bf5:	6a 00                	push   $0x0
  pushl $237
80107bf7:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107bfc:	e9 15 f0 ff ff       	jmp    80106c16 <alltraps>

80107c01 <vector238>:
.globl vector238
vector238:
  pushl $0
80107c01:	6a 00                	push   $0x0
  pushl $238
80107c03:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107c08:	e9 09 f0 ff ff       	jmp    80106c16 <alltraps>

80107c0d <vector239>:
.globl vector239
vector239:
  pushl $0
80107c0d:	6a 00                	push   $0x0
  pushl $239
80107c0f:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107c14:	e9 fd ef ff ff       	jmp    80106c16 <alltraps>

80107c19 <vector240>:
.globl vector240
vector240:
  pushl $0
80107c19:	6a 00                	push   $0x0
  pushl $240
80107c1b:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107c20:	e9 f1 ef ff ff       	jmp    80106c16 <alltraps>

80107c25 <vector241>:
.globl vector241
vector241:
  pushl $0
80107c25:	6a 00                	push   $0x0
  pushl $241
80107c27:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107c2c:	e9 e5 ef ff ff       	jmp    80106c16 <alltraps>

80107c31 <vector242>:
.globl vector242
vector242:
  pushl $0
80107c31:	6a 00                	push   $0x0
  pushl $242
80107c33:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107c38:	e9 d9 ef ff ff       	jmp    80106c16 <alltraps>

80107c3d <vector243>:
.globl vector243
vector243:
  pushl $0
80107c3d:	6a 00                	push   $0x0
  pushl $243
80107c3f:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107c44:	e9 cd ef ff ff       	jmp    80106c16 <alltraps>

80107c49 <vector244>:
.globl vector244
vector244:
  pushl $0
80107c49:	6a 00                	push   $0x0
  pushl $244
80107c4b:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107c50:	e9 c1 ef ff ff       	jmp    80106c16 <alltraps>

80107c55 <vector245>:
.globl vector245
vector245:
  pushl $0
80107c55:	6a 00                	push   $0x0
  pushl $245
80107c57:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107c5c:	e9 b5 ef ff ff       	jmp    80106c16 <alltraps>

80107c61 <vector246>:
.globl vector246
vector246:
  pushl $0
80107c61:	6a 00                	push   $0x0
  pushl $246
80107c63:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107c68:	e9 a9 ef ff ff       	jmp    80106c16 <alltraps>

80107c6d <vector247>:
.globl vector247
vector247:
  pushl $0
80107c6d:	6a 00                	push   $0x0
  pushl $247
80107c6f:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107c74:	e9 9d ef ff ff       	jmp    80106c16 <alltraps>

80107c79 <vector248>:
.globl vector248
vector248:
  pushl $0
80107c79:	6a 00                	push   $0x0
  pushl $248
80107c7b:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107c80:	e9 91 ef ff ff       	jmp    80106c16 <alltraps>

80107c85 <vector249>:
.globl vector249
vector249:
  pushl $0
80107c85:	6a 00                	push   $0x0
  pushl $249
80107c87:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107c8c:	e9 85 ef ff ff       	jmp    80106c16 <alltraps>

80107c91 <vector250>:
.globl vector250
vector250:
  pushl $0
80107c91:	6a 00                	push   $0x0
  pushl $250
80107c93:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107c98:	e9 79 ef ff ff       	jmp    80106c16 <alltraps>

80107c9d <vector251>:
.globl vector251
vector251:
  pushl $0
80107c9d:	6a 00                	push   $0x0
  pushl $251
80107c9f:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107ca4:	e9 6d ef ff ff       	jmp    80106c16 <alltraps>

80107ca9 <vector252>:
.globl vector252
vector252:
  pushl $0
80107ca9:	6a 00                	push   $0x0
  pushl $252
80107cab:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107cb0:	e9 61 ef ff ff       	jmp    80106c16 <alltraps>

80107cb5 <vector253>:
.globl vector253
vector253:
  pushl $0
80107cb5:	6a 00                	push   $0x0
  pushl $253
80107cb7:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107cbc:	e9 55 ef ff ff       	jmp    80106c16 <alltraps>

80107cc1 <vector254>:
.globl vector254
vector254:
  pushl $0
80107cc1:	6a 00                	push   $0x0
  pushl $254
80107cc3:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107cc8:	e9 49 ef ff ff       	jmp    80106c16 <alltraps>

80107ccd <vector255>:
.globl vector255
vector255:
  pushl $0
80107ccd:	6a 00                	push   $0x0
  pushl $255
80107ccf:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107cd4:	e9 3d ef ff ff       	jmp    80106c16 <alltraps>

80107cd9 <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
80107cd9:	55                   	push   %ebp
80107cda:	89 e5                	mov    %esp,%ebp
80107cdc:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80107cdf:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ce2:	83 e8 01             	sub    $0x1,%eax
80107ce5:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80107ce9:	8b 45 08             	mov    0x8(%ebp),%eax
80107cec:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80107cf0:	8b 45 08             	mov    0x8(%ebp),%eax
80107cf3:	c1 e8 10             	shr    $0x10,%eax
80107cf6:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80107cfa:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107cfd:	0f 01 10             	lgdtl  (%eax)
}
80107d00:	90                   	nop
80107d01:	c9                   	leave  
80107d02:	c3                   	ret    

80107d03 <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
80107d03:	55                   	push   %ebp
80107d04:	89 e5                	mov    %esp,%ebp
80107d06:	83 ec 04             	sub    $0x4,%esp
80107d09:	8b 45 08             	mov    0x8(%ebp),%eax
80107d0c:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
80107d10:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107d14:	0f 00 d8             	ltr    %ax
}
80107d17:	90                   	nop
80107d18:	c9                   	leave  
80107d19:	c3                   	ret    

80107d1a <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
80107d1a:	55                   	push   %ebp
80107d1b:	89 e5                	mov    %esp,%ebp
80107d1d:	83 ec 04             	sub    $0x4,%esp
80107d20:	8b 45 08             	mov    0x8(%ebp),%eax
80107d23:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
80107d27:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107d2b:	8e e8                	mov    %eax,%gs
}
80107d2d:	90                   	nop
80107d2e:	c9                   	leave  
80107d2f:	c3                   	ret    

80107d30 <lcr3>:
  return val;
}

static inline void
lcr3(uint val) 
{
80107d30:	55                   	push   %ebp
80107d31:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107d33:	8b 45 08             	mov    0x8(%ebp),%eax
80107d36:	0f 22 d8             	mov    %eax,%cr3
}
80107d39:	90                   	nop
80107d3a:	5d                   	pop    %ebp
80107d3b:	c3                   	ret    

80107d3c <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80107d3c:	55                   	push   %ebp
80107d3d:	89 e5                	mov    %esp,%ebp
80107d3f:	8b 45 08             	mov    0x8(%ebp),%eax
80107d42:	05 00 00 00 80       	add    $0x80000000,%eax
80107d47:	5d                   	pop    %ebp
80107d48:	c3                   	ret    

80107d49 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80107d49:	55                   	push   %ebp
80107d4a:	89 e5                	mov    %esp,%ebp
80107d4c:	8b 45 08             	mov    0x8(%ebp),%eax
80107d4f:	05 00 00 00 80       	add    $0x80000000,%eax
80107d54:	5d                   	pop    %ebp
80107d55:	c3                   	ret    

80107d56 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80107d56:	55                   	push   %ebp
80107d57:	89 e5                	mov    %esp,%ebp
80107d59:	53                   	push   %ebx
80107d5a:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80107d5d:	e8 6a b2 ff ff       	call   80102fcc <cpunum>
80107d62:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80107d68:	05 60 33 11 80       	add    $0x80113360,%eax
80107d6d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107d70:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d73:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
80107d79:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d7c:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
80107d82:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d85:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
80107d89:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d8c:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107d90:	83 e2 f0             	and    $0xfffffff0,%edx
80107d93:	83 ca 0a             	or     $0xa,%edx
80107d96:	88 50 7d             	mov    %dl,0x7d(%eax)
80107d99:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d9c:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107da0:	83 ca 10             	or     $0x10,%edx
80107da3:	88 50 7d             	mov    %dl,0x7d(%eax)
80107da6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107da9:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107dad:	83 e2 9f             	and    $0xffffff9f,%edx
80107db0:	88 50 7d             	mov    %dl,0x7d(%eax)
80107db3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107db6:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107dba:	83 ca 80             	or     $0xffffff80,%edx
80107dbd:	88 50 7d             	mov    %dl,0x7d(%eax)
80107dc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dc3:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107dc7:	83 ca 0f             	or     $0xf,%edx
80107dca:	88 50 7e             	mov    %dl,0x7e(%eax)
80107dcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dd0:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107dd4:	83 e2 ef             	and    $0xffffffef,%edx
80107dd7:	88 50 7e             	mov    %dl,0x7e(%eax)
80107dda:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ddd:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107de1:	83 e2 df             	and    $0xffffffdf,%edx
80107de4:	88 50 7e             	mov    %dl,0x7e(%eax)
80107de7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dea:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107dee:	83 ca 40             	or     $0x40,%edx
80107df1:	88 50 7e             	mov    %dl,0x7e(%eax)
80107df4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107df7:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107dfb:	83 ca 80             	or     $0xffffff80,%edx
80107dfe:	88 50 7e             	mov    %dl,0x7e(%eax)
80107e01:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e04:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107e08:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e0b:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
80107e12:	ff ff 
80107e14:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e17:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80107e1e:	00 00 
80107e20:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e23:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80107e2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e2d:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107e34:	83 e2 f0             	and    $0xfffffff0,%edx
80107e37:	83 ca 02             	or     $0x2,%edx
80107e3a:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107e40:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e43:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107e4a:	83 ca 10             	or     $0x10,%edx
80107e4d:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107e53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e56:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107e5d:	83 e2 9f             	and    $0xffffff9f,%edx
80107e60:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107e66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e69:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107e70:	83 ca 80             	or     $0xffffff80,%edx
80107e73:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107e79:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e7c:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107e83:	83 ca 0f             	or     $0xf,%edx
80107e86:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107e8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e8f:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107e96:	83 e2 ef             	and    $0xffffffef,%edx
80107e99:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107e9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ea2:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107ea9:	83 e2 df             	and    $0xffffffdf,%edx
80107eac:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107eb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107eb5:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107ebc:	83 ca 40             	or     $0x40,%edx
80107ebf:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107ec5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ec8:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107ecf:	83 ca 80             	or     $0xffffff80,%edx
80107ed2:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107ed8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107edb:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107ee2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ee5:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80107eec:	ff ff 
80107eee:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ef1:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80107ef8:	00 00 
80107efa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107efd:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80107f04:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f07:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107f0e:	83 e2 f0             	and    $0xfffffff0,%edx
80107f11:	83 ca 0a             	or     $0xa,%edx
80107f14:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107f1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f1d:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107f24:	83 ca 10             	or     $0x10,%edx
80107f27:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107f2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f30:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107f37:	83 ca 60             	or     $0x60,%edx
80107f3a:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107f40:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f43:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107f4a:	83 ca 80             	or     $0xffffff80,%edx
80107f4d:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107f53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f56:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107f5d:	83 ca 0f             	or     $0xf,%edx
80107f60:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107f66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f69:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107f70:	83 e2 ef             	and    $0xffffffef,%edx
80107f73:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107f79:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f7c:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107f83:	83 e2 df             	and    $0xffffffdf,%edx
80107f86:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107f8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f8f:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107f96:	83 ca 40             	or     $0x40,%edx
80107f99:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107f9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fa2:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107fa9:	83 ca 80             	or     $0xffffff80,%edx
80107fac:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107fb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fb5:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107fbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fbf:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107fc6:	ff ff 
80107fc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fcb:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80107fd2:	00 00 
80107fd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fd7:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107fde:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fe1:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107fe8:	83 e2 f0             	and    $0xfffffff0,%edx
80107feb:	83 ca 02             	or     $0x2,%edx
80107fee:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107ff4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ff7:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107ffe:	83 ca 10             	or     $0x10,%edx
80108001:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80108007:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010800a:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80108011:	83 ca 60             	or     $0x60,%edx
80108014:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
8010801a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010801d:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80108024:	83 ca 80             	or     $0xffffff80,%edx
80108027:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
8010802d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108030:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80108037:	83 ca 0f             	or     $0xf,%edx
8010803a:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80108040:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108043:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
8010804a:	83 e2 ef             	and    $0xffffffef,%edx
8010804d:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80108053:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108056:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
8010805d:	83 e2 df             	and    $0xffffffdf,%edx
80108060:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80108066:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108069:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80108070:	83 ca 40             	or     $0x40,%edx
80108073:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80108079:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010807c:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80108083:	83 ca 80             	or     $0xffffff80,%edx
80108086:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
8010808c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010808f:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80108096:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108099:	05 b4 00 00 00       	add    $0xb4,%eax
8010809e:	89 c3                	mov    %eax,%ebx
801080a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080a3:	05 b4 00 00 00       	add    $0xb4,%eax
801080a8:	c1 e8 10             	shr    $0x10,%eax
801080ab:	89 c2                	mov    %eax,%edx
801080ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080b0:	05 b4 00 00 00       	add    $0xb4,%eax
801080b5:	c1 e8 18             	shr    $0x18,%eax
801080b8:	89 c1                	mov    %eax,%ecx
801080ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080bd:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
801080c4:	00 00 
801080c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080c9:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
801080d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080d3:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
801080d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080dc:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
801080e3:	83 e2 f0             	and    $0xfffffff0,%edx
801080e6:	83 ca 02             	or     $0x2,%edx
801080e9:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
801080ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080f2:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
801080f9:	83 ca 10             	or     $0x10,%edx
801080fc:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80108102:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108105:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
8010810c:	83 e2 9f             	and    $0xffffff9f,%edx
8010810f:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80108115:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108118:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
8010811f:	83 ca 80             	or     $0xffffff80,%edx
80108122:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80108128:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010812b:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80108132:	83 e2 f0             	and    $0xfffffff0,%edx
80108135:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
8010813b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010813e:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80108145:	83 e2 ef             	and    $0xffffffef,%edx
80108148:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
8010814e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108151:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80108158:	83 e2 df             	and    $0xffffffdf,%edx
8010815b:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80108161:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108164:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
8010816b:	83 ca 40             	or     $0x40,%edx
8010816e:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80108174:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108177:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
8010817e:	83 ca 80             	or     $0xffffff80,%edx
80108181:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80108187:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010818a:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80108190:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108193:	83 c0 70             	add    $0x70,%eax
80108196:	83 ec 08             	sub    $0x8,%esp
80108199:	6a 38                	push   $0x38
8010819b:	50                   	push   %eax
8010819c:	e8 38 fb ff ff       	call   80107cd9 <lgdt>
801081a1:	83 c4 10             	add    $0x10,%esp
  loadgs(SEG_KCPU << 3);
801081a4:	83 ec 0c             	sub    $0xc,%esp
801081a7:	6a 18                	push   $0x18
801081a9:	e8 6c fb ff ff       	call   80107d1a <loadgs>
801081ae:	83 c4 10             	add    $0x10,%esp
  
  // Initialize cpu-local storage.
  cpu = c;
801081b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081b4:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
801081ba:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
801081c1:	00 00 00 00 
}
801081c5:	90                   	nop
801081c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801081c9:	c9                   	leave  
801081ca:	c3                   	ret    

801081cb <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801081cb:	55                   	push   %ebp
801081cc:	89 e5                	mov    %esp,%ebp
801081ce:	83 ec 18             	sub    $0x18,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801081d1:	8b 45 0c             	mov    0xc(%ebp),%eax
801081d4:	c1 e8 16             	shr    $0x16,%eax
801081d7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801081de:	8b 45 08             	mov    0x8(%ebp),%eax
801081e1:	01 d0                	add    %edx,%eax
801081e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
801081e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801081e9:	8b 00                	mov    (%eax),%eax
801081eb:	83 e0 01             	and    $0x1,%eax
801081ee:	85 c0                	test   %eax,%eax
801081f0:	74 18                	je     8010820a <walkpgdir+0x3f>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
801081f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801081f5:	8b 00                	mov    (%eax),%eax
801081f7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801081fc:	50                   	push   %eax
801081fd:	e8 47 fb ff ff       	call   80107d49 <p2v>
80108202:	83 c4 04             	add    $0x4,%esp
80108205:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108208:	eb 48                	jmp    80108252 <walkpgdir+0x87>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
8010820a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010820e:	74 0e                	je     8010821e <walkpgdir+0x53>
80108210:	e8 51 aa ff ff       	call   80102c66 <kalloc>
80108215:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108218:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010821c:	75 07                	jne    80108225 <walkpgdir+0x5a>
      return 0;
8010821e:	b8 00 00 00 00       	mov    $0x0,%eax
80108223:	eb 44                	jmp    80108269 <walkpgdir+0x9e>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80108225:	83 ec 04             	sub    $0x4,%esp
80108228:	68 00 10 00 00       	push   $0x1000
8010822d:	6a 00                	push   $0x0
8010822f:	ff 75 f4             	pushl  -0xc(%ebp)
80108232:	e8 77 d5 ff ff       	call   801057ae <memset>
80108237:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
8010823a:	83 ec 0c             	sub    $0xc,%esp
8010823d:	ff 75 f4             	pushl  -0xc(%ebp)
80108240:	e8 f7 fa ff ff       	call   80107d3c <v2p>
80108245:	83 c4 10             	add    $0x10,%esp
80108248:	83 c8 07             	or     $0x7,%eax
8010824b:	89 c2                	mov    %eax,%edx
8010824d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108250:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80108252:	8b 45 0c             	mov    0xc(%ebp),%eax
80108255:	c1 e8 0c             	shr    $0xc,%eax
80108258:	25 ff 03 00 00       	and    $0x3ff,%eax
8010825d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108264:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108267:	01 d0                	add    %edx,%eax
}
80108269:	c9                   	leave  
8010826a:	c3                   	ret    

8010826b <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
8010826b:	55                   	push   %ebp
8010826c:	89 e5                	mov    %esp,%ebp
8010826e:	83 ec 18             	sub    $0x18,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
80108271:	8b 45 0c             	mov    0xc(%ebp),%eax
80108274:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108279:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010827c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010827f:	8b 45 10             	mov    0x10(%ebp),%eax
80108282:	01 d0                	add    %edx,%eax
80108284:	83 e8 01             	sub    $0x1,%eax
80108287:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010828c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
8010828f:	83 ec 04             	sub    $0x4,%esp
80108292:	6a 01                	push   $0x1
80108294:	ff 75 f4             	pushl  -0xc(%ebp)
80108297:	ff 75 08             	pushl  0x8(%ebp)
8010829a:	e8 2c ff ff ff       	call   801081cb <walkpgdir>
8010829f:	83 c4 10             	add    $0x10,%esp
801082a2:	89 45 ec             	mov    %eax,-0x14(%ebp)
801082a5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801082a9:	75 07                	jne    801082b2 <mappages+0x47>
      return -1;
801082ab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801082b0:	eb 47                	jmp    801082f9 <mappages+0x8e>
    if(*pte & PTE_P)
801082b2:	8b 45 ec             	mov    -0x14(%ebp),%eax
801082b5:	8b 00                	mov    (%eax),%eax
801082b7:	83 e0 01             	and    $0x1,%eax
801082ba:	85 c0                	test   %eax,%eax
801082bc:	74 0d                	je     801082cb <mappages+0x60>
      panic("remap");
801082be:	83 ec 0c             	sub    $0xc,%esp
801082c1:	68 2c 91 10 80       	push   $0x8010912c
801082c6:	e8 9b 82 ff ff       	call   80100566 <panic>
    *pte = pa | perm | PTE_P;
801082cb:	8b 45 18             	mov    0x18(%ebp),%eax
801082ce:	0b 45 14             	or     0x14(%ebp),%eax
801082d1:	83 c8 01             	or     $0x1,%eax
801082d4:	89 c2                	mov    %eax,%edx
801082d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801082d9:	89 10                	mov    %edx,(%eax)
    if(a == last)
801082db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082de:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801082e1:	74 10                	je     801082f3 <mappages+0x88>
      break;
    a += PGSIZE;
801082e3:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
801082ea:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
801082f1:	eb 9c                	jmp    8010828f <mappages+0x24>
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
801082f3:	90                   	nop
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
801082f4:	b8 00 00 00 00       	mov    $0x0,%eax
}
801082f9:	c9                   	leave  
801082fa:	c3                   	ret    

801082fb <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
801082fb:	55                   	push   %ebp
801082fc:	89 e5                	mov    %esp,%ebp
801082fe:	53                   	push   %ebx
801082ff:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80108302:	e8 5f a9 ff ff       	call   80102c66 <kalloc>
80108307:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010830a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010830e:	75 0a                	jne    8010831a <setupkvm+0x1f>
    return 0;
80108310:	b8 00 00 00 00       	mov    $0x0,%eax
80108315:	e9 8e 00 00 00       	jmp    801083a8 <setupkvm+0xad>
  memset(pgdir, 0, PGSIZE);
8010831a:	83 ec 04             	sub    $0x4,%esp
8010831d:	68 00 10 00 00       	push   $0x1000
80108322:	6a 00                	push   $0x0
80108324:	ff 75 f0             	pushl  -0x10(%ebp)
80108327:	e8 82 d4 ff ff       	call   801057ae <memset>
8010832c:	83 c4 10             	add    $0x10,%esp
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
8010832f:	83 ec 0c             	sub    $0xc,%esp
80108332:	68 00 00 00 0e       	push   $0xe000000
80108337:	e8 0d fa ff ff       	call   80107d49 <p2v>
8010833c:	83 c4 10             	add    $0x10,%esp
8010833f:	3d 00 00 00 fe       	cmp    $0xfe000000,%eax
80108344:	76 0d                	jbe    80108353 <setupkvm+0x58>
    panic("PHYSTOP too high");
80108346:	83 ec 0c             	sub    $0xc,%esp
80108349:	68 32 91 10 80       	push   $0x80109132
8010834e:	e8 13 82 ff ff       	call   80100566 <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108353:	c7 45 f4 a0 c4 10 80 	movl   $0x8010c4a0,-0xc(%ebp)
8010835a:	eb 40                	jmp    8010839c <setupkvm+0xa1>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
8010835c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010835f:	8b 48 0c             	mov    0xc(%eax),%ecx
                (uint)k->phys_start, k->perm) < 0)
80108362:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108365:	8b 50 04             	mov    0x4(%eax),%edx
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80108368:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010836b:	8b 58 08             	mov    0x8(%eax),%ebx
8010836e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108371:	8b 40 04             	mov    0x4(%eax),%eax
80108374:	29 c3                	sub    %eax,%ebx
80108376:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108379:	8b 00                	mov    (%eax),%eax
8010837b:	83 ec 0c             	sub    $0xc,%esp
8010837e:	51                   	push   %ecx
8010837f:	52                   	push   %edx
80108380:	53                   	push   %ebx
80108381:	50                   	push   %eax
80108382:	ff 75 f0             	pushl  -0x10(%ebp)
80108385:	e8 e1 fe ff ff       	call   8010826b <mappages>
8010838a:	83 c4 20             	add    $0x20,%esp
8010838d:	85 c0                	test   %eax,%eax
8010838f:	79 07                	jns    80108398 <setupkvm+0x9d>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
80108391:	b8 00 00 00 00       	mov    $0x0,%eax
80108396:	eb 10                	jmp    801083a8 <setupkvm+0xad>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108398:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
8010839c:	81 7d f4 e0 c4 10 80 	cmpl   $0x8010c4e0,-0xc(%ebp)
801083a3:	72 b7                	jb     8010835c <setupkvm+0x61>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
801083a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
801083a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801083ab:	c9                   	leave  
801083ac:	c3                   	ret    

801083ad <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
801083ad:	55                   	push   %ebp
801083ae:	89 e5                	mov    %esp,%ebp
801083b0:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801083b3:	e8 43 ff ff ff       	call   801082fb <setupkvm>
801083b8:	a3 78 68 11 80       	mov    %eax,0x80116878
  switchkvm();
801083bd:	e8 03 00 00 00       	call   801083c5 <switchkvm>
}
801083c2:	90                   	nop
801083c3:	c9                   	leave  
801083c4:	c3                   	ret    

801083c5 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
801083c5:	55                   	push   %ebp
801083c6:	89 e5                	mov    %esp,%ebp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
801083c8:	a1 78 68 11 80       	mov    0x80116878,%eax
801083cd:	50                   	push   %eax
801083ce:	e8 69 f9 ff ff       	call   80107d3c <v2p>
801083d3:	83 c4 04             	add    $0x4,%esp
801083d6:	50                   	push   %eax
801083d7:	e8 54 f9 ff ff       	call   80107d30 <lcr3>
801083dc:	83 c4 04             	add    $0x4,%esp
}
801083df:	90                   	nop
801083e0:	c9                   	leave  
801083e1:	c3                   	ret    

801083e2 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
801083e2:	55                   	push   %ebp
801083e3:	89 e5                	mov    %esp,%ebp
801083e5:	56                   	push   %esi
801083e6:	53                   	push   %ebx
  pushcli();
801083e7:	e8 bc d2 ff ff       	call   801056a8 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
801083ec:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801083f2:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801083f9:	83 c2 08             	add    $0x8,%edx
801083fc:	89 d6                	mov    %edx,%esi
801083fe:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80108405:	83 c2 08             	add    $0x8,%edx
80108408:	c1 ea 10             	shr    $0x10,%edx
8010840b:	89 d3                	mov    %edx,%ebx
8010840d:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80108414:	83 c2 08             	add    $0x8,%edx
80108417:	c1 ea 18             	shr    $0x18,%edx
8010841a:	89 d1                	mov    %edx,%ecx
8010841c:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80108423:	67 00 
80108425:	66 89 b0 a2 00 00 00 	mov    %si,0xa2(%eax)
8010842c:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
80108432:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80108439:	83 e2 f0             	and    $0xfffffff0,%edx
8010843c:	83 ca 09             	or     $0x9,%edx
8010843f:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80108445:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
8010844c:	83 ca 10             	or     $0x10,%edx
8010844f:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80108455:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
8010845c:	83 e2 9f             	and    $0xffffff9f,%edx
8010845f:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80108465:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
8010846c:	83 ca 80             	or     $0xffffff80,%edx
8010846f:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80108475:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
8010847c:	83 e2 f0             	and    $0xfffffff0,%edx
8010847f:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80108485:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
8010848c:	83 e2 ef             	and    $0xffffffef,%edx
8010848f:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80108495:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
8010849c:	83 e2 df             	and    $0xffffffdf,%edx
8010849f:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801084a5:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
801084ac:	83 ca 40             	or     $0x40,%edx
801084af:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801084b5:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
801084bc:	83 e2 7f             	and    $0x7f,%edx
801084bf:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801084c5:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
801084cb:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801084d1:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
801084d8:	83 e2 ef             	and    $0xffffffef,%edx
801084db:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
801084e1:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801084e7:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
801084ed:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801084f3:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801084fa:	8b 52 08             	mov    0x8(%edx),%edx
801084fd:	81 c2 00 10 00 00    	add    $0x1000,%edx
80108503:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
80108506:	83 ec 0c             	sub    $0xc,%esp
80108509:	6a 30                	push   $0x30
8010850b:	e8 f3 f7 ff ff       	call   80107d03 <ltr>
80108510:	83 c4 10             	add    $0x10,%esp
  if(p->pgdir == 0)
80108513:	8b 45 08             	mov    0x8(%ebp),%eax
80108516:	8b 40 04             	mov    0x4(%eax),%eax
80108519:	85 c0                	test   %eax,%eax
8010851b:	75 0d                	jne    8010852a <switchuvm+0x148>
    panic("switchuvm: no pgdir");
8010851d:	83 ec 0c             	sub    $0xc,%esp
80108520:	68 43 91 10 80       	push   $0x80109143
80108525:	e8 3c 80 ff ff       	call   80100566 <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
8010852a:	8b 45 08             	mov    0x8(%ebp),%eax
8010852d:	8b 40 04             	mov    0x4(%eax),%eax
80108530:	83 ec 0c             	sub    $0xc,%esp
80108533:	50                   	push   %eax
80108534:	e8 03 f8 ff ff       	call   80107d3c <v2p>
80108539:	83 c4 10             	add    $0x10,%esp
8010853c:	83 ec 0c             	sub    $0xc,%esp
8010853f:	50                   	push   %eax
80108540:	e8 eb f7 ff ff       	call   80107d30 <lcr3>
80108545:	83 c4 10             	add    $0x10,%esp
  popcli();
80108548:	e8 a0 d1 ff ff       	call   801056ed <popcli>
}
8010854d:	90                   	nop
8010854e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108551:	5b                   	pop    %ebx
80108552:	5e                   	pop    %esi
80108553:	5d                   	pop    %ebp
80108554:	c3                   	ret    

80108555 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80108555:	55                   	push   %ebp
80108556:	89 e5                	mov    %esp,%ebp
80108558:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  
  if(sz >= PGSIZE)
8010855b:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80108562:	76 0d                	jbe    80108571 <inituvm+0x1c>
    panic("inituvm: more than a page");
80108564:	83 ec 0c             	sub    $0xc,%esp
80108567:	68 57 91 10 80       	push   $0x80109157
8010856c:	e8 f5 7f ff ff       	call   80100566 <panic>
  mem = kalloc();
80108571:	e8 f0 a6 ff ff       	call   80102c66 <kalloc>
80108576:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
80108579:	83 ec 04             	sub    $0x4,%esp
8010857c:	68 00 10 00 00       	push   $0x1000
80108581:	6a 00                	push   $0x0
80108583:	ff 75 f4             	pushl  -0xc(%ebp)
80108586:	e8 23 d2 ff ff       	call   801057ae <memset>
8010858b:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
8010858e:	83 ec 0c             	sub    $0xc,%esp
80108591:	ff 75 f4             	pushl  -0xc(%ebp)
80108594:	e8 a3 f7 ff ff       	call   80107d3c <v2p>
80108599:	83 c4 10             	add    $0x10,%esp
8010859c:	83 ec 0c             	sub    $0xc,%esp
8010859f:	6a 06                	push   $0x6
801085a1:	50                   	push   %eax
801085a2:	68 00 10 00 00       	push   $0x1000
801085a7:	6a 00                	push   $0x0
801085a9:	ff 75 08             	pushl  0x8(%ebp)
801085ac:	e8 ba fc ff ff       	call   8010826b <mappages>
801085b1:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
801085b4:	83 ec 04             	sub    $0x4,%esp
801085b7:	ff 75 10             	pushl  0x10(%ebp)
801085ba:	ff 75 0c             	pushl  0xc(%ebp)
801085bd:	ff 75 f4             	pushl  -0xc(%ebp)
801085c0:	e8 a8 d2 ff ff       	call   8010586d <memmove>
801085c5:	83 c4 10             	add    $0x10,%esp
}
801085c8:	90                   	nop
801085c9:	c9                   	leave  
801085ca:	c3                   	ret    

801085cb <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
801085cb:	55                   	push   %ebp
801085cc:	89 e5                	mov    %esp,%ebp
801085ce:	53                   	push   %ebx
801085cf:	83 ec 14             	sub    $0x14,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
801085d2:	8b 45 0c             	mov    0xc(%ebp),%eax
801085d5:	25 ff 0f 00 00       	and    $0xfff,%eax
801085da:	85 c0                	test   %eax,%eax
801085dc:	74 0d                	je     801085eb <loaduvm+0x20>
    panic("loaduvm: addr must be page aligned");
801085de:	83 ec 0c             	sub    $0xc,%esp
801085e1:	68 74 91 10 80       	push   $0x80109174
801085e6:	e8 7b 7f ff ff       	call   80100566 <panic>
  for(i = 0; i < sz; i += PGSIZE){
801085eb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801085f2:	e9 95 00 00 00       	jmp    8010868c <loaduvm+0xc1>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801085f7:	8b 55 0c             	mov    0xc(%ebp),%edx
801085fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085fd:	01 d0                	add    %edx,%eax
801085ff:	83 ec 04             	sub    $0x4,%esp
80108602:	6a 00                	push   $0x0
80108604:	50                   	push   %eax
80108605:	ff 75 08             	pushl  0x8(%ebp)
80108608:	e8 be fb ff ff       	call   801081cb <walkpgdir>
8010860d:	83 c4 10             	add    $0x10,%esp
80108610:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108613:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108617:	75 0d                	jne    80108626 <loaduvm+0x5b>
      panic("loaduvm: address should exist");
80108619:	83 ec 0c             	sub    $0xc,%esp
8010861c:	68 97 91 10 80       	push   $0x80109197
80108621:	e8 40 7f ff ff       	call   80100566 <panic>
    pa = PTE_ADDR(*pte);
80108626:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108629:	8b 00                	mov    (%eax),%eax
8010862b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108630:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
80108633:	8b 45 18             	mov    0x18(%ebp),%eax
80108636:	2b 45 f4             	sub    -0xc(%ebp),%eax
80108639:	3d ff 0f 00 00       	cmp    $0xfff,%eax
8010863e:	77 0b                	ja     8010864b <loaduvm+0x80>
      n = sz - i;
80108640:	8b 45 18             	mov    0x18(%ebp),%eax
80108643:	2b 45 f4             	sub    -0xc(%ebp),%eax
80108646:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108649:	eb 07                	jmp    80108652 <loaduvm+0x87>
    else
      n = PGSIZE;
8010864b:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
80108652:	8b 55 14             	mov    0x14(%ebp),%edx
80108655:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108658:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
8010865b:	83 ec 0c             	sub    $0xc,%esp
8010865e:	ff 75 e8             	pushl  -0x18(%ebp)
80108661:	e8 e3 f6 ff ff       	call   80107d49 <p2v>
80108666:	83 c4 10             	add    $0x10,%esp
80108669:	ff 75 f0             	pushl  -0x10(%ebp)
8010866c:	53                   	push   %ebx
8010866d:	50                   	push   %eax
8010866e:	ff 75 10             	pushl  0x10(%ebp)
80108671:	e8 62 98 ff ff       	call   80101ed8 <readi>
80108676:	83 c4 10             	add    $0x10,%esp
80108679:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010867c:	74 07                	je     80108685 <loaduvm+0xba>
      return -1;
8010867e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108683:	eb 18                	jmp    8010869d <loaduvm+0xd2>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80108685:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010868c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010868f:	3b 45 18             	cmp    0x18(%ebp),%eax
80108692:	0f 82 5f ff ff ff    	jb     801085f7 <loaduvm+0x2c>
    else
      n = PGSIZE;
    if(readi(ip, p2v(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80108698:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010869d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801086a0:	c9                   	leave  
801086a1:	c3                   	ret    

801086a2 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801086a2:	55                   	push   %ebp
801086a3:	89 e5                	mov    %esp,%ebp
801086a5:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
801086a8:	8b 45 10             	mov    0x10(%ebp),%eax
801086ab:	85 c0                	test   %eax,%eax
801086ad:	79 0a                	jns    801086b9 <allocuvm+0x17>
    return 0;
801086af:	b8 00 00 00 00       	mov    $0x0,%eax
801086b4:	e9 b0 00 00 00       	jmp    80108769 <allocuvm+0xc7>
  if(newsz < oldsz)
801086b9:	8b 45 10             	mov    0x10(%ebp),%eax
801086bc:	3b 45 0c             	cmp    0xc(%ebp),%eax
801086bf:	73 08                	jae    801086c9 <allocuvm+0x27>
    return oldsz;
801086c1:	8b 45 0c             	mov    0xc(%ebp),%eax
801086c4:	e9 a0 00 00 00       	jmp    80108769 <allocuvm+0xc7>

  a = PGROUNDUP(oldsz);
801086c9:	8b 45 0c             	mov    0xc(%ebp),%eax
801086cc:	05 ff 0f 00 00       	add    $0xfff,%eax
801086d1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801086d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
801086d9:	eb 7f                	jmp    8010875a <allocuvm+0xb8>
    mem = kalloc();
801086db:	e8 86 a5 ff ff       	call   80102c66 <kalloc>
801086e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
801086e3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801086e7:	75 2b                	jne    80108714 <allocuvm+0x72>
      cprintf("allocuvm out of memory\n");
801086e9:	83 ec 0c             	sub    $0xc,%esp
801086ec:	68 b5 91 10 80       	push   $0x801091b5
801086f1:	e8 d0 7c ff ff       	call   801003c6 <cprintf>
801086f6:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
801086f9:	83 ec 04             	sub    $0x4,%esp
801086fc:	ff 75 0c             	pushl  0xc(%ebp)
801086ff:	ff 75 10             	pushl  0x10(%ebp)
80108702:	ff 75 08             	pushl  0x8(%ebp)
80108705:	e8 61 00 00 00       	call   8010876b <deallocuvm>
8010870a:	83 c4 10             	add    $0x10,%esp
      return 0;
8010870d:	b8 00 00 00 00       	mov    $0x0,%eax
80108712:	eb 55                	jmp    80108769 <allocuvm+0xc7>
    }
    memset(mem, 0, PGSIZE);
80108714:	83 ec 04             	sub    $0x4,%esp
80108717:	68 00 10 00 00       	push   $0x1000
8010871c:	6a 00                	push   $0x0
8010871e:	ff 75 f0             	pushl  -0x10(%ebp)
80108721:	e8 88 d0 ff ff       	call   801057ae <memset>
80108726:	83 c4 10             	add    $0x10,%esp
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
80108729:	83 ec 0c             	sub    $0xc,%esp
8010872c:	ff 75 f0             	pushl  -0x10(%ebp)
8010872f:	e8 08 f6 ff ff       	call   80107d3c <v2p>
80108734:	83 c4 10             	add    $0x10,%esp
80108737:	89 c2                	mov    %eax,%edx
80108739:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010873c:	83 ec 0c             	sub    $0xc,%esp
8010873f:	6a 06                	push   $0x6
80108741:	52                   	push   %edx
80108742:	68 00 10 00 00       	push   $0x1000
80108747:	50                   	push   %eax
80108748:	ff 75 08             	pushl  0x8(%ebp)
8010874b:	e8 1b fb ff ff       	call   8010826b <mappages>
80108750:	83 c4 20             	add    $0x20,%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80108753:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010875a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010875d:	3b 45 10             	cmp    0x10(%ebp),%eax
80108760:	0f 82 75 ff ff ff    	jb     801086db <allocuvm+0x39>
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
  }
  return newsz;
80108766:	8b 45 10             	mov    0x10(%ebp),%eax
}
80108769:	c9                   	leave  
8010876a:	c3                   	ret    

8010876b <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
8010876b:	55                   	push   %ebp
8010876c:	89 e5                	mov    %esp,%ebp
8010876e:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80108771:	8b 45 10             	mov    0x10(%ebp),%eax
80108774:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108777:	72 08                	jb     80108781 <deallocuvm+0x16>
    return oldsz;
80108779:	8b 45 0c             	mov    0xc(%ebp),%eax
8010877c:	e9 a5 00 00 00       	jmp    80108826 <deallocuvm+0xbb>

  a = PGROUNDUP(newsz);
80108781:	8b 45 10             	mov    0x10(%ebp),%eax
80108784:	05 ff 0f 00 00       	add    $0xfff,%eax
80108789:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010878e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80108791:	e9 81 00 00 00       	jmp    80108817 <deallocuvm+0xac>
    pte = walkpgdir(pgdir, (char*)a, 0);
80108796:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108799:	83 ec 04             	sub    $0x4,%esp
8010879c:	6a 00                	push   $0x0
8010879e:	50                   	push   %eax
8010879f:	ff 75 08             	pushl  0x8(%ebp)
801087a2:	e8 24 fa ff ff       	call   801081cb <walkpgdir>
801087a7:	83 c4 10             	add    $0x10,%esp
801087aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
801087ad:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801087b1:	75 09                	jne    801087bc <deallocuvm+0x51>
      a += (NPTENTRIES - 1) * PGSIZE;
801087b3:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
801087ba:	eb 54                	jmp    80108810 <deallocuvm+0xa5>
    else if((*pte & PTE_P) != 0){
801087bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801087bf:	8b 00                	mov    (%eax),%eax
801087c1:	83 e0 01             	and    $0x1,%eax
801087c4:	85 c0                	test   %eax,%eax
801087c6:	74 48                	je     80108810 <deallocuvm+0xa5>
      pa = PTE_ADDR(*pte);
801087c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801087cb:	8b 00                	mov    (%eax),%eax
801087cd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801087d2:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
801087d5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801087d9:	75 0d                	jne    801087e8 <deallocuvm+0x7d>
        panic("kfree");
801087db:	83 ec 0c             	sub    $0xc,%esp
801087de:	68 cd 91 10 80       	push   $0x801091cd
801087e3:	e8 7e 7d ff ff       	call   80100566 <panic>
      char *v = p2v(pa);
801087e8:	83 ec 0c             	sub    $0xc,%esp
801087eb:	ff 75 ec             	pushl  -0x14(%ebp)
801087ee:	e8 56 f5 ff ff       	call   80107d49 <p2v>
801087f3:	83 c4 10             	add    $0x10,%esp
801087f6:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
801087f9:	83 ec 0c             	sub    $0xc,%esp
801087fc:	ff 75 e8             	pushl  -0x18(%ebp)
801087ff:	e8 c5 a3 ff ff       	call   80102bc9 <kfree>
80108804:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80108807:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010880a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80108810:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108817:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010881a:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010881d:	0f 82 73 ff ff ff    	jb     80108796 <deallocuvm+0x2b>
      char *v = p2v(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
80108823:	8b 45 10             	mov    0x10(%ebp),%eax
}
80108826:	c9                   	leave  
80108827:	c3                   	ret    

80108828 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108828:	55                   	push   %ebp
80108829:	89 e5                	mov    %esp,%ebp
8010882b:	83 ec 18             	sub    $0x18,%esp
  uint i;

  if(pgdir == 0)
8010882e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80108832:	75 0d                	jne    80108841 <freevm+0x19>
    panic("freevm: no pgdir");
80108834:	83 ec 0c             	sub    $0xc,%esp
80108837:	68 d3 91 10 80       	push   $0x801091d3
8010883c:	e8 25 7d ff ff       	call   80100566 <panic>
  deallocuvm(pgdir, KERNBASE, 0);
80108841:	83 ec 04             	sub    $0x4,%esp
80108844:	6a 00                	push   $0x0
80108846:	68 00 00 00 80       	push   $0x80000000
8010884b:	ff 75 08             	pushl  0x8(%ebp)
8010884e:	e8 18 ff ff ff       	call   8010876b <deallocuvm>
80108853:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108856:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010885d:	eb 4f                	jmp    801088ae <freevm+0x86>
    if(pgdir[i] & PTE_P){
8010885f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108862:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108869:	8b 45 08             	mov    0x8(%ebp),%eax
8010886c:	01 d0                	add    %edx,%eax
8010886e:	8b 00                	mov    (%eax),%eax
80108870:	83 e0 01             	and    $0x1,%eax
80108873:	85 c0                	test   %eax,%eax
80108875:	74 33                	je     801088aa <freevm+0x82>
      char * v = p2v(PTE_ADDR(pgdir[i]));
80108877:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010887a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108881:	8b 45 08             	mov    0x8(%ebp),%eax
80108884:	01 d0                	add    %edx,%eax
80108886:	8b 00                	mov    (%eax),%eax
80108888:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010888d:	83 ec 0c             	sub    $0xc,%esp
80108890:	50                   	push   %eax
80108891:	e8 b3 f4 ff ff       	call   80107d49 <p2v>
80108896:	83 c4 10             	add    $0x10,%esp
80108899:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
8010889c:	83 ec 0c             	sub    $0xc,%esp
8010889f:	ff 75 f0             	pushl  -0x10(%ebp)
801088a2:	e8 22 a3 ff ff       	call   80102bc9 <kfree>
801088a7:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801088aa:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801088ae:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
801088b5:	76 a8                	jbe    8010885f <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = p2v(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801088b7:	83 ec 0c             	sub    $0xc,%esp
801088ba:	ff 75 08             	pushl  0x8(%ebp)
801088bd:	e8 07 a3 ff ff       	call   80102bc9 <kfree>
801088c2:	83 c4 10             	add    $0x10,%esp
}
801088c5:	90                   	nop
801088c6:	c9                   	leave  
801088c7:	c3                   	ret    

801088c8 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801088c8:	55                   	push   %ebp
801088c9:	89 e5                	mov    %esp,%ebp
801088cb:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801088ce:	83 ec 04             	sub    $0x4,%esp
801088d1:	6a 00                	push   $0x0
801088d3:	ff 75 0c             	pushl  0xc(%ebp)
801088d6:	ff 75 08             	pushl  0x8(%ebp)
801088d9:	e8 ed f8 ff ff       	call   801081cb <walkpgdir>
801088de:	83 c4 10             	add    $0x10,%esp
801088e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
801088e4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801088e8:	75 0d                	jne    801088f7 <clearpteu+0x2f>
    panic("clearpteu");
801088ea:	83 ec 0c             	sub    $0xc,%esp
801088ed:	68 e4 91 10 80       	push   $0x801091e4
801088f2:	e8 6f 7c ff ff       	call   80100566 <panic>
  *pte &= ~PTE_U;
801088f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088fa:	8b 00                	mov    (%eax),%eax
801088fc:	83 e0 fb             	and    $0xfffffffb,%eax
801088ff:	89 c2                	mov    %eax,%edx
80108901:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108904:	89 10                	mov    %edx,(%eax)
}
80108906:	90                   	nop
80108907:	c9                   	leave  
80108908:	c3                   	ret    

80108909 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108909:	55                   	push   %ebp
8010890a:	89 e5                	mov    %esp,%ebp
8010890c:	53                   	push   %ebx
8010890d:	83 ec 24             	sub    $0x24,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108910:	e8 e6 f9 ff ff       	call   801082fb <setupkvm>
80108915:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108918:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010891c:	75 0a                	jne    80108928 <copyuvm+0x1f>
    return 0;
8010891e:	b8 00 00 00 00       	mov    $0x0,%eax
80108923:	e9 f8 00 00 00       	jmp    80108a20 <copyuvm+0x117>
  for(i = 0; i < sz; i += PGSIZE){
80108928:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010892f:	e9 c4 00 00 00       	jmp    801089f8 <copyuvm+0xef>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108934:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108937:	83 ec 04             	sub    $0x4,%esp
8010893a:	6a 00                	push   $0x0
8010893c:	50                   	push   %eax
8010893d:	ff 75 08             	pushl  0x8(%ebp)
80108940:	e8 86 f8 ff ff       	call   801081cb <walkpgdir>
80108945:	83 c4 10             	add    $0x10,%esp
80108948:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010894b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010894f:	75 0d                	jne    8010895e <copyuvm+0x55>
      panic("copyuvm: pte should exist");
80108951:	83 ec 0c             	sub    $0xc,%esp
80108954:	68 ee 91 10 80       	push   $0x801091ee
80108959:	e8 08 7c ff ff       	call   80100566 <panic>
    if(!(*pte & PTE_P))
8010895e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108961:	8b 00                	mov    (%eax),%eax
80108963:	83 e0 01             	and    $0x1,%eax
80108966:	85 c0                	test   %eax,%eax
80108968:	75 0d                	jne    80108977 <copyuvm+0x6e>
      panic("copyuvm: page not present");
8010896a:	83 ec 0c             	sub    $0xc,%esp
8010896d:	68 08 92 10 80       	push   $0x80109208
80108972:	e8 ef 7b ff ff       	call   80100566 <panic>
    pa = PTE_ADDR(*pte);
80108977:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010897a:	8b 00                	mov    (%eax),%eax
8010897c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108981:	89 45 e8             	mov    %eax,-0x18(%ebp)
    flags = PTE_FLAGS(*pte);
80108984:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108987:	8b 00                	mov    (%eax),%eax
80108989:	25 ff 0f 00 00       	and    $0xfff,%eax
8010898e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80108991:	e8 d0 a2 ff ff       	call   80102c66 <kalloc>
80108996:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108999:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010899d:	74 6a                	je     80108a09 <copyuvm+0x100>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
8010899f:	83 ec 0c             	sub    $0xc,%esp
801089a2:	ff 75 e8             	pushl  -0x18(%ebp)
801089a5:	e8 9f f3 ff ff       	call   80107d49 <p2v>
801089aa:	83 c4 10             	add    $0x10,%esp
801089ad:	83 ec 04             	sub    $0x4,%esp
801089b0:	68 00 10 00 00       	push   $0x1000
801089b5:	50                   	push   %eax
801089b6:	ff 75 e0             	pushl  -0x20(%ebp)
801089b9:	e8 af ce ff ff       	call   8010586d <memmove>
801089be:	83 c4 10             	add    $0x10,%esp
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
801089c1:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801089c4:	83 ec 0c             	sub    $0xc,%esp
801089c7:	ff 75 e0             	pushl  -0x20(%ebp)
801089ca:	e8 6d f3 ff ff       	call   80107d3c <v2p>
801089cf:	83 c4 10             	add    $0x10,%esp
801089d2:	89 c2                	mov    %eax,%edx
801089d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089d7:	83 ec 0c             	sub    $0xc,%esp
801089da:	53                   	push   %ebx
801089db:	52                   	push   %edx
801089dc:	68 00 10 00 00       	push   $0x1000
801089e1:	50                   	push   %eax
801089e2:	ff 75 f0             	pushl  -0x10(%ebp)
801089e5:	e8 81 f8 ff ff       	call   8010826b <mappages>
801089ea:	83 c4 20             	add    $0x20,%esp
801089ed:	85 c0                	test   %eax,%eax
801089ef:	78 1b                	js     80108a0c <copyuvm+0x103>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801089f1:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801089f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089fb:	3b 45 0c             	cmp    0xc(%ebp),%eax
801089fe:	0f 82 30 ff ff ff    	jb     80108934 <copyuvm+0x2b>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
      goto bad;
  }
  return d;
80108a04:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108a07:	eb 17                	jmp    80108a20 <copyuvm+0x117>
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
80108a09:	90                   	nop
80108a0a:	eb 01                	jmp    80108a0d <copyuvm+0x104>
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
      goto bad;
80108a0c:	90                   	nop
  }
  return d;

bad:
  freevm(d);
80108a0d:	83 ec 0c             	sub    $0xc,%esp
80108a10:	ff 75 f0             	pushl  -0x10(%ebp)
80108a13:	e8 10 fe ff ff       	call   80108828 <freevm>
80108a18:	83 c4 10             	add    $0x10,%esp
  return 0;
80108a1b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108a20:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80108a23:	c9                   	leave  
80108a24:	c3                   	ret    

80108a25 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108a25:	55                   	push   %ebp
80108a26:	89 e5                	mov    %esp,%ebp
80108a28:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108a2b:	83 ec 04             	sub    $0x4,%esp
80108a2e:	6a 00                	push   $0x0
80108a30:	ff 75 0c             	pushl  0xc(%ebp)
80108a33:	ff 75 08             	pushl  0x8(%ebp)
80108a36:	e8 90 f7 ff ff       	call   801081cb <walkpgdir>
80108a3b:	83 c4 10             	add    $0x10,%esp
80108a3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
80108a41:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a44:	8b 00                	mov    (%eax),%eax
80108a46:	83 e0 01             	and    $0x1,%eax
80108a49:	85 c0                	test   %eax,%eax
80108a4b:	75 07                	jne    80108a54 <uva2ka+0x2f>
    return 0;
80108a4d:	b8 00 00 00 00       	mov    $0x0,%eax
80108a52:	eb 29                	jmp    80108a7d <uva2ka+0x58>
  if((*pte & PTE_U) == 0)
80108a54:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a57:	8b 00                	mov    (%eax),%eax
80108a59:	83 e0 04             	and    $0x4,%eax
80108a5c:	85 c0                	test   %eax,%eax
80108a5e:	75 07                	jne    80108a67 <uva2ka+0x42>
    return 0;
80108a60:	b8 00 00 00 00       	mov    $0x0,%eax
80108a65:	eb 16                	jmp    80108a7d <uva2ka+0x58>
  return (char*)p2v(PTE_ADDR(*pte));
80108a67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a6a:	8b 00                	mov    (%eax),%eax
80108a6c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108a71:	83 ec 0c             	sub    $0xc,%esp
80108a74:	50                   	push   %eax
80108a75:	e8 cf f2 ff ff       	call   80107d49 <p2v>
80108a7a:	83 c4 10             	add    $0x10,%esp
}
80108a7d:	c9                   	leave  
80108a7e:	c3                   	ret    

80108a7f <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108a7f:	55                   	push   %ebp
80108a80:	89 e5                	mov    %esp,%ebp
80108a82:	83 ec 18             	sub    $0x18,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
80108a85:	8b 45 10             	mov    0x10(%ebp),%eax
80108a88:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
80108a8b:	eb 7f                	jmp    80108b0c <copyout+0x8d>
    va0 = (uint)PGROUNDDOWN(va);
80108a8d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108a90:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108a95:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80108a98:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108a9b:	83 ec 08             	sub    $0x8,%esp
80108a9e:	50                   	push   %eax
80108a9f:	ff 75 08             	pushl  0x8(%ebp)
80108aa2:	e8 7e ff ff ff       	call   80108a25 <uva2ka>
80108aa7:	83 c4 10             	add    $0x10,%esp
80108aaa:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
80108aad:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80108ab1:	75 07                	jne    80108aba <copyout+0x3b>
      return -1;
80108ab3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108ab8:	eb 61                	jmp    80108b1b <copyout+0x9c>
    n = PGSIZE - (va - va0);
80108aba:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108abd:	2b 45 0c             	sub    0xc(%ebp),%eax
80108ac0:	05 00 10 00 00       	add    $0x1000,%eax
80108ac5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
80108ac8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108acb:	3b 45 14             	cmp    0x14(%ebp),%eax
80108ace:	76 06                	jbe    80108ad6 <copyout+0x57>
      n = len;
80108ad0:	8b 45 14             	mov    0x14(%ebp),%eax
80108ad3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
80108ad6:	8b 45 0c             	mov    0xc(%ebp),%eax
80108ad9:	2b 45 ec             	sub    -0x14(%ebp),%eax
80108adc:	89 c2                	mov    %eax,%edx
80108ade:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108ae1:	01 d0                	add    %edx,%eax
80108ae3:	83 ec 04             	sub    $0x4,%esp
80108ae6:	ff 75 f0             	pushl  -0x10(%ebp)
80108ae9:	ff 75 f4             	pushl  -0xc(%ebp)
80108aec:	50                   	push   %eax
80108aed:	e8 7b cd ff ff       	call   8010586d <memmove>
80108af2:	83 c4 10             	add    $0x10,%esp
    len -= n;
80108af5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108af8:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
80108afb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108afe:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
80108b01:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108b04:	05 00 10 00 00       	add    $0x1000,%eax
80108b09:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108b0c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80108b10:	0f 85 77 ff ff ff    	jne    80108a8d <copyout+0xe>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80108b16:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108b1b:	c9                   	leave  
80108b1c:	c3                   	ret    
