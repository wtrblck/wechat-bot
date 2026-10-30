
E:/Tencent/Weixin/4.1.15.56/Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001855ed160 <.text+0x55ec160>:
   1855ed160:	55                   	push   rbp
   1855ed161:	41 57                	push   r15
   1855ed163:	41 56                	push   r14
   1855ed165:	41 54                	push   r12
   1855ed167:	56                   	push   rsi
   1855ed168:	57                   	push   rdi
   1855ed169:	53                   	push   rbx
   1855ed16a:	48 81 ec 30 06 00 00 	sub    rsp,0x630
   1855ed171:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   1855ed178:	00
   1855ed179:	0f 29 b5 a0 05 00 00 	movaps XMMWORD PTR [rbp+0x5a0],xmm6
   1855ed180:	48 c7 85 98 05 00 00 	mov    QWORD PTR [rbp+0x598],0xfffffffffffffffe
   1855ed187:	fe ff ff ff
   1855ed18b:	48 89 ce             	mov    rsi,rcx
   1855ed18e:	0f 28 35 1b 9a 92 03 	movaps xmm6,XMMWORD PTR [rip+0x3929a1b]        # 0x188f16bb0
   1855ed195:	0f 29 b5 70 05 00 00 	movaps XMMWORD PTR [rbp+0x570],xmm6
   1855ed19c:	48 8d bd 30 04 00 00 	lea    rdi,[rbp+0x430]
   1855ed1a3:	48 89 f9             	mov    rcx,rdi
   1855ed1a6:	e8 75 a0 a5 fa       	call   0x180047220
   1855ed1ab:	48 8b 8d 30 04 00 00 	mov    rcx,QWORD PTR [rbp+0x430]
   1855ed1b2:	48 8d 95 90 04 00 00 	lea    rdx,[rbp+0x490]
   1855ed1b9:	e8 12 52 d9 fa       	call   0x1803823d0
   1855ed1be:	90                   	nop
   1855ed1bf:	48 8b 8d 90 04 00 00 	mov    rcx,QWORD PTR [rbp+0x490]
   1855ed1c6:	48 8d 55 10          	lea    rdx,[rbp+0x10]
   1855ed1ca:	e8 b1 79 8c fb       	call   0x180eb4b80
   1855ed1cf:	90                   	nop
   1855ed1d0:	48 8b 4d 10          	mov    rcx,QWORD PTR [rbp+0x10]
   1855ed1d4:	0f 57 c0             	xorps  xmm0,xmm0
   1855ed1d7:	0f 29 85 10 05 00 00 	movaps XMMWORD PTR [rbp+0x510],xmm0
   1855ed1de:	48 8b 46 40          	mov    rax,QWORD PTR [rsi+0x40]
   1855ed1e2:	48 85 c0             	test   rax,rax
   1855ed1e5:	74 0a                	je     0x1855ed1f1
   1855ed1e7:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1855ed1eb:	48 8b 46 40          	mov    rax,QWORD PTR [rsi+0x40]
   1855ed1ef:	eb 02                	jmp    0x1855ed1f3
   1855ed1f1:	31 c0                	xor    eax,eax
   1855ed1f3:	48 8b 56 38          	mov    rdx,QWORD PTR [rsi+0x38]
   1855ed1f7:	48 89 95 10 05 00 00 	mov    QWORD PTR [rbp+0x510],rdx
   1855ed1fe:	48 89 85 18 05 00 00 	mov    QWORD PTR [rbp+0x518],rax
   1855ed205:	48 8d 95 70 05 00 00 	lea    rdx,[rbp+0x570]
   1855ed20c:	48 8d 9d 10 05 00 00 	lea    rbx,[rbp+0x510]
   1855ed213:	49 89 d8             	mov    r8,rbx
   1855ed216:	41 b9 f4 01 00 00    	mov    r9d,0x1f4
   1855ed21c:	e8 bf 36 77 fd       	call   0x182d608e0
   1855ed221:	90                   	nop
   1855ed222:	4c 8b b5 18 05 00 00 	mov    r14,QWORD PTR [rbp+0x518]
   1855ed229:	4d 85 f6             	test   r14,r14
   1855ed22c:	74 1f                	je     0x1855ed24d
   1855ed22e:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1855ed233:	75 18                	jne    0x1855ed24d
   1855ed235:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed238:	4c 89 f1             	mov    rcx,r14
   1855ed23b:	ff 10                	call   QWORD PTR [rax]
   1855ed23d:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1855ed242:	75 09                	jne    0x1855ed24d
   1855ed244:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed247:	4c 89 f1             	mov    rcx,r14
   1855ed24a:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ed24d:	4c 8b 75 18          	mov    r14,QWORD PTR [rbp+0x18]
   1855ed251:	4d 85 f6             	test   r14,r14
   1855ed254:	74 1f                	je     0x1855ed275
   1855ed256:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1855ed25b:	75 18                	jne    0x1855ed275
   1855ed25d:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed260:	4c 89 f1             	mov    rcx,r14
   1855ed263:	ff 10                	call   QWORD PTR [rax]
   1855ed265:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1855ed26a:	75 09                	jne    0x1855ed275
   1855ed26c:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed26f:	4c 89 f1             	mov    rcx,r14
   1855ed272:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ed275:	4c 8b b5 98 04 00 00 	mov    r14,QWORD PTR [rbp+0x498]
   1855ed27c:	4d 85 f6             	test   r14,r14
   1855ed27f:	74 1f                	je     0x1855ed2a0
   1855ed281:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1855ed286:	75 18                	jne    0x1855ed2a0
   1855ed288:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed28b:	4c 89 f1             	mov    rcx,r14
   1855ed28e:	ff 10                	call   QWORD PTR [rax]
   1855ed290:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1855ed295:	75 09                	jne    0x1855ed2a0
   1855ed297:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed29a:	4c 89 f1             	mov    rcx,r14
   1855ed29d:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ed2a0:	4c 8b b5 38 04 00 00 	mov    r14,QWORD PTR [rbp+0x438]
   1855ed2a7:	4d 85 f6             	test   r14,r14
   1855ed2aa:	74 1f                	je     0x1855ed2cb
   1855ed2ac:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1855ed2b1:	75 18                	jne    0x1855ed2cb
   1855ed2b3:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed2b6:	4c 89 f1             	mov    rcx,r14
   1855ed2b9:	ff 10                	call   QWORD PTR [rax]
   1855ed2bb:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1855ed2c0:	75 09                	jne    0x1855ed2cb
   1855ed2c2:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed2c5:	4c 89 f1             	mov    rcx,r14
   1855ed2c8:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ed2cb:	48 8b 85 70 05 00 00 	mov    rax,QWORD PTR [rbp+0x570]
   1855ed2d2:	48 85 c0             	test   rax,rax
   1855ed2d5:	0f 84 cc 00 00 00    	je     0x1855ed3a7
   1855ed2db:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
   1855ed2df:	48 85 c9             	test   rcx,rcx
   1855ed2e2:	0f 84 b5 00 00 00    	je     0x1855ed39d
   1855ed2e8:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   1855ed2ec:	4c 8b 38             	mov    r15,QWORD PTR [rax]
   1855ed2ef:	4c 8b 70 08          	mov    r14,QWORD PTR [rax+0x8]
   1855ed2f3:	4d 85 f6             	test   r14,r14
   1855ed2f6:	74 1f                	je     0x1855ed317
   1855ed2f8:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1855ed2fd:	75 18                	jne    0x1855ed317
   1855ed2ff:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed302:	4c 89 f1             	mov    rcx,r14
   1855ed305:	ff 10                	call   QWORD PTR [rax]
   1855ed307:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1855ed30c:	75 09                	jne    0x1855ed317
   1855ed30e:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed311:	4c 89 f1             	mov    rcx,r14
   1855ed314:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ed317:	4d 85 ff             	test   r15,r15
   1855ed31a:	0f 84 87 00 00 00    	je     0x1855ed3a7
   1855ed320:	0f 29 b5 80 05 00 00 	movaps XMMWORD PTR [rbp+0x580],xmm6
   1855ed327:	48 8b 7e 38          	mov    rdi,QWORD PTR [rsi+0x38]
   1855ed32b:	b9 f0 01 00 00       	mov    ecx,0x1f0
   1855ed330:	e8 a7 e9 f5 01       	call   0x18754bcdc
   1855ed335:	90                   	nop
   1855ed336:	48 b9 01 00 00 00 01 	movabs rcx,0x100000001
   1855ed33d:	00 00 00
   1855ed340:	48 89 48 08          	mov    QWORD PTR [rax+0x8],rcx
   1855ed344:	48 8d 0d 4d d7 a9 03 	lea    rcx,[rip+0x3a9d74d]        # 0x18908aa98
   1855ed34b:	48 89 08             	mov    QWORD PTR [rax],rcx
   1855ed34e:	48 89 c3             	mov    rbx,rax
   1855ed351:	48 89 85 18 04 00 00 	mov    QWORD PTR [rbp+0x418],rax
   1855ed358:	48 83 c3 10          	add    rbx,0x10
   1855ed35c:	48 89 d9             	mov    rcx,rbx
   1855ed35f:	48 89 fa             	mov    rdx,rdi
   1855ed362:	e8 e9 64 ab fc       	call   0x1820a3850
   1855ed367:	90                   	nop
   1855ed368:	48 89 9d 80 05 00 00 	mov    QWORD PTR [rbp+0x580],rbx
   1855ed36f:	48 8b 95 18 04 00 00 	mov    rdx,QWORD PTR [rbp+0x418]
   1855ed376:	48 89 95 88 05 00 00 	mov    QWORD PTR [rbp+0x588],rdx
   1855ed37d:	48 8b 85 78 05 00 00 	mov    rax,QWORD PTR [rbp+0x578]
   1855ed384:	48 85 c0             	test   rax,rax
   1855ed387:	0f 84 6b 02 00 00    	je     0x1855ed5f8
   1855ed38d:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1855ed391:	48 8b 85 78 05 00 00 	mov    rax,QWORD PTR [rbp+0x578]
   1855ed398:	e9 5d 02 00 00       	jmp    0x1855ed5fa
   1855ed39d:	48 83 38 00          	cmp    QWORD PTR [rax],0x0
   1855ed3a1:	0f 85 79 ff ff ff    	jne    0x1855ed320
   1855ed3a7:	b9 04 00 00 00       	mov    ecx,0x4
   1855ed3ac:	e8 2f fa a7 fa       	call   0x18006cde0
   1855ed3b1:	85 c0                	test   eax,eax
   1855ed3b3:	0f 84 59 01 00 00    	je     0x1855ed512
   1855ed3b9:	4c 8d b5 70 03 00 00 	lea    r14,[rbp+0x370]
   1855ed3c0:	4c 89 f1             	mov    rcx,r14
   1855ed3c3:	e8 48 fb a7 fa       	call   0x18006cf10
   1855ed3c8:	90                   	nop
   1855ed3c9:	48 83 bd 88 03 00 00 	cmp    QWORD PTR [rbp+0x388],0x10
   1855ed3d0:	10
   1855ed3d1:	72 07                	jb     0x1855ed3da
   1855ed3d3:	4c 8b b5 70 03 00 00 	mov    r14,QWORD PTR [rbp+0x370]
   1855ed3da:	48 8d 05 ef 8c 41 04 	lea    rax,[rip+0x4418cef]        # 0x189a060d0
   1855ed3e1:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855ed3e6:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855ed3ed:	00 00
   1855ed3ef:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855ed3f4:	c7 44 24 28 71 04 00 	mov    DWORD PTR [rsp+0x28],0x471
   1855ed3fb:	00
   1855ed3fc:	4c 8d 0d bd 7e 41 04 	lea    r9,[rip+0x4417ebd]        # 0x189a052c0
   1855ed403:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855ed407:	ba 04 00 00 00       	mov    edx,0x4
   1855ed40c:	4d 89 f0             	mov    r8,r14
   1855ed40f:	e8 5c fe a7 fa       	call   0x18006d270
   1855ed414:	90                   	nop
   1855ed415:	48 8b 46 38          	mov    rax,QWORD PTR [rsi+0x38]
   1855ed419:	48 83 78 28 10       	cmp    QWORD PTR [rax+0x28],0x10
   1855ed41e:	72 1f                	jb     0x1855ed43f
   1855ed420:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
   1855ed424:	48 89 85 30 04 00 00 	mov    QWORD PTR [rbp+0x430],rax
   1855ed42b:	c6 85 38 04 00 00 00 	mov    BYTE PTR [rbp+0x438],0x0
   1855ed432:	48 83 7e 30 10       	cmp    QWORD PTR [rsi+0x30],0x10
   1855ed437:	73 1f                	jae    0x1855ed458
   1855ed439:	48 8d 46 18          	lea    rax,[rsi+0x18]
   1855ed43d:	eb 1d                	jmp    0x1855ed45c
   1855ed43f:	48 83 c0 10          	add    rax,0x10
   1855ed443:	48 89 85 30 04 00 00 	mov    QWORD PTR [rbp+0x430],rax
   1855ed44a:	c6 85 38 04 00 00 00 	mov    BYTE PTR [rbp+0x438],0x0
   1855ed451:	48 83 7e 30 10       	cmp    QWORD PTR [rsi+0x30],0x10
   1855ed456:	72 e1                	jb     0x1855ed439
   1855ed458:	48 8b 46 18          	mov    rax,QWORD PTR [rsi+0x18]
   1855ed45c:	48 89 85 10 05 00 00 	mov    QWORD PTR [rbp+0x510],rax
   1855ed463:	c6 85 18 05 00 00 00 	mov    BYTE PTR [rbp+0x518],0x0
   1855ed46a:	0f 57 c0             	xorps  xmm0,xmm0
   1855ed46d:	0f 11 85 00 05 00 00 	movups XMMWORD PTR [rbp+0x500],xmm0
   1855ed474:	0f 11 85 f0 04 00 00 	movups XMMWORD PTR [rbp+0x4f0],xmm0
   1855ed47b:	0f 11 85 e0 04 00 00 	movups XMMWORD PTR [rbp+0x4e0],xmm0
   1855ed482:	0f 11 85 d0 04 00 00 	movups XMMWORD PTR [rbp+0x4d0],xmm0
   1855ed489:	0f 11 85 c0 04 00 00 	movups XMMWORD PTR [rbp+0x4c0],xmm0
   1855ed490:	0f 11 85 b0 04 00 00 	movups XMMWORD PTR [rbp+0x4b0],xmm0
   1855ed497:	0f 11 85 a0 04 00 00 	movups XMMWORD PTR [rbp+0x4a0],xmm0
   1855ed49e:	48 89 9d 90 04 00 00 	mov    QWORD PTR [rbp+0x490],rbx
   1855ed4a5:	48 89 bd 98 04 00 00 	mov    QWORD PTR [rbp+0x498],rdi
   1855ed4ac:	48 8d 15 dd 99 41 04 	lea    rdx,[rip+0x44199dd]        # 0x189a06e90
   1855ed4b3:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855ed4b7:	4c 8d 85 90 04 00 00 	lea    r8,[rbp+0x490]
   1855ed4be:	e8 4d 03 a8 fa       	call   0x18006d810
   1855ed4c3:	90                   	nop
   1855ed4c4:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855ed4c8:	e8 a3 fe a7 fa       	call   0x18006d370
   1855ed4cd:	48 8b 85 88 03 00 00 	mov    rax,QWORD PTR [rbp+0x388]
   1855ed4d4:	48 83 f8 10          	cmp    rax,0x10
   1855ed4d8:	72 38                	jb     0x1855ed512
   1855ed4da:	48 8b 8d 70 03 00 00 	mov    rcx,QWORD PTR [rbp+0x370]
   1855ed4e1:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ed4e5:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ed4ec:	72 1f                	jb     0x1855ed50d
   1855ed4ee:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ed4f2:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ed4f6:	4c 29 c1             	sub    rcx,r8
   1855ed4f9:	48 83 f9 20          	cmp    rcx,0x20
   1855ed4fd:	0f 83 8d 0e 00 00    	jae    0x1855ee390
   1855ed503:	48 83 c0 28          	add    rax,0x28
   1855ed507:	48 89 c2             	mov    rdx,rax
   1855ed50a:	4c 89 c1             	mov    rcx,r8
   1855ed50d:	e8 0e e8 f5 01       	call   0x18754bd20
   1855ed512:	48 8b 76 08          	mov    rsi,QWORD PTR [rsi+0x8]
   1855ed516:	0f 57 c0             	xorps  xmm0,xmm0
   1855ed519:	0f 29 85 a0 04 00 00 	movaps XMMWORD PTR [rbp+0x4a0],xmm0
   1855ed520:	0f 29 85 90 04 00 00 	movaps XMMWORD PTR [rbp+0x490],xmm0
   1855ed527:	b9 30 00 00 00       	mov    ecx,0x30
   1855ed52c:	e8 ab e7 f5 01       	call   0x18754bcdc
   1855ed531:	90                   	nop
   1855ed532:	48 89 85 90 04 00 00 	mov    QWORD PTR [rbp+0x490],rax
   1855ed539:	48 c7 85 a0 04 00 00 	mov    QWORD PTR [rbp+0x4a0],0x20
   1855ed540:	20 00 00 00
   1855ed544:	48 c7 85 a8 04 00 00 	mov    QWORD PTR [rbp+0x4a8],0x2f
   1855ed54b:	2f 00 00 00
   1855ed54f:	0f 10 05 6a 7b 41 04 	movups xmm0,XMMWORD PTR [rip+0x4417b6a]        # 0x189a050c0
   1855ed556:	0f 11 40 10          	movups XMMWORD PTR [rax+0x10],xmm0
   1855ed55a:	0f 10 05 4f 7b 41 04 	movups xmm0,XMMWORD PTR [rip+0x4417b4f]        # 0x189a050b0
   1855ed561:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   1855ed564:	c6 40 20 00          	mov    BYTE PTR [rax+0x20],0x0
   1855ed568:	0f 29 75 20          	movaps XMMWORD PTR [rbp+0x20],xmm6
   1855ed56c:	0f 29 75 30          	movaps XMMWORD PTR [rbp+0x30],xmm6
   1855ed570:	0f 29 75 50          	movaps XMMWORD PTR [rbp+0x50],xmm6
   1855ed574:	0f 29 75 10          	movaps XMMWORD PTR [rbp+0x10],xmm6
   1855ed578:	0f 29 75 40          	movaps XMMWORD PTR [rbp+0x40],xmm6
   1855ed57c:	c6 45 20 00          	mov    BYTE PTR [rbp+0x20],0x0
   1855ed580:	c6 45 30 00          	mov    BYTE PTR [rbp+0x30],0x0
   1855ed584:	c6 45 58 00          	mov    BYTE PTR [rbp+0x58],0x0
   1855ed588:	c6 45 10 00          	mov    BYTE PTR [rbp+0x10],0x0
   1855ed58c:	48 8d 4d 38          	lea    rcx,[rbp+0x38]
   1855ed590:	48 8d 95 90 04 00 00 	lea    rdx,[rbp+0x490]
   1855ed597:	e8 54 7a 3a fc       	call   0x181994ff0
   1855ed59c:	90                   	nop
   1855ed59d:	48 8d 55 10          	lea    rdx,[rbp+0x10]
   1855ed5a1:	48 89 f1             	mov    rcx,rsi
   1855ed5a4:	e8 87 52 ff ff       	call   0x1855e2830
   1855ed5a9:	90                   	nop
   1855ed5aa:	48 8b 85 a8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4a8]
   1855ed5b1:	48 83 f8 10          	cmp    rax,0x10
   1855ed5b5:	0f 82 93 0d 00 00    	jb     0x1855ee34e
   1855ed5bb:	48 8b 8d 90 04 00 00 	mov    rcx,QWORD PTR [rbp+0x490]
   1855ed5c2:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ed5c6:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ed5cd:	72 1f                	jb     0x1855ed5ee
   1855ed5cf:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ed5d3:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ed5d7:	4c 29 c1             	sub    rcx,r8
   1855ed5da:	48 83 f9 20          	cmp    rcx,0x20
   1855ed5de:	0f 83 ac 0d 00 00    	jae    0x1855ee390
   1855ed5e4:	48 83 c0 28          	add    rax,0x28
   1855ed5e8:	48 89 c2             	mov    rdx,rax
   1855ed5eb:	4c 89 c1             	mov    rcx,r8
   1855ed5ee:	e8 2d e7 f5 01       	call   0x18754bd20
   1855ed5f3:	e9 56 0d 00 00       	jmp    0x1855ee34e
   1855ed5f8:	31 c0                	xor    eax,eax
   1855ed5fa:	48 8b 8d 70 05 00 00 	mov    rcx,QWORD PTR [rbp+0x570]
   1855ed601:	48 89 8a e0 01 00 00 	mov    QWORD PTR [rdx+0x1e0],rcx
   1855ed608:	48 8b ba e8 01 00 00 	mov    rdi,QWORD PTR [rdx+0x1e8]
   1855ed60f:	48 89 82 e8 01 00 00 	mov    QWORD PTR [rdx+0x1e8],rax
   1855ed616:	48 85 ff             	test   rdi,rdi
   1855ed619:	74 1d                	je     0x1855ed638
   1855ed61b:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1855ed61f:	75 17                	jne    0x1855ed638
   1855ed621:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855ed624:	48 89 f9             	mov    rcx,rdi
   1855ed627:	ff 10                	call   QWORD PTR [rax]
   1855ed629:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1855ed62d:	75 09                	jne    0x1855ed638
   1855ed62f:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855ed632:	48 89 f9             	mov    rcx,rdi
   1855ed635:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ed638:	48 8b 9d 80 05 00 00 	mov    rbx,QWORD PTR [rbp+0x580]
   1855ed63f:	c6 83 91 01 00 00 01 	mov    BYTE PTR [rbx+0x191],0x1
   1855ed646:	48 8d bd 30 04 00 00 	lea    rdi,[rbp+0x430]
   1855ed64d:	48 89 f9             	mov    rcx,rdi
   1855ed650:	e8 cb 9b a5 fa       	call   0x180047220
   1855ed655:	90                   	nop
   1855ed656:	48 8b 8d 30 04 00 00 	mov    rcx,QWORD PTR [rbp+0x430]
   1855ed65d:	48 8d 95 90 04 00 00 	lea    rdx,[rbp+0x490]
   1855ed664:	e8 67 4d d9 fa       	call   0x1803823d0
   1855ed669:	90                   	nop
   1855ed66a:	48 8b 8d 90 04 00 00 	mov    rcx,QWORD PTR [rbp+0x490]
   1855ed671:	48 8d 55 10          	lea    rdx,[rbp+0x10]
   1855ed675:	e8 06 75 8c fb       	call   0x180eb4b80
   1855ed67a:	90                   	nop
   1855ed67b:	48 8b 4d 10          	mov    rcx,QWORD PTR [rbp+0x10]
   1855ed67f:	0f 57 c0             	xorps  xmm0,xmm0
   1855ed682:	0f 29 85 10 05 00 00 	movaps XMMWORD PTR [rbp+0x510],xmm0
   1855ed689:	48 8b 85 88 05 00 00 	mov    rax,QWORD PTR [rbp+0x588]
   1855ed690:	48 85 c0             	test   rax,rax
   1855ed693:	74 14                	je     0x1855ed6a9
   1855ed695:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1855ed699:	48 8b 9d 80 05 00 00 	mov    rbx,QWORD PTR [rbp+0x580]
   1855ed6a0:	48 8b 85 88 05 00 00 	mov    rax,QWORD PTR [rbp+0x588]
   1855ed6a7:	eb 02                	jmp    0x1855ed6ab
   1855ed6a9:	31 c0                	xor    eax,eax
   1855ed6ab:	48 89 9d 10 05 00 00 	mov    QWORD PTR [rbp+0x510],rbx
   1855ed6b2:	48 89 85 18 05 00 00 	mov    QWORD PTR [rbp+0x518],rax
   1855ed6b9:	48 8d 9d 10 05 00 00 	lea    rbx,[rbp+0x510]
   1855ed6c0:	48 89 da             	mov    rdx,rbx
   1855ed6c3:	41 b8 f4 01 00 00    	mov    r8d,0x1f4
   1855ed6c9:	e8 32 3a 77 fd       	call   0x182d61100
   1855ed6ce:	90                   	nop
   1855ed6cf:	4c 8b b5 18 05 00 00 	mov    r14,QWORD PTR [rbp+0x518]
   1855ed6d6:	4d 85 f6             	test   r14,r14
   1855ed6d9:	74 1f                	je     0x1855ed6fa
   1855ed6db:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1855ed6e0:	75 18                	jne    0x1855ed6fa
   1855ed6e2:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed6e5:	4c 89 f1             	mov    rcx,r14
   1855ed6e8:	ff 10                	call   QWORD PTR [rax]
   1855ed6ea:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1855ed6ef:	75 09                	jne    0x1855ed6fa
   1855ed6f1:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed6f4:	4c 89 f1             	mov    rcx,r14
   1855ed6f7:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ed6fa:	4c 8b 75 18          	mov    r14,QWORD PTR [rbp+0x18]
   1855ed6fe:	4d 85 f6             	test   r14,r14
   1855ed701:	74 1f                	je     0x1855ed722
   1855ed703:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1855ed708:	75 18                	jne    0x1855ed722
   1855ed70a:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed70d:	4c 89 f1             	mov    rcx,r14
   1855ed710:	ff 10                	call   QWORD PTR [rax]
   1855ed712:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1855ed717:	75 09                	jne    0x1855ed722
   1855ed719:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed71c:	4c 89 f1             	mov    rcx,r14
   1855ed71f:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ed722:	4c 8b b5 98 04 00 00 	mov    r14,QWORD PTR [rbp+0x498]
   1855ed729:	4d 85 f6             	test   r14,r14
   1855ed72c:	74 1f                	je     0x1855ed74d
   1855ed72e:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1855ed733:	75 18                	jne    0x1855ed74d
   1855ed735:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed738:	4c 89 f1             	mov    rcx,r14
   1855ed73b:	ff 10                	call   QWORD PTR [rax]
   1855ed73d:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1855ed742:	75 09                	jne    0x1855ed74d
   1855ed744:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed747:	4c 89 f1             	mov    rcx,r14
   1855ed74a:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ed74d:	4c 8b b5 38 04 00 00 	mov    r14,QWORD PTR [rbp+0x438]
   1855ed754:	4d 85 f6             	test   r14,r14
   1855ed757:	74 1f                	je     0x1855ed778
   1855ed759:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1855ed75e:	75 18                	jne    0x1855ed778
   1855ed760:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed763:	4c 89 f1             	mov    rcx,r14
   1855ed766:	ff 10                	call   QWORD PTR [rax]
   1855ed768:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1855ed76d:	75 09                	jne    0x1855ed778
   1855ed76f:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed772:	4c 89 f1             	mov    rcx,r14
   1855ed775:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ed778:	4c 8b b5 80 05 00 00 	mov    r14,QWORD PTR [rbp+0x580]
   1855ed77f:	41 c6 86 91 01 00 00 	mov    BYTE PTR [r14+0x191],0x0
   1855ed786:	00
   1855ed787:	0f 29 b5 60 05 00 00 	movaps XMMWORD PTR [rbp+0x560],xmm6
   1855ed78e:	48 8d 8d 60 05 00 00 	lea    rcx,[rbp+0x560]
   1855ed795:	e8 66 52 62 fc       	call   0x181c12a00
   1855ed79a:	90                   	nop
   1855ed79b:	48 8b 85 60 05 00 00 	mov    rax,QWORD PTR [rbp+0x560]
   1855ed7a2:	c7 80 18 01 00 00 2f 	mov    DWORD PTR [rax+0x118],0x2f
   1855ed7a9:	00 00 00
   1855ed7ac:	48 8b 8d 88 05 00 00 	mov    rcx,QWORD PTR [rbp+0x588]
   1855ed7b3:	48 85 c9             	test   rcx,rcx
   1855ed7b6:	74 14                	je     0x1855ed7cc
   1855ed7b8:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   1855ed7bc:	4c 8b b5 80 05 00 00 	mov    r14,QWORD PTR [rbp+0x580]
   1855ed7c3:	48 8b 8d 88 05 00 00 	mov    rcx,QWORD PTR [rbp+0x588]
   1855ed7ca:	eb 02                	jmp    0x1855ed7ce
   1855ed7cc:	31 c9                	xor    ecx,ecx
   1855ed7ce:	4c 89 b0 58 07 00 00 	mov    QWORD PTR [rax+0x758],r14
   1855ed7d5:	4c 8b b0 60 07 00 00 	mov    r14,QWORD PTR [rax+0x760]
   1855ed7dc:	48 89 88 60 07 00 00 	mov    QWORD PTR [rax+0x760],rcx
   1855ed7e3:	4d 85 f6             	test   r14,r14
   1855ed7e6:	74 1f                	je     0x1855ed807
   1855ed7e8:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1855ed7ed:	75 18                	jne    0x1855ed807
   1855ed7ef:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed7f2:	4c 89 f1             	mov    rcx,r14
   1855ed7f5:	ff 10                	call   QWORD PTR [rax]
   1855ed7f7:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1855ed7fc:	75 09                	jne    0x1855ed807
   1855ed7fe:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed801:	4c 89 f1             	mov    rcx,r14
   1855ed804:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ed807:	48 8b 85 60 05 00 00 	mov    rax,QWORD PTR [rbp+0x560]
   1855ed80e:	48 8b 8d 78 05 00 00 	mov    rcx,QWORD PTR [rbp+0x578]
   1855ed815:	48 85 c9             	test   rcx,rcx
   1855ed818:	74 0d                	je     0x1855ed827
   1855ed81a:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   1855ed81e:	48 8b 8d 78 05 00 00 	mov    rcx,QWORD PTR [rbp+0x578]
   1855ed825:	eb 02                	jmp    0x1855ed829
   1855ed827:	31 c9                	xor    ecx,ecx
   1855ed829:	48 8b 95 70 05 00 00 	mov    rdx,QWORD PTR [rbp+0x570]
   1855ed830:	48 89 90 68 07 00 00 	mov    QWORD PTR [rax+0x768],rdx
   1855ed837:	4c 8b b0 70 07 00 00 	mov    r14,QWORD PTR [rax+0x770]
   1855ed83e:	48 89 88 70 07 00 00 	mov    QWORD PTR [rax+0x770],rcx
   1855ed845:	4d 85 f6             	test   r14,r14
   1855ed848:	74 1f                	je     0x1855ed869
   1855ed84a:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1855ed84f:	75 18                	jne    0x1855ed869
   1855ed851:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed854:	4c 89 f1             	mov    rcx,r14
   1855ed857:	ff 10                	call   QWORD PTR [rax]
   1855ed859:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1855ed85e:	75 09                	jne    0x1855ed869
   1855ed860:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855ed863:	4c 89 f1             	mov    rcx,r14
   1855ed866:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ed869:	4c 8d 76 48          	lea    r14,[rsi+0x48]
   1855ed86d:	48 8b 85 60 05 00 00 	mov    rax,QWORD PTR [rbp+0x560]
   1855ed874:	4c 8d b8 b0 00 00 00 	lea    r15,[rax+0xb0]
   1855ed87b:	4d 39 f7             	cmp    r15,r14
   1855ed87e:	74 4f                	je     0x1855ed8cf
   1855ed880:	4c 8b 66 58          	mov    r12,QWORD PTR [rsi+0x58]
   1855ed884:	48 83 7e 60 10       	cmp    QWORD PTR [rsi+0x60],0x10
   1855ed889:	4d 89 f1             	mov    r9,r14
   1855ed88c:	72 04                	jb     0x1855ed892
   1855ed88e:	4c 8b 4e 48          	mov    r9,QWORD PTR [rsi+0x48]
   1855ed892:	48 8b 88 c8 00 00 00 	mov    rcx,QWORD PTR [rax+0xc8]
   1855ed899:	49 39 cc             	cmp    r12,rcx
   1855ed89c:	76 0e                	jbe    0x1855ed8ac
   1855ed89e:	4c 89 f9             	mov    rcx,r15
   1855ed8a1:	4c 89 e2             	mov    rdx,r12
   1855ed8a4:	e8 a7 08 a5 fa       	call   0x18003e150
   1855ed8a9:	90                   	nop
   1855ed8aa:	eb 23                	jmp    0x1855ed8cf
   1855ed8ac:	48 83 f9 10          	cmp    rcx,0x10
   1855ed8b0:	72 03                	jb     0x1855ed8b5
   1855ed8b2:	4d 8b 3f             	mov    r15,QWORD PTR [r15]
   1855ed8b5:	4c 89 a0 c0 00 00 00 	mov    QWORD PTR [rax+0xc0],r12
   1855ed8bc:	4c 89 f9             	mov    rcx,r15
   1855ed8bf:	4c 89 ca             	mov    rdx,r9
   1855ed8c2:	4d 89 e0             	mov    r8,r12
   1855ed8c5:	e8 76 75 12 02       	call   0x187714e40
   1855ed8ca:	43 c6 04 27 00       	mov    BYTE PTR [r15+r12*1],0x0
   1855ed8cf:	0f 29 b5 20 04 00 00 	movaps XMMWORD PTR [rbp+0x420],xmm6
   1855ed8d6:	48 8d 8d 90 04 00 00 	lea    rcx,[rbp+0x490]
   1855ed8dd:	e8 3e 99 a5 fa       	call   0x180047220
   1855ed8e2:	90                   	nop
   1855ed8e3:	48 8b 8d 90 04 00 00 	mov    rcx,QWORD PTR [rbp+0x490]
   1855ed8ea:	48 8d 55 10          	lea    rdx,[rbp+0x10]
   1855ed8ee:	e8 dd 4a d9 fa       	call   0x1803823d0
   1855ed8f3:	90                   	nop
   1855ed8f4:	48 8b 4d 10          	mov    rcx,QWORD PTR [rbp+0x10]
   1855ed8f8:	48 8d 95 20 04 00 00 	lea    rdx,[rbp+0x420]
   1855ed8ff:	e8 7c b9 11 fb       	call   0x180709280
   1855ed904:	90                   	nop
   1855ed905:	4c 8b 7d 18          	mov    r15,QWORD PTR [rbp+0x18]
   1855ed909:	4d 85 ff             	test   r15,r15
   1855ed90c:	74 1f                	je     0x1855ed92d
   1855ed90e:	f0 41 ff 4f 08       	lock dec DWORD PTR [r15+0x8]
   1855ed913:	75 18                	jne    0x1855ed92d
   1855ed915:	49 8b 07             	mov    rax,QWORD PTR [r15]
   1855ed918:	4c 89 f9             	mov    rcx,r15
   1855ed91b:	ff 10                	call   QWORD PTR [rax]
   1855ed91d:	f0 41 ff 4f 0c       	lock dec DWORD PTR [r15+0xc]
   1855ed922:	75 09                	jne    0x1855ed92d
   1855ed924:	49 8b 07             	mov    rax,QWORD PTR [r15]
   1855ed927:	4c 89 f9             	mov    rcx,r15
   1855ed92a:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ed92d:	4c 8b bd 98 04 00 00 	mov    r15,QWORD PTR [rbp+0x498]
   1855ed934:	4d 85 ff             	test   r15,r15
   1855ed937:	74 1f                	je     0x1855ed958
   1855ed939:	f0 41 ff 4f 08       	lock dec DWORD PTR [r15+0x8]
   1855ed93e:	75 18                	jne    0x1855ed958
   1855ed940:	49 8b 07             	mov    rax,QWORD PTR [r15]
   1855ed943:	4c 89 f9             	mov    rcx,r15
   1855ed946:	ff 10                	call   QWORD PTR [rax]
   1855ed948:	f0 41 ff 4f 0c       	lock dec DWORD PTR [r15+0xc]
   1855ed94d:	75 09                	jne    0x1855ed958
   1855ed94f:	49 8b 07             	mov    rax,QWORD PTR [r15]
   1855ed952:	4c 89 f9             	mov    rcx,r15
   1855ed955:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ed958:	48 8b 8d 20 04 00 00 	mov    rcx,QWORD PTR [rbp+0x420]
   1855ed95f:	48 85 c9             	test   rcx,rcx
   1855ed962:	74 50                	je     0x1855ed9b4
   1855ed964:	49 bf aa aa aa aa aa 	movabs r15,0xaaaaaaaaaaaaaaaa
   1855ed96b:	aa aa aa
   1855ed96e:	4c 89 bd f0 03 00 00 	mov    QWORD PTR [rbp+0x3f0],r15
   1855ed975:	0f 29 b5 e0 03 00 00 	movaps XMMWORD PTR [rbp+0x3e0],xmm6
   1855ed97c:	0f 29 b5 d0 03 00 00 	movaps XMMWORD PTR [rbp+0x3d0],xmm6
   1855ed983:	0f 29 b5 c0 03 00 00 	movaps XMMWORD PTR [rbp+0x3c0],xmm6
   1855ed98a:	0f 57 c0             	xorps  xmm0,xmm0
   1855ed98d:	0f 29 85 00 04 00 00 	movaps XMMWORD PTR [rbp+0x400],xmm0
   1855ed994:	48 8b 85 68 05 00 00 	mov    rax,QWORD PTR [rbp+0x568]
   1855ed99b:	48 85 c0             	test   rax,rax
   1855ed99e:	0f 84 e7 00 00 00    	je     0x1855eda8b
   1855ed9a4:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1855ed9a8:	48 8b 85 68 05 00 00 	mov    rax,QWORD PTR [rbp+0x568]
   1855ed9af:	e9 d9 00 00 00       	jmp    0x1855eda8d
   1855ed9b4:	48 8b 76 08          	mov    rsi,QWORD PTR [rsi+0x8]
   1855ed9b8:	0f 57 c0             	xorps  xmm0,xmm0
   1855ed9bb:	0f 29 85 a0 04 00 00 	movaps XMMWORD PTR [rbp+0x4a0],xmm0
   1855ed9c2:	0f 29 85 90 04 00 00 	movaps XMMWORD PTR [rbp+0x490],xmm0
   1855ed9c9:	b9 40 00 00 00       	mov    ecx,0x40
   1855ed9ce:	e8 09 e3 f5 01       	call   0x18754bcdc
   1855ed9d3:	90                   	nop
   1855ed9d4:	48 89 85 90 04 00 00 	mov    QWORD PTR [rbp+0x490],rax
   1855ed9db:	48 c7 85 a0 04 00 00 	mov    QWORD PTR [rbp+0x4a0],0x32
   1855ed9e2:	32 00 00 00
   1855ed9e6:	48 c7 85 a8 04 00 00 	mov    QWORD PTR [rbp+0x4a8],0x3f
   1855ed9ed:	3f 00 00 00
   1855ed9f1:	0f 10 05 c0 5f 41 04 	movups xmm0,XMMWORD PTR [rip+0x4415fc0]        # 0x189a039b8
   1855ed9f8:	0f 11 40 20          	movups XMMWORD PTR [rax+0x20],xmm0
   1855ed9fc:	0f 10 05 a5 5f 41 04 	movups xmm0,XMMWORD PTR [rip+0x4415fa5]        # 0x189a039a8
   1855eda03:	0f 11 40 10          	movups XMMWORD PTR [rax+0x10],xmm0
   1855eda07:	0f 10 05 8a 5f 41 04 	movups xmm0,XMMWORD PTR [rip+0x4415f8a]        # 0x189a03998
   1855eda0e:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   1855eda11:	66 c7 40 30 6c 65    	mov    WORD PTR [rax+0x30],0x656c
   1855eda17:	c6 40 32 00          	mov    BYTE PTR [rax+0x32],0x0
   1855eda1b:	0f 29 75 20          	movaps XMMWORD PTR [rbp+0x20],xmm6
   1855eda1f:	0f 29 75 30          	movaps XMMWORD PTR [rbp+0x30],xmm6
   1855eda23:	0f 29 75 50          	movaps XMMWORD PTR [rbp+0x50],xmm6
   1855eda27:	0f 29 75 10          	movaps XMMWORD PTR [rbp+0x10],xmm6
   1855eda2b:	0f 29 75 40          	movaps XMMWORD PTR [rbp+0x40],xmm6
   1855eda2f:	c6 45 20 00          	mov    BYTE PTR [rbp+0x20],0x0
   1855eda33:	c6 45 30 00          	mov    BYTE PTR [rbp+0x30],0x0
   1855eda37:	c6 45 58 00          	mov    BYTE PTR [rbp+0x58],0x0
   1855eda3b:	c6 45 10 00          	mov    BYTE PTR [rbp+0x10],0x0
   1855eda3f:	48 8d 4d 38          	lea    rcx,[rbp+0x38]
   1855eda43:	48 8d 95 90 04 00 00 	lea    rdx,[rbp+0x490]
   1855eda4a:	e8 a1 75 3a fc       	call   0x181994ff0
   1855eda4f:	90                   	nop
   1855eda50:	48 8d 55 10          	lea    rdx,[rbp+0x10]
   1855eda54:	48 89 f1             	mov    rcx,rsi
   1855eda57:	e8 d4 4d ff ff       	call   0x1855e2830
   1855eda5c:	90                   	nop
   1855eda5d:	48 8b 85 a8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4a8]
   1855eda64:	48 83 f8 10          	cmp    rax,0x10
   1855eda68:	0f 82 65 08 00 00    	jb     0x1855ee2d3
   1855eda6e:	48 8b 8d 90 04 00 00 	mov    rcx,QWORD PTR [rbp+0x490]
   1855eda75:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855eda79:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855eda80:	0f 83 29 08 00 00    	jae    0x1855ee2af
   1855eda86:	e9 43 08 00 00       	jmp    0x1855ee2ce
   1855eda8b:	31 c0                	xor    eax,eax
   1855eda8d:	48 8b 95 60 05 00 00 	mov    rdx,QWORD PTR [rbp+0x560]
   1855eda94:	48 89 95 00 04 00 00 	mov    QWORD PTR [rbp+0x400],rdx
   1855eda9b:	48 89 85 08 04 00 00 	mov    QWORD PTR [rbp+0x408],rax
   1855edaa2:	48 8d 95 c0 03 00 00 	lea    rdx,[rbp+0x3c0]
   1855edaa9:	4c 8d 85 00 04 00 00 	lea    r8,[rbp+0x400]
   1855edab0:	e8 ab 60 1b fc       	call   0x1817a3b60
   1855edab5:	90                   	nop
   1855edab6:	8b 85 c4 03 00 00    	mov    eax,DWORD PTR [rbp+0x3c4]
   1855edabc:	0b 85 c0 03 00 00    	or     eax,DWORD PTR [rbp+0x3c0]
   1855edac2:	0f 84 b8 00 00 00    	je     0x1855edb80
   1855edac8:	b9 04 00 00 00       	mov    ecx,0x4
   1855edacd:	e8 0e f3 a7 fa       	call   0x18006cde0
   1855edad2:	85 c0                	test   eax,eax
   1855edad4:	0f 84 a8 05 00 00    	je     0x1855ee082
   1855edada:	4c 8d b5 70 03 00 00 	lea    r14,[rbp+0x370]
   1855edae1:	4c 89 f1             	mov    rcx,r14
   1855edae4:	e8 27 f4 a7 fa       	call   0x18006cf10
   1855edae9:	90                   	nop
   1855edaea:	48 83 bd 88 03 00 00 	cmp    QWORD PTR [rbp+0x388],0x10
   1855edaf1:	10
   1855edaf2:	72 07                	jb     0x1855edafb
   1855edaf4:	4c 8b b5 70 03 00 00 	mov    r14,QWORD PTR [rbp+0x370]
   1855edafb:	48 8d 05 ce 85 41 04 	lea    rax,[rip+0x44185ce]        # 0x189a060d0
   1855edb02:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855edb07:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855edb0e:	00 00
   1855edb10:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855edb15:	c7 44 24 28 8f 04 00 	mov    DWORD PTR [rsp+0x28],0x48f
   1855edb1c:	00
   1855edb1d:	4c 8d 0d 9c 77 41 04 	lea    r9,[rip+0x441779c]        # 0x189a052c0
   1855edb24:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855edb28:	ba 04 00 00 00       	mov    edx,0x4
   1855edb2d:	4d 89 f0             	mov    r8,r14
   1855edb30:	e8 3b f7 a7 fa       	call   0x18006d270
   1855edb35:	90                   	nop
   1855edb36:	48 8d 8d c0 03 00 00 	lea    rcx,[rbp+0x3c0]
   1855edb3d:	4c 8d b5 00 03 00 00 	lea    r14,[rbp+0x300]
   1855edb44:	4c 89 f2             	mov    rdx,r14
   1855edb47:	e8 14 31 b2 fa       	call   0x180110c60
   1855edb4c:	90                   	nop
   1855edb4d:	48 83 bd 18 03 00 00 	cmp    QWORD PTR [rbp+0x318],0x10
   1855edb54:	10
   1855edb55:	72 07                	jb     0x1855edb5e
   1855edb57:	4c 8b b5 00 03 00 00 	mov    r14,QWORD PTR [rbp+0x300]
   1855edb5e:	4c 89 b5 30 04 00 00 	mov    QWORD PTR [rbp+0x430],r14
   1855edb65:	c6 85 38 04 00 00 00 	mov    BYTE PTR [rbp+0x438],0x0
   1855edb6c:	48 83 7e 30 10       	cmp    QWORD PTR [rsi+0x30],0x10
   1855edb71:	0f 82 0c 04 00 00    	jb     0x1855edf83
   1855edb77:	48 8b 46 18          	mov    rax,QWORD PTR [rsi+0x18]
   1855edb7b:	e9 07 04 00 00       	jmp    0x1855edf87
   1855edb80:	0f 29 b5 20 05 00 00 	movaps XMMWORD PTR [rbp+0x520],xmm6
   1855edb87:	0f 29 b5 30 05 00 00 	movaps XMMWORD PTR [rbp+0x530],xmm6
   1855edb8e:	0f 29 b5 50 05 00 00 	movaps XMMWORD PTR [rbp+0x550],xmm6
   1855edb95:	0f 29 b5 10 05 00 00 	movaps XMMWORD PTR [rbp+0x510],xmm6
   1855edb9c:	0f 29 b5 40 05 00 00 	movaps XMMWORD PTR [rbp+0x540],xmm6
   1855edba3:	c6 85 20 05 00 00 00 	mov    BYTE PTR [rbp+0x520],0x0
   1855edbaa:	c6 85 30 05 00 00 00 	mov    BYTE PTR [rbp+0x530],0x0
   1855edbb1:	c6 85 58 05 00 00 00 	mov    BYTE PTR [rbp+0x558],0x0
   1855edbb8:	c6 85 10 05 00 00 01 	mov    BYTE PTR [rbp+0x510],0x1
   1855edbbf:	4c 89 bd 80 04 00 00 	mov    QWORD PTR [rbp+0x480],r15
   1855edbc6:	0f 29 b5 70 04 00 00 	movaps XMMWORD PTR [rbp+0x470],xmm6
   1855edbcd:	0f 29 b5 60 04 00 00 	movaps XMMWORD PTR [rbp+0x460],xmm6
   1855edbd4:	0f 29 b5 50 04 00 00 	movaps XMMWORD PTR [rbp+0x450],xmm6
   1855edbdb:	0f 29 b5 40 04 00 00 	movaps XMMWORD PTR [rbp+0x440],xmm6
   1855edbe2:	0f 29 b5 30 04 00 00 	movaps XMMWORD PTR [rbp+0x430],xmm6
   1855edbe9:	48 8b 95 e8 03 00 00 	mov    rdx,QWORD PTR [rbp+0x3e8]
   1855edbf0:	c6 85 80 04 00 00 00 	mov    BYTE PTR [rbp+0x480],0x0
   1855edbf7:	80 7a 50 01          	cmp    BYTE PTR [rdx+0x50],0x1
   1855edbfb:	0f 85 86 00 00 00    	jne    0x1855edc87
   1855edc01:	48 8d 8d 30 04 00 00 	lea    rcx,[rbp+0x430]
   1855edc08:	e8 c3 fb 18 fb       	call   0x18077d7d0
   1855edc0d:	90                   	nop
   1855edc0e:	c6 85 80 04 00 00 01 	mov    BYTE PTR [rbp+0x480],0x1
   1855edc15:	8b 9d 50 04 00 00    	mov    ebx,DWORD PTR [rbp+0x450]
   1855edc1b:	48 89 9d 28 05 00 00 	mov    QWORD PTR [rbp+0x528],rbx
   1855edc22:	c6 85 30 05 00 00 01 	mov    BYTE PTR [rbp+0x530],0x1
   1855edc29:	48 8d 15 88 55 ab 03 	lea    rdx,[rip+0x3ab5588]        # 0x1890a31b8
   1855edc30:	48 8d 7d 10          	lea    rdi,[rbp+0x10]
   1855edc34:	41 b8 f0 02 00 00    	mov    r8d,0x2f0
   1855edc3a:	48 89 f9             	mov    rcx,rdi
   1855edc3d:	e8 fe 71 12 02       	call   0x187714e40
   1855edc42:	48 8b 8d 20 04 00 00 	mov    rcx,QWORD PTR [rbp+0x420]
   1855edc49:	44 8b 8d 54 04 00 00 	mov    r9d,DWORD PTR [rbp+0x454]
   1855edc50:	89 5c 24 20          	mov    DWORD PTR [rsp+0x20],ebx
   1855edc54:	48 89 fa             	mov    rdx,rdi
   1855edc57:	4d 89 f0             	mov    r8,r14
   1855edc5a:	e8 31 bf 1c fc       	call   0x1817b9b90
   1855edc5f:	90                   	nop
   1855edc60:	80 bd f8 02 00 00 01 	cmp    BYTE PTR [rbp+0x2f8],0x1
   1855edc67:	75 1e                	jne    0x1855edc87
   1855edc69:	48 8b 85 58 01 00 00 	mov    rax,QWORD PTR [rbp+0x158]
   1855edc70:	48 89 85 18 05 00 00 	mov    QWORD PTR [rbp+0x518],rax
   1855edc77:	c6 85 20 05 00 00 01 	mov    BYTE PTR [rbp+0x520],0x1
   1855edc7e:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855edc82:	e8 b9 e9 bd fa       	call   0x1801cc640
   1855edc87:	b9 02 00 00 00       	mov    ecx,0x2
   1855edc8c:	e8 4f f1 a7 fa       	call   0x18006cde0
   1855edc91:	85 c0                	test   eax,eax
   1855edc93:	74 6d                	je     0x1855edd02
   1855edc95:	48 8d bd 50 03 00 00 	lea    rdi,[rbp+0x350]
   1855edc9c:	48 89 f9             	mov    rcx,rdi
   1855edc9f:	e8 6c f2 a7 fa       	call   0x18006cf10
   1855edca4:	90                   	nop
   1855edca5:	48 83 bd 68 03 00 00 	cmp    QWORD PTR [rbp+0x368],0x10
   1855edcac:	10
   1855edcad:	72 07                	jb     0x1855edcb6
   1855edcaf:	48 8b bd 50 03 00 00 	mov    rdi,QWORD PTR [rbp+0x350]
   1855edcb6:	48 8d 05 13 84 41 04 	lea    rax,[rip+0x4418413]        # 0x189a060d0
   1855edcbd:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855edcc2:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855edcc9:	00 00
   1855edccb:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855edcd0:	c7 44 24 28 9c 04 00 	mov    DWORD PTR [rsp+0x28],0x49c
   1855edcd7:	00
   1855edcd8:	4c 8d 0d e1 75 41 04 	lea    r9,[rip+0x44175e1]        # 0x189a052c0
   1855edcdf:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855edce3:	ba 02 00 00 00       	mov    edx,0x2
   1855edce8:	49 89 f8             	mov    r8,rdi
   1855edceb:	e8 80 f5 a7 fa       	call   0x18006d270
   1855edcf0:	90                   	nop
   1855edcf1:	48 8b 46 38          	mov    rax,QWORD PTR [rsi+0x38]
   1855edcf5:	48 83 78 28 10       	cmp    QWORD PTR [rax+0x28],0x10
   1855edcfa:	72 34                	jb     0x1855edd30
   1855edcfc:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
   1855edd00:	eb 32                	jmp    0x1855edd34
   1855edd02:	48 8b 4e 08          	mov    rcx,QWORD PTR [rsi+0x8]
   1855edd06:	48 8b 85 30 05 00 00 	mov    rax,QWORD PTR [rbp+0x530]
   1855edd0d:	48 89 45 30          	mov    QWORD PTR [rbp+0x30],rax
   1855edd11:	0f 28 85 10 05 00 00 	movaps xmm0,XMMWORD PTR [rbp+0x510]
   1855edd18:	0f 28 8d 20 05 00 00 	movaps xmm1,XMMWORD PTR [rbp+0x520]
   1855edd1f:	0f 29 4d 20          	movaps XMMWORD PTR [rbp+0x20],xmm1
   1855edd23:	0f 29 45 10          	movaps XMMWORD PTR [rbp+0x10],xmm0
   1855edd27:	c6 45 58 00          	mov    BYTE PTR [rbp+0x58],0x0
   1855edd2b:	e9 79 01 00 00       	jmp    0x1855edea9
   1855edd30:	48 83 c0 10          	add    rax,0x10
   1855edd34:	48 89 85 70 03 00 00 	mov    QWORD PTR [rbp+0x370],rax
   1855edd3b:	c6 85 78 03 00 00 00 	mov    BYTE PTR [rbp+0x378],0x0
   1855edd42:	48 83 7e 60 10       	cmp    QWORD PTR [rsi+0x60],0x10
   1855edd47:	72 04                	jb     0x1855edd4d
   1855edd49:	4c 8b 76 48          	mov    r14,QWORD PTR [rsi+0x48]
   1855edd4d:	4c 89 b5 00 03 00 00 	mov    QWORD PTR [rbp+0x300],r14
   1855edd54:	c6 85 08 03 00 00 00 	mov    BYTE PTR [rbp+0x308],0x0
   1855edd5b:	48 83 7e 30 10       	cmp    QWORD PTR [rsi+0x30],0x10
   1855edd60:	72 06                	jb     0x1855edd68
   1855edd62:	48 8b 46 18          	mov    rax,QWORD PTR [rsi+0x18]
   1855edd66:	eb 04                	jmp    0x1855edd6c
   1855edd68:	48 8d 46 18          	lea    rax,[rsi+0x18]
   1855edd6c:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
   1855edd70:	c6 45 c8 00          	mov    BYTE PTR [rbp-0x38],0x0
   1855edd74:	0f 57 c0             	xorps  xmm0,xmm0
   1855edd77:	0f 11 85 f8 04 00 00 	movups XMMWORD PTR [rbp+0x4f8],xmm0
   1855edd7e:	0f 11 85 e8 04 00 00 	movups XMMWORD PTR [rbp+0x4e8],xmm0
   1855edd85:	0f 11 85 d8 04 00 00 	movups XMMWORD PTR [rbp+0x4d8],xmm0
   1855edd8c:	0f 11 85 c8 04 00 00 	movups XMMWORD PTR [rbp+0x4c8],xmm0
   1855edd93:	0f 11 85 b8 04 00 00 	movups XMMWORD PTR [rbp+0x4b8],xmm0
   1855edd9a:	0f 11 85 a8 04 00 00 	movups XMMWORD PTR [rbp+0x4a8],xmm0
   1855edda1:	48 c7 85 08 05 00 00 	mov    QWORD PTR [rbp+0x508],0x0
   1855edda8:	00 00 00 00
   1855eddac:	48 8d 45 c0          	lea    rax,[rbp-0x40]
   1855eddb0:	48 89 85 90 04 00 00 	mov    QWORD PTR [rbp+0x490],rax
   1855eddb7:	48 8d 85 00 03 00 00 	lea    rax,[rbp+0x300]
   1855eddbe:	48 89 85 98 04 00 00 	mov    QWORD PTR [rbp+0x498],rax
   1855eddc5:	48 8d 85 70 03 00 00 	lea    rax,[rbp+0x370]
   1855eddcc:	48 89 85 a0 04 00 00 	mov    QWORD PTR [rbp+0x4a0],rax
   1855eddd3:	48 8d 15 6e 91 41 04 	lea    rdx,[rip+0x441916e]        # 0x189a06f48
   1855eddda:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855eddde:	4c 8d 85 90 04 00 00 	lea    r8,[rbp+0x490]
   1855edde5:	e8 26 fa a7 fa       	call   0x18006d810
   1855eddea:	90                   	nop
   1855eddeb:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855eddef:	e8 7c f5 a7 fa       	call   0x18006d370
   1855eddf4:	48 8b 85 68 03 00 00 	mov    rax,QWORD PTR [rbp+0x368]
   1855eddfb:	48 83 f8 10          	cmp    rax,0x10
   1855eddff:	72 38                	jb     0x1855ede39
   1855ede01:	48 8b 8d 50 03 00 00 	mov    rcx,QWORD PTR [rbp+0x350]
   1855ede08:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ede0c:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ede13:	72 1f                	jb     0x1855ede34
   1855ede15:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ede19:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ede1d:	4c 29 c1             	sub    rcx,r8
   1855ede20:	48 83 f9 20          	cmp    rcx,0x20
   1855ede24:	0f 83 66 05 00 00    	jae    0x1855ee390
   1855ede2a:	48 83 c0 28          	add    rax,0x28
   1855ede2e:	48 89 c2             	mov    rdx,rax
   1855ede31:	4c 89 c1             	mov    rcx,r8
   1855ede34:	e8 e7 de f5 01       	call   0x18754bd20
   1855ede39:	0f b6 85 58 05 00 00 	movzx  eax,BYTE PTR [rbp+0x558]
   1855ede40:	48 8b 4e 08          	mov    rcx,QWORD PTR [rsi+0x8]
   1855ede44:	0f 28 85 10 05 00 00 	movaps xmm0,XMMWORD PTR [rbp+0x510]
   1855ede4b:	0f 28 8d 20 05 00 00 	movaps xmm1,XMMWORD PTR [rbp+0x520]
   1855ede52:	0f 29 45 10          	movaps XMMWORD PTR [rbp+0x10],xmm0
   1855ede56:	0f 29 4d 20          	movaps XMMWORD PTR [rbp+0x20],xmm1
   1855ede5a:	48 8b 95 30 05 00 00 	mov    rdx,QWORD PTR [rbp+0x530]
   1855ede61:	48 89 55 30          	mov    QWORD PTR [rbp+0x30],rdx
   1855ede65:	c6 45 58 00          	mov    BYTE PTR [rbp+0x58],0x0
   1855ede69:	3c 01                	cmp    al,0x1
   1855ede6b:	75 3c                	jne    0x1855edea9
   1855ede6d:	0f 10 85 38 05 00 00 	movups xmm0,XMMWORD PTR [rbp+0x538]
   1855ede74:	0f 10 8d 48 05 00 00 	movups xmm1,XMMWORD PTR [rbp+0x548]
   1855ede7b:	0f 11 4d 48          	movups XMMWORD PTR [rbp+0x48],xmm1
   1855ede7f:	0f 11 45 38          	movups XMMWORD PTR [rbp+0x38],xmm0
   1855ede83:	48 c7 85 48 05 00 00 	mov    QWORD PTR [rbp+0x548],0x0
   1855ede8a:	00 00 00 00
   1855ede8e:	48 c7 85 50 05 00 00 	mov    QWORD PTR [rbp+0x550],0xf
   1855ede95:	0f 00 00 00
   1855ede99:	c6 85 38 05 00 00 00 	mov    BYTE PTR [rbp+0x538],0x0
   1855edea0:	c6 45 58 01          	mov    BYTE PTR [rbp+0x58],0x1
   1855edea4:	40 b6 01             	mov    sil,0x1
   1855edea7:	eb 02                	jmp    0x1855edeab
   1855edea9:	31 f6                	xor    esi,esi
   1855edeab:	48 8d 55 10          	lea    rdx,[rbp+0x10]
   1855edeaf:	e8 7c 49 ff ff       	call   0x1855e2830
   1855edeb4:	90                   	nop
   1855edeb5:	80 bd 80 04 00 00 01 	cmp    BYTE PTR [rbp+0x480],0x1
   1855edebc:	0f 85 8a 00 00 00    	jne    0x1855edf4c
   1855edec2:	48 8b 85 78 04 00 00 	mov    rax,QWORD PTR [rbp+0x478]
   1855edec9:	48 83 f8 10          	cmp    rax,0x10
   1855edecd:	72 38                	jb     0x1855edf07
   1855edecf:	48 8b 8d 60 04 00 00 	mov    rcx,QWORD PTR [rbp+0x460]
   1855eded6:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ededa:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855edee1:	72 1f                	jb     0x1855edf02
   1855edee3:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855edee7:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855edeeb:	4c 29 c1             	sub    rcx,r8
   1855edeee:	48 83 f9 20          	cmp    rcx,0x20
   1855edef2:	0f 83 98 04 00 00    	jae    0x1855ee390
   1855edef8:	48 83 c0 28          	add    rax,0x28
   1855edefc:	48 89 c2             	mov    rdx,rax
   1855edeff:	4c 89 c1             	mov    rcx,r8
   1855edf02:	e8 19 de f5 01       	call   0x18754bd20
   1855edf07:	48 8b 85 48 04 00 00 	mov    rax,QWORD PTR [rbp+0x448]
   1855edf0e:	48 83 f8 10          	cmp    rax,0x10
   1855edf12:	72 38                	jb     0x1855edf4c
   1855edf14:	48 8b 8d 30 04 00 00 	mov    rcx,QWORD PTR [rbp+0x430]
   1855edf1b:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855edf1f:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855edf26:	72 1f                	jb     0x1855edf47
   1855edf28:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855edf2c:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855edf30:	4c 29 c1             	sub    rcx,r8
   1855edf33:	48 83 f9 20          	cmp    rcx,0x20
   1855edf37:	0f 83 53 04 00 00    	jae    0x1855ee390
   1855edf3d:	48 83 c0 28          	add    rax,0x28
   1855edf41:	48 89 c2             	mov    rdx,rax
   1855edf44:	4c 89 c1             	mov    rcx,r8
   1855edf47:	e8 d4 dd f5 01       	call   0x18754bd20
   1855edf4c:	40 84 f6             	test   sil,sil
   1855edf4f:	0f 84 10 03 00 00    	je     0x1855ee265
   1855edf55:	48 8b 85 50 05 00 00 	mov    rax,QWORD PTR [rbp+0x550]
   1855edf5c:	48 83 f8 10          	cmp    rax,0x10
   1855edf60:	0f 82 ff 02 00 00    	jb     0x1855ee265
   1855edf66:	48 8b 8d 38 05 00 00 	mov    rcx,QWORD PTR [rbp+0x538]
   1855edf6d:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855edf71:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855edf78:	0f 82 e2 02 00 00    	jb     0x1855ee260
   1855edf7e:	e9 be 02 00 00       	jmp    0x1855ee241
   1855edf83:	48 8d 46 18          	lea    rax,[rsi+0x18]
   1855edf87:	48 89 85 10 05 00 00 	mov    QWORD PTR [rbp+0x510],rax
   1855edf8e:	c6 85 18 05 00 00 00 	mov    BYTE PTR [rbp+0x518],0x0
   1855edf95:	0f 57 c0             	xorps  xmm0,xmm0
   1855edf98:	0f 11 85 00 05 00 00 	movups XMMWORD PTR [rbp+0x500],xmm0
   1855edf9f:	0f 11 85 f0 04 00 00 	movups XMMWORD PTR [rbp+0x4f0],xmm0
   1855edfa6:	0f 11 85 e0 04 00 00 	movups XMMWORD PTR [rbp+0x4e0],xmm0
   1855edfad:	0f 11 85 d0 04 00 00 	movups XMMWORD PTR [rbp+0x4d0],xmm0
   1855edfb4:	0f 11 85 c0 04 00 00 	movups XMMWORD PTR [rbp+0x4c0],xmm0
   1855edfbb:	0f 11 85 b0 04 00 00 	movups XMMWORD PTR [rbp+0x4b0],xmm0
   1855edfc2:	0f 11 85 a0 04 00 00 	movups XMMWORD PTR [rbp+0x4a0],xmm0
   1855edfc9:	48 89 9d 90 04 00 00 	mov    QWORD PTR [rbp+0x490],rbx
   1855edfd0:	48 89 bd 98 04 00 00 	mov    QWORD PTR [rbp+0x498],rdi
   1855edfd7:	48 8d 15 12 8f 41 04 	lea    rdx,[rip+0x4418f12]        # 0x189a06ef0
   1855edfde:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855edfe2:	4c 8d 85 90 04 00 00 	lea    r8,[rbp+0x490]
   1855edfe9:	e8 22 f8 a7 fa       	call   0x18006d810
   1855edfee:	90                   	nop
   1855edfef:	48 8b 85 18 03 00 00 	mov    rax,QWORD PTR [rbp+0x318]
   1855edff6:	48 83 f8 10          	cmp    rax,0x10
   1855edffa:	72 38                	jb     0x1855ee034
   1855edffc:	48 8b 8d 00 03 00 00 	mov    rcx,QWORD PTR [rbp+0x300]
   1855ee003:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ee007:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ee00e:	72 1f                	jb     0x1855ee02f
   1855ee010:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ee014:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ee018:	4c 29 c1             	sub    rcx,r8
   1855ee01b:	48 83 f9 20          	cmp    rcx,0x20
   1855ee01f:	0f 83 6b 03 00 00    	jae    0x1855ee390
   1855ee025:	48 83 c0 28          	add    rax,0x28
   1855ee029:	48 89 c2             	mov    rdx,rax
   1855ee02c:	4c 89 c1             	mov    rcx,r8
   1855ee02f:	e8 ec dc f5 01       	call   0x18754bd20
   1855ee034:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855ee038:	e8 33 f3 a7 fa       	call   0x18006d370
   1855ee03d:	48 8b 85 88 03 00 00 	mov    rax,QWORD PTR [rbp+0x388]
   1855ee044:	48 83 f8 10          	cmp    rax,0x10
   1855ee048:	72 38                	jb     0x1855ee082
   1855ee04a:	48 8b 8d 70 03 00 00 	mov    rcx,QWORD PTR [rbp+0x370]
   1855ee051:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ee055:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ee05c:	72 1f                	jb     0x1855ee07d
   1855ee05e:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ee062:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ee066:	4c 29 c1             	sub    rcx,r8
   1855ee069:	48 83 f9 20          	cmp    rcx,0x20
   1855ee06d:	0f 83 1d 03 00 00    	jae    0x1855ee390
   1855ee073:	48 83 c0 28          	add    rax,0x28
   1855ee077:	48 89 c2             	mov    rdx,rax
   1855ee07a:	4c 89 c1             	mov    rcx,r8
   1855ee07d:	e8 9e dc f5 01       	call   0x18754bd20
   1855ee082:	48 8b 76 08          	mov    rsi,QWORD PTR [rsi+0x8]
   1855ee086:	48 8d 8d c0 03 00 00 	lea    rcx,[rbp+0x3c0]
   1855ee08d:	48 89 fa             	mov    rdx,rdi
   1855ee090:	e8 cb 2b b2 fa       	call   0x180110c60
   1855ee095:	90                   	nop
   1855ee096:	4c 8b 85 40 04 00 00 	mov    r8,QWORD PTR [rbp+0x440]
   1855ee09d:	48 8b 85 48 04 00 00 	mov    rax,QWORD PTR [rbp+0x448]
   1855ee0a4:	48 89 c1             	mov    rcx,rax
   1855ee0a7:	4c 29 c1             	sub    rcx,r8
   1855ee0aa:	48 8d 1d 0f 6e 41 04 	lea    rbx,[rip+0x4416e0f]        # 0x189a04ec0
   1855ee0b1:	48 83 f9 19          	cmp    rcx,0x19
   1855ee0b5:	73 2b                	jae    0x1855ee0e2
   1855ee0b7:	48 89 5c 24 20       	mov    QWORD PTR [rsp+0x20],rbx
   1855ee0bc:	48 c7 44 24 28 19 00 	mov    QWORD PTR [rsp+0x28],0x19
   1855ee0c3:	00 00
   1855ee0c5:	48 8d 8d 30 04 00 00 	lea    rcx,[rbp+0x430]
   1855ee0cc:	ba 19 00 00 00       	mov    edx,0x19
   1855ee0d1:	45 31 c9             	xor    r9d,r9d
   1855ee0d4:	e8 77 dc a1 fa       	call   0x18000bd50
   1855ee0d9:	90                   	nop
   1855ee0da:	48 89 c7             	mov    rdi,rax
   1855ee0dd:	e9 8f 00 00 00       	jmp    0x1855ee171
   1855ee0e2:	49 8d 48 19          	lea    rcx,[r8+0x19]
   1855ee0e6:	48 89 8d 40 04 00 00 	mov    QWORD PTR [rbp+0x440],rcx
   1855ee0ed:	48 83 f8 10          	cmp    rax,0x10
   1855ee0f1:	48 8b 8d 30 04 00 00 	mov    rcx,QWORD PTR [rbp+0x430]
   1855ee0f8:	49 89 fe             	mov    r14,rdi
   1855ee0fb:	4c 0f 43 f1          	cmovae r14,rcx
   1855ee0ff:	48 8d 15 d3 6d 41 04 	lea    rdx,[rip+0x4416dd3]        # 0x189a04ed9
   1855ee106:	49 39 d6             	cmp    r14,rdx
   1855ee109:	0f 93 c2             	setae  dl
   1855ee10c:	4f 8d 0c 06          	lea    r9,[r14+r8*1]
   1855ee110:	49 39 d9             	cmp    r9,rbx
   1855ee113:	41 0f 92 c1          	setb   r9b
   1855ee117:	41 08 d1             	or     r9b,dl
   1855ee11a:	41 bf 19 00 00 00    	mov    r15d,0x19
   1855ee120:	41 bc 19 00 00 00    	mov    r12d,0x19
   1855ee126:	75 0b                	jne    0x1855ee133
   1855ee128:	4d 89 f4             	mov    r12,r14
   1855ee12b:	49 29 dc             	sub    r12,rbx
   1855ee12e:	77 03                	ja     0x1855ee133
   1855ee130:	45 31 e4             	xor    r12d,r12d
   1855ee133:	49 ff c0             	inc    r8
   1855ee136:	48 83 f8 10          	cmp    rax,0x10
   1855ee13a:	48 0f 42 cf          	cmovb  rcx,rdi
   1855ee13e:	48 83 c1 19          	add    rcx,0x19
   1855ee142:	4c 89 f2             	mov    rdx,r14
   1855ee145:	e8 f6 6c 12 02       	call   0x187714e40
   1855ee14a:	4c 89 f1             	mov    rcx,r14
   1855ee14d:	48 89 da             	mov    rdx,rbx
   1855ee150:	4d 89 e0             	mov    r8,r12
   1855ee153:	e8 e8 6c 12 02       	call   0x187714e40
   1855ee158:	4d 29 e7             	sub    r15,r12
   1855ee15b:	49 8d 14 1c          	lea    rdx,[r12+rbx*1]
   1855ee15f:	48 83 c2 19          	add    rdx,0x19
   1855ee163:	4d 01 e6             	add    r14,r12
   1855ee166:	4c 89 f1             	mov    rcx,r14
   1855ee169:	4d 89 f8             	mov    r8,r15
   1855ee16c:	e8 cf 6c 12 02       	call   0x187714e40
   1855ee171:	0f 10 07             	movups xmm0,XMMWORD PTR [rdi]
   1855ee174:	0f 10 4f 10          	movups xmm1,XMMWORD PTR [rdi+0x10]
   1855ee178:	0f 29 8d a0 04 00 00 	movaps XMMWORD PTR [rbp+0x4a0],xmm1
   1855ee17f:	0f 29 85 90 04 00 00 	movaps XMMWORD PTR [rbp+0x490],xmm0
   1855ee186:	48 c7 47 10 00 00 00 	mov    QWORD PTR [rdi+0x10],0x0
   1855ee18d:	00
   1855ee18e:	48 c7 47 18 0f 00 00 	mov    QWORD PTR [rdi+0x18],0xf
   1855ee195:	00
   1855ee196:	c6 07 00             	mov    BYTE PTR [rdi],0x0
   1855ee199:	0f 29 75 20          	movaps XMMWORD PTR [rbp+0x20],xmm6
   1855ee19d:	0f 29 75 30          	movaps XMMWORD PTR [rbp+0x30],xmm6
   1855ee1a1:	0f 29 75 50          	movaps XMMWORD PTR [rbp+0x50],xmm6
   1855ee1a5:	0f 29 75 10          	movaps XMMWORD PTR [rbp+0x10],xmm6
   1855ee1a9:	0f 29 75 40          	movaps XMMWORD PTR [rbp+0x40],xmm6
   1855ee1ad:	c6 45 20 00          	mov    BYTE PTR [rbp+0x20],0x0
   1855ee1b1:	c6 45 30 00          	mov    BYTE PTR [rbp+0x30],0x0
   1855ee1b5:	c6 45 58 00          	mov    BYTE PTR [rbp+0x58],0x0
   1855ee1b9:	c6 45 10 00          	mov    BYTE PTR [rbp+0x10],0x0
   1855ee1bd:	48 8d 4d 38          	lea    rcx,[rbp+0x38]
   1855ee1c1:	48 8d 95 90 04 00 00 	lea    rdx,[rbp+0x490]
   1855ee1c8:	e8 23 6e 3a fc       	call   0x181994ff0
   1855ee1cd:	90                   	nop
   1855ee1ce:	48 8d 55 10          	lea    rdx,[rbp+0x10]
   1855ee1d2:	48 89 f1             	mov    rcx,rsi
   1855ee1d5:	e8 56 46 ff ff       	call   0x1855e2830
   1855ee1da:	90                   	nop
   1855ee1db:	48 8b 85 a8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4a8]
   1855ee1e2:	48 83 f8 10          	cmp    rax,0x10
   1855ee1e6:	72 38                	jb     0x1855ee220
   1855ee1e8:	48 8b 8d 90 04 00 00 	mov    rcx,QWORD PTR [rbp+0x490]
   1855ee1ef:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ee1f3:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ee1fa:	72 1f                	jb     0x1855ee21b
   1855ee1fc:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ee200:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ee204:	4c 29 c1             	sub    rcx,r8
   1855ee207:	48 83 f9 20          	cmp    rcx,0x20
   1855ee20b:	0f 83 7f 01 00 00    	jae    0x1855ee390
   1855ee211:	48 83 c0 28          	add    rax,0x28
   1855ee215:	48 89 c2             	mov    rdx,rax
   1855ee218:	4c 89 c1             	mov    rcx,r8
   1855ee21b:	e8 00 db f5 01       	call   0x18754bd20
   1855ee220:	48 8b 85 48 04 00 00 	mov    rax,QWORD PTR [rbp+0x448]
   1855ee227:	48 83 f8 10          	cmp    rax,0x10
   1855ee22b:	72 38                	jb     0x1855ee265
   1855ee22d:	48 8b 8d 30 04 00 00 	mov    rcx,QWORD PTR [rbp+0x430]
   1855ee234:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ee238:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ee23f:	72 1f                	jb     0x1855ee260
   1855ee241:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ee245:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ee249:	4c 29 c1             	sub    rcx,r8
   1855ee24c:	48 83 f9 20          	cmp    rcx,0x20
   1855ee250:	0f 83 3a 01 00 00    	jae    0x1855ee390
   1855ee256:	48 83 c0 28          	add    rax,0x28
   1855ee25a:	48 89 c2             	mov    rdx,rax
   1855ee25d:	4c 89 c1             	mov    rcx,r8
   1855ee260:	e8 bb da f5 01       	call   0x18754bd20
   1855ee265:	48 8b b5 f0 03 00 00 	mov    rsi,QWORD PTR [rbp+0x3f0]
   1855ee26c:	48 85 f6             	test   rsi,rsi
   1855ee26f:	74 1d                	je     0x1855ee28e
   1855ee271:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855ee275:	75 17                	jne    0x1855ee28e
   1855ee277:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ee27a:	48 89 f1             	mov    rcx,rsi
   1855ee27d:	ff 10                	call   QWORD PTR [rax]
   1855ee27f:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855ee283:	75 09                	jne    0x1855ee28e
   1855ee285:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ee288:	48 89 f1             	mov    rcx,rsi
   1855ee28b:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ee28e:	48 8b 85 e0 03 00 00 	mov    rax,QWORD PTR [rbp+0x3e0]
   1855ee295:	48 83 f8 10          	cmp    rax,0x10
   1855ee299:	72 38                	jb     0x1855ee2d3
   1855ee29b:	48 8b 8d c8 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3c8]
   1855ee2a2:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ee2a6:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ee2ad:	72 1f                	jb     0x1855ee2ce
   1855ee2af:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ee2b3:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ee2b7:	4c 29 c1             	sub    rcx,r8
   1855ee2ba:	48 83 f9 20          	cmp    rcx,0x20
   1855ee2be:	0f 83 cc 00 00 00    	jae    0x1855ee390
   1855ee2c4:	48 83 c0 28          	add    rax,0x28
   1855ee2c8:	48 89 c2             	mov    rdx,rax
   1855ee2cb:	4c 89 c1             	mov    rcx,r8
   1855ee2ce:	e8 4d da f5 01       	call   0x18754bd20
   1855ee2d3:	48 8b b5 28 04 00 00 	mov    rsi,QWORD PTR [rbp+0x428]
   1855ee2da:	48 85 f6             	test   rsi,rsi
   1855ee2dd:	74 1d                	je     0x1855ee2fc
   1855ee2df:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855ee2e3:	75 17                	jne    0x1855ee2fc
   1855ee2e5:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ee2e8:	48 89 f1             	mov    rcx,rsi
   1855ee2eb:	ff 10                	call   QWORD PTR [rax]
   1855ee2ed:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855ee2f1:	75 09                	jne    0x1855ee2fc
   1855ee2f3:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ee2f6:	48 89 f1             	mov    rcx,rsi
   1855ee2f9:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ee2fc:	48 8b b5 68 05 00 00 	mov    rsi,QWORD PTR [rbp+0x568]
   1855ee303:	48 85 f6             	test   rsi,rsi
   1855ee306:	74 1d                	je     0x1855ee325
   1855ee308:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855ee30c:	75 17                	jne    0x1855ee325
   1855ee30e:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ee311:	48 89 f1             	mov    rcx,rsi
   1855ee314:	ff 10                	call   QWORD PTR [rax]
   1855ee316:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855ee31a:	75 09                	jne    0x1855ee325
   1855ee31c:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ee31f:	48 89 f1             	mov    rcx,rsi
   1855ee322:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ee325:	48 8b b5 88 05 00 00 	mov    rsi,QWORD PTR [rbp+0x588]
   1855ee32c:	48 85 f6             	test   rsi,rsi
   1855ee32f:	74 1d                	je     0x1855ee34e
   1855ee331:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855ee335:	75 17                	jne    0x1855ee34e
   1855ee337:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ee33a:	48 89 f1             	mov    rcx,rsi
   1855ee33d:	ff 10                	call   QWORD PTR [rax]
   1855ee33f:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855ee343:	75 09                	jne    0x1855ee34e
   1855ee345:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ee348:	48 89 f1             	mov    rcx,rsi
   1855ee34b:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ee34e:	48 8b b5 78 05 00 00 	mov    rsi,QWORD PTR [rbp+0x578]
   1855ee355:	48 85 f6             	test   rsi,rsi
   1855ee358:	74 1d                	je     0x1855ee377
   1855ee35a:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855ee35e:	75 17                	jne    0x1855ee377
   1855ee360:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ee363:	48 89 f1             	mov    rcx,rsi
   1855ee366:	ff 10                	call   QWORD PTR [rax]
   1855ee368:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855ee36c:	75 09                	jne    0x1855ee377
   1855ee36e:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ee371:	48 89 f1             	mov    rcx,rsi
   1855ee374:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ee377:	0f 28 b5 a0 05 00 00 	movaps xmm6,XMMWORD PTR [rbp+0x5a0]
   1855ee37e:	48 81 c4 30 06 00 00 	add    rsp,0x630
   1855ee385:	5b                   	pop    rbx
   1855ee386:	5f                   	pop    rdi
   1855ee387:	5e                   	pop    rsi
   1855ee388:	41 5c                	pop    r12
   1855ee38a:	41 5e                	pop    r14
   1855ee38c:	41 5f                	pop    r15
   1855ee38e:	5d                   	pop    rbp
   1855ee38f:	c3                   	ret
   1855ee390:	e8 f7 fd 0e 02       	call   0x1876de18c
   1855ee395:	cc                   	int3
