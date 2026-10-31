
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

000000018032f980 <.text+0x32e980>:
   18032f980:	41 57                	push   r15
   18032f982:	41 56                	push   r14
   18032f984:	41 55                	push   r13
   18032f986:	41 54                	push   r12
   18032f988:	56                   	push   rsi
   18032f989:	57                   	push   rdi
   18032f98a:	55                   	push   rbp
   18032f98b:	53                   	push   rbx
   18032f98c:	48 83 ec 48          	sub    rsp,0x48
   18032f990:	48 89 d6             	mov    rsi,rdx
   18032f993:	49 89 cd             	mov    r13,rcx
   18032f996:	49 8b 00             	mov    rax,QWORD PTR [r8]
   18032f999:	4c 89 c1             	mov    rcx,r8
   18032f99c:	ff 50 08             	call   QWORD PTR [rax+0x8]
   18032f99f:	49 89 c6             	mov    r14,rax
   18032f9a2:	0f 57 c0             	xorps  xmm0,xmm0
   18032f9a5:	0f 29 44 24 20       	movaps XMMWORD PTR [rsp+0x20],xmm0
   18032f9aa:	48 89 c1             	mov    rcx,rax
   18032f9ad:	e8 ee 59 3c 07       	call   0x1876f53a0
   18032f9b2:	48 85 c0             	test   rax,rax
   18032f9b5:	0f 88 84 02 00 00    	js     0x18032fc3f
   18032f9bb:	49 89 c7             	mov    r15,rax
   18032f9be:	48 8d 5c 24 20       	lea    rbx,[rsp+0x20]
   18032f9c3:	bf 0f 00 00 00       	mov    edi,0xf
   18032f9c8:	49 89 dc             	mov    r12,rbx
   18032f9cb:	48 83 f8 10          	cmp    rax,0x10
   18032f9cf:	72 51                	jb     0x18032fa22
   18032f9d1:	4c 89 f8             	mov    rax,r15
   18032f9d4:	48 83 c8 0f          	or     rax,0xf
   18032f9d8:	48 83 f8 17          	cmp    rax,0x17
   18032f9dc:	bf 16 00 00 00       	mov    edi,0x16
   18032f9e1:	48 0f 43 f8          	cmovae rdi,rax
   18032f9e5:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   18032f9eb:	72 24                	jb     0x18032fa11
   18032f9ed:	48 8d 4f 28          	lea    rcx,[rdi+0x28]
   18032f9f1:	e8 e6 c2 21 07       	call   0x18754bcdc
   18032f9f6:	48 85 c0             	test   rax,rax
   18032f9f9:	0f 84 45 02 00 00    	je     0x18032fc44
   18032f9ff:	49 89 c4             	mov    r12,rax
   18032fa02:	49 83 c4 27          	add    r12,0x27
   18032fa06:	49 83 e4 e0          	and    r12,0xffffffffffffffe0
   18032fa0a:	49 89 44 24 f8       	mov    QWORD PTR [r12-0x8],rax
   18032fa0f:	eb 0c                	jmp    0x18032fa1d
   18032fa11:	48 8d 4f 01          	lea    rcx,[rdi+0x1]
   18032fa15:	e8 c2 c2 21 07       	call   0x18754bcdc
   18032fa1a:	49 89 c4             	mov    r12,rax
   18032fa1d:	4c 89 64 24 20       	mov    QWORD PTR [rsp+0x20],r12
   18032fa22:	4c 89 7c 24 30       	mov    QWORD PTR [rsp+0x30],r15
   18032fa27:	48 89 7c 24 38       	mov    QWORD PTR [rsp+0x38],rdi
   18032fa2c:	4c 89 e1             	mov    rcx,r12
   18032fa2f:	4c 89 f2             	mov    rdx,r14
   18032fa32:	4d 89 f8             	mov    r8,r15
   18032fa35:	e8 06 54 3e 07       	call   0x187714e40
   18032fa3a:	43 c6 04 3c 00       	mov    BYTE PTR [r12+r15*1],0x0
   18032fa3f:	4c 8b 74 24 20       	mov    r14,QWORD PTR [rsp+0x20]
   18032fa44:	4c 8b 7c 24 30       	mov    r15,QWORD PTR [rsp+0x30]
   18032fa49:	4c 8b 64 24 38       	mov    r12,QWORD PTR [rsp+0x38]
   18032fa4e:	49 83 fc 10          	cmp    r12,0x10
   18032fa52:	49 0f 43 de          	cmovae rbx,r14
   18032fa56:	4d 85 ff             	test   r15,r15
   18032fa59:	74 25                	je     0x18032fa80
   18032fa5b:	44 89 f8             	mov    eax,r15d
   18032fa5e:	83 e0 03             	and    eax,0x3
   18032fa61:	48 ba b3 01 00 00 00 	movabs rdx,0x100000001b3
   18032fa68:	01 00 00 
   18032fa6b:	49 83 ff 04          	cmp    r15,0x4
   18032fa6f:	73 1e                	jae    0x18032fa8f
   18032fa71:	48 b9 25 23 22 84 e4 	movabs rcx,0xcbf29ce484222325
   18032fa78:	9c f2 cb 
   18032fa7b:	45 31 c0             	xor    r8d,r8d
   18032fa7e:	eb 71                	jmp    0x18032faf1
   18032fa80:	48 b9 25 23 22 84 e4 	movabs rcx,0xcbf29ce484222325
   18032fa87:	9c f2 cb 
   18032fa8a:	e9 85 00 00 00       	jmp    0x18032fb14
   18032fa8f:	4d 89 f9             	mov    r9,r15
   18032fa92:	49 83 e1 fc          	and    r9,0xfffffffffffffffc
   18032fa96:	48 b9 25 23 22 84 e4 	movabs rcx,0xcbf29ce484222325
   18032fa9d:	9c f2 cb 
   18032faa0:	45 31 c0             	xor    r8d,r8d
   18032faa3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   18032faaa:	84 00 00 00 00 00 
   18032fab0:	46 0f b6 14 03       	movzx  r10d,BYTE PTR [rbx+r8*1]
   18032fab5:	4c 31 d1             	xor    rcx,r10
   18032fab8:	48 0f af ca          	imul   rcx,rdx
   18032fabc:	46 0f b6 54 03 01    	movzx  r10d,BYTE PTR [rbx+r8*1+0x1]
   18032fac2:	49 31 ca             	xor    r10,rcx
   18032fac5:	4c 0f af d2          	imul   r10,rdx
   18032fac9:	46 0f b6 5c 03 02    	movzx  r11d,BYTE PTR [rbx+r8*1+0x2]
   18032facf:	4d 31 d3             	xor    r11,r10
   18032fad2:	4c 0f af da          	imul   r11,rdx
   18032fad6:	42 0f b6 4c 03 03    	movzx  ecx,BYTE PTR [rbx+r8*1+0x3]
   18032fadc:	4c 31 d9             	xor    rcx,r11
   18032fadf:	48 0f af ca          	imul   rcx,rdx
   18032fae3:	49 83 c0 04          	add    r8,0x4
   18032fae7:	4d 39 c1             	cmp    r9,r8
   18032faea:	75 c4                	jne    0x18032fab0
   18032faec:	48 85 c0             	test   rax,rax
   18032faef:	74 23                	je     0x18032fb14
   18032faf1:	49 01 d8             	add    r8,rbx
   18032faf4:	45 31 c9             	xor    r9d,r9d
   18032faf7:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
   18032fafe:	00 00 
   18032fb00:	47 0f b6 14 08       	movzx  r10d,BYTE PTR [r8+r9*1]
   18032fb05:	4c 31 d1             	xor    rcx,r10
   18032fb08:	48 0f af ca          	imul   rcx,rdx
   18032fb0c:	49 ff c1             	inc    r9
   18032fb0f:	4c 39 c8             	cmp    rax,r9
   18032fb12:	75 ec                	jne    0x18032fb00
   18032fb14:	49 23 4d 70          	and    rcx,QWORD PTR [r13+0x70]
   18032fb18:	49 8b 6d 48          	mov    rbp,QWORD PTR [r13+0x48]
   18032fb1c:	4c 89 6c 24 40       	mov    QWORD PTR [rsp+0x40],r13
   18032fb21:	49 8b 45 58          	mov    rax,QWORD PTR [r13+0x58]
   18032fb25:	48 c1 e1 04          	shl    rcx,0x4
   18032fb29:	4c 8b 6c 08 08       	mov    r13,QWORD PTR [rax+rcx*1+0x8]
   18032fb2e:	49 39 ed             	cmp    r13,rbp
   18032fb31:	0f 84 a7 00 00 00    	je     0x18032fbde
   18032fb37:	48 8b 3c 08          	mov    rdi,QWORD PTR [rax+rcx*1]
   18032fb3b:	4d 85 ff             	test   r15,r15
   18032fb3e:	74 59                	je     0x18032fb99
   18032fb40:	4d 3b 7d 20          	cmp    r15,QWORD PTR [r13+0x20]
   18032fb44:	75 2d                	jne    0x18032fb73
   18032fb46:	49 83 7d 28 10       	cmp    QWORD PTR [r13+0x28],0x10
   18032fb4b:	72 13                	jb     0x18032fb60
   18032fb4d:	49 8b 55 10          	mov    rdx,QWORD PTR [r13+0x10]
   18032fb51:	eb 11                	jmp    0x18032fb64
   18032fb53:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   18032fb5a:	84 00 00 00 00 00 
   18032fb60:	49 8d 55 10          	lea    rdx,[r13+0x10]
   18032fb64:	48 89 d9             	mov    rcx,rbx
   18032fb67:	4d 89 f8             	mov    r8,r15
   18032fb6a:	e8 d1 51 3e 07       	call   0x187714d40
   18032fb6f:	85 c0                	test   eax,eax
   18032fb71:	74 2d                	je     0x18032fba0
   18032fb73:	49 39 fd             	cmp    r13,rdi
   18032fb76:	74 66                	je     0x18032fbde
   18032fb78:	4d 8b 6d 08          	mov    r13,QWORD PTR [r13+0x8]
   18032fb7c:	4d 3b 7d 20          	cmp    r15,QWORD PTR [r13+0x20]
   18032fb80:	74 c4                	je     0x18032fb46
   18032fb82:	eb ef                	jmp    0x18032fb73
   18032fb84:	66 66 66 2e 0f 1f 84 	data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   18032fb8b:	00 00 00 00 00 
   18032fb90:	49 39 fd             	cmp    r13,rdi
   18032fb93:	74 49                	je     0x18032fbde
   18032fb95:	4d 8b 6d 08          	mov    r13,QWORD PTR [r13+0x8]
   18032fb99:	49 83 7d 20 00       	cmp    QWORD PTR [r13+0x20],0x0
   18032fb9e:	75 f0                	jne    0x18032fb90
   18032fba0:	4d 85 ed             	test   r13,r13
   18032fba3:	74 39                	je     0x18032fbde
   18032fba5:	49 83 fc 10          	cmp    r12,0x10
   18032fba9:	73 3c                	jae    0x18032fbe7
   18032fbab:	49 39 ed             	cmp    r13,rbp
   18032fbae:	74 76                	je     0x18032fc26
   18032fbb0:	0f 57 c0             	xorps  xmm0,xmm0
   18032fbb3:	0f 11 06             	movups XMMWORD PTR [rsi],xmm0
   18032fbb6:	49 8b 45 38          	mov    rax,QWORD PTR [r13+0x38]
   18032fbba:	48 85 c0             	test   rax,rax
   18032fbbd:	74 04                	je     0x18032fbc3
   18032fbbf:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   18032fbc3:	49 8b 45 30          	mov    rax,QWORD PTR [r13+0x30]
   18032fbc7:	48 89 06             	mov    QWORD PTR [rsi],rax
   18032fbca:	49 8b 45 38          	mov    rax,QWORD PTR [r13+0x38]
   18032fbce:	48 89 46 08          	mov    QWORD PTR [rsi+0x8],rax
   18032fbd2:	49 8b 45 40          	mov    rax,QWORD PTR [r13+0x40]
   18032fbd6:	48 89 46 10          	mov    QWORD PTR [rsi+0x10],rax
   18032fbda:	b0 01                	mov    al,0x1
   18032fbdc:	eb 4a                	jmp    0x18032fc28
   18032fbde:	49 89 ed             	mov    r13,rbp
   18032fbe1:	49 83 fc 10          	cmp    r12,0x10
   18032fbe5:	72 c4                	jb     0x18032fbab
   18032fbe7:	49 8d 54 24 01       	lea    rdx,[r12+0x1]
   18032fbec:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   18032fbf3:	72 1b                	jb     0x18032fc10
   18032fbf5:	49 8b 46 f8          	mov    rax,QWORD PTR [r14-0x8]
   18032fbf9:	49 83 c6 f8          	add    r14,0xfffffffffffffff8
   18032fbfd:	49 29 c6             	sub    r14,rax
   18032fc00:	49 83 fe 20          	cmp    r14,0x20
   18032fc04:	73 3e                	jae    0x18032fc44
   18032fc06:	49 83 c4 28          	add    r12,0x28
   18032fc0a:	4c 89 e2             	mov    rdx,r12
   18032fc0d:	49 89 c6             	mov    r14,rax
   18032fc10:	4c 89 f1             	mov    rcx,r14
   18032fc13:	e8 08 c1 21 07       	call   0x18754bd20
   18032fc18:	48 8b 44 24 40       	mov    rax,QWORD PTR [rsp+0x40]
   18032fc1d:	48 8b 68 48          	mov    rbp,QWORD PTR [rax+0x48]
   18032fc21:	49 39 ed             	cmp    r13,rbp
   18032fc24:	75 8a                	jne    0x18032fbb0
   18032fc26:	31 c0                	xor    eax,eax
   18032fc28:	88 46 18             	mov    BYTE PTR [rsi+0x18],al
   18032fc2b:	48 89 f0             	mov    rax,rsi
   18032fc2e:	48 83 c4 48          	add    rsp,0x48
   18032fc32:	5b                   	pop    rbx
   18032fc33:	5d                   	pop    rbp
   18032fc34:	5f                   	pop    rdi
   18032fc35:	5e                   	pop    rsi
   18032fc36:	41 5c                	pop    r12
   18032fc38:	41 5d                	pop    r13
   18032fc3a:	41 5e                	pop    r14
   18032fc3c:	41 5f                	pop    r15
   18032fc3e:	c3                   	ret
   18032fc3f:	e8 4c 8f cd ff       	call   0x180008b90
   18032fc44:	e8 43 e5 3a 07       	call   0x1876de18c
   18032fc49:	cc                   	int3
