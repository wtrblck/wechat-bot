
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

0000000181808560 <.text+0x1807560>:
   181808560:	55                   	push   rbp
   181808561:	41 57                	push   r15
   181808563:	41 56                	push   r14
   181808565:	56                   	push   rsi
   181808566:	57                   	push   rdi
   181808567:	53                   	push   rbx
   181808568:	48 81 ec 68 03 00 00 	sub    rsp,0x368
   18180856f:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   181808576:	00
   181808577:	0f 29 b5 d0 02 00 00 	movaps XMMWORD PTR [rbp+0x2d0],xmm6
   18180857e:	48 c7 85 c8 02 00 00 	mov    QWORD PTR [rbp+0x2c8],0xfffffffffffffffe
   181808585:	fe ff ff ff
   181808589:	4c 89 85 c0 02 00 00 	mov    QWORD PTR [rbp+0x2c0],r8
   181808590:	48 89 d6             	mov    rsi,rdx
   181808593:	48 89 cf             	mov    rdi,rcx
   181808596:	0f 28 35 13 e6 70 07 	movaps xmm6,XMMWORD PTR [rip+0x770e613]        # 0x188f16bb0
   18180859d:	0f 29 b5 b0 00 00 00 	movaps XMMWORD PTR [rbp+0xb0],xmm6
   1818085a4:	48 8d 15 6d 68 ab 07 	lea    rdx,[rip+0x7ab686d]        # 0x1892bee18
   1818085ab:	4c 8d 05 ce b5 aa 07 	lea    r8,[rip+0x7aab5ce]        # 0x1892b3b80
   1818085b2:	48 8d 8d 30 01 00 00 	lea    rcx,[rbp+0x130]
   1818085b9:	41 b9 69 10 00 00    	mov    r9d,0x1069
   1818085bf:	e8 2c 96 99 fe       	call   0x1801a1bf0
   1818085c4:	90                   	nop
   1818085c5:	c7 85 b0 00 00 00 02 	mov    DWORD PTR [rbp+0xb0],0x2
   1818085cc:	00 00 00
   1818085cf:	48 c7 85 c0 00 00 00 	mov    QWORD PTR [rbp+0xc0],0x0
   1818085d6:	00 00 00 00
   1818085da:	0f 28 85 30 01 00 00 	movaps xmm0,XMMWORD PTR [rbp+0x130]
   1818085e1:	0f 11 85 c8 00 00 00 	movups XMMWORD PTR [rbp+0xc8],xmm0
   1818085e8:	0f 57 c0             	xorps  xmm0,xmm0
   1818085eb:	0f 11 85 d8 00 00 00 	movups XMMWORD PTR [rbp+0xd8],xmm0
   1818085f2:	48 c7 85 e8 00 00 00 	mov    QWORD PTR [rbp+0xe8],0x0
   1818085f9:	00 00 00 00
   1818085fd:	48 c7 85 f0 00 00 00 	mov    QWORD PTR [rbp+0xf0],0xf
   181808604:	0f 00 00 00
   181808608:	e8 e3 17 1d ff       	call   0x1809d9df0
   18180860d:	90                   	nop
   18180860e:	48 89 85 b8 00 00 00 	mov    QWORD PTR [rbp+0xb8],rax
   181808615:	48 83 bd f0 00 00 00 	cmp    QWORD PTR [rbp+0xf0],0x1f
   18180861c:	1f
   18180861d:	73 1b                	jae    0x18180863a
   18180861f:	4c 8d 0d ba 4b aa 07 	lea    r9,[rip+0x7aa4bba]        # 0x1892ad1e0 ; Begin StartSendMessageSyncStage
   181808626:	ba 1f 00 00 00       	mov    edx,0x1f
   18180862b:	48 8d 8d d8 00 00 00 	lea    rcx,[rbp+0xd8]
   181808632:	e8 19 5b 83 fe       	call   0x18003e150
   181808637:	90                   	nop
   181808638:	eb 2b                	jmp    0x181808665
   18180863a:	48 8b 85 d8 00 00 00 	mov    rax,QWORD PTR [rbp+0xd8]
   181808641:	48 c7 85 e8 00 00 00 	mov    QWORD PTR [rbp+0xe8],0x1f
   181808648:	1f 00 00 00
   18180864c:	0f 10 05 9c 4b aa 07 	movups xmm0,XMMWORD PTR [rip+0x7aa4b9c]        # 0x1892ad1ef ; MessageSyncStage
   181808653:	0f 11 40 0f          	movups XMMWORD PTR [rax+0xf],xmm0
   181808657:	0f 10 05 82 4b aa 07 	movups xmm0,XMMWORD PTR [rip+0x7aa4b82]        # 0x1892ad1e0 ; Begin StartSendMessageSyncStage
   18180865e:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   181808661:	c6 40 1f 00          	mov    BYTE PTR [rax+0x1f],0x0
   181808665:	48 8b 9d c0 02 00 00 	mov    rbx,QWORD PTR [rbp+0x2c0]
   18180866c:	48 8b 0b             	mov    rcx,QWORD PTR [rbx]
   18180866f:	ba 01 00 00 00       	mov    edx,0x1
   181808674:	e8 47 5d 1d 02       	call   0x1839de3c0
   181808679:	90                   	nop
   18180867a:	48 b8 aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaaa
   181808681:	aa aa aa
   181808684:	48 89 85 b0 02 00 00 	mov    QWORD PTR [rbp+0x2b0],rax
   18180868b:	0f 29 b5 a0 02 00 00 	movaps XMMWORD PTR [rbp+0x2a0],xmm6
   181808692:	0f 29 b5 90 02 00 00 	movaps XMMWORD PTR [rbp+0x290],xmm6
   181808699:	0f 29 b5 80 02 00 00 	movaps XMMWORD PTR [rbp+0x280],xmm6
   1818086a0:	0f 57 c0             	xorps  xmm0,xmm0
   1818086a3:	0f 29 85 00 01 00 00 	movaps XMMWORD PTR [rbp+0x100],xmm0
   1818086aa:	48 8b 43 08          	mov    rax,QWORD PTR [rbx+0x8]
   1818086ae:	48 85 c0             	test   rax,rax
   1818086b1:	74 0a                	je     0x1818086bd
   1818086b3:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1818086b7:	48 8b 43 08          	mov    rax,QWORD PTR [rbx+0x8]
   1818086bb:	eb 02                	jmp    0x1818086bf
   1818086bd:	31 c0                	xor    eax,eax
   1818086bf:	48 8b 0b             	mov    rcx,QWORD PTR [rbx]
   1818086c2:	48 89 8d 00 01 00 00 	mov    QWORD PTR [rbp+0x100],rcx
   1818086c9:	48 89 85 08 01 00 00 	mov    QWORD PTR [rbp+0x108],rax
   1818086d0:	48 8d 95 30 01 00 00 	lea    rdx,[rbp+0x130]
   1818086d7:	4c 8d 85 00 01 00 00 	lea    r8,[rbp+0x100]
   1818086de:	48 89 f9             	mov    rcx,rdi
   1818086e1:	e8 4a 15 00 00       	call   0x181809c30
   1818086e6:	90                   	nop
   1818086e7:	48 8d 9d 00 02 00 00 	lea    rbx,[rbp+0x200]
   1818086ee:	48 8d 95 80 02 00 00 	lea    rdx,[rbp+0x280]
   1818086f5:	4c 8d 85 30 01 00 00 	lea    r8,[rbp+0x130]
   1818086fc:	48 89 d9             	mov    rcx,rbx
   1818086ff:	e8 ac 8f fa ff       	call   0x1817b16b0
   181808704:	90                   	nop
   181808705:	4c 8b b5 38 01 00 00 	mov    r14,QWORD PTR [rbp+0x138]
   18180870c:	4d 85 f6             	test   r14,r14
   18180870f:	74 1f                	je     0x181808730
   181808711:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   181808716:	75 18                	jne    0x181808730
   181808718:	49 8b 06             	mov    rax,QWORD PTR [r14]
   18180871b:	4c 89 f1             	mov    rcx,r14
   18180871e:	ff 10                	call   QWORD PTR [rax]
   181808720:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   181808725:	75 09                	jne    0x181808730
   181808727:	49 8b 06             	mov    rax,QWORD PTR [r14]
   18180872a:	4c 89 f1             	mov    rcx,r14
   18180872d:	ff 50 08             	call   QWORD PTR [rax+0x8]
   181808730:	48 8b 8d a8 02 00 00 	mov    rcx,QWORD PTR [rbp+0x2a8]
   181808737:	48 8b 85 c0 02 00 00 	mov    rax,QWORD PTR [rbp+0x2c0]
   18180873e:	48 8b 00             	mov    rax,QWORD PTR [rax]
   181808741:	48 8b 50 20          	mov    rdx,QWORD PTR [rax+0x20]
   181808745:	48 85 d2             	test   rdx,rdx
   181808748:	74 0a                	je     0x181808754
   18180874a:	f0 ff 42 08          	lock inc DWORD PTR [rdx+0x8]
   18180874e:	48 8b 50 20          	mov    rdx,QWORD PTR [rax+0x20]
   181808752:	eb 02                	jmp    0x181808756
   181808754:	31 d2                	xor    edx,edx
   181808756:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
   18180875a:	48 89 45 50          	mov    QWORD PTR [rbp+0x50],rax
   18180875e:	48 89 55 58          	mov    QWORD PTR [rbp+0x58],rdx
   181808762:	48 8d 55 50          	lea    rdx,[rbp+0x50]
   181808766:	e8 55 3d 00 00       	call   0x18180c4c0
   18180876b:	90                   	nop
   18180876c:	48 8b 85 c0 02 00 00 	mov    rax,QWORD PTR [rbp+0x2c0]
   181808773:	48 8b 08             	mov    rcx,QWORD PTR [rax]
   181808776:	48 83 c1 78          	add    rcx,0x78
   18180877a:	48 8d 95 80 02 00 00 	lea    rdx,[rbp+0x280]
   181808781:	e8 fa 3e 00 00       	call   0x18180c680
   181808786:	90                   	nop
   181808787:	48 8b 85 c0 02 00 00 	mov    rax,QWORD PTR [rbp+0x2c0]
   18180878e:	48 8b 08             	mov    rcx,QWORD PTR [rax]
   181808791:	4c 8d b5 30 01 00 00 	lea    r14,[rbp+0x130]
   181808798:	4c 89 f2             	mov    rdx,r14
   18180879b:	e8 c0 47 1d 02       	call   0x1839dcf60
   1818087a0:	90                   	nop
   1818087a1:	48 c7 85 08 02 00 00 	mov    QWORD PTR [rbp+0x208],0x0
   1818087a8:	00 00 00 00
   1818087ac:	b9 20 00 00 00       	mov    ecx,0x20
   1818087b1:	e8 26 35 d4 05       	call   0x18754bcdc
   1818087b6:	90                   	nop
   1818087b7:	48 89 85 00 02 00 00 	mov    QWORD PTR [rbp+0x200],rax
   1818087be:	48 c7 85 10 02 00 00 	mov    QWORD PTR [rbp+0x210],0x15
   1818087c5:	15 00 00 00
   1818087c9:	48 c7 85 18 02 00 00 	mov    QWORD PTR [rbp+0x218],0x1f
   1818087d0:	1f 00 00 00
   1818087d4:	0f 10 05 25 4a aa 07 	movups xmm0,XMMWORD PTR [rip+0x7aa4a25]        # 0x1892ad200 ; GetAddSendMessageToDb
   1818087db:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   1818087de:	48 b9 73 61 67 65 54 	movabs rcx,0x62446f5465676173
   1818087e5:	6f 44 62
   1818087e8:	48 89 48 0d          	mov    QWORD PTR [rax+0xd],rcx
   1818087ec:	c6 40 15 00          	mov    BYTE PTR [rax+0x15],0x0
   1818087f0:	4c 8b bd 40 01 00 00 	mov    r15,QWORD PTR [rbp+0x140]
   1818087f7:	48 83 bd 48 01 00 00 	cmp    QWORD PTR [rbp+0x148],0x10
   1818087fe:	10
   1818087ff:	72 07                	jb     0x181808808
   181808801:	4c 8b b5 30 01 00 00 	mov    r14,QWORD PTR [rbp+0x130]
   181808808:	49 83 ff 0a          	cmp    r15,0xa
   18180880c:	76 1d                	jbe    0x18180882b
   18180880e:	4c 89 7c 24 20       	mov    QWORD PTR [rsp+0x20],r15
   181808813:	48 8d 8d 00 02 00 00 	lea    rcx,[rbp+0x200]
   18180881a:	4c 89 fa             	mov    rdx,r15
   18180881d:	4d 89 f1             	mov    r9,r14
   181808820:	e8 9b 0b 80 fe       	call   0x1800093c0
   181808825:	90                   	nop
   181808826:	48 89 c3             	mov    rbx,rax
   181808829:	eb 26                	jmp    0x181808851
   18180882b:	48 89 c1             	mov    rcx,rax
   18180882e:	48 83 c1 15          	add    rcx,0x15
   181808832:	49 8d 57 15          	lea    rdx,[r15+0x15]
   181808836:	48 89 95 10 02 00 00 	mov    QWORD PTR [rbp+0x210],rdx
   18180883d:	4c 89 f2             	mov    rdx,r14
   181808840:	4d 89 f8             	mov    r8,r15
   181808843:	49 89 c6             	mov    r14,rax
   181808846:	e8 f5 c5 f0 05       	call   0x187714e40
   18180884b:	43 c6 44 3e 15 00    	mov    BYTE PTR [r14+r15*1+0x15],0x0
   181808851:	0f 10 03             	movups xmm0,XMMWORD PTR [rbx]
   181808854:	0f 10 4b 10          	movups xmm1,XMMWORD PTR [rbx+0x10]
   181808858:	0f 29 4d d0          	movaps XMMWORD PTR [rbp-0x30],xmm1
   18180885c:	0f 29 45 c0          	movaps XMMWORD PTR [rbp-0x40],xmm0
   181808860:	48 c7 43 10 00 00 00 	mov    QWORD PTR [rbx+0x10],0x0
   181808867:	00
   181808868:	48 c7 43 18 0f 00 00 	mov    QWORD PTR [rbx+0x18],0xf
   18180886f:	00
   181808870:	c6 03 00             	mov    BYTE PTR [rbx],0x0
   181808873:	48 8d 8d b0 00 00 00 	lea    rcx,[rbp+0xb0]
   18180887a:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   18180887e:	41 b8 32 00 00 00    	mov    r8d,0x32
   181808884:	e8 47 ff 7d ff       	call   0x180fe87d0
   181808889:	90                   	nop
   18180888a:	48 8b 85 18 02 00 00 	mov    rax,QWORD PTR [rbp+0x218]
   181808891:	48 83 f8 10          	cmp    rax,0x10
   181808895:	48 8b 9d c0 02 00 00 	mov    rbx,QWORD PTR [rbp+0x2c0]
   18180889c:	72 38                	jb     0x1818088d6
   18180889e:	48 8b 8d 00 02 00 00 	mov    rcx,QWORD PTR [rbp+0x200]
   1818088a5:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1818088a9:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1818088b0:	72 1f                	jb     0x1818088d1
   1818088b2:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1818088b6:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1818088ba:	4c 29 c1             	sub    rcx,r8
   1818088bd:	48 83 f9 20          	cmp    rcx,0x20
   1818088c1:	0f 83 c4 0d 00 00    	jae    0x18180968b
   1818088c7:	48 83 c0 28          	add    rax,0x28
   1818088cb:	48 89 c2             	mov    rdx,rax
   1818088ce:	4c 89 c1             	mov    rcx,r8
   1818088d1:	e8 4a 34 d4 05       	call   0x18754bd20
   1818088d6:	48 8b 85 48 01 00 00 	mov    rax,QWORD PTR [rbp+0x148]
   1818088dd:	48 83 f8 10          	cmp    rax,0x10
   1818088e1:	72 38                	jb     0x18180891b
   1818088e3:	48 8b 8d 30 01 00 00 	mov    rcx,QWORD PTR [rbp+0x130]
   1818088ea:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1818088ee:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1818088f5:	72 1f                	jb     0x181808916
   1818088f7:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1818088fb:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1818088ff:	4c 29 c1             	sub    rcx,r8
   181808902:	48 83 f9 20          	cmp    rcx,0x20
   181808906:	0f 83 7f 0d 00 00    	jae    0x18180968b
   18180890c:	48 83 c0 28          	add    rax,0x28
   181808910:	48 89 c2             	mov    rdx,rax
   181808913:	4c 89 c1             	mov    rcx,r8
   181808916:	e8 05 34 d4 05       	call   0x18754bd20
   18180891b:	8b 85 84 02 00 00    	mov    eax,DWORD PTR [rbp+0x284]
   181808921:	0b 85 80 02 00 00    	or     eax,DWORD PTR [rbp+0x280]
   181808927:	0f 84 68 02 00 00    	je     0x181808b95
   18180892d:	b9 04 00 00 00       	mov    ecx,0x4
   181808932:	e8 a9 44 86 fe       	call   0x18006cde0
   181808937:	85 c0                	test   eax,eax
   181808939:	0f 84 27 02 00 00    	je     0x181808b66
   18180893f:	48 8d bd c0 01 00 00 	lea    rdi,[rbp+0x1c0]
   181808946:	48 89 f9             	mov    rcx,rdi
   181808949:	e8 c2 45 86 fe       	call   0x18006cf10
   18180894e:	90                   	nop
   18180894f:	48 83 bd d8 01 00 00 	cmp    QWORD PTR [rbp+0x1d8],0x10
   181808956:	10
   181808957:	72 07                	jb     0x181808960
   181808959:	48 8b bd c0 01 00 00 	mov    rdi,QWORD PTR [rbp+0x1c0]
   181808960:	48 8d 05 19 3e ab 07 	lea    rax,[rip+0x7ab3e19]        # 0x1892bc780
   181808967:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   18180896c:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   181808973:	00 00
   181808975:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   18180897a:	c7 44 24 28 72 10 00 	mov    DWORD PTR [rsp+0x28],0x1072
   181808981:	00
   181808982:	4c 8d 0d f7 b1 aa 07 	lea    r9,[rip+0x7aab1f7]        # 0x1892b3b80
   181808989:	48 8d 8d 30 01 00 00 	lea    rcx,[rbp+0x130]
   181808990:	ba 04 00 00 00       	mov    edx,0x4
   181808995:	49 89 f8             	mov    r8,rdi
   181808998:	e8 d3 48 86 fe       	call   0x18006d270
   18180899d:	90                   	nop
   18180899e:	48 8b 85 c0 02 00 00 	mov    rax,QWORD PTR [rbp+0x2c0]
   1818089a5:	48 8b 08             	mov    rcx,QWORD PTR [rax]
   1818089a8:	e8 b3 c4 73 ff       	call   0x180f44e60
   1818089ad:	90                   	nop
   1818089ae:	48 c7 45 60 00 00 00 	mov    QWORD PTR [rbp+0x60],0x0
   1818089b5:	00
   1818089b6:	b9 07 00 00 00       	mov    ecx,0x7
   1818089bb:	48 8d 55 67          	lea    rdx,[rbp+0x67]
   1818089bf:	41 b8 cd cc cc cc    	mov    r8d,0xcccccccd
   1818089c5:	4c 8d 0d a4 e8 70 07 	lea    r9,[rip+0x770e8a4]        # 0x188f17270 ; ZYXWVUTSRQPONMLKJIHGFEDCBA9876543210123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ
   1818089cc:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
   1818089d0:	41 89 c2             	mov    r10d,eax
   1818089d3:	4d 0f af d0          	imul   r10,r8
   1818089d7:	49 c1 ea 23          	shr    r10,0x23
   1818089db:	47 8d 1c 12          	lea    r11d,[r10+r10*1]
   1818089df:	47 8d 1c 9b          	lea    r11d,[r11+r11*4]
   1818089e3:	41 f7 db             	neg    r11d
   1818089e6:	41 01 c3             	add    r11d,eax
   1818089e9:	41 83 c3 23          	add    r11d,0x23
   1818089ed:	47 0f b6 1c 0b       	movzx  r11d,BYTE PTR [r11+r9*1]
   1818089f2:	44 88 5a 01          	mov    BYTE PTR [rdx+0x1],r11b
   1818089f6:	48 ff c2             	inc    rdx
   1818089f9:	48 ff c1             	inc    rcx
   1818089fc:	83 f8 09             	cmp    eax,0x9
   1818089ff:	44                   	rex.R
