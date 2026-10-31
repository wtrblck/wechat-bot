
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

000000018032e7e0 <.text+0x32d7e0>:
   18032e7e0:	55                   	push   rbp
   18032e7e1:	41 57                	push   r15
   18032e7e3:	41 56                	push   r14
   18032e7e5:	41 55                	push   r13
   18032e7e7:	41 54                	push   r12
   18032e7e9:	56                   	push   rsi
   18032e7ea:	57                   	push   rdi
   18032e7eb:	53                   	push   rbx
   18032e7ec:	48 81 ec c8 00 00 00 	sub    rsp,0xc8
   18032e7f3:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   18032e7fa:	00 
   18032e7fb:	48 c7 45 40 fe ff ff 	mov    QWORD PTR [rbp+0x40],0xfffffffffffffffe
   18032e802:	ff 
   18032e803:	4c 89 c3             	mov    rbx,r8
   18032e806:	48 89 d7             	mov    rdi,rdx
   18032e809:	49 89 ce             	mov    r14,rcx
   18032e80c:	49 8b 00             	mov    rax,QWORD PTR [r8]
   18032e80f:	4c 89 c1             	mov    rcx,r8
   18032e812:	ff 50 08             	call   QWORD PTR [rax+0x8]
   18032e815:	0f 57 c0             	xorps  xmm0,xmm0
   18032e818:	0f 29 45 20          	movaps XMMWORD PTR [rbp+0x20],xmm0
   18032e81c:	48 89 45 08          	mov    QWORD PTR [rbp+0x8],rax
   18032e820:	48 89 c1             	mov    rcx,rax
   18032e823:	e8 78 6b 3c 07       	call   0x1876f53a0
   18032e828:	48 85 c0             	test   rax,rax
   18032e82b:	0f 88 28 03 00 00    	js     0x18032eb59
   18032e831:	49 89 c4             	mov    r12,rax
   18032e834:	4c 8d 7d 20          	lea    r15,[rbp+0x20]
   18032e838:	be 0f 00 00 00       	mov    esi,0xf
   18032e83d:	4d 89 fd             	mov    r13,r15
   18032e840:	48 83 f8 10          	cmp    rax,0x10
   18032e844:	72 4f                	jb     0x18032e895
   18032e846:	4c 89 e0             	mov    rax,r12
   18032e849:	48 83 c8 0f          	or     rax,0xf
   18032e84d:	48 83 f8 17          	cmp    rax,0x17
   18032e851:	be 16 00 00 00       	mov    esi,0x16
   18032e856:	48 0f 43 f0          	cmovae rsi,rax
   18032e85a:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   18032e860:	72 23                	jb     0x18032e885
   18032e862:	48 8d 4e 28          	lea    rcx,[rsi+0x28]
   18032e866:	e8 71 d4 21 07       	call   0x18754bcdc
   18032e86b:	48 85 c0             	test   rax,rax
   18032e86e:	0f 84 ea 02 00 00    	je     0x18032eb5e
   18032e874:	49 89 c5             	mov    r13,rax
   18032e877:	49 83 c5 27          	add    r13,0x27
   18032e87b:	49 83 e5 e0          	and    r13,0xffffffffffffffe0
   18032e87f:	49 89 45 f8          	mov    QWORD PTR [r13-0x8],rax
   18032e883:	eb 0c                	jmp    0x18032e891
   18032e885:	48 8d 4e 01          	lea    rcx,[rsi+0x1]
   18032e889:	e8 4e d4 21 07       	call   0x18754bcdc
   18032e88e:	49 89 c5             	mov    r13,rax
   18032e891:	4c 89 6d 20          	mov    QWORD PTR [rbp+0x20],r13
   18032e895:	4c 89 65 30          	mov    QWORD PTR [rbp+0x30],r12
   18032e899:	48 89 75 38          	mov    QWORD PTR [rbp+0x38],rsi
   18032e89d:	4c 89 e9             	mov    rcx,r13
   18032e8a0:	48 8b 55 08          	mov    rdx,QWORD PTR [rbp+0x8]
   18032e8a4:	4d 89 e0             	mov    r8,r12
   18032e8a7:	e8 94 65 3e 07       	call   0x187714e40
   18032e8ac:	43 c6 44 25 00 00    	mov    BYTE PTR [r13+r12*1+0x0],0x0
   18032e8b2:	4c 8b 65 20          	mov    r12,QWORD PTR [rbp+0x20]
   18032e8b6:	4c 8b 6d 30          	mov    r13,QWORD PTR [rbp+0x30]
   18032e8ba:	48 8b 75 38          	mov    rsi,QWORD PTR [rbp+0x38]
   18032e8be:	48 83 fe 10          	cmp    rsi,0x10
   18032e8c2:	4d 0f 43 fc          	cmovae r15,r12
   18032e8c6:	4d 85 ed             	test   r13,r13
   18032e8c9:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
   18032e8cd:	48 89 5d 10          	mov    QWORD PTR [rbp+0x10],rbx
   18032e8d1:	74 25                	je     0x18032e8f8
   18032e8d3:	44 89 e8             	mov    eax,r13d
   18032e8d6:	83 e0 03             	and    eax,0x3
   18032e8d9:	48 ba b3 01 00 00 00 	movabs rdx,0x100000001b3
   18032e8e0:	01 00 00 
   18032e8e3:	49 83 fd 04          	cmp    r13,0x4
   18032e8e7:	73 1e                	jae    0x18032e907
   18032e8e9:	48 b9 25 23 22 84 e4 	movabs rcx,0xcbf29ce484222325
   18032e8f0:	9c f2 cb 
   18032e8f3:	45 31 c0             	xor    r8d,r8d
   18032e8f6:	eb 69                	jmp    0x18032e961
   18032e8f8:	48 b9 25 23 22 84 e4 	movabs rcx,0xcbf29ce484222325
   18032e8ff:	9c f2 cb 
   18032e902:	e9 7d 00 00 00       	jmp    0x18032e984
   18032e907:	4d 89 e9             	mov    r9,r13
   18032e90a:	49 83 e1 fc          	and    r9,0xfffffffffffffffc
   18032e90e:	48 b9 25 23 22 84 e4 	movabs rcx,0xcbf29ce484222325
   18032e915:	9c f2 cb 
   18032e918:	45 31 c0             	xor    r8d,r8d
   18032e91b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
   18032e920:	47 0f b6 14 07       	movzx  r10d,BYTE PTR [r15+r8*1]
   18032e925:	4c 31 d1             	xor    rcx,r10
   18032e928:	48 0f af ca          	imul   rcx,rdx
   18032e92c:	47 0f b6 54 07 01    	movzx  r10d,BYTE PTR [r15+r8*1+0x1]
   18032e932:	49 31 ca             	xor    r10,rcx
   18032e935:	4c 0f af d2          	imul   r10,rdx
   18032e939:	47 0f b6 5c 07 02    	movzx  r11d,BYTE PTR [r15+r8*1+0x2]
   18032e93f:	4d 31 d3             	xor    r11,r10
   18032e942:	4c 0f af da          	imul   r11,rdx
   18032e946:	43 0f b6 4c 07 03    	movzx  ecx,BYTE PTR [r15+r8*1+0x3]
   18032e94c:	4c 31 d9             	xor    rcx,r11
   18032e94f:	48 0f af ca          	imul   rcx,rdx
   18032e953:	49 83 c0 04          	add    r8,0x4
   18032e957:	4d 39 c1             	cmp    r9,r8
   18032e95a:	75 c4                	jne    0x18032e920
   18032e95c:	48 85 c0             	test   rax,rax
   18032e95f:	74 23                	je     0x18032e984
   18032e961:	4d 01 f8             	add    r8,r15
   18032e964:	45 31 c9             	xor    r9d,r9d
   18032e967:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
   18032e96e:	00 00 
   18032e970:	47 0f b6 14 08       	movzx  r10d,BYTE PTR [r8+r9*1]
   18032e975:	4c 31 d1             	xor    rcx,r10
   18032e978:	48 0f af ca          	imul   rcx,rdx
   18032e97c:	49 ff c1             	inc    r9
   18032e97f:	4c 39 c8             	cmp    rax,r9
   18032e982:	75 ec                	jne    0x18032e970
   18032e984:	49 23 4e 30          	and    rcx,QWORD PTR [r14+0x30]
   18032e988:	49 8b 7e 08          	mov    rdi,QWORD PTR [r14+0x8]
   18032e98c:	4c 89 75 18          	mov    QWORD PTR [rbp+0x18],r14
   18032e990:	49 8b 46 18          	mov    rax,QWORD PTR [r14+0x18]
   18032e994:	48 c1 e1 04          	shl    rcx,0x4
   18032e998:	4c 8b 74 08 08       	mov    r14,QWORD PTR [rax+rcx*1+0x8]
   18032e99d:	49 39 fe             	cmp    r14,rdi
   18032e9a0:	0f 84 a9 00 00 00    	je     0x18032ea4f
   18032e9a6:	48 8b 1c 08          	mov    rbx,QWORD PTR [rax+rcx*1]
   18032e9aa:	4d 85 ed             	test   r13,r13
   18032e9ad:	74 5a                	je     0x18032ea09
   18032e9af:	90                   	nop
   18032e9b0:	4d 3b 6e 20          	cmp    r13,QWORD PTR [r14+0x20]
   18032e9b4:	75 2d                	jne    0x18032e9e3
   18032e9b6:	49 83 7e 28 10       	cmp    QWORD PTR [r14+0x28],0x10
   18032e9bb:	72 13                	jb     0x18032e9d0
   18032e9bd:	49 8b 56 10          	mov    rdx,QWORD PTR [r14+0x10]
   18032e9c1:	eb 11                	jmp    0x18032e9d4
   18032e9c3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   18032e9ca:	84 00 00 00 00 00 
   18032e9d0:	49 8d 56 10          	lea    rdx,[r14+0x10]
   18032e9d4:	4c 89 f9             	mov    rcx,r15
   18032e9d7:	4d 89 e8             	mov    r8,r13
   18032e9da:	e8 61 63 3e 07       	call   0x187714d40
   18032e9df:	85 c0                	test   eax,eax
   18032e9e1:	74 2d                	je     0x18032ea10
   18032e9e3:	49 39 de             	cmp    r14,rbx
   18032e9e6:	74 67                	je     0x18032ea4f
   18032e9e8:	4d 8b 76 08          	mov    r14,QWORD PTR [r14+0x8]
   18032e9ec:	4d 3b 6e 20          	cmp    r13,QWORD PTR [r14+0x20]
   18032e9f0:	74 c4                	je     0x18032e9b6
   18032e9f2:	eb ef                	jmp    0x18032e9e3
   18032e9f4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   18032e9fb:	00 00 00 00 00 
   18032ea00:	49 39 de             	cmp    r14,rbx
   18032ea03:	74 4a                	je     0x18032ea4f
   18032ea05:	4d 8b 76 08          	mov    r14,QWORD PTR [r14+0x8]
   18032ea09:	49 83 7e 20 00       	cmp    QWORD PTR [r14+0x20],0x0
   18032ea0e:	75 f0                	jne    0x18032ea00
   18032ea10:	4d 85 f6             	test   r14,r14
   18032ea13:	74 3a                	je     0x18032ea4f
   18032ea15:	48 83 fe 10          	cmp    rsi,0x10
   18032ea19:	48 8b 5d e8          	mov    rbx,QWORD PTR [rbp-0x18]
   18032ea1d:	73 3d                	jae    0x18032ea5c
   18032ea1f:	49 39 fe             	cmp    r14,rdi
   18032ea22:	74 7a                	je     0x18032ea9e
   18032ea24:	0f 28 05 85 81 be 08 	movaps xmm0,XMMWORD PTR [rip+0x8be8185]        # 0x188f16bb0
   18032ea2b:	0f 11 03             	movups XMMWORD PTR [rbx],xmm0
   18032ea2e:	0f 57 c0             	xorps  xmm0,xmm0
   18032ea31:	0f 29 45 f0          	movaps XMMWORD PTR [rbp-0x10],xmm0
   18032ea35:	49 8b 46 38          	mov    rax,QWORD PTR [r14+0x38]
   18032ea39:	48 85 c0             	test   rax,rax
   18032ea3c:	0f 84 e1 00 00 00    	je     0x18032eb23
   18032ea42:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   18032ea46:	49 8b 46 38          	mov    rax,QWORD PTR [r14+0x38]
   18032ea4a:	e9 d6 00 00 00       	jmp    0x18032eb25
   18032ea4f:	49 89 fe             	mov    r14,rdi
   18032ea52:	48 83 fe 10          	cmp    rsi,0x10
   18032ea56:	48 8b 5d e8          	mov    rbx,QWORD PTR [rbp-0x18]
   18032ea5a:	72 c3                	jb     0x18032ea1f
   18032ea5c:	48 8d 56 01          	lea    rdx,[rsi+0x1]
   18032ea60:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   18032ea67:	72 20                	jb     0x18032ea89
   18032ea69:	49 8b 44 24 f8       	mov    rax,QWORD PTR [r12-0x8]
   18032ea6e:	49 83 c4 f8          	add    r12,0xfffffffffffffff8
   18032ea72:	49 29 c4             	sub    r12,rax
   18032ea75:	49 83 fc 20          	cmp    r12,0x20
   18032ea79:	0f 83 df 00 00 00    	jae    0x18032eb5e
   18032ea7f:	48 83 c6 28          	add    rsi,0x28
   18032ea83:	48 89 f2             	mov    rdx,rsi
   18032ea86:	49 89 c4             	mov    r12,rax
   18032ea89:	4c 89 e1             	mov    rcx,r12
   18032ea8c:	e8 8f d2 21 07       	call   0x18754bd20
   18032ea91:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
   18032ea95:	48 8b 78 08          	mov    rdi,QWORD PTR [rax+0x8]
   18032ea99:	49 39 fe             	cmp    r14,rdi
   18032ea9c:	75 86                	jne    0x18032ea24
   18032ea9e:	48 b8 aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaaa
   18032eaa5:	aa aa aa 
   18032eaa8:	48 89 45 30          	mov    QWORD PTR [rbp+0x30],rax
   18032eaac:	0f 28 05 fd 80 be 08 	movaps xmm0,XMMWORD PTR [rip+0x8be80fd]        # 0x188f16bb0
   18032eab3:	0f 29 45 20          	movaps XMMWORD PTR [rbp+0x20],xmm0
   18032eab7:	48 8d 05 4a b8 c9 08 	lea    rax,[rip+0x8c9b84a]        # 0x188fca308
   18032eabe:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
   18032eac2:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
   18032eac6:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
   18032eaca:	48 8b 45 08          	mov    rax,QWORD PTR [rbp+0x8]
   18032eace:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
   18032ead2:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
   18032ead6:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
   18032eada:	48 8d 55 a8          	lea    rdx,[rbp-0x58]
   18032eade:	48 89 55 e0          	mov    QWORD PTR [rbp-0x20],rdx
   18032eae2:	48 8d 7d 20          	lea    rdi,[rbp+0x20]
   18032eae6:	48 89 f9             	mov    rcx,rdi
   18032eae9:	e8 b2 6b 08 00       	call   0x1803b56a0
   18032eaee:	90                   	nop
   18032eaef:	48 89 d9             	mov    rcx,rbx
   18032eaf2:	48 89 fa             	mov    rdx,rdi
   18032eaf5:	e8 d6 c3 d2 ff       	call   0x18005aed0
   18032eafa:	90                   	nop
   18032eafb:	48 8b 7d 28          	mov    rdi,QWORD PTR [rbp+0x28]
   18032eaff:	48 85 ff             	test   rdi,rdi
   18032eb02:	74 3e                	je     0x18032eb42
   18032eb04:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   18032eb08:	75 38                	jne    0x18032eb42
   18032eb0a:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   18032eb0d:	48 89 f9             	mov    rcx,rdi
   18032eb10:	ff 10                	call   QWORD PTR [rax]
   18032eb12:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   18032eb16:	75 2a                	jne    0x18032eb42
   18032eb18:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   18032eb1b:	48 89 f9             	mov    rcx,rdi
   18032eb1e:	ff 50 08             	call   QWORD PTR [rax+0x8]
   18032eb21:	eb 1f                	jmp    0x18032eb42
   18032eb23:	31 c0                	xor    eax,eax
   18032eb25:	49 8b 4e 30          	mov    rcx,QWORD PTR [r14+0x30]
   18032eb29:	48 89 4d f0          	mov    QWORD PTR [rbp-0x10],rcx
   18032eb2d:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
   18032eb31:	48 8b 4d 10          	mov    rcx,QWORD PTR [rbp+0x10]
   18032eb35:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   18032eb38:	4c 8d 45 f0          	lea    r8,[rbp-0x10]
   18032eb3c:	48 89 da             	mov    rdx,rbx
   18032eb3f:	ff 50 18             	call   QWORD PTR [rax+0x18]
   18032eb42:	48 89 d8             	mov    rax,rbx
   18032eb45:	48 81 c4 c8 00 00 00 	add    rsp,0xc8
   18032eb4c:	5b                   	pop    rbx
   18032eb4d:	5f                   	pop    rdi
   18032eb4e:	5e                   	pop    rsi
   18032eb4f:	41 5c                	pop    r12
   18032eb51:	41 5d                	pop    r13
   18032eb53:	41 5e                	pop    r14
   18032eb55:	41 5f                	pop    r15
   18032eb57:	5d                   	pop    rbp
   18032eb58:	c3                   	ret
   18032eb59:	e8 32 a0 cd ff       	call   0x180008b90
   18032eb5e:	e8 29 f6 3a 07       	call   0x1876de18c
   18032eb63:	cc                   	int3
