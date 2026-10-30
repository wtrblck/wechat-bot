
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001855e52d0 <.text+0x55e42d0>:
   1855e52d0:	55                   	push   rbp
   1855e52d1:	41 56                	push   r14
   1855e52d3:	56                   	push   rsi
   1855e52d4:	57                   	push   rdi
   1855e52d5:	53                   	push   rbx
   1855e52d6:	48 81 ec c0 02 00 00 	sub    rsp,0x2c0
   1855e52dd:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   1855e52e4:	00
   1855e52e5:	0f 29 b5 30 02 00 00 	movaps XMMWORD PTR [rbp+0x230],xmm6
   1855e52ec:	48 c7 85 28 02 00 00 	mov    QWORD PTR [rbp+0x228],0xfffffffffffffffe
   1855e52f3:	fe ff ff ff
   1855e52f7:	48 89 ce             	mov    rsi,rcx
   1855e52fa:	48 b8 aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaaa
   1855e5301:	aa aa aa
   1855e5304:	48 89 85 80 01 00 00 	mov    QWORD PTR [rbp+0x180],rax
   1855e530b:	0f 28 35 9e 18 93 03 	movaps xmm6,XMMWORD PTR [rip+0x393189e]        # 0x188f16bb0
   1855e5312:	0f 29 b5 70 01 00 00 	movaps XMMWORD PTR [rbp+0x170],xmm6
   1855e5319:	0f 29 b5 60 01 00 00 	movaps XMMWORD PTR [rbp+0x160],xmm6
   1855e5320:	0f 29 b5 50 01 00 00 	movaps XMMWORD PTR [rbp+0x150],xmm6
   1855e5327:	48 8d 7d 60          	lea    rdi,[rbp+0x60]
   1855e532b:	48 89 f9             	mov    rcx,rdi
   1855e532e:	e8 ed 1e a6 fa       	call   0x180047220
   1855e5333:	48 8b 4d 60          	mov    rcx,QWORD PTR [rbp+0x60]
   1855e5337:	48 8d 95 d0 00 00 00 	lea    rdx,[rbp+0xd0]
   1855e533e:	e8 8d d0 d9 fa       	call   0x1803823d0
   1855e5343:	90                   	nop
   1855e5344:	48 8b 8d d0 00 00 00 	mov    rcx,QWORD PTR [rbp+0xd0]
   1855e534b:	48 8d 95 90 01 00 00 	lea    rdx,[rbp+0x190]
   1855e5352:	e8 a9 1d 8d fb       	call   0x180eb7100
   1855e5357:	90                   	nop
   1855e5358:	48 8b 8d 90 01 00 00 	mov    rcx,QWORD PTR [rbp+0x190]
   1855e535f:	48 8d 5e 58          	lea    rbx,[rsi+0x58]
   1855e5363:	4c 8d 46 38          	lea    r8,[rsi+0x38]
   1855e5367:	48 8d 95 50 01 00 00 	lea    rdx,[rbp+0x150]
   1855e536e:	49 89 d9             	mov    r9,rbx
   1855e5371:	e8 ca 2c 63 fd       	call   0x182c18040
   1855e5376:	90                   	nop
   1855e5377:	4c 8b b5 98 01 00 00 	mov    r14,QWORD PTR [rbp+0x198]
   1855e537e:	4d 85 f6             	test   r14,r14
   1855e5381:	74 1f                	je     0x1855e53a2
   1855e5383:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1855e5388:	75 18                	jne    0x1855e53a2
   1855e538a:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855e538d:	4c 89 f1             	mov    rcx,r14
   1855e5390:	ff 10                	call   QWORD PTR [rax]
   1855e5392:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1855e5397:	75 09                	jne    0x1855e53a2
   1855e5399:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855e539c:	4c 89 f1             	mov    rcx,r14
   1855e539f:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855e53a2:	4c 8b b5 d8 00 00 00 	mov    r14,QWORD PTR [rbp+0xd8]
   1855e53a9:	4d 85 f6             	test   r14,r14
   1855e53ac:	74 1f                	je     0x1855e53cd
   1855e53ae:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1855e53b3:	75 18                	jne    0x1855e53cd
   1855e53b5:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855e53b8:	4c 89 f1             	mov    rcx,r14
   1855e53bb:	ff 10                	call   QWORD PTR [rax]
   1855e53bd:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1855e53c2:	75 09                	jne    0x1855e53cd
   1855e53c4:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855e53c7:	4c 89 f1             	mov    rcx,r14
   1855e53ca:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855e53cd:	4c 8b 75 68          	mov    r14,QWORD PTR [rbp+0x68]
   1855e53d1:	4d 85 f6             	test   r14,r14
   1855e53d4:	74 1f                	je     0x1855e53f5
   1855e53d6:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1855e53db:	75 18                	jne    0x1855e53f5
   1855e53dd:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855e53e0:	4c 89 f1             	mov    rcx,r14
   1855e53e3:	ff 10                	call   QWORD PTR [rax]
   1855e53e5:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1855e53ea:	75 09                	jne    0x1855e53f5
   1855e53ec:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855e53ef:	4c 89 f1             	mov    rcx,r14
   1855e53f2:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855e53f5:	f6 85 50 01 00 00 01 	test   BYTE PTR [rbp+0x150],0x1
   1855e53fc:	0f 84 e4 00 00 00    	je     0x1855e54e6
   1855e5402:	0f 29 b5 d0 01 00 00 	movaps XMMWORD PTR [rbp+0x1d0],xmm6
   1855e5409:	0f 29 b5 90 01 00 00 	movaps XMMWORD PTR [rbp+0x190],xmm6
   1855e5410:	0f 29 b5 a0 01 00 00 	movaps XMMWORD PTR [rbp+0x1a0],xmm6
   1855e5417:	0f 29 b5 b0 01 00 00 	movaps XMMWORD PTR [rbp+0x1b0],xmm6
   1855e541e:	0f 29 b5 c0 01 00 00 	movaps XMMWORD PTR [rbp+0x1c0],xmm6
   1855e5425:	c6 85 d8 01 00 00 00 	mov    BYTE PTR [rbp+0x1d8],0x0
   1855e542c:	c6 85 90 01 00 00 01 	mov    BYTE PTR [rbp+0x190],0x1
   1855e5433:	48 8b 85 58 01 00 00 	mov    rax,QWORD PTR [rbp+0x158]
   1855e543a:	48 8b 8d 60 01 00 00 	mov    rcx,QWORD PTR [rbp+0x160]
   1855e5441:	48 89 85 98 01 00 00 	mov    QWORD PTR [rbp+0x198],rax
   1855e5448:	c6 85 a0 01 00 00 01 	mov    BYTE PTR [rbp+0x1a0],0x1
   1855e544f:	48 89 8d a8 01 00 00 	mov    QWORD PTR [rbp+0x1a8],rcx
   1855e5456:	c6 85 b0 01 00 00 01 	mov    BYTE PTR [rbp+0x1b0],0x1
   1855e545d:	48 8b 4e 08          	mov    rcx,QWORD PTR [rsi+0x8]
   1855e5461:	0f b6 85 a0 01 00 00 	movzx  eax,BYTE PTR [rbp+0x1a0]
   1855e5468:	88 85 e0 00 00 00    	mov    BYTE PTR [rbp+0xe0],al
   1855e546e:	8b 85 a1 01 00 00    	mov    eax,DWORD PTR [rbp+0x1a1]
   1855e5474:	89 85 e1 00 00 00    	mov    DWORD PTR [rbp+0xe1],eax
   1855e547a:	0f b7 85 a5 01 00 00 	movzx  eax,WORD PTR [rbp+0x1a5]
   1855e5481:	66 89 85 e5 00 00 00 	mov    WORD PTR [rbp+0xe5],ax
   1855e5488:	0f b6 85 a7 01 00 00 	movzx  eax,BYTE PTR [rbp+0x1a7]
   1855e548f:	88 85 e7 00 00 00    	mov    BYTE PTR [rbp+0xe7],al
   1855e5495:	48 8b 85 a8 01 00 00 	mov    rax,QWORD PTR [rbp+0x1a8]
   1855e549c:	48 89 85 e8 00 00 00 	mov    QWORD PTR [rbp+0xe8],rax
   1855e54a3:	48 8b 85 b0 01 00 00 	mov    rax,QWORD PTR [rbp+0x1b0]
   1855e54aa:	48 89 85 f0 00 00 00 	mov    QWORD PTR [rbp+0xf0],rax
   1855e54b1:	48 8b 85 90 01 00 00 	mov    rax,QWORD PTR [rbp+0x190]
   1855e54b8:	48 89 85 d0 00 00 00 	mov    QWORD PTR [rbp+0xd0],rax
   1855e54bf:	48 8b 85 98 01 00 00 	mov    rax,QWORD PTR [rbp+0x198]
   1855e54c6:	48 89 85 d8 00 00 00 	mov    QWORD PTR [rbp+0xd8],rax
   1855e54cd:	c6 85 18 01 00 00 00 	mov    BYTE PTR [rbp+0x118],0x0
   1855e54d4:	48 8d 95 d0 00 00 00 	lea    rdx,[rbp+0xd0]
   1855e54db:	e8 50 d3 ff ff       	call   0x1855e2830
   1855e54e0:	90                   	nop
   1855e54e1:	e9 f6 01 00 00       	jmp    0x1855e56dc
   1855e54e6:	b9 04 00 00 00       	mov    ecx,0x4
   1855e54eb:	e8 f0 78 a8 fa       	call   0x18006cde0
   1855e54f0:	85 c0                	test   eax,eax
   1855e54f2:	0f 84 7d 01 00 00    	je     0x1855e5675
   1855e54f8:	4c 8d b5 b0 00 00 00 	lea    r14,[rbp+0xb0]
   1855e54ff:	4c 89 f1             	mov    rcx,r14
   1855e5502:	e8 09 7a a8 fa       	call   0x18006cf10
   1855e5507:	90                   	nop
   1855e5508:	48 83 bd c8 00 00 00 	cmp    QWORD PTR [rbp+0xc8],0x10
   1855e550f:	10
   1855e5510:	72 07                	jb     0x1855e5519
   1855e5512:	4c 8b b5 b0 00 00 00 	mov    r14,QWORD PTR [rbp+0xb0]
   1855e5519:	48 8d 05 10 08 42 04 	lea    rax,[rip+0x4420810]        # 0x189a05d30
   1855e5520:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855e5525:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855e552c:	00 00
   1855e552e:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855e5533:	c7 44 24 28 b8 01 00 	mov    DWORD PTR [rsp+0x28],0x1b8
   1855e553a:	00
   1855e553b:	4c 8d 0d 7e fd 41 04 	lea    r9,[rip+0x441fd7e]        # 0x189a052c0
   1855e5542:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855e5549:	ba 04 00 00 00       	mov    edx,0x4
   1855e554e:	4d 89 f0             	mov    r8,r14
   1855e5551:	e8 1a 7d a8 fa       	call   0x18006d270
   1855e5556:	90                   	nop
   1855e5557:	48 83 bd 80 01 00 00 	cmp    QWORD PTR [rbp+0x180],0x10
   1855e555e:	10
   1855e555f:	72 18                	jb     0x1855e5579
   1855e5561:	48 8b 85 68 01 00 00 	mov    rax,QWORD PTR [rbp+0x168]
   1855e5568:	48 89 45 60          	mov    QWORD PTR [rbp+0x60],rax
   1855e556c:	c6 45 68 00          	mov    BYTE PTR [rbp+0x68],0x0
   1855e5570:	48 83 7e 70 10       	cmp    QWORD PTR [rsi+0x70],0x10
   1855e5575:	73 18                	jae    0x1855e558f
   1855e5577:	eb 1a                	jmp    0x1855e5593
   1855e5579:	48 8d 85 68 01 00 00 	lea    rax,[rbp+0x168]
   1855e5580:	48 89 45 60          	mov    QWORD PTR [rbp+0x60],rax
   1855e5584:	c6 45 68 00          	mov    BYTE PTR [rbp+0x68],0x0
   1855e5588:	48 83 7e 70 10       	cmp    QWORD PTR [rsi+0x70],0x10
   1855e558d:	72 04                	jb     0x1855e5593
   1855e558f:	48 8b 5e 58          	mov    rbx,QWORD PTR [rsi+0x58]
   1855e5593:	48 89 5d c0          	mov    QWORD PTR [rbp-0x40],rbx
   1855e5597:	c6 45 c8 00          	mov    BYTE PTR [rbp-0x38],0x0
   1855e559b:	48 83 7e 30 10       	cmp    QWORD PTR [rsi+0x30],0x10
   1855e55a0:	72 06                	jb     0x1855e55a8
   1855e55a2:	48 8b 46 18          	mov    rax,QWORD PTR [rsi+0x18]
   1855e55a6:	eb 04                	jmp    0x1855e55ac
   1855e55a8:	48 8d 46 18          	lea    rax,[rsi+0x18]
   1855e55ac:	48 89 45 10          	mov    QWORD PTR [rbp+0x10],rax
   1855e55b0:	c6 45 18 00          	mov    BYTE PTR [rbp+0x18],0x0
   1855e55b4:	0f 57 c0             	xorps  xmm0,xmm0
   1855e55b7:	0f 11 85 38 01 00 00 	movups XMMWORD PTR [rbp+0x138],xmm0
   1855e55be:	0f 11 85 28 01 00 00 	movups XMMWORD PTR [rbp+0x128],xmm0
   1855e55c5:	0f 11 85 18 01 00 00 	movups XMMWORD PTR [rbp+0x118],xmm0
   1855e55cc:	0f 11 85 08 01 00 00 	movups XMMWORD PTR [rbp+0x108],xmm0
   1855e55d3:	0f 11 85 f8 00 00 00 	movups XMMWORD PTR [rbp+0xf8],xmm0
   1855e55da:	0f 11 85 e8 00 00 00 	movups XMMWORD PTR [rbp+0xe8],xmm0
   1855e55e1:	48 c7 85 48 01 00 00 	mov    QWORD PTR [rbp+0x148],0x0
   1855e55e8:	00 00 00 00
   1855e55ec:	48 8d 45 10          	lea    rax,[rbp+0x10]
   1855e55f0:	48 89 85 d0 00 00 00 	mov    QWORD PTR [rbp+0xd0],rax
   1855e55f7:	48 8d 45 c0          	lea    rax,[rbp-0x40]
   1855e55fb:	48 89 85 d8 00 00 00 	mov    QWORD PTR [rbp+0xd8],rax
   1855e5602:	48 89 bd e0 00 00 00 	mov    QWORD PTR [rbp+0xe0],rdi
   1855e5609:	48 8d 15 c8 13 42 04 	lea    rdx,[rip+0x44213c8]        # 0x189a069d8
   1855e5610:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855e5617:	4c 8d 85 d0 00 00 00 	lea    r8,[rbp+0xd0]
   1855e561e:	e8 ed 81 a8 fa       	call   0x18006d810
   1855e5623:	90                   	nop
   1855e5624:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855e562b:	e8 40 7d a8 fa       	call   0x18006d370
   1855e5630:	48 8b 85 c8 00 00 00 	mov    rax,QWORD PTR [rbp+0xc8]
   1855e5637:	48 83 f8 10          	cmp    rax,0x10
   1855e563b:	72 38                	jb     0x1855e5675
   1855e563d:	48 8b 8d b0 00 00 00 	mov    rcx,QWORD PTR [rbp+0xb0]
   1855e5644:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855e5648:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855e564f:	72 1f                	jb     0x1855e5670
   1855e5651:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855e5655:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855e5659:	4c 29 c1             	sub    rcx,r8
   1855e565c:	48 83 f9 20          	cmp    rcx,0x20
   1855e5660:	0f 83 cc 00 00 00    	jae    0x1855e5732
   1855e5666:	48 83 c0 28          	add    rax,0x28
   1855e566a:	48 89 c2             	mov    rdx,rax
   1855e566d:	4c 89 c1             	mov    rcx,r8
   1855e5670:	e8 ab 66 f6 01       	call   0x18754bd20
   1855e5675:	48 8b 76 08          	mov    rsi,QWORD PTR [rsi+0x8]
   1855e5679:	48 8d 95 68 01 00 00 	lea    rdx,[rbp+0x168]
   1855e5680:	0f 29 b5 a0 01 00 00 	movaps XMMWORD PTR [rbp+0x1a0],xmm6
   1855e5687:	0f 29 b5 b0 01 00 00 	movaps XMMWORD PTR [rbp+0x1b0],xmm6
   1855e568e:	0f 29 b5 d0 01 00 00 	movaps XMMWORD PTR [rbp+0x1d0],xmm6
   1855e5695:	0f 29 b5 90 01 00 00 	movaps XMMWORD PTR [rbp+0x190],xmm6
   1855e569c:	0f 29 b5 c0 01 00 00 	movaps XMMWORD PTR [rbp+0x1c0],xmm6
   1855e56a3:	c6 85 a0 01 00 00 00 	mov    BYTE PTR [rbp+0x1a0],0x0
   1855e56aa:	c6 85 b0 01 00 00 00 	mov    BYTE PTR [rbp+0x1b0],0x0
   1855e56b1:	c6 85 d8 01 00 00 00 	mov    BYTE PTR [rbp+0x1d8],0x0
   1855e56b8:	c6 85 90 01 00 00 00 	mov    BYTE PTR [rbp+0x190],0x0
   1855e56bf:	48 8d 8d b8 01 00 00 	lea    rcx,[rbp+0x1b8]
   1855e56c6:	e8 25 f9 3a fc       	call   0x181994ff0
   1855e56cb:	90                   	nop
   1855e56cc:	48 8d 95 90 01 00 00 	lea    rdx,[rbp+0x190]
   1855e56d3:	48 89 f1             	mov    rcx,rsi
   1855e56d6:	e8 55 d1 ff ff       	call   0x1855e2830
   1855e56db:	90                   	nop
   1855e56dc:	48 8b 85 80 01 00 00 	mov    rax,QWORD PTR [rbp+0x180]
   1855e56e3:	48 83 f8 10          	cmp    rax,0x10
   1855e56e7:	72 34                	jb     0x1855e571d
   1855e56e9:	48 8b 8d 68 01 00 00 	mov    rcx,QWORD PTR [rbp+0x168]
   1855e56f0:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855e56f4:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855e56fb:	72 1b                	jb     0x1855e5718
   1855e56fd:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855e5701:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855e5705:	4c 29 c1             	sub    rcx,r8
   1855e5708:	48 83 f9 20          	cmp    rcx,0x20
   1855e570c:	73 24                	jae    0x1855e5732
   1855e570e:	48 83 c0 28          	add    rax,0x28
   1855e5712:	48 89 c2             	mov    rdx,rax
   1855e5715:	4c 89 c1             	mov    rcx,r8
   1855e5718:	e8 03 66 f6 01       	call   0x18754bd20
   1855e571d:	0f 28 b5 30 02 00 00 	movaps xmm6,XMMWORD PTR [rbp+0x230]
   1855e5724:	48 81 c4 c0 02 00 00 	add    rsp,0x2c0
   1855e572b:	5b                   	pop    rbx
   1855e572c:	5f                   	pop    rdi
   1855e572d:	5e                   	pop    rsi
   1855e572e:	41 5e                	pop    r14
   1855e5730:	5d                   	pop    rbp
   1855e5731:	c3                   	ret
   1855e5732:	e8 55 8a 0f 02       	call   0x1876de18c
   1855e5737:	cc                   	int3
