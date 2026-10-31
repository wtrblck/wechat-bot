
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001819b9d10 <.text+0x19b8d10>:
   1819b9d10:	55                   	push   rbp
   1819b9d11:	41 57                	push   r15
   1819b9d13:	41 56                	push   r14
   1819b9d15:	41 54                	push   r12
   1819b9d17:	56                   	push   rsi
   1819b9d18:	57                   	push   rdi
   1819b9d19:	53                   	push   rbx
   1819b9d1a:	48 83 ec 50          	sub    rsp,0x50
   1819b9d1e:	48 8d 6c 24 50       	lea    rbp,[rsp+0x50]
   1819b9d23:	48 c7 45 f8 fe ff ff 	mov    QWORD PTR [rbp-0x8],0xfffffffffffffffe
   1819b9d2a:	ff 
   1819b9d2b:	48 89 d6             	mov    rsi,rdx
   1819b9d2e:	0f 57 c0             	xorps  xmm0,xmm0
   1819b9d31:	0f 29 45 d0          	movaps XMMWORD PTR [rbp-0x30],xmm0
   1819b9d35:	48 c7 45 e0 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
   1819b9d3c:	00 
   1819b9d3d:	49 8b 78 08          	mov    rdi,QWORD PTR [r8+0x8]
   1819b9d41:	49 8b 08             	mov    rcx,QWORD PTR [r8]
   1819b9d44:	48 89 f8             	mov    rax,rdi
   1819b9d47:	48 29 c8             	sub    rax,rcx
   1819b9d4a:	48 29 cf             	sub    rdi,rcx
   1819b9d4d:	74 3f                	je     0x1819b9d8e
   1819b9d4f:	48 c1 f8 04          	sar    rax,0x4
   1819b9d53:	48 89 c1             	mov    rcx,rax
   1819b9d56:	48 c1 e9 3c          	shr    rcx,0x3c
   1819b9d5a:	0f 85 3a 02 00 00    	jne    0x1819b9f9a
   1819b9d60:	4d 89 c6             	mov    r14,r8
   1819b9d63:	48 3d 00 01 00 00    	cmp    rax,0x100
   1819b9d69:	72 2c                	jb     0x1819b9d97
   1819b9d6b:	48 8d 4f 27          	lea    rcx,[rdi+0x27]
   1819b9d6f:	e8 68 1f b9 05       	call   0x18754bcdc
   1819b9d74:	48 85 c0             	test   rax,rax
   1819b9d77:	0f 84 18 02 00 00    	je     0x1819b9f95
   1819b9d7d:	48 89 c3             	mov    rbx,rax
   1819b9d80:	48 83 c3 27          	add    rbx,0x27
   1819b9d84:	48 83 e3 e0          	and    rbx,0xffffffffffffffe0
   1819b9d88:	48 89 43 f8          	mov    QWORD PTR [rbx-0x8],rax
   1819b9d8c:	eb 14                	jmp    0x1819b9da2
   1819b9d8e:	31 ff                	xor    edi,edi
   1819b9d90:	31 db                	xor    ebx,ebx
   1819b9d92:	45 31 ff             	xor    r15d,r15d
   1819b9d95:	eb 6b                	jmp    0x1819b9e02
   1819b9d97:	48 89 f9             	mov    rcx,rdi
   1819b9d9a:	e8 3d 1f b9 05       	call   0x18754bcdc
   1819b9d9f:	48 89 c3             	mov    rbx,rax
   1819b9da2:	48 89 5d d0          	mov    QWORD PTR [rbp-0x30],rbx
   1819b9da6:	48 01 df             	add    rdi,rbx
   1819b9da9:	48 89 7d e0          	mov    QWORD PTR [rbp-0x20],rdi
   1819b9dad:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1819b9db0:	49 8b 4e 08          	mov    rcx,QWORD PTR [r14+0x8]
   1819b9db4:	49 89 df             	mov    r15,rbx
   1819b9db7:	48 39 c8             	cmp    rax,rcx
   1819b9dba:	74 42                	je     0x1819b9dfe
   1819b9dbc:	0f 57 c0             	xorps  xmm0,xmm0
   1819b9dbf:	49 89 df             	mov    r15,rbx
   1819b9dc2:	eb 27                	jmp    0x1819b9deb
   1819b9dc4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   1819b9dcb:	00 00 00 00 00 
   1819b9dd0:	48 8b 10             	mov    rdx,QWORD PTR [rax]
   1819b9dd3:	49 89 17             	mov    QWORD PTR [r15],rdx
   1819b9dd6:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
   1819b9dda:	49 89 57 08          	mov    QWORD PTR [r15+0x8],rdx
   1819b9dde:	49 83 c7 10          	add    r15,0x10
   1819b9de2:	48 83 c0 10          	add    rax,0x10
   1819b9de6:	48 39 c8             	cmp    rax,rcx
   1819b9de9:	74 13                	je     0x1819b9dfe
   1819b9deb:	41 0f 11 07          	movups XMMWORD PTR [r15],xmm0
   1819b9def:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
   1819b9df3:	48 85 d2             	test   rdx,rdx
   1819b9df6:	74 d8                	je     0x1819b9dd0
   1819b9df8:	f0 ff 42 08          	lock inc DWORD PTR [rdx+0x8]
   1819b9dfc:	eb d2                	jmp    0x1819b9dd0
   1819b9dfe:	4c 89 7d d8          	mov    QWORD PTR [rbp-0x28],r15
   1819b9e02:	b9 20 00 00 00       	mov    ecx,0x20
   1819b9e07:	e8 d0 1e b9 05       	call   0x18754bcdc
   1819b9e0c:	90                   	nop
   1819b9e0d:	49 89 c0             	mov    r8,rax
   1819b9e10:	4c 89 f8             	mov    rax,r15
   1819b9e13:	48 29 d8             	sub    rax,rbx
   1819b9e16:	4d 89 fe             	mov    r14,r15
   1819b9e19:	48 8d 0d 68 02 93 07 	lea    rcx,[rip+0x7930268]        # 0x1892ea088
   1819b9e20:	49 89 08             	mov    QWORD PTR [r8],rcx
   1819b9e23:	0f 57 c0             	xorps  xmm0,xmm0
   1819b9e26:	41 0f 11 40 08       	movups XMMWORD PTR [r8+0x8],xmm0
   1819b9e2b:	49 c7 40 18 00 00 00 	mov    QWORD PTR [r8+0x18],0x0
   1819b9e32:	00 
   1819b9e33:	49 29 de             	sub    r14,rbx
   1819b9e36:	0f 84 a5 00 00 00    	je     0x1819b9ee1
   1819b9e3c:	48 c1 f8 04          	sar    rax,0x4
   1819b9e40:	48 89 c1             	mov    rcx,rax
   1819b9e43:	48 c1 e9 3c          	shr    rcx,0x3c
   1819b9e47:	4c 89 45 f0          	mov    QWORD PTR [rbp-0x10],r8
   1819b9e4b:	0f 85 4f 01 00 00    	jne    0x1819b9fa0
   1819b9e51:	48 3d 00 01 00 00    	cmp    rax,0x100
   1819b9e57:	72 24                	jb     0x1819b9e7d
   1819b9e59:	49 8d 4e 27          	lea    rcx,[r14+0x27]
   1819b9e5d:	e8 7a 1e b9 05       	call   0x18754bcdc
   1819b9e62:	90                   	nop
   1819b9e63:	48 85 c0             	test   rax,rax
   1819b9e66:	0f 84 29 01 00 00    	je     0x1819b9f95
   1819b9e6c:	48 89 c1             	mov    rcx,rax
   1819b9e6f:	48 83 c0 27          	add    rax,0x27
   1819b9e73:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
   1819b9e77:	48 89 48 f8          	mov    QWORD PTR [rax-0x8],rcx
   1819b9e7b:	eb 09                	jmp    0x1819b9e86
   1819b9e7d:	4c 89 f1             	mov    rcx,r14
   1819b9e80:	e8 57 1e b9 05       	call   0x18754bcdc
   1819b9e85:	90                   	nop
   1819b9e86:	4c 8b 45 f0          	mov    r8,QWORD PTR [rbp-0x10]
   1819b9e8a:	49 89 40 08          	mov    QWORD PTR [r8+0x8],rax
   1819b9e8e:	49 89 40 10          	mov    QWORD PTR [r8+0x10],rax
   1819b9e92:	49 01 c6             	add    r14,rax
   1819b9e95:	4d 89 70 18          	mov    QWORD PTR [r8+0x18],r14
   1819b9e99:	0f 57 c0             	xorps  xmm0,xmm0
   1819b9e9c:	48 89 d9             	mov    rcx,rbx
   1819b9e9f:	eb 2a                	jmp    0x1819b9ecb
   1819b9ea1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   1819b9ea8:	0f 1f 84 00 00 00 00 
   1819b9eaf:	00 
   1819b9eb0:	48 8b 11             	mov    rdx,QWORD PTR [rcx]
   1819b9eb3:	48 89 10             	mov    QWORD PTR [rax],rdx
   1819b9eb6:	48 8b 51 08          	mov    rdx,QWORD PTR [rcx+0x8]
   1819b9eba:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
   1819b9ebe:	48 83 c0 10          	add    rax,0x10
   1819b9ec2:	48 83 c1 10          	add    rcx,0x10
   1819b9ec6:	4c 39 f9             	cmp    rcx,r15
   1819b9ec9:	74 12                	je     0x1819b9edd
   1819b9ecb:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   1819b9ece:	48 8b 51 08          	mov    rdx,QWORD PTR [rcx+0x8]
   1819b9ed2:	48 85 d2             	test   rdx,rdx
   1819b9ed5:	74 d9                	je     0x1819b9eb0
   1819b9ed7:	f0 ff 42 08          	lock inc DWORD PTR [rdx+0x8]
   1819b9edb:	eb d3                	jmp    0x1819b9eb0
   1819b9edd:	49 89 40 10          	mov    QWORD PTR [r8+0x10],rax
   1819b9ee1:	4d 85 c0             	test   r8,r8
   1819b9ee4:	74 1d                	je     0x1819b9f03
   1819b9ee6:	4c 89 46 38          	mov    QWORD PTR [rsi+0x38],r8
   1819b9eea:	0f 57 c0             	xorps  xmm0,xmm0
   1819b9eed:	0f 11 46 40          	movups XMMWORD PTR [rsi+0x40],xmm0
   1819b9ef1:	48 c7 46 50 00 00 00 	mov    QWORD PTR [rsi+0x50],0x0
   1819b9ef8:	00 
   1819b9ef9:	48 85 db             	test   rbx,rbx
   1819b9efc:	75 18                	jne    0x1819b9f16
   1819b9efe:	e9 80 00 00 00       	jmp    0x1819b9f83
   1819b9f03:	48 8d 46 38          	lea    rax,[rsi+0x38]
   1819b9f07:	0f 57 c0             	xorps  xmm0,xmm0
   1819b9f0a:	0f 11 40 10          	movups XMMWORD PTR [rax+0x10],xmm0
   1819b9f0e:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   1819b9f11:	48 85 db             	test   rbx,rbx
   1819b9f14:	74 6d                	je     0x1819b9f83
   1819b9f16:	49 39 df             	cmp    r15,rbx
   1819b9f19:	74 39                	je     0x1819b9f54
   1819b9f1b:	49 89 dc             	mov    r12,rbx
   1819b9f1e:	eb 09                	jmp    0x1819b9f29
   1819b9f20:	49 83 c4 10          	add    r12,0x10
   1819b9f24:	4d 39 fc             	cmp    r12,r15
   1819b9f27:	74 2b                	je     0x1819b9f54
   1819b9f29:	4d 8b 74 24 08       	mov    r14,QWORD PTR [r12+0x8]
   1819b9f2e:	4d 85 f6             	test   r14,r14
   1819b9f31:	74 ed                	je     0x1819b9f20
   1819b9f33:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1819b9f38:	75 e6                	jne    0x1819b9f20
   1819b9f3a:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1819b9f3d:	4c 89 f1             	mov    rcx,r14
   1819b9f40:	ff 10                	call   QWORD PTR [rax]
   1819b9f42:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1819b9f47:	75 d7                	jne    0x1819b9f20
   1819b9f49:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1819b9f4c:	4c 89 f1             	mov    rcx,r14
   1819b9f4f:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1819b9f52:	eb cc                	jmp    0x1819b9f20
   1819b9f54:	48 29 df             	sub    rdi,rbx
   1819b9f57:	48 81 ff 00 10 00 00 	cmp    rdi,0x1000
   1819b9f5e:	72 18                	jb     0x1819b9f78
   1819b9f60:	48 8b 43 f8          	mov    rax,QWORD PTR [rbx-0x8]
   1819b9f64:	48 83 c3 f8          	add    rbx,0xfffffffffffffff8
   1819b9f68:	48 29 c3             	sub    rbx,rax
   1819b9f6b:	48 83 fb 20          	cmp    rbx,0x20
   1819b9f6f:	73 24                	jae    0x1819b9f95
   1819b9f71:	48 83 c7 27          	add    rdi,0x27
   1819b9f75:	48 89 c3             	mov    rbx,rax
   1819b9f78:	48 89 d9             	mov    rcx,rbx
   1819b9f7b:	48 89 fa             	mov    rdx,rdi
   1819b9f7e:	e8 9d 1d b9 05       	call   0x18754bd20
   1819b9f83:	48 89 f0             	mov    rax,rsi
   1819b9f86:	48 83 c4 50          	add    rsp,0x50
   1819b9f8a:	5b                   	pop    rbx
   1819b9f8b:	5f                   	pop    rdi
   1819b9f8c:	5e                   	pop    rsi
   1819b9f8d:	41 5c                	pop    r12
   1819b9f8f:	41 5e                	pop    r14
   1819b9f91:	41 5f                	pop    r15
   1819b9f93:	5d                   	pop    rbp
   1819b9f94:	c3                   	ret
   1819b9f95:	e8 f2 41 d2 05       	call   0x1876de18c
   1819b9f9a:	e8 91 17 65 fe       	call   0x18000b730
   1819b9f9f:	90                   	nop
   1819b9fa0:	e8 8b 17 65 fe       	call   0x18000b730
   1819b9fa5:	90                   	nop
   1819b9fa6:	cc                   	int3
