
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001839de3e0 <.text+0x39dd3e0>:
   1839de3e0:	55                   	push   rbp
   1839de3e1:	56                   	push   rsi
   1839de3e2:	57                   	push   rdi
   1839de3e3:	53                   	push   rbx
   1839de3e4:	48 83 ec 78          	sub    rsp,0x78
   1839de3e8:	48 8d 6c 24 70       	lea    rbp,[rsp+0x70]
   1839de3ed:	48 c7 45 00 fe ff ff 	mov    QWORD PTR [rbp+0x0],0xfffffffffffffffe
   1839de3f4:	ff
   1839de3f5:	49 89 d1             	mov    r9,rdx
   1839de3f8:	48 89 ce             	mov    rsi,rcx
   1839de3fb:	0f 57 c0             	xorps  xmm0,xmm0
   1839de3fe:	0f 29 45 b0          	movaps XMMWORD PTR [rbp-0x50],xmm0
   1839de402:	48 8b 42 08          	mov    rax,QWORD PTR [rdx+0x8]
   1839de406:	48 85 c0             	test   rax,rax
   1839de409:	74 0a                	je     0x1839de415
   1839de40b:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1839de40f:	49 8b 41 08          	mov    rax,QWORD PTR [r9+0x8]
   1839de413:	eb 02                	jmp    0x1839de417
   1839de415:	31 c0                	xor    eax,eax
   1839de417:	49 8b 09             	mov    rcx,QWORD PTR [r9]
   1839de41a:	48 89 4d b0          	mov    QWORD PTR [rbp-0x50],rcx
   1839de41e:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
   1839de422:	48 8d 55 b0          	lea    rdx,[rbp-0x50]
   1839de426:	48 89 f1             	mov    rcx,rsi
   1839de429:	45 31 c0             	xor    r8d,r8d
   1839de42c:	4c 89 4d f8          	mov    QWORD PTR [rbp-0x8],r9
   1839de430:	e8 8b ae ff ff       	call   0x1839d92c0
   1839de435:	90                   	nop
   1839de436:	48 8d 05 fb 47 d1 05 	lea    rax,[rip+0x5d147fb]        # 0x1896f2c38
   1839de43d:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
   1839de441:	48 89 06             	mov    QWORD PTR [rsi],rax
   1839de444:	0f 28 05 65 87 53 05 	movaps xmm0,XMMWORD PTR [rip+0x5538765]        # 0x188f16bb0
   1839de44b:	0f 29 45 c0          	movaps XMMWORD PTR [rbp-0x40],xmm0
   1839de44f:	ba 18 01 00 00       	mov    edx,0x118
   1839de454:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
   1839de458:	48 03 10             	add    rdx,QWORD PTR [rax]
   1839de45b:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1839de45f:	e8 9c 97 0a fd       	call   0x180a87c00
   1839de464:	90                   	nop
   1839de465:	48 8b 75 c0          	mov    rsi,QWORD PTR [rbp-0x40]
   1839de469:	b9 f8 02 00 00       	mov    ecx,0x2f8
   1839de46e:	e8 69 d8 b6 03       	call   0x18754bcdc
   1839de473:	90                   	nop
   1839de474:	48 89 c7             	mov    rdi,rax
   1839de477:	48 bb 01 00 00 00 01 	movabs rbx,0x100000001
   1839de47e:	00 00 00
   1839de481:	48 89 58 08          	mov    QWORD PTR [rax+0x8],rbx
   1839de485:	48 8d 05 4c 2f 59 05 	lea    rax,[rip+0x5592f4c]        # 0x188f713d8
   1839de48c:	48 89 07             	mov    QWORD PTR [rdi],rax
   1839de48f:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
   1839de493:	48 83 c7 10          	add    rdi,0x10
   1839de497:	48 89 f9             	mov    rcx,rdi
   1839de49a:	48 89 f2             	mov    rdx,rsi
   1839de49d:	e8 8e d3 7e fc       	call   0x1801cb830
   1839de4a2:	90                   	nop
   1839de4a3:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
   1839de4a7:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
   1839de4ab:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
   1839de4af:	0f 57 c0             	xorps  xmm0,xmm0
   1839de4b2:	48 8b b0 a0 02 00 00 	mov    rsi,QWORD PTR [rax+0x2a0]
   1839de4b9:	0f 11 80 98 02 00 00 	movups XMMWORD PTR [rax+0x298],xmm0
   1839de4c0:	48 85 f6             	test   rsi,rsi
   1839de4c3:	74 1e                	je     0x1839de4e3
   1839de4c5:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1839de4c9:	75 18                	jne    0x1839de4e3
   1839de4cb:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1839de4ce:	48 89 f1             	mov    rcx,rsi
   1839de4d1:	ff 10                	call   QWORD PTR [rax]
   1839de4d3:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1839de4d7:	75 0a                	jne    0x1839de4e3
   1839de4d9:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1839de4dc:	48 89 f1             	mov    rcx,rsi
   1839de4df:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1839de4e2:	90                   	nop
   1839de4e3:	b9 40 01 00 00       	mov    ecx,0x140
   1839de4e8:	e8 ef d7 b6 03       	call   0x18754bcdc
   1839de4ed:	90                   	nop
   1839de4ee:	48 89 c6             	mov    rsi,rax
   1839de4f1:	48 89 c7             	mov    rdi,rax
   1839de4f4:	48 89 5e 08          	mov    QWORD PTR [rsi+0x8],rbx
   1839de4f8:	48 8d 05 59 46 6c 05 	lea    rax,[rip+0x56c4659]        # 0x1890a2b58
   1839de4ff:	48 89 06             	mov    QWORD PTR [rsi],rax
   1839de502:	48 83 c6 10          	add    rsi,0x10
   1839de506:	41 b8 30 01 00 00    	mov    r8d,0x130
   1839de50c:	48 89 f1             	mov    rcx,rsi
   1839de50f:	31 d2                	xor    edx,edx
   1839de511:	e8 ca 6f d3 03       	call   0x1877154e0
   1839de516:	48 c7 47 28 0f 00 00 	mov    QWORD PTR [rdi+0x28],0xf
   1839de51d:	00
   1839de51e:	0f 57 c0             	xorps  xmm0,xmm0
   1839de521:	0f 11 47 30          	movups XMMWORD PTR [rdi+0x30],xmm0
   1839de525:	48 c7 47 40 00 00 00 	mov    QWORD PTR [rdi+0x40],0x0
   1839de52c:	00
   1839de52d:	48 c7 47 48 0f 00 00 	mov    QWORD PTR [rdi+0x48],0xf
   1839de534:	00
   1839de535:	0f 11 47 50          	movups XMMWORD PTR [rdi+0x50],xmm0
   1839de539:	48 c7 47 60 00 00 00 	mov    QWORD PTR [rdi+0x60],0x0
   1839de540:	00
   1839de541:	48 c7 47 68 0f 00 00 	mov    QWORD PTR [rdi+0x68],0xf
   1839de548:	00
   1839de549:	0f 11 87 f8 00 00 00 	movups XMMWORD PTR [rdi+0xf8],xmm0
   1839de550:	48 c7 87 08 01 00 00 	mov    QWORD PTR [rdi+0x108],0x0
   1839de557:	00 00 00 00
   1839de55b:	0f 11 47 70          	movups XMMWORD PTR [rdi+0x70],xmm0
   1839de55f:	0f 11 87 80 00 00 00 	movups XMMWORD PTR [rdi+0x80],xmm0
   1839de566:	0f 11 87 90 00 00 00 	movups XMMWORD PTR [rdi+0x90],xmm0
   1839de56d:	0f 11 87 a0 00 00 00 	movups XMMWORD PTR [rdi+0xa0],xmm0
   1839de574:	0f 11 87 b0 00 00 00 	movups XMMWORD PTR [rdi+0xb0],xmm0
   1839de57b:	0f 11 87 c0 00 00 00 	movups XMMWORD PTR [rdi+0xc0],xmm0
   1839de582:	0f 11 87 d0 00 00 00 	movups XMMWORD PTR [rdi+0xd0],xmm0
   1839de589:	0f 11 87 dc 00 00 00 	movups XMMWORD PTR [rdi+0xdc],xmm0
   1839de590:	48 c7 87 10 01 00 00 	mov    QWORD PTR [rdi+0x110],0xf
   1839de597:	0f 00 00 00
   1839de59b:	0f 11 87 28 01 00 00 	movups XMMWORD PTR [rdi+0x128],xmm0
   1839de5a2:	0f 11 87 18 01 00 00 	movups XMMWORD PTR [rdi+0x118],xmm0
   1839de5a9:	c6 87 38 01 00 00 00 	mov    BYTE PTR [rdi+0x138],0x0
   1839de5b0:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
   1839de5b4:	48 89 b0 98 02 00 00 	mov    QWORD PTR [rax+0x298],rsi
   1839de5bb:	48 8b b0 a0 02 00 00 	mov    rsi,QWORD PTR [rax+0x2a0]
   1839de5c2:	48 89 b8 a0 02 00 00 	mov    QWORD PTR [rax+0x2a0],rdi
   1839de5c9:	48 85 f6             	test   rsi,rsi
   1839de5cc:	74 1d                	je     0x1839de5eb
   1839de5ce:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1839de5d2:	75 17                	jne    0x1839de5eb
   1839de5d4:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1839de5d7:	48 89 f1             	mov    rcx,rsi
   1839de5da:	ff 10                	call   QWORD PTR [rax]
   1839de5dc:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1839de5e0:	75 09                	jne    0x1839de5eb
   1839de5e2:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1839de5e5:	48 89 f1             	mov    rcx,rsi
   1839de5e8:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1839de5eb:	48 8b 75 e8          	mov    rsi,QWORD PTR [rbp-0x18]
   1839de5ef:	48 89 f1             	mov    rcx,rsi
   1839de5f2:	b2 01                	mov    dl,0x1
   1839de5f4:	e8 77 10 0a fd       	call   0x180a7f670
   1839de5f9:	90                   	nop
   1839de5fa:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
   1839de5fe:	48 85 c0             	test   rax,rax
   1839de601:	74 0e                	je     0x1839de611
   1839de603:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1839de607:	48 8b 75 e8          	mov    rsi,QWORD PTR [rbp-0x18]
   1839de60b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
   1839de60f:	eb 02                	jmp    0x1839de613
   1839de611:	31 c0                	xor    eax,eax
   1839de613:	48 8b 7d e0          	mov    rdi,QWORD PTR [rbp-0x20]
   1839de617:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
   1839de61b:	48 89 77 18          	mov    QWORD PTR [rdi+0x18],rsi
   1839de61f:	48 8b 77 20          	mov    rsi,QWORD PTR [rdi+0x20]
   1839de623:	48 89 47 20          	mov    QWORD PTR [rdi+0x20],rax
   1839de627:	48 85 f6             	test   rsi,rsi
   1839de62a:	74 1d                	je     0x1839de649
   1839de62c:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1839de630:	75 17                	jne    0x1839de649
   1839de632:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1839de635:	48 89 f1             	mov    rcx,rsi
   1839de638:	ff 10                	call   QWORD PTR [rax]
   1839de63a:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1839de63e:	75 09                	jne    0x1839de649
   1839de640:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1839de643:	48 89 f1             	mov    rcx,rsi
   1839de646:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1839de649:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10]
   1839de64d:	48 85 f6             	test   rsi,rsi
   1839de650:	74 1d                	je     0x1839de66f
   1839de652:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1839de656:	75 17                	jne    0x1839de66f
   1839de658:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1839de65b:	48 89 f1             	mov    rcx,rsi
   1839de65e:	ff 10                	call   QWORD PTR [rax]
   1839de660:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1839de664:	75 09                	jne    0x1839de66f
   1839de666:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1839de669:	48 89 f1             	mov    rcx,rsi
   1839de66c:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1839de66f:	48 8b 75 c8          	mov    rsi,QWORD PTR [rbp-0x38]
   1839de673:	48 85 f6             	test   rsi,rsi
   1839de676:	74 1d                	je     0x1839de695
   1839de678:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1839de67c:	75 17                	jne    0x1839de695
   1839de67e:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1839de681:	48 89 f1             	mov    rcx,rsi
   1839de684:	ff 10                	call   QWORD PTR [rax]
   1839de686:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1839de68a:	75 09                	jne    0x1839de695
   1839de68c:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1839de68f:	48 89 f1             	mov    rcx,rsi
   1839de692:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1839de695:	48 8b 73 08          	mov    rsi,QWORD PTR [rbx+0x8]
   1839de699:	48 85 f6             	test   rsi,rsi
   1839de69c:	74 1d                	je     0x1839de6bb
   1839de69e:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1839de6a2:	75 17                	jne    0x1839de6bb
   1839de6a4:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1839de6a7:	48 89 f1             	mov    rcx,rsi
   1839de6aa:	ff 10                	call   QWORD PTR [rax]
   1839de6ac:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1839de6b0:	75 09                	jne    0x1839de6bb
   1839de6b2:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1839de6b5:	48 89 f1             	mov    rcx,rsi
   1839de6b8:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1839de6bb:	48 89 f8             	mov    rax,rdi
   1839de6be:	48 83 c4 78          	add    rsp,0x78
   1839de6c2:	5b                   	pop    rbx
   1839de6c3:	5f                   	pop    rdi
   1839de6c4:	5e                   	pop    rsi
   1839de6c5:	5d                   	pop    rbp
   1839de6c6:	c3                   	ret
