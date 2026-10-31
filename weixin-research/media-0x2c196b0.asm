
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

0000000182c196b0 <.text+0x2c186b0>:
   182c196b0:	55                   	push   rbp
   182c196b1:	41 57                	push   r15
   182c196b3:	41 56                	push   r14
   182c196b5:	41 55                	push   r13
   182c196b7:	41 54                	push   r12
   182c196b9:	56                   	push   rsi
   182c196ba:	57                   	push   rdi
   182c196bb:	53                   	push   rbx
   182c196bc:	48 81 ec e8 05 00 00 	sub    rsp,0x5e8
   182c196c3:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   182c196ca:	00 
   182c196cb:	0f 29 b5 50 05 00 00 	movaps XMMWORD PTR [rbp+0x550],xmm6
   182c196d2:	48 c7 85 48 05 00 00 	mov    QWORD PTR [rbp+0x548],0xfffffffffffffffe
   182c196d9:	fe ff ff ff 
   182c196dd:	4c 89 cf             	mov    rdi,r9
   182c196e0:	4c 89 c6             	mov    rsi,r8
   182c196e3:	48 8b 9d d8 05 00 00 	mov    rbx,QWORD PTR [rbp+0x5d8]
   182c196ea:	49 bd aa aa aa aa aa 	movabs r13,0xaaaaaaaaaaaaaaaa
   182c196f1:	aa aa aa 
   182c196f4:	4c 89 2a             	mov    QWORD PTR [rdx],r13
   182c196f7:	c6 02 00             	mov    BYTE PTR [rdx],0x0
   182c196fa:	0f 57 c0             	xorps  xmm0,xmm0
   182c196fd:	0f 11 42 08          	movups XMMWORD PTR [rdx+0x8],xmm0
   182c19701:	0f 11 42 18          	movups XMMWORD PTR [rdx+0x18],xmm0
   182c19705:	48 c7 42 28 00 00 00 	mov    QWORD PTR [rdx+0x28],0x0
   182c1970c:	00 
   182c1970d:	48 c7 42 30 0f 00 00 	mov    QWORD PTR [rdx+0x30],0xf
   182c19714:	00 
   182c19715:	0f 29 85 d0 04 00 00 	movaps XMMWORD PTR [rbp+0x4d0],xmm0
   182c1971c:	0f 29 85 c0 04 00 00 	movaps XMMWORD PTR [rbp+0x4c0],xmm0
   182c19723:	4c 8b 73 10          	mov    r14,QWORD PTR [rbx+0x10]
   182c19727:	48 83 7b 18 10       	cmp    QWORD PTR [rbx+0x18],0x10
   182c1972c:	72 03                	jb     0x182c19731
   182c1972e:	48 8b 1b             	mov    rbx,QWORD PTR [rbx]
   182c19731:	4d 85 f6             	test   r14,r14
   182c19734:	48 89 95 40 05 00 00 	mov    QWORD PTR [rbp+0x540],rdx
   182c1973b:	0f 88 62 17 00 00    	js     0x182c1aea3
   182c19741:	49 83 fe 0f          	cmp    r14,0xf
   182c19745:	77 1e                	ja     0x182c19765
   182c19747:	4c 89 b5 d0 04 00 00 	mov    QWORD PTR [rbp+0x4d0],r14
   182c1974e:	48 c7 85 d8 04 00 00 	mov    QWORD PTR [rbp+0x4d8],0xf
   182c19755:	0f 00 00 00 
   182c19759:	0f 10 03             	movups xmm0,XMMWORD PTR [rbx]
   182c1975c:	0f 29 85 c0 04 00 00 	movaps XMMWORD PTR [rbp+0x4c0],xmm0
   182c19763:	eb 71                	jmp    0x182c197d6
   182c19765:	4c 89 f0             	mov    rax,r14
   182c19768:	48 83 c8 0f          	or     rax,0xf
   182c1976c:	48 83 f8 17          	cmp    rax,0x17
   182c19770:	41 bf 16 00 00 00    	mov    r15d,0x16
   182c19776:	4c 0f 43 f8          	cmovae r15,rax
   182c1977a:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   182c19780:	72 24                	jb     0x182c197a6
   182c19782:	49 8d 4f 28          	lea    rcx,[r15+0x28]
   182c19786:	e8 51 25 93 04       	call   0x18754bcdc
   182c1978b:	90                   	nop
   182c1978c:	48 85 c0             	test   rax,rax
   182c1978f:	0f 84 08 17 00 00    	je     0x182c1ae9d
   182c19795:	48 89 c1             	mov    rcx,rax
   182c19798:	48 83 c0 27          	add    rax,0x27
   182c1979c:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
   182c197a0:	48 89 48 f8          	mov    QWORD PTR [rax-0x8],rcx
   182c197a4:	eb 0a                	jmp    0x182c197b0
   182c197a6:	49 8d 4f 01          	lea    rcx,[r15+0x1]
   182c197aa:	e8 2d 25 93 04       	call   0x18754bcdc
   182c197af:	90                   	nop
   182c197b0:	48 89 85 c0 04 00 00 	mov    QWORD PTR [rbp+0x4c0],rax
   182c197b7:	4c 89 b5 d0 04 00 00 	mov    QWORD PTR [rbp+0x4d0],r14
   182c197be:	4c 89 bd d8 04 00 00 	mov    QWORD PTR [rbp+0x4d8],r15
   182c197c5:	49 ff c6             	inc    r14
   182c197c8:	48 89 c1             	mov    rcx,rax
   182c197cb:	48 89 da             	mov    rdx,rbx
   182c197ce:	4d 89 f0             	mov    r8,r14
   182c197d1:	e8 6a b6 af 04       	call   0x187714e40
   182c197d6:	4c 8b 85 e0 05 00 00 	mov    r8,QWORD PTR [rbp+0x5e0]
   182c197dd:	0f 28 35 cc d3 2f 06 	movaps xmm6,XMMWORD PTR [rip+0x62fd3cc]        # 0x188f16bb0
   182c197e4:	0f 29 b5 20 03 00 00 	movaps XMMWORD PTR [rbp+0x320],xmm6
   182c197eb:	0f 29 b5 10 03 00 00 	movaps XMMWORD PTR [rbp+0x310],xmm6
   182c197f2:	0f 57 c0             	xorps  xmm0,xmm0
   182c197f5:	0f 29 45 c0          	movaps XMMWORD PTR [rbp-0x40],xmm0
   182c197f9:	48 c7 45 d0 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
   182c19800:	00 
   182c19801:	48 c7 45 d8 0f 00 00 	mov    QWORD PTR [rbp-0x28],0xf
   182c19808:	00 
   182c19809:	4c 8d 75 c0          	lea    r14,[rbp-0x40]
   182c1980d:	4c 89 74 24 20       	mov    QWORD PTR [rsp+0x20],r14
   182c19812:	48 8d 8d 10 03 00 00 	lea    rcx,[rbp+0x310]
   182c19819:	48 8d 9d c0 04 00 00 	lea    rbx,[rbp+0x4c0]
   182c19820:	ba 01 00 00 00       	mov    edx,0x1
   182c19825:	49 89 d9             	mov    r9,rbx
   182c19828:	e8 63 2c d7 01       	call   0x18498c490
   182c1982d:	90                   	nop
   182c1982e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
   182c19832:	48 83 f8 10          	cmp    rax,0x10
   182c19836:	72 36                	jb     0x182c1986e
   182c19838:	48 8b 4d c0          	mov    rcx,QWORD PTR [rbp-0x40]
   182c1983c:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c19840:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c19847:	72 1f                	jb     0x182c19868
   182c19849:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c1984d:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c19851:	4c 29 c1             	sub    rcx,r8
   182c19854:	48 83 f9 20          	cmp    rcx,0x20
   182c19858:	0f 83 3f 16 00 00    	jae    0x182c1ae9d
   182c1985e:	48 83 c0 28          	add    rax,0x28
   182c19862:	48 89 c2             	mov    rdx,rax
   182c19865:	4c 89 c1             	mov    rcx,r8
   182c19868:	e8 b3 24 93 04       	call   0x18754bd20
   182c1986d:	90                   	nop
   182c1986e:	48 8d 8d 10 03 00 00 	lea    rcx,[rbp+0x310]
   182c19875:	e8 46 ac 78 fd       	call   0x1803a44c0
   182c1987a:	90                   	nop
   182c1987b:	41 89 c7             	mov    r15d,eax
   182c1987e:	b9 02 00 00 00       	mov    ecx,0x2
   182c19883:	e8 58 35 45 fd       	call   0x18006cde0
   182c19888:	45 84 ff             	test   r15b,r15b
   182c1988b:	0f 84 3b 01 00 00    	je     0x182c199cc
   182c19891:	85 c0                	test   eax,eax
   182c19893:	0f 84 5e 08 00 00    	je     0x182c1a0f7
   182c19899:	48 8d bd e0 04 00 00 	lea    rdi,[rbp+0x4e0]
   182c198a0:	48 89 f9             	mov    rcx,rdi
   182c198a3:	e8 68 36 45 fd       	call   0x18006cf10
   182c198a8:	90                   	nop
   182c198a9:	48 83 bd f8 04 00 00 	cmp    QWORD PTR [rbp+0x4f8],0x10
   182c198b0:	10 
   182c198b1:	72 07                	jb     0x182c198ba
   182c198b3:	48 8b bd e0 04 00 00 	mov    rdi,QWORD PTR [rbp+0x4e0]
   182c198ba:	48 8d 05 2f 4c 95 06 	lea    rax,[rip+0x6954c2f]        # 0x18956e4f0
   182c198c1:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182c198c6:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182c198cd:	00 00 
   182c198cf:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182c198d4:	c7 44 24 28 c2 0a 00 	mov    DWORD PTR [rsp+0x28],0xac2
   182c198db:	00 
   182c198dc:	4c 8d 0d 85 fc 94 06 	lea    r9,[rip+0x694fc85]        # 0x189569568
   182c198e3:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c198e7:	ba 02 00 00 00       	mov    edx,0x2
   182c198ec:	49 89 f8             	mov    r8,rdi
   182c198ef:	e8 7c 39 45 fd       	call   0x18006d270
   182c198f4:	90                   	nop
   182c198f5:	48 83 7e 18 10       	cmp    QWORD PTR [rsi+0x18],0x10
   182c198fa:	48 89 f0             	mov    rax,rsi
   182c198fd:	72 03                	jb     0x182c19902
   182c198ff:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182c19902:	48 89 85 a0 03 00 00 	mov    QWORD PTR [rbp+0x3a0],rax
   182c19909:	c6 85 a8 03 00 00 00 	mov    BYTE PTR [rbp+0x3a8],0x0
   182c19910:	0f 57 c0             	xorps  xmm0,xmm0
   182c19913:	0f 11 85 98 04 00 00 	movups XMMWORD PTR [rbp+0x498],xmm0
   182c1991a:	0f 11 85 88 04 00 00 	movups XMMWORD PTR [rbp+0x488],xmm0
   182c19921:	0f 11 85 78 04 00 00 	movups XMMWORD PTR [rbp+0x478],xmm0
   182c19928:	0f 11 85 68 04 00 00 	movups XMMWORD PTR [rbp+0x468],xmm0
   182c1992f:	0f 11 85 58 04 00 00 	movups XMMWORD PTR [rbp+0x458],xmm0
   182c19936:	0f 11 85 48 04 00 00 	movups XMMWORD PTR [rbp+0x448],xmm0
   182c1993d:	0f 11 85 38 04 00 00 	movups XMMWORD PTR [rbp+0x438],xmm0
   182c19944:	48 c7 85 a8 04 00 00 	mov    QWORD PTR [rbp+0x4a8],0x0
   182c1994b:	00 00 00 00 
   182c1994f:	48 8d 85 a0 03 00 00 	lea    rax,[rbp+0x3a0]
   182c19956:	48 89 85 30 04 00 00 	mov    QWORD PTR [rbp+0x430],rax
   182c1995d:	48 8d 15 9c 4d 95 06 	lea    rdx,[rip+0x6954d9c]        # 0x18956e700
   182c19964:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c19968:	4c 8d 85 30 04 00 00 	lea    r8,[rbp+0x430]
   182c1996f:	e8 9c 3e 45 fd       	call   0x18006d810
   182c19974:	90                   	nop
   182c19975:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c19979:	e8 f2 39 45 fd       	call   0x18006d370
   182c1997e:	48 8b 85 f8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4f8]
   182c19985:	48 83 f8 10          	cmp    rax,0x10
   182c19989:	0f 82 68 07 00 00    	jb     0x182c1a0f7
   182c1998f:	48 8b 8d e0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4e0]
   182c19996:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c1999a:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c199a1:	72 1f                	jb     0x182c199c2
   182c199a3:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c199a7:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c199ab:	4c 29 c1             	sub    rcx,r8
   182c199ae:	48 83 f9 20          	cmp    rcx,0x20
   182c199b2:	0f 83 e5 14 00 00    	jae    0x182c1ae9d
   182c199b8:	48 83 c0 28          	add    rax,0x28
   182c199bc:	48 89 c2             	mov    rdx,rax
   182c199bf:	4c 89 c1             	mov    rcx,r8
   182c199c2:	e8 59 23 93 04       	call   0x18754bd20
   182c199c7:	e9 2b 07 00 00       	jmp    0x182c1a0f7
   182c199cc:	85 c0                	test   eax,eax
   182c199ce:	0f 84 2a 01 00 00    	je     0x182c19afe
   182c199d4:	4c 8d bd e0 04 00 00 	lea    r15,[rbp+0x4e0]
   182c199db:	4c 89 f9             	mov    rcx,r15
   182c199de:	e8 2d 35 45 fd       	call   0x18006cf10
   182c199e3:	90                   	nop
   182c199e4:	48 83 bd f8 04 00 00 	cmp    QWORD PTR [rbp+0x4f8],0x10
   182c199eb:	10 
   182c199ec:	72 07                	jb     0x182c199f5
   182c199ee:	4c 8b bd e0 04 00 00 	mov    r15,QWORD PTR [rbp+0x4e0]
   182c199f5:	48 8d 05 f4 4a 95 06 	lea    rax,[rip+0x6954af4]        # 0x18956e4f0
   182c199fc:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182c19a01:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182c19a08:	00 00 
   182c19a0a:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182c19a0f:	c7 44 24 28 ab 0a 00 	mov    DWORD PTR [rsp+0x28],0xaab
   182c19a16:	00 
   182c19a17:	4c 8d 0d 4a fb 94 06 	lea    r9,[rip+0x694fb4a]        # 0x189569568
   182c19a1e:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c19a22:	ba 02 00 00 00       	mov    edx,0x2
   182c19a27:	4d 89 f8             	mov    r8,r15
   182c19a2a:	e8 41 38 45 fd       	call   0x18006d270
   182c19a2f:	90                   	nop
   182c19a30:	48 83 7e 18 10       	cmp    QWORD PTR [rsi+0x18],0x10
   182c19a35:	48 89 f0             	mov    rax,rsi
   182c19a38:	72 03                	jb     0x182c19a3d
   182c19a3a:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182c19a3d:	48 89 85 a0 03 00 00 	mov    QWORD PTR [rbp+0x3a0],rax
   182c19a44:	c6 85 a8 03 00 00 00 	mov    BYTE PTR [rbp+0x3a8],0x0
   182c19a4b:	0f 57 c0             	xorps  xmm0,xmm0
   182c19a4e:	0f 11 85 98 04 00 00 	movups XMMWORD PTR [rbp+0x498],xmm0
   182c19a55:	0f 11 85 88 04 00 00 	movups XMMWORD PTR [rbp+0x488],xmm0
   182c19a5c:	0f 11 85 78 04 00 00 	movups XMMWORD PTR [rbp+0x478],xmm0
   182c19a63:	0f 11 85 68 04 00 00 	movups XMMWORD PTR [rbp+0x468],xmm0
   182c19a6a:	0f 11 85 58 04 00 00 	movups XMMWORD PTR [rbp+0x458],xmm0
   182c19a71:	0f 11 85 48 04 00 00 	movups XMMWORD PTR [rbp+0x448],xmm0
   182c19a78:	0f 11 85 38 04 00 00 	movups XMMWORD PTR [rbp+0x438],xmm0
   182c19a7f:	48 c7 85 a8 04 00 00 	mov    QWORD PTR [rbp+0x4a8],0x0
   182c19a86:	00 00 00 00 
   182c19a8a:	48 8d 85 a0 03 00 00 	lea    rax,[rbp+0x3a0]
   182c19a91:	48 89 85 30 04 00 00 	mov    QWORD PTR [rbp+0x430],rax
   182c19a98:	48 8d 15 d1 4a 95 06 	lea    rdx,[rip+0x6954ad1]        # 0x18956e570
   182c19a9f:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c19aa3:	4c 8d 85 30 04 00 00 	lea    r8,[rbp+0x430]
   182c19aaa:	e8 61 3d 45 fd       	call   0x18006d810
   182c19aaf:	90                   	nop
   182c19ab0:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c19ab4:	e8 b7 38 45 fd       	call   0x18006d370
   182c19ab9:	48 8b 85 f8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4f8]
   182c19ac0:	48 83 f8 10          	cmp    rax,0x10
   182c19ac4:	72 38                	jb     0x182c19afe
   182c19ac6:	48 8b 8d e0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4e0]
   182c19acd:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c19ad1:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c19ad8:	72 1f                	jb     0x182c19af9
   182c19ada:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c19ade:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c19ae2:	4c 29 c1             	sub    rcx,r8
   182c19ae5:	48 83 f9 20          	cmp    rcx,0x20
   182c19ae9:	0f 83 ae 13 00 00    	jae    0x182c1ae9d
   182c19aef:	48 83 c0 28          	add    rax,0x28
   182c19af3:	48 89 c2             	mov    rdx,rax
   182c19af6:	4c 89 c1             	mov    rcx,r8
   182c19af9:	e8 22 22 93 04       	call   0x18754bd20
   182c19afe:	4c 8d 7d 28          	lea    r15,[rbp+0x28]
   182c19b02:	0f 11 75 48          	movups XMMWORD PTR [rbp+0x48],xmm6
   182c19b06:	0f 11 75 38          	movups XMMWORD PTR [rbp+0x38],xmm6
   182c19b0a:	0f 11 75 28          	movups XMMWORD PTR [rbp+0x28],xmm6
   182c19b0e:	0f 57 c0             	xorps  xmm0,xmm0
   182c19b11:	0f 29 45 c0          	movaps XMMWORD PTR [rbp-0x40],xmm0
   182c19b15:	48 c7 45 d0 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
   182c19b1c:	00 
   182c19b1d:	48 c7 45 d8 0f 00 00 	mov    QWORD PTR [rbp-0x28],0xf
   182c19b24:	00 
   182c19b25:	48 8d 45 e0          	lea    rax,[rbp-0x20]
   182c19b29:	48 89 85 58 03 00 00 	mov    QWORD PTR [rbp+0x358],rax
   182c19b30:	0f 29 45 e0          	movaps XMMWORD PTR [rbp-0x20],xmm0
   182c19b34:	48 c7 45 f0 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
   182c19b3b:	00 
   182c19b3c:	48 c7 45 f8 0f 00 00 	mov    QWORD PTR [rbp-0x8],0xf
   182c19b43:	00 
   182c19b44:	0f 29 45 00          	movaps XMMWORD PTR [rbp+0x0],xmm0
   182c19b48:	48 c7 45 10 00 00 00 	mov    QWORD PTR [rbp+0x10],0x0
   182c19b4f:	00 
   182c19b50:	48 c7 45 18 0f 00 00 	mov    QWORD PTR [rbp+0x18],0xf
   182c19b57:	00 
   182c19b58:	48 c7 45 20 00 00 00 	mov    QWORD PTR [rbp+0x20],0x0
   182c19b5f:	00 
   182c19b60:	4c 89 f9             	mov    rcx,r15
   182c19b63:	e8 f8 18 48 fd       	call   0x18009b460
   182c19b68:	90                   	nop
   182c19b69:	48 c7 45 48 00 00 00 	mov    QWORD PTR [rbp+0x48],0x0
   182c19b70:	00 
   182c19b71:	66 c7 45 50 00 00    	mov    WORD PTR [rbp+0x50],0x0
   182c19b77:	4c 8b a5 d0 04 00 00 	mov    r12,QWORD PTR [rbp+0x4d0]
   182c19b7e:	48 83 bd d8 04 00 00 	cmp    QWORD PTR [rbp+0x4d8],0x10
   182c19b85:	10 
   182c19b86:	72 07                	jb     0x182c19b8f
   182c19b88:	48 8b 9d c0 04 00 00 	mov    rbx,QWORD PTR [rbp+0x4c0]
   182c19b8f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
   182c19b93:	49 39 c4             	cmp    r12,rax
   182c19b96:	76 6e                	jbe    0x182c19c06
   182c19b98:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c19b9c:	4c 89 e2             	mov    rdx,r12
   182c19b9f:	49 89 d9             	mov    r9,rbx
   182c19ba2:	e8 a9 45 42 fd       	call   0x18003e150
   182c19ba7:	90                   	nop
   182c19ba8:	4c 8d 75 00          	lea    r14,[rbp+0x0]
   182c19bac:	48 8b 5f 10          	mov    rbx,QWORD PTR [rdi+0x10]
   182c19bb0:	48 83 7f 18 10       	cmp    QWORD PTR [rdi+0x18],0x10
   182c19bb5:	72 03                	jb     0x182c19bba
   182c19bb7:	48 8b 3f             	mov    rdi,QWORD PTR [rdi]
   182c19bba:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
   182c19bbe:	48 39 c3             	cmp    rbx,rax
   182c19bc1:	76 75                	jbe    0x182c19c38
   182c19bc3:	48 8d 4d e0          	lea    rcx,[rbp-0x20]
   182c19bc7:	48 89 da             	mov    rdx,rbx
   182c19bca:	49 89 f9             	mov    r9,rdi
   182c19bcd:	e8 7e 45 42 fd       	call   0x18003e150
   182c19bd2:	90                   	nop
   182c19bd3:	4c 8b 8d d0 05 00 00 	mov    r9,QWORD PTR [rbp+0x5d0]
   182c19bda:	49 8b 79 10          	mov    rdi,QWORD PTR [r9+0x10]
   182c19bde:	49 83 79 18 10       	cmp    QWORD PTR [r9+0x18],0x10
   182c19be3:	72 03                	jb     0x182c19be8
   182c19be5:	4d 8b 09             	mov    r9,QWORD PTR [r9]
   182c19be8:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
   182c19bec:	48 39 c7             	cmp    rdi,rax
   182c19bef:	0f 86 8d 00 00 00    	jbe    0x182c19c82
   182c19bf5:	4c 89 f1             	mov    rcx,r14
   182c19bf8:	48 89 fa             	mov    rdx,rdi
   182c19bfb:	e8 50 45 42 fd       	call   0x18003e150
   182c19c00:	90                   	nop
   182c19c01:	e9 9d 00 00 00       	jmp    0x182c19ca3
   182c19c06:	48 83 f8 10          	cmp    rax,0x10
   182c19c0a:	72 04                	jb     0x182c19c10
   182c19c0c:	4c 8b 75 c0          	mov    r14,QWORD PTR [rbp-0x40]
   182c19c10:	4c 89 65 d0          	mov    QWORD PTR [rbp-0x30],r12
   182c19c14:	4c 89 f1             	mov    rcx,r14
   182c19c17:	48 89 da             	mov    rdx,rbx
   182c19c1a:	4d 89 e0             	mov    r8,r12
   182c19c1d:	e8 1e b2 af 04       	call   0x187714e40
   182c19c22:	43 c6 04 26 00       	mov    BYTE PTR [r14+r12*1],0x0
   182c19c27:	4c 8d 75 00          	lea    r14,[rbp+0x0]
   182c19c2b:	48 8b 5f 10          	mov    rbx,QWORD PTR [rdi+0x10]
   182c19c2f:	48 83 7f 18 10       	cmp    QWORD PTR [rdi+0x18],0x10
   182c19c34:	73 81                	jae    0x182c19bb7
   182c19c36:	eb 82                	jmp    0x182c19bba
   182c19c38:	48 83 f8 10          	cmp    rax,0x10
   182c19c3c:	72 0b                	jb     0x182c19c49
   182c19c3e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
   182c19c42:	48 89 85 58 03 00 00 	mov    QWORD PTR [rbp+0x358],rax
   182c19c49:	48 89 5d f0          	mov    QWORD PTR [rbp-0x10],rbx
   182c19c4d:	4c 8b a5 58 03 00 00 	mov    r12,QWORD PTR [rbp+0x358]
   182c19c54:	4c 89 e1             	mov    rcx,r12
   182c19c57:	48 89 fa             	mov    rdx,rdi
   182c19c5a:	49 89 d8             	mov    r8,rbx
   182c19c5d:	e8 de b1 af 04       	call   0x187714e40
   182c19c62:	41 c6 04 1c 00       	mov    BYTE PTR [r12+rbx*1],0x0
   182c19c67:	4c 8b 8d d0 05 00 00 	mov    r9,QWORD PTR [rbp+0x5d0]
   182c19c6e:	49 8b 79 10          	mov    rdi,QWORD PTR [r9+0x10]
   182c19c72:	49 83 79 18 10       	cmp    QWORD PTR [r9+0x18],0x10
   182c19c77:	0f 83 68 ff ff ff    	jae    0x182c19be5
   182c19c7d:	e9 66 ff ff ff       	jmp    0x182c19be8
   182c19c82:	48 83 f8 10          	cmp    rax,0x10
   182c19c86:	72 04                	jb     0x182c19c8c
   182c19c88:	4c 8b 75 00          	mov    r14,QWORD PTR [rbp+0x0]
   182c19c8c:	48 89 7d 10          	mov    QWORD PTR [rbp+0x10],rdi
   182c19c90:	4c 89 f1             	mov    rcx,r14
   182c19c93:	4c 89 ca             	mov    rdx,r9
   182c19c96:	49 89 f8             	mov    r8,rdi
   182c19c99:	e8 a2 b1 af 04       	call   0x187714e40
   182c19c9e:	41 c6 04 3e 00       	mov    BYTE PTR [r14+rdi*1],0x0
   182c19ca3:	c7 45 20 05 00 00 00 	mov    DWORD PTR [rbp+0x20],0x5
   182c19caa:	48 8d 95 10 03 00 00 	lea    rdx,[rbp+0x310]
   182c19cb1:	4c 89 f9             	mov    rcx,r15
   182c19cb4:	e8 27 19 48 fd       	call   0x18009b5e0
   182c19cb9:	90                   	nop
   182c19cba:	0f 29 b5 d0 02 00 00 	movaps XMMWORD PTR [rbp+0x2d0],xmm6
   182c19cc1:	0f 29 b5 c0 02 00 00 	movaps XMMWORD PTR [rbp+0x2c0],xmm6
   182c19cc8:	48 8d bd e0 04 00 00 	lea    rdi,[rbp+0x4e0]
   182c19ccf:	48 89 f9             	mov    rcx,rdi
   182c19cd2:	e8 49 d5 42 fd       	call   0x180047220
   182c19cd7:	90                   	nop
   182c19cd8:	48 8b 8d e0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4e0]
   182c19cdf:	48 8d 95 a0 03 00 00 	lea    rdx,[rbp+0x3a0]
   182c19ce6:	e8 e5 86 76 fd       	call   0x1803823d0
   182c19ceb:	90                   	nop
   182c19cec:	48 8b 8d a0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3a0]
   182c19cf3:	48 8d 95 30 04 00 00 	lea    rdx,[rbp+0x430]
   182c19cfa:	e8 61 2d 75 fd       	call   0x18036ca60
   182c19cff:	90                   	nop
   182c19d00:	48 8b 8d 30 04 00 00 	mov    rcx,QWORD PTR [rbp+0x430]
   182c19d07:	e8 a4 a0 4f fd       	call   0x180113db0
   182c19d0c:	90                   	nop
   182c19d0d:	48 89 c3             	mov    rbx,rax
   182c19d10:	c7 85 30 05 00 00 00 	mov    DWORD PTR [rbp+0x530],0x0
   182c19d17:	00 00 00 
   182c19d1a:	48 8d 8d 30 03 00 00 	lea    rcx,[rbp+0x330]
   182c19d21:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   182c19d25:	4c 8d 85 30 05 00 00 	lea    r8,[rbp+0x530]
   182c19d2c:	e8 2f bc ff ff       	call   0x182c15960
   182c19d31:	90                   	nop
   182c19d32:	0f 28 85 30 03 00 00 	movaps xmm0,XMMWORD PTR [rbp+0x330]
   182c19d39:	0f 29 85 60 03 00 00 	movaps XMMWORD PTR [rbp+0x360],xmm0
   182c19d40:	0f 57 c0             	xorps  xmm0,xmm0
   182c19d43:	0f 29 85 30 03 00 00 	movaps XMMWORD PTR [rbp+0x330],xmm0
   182c19d4a:	c7 85 2c 04 00 00 0e 	mov    DWORD PTR [rbp+0x42c],0xe
   182c19d51:	00 00 00 
   182c19d54:	48 8d 95 c0 02 00 00 	lea    rdx,[rbp+0x2c0]
   182c19d5b:	4c 8d 85 2c 04 00 00 	lea    r8,[rbp+0x42c]
   182c19d62:	4c 8d 8d 60 03 00 00 	lea    r9,[rbp+0x360]
   182c19d69:	48 89 d9             	mov    rcx,rbx
   182c19d6c:	e8 af a0 26 fe       	call   0x180e83e20
   182c19d71:	90                   	nop
   182c19d72:	48 8b 9d 68 03 00 00 	mov    rbx,QWORD PTR [rbp+0x368]
   182c19d79:	48 85 db             	test   rbx,rbx
   182c19d7c:	74 1d                	je     0x182c19d9b
   182c19d7e:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   182c19d82:	75 17                	jne    0x182c19d9b
   182c19d84:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c19d87:	48 89 d9             	mov    rcx,rbx
   182c19d8a:	ff 10                	call   QWORD PTR [rax]
   182c19d8c:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   182c19d90:	75 09                	jne    0x182c19d9b
   182c19d92:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c19d95:	48 89 d9             	mov    rcx,rbx
   182c19d98:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c19d9b:	48 8b 9d 38 03 00 00 	mov    rbx,QWORD PTR [rbp+0x338]
   182c19da2:	48 85 db             	test   rbx,rbx
   182c19da5:	74 1d                	je     0x182c19dc4
   182c19da7:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   182c19dab:	75 17                	jne    0x182c19dc4
   182c19dad:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c19db0:	48 89 d9             	mov    rcx,rbx
   182c19db3:	ff 10                	call   QWORD PTR [rax]
   182c19db5:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   182c19db9:	75 09                	jne    0x182c19dc4
   182c19dbb:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c19dbe:	48 89 d9             	mov    rcx,rbx
   182c19dc1:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c19dc4:	48 8b 9d 38 04 00 00 	mov    rbx,QWORD PTR [rbp+0x438]
   182c19dcb:	48 85 db             	test   rbx,rbx
   182c19dce:	74 1d                	je     0x182c19ded
   182c19dd0:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   182c19dd4:	75 17                	jne    0x182c19ded
   182c19dd6:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c19dd9:	48 89 d9             	mov    rcx,rbx
   182c19ddc:	ff 10                	call   QWORD PTR [rax]
   182c19dde:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   182c19de2:	75 09                	jne    0x182c19ded
   182c19de4:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c19de7:	48 89 d9             	mov    rcx,rbx
   182c19dea:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c19ded:	48 8b 9d a8 03 00 00 	mov    rbx,QWORD PTR [rbp+0x3a8]
   182c19df4:	48 85 db             	test   rbx,rbx
   182c19df7:	74 1d                	je     0x182c19e16
   182c19df9:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   182c19dfd:	75 17                	jne    0x182c19e16
   182c19dff:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c19e02:	48 89 d9             	mov    rcx,rbx
   182c19e05:	ff 10                	call   QWORD PTR [rax]
   182c19e07:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   182c19e0b:	75 09                	jne    0x182c19e16
   182c19e0d:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c19e10:	48 89 d9             	mov    rcx,rbx
   182c19e13:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c19e16:	48 8b 9d e8 04 00 00 	mov    rbx,QWORD PTR [rbp+0x4e8]
   182c19e1d:	48 85 db             	test   rbx,rbx
   182c19e20:	74 1d                	je     0x182c19e3f
   182c19e22:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   182c19e26:	75 17                	jne    0x182c19e3f
   182c19e28:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c19e2b:	48 89 d9             	mov    rcx,rbx
   182c19e2e:	ff 10                	call   QWORD PTR [rax]
   182c19e30:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   182c19e34:	75 09                	jne    0x182c19e3f
   182c19e36:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c19e39:	48 89 d9             	mov    rcx,rbx
   182c19e3c:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c19e3f:	83 bd c8 02 00 00 00 	cmp    DWORD PTR [rbp+0x2c8],0x0
   182c19e46:	0f 84 56 02 00 00    	je     0x182c1a0a2
   182c19e4c:	b9 04 00 00 00       	mov    ecx,0x4
   182c19e51:	e8 8a 2f 45 fd       	call   0x18006cde0
   182c19e56:	85 c0                	test   eax,eax
   182c19e58:	0f 84 d7 01 00 00    	je     0x182c1a035
   182c19e5e:	48 8d b5 60 03 00 00 	lea    rsi,[rbp+0x360]
   182c19e65:	48 89 f1             	mov    rcx,rsi
   182c19e68:	e8 a3 30 45 fd       	call   0x18006cf10
   182c19e6d:	90                   	nop
   182c19e6e:	48 83 bd 78 03 00 00 	cmp    QWORD PTR [rbp+0x378],0x10
   182c19e75:	10 
   182c19e76:	72 07                	jb     0x182c19e7f
   182c19e78:	48 8b b5 60 03 00 00 	mov    rsi,QWORD PTR [rbp+0x360]
   182c19e7f:	48 8d 05 6a 46 95 06 	lea    rax,[rip+0x695466a]        # 0x18956e4f0
   182c19e86:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182c19e8b:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182c19e92:	00 00 
   182c19e94:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182c19e99:	c7 44 24 28 b8 0a 00 	mov    DWORD PTR [rsp+0x28],0xab8
   182c19ea0:	00 
   182c19ea1:	4c 8d 0d c0 f6 94 06 	lea    r9,[rip+0x694f6c0]        # 0x189569568
   182c19ea8:	48 8d 8d 30 04 00 00 	lea    rcx,[rbp+0x430]
   182c19eaf:	ba 04 00 00 00       	mov    edx,0x4
   182c19eb4:	49 89 f0             	mov    r8,rsi
   182c19eb7:	e8 b4 33 45 fd       	call   0x18006d270
   182c19ebc:	90                   	nop
   182c19ebd:	8b 8d c8 02 00 00    	mov    ecx,DWORD PTR [rbp+0x2c8]
   182c19ec3:	48 c7 85 e0 04 00 00 	mov    QWORD PTR [rbp+0x4e0],0x0
   182c19eca:	00 00 00 00 
   182c19ece:	b8 08 00 00 00       	mov    eax,0x8
   182c19ed3:	48 8d 15 96 d3 2f 06 	lea    rdx,[rip+0x62fd396]        # 0x188f17270
   182c19eda:	41 89 c8             	mov    r8d,ecx
   182c19edd:	0f 1f 00             	nop    DWORD PTR [rax]
   182c19ee0:	4d 63 c8             	movsxd r9,r8d
   182c19ee3:	4d 69 c1 67 66 66 66 	imul   r8,r9,0x66666667
   182c19eea:	4d 89 c2             	mov    r10,r8
   182c19eed:	49 c1 ea 3f          	shr    r10,0x3f
   182c19ef1:	49 c1 f8 22          	sar    r8,0x22
   182c19ef5:	45 01 d0             	add    r8d,r10d
   182c19ef8:	47 8d 14 00          	lea    r10d,[r8+r8*1]
   182c19efc:	47 8d 14 92          	lea    r10d,[r10+r10*4]
   182c19f00:	41 f7 da             	neg    r10d
   182c19f03:	45 01 ca             	add    r10d,r9d
   182c19f06:	41 83 c2 23          	add    r10d,0x23
   182c19f0a:	4d 63 d2             	movsxd r10,r10d
   182c19f0d:	45 0f b6 14 12       	movzx  r10d,BYTE PTR [r10+rdx*1]
   182c19f12:	44 88 94 05 e0 04 00 	mov    BYTE PTR [rbp+rax*1+0x4e0],r10b
   182c19f19:	00 
   182c19f1a:	48 ff c0             	inc    rax
   182c19f1d:	41 83 c1 09          	add    r9d,0x9
   182c19f21:	41 83 f9 12          	cmp    r9d,0x12
   182c19f25:	77 b9                	ja     0x182c19ee0
   182c19f27:	85 c9                	test   ecx,ecx
   182c19f29:	79 0b                	jns    0x182c19f36
   182c19f2b:	c6 84 05 e0 04 00 00 	mov    BYTE PTR [rbp+rax*1+0x4e0],0x2d
   182c19f32:	2d 
   182c19f33:	48 ff c0             	inc    rax
   182c19f36:	48 8d 8d e8 04 00 00 	lea    rcx,[rbp+0x4e8]
   182c19f3d:	c6 84 05 e0 04 00 00 	mov    BYTE PTR [rbp+rax*1+0x4e0],0x0
   182c19f44:	00 
   182c19f45:	48 83 f8 0a          	cmp    rax,0xa
   182c19f49:	7c 31                	jl     0x182c19f7c
   182c19f4b:	48 01 e8             	add    rax,rbp
   182c19f4e:	48 05 e0 04 00 00    	add    rax,0x4e0
   182c19f54:	48 ff c8             	dec    rax
   182c19f57:	48 8d 95 e9 04 00 00 	lea    rdx,[rbp+0x4e9]
   182c19f5e:	66 90                	xchg   ax,ax
   182c19f60:	44 0f b6 00          	movzx  r8d,BYTE PTR [rax]
   182c19f64:	44 0f b6 4a ff       	movzx  r9d,BYTE PTR [rdx-0x1]
   182c19f69:	44 88 08             	mov    BYTE PTR [rax],r9b
   182c19f6c:	44 88 42 ff          	mov    BYTE PTR [rdx-0x1],r8b
   182c19f70:	48 ff c8             	dec    rax
   182c19f73:	48 39 c2             	cmp    rdx,rax
   182c19f76:	48 8d 52 01          	lea    rdx,[rdx+0x1]
   182c19f7a:	72 e4                	jb     0x182c19f60
   182c19f7c:	48 89 8d e0 04 00 00 	mov    QWORD PTR [rbp+0x4e0],rcx
   182c19f83:	0f 57 c0             	xorps  xmm0,xmm0
   182c19f86:	0f 11 85 08 04 00 00 	movups XMMWORD PTR [rbp+0x408],xmm0
   182c19f8d:	0f 11 85 f8 03 00 00 	movups XMMWORD PTR [rbp+0x3f8],xmm0
   182c19f94:	0f 11 85 e8 03 00 00 	movups XMMWORD PTR [rbp+0x3e8],xmm0
   182c19f9b:	0f 11 85 d8 03 00 00 	movups XMMWORD PTR [rbp+0x3d8],xmm0
   182c19fa2:	0f 11 85 c8 03 00 00 	movups XMMWORD PTR [rbp+0x3c8],xmm0
   182c19fa9:	0f 11 85 b8 03 00 00 	movups XMMWORD PTR [rbp+0x3b8],xmm0
   182c19fb0:	0f 11 85 a8 03 00 00 	movups XMMWORD PTR [rbp+0x3a8],xmm0
   182c19fb7:	48 c7 85 18 04 00 00 	mov    QWORD PTR [rbp+0x418],0x0
   182c19fbe:	00 00 00 00 
   182c19fc2:	48 89 bd a0 03 00 00 	mov    QWORD PTR [rbp+0x3a0],rdi
   182c19fc9:	48 8d 15 70 22 95 06 	lea    rdx,[rip+0x6952270]        # 0x18956c240
   182c19fd0:	48 8d 8d 30 04 00 00 	lea    rcx,[rbp+0x430]
   182c19fd7:	4c 8d 85 a0 03 00 00 	lea    r8,[rbp+0x3a0]
   182c19fde:	e8 2d 38 45 fd       	call   0x18006d810
   182c19fe3:	90                   	nop
   182c19fe4:	48 8d 8d 30 04 00 00 	lea    rcx,[rbp+0x430]
   182c19feb:	e8 80 33 45 fd       	call   0x18006d370
   182c19ff0:	48 8b 85 78 03 00 00 	mov    rax,QWORD PTR [rbp+0x378]
   182c19ff7:	48 83 f8 10          	cmp    rax,0x10
   182c19ffb:	72 38                	jb     0x182c1a035
   182c19ffd:	48 8b 8d 60 03 00 00 	mov    rcx,QWORD PTR [rbp+0x360]
   182c1a004:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c1a008:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c1a00f:	72 1f                	jb     0x182c1a030
   182c1a011:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c1a015:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c1a019:	4c 29 c1             	sub    rcx,r8
   182c1a01c:	48 83 f9 20          	cmp    rcx,0x20
   182c1a020:	0f 83 77 0e 00 00    	jae    0x182c1ae9d
   182c1a026:	48 83 c0 28          	add    rax,0x28
   182c1a02a:	48 89 c2             	mov    rdx,rax
   182c1a02d:	4c 89 c1             	mov    rcx,r8
   182c1a030:	e8 eb 1c 93 04       	call   0x18754bd20
   182c1a035:	8b 95 c8 02 00 00    	mov    edx,DWORD PTR [rbp+0x2c8]
   182c1a03b:	48 8d b5 30 04 00 00 	lea    rsi,[rbp+0x430]
   182c1a042:	48 89 f1             	mov    rcx,rsi
   182c1a045:	e8 b6 0a 48 fd       	call   0x18009ab00
   182c1a04a:	90                   	nop
   182c1a04b:	4c 8b 85 40 04 00 00 	mov    r8,QWORD PTR [rbp+0x440]
   182c1a052:	48 8b 85 48 04 00 00 	mov    rax,QWORD PTR [rbp+0x448]
   182c1a059:	48 89 c1             	mov    rcx,rax
   182c1a05c:	4c 29 c1             	sub    rcx,r8
   182c1a05f:	48 83 f9 22          	cmp    rcx,0x22
   182c1a063:	0f 83 6f 08 00 00    	jae    0x182c1a8d8
   182c1a069:	48 8d 05 80 7b 94 06 	lea    rax,[rip+0x6947b80]        # 0x189561bf0
   182c1a070:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182c1a075:	48 c7 44 24 28 22 00 	mov    QWORD PTR [rsp+0x28],0x22
   182c1a07c:	00 00 
   182c1a07e:	48 8d 8d 30 04 00 00 	lea    rcx,[rbp+0x430]
   182c1a085:	ba 22 00 00 00       	mov    edx,0x22
   182c1a08a:	45 31 c9             	xor    r9d,r9d
   182c1a08d:	e8 be 1c 3f fd       	call   0x18000bd50
   182c1a092:	90                   	nop
   182c1a093:	48 89 c6             	mov    rsi,rax
   182c1a096:	4c 8b a5 40 05 00 00 	mov    r12,QWORD PTR [rbp+0x540]
   182c1a09d:	e9 d3 08 00 00       	jmp    0x182c1a975
   182c1a0a2:	48 8d 8d 10 03 00 00 	lea    rcx,[rbp+0x310]
   182c1a0a9:	e8 12 a4 78 fd       	call   0x1803a44c0
   182c1a0ae:	90                   	nop
   182c1a0af:	84 c0                	test   al,al
   182c1a0b1:	0f 84 c3 0b 00 00    	je     0x182c1ac7a
   182c1a0b7:	48 8d 05 5a 45 3b 06 	lea    rax,[rip+0x63b455a]        # 0x188fce618
   182c1a0be:	48 89 85 c0 02 00 00 	mov    QWORD PTR [rbp+0x2c0],rax
   182c1a0c5:	48 8b bd d8 02 00 00 	mov    rdi,QWORD PTR [rbp+0x2d8]
   182c1a0cc:	48 85 ff             	test   rdi,rdi
   182c1a0cf:	74 1d                	je     0x182c1a0ee
   182c1a0d1:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   182c1a0d5:	75 17                	jne    0x182c1a0ee
   182c1a0d7:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c1a0da:	48 89 f9             	mov    rcx,rdi
   182c1a0dd:	ff 10                	call   QWORD PTR [rax]
   182c1a0df:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   182c1a0e3:	75 09                	jne    0x182c1a0ee
   182c1a0e5:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c1a0e8:	48 89 f9             	mov    rcx,rdi
   182c1a0eb:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c1a0ee:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c1a0f2:	e8 69 de ff ff       	call   0x182c17f60
   182c1a0f7:	0f 29 b5 30 05 00 00 	movaps XMMWORD PTR [rbp+0x530],xmm6
   182c1a0fe:	48 8d 8d 30 05 00 00 	lea    rcx,[rbp+0x530]
   182c1a105:	e8 76 18 00 00       	call   0x182c1b980
   182c1a10a:	90                   	nop
   182c1a10b:	48 8b 85 30 05 00 00 	mov    rax,QWORD PTR [rbp+0x530]
   182c1a112:	48 b9 31 00 00 00 06 	movabs rcx,0x600000031
   182c1a119:	00 00 00 
   182c1a11c:	48 89 88 18 01 00 00 	mov    QWORD PTR [rax+0x118],rcx
   182c1a123:	48 8d b8 b0 00 00 00 	lea    rdi,[rax+0xb0]
   182c1a12a:	48 39 f7             	cmp    rdi,rsi
   182c1a12d:	74 4d                	je     0x182c1a17c
   182c1a12f:	48 8b 5e 10          	mov    rbx,QWORD PTR [rsi+0x10]
   182c1a133:	48 83 7e 18 10       	cmp    QWORD PTR [rsi+0x18],0x10
   182c1a138:	49 89 f1             	mov    r9,rsi
   182c1a13b:	72 03                	jb     0x182c1a140
   182c1a13d:	4c 8b 0e             	mov    r9,QWORD PTR [rsi]
   182c1a140:	48 8b 88 c8 00 00 00 	mov    rcx,QWORD PTR [rax+0xc8]
   182c1a147:	48 39 cb             	cmp    rbx,rcx
   182c1a14a:	76 0e                	jbe    0x182c1a15a
   182c1a14c:	48 89 f9             	mov    rcx,rdi
   182c1a14f:	48 89 da             	mov    rdx,rbx
   182c1a152:	e8 f9 3f 42 fd       	call   0x18003e150
   182c1a157:	90                   	nop
   182c1a158:	eb 22                	jmp    0x182c1a17c
   182c1a15a:	48 83 f9 10          	cmp    rcx,0x10
   182c1a15e:	72 03                	jb     0x182c1a163
   182c1a160:	48 8b 3f             	mov    rdi,QWORD PTR [rdi]
   182c1a163:	48 89 98 c0 00 00 00 	mov    QWORD PTR [rax+0xc0],rbx
   182c1a16a:	48 89 f9             	mov    rcx,rdi
   182c1a16d:	4c 89 ca             	mov    rdx,r9
   182c1a170:	49 89 d8             	mov    r8,rbx
   182c1a173:	e8 c8 ac af 04       	call   0x187714e40
   182c1a178:	c6 04 1f 00          	mov    BYTE PTR [rdi+rbx*1],0x0
   182c1a17c:	b9 20 01 00 00       	mov    ecx,0x120
   182c1a181:	48 03 8d 30 05 00 00 	add    rcx,QWORD PTR [rbp+0x530]
   182c1a188:	48 8d 95 10 03 00 00 	lea    rdx,[rbp+0x310]
   182c1a18f:	e8 4c 14 48 fd       	call   0x18009b5e0
   182c1a194:	90                   	nop
   182c1a195:	4c 89 ad 90 03 00 00 	mov    QWORD PTR [rbp+0x390],r13
   182c1a19c:	0f 29 b5 80 03 00 00 	movaps XMMWORD PTR [rbp+0x380],xmm6
   182c1a1a3:	0f 29 b5 70 03 00 00 	movaps XMMWORD PTR [rbp+0x370],xmm6
   182c1a1aa:	0f 29 b5 60 03 00 00 	movaps XMMWORD PTR [rbp+0x360],xmm6
   182c1a1b1:	48 8d bd a0 03 00 00 	lea    rdi,[rbp+0x3a0]
   182c1a1b8:	48 89 f9             	mov    rcx,rdi
   182c1a1bb:	e8 60 d0 42 fd       	call   0x180047220
   182c1a1c0:	90                   	nop
   182c1a1c1:	48 8b 8d a0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3a0]
   182c1a1c8:	48 8d 95 30 04 00 00 	lea    rdx,[rbp+0x430]
   182c1a1cf:	e8 fc 81 76 fd       	call   0x1803823d0
   182c1a1d4:	90                   	nop
   182c1a1d5:	48 8b 8d 30 04 00 00 	mov    rcx,QWORD PTR [rbp+0x430]
   182c1a1dc:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   182c1a1e0:	e8 9b f0 ae fd       	call   0x180709280
   182c1a1e5:	90                   	nop
   182c1a1e6:	48 8b 4d c0          	mov    rcx,QWORD PTR [rbp-0x40]
   182c1a1ea:	0f 57 c0             	xorps  xmm0,xmm0
   182c1a1ed:	0f 29 85 b0 02 00 00 	movaps XMMWORD PTR [rbp+0x2b0],xmm0
   182c1a1f4:	48 8b 85 38 05 00 00 	mov    rax,QWORD PTR [rbp+0x538]
   182c1a1fb:	48 85 c0             	test   rax,rax
   182c1a1fe:	74 0d                	je     0x182c1a20d
   182c1a200:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   182c1a204:	48 8b 85 38 05 00 00 	mov    rax,QWORD PTR [rbp+0x538]
   182c1a20b:	eb 02                	jmp    0x182c1a20f
   182c1a20d:	31 c0                	xor    eax,eax
   182c1a20f:	48 8b 95 30 05 00 00 	mov    rdx,QWORD PTR [rbp+0x530]
   182c1a216:	48 89 95 b0 02 00 00 	mov    QWORD PTR [rbp+0x2b0],rdx
   182c1a21d:	48 89 85 b8 02 00 00 	mov    QWORD PTR [rbp+0x2b8],rax
   182c1a224:	48 8d 95 60 03 00 00 	lea    rdx,[rbp+0x360]
   182c1a22b:	4c 8d 85 b0 02 00 00 	lea    r8,[rbp+0x2b0]
   182c1a232:	e8 29 99 b8 fe       	call   0x1817a3b60
   182c1a237:	90                   	nop
   182c1a238:	48 8b 5d c8          	mov    rbx,QWORD PTR [rbp-0x38]
   182c1a23c:	48 85 db             	test   rbx,rbx
   182c1a23f:	74 1d                	je     0x182c1a25e
   182c1a241:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   182c1a245:	75 17                	jne    0x182c1a25e
   182c1a247:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c1a24a:	48 89 d9             	mov    rcx,rbx
   182c1a24d:	ff 10                	call   QWORD PTR [rax]
   182c1a24f:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   182c1a253:	75 09                	jne    0x182c1a25e
   182c1a255:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c1a258:	48 89 d9             	mov    rcx,rbx
   182c1a25b:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c1a25e:	48 8b 9d 38 04 00 00 	mov    rbx,QWORD PTR [rbp+0x438]
   182c1a265:	48 85 db             	test   rbx,rbx
   182c1a268:	4c 8b a5 40 05 00 00 	mov    r12,QWORD PTR [rbp+0x540]
   182c1a26f:	74 1d                	je     0x182c1a28e
   182c1a271:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   182c1a275:	75 17                	jne    0x182c1a28e
   182c1a277:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c1a27a:	48 89 d9             	mov    rcx,rbx
   182c1a27d:	ff 10                	call   QWORD PTR [rax]
   182c1a27f:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   182c1a283:	75 09                	jne    0x182c1a28e
   182c1a285:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c1a288:	48 89 d9             	mov    rcx,rbx
   182c1a28b:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c1a28e:	48 8b 9d a8 03 00 00 	mov    rbx,QWORD PTR [rbp+0x3a8]
   182c1a295:	48 85 db             	test   rbx,rbx
   182c1a298:	74 1d                	je     0x182c1a2b7
   182c1a29a:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   182c1a29e:	75 17                	jne    0x182c1a2b7
   182c1a2a0:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c1a2a3:	48 89 d9             	mov    rcx,rbx
   182c1a2a6:	ff 10                	call   QWORD PTR [rax]
   182c1a2a8:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   182c1a2ac:	75 09                	jne    0x182c1a2b7
   182c1a2ae:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c1a2b1:	48 89 d9             	mov    rcx,rbx
   182c1a2b4:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c1a2b7:	8b 85 64 03 00 00    	mov    eax,DWORD PTR [rbp+0x364]
   182c1a2bd:	0b 85 60 03 00 00    	or     eax,DWORD PTR [rbp+0x360]
   182c1a2c3:	0f 84 f8 01 00 00    	je     0x182c1a4c1
   182c1a2c9:	b9 04 00 00 00       	mov    ecx,0x4
   182c1a2ce:	e8 0d 2b 45 fd       	call   0x18006cde0
   182c1a2d3:	85 c0                	test   eax,eax
   182c1a2d5:	0f 84 84 01 00 00    	je     0x182c1a45f
   182c1a2db:	48 8d b5 e0 04 00 00 	lea    rsi,[rbp+0x4e0]
   182c1a2e2:	48 89 f1             	mov    rcx,rsi
   182c1a2e5:	e8 26 2c 45 fd       	call   0x18006cf10
   182c1a2ea:	90                   	nop
   182c1a2eb:	48 83 bd f8 04 00 00 	cmp    QWORD PTR [rbp+0x4f8],0x10
   182c1a2f2:	10 
   182c1a2f3:	72 07                	jb     0x182c1a2fc
   182c1a2f5:	48 8b b5 e0 04 00 00 	mov    rsi,QWORD PTR [rbp+0x4e0]
   182c1a2fc:	48 8d 05 ed 41 95 06 	lea    rax,[rip+0x69541ed]        # 0x18956e4f0
   182c1a303:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182c1a308:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182c1a30f:	00 00 
   182c1a311:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182c1a316:	c7 44 24 28 cd 0a 00 	mov    DWORD PTR [rsp+0x28],0xacd
   182c1a31d:	00 
   182c1a31e:	4c 8d 0d 43 f2 94 06 	lea    r9,[rip+0x694f243]        # 0x189569568
   182c1a325:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c1a329:	ba 04 00 00 00       	mov    edx,0x4
   182c1a32e:	49 89 f0             	mov    r8,rsi
   182c1a331:	e8 3a 2f 45 fd       	call   0x18006d270
   182c1a336:	90                   	nop
   182c1a337:	48 8d 8d 60 03 00 00 	lea    rcx,[rbp+0x360]
   182c1a33e:	48 8d b5 c0 02 00 00 	lea    rsi,[rbp+0x2c0]
   182c1a345:	48 89 f2             	mov    rdx,rsi
   182c1a348:	e8 13 69 4f fd       	call   0x180110c60
   182c1a34d:	90                   	nop
   182c1a34e:	48 83 bd d8 02 00 00 	cmp    QWORD PTR [rbp+0x2d8],0x10
   182c1a355:	10 
   182c1a356:	72 07                	jb     0x182c1a35f
   182c1a358:	48 8b b5 c0 02 00 00 	mov    rsi,QWORD PTR [rbp+0x2c0]
   182c1a35f:	48 89 b5 a0 03 00 00 	mov    QWORD PTR [rbp+0x3a0],rsi
   182c1a366:	c6 85 a8 03 00 00 00 	mov    BYTE PTR [rbp+0x3a8],0x0
   182c1a36d:	0f 57 c0             	xorps  xmm0,xmm0
   182c1a370:	0f 11 85 98 04 00 00 	movups XMMWORD PTR [rbp+0x498],xmm0
   182c1a377:	0f 11 85 88 04 00 00 	movups XMMWORD PTR [rbp+0x488],xmm0
   182c1a37e:	0f 11 85 78 04 00 00 	movups XMMWORD PTR [rbp+0x478],xmm0
   182c1a385:	0f 11 85 68 04 00 00 	movups XMMWORD PTR [rbp+0x468],xmm0
   182c1a38c:	0f 11 85 58 04 00 00 	movups XMMWORD PTR [rbp+0x458],xmm0
   182c1a393:	0f 11 85 48 04 00 00 	movups XMMWORD PTR [rbp+0x448],xmm0
   182c1a39a:	0f 11 85 38 04 00 00 	movups XMMWORD PTR [rbp+0x438],xmm0
   182c1a3a1:	48 c7 85 a8 04 00 00 	mov    QWORD PTR [rbp+0x4a8],0x0
   182c1a3a8:	00 00 00 00 
   182c1a3ac:	48 89 bd 30 04 00 00 	mov    QWORD PTR [rbp+0x430],rdi
   182c1a3b3:	48 8d 15 fe 43 95 06 	lea    rdx,[rip+0x69543fe]        # 0x18956e7b8
   182c1a3ba:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c1a3be:	4c 8d 85 30 04 00 00 	lea    r8,[rbp+0x430]
   182c1a3c5:	e8 46 34 45 fd       	call   0x18006d810
   182c1a3ca:	90                   	nop
   182c1a3cb:	48 8b 85 d8 02 00 00 	mov    rax,QWORD PTR [rbp+0x2d8]
   182c1a3d2:	48 83 f8 10          	cmp    rax,0x10
   182c1a3d6:	72 38                	jb     0x182c1a410
   182c1a3d8:	48 8b 8d c0 02 00 00 	mov    rcx,QWORD PTR [rbp+0x2c0]
   182c1a3df:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c1a3e3:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c1a3ea:	72 1f                	jb     0x182c1a40b
   182c1a3ec:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c1a3f0:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c1a3f4:	4c 29 c1             	sub    rcx,r8
   182c1a3f7:	48 83 f9 20          	cmp    rcx,0x20
   182c1a3fb:	0f 83 9c 0a 00 00    	jae    0x182c1ae9d
   182c1a401:	48 83 c0 28          	add    rax,0x28
   182c1a405:	48 89 c2             	mov    rdx,rax
   182c1a408:	4c 89 c1             	mov    rcx,r8
   182c1a40b:	e8 10 19 93 04       	call   0x18754bd20
   182c1a410:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c1a414:	e8 57 2f 45 fd       	call   0x18006d370
   182c1a419:	48 8b 85 f8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4f8]
   182c1a420:	48 83 f8 10          	cmp    rax,0x10
   182c1a424:	72 39                	jb     0x182c1a45f
   182c1a426:	48 8b 8d e0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4e0]
   182c1a42d:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c1a431:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c1a438:	72 1f                	jb     0x182c1a459
   182c1a43a:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c1a43e:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c1a442:	4c 29 c1             	sub    rcx,r8
   182c1a445:	48 83 f9 20          	cmp    rcx,0x20
   182c1a449:	0f 83 4e 0a 00 00    	jae    0x182c1ae9d
   182c1a44f:	48 83 c0 28          	add    rax,0x28
   182c1a453:	48 89 c2             	mov    rdx,rax
   182c1a456:	4c 89 c1             	mov    rcx,r8
   182c1a459:	e8 c2 18 93 04       	call   0x18754bd20
   182c1a45e:	90                   	nop
   182c1a45f:	48 8d 8d 60 03 00 00 	lea    rcx,[rbp+0x360]
   182c1a466:	48 8d 75 c0          	lea    rsi,[rbp-0x40]
   182c1a46a:	48 89 f2             	mov    rdx,rsi
   182c1a46d:	e8 ee 67 4f fd       	call   0x180110c60
   182c1a472:	90                   	nop
   182c1a473:	4c 8b 45 d0          	mov    r8,QWORD PTR [rbp-0x30]
   182c1a477:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
   182c1a47b:	48 89 c1             	mov    rcx,rax
   182c1a47e:	4c 29 c1             	sub    rcx,r8
   182c1a481:	48 83 f9 1a          	cmp    rcx,0x1a
   182c1a485:	0f 83 cc 05 00 00    	jae    0x182c1aa57
   182c1a48b:	48 8d 05 ae 77 94 06 	lea    rax,[rip+0x69477ae]        # 0x189561c40
   182c1a492:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182c1a497:	48 c7 44 24 28 1a 00 	mov    QWORD PTR [rsp+0x28],0x1a
   182c1a49e:	00 00 
   182c1a4a0:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c1a4a4:	ba 1a 00 00 00       	mov    edx,0x1a
   182c1a4a9:	45 31 c9             	xor    r9d,r9d
   182c1a4ac:	e8 9f 18 3f fd       	call   0x18000bd50
   182c1a4b1:	90                   	nop
   182c1a4b2:	48 89 c6             	mov    rsi,rax
   182c1a4b5:	4c 8b a5 40 05 00 00 	mov    r12,QWORD PTR [rbp+0x540]
   182c1a4bc:	e9 2d 06 00 00       	jmp    0x182c1aaee
   182c1a4c1:	49 8d 5c 24 08       	lea    rbx,[r12+0x8]
   182c1a4c6:	41 c6 04 24 01       	mov    BYTE PTR [r12],0x1
   182c1a4cb:	4c 89 ad f0 03 00 00 	mov    QWORD PTR [rbp+0x3f0],r13
   182c1a4d2:	0f 29 b5 e0 03 00 00 	movaps XMMWORD PTR [rbp+0x3e0],xmm6
   182c1a4d9:	0f 29 b5 d0 03 00 00 	movaps XMMWORD PTR [rbp+0x3d0],xmm6
   182c1a4e0:	0f 29 b5 c0 03 00 00 	movaps XMMWORD PTR [rbp+0x3c0],xmm6
   182c1a4e7:	0f 29 b5 b0 03 00 00 	movaps XMMWORD PTR [rbp+0x3b0],xmm6
   182c1a4ee:	0f 29 b5 a0 03 00 00 	movaps XMMWORD PTR [rbp+0x3a0],xmm6
   182c1a4f5:	48 8b 95 88 03 00 00 	mov    rdx,QWORD PTR [rbp+0x388]
   182c1a4fc:	c6 85 f0 03 00 00 00 	mov    BYTE PTR [rbp+0x3f0],0x0
   182c1a503:	80 7a 50 01          	cmp    BYTE PTR [rdx+0x50],0x1
   182c1a507:	0f 85 34 01 00 00    	jne    0x182c1a641
   182c1a50d:	48 8d 8d a0 03 00 00 	lea    rcx,[rbp+0x3a0]
   182c1a514:	e8 b7 32 b6 fd       	call   0x18077d7d0
   182c1a519:	90                   	nop
   182c1a51a:	c6 85 f0 03 00 00 01 	mov    BYTE PTR [rbp+0x3f0],0x1
   182c1a521:	8b 85 c0 03 00 00    	mov    eax,DWORD PTR [rbp+0x3c0]
   182c1a527:	48 8b 8d 40 05 00 00 	mov    rcx,QWORD PTR [rbp+0x540]
   182c1a52e:	48 89 41 10          	mov    QWORD PTR [rcx+0x10],rax
   182c1a532:	48 8d 15 7f 8c 48 06 	lea    rdx,[rip+0x6488c7f]        # 0x1890a31b8
   182c1a539:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c1a53d:	41 b8 f0 02 00 00    	mov    r8d,0x2f0
   182c1a543:	e8 f8 a8 af 04       	call   0x187714e40
   182c1a548:	90                   	nop
   182c1a549:	48 8d 8d c0 02 00 00 	lea    rcx,[rbp+0x2c0]
   182c1a550:	e8 cb cc 42 fd       	call   0x180047220
   182c1a555:	90                   	nop
   182c1a556:	48 8b 8d c0 02 00 00 	mov    rcx,QWORD PTR [rbp+0x2c0]
   182c1a55d:	48 8d 95 e0 04 00 00 	lea    rdx,[rbp+0x4e0]
   182c1a564:	e8 67 7e 76 fd       	call   0x1803823d0
   182c1a569:	90                   	nop
   182c1a56a:	48 8b 8d e0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4e0]
   182c1a571:	48 8d 95 30 04 00 00 	lea    rdx,[rbp+0x430]
   182c1a578:	e8 03 ed ae fd       	call   0x180709280
   182c1a57d:	90                   	nop
   182c1a57e:	48 8b 8d 30 04 00 00 	mov    rcx,QWORD PTR [rbp+0x430]
   182c1a585:	8b 85 c0 03 00 00    	mov    eax,DWORD PTR [rbp+0x3c0]
   182c1a58b:	44 8b 8d c4 03 00 00 	mov    r9d,DWORD PTR [rbp+0x3c4]
   182c1a592:	89 44 24 20          	mov    DWORD PTR [rsp+0x20],eax
   182c1a596:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   182c1a59a:	49 89 f0             	mov    r8,rsi
   182c1a59d:	e8 ee f5 b9 fe       	call   0x1817b9b90
   182c1a5a2:	90                   	nop
   182c1a5a3:	48 8b bd 38 04 00 00 	mov    rdi,QWORD PTR [rbp+0x438]
   182c1a5aa:	48 85 ff             	test   rdi,rdi
   182c1a5ad:	74 1d                	je     0x182c1a5cc
   182c1a5af:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   182c1a5b3:	75 17                	jne    0x182c1a5cc
   182c1a5b5:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c1a5b8:	48 89 f9             	mov    rcx,rdi
   182c1a5bb:	ff 10                	call   QWORD PTR [rax]
   182c1a5bd:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   182c1a5c1:	75 09                	jne    0x182c1a5cc
   182c1a5c3:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c1a5c6:	48 89 f9             	mov    rcx,rdi
   182c1a5c9:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c1a5cc:	48 8b bd e8 04 00 00 	mov    rdi,QWORD PTR [rbp+0x4e8]
   182c1a5d3:	48 85 ff             	test   rdi,rdi
   182c1a5d6:	4c 8b a5 40 05 00 00 	mov    r12,QWORD PTR [rbp+0x540]
   182c1a5dd:	74 1d                	je     0x182c1a5fc
   182c1a5df:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   182c1a5e3:	75 17                	jne    0x182c1a5fc
   182c1a5e5:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c1a5e8:	48 89 f9             	mov    rcx,rdi
   182c1a5eb:	ff 10                	call   QWORD PTR [rax]
   182c1a5ed:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   182c1a5f1:	75 09                	jne    0x182c1a5fc
   182c1a5f3:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c1a5f6:	48 89 f9             	mov    rcx,rdi
   182c1a5f9:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c1a5fc:	48 8b bd c8 02 00 00 	mov    rdi,QWORD PTR [rbp+0x2c8]
   182c1a603:	48 85 ff             	test   rdi,rdi
   182c1a606:	74 1d                	je     0x182c1a625
   182c1a608:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   182c1a60c:	75 17                	jne    0x182c1a625
   182c1a60e:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c1a611:	48 89 f9             	mov    rcx,rdi
   182c1a614:	ff 10                	call   QWORD PTR [rax]
   182c1a616:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   182c1a61a:	75 09                	jne    0x182c1a625
   182c1a61c:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c1a61f:	48 89 f9             	mov    rcx,rdi
   182c1a622:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c1a625:	80 bd a8 02 00 00 00 	cmp    BYTE PTR [rbp+0x2a8],0x0
   182c1a62c:	74 13                	je     0x182c1a641
   182c1a62e:	48 8b 85 08 01 00 00 	mov    rax,QWORD PTR [rbp+0x108]
   182c1a635:	48 89 03             	mov    QWORD PTR [rbx],rax
   182c1a638:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c1a63c:	e8 ff 1f 5b fd       	call   0x1801cc640
   182c1a641:	b9 02 00 00 00       	mov    ecx,0x2
   182c1a646:	e8 95 27 45 fd       	call   0x18006cde0
   182c1a64b:	85 c0                	test   eax,eax
   182c1a64d:	0f 84 05 02 00 00    	je     0x182c1a858
   182c1a653:	48 8d bd 30 03 00 00 	lea    rdi,[rbp+0x330]
   182c1a65a:	48 89 f9             	mov    rcx,rdi
   182c1a65d:	e8 ae 28 45 fd       	call   0x18006cf10
   182c1a662:	90                   	nop
   182c1a663:	48 83 bd 48 03 00 00 	cmp    QWORD PTR [rbp+0x348],0x10
   182c1a66a:	10 
   182c1a66b:	72 07                	jb     0x182c1a674
   182c1a66d:	48 8b bd 30 03 00 00 	mov    rdi,QWORD PTR [rbp+0x330]
   182c1a674:	48 8d 05 75 3e 95 06 	lea    rax,[rip+0x6953e75]        # 0x18956e4f0
   182c1a67b:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182c1a680:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182c1a687:	00 00 
   182c1a689:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182c1a68e:	c7 44 24 28 db 0a 00 	mov    DWORD PTR [rsp+0x28],0xadb
   182c1a695:	00 
   182c1a696:	4c 8d 0d cb ee 94 06 	lea    r9,[rip+0x694eecb]        # 0x189569568
   182c1a69d:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c1a6a1:	ba 02 00 00 00       	mov    edx,0x2
   182c1a6a6:	49 89 f8             	mov    r8,rdi
   182c1a6a9:	e8 c2 2b 45 fd       	call   0x18006d270
   182c1a6ae:	90                   	nop
   182c1a6af:	4c 8b 0b             	mov    r9,QWORD PTR [rbx]
   182c1a6b2:	48 c7 85 e0 04 00 00 	mov    QWORD PTR [rbp+0x4e0],0x0
   182c1a6b9:	00 00 00 00 
   182c1a6bd:	41 b8 08 00 00 00    	mov    r8d,0x8
   182c1a6c3:	49 ba 67 66 66 66 66 	movabs r10,0x6666666666666667
   182c1a6ca:	66 66 66 
   182c1a6cd:	4c 8d 1d 9c cb 2f 06 	lea    r11,[rip+0x62fcb9c]        # 0x188f17270
   182c1a6d4:	4c 89 c9             	mov    rcx,r9
   182c1a6d7:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
   182c1a6de:	00 00 
   182c1a6e0:	48 89 c8             	mov    rax,rcx
   182c1a6e3:	49 f7 ea             	imul   r10
   182c1a6e6:	48 89 d0             	mov    rax,rdx
   182c1a6e9:	48 c1 e8 3f          	shr    rax,0x3f
   182c1a6ed:	48 c1 fa 02          	sar    rdx,0x2
   182c1a6f1:	48 01 c2             	add    rdx,rax
   182c1a6f4:	48 8d 04 12          	lea    rax,[rdx+rdx*1]
   182c1a6f8:	48 8d 04 80          	lea    rax,[rax+rax*4]
   182c1a6fc:	4c 89 df             	mov    rdi,r11
   182c1a6ff:	48 29 c7             	sub    rdi,rax
   182c1a702:	0f b6 44 0f 23       	movzx  eax,BYTE PTR [rdi+rcx*1+0x23]
   182c1a707:	42 88 84 05 e0 04 00 	mov    BYTE PTR [rbp+r8*1+0x4e0],al
   182c1a70e:	00 
   182c1a70f:	49 ff c0             	inc    r8
   182c1a712:	48 83 c1 09          	add    rcx,0x9
   182c1a716:	48 83 f9 12          	cmp    rcx,0x12
   182c1a71a:	48 89 d1             	mov    rcx,rdx
   182c1a71d:	77 c1                	ja     0x182c1a6e0
   182c1a71f:	4d 85 c9             	test   r9,r9
   182c1a722:	79 0c                	jns    0x182c1a730
   182c1a724:	42 c6 84 05 e0 04 00 	mov    BYTE PTR [rbp+r8*1+0x4e0],0x2d
   182c1a72b:	00 2d 
   182c1a72d:	49 ff c0             	inc    r8
   182c1a730:	48 8d 85 e8 04 00 00 	lea    rax,[rbp+0x4e8]
   182c1a737:	42 c6 84 05 e0 04 00 	mov    BYTE PTR [rbp+r8*1+0x4e0],0x0
   182c1a73e:	00 00 
   182c1a740:	49 83 f8 0a          	cmp    r8,0xa
   182c1a744:	7c 36                	jl     0x182c1a77c
   182c1a746:	49 8d 0c 28          	lea    rcx,[r8+rbp*1]
   182c1a74a:	48 81 c1 e0 04 00 00 	add    rcx,0x4e0
   182c1a751:	48 ff c9             	dec    rcx
   182c1a754:	48 8d 95 e9 04 00 00 	lea    rdx,[rbp+0x4e9]
   182c1a75b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
   182c1a760:	44 0f b6 01          	movzx  r8d,BYTE PTR [rcx]
   182c1a764:	44 0f b6 4a ff       	movzx  r9d,BYTE PTR [rdx-0x1]
   182c1a769:	44 88 09             	mov    BYTE PTR [rcx],r9b
   182c1a76c:	44 88 42 ff          	mov    BYTE PTR [rdx-0x1],r8b
   182c1a770:	48 ff c9             	dec    rcx
   182c1a773:	48 39 ca             	cmp    rdx,rcx
   182c1a776:	48 8d 52 01          	lea    rdx,[rdx+0x1]
   182c1a77a:	72 e4                	jb     0x182c1a760
   182c1a77c:	48 89 85 e0 04 00 00 	mov    QWORD PTR [rbp+0x4e0],rax
   182c1a783:	48 83 7e 18 10       	cmp    QWORD PTR [rsi+0x18],0x10
   182c1a788:	72 03                	jb     0x182c1a78d
   182c1a78a:	48 8b 36             	mov    rsi,QWORD PTR [rsi]
   182c1a78d:	48 89 b5 c0 02 00 00 	mov    QWORD PTR [rbp+0x2c0],rsi
   182c1a794:	c6 85 c8 02 00 00 00 	mov    BYTE PTR [rbp+0x2c8],0x0
   182c1a79b:	0f 57 c0             	xorps  xmm0,xmm0
   182c1a79e:	0f 11 85 a0 04 00 00 	movups XMMWORD PTR [rbp+0x4a0],xmm0
   182c1a7a5:	0f 11 85 90 04 00 00 	movups XMMWORD PTR [rbp+0x490],xmm0
   182c1a7ac:	0f 11 85 80 04 00 00 	movups XMMWORD PTR [rbp+0x480],xmm0
   182c1a7b3:	0f 11 85 70 04 00 00 	movups XMMWORD PTR [rbp+0x470],xmm0
   182c1a7ba:	0f 11 85 60 04 00 00 	movups XMMWORD PTR [rbp+0x460],xmm0
   182c1a7c1:	0f 11 85 50 04 00 00 	movups XMMWORD PTR [rbp+0x450],xmm0
   182c1a7c8:	0f 11 85 40 04 00 00 	movups XMMWORD PTR [rbp+0x440],xmm0
   182c1a7cf:	48 8d 85 c0 02 00 00 	lea    rax,[rbp+0x2c0]
   182c1a7d6:	48 89 85 30 04 00 00 	mov    QWORD PTR [rbp+0x430],rax
   182c1a7dd:	48 8d 85 e0 04 00 00 	lea    rax,[rbp+0x4e0]
   182c1a7e4:	48 89 85 38 04 00 00 	mov    QWORD PTR [rbp+0x438],rax
   182c1a7eb:	48 8d 15 4e 40 95 06 	lea    rdx,[rip+0x695404e]        # 0x18956e840
   182c1a7f2:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c1a7f6:	4c 8d 85 30 04 00 00 	lea    r8,[rbp+0x430]
   182c1a7fd:	e8 0e 30 45 fd       	call   0x18006d810
   182c1a802:	90                   	nop
   182c1a803:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c1a807:	e8 64 2b 45 fd       	call   0x18006d370
   182c1a80c:	48 8b 85 48 03 00 00 	mov    rax,QWORD PTR [rbp+0x348]
   182c1a813:	48 83 f8 10          	cmp    rax,0x10
   182c1a817:	4c 8b a5 40 05 00 00 	mov    r12,QWORD PTR [rbp+0x540]
   182c1a81e:	72 38                	jb     0x182c1a858
   182c1a820:	48 8b 8d 30 03 00 00 	mov    rcx,QWORD PTR [rbp+0x330]
   182c1a827:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c1a82b:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c1a832:	72 1f                	jb     0x182c1a853
   182c1a834:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c1a838:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c1a83c:	4c 29 c1             	sub    rcx,r8
   182c1a83f:	48 83 f9 20          	cmp    rcx,0x20
   182c1a843:	0f 83 54 06 00 00    	jae    0x182c1ae9d
   182c1a849:	48 83 c0 28          	add    rax,0x28
   182c1a84d:	48 89 c2             	mov    rdx,rax
   182c1a850:	4c 89 c1             	mov    rcx,r8
   182c1a853:	e8 c8 14 93 04       	call   0x18754bd20
   182c1a858:	80 bd f0 03 00 00 01 	cmp    BYTE PTR [rbp+0x3f0],0x1
   182c1a85f:	0f 85 5c 03 00 00    	jne    0x182c1abc1
   182c1a865:	48 8b 85 e8 03 00 00 	mov    rax,QWORD PTR [rbp+0x3e8]
   182c1a86c:	48 83 f8 10          	cmp    rax,0x10
   182c1a870:	72 38                	jb     0x182c1a8aa
   182c1a872:	48 8b 8d d0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3d0]
   182c1a879:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c1a87d:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c1a884:	72 1f                	jb     0x182c1a8a5
   182c1a886:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c1a88a:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c1a88e:	4c 29 c1             	sub    rcx,r8
   182c1a891:	48 83 f9 20          	cmp    rcx,0x20
   182c1a895:	0f 83 02 06 00 00    	jae    0x182c1ae9d
   182c1a89b:	48 83 c0 28          	add    rax,0x28
   182c1a89f:	48 89 c2             	mov    rdx,rax
   182c1a8a2:	4c 89 c1             	mov    rcx,r8
   182c1a8a5:	e8 76 14 93 04       	call   0x18754bd20
   182c1a8aa:	48 8b 85 b8 03 00 00 	mov    rax,QWORD PTR [rbp+0x3b8]
   182c1a8b1:	48 83 f8 10          	cmp    rax,0x10
   182c1a8b5:	0f 82 06 03 00 00    	jb     0x182c1abc1
   182c1a8bb:	48 8b 8d a0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3a0]
   182c1a8c2:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c1a8c6:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c1a8cd:	0f 83 ca 02 00 00    	jae    0x182c1ab9d
   182c1a8d3:	e9 e4 02 00 00       	jmp    0x182c1abbc
   182c1a8d8:	49 8d 48 22          	lea    rcx,[r8+0x22]
   182c1a8dc:	48 89 8d 40 04 00 00 	mov    QWORD PTR [rbp+0x440],rcx
   182c1a8e3:	48 83 f8 10          	cmp    rax,0x10
   182c1a8e7:	48 8b 8d 30 04 00 00 	mov    rcx,QWORD PTR [rbp+0x430]
   182c1a8ee:	48 89 f7             	mov    rdi,rsi
   182c1a8f1:	48 0f 43 f9          	cmovae rdi,rcx
   182c1a8f5:	48 8d 15 16 73 94 06 	lea    rdx,[rip+0x6947316]        # 0x189561c12
   182c1a8fc:	48 39 d7             	cmp    rdi,rdx
   182c1a8ff:	0f 93 c2             	setae  dl
   182c1a902:	48 8d 1d e7 72 94 06 	lea    rbx,[rip+0x69472e7]        # 0x189561bf0
   182c1a909:	4e 8d 0c 07          	lea    r9,[rdi+r8*1]
   182c1a90d:	49 39 d9             	cmp    r9,rbx
   182c1a910:	41 0f 92 c1          	setb   r9b
   182c1a914:	41 08 d1             	or     r9b,dl
   182c1a917:	41 be 22 00 00 00    	mov    r14d,0x22
   182c1a91d:	41 bf 22 00 00 00    	mov    r15d,0x22
   182c1a923:	4c 8b a5 40 05 00 00 	mov    r12,QWORD PTR [rbp+0x540]
   182c1a92a:	75 0b                	jne    0x182c1a937
   182c1a92c:	49 89 ff             	mov    r15,rdi
   182c1a92f:	49 29 df             	sub    r15,rbx
   182c1a932:	77 03                	ja     0x182c1a937
   182c1a934:	45 31 ff             	xor    r15d,r15d
   182c1a937:	49 ff c0             	inc    r8
   182c1a93a:	48 83 f8 10          	cmp    rax,0x10
   182c1a93e:	48 0f 42 ce          	cmovb  rcx,rsi
   182c1a942:	48 83 c1 22          	add    rcx,0x22
   182c1a946:	48 89 fa             	mov    rdx,rdi
   182c1a949:	e8 f2 a4 af 04       	call   0x187714e40
   182c1a94e:	48 89 f9             	mov    rcx,rdi
   182c1a951:	48 89 da             	mov    rdx,rbx
   182c1a954:	4d 89 f8             	mov    r8,r15
   182c1a957:	e8 e4 a4 af 04       	call   0x187714e40
   182c1a95c:	4d 29 fe             	sub    r14,r15
   182c1a95f:	49 8d 14 1f          	lea    rdx,[r15+rbx*1]
   182c1a963:	48 83 c2 22          	add    rdx,0x22
   182c1a967:	4c 01 ff             	add    rdi,r15
   182c1a96a:	48 89 f9             	mov    rcx,rdi
   182c1a96d:	4d 89 f0             	mov    r8,r14
   182c1a970:	e8 cb a4 af 04       	call   0x187714e40
   182c1a975:	0f b6 1e             	movzx  ebx,BYTE PTR [rsi]
   182c1a978:	48 8b 46 08          	mov    rax,QWORD PTR [rsi+0x8]
   182c1a97c:	48 89 85 a7 03 00 00 	mov    QWORD PTR [rbp+0x3a7],rax
   182c1a983:	48 8b 46 01          	mov    rax,QWORD PTR [rsi+0x1]
   182c1a987:	48 89 85 a0 03 00 00 	mov    QWORD PTR [rbp+0x3a0],rax
   182c1a98e:	0f 10 76 10          	movups xmm6,XMMWORD PTR [rsi+0x10]
   182c1a992:	48 c7 46 10 00 00 00 	mov    QWORD PTR [rsi+0x10],0x0
   182c1a999:	00 
   182c1a99a:	48 c7 46 18 0f 00 00 	mov    QWORD PTR [rsi+0x18],0xf
   182c1a9a1:	00 
   182c1a9a2:	c6 06 00             	mov    BYTE PTR [rsi],0x0
   182c1a9a5:	49 8b 44 24 30       	mov    rax,QWORD PTR [r12+0x30]
   182c1a9aa:	48 83 f8 10          	cmp    rax,0x10
   182c1a9ae:	72 36                	jb     0x182c1a9e6
   182c1a9b0:	49 8b 4c 24 18       	mov    rcx,QWORD PTR [r12+0x18]
   182c1a9b5:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c1a9b9:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c1a9c0:	72 1f                	jb     0x182c1a9e1
   182c1a9c2:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c1a9c6:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c1a9ca:	4c 29 c1             	sub    rcx,r8
   182c1a9cd:	48 83 f9 20          	cmp    rcx,0x20
   182c1a9d1:	0f 83 c6 04 00 00    	jae    0x182c1ae9d
   182c1a9d7:	48 83 c0 28          	add    rax,0x28
   182c1a9db:	48 89 c2             	mov    rdx,rax
   182c1a9de:	4c 89 c1             	mov    rcx,r8
   182c1a9e1:	e8 3a 13 93 04       	call   0x18754bd20
   182c1a9e6:	41 88 5c 24 18       	mov    BYTE PTR [r12+0x18],bl
   182c1a9eb:	48 8b 85 a0 03 00 00 	mov    rax,QWORD PTR [rbp+0x3a0]
   182c1a9f2:	48 8b 8d a7 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3a7]
   182c1a9f9:	49 89 44 24 19       	mov    QWORD PTR [r12+0x19],rax
   182c1a9fe:	49 89 4c 24 20       	mov    QWORD PTR [r12+0x20],rcx
   182c1aa03:	41 0f 11 74 24 28    	movups XMMWORD PTR [r12+0x28],xmm6
   182c1aa09:	48 8b 85 48 04 00 00 	mov    rax,QWORD PTR [rbp+0x448]
   182c1aa10:	48 83 f8 10          	cmp    rax,0x10
   182c1aa14:	0f 82 d1 03 00 00    	jb     0x182c1adeb
   182c1aa1a:	48 8b 8d 30 04 00 00 	mov    rcx,QWORD PTR [rbp+0x430]
   182c1aa21:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c1aa25:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c1aa2c:	72 1f                	jb     0x182c1aa4d
   182c1aa2e:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c1aa32:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c1aa36:	4c 29 c1             	sub    rcx,r8
   182c1aa39:	48 83 f9 20          	cmp    rcx,0x20
   182c1aa3d:	0f 83 5a 04 00 00    	jae    0x182c1ae9d
   182c1aa43:	48 83 c0 28          	add    rax,0x28
   182c1aa47:	48 89 c2             	mov    rdx,rax
   182c1aa4a:	4c 89 c1             	mov    rcx,r8
   182c1aa4d:	e8 ce 12 93 04       	call   0x18754bd20
   182c1aa52:	e9 94 03 00 00       	jmp    0x182c1adeb
   182c1aa57:	49 8d 48 1a          	lea    rcx,[r8+0x1a]
   182c1aa5b:	48 89 4d d0          	mov    QWORD PTR [rbp-0x30],rcx
   182c1aa5f:	48 83 f8 10          	cmp    rax,0x10
   182c1aa63:	48 8b 4d c0          	mov    rcx,QWORD PTR [rbp-0x40]
   182c1aa67:	48 89 f7             	mov    rdi,rsi
   182c1aa6a:	48 0f 43 f9          	cmovae rdi,rcx
   182c1aa6e:	48 8d 15 e5 71 94 06 	lea    rdx,[rip+0x69471e5]        # 0x189561c5a
   182c1aa75:	48 39 d7             	cmp    rdi,rdx
   182c1aa78:	0f 93 c2             	setae  dl
   182c1aa7b:	48 8d 1d be 71 94 06 	lea    rbx,[rip+0x69471be]        # 0x189561c40
   182c1aa82:	4e 8d 0c 07          	lea    r9,[rdi+r8*1]
   182c1aa86:	49 39 d9             	cmp    r9,rbx
   182c1aa89:	41 0f 92 c1          	setb   r9b
   182c1aa8d:	41 08 d1             	or     r9b,dl
   182c1aa90:	41 be 1a 00 00 00    	mov    r14d,0x1a
   182c1aa96:	41 bf 1a 00 00 00    	mov    r15d,0x1a
   182c1aa9c:	4c 8b a5 40 05 00 00 	mov    r12,QWORD PTR [rbp+0x540]
   182c1aaa3:	75 0b                	jne    0x182c1aab0
   182c1aaa5:	49 89 ff             	mov    r15,rdi
   182c1aaa8:	49 29 df             	sub    r15,rbx
   182c1aaab:	77 03                	ja     0x182c1aab0
   182c1aaad:	45 31 ff             	xor    r15d,r15d
   182c1aab0:	49 ff c0             	inc    r8
   182c1aab3:	48 83 f8 10          	cmp    rax,0x10
   182c1aab7:	48 0f 42 ce          	cmovb  rcx,rsi
   182c1aabb:	48 83 c1 1a          	add    rcx,0x1a
   182c1aabf:	48 89 fa             	mov    rdx,rdi
   182c1aac2:	e8 79 a3 af 04       	call   0x187714e40
   182c1aac7:	48 89 f9             	mov    rcx,rdi
   182c1aaca:	48 89 da             	mov    rdx,rbx
   182c1aacd:	4d 89 f8             	mov    r8,r15
   182c1aad0:	e8 6b a3 af 04       	call   0x187714e40
   182c1aad5:	4d 29 fe             	sub    r14,r15
   182c1aad8:	49 8d 14 1f          	lea    rdx,[r15+rbx*1]
   182c1aadc:	48 83 c2 1a          	add    rdx,0x1a
   182c1aae0:	4c 01 ff             	add    rdi,r15
   182c1aae3:	48 89 f9             	mov    rcx,rdi
   182c1aae6:	4d 89 f0             	mov    r8,r14
   182c1aae9:	e8 52 a3 af 04       	call   0x187714e40
   182c1aaee:	0f b6 1e             	movzx  ebx,BYTE PTR [rsi]
   182c1aaf1:	48 8b 46 08          	mov    rax,QWORD PTR [rsi+0x8]
   182c1aaf5:	48 89 85 37 04 00 00 	mov    QWORD PTR [rbp+0x437],rax
   182c1aafc:	48 8b 46 01          	mov    rax,QWORD PTR [rsi+0x1]
   182c1ab00:	48 89 85 30 04 00 00 	mov    QWORD PTR [rbp+0x430],rax
   182c1ab07:	0f 10 76 10          	movups xmm6,XMMWORD PTR [rsi+0x10]
   182c1ab0b:	48 c7 46 10 00 00 00 	mov    QWORD PTR [rsi+0x10],0x0
   182c1ab12:	00 
   182c1ab13:	48 c7 46 18 0f 00 00 	mov    QWORD PTR [rsi+0x18],0xf
   182c1ab1a:	00 
   182c1ab1b:	c6 06 00             	mov    BYTE PTR [rsi],0x0
   182c1ab1e:	49 8b 44 24 30       	mov    rax,QWORD PTR [r12+0x30]
   182c1ab23:	48 83 f8 10          	cmp    rax,0x10
   182c1ab27:	72 36                	jb     0x182c1ab5f
   182c1ab29:	49 8b 4c 24 18       	mov    rcx,QWORD PTR [r12+0x18]
   182c1ab2e:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c1ab32:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c1ab39:	72 1f                	jb     0x182c1ab5a
   182c1ab3b:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c1ab3f:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c1ab43:	4c 29 c1             	sub    rcx,r8
   182c1ab46:	48 83 f9 20          	cmp    rcx,0x20
   182c1ab4a:	0f 83 4d 03 00 00    	jae    0x182c1ae9d
   182c1ab50:	48 83 c0 28          	add    rax,0x28
   182c1ab54:	48 89 c2             	mov    rdx,rax
   182c1ab57:	4c 89 c1             	mov    rcx,r8
   182c1ab5a:	e8 c1 11 93 04       	call   0x18754bd20
   182c1ab5f:	41 88 5c 24 18       	mov    BYTE PTR [r12+0x18],bl
   182c1ab64:	48 8b 85 30 04 00 00 	mov    rax,QWORD PTR [rbp+0x430]
   182c1ab6b:	48 8b 8d 37 04 00 00 	mov    rcx,QWORD PTR [rbp+0x437]
   182c1ab72:	49 89 44 24 19       	mov    QWORD PTR [r12+0x19],rax
   182c1ab77:	49 89 4c 24 20       	mov    QWORD PTR [r12+0x20],rcx
   182c1ab7c:	41 0f 11 74 24 28    	movups XMMWORD PTR [r12+0x28],xmm6
   182c1ab82:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
   182c1ab86:	48 83 f8 10          	cmp    rax,0x10
   182c1ab8a:	72 35                	jb     0x182c1abc1
   182c1ab8c:	48 8b 4d c0          	mov    rcx,QWORD PTR [rbp-0x40]
   182c1ab90:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c1ab94:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c1ab9b:	72 1f                	jb     0x182c1abbc
   182c1ab9d:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c1aba1:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c1aba5:	4c 29 c1             	sub    rcx,r8
   182c1aba8:	48 83 f9 20          	cmp    rcx,0x20
   182c1abac:	0f 83 eb 02 00 00    	jae    0x182c1ae9d
   182c1abb2:	48 83 c0 28          	add    rax,0x28
   182c1abb6:	48 89 c2             	mov    rdx,rax
   182c1abb9:	4c 89 c1             	mov    rcx,r8
   182c1abbc:	e8 5f 11 93 04       	call   0x18754bd20
   182c1abc1:	48 8b b5 90 03 00 00 	mov    rsi,QWORD PTR [rbp+0x390]
   182c1abc8:	48 85 f6             	test   rsi,rsi
   182c1abcb:	74 1d                	je     0x182c1abea
   182c1abcd:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182c1abd1:	75 17                	jne    0x182c1abea
   182c1abd3:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182c1abd6:	48 89 f1             	mov    rcx,rsi
   182c1abd9:	ff 10                	call   QWORD PTR [rax]
   182c1abdb:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182c1abdf:	75 09                	jne    0x182c1abea
   182c1abe1:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182c1abe4:	48 89 f1             	mov    rcx,rsi
   182c1abe7:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c1abea:	48 8b 85 80 03 00 00 	mov    rax,QWORD PTR [rbp+0x380]
   182c1abf1:	48 83 f8 10          	cmp    rax,0x10
   182c1abf5:	72 38                	jb     0x182c1ac2f
   182c1abf7:	48 8b 8d 68 03 00 00 	mov    rcx,QWORD PTR [rbp+0x368]
   182c1abfe:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c1ac02:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c1ac09:	72 1f                	jb     0x182c1ac2a
   182c1ac0b:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c1ac0f:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c1ac13:	4c 29 c1             	sub    rcx,r8
   182c1ac16:	48 83 f9 20          	cmp    rcx,0x20
   182c1ac1a:	0f 83 7d 02 00 00    	jae    0x182c1ae9d
   182c1ac20:	48 83 c0 28          	add    rax,0x28
   182c1ac24:	48 89 c2             	mov    rdx,rax
   182c1ac27:	4c 89 c1             	mov    rcx,r8
   182c1ac2a:	e8 f1 10 93 04       	call   0x18754bd20
   182c1ac2f:	48 8b b5 38 05 00 00 	mov    rsi,QWORD PTR [rbp+0x538]
   182c1ac36:	48 85 f6             	test   rsi,rsi
   182c1ac39:	74 1d                	je     0x182c1ac58
   182c1ac3b:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182c1ac3f:	75 17                	jne    0x182c1ac58
   182c1ac41:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182c1ac44:	48 89 f1             	mov    rcx,rsi
   182c1ac47:	ff 10                	call   QWORD PTR [rax]
   182c1ac49:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182c1ac4d:	75 09                	jne    0x182c1ac58
   182c1ac4f:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182c1ac52:	48 89 f1             	mov    rcx,rsi
   182c1ac55:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c1ac58:	48 8d 8d 10 03 00 00 	lea    rcx,[rbp+0x310]
   182c1ac5f:	e8 fc cd 3e fd       	call   0x180007a60
   182c1ac64:	48 8b 85 d8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4d8]
   182c1ac6b:	48 83 f8 10          	cmp    rax,0x10
   182c1ac6f:	0f 83 d6 01 00 00    	jae    0x182c1ae4b
   182c1ac75:	e9 05 02 00 00       	jmp    0x182c1ae7f
   182c1ac7a:	b9 04 00 00 00       	mov    ecx,0x4
   182c1ac7f:	e8 5c 21 45 fd       	call   0x18006cde0
   182c1ac84:	85 c0                	test   eax,eax
   182c1ac86:	0f 84 06 01 00 00    	je     0x182c1ad92
   182c1ac8c:	48 8d b5 e0 04 00 00 	lea    rsi,[rbp+0x4e0]
   182c1ac93:	48 89 f1             	mov    rcx,rsi
   182c1ac96:	e8 75 22 45 fd       	call   0x18006cf10
   182c1ac9b:	90                   	nop
   182c1ac9c:	48 83 bd f8 04 00 00 	cmp    QWORD PTR [rbp+0x4f8],0x10
   182c1aca3:	10 
   182c1aca4:	72 07                	jb     0x182c1acad
   182c1aca6:	48 8b b5 e0 04 00 00 	mov    rsi,QWORD PTR [rbp+0x4e0]
   182c1acad:	48 8d 05 3c 38 95 06 	lea    rax,[rip+0x695383c]        # 0x18956e4f0
   182c1acb4:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182c1acb9:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182c1acc0:	00 00 
   182c1acc2:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182c1acc7:	c7 44 24 28 bd 0a 00 	mov    DWORD PTR [rsp+0x28],0xabd
   182c1acce:	00 
   182c1accf:	4c 8d 0d 92 e8 94 06 	lea    r9,[rip+0x694e892]        # 0x189569568
   182c1acd6:	48 8d 8d 30 04 00 00 	lea    rcx,[rbp+0x430]
   182c1acdd:	ba 04 00 00 00       	mov    edx,0x4
   182c1ace2:	49 89 f0             	mov    r8,rsi
   182c1ace5:	e8 86 25 45 fd       	call   0x18006d270
   182c1acea:	90                   	nop
   182c1aceb:	0f 57 c0             	xorps  xmm0,xmm0
   182c1acee:	0f 29 85 10 04 00 00 	movaps XMMWORD PTR [rbp+0x410],xmm0
   182c1acf5:	0f 29 85 00 04 00 00 	movaps XMMWORD PTR [rbp+0x400],xmm0
   182c1acfc:	0f 29 85 f0 03 00 00 	movaps XMMWORD PTR [rbp+0x3f0],xmm0
   182c1ad03:	0f 29 85 e0 03 00 00 	movaps XMMWORD PTR [rbp+0x3e0],xmm0
   182c1ad0a:	0f 29 85 d0 03 00 00 	movaps XMMWORD PTR [rbp+0x3d0],xmm0
   182c1ad11:	0f 29 85 c0 03 00 00 	movaps XMMWORD PTR [rbp+0x3c0],xmm0
   182c1ad18:	0f 29 85 b0 03 00 00 	movaps XMMWORD PTR [rbp+0x3b0],xmm0
   182c1ad1f:	0f 29 85 a0 03 00 00 	movaps XMMWORD PTR [rbp+0x3a0],xmm0
   182c1ad26:	48 8d 15 33 39 95 06 	lea    rdx,[rip+0x6953933]        # 0x18956e660
   182c1ad2d:	48 8d 8d 30 04 00 00 	lea    rcx,[rbp+0x430]
   182c1ad34:	4c 8d 85 a0 03 00 00 	lea    r8,[rbp+0x3a0]
   182c1ad3b:	e8 d0 2a 45 fd       	call   0x18006d810
   182c1ad40:	90                   	nop
   182c1ad41:	48 8d 8d 30 04 00 00 	lea    rcx,[rbp+0x430]
   182c1ad48:	e8 23 26 45 fd       	call   0x18006d370
   182c1ad4d:	48 8b 85 f8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4f8]
   182c1ad54:	48 83 f8 10          	cmp    rax,0x10
   182c1ad58:	72 38                	jb     0x182c1ad92
   182c1ad5a:	48 8b 8d e0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4e0]
   182c1ad61:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c1ad65:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c1ad6c:	72 1f                	jb     0x182c1ad8d
   182c1ad6e:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c1ad72:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c1ad76:	4c 29 c1             	sub    rcx,r8
   182c1ad79:	48 83 f9 20          	cmp    rcx,0x20
   182c1ad7d:	0f 83 1a 01 00 00    	jae    0x182c1ae9d
   182c1ad83:	48 83 c0 28          	add    rax,0x28
   182c1ad87:	48 89 c2             	mov    rdx,rax
   182c1ad8a:	4c 89 c1             	mov    rcx,r8
   182c1ad8d:	e8 8e 0f 93 04       	call   0x18754bd20
   182c1ad92:	48 8b 8d 40 05 00 00 	mov    rcx,QWORD PTR [rbp+0x540]
   182c1ad99:	48 83 79 30 25       	cmp    QWORD PTR [rcx+0x30],0x25
   182c1ad9e:	73 18                	jae    0x182c1adb8
   182c1ada0:	48 83 c1 18          	add    rcx,0x18
   182c1ada4:	4c 8d 0d 6d 6e 94 06 	lea    r9,[rip+0x6946e6d]        # 0x189561c18
   182c1adab:	ba 25 00 00 00       	mov    edx,0x25
   182c1adb0:	e8 9b 33 42 fd       	call   0x18003e150
   182c1adb5:	90                   	nop
   182c1adb6:	eb 33                	jmp    0x182c1adeb
   182c1adb8:	48 8b 41 18          	mov    rax,QWORD PTR [rcx+0x18]
   182c1adbc:	48 c7 41 28 25 00 00 	mov    QWORD PTR [rcx+0x28],0x25
   182c1adc3:	00 
   182c1adc4:	0f 10 05 5d 6e 94 06 	movups xmm0,XMMWORD PTR [rip+0x6946e5d]        # 0x189561c28
   182c1adcb:	0f 11 40 10          	movups XMMWORD PTR [rax+0x10],xmm0
   182c1adcf:	0f 10 05 42 6e 94 06 	movups xmm0,XMMWORD PTR [rip+0x6946e42]        # 0x189561c18
   182c1add6:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   182c1add9:	48 b9 20 6f 6e 20 64 	movabs rcx,0x6b736964206e6f20
   182c1ade0:	69 73 6b 
   182c1ade3:	48 89 48 1d          	mov    QWORD PTR [rax+0x1d],rcx
   182c1ade7:	c6 40 25 00          	mov    BYTE PTR [rax+0x25],0x0
   182c1adeb:	48 8d 05 26 38 3b 06 	lea    rax,[rip+0x63b3826]        # 0x188fce618
   182c1adf2:	48 89 85 c0 02 00 00 	mov    QWORD PTR [rbp+0x2c0],rax
   182c1adf9:	48 8b b5 d8 02 00 00 	mov    rsi,QWORD PTR [rbp+0x2d8]
   182c1ae00:	48 85 f6             	test   rsi,rsi
   182c1ae03:	74 1d                	je     0x182c1ae22
   182c1ae05:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182c1ae09:	75 17                	jne    0x182c1ae22
   182c1ae0b:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182c1ae0e:	48 89 f1             	mov    rcx,rsi
   182c1ae11:	ff 10                	call   QWORD PTR [rax]
   182c1ae13:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182c1ae17:	75 09                	jne    0x182c1ae22
   182c1ae19:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182c1ae1c:	48 89 f1             	mov    rcx,rsi
   182c1ae1f:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c1ae22:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c1ae26:	e8 35 d1 ff ff       	call   0x182c17f60
   182c1ae2b:	48 8d 8d 10 03 00 00 	lea    rcx,[rbp+0x310]
   182c1ae32:	e8 29 cc 3e fd       	call   0x180007a60
   182c1ae37:	48 8b 85 d8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4d8]
   182c1ae3e:	48 83 f8 10          	cmp    rax,0x10
   182c1ae42:	4c 8b a5 40 05 00 00 	mov    r12,QWORD PTR [rbp+0x540]
   182c1ae49:	72 34                	jb     0x182c1ae7f
   182c1ae4b:	48 8b 8d c0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4c0]
   182c1ae52:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c1ae56:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c1ae5d:	72 1b                	jb     0x182c1ae7a
   182c1ae5f:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c1ae63:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c1ae67:	4c 29 c1             	sub    rcx,r8
   182c1ae6a:	48 83 f9 20          	cmp    rcx,0x20
   182c1ae6e:	73 2d                	jae    0x182c1ae9d
   182c1ae70:	48 83 c0 28          	add    rax,0x28
   182c1ae74:	48 89 c2             	mov    rdx,rax
   182c1ae77:	4c 89 c1             	mov    rcx,r8
   182c1ae7a:	e8 a1 0e 93 04       	call   0x18754bd20
   182c1ae7f:	4c 89 e0             	mov    rax,r12
   182c1ae82:	0f 28 b5 50 05 00 00 	movaps xmm6,XMMWORD PTR [rbp+0x550]
   182c1ae89:	48 81 c4 e8 05 00 00 	add    rsp,0x5e8
   182c1ae90:	5b                   	pop    rbx
   182c1ae91:	5f                   	pop    rdi
   182c1ae92:	5e                   	pop    rsi
   182c1ae93:	41 5c                	pop    r12
   182c1ae95:	41 5d                	pop    r13
   182c1ae97:	41 5e                	pop    r14
   182c1ae99:	41 5f                	pop    r15
   182c1ae9b:	5d                   	pop    rbp
   182c1ae9c:	c3                   	ret
   182c1ae9d:	e8 ea 32 ac 04       	call   0x1876de18c
   182c1aea2:	90                   	nop
   182c1aea3:	e8 e8 dc 3e fd       	call   0x180008b90
   182c1aea8:	90                   	nop
   182c1aea9:	cc                   	int3
