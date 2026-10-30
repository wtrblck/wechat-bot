
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001817a3c20 <.text+0x17a2c20>:
   1817a3c20:	55                   	push   rbp
   1817a3c21:	41 57                	push   r15
   1817a3c23:	41 56                	push   r14
   1817a3c25:	56                   	push   rsi
   1817a3c26:	57                   	push   rdi
   1817a3c27:	53                   	push   rbx
   1817a3c28:	48 83 ec 78          	sub    rsp,0x78
   1817a3c2c:	48 8d 6c 24 70       	lea    rbp,[rsp+0x70]
   1817a3c31:	48 c7 45 00 fe ff ff 	mov    QWORD PTR [rbp+0x0],0xfffffffffffffffe
   1817a3c38:	ff
   1817a3c39:	44 89 cb             	mov    ebx,r9d
   1817a3c3c:	48 89 d6             	mov    rsi,rdx
   1817a3c3f:	48 89 cf             	mov    rdi,rcx
   1817a3c42:	4c 89 45 f0          	mov    QWORD PTR [rbp-0x10],r8
   1817a3c46:	49 8b 08             	mov    rcx,QWORD PTR [r8]
   1817a3c49:	48 85 c9             	test   rcx,rcx
   1817a3c4c:	74 51                	je     0x1817a3c9f
   1817a3c4e:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   1817a3c51:	ff 50 18             	call   QWORD PTR [rax+0x18]
   1817a3c54:	90                   	nop
   1817a3c55:	84 db                	test   bl,bl
   1817a3c57:	74 46                	je     0x1817a3c9f
   1817a3c59:	41 89 c6             	mov    r14d,eax
   1817a3c5c:	41 8d 46 ff          	lea    eax,[r14-0x1]
   1817a3c60:	83 f8 01             	cmp    eax,0x1
   1817a3c63:	77 3a                	ja     0x1817a3c9f
   1817a3c65:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
   1817a3c69:	48 8b 08             	mov    rcx,QWORD PTR [rax]
   1817a3c6c:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   1817a3c6f:	ff 50 10             	call   QWORD PTR [rax+0x10]
   1817a3c72:	90                   	nop
   1817a3c73:	41 89 c7             	mov    r15d,eax
   1817a3c76:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
   1817a3c7a:	48 8b 08             	mov    rcx,QWORD PTR [rax]
   1817a3c7d:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   1817a3c80:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1817a3c83:	90                   	nop
   1817a3c84:	ba b0 00 00 00       	mov    edx,0xb0
   1817a3c89:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
   1817a3c8d:	48 03 11             	add    rdx,QWORD PTR [rcx]
   1817a3c90:	44 89 f1             	mov    ecx,r14d
   1817a3c93:	41 89 c0             	mov    r8d,eax
   1817a3c96:	45 89 f9             	mov    r9d,r15d
   1817a3c99:	e8 12 83 62 ff       	call   0x180dcbfb0
   1817a3c9e:	90                   	nop
   1817a3c9f:	0f 28 05 0a 2f 77 07 	movaps xmm0,XMMWORD PTR [rip+0x7772f0a]        # 0x188f16bb0
   1817a3ca6:	0f 29 45 d0          	movaps XMMWORD PTR [rbp-0x30],xmm0
   1817a3caa:	b9 00 01 00 00       	mov    ecx,0x100
   1817a3caf:	e8 28 80 da 05       	call   0x18754bcdc
   1817a3cb4:	90                   	nop
   1817a3cb5:	48 b9 01 00 00 00 01 	movabs rcx,0x100000001
   1817a3cbc:	00 00 00
   1817a3cbf:	48 89 48 08          	mov    QWORD PTR [rax+0x8],rcx
   1817a3cc3:	48 8d 0d 0e bf b0 07 	lea    rcx,[rip+0x7b0bf0e]        # 0x1892afbd8
   1817a3cca:	48 89 08             	mov    QWORD PTR [rax],rcx
   1817a3ccd:	0f 57 c0             	xorps  xmm0,xmm0
   1817a3cd0:	0f 29 45 e0          	movaps XMMWORD PTR [rbp-0x20],xmm0
   1817a3cd4:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
   1817a3cd8:	48 8b 51 08          	mov    rdx,QWORD PTR [rcx+0x8]
   1817a3cdc:	48 85 d2             	test   rdx,rdx
   1817a3cdf:	74 0a                	je     0x1817a3ceb
   1817a3ce1:	f0 ff 42 08          	lock inc DWORD PTR [rdx+0x8]
   1817a3ce5:	48 8b 51 08          	mov    rdx,QWORD PTR [rcx+0x8]
   1817a3ce9:	eb 02                	jmp    0x1817a3ced
   1817a3ceb:	31 d2                	xor    edx,edx
   1817a3ced:	4c 8d 70 10          	lea    r14,[rax+0x10]
   1817a3cf1:	48 8b 09             	mov    rcx,QWORD PTR [rcx]
   1817a3cf4:	48 89 4d e0          	mov    QWORD PTR [rbp-0x20],rcx
   1817a3cf8:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
   1817a3cfc:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
   1817a3d00:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
   1817a3d04:	4c 89 f1             	mov    rcx,r14
   1817a3d07:	41 89 d8             	mov    r8d,ebx
   1817a3d0a:	e8 b1 55 23 02       	call   0x1839d92c0
   1817a3d0f:	90                   	nop
   1817a3d10:	4c 89 75 d0          	mov    QWORD PTR [rbp-0x30],r14
   1817a3d14:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
   1817a3d18:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
   1817a3d1c:	4c 8d 48 48          	lea    r9,[rax+0x48]
   1817a3d20:	0f 57 c0             	xorps  xmm0,xmm0
   1817a3d23:	0f 29 45 b0          	movaps XMMWORD PTR [rbp-0x50],xmm0
   1817a3d27:	48 85 c0             	test   rax,rax
   1817a3d2a:	74 0e                	je     0x1817a3d3a
   1817a3d2c:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1817a3d30:	4c 8b 75 d0          	mov    r14,QWORD PTR [rbp-0x30]
   1817a3d34:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
   1817a3d38:	eb 02                	jmp    0x1817a3d3c
   1817a3d3a:	31 c0                	xor    eax,eax
   1817a3d3c:	4c 89 75 b0          	mov    QWORD PTR [rbp-0x50],r14
   1817a3d40:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
   1817a3d44:	ba 90 00 00 00       	mov    edx,0x90
   1817a3d49:	48 03 97 f8 0b 00 00 	add    rdx,QWORD PTR [rdi+0xbf8]
   1817a3d50:	4c 8d 45 b0          	lea    r8,[rbp-0x50]
   1817a3d54:	e8 17 3e 00 00       	call   0x1817a7b70
   1817a3d59:	90                   	nop
   1817a3d5a:	49 8d 56 38          	lea    rdx,[r14+0x38]
   1817a3d5e:	48 89 f9             	mov    rcx,rdi
   1817a3d61:	e8 4a 4a 00 00       	call   0x1817a87b0
   1817a3d66:	90                   	nop
   1817a3d67:	49 8b 86 80 00 00 00 	mov    rax,QWORD PTR [r14+0x80]
   1817a3d6e:	48 85 c0             	test   rax,rax
   1817a3d71:	74 0d                	je     0x1817a3d80
   1817a3d73:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1817a3d77:	49 8b 86 80 00 00 00 	mov    rax,QWORD PTR [r14+0x80]
   1817a3d7e:	eb 02                	jmp    0x1817a3d82
   1817a3d80:	31 c0                	xor    eax,eax
   1817a3d82:	49 8b 4e 78          	mov    rcx,QWORD PTR [r14+0x78]
   1817a3d86:	48 89 4d e0          	mov    QWORD PTR [rbp-0x20],rcx
   1817a3d8a:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
   1817a3d8e:	48 8d 4d ff          	lea    rcx,[rbp-0x1]
   1817a3d92:	4c 8d 45 e0          	lea    r8,[rbp-0x20]
   1817a3d96:	48 89 f2             	mov    rdx,rsi
   1817a3d99:	e8 12 d9 00 00       	call   0x1817b16b0
   1817a3d9e:	90                   	nop
   1817a3d9f:	48 8b 7d e8          	mov    rdi,QWORD PTR [rbp-0x18]
   1817a3da3:	48 85 ff             	test   rdi,rdi
   1817a3da6:	74 1d                	je     0x1817a3dc5
   1817a3da8:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1817a3dac:	75 17                	jne    0x1817a3dc5
   1817a3dae:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1817a3db1:	48 89 f9             	mov    rcx,rdi
   1817a3db4:	ff 10                	call   QWORD PTR [rax]
   1817a3db6:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1817a3dba:	75 09                	jne    0x1817a3dc5
   1817a3dbc:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1817a3dbf:	48 89 f9             	mov    rcx,rdi
   1817a3dc2:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1817a3dc5:	48 8b 7d d8          	mov    rdi,QWORD PTR [rbp-0x28]
   1817a3dc9:	48 85 ff             	test   rdi,rdi
   1817a3dcc:	74 1d                	je     0x1817a3deb
   1817a3dce:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1817a3dd2:	75 17                	jne    0x1817a3deb
   1817a3dd4:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1817a3dd7:	48 89 f9             	mov    rcx,rdi
   1817a3dda:	ff 10                	call   QWORD PTR [rax]
   1817a3ddc:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1817a3de0:	75 09                	jne    0x1817a3deb
   1817a3de2:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1817a3de5:	48 89 f9             	mov    rcx,rdi
   1817a3de8:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1817a3deb:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
   1817a3def:	48 8b 78 08          	mov    rdi,QWORD PTR [rax+0x8]
   1817a3df3:	48 85 ff             	test   rdi,rdi
   1817a3df6:	74 1d                	je     0x1817a3e15
   1817a3df8:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1817a3dfc:	75 17                	jne    0x1817a3e15
   1817a3dfe:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1817a3e01:	48 89 f9             	mov    rcx,rdi
   1817a3e04:	ff 10                	call   QWORD PTR [rax]
   1817a3e06:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1817a3e0a:	75 09                	jne    0x1817a3e15
   1817a3e0c:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1817a3e0f:	48 89 f9             	mov    rcx,rdi
   1817a3e12:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1817a3e15:	48 89 f0             	mov    rax,rsi
   1817a3e18:	48 83 c4 78          	add    rsp,0x78
   1817a3e1c:	5b                   	pop    rbx
   1817a3e1d:	5f                   	pop    rdi
   1817a3e1e:	5e                   	pop    rsi
   1817a3e1f:	41 5e                	pop    r14
   1817a3e21:	41 5f                	pop    r15
   1817a3e23:	5d                   	pop    rbp
   1817a3e24:	c3                   	ret
