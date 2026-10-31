
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

0000000186cd1bd0 <.text+0x6cd0bd0>:
   186cd1bd0:	55                   	push   rbp
   186cd1bd1:	41 57                	push   r15
   186cd1bd3:	41 56                	push   r14
   186cd1bd5:	41 55                	push   r13
   186cd1bd7:	41 54                	push   r12
   186cd1bd9:	56                   	push   rsi
   186cd1bda:	57                   	push   rdi
   186cd1bdb:	53                   	push   rbx
   186cd1bdc:	48 83 ec 68          	sub    rsp,0x68
   186cd1be0:	48 8d 6c 24 60       	lea    rbp,[rsp+0x60]
   186cd1be5:	48 c7 45 00 fe ff ff 	mov    QWORD PTR [rbp+0x0],0xfffffffffffffffe
   186cd1bec:	ff 
   186cd1bed:	44 89 cf             	mov    edi,r9d
   186cd1bf0:	4c 89 c3             	mov    rbx,r8
   186cd1bf3:	48 89 d6             	mov    rsi,rdx
   186cd1bf6:	49 89 cc             	mov    r12,rcx
   186cd1bf9:	4c 8d 75 c8          	lea    r14,[rbp-0x38]
   186cd1bfd:	4c 89 f1             	mov    rcx,r14
   186cd1c00:	e8 0b 36 8c f9       	call   0x180595210
   186cd1c05:	90                   	nop
   186cd1c06:	4c 89 e1             	mov    rcx,r12
   186cd1c09:	4c 89 f2             	mov    rdx,r14
   186cd1c0c:	e8 5f 90 aa f9       	call   0x18077ac70
   186cd1c11:	90                   	nop
   186cd1c12:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
   186cd1c16:	48 83 f8 10          	cmp    rax,0x10
   186cd1c1a:	72 35                	jb     0x186cd1c51
   186cd1c1c:	48 8b 4d c8          	mov    rcx,QWORD PTR [rbp-0x38]
   186cd1c20:	48 8d 50 01          	lea    rdx,[rax+0x1]
   186cd1c24:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   186cd1c2b:	72 1f                	jb     0x186cd1c4c
   186cd1c2d:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   186cd1c31:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   186cd1c35:	4c 29 c1             	sub    rcx,r8
   186cd1c38:	48 83 f9 20          	cmp    rcx,0x20
   186cd1c3c:	0f 83 8b 02 00 00    	jae    0x186cd1ecd
   186cd1c42:	48 83 c0 28          	add    rax,0x28
   186cd1c46:	48 89 c2             	mov    rdx,rax
   186cd1c49:	4c 89 c1             	mov    rcx,r8
   186cd1c4c:	e8 cf a0 87 00       	call   0x18754bd20
   186cd1c51:	48 8d 05 c0 db 02 03 	lea    rax,[rip+0x302dbc0]        # 0x189cff818
   186cd1c58:	49 89 04 24          	mov    QWORD PTR [r12],rax
   186cd1c5c:	0f 57 c0             	xorps  xmm0,xmm0
   186cd1c5f:	41 0f 11 84 24 58 07 	movups XMMWORD PTR [r12+0x758],xmm0
   186cd1c66:	00 00 
   186cd1c68:	41 0f 11 84 24 68 07 	movups XMMWORD PTR [r12+0x768],xmm0
   186cd1c6f:	00 00 
   186cd1c71:	4c 8b 73 10          	mov    r14,QWORD PTR [rbx+0x10]
   186cd1c75:	48 83 7b 18 10       	cmp    QWORD PTR [rbx+0x18],0x10
   186cd1c7a:	72 03                	jb     0x186cd1c7f
   186cd1c7c:	48 8b 1b             	mov    rbx,QWORD PTR [rbx]
   186cd1c7f:	4d 85 f6             	test   r14,r14
   186cd1c82:	4c 89 65 f8          	mov    QWORD PTR [rbp-0x8],r12
   186cd1c86:	0f 88 35 02 00 00    	js     0x186cd1ec1
   186cd1c8c:	4d 8d ac 24 58 07 00 	lea    r13,[r12+0x758]
   186cd1c93:	00 
   186cd1c94:	49 83 fe 0f          	cmp    r14,0xf
   186cd1c98:	77 1e                	ja     0x186cd1cb8
   186cd1c9a:	4d 89 b4 24 68 07 00 	mov    QWORD PTR [r12+0x768],r14
   186cd1ca1:	00 
   186cd1ca2:	49 c7 84 24 70 07 00 	mov    QWORD PTR [r12+0x770],0xf
   186cd1ca9:	00 0f 00 00 00 
   186cd1cae:	0f 10 03             	movups xmm0,XMMWORD PTR [rbx]
   186cd1cb1:	41 0f 11 45 00       	movups XMMWORD PTR [r13+0x0],xmm0
   186cd1cb6:	eb 78                	jmp    0x186cd1d30
   186cd1cb8:	4c 89 f0             	mov    rax,r14
   186cd1cbb:	48 83 c8 0f          	or     rax,0xf
   186cd1cbf:	48 83 f8 17          	cmp    rax,0x17
   186cd1cc3:	41 bf 16 00 00 00    	mov    r15d,0x16
   186cd1cc9:	4c 0f 43 f8          	cmovae r15,rax
   186cd1ccd:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   186cd1cd3:	72 24                	jb     0x186cd1cf9
   186cd1cd5:	49 8d 4f 28          	lea    rcx,[r15+0x28]
   186cd1cd9:	e8 fe 9f 87 00       	call   0x18754bcdc
   186cd1cde:	90                   	nop
   186cd1cdf:	48 85 c0             	test   rax,rax
   186cd1ce2:	0f 84 e5 01 00 00    	je     0x186cd1ecd
   186cd1ce8:	48 89 c1             	mov    rcx,rax
   186cd1ceb:	48 83 c0 27          	add    rax,0x27
   186cd1cef:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
   186cd1cf3:	48 89 48 f8          	mov    QWORD PTR [rax-0x8],rcx
   186cd1cf7:	eb 0a                	jmp    0x186cd1d03
   186cd1cf9:	49 8d 4f 01          	lea    rcx,[r15+0x1]
   186cd1cfd:	e8 da 9f 87 00       	call   0x18754bcdc
   186cd1d02:	90                   	nop
   186cd1d03:	4c 8b 65 f8          	mov    r12,QWORD PTR [rbp-0x8]
   186cd1d07:	49 89 84 24 58 07 00 	mov    QWORD PTR [r12+0x758],rax
   186cd1d0e:	00 
   186cd1d0f:	4d 89 b4 24 68 07 00 	mov    QWORD PTR [r12+0x768],r14
   186cd1d16:	00 
   186cd1d17:	4d 89 bc 24 70 07 00 	mov    QWORD PTR [r12+0x770],r15
   186cd1d1e:	00 
   186cd1d1f:	49 ff c6             	inc    r14
   186cd1d22:	48 89 c1             	mov    rcx,rax
   186cd1d25:	48 89 da             	mov    rdx,rbx
   186cd1d28:	4d 89 f0             	mov    r8,r14
   186cd1d2b:	e8 10 31 a4 00       	call   0x187714e40
   186cd1d30:	48 8b 5d 70          	mov    rbx,QWORD PTR [rbp+0x70]
   186cd1d34:	41 89 bc 24 78 07 00 	mov    DWORD PTR [r12+0x778],edi
   186cd1d3b:	00 
   186cd1d3c:	0f 10 03             	movups xmm0,XMMWORD PTR [rbx]
   186cd1d3f:	41 0f 11 84 24 80 07 	movups XMMWORD PTR [r12+0x780],xmm0
   186cd1d46:	00 00 
   186cd1d48:	0f b6 43 10          	movzx  eax,BYTE PTR [rbx+0x10]
   186cd1d4c:	41 88 84 24 90 07 00 	mov    BYTE PTR [r12+0x790],al
   186cd1d53:	00 
   186cd1d54:	0f 57 c0             	xorps  xmm0,xmm0
   186cd1d57:	41 0f 11 84 24 98 07 	movups XMMWORD PTR [r12+0x798],xmm0
   186cd1d5e:	00 00 
   186cd1d60:	41 0f 11 84 24 a8 07 	movups XMMWORD PTR [r12+0x7a8],xmm0
   186cd1d67:	00 00 
   186cd1d69:	48 8b 7b 28          	mov    rdi,QWORD PTR [rbx+0x28]
   186cd1d6d:	48 83 7b 30 10       	cmp    QWORD PTR [rbx+0x30],0x10
   186cd1d72:	72 06                	jb     0x186cd1d7a
   186cd1d74:	48 8b 5b 18          	mov    rbx,QWORD PTR [rbx+0x18]
   186cd1d78:	eb 04                	jmp    0x186cd1d7e
   186cd1d7a:	48 83 c3 18          	add    rbx,0x18
   186cd1d7e:	48 85 ff             	test   rdi,rdi
   186cd1d81:	4c 89 6d e8          	mov    QWORD PTR [rbp-0x18],r13
   186cd1d85:	0f 88 3c 01 00 00    	js     0x186cd1ec7
   186cd1d8b:	48 83 ff 0f          	cmp    rdi,0xf
   186cd1d8f:	77 38                	ja     0x186cd1dc9
   186cd1d91:	49 8d 84 24 98 07 00 	lea    rax,[r12+0x798]
   186cd1d98:	00 
   186cd1d99:	49 89 bc 24 a8 07 00 	mov    QWORD PTR [r12+0x7a8],rdi
   186cd1da0:	00 
   186cd1da1:	49 c7 84 24 b0 07 00 	mov    QWORD PTR [r12+0x7b0],0xf
   186cd1da8:	00 0f 00 00 00 
   186cd1dad:	0f 10 03             	movups xmm0,XMMWORD PTR [rbx]
   186cd1db0:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   186cd1db3:	49 8d bc 24 b0 00 00 	lea    rdi,[r12+0xb0]
   186cd1dba:	00 
   186cd1dbb:	48 39 f7             	cmp    rdi,rsi
   186cd1dbe:	0f 85 8a 00 00 00    	jne    0x186cd1e4e
   186cd1dc4:	e9 e4 00 00 00       	jmp    0x186cd1ead
   186cd1dc9:	48 89 f8             	mov    rax,rdi
   186cd1dcc:	48 83 c8 0f          	or     rax,0xf
   186cd1dd0:	48 83 f8 17          	cmp    rax,0x17
   186cd1dd4:	41 be 16 00 00 00    	mov    r14d,0x16
   186cd1dda:	4c 0f 43 f0          	cmovae r14,rax
   186cd1dde:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   186cd1de4:	72 24                	jb     0x186cd1e0a
   186cd1de6:	49 8d 4e 28          	lea    rcx,[r14+0x28]
   186cd1dea:	e8 ed 9e 87 00       	call   0x18754bcdc
   186cd1def:	90                   	nop
   186cd1df0:	48 85 c0             	test   rax,rax
   186cd1df3:	0f 84 d4 00 00 00    	je     0x186cd1ecd
   186cd1df9:	48 89 c1             	mov    rcx,rax
   186cd1dfc:	48 83 c0 27          	add    rax,0x27
   186cd1e00:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
   186cd1e04:	48 89 48 f8          	mov    QWORD PTR [rax-0x8],rcx
   186cd1e08:	eb 0a                	jmp    0x186cd1e14
   186cd1e0a:	49 8d 4e 01          	lea    rcx,[r14+0x1]
   186cd1e0e:	e8 c9 9e 87 00       	call   0x18754bcdc
   186cd1e13:	90                   	nop
   186cd1e14:	4c 8b 65 f8          	mov    r12,QWORD PTR [rbp-0x8]
   186cd1e18:	49 89 84 24 98 07 00 	mov    QWORD PTR [r12+0x798],rax
   186cd1e1f:	00 
   186cd1e20:	49 89 bc 24 a8 07 00 	mov    QWORD PTR [r12+0x7a8],rdi
   186cd1e27:	00 
   186cd1e28:	4d 89 b4 24 b0 07 00 	mov    QWORD PTR [r12+0x7b0],r14
   186cd1e2f:	00 
   186cd1e30:	48 ff c7             	inc    rdi
   186cd1e33:	48 89 c1             	mov    rcx,rax
   186cd1e36:	48 89 da             	mov    rdx,rbx
   186cd1e39:	49 89 f8             	mov    r8,rdi
   186cd1e3c:	e8 ff 2f a4 00       	call   0x187714e40
   186cd1e41:	49 8d bc 24 b0 00 00 	lea    rdi,[r12+0xb0]
   186cd1e48:	00 
   186cd1e49:	48 39 f7             	cmp    rdi,rsi
   186cd1e4c:	74 5f                	je     0x186cd1ead
   186cd1e4e:	48 8b 5e 10          	mov    rbx,QWORD PTR [rsi+0x10]
   186cd1e52:	48 83 7e 18 10       	cmp    QWORD PTR [rsi+0x18],0x10
   186cd1e57:	72 03                	jb     0x186cd1e5c
   186cd1e59:	48 8b 36             	mov    rsi,QWORD PTR [rsi]
   186cd1e5c:	4c 8b 65 f8          	mov    r12,QWORD PTR [rbp-0x8]
   186cd1e60:	49 8b 84 24 c8 00 00 	mov    rax,QWORD PTR [r12+0xc8]
   186cd1e67:	00 
   186cd1e68:	48 39 c3             	cmp    rbx,rax
   186cd1e6b:	76 1d                	jbe    0x186cd1e8a
   186cd1e6d:	49 8d 84 24 80 07 00 	lea    rax,[r12+0x780]
   186cd1e74:	00 
   186cd1e75:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
   186cd1e79:	48 89 f9             	mov    rcx,rdi
   186cd1e7c:	48 89 da             	mov    rdx,rbx
   186cd1e7f:	49 89 f1             	mov    r9,rsi
   186cd1e82:	e8 c9 c2 36 f9       	call   0x18003e150
   186cd1e87:	90                   	nop
   186cd1e88:	eb 23                	jmp    0x186cd1ead
   186cd1e8a:	48 83 f8 10          	cmp    rax,0x10
   186cd1e8e:	72 03                	jb     0x186cd1e93
   186cd1e90:	48 8b 3f             	mov    rdi,QWORD PTR [rdi]
   186cd1e93:	49 89 9c 24 c0 00 00 	mov    QWORD PTR [r12+0xc0],rbx
   186cd1e9a:	00 
   186cd1e9b:	48 89 f9             	mov    rcx,rdi
   186cd1e9e:	48 89 f2             	mov    rdx,rsi
   186cd1ea1:	49 89 d8             	mov    r8,rbx
   186cd1ea4:	e8 97 2f a4 00       	call   0x187714e40
   186cd1ea9:	c6 04 1f 00          	mov    BYTE PTR [rdi+rbx*1],0x0
   186cd1ead:	4c 89 e0             	mov    rax,r12
   186cd1eb0:	48 83 c4 68          	add    rsp,0x68
   186cd1eb4:	5b                   	pop    rbx
   186cd1eb5:	5f                   	pop    rdi
   186cd1eb6:	5e                   	pop    rsi
   186cd1eb7:	41 5c                	pop    r12
   186cd1eb9:	41 5d                	pop    r13
   186cd1ebb:	41 5e                	pop    r14
   186cd1ebd:	41 5f                	pop    r15
   186cd1ebf:	5d                   	pop    rbp
   186cd1ec0:	c3                   	ret
   186cd1ec1:	e8 ca 6c 33 f9       	call   0x180008b90
   186cd1ec6:	90                   	nop
   186cd1ec7:	e8 c4 6c 33 f9       	call   0x180008b90
   186cd1ecc:	90                   	nop
   186cd1ecd:	e8 ba c2 a0 00       	call   0x1876de18c
   186cd1ed2:	cc                   	int3
