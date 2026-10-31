
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001855f1b90 <.text+0x55f0b90>:
   1855f1b90:	55                   	push   rbp
   1855f1b91:	56                   	push   rsi
   1855f1b92:	48 83 ec 78          	sub    rsp,0x78
   1855f1b96:	48 8d 6c 24 70       	lea    rbp,[rsp+0x70]
   1855f1b9b:	48 c7 45 00 fe ff ff 	mov    QWORD PTR [rbp+0x0],0xfffffffffffffffe
   1855f1ba2:	ff 
   1855f1ba3:	48 8b 71 08          	mov    rsi,QWORD PTR [rcx+0x8]
   1855f1ba7:	48 c7 45 e8 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
   1855f1bae:	00 
   1855f1baf:	b9 30 00 00 00       	mov    ecx,0x30
   1855f1bb4:	e8 23 a1 f5 01       	call   0x18754bcdc
   1855f1bb9:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
   1855f1bbd:	48 c7 45 f0 21 00 00 	mov    QWORD PTR [rbp-0x10],0x21
   1855f1bc4:	00 
   1855f1bc5:	48 c7 45 f8 2f 00 00 	mov    QWORD PTR [rbp-0x8],0x2f
   1855f1bcc:	00 
   1855f1bcd:	0f 10 05 7c 55 41 04 	movups xmm0,XMMWORD PTR [rip+0x441557c]        # 0x189a07150 ; send_text_message_failed (logout)
   1855f1bd4:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   1855f1bd7:	0f 10 05 82 55 41 04 	movups xmm0,XMMWORD PTR [rip+0x4415582]        # 0x189a07160 ; e_failed (logout)
   1855f1bde:	0f 11 40 10          	movups XMMWORD PTR [rax+0x10],xmm0
   1855f1be2:	66 c7 40 20 29 00    	mov    WORD PTR [rax+0x20],0x29
   1855f1be8:	0f 28 05 c1 4f 92 03 	movaps xmm0,XMMWORD PTR [rip+0x3924fc1]        # 0x188f16bb0
   1855f1bef:	0f 29 45 d0          	movaps XMMWORD PTR [rbp-0x30],xmm0
   1855f1bf3:	0f 29 45 b0          	movaps XMMWORD PTR [rbp-0x50],xmm0
   1855f1bf7:	0f 29 45 c0          	movaps XMMWORD PTR [rbp-0x40],xmm0
   1855f1bfb:	c6 45 d8 00          	mov    BYTE PTR [rbp-0x28],0x0
   1855f1bff:	c6 45 b0 00          	mov    BYTE PTR [rbp-0x50],0x0
   1855f1c03:	48 8d 4d b8          	lea    rcx,[rbp-0x48]
   1855f1c07:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
   1855f1c0b:	e8 e0 33 3a fc       	call   0x181994ff0
   1855f1c10:	90                   	nop
   1855f1c11:	48 8d 55 b0          	lea    rdx,[rbp-0x50]
   1855f1c15:	48 89 f1             	mov    rcx,rsi
   1855f1c18:	e8 c3 48 f7 ff       	call   0x1855664e0
   1855f1c1d:	90                   	nop
   1855f1c1e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
   1855f1c22:	48 83 f8 10          	cmp    rax,0x10
   1855f1c26:	72 32                	jb     0x1855f1c5a
   1855f1c28:	48 8b 4d e0          	mov    rcx,QWORD PTR [rbp-0x20]
   1855f1c2c:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855f1c30:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855f1c37:	72 1b                	jb     0x1855f1c54
   1855f1c39:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855f1c3d:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855f1c41:	4c 29 c1             	sub    rcx,r8
   1855f1c44:	48 83 f9 20          	cmp    rcx,0x20
   1855f1c48:	73 17                	jae    0x1855f1c61
   1855f1c4a:	48 83 c0 28          	add    rax,0x28
   1855f1c4e:	48 89 c2             	mov    rdx,rax
   1855f1c51:	4c 89 c1             	mov    rcx,r8
   1855f1c54:	e8 c7 a0 f5 01       	call   0x18754bd20
   1855f1c59:	90                   	nop
   1855f1c5a:	48 83 c4 78          	add    rsp,0x78
   1855f1c5e:	5e                   	pop    rsi
   1855f1c5f:	5d                   	pop    rbp
   1855f1c60:	c3                   	ret
   1855f1c61:	e8 26 c5 0e 02       	call   0x1876de18c
   1855f1c66:	cc                   	int3
   1855f1c67:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
   1855f1c6e:	00 00 
   1855f1c70:	48 89 54 24 10       	mov    QWORD PTR [rsp+0x10],rdx
   1855f1c75:	55                   	push   rbp
   1855f1c76:	56                   	push   rsi
   1855f1c77:	48 83 ec 28          	sub    rsp,0x28
   1855f1c7b:	48 8d 6a 70          	lea    rbp,[rdx+0x70]
   1855f1c7f:	48 8d 4d b0          	lea    rcx,[rbp-0x50]
   1855f1c83:	e8 58 44 f7 ff       	call   0x1855660e0
   1855f1c88:	90                   	nop
   1855f1c89:	48 83 c4 28          	add    rsp,0x28
   1855f1c8d:	5e                   	pop    rsi
   1855f1c8e:	5d                   	pop    rbp
   1855f1c8f:	c3                   	ret
   1855f1c90:	48 89 54 24 10       	mov    QWORD PTR [rsp+0x10],rdx
   1855f1c95:	55                   	push   rbp
   1855f1c96:	56                   	push   rsi
   1855f1c97:	48 83 ec 28          	sub    rsp,0x28
   1855f1c9b:	48 8d 6a 70          	lea    rbp,[rdx+0x70]
   1855f1c9f:	48 8d 4d e0          	lea    rcx,[rbp-0x20]
   1855f1ca3:	e8 68 03 a1 fa       	call   0x180002010
   1855f1ca8:	90                   	nop
   1855f1ca9:	48 83 c4 28          	add    rsp,0x28
   1855f1cad:	5e                   	pop    rsi
   1855f1cae:	5d                   	pop    rbp
   1855f1caf:	c3                   	ret
   1855f1cb0:	48 8d 05 99 1b 3b 06 	lea    rax,[rip+0x63b1b99]        # 0x18b9a3850
   1855f1cb7:	c3                   	ret
   1855f1cb8:	cc                   	int3
   1855f1cb9:	cc                   	int3
   1855f1cba:	cc                   	int3
   1855f1cbb:	cc                   	int3
   1855f1cbc:	cc                   	int3
   1855f1cbd:	cc                   	int3
   1855f1cbe:	cc                   	int3
   1855f1cbf:	cc                   	int3
   1855f1cc0:	55                   	push   rbp
   1855f1cc1:	41 57                	push   r15
   1855f1cc3:	41 56                	push   r14
   1855f1cc5:	56                   	push   rsi
   1855f1cc6:	57                   	push   rdi
   1855f1cc7:	53                   	push   rbx
   1855f1cc8:	48 83 ec 38          	sub    rsp,0x38
   1855f1ccc:	48 8d 6c 24 30       	lea    rbp,[rsp+0x30]
   1855f1cd1:	48 c7 45 00 fe ff ff 	mov    QWORD PTR [rbp+0x0],0xfffffffffffffffe
   1855f1cd8:	ff 
   1855f1cd9:	48 89 ce             	mov    rsi,rcx
   1855f1cdc:	b9 58 00 00 00       	mov    ecx,0x58
   1855f1ce1:	e8 f6 9f f5 01       	call   0x18754bcdc
   1855f1ce6:	49 89 c7             	mov    r15,rax
   1855f1ce9:	48 8d 05 98 54 41 04 	lea    rax,[rip+0x4415498]        # 0x189a07188
   1855f1cf0:	49 89 07             	mov    QWORD PTR [r15],rax
   1855f1cf3:	0f 57 c0             	xorps  xmm0,xmm0
   1855f1cf6:	41 0f 11 47 08       	movups XMMWORD PTR [r15+0x8],xmm0
   1855f1cfb:	48 8b 46 10          	mov    rax,QWORD PTR [rsi+0x10]
   1855f1cff:	48 85 c0             	test   rax,rax
   1855f1d02:	74 0a                	je     0x1855f1d0e
   1855f1d04:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1855f1d08:	48 8b 4e 10          	mov    rcx,QWORD PTR [rsi+0x10]
   1855f1d0c:	eb 02                	jmp    0x1855f1d10
   1855f1d0e:	31 c9                	xor    ecx,ecx
   1855f1d10:	48 8b 46 08          	mov    rax,QWORD PTR [rsi+0x8]
   1855f1d14:	49 89 47 08          	mov    QWORD PTR [r15+0x8],rax
   1855f1d18:	49 89 4f 10          	mov    QWORD PTR [r15+0x10],rcx
   1855f1d1c:	41 0f 11 47 18       	movups XMMWORD PTR [r15+0x18],xmm0
   1855f1d21:	41 0f 11 47 28       	movups XMMWORD PTR [r15+0x28],xmm0
   1855f1d26:	48 8b 7e 28          	mov    rdi,QWORD PTR [rsi+0x28]
   1855f1d2a:	48 83 7e 30 10       	cmp    QWORD PTR [rsi+0x30],0x10
   1855f1d2f:	72 06                	jb     0x1855f1d37
   1855f1d31:	48 8b 5e 18          	mov    rbx,QWORD PTR [rsi+0x18]
   1855f1d35:	eb 04                	jmp    0x1855f1d3b
   1855f1d37:	48 8d 5e 18          	lea    rbx,[rsi+0x18]
   1855f1d3b:	48 85 ff             	test   rdi,rdi
   1855f1d3e:	0f 88 f4 00 00 00    	js     0x1855f1e38
   1855f1d44:	48 83 ff 0f          	cmp    rdi,0xf
   1855f1d48:	77 1b                	ja     0x1855f1d65
   1855f1d4a:	4c 89 f8             	mov    rax,r15
   1855f1d4d:	48 83 c0 18          	add    rax,0x18
   1855f1d51:	49 89 7f 28          	mov    QWORD PTR [r15+0x28],rdi
   1855f1d55:	49 c7 47 30 0f 00 00 	mov    QWORD PTR [r15+0x30],0xf
   1855f1d5c:	00 
   1855f1d5d:	0f 10 03             	movups xmm0,XMMWORD PTR [rbx]
   1855f1d60:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   1855f1d63:	eb 74                	jmp    0x1855f1dd9
   1855f1d65:	48 89 4d f0          	mov    QWORD PTR [rbp-0x10],rcx
   1855f1d69:	4c 89 7d f8          	mov    QWORD PTR [rbp-0x8],r15
   1855f1d6d:	48 89 f8             	mov    rax,rdi
   1855f1d70:	48 83 c8 0f          	or     rax,0xf
   1855f1d74:	48 83 f8 17          	cmp    rax,0x17
   1855f1d78:	41 be 16 00 00 00    	mov    r14d,0x16
   1855f1d7e:	4c 0f 43 f0          	cmovae r14,rax
   1855f1d82:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   1855f1d88:	72 24                	jb     0x1855f1dae
   1855f1d8a:	49 8d 4e 28          	lea    rcx,[r14+0x28]
   1855f1d8e:	e8 49 9f f5 01       	call   0x18754bcdc
   1855f1d93:	90                   	nop
   1855f1d94:	48 85 c0             	test   rax,rax
   1855f1d97:	0f 84 a9 00 00 00    	je     0x1855f1e46
   1855f1d9d:	48 89 c1             	mov    rcx,rax
   1855f1da0:	48 83 c0 27          	add    rax,0x27
   1855f1da4:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
   1855f1da8:	48 89 48 f8          	mov    QWORD PTR [rax-0x8],rcx
   1855f1dac:	eb 0a                	jmp    0x1855f1db8
   1855f1dae:	49 8d 4e 01          	lea    rcx,[r14+0x1]
   1855f1db2:	e8 25 9f f5 01       	call   0x18754bcdc
   1855f1db7:	90                   	nop
   1855f1db8:	4c 8b 7d f8          	mov    r15,QWORD PTR [rbp-0x8]
   1855f1dbc:	49 89 47 18          	mov    QWORD PTR [r15+0x18],rax
   1855f1dc0:	49 89 7f 28          	mov    QWORD PTR [r15+0x28],rdi
   1855f1dc4:	4d 89 77 30          	mov    QWORD PTR [r15+0x30],r14
   1855f1dc8:	48 ff c7             	inc    rdi
   1855f1dcb:	48 89 c1             	mov    rcx,rax
   1855f1dce:	48 89 da             	mov    rdx,rbx
   1855f1dd1:	49 89 f8             	mov    r8,rdi
   1855f1dd4:	e8 67 30 12 02       	call   0x187714e40
   1855f1dd9:	0f 57 c0             	xorps  xmm0,xmm0
   1855f1ddc:	41 0f 11 47 38       	movups XMMWORD PTR [r15+0x38],xmm0
   1855f1de1:	48 8b 46 40          	mov    rax,QWORD PTR [rsi+0x40]
   1855f1de5:	48 85 c0             	test   rax,rax
   1855f1de8:	74 0a                	je     0x1855f1df4
   1855f1dea:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1855f1dee:	48 8b 46 40          	mov    rax,QWORD PTR [rsi+0x40]
   1855f1df2:	eb 02                	jmp    0x1855f1df6
   1855f1df4:	31 c0                	xor    eax,eax
   1855f1df6:	48 8b 4e 38          	mov    rcx,QWORD PTR [rsi+0x38]
   1855f1dfa:	49 89 4f 38          	mov    QWORD PTR [r15+0x38],rcx
   1855f1dfe:	49 89 47 40          	mov    QWORD PTR [r15+0x40],rax
   1855f1e02:	41 0f 11 47 48       	movups XMMWORD PTR [r15+0x48],xmm0
   1855f1e07:	48 8b 46 50          	mov    rax,QWORD PTR [rsi+0x50]
   1855f1e0b:	48 85 c0             	test   rax,rax
   1855f1e0e:	74 0a                	je     0x1855f1e1a
   1855f1e10:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1855f1e14:	48 8b 46 50          	mov    rax,QWORD PTR [rsi+0x50]
   1855f1e18:	eb 02                	jmp    0x1855f1e1c
   1855f1e1a:	31 c0                	xor    eax,eax
   1855f1e1c:	48 8b 4e 48          	mov    rcx,QWORD PTR [rsi+0x48]
   1855f1e20:	49 89 4f 48          	mov    QWORD PTR [r15+0x48],rcx
   1855f1e24:	49 89 47 50          	mov    QWORD PTR [r15+0x50],rax
   1855f1e28:	4c 89 f8             	mov    rax,r15
   1855f1e2b:	48 83 c4 38          	add    rsp,0x38
   1855f1e2f:	5b                   	pop    rbx
   1855f1e30:	5f                   	pop    rdi
   1855f1e31:	5e                   	pop    rsi
   1855f1e32:	41 5e                	pop    r14
   1855f1e34:	41 5f                	pop    r15
   1855f1e36:	5d                   	pop    rbp
   1855f1e37:	c3                   	ret
   1855f1e38:	48 89 4d f0          	mov    QWORD PTR [rbp-0x10],rcx
   1855f1e3c:	4c 89 7d f8          	mov    QWORD PTR [rbp-0x8],r15