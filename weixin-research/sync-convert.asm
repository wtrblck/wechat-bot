
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

0000000182ebc830 <.text+0x2ebb830>:
   182ebc830:	55                   	push   rbp
   182ebc831:	41 57                	push   r15
   182ebc833:	41 56                	push   r14
   182ebc835:	41 55                	push   r13
   182ebc837:	41 54                	push   r12
   182ebc839:	56                   	push   rsi
   182ebc83a:	57                   	push   rdi
   182ebc83b:	53                   	push   rbx
   182ebc83c:	48 81 ec 48 05 00 00 	sub    rsp,0x548
   182ebc843:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   182ebc84a:	00 
   182ebc84b:	0f 29 bd b0 04 00 00 	movaps XMMWORD PTR [rbp+0x4b0],xmm7
   182ebc852:	0f 29 b5 a0 04 00 00 	movaps XMMWORD PTR [rbp+0x4a0],xmm6
   182ebc859:	48 c7 85 98 04 00 00 	mov    QWORD PTR [rbp+0x498],0xfffffffffffffffe
   182ebc860:	fe ff ff ff 
   182ebc864:	44 89 c3             	mov    ebx,r8d
   182ebc867:	48 89 d6             	mov    rsi,rdx
   182ebc86a:	49 89 ce             	mov    r14,rcx
   182ebc86d:	b9 02 00 00 00       	mov    ecx,0x2
   182ebc872:	e8 69 05 1b fd       	call   0x18006cde0
   182ebc877:	49 bc cd cc cc cc cc 	movabs r12,0xcccccccccccccccd
   182ebc87e:	cc cc cc 
   182ebc881:	85 c0                	test   eax,eax
   182ebc883:	0f 84 f5 01 00 00    	je     0x182ebca7e
   182ebc889:	48 8d bd 18 03 00 00 	lea    rdi,[rbp+0x318]
   182ebc890:	48 89 f9             	mov    rcx,rdi
   182ebc893:	e8 78 06 1b fd       	call   0x18006cf10
   182ebc898:	48 83 bd 30 03 00 00 	cmp    QWORD PTR [rbp+0x330],0x10
   182ebc89f:	10 
   182ebc8a0:	72 07                	jb     0x182ebc8a9
   182ebc8a2:	48 8b bd 18 03 00 00 	mov    rdi,QWORD PTR [rbp+0x318]
   182ebc8a9:	48 8d 05 60 3c 6f 06 	lea    rax,[rip+0x66f3c60]        # 0x1895b0510
   182ebc8b0:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182ebc8b5:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182ebc8bc:	00 00 
   182ebc8be:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182ebc8c3:	c7 44 24 28 aa 01 00 	mov    DWORD PTR [rsp+0x28],0x1aa
   182ebc8ca:	00 
   182ebc8cb:	4c 8d 0d 4e 34 6f 06 	lea    r9,[rip+0x66f344e]        # 0x1895afd20
   182ebc8d2:	48 8d 8d 80 01 00 00 	lea    rcx,[rbp+0x180]
   182ebc8d9:	ba 02 00 00 00       	mov    edx,0x2
   182ebc8de:	49 89 f8             	mov    r8,rdi
   182ebc8e1:	e8 8a 09 1b fd       	call   0x18006d270
   182ebc8e6:	90                   	nop
   182ebc8e7:	48 8d 05 c2 40 09 06 	lea    rax,[rip+0x60940c2]        # 0x188f509b0
   182ebc8ee:	48 8d 0d c3 40 09 06 	lea    rcx,[rip+0x60940c3]        # 0x188f509b8
   182ebc8f5:	84 db                	test   bl,bl
   182ebc8f7:	48 0f 45 c8          	cmovne rcx,rax
   182ebc8fb:	48 89 8d a0 02 00 00 	mov    QWORD PTR [rbp+0x2a0],rcx
   182ebc902:	c6 85 a8 02 00 00 00 	mov    BYTE PTR [rbp+0x2a8],0x0
   182ebc909:	48 8b 46 08          	mov    rax,QWORD PTR [rsi+0x8]
   182ebc90d:	48 2b 06             	sub    rax,QWORD PTR [rsi]
   182ebc910:	48 c1 f8 04          	sar    rax,0x4
   182ebc914:	48 b9 b7 6d db b6 6d 	movabs rcx,0x6db6db6db6db6db7
   182ebc91b:	db b6 6d 
   182ebc91e:	48 0f af c8          	imul   rcx,rax
   182ebc922:	48 c7 85 18 04 00 00 	mov    QWORD PTR [rbp+0x418],0x0
   182ebc929:	00 00 00 00 
   182ebc92d:	41 b9 07 00 00 00    	mov    r9d,0x7
   182ebc933:	4c 8d 85 1f 04 00 00 	lea    r8,[rbp+0x41f]
   182ebc93a:	4c 8d 15 2f a9 05 06 	lea    r10,[rip+0x605a92f]        # 0x188f17270
   182ebc941:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebc948:	0f 1f 84 00 00 00 00 
   182ebc94f:	00 
   182ebc950:	48 89 c8             	mov    rax,rcx
   182ebc953:	49 f7 e4             	mul    r12
   182ebc956:	48 c1 ea 03          	shr    rdx,0x3
   182ebc95a:	48 8d 04 12          	lea    rax,[rdx+rdx*1]
   182ebc95e:	48 8d 04 80          	lea    rax,[rax+rax*4]
   182ebc962:	4d 89 d3             	mov    r11,r10
   182ebc965:	49 29 c3             	sub    r11,rax
   182ebc968:	41 0f b6 44 0b 23    	movzx  eax,BYTE PTR [r11+rcx*1+0x23]
   182ebc96e:	41 88 40 01          	mov    BYTE PTR [r8+0x1],al
   182ebc972:	49 ff c0             	inc    r8
   182ebc975:	49 ff c1             	inc    r9
   182ebc978:	48 83 f9 09          	cmp    rcx,0x9
   182ebc97c:	48 89 d1             	mov    rcx,rdx
   182ebc97f:	77 cf                	ja     0x182ebc950
   182ebc981:	48 8d 85 20 04 00 00 	lea    rax,[rbp+0x420]
   182ebc988:	41 c6 40 01 00       	mov    BYTE PTR [r8+0x1],0x0
   182ebc98d:	49 83 f9 09          	cmp    r9,0x9
   182ebc991:	72 28                	jb     0x182ebc9bb
   182ebc993:	48 8d 8d 21 04 00 00 	lea    rcx,[rbp+0x421]
   182ebc99a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
   182ebc9a0:	41 0f b6 10          	movzx  edx,BYTE PTR [r8]
   182ebc9a4:	44 0f b6 49 ff       	movzx  r9d,BYTE PTR [rcx-0x1]
   182ebc9a9:	45 88 08             	mov    BYTE PTR [r8],r9b
   182ebc9ac:	49 ff c8             	dec    r8
   182ebc9af:	88 51 ff             	mov    BYTE PTR [rcx-0x1],dl
   182ebc9b2:	4c 39 c1             	cmp    rcx,r8
   182ebc9b5:	48 8d 49 01          	lea    rcx,[rcx+0x1]
   182ebc9b9:	72 e5                	jb     0x182ebc9a0
   182ebc9bb:	48 89 85 18 04 00 00 	mov    QWORD PTR [rbp+0x418],rax
   182ebc9c2:	0f 57 c0             	xorps  xmm0,xmm0
   182ebc9c5:	0f 11 85 08 04 00 00 	movups XMMWORD PTR [rbp+0x408],xmm0
   182ebc9cc:	0f 11 85 f8 03 00 00 	movups XMMWORD PTR [rbp+0x3f8],xmm0
   182ebc9d3:	0f 11 85 e8 03 00 00 	movups XMMWORD PTR [rbp+0x3e8],xmm0
   182ebc9da:	0f 11 85 d8 03 00 00 	movups XMMWORD PTR [rbp+0x3d8],xmm0
   182ebc9e1:	0f 11 85 c8 03 00 00 	movups XMMWORD PTR [rbp+0x3c8],xmm0
   182ebc9e8:	0f 11 85 b8 03 00 00 	movups XMMWORD PTR [rbp+0x3b8],xmm0
   182ebc9ef:	0f 11 85 a8 03 00 00 	movups XMMWORD PTR [rbp+0x3a8],xmm0
   182ebc9f6:	48 8d 85 18 04 00 00 	lea    rax,[rbp+0x418]
   182ebc9fd:	48 89 85 98 03 00 00 	mov    QWORD PTR [rbp+0x398],rax
   182ebca04:	48 8d 85 a0 02 00 00 	lea    rax,[rbp+0x2a0]
   182ebca0b:	48 89 85 a0 03 00 00 	mov    QWORD PTR [rbp+0x3a0],rax
   182ebca12:	48 8d 15 7f 3b 6f 06 	lea    rdx,[rip+0x66f3b7f]        # 0x1895b0598
   182ebca19:	48 8d 8d 80 01 00 00 	lea    rcx,[rbp+0x180]
   182ebca20:	4c 8d 85 98 03 00 00 	lea    r8,[rbp+0x398]
   182ebca27:	e8 e4 0d 1b fd       	call   0x18006d810
   182ebca2c:	90                   	nop
   182ebca2d:	48 8d 8d 80 01 00 00 	lea    rcx,[rbp+0x180]
   182ebca34:	e8 37 09 1b fd       	call   0x18006d370
   182ebca39:	48 8b 85 30 03 00 00 	mov    rax,QWORD PTR [rbp+0x330]
   182ebca40:	48 83 f8 10          	cmp    rax,0x10
   182ebca44:	72 38                	jb     0x182ebca7e
   182ebca46:	48 8b 8d 18 03 00 00 	mov    rcx,QWORD PTR [rbp+0x318]
   182ebca4d:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182ebca51:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182ebca58:	72 1f                	jb     0x182ebca79
   182ebca5a:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182ebca5e:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182ebca62:	4c 29 c1             	sub    rcx,r8
   182ebca65:	48 83 f9 20          	cmp    rcx,0x20
   182ebca69:	0f 83 16 10 00 00    	jae    0x182ebda85
   182ebca6f:	48 83 c0 28          	add    rax,0x28
   182ebca73:	48 89 c2             	mov    rdx,rax
   182ebca76:	4c 89 c1             	mov    rcx,r8
   182ebca79:	e8 a2 f2 68 04       	call   0x18754bd20
   182ebca7e:	4c 89 b5 68 04 00 00 	mov    QWORD PTR [rbp+0x468],r14
   182ebca85:	49 be 67 66 66 66 66 	movabs r14,0x6666666666666667
   182ebca8c:	66 66 66 
   182ebca8f:	84 db                	test   bl,bl
   182ebca91:	0f 84 f3 0f 00 00    	je     0x182ebda8a
   182ebca97:	c7 85 10 02 00 00 ff 	mov    DWORD PTR [rbp+0x210],0xffffffff
   182ebca9e:	ff ff ff 
   182ebcaa1:	0f 28 35 08 a1 05 06 	movaps xmm6,XMMWORD PTR [rip+0x605a108]        # 0x188f16bb0
   182ebcaa8:	0f 11 b5 14 02 00 00 	movups XMMWORD PTR [rbp+0x214],xmm6
   182ebcaaf:	0f 11 b5 24 02 00 00 	movups XMMWORD PTR [rbp+0x224],xmm6
   182ebcab6:	0f 11 b5 34 02 00 00 	movups XMMWORD PTR [rbp+0x234],xmm6
   182ebcabd:	0f 11 b5 40 02 00 00 	movups XMMWORD PTR [rbp+0x240],xmm6
   182ebcac4:	c7 85 80 01 00 00 00 	mov    DWORD PTR [rbp+0x180],0x0
   182ebcacb:	00 00 00 
   182ebcace:	48 8d 8d 10 02 00 00 	lea    rcx,[rbp+0x210]
   182ebcad5:	48 8d 95 80 01 00 00 	lea    rdx,[rbp+0x180]
   182ebcadc:	4c 8d 85 98 03 00 00 	lea    r8,[rbp+0x398]
   182ebcae3:	e8 28 cb 1f fd       	call   0x1800b9610
   182ebcae8:	48 8b 3e             	mov    rdi,QWORD PTR [rsi]
   182ebcaeb:	48 8b 46 08          	mov    rax,QWORD PTR [rsi+0x8]
   182ebcaef:	48 89 85 68 03 00 00 	mov    QWORD PTR [rbp+0x368],rax
   182ebcaf6:	0f 57 ff             	xorps  xmm7,xmm7
   182ebcaf9:	48 8d b5 a0 02 00 00 	lea    rsi,[rbp+0x2a0]
   182ebcb00:	48 8d 1d 69 a7 05 06 	lea    rbx,[rip+0x605a769]        # 0x188f17270
   182ebcb07:	41 bf cd cc cc cc    	mov    r15d,0xcccccccd
   182ebcb0d:	c7 85 90 04 00 00 00 	mov    DWORD PTR [rbp+0x490],0x0
   182ebcb14:	00 00 00 
   182ebcb17:	eb 22                	jmp    0x182ebcb3b
   182ebcb19:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
   182ebcb20:	48 83 c0 28          	add    rax,0x28
   182ebcb24:	48 89 c2             	mov    rdx,rax
   182ebcb27:	4c 89 c1             	mov    rcx,r8
   182ebcb2a:	e8 f1 f1 68 04       	call   0x18754bd20
   182ebcb2f:	48 89 f1             	mov    rcx,rsi
   182ebcb32:	e8 b9 7c 1d fe       	call   0x1810947f0
   182ebcb37:	48 83 c7 70          	add    rdi,0x70
   182ebcb3b:	48 3b bd 68 03 00 00 	cmp    rdi,QWORD PTR [rbp+0x368]
   182ebcb42:	0f 84 6b 19 00 00    	je     0x182ebe4b3
   182ebcb48:	48 b8 aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaaa
   182ebcb4f:	aa aa aa 
   182ebcb52:	48 89 85 10 03 00 00 	mov    QWORD PTR [rbp+0x310],rax
   182ebcb59:	0f 29 b5 00 03 00 00 	movaps XMMWORD PTR [rbp+0x300],xmm6
   182ebcb60:	0f 29 b5 f0 02 00 00 	movaps XMMWORD PTR [rbp+0x2f0],xmm6
   182ebcb67:	0f 29 b5 e0 02 00 00 	movaps XMMWORD PTR [rbp+0x2e0],xmm6
   182ebcb6e:	0f 29 b5 d0 02 00 00 	movaps XMMWORD PTR [rbp+0x2d0],xmm6
   182ebcb75:	0f 29 b5 c0 02 00 00 	movaps XMMWORD PTR [rbp+0x2c0],xmm6
   182ebcb7c:	0f 29 b5 b0 02 00 00 	movaps XMMWORD PTR [rbp+0x2b0],xmm6
   182ebcb83:	0f 29 b5 a0 02 00 00 	movaps XMMWORD PTR [rbp+0x2a0],xmm6
   182ebcb8a:	48 89 f1             	mov    rcx,rsi
   182ebcb8d:	48 89 fa             	mov    rdx,rdi
   182ebcb90:	e8 4b 59 bc fd       	call   0x180a824e0
   182ebcb95:	90                   	nop
   182ebcb96:	0f 29 b5 80 04 00 00 	movaps XMMWORD PTR [rbp+0x480],xmm6
   182ebcb9d:	0f 29 b5 70 04 00 00 	movaps XMMWORD PTR [rbp+0x470],xmm6
   182ebcba4:	48 89 f1             	mov    rcx,rsi
   182ebcba7:	48 8d 95 70 04 00 00 	lea    rdx,[rbp+0x470]
   182ebcbae:	e8 bd 25 00 00       	call   0x182ebf170
   182ebcbb3:	90                   	nop
   182ebcbb4:	48 89 f1             	mov    rcx,rsi
   182ebcbb7:	e8 44 28 00 00       	call   0x182ebf400
   182ebcbbc:	90                   	nop
   182ebcbbd:	84 c0                	test   al,al
   182ebcbbf:	0f 84 2b 01 00 00    	je     0x182ebccf0
   182ebcbc5:	b9 03 00 00 00       	mov    ecx,0x3
   182ebcbca:	e8 11 02 1b fd       	call   0x18006cde0
   182ebcbcf:	85 c0                	test   eax,eax
   182ebcbd1:	0f 84 70 0e 00 00    	je     0x182ebda47
   182ebcbd7:	48 8d 8d 50 02 00 00 	lea    rcx,[rbp+0x250]
   182ebcbde:	e8 2d 03 1b fd       	call   0x18006cf10
   182ebcbe3:	90                   	nop
   182ebcbe4:	48 83 bd 68 02 00 00 	cmp    QWORD PTR [rbp+0x268],0x10
   182ebcbeb:	10 
   182ebcbec:	4c 8d 85 50 02 00 00 	lea    r8,[rbp+0x250]
   182ebcbf3:	72 07                	jb     0x182ebcbfc
   182ebcbf5:	4c 8b 85 50 02 00 00 	mov    r8,QWORD PTR [rbp+0x250]
   182ebcbfc:	48 8d 05 0d 39 6f 06 	lea    rax,[rip+0x66f390d]        # 0x1895b0510
   182ebcc03:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182ebcc08:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182ebcc0f:	00 00 
   182ebcc11:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182ebcc16:	c7 44 24 28 c6 01 00 	mov    DWORD PTR [rsp+0x28],0x1c6
   182ebcc1d:	00 
   182ebcc1e:	48 8d 8d 80 01 00 00 	lea    rcx,[rbp+0x180]
   182ebcc25:	ba 03 00 00 00       	mov    edx,0x3
   182ebcc2a:	4c 8d 0d ef 30 6f 06 	lea    r9,[rip+0x66f30ef]        # 0x1895afd20
   182ebcc31:	e8 3a 06 1b fd       	call   0x18006d270
   182ebcc36:	90                   	nop
   182ebcc37:	48 83 bd 88 04 00 00 	cmp    QWORD PTR [rbp+0x488],0x10
   182ebcc3e:	10 
   182ebcc3f:	48 8d 85 70 04 00 00 	lea    rax,[rbp+0x470]
   182ebcc46:	72 07                	jb     0x182ebcc4f
   182ebcc48:	48 8b 85 70 04 00 00 	mov    rax,QWORD PTR [rbp+0x470]
   182ebcc4f:	48 89 85 18 04 00 00 	mov    QWORD PTR [rbp+0x418],rax
   182ebcc56:	c6 85 20 04 00 00 00 	mov    BYTE PTR [rbp+0x420],0x0
   182ebcc5d:	4c 8b 8d f0 02 00 00 	mov    r9,QWORD PTR [rbp+0x2f0]
   182ebcc64:	48 c7 85 18 03 00 00 	mov    QWORD PTR [rbp+0x318],0x0
   182ebcc6b:	00 00 00 00 
   182ebcc6f:	41 b8 08 00 00 00    	mov    r8d,0x8
   182ebcc75:	4c 89 c9             	mov    rcx,r9
   182ebcc78:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
   182ebcc7f:	00 
   182ebcc80:	48 89 c8             	mov    rax,rcx
   182ebcc83:	49 f7 ee             	imul   r14
   182ebcc86:	48 89 d0             	mov    rax,rdx
   182ebcc89:	48 c1 e8 3f          	shr    rax,0x3f
   182ebcc8d:	48 c1 fa 02          	sar    rdx,0x2
   182ebcc91:	48 01 c2             	add    rdx,rax
   182ebcc94:	48 8d 04 12          	lea    rax,[rdx+rdx*1]
   182ebcc98:	48 8d 04 80          	lea    rax,[rax+rax*4]
   182ebcc9c:	49 89 da             	mov    r10,rbx
   182ebcc9f:	49 29 c2             	sub    r10,rax
   182ebcca2:	41 0f b6 44 0a 23    	movzx  eax,BYTE PTR [r10+rcx*1+0x23]
   182ebcca8:	42 88 84 05 18 03 00 	mov    BYTE PTR [rbp+r8*1+0x318],al
   182ebccaf:	00 
   182ebccb0:	49 ff c0             	inc    r8
   182ebccb3:	48 83 c1 09          	add    rcx,0x9
   182ebccb7:	48 83 f9 12          	cmp    rcx,0x12
   182ebccbb:	48 89 d1             	mov    rcx,rdx
   182ebccbe:	77 c0                	ja     0x182ebcc80
   182ebccc0:	4d 85 c9             	test   r9,r9
   182ebccc3:	0f 88 08 06 00 00    	js     0x182ebd2d1
   182ebccc9:	42 c6 84 05 18 03 00 	mov    BYTE PTR [rbp+r8*1+0x318],0x0
   182ebccd0:	00 00 
   182ebccd2:	49 83 f8 0a          	cmp    r8,0xa
   182ebccd6:	0f 8d 10 06 00 00    	jge    0x182ebd2ec
   182ebccdc:	e9 39 06 00 00       	jmp    0x182ebd31a
   182ebcce1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebcce8:	0f 1f 84 00 00 00 00 
   182ebccef:	00 
   182ebccf0:	0f 29 b5 80 03 00 00 	movaps XMMWORD PTR [rbp+0x380],xmm6
   182ebccf7:	0f 29 b5 70 03 00 00 	movaps XMMWORD PTR [rbp+0x370],xmm6
   182ebccfe:	48 8d 8d 70 03 00 00 	lea    rcx,[rbp+0x370]
   182ebcd05:	48 89 f2             	mov    rdx,rsi
   182ebcd08:	e8 83 2a 00 00       	call   0x182ebf790
   182ebcd0d:	90                   	nop
   182ebcd0e:	48 89 bd d8 00 00 00 	mov    QWORD PTR [rbp+0xd8],rdi
   182ebcd15:	8b bd e8 02 00 00    	mov    edi,DWORD PTR [rbp+0x2e8]
   182ebcd1b:	48 8d 8d 18 04 00 00 	lea    rcx,[rbp+0x418]
   182ebcd22:	e8 f9 a4 18 fd       	call   0x180047220
   182ebcd27:	90                   	nop
   182ebcd28:	48 8b 8d 18 04 00 00 	mov    rcx,QWORD PTR [rbp+0x418]
   182ebcd2f:	48 8d 95 98 03 00 00 	lea    rdx,[rbp+0x398]
   182ebcd36:	e8 95 56 4c fd       	call   0x1803823d0
   182ebcd3b:	90                   	nop
   182ebcd3c:	48 8b 8d 98 03 00 00 	mov    rcx,QWORD PTR [rbp+0x398]
   182ebcd43:	48 8d 95 80 01 00 00 	lea    rdx,[rbp+0x180]
   182ebcd4a:	e8 b1 7c ff fd       	call   0x180eb4a00
   182ebcd4f:	90                   	nop
   182ebcd50:	48 8b 8d 80 01 00 00 	mov    rcx,QWORD PTR [rbp+0x180]
   182ebcd57:	48 8d 95 70 04 00 00 	lea    rdx,[rbp+0x470]
   182ebcd5e:	e8 9d 7f c1 ff       	call   0x182ad4d00
   182ebcd63:	90                   	nop
   182ebcd64:	49 89 c5             	mov    r13,rax
   182ebcd67:	48 8b b5 88 01 00 00 	mov    rsi,QWORD PTR [rbp+0x188]
   182ebcd6e:	48 85 f6             	test   rsi,rsi
   182ebcd71:	74 1d                	je     0x182ebcd90
   182ebcd73:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182ebcd77:	75 17                	jne    0x182ebcd90
   182ebcd79:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebcd7c:	48 89 f1             	mov    rcx,rsi
   182ebcd7f:	ff 10                	call   QWORD PTR [rax]
   182ebcd81:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182ebcd85:	75 09                	jne    0x182ebcd90
   182ebcd87:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebcd8a:	48 89 f1             	mov    rcx,rsi
   182ebcd8d:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182ebcd90:	48 8b b5 a0 03 00 00 	mov    rsi,QWORD PTR [rbp+0x3a0]
   182ebcd97:	48 85 f6             	test   rsi,rsi
   182ebcd9a:	74 24                	je     0x182ebcdc0
   182ebcd9c:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182ebcda0:	75 1e                	jne    0x182ebcdc0
   182ebcda2:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebcda5:	48 89 f1             	mov    rcx,rsi
   182ebcda8:	ff 10                	call   QWORD PTR [rax]
   182ebcdaa:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182ebcdae:	75 10                	jne    0x182ebcdc0
   182ebcdb0:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebcdb3:	48 89 f1             	mov    rcx,rsi
   182ebcdb6:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182ebcdb9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
   182ebcdc0:	48 8b b5 20 04 00 00 	mov    rsi,QWORD PTR [rbp+0x420]
   182ebcdc7:	48 85 f6             	test   rsi,rsi
   182ebcdca:	74 24                	je     0x182ebcdf0
   182ebcdcc:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182ebcdd0:	75 1e                	jne    0x182ebcdf0
   182ebcdd2:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebcdd5:	48 89 f1             	mov    rcx,rsi
   182ebcdd8:	ff 10                	call   QWORD PTR [rax]
   182ebcdda:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182ebcdde:	75 10                	jne    0x182ebcdf0
   182ebcde0:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebcde3:	48 89 f1             	mov    rcx,rsi
   182ebcde6:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182ebcde9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
   182ebcdf0:	f6 85 90 04 00 00 01 	test   BYTE PTR [rbp+0x490],0x1
   182ebcdf7:	0f 85 d3 02 00 00    	jne    0x182ebd0d0
   182ebcdfd:	48 69 f7 e8 03 00 00 	imul   rsi,rdi,0x3e8
   182ebce04:	4c 39 ee             	cmp    rsi,r13
   182ebce07:	0f 83 c3 02 00 00    	jae    0x182ebd0d0
   182ebce0d:	b9 03 00 00 00       	mov    ecx,0x3
   182ebce12:	e8 c9 ff 1a fd       	call   0x18006cde0
   182ebce17:	85 c0                	test   eax,eax
   182ebce19:	0f 84 82 02 00 00    	je     0x182ebd0a1
   182ebce1f:	48 8d 8d 30 01 00 00 	lea    rcx,[rbp+0x130]
   182ebce26:	e8 e5 00 1b fd       	call   0x18006cf10
   182ebce2b:	90                   	nop
   182ebce2c:	48 83 bd 48 01 00 00 	cmp    QWORD PTR [rbp+0x148],0x10
   182ebce33:	10 
   182ebce34:	4c 8d 85 30 01 00 00 	lea    r8,[rbp+0x130]
   182ebce3b:	72 07                	jb     0x182ebce44
   182ebce3d:	4c 8b 85 30 01 00 00 	mov    r8,QWORD PTR [rbp+0x130]
   182ebce44:	48 8d 05 c5 36 6f 06 	lea    rax,[rip+0x66f36c5]        # 0x1895b0510
   182ebce4b:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182ebce50:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182ebce57:	00 00 
   182ebce59:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182ebce5e:	c7 44 24 28 d1 01 00 	mov    DWORD PTR [rsp+0x28],0x1d1
   182ebce65:	00 
   182ebce66:	48 8d 8d 80 01 00 00 	lea    rcx,[rbp+0x180]
   182ebce6d:	ba 03 00 00 00       	mov    edx,0x3
   182ebce72:	4c 8d 0d a7 2e 6f 06 	lea    r9,[rip+0x66f2ea7]        # 0x1895afd20
   182ebce79:	e8 f2 03 1b fd       	call   0x18006d270
   182ebce7e:	90                   	nop
   182ebce7f:	48 83 bd 88 03 00 00 	cmp    QWORD PTR [rbp+0x388],0x10
   182ebce86:	10 
   182ebce87:	48 8d 85 70 03 00 00 	lea    rax,[rbp+0x370]
   182ebce8e:	72 07                	jb     0x182ebce97
   182ebce90:	48 8b 85 70 03 00 00 	mov    rax,QWORD PTR [rbp+0x370]
   182ebce97:	48 89 85 18 04 00 00 	mov    QWORD PTR [rbp+0x418],rax
   182ebce9e:	c6 85 20 04 00 00 00 	mov    BYTE PTR [rbp+0x420],0x0
   182ebcea5:	48 83 bd 88 04 00 00 	cmp    QWORD PTR [rbp+0x488],0x10
   182ebceac:	10 
   182ebcead:	48 8d 85 70 04 00 00 	lea    rax,[rbp+0x470]
   182ebceb4:	72 07                	jb     0x182ebcebd
   182ebceb6:	48 8b 85 70 04 00 00 	mov    rax,QWORD PTR [rbp+0x470]
   182ebcebd:	48 89 85 18 03 00 00 	mov    QWORD PTR [rbp+0x318],rax
   182ebcec4:	c6 85 20 03 00 00 00 	mov    BYTE PTR [rbp+0x320],0x0
   182ebcecb:	48 c7 85 50 02 00 00 	mov    QWORD PTR [rbp+0x250],0x0
   182ebced2:	00 00 00 00 
   182ebced6:	41 b8 07 00 00 00    	mov    r8d,0x7
   182ebcedc:	48 8d 8d 57 02 00 00 	lea    rcx,[rbp+0x257]
   182ebcee3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebceea:	84 00 00 00 00 00 
   182ebcef0:	4c 89 e8             	mov    rax,r13
   182ebcef3:	49 f7 e4             	mul    r12
   182ebcef6:	48 c1 ea 03          	shr    rdx,0x3
   182ebcefa:	48 8d 04 12          	lea    rax,[rdx+rdx*1]
   182ebcefe:	48 8d 04 80          	lea    rax,[rax+rax*4]
   182ebcf02:	49 89 d9             	mov    r9,rbx
   182ebcf05:	49 29 c1             	sub    r9,rax
   182ebcf08:	43 0f b6 44 29 23    	movzx  eax,BYTE PTR [r9+r13*1+0x23]
   182ebcf0e:	88 41 01             	mov    BYTE PTR [rcx+0x1],al
   182ebcf11:	48 ff c1             	inc    rcx
   182ebcf14:	49 ff c0             	inc    r8
   182ebcf17:	49 83 fd 09          	cmp    r13,0x9
   182ebcf1b:	49 89 d5             	mov    r13,rdx
   182ebcf1e:	77 d0                	ja     0x182ebcef0
   182ebcf20:	c6 41 01 00          	mov    BYTE PTR [rcx+0x1],0x0
   182ebcf24:	49 83 f8 09          	cmp    r8,0x9
   182ebcf28:	72 30                	jb     0x182ebcf5a
   182ebcf2a:	48 8d 85 59 02 00 00 	lea    rax,[rbp+0x259]
   182ebcf31:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebcf38:	0f 1f 84 00 00 00 00 
   182ebcf3f:	00 
   182ebcf40:	0f b6 11             	movzx  edx,BYTE PTR [rcx]
   182ebcf43:	44 0f b6 40 ff       	movzx  r8d,BYTE PTR [rax-0x1]
   182ebcf48:	44 88 01             	mov    BYTE PTR [rcx],r8b
   182ebcf4b:	48 ff c9             	dec    rcx
   182ebcf4e:	88 50 ff             	mov    BYTE PTR [rax-0x1],dl
   182ebcf51:	48 39 c8             	cmp    rax,rcx
   182ebcf54:	48 8d 40 01          	lea    rax,[rax+0x1]
   182ebcf58:	72 e6                	jb     0x182ebcf40
   182ebcf5a:	48 8d 85 58 02 00 00 	lea    rax,[rbp+0x258]
   182ebcf61:	48 89 85 50 02 00 00 	mov    QWORD PTR [rbp+0x250],rax
   182ebcf68:	48 c7 45 18 00 00 00 	mov    QWORD PTR [rbp+0x18],0x0
   182ebcf6f:	00 
   182ebcf70:	41 b9 07 00 00 00    	mov    r9d,0x7
   182ebcf76:	4c 8d 45 1f          	lea    r8,[rbp+0x1f]
   182ebcf7a:	48 89 f1             	mov    rcx,rsi
   182ebcf7d:	0f 1f 00             	nop    DWORD PTR [rax]
   182ebcf80:	48 89 c8             	mov    rax,rcx
   182ebcf83:	49 f7 e4             	mul    r12
   182ebcf86:	48 c1 ea 03          	shr    rdx,0x3
   182ebcf8a:	48 8d 04 12          	lea    rax,[rdx+rdx*1]
   182ebcf8e:	48 8d 04 80          	lea    rax,[rax+rax*4]
   182ebcf92:	49 89 da             	mov    r10,rbx
   182ebcf95:	49 29 c2             	sub    r10,rax
   182ebcf98:	41 0f b6 44 0a 23    	movzx  eax,BYTE PTR [r10+rcx*1+0x23]
   182ebcf9e:	41 88 40 01          	mov    BYTE PTR [r8+0x1],al
   182ebcfa2:	49 ff c0             	inc    r8
   182ebcfa5:	49 ff c1             	inc    r9
   182ebcfa8:	48 83 f9 09          	cmp    rcx,0x9
   182ebcfac:	48 89 d1             	mov    rcx,rdx
   182ebcfaf:	77 cf                	ja     0x182ebcf80
   182ebcfb1:	41 c6 40 01 00       	mov    BYTE PTR [r8+0x1],0x0
   182ebcfb6:	49 83 f9 09          	cmp    r9,0x9
   182ebcfba:	72 1e                	jb     0x182ebcfda
   182ebcfbc:	48 8d 45 21          	lea    rax,[rbp+0x21]
   182ebcfc0:	41 0f b6 08          	movzx  ecx,BYTE PTR [r8]
   182ebcfc4:	0f b6 50 ff          	movzx  edx,BYTE PTR [rax-0x1]
   182ebcfc8:	41 88 10             	mov    BYTE PTR [r8],dl
   182ebcfcb:	49 ff c8             	dec    r8
   182ebcfce:	88 48 ff             	mov    BYTE PTR [rax-0x1],cl
   182ebcfd1:	4c 39 c0             	cmp    rax,r8
   182ebcfd4:	48 8d 40 01          	lea    rax,[rax+0x1]
   182ebcfd8:	72 e6                	jb     0x182ebcfc0
   182ebcfda:	48 8d 45 20          	lea    rax,[rbp+0x20]
   182ebcfde:	48 89 45 18          	mov    QWORD PTR [rbp+0x18],rax
   182ebcfe2:	4c 8d 85 98 03 00 00 	lea    r8,[rbp+0x398]
   182ebcfe9:	41 0f 11 78 70       	movups XMMWORD PTR [r8+0x70],xmm7
   182ebcfee:	41 0f 11 78 60       	movups XMMWORD PTR [r8+0x60],xmm7
   182ebcff3:	41 0f 11 78 50       	movups XMMWORD PTR [r8+0x50],xmm7
   182ebcff8:	41 0f 11 78 40       	movups XMMWORD PTR [r8+0x40],xmm7
   182ebcffd:	41 0f 11 78 30       	movups XMMWORD PTR [r8+0x30],xmm7
   182ebd002:	41 0f 11 78 20       	movups XMMWORD PTR [r8+0x20],xmm7
   182ebd007:	48 8d 45 18          	lea    rax,[rbp+0x18]
   182ebd00b:	48 89 85 98 03 00 00 	mov    QWORD PTR [rbp+0x398],rax
   182ebd012:	48 8d 85 50 02 00 00 	lea    rax,[rbp+0x250]
   182ebd019:	48 89 85 a0 03 00 00 	mov    QWORD PTR [rbp+0x3a0],rax
   182ebd020:	48 8d 85 18 03 00 00 	lea    rax,[rbp+0x318]
   182ebd027:	48 89 85 a8 03 00 00 	mov    QWORD PTR [rbp+0x3a8],rax
   182ebd02e:	48 8d 85 18 04 00 00 	lea    rax,[rbp+0x418]
   182ebd035:	48 89 85 b0 03 00 00 	mov    QWORD PTR [rbp+0x3b0],rax
   182ebd03c:	4c 8d ad 80 01 00 00 	lea    r13,[rbp+0x180]
   182ebd043:	4c 89 e9             	mov    rcx,r13
   182ebd046:	48 8d 15 73 37 6f 06 	lea    rdx,[rip+0x66f3773]        # 0x1895b07c0
   182ebd04d:	e8 be 07 1b fd       	call   0x18006d810
   182ebd052:	90                   	nop
   182ebd053:	4c 89 e9             	mov    rcx,r13
   182ebd056:	e8 15 03 1b fd       	call   0x18006d370
   182ebd05b:	48 8b 85 48 01 00 00 	mov    rax,QWORD PTR [rbp+0x148]
   182ebd062:	48 83 f8 10          	cmp    rax,0x10
   182ebd066:	72 39                	jb     0x182ebd0a1
   182ebd068:	48 8b 8d 30 01 00 00 	mov    rcx,QWORD PTR [rbp+0x130]
   182ebd06f:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182ebd073:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182ebd07a:	72 1f                	jb     0x182ebd09b
   182ebd07c:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182ebd080:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182ebd084:	4c 29 c1             	sub    rcx,r8
   182ebd087:	48 83 f9 20          	cmp    rcx,0x20
   182ebd08b:	0f 83 f4 09 00 00    	jae    0x182ebda85
   182ebd091:	48 83 c0 28          	add    rax,0x28
   182ebd095:	48 89 c2             	mov    rdx,rax
   182ebd098:	4c 89 c1             	mov    rcx,r8
   182ebd09b:	e8 80 ec 68 04       	call   0x18754bd20
   182ebd0a0:	90                   	nop
   182ebd0a1:	48 8d 8d 10 02 00 00 	lea    rcx,[rbp+0x210]
   182ebd0a8:	48 8d 95 80 01 00 00 	lea    rdx,[rbp+0x180]
   182ebd0af:	4c 8d 85 70 04 00 00 	lea    r8,[rbp+0x470]
   182ebd0b6:	e8 a5 75 7d fd       	call   0x180694660
   182ebd0bb:	90                   	nop
   182ebd0bc:	48 8b 85 80 01 00 00 	mov    rax,QWORD PTR [rbp+0x180]
   182ebd0c3:	48 89 70 30          	mov    QWORD PTR [rax+0x30],rsi
   182ebd0c7:	eb 14                	jmp    0x182ebd0dd
   182ebd0c9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
   182ebd0d0:	80 bd 90 04 00 00 01 	cmp    BYTE PTR [rbp+0x490],0x1
   182ebd0d7:	0f 85 89 01 00 00    	jne    0x182ebd266
   182ebd0dd:	48 83 bd 80 03 00 00 	cmp    QWORD PTR [rbp+0x380],0x0
   182ebd0e4:	00 
   182ebd0e5:	74 66                	je     0x182ebd14d
   182ebd0e7:	48 8d 8d 18 04 00 00 	lea    rcx,[rbp+0x418]
   182ebd0ee:	e8 2d a1 18 fd       	call   0x180047220
   182ebd0f3:	90                   	nop
   182ebd0f4:	48 8b 8d 18 04 00 00 	mov    rcx,QWORD PTR [rbp+0x418]
   182ebd0fb:	48 8d 95 98 03 00 00 	lea    rdx,[rbp+0x398]
   182ebd102:	e8 c9 52 4c fd       	call   0x1803823d0
   182ebd107:	90                   	nop
   182ebd108:	48 8b 8d 98 03 00 00 	mov    rcx,QWORD PTR [rbp+0x398]
   182ebd10f:	48 8d 95 80 01 00 00 	lea    rdx,[rbp+0x180]
   182ebd116:	e8 e5 78 ff fd       	call   0x180eb4a00
   182ebd11b:	90                   	nop
   182ebd11c:	48 8b 8d 80 01 00 00 	mov    rcx,QWORD PTR [rbp+0x180]
   182ebd123:	48 8d 85 10 02 00 00 	lea    rax,[rbp+0x210]
   182ebd12a:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182ebd12f:	c6 44 24 28 00       	mov    BYTE PTR [rsp+0x28],0x0
   182ebd134:	48 8d 95 70 04 00 00 	lea    rdx,[rbp+0x470]
   182ebd13b:	4c 8d 85 70 03 00 00 	lea    r8,[rbp+0x370]
   182ebd142:	41 89 f9             	mov    r9d,edi
   182ebd145:	e8 36 a6 c1 ff       	call   0x182ad7780
   182ebd14a:	90                   	nop
   182ebd14b:	eb 58                	jmp    0x182ebd1a5
   182ebd14d:	48 8d 8d 18 04 00 00 	lea    rcx,[rbp+0x418]
   182ebd154:	e8 c7 a0 18 fd       	call   0x180047220
   182ebd159:	90                   	nop
   182ebd15a:	48 8b 8d 18 04 00 00 	mov    rcx,QWORD PTR [rbp+0x418]
   182ebd161:	48 8d 95 98 03 00 00 	lea    rdx,[rbp+0x398]
   182ebd168:	e8 63 52 4c fd       	call   0x1803823d0
   182ebd16d:	90                   	nop
   182ebd16e:	48 8b 8d 98 03 00 00 	mov    rcx,QWORD PTR [rbp+0x398]
   182ebd175:	48 8d 95 80 01 00 00 	lea    rdx,[rbp+0x180]
   182ebd17c:	e8 7f 78 ff fd       	call   0x180eb4a00
   182ebd181:	90                   	nop
   182ebd182:	48 8b 8d 80 01 00 00 	mov    rcx,QWORD PTR [rbp+0x180]
   182ebd189:	c6 44 24 20 00       	mov    BYTE PTR [rsp+0x20],0x0
   182ebd18e:	48 8d 95 70 04 00 00 	lea    rdx,[rbp+0x470]
   182ebd195:	41 89 f8             	mov    r8d,edi
   182ebd198:	4c 8d 8d 10 02 00 00 	lea    r9,[rbp+0x210]
   182ebd19f:	e8 7c 89 c1 ff       	call   0x182ad5b20
   182ebd1a4:	90                   	nop
   182ebd1a5:	48 89 85 10 03 00 00 	mov    QWORD PTR [rbp+0x310],rax
   182ebd1ac:	48 8b b5 88 01 00 00 	mov    rsi,QWORD PTR [rbp+0x188]
   182ebd1b3:	48 85 f6             	test   rsi,rsi
   182ebd1b6:	74 28                	je     0x182ebd1e0
   182ebd1b8:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182ebd1bc:	75 22                	jne    0x182ebd1e0
   182ebd1be:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebd1c1:	48 89 f1             	mov    rcx,rsi
   182ebd1c4:	ff 10                	call   QWORD PTR [rax]
   182ebd1c6:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182ebd1ca:	75 14                	jne    0x182ebd1e0
   182ebd1cc:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebd1cf:	48 89 f1             	mov    rcx,rsi
   182ebd1d2:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182ebd1d5:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebd1dc:	00 00 00 00 
   182ebd1e0:	48 8b b5 a0 03 00 00 	mov    rsi,QWORD PTR [rbp+0x3a0]
   182ebd1e7:	48 85 f6             	test   rsi,rsi
   182ebd1ea:	74 24                	je     0x182ebd210
   182ebd1ec:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182ebd1f0:	75 1e                	jne    0x182ebd210
   182ebd1f2:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebd1f5:	48 89 f1             	mov    rcx,rsi
   182ebd1f8:	ff 10                	call   QWORD PTR [rax]
   182ebd1fa:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182ebd1fe:	75 10                	jne    0x182ebd210
   182ebd200:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebd203:	48 89 f1             	mov    rcx,rsi
   182ebd206:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182ebd209:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
   182ebd210:	48 8b b5 20 04 00 00 	mov    rsi,QWORD PTR [rbp+0x420]
   182ebd217:	48 85 f6             	test   rsi,rsi
   182ebd21a:	74 24                	je     0x182ebd240
   182ebd21c:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182ebd220:	75 1e                	jne    0x182ebd240
   182ebd222:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebd225:	48 89 f1             	mov    rcx,rsi
   182ebd228:	ff 10                	call   QWORD PTR [rax]
   182ebd22a:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182ebd22e:	75 10                	jne    0x182ebd240
   182ebd230:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebd233:	48 89 f1             	mov    rcx,rsi
   182ebd236:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182ebd239:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
   182ebd240:	b0 01                	mov    al,0x1
   182ebd242:	89 85 90 04 00 00    	mov    DWORD PTR [rbp+0x490],eax
   182ebd248:	48 8d 35 61 37 09 06 	lea    rsi,[rip+0x6093761]        # 0x188f509b0
   182ebd24f:	b9 02 00 00 00       	mov    ecx,0x2
   182ebd254:	e8 87 fb 1a fd       	call   0x18006cde0
   182ebd259:	85 c0                	test   eax,eax
   182ebd25b:	0f 85 55 02 00 00    	jne    0x182ebd4b6
   182ebd261:	e9 48 07 00 00       	jmp    0x182ebd9ae
   182ebd266:	48 83 bd 80 03 00 00 	cmp    QWORD PTR [rbp+0x380],0x0
   182ebd26d:	00 
   182ebd26e:	0f 84 4e 01 00 00    	je     0x182ebd3c2
   182ebd274:	48 8d 8d 18 04 00 00 	lea    rcx,[rbp+0x418]
   182ebd27b:	e8 a0 9f 18 fd       	call   0x180047220
   182ebd280:	90                   	nop
   182ebd281:	48 8b 8d 18 04 00 00 	mov    rcx,QWORD PTR [rbp+0x418]
   182ebd288:	48 8d 95 98 03 00 00 	lea    rdx,[rbp+0x398]
   182ebd28f:	e8 3c 51 4c fd       	call   0x1803823d0
   182ebd294:	90                   	nop
   182ebd295:	48 8b 8d 98 03 00 00 	mov    rcx,QWORD PTR [rbp+0x398]
   182ebd29c:	48 8d 95 80 01 00 00 	lea    rdx,[rbp+0x180]
   182ebd2a3:	e8 58 77 ff fd       	call   0x180eb4a00
   182ebd2a8:	90                   	nop
   182ebd2a9:	48 8b 8d 80 01 00 00 	mov    rcx,QWORD PTR [rbp+0x180]
   182ebd2b0:	c6 44 24 20 00       	mov    BYTE PTR [rsp+0x20],0x0
   182ebd2b5:	48 8d 95 70 04 00 00 	lea    rdx,[rbp+0x470]
   182ebd2bc:	4c 8d 85 70 03 00 00 	lea    r8,[rbp+0x370]
   182ebd2c3:	41 89 f9             	mov    r9d,edi
   182ebd2c6:	e8 e5 8e c1 ff       	call   0x182ad61b0
   182ebd2cb:	90                   	nop
   182ebd2cc:	e9 40 01 00 00       	jmp    0x182ebd411
   182ebd2d1:	42 c6 84 05 18 03 00 	mov    BYTE PTR [rbp+r8*1+0x318],0x2d
   182ebd2d8:	00 2d 
   182ebd2da:	49 ff c0             	inc    r8
   182ebd2dd:	42 c6 84 05 18 03 00 	mov    BYTE PTR [rbp+r8*1+0x318],0x0
   182ebd2e4:	00 00 
   182ebd2e6:	49 83 f8 0a          	cmp    r8,0xa
   182ebd2ea:	7c 2e                	jl     0x182ebd31a
   182ebd2ec:	49 8d 04 28          	lea    rax,[r8+rbp*1]
   182ebd2f0:	48 05 18 03 00 00    	add    rax,0x318
   182ebd2f6:	48 ff c8             	dec    rax
   182ebd2f9:	48 8d 8d 21 03 00 00 	lea    rcx,[rbp+0x321]
   182ebd300:	0f b6 10             	movzx  edx,BYTE PTR [rax]
   182ebd303:	44 0f b6 41 ff       	movzx  r8d,BYTE PTR [rcx-0x1]
   182ebd308:	44 88 00             	mov    BYTE PTR [rax],r8b
   182ebd30b:	88 51 ff             	mov    BYTE PTR [rcx-0x1],dl
   182ebd30e:	48 ff c8             	dec    rax
   182ebd311:	48 39 c1             	cmp    rcx,rax
   182ebd314:	48 8d 49 01          	lea    rcx,[rcx+0x1]
   182ebd318:	72 e6                	jb     0x182ebd300
   182ebd31a:	48 8d 85 20 03 00 00 	lea    rax,[rbp+0x320]
   182ebd321:	48 89 85 18 03 00 00 	mov    QWORD PTR [rbp+0x318],rax
   182ebd328:	4c 8d 85 98 03 00 00 	lea    r8,[rbp+0x398]
   182ebd32f:	41 0f 11 78 70       	movups XMMWORD PTR [r8+0x70],xmm7
   182ebd334:	41 0f 11 78 60       	movups XMMWORD PTR [r8+0x60],xmm7
   182ebd339:	41 0f 11 78 50       	movups XMMWORD PTR [r8+0x50],xmm7
   182ebd33e:	41 0f 11 78 40       	movups XMMWORD PTR [r8+0x40],xmm7
   182ebd343:	41 0f 11 78 30       	movups XMMWORD PTR [r8+0x30],xmm7
   182ebd348:	41 0f 11 78 20       	movups XMMWORD PTR [r8+0x20],xmm7
   182ebd34d:	41 0f 11 78 10       	movups XMMWORD PTR [r8+0x10],xmm7
   182ebd352:	48 8d 85 18 03 00 00 	lea    rax,[rbp+0x318]
   182ebd359:	48 89 85 98 03 00 00 	mov    QWORD PTR [rbp+0x398],rax
   182ebd360:	48 8d 85 18 04 00 00 	lea    rax,[rbp+0x418]
   182ebd367:	48 89 85 a0 03 00 00 	mov    QWORD PTR [rbp+0x3a0],rax
   182ebd36e:	48 8d b5 80 01 00 00 	lea    rsi,[rbp+0x180]
   182ebd375:	48 89 f1             	mov    rcx,rsi
   182ebd378:	48 8d 15 e1 33 6f 06 	lea    rdx,[rip+0x66f33e1]        # 0x1895b0760
   182ebd37f:	e8 8c 04 1b fd       	call   0x18006d810
   182ebd384:	90                   	nop
   182ebd385:	48 89 f1             	mov    rcx,rsi
   182ebd388:	e8 e3 ff 1a fd       	call   0x18006d370
   182ebd38d:	48 8b 85 68 02 00 00 	mov    rax,QWORD PTR [rbp+0x268]
   182ebd394:	48 83 f8 10          	cmp    rax,0x10
   182ebd398:	48 8d b5 a0 02 00 00 	lea    rsi,[rbp+0x2a0]
   182ebd39f:	0f 82 a2 06 00 00    	jb     0x182ebda47
   182ebd3a5:	48 8b 8d 50 02 00 00 	mov    rcx,QWORD PTR [rbp+0x250]
   182ebd3ac:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182ebd3b0:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182ebd3b7:	0f 83 6a 06 00 00    	jae    0x182ebda27
   182ebd3bd:	e9 80 06 00 00       	jmp    0x182ebda42
   182ebd3c2:	48 8d 8d 18 04 00 00 	lea    rcx,[rbp+0x418]
   182ebd3c9:	e8 52 9e 18 fd       	call   0x180047220
   182ebd3ce:	90                   	nop
   182ebd3cf:	48 8b 8d 18 04 00 00 	mov    rcx,QWORD PTR [rbp+0x418]
   182ebd3d6:	48 8d 95 98 03 00 00 	lea    rdx,[rbp+0x398]
   182ebd3dd:	e8 ee 4f 4c fd       	call   0x1803823d0
   182ebd3e2:	90                   	nop
   182ebd3e3:	48 8b 8d 98 03 00 00 	mov    rcx,QWORD PTR [rbp+0x398]
   182ebd3ea:	48 8d 95 80 01 00 00 	lea    rdx,[rbp+0x180]
   182ebd3f1:	e8 0a 76 ff fd       	call   0x180eb4a00
   182ebd3f6:	90                   	nop
   182ebd3f7:	48 8b 8d 80 01 00 00 	mov    rcx,QWORD PTR [rbp+0x180]
   182ebd3fe:	48 8d 95 70 04 00 00 	lea    rdx,[rbp+0x470]
   182ebd405:	41 89 f8             	mov    r8d,edi
   182ebd408:	45 31 c9             	xor    r9d,r9d
   182ebd40b:	e8 90 80 c1 ff       	call   0x182ad54a0
   182ebd410:	90                   	nop
   182ebd411:	48 89 85 10 03 00 00 	mov    QWORD PTR [rbp+0x310],rax
   182ebd418:	48 8b b5 88 01 00 00 	mov    rsi,QWORD PTR [rbp+0x188]
   182ebd41f:	48 85 f6             	test   rsi,rsi
   182ebd422:	74 1d                	je     0x182ebd441
   182ebd424:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182ebd428:	75 17                	jne    0x182ebd441
   182ebd42a:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebd42d:	48 89 f1             	mov    rcx,rsi
   182ebd430:	ff 10                	call   QWORD PTR [rax]
   182ebd432:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182ebd436:	75 09                	jne    0x182ebd441
   182ebd438:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebd43b:	48 89 f1             	mov    rcx,rsi
   182ebd43e:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182ebd441:	48 8b b5 a0 03 00 00 	mov    rsi,QWORD PTR [rbp+0x3a0]
   182ebd448:	48 85 f6             	test   rsi,rsi
   182ebd44b:	74 1d                	je     0x182ebd46a
   182ebd44d:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182ebd451:	75 17                	jne    0x182ebd46a
   182ebd453:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebd456:	48 89 f1             	mov    rcx,rsi
   182ebd459:	ff 10                	call   QWORD PTR [rax]
   182ebd45b:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182ebd45f:	75 09                	jne    0x182ebd46a
   182ebd461:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebd464:	48 89 f1             	mov    rcx,rsi
   182ebd467:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182ebd46a:	48 8b b5 20 04 00 00 	mov    rsi,QWORD PTR [rbp+0x420]
   182ebd471:	48 85 f6             	test   rsi,rsi
   182ebd474:	74 1d                	je     0x182ebd493
   182ebd476:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182ebd47a:	75 17                	jne    0x182ebd493
   182ebd47c:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebd47f:	48 89 f1             	mov    rcx,rsi
   182ebd482:	ff 10                	call   QWORD PTR [rax]
   182ebd484:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182ebd488:	75 09                	jne    0x182ebd493
   182ebd48a:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebd48d:	48 89 f1             	mov    rcx,rsi
   182ebd490:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182ebd493:	c7 85 90 04 00 00 00 	mov    DWORD PTR [rbp+0x490],0x0
   182ebd49a:	00 00 00 
   182ebd49d:	48 8d 35 14 35 09 06 	lea    rsi,[rip+0x6093514]        # 0x188f509b8
   182ebd4a4:	b9 02 00 00 00       	mov    ecx,0x2
   182ebd4a9:	e8 32 f9 1a fd       	call   0x18006cde0
   182ebd4ae:	85 c0                	test   eax,eax
   182ebd4b0:	0f 84 f8 04 00 00    	je     0x182ebd9ae
   182ebd4b6:	48 8d 8d b8 00 00 00 	lea    rcx,[rbp+0xb8]
   182ebd4bd:	e8 4e fa 1a fd       	call   0x18006cf10
   182ebd4c2:	90                   	nop
   182ebd4c3:	48 83 bd d0 00 00 00 	cmp    QWORD PTR [rbp+0xd0],0x10
   182ebd4ca:	10 
   182ebd4cb:	4c 8d 85 b8 00 00 00 	lea    r8,[rbp+0xb8]
   182ebd4d2:	72 07                	jb     0x182ebd4db
   182ebd4d4:	4c 8b 85 b8 00 00 00 	mov    r8,QWORD PTR [rbp+0xb8]
   182ebd4db:	48 8d 05 2e 30 6f 06 	lea    rax,[rip+0x66f302e]        # 0x1895b0510
   182ebd4e2:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182ebd4e7:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182ebd4ee:	00 00 
   182ebd4f0:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182ebd4f5:	c7 44 24 28 ef 01 00 	mov    DWORD PTR [rsp+0x28],0x1ef
   182ebd4fc:	00 
   182ebd4fd:	48 8d 8d 80 01 00 00 	lea    rcx,[rbp+0x180]
   182ebd504:	ba 02 00 00 00       	mov    edx,0x2
   182ebd509:	4c 8d 0d 10 28 6f 06 	lea    r9,[rip+0x66f2810]        # 0x1895afd20
   182ebd510:	e8 5b fd 1a fd       	call   0x18006d270
   182ebd515:	90                   	nop
   182ebd516:	48 89 b5 18 04 00 00 	mov    QWORD PTR [rbp+0x418],rsi
   182ebd51d:	c6 85 20 04 00 00 00 	mov    BYTE PTR [rbp+0x420],0x0
   182ebd524:	48 83 bd 88 03 00 00 	cmp    QWORD PTR [rbp+0x388],0x10
   182ebd52b:	10 
   182ebd52c:	48 8d 85 70 03 00 00 	lea    rax,[rbp+0x370]
   182ebd533:	72 07                	jb     0x182ebd53c
   182ebd535:	48 8b 85 70 03 00 00 	mov    rax,QWORD PTR [rbp+0x370]
   182ebd53c:	48 89 85 18 03 00 00 	mov    QWORD PTR [rbp+0x318],rax
   182ebd543:	c6 85 20 03 00 00 00 	mov    BYTE PTR [rbp+0x320],0x0
   182ebd54a:	8b 8d b4 02 00 00    	mov    ecx,DWORD PTR [rbp+0x2b4]
   182ebd550:	48 c7 85 50 02 00 00 	mov    QWORD PTR [rbp+0x250],0x0
   182ebd557:	00 00 00 00 
   182ebd55b:	b8 08 00 00 00       	mov    eax,0x8
   182ebd560:	89 ca                	mov    edx,ecx
   182ebd562:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebd569:	1f 84 00 00 00 00 00 
   182ebd570:	4c 63 c2             	movsxd r8,edx
   182ebd573:	49 69 d0 67 66 66 66 	imul   rdx,r8,0x66666667
   182ebd57a:	49 89 d1             	mov    r9,rdx
   182ebd57d:	49 c1 e9 3f          	shr    r9,0x3f
   182ebd581:	48 c1 fa 22          	sar    rdx,0x22
   182ebd585:	44 01 ca             	add    edx,r9d
   182ebd588:	44 8d 0c 12          	lea    r9d,[rdx+rdx*1]
   182ebd58c:	47 8d 0c 89          	lea    r9d,[r9+r9*4]
   182ebd590:	41 f7 d9             	neg    r9d
   182ebd593:	45 01 c1             	add    r9d,r8d
   182ebd596:	41 83 c1 23          	add    r9d,0x23
   182ebd59a:	4d 63 c9             	movsxd r9,r9d
   182ebd59d:	45 0f b6 0c 19       	movzx  r9d,BYTE PTR [r9+rbx*1]
   182ebd5a2:	44 88 8c 05 50 02 00 	mov    BYTE PTR [rbp+rax*1+0x250],r9b
   182ebd5a9:	00 
   182ebd5aa:	48 ff c0             	inc    rax
   182ebd5ad:	41 83 c0 09          	add    r8d,0x9
   182ebd5b1:	41 83 f8 12          	cmp    r8d,0x12
   182ebd5b5:	77 b9                	ja     0x182ebd570
   182ebd5b7:	85 c9                	test   ecx,ecx
   182ebd5b9:	78 10                	js     0x182ebd5cb
   182ebd5bb:	c6 84 05 50 02 00 00 	mov    BYTE PTR [rbp+rax*1+0x250],0x0
   182ebd5c2:	00 
   182ebd5c3:	48 83 f8 0a          	cmp    rax,0xa
   182ebd5c7:	7d 1b                	jge    0x182ebd5e4
   182ebd5c9:	eb 4f                	jmp    0x182ebd61a
   182ebd5cb:	c6 84 05 50 02 00 00 	mov    BYTE PTR [rbp+rax*1+0x250],0x2d
   182ebd5d2:	2d 
   182ebd5d3:	48 ff c0             	inc    rax
   182ebd5d6:	c6 84 05 50 02 00 00 	mov    BYTE PTR [rbp+rax*1+0x250],0x0
   182ebd5dd:	00 
   182ebd5de:	48 83 f8 0a          	cmp    rax,0xa
   182ebd5e2:	7c 36                	jl     0x182ebd61a
   182ebd5e4:	48 01 e8             	add    rax,rbp
   182ebd5e7:	48 05 50 02 00 00    	add    rax,0x250
   182ebd5ed:	48 ff c8             	dec    rax
   182ebd5f0:	48 8d 8d 59 02 00 00 	lea    rcx,[rbp+0x259]
   182ebd5f7:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
   182ebd5fe:	00 00 
   182ebd600:	0f b6 10             	movzx  edx,BYTE PTR [rax]
   182ebd603:	44 0f b6 41 ff       	movzx  r8d,BYTE PTR [rcx-0x1]
   182ebd608:	44 88 00             	mov    BYTE PTR [rax],r8b
   182ebd60b:	88 51 ff             	mov    BYTE PTR [rcx-0x1],dl
   182ebd60e:	48 ff c8             	dec    rax
   182ebd611:	48 39 c1             	cmp    rcx,rax
   182ebd614:	48 8d 49 01          	lea    rcx,[rcx+0x1]
   182ebd618:	72 e6                	jb     0x182ebd600
   182ebd61a:	48 8d 85 58 02 00 00 	lea    rax,[rbp+0x258]
   182ebd621:	48 89 85 50 02 00 00 	mov    QWORD PTR [rbp+0x250],rax
   182ebd628:	48 83 bd 88 04 00 00 	cmp    QWORD PTR [rbp+0x488],0x10
   182ebd62f:	10 
   182ebd630:	48 8d 85 70 04 00 00 	lea    rax,[rbp+0x470]
   182ebd637:	72 07                	jb     0x182ebd640
   182ebd639:	48 8b 85 70 04 00 00 	mov    rax,QWORD PTR [rbp+0x470]
   182ebd640:	48 89 45 18          	mov    QWORD PTR [rbp+0x18],rax
   182ebd644:	c6 45 20 00          	mov    BYTE PTR [rbp+0x20],0x0
   182ebd648:	8b 95 ec 02 00 00    	mov    edx,DWORD PTR [rbp+0x2ec]
   182ebd64e:	48 c7 85 30 01 00 00 	mov    QWORD PTR [rbp+0x130],0x0
   182ebd655:	00 00 00 00 
   182ebd659:	b8 07 00 00 00       	mov    eax,0x7
   182ebd65e:	48 8d 8d 37 01 00 00 	lea    rcx,[rbp+0x137]
   182ebd665:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebd66c:	00 00 00 00 
   182ebd670:	41 89 d0             	mov    r8d,edx
   182ebd673:	4d 0f af c7          	imul   r8,r15
   182ebd677:	49 c1 e8 23          	shr    r8,0x23
   182ebd67b:	47 8d 0c 00          	lea    r9d,[r8+r8*1]
   182ebd67f:	47 8d 0c 89          	lea    r9d,[r9+r9*4]
   182ebd683:	41 f7 d9             	neg    r9d
   182ebd686:	41 01 d1             	add    r9d,edx
   182ebd689:	41 83 c1 23          	add    r9d,0x23
   182ebd68d:	45 0f b6 0c 19       	movzx  r9d,BYTE PTR [r9+rbx*1]
   182ebd692:	44 88 49 01          	mov    BYTE PTR [rcx+0x1],r9b
   182ebd696:	48 ff c1             	inc    rcx
   182ebd699:	48 ff c0             	inc    rax
   182ebd69c:	83 fa 09             	cmp    edx,0x9
   182ebd69f:	44 89 c2             	mov    edx,r8d
   182ebd6a2:	77 cc                	ja     0x182ebd670
   182ebd6a4:	c6 41 01 00          	mov    BYTE PTR [rcx+0x1],0x0
   182ebd6a8:	48 83 f8 09          	cmp    rax,0x9
   182ebd6ac:	72 2c                	jb     0x182ebd6da
   182ebd6ae:	48 8d 85 39 01 00 00 	lea    rax,[rbp+0x139]
   182ebd6b5:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebd6bc:	00 00 00 00 
   182ebd6c0:	0f b6 11             	movzx  edx,BYTE PTR [rcx]
   182ebd6c3:	44 0f b6 40 ff       	movzx  r8d,BYTE PTR [rax-0x1]
   182ebd6c8:	44 88 01             	mov    BYTE PTR [rcx],r8b
   182ebd6cb:	48 ff c9             	dec    rcx
   182ebd6ce:	88 50 ff             	mov    BYTE PTR [rax-0x1],dl
   182ebd6d1:	48 39 c8             	cmp    rax,rcx
   182ebd6d4:	48 8d 40 01          	lea    rax,[rax+0x1]
   182ebd6d8:	72 e6                	jb     0x182ebd6c0
   182ebd6da:	48 8d 85 38 01 00 00 	lea    rax,[rbp+0x138]
   182ebd6e1:	48 89 85 30 01 00 00 	mov    QWORD PTR [rbp+0x130],rax
   182ebd6e8:	4c 8b 8d f0 02 00 00 	mov    r9,QWORD PTR [rbp+0x2f0]
   182ebd6ef:	48 c7 45 68 00 00 00 	mov    QWORD PTR [rbp+0x68],0x0
   182ebd6f6:	00 
   182ebd6f7:	41 b8 08 00 00 00    	mov    r8d,0x8
   182ebd6fd:	4c 89 c9             	mov    rcx,r9
   182ebd700:	48 89 c8             	mov    rax,rcx
   182ebd703:	49 f7 ee             	imul   r14
   182ebd706:	48 89 d0             	mov    rax,rdx
   182ebd709:	48 c1 e8 3f          	shr    rax,0x3f
   182ebd70d:	48 c1 fa 02          	sar    rdx,0x2
   182ebd711:	48 01 c2             	add    rdx,rax
   182ebd714:	48 8d 04 12          	lea    rax,[rdx+rdx*1]
   182ebd718:	48 8d 04 80          	lea    rax,[rax+rax*4]
   182ebd71c:	49 89 da             	mov    r10,rbx
   182ebd71f:	49 29 c2             	sub    r10,rax
   182ebd722:	41 0f b6 44 0a 23    	movzx  eax,BYTE PTR [r10+rcx*1+0x23]
   182ebd728:	42 88 44 05 68       	mov    BYTE PTR [rbp+r8*1+0x68],al
   182ebd72d:	49 ff c0             	inc    r8
   182ebd730:	48 83 c1 09          	add    rcx,0x9
   182ebd734:	48 83 f9 12          	cmp    rcx,0x12
   182ebd738:	48 89 d1             	mov    rcx,rdx
   182ebd73b:	77 c3                	ja     0x182ebd700
   182ebd73d:	4d 85 c9             	test   r9,r9
   182ebd740:	78 0e                	js     0x182ebd750
   182ebd742:	42 c6 44 05 68 00    	mov    BYTE PTR [rbp+r8*1+0x68],0x0
   182ebd748:	49 83 f8 0a          	cmp    r8,0xa
   182ebd74c:	7d 17                	jge    0x182ebd765
   182ebd74e:	eb 4a                	jmp    0x182ebd79a
   182ebd750:	42 c6 44 05 68 2d    	mov    BYTE PTR [rbp+r8*1+0x68],0x2d
   182ebd756:	49 ff c0             	inc    r8
   182ebd759:	42 c6 44 05 68 00    	mov    BYTE PTR [rbp+r8*1+0x68],0x0
   182ebd75f:	49 83 f8 0a          	cmp    r8,0xa
   182ebd763:	7c 35                	jl     0x182ebd79a
   182ebd765:	49 8d 04 28          	lea    rax,[r8+rbp*1]
   182ebd769:	48 83 c0 68          	add    rax,0x68
   182ebd76d:	48 ff c8             	dec    rax
   182ebd770:	48 8d 4d 71          	lea    rcx,[rbp+0x71]
   182ebd774:	66 66 66 2e 0f 1f 84 	data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebd77b:	00 00 00 00 00 
   182ebd780:	0f b6 10             	movzx  edx,BYTE PTR [rax]
   182ebd783:	44 0f b6 41 ff       	movzx  r8d,BYTE PTR [rcx-0x1]
   182ebd788:	44 88 00             	mov    BYTE PTR [rax],r8b
   182ebd78b:	88 51 ff             	mov    BYTE PTR [rcx-0x1],dl
   182ebd78e:	48 ff c8             	dec    rax
   182ebd791:	48 39 c1             	cmp    rcx,rax
   182ebd794:	48 8d 49 01          	lea    rcx,[rcx+0x1]
   182ebd798:	72 e6                	jb     0x182ebd780
   182ebd79a:	48 8d 45 70          	lea    rax,[rbp+0x70]
   182ebd79e:	48 89 45 68          	mov    QWORD PTR [rbp+0x68],rax
   182ebd7a2:	48 c7 45 c8 00 00 00 	mov    QWORD PTR [rbp-0x38],0x0
   182ebd7a9:	00 
   182ebd7aa:	b8 07 00 00 00       	mov    eax,0x7
   182ebd7af:	48 8d 4d cf          	lea    rcx,[rbp-0x31]
   182ebd7b3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebd7ba:	84 00 00 00 00 00 
   182ebd7c0:	89 fa                	mov    edx,edi
   182ebd7c2:	49 0f af d7          	imul   rdx,r15
   182ebd7c6:	48 c1 ea 23          	shr    rdx,0x23
   182ebd7ca:	44 8d 04 12          	lea    r8d,[rdx+rdx*1]
   182ebd7ce:	47 8d 04 80          	lea    r8d,[r8+r8*4]
   182ebd7d2:	41 f7 d8             	neg    r8d
   182ebd7d5:	41 01 f8             	add    r8d,edi
   182ebd7d8:	41 83 c0 23          	add    r8d,0x23
   182ebd7dc:	45 0f b6 04 18       	movzx  r8d,BYTE PTR [r8+rbx*1]
   182ebd7e1:	44 88 41 01          	mov    BYTE PTR [rcx+0x1],r8b
   182ebd7e5:	48 ff c1             	inc    rcx
   182ebd7e8:	48 ff c0             	inc    rax
   182ebd7eb:	83 ff 09             	cmp    edi,0x9
   182ebd7ee:	89 d7                	mov    edi,edx
   182ebd7f0:	77 ce                	ja     0x182ebd7c0
   182ebd7f2:	c6 41 01 00          	mov    BYTE PTR [rcx+0x1],0x0
   182ebd7f6:	48 83 f8 09          	cmp    rax,0x9
   182ebd7fa:	72 1e                	jb     0x182ebd81a
   182ebd7fc:	48 8d 45 d1          	lea    rax,[rbp-0x2f]
   182ebd800:	0f b6 11             	movzx  edx,BYTE PTR [rcx]
   182ebd803:	44 0f b6 40 ff       	movzx  r8d,BYTE PTR [rax-0x1]
   182ebd808:	44 88 01             	mov    BYTE PTR [rcx],r8b
   182ebd80b:	48 ff c9             	dec    rcx
   182ebd80e:	88 50 ff             	mov    BYTE PTR [rax-0x1],dl
   182ebd811:	48 39 c8             	cmp    rax,rcx
   182ebd814:	48 8d 40 01          	lea    rax,[rax+0x1]
   182ebd818:	72 e6                	jb     0x182ebd800
   182ebd81a:	48 8d 45 d0          	lea    rax,[rbp-0x30]
   182ebd81e:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
   182ebd822:	48 8b 8d 10 03 00 00 	mov    rcx,QWORD PTR [rbp+0x310]
   182ebd829:	48 c7 85 e0 00 00 00 	mov    QWORD PTR [rbp+0xe0],0x0
   182ebd830:	00 00 00 00 
   182ebd834:	41 b9 07 00 00 00    	mov    r9d,0x7
   182ebd83a:	4c 8d 85 e7 00 00 00 	lea    r8,[rbp+0xe7]
   182ebd841:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebd848:	0f 1f 84 00 00 00 00 
   182ebd84f:	00 
   182ebd850:	48 89 c8             	mov    rax,rcx
   182ebd853:	49 f7 e4             	mul    r12
   182ebd856:	48 c1 ea 03          	shr    rdx,0x3
   182ebd85a:	48 8d 04 12          	lea    rax,[rdx+rdx*1]
   182ebd85e:	48 8d 04 80          	lea    rax,[rax+rax*4]
   182ebd862:	49 89 da             	mov    r10,rbx
   182ebd865:	49 29 c2             	sub    r10,rax
   182ebd868:	41 0f b6 44 0a 23    	movzx  eax,BYTE PTR [r10+rcx*1+0x23]
   182ebd86e:	41 88 40 01          	mov    BYTE PTR [r8+0x1],al
   182ebd872:	49 ff c0             	inc    r8
   182ebd875:	49 ff c1             	inc    r9
   182ebd878:	48 83 f9 09          	cmp    rcx,0x9
   182ebd87c:	48 89 d1             	mov    rcx,rdx
   182ebd87f:	77 cf                	ja     0x182ebd850
   182ebd881:	41 c6 40 01 00       	mov    BYTE PTR [r8+0x1],0x0
   182ebd886:	49 83 f9 09          	cmp    r9,0x9
   182ebd88a:	72 2e                	jb     0x182ebd8ba
   182ebd88c:	48 8d 85 e9 00 00 00 	lea    rax,[rbp+0xe9]
   182ebd893:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebd89a:	84 00 00 00 00 00 
   182ebd8a0:	41 0f b6 08          	movzx  ecx,BYTE PTR [r8]
   182ebd8a4:	0f b6 50 ff          	movzx  edx,BYTE PTR [rax-0x1]
   182ebd8a8:	41 88 10             	mov    BYTE PTR [r8],dl
   182ebd8ab:	49 ff c8             	dec    r8
   182ebd8ae:	88 48 ff             	mov    BYTE PTR [rax-0x1],cl
   182ebd8b1:	4c 39 c0             	cmp    rax,r8
   182ebd8b4:	48 8d 40 01          	lea    rax,[rax+0x1]
   182ebd8b8:	72 e6                	jb     0x182ebd8a0
   182ebd8ba:	48 8d 85 e8 00 00 00 	lea    rax,[rbp+0xe8]
   182ebd8c1:	48 89 85 e0 00 00 00 	mov    QWORD PTR [rbp+0xe0],rax
   182ebd8c8:	48 8d 85 e0 00 00 00 	lea    rax,[rbp+0xe0]
   182ebd8cf:	48 89 85 98 03 00 00 	mov    QWORD PTR [rbp+0x398],rax
   182ebd8d6:	48 8d 45 c8          	lea    rax,[rbp-0x38]
   182ebd8da:	48 89 85 a0 03 00 00 	mov    QWORD PTR [rbp+0x3a0],rax
   182ebd8e1:	48 8d 45 68          	lea    rax,[rbp+0x68]
   182ebd8e5:	48 89 85 a8 03 00 00 	mov    QWORD PTR [rbp+0x3a8],rax
   182ebd8ec:	48 8d 85 30 01 00 00 	lea    rax,[rbp+0x130]
   182ebd8f3:	48 89 85 b0 03 00 00 	mov    QWORD PTR [rbp+0x3b0],rax
   182ebd8fa:	48 8d 45 18          	lea    rax,[rbp+0x18]
   182ebd8fe:	48 89 85 b8 03 00 00 	mov    QWORD PTR [rbp+0x3b8],rax
   182ebd905:	48 8d 85 50 02 00 00 	lea    rax,[rbp+0x250]
   182ebd90c:	48 89 85 c0 03 00 00 	mov    QWORD PTR [rbp+0x3c0],rax
   182ebd913:	48 8d 85 18 03 00 00 	lea    rax,[rbp+0x318]
   182ebd91a:	48 89 85 c8 03 00 00 	mov    QWORD PTR [rbp+0x3c8],rax
   182ebd921:	48 8d 85 18 04 00 00 	lea    rax,[rbp+0x418]
   182ebd928:	48 89 85 d0 03 00 00 	mov    QWORD PTR [rbp+0x3d0],rax
   182ebd92f:	4c 8d 85 98 03 00 00 	lea    r8,[rbp+0x398]
   182ebd936:	41 0f 11 78 70       	movups XMMWORD PTR [r8+0x70],xmm7
   182ebd93b:	41 0f 11 78 60       	movups XMMWORD PTR [r8+0x60],xmm7
   182ebd940:	41 0f 11 78 50       	movups XMMWORD PTR [r8+0x50],xmm7
   182ebd945:	41 0f 11 78 40       	movups XMMWORD PTR [r8+0x40],xmm7
   182ebd94a:	48 8d b5 80 01 00 00 	lea    rsi,[rbp+0x180]
   182ebd951:	48 89 f1             	mov    rcx,rsi
   182ebd954:	48 8d 15 25 26 6f 06 	lea    rdx,[rip+0x66f2625]        # 0x1895aff80
   182ebd95b:	e8 b0 fe 1a fd       	call   0x18006d810
   182ebd960:	90                   	nop
   182ebd961:	48 89 f1             	mov    rcx,rsi
   182ebd964:	e8 07 fa 1a fd       	call   0x18006d370
   182ebd969:	48 8b 85 d0 00 00 00 	mov    rax,QWORD PTR [rbp+0xd0]
   182ebd970:	48 83 f8 10          	cmp    rax,0x10
   182ebd974:	72 38                	jb     0x182ebd9ae
   182ebd976:	48 8b 8d b8 00 00 00 	mov    rcx,QWORD PTR [rbp+0xb8]
   182ebd97d:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182ebd981:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182ebd988:	72 1f                	jb     0x182ebd9a9
   182ebd98a:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182ebd98e:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182ebd992:	4c 29 c1             	sub    rcx,r8
   182ebd995:	48 83 f9 20          	cmp    rcx,0x20
   182ebd999:	0f 83 e6 00 00 00    	jae    0x182ebda85
   182ebd99f:	48 83 c0 28          	add    rax,0x28
   182ebd9a3:	48 89 c2             	mov    rdx,rax
   182ebd9a6:	4c 89 c1             	mov    rcx,r8
   182ebd9a9:	e8 72 e3 68 04       	call   0x18754bd20
   182ebd9ae:	48 8b 8d 68 04 00 00 	mov    rcx,QWORD PTR [rbp+0x468]
   182ebd9b5:	48 8b 71 08          	mov    rsi,QWORD PTR [rcx+0x8]
   182ebd9b9:	48 3b 71 10          	cmp    rsi,QWORD PTR [rcx+0x10]
   182ebd9bd:	74 29                	je     0x182ebd9e8
   182ebd9bf:	48 89 f1             	mov    rcx,rsi
   182ebd9c2:	48 8d 95 a0 02 00 00 	lea    rdx,[rbp+0x2a0]
   182ebd9c9:	e8 c2 67 1d fe       	call   0x181094190
   182ebd9ce:	90                   	nop
   182ebd9cf:	48 8b 85 10 03 00 00 	mov    rax,QWORD PTR [rbp+0x310]
   182ebd9d6:	48 89 46 70          	mov    QWORD PTR [rsi+0x70],rax
   182ebd9da:	48 8b 85 68 04 00 00 	mov    rax,QWORD PTR [rbp+0x468]
   182ebd9e1:	48 83 40 08 78       	add    QWORD PTR [rax+0x8],0x78
   182ebd9e6:	eb 10                	jmp    0x182ebd9f8
   182ebd9e8:	48 89 f2             	mov    rdx,rsi
   182ebd9eb:	4c 8d 85 a0 02 00 00 	lea    r8,[rbp+0x2a0]
   182ebd9f2:	e8 a9 2e 00 00       	call   0x182ec08a0
   182ebd9f7:	90                   	nop
   182ebd9f8:	48 8b 85 88 03 00 00 	mov    rax,QWORD PTR [rbp+0x388]
   182ebd9ff:	48 83 f8 10          	cmp    rax,0x10
   182ebda03:	48 8b bd d8 00 00 00 	mov    rdi,QWORD PTR [rbp+0xd8]
   182ebda0a:	48 8d b5 a0 02 00 00 	lea    rsi,[rbp+0x2a0]
   182ebda11:	72 34                	jb     0x182ebda47
   182ebda13:	48 8b 8d 70 03 00 00 	mov    rcx,QWORD PTR [rbp+0x370]
   182ebda1a:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182ebda1e:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182ebda25:	72 1b                	jb     0x182ebda42
   182ebda27:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182ebda2b:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182ebda2f:	4c 29 c1             	sub    rcx,r8
   182ebda32:	48 83 f9 20          	cmp    rcx,0x20
   182ebda36:	73 4d                	jae    0x182ebda85
   182ebda38:	48 83 c0 28          	add    rax,0x28
   182ebda3c:	48 89 c2             	mov    rdx,rax
   182ebda3f:	4c 89 c1             	mov    rcx,r8
   182ebda42:	e8 d9 e2 68 04       	call   0x18754bd20
   182ebda47:	48 8b 85 88 04 00 00 	mov    rax,QWORD PTR [rbp+0x488]
   182ebda4e:	48 83 f8 10          	cmp    rax,0x10
   182ebda52:	0f 82 d7 f0 ff ff    	jb     0x182ebcb2f
   182ebda58:	48 8b 8d 70 04 00 00 	mov    rcx,QWORD PTR [rbp+0x470]
   182ebda5f:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182ebda63:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182ebda6a:	0f 82 ba f0 ff ff    	jb     0x182ebcb2a
   182ebda70:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182ebda74:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182ebda78:	4c 29 c1             	sub    rcx,r8
   182ebda7b:	48 83 f9 20          	cmp    rcx,0x20
   182ebda7f:	0f 82 9b f0 ff ff    	jb     0x182ebcb20
   182ebda85:	e8 02 07 82 04       	call   0x1876de18c
   182ebda8a:	48 8b 16             	mov    rdx,QWORD PTR [rsi]
   182ebda8d:	48 8b 46 08          	mov    rax,QWORD PTR [rsi+0x8]
   182ebda91:	48 89 85 68 03 00 00 	mov    QWORD PTR [rbp+0x368],rax
   182ebda98:	0f 28 35 11 91 05 06 	movaps xmm6,XMMWORD PTR [rip+0x6059111]        # 0x188f16bb0
   182ebda9f:	0f 57 ff             	xorps  xmm7,xmm7
   182ebdaa2:	48 8d b5 a0 02 00 00 	lea    rsi,[rbp+0x2a0]
   182ebdaa9:	48 8d bd 80 01 00 00 	lea    rdi,[rbp+0x180]
   182ebdab0:	4c 8d 2d b9 97 05 06 	lea    r13,[rip+0x60597b9]        # 0x188f17270
   182ebdab7:	bb cd cc cc cc       	mov    ebx,0xcccccccd
   182ebdabc:	eb 1a                	jmp    0x182ebdad8
   182ebdabe:	66 90                	xchg   ax,ax
   182ebdac0:	e8 5b e2 68 04       	call   0x18754bd20
   182ebdac5:	48 89 f1             	mov    rcx,rsi
   182ebdac8:	e8 23 6d 1d fe       	call   0x1810947f0
   182ebdacd:	48 8b 95 90 04 00 00 	mov    rdx,QWORD PTR [rbp+0x490]
   182ebdad4:	48 83 c2 70          	add    rdx,0x70
   182ebdad8:	48 3b 95 68 03 00 00 	cmp    rdx,QWORD PTR [rbp+0x368]
   182ebdadf:	0f 84 da 09 00 00    	je     0x182ebe4bf
   182ebdae5:	48 b8 aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaaa
   182ebdaec:	aa aa aa 
   182ebdaef:	48 89 85 10 03 00 00 	mov    QWORD PTR [rbp+0x310],rax
   182ebdaf6:	0f 29 b5 00 03 00 00 	movaps XMMWORD PTR [rbp+0x300],xmm6
   182ebdafd:	0f 29 b5 f0 02 00 00 	movaps XMMWORD PTR [rbp+0x2f0],xmm6
   182ebdb04:	0f 29 b5 e0 02 00 00 	movaps XMMWORD PTR [rbp+0x2e0],xmm6
   182ebdb0b:	0f 29 b5 d0 02 00 00 	movaps XMMWORD PTR [rbp+0x2d0],xmm6
   182ebdb12:	0f 29 b5 c0 02 00 00 	movaps XMMWORD PTR [rbp+0x2c0],xmm6
   182ebdb19:	0f 29 b5 b0 02 00 00 	movaps XMMWORD PTR [rbp+0x2b0],xmm6
   182ebdb20:	0f 29 b5 a0 02 00 00 	movaps XMMWORD PTR [rbp+0x2a0],xmm6
   182ebdb27:	48 89 f1             	mov    rcx,rsi
   182ebdb2a:	48 89 95 90 04 00 00 	mov    QWORD PTR [rbp+0x490],rdx
   182ebdb31:	e8 aa 49 bc fd       	call   0x180a824e0
   182ebdb36:	0f 29 b5 f0 00 00 00 	movaps XMMWORD PTR [rbp+0xf0],xmm6
   182ebdb3d:	0f 29 b5 e0 00 00 00 	movaps XMMWORD PTR [rbp+0xe0],xmm6
   182ebdb44:	48 89 f1             	mov    rcx,rsi
   182ebdb47:	48 8d 95 e0 00 00 00 	lea    rdx,[rbp+0xe0]
   182ebdb4e:	e8 1d 16 00 00       	call   0x182ebf170
   182ebdb53:	90                   	nop
   182ebdb54:	48 89 f1             	mov    rcx,rsi
   182ebdb57:	e8 a4 18 00 00       	call   0x182ebf400
   182ebdb5c:	90                   	nop
   182ebdb5d:	84 c0                	test   al,al
   182ebdb5f:	0f 84 2b 01 00 00    	je     0x182ebdc90
   182ebdb65:	b9 03 00 00 00       	mov    ecx,0x3
   182ebdb6a:	e8 71 f2 1a fd       	call   0x18006cde0
   182ebdb6f:	85 c0                	test   eax,eax
   182ebdb71:	0f 84 ef 08 00 00    	je     0x182ebe466
   182ebdb77:	48 8d 8d 50 02 00 00 	lea    rcx,[rbp+0x250]
   182ebdb7e:	e8 8d f3 1a fd       	call   0x18006cf10
   182ebdb83:	90                   	nop
   182ebdb84:	48 83 bd 68 02 00 00 	cmp    QWORD PTR [rbp+0x268],0x10
   182ebdb8b:	10 
   182ebdb8c:	4c 8d 85 50 02 00 00 	lea    r8,[rbp+0x250]
   182ebdb93:	72 07                	jb     0x182ebdb9c
   182ebdb95:	4c 8b 85 50 02 00 00 	mov    r8,QWORD PTR [rbp+0x250]
   182ebdb9c:	48 8d 05 6d 29 6f 06 	lea    rax,[rip+0x66f296d]        # 0x1895b0510
   182ebdba3:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182ebdba8:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182ebdbaf:	00 00 
   182ebdbb1:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182ebdbb6:	c7 44 24 28 f8 01 00 	mov    DWORD PTR [rsp+0x28],0x1f8
   182ebdbbd:	00 
   182ebdbbe:	48 89 f9             	mov    rcx,rdi
   182ebdbc1:	ba 03 00 00 00       	mov    edx,0x3
   182ebdbc6:	4c 8d 0d 53 21 6f 06 	lea    r9,[rip+0x66f2153]        # 0x1895afd20
   182ebdbcd:	e8 9e f6 1a fd       	call   0x18006d270
   182ebdbd2:	90                   	nop
   182ebdbd3:	48 83 bd f8 00 00 00 	cmp    QWORD PTR [rbp+0xf8],0x10
   182ebdbda:	10 
   182ebdbdb:	48 8d 85 e0 00 00 00 	lea    rax,[rbp+0xe0]
   182ebdbe2:	72 07                	jb     0x182ebdbeb
   182ebdbe4:	48 8b 85 e0 00 00 00 	mov    rax,QWORD PTR [rbp+0xe0]
   182ebdbeb:	48 89 85 18 04 00 00 	mov    QWORD PTR [rbp+0x418],rax
   182ebdbf2:	c6 85 20 04 00 00 00 	mov    BYTE PTR [rbp+0x420],0x0
   182ebdbf9:	4c 8b 8d f0 02 00 00 	mov    r9,QWORD PTR [rbp+0x2f0]
   182ebdc00:	48 c7 85 18 03 00 00 	mov    QWORD PTR [rbp+0x318],0x0
   182ebdc07:	00 00 00 00 
   182ebdc0b:	41 b8 08 00 00 00    	mov    r8d,0x8
   182ebdc11:	4c 89 c9             	mov    rcx,r9
   182ebdc14:	66 66 66 2e 0f 1f 84 	data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebdc1b:	00 00 00 00 00 
   182ebdc20:	48 89 c8             	mov    rax,rcx
   182ebdc23:	49 f7 ee             	imul   r14
   182ebdc26:	48 89 d0             	mov    rax,rdx
   182ebdc29:	48 c1 e8 3f          	shr    rax,0x3f
   182ebdc2d:	48 c1 fa 02          	sar    rdx,0x2
   182ebdc31:	48 01 c2             	add    rdx,rax
   182ebdc34:	48 8d 04 12          	lea    rax,[rdx+rdx*1]
   182ebdc38:	48 8d 04 80          	lea    rax,[rax+rax*4]
   182ebdc3c:	4d 89 ea             	mov    r10,r13
   182ebdc3f:	49 29 c2             	sub    r10,rax
   182ebdc42:	41 0f b6 44 0a 23    	movzx  eax,BYTE PTR [r10+rcx*1+0x23]
   182ebdc48:	42 88 84 05 18 03 00 	mov    BYTE PTR [rbp+r8*1+0x318],al
   182ebdc4f:	00 
   182ebdc50:	49 ff c0             	inc    r8
   182ebdc53:	48 83 c1 09          	add    rcx,0x9
   182ebdc57:	48 83 f9 12          	cmp    rcx,0x12
   182ebdc5b:	48 89 d1             	mov    rcx,rdx
   182ebdc5e:	77 c0                	ja     0x182ebdc20
   182ebdc60:	4d 85 c9             	test   r9,r9
   182ebdc63:	0f 88 9d 02 00 00    	js     0x182ebdf06
   182ebdc69:	42 c6 84 05 18 03 00 	mov    BYTE PTR [rbp+r8*1+0x318],0x0
   182ebdc70:	00 00 
   182ebdc72:	49 83 f8 0a          	cmp    r8,0xa
   182ebdc76:	0f 8d a5 02 00 00    	jge    0x182ebdf21
   182ebdc7c:	e9 d9 02 00 00       	jmp    0x182ebdf5a
   182ebdc81:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebdc88:	0f 1f 84 00 00 00 00 
   182ebdc8f:	00 
   182ebdc90:	0f 29 b5 20 02 00 00 	movaps XMMWORD PTR [rbp+0x220],xmm6
   182ebdc97:	0f 29 b5 10 02 00 00 	movaps XMMWORD PTR [rbp+0x210],xmm6
   182ebdc9e:	48 8d 8d 10 02 00 00 	lea    rcx,[rbp+0x210]
   182ebdca5:	48 89 f2             	mov    rdx,rsi
   182ebdca8:	e8 e3 1a 00 00       	call   0x182ebf790
   182ebdcad:	90                   	nop
   182ebdcae:	44 8b bd e8 02 00 00 	mov    r15d,DWORD PTR [rbp+0x2e8]
   182ebdcb5:	48 83 bd 20 02 00 00 	cmp    QWORD PTR [rbp+0x220],0x0
   182ebdcbc:	00 
   182ebdcbd:	74 56                	je     0x182ebdd15
   182ebdcbf:	48 8d 8d 18 04 00 00 	lea    rcx,[rbp+0x418]
   182ebdcc6:	e8 55 95 18 fd       	call   0x180047220
   182ebdccb:	90                   	nop
   182ebdccc:	48 8b 8d 18 04 00 00 	mov    rcx,QWORD PTR [rbp+0x418]
   182ebdcd3:	48 8d 95 98 03 00 00 	lea    rdx,[rbp+0x398]
   182ebdcda:	e8 f1 46 4c fd       	call   0x1803823d0
   182ebdcdf:	90                   	nop
   182ebdce0:	48 8b 8d 98 03 00 00 	mov    rcx,QWORD PTR [rbp+0x398]
   182ebdce7:	48 89 fa             	mov    rdx,rdi
   182ebdcea:	e8 11 6d ff fd       	call   0x180eb4a00
   182ebdcef:	90                   	nop
   182ebdcf0:	48 8b 8d 80 01 00 00 	mov    rcx,QWORD PTR [rbp+0x180]
   182ebdcf7:	c6 44 24 20 01       	mov    BYTE PTR [rsp+0x20],0x1
   182ebdcfc:	48 8d 95 e0 00 00 00 	lea    rdx,[rbp+0xe0]
   182ebdd03:	4c 8d 85 10 02 00 00 	lea    r8,[rbp+0x210]
   182ebdd0a:	45 89 f9             	mov    r9d,r15d
   182ebdd0d:	e8 9e 84 c1 ff       	call   0x182ad61b0
   182ebdd12:	90                   	nop
   182ebdd13:	eb 4b                	jmp    0x182ebdd60
   182ebdd15:	48 8d 8d 18 04 00 00 	lea    rcx,[rbp+0x418]
   182ebdd1c:	e8 ff 94 18 fd       	call   0x180047220
   182ebdd21:	90                   	nop
   182ebdd22:	48 8b 8d 18 04 00 00 	mov    rcx,QWORD PTR [rbp+0x418]
   182ebdd29:	48 8d 95 98 03 00 00 	lea    rdx,[rbp+0x398]
   182ebdd30:	e8 9b 46 4c fd       	call   0x1803823d0
   182ebdd35:	90                   	nop
   182ebdd36:	48 8b 8d 98 03 00 00 	mov    rcx,QWORD PTR [rbp+0x398]
   182ebdd3d:	48 89 fa             	mov    rdx,rdi
   182ebdd40:	e8 bb 6c ff fd       	call   0x180eb4a00
   182ebdd45:	90                   	nop
   182ebdd46:	48 8b 8d 80 01 00 00 	mov    rcx,QWORD PTR [rbp+0x180]
   182ebdd4d:	48 8d 95 e0 00 00 00 	lea    rdx,[rbp+0xe0]
   182ebdd54:	45 89 f8             	mov    r8d,r15d
   182ebdd57:	41 b1 01             	mov    r9b,0x1
   182ebdd5a:	e8 41 77 c1 ff       	call   0x182ad54a0
   182ebdd5f:	90                   	nop
   182ebdd60:	48 89 85 10 03 00 00 	mov    QWORD PTR [rbp+0x310],rax
   182ebdd67:	48 8b b5 88 01 00 00 	mov    rsi,QWORD PTR [rbp+0x188]
   182ebdd6e:	48 85 f6             	test   rsi,rsi
   182ebdd71:	74 1d                	je     0x182ebdd90
   182ebdd73:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182ebdd77:	75 17                	jne    0x182ebdd90
   182ebdd79:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebdd7c:	48 89 f1             	mov    rcx,rsi
   182ebdd7f:	ff 10                	call   QWORD PTR [rax]
   182ebdd81:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182ebdd85:	75 09                	jne    0x182ebdd90
   182ebdd87:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebdd8a:	48 89 f1             	mov    rcx,rsi
   182ebdd8d:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182ebdd90:	48 8b b5 a0 03 00 00 	mov    rsi,QWORD PTR [rbp+0x3a0]
   182ebdd97:	48 85 f6             	test   rsi,rsi
   182ebdd9a:	74 24                	je     0x182ebddc0
   182ebdd9c:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182ebdda0:	75 1e                	jne    0x182ebddc0
   182ebdda2:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebdda5:	48 89 f1             	mov    rcx,rsi
   182ebdda8:	ff 10                	call   QWORD PTR [rax]
   182ebddaa:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182ebddae:	75 10                	jne    0x182ebddc0
   182ebddb0:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebddb3:	48 89 f1             	mov    rcx,rsi
   182ebddb6:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182ebddb9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
   182ebddc0:	48 8b b5 20 04 00 00 	mov    rsi,QWORD PTR [rbp+0x420]
   182ebddc7:	48 85 f6             	test   rsi,rsi
   182ebddca:	74 24                	je     0x182ebddf0
   182ebddcc:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182ebddd0:	75 1e                	jne    0x182ebddf0
   182ebddd2:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebddd5:	48 89 f1             	mov    rcx,rsi
   182ebddd8:	ff 10                	call   QWORD PTR [rax]
   182ebddda:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182ebddde:	75 10                	jne    0x182ebddf0
   182ebdde0:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182ebdde3:	48 89 f1             	mov    rcx,rsi
   182ebdde6:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182ebdde9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
   182ebddf0:	b9 02 00 00 00       	mov    ecx,0x2
   182ebddf5:	e8 e6 ef 1a fd       	call   0x18006cde0
   182ebddfa:	85 c0                	test   eax,eax
   182ebddfc:	0f 84 ce 05 00 00    	je     0x182ebe3d0
   182ebde02:	48 8d 8d 70 04 00 00 	lea    rcx,[rbp+0x470]
   182ebde09:	e8 02 f1 1a fd       	call   0x18006cf10
   182ebde0e:	90                   	nop
   182ebde0f:	48 83 bd 88 04 00 00 	cmp    QWORD PTR [rbp+0x488],0x10
   182ebde16:	10 
   182ebde17:	4c 8d 85 70 04 00 00 	lea    r8,[rbp+0x470]
   182ebde1e:	72 07                	jb     0x182ebde27
   182ebde20:	4c 8b 85 70 04 00 00 	mov    r8,QWORD PTR [rbp+0x470]
   182ebde27:	48 8d 05 e2 26 6f 06 	lea    rax,[rip+0x66f26e2]        # 0x1895b0510
   182ebde2e:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182ebde33:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182ebde3a:	00 00 
   182ebde3c:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182ebde41:	c7 44 24 28 08 02 00 	mov    DWORD PTR [rsp+0x28],0x208
   182ebde48:	00 
   182ebde49:	48 89 f9             	mov    rcx,rdi
   182ebde4c:	ba 02 00 00 00       	mov    edx,0x2
   182ebde51:	4c 8d 0d c8 1e 6f 06 	lea    r9,[rip+0x66f1ec8]        # 0x1895afd20
   182ebde58:	e8 13 f4 1a fd       	call   0x18006d270
   182ebde5d:	90                   	nop
   182ebde5e:	48 83 bd 28 02 00 00 	cmp    QWORD PTR [rbp+0x228],0x10
   182ebde65:	10 
   182ebde66:	48 8d 85 10 02 00 00 	lea    rax,[rbp+0x210]
   182ebde6d:	72 07                	jb     0x182ebde76
   182ebde6f:	48 8b 85 10 02 00 00 	mov    rax,QWORD PTR [rbp+0x210]
   182ebde76:	48 89 85 18 04 00 00 	mov    QWORD PTR [rbp+0x418],rax
   182ebde7d:	c6 85 20 04 00 00 00 	mov    BYTE PTR [rbp+0x420],0x0
   182ebde84:	8b 8d b4 02 00 00    	mov    ecx,DWORD PTR [rbp+0x2b4]
   182ebde8a:	48 c7 85 18 03 00 00 	mov    QWORD PTR [rbp+0x318],0x0
   182ebde91:	00 00 00 00 
   182ebde95:	b8 08 00 00 00       	mov    eax,0x8
   182ebde9a:	89 ca                	mov    edx,ecx
   182ebde9c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
   182ebdea0:	4c 63 c2             	movsxd r8,edx
   182ebdea3:	49 69 d0 67 66 66 66 	imul   rdx,r8,0x66666667
   182ebdeaa:	49 89 d1             	mov    r9,rdx
   182ebdead:	49 c1 e9 3f          	shr    r9,0x3f
   182ebdeb1:	48 c1 fa 22          	sar    rdx,0x22
   182ebdeb5:	44 01 ca             	add    edx,r9d
   182ebdeb8:	44 8d 0c 12          	lea    r9d,[rdx+rdx*1]
   182ebdebc:	47 8d 0c 89          	lea    r9d,[r9+r9*4]
   182ebdec0:	41 f7 d9             	neg    r9d
   182ebdec3:	45 01 c1             	add    r9d,r8d
   182ebdec6:	41 83 c1 23          	add    r9d,0x23
   182ebdeca:	4d 63 c9             	movsxd r9,r9d
   182ebdecd:	47 0f b6 0c 29       	movzx  r9d,BYTE PTR [r9+r13*1]
   182ebded2:	44 88 8c 05 18 03 00 	mov    BYTE PTR [rbp+rax*1+0x318],r9b
   182ebded9:	00 
   182ebdeda:	48 ff c0             	inc    rax
   182ebdedd:	41 83 c0 09          	add    r8d,0x9
   182ebdee1:	41 83 f8 12          	cmp    r8d,0x12
   182ebdee5:	77 b9                	ja     0x182ebdea0
   182ebdee7:	85 c9                	test   ecx,ecx
   182ebdee9:	0f 88 08 01 00 00    	js     0x182ebdff7
   182ebdeef:	c6 84 05 18 03 00 00 	mov    BYTE PTR [rbp+rax*1+0x318],0x0
   182ebdef6:	00 
   182ebdef7:	48 83 f8 0a          	cmp    rax,0xa
   182ebdefb:	0f 8d 0f 01 00 00    	jge    0x182ebe010
   182ebdf01:	e9 44 01 00 00       	jmp    0x182ebe04a
   182ebdf06:	42 c6 84 05 18 03 00 	mov    BYTE PTR [rbp+r8*1+0x318],0x2d
   182ebdf0d:	00 2d 
   182ebdf0f:	49 ff c0             	inc    r8
   182ebdf12:	42 c6 84 05 18 03 00 	mov    BYTE PTR [rbp+r8*1+0x318],0x0
   182ebdf19:	00 00 
   182ebdf1b:	49 83 f8 0a          	cmp    r8,0xa
   182ebdf1f:	7c 39                	jl     0x182ebdf5a
   182ebdf21:	49 8d 04 28          	lea    rax,[r8+rbp*1]
   182ebdf25:	48 05 18 03 00 00    	add    rax,0x318
   182ebdf2b:	48 ff c8             	dec    rax
   182ebdf2e:	48 8d 8d 21 03 00 00 	lea    rcx,[rbp+0x321]
   182ebdf35:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebdf3c:	00 00 00 00 
   182ebdf40:	0f b6 10             	movzx  edx,BYTE PTR [rax]
   182ebdf43:	44 0f b6 41 ff       	movzx  r8d,BYTE PTR [rcx-0x1]
   182ebdf48:	44 88 00             	mov    BYTE PTR [rax],r8b
   182ebdf4b:	88 51 ff             	mov    BYTE PTR [rcx-0x1],dl
   182ebdf4e:	48 ff c8             	dec    rax
   182ebdf51:	48 39 c1             	cmp    rcx,rax
   182ebdf54:	48 8d 49 01          	lea    rcx,[rcx+0x1]
   182ebdf58:	72 e6                	jb     0x182ebdf40
   182ebdf5a:	48 8d 85 20 03 00 00 	lea    rax,[rbp+0x320]
   182ebdf61:	48 89 85 18 03 00 00 	mov    QWORD PTR [rbp+0x318],rax
   182ebdf68:	48 8d 85 d0 03 00 00 	lea    rax,[rbp+0x3d0]
   182ebdf6f:	0f 11 78 38          	movups XMMWORD PTR [rax+0x38],xmm7
   182ebdf73:	0f 11 78 28          	movups XMMWORD PTR [rax+0x28],xmm7
   182ebdf77:	0f 11 78 18          	movups XMMWORD PTR [rax+0x18],xmm7
   182ebdf7b:	0f 11 78 08          	movups XMMWORD PTR [rax+0x8],xmm7
   182ebdf7f:	0f 11 78 f8          	movups XMMWORD PTR [rax-0x8],xmm7
   182ebdf83:	0f 11 78 e8          	movups XMMWORD PTR [rax-0x18],xmm7
   182ebdf87:	0f 11 78 d8          	movups XMMWORD PTR [rax-0x28],xmm7
   182ebdf8b:	48 8d 85 18 03 00 00 	lea    rax,[rbp+0x318]
   182ebdf92:	48 89 85 98 03 00 00 	mov    QWORD PTR [rbp+0x398],rax
   182ebdf99:	48 8d 85 18 04 00 00 	lea    rax,[rbp+0x418]
   182ebdfa0:	48 89 85 a0 03 00 00 	mov    QWORD PTR [rbp+0x3a0],rax
   182ebdfa7:	49 89 ff             	mov    r15,rdi
   182ebdfaa:	48 89 f9             	mov    rcx,rdi
   182ebdfad:	48 8d 15 ac 27 6f 06 	lea    rdx,[rip+0x66f27ac]        # 0x1895b0760
   182ebdfb4:	4c 8d 85 98 03 00 00 	lea    r8,[rbp+0x398]
   182ebdfbb:	e8 50 f8 1a fd       	call   0x18006d810
   182ebdfc0:	90                   	nop
   182ebdfc1:	4c 89 f9             	mov    rcx,r15
   182ebdfc4:	e8 a7 f3 1a fd       	call   0x18006d370
   182ebdfc9:	48 8b 85 68 02 00 00 	mov    rax,QWORD PTR [rbp+0x268]
   182ebdfd0:	48 83 f8 10          	cmp    rax,0x10
   182ebdfd4:	0f 82 8c 04 00 00    	jb     0x182ebe466
   182ebdfda:	48 8b 8d 50 02 00 00 	mov    rcx,QWORD PTR [rbp+0x250]
   182ebdfe1:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182ebdfe5:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182ebdfec:	0f 83 50 04 00 00    	jae    0x182ebe442
   182ebdff2:	e9 6a 04 00 00       	jmp    0x182ebe461
   182ebdff7:	c6 84 05 18 03 00 00 	mov    BYTE PTR [rbp+rax*1+0x318],0x2d
   182ebdffe:	2d 
   182ebdfff:	48 ff c0             	inc    rax
   182ebe002:	c6 84 05 18 03 00 00 	mov    BYTE PTR [rbp+rax*1+0x318],0x0
   182ebe009:	00 
   182ebe00a:	48 83 f8 0a          	cmp    rax,0xa
   182ebe00e:	7c 3a                	jl     0x182ebe04a
   182ebe010:	48 01 e8             	add    rax,rbp
   182ebe013:	48 05 18 03 00 00    	add    rax,0x318
   182ebe019:	48 ff c8             	dec    rax
   182ebe01c:	48 8d 8d 21 03 00 00 	lea    rcx,[rbp+0x321]
   182ebe023:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebe02a:	84 00 00 00 00 00 
   182ebe030:	0f b6 10             	movzx  edx,BYTE PTR [rax]
   182ebe033:	44 0f b6 41 ff       	movzx  r8d,BYTE PTR [rcx-0x1]
   182ebe038:	44 88 00             	mov    BYTE PTR [rax],r8b
   182ebe03b:	88 51 ff             	mov    BYTE PTR [rcx-0x1],dl
   182ebe03e:	48 ff c8             	dec    rax
   182ebe041:	48 39 c1             	cmp    rcx,rax
   182ebe044:	48 8d 49 01          	lea    rcx,[rcx+0x1]
   182ebe048:	72 e6                	jb     0x182ebe030
   182ebe04a:	48 8d 85 20 03 00 00 	lea    rax,[rbp+0x320]
   182ebe051:	48 89 85 18 03 00 00 	mov    QWORD PTR [rbp+0x318],rax
   182ebe058:	48 83 bd f8 00 00 00 	cmp    QWORD PTR [rbp+0xf8],0x10
   182ebe05f:	10 
   182ebe060:	48 8d 85 e0 00 00 00 	lea    rax,[rbp+0xe0]
   182ebe067:	72 07                	jb     0x182ebe070
   182ebe069:	48 8b 85 e0 00 00 00 	mov    rax,QWORD PTR [rbp+0xe0]
   182ebe070:	48 89 85 50 02 00 00 	mov    QWORD PTR [rbp+0x250],rax
   182ebe077:	c6 85 58 02 00 00 00 	mov    BYTE PTR [rbp+0x258],0x0
   182ebe07e:	8b 95 ec 02 00 00    	mov    edx,DWORD PTR [rbp+0x2ec]
   182ebe084:	48 c7 45 18 00 00 00 	mov    QWORD PTR [rbp+0x18],0x0
   182ebe08b:	00 
   182ebe08c:	b8 07 00 00 00       	mov    eax,0x7
   182ebe091:	48 8d 4d 1f          	lea    rcx,[rbp+0x1f]
   182ebe095:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebe09c:	00 00 00 00 
   182ebe0a0:	41 89 d0             	mov    r8d,edx
   182ebe0a3:	4c 0f af c3          	imul   r8,rbx
   182ebe0a7:	49 c1 e8 23          	shr    r8,0x23
   182ebe0ab:	47 8d 0c 00          	lea    r9d,[r8+r8*1]
   182ebe0af:	47 8d 0c 89          	lea    r9d,[r9+r9*4]
   182ebe0b3:	41 f7 d9             	neg    r9d
   182ebe0b6:	41 01 d1             	add    r9d,edx
   182ebe0b9:	41 83 c1 23          	add    r9d,0x23
   182ebe0bd:	47 0f b6 0c 29       	movzx  r9d,BYTE PTR [r9+r13*1]
   182ebe0c2:	44 88 49 01          	mov    BYTE PTR [rcx+0x1],r9b
   182ebe0c6:	48 ff c1             	inc    rcx
   182ebe0c9:	48 ff c0             	inc    rax
   182ebe0cc:	83 fa 09             	cmp    edx,0x9
   182ebe0cf:	44 89 c2             	mov    edx,r8d
   182ebe0d2:	77 cc                	ja     0x182ebe0a0
   182ebe0d4:	c6 41 01 00          	mov    BYTE PTR [rcx+0x1],0x0
   182ebe0d8:	48 83 f8 09          	cmp    rax,0x9
   182ebe0dc:	72 2c                	jb     0x182ebe10a
   182ebe0de:	48 8d 45 21          	lea    rax,[rbp+0x21]
   182ebe0e2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebe0e9:	1f 84 00 00 00 00 00 
   182ebe0f0:	0f b6 11             	movzx  edx,BYTE PTR [rcx]
   182ebe0f3:	44 0f b6 40 ff       	movzx  r8d,BYTE PTR [rax-0x1]
   182ebe0f8:	44 88 01             	mov    BYTE PTR [rcx],r8b
   182ebe0fb:	48 ff c9             	dec    rcx
   182ebe0fe:	88 50 ff             	mov    BYTE PTR [rax-0x1],dl
   182ebe101:	48 39 c8             	cmp    rax,rcx
   182ebe104:	48 8d 40 01          	lea    rax,[rax+0x1]
   182ebe108:	72 e6                	jb     0x182ebe0f0
   182ebe10a:	48 8d 45 20          	lea    rax,[rbp+0x20]
   182ebe10e:	48 89 45 18          	mov    QWORD PTR [rbp+0x18],rax
   182ebe112:	4c 8b 8d f0 02 00 00 	mov    r9,QWORD PTR [rbp+0x2f0]
   182ebe119:	48 c7 85 30 01 00 00 	mov    QWORD PTR [rbp+0x130],0x0
   182ebe120:	00 00 00 00 
   182ebe124:	41 b8 08 00 00 00    	mov    r8d,0x8
   182ebe12a:	4c 89 c9             	mov    rcx,r9
   182ebe12d:	0f 1f 00             	nop    DWORD PTR [rax]
   182ebe130:	48 89 c8             	mov    rax,rcx
   182ebe133:	49 f7 ee             	imul   r14
   182ebe136:	48 89 d0             	mov    rax,rdx
   182ebe139:	48 c1 e8 3f          	shr    rax,0x3f
   182ebe13d:	48 c1 fa 02          	sar    rdx,0x2
   182ebe141:	48 01 c2             	add    rdx,rax
   182ebe144:	48 8d 04 12          	lea    rax,[rdx+rdx*1]
   182ebe148:	48 8d 04 80          	lea    rax,[rax+rax*4]
   182ebe14c:	4d 89 ea             	mov    r10,r13
   182ebe14f:	49 29 c2             	sub    r10,rax
   182ebe152:	41 0f b6 44 0a 23    	movzx  eax,BYTE PTR [r10+rcx*1+0x23]
   182ebe158:	42 88 84 05 30 01 00 	mov    BYTE PTR [rbp+r8*1+0x130],al
   182ebe15f:	00 
   182ebe160:	49 ff c0             	inc    r8
   182ebe163:	48 83 c1 09          	add    rcx,0x9
   182ebe167:	48 83 f9 12          	cmp    rcx,0x12
   182ebe16b:	48 89 d1             	mov    rcx,rdx
   182ebe16e:	77 c0                	ja     0x182ebe130
   182ebe170:	4d 85 c9             	test   r9,r9
   182ebe173:	78 11                	js     0x182ebe186
   182ebe175:	42 c6 84 05 30 01 00 	mov    BYTE PTR [rbp+r8*1+0x130],0x0
   182ebe17c:	00 00 
   182ebe17e:	49 83 f8 0a          	cmp    r8,0xa
   182ebe182:	7d 1d                	jge    0x182ebe1a1
   182ebe184:	eb 54                	jmp    0x182ebe1da
   182ebe186:	42 c6 84 05 30 01 00 	mov    BYTE PTR [rbp+r8*1+0x130],0x2d
   182ebe18d:	00 2d 
   182ebe18f:	49 ff c0             	inc    r8
   182ebe192:	42 c6 84 05 30 01 00 	mov    BYTE PTR [rbp+r8*1+0x130],0x0
   182ebe199:	00 00 
   182ebe19b:	49 83 f8 0a          	cmp    r8,0xa
   182ebe19f:	7c 39                	jl     0x182ebe1da
   182ebe1a1:	49 8d 04 28          	lea    rax,[r8+rbp*1]
   182ebe1a5:	48 05 30 01 00 00    	add    rax,0x130
   182ebe1ab:	48 ff c8             	dec    rax
   182ebe1ae:	48 8d 8d 39 01 00 00 	lea    rcx,[rbp+0x139]
   182ebe1b5:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebe1bc:	00 00 00 00 
   182ebe1c0:	0f b6 10             	movzx  edx,BYTE PTR [rax]
   182ebe1c3:	44 0f b6 41 ff       	movzx  r8d,BYTE PTR [rcx-0x1]
   182ebe1c8:	44 88 00             	mov    BYTE PTR [rax],r8b
   182ebe1cb:	88 51 ff             	mov    BYTE PTR [rcx-0x1],dl
   182ebe1ce:	48 ff c8             	dec    rax
   182ebe1d1:	48 39 c1             	cmp    rcx,rax
   182ebe1d4:	48 8d 49 01          	lea    rcx,[rcx+0x1]
   182ebe1d8:	72 e6                	jb     0x182ebe1c0
   182ebe1da:	48 8d 85 38 01 00 00 	lea    rax,[rbp+0x138]
   182ebe1e1:	48 89 85 30 01 00 00 	mov    QWORD PTR [rbp+0x130],rax
   182ebe1e8:	48 c7 45 68 00 00 00 	mov    QWORD PTR [rbp+0x68],0x0
   182ebe1ef:	00 
   182ebe1f0:	b8 07 00 00 00       	mov    eax,0x7
   182ebe1f5:	48 8d 4d 6f          	lea    rcx,[rbp+0x6f]
   182ebe1f9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
   182ebe200:	44 89 fa             	mov    edx,r15d
   182ebe203:	48 0f af d3          	imul   rdx,rbx
   182ebe207:	48 c1 ea 23          	shr    rdx,0x23
   182ebe20b:	44 8d 04 12          	lea    r8d,[rdx+rdx*1]
   182ebe20f:	47 8d 04 80          	lea    r8d,[r8+r8*4]
   182ebe213:	41 f7 d8             	neg    r8d
   182ebe216:	45 01 f8             	add    r8d,r15d
   182ebe219:	41 83 c0 23          	add    r8d,0x23
   182ebe21d:	47 0f b6 04 28       	movzx  r8d,BYTE PTR [r8+r13*1]
   182ebe222:	44 88 41 01          	mov    BYTE PTR [rcx+0x1],r8b
   182ebe226:	48 ff c1             	inc    rcx
   182ebe229:	48 ff c0             	inc    rax
   182ebe22c:	41 83 ff 09          	cmp    r15d,0x9
   182ebe230:	41 89 d7             	mov    r15d,edx
   182ebe233:	77 cb                	ja     0x182ebe200
   182ebe235:	c6 41 01 00          	mov    BYTE PTR [rcx+0x1],0x0
   182ebe239:	48 83 f8 09          	cmp    rax,0x9
   182ebe23d:	72 2b                	jb     0x182ebe26a
   182ebe23f:	48 8d 45 71          	lea    rax,[rbp+0x71]
   182ebe243:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   182ebe24a:	84 00 00 00 00 00 
   182ebe250:	0f b6 11             	movzx  edx,BYTE PTR [rcx]
   182ebe253:	44 0f b6 40 ff       	movzx  r8d,BYTE PTR [rax-0x1]
   182ebe258:	44 88 01             	mov    BYTE PTR [rcx],r8b
   182ebe25b:	48 ff c9             	dec    rcx
   182ebe25e:	88 50 ff             	mov    BYTE PTR [rax-0x1],dl
   182ebe261:	48 39 c8             	cmp    rax,rcx
   182ebe264:	48 8d 40 01          	lea    rax,[rax+0x1]
   182ebe268:	72 e6                	jb     0x182ebe250
   182ebe26a:	48 8d 45 70          	lea    rax,[rbp+0x70]
   182ebe26e:	48 89 45 68          	mov    QWORD PTR [rbp+0x68],rax
   182ebe272:	48 8b 8d 10 03 00 00 	mov    rcx,QWORD PTR [rbp+0x310]
   182ebe279:	48 c7 45 c8 00 00 00 	mov    QWORD PTR [rbp-0x38],0x0
   182ebe280:	00 
   182ebe281:	41 b9 07 00 00 00    	mov    r9d,0x7
   182ebe287:	4c 8d 45 cf          	lea    r8,[rbp-0x31]
   182ebe28b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
   182ebe290:	48 89 c8             	mov    rax,rcx
   182ebe293:	49 f7 e4             	mul    r12
   182ebe296:	48 c1 ea 03          	shr    rdx,0x3
   182ebe29a:	48 8d 04 12          	lea    rax,[rdx+rdx*1]
   182ebe29e:	48 8d 04 80          	lea    rax,[rax+rax*4]
   182ebe2a2:	4d 89 ea             	mov    r10,r13
   182ebe2a5:	49 29 c2             	sub    r10,rax
   182ebe2a8:	41 0f b6 44 0a 23    	movzx  eax,BYTE PTR [r10+rcx*1+0x23]
   182ebe2ae:	41 88 40 01          	mov    BYTE PTR [r8+0x1],al
   182ebe2b2:	49 ff c0             	inc    r8
   182ebe2b5:	49 ff c1             	inc    r9
   182ebe2b8:	48 83 f9 09          	cmp    rcx,0x9
   182ebe2bc:	48 89 d1             	mov    rcx,rdx
   182ebe2bf:	77 cf                	ja     0x182ebe290
   182ebe2c1:	41 c6 40 01 00       	mov    BYTE PTR [r8+0x1],0x0
   182ebe2c6:	49 83 f9 09          	cmp    r9,0x9
   182ebe2ca:	72 1e                	jb     0x182ebe2ea
   182ebe2cc:	48 8d 45 d1          	lea    rax,[rbp-0x2f]
   182ebe2d0:	41 0f b6 08          	movzx  ecx,BYTE PTR [r8]
   182ebe2d4:	0f b6 50 ff          	movzx  edx,BYTE PTR [rax-0x1]
   182ebe2d8:	41 88 10             	mov    BYTE PTR [r8],dl
   182ebe2db:	49 ff c8             	dec    r8
   182ebe2de:	88 48 ff             	mov    BYTE PTR [rax-0x1],cl
   182ebe2e1:	4c 39 c0             	cmp    rax,r8
   182ebe2e4:	48 8d 40 01          	lea    rax,[rax+0x1]
   182ebe2e8:	72 e6                	jb     0x182ebe2d0
   182ebe2ea:	48 8d 45 d0          	lea    rax,[rbp-0x30]
   182ebe2ee:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
   182ebe2f2:	48 8d 45 c8          	lea    rax,[rbp-0x38]
   182ebe2f6:	48 89 85 98 03 00 00 	mov    QWORD PTR [rbp+0x398],rax
   182ebe2fd:	48 8d 45 68          	lea    rax,[rbp+0x68]
   182ebe301:	48 89 85 a0 03 00 00 	mov    QWORD PTR [rbp+0x3a0],rax
   182ebe308:	48 8d 85 30 01 00 00 	lea    rax,[rbp+0x130]
   182ebe30f:	48 89 85 a8 03 00 00 	mov    QWORD PTR [rbp+0x3a8],rax
   182ebe316:	48 8d 45 18          	lea    rax,[rbp+0x18]
   182ebe31a:	48 89 85 b0 03 00 00 	mov    QWORD PTR [rbp+0x3b0],rax
   182ebe321:	48 8d 85 50 02 00 00 	lea    rax,[rbp+0x250]
   182ebe328:	48 89 85 b8 03 00 00 	mov    QWORD PTR [rbp+0x3b8],rax
   182ebe32f:	48 8d 85 18 03 00 00 	lea    rax,[rbp+0x318]
   182ebe336:	48 89 85 c0 03 00 00 	mov    QWORD PTR [rbp+0x3c0],rax
   182ebe33d:	48 8d 85 18 04 00 00 	lea    rax,[rbp+0x418]
   182ebe344:	48 89 85 c8 03 00 00 	mov    QWORD PTR [rbp+0x3c8],rax
   182ebe34b:	48 8d 85 d0 03 00 00 	lea    rax,[rbp+0x3d0]
   182ebe352:	0f 11 78 30          	movups XMMWORD PTR [rax+0x30],xmm7
   182ebe356:	0f 11 78 20          	movups XMMWORD PTR [rax+0x20],xmm7
   182ebe35a:	0f 11 78 10          	movups XMMWORD PTR [rax+0x10],xmm7
   182ebe35e:	0f 11 38             	movups XMMWORD PTR [rax],xmm7
   182ebe361:	48 c7 40 40 00 00 00 	mov    QWORD PTR [rax+0x40],0x0
   182ebe368:	00 
   182ebe369:	48 89 fe             	mov    rsi,rdi
   182ebe36c:	48 89 f9             	mov    rcx,rdi
   182ebe36f:	48 8d 15 ca 1d 6f 06 	lea    rdx,[rip+0x66f1dca]        # 0x1895b0140
   182ebe376:	4c 8d 85 98 03 00 00 	lea    r8,[rbp+0x398]
   182ebe37d:	e8 8e f4 1a fd       	call   0x18006d810
   182ebe382:	90                   	nop
   182ebe383:	48 89 f1             	mov    rcx,rsi
   182ebe386:	e8 e5 ef 1a fd       	call   0x18006d370
   182ebe38b:	48 8b 85 88 04 00 00 	mov    rax,QWORD PTR [rbp+0x488]
   182ebe392:	48 83 f8 10          	cmp    rax,0x10
   182ebe396:	72 38                	jb     0x182ebe3d0
   182ebe398:	48 8b 8d 70 04 00 00 	mov    rcx,QWORD PTR [rbp+0x470]
   182ebe39f:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182ebe3a3:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182ebe3aa:	72 1f                	jb     0x182ebe3cb
   182ebe3ac:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182ebe3b0:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182ebe3b4:	4c 29 c1             	sub    rcx,r8
   182ebe3b7:	48 83 f9 20          	cmp    rcx,0x20
   182ebe3bb:	0f 83 c4 f6 ff ff    	jae    0x182ebda85
   182ebe3c1:	48 83 c0 28          	add    rax,0x28
   182ebe3c5:	48 89 c2             	mov    rdx,rax
   182ebe3c8:	4c 89 c1             	mov    rcx,r8
   182ebe3cb:	e8 50 d9 68 04       	call   0x18754bd20
   182ebe3d0:	48 8b 8d 68 04 00 00 	mov    rcx,QWORD PTR [rbp+0x468]
   182ebe3d7:	48 8b 71 08          	mov    rsi,QWORD PTR [rcx+0x8]
   182ebe3db:	48 3b 71 10          	cmp    rsi,QWORD PTR [rcx+0x10]
   182ebe3df:	74 29                	je     0x182ebe40a
   182ebe3e1:	48 89 f1             	mov    rcx,rsi
   182ebe3e4:	48 8d 95 a0 02 00 00 	lea    rdx,[rbp+0x2a0]
   182ebe3eb:	e8 a0 5d 1d fe       	call   0x181094190
   182ebe3f0:	90                   	nop
   182ebe3f1:	48 8b 85 10 03 00 00 	mov    rax,QWORD PTR [rbp+0x310]
   182ebe3f8:	48 89 46 70          	mov    QWORD PTR [rsi+0x70],rax
   182ebe3fc:	48 8b 85 68 04 00 00 	mov    rax,QWORD PTR [rbp+0x468]
   182ebe403:	48 83 40 08 78       	add    QWORD PTR [rax+0x8],0x78
   182ebe408:	eb 10                	jmp    0x182ebe41a
   182ebe40a:	48 89 f2             	mov    rdx,rsi
   182ebe40d:	4c 8d 85 a0 02 00 00 	lea    r8,[rbp+0x2a0]
   182ebe414:	e8 87 24 00 00       	call   0x182ec08a0
   182ebe419:	90                   	nop
   182ebe41a:	48 8b 85 28 02 00 00 	mov    rax,QWORD PTR [rbp+0x228]
   182ebe421:	48 83 f8 10          	cmp    rax,0x10
   182ebe425:	48 8d b5 a0 02 00 00 	lea    rsi,[rbp+0x2a0]
   182ebe42c:	72 38                	jb     0x182ebe466
   182ebe42e:	48 8b 8d 10 02 00 00 	mov    rcx,QWORD PTR [rbp+0x210]
   182ebe435:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182ebe439:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182ebe440:	72 1f                	jb     0x182ebe461
   182ebe442:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182ebe446:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182ebe44a:	4c 29 c1             	sub    rcx,r8
   182ebe44d:	48 83 f9 20          	cmp    rcx,0x20
   182ebe451:	0f 83 2e f6 ff ff    	jae    0x182ebda85
   182ebe457:	48 83 c0 28          	add    rax,0x28
   182ebe45b:	48 89 c2             	mov    rdx,rax
   182ebe45e:	4c 89 c1             	mov    rcx,r8
   182ebe461:	e8 ba d8 68 04       	call   0x18754bd20
   182ebe466:	48 8b 85 f8 00 00 00 	mov    rax,QWORD PTR [rbp+0xf8]
   182ebe46d:	48 83 f8 10          	cmp    rax,0x10
   182ebe471:	0f 82 4e f6 ff ff    	jb     0x182ebdac5
   182ebe477:	48 8b 8d e0 00 00 00 	mov    rcx,QWORD PTR [rbp+0xe0]
   182ebe47e:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182ebe482:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182ebe489:	0f 82 31 f6 ff ff    	jb     0x182ebdac0
   182ebe48f:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182ebe493:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182ebe497:	4c 29 c1             	sub    rcx,r8
   182ebe49a:	48 83 f9 20          	cmp    rcx,0x20
   182ebe49e:	0f 83 e1 f5 ff ff    	jae    0x182ebda85
   182ebe4a4:	48 83 c0 28          	add    rax,0x28
   182ebe4a8:	48 89 c2             	mov    rdx,rax
   182ebe4ab:	4c 89 c1             	mov    rcx,r8
   182ebe4ae:	e9 0d f6 ff ff       	jmp    0x182ebdac0
   182ebe4b3:	48 8d 8d 10 02 00 00 	lea    rcx,[rbp+0x210]
   182ebe4ba:	e8 c1 91 1f fd       	call   0x1800b7680
   182ebe4bf:	0f 28 b5 a0 04 00 00 	movaps xmm6,XMMWORD PTR [rbp+0x4a0]
   182ebe4c6:	0f 28 bd b0 04 00 00 	movaps xmm7,XMMWORD PTR [rbp+0x4b0]
   182ebe4cd:	48 81 c4 48 05 00 00 	add    rsp,0x548
   182ebe4d4:	5b                   	pop    rbx
   182ebe4d5:	5f                   	pop    rdi
   182ebe4d6:	5e                   	pop    rsi
   182ebe4d7:	41 5c                	pop    r12
   182ebe4d9:	41 5d                	pop    r13
   182ebe4db:	41 5e                	pop    r14
   182ebe4dd:	41 5f                	pop    r15
   182ebe4df:	5d                   	pop    rbp
   182ebe4e0:	c3                   	ret
