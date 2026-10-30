
E:/Tencent/Weixin/4.1.15.56/Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001855e9a40 <.text+0x55e8a40>:
   1855e9a40:	55                   	push   rbp
   1855e9a41:	41 57                	push   r15
   1855e9a43:	41 56                	push   r14
   1855e9a45:	41 54                	push   r12
   1855e9a47:	56                   	push   rsi
   1855e9a48:	57                   	push   rdi
   1855e9a49:	53                   	push   rbx
   1855e9a4a:	48 81 ec f0 05 00 00 	sub    rsp,0x5f0
   1855e9a51:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   1855e9a58:	00
   1855e9a59:	0f 29 b5 60 05 00 00 	movaps XMMWORD PTR [rbp+0x560],xmm6
   1855e9a60:	48 c7 85 58 05 00 00 	mov    QWORD PTR [rbp+0x558],0xfffffffffffffffe
   1855e9a67:	fe ff ff ff
   1855e9a6b:	48 89 ce             	mov    rsi,rcx
   1855e9a6e:	0f 28 35 3b d1 92 03 	movaps xmm6,XMMWORD PTR [rip+0x392d13b]        # 0x188f16bb0
   1855e9a75:	0f 29 b5 f0 04 00 00 	movaps XMMWORD PTR [rbp+0x4f0],xmm6
   1855e9a7c:	48 8d 8d 10 04 00 00 	lea    rcx,[rbp+0x410]
   1855e9a83:	e8 98 d7 a5 fa       	call   0x180047220
   1855e9a88:	48 8b 8d 10 04 00 00 	mov    rcx,QWORD PTR [rbp+0x410]
   1855e9a8f:	48 8d 55 10          	lea    rdx,[rbp+0x10]
   1855e9a93:	e8 38 89 d9 fa       	call   0x1803823d0
   1855e9a98:	90                   	nop
   1855e9a99:	48 8b 4d 10          	mov    rcx,QWORD PTR [rbp+0x10]
   1855e9a9d:	48 8d 95 f0 04 00 00 	lea    rdx,[rbp+0x4f0]
   1855e9aa4:	e8 d7 f7 11 fb       	call   0x180709280
   1855e9aa9:	90                   	nop
   1855e9aaa:	48 8b 7d 18          	mov    rdi,QWORD PTR [rbp+0x18]
   1855e9aae:	48 85 ff             	test   rdi,rdi
   1855e9ab1:	74 1d                	je     0x1855e9ad0
   1855e9ab3:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1855e9ab7:	75 17                	jne    0x1855e9ad0
   1855e9ab9:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855e9abc:	48 89 f9             	mov    rcx,rdi
   1855e9abf:	ff 10                	call   QWORD PTR [rax]
   1855e9ac1:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1855e9ac5:	75 09                	jne    0x1855e9ad0
   1855e9ac7:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855e9aca:	48 89 f9             	mov    rcx,rdi
   1855e9acd:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855e9ad0:	48 8b bd 18 04 00 00 	mov    rdi,QWORD PTR [rbp+0x418]
   1855e9ad7:	48 85 ff             	test   rdi,rdi
   1855e9ada:	74 1d                	je     0x1855e9af9
   1855e9adc:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1855e9ae0:	75 17                	jne    0x1855e9af9
   1855e9ae2:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855e9ae5:	48 89 f9             	mov    rcx,rdi
   1855e9ae8:	ff 10                	call   QWORD PTR [rax]
   1855e9aea:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1855e9aee:	75 09                	jne    0x1855e9af9
   1855e9af0:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855e9af3:	48 89 f9             	mov    rcx,rdi
   1855e9af6:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855e9af9:	48 8b 8d f0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4f0]
   1855e9b00:	48 85 c9             	test   rcx,rcx
   1855e9b03:	74 4a                	je     0x1855e9b4f
   1855e9b05:	48 bf aa aa aa aa aa 	movabs rdi,0xaaaaaaaaaaaaaaaa
   1855e9b0c:	aa aa aa
   1855e9b0f:	48 89 bd f0 03 00 00 	mov    QWORD PTR [rbp+0x3f0],rdi
   1855e9b16:	0f 29 b5 e0 03 00 00 	movaps XMMWORD PTR [rbp+0x3e0],xmm6
   1855e9b1d:	0f 29 b5 d0 03 00 00 	movaps XMMWORD PTR [rbp+0x3d0],xmm6
   1855e9b24:	0f 29 b5 c0 03 00 00 	movaps XMMWORD PTR [rbp+0x3c0],xmm6
   1855e9b2b:	0f 57 c0             	xorps  xmm0,xmm0
   1855e9b2e:	0f 29 85 00 04 00 00 	movaps XMMWORD PTR [rbp+0x400],xmm0
   1855e9b35:	48 8b 46 40          	mov    rax,QWORD PTR [rsi+0x40]
   1855e9b39:	48 85 c0             	test   rax,rax
   1855e9b3c:	0f 84 e4 00 00 00    	je     0x1855e9c26
   1855e9b42:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1855e9b46:	48 8b 46 40          	mov    rax,QWORD PTR [rsi+0x40]
   1855e9b4a:	e9 d9 00 00 00       	jmp    0x1855e9c28
   1855e9b4f:	48 8b 76 08          	mov    rsi,QWORD PTR [rsi+0x8]
   1855e9b53:	0f 57 c0             	xorps  xmm0,xmm0
   1855e9b56:	0f 29 85 20 04 00 00 	movaps XMMWORD PTR [rbp+0x420],xmm0
   1855e9b5d:	0f 29 85 10 04 00 00 	movaps XMMWORD PTR [rbp+0x410],xmm0
   1855e9b64:	b9 40 00 00 00       	mov    ecx,0x40
   1855e9b69:	e8 6e 21 f6 01       	call   0x18754bcdc
   1855e9b6e:	90                   	nop
   1855e9b6f:	48 89 85 10 04 00 00 	mov    QWORD PTR [rbp+0x410],rax
   1855e9b76:	48 c7 85 20 04 00 00 	mov    QWORD PTR [rbp+0x420],0x32
   1855e9b7d:	32 00 00 00
   1855e9b81:	48 c7 85 28 04 00 00 	mov    QWORD PTR [rbp+0x428],0x3f
   1855e9b88:	3f 00 00 00
   1855e9b8c:	0f 10 05 25 9e 41 04 	movups xmm0,XMMWORD PTR [rip+0x4419e25]        # 0x189a039b8
   1855e9b93:	0f 11 40 20          	movups XMMWORD PTR [rax+0x20],xmm0
   1855e9b97:	0f 10 05 0a 9e 41 04 	movups xmm0,XMMWORD PTR [rip+0x4419e0a]        # 0x189a039a8
   1855e9b9e:	0f 11 40 10          	movups XMMWORD PTR [rax+0x10],xmm0
   1855e9ba2:	0f 10 05 ef 9d 41 04 	movups xmm0,XMMWORD PTR [rip+0x4419def]        # 0x189a03998
   1855e9ba9:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   1855e9bac:	66 c7 40 30 6c 65    	mov    WORD PTR [rax+0x30],0x656c
   1855e9bb2:	c6 40 32 00          	mov    BYTE PTR [rax+0x32],0x0
   1855e9bb6:	0f 29 75 20          	movaps XMMWORD PTR [rbp+0x20],xmm6
   1855e9bba:	0f 29 75 30          	movaps XMMWORD PTR [rbp+0x30],xmm6
   1855e9bbe:	0f 29 75 50          	movaps XMMWORD PTR [rbp+0x50],xmm6
   1855e9bc2:	0f 29 75 10          	movaps XMMWORD PTR [rbp+0x10],xmm6
   1855e9bc6:	0f 29 75 40          	movaps XMMWORD PTR [rbp+0x40],xmm6
   1855e9bca:	c6 45 20 00          	mov    BYTE PTR [rbp+0x20],0x0
   1855e9bce:	c6 45 30 00          	mov    BYTE PTR [rbp+0x30],0x0
   1855e9bd2:	c6 45 58 00          	mov    BYTE PTR [rbp+0x58],0x0
   1855e9bd6:	c6 45 10 00          	mov    BYTE PTR [rbp+0x10],0x0
   1855e9bda:	48 8d 4d 38          	lea    rcx,[rbp+0x38]
   1855e9bde:	48 8d 95 10 04 00 00 	lea    rdx,[rbp+0x410]
   1855e9be5:	e8 06 b4 3a fc       	call   0x181994ff0
   1855e9bea:	90                   	nop
   1855e9beb:	48 8d 55 10          	lea    rdx,[rbp+0x10]
   1855e9bef:	48 89 f1             	mov    rcx,rsi
   1855e9bf2:	e8 39 8c ff ff       	call   0x1855e2830
   1855e9bf7:	90                   	nop
   1855e9bf8:	48 8b 85 28 04 00 00 	mov    rax,QWORD PTR [rbp+0x428]
   1855e9bff:	48 83 f8 10          	cmp    rax,0x10
   1855e9c03:	0f 82 1e 09 00 00    	jb     0x1855ea527
   1855e9c09:	48 8b 8d 10 04 00 00 	mov    rcx,QWORD PTR [rbp+0x410]
   1855e9c10:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855e9c14:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855e9c1b:	0f 83 e6 08 00 00    	jae    0x1855ea507
   1855e9c21:	e9 fc 08 00 00       	jmp    0x1855ea522
   1855e9c26:	31 c0                	xor    eax,eax
   1855e9c28:	48 8b 56 38          	mov    rdx,QWORD PTR [rsi+0x38]
   1855e9c2c:	48 89 95 00 04 00 00 	mov    QWORD PTR [rbp+0x400],rdx
   1855e9c33:	48 89 85 08 04 00 00 	mov    QWORD PTR [rbp+0x408],rax
   1855e9c3a:	48 8d 95 c0 03 00 00 	lea    rdx,[rbp+0x3c0]
   1855e9c41:	4c 8d 85 00 04 00 00 	lea    r8,[rbp+0x400]
   1855e9c48:	e8 13 9f 1b fc       	call   0x1817a3b60
   1855e9c4d:	90                   	nop
   1855e9c4e:	8b 85 c4 03 00 00    	mov    eax,DWORD PTR [rbp+0x3c4]
   1855e9c54:	0b 85 c0 03 00 00    	or     eax,DWORD PTR [rbp+0x3c0]
   1855e9c5a:	0f 84 b8 00 00 00    	je     0x1855e9d18
   1855e9c60:	b9 04 00 00 00       	mov    ecx,0x4
   1855e9c65:	e8 76 31 a8 fa       	call   0x18006cde0
   1855e9c6a:	85 c0                	test   eax,eax
   1855e9c6c:	0f 84 2d 04 00 00    	je     0x1855ea09f
   1855e9c72:	48 8d bd 50 03 00 00 	lea    rdi,[rbp+0x350]
   1855e9c79:	48 89 f9             	mov    rcx,rdi
   1855e9c7c:	e8 8f 32 a8 fa       	call   0x18006cf10
   1855e9c81:	90                   	nop
   1855e9c82:	48 83 bd 68 03 00 00 	cmp    QWORD PTR [rbp+0x368],0x10
   1855e9c89:	10
   1855e9c8a:	72 07                	jb     0x1855e9c93
   1855e9c8c:	48 8b bd 50 03 00 00 	mov    rdi,QWORD PTR [rbp+0x350]
   1855e9c93:	48 8d 05 b6 b7 41 04 	lea    rax,[rip+0x441b7b6]        # 0x189a05450
   1855e9c9a:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855e9c9f:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855e9ca6:	00 00
   1855e9ca8:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855e9cad:	c7 44 24 28 4f 03 00 	mov    DWORD PTR [rsp+0x28],0x34f
   1855e9cb4:	00
   1855e9cb5:	4c 8d 0d 04 b6 41 04 	lea    r9,[rip+0x441b604]        # 0x189a052c0
   1855e9cbc:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855e9cc0:	ba 04 00 00 00       	mov    edx,0x4
   1855e9cc5:	49 89 f8             	mov    r8,rdi
   1855e9cc8:	e8 a3 35 a8 fa       	call   0x18006d270
   1855e9ccd:	90                   	nop
   1855e9cce:	48 8d 8d c0 03 00 00 	lea    rcx,[rbp+0x3c0]
   1855e9cd5:	48 8d bd 00 03 00 00 	lea    rdi,[rbp+0x300]
   1855e9cdc:	48 89 fa             	mov    rdx,rdi
   1855e9cdf:	e8 7c 6f b2 fa       	call   0x180110c60
   1855e9ce4:	90                   	nop
   1855e9ce5:	48 83 bd 18 03 00 00 	cmp    QWORD PTR [rbp+0x318],0x10
   1855e9cec:	10
   1855e9ced:	72 07                	jb     0x1855e9cf6
   1855e9cef:	48 8b bd 00 03 00 00 	mov    rdi,QWORD PTR [rbp+0x300]
   1855e9cf6:	48 89 bd 90 04 00 00 	mov    QWORD PTR [rbp+0x490],rdi
   1855e9cfd:	c6 85 98 04 00 00 00 	mov    BYTE PTR [rbp+0x498],0x0
   1855e9d04:	48 83 7e 30 10       	cmp    QWORD PTR [rsi+0x30],0x10
   1855e9d09:	0f 82 83 02 00 00    	jb     0x1855e9f92
   1855e9d0f:	48 8b 46 18          	mov    rax,QWORD PTR [rsi+0x18]
   1855e9d13:	e9 7e 02 00 00       	jmp    0x1855e9f96
   1855e9d18:	0f 29 b5 10 05 00 00 	movaps XMMWORD PTR [rbp+0x510],xmm6
   1855e9d1f:	0f 29 b5 20 05 00 00 	movaps XMMWORD PTR [rbp+0x520],xmm6
   1855e9d26:	0f 29 b5 40 05 00 00 	movaps XMMWORD PTR [rbp+0x540],xmm6
   1855e9d2d:	0f 29 b5 00 05 00 00 	movaps XMMWORD PTR [rbp+0x500],xmm6
   1855e9d34:	0f 29 b5 30 05 00 00 	movaps XMMWORD PTR [rbp+0x530],xmm6
   1855e9d3b:	c6 85 10 05 00 00 00 	mov    BYTE PTR [rbp+0x510],0x0
   1855e9d42:	c6 85 20 05 00 00 00 	mov    BYTE PTR [rbp+0x520],0x0
   1855e9d49:	c6 85 48 05 00 00 00 	mov    BYTE PTR [rbp+0x548],0x0
   1855e9d50:	c6 85 00 05 00 00 01 	mov    BYTE PTR [rbp+0x500],0x1
   1855e9d57:	48 89 bd e0 04 00 00 	mov    QWORD PTR [rbp+0x4e0],rdi
   1855e9d5e:	0f 29 b5 d0 04 00 00 	movaps XMMWORD PTR [rbp+0x4d0],xmm6
   1855e9d65:	0f 29 b5 c0 04 00 00 	movaps XMMWORD PTR [rbp+0x4c0],xmm6
   1855e9d6c:	0f 29 b5 b0 04 00 00 	movaps XMMWORD PTR [rbp+0x4b0],xmm6
   1855e9d73:	0f 29 b5 a0 04 00 00 	movaps XMMWORD PTR [rbp+0x4a0],xmm6
   1855e9d7a:	0f 29 b5 90 04 00 00 	movaps XMMWORD PTR [rbp+0x490],xmm6
   1855e9d81:	48 8b 95 e8 03 00 00 	mov    rdx,QWORD PTR [rbp+0x3e8]
   1855e9d88:	c6 85 e0 04 00 00 00 	mov    BYTE PTR [rbp+0x4e0],0x0
   1855e9d8f:	80 7a 50 01          	cmp    BYTE PTR [rdx+0x50],0x1
   1855e9d93:	0f 85 87 00 00 00    	jne    0x1855e9e20
   1855e9d99:	48 8d 8d 90 04 00 00 	lea    rcx,[rbp+0x490]
   1855e9da0:	e8 2b 3a 19 fb       	call   0x18077d7d0
   1855e9da5:	90                   	nop
   1855e9da6:	c6 85 e0 04 00 00 01 	mov    BYTE PTR [rbp+0x4e0],0x1
   1855e9dad:	8b 9d b0 04 00 00    	mov    ebx,DWORD PTR [rbp+0x4b0]
   1855e9db3:	48 89 9d 18 05 00 00 	mov    QWORD PTR [rbp+0x518],rbx
   1855e9dba:	c6 85 20 05 00 00 01 	mov    BYTE PTR [rbp+0x520],0x1
   1855e9dc1:	48 8d 15 f0 93 ab 03 	lea    rdx,[rip+0x3ab93f0]        # 0x1890a31b8
   1855e9dc8:	48 8d 7d 10          	lea    rdi,[rbp+0x10]
   1855e9dcc:	41 b8 f0 02 00 00    	mov    r8d,0x2f0
   1855e9dd2:	48 89 f9             	mov    rcx,rdi
   1855e9dd5:	e8 66 b0 12 02       	call   0x187714e40
   1855e9dda:	48 8b 8d f0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4f0]
   1855e9de1:	44 8b 8d b4 04 00 00 	mov    r9d,DWORD PTR [rbp+0x4b4]
   1855e9de8:	4c 8d 46 48          	lea    r8,[rsi+0x48]
   1855e9dec:	89 5c 24 20          	mov    DWORD PTR [rsp+0x20],ebx
   1855e9df0:	48 89 fa             	mov    rdx,rdi
   1855e9df3:	e8 98 fd 1c fc       	call   0x1817b9b90
   1855e9df8:	90                   	nop
   1855e9df9:	80 bd f8 02 00 00 01 	cmp    BYTE PTR [rbp+0x2f8],0x1
   1855e9e00:	75 1e                	jne    0x1855e9e20
   1855e9e02:	48 8b 85 58 01 00 00 	mov    rax,QWORD PTR [rbp+0x158]
   1855e9e09:	48 89 85 08 05 00 00 	mov    QWORD PTR [rbp+0x508],rax
   1855e9e10:	c6 85 10 05 00 00 01 	mov    BYTE PTR [rbp+0x510],0x1
   1855e9e17:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855e9e1b:	e8 20 28 be fa       	call   0x1801cc640
   1855e9e20:	b9 02 00 00 00       	mov    ecx,0x2
   1855e9e25:	e8 b6 2f a8 fa       	call   0x18006cde0
   1855e9e2a:	85 c0                	test   eax,eax
   1855e9e2c:	0f 84 32 01 00 00    	je     0x1855e9f64
   1855e9e32:	48 8d bd a0 03 00 00 	lea    rdi,[rbp+0x3a0]
   1855e9e39:	48 89 f9             	mov    rcx,rdi
   1855e9e3c:	e8 cf 30 a8 fa       	call   0x18006cf10
   1855e9e41:	90                   	nop
   1855e9e42:	48 83 bd b8 03 00 00 	cmp    QWORD PTR [rbp+0x3b8],0x10
   1855e9e49:	10
   1855e9e4a:	72 07                	jb     0x1855e9e53
   1855e9e4c:	48 8b bd a0 03 00 00 	mov    rdi,QWORD PTR [rbp+0x3a0]
   1855e9e53:	48 8d 05 f6 b5 41 04 	lea    rax,[rip+0x441b5f6]        # 0x189a05450
   1855e9e5a:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855e9e5f:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855e9e66:	00 00
   1855e9e68:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855e9e6d:	c7 44 24 28 5c 03 00 	mov    DWORD PTR [rsp+0x28],0x35c
   1855e9e74:	00
   1855e9e75:	4c 8d 0d 44 b4 41 04 	lea    r9,[rip+0x441b444]        # 0x189a052c0
   1855e9e7c:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855e9e80:	ba 02 00 00 00       	mov    edx,0x2
   1855e9e85:	49 89 f8             	mov    r8,rdi
   1855e9e88:	e8 e3 33 a8 fa       	call   0x18006d270
   1855e9e8d:	90                   	nop
   1855e9e8e:	48 8b 4e 38          	mov    rcx,QWORD PTR [rsi+0x38]
   1855e9e92:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   1855e9e95:	ff 50 10             	call   QWORD PTR [rax+0x10]
   1855e9e98:	90                   	nop
   1855e9e99:	48 c7 85 50 03 00 00 	mov    QWORD PTR [rbp+0x350],0x0
   1855e9ea0:	00 00 00 00
   1855e9ea4:	b9 07 00 00 00       	mov    ecx,0x7
   1855e9ea9:	48 8d 95 57 03 00 00 	lea    rdx,[rbp+0x357]
   1855e9eb0:	41 b8 cd cc cc cc    	mov    r8d,0xcccccccd
   1855e9eb6:	4c 8d 0d b3 d3 92 03 	lea    r9,[rip+0x392d3b3]        # 0x188f17270
   1855e9ebd:	0f 1f 00             	nop    DWORD PTR [rax]
   1855e9ec0:	41 89 c2             	mov    r10d,eax
   1855e9ec3:	4d 0f af d0          	imul   r10,r8
   1855e9ec7:	49 c1 ea 23          	shr    r10,0x23
   1855e9ecb:	47 8d 1c 12          	lea    r11d,[r10+r10*1]
   1855e9ecf:	47 8d 1c 9b          	lea    r11d,[r11+r11*4]
   1855e9ed3:	41 f7 db             	neg    r11d
   1855e9ed6:	41 01 c3             	add    r11d,eax
   1855e9ed9:	41 83 c3 23          	add    r11d,0x23
   1855e9edd:	47 0f b6 1c 0b       	movzx  r11d,BYTE PTR [r11+r9*1]
   1855e9ee2:	44 88 5a 01          	mov    BYTE PTR [rdx+0x1],r11b
   1855e9ee6:	48 ff c2             	inc    rdx
   1855e9ee9:	48 ff c1             	inc    rcx
   1855e9eec:	83 f8 09             	cmp    eax,0x9
   1855e9eef:	44 89 d0             	mov    eax,r10d
   1855e9ef2:	77 cc                	ja     0x1855e9ec0
   1855e9ef4:	48 8d 85 58 03 00 00 	lea    rax,[rbp+0x358]
   1855e9efb:	c6 42 01 00          	mov    BYTE PTR [rdx+0x1],0x0
   1855e9eff:	48 83 f9 09          	cmp    rcx,0x9
   1855e9f03:	72 27                	jb     0x1855e9f2c
   1855e9f05:	48 8d 8d 59 03 00 00 	lea    rcx,[rbp+0x359]
   1855e9f0c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
   1855e9f10:	44 0f b6 02          	movzx  r8d,BYTE PTR [rdx]
   1855e9f14:	44 0f b6 49 ff       	movzx  r9d,BYTE PTR [rcx-0x1]
   1855e9f19:	44 88 0a             	mov    BYTE PTR [rdx],r9b
   1855e9f1c:	48 ff ca             	dec    rdx
   1855e9f1f:	44 88 41 ff          	mov    BYTE PTR [rcx-0x1],r8b
   1855e9f23:	48 39 d1             	cmp    rcx,rdx
   1855e9f26:	48 8d 49 01          	lea    rcx,[rcx+0x1]
   1855e9f2a:	72 e4                	jb     0x1855e9f10
   1855e9f2c:	48 89 85 50 03 00 00 	mov    QWORD PTR [rbp+0x350],rax
   1855e9f33:	48 83 7e 60 10       	cmp    QWORD PTR [rsi+0x60],0x10
   1855e9f38:	0f 82 34 03 00 00    	jb     0x1855ea272
   1855e9f3e:	48 8b 46 48          	mov    rax,QWORD PTR [rsi+0x48]
   1855e9f42:	48 89 85 00 03 00 00 	mov    QWORD PTR [rbp+0x300],rax
   1855e9f49:	c6 85 08 03 00 00 00 	mov    BYTE PTR [rbp+0x308],0x0
   1855e9f50:	48 83 7e 30 10       	cmp    QWORD PTR [rsi+0x30],0x10
   1855e9f55:	0f 83 34 03 00 00    	jae    0x1855ea28f
   1855e9f5b:	48 8d 46 18          	lea    rax,[rsi+0x18]
   1855e9f5f:	e9 2f 03 00 00       	jmp    0x1855ea293
   1855e9f64:	48 8b 4e 08          	mov    rcx,QWORD PTR [rsi+0x8]
   1855e9f68:	48 8b 85 20 05 00 00 	mov    rax,QWORD PTR [rbp+0x520]
   1855e9f6f:	48 89 45 30          	mov    QWORD PTR [rbp+0x30],rax
   1855e9f73:	0f 28 85 00 05 00 00 	movaps xmm0,XMMWORD PTR [rbp+0x500]
   1855e9f7a:	0f 28 8d 10 05 00 00 	movaps xmm1,XMMWORD PTR [rbp+0x510]
   1855e9f81:	0f 29 4d 20          	movaps XMMWORD PTR [rbp+0x20],xmm1
   1855e9f85:	0f 29 45 10          	movaps XMMWORD PTR [rbp+0x10],xmm0
   1855e9f89:	c6 45 58 00          	mov    BYTE PTR [rbp+0x58],0x0
   1855e9f8d:	e9 3e 04 00 00       	jmp    0x1855ea3d0
   1855e9f92:	48 8d 46 18          	lea    rax,[rsi+0x18]
   1855e9f96:	48 89 85 00 05 00 00 	mov    QWORD PTR [rbp+0x500],rax
   1855e9f9d:	c6 85 08 05 00 00 00 	mov    BYTE PTR [rbp+0x508],0x0
   1855e9fa4:	0f 57 c0             	xorps  xmm0,xmm0
   1855e9fa7:	0f 11 85 80 04 00 00 	movups XMMWORD PTR [rbp+0x480],xmm0
   1855e9fae:	0f 11 85 70 04 00 00 	movups XMMWORD PTR [rbp+0x470],xmm0
   1855e9fb5:	0f 11 85 60 04 00 00 	movups XMMWORD PTR [rbp+0x460],xmm0
   1855e9fbc:	0f 11 85 50 04 00 00 	movups XMMWORD PTR [rbp+0x450],xmm0
   1855e9fc3:	0f 11 85 40 04 00 00 	movups XMMWORD PTR [rbp+0x440],xmm0
   1855e9fca:	0f 11 85 30 04 00 00 	movups XMMWORD PTR [rbp+0x430],xmm0
   1855e9fd1:	0f 11 85 20 04 00 00 	movups XMMWORD PTR [rbp+0x420],xmm0
   1855e9fd8:	48 8d 85 00 05 00 00 	lea    rax,[rbp+0x500]
   1855e9fdf:	48 89 85 10 04 00 00 	mov    QWORD PTR [rbp+0x410],rax
   1855e9fe6:	48 8d 85 90 04 00 00 	lea    rax,[rbp+0x490]
   1855e9fed:	48 89 85 18 04 00 00 	mov    QWORD PTR [rbp+0x418],rax
   1855e9ff4:	48 8d 15 7d c9 41 04 	lea    rdx,[rip+0x441c97d]        # 0x189a06978
   1855e9ffb:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855e9fff:	4c 8d 85 10 04 00 00 	lea    r8,[rbp+0x410]
   1855ea006:	e8 05 38 a8 fa       	call   0x18006d810
   1855ea00b:	90                   	nop
   1855ea00c:	48 8b 85 18 03 00 00 	mov    rax,QWORD PTR [rbp+0x318]
   1855ea013:	48 83 f8 10          	cmp    rax,0x10
   1855ea017:	72 38                	jb     0x1855ea051
   1855ea019:	48 8b 8d 00 03 00 00 	mov    rcx,QWORD PTR [rbp+0x300]
   1855ea020:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ea024:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ea02b:	72 1f                	jb     0x1855ea04c
   1855ea02d:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ea031:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ea035:	4c 29 c1             	sub    rcx,r8
   1855ea038:	48 83 f9 20          	cmp    rcx,0x20
   1855ea03c:	0f 83 27 05 00 00    	jae    0x1855ea569
   1855ea042:	48 83 c0 28          	add    rax,0x28
   1855ea046:	48 89 c2             	mov    rdx,rax
   1855ea049:	4c 89 c1             	mov    rcx,r8
   1855ea04c:	e8 cf 1c f6 01       	call   0x18754bd20
   1855ea051:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855ea055:	e8 16 33 a8 fa       	call   0x18006d370
   1855ea05a:	48 8b 85 68 03 00 00 	mov    rax,QWORD PTR [rbp+0x368]
   1855ea061:	48 83 f8 10          	cmp    rax,0x10
   1855ea065:	72 38                	jb     0x1855ea09f
   1855ea067:	48 8b 8d 50 03 00 00 	mov    rcx,QWORD PTR [rbp+0x350]
   1855ea06e:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ea072:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ea079:	72 1f                	jb     0x1855ea09a
   1855ea07b:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ea07f:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ea083:	4c 29 c1             	sub    rcx,r8
   1855ea086:	48 83 f9 20          	cmp    rcx,0x20
   1855ea08a:	0f 83 d9 04 00 00    	jae    0x1855ea569
   1855ea090:	48 83 c0 28          	add    rax,0x28
   1855ea094:	48 89 c2             	mov    rdx,rax
   1855ea097:	4c 89 c1             	mov    rcx,r8
   1855ea09a:	e8 81 1c f6 01       	call   0x18754bd20
   1855ea09f:	48 8b 76 08          	mov    rsi,QWORD PTR [rsi+0x8]
   1855ea0a3:	48 8d 8d c0 03 00 00 	lea    rcx,[rbp+0x3c0]
   1855ea0aa:	48 8d bd 90 04 00 00 	lea    rdi,[rbp+0x490]
   1855ea0b1:	48 89 fa             	mov    rdx,rdi
   1855ea0b4:	e8 a7 6b b2 fa       	call   0x180110c60
   1855ea0b9:	90                   	nop
   1855ea0ba:	4c 8b 85 a0 04 00 00 	mov    r8,QWORD PTR [rbp+0x4a0]
   1855ea0c1:	48 8b 85 a8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4a8]
   1855ea0c8:	48 89 c1             	mov    rcx,rax
   1855ea0cb:	4c 29 c1             	sub    rcx,r8
   1855ea0ce:	48 8d 1d 0b aa 41 04 	lea    rbx,[rip+0x441aa0b]        # 0x189a04ae0
   1855ea0d5:	48 83 f9 1c          	cmp    rcx,0x1c
   1855ea0d9:	73 2b                	jae    0x1855ea106
   1855ea0db:	48 89 5c 24 20       	mov    QWORD PTR [rsp+0x20],rbx
   1855ea0e0:	48 c7 44 24 28 1c 00 	mov    QWORD PTR [rsp+0x28],0x1c
   1855ea0e7:	00 00
   1855ea0e9:	48 8d 8d 90 04 00 00 	lea    rcx,[rbp+0x490]
   1855ea0f0:	ba 1c 00 00 00       	mov    edx,0x1c
   1855ea0f5:	45 31 c9             	xor    r9d,r9d
   1855ea0f8:	e8 53 1c a2 fa       	call   0x18000bd50
   1855ea0fd:	90                   	nop
   1855ea0fe:	48 89 c7             	mov    rdi,rax
   1855ea101:	e9 8f 00 00 00       	jmp    0x1855ea195
   1855ea106:	49 8d 48 1c          	lea    rcx,[r8+0x1c]
   1855ea10a:	48 89 8d a0 04 00 00 	mov    QWORD PTR [rbp+0x4a0],rcx
   1855ea111:	48 83 f8 10          	cmp    rax,0x10
   1855ea115:	48 8b 8d 90 04 00 00 	mov    rcx,QWORD PTR [rbp+0x490]
   1855ea11c:	49 89 fe             	mov    r14,rdi
   1855ea11f:	4c 0f 43 f1          	cmovae r14,rcx
   1855ea123:	48 8d 15 d2 a9 41 04 	lea    rdx,[rip+0x441a9d2]        # 0x189a04afc
   1855ea12a:	49 39 d6             	cmp    r14,rdx
   1855ea12d:	0f 93 c2             	setae  dl
   1855ea130:	4f 8d 0c 06          	lea    r9,[r14+r8*1]
   1855ea134:	49 39 d9             	cmp    r9,rbx
   1855ea137:	41 0f 92 c1          	setb   r9b
   1855ea13b:	41 08 d1             	or     r9b,dl
   1855ea13e:	41 bf 1c 00 00 00    	mov    r15d,0x1c
   1855ea144:	41 bc 1c 00 00 00    	mov    r12d,0x1c
   1855ea14a:	75 0b                	jne    0x1855ea157
   1855ea14c:	4d 89 f4             	mov    r12,r14
   1855ea14f:	49 29 dc             	sub    r12,rbx
   1855ea152:	77 03                	ja     0x1855ea157
   1855ea154:	45 31 e4             	xor    r12d,r12d
   1855ea157:	49 ff c0             	inc    r8
   1855ea15a:	48 83 f8 10          	cmp    rax,0x10
   1855ea15e:	48 0f 42 cf          	cmovb  rcx,rdi
   1855ea162:	48 83 c1 1c          	add    rcx,0x1c
   1855ea166:	4c 89 f2             	mov    rdx,r14
   1855ea169:	e8 d2 ac 12 02       	call   0x187714e40
   1855ea16e:	4c 89 f1             	mov    rcx,r14
   1855ea171:	48 89 da             	mov    rdx,rbx
   1855ea174:	4d 89 e0             	mov    r8,r12
   1855ea177:	e8 c4 ac 12 02       	call   0x187714e40
   1855ea17c:	4d 29 e7             	sub    r15,r12
   1855ea17f:	49 8d 14 1c          	lea    rdx,[r12+rbx*1]
   1855ea183:	48 83 c2 1c          	add    rdx,0x1c
   1855ea187:	4d 01 e6             	add    r14,r12
   1855ea18a:	4c 89 f1             	mov    rcx,r14
   1855ea18d:	4d 89 f8             	mov    r8,r15
   1855ea190:	e8 ab ac 12 02       	call   0x187714e40
   1855ea195:	0f 10 07             	movups xmm0,XMMWORD PTR [rdi]
   1855ea198:	0f 10 4f 10          	movups xmm1,XMMWORD PTR [rdi+0x10]
   1855ea19c:	0f 29 8d 20 04 00 00 	movaps XMMWORD PTR [rbp+0x420],xmm1
   1855ea1a3:	0f 29 85 10 04 00 00 	movaps XMMWORD PTR [rbp+0x410],xmm0
   1855ea1aa:	48 c7 47 10 00 00 00 	mov    QWORD PTR [rdi+0x10],0x0
   1855ea1b1:	00
   1855ea1b2:	48 c7 47 18 0f 00 00 	mov    QWORD PTR [rdi+0x18],0xf
   1855ea1b9:	00
   1855ea1ba:	c6 07 00             	mov    BYTE PTR [rdi],0x0
   1855ea1bd:	0f 29 75 20          	movaps XMMWORD PTR [rbp+0x20],xmm6
   1855ea1c1:	0f 29 75 30          	movaps XMMWORD PTR [rbp+0x30],xmm6
   1855ea1c5:	0f 29 75 50          	movaps XMMWORD PTR [rbp+0x50],xmm6
   1855ea1c9:	0f 29 75 10          	movaps XMMWORD PTR [rbp+0x10],xmm6
   1855ea1cd:	0f 29 75 40          	movaps XMMWORD PTR [rbp+0x40],xmm6
   1855ea1d1:	c6 45 20 00          	mov    BYTE PTR [rbp+0x20],0x0
   1855ea1d5:	c6 45 30 00          	mov    BYTE PTR [rbp+0x30],0x0
   1855ea1d9:	c6 45 58 00          	mov    BYTE PTR [rbp+0x58],0x0
   1855ea1dd:	c6 45 10 00          	mov    BYTE PTR [rbp+0x10],0x0
   1855ea1e1:	48 8d 4d 38          	lea    rcx,[rbp+0x38]
   1855ea1e5:	48 8d 95 10 04 00 00 	lea    rdx,[rbp+0x410]
   1855ea1ec:	e8 ff ad 3a fc       	call   0x181994ff0
   1855ea1f1:	90                   	nop
   1855ea1f2:	48 8d 55 10          	lea    rdx,[rbp+0x10]
   1855ea1f6:	48 89 f1             	mov    rcx,rsi
   1855ea1f9:	e8 32 86 ff ff       	call   0x1855e2830
   1855ea1fe:	90                   	nop
   1855ea1ff:	48 8b 85 28 04 00 00 	mov    rax,QWORD PTR [rbp+0x428]
   1855ea206:	48 83 f8 10          	cmp    rax,0x10
   1855ea20a:	72 38                	jb     0x1855ea244
   1855ea20c:	48 8b 8d 10 04 00 00 	mov    rcx,QWORD PTR [rbp+0x410]
   1855ea213:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ea217:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ea21e:	72 1f                	jb     0x1855ea23f
   1855ea220:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ea224:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ea228:	4c 29 c1             	sub    rcx,r8
   1855ea22b:	48 83 f9 20          	cmp    rcx,0x20
   1855ea22f:	0f 83 34 03 00 00    	jae    0x1855ea569
   1855ea235:	48 83 c0 28          	add    rax,0x28
   1855ea239:	48 89 c2             	mov    rdx,rax
   1855ea23c:	4c 89 c1             	mov    rcx,r8
   1855ea23f:	e8 dc 1a f6 01       	call   0x18754bd20
   1855ea244:	48 8b 85 a8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4a8]
   1855ea24b:	48 83 f8 10          	cmp    rax,0x10
   1855ea24f:	0f 82 68 02 00 00    	jb     0x1855ea4bd
   1855ea255:	48 8b 8d 90 04 00 00 	mov    rcx,QWORD PTR [rbp+0x490]
   1855ea25c:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ea260:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ea267:	0f 83 2c 02 00 00    	jae    0x1855ea499
   1855ea26d:	e9 46 02 00 00       	jmp    0x1855ea4b8
   1855ea272:	48 8d 46 48          	lea    rax,[rsi+0x48]
   1855ea276:	48 89 85 00 03 00 00 	mov    QWORD PTR [rbp+0x300],rax
   1855ea27d:	c6 85 08 03 00 00 00 	mov    BYTE PTR [rbp+0x308],0x0
   1855ea284:	48 83 7e 30 10       	cmp    QWORD PTR [rsi+0x30],0x10
   1855ea289:	0f 82 cc fc ff ff    	jb     0x1855e9f5b
   1855ea28f:	48 8b 46 18          	mov    rax,QWORD PTR [rsi+0x18]
   1855ea293:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
   1855ea297:	c6 45 c8 00          	mov    BYTE PTR [rbp-0x38],0x0
   1855ea29b:	0f 57 c0             	xorps  xmm0,xmm0
   1855ea29e:	0f 11 85 78 04 00 00 	movups XMMWORD PTR [rbp+0x478],xmm0
   1855ea2a5:	0f 11 85 68 04 00 00 	movups XMMWORD PTR [rbp+0x468],xmm0
   1855ea2ac:	0f 11 85 58 04 00 00 	movups XMMWORD PTR [rbp+0x458],xmm0
   1855ea2b3:	0f 11 85 48 04 00 00 	movups XMMWORD PTR [rbp+0x448],xmm0
   1855ea2ba:	0f 11 85 38 04 00 00 	movups XMMWORD PTR [rbp+0x438],xmm0
   1855ea2c1:	0f 11 85 28 04 00 00 	movups XMMWORD PTR [rbp+0x428],xmm0
   1855ea2c8:	48 c7 85 88 04 00 00 	mov    QWORD PTR [rbp+0x488],0x0
   1855ea2cf:	00 00 00 00
   1855ea2d3:	48 8d 45 c0          	lea    rax,[rbp-0x40]
   1855ea2d7:	48 89 85 10 04 00 00 	mov    QWORD PTR [rbp+0x410],rax
   1855ea2de:	48 8d 85 00 03 00 00 	lea    rax,[rbp+0x300]
   1855ea2e5:	48 89 85 18 04 00 00 	mov    QWORD PTR [rbp+0x418],rax
   1855ea2ec:	48 8d 85 50 03 00 00 	lea    rax,[rbp+0x350]
   1855ea2f3:	48 89 85 20 04 00 00 	mov    QWORD PTR [rbp+0x420],rax
   1855ea2fa:	48 8d 15 8f c2 41 04 	lea    rdx,[rip+0x441c28f]        # 0x189a06590
   1855ea301:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855ea305:	4c 8d 85 10 04 00 00 	lea    r8,[rbp+0x410]
   1855ea30c:	e8 ff 34 a8 fa       	call   0x18006d810
   1855ea311:	90                   	nop
   1855ea312:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855ea316:	e8 55 30 a8 fa       	call   0x18006d370
   1855ea31b:	48 8b 85 b8 03 00 00 	mov    rax,QWORD PTR [rbp+0x3b8]
   1855ea322:	48 83 f8 10          	cmp    rax,0x10
   1855ea326:	72 38                	jb     0x1855ea360
   1855ea328:	48 8b 8d a0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3a0]
   1855ea32f:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ea333:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ea33a:	72 1f                	jb     0x1855ea35b
   1855ea33c:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ea340:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ea344:	4c 29 c1             	sub    rcx,r8
   1855ea347:	48 83 f9 20          	cmp    rcx,0x20
   1855ea34b:	0f 83 18 02 00 00    	jae    0x1855ea569
   1855ea351:	48 83 c0 28          	add    rax,0x28
   1855ea355:	48 89 c2             	mov    rdx,rax
   1855ea358:	4c 89 c1             	mov    rcx,r8
   1855ea35b:	e8 c0 19 f6 01       	call   0x18754bd20
   1855ea360:	0f b6 85 48 05 00 00 	movzx  eax,BYTE PTR [rbp+0x548]
   1855ea367:	48 8b 4e 08          	mov    rcx,QWORD PTR [rsi+0x8]
   1855ea36b:	0f 28 85 00 05 00 00 	movaps xmm0,XMMWORD PTR [rbp+0x500]
   1855ea372:	0f 28 8d 10 05 00 00 	movaps xmm1,XMMWORD PTR [rbp+0x510]
   1855ea379:	0f 29 45 10          	movaps XMMWORD PTR [rbp+0x10],xmm0
   1855ea37d:	0f 29 4d 20          	movaps XMMWORD PTR [rbp+0x20],xmm1
   1855ea381:	48 8b 95 20 05 00 00 	mov    rdx,QWORD PTR [rbp+0x520]
   1855ea388:	48 89 55 30          	mov    QWORD PTR [rbp+0x30],rdx
   1855ea38c:	c6 45 58 00          	mov    BYTE PTR [rbp+0x58],0x0
   1855ea390:	3c 01                	cmp    al,0x1
   1855ea392:	75 3c                	jne    0x1855ea3d0
   1855ea394:	0f 10 85 28 05 00 00 	movups xmm0,XMMWORD PTR [rbp+0x528]
   1855ea39b:	0f 10 8d 38 05 00 00 	movups xmm1,XMMWORD PTR [rbp+0x538]
   1855ea3a2:	0f 11 4d 48          	movups XMMWORD PTR [rbp+0x48],xmm1
   1855ea3a6:	0f 11 45 38          	movups XMMWORD PTR [rbp+0x38],xmm0
   1855ea3aa:	48 c7 85 38 05 00 00 	mov    QWORD PTR [rbp+0x538],0x0
   1855ea3b1:	00 00 00 00
   1855ea3b5:	48 c7 85 40 05 00 00 	mov    QWORD PTR [rbp+0x540],0xf
   1855ea3bc:	0f 00 00 00
   1855ea3c0:	c6 85 28 05 00 00 00 	mov    BYTE PTR [rbp+0x528],0x0
   1855ea3c7:	c6 45 58 01          	mov    BYTE PTR [rbp+0x58],0x1
   1855ea3cb:	40 b6 01             	mov    sil,0x1
   1855ea3ce:	eb 02                	jmp    0x1855ea3d2
   1855ea3d0:	31 f6                	xor    esi,esi
   1855ea3d2:	48 8d 55 10          	lea    rdx,[rbp+0x10]
   1855ea3d6:	e8 55 84 ff ff       	call   0x1855e2830
   1855ea3db:	90                   	nop
   1855ea3dc:	80 bd e0 04 00 00 01 	cmp    BYTE PTR [rbp+0x4e0],0x1
   1855ea3e3:	0f 85 8a 00 00 00    	jne    0x1855ea473
   1855ea3e9:	48 8b 85 d8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4d8]
   1855ea3f0:	48 83 f8 10          	cmp    rax,0x10
   1855ea3f4:	72 38                	jb     0x1855ea42e
   1855ea3f6:	48 8b 8d c0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4c0]
   1855ea3fd:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ea401:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ea408:	72 1f                	jb     0x1855ea429
   1855ea40a:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ea40e:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ea412:	4c 29 c1             	sub    rcx,r8
   1855ea415:	48 83 f9 20          	cmp    rcx,0x20
   1855ea419:	0f 83 4a 01 00 00    	jae    0x1855ea569
   1855ea41f:	48 83 c0 28          	add    rax,0x28
   1855ea423:	48 89 c2             	mov    rdx,rax
   1855ea426:	4c 89 c1             	mov    rcx,r8
   1855ea429:	e8 f2 18 f6 01       	call   0x18754bd20
   1855ea42e:	48 8b 85 a8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4a8]
   1855ea435:	48 83 f8 10          	cmp    rax,0x10
   1855ea439:	72 38                	jb     0x1855ea473
   1855ea43b:	48 8b 8d 90 04 00 00 	mov    rcx,QWORD PTR [rbp+0x490]
   1855ea442:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ea446:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ea44d:	72 1f                	jb     0x1855ea46e
   1855ea44f:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ea453:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ea457:	4c 29 c1             	sub    rcx,r8
   1855ea45a:	48 83 f9 20          	cmp    rcx,0x20
   1855ea45e:	0f 83 05 01 00 00    	jae    0x1855ea569
   1855ea464:	48 83 c0 28          	add    rax,0x28
   1855ea468:	48 89 c2             	mov    rdx,rax
   1855ea46b:	4c 89 c1             	mov    rcx,r8
   1855ea46e:	e8 ad 18 f6 01       	call   0x18754bd20
   1855ea473:	40 84 f6             	test   sil,sil
   1855ea476:	74 45                	je     0x1855ea4bd
   1855ea478:	48 8b 85 40 05 00 00 	mov    rax,QWORD PTR [rbp+0x540]
   1855ea47f:	48 83 f8 10          	cmp    rax,0x10
   1855ea483:	72 38                	jb     0x1855ea4bd
   1855ea485:	48 8b 8d 28 05 00 00 	mov    rcx,QWORD PTR [rbp+0x528]
   1855ea48c:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ea490:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ea497:	72 1f                	jb     0x1855ea4b8
   1855ea499:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ea49d:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ea4a1:	4c 29 c1             	sub    rcx,r8
   1855ea4a4:	48 83 f9 20          	cmp    rcx,0x20
   1855ea4a8:	0f 83 bb 00 00 00    	jae    0x1855ea569
   1855ea4ae:	48 83 c0 28          	add    rax,0x28
   1855ea4b2:	48 89 c2             	mov    rdx,rax
   1855ea4b5:	4c 89 c1             	mov    rcx,r8
   1855ea4b8:	e8 63 18 f6 01       	call   0x18754bd20
   1855ea4bd:	48 8b b5 f0 03 00 00 	mov    rsi,QWORD PTR [rbp+0x3f0]
   1855ea4c4:	48 85 f6             	test   rsi,rsi
   1855ea4c7:	74 1d                	je     0x1855ea4e6
   1855ea4c9:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855ea4cd:	75 17                	jne    0x1855ea4e6
   1855ea4cf:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ea4d2:	48 89 f1             	mov    rcx,rsi
   1855ea4d5:	ff 10                	call   QWORD PTR [rax]
   1855ea4d7:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855ea4db:	75 09                	jne    0x1855ea4e6
   1855ea4dd:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ea4e0:	48 89 f1             	mov    rcx,rsi
   1855ea4e3:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ea4e6:	48 8b 85 e0 03 00 00 	mov    rax,QWORD PTR [rbp+0x3e0]
   1855ea4ed:	48 83 f8 10          	cmp    rax,0x10
   1855ea4f1:	72 34                	jb     0x1855ea527
   1855ea4f3:	48 8b 8d c8 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3c8]
   1855ea4fa:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ea4fe:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ea505:	72 1b                	jb     0x1855ea522
   1855ea507:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ea50b:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ea50f:	4c 29 c1             	sub    rcx,r8
   1855ea512:	48 83 f9 20          	cmp    rcx,0x20
   1855ea516:	73 51                	jae    0x1855ea569
   1855ea518:	48 83 c0 28          	add    rax,0x28
   1855ea51c:	48 89 c2             	mov    rdx,rax
   1855ea51f:	4c 89 c1             	mov    rcx,r8
   1855ea522:	e8 f9 17 f6 01       	call   0x18754bd20
   1855ea527:	48 8b b5 f8 04 00 00 	mov    rsi,QWORD PTR [rbp+0x4f8]
   1855ea52e:	48 85 f6             	test   rsi,rsi
   1855ea531:	74 1d                	je     0x1855ea550
   1855ea533:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855ea537:	75 17                	jne    0x1855ea550
   1855ea539:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ea53c:	48 89 f1             	mov    rcx,rsi
   1855ea53f:	ff 10                	call   QWORD PTR [rax]
   1855ea541:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855ea545:	75 09                	jne    0x1855ea550
   1855ea547:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ea54a:	48 89 f1             	mov    rcx,rsi
   1855ea54d:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ea550:	0f 28 b5 60 05 00 00 	movaps xmm6,XMMWORD PTR [rbp+0x560]
   1855ea557:	48 81 c4 f0 05 00 00 	add    rsp,0x5f0
   1855ea55e:	5b                   	pop    rbx
   1855ea55f:	5f                   	pop    rdi
   1855ea560:	5e                   	pop    rsi
   1855ea561:	41 5c                	pop    r12
   1855ea563:	41 5e                	pop    r14
   1855ea565:	41 5f                	pop    r15
   1855ea567:	5d                   	pop    rbp
   1855ea568:	c3                   	ret
   1855ea569:	e8 1e 3c 0f 02       	call   0x1876de18c
   1855ea56e:	cc                   	int3
