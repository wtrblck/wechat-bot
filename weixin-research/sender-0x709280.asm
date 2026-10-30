
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

0000000180709280 <.text+0x708280>:
   180709280:	55                   	push   rbp
   180709281:	56                   	push   rsi
   180709282:	57                   	push   rdi
   180709283:	48 81 ec 90 00 00 00 	sub    rsp,0x90
   18070928a:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   180709291:	00
   180709292:	0f 29 75 00          	movaps XMMWORD PTR [rbp+0x0],xmm6
   180709296:	48 c7 45 f8 fe ff ff 	mov    QWORD PTR [rbp-0x8],0xfffffffffffffffe
   18070929d:	ff
   18070929e:	48 89 d6             	mov    rsi,rdx
   1807092a1:	48 89 cf             	mov    rdi,rcx
   1807092a4:	48 8d 05 7d 84 91 08 	lea    rax,[rip+0x891847d]        # 0x189021728
   1807092ab:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
   1807092af:	0f 28 35 fa d8 80 08 	movaps xmm6,XMMWORD PTR [rip+0x880d8fa]        # 0x188f16bb0
   1807092b6:	0f 29 75 b0          	movaps XMMWORD PTR [rbp-0x50],xmm6
   1807092ba:	0f 29 75 a0          	movaps XMMWORD PTR [rbp-0x60],xmm6
   1807092be:	48 8d 55 a0          	lea    rdx,[rbp-0x60]
   1807092c2:	4c 8d 45 d8          	lea    r8,[rbp-0x28]
   1807092c6:	e8 b5 66 c2 ff       	call   0x18032f980
   1807092cb:	0f 29 75 c0          	movaps XMMWORD PTR [rbp-0x40],xmm6
   1807092cf:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1807092d3:	e8 f8 8c d9 ff       	call   0x1804a1fd0
   1807092d8:	90                   	nop
   1807092d9:	80 7d b8 01          	cmp    BYTE PTR [rbp-0x48],0x1
   1807092dd:	75 17                	jne    0x1807092f6
   1807092df:	48 8d 4d e0          	lea    rcx,[rbp-0x20]
   1807092e3:	48 8d 55 a0          	lea    rdx,[rbp-0x60]
   1807092e7:	e8 e4 1b 95 ff       	call   0x18005aed0
   1807092ec:	90                   	nop
   1807092ed:	0f 28 45 e0          	movaps xmm0,XMMWORD PTR [rbp-0x20]
   1807092f1:	0f 11 06             	movups XMMWORD PTR [rsi],xmm0
   1807092f4:	eb 60                	jmp    0x180709356
   1807092f6:	0f 29 75 e0          	movaps XMMWORD PTR [rbp-0x20],xmm6
   1807092fa:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
   1807092fe:	4c 8d 45 d8          	lea    r8,[rbp-0x28]
   180709302:	48 89 f9             	mov    rcx,rdi
   180709305:	e8 d6 54 c2 ff       	call   0x18032e7e0
   18070930a:	90                   	nop
   18070930b:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
   18070930f:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
   180709313:	48 85 c9             	test   rcx,rcx
   180709316:	74 33                	je     0x18070934b
   180709318:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   18070931c:	48 8b 7d e8          	mov    rdi,QWORD PTR [rbp-0x18]
   180709320:	48 89 06             	mov    QWORD PTR [rsi],rax
   180709323:	48 89 7e 08          	mov    QWORD PTR [rsi+0x8],rdi
   180709327:	48 85 ff             	test   rdi,rdi
   18070932a:	74 2a                	je     0x180709356
   18070932c:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   180709330:	75 24                	jne    0x180709356
   180709332:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   180709335:	48 89 f9             	mov    rcx,rdi
   180709338:	ff 10                	call   QWORD PTR [rax]
   18070933a:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   18070933e:	75 16                	jne    0x180709356
   180709340:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   180709343:	48 89 f9             	mov    rcx,rdi
   180709346:	ff 50 08             	call   QWORD PTR [rax+0x8]
   180709349:	eb 0b                	jmp    0x180709356
   18070934b:	48 89 06             	mov    QWORD PTR [rsi],rax
   18070934e:	48 c7 46 08 00 00 00 	mov    QWORD PTR [rsi+0x8],0x0
   180709355:	00
   180709356:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   18070935a:	e8 51 8d d9 ff       	call   0x1804a20b0
   18070935f:	80 7d b8 01          	cmp    BYTE PTR [rbp-0x48],0x1
   180709363:	75 26                	jne    0x18070938b
   180709365:	48 8b 7d a8          	mov    rdi,QWORD PTR [rbp-0x58]
   180709369:	48 85 ff             	test   rdi,rdi
   18070936c:	74 1d                	je     0x18070938b
   18070936e:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   180709372:	75 17                	jne    0x18070938b
   180709374:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   180709377:	48 89 f9             	mov    rcx,rdi
   18070937a:	ff 10                	call   QWORD PTR [rax]
   18070937c:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   180709380:	75 09                	jne    0x18070938b
   180709382:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   180709385:	48 89 f9             	mov    rcx,rdi
   180709388:	ff 50 08             	call   QWORD PTR [rax+0x8]
   18070938b:	48 89 f0             	mov    rax,rsi
   18070938e:	0f 28 75 00          	movaps xmm6,XMMWORD PTR [rbp+0x0]
   180709392:	48 81 c4 90 00 00 00 	add    rsp,0x90
   180709399:	5f                   	pop    rdi
   18070939a:	5e                   	pop    rsi
   18070939b:	5d                   	pop    rbp
   18070939c:	c3                   	ret
