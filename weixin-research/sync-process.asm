
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

0000000182ebb760 <.text+0x2eba760>:
   182ebb760:	55                   	push   rbp
   182ebb761:	41 57                	push   r15
   182ebb763:	41 56                	push   r14
   182ebb765:	41 55                	push   r13
   182ebb767:	41 54                	push   r12
   182ebb769:	56                   	push   rsi
   182ebb76a:	57                   	push   rdi
   182ebb76b:	53                   	push   rbx
   182ebb76c:	48 81 ec d8 03 00 00 	sub    rsp,0x3d8
   182ebb773:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   182ebb77a:	00 
   182ebb77b:	0f 29 bd 40 03 00 00 	movaps XMMWORD PTR [rbp+0x340],xmm7
   182ebb782:	0f 29 b5 30 03 00 00 	movaps XMMWORD PTR [rbp+0x330],xmm6
   182ebb789:	48 c7 85 28 03 00 00 	mov    QWORD PTR [rbp+0x328],0xfffffffffffffffe
   182ebb790:	fe ff ff ff 
   182ebb794:	45 89 cf             	mov    r15d,r9d
   182ebb797:	45 89 c4             	mov    r12d,r8d
   182ebb79a:	48 89 ce             	mov    rsi,rcx
   182ebb79d:	48 b8 aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaaa
   182ebb7a4:	aa aa aa 
   182ebb7a7:	48 89 85 70 02 00 00 	mov    QWORD PTR [rbp+0x270],rax
   182ebb7ae:	0f 28 3d fb b3 05 06 	movaps xmm7,XMMWORD PTR [rip+0x605b3fb]        # 0x188f16bb0
   182ebb7b5:	0f 29 bd 60 02 00 00 	movaps XMMWORD PTR [rbp+0x260],xmm7
   182ebb7bc:	0f 29 bd 50 02 00 00 	movaps XMMWORD PTR [rbp+0x250],xmm7
   182ebb7c3:	0f 29 bd 40 02 00 00 	movaps XMMWORD PTR [rbp+0x240],xmm7
   182ebb7ca:	0f 29 bd 30 02 00 00 	movaps XMMWORD PTR [rbp+0x230],xmm7
   182ebb7d1:	4c 8b 71 08          	mov    r14,QWORD PTR [rcx+0x8]
   182ebb7d5:	4c 2b 31             	sub    r14,QWORD PTR [rcx]
   182ebb7d8:	48 89 95 d8 02 00 00 	mov    QWORD PTR [rbp+0x2d8],rdx
   182ebb7df:	49 c1 fe 04          	sar    r14,0x4
   182ebb7e3:	48 bf b7 6d db b6 6d 	movabs rdi,0x6db6db6db6db6db7
   182ebb7ea:	db b6 6d 
   182ebb7ed:	4c 0f af f7          	imul   r14,rdi
   182ebb7f1:	48 8d 15 d0 45 6f 06 	lea    rdx,[rip+0x66f45d0]        # 0x1895afdc8
   182ebb7f8:	4c 8d 05 21 45 6f 06 	lea    r8,[rip+0x66f4521]        # 0x1895afd20
   182ebb7ff:	48 8d 5d 10          	lea    rbx,[rbp+0x10]
   182ebb803:	48 89 d9             	mov    rcx,rbx
   182ebb806:	41 b9 12 02 00 00    	mov    r9d,0x212
   182ebb80c:	e8 df 63 2e fd       	call   0x1801a1bf0
   182ebb811:	44 88 bd 25 03 00 00 	mov    BYTE PTR [rbp+0x325],r15b
   182ebb818:	44 88 7c 24 30       	mov    BYTE PTR [rsp+0x30],r15b
   182ebb81d:	44 88 a5 27 03 00 00 	mov    BYTE PTR [rbp+0x327],r12b
   182ebb824:	44 88 64 24 28       	mov    BYTE PTR [rsp+0x28],r12b
   182ebb829:	4c 89 74 24 20       	mov    QWORD PTR [rsp+0x20],r14
   182ebb82e:	4c 8d 0d 0b 31 6f 06 	lea    r9,[rip+0x66f310b]        # 0x1895ae940
   182ebb835:	48 8d 8d 30 02 00 00 	lea    rcx,[rbp+0x230]
   182ebb83c:	ba 02 00 00 00       	mov    edx,0x2
   182ebb841:	49 89 d8             	mov    r8,rbx
   182ebb844:	e8 37 74 00 00       	call   0x182ec2c80
   182ebb849:	0f 57 c0             	xorps  xmm0,xmm0
   182ebb84c:	0f 29 85 e0 02 00 00 	movaps XMMWORD PTR [rbp+0x2e0],xmm0
   182ebb853:	48 c7 85 f0 02 00 00 	mov    QWORD PTR [rbp+0x2f0],0x0
   182ebb85a:	00 00 00 00 
   182ebb85e:	48 8b 4e 08          	mov    rcx,QWORD PTR [rsi+0x8]
   182ebb862:	48 8b 16             	mov    rdx,QWORD PTR [rsi]
   182ebb865:	48 89 c8             	mov    rax,rcx
   182ebb868:	48 29 d0             	sub    rax,rdx
   182ebb86b:	48 c1 f8 04          	sar    rax,0x4
   182ebb86f:	48 0f af c7          	imul   rax,rdi
   182ebb873:	48 89 45 10          	mov    QWORD PTR [rbp+0x10],rax
   182ebb877:	48 39 d1             	cmp    rcx,rdx
   182ebb87a:	74 24                	je     0x182ebb8a0
   182ebb87c:	48 b9 23 22 22 22 22 	movabs rcx,0x222222222222223
   182ebb883:	22 22 02 
   182ebb886:	48 39 c8             	cmp    rax,rcx
   182ebb889:	0f 83 97 0a 00 00    	jae    0x182ebc326
   182ebb88f:	48 8d 8d e0 02 00 00 	lea    rcx,[rbp+0x2e0]
   182ebb896:	48 8d 55 10          	lea    rdx,[rbp+0x10]
   182ebb89a:	e8 71 75 00 00       	call   0x182ec2e10
   182ebb89f:	90                   	nop
   182ebb8a0:	48 8d 8d e0 02 00 00 	lea    rcx,[rbp+0x2e0]
   182ebb8a7:	48 89 f2             	mov    rdx,rsi
   182ebb8aa:	44 0f b6 85 27 03 00 	movzx  r8d,BYTE PTR [rbp+0x327]
   182ebb8b1:	00 
   182ebb8b2:	e8 79 0f 00 00       	call   0x182ebc830
   182ebb8b7:	90                   	nop
   182ebb8b8:	48 8b 8d e0 02 00 00 	mov    rcx,QWORD PTR [rbp+0x2e0]
   182ebb8bf:	48 8b 95 e8 02 00 00 	mov    rdx,QWORD PTR [rbp+0x2e8]
   182ebb8c6:	4c 8d 05 03 a7 ff ff 	lea    r8,[rip+0xffffffffffffa703]        # 0x182eb5fd0
   182ebb8cd:	e8 8e 49 00 00       	call   0x182ec0260
   182ebb8d2:	90                   	nop
   182ebb8d3:	c6 85 26 03 00 00 01 	mov    BYTE PTR [rbp+0x326],0x1
   182ebb8da:	0f 57 f6             	xorps  xmm6,xmm6
   182ebb8dd:	0f 29 b5 00 03 00 00 	movaps XMMWORD PTR [rbp+0x300],xmm6
   182ebb8e4:	48 c7 85 10 03 00 00 	mov    QWORD PTR [rbp+0x310],0x0
   182ebb8eb:	00 00 00 00 
   182ebb8ef:	0f 29 bd 80 01 00 00 	movaps XMMWORD PTR [rbp+0x180],xmm7
   182ebb8f6:	0f 29 bd 70 01 00 00 	movaps XMMWORD PTR [rbp+0x170],xmm7
   182ebb8fd:	0f 29 bd 60 01 00 00 	movaps XMMWORD PTR [rbp+0x160],xmm7
   182ebb904:	0f 29 bd 50 01 00 00 	movaps XMMWORD PTR [rbp+0x150],xmm7
   182ebb90b:	0f 29 bd 40 01 00 00 	movaps XMMWORD PTR [rbp+0x140],xmm7
   182ebb912:	0f 29 bd 30 01 00 00 	movaps XMMWORD PTR [rbp+0x130],xmm7
   182ebb919:	0f 29 bd 20 01 00 00 	movaps XMMWORD PTR [rbp+0x120],xmm7
   182ebb920:	48 8d 8d 20 01 00 00 	lea    rcx,[rbp+0x120]
   182ebb927:	e8 94 62 1d fe       	call   0x181091bc0
   182ebb92c:	90                   	nop
   182ebb92d:	48 8b bd e0 02 00 00 	mov    rdi,QWORD PTR [rbp+0x2e0]
   182ebb934:	48 8b 85 e8 02 00 00 	mov    rax,QWORD PTR [rbp+0x2e8]
   182ebb93b:	48 89 85 a0 02 00 00 	mov    QWORD PTR [rbp+0x2a0],rax
   182ebb942:	48 8d b5 b8 02 00 00 	lea    rsi,[rbp+0x2b8]
   182ebb949:	4c 8d 2d 20 b9 05 06 	lea    r13,[rip+0x605b920]        # 0x188f17270
   182ebb950:	48 8b 9d d8 02 00 00 	mov    rbx,QWORD PTR [rbp+0x2d8]
   182ebb957:	eb 21                	jmp    0x182ebb97a
   182ebb959:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
   182ebb960:	48 83 c0 28          	add    rax,0x28
   182ebb964:	48 89 c2             	mov    rdx,rax
   182ebb967:	4c 89 c1             	mov    rcx,r8
   182ebb96a:	e8 b1 03 69 04       	call   0x18754bd20
   182ebb96f:	48 83 c7 78          	add    rdi,0x78
   182ebb973:	48 8d b5 b8 02 00 00 	lea    rsi,[rbp+0x2b8]
   182ebb97a:	48 3b bd a0 02 00 00 	cmp    rdi,QWORD PTR [rbp+0x2a0]
   182ebb981:	0f 84 64 07 00 00    	je     0x182ebc0eb
   182ebb987:	48 89 f1             	mov    rcx,rsi
   182ebb98a:	48 89 bd 18 03 00 00 	mov    QWORD PTR [rbp+0x318],rdi
   182ebb991:	48 89 fa             	mov    rdx,rdi
   182ebb994:	e8 37 7f c0 fd       	call   0x180ac38d0
   182ebb999:	90                   	nop
   182ebb99a:	48 89 f1             	mov    rcx,rsi
   182ebb99d:	e8 6e d2 d0 fd       	call   0x180bc8c10
   182ebb9a2:	90                   	nop
   182ebb9a3:	84 c0                	test   al,al
   182ebb9a5:	0f 84 95 01 00 00    	je     0x182ebbb40
   182ebb9ab:	b9 02 00 00 00       	mov    ecx,0x2
   182ebb9b0:	e8 2b 14 1b fd       	call   0x18006cde0
   182ebb9b5:	85 c0                	test   eax,eax
   182ebb9b7:	0f 84 c3 02 00 00    	je     0x182ebbc80
   182ebb9bd:	48 8d 8d 80 02 00 00 	lea    rcx,[rbp+0x280]
   182ebb9c4:	e8 47 15 1b fd       	call   0x18006cf10
   182ebb9c9:	90                   	nop
   182ebb9ca:	48 83 bd 98 02 00 00 	cmp    QWORD PTR [rbp+0x298],0x10
   182ebb9d1:	10 
   182ebb9d2:	4c 8d 85 80 02 00 00 	lea    r8,[rbp+0x280]
   182ebb9d9:	72 07                	jb     0x182ebb9e2
   182ebb9db:	4c 8b 85 80 02 00 00 	mov    r8,QWORD PTR [rbp+0x280]
   182ebb9e2:	48 8d 05 ef 48 6f 06 	lea    rax,[rip+0x66f48ef]        # 0x1895b02d8
   182ebb9e9:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182ebb9ee:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182ebb9f5:	00 00 
   182ebb9f7:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182ebb9fc:	c7 44 24 28 24 02 00 	mov    DWORD PTR [rsp+0x28],0x224
   182ebba03:	00 
   182ebba04:	48 8d 75 10          	lea    rsi,[rbp+0x10]
   182ebba08:	48 89 f1             	mov    rcx,rsi
   182ebba0b:	ba 02 00 00 00       	mov    edx,0x2
   182ebba10:	4c 8d 0d 09 43 6f 06 	lea    r9,[rip+0x66f4309]        # 0x1895afd20
   182ebba17:	e8 54 18 1b fd       	call   0x18006d270
   182ebba1c:	90                   	nop
   182ebba1d:	41 ba cd cc cc cc    	mov    r10d,0xcccccccd
   182ebba23:	4c 8b 9d 18 03 00 00 	mov    r11,QWORD PTR [rbp+0x318]
   182ebba2a:	41 8b 53 48          	mov    edx,DWORD PTR [r11+0x48]
   182ebba2e:	48 c7 85 e0 01 00 00 	mov    QWORD PTR [rbp+0x1e0],0x0
   182ebba35:	00 00 00 00 
   182ebba39:	b8 07 00 00 00       	mov    eax,0x7
   182ebba3e:	48 8d 8d e7 01 00 00 	lea    rcx,[rbp+0x1e7]
   182ebba45:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebba4c:	00 00 00 00 
   182ebba50:	41 89 d0             	mov    r8d,edx
   182ebba53:	4d 0f af c2          	imul   r8,r10
   182ebba57:	49 c1 e8 23          	shr    r8,0x23
   182ebba5b:	47 8d 0c 00          	lea    r9d,[r8+r8*1]
   182ebba5f:	47 8d 0c 89          	lea    r9d,[r9+r9*4]
   182ebba63:	41 f7 d9             	neg    r9d
   182ebba66:	41 01 d1             	add    r9d,edx
   182ebba69:	41 83 c1 23          	add    r9d,0x23
   182ebba6d:	47 0f b6 0c 29       	movzx  r9d,BYTE PTR [r9+r13*1]
   182ebba72:	44 88 49 01          	mov    BYTE PTR [rcx+0x1],r9b
   182ebba76:	48 ff c1             	inc    rcx
   182ebba79:	48 ff c0             	inc    rax
   182ebba7c:	83 fa 09             	cmp    edx,0x9
   182ebba7f:	44 89 c2             	mov    edx,r8d
   182ebba82:	77 cc                	ja     0x182ebba50
   182ebba84:	c6 41 01 00          	mov    BYTE PTR [rcx+0x1],0x0
   182ebba88:	48 83 f8 09          	cmp    rax,0x9
   182ebba8c:	4c 8d 95 b8 02 00 00 	lea    r10,[rbp+0x2b8]
   182ebba93:	72 25                	jb     0x182ebbaba
   182ebba95:	48 8d 85 e9 01 00 00 	lea    rax,[rbp+0x1e9]
   182ebba9c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
   182ebbaa0:	0f b6 11             	movzx  edx,BYTE PTR [rcx]
   182ebbaa3:	44 0f b6 40 ff       	movzx  r8d,BYTE PTR [rax-0x1]
   182ebbaa8:	44 88 01             	mov    BYTE PTR [rcx],r8b
   182ebbaab:	48 ff c9             	dec    rcx
   182ebbaae:	88 50 ff             	mov    BYTE PTR [rax-0x1],dl
   182ebbab1:	48 39 c8             	cmp    rax,rcx
   182ebbab4:	48 8d 40 01          	lea    rax,[rax+0x1]
   182ebbab8:	72 e6                	jb     0x182ebbaa0
   182ebbaba:	48 8d 85 e8 01 00 00 	lea    rax,[rbp+0x1e8]
   182ebbac1:	48 89 85 e0 01 00 00 	mov    QWORD PTR [rbp+0x1e0],rax
   182ebbac8:	41 8b 4b 14          	mov    ecx,DWORD PTR [r11+0x14]
   182ebbacc:	48 c7 85 90 01 00 00 	mov    QWORD PTR [rbp+0x190],0x0
   182ebbad3:	00 00 00 00 
   182ebbad7:	b8 08 00 00 00       	mov    eax,0x8
   182ebbadc:	89 ca                	mov    edx,ecx
   182ebbade:	66 90                	xchg   ax,ax
   182ebbae0:	4c 63 c2             	movsxd r8,edx
   182ebbae3:	49 69 d0 67 66 66 66 	imul   rdx,r8,0x66666667
   182ebbaea:	49 89 d1             	mov    r9,rdx
   182ebbaed:	49 c1 e9 3f          	shr    r9,0x3f
   182ebbaf1:	48 c1 fa 22          	sar    rdx,0x22
   182ebbaf5:	44 01 ca             	add    edx,r9d
   182ebbaf8:	44 8d 0c 12          	lea    r9d,[rdx+rdx*1]
   182ebbafc:	47 8d 0c 89          	lea    r9d,[r9+r9*4]
   182ebbb00:	41 f7 d9             	neg    r9d
   182ebbb03:	45 01 c1             	add    r9d,r8d
   182ebbb06:	41 83 c1 23          	add    r9d,0x23
   182ebbb0a:	4d 63 c9             	movsxd r9,r9d
   182ebbb0d:	47 0f b6 0c 29       	movzx  r9d,BYTE PTR [r9+r13*1]
   182ebbb12:	44 88 8c 05 90 01 00 	mov    BYTE PTR [rbp+rax*1+0x190],r9b
   182ebbb19:	00 
   182ebbb1a:	48 ff c0             	inc    rax
   182ebbb1d:	41 83 c0 09          	add    r8d,0x9
   182ebbb21:	41 83 f8 12          	cmp    r8d,0x12
   182ebbb25:	77 b9                	ja     0x182ebbae0
   182ebbb27:	85 c9                	test   ecx,ecx
   182ebbb29:	78 27                	js     0x182ebbb52
   182ebbb2b:	c6 84 05 90 01 00 00 	mov    BYTE PTR [rbp+rax*1+0x190],0x0
   182ebbb32:	00 
   182ebbb33:	48 83 f8 0a          	cmp    rax,0xa
   182ebbb37:	7d 32                	jge    0x182ebbb6b
   182ebbb39:	eb 5f                	jmp    0x182ebbb9a
   182ebbb3b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
   182ebbb40:	48 8d 8d b8 02 00 00 	lea    rcx,[rbp+0x2b8]
   182ebbb47:	e8 74 9f d0 fd       	call   0x180bc5ac0
   182ebbb4c:	90                   	nop
   182ebbb4d:	e9 2e 01 00 00       	jmp    0x182ebbc80
   182ebbb52:	c6 84 05 90 01 00 00 	mov    BYTE PTR [rbp+rax*1+0x190],0x2d
   182ebbb59:	2d 
   182ebbb5a:	48 ff c0             	inc    rax
   182ebbb5d:	c6 84 05 90 01 00 00 	mov    BYTE PTR [rbp+rax*1+0x190],0x0
   182ebbb64:	00 
   182ebbb65:	48 83 f8 0a          	cmp    rax,0xa
   182ebbb69:	7c 2f                	jl     0x182ebbb9a
   182ebbb6b:	48 01 e8             	add    rax,rbp
   182ebbb6e:	48 05 90 01 00 00    	add    rax,0x190
   182ebbb74:	48 ff c8             	dec    rax
   182ebbb77:	48 8d 8d 99 01 00 00 	lea    rcx,[rbp+0x199]
   182ebbb7e:	66 90                	xchg   ax,ax
   182ebbb80:	0f b6 10             	movzx  edx,BYTE PTR [rax]
   182ebbb83:	44 0f b6 41 ff       	movzx  r8d,BYTE PTR [rcx-0x1]
   182ebbb88:	44 88 00             	mov    BYTE PTR [rax],r8b
   182ebbb8b:	88 51 ff             	mov    BYTE PTR [rcx-0x1],dl
   182ebbb8e:	48 ff c8             	dec    rax
   182ebbb91:	48 39 c1             	cmp    rcx,rax
   182ebbb94:	48 8d 49 01          	lea    rcx,[rcx+0x1]
   182ebbb98:	72 e6                	jb     0x182ebbb80
   182ebbb9a:	48 8d 85 98 01 00 00 	lea    rax,[rbp+0x198]
   182ebbba1:	48 89 85 90 01 00 00 	mov    QWORD PTR [rbp+0x190],rax
   182ebbba8:	48 83 bd d0 02 00 00 	cmp    QWORD PTR [rbp+0x2d0],0x10
   182ebbbaf:	10 
   182ebbbb0:	4c 89 d0             	mov    rax,r10
   182ebbbb3:	72 07                	jb     0x182ebbbbc
   182ebbbb5:	48 8b 85 b8 02 00 00 	mov    rax,QWORD PTR [rbp+0x2b8]
   182ebbbbc:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
   182ebbbc0:	c6 45 c8 00          	mov    BYTE PTR [rbp-0x38],0x0
   182ebbbc4:	48 8d 85 b8 00 00 00 	lea    rax,[rbp+0xb8]
   182ebbbcb:	0f 11 70 50          	movups XMMWORD PTR [rax+0x50],xmm6
   182ebbbcf:	0f 11 70 40          	movups XMMWORD PTR [rax+0x40],xmm6
   182ebbbd3:	0f 11 70 30          	movups XMMWORD PTR [rax+0x30],xmm6
   182ebbbd7:	0f 11 70 20          	movups XMMWORD PTR [rax+0x20],xmm6
   182ebbbdb:	0f 11 70 10          	movups XMMWORD PTR [rax+0x10],xmm6
   182ebbbdf:	0f 11 30             	movups XMMWORD PTR [rax],xmm6
   182ebbbe2:	48 c7 40 60 00 00 00 	mov    QWORD PTR [rax+0x60],0x0
   182ebbbe9:	00 
   182ebbbea:	48 8d 45 c0          	lea    rax,[rbp-0x40]
   182ebbbee:	48 89 85 a0 00 00 00 	mov    QWORD PTR [rbp+0xa0],rax
   182ebbbf5:	48 8d 85 90 01 00 00 	lea    rax,[rbp+0x190]
   182ebbbfc:	48 89 85 a8 00 00 00 	mov    QWORD PTR [rbp+0xa8],rax
   182ebbc03:	48 8d 85 e0 01 00 00 	lea    rax,[rbp+0x1e0]
   182ebbc0a:	48 89 85 b0 00 00 00 	mov    QWORD PTR [rbp+0xb0],rax
   182ebbc11:	48 89 f1             	mov    rcx,rsi
   182ebbc14:	48 8d 15 0d 4d 6f 06 	lea    rdx,[rip+0x66f4d0d]        # 0x1895b0928
   182ebbc1b:	4c 8d 85 a0 00 00 00 	lea    r8,[rbp+0xa0]
   182ebbc22:	e8 e9 1b 1b fd       	call   0x18006d810
   182ebbc27:	90                   	nop
   182ebbc28:	48 89 f1             	mov    rcx,rsi
   182ebbc2b:	e8 40 17 1b fd       	call   0x18006d370
   182ebbc30:	48 8b 85 98 02 00 00 	mov    rax,QWORD PTR [rbp+0x298]
   182ebbc37:	48 83 f8 10          	cmp    rax,0x10
   182ebbc3b:	72 43                	jb     0x182ebbc80
   182ebbc3d:	48 8b 8d 80 02 00 00 	mov    rcx,QWORD PTR [rbp+0x280]
   182ebbc44:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182ebbc48:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182ebbc4f:	72 1f                	jb     0x182ebbc70
   182ebbc51:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182ebbc55:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182ebbc59:	4c 29 c1             	sub    rcx,r8
   182ebbc5c:	48 83 f9 20          	cmp    rcx,0x20
   182ebbc60:	0f 83 7f 04 00 00    	jae    0x182ebc0e5
   182ebbc66:	48 83 c0 28          	add    rax,0x28
   182ebbc6a:	48 89 c2             	mov    rdx,rax
   182ebbc6d:	4c 89 c1             	mov    rcx,r8
   182ebbc70:	e8 ab 00 69 04       	call   0x18754bd20
   182ebbc75:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebbc7c:	00 00 00 00 
   182ebbc80:	48 8b 95 18 03 00 00 	mov    rdx,QWORD PTR [rbp+0x318]
   182ebbc87:	8b 42 14             	mov    eax,DWORD PTR [rdx+0x14]
   182ebbc8a:	3d 12 27 00 00       	cmp    eax,0x2712
   182ebbc8f:	0f 84 3b 01 00 00    	je     0x182ebbdd0
   182ebbc95:	83 f8 33             	cmp    eax,0x33
   182ebbc98:	0f 85 82 01 00 00    	jne    0x182ebbe20
   182ebbc9e:	48 8b 4a 50          	mov    rcx,QWORD PTR [rdx+0x50]
   182ebbca2:	41 89 c9             	mov    r9d,ecx
   182ebbca5:	41 c1 e9 10          	shr    r9d,0x10
   182ebbca9:	41 89 ce             	mov    r14d,ecx
   182ebbcac:	41 c1 ee 18          	shr    r14d,0x18
   182ebbcb0:	48 89 ce             	mov    rsi,rcx
   182ebbcb3:	48 c1 ee 20          	shr    rsi,0x20
   182ebbcb7:	48 89 cf             	mov    rdi,rcx
   182ebbcba:	48 c1 ef 28          	shr    rdi,0x28
   182ebbcbe:	49 89 cb             	mov    r11,rcx
   182ebbcc1:	49 c1 eb 30          	shr    r11,0x30
   182ebbcc5:	49 89 ca             	mov    r10,rcx
   182ebbcc8:	49 c1 ea 38          	shr    r10,0x38
   182ebbccc:	0f b6 d1             	movzx  edx,cl
   182ebbccf:	48 89 95 a8 02 00 00 	mov    QWORD PTR [rbp+0x2a8],rdx
   182ebbcd6:	48 b8 25 23 22 84 e4 	movabs rax,0xcbf29ce484222325
   182ebbcdd:	9c f2 cb 
   182ebbce0:	48 31 c2             	xor    rdx,rax
   182ebbce3:	49 89 d8             	mov    r8,rbx
   182ebbce6:	48 bb b3 01 00 00 00 	movabs rbx,0x100000001b3
   182ebbced:	01 00 00 
   182ebbcf0:	48 0f af d3          	imul   rdx,rbx
   182ebbcf4:	48 89 8d b0 02 00 00 	mov    QWORD PTR [rbp+0x2b0],rcx
   182ebbcfb:	0f b6 c5             	movzx  eax,ch
   182ebbcfe:	48 31 c2             	xor    rdx,rax
   182ebbd01:	48 0f af d3          	imul   rdx,rbx
   182ebbd05:	45 0f b6 c9          	movzx  r9d,r9b
   182ebbd09:	4c 31 ca             	xor    rdx,r9
   182ebbd0c:	48 0f af d3          	imul   rdx,rbx
   182ebbd10:	4c 31 f2             	xor    rdx,r14
   182ebbd13:	48 0f af d3          	imul   rdx,rbx
   182ebbd17:	40 0f b6 f6          	movzx  esi,sil
   182ebbd1b:	48 31 f2             	xor    rdx,rsi
   182ebbd1e:	48 0f af d3          	imul   rdx,rbx
   182ebbd22:	44 0f b6 ff          	movzx  r15d,dil
   182ebbd26:	4c 31 fa             	xor    rdx,r15
   182ebbd29:	48 0f af d3          	imul   rdx,rbx
   182ebbd2d:	45 0f b6 e3          	movzx  r12d,r11b
   182ebbd31:	4c 31 e2             	xor    rdx,r12
   182ebbd34:	48 0f af d3          	imul   rdx,rbx
   182ebbd38:	4c 31 d2             	xor    rdx,r10
   182ebbd3b:	48 0f af d3          	imul   rdx,rbx
   182ebbd3f:	4c 89 c3             	mov    rbx,r8
   182ebbd42:	49 23 90 f8 00 00 00 	and    rdx,QWORD PTR [r8+0xf8]
   182ebbd49:	4d 8b 90 d0 00 00 00 	mov    r10,QWORD PTR [r8+0xd0]
   182ebbd50:	49 8b b8 e0 00 00 00 	mov    rdi,QWORD PTR [r8+0xe0]
   182ebbd57:	48 c1 e2 04          	shl    rdx,0x4
   182ebbd5b:	4c 8b 5c 17 08       	mov    r11,QWORD PTR [rdi+rdx*1+0x8]
   182ebbd60:	4d 39 d3             	cmp    r11,r10
   182ebbd63:	0f 84 37 03 00 00    	je     0x182ebc0a0
   182ebbd69:	48 8b 9d b0 02 00 00 	mov    rbx,QWORD PTR [rbp+0x2b0]
   182ebbd70:	49 b8 00 00 00 00 00 	movabs r8,0xff00000000000000
   182ebbd77:	00 00 ff 
   182ebbd7a:	4c 21 c3             	and    rbx,r8
   182ebbd7d:	49 c1 e4 30          	shl    r12,0x30
   182ebbd81:	49 09 dc             	or     r12,rbx
   182ebbd84:	49 c1 e7 28          	shl    r15,0x28
   182ebbd88:	4d 09 e7             	or     r15,r12
   182ebbd8b:	48 c1 e6 20          	shl    rsi,0x20
   182ebbd8f:	4c 09 fe             	or     rsi,r15
   182ebbd92:	41 c1 e6 18          	shl    r14d,0x18
   182ebbd96:	49 09 f6             	or     r14,rsi
   182ebbd99:	41 c1 e1 10          	shl    r9d,0x10
   182ebbd9d:	4d 09 f1             	or     r9,r14
   182ebbda0:	c1 e0 08             	shl    eax,0x8
   182ebbda3:	4c 09 c8             	or     rax,r9
   182ebbda6:	48 0b 85 a8 02 00 00 	or     rax,QWORD PTR [rbp+0x2a8]
   182ebbdad:	49 3b 43 10          	cmp    rax,QWORD PTR [r11+0x10]
   182ebbdb1:	0f 85 ba 00 00 00    	jne    0x182ebbe71
   182ebbdb7:	48 8b 9d d8 02 00 00 	mov    rbx,QWORD PTR [rbp+0x2d8]
   182ebbdbe:	e9 d0 00 00 00       	jmp    0x182ebbe93
   182ebbdc3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebbdca:	84 00 00 00 00 00 
   182ebbdd0:	48 8b 85 00 03 00 00 	mov    rax,QWORD PTR [rbp+0x300]
   182ebbdd7:	48 3b 85 08 03 00 00 	cmp    rax,QWORD PTR [rbp+0x308]
   182ebbdde:	74 24                	je     0x182ebbe04
   182ebbde0:	48 8d 8d 00 03 00 00 	lea    rcx,[rbp+0x300]
   182ebbde7:	48 8d 95 26 03 00 00 	lea    rdx,[rbp+0x326]
   182ebbdee:	44 0f b6 85 27 03 00 	movzx  r8d,BYTE PTR [rbp+0x327]
   182ebbdf5:	00 
   182ebbdf6:	44 0f b6 8d 25 03 00 	movzx  r9d,BYTE PTR [rbp+0x325]
   182ebbdfd:	00 
   182ebbdfe:	e8 dd 45 00 00       	call   0x182ec03e0
   182ebbe03:	90                   	nop
   182ebbe04:	48 8b 8d 18 03 00 00 	mov    rcx,QWORD PTR [rbp+0x318]
   182ebbe0b:	e8 70 4d 77 02       	call   0x185630b80
   182ebbe10:	90                   	nop
   182ebbe11:	e9 8a 02 00 00       	jmp    0x182ebc0a0
   182ebbe16:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
   182ebbe1d:	00 00 00 
   182ebbe20:	48 89 d9             	mov    rcx,rbx
   182ebbe23:	e8 98 a6 ff ff       	call   0x182eb64c0
   182ebbe28:	90                   	nop
   182ebbe29:	84 c0                	test   al,al
   182ebbe2b:	0f 85 6f 02 00 00    	jne    0x182ebc0a0
   182ebbe31:	48 8b b5 08 03 00 00 	mov    rsi,QWORD PTR [rbp+0x308]
   182ebbe38:	48 3b b5 10 03 00 00 	cmp    rsi,QWORD PTR [rbp+0x310]
   182ebbe3f:	0f 84 bf 00 00 00    	je     0x182ebbf04
   182ebbe45:	48 89 f1             	mov    rcx,rsi
   182ebbe48:	48 8b 95 18 03 00 00 	mov    rdx,QWORD PTR [rbp+0x318]
   182ebbe4f:	e8 3c 83 1d fe       	call   0x181094190
   182ebbe54:	90                   	nop
   182ebbe55:	48 8b 85 18 03 00 00 	mov    rax,QWORD PTR [rbp+0x318]
   182ebbe5c:	48 8b 40 70          	mov    rax,QWORD PTR [rax+0x70]
   182ebbe60:	48 89 46 70          	mov    QWORD PTR [rsi+0x70],rax
   182ebbe64:	48 83 85 08 03 00 00 	add    QWORD PTR [rbp+0x308],0x78
   182ebbe6b:	78 
   182ebbe6c:	e9 2f 02 00 00       	jmp    0x182ebc0a0
   182ebbe71:	48 8b 0c 17          	mov    rcx,QWORD PTR [rdi+rdx*1]
   182ebbe75:	48 8b 9d d8 02 00 00 	mov    rbx,QWORD PTR [rbp+0x2d8]
   182ebbe7c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
   182ebbe80:	49 39 cb             	cmp    r11,rcx
   182ebbe83:	0f 84 17 02 00 00    	je     0x182ebc0a0
   182ebbe89:	4d 8b 5b 08          	mov    r11,QWORD PTR [r11+0x8]
   182ebbe8d:	49 3b 43 10          	cmp    rax,QWORD PTR [r11+0x10]
   182ebbe91:	75 ed                	jne    0x182ebbe80
   182ebbe93:	4d 85 db             	test   r11,r11
   182ebbe96:	0f 84 04 02 00 00    	je     0x182ebc0a0
   182ebbe9c:	4d 39 d3             	cmp    r11,r10
   182ebbe9f:	0f 84 fb 01 00 00    	je     0x182ebc0a0
   182ebbea5:	41 8b 43 18          	mov    eax,DWORD PTR [r11+0x18]
   182ebbea9:	83 f8 05             	cmp    eax,0x5
   182ebbeac:	77 72                	ja     0x182ebbf20
   182ebbeae:	b9 26 00 00 00       	mov    ecx,0x26
   182ebbeb3:	0f a3 c1             	bt     ecx,eax
   182ebbeb6:	73 68                	jae    0x182ebbf20
   182ebbeb8:	48 83 bd d0 02 00 00 	cmp    QWORD PTR [rbp+0x2d0],0x10
   182ebbebf:	10 
   182ebbec0:	4c 8d bd b8 02 00 00 	lea    r15,[rbp+0x2b8]
   182ebbec7:	72 07                	jb     0x182ebbed0
   182ebbec9:	4c 8b bd b8 02 00 00 	mov    r15,QWORD PTR [rbp+0x2b8]
   182ebbed0:	4c 8b b5 c8 02 00 00 	mov    r14,QWORD PTR [rbp+0x2c8]
   182ebbed7:	48 b9 25 23 22 84 e4 	movabs rcx,0xcbf29ce484222325
   182ebbede:	9c f2 cb 
   182ebbee1:	4d 85 f6             	test   r14,r14
   182ebbee4:	49 bb b3 01 00 00 00 	movabs r11,0x100000001b3
   182ebbeeb:	01 00 00 
   182ebbeee:	0f 84 b0 00 00 00    	je     0x182ebbfa4
   182ebbef4:	44 89 f0             	mov    eax,r14d
   182ebbef7:	83 e0 03             	and    eax,0x3
   182ebbefa:	49 83 fe 04          	cmp    r14,0x4
   182ebbefe:	73 32                	jae    0x182ebbf32
   182ebbf00:	31 d2                	xor    edx,edx
   182ebbf02:	eb 7d                	jmp    0x182ebbf81
   182ebbf04:	48 8d 8d 00 03 00 00 	lea    rcx,[rbp+0x300]
   182ebbf0b:	48 89 f2             	mov    rdx,rsi
   182ebbf0e:	4c 8b 85 18 03 00 00 	mov    r8,QWORD PTR [rbp+0x318]
   182ebbf15:	e8 86 49 00 00       	call   0x182ec08a0
   182ebbf1a:	90                   	nop
   182ebbf1b:	e9 80 01 00 00       	jmp    0x182ebc0a0
   182ebbf20:	48 8b 8d 18 03 00 00 	mov    rcx,QWORD PTR [rbp+0x318]
   182ebbf27:	e8 64 53 bc ff       	call   0x182a81290
   182ebbf2c:	90                   	nop
   182ebbf2d:	e9 6e 01 00 00       	jmp    0x182ebc0a0
   182ebbf32:	4d 89 f0             	mov    r8,r14
   182ebbf35:	49 83 e0 fc          	and    r8,0xfffffffffffffffc
   182ebbf39:	31 d2                	xor    edx,edx
   182ebbf3b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
   182ebbf40:	45 0f b6 0c 17       	movzx  r9d,BYTE PTR [r15+rdx*1]
   182ebbf45:	4c 31 c9             	xor    rcx,r9
   182ebbf48:	49 0f af cb          	imul   rcx,r11
   182ebbf4c:	45 0f b6 4c 17 01    	movzx  r9d,BYTE PTR [r15+rdx*1+0x1]
   182ebbf52:	49 31 c9             	xor    r9,rcx
   182ebbf55:	4d 0f af cb          	imul   r9,r11
   182ebbf59:	45 0f b6 54 17 02    	movzx  r10d,BYTE PTR [r15+rdx*1+0x2]
   182ebbf5f:	4d 31 ca             	xor    r10,r9
   182ebbf62:	4d 0f af d3          	imul   r10,r11
   182ebbf66:	41 0f b6 4c 17 03    	movzx  ecx,BYTE PTR [r15+rdx*1+0x3]
   182ebbf6c:	4c 31 d1             	xor    rcx,r10
   182ebbf6f:	49 0f af cb          	imul   rcx,r11
   182ebbf73:	48 83 c2 04          	add    rdx,0x4
   182ebbf77:	49 39 d0             	cmp    r8,rdx
   182ebbf7a:	75 c4                	jne    0x182ebbf40
   182ebbf7c:	48 85 c0             	test   rax,rax
   182ebbf7f:	74 23                	je     0x182ebbfa4
   182ebbf81:	4c 01 fa             	add    rdx,r15
   182ebbf84:	45 31 c0             	xor    r8d,r8d
   182ebbf87:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
   182ebbf8e:	00 00 
   182ebbf90:	46 0f b6 0c 02       	movzx  r9d,BYTE PTR [rdx+r8*1]
   182ebbf95:	4c 31 c9             	xor    rcx,r9
   182ebbf98:	49 0f af cb          	imul   rcx,r11
   182ebbf9c:	49 ff c0             	inc    r8
   182ebbf9f:	4c 39 c0             	cmp    rax,r8
   182ebbfa2:	75 ec                	jne    0x182ebbf90
   182ebbfa4:	48 23 8b b8 00 00 00 	and    rcx,QWORD PTR [rbx+0xb8]
   182ebbfab:	4c 8b a3 90 00 00 00 	mov    r12,QWORD PTR [rbx+0x90]
   182ebbfb2:	48 8b 83 a0 00 00 00 	mov    rax,QWORD PTR [rbx+0xa0]
   182ebbfb9:	48 c1 e1 04          	shl    rcx,0x4
   182ebbfbd:	48 8b 7c 08 08       	mov    rdi,QWORD PTR [rax+rcx*1+0x8]
   182ebbfc2:	4c 39 e7             	cmp    rdi,r12
   182ebbfc5:	0f 84 d5 00 00 00    	je     0x182ebc0a0
   182ebbfcb:	48 8b 34 08          	mov    rsi,QWORD PTR [rax+rcx*1]
   182ebbfcf:	4d 85 f6             	test   r14,r14
   182ebbfd2:	74 60                	je     0x182ebc034
   182ebbfd4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebbfdb:	00 00 00 00 00 
   182ebbfe0:	4c 3b 77 20          	cmp    r14,QWORD PTR [rdi+0x20]
   182ebbfe4:	75 2d                	jne    0x182ebc013
   182ebbfe6:	48 83 7f 28 10       	cmp    QWORD PTR [rdi+0x28],0x10
   182ebbfeb:	72 13                	jb     0x182ebc000
   182ebbfed:	48 8b 57 10          	mov    rdx,QWORD PTR [rdi+0x10]
   182ebbff1:	eb 11                	jmp    0x182ebc004
   182ebbff3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebbffa:	84 00 00 00 00 00 
   182ebc000:	48 8d 57 10          	lea    rdx,[rdi+0x10]
   182ebc004:	4c 89 f9             	mov    rcx,r15
   182ebc007:	4d 89 f0             	mov    r8,r14
   182ebc00a:	e8 31 8d 85 04       	call   0x187714d40
   182ebc00f:	85 c0                	test   eax,eax
   182ebc011:	74 2f                	je     0x182ebc042
   182ebc013:	48 39 f7             	cmp    rdi,rsi
   182ebc016:	0f 84 84 00 00 00    	je     0x182ebc0a0
   182ebc01c:	48 8b 7f 08          	mov    rdi,QWORD PTR [rdi+0x8]
   182ebc020:	4c 3b 77 20          	cmp    r14,QWORD PTR [rdi+0x20]
   182ebc024:	74 c0                	je     0x182ebbfe6
   182ebc026:	eb eb                	jmp    0x182ebc013
   182ebc028:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
   182ebc02f:	00 
   182ebc030:	48 8b 7f 08          	mov    rdi,QWORD PTR [rdi+0x8]
   182ebc034:	48 83 7f 20 00       	cmp    QWORD PTR [rdi+0x20],0x0
   182ebc039:	74 07                	je     0x182ebc042
   182ebc03b:	48 39 f7             	cmp    rdi,rsi
   182ebc03e:	75 f0                	jne    0x182ebc030
   182ebc040:	eb 5e                	jmp    0x182ebc0a0
   182ebc042:	48 85 ff             	test   rdi,rdi
   182ebc045:	74 59                	je     0x182ebc0a0
   182ebc047:	4c 39 e7             	cmp    rdi,r12
   182ebc04a:	74 54                	je     0x182ebc0a0
   182ebc04c:	48 8b 85 b0 02 00 00 	mov    rax,QWORD PTR [rbp+0x2b0]
   182ebc053:	48 3b 47 30          	cmp    rax,QWORD PTR [rdi+0x30]
   182ebc057:	75 47                	jne    0x182ebc0a0
   182ebc059:	48 8b 85 00 03 00 00 	mov    rax,QWORD PTR [rbp+0x300]
   182ebc060:	48 3b 85 08 03 00 00 	cmp    rax,QWORD PTR [rbp+0x308]
   182ebc067:	74 24                	je     0x182ebc08d
   182ebc069:	48 8d 8d 00 03 00 00 	lea    rcx,[rbp+0x300]
   182ebc070:	48 8d 95 26 03 00 00 	lea    rdx,[rbp+0x326]
   182ebc077:	44 0f b6 85 27 03 00 	movzx  r8d,BYTE PTR [rbp+0x327]
   182ebc07e:	00 
   182ebc07f:	44 0f b6 8d 25 03 00 	movzx  r9d,BYTE PTR [rbp+0x325]
   182ebc086:	00 
   182ebc087:	e8 54 43 00 00       	call   0x182ec03e0
   182ebc08c:	90                   	nop
   182ebc08d:	48 8b 8d 18 03 00 00 	mov    rcx,QWORD PTR [rbp+0x318]
   182ebc094:	e8 f7 51 bc ff       	call   0x182a81290
   182ebc099:	90                   	nop
   182ebc09a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
   182ebc0a0:	48 8b 85 d0 02 00 00 	mov    rax,QWORD PTR [rbp+0x2d0]
   182ebc0a7:	48 83 f8 10          	cmp    rax,0x10
   182ebc0ab:	48 8b bd 18 03 00 00 	mov    rdi,QWORD PTR [rbp+0x318]
   182ebc0b2:	0f 82 b7 f8 ff ff    	jb     0x182ebb96f
   182ebc0b8:	48 8b 8d b8 02 00 00 	mov    rcx,QWORD PTR [rbp+0x2b8]
   182ebc0bf:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182ebc0c3:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182ebc0ca:	0f 82 9a f8 ff ff    	jb     0x182ebb96a
   182ebc0d0:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182ebc0d4:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182ebc0d8:	4c 29 c1             	sub    rcx,r8
   182ebc0db:	48 83 f9 20          	cmp    rcx,0x20
   182ebc0df:	0f 82 7b f8 ff ff    	jb     0x182ebb960
   182ebc0e5:	e8 a2 20 82 04       	call   0x1876de18c
   182ebc0ea:	90                   	nop
   182ebc0eb:	48 8d 8d 00 03 00 00 	lea    rcx,[rbp+0x300]
   182ebc0f2:	48 8d 95 26 03 00 00 	lea    rdx,[rbp+0x326]
   182ebc0f9:	44 0f b6 85 27 03 00 	movzx  r8d,BYTE PTR [rbp+0x327]
   182ebc100:	00 
   182ebc101:	44 0f b6 8d 25 03 00 	movzx  r9d,BYTE PTR [rbp+0x325]
   182ebc108:	00 
   182ebc109:	e8 d2 42 00 00       	call   0x182ec03e0
   182ebc10e:	90                   	nop
   182ebc10f:	48 8d 8d e0 01 00 00 	lea    rcx,[rbp+0x1e0]
   182ebc116:	e8 05 b1 18 fd       	call   0x180047220
   182ebc11b:	90                   	nop
   182ebc11c:	48 8b 8d e0 01 00 00 	mov    rcx,QWORD PTR [rbp+0x1e0]
   182ebc123:	48 8d 95 a0 00 00 00 	lea    rdx,[rbp+0xa0]
   182ebc12a:	e8 a1 62 4c fd       	call   0x1803823d0
   182ebc12f:	90                   	nop
   182ebc130:	48 8b 8d a0 00 00 00 	mov    rcx,QWORD PTR [rbp+0xa0]
   182ebc137:	48 8d 55 10          	lea    rdx,[rbp+0x10]
   182ebc13b:	e8 30 02 8c fe       	call   0x18177c370
   182ebc140:	90                   	nop
   182ebc141:	48 8b 4d 10          	mov    rcx,QWORD PTR [rbp+0x10]
   182ebc145:	e8 f6 21 9d 00       	call   0x18388e340
   182ebc14a:	90                   	nop
   182ebc14b:	48 8b 75 18          	mov    rsi,QWORD PTR [rbp+0x18]
   182ebc14f:	48 85 f6             	test   rsi,rsi
   182ebc152:	74 1d                	je     0x182ebc171
   182ebc154:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182ebc158:	75 17                	jne    0x182ebc171
   182ebc15a:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebc15d:	48 89 f1             	mov    rcx,rsi
   182ebc160:	ff 10                	call   QWORD PTR [rax]
   182ebc162:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182ebc166:	75 09                	jne    0x182ebc171
   182ebc168:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebc16b:	48 89 f1             	mov    rcx,rsi
   182ebc16e:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182ebc171:	48 8b b5 a8 00 00 00 	mov    rsi,QWORD PTR [rbp+0xa8]
   182ebc178:	48 85 f6             	test   rsi,rsi
   182ebc17b:	74 1d                	je     0x182ebc19a
   182ebc17d:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182ebc181:	75 17                	jne    0x182ebc19a
   182ebc183:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebc186:	48 89 f1             	mov    rcx,rsi
   182ebc189:	ff 10                	call   QWORD PTR [rax]
   182ebc18b:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182ebc18f:	75 09                	jne    0x182ebc19a
   182ebc191:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebc194:	48 89 f1             	mov    rcx,rsi
   182ebc197:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182ebc19a:	48 8b b5 e8 01 00 00 	mov    rsi,QWORD PTR [rbp+0x1e8]
   182ebc1a1:	48 85 f6             	test   rsi,rsi
   182ebc1a4:	74 1d                	je     0x182ebc1c3
   182ebc1a6:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182ebc1aa:	75 17                	jne    0x182ebc1c3
   182ebc1ac:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebc1af:	48 89 f1             	mov    rcx,rsi
   182ebc1b2:	ff 10                	call   QWORD PTR [rax]
   182ebc1b4:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182ebc1b8:	75 09                	jne    0x182ebc1c3
   182ebc1ba:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebc1bd:	48 89 f1             	mov    rcx,rsi
   182ebc1c0:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182ebc1c3:	0f b6 9d 26 03 00 00 	movzx  ebx,BYTE PTR [rbp+0x326]
   182ebc1ca:	48 8d 8d 20 01 00 00 	lea    rcx,[rbp+0x120]
   182ebc1d1:	e8 1a 86 1d fe       	call   0x1810947f0
   182ebc1d6:	48 8b b5 00 03 00 00 	mov    rsi,QWORD PTR [rbp+0x300]
   182ebc1dd:	48 85 f6             	test   rsi,rsi
   182ebc1e0:	74 5d                	je     0x182ebc23f
   182ebc1e2:	48 8b bd 08 03 00 00 	mov    rdi,QWORD PTR [rbp+0x308]
   182ebc1e9:	48 39 fe             	cmp    rsi,rdi
   182ebc1ec:	74 1a                	je     0x182ebc208
   182ebc1ee:	66 90                	xchg   ax,ax
   182ebc1f0:	48 89 f1             	mov    rcx,rsi
   182ebc1f3:	e8 f8 85 1d fe       	call   0x1810947f0
   182ebc1f8:	48 83 c6 78          	add    rsi,0x78
   182ebc1fc:	48 39 fe             	cmp    rsi,rdi
   182ebc1ff:	75 ef                	jne    0x182ebc1f0
   182ebc201:	48 8b b5 00 03 00 00 	mov    rsi,QWORD PTR [rbp+0x300]
   182ebc208:	48 8b 95 10 03 00 00 	mov    rdx,QWORD PTR [rbp+0x310]
   182ebc20f:	48 29 f2             	sub    rdx,rsi
   182ebc212:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182ebc219:	72 1c                	jb     0x182ebc237
   182ebc21b:	48 8b 46 f8          	mov    rax,QWORD PTR [rsi-0x8]
   182ebc21f:	48 83 c6 f8          	add    rsi,0xfffffffffffffff8
   182ebc223:	48 29 c6             	sub    rsi,rax
   182ebc226:	48 83 fe 20          	cmp    rsi,0x20
   182ebc22a:	0f 83 b5 fe ff ff    	jae    0x182ebc0e5
   182ebc230:	48 83 c2 27          	add    rdx,0x27
   182ebc234:	48 89 c6             	mov    rsi,rax
   182ebc237:	48 89 f1             	mov    rcx,rsi
   182ebc23a:	e8 e1 fa 68 04       	call   0x18754bd20
   182ebc23f:	48 8b b5 e0 02 00 00 	mov    rsi,QWORD PTR [rbp+0x2e0]
   182ebc246:	48 85 f6             	test   rsi,rsi
   182ebc249:	74 65                	je     0x182ebc2b0
   182ebc24b:	48 8b bd e8 02 00 00 	mov    rdi,QWORD PTR [rbp+0x2e8]
   182ebc252:	48 39 fe             	cmp    rsi,rdi
   182ebc255:	74 21                	je     0x182ebc278
   182ebc257:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
   182ebc25e:	00 00 
   182ebc260:	48 89 f1             	mov    rcx,rsi
   182ebc263:	e8 88 85 1d fe       	call   0x1810947f0
   182ebc268:	48 83 c6 78          	add    rsi,0x78
   182ebc26c:	48 39 fe             	cmp    rsi,rdi
   182ebc26f:	75 ef                	jne    0x182ebc260
   182ebc271:	48 8b b5 e0 02 00 00 	mov    rsi,QWORD PTR [rbp+0x2e0]
   182ebc278:	48 8b 95 f0 02 00 00 	mov    rdx,QWORD PTR [rbp+0x2f0]
   182ebc27f:	48 29 f2             	sub    rdx,rsi
   182ebc282:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182ebc289:	72 1c                	jb     0x182ebc2a7
   182ebc28b:	48 8b 46 f8          	mov    rax,QWORD PTR [rsi-0x8]
   182ebc28f:	48 83 c6 f8          	add    rsi,0xfffffffffffffff8
   182ebc293:	48 29 c6             	sub    rsi,rax
   182ebc296:	48 83 fe 20          	cmp    rsi,0x20
   182ebc29a:	0f 83 45 fe ff ff    	jae    0x182ebc0e5
   182ebc2a0:	48 83 c2 27          	add    rdx,0x27
   182ebc2a4:	48 89 c6             	mov    rsi,rax
   182ebc2a7:	48 89 f1             	mov    rcx,rsi
   182ebc2aa:	e8 71 fa 68 04       	call   0x18754bd20
   182ebc2af:	90                   	nop
   182ebc2b0:	48 8d 8d 30 02 00 00 	lea    rcx,[rbp+0x230]
   182ebc2b7:	e8 b4 29 4f fd       	call   0x1803aec70
   182ebc2bc:	90                   	nop
   182ebc2bd:	48 8b 85 70 02 00 00 	mov    rax,QWORD PTR [rbp+0x270]
   182ebc2c4:	48 83 f8 10          	cmp    rax,0x10
   182ebc2c8:	72 38                	jb     0x182ebc302
   182ebc2ca:	48 8b 8d 58 02 00 00 	mov    rcx,QWORD PTR [rbp+0x258]
   182ebc2d1:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182ebc2d5:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182ebc2dc:	72 1f                	jb     0x182ebc2fd
   182ebc2de:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182ebc2e2:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182ebc2e6:	4c 29 c1             	sub    rcx,r8
   182ebc2e9:	48 83 f9 20          	cmp    rcx,0x20
   182ebc2ed:	0f 83 f2 fd ff ff    	jae    0x182ebc0e5
   182ebc2f3:	48 83 c0 28          	add    rax,0x28
   182ebc2f7:	48 89 c2             	mov    rdx,rax
   182ebc2fa:	4c 89 c1             	mov    rcx,r8
   182ebc2fd:	e8 1e fa 68 04       	call   0x18754bd20
   182ebc302:	89 d8                	mov    eax,ebx
   182ebc304:	0f 28 b5 30 03 00 00 	movaps xmm6,XMMWORD PTR [rbp+0x330]
   182ebc30b:	0f 28 bd 40 03 00 00 	movaps xmm7,XMMWORD PTR [rbp+0x340]
   182ebc312:	48 81 c4 d8 03 00 00 	add    rsp,0x3d8
   182ebc319:	5b                   	pop    rbx
   182ebc31a:	5f                   	pop    rdi
   182ebc31b:	5e                   	pop    rsi
   182ebc31c:	41 5c                	pop    r12
   182ebc31e:	41 5d                	pop    r13
   182ebc320:	41 5e                	pop    r14
   182ebc322:	41 5f                	pop    r15
   182ebc324:	5d                   	pop    rbp
   182ebc325:	c3                   	ret
   182ebc326:	e8 05 f4 14 fd       	call   0x18000b730
   182ebc32b:	90                   	nop
   182ebc32c:	cc                   	int3
