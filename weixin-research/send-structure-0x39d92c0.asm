
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001839d92c0 <.text+0x39d82c0>:
   1839d92c0:	55                   	push   rbp
   1839d92c1:	41 56                	push   r14
   1839d92c3:	56                   	push   rsi
   1839d92c4:	57                   	push   rdi
   1839d92c5:	53                   	push   rbx
   1839d92c6:	48 81 ec b0 00 00 00 	sub    rsp,0xb0
   1839d92cd:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   1839d92d4:	00 
   1839d92d5:	0f 29 75 20          	movaps XMMWORD PTR [rbp+0x20],xmm6
   1839d92d9:	48 c7 45 18 fe ff ff 	mov    QWORD PTR [rbp+0x18],0xfffffffffffffffe
   1839d92e0:	ff 
   1839d92e1:	44 89 c3             	mov    ebx,r8d
   1839d92e4:	49 89 c8             	mov    r8,rcx
   1839d92e7:	48 8d 05 1a 99 d1 05 	lea    rax,[rip+0x5d1991a]        # 0x1896f2c08
   1839d92ee:	48 89 01             	mov    QWORD PTR [rcx],rax
   1839d92f1:	0f 57 c0             	xorps  xmm0,xmm0
   1839d92f4:	0f 11 41 08          	movups XMMWORD PTR [rcx+0x8],xmm0
   1839d92f8:	48 8b 42 08          	mov    rax,QWORD PTR [rdx+0x8]
   1839d92fc:	48 85 c0             	test   rax,rax
   1839d92ff:	74 04                	je     0x1839d9305
   1839d9301:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1839d9305:	49 8d 40 08          	lea    rax,[r8+0x8]
   1839d9309:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
   1839d930d:	48 8b 02             	mov    rax,QWORD PTR [rdx]
   1839d9310:	49 89 40 08          	mov    QWORD PTR [r8+0x8],rax
   1839d9314:	48 89 55 00          	mov    QWORD PTR [rbp+0x0],rdx
   1839d9318:	48 8b 42 08          	mov    rax,QWORD PTR [rdx+0x8]
   1839d931c:	49 89 40 10          	mov    QWORD PTR [r8+0x10],rax
   1839d9320:	49 8d 40 18          	lea    rax,[r8+0x18]
   1839d9324:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
   1839d9328:	49 8d 40 28          	lea    rax,[r8+0x28]
   1839d932c:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
   1839d9330:	49 8d 40 38          	lea    rax,[r8+0x38]
   1839d9334:	48 89 45 08          	mov    QWORD PTR [rbp+0x8],rax
   1839d9338:	41 0f 11 40 18       	movups XMMWORD PTR [r8+0x18],xmm0
   1839d933d:	41 0f 11 40 28       	movups XMMWORD PTR [r8+0x28],xmm0
   1839d9342:	41 0f 11 40 38       	movups XMMWORD PTR [r8+0x38],xmm0
   1839d9347:	49 c7 40 48 00 00 00 	mov    QWORD PTR [r8+0x48],0x0
   1839d934e:	00 
   1839d934f:	49 c7 40 50 0f 00 00 	mov    QWORD PTR [r8+0x50],0xf
   1839d9356:	00 
   1839d9357:	49 8d 40 58          	lea    rax,[r8+0x58]
   1839d935b:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
   1839d935f:	49 8d 48 78          	lea    rcx,[r8+0x78]
   1839d9363:	41 0f 11 40 58       	movups XMMWORD PTR [r8+0x58],xmm0
   1839d9368:	41 0f 11 40 68       	movups XMMWORD PTR [r8+0x68],xmm0
   1839d936d:	48 89 4d c0          	mov    QWORD PTR [rbp-0x40],rcx
   1839d9371:	4c 89 45 10          	mov    QWORD PTR [rbp+0x10],r8
   1839d9375:	e8 36 25 68 fc       	call   0x18005b8b0
   1839d937a:	90                   	nop
   1839d937b:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
   1839d937f:	48 8d 88 88 00 00 00 	lea    rcx,[rax+0x88]
   1839d9386:	48 89 4d c8          	mov    QWORD PTR [rbp-0x38],rcx
   1839d938a:	e8 21 25 68 fc       	call   0x18005b8b0
   1839d938f:	90                   	nop
   1839d9390:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
   1839d9394:	48 8d 88 98 00 00 00 	lea    rcx,[rax+0x98]
   1839d939b:	48 89 4d d0          	mov    QWORD PTR [rbp-0x30],rcx
   1839d939f:	e8 0c 25 68 fc       	call   0x18005b8b0
   1839d93a4:	90                   	nop
   1839d93a5:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
   1839d93a9:	48 8d 88 a8 00 00 00 	lea    rcx,[rax+0xa8]
   1839d93b0:	48 89 4d d8          	mov    QWORD PTR [rbp-0x28],rcx
   1839d93b4:	e8 f7 24 68 fc       	call   0x18005b8b0
   1839d93b9:	90                   	nop
   1839d93ba:	48 8b 4d 10          	mov    rcx,QWORD PTR [rbp+0x10]
   1839d93be:	88 99 b8 00 00 00    	mov    BYTE PTR [rcx+0xb8],bl
   1839d93c4:	48 8d 81 c0 00 00 00 	lea    rax,[rcx+0xc0]
   1839d93cb:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
   1839d93cf:	0f 57 f6             	xorps  xmm6,xmm6
   1839d93d2:	0f 11 b1 bc 00 00 00 	movups XMMWORD PTR [rcx+0xbc],xmm6
   1839d93d9:	0f 11 b1 c8 00 00 00 	movups XMMWORD PTR [rcx+0xc8],xmm6
   1839d93e0:	48 c7 81 d8 00 00 00 	mov    QWORD PTR [rcx+0xd8],0xf
   1839d93e7:	0f 00 00 00 
   1839d93eb:	48 8d 81 e0 00 00 00 	lea    rax,[rcx+0xe0]
   1839d93f2:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
   1839d93f6:	0f 11 b1 e0 00 00 00 	movups XMMWORD PTR [rcx+0xe0],xmm6
   1839d93fd:	48 8d 55 f0          	lea    rdx,[rbp-0x10]
   1839d9401:	e8 aa 03 00 00       	call   0x1839d97b0
   1839d9406:	90                   	nop
   1839d9407:	0f 28 45 f0          	movaps xmm0,XMMWORD PTR [rbp-0x10]
   1839d940b:	0f 29 75 f0          	movaps XMMWORD PTR [rbp-0x10],xmm6
   1839d940f:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
   1839d9413:	48 8b 70 20          	mov    rsi,QWORD PTR [rax+0x20]
   1839d9417:	0f 11 40 18          	movups XMMWORD PTR [rax+0x18],xmm0
   1839d941b:	48 85 f6             	test   rsi,rsi
   1839d941e:	74 1d                	je     0x1839d943d
   1839d9420:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1839d9424:	75 17                	jne    0x1839d943d
   1839d9426:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1839d9429:	48 89 f1             	mov    rcx,rsi
   1839d942c:	ff 10                	call   QWORD PTR [rax]
   1839d942e:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1839d9432:	75 09                	jne    0x1839d943d
   1839d9434:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1839d9437:	48 89 f1             	mov    rcx,rsi
   1839d943a:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1839d943d:	48 8b 75 f8          	mov    rsi,QWORD PTR [rbp-0x8]
   1839d9441:	48 85 f6             	test   rsi,rsi
   1839d9444:	48 8b 7d 00          	mov    rdi,QWORD PTR [rbp+0x0]
   1839d9448:	74 1d                	je     0x1839d9467
   1839d944a:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1839d944e:	75 17                	jne    0x1839d9467
   1839d9450:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1839d9453:	48 89 f1             	mov    rcx,rsi
   1839d9456:	ff 10                	call   QWORD PTR [rax]
   1839d9458:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1839d945c:	75 09                	jne    0x1839d9467
   1839d945e:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1839d9461:	48 89 f1             	mov    rcx,rsi
   1839d9464:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1839d9467:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1839d946a:	4c 8d 88 b0 00 00 00 	lea    r9,[rax+0xb0]
   1839d9471:	4c 39 4d 08          	cmp    QWORD PTR [rbp+0x8],r9
   1839d9475:	74 5b                	je     0x1839d94d2
   1839d9477:	48 8b b0 c0 00 00 00 	mov    rsi,QWORD PTR [rax+0xc0]
   1839d947e:	48 83 b8 c8 00 00 00 	cmp    QWORD PTR [rax+0xc8],0x10
   1839d9485:	10 
   1839d9486:	72 07                	jb     0x1839d948f
   1839d9488:	4c 8b 88 b0 00 00 00 	mov    r9,QWORD PTR [rax+0xb0]
   1839d948f:	48 8b 4d 10          	mov    rcx,QWORD PTR [rbp+0x10]
   1839d9493:	48 8b 41 50          	mov    rax,QWORD PTR [rcx+0x50]
   1839d9497:	48 39 c6             	cmp    rsi,rax
   1839d949a:	76 0f                	jbe    0x1839d94ab
   1839d949c:	48 8b 4d 08          	mov    rcx,QWORD PTR [rbp+0x8]
   1839d94a0:	48 89 f2             	mov    rdx,rsi
   1839d94a3:	e8 a8 4c 66 fc       	call   0x18003e150
   1839d94a8:	90                   	nop
   1839d94a9:	eb 27                	jmp    0x1839d94d2
   1839d94ab:	48 8b 7d 08          	mov    rdi,QWORD PTR [rbp+0x8]
   1839d94af:	48 83 f8 10          	cmp    rax,0x10
   1839d94b3:	72 07                	jb     0x1839d94bc
   1839d94b5:	48 8b 45 08          	mov    rax,QWORD PTR [rbp+0x8]
   1839d94b9:	48 8b 38             	mov    rdi,QWORD PTR [rax]
   1839d94bc:	48 89 71 48          	mov    QWORD PTR [rcx+0x48],rsi
   1839d94c0:	48 89 f9             	mov    rcx,rdi
   1839d94c3:	4c 89 ca             	mov    rdx,r9
   1839d94c6:	49 89 f0             	mov    r8,rsi
   1839d94c9:	e8 72 b9 d3 03       	call   0x187714e40
   1839d94ce:	c6 04 37 00          	mov    BYTE PTR [rdi+rsi*1],0x0
   1839d94d2:	b9 c8 00 00 00       	mov    ecx,0xc8
   1839d94d7:	e8 00 28 b7 03       	call   0x18754bcdc
   1839d94dc:	90                   	nop
   1839d94dd:	48 89 c6             	mov    rsi,rax
   1839d94e0:	48 8d 58 08          	lea    rbx,[rax+0x8]
   1839d94e4:	48 b8 01 00 00 00 01 	movabs rax,0x100000001
   1839d94eb:	00 00 00 
   1839d94ee:	48 89 46 08          	mov    QWORD PTR [rsi+0x8],rax
   1839d94f2:	48 8d 05 6f 98 d1 05 	lea    rax,[rip+0x5d1986f]        # 0x1896f2d68
   1839d94f9:	48 89 06             	mov    QWORD PTR [rsi],rax
   1839d94fc:	48 8d 46 10          	lea    rax,[rsi+0x10]
   1839d9500:	0f 57 c0             	xorps  xmm0,xmm0
   1839d9503:	0f 11 46 10          	movups XMMWORD PTR [rsi+0x10],xmm0
   1839d9507:	0f 11 46 30          	movups XMMWORD PTR [rsi+0x30],xmm0
   1839d950b:	0f 11 46 20          	movups XMMWORD PTR [rsi+0x20],xmm0
   1839d950f:	0f 11 46 50          	movups XMMWORD PTR [rsi+0x50],xmm0
   1839d9513:	0f 11 46 60          	movups XMMWORD PTR [rsi+0x60],xmm0
   1839d9517:	0f 11 46 70          	movups XMMWORD PTR [rsi+0x70],xmm0
   1839d951b:	0f 11 86 80 00 00 00 	movups XMMWORD PTR [rsi+0x80],xmm0
   1839d9522:	0f 11 86 90 00 00 00 	movups XMMWORD PTR [rsi+0x90],xmm0
   1839d9529:	48 c7 86 a0 00 00 00 	mov    QWORD PTR [rsi+0xa0],0x0
   1839d9530:	00 00 00 00 
   1839d9534:	c6 46 10 01          	mov    BYTE PTR [rsi+0x10],0x1
   1839d9538:	0f 11 46 28          	movups XMMWORD PTR [rsi+0x28],xmm0
   1839d953c:	0f 11 46 1c          	movups XMMWORD PTR [rsi+0x1c],xmm0
   1839d9540:	48 c7 46 38 0f 00 00 	mov    QWORD PTR [rsi+0x38],0xf
   1839d9547:	00 
   1839d9548:	0f 11 46 40          	movups XMMWORD PTR [rsi+0x40],xmm0
   1839d954c:	48 c7 46 50 00 00 00 	mov    QWORD PTR [rsi+0x50],0x0
   1839d9553:	00 
   1839d9554:	48 c7 46 58 0f 00 00 	mov    QWORD PTR [rsi+0x58],0xf
   1839d955b:	00 
   1839d955c:	0f 11 86 88 00 00 00 	movups XMMWORD PTR [rsi+0x88],xmm0
   1839d9563:	0f 11 46 78          	movups XMMWORD PTR [rsi+0x78],xmm0
   1839d9567:	66 c7 86 98 00 00 00 	mov    WORD PTR [rsi+0x98],0x0
   1839d956e:	00 00 
   1839d9570:	c7 86 a4 00 00 00 01 	mov    DWORD PTR [rsi+0xa4],0x1
   1839d9577:	00 00 00 
   1839d957a:	0f 11 86 b8 00 00 00 	movups XMMWORD PTR [rsi+0xb8],xmm0
   1839d9581:	0f 11 86 a8 00 00 00 	movups XMMWORD PTR [rsi+0xa8],xmm0
   1839d9588:	48 85 f6             	test   rsi,rsi
   1839d958b:	74 03                	je     0x1839d9590
   1839d958d:	f0 ff 03             	lock inc DWORD PTR [rbx]
   1839d9590:	4c 8b 75 10          	mov    r14,QWORD PTR [rbp+0x10]
   1839d9594:	49 89 46 28          	mov    QWORD PTR [r14+0x28],rax
   1839d9598:	49 8b 7e 30          	mov    rdi,QWORD PTR [r14+0x30]
   1839d959c:	49 89 76 30          	mov    QWORD PTR [r14+0x30],rsi
   1839d95a0:	48 85 ff             	test   rdi,rdi
   1839d95a3:	74 1d                	je     0x1839d95c2
   1839d95a5:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1839d95a9:	75 17                	jne    0x1839d95c2
   1839d95ab:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1839d95ae:	48 89 f9             	mov    rcx,rdi
   1839d95b1:	ff 10                	call   QWORD PTR [rax]
   1839d95b3:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1839d95b7:	75 09                	jne    0x1839d95c2
   1839d95b9:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1839d95bc:	48 89 f9             	mov    rcx,rdi
   1839d95bf:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1839d95c2:	48 85 f6             	test   rsi,rsi
   1839d95c5:	74 22                	je     0x1839d95e9
   1839d95c7:	f0 ff 0b             	lock dec DWORD PTR [rbx]
   1839d95ca:	75 1d                	jne    0x1839d95e9
   1839d95cc:	48 89 f7             	mov    rdi,rsi
   1839d95cf:	48 83 c7 0c          	add    rdi,0xc
   1839d95d3:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1839d95d6:	48 89 f1             	mov    rcx,rsi
   1839d95d9:	ff 10                	call   QWORD PTR [rax]
   1839d95db:	f0 ff 0f             	lock dec DWORD PTR [rdi]
   1839d95de:	75 09                	jne    0x1839d95e9
   1839d95e0:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1839d95e3:	48 89 f1             	mov    rcx,rsi
   1839d95e6:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1839d95e9:	48 8b 45 00          	mov    rax,QWORD PTR [rbp+0x0]
   1839d95ed:	48 8b 70 08          	mov    rsi,QWORD PTR [rax+0x8]
   1839d95f1:	48 85 f6             	test   rsi,rsi
   1839d95f4:	74 1d                	je     0x1839d9613
   1839d95f6:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1839d95fa:	75 17                	jne    0x1839d9613
   1839d95fc:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1839d95ff:	48 89 f1             	mov    rcx,rsi
   1839d9602:	ff 10                	call   QWORD PTR [rax]
   1839d9604:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1839d9608:	75 09                	jne    0x1839d9613
   1839d960a:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1839d960d:	48 89 f1             	mov    rcx,rsi
   1839d9610:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1839d9613:	4c 89 f0             	mov    rax,r14
   1839d9616:	0f 28 75 20          	movaps xmm6,XMMWORD PTR [rbp+0x20]
   1839d961a:	48 81 c4 b0 00 00 00 	add    rsp,0xb0
   1839d9621:	5b                   	pop    rbx
   1839d9622:	5f                   	pop    rdi
   1839d9623:	5e                   	pop    rsi
   1839d9624:	41 5e                	pop    r14
   1839d9626:	5d                   	pop    rbp
   1839d9627:	c3                   	ret
