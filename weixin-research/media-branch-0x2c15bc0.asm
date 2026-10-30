
E:/Tencent/Weixin/4.1.15.56/Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

0000000182c15bc0 <.text+0x2c14bc0>:
   182c15bc0:	55                   	push   rbp
   182c15bc1:	41 57                	push   r15
   182c15bc3:	41 56                	push   r14
   182c15bc5:	41 55                	push   r13
   182c15bc7:	41 54                	push   r12
   182c15bc9:	56                   	push   rsi
   182c15bca:	57                   	push   rdi
   182c15bcb:	53                   	push   rbx
   182c15bcc:	48 81 ec e8 05 00 00 	sub    rsp,0x5e8
   182c15bd3:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   182c15bda:	00
   182c15bdb:	0f 29 b5 50 05 00 00 	movaps XMMWORD PTR [rbp+0x550],xmm6
   182c15be2:	48 c7 85 48 05 00 00 	mov    QWORD PTR [rbp+0x548],0xfffffffffffffffe
   182c15be9:	fe ff ff ff
   182c15bed:	4c 89 8d b8 02 00 00 	mov    QWORD PTR [rbp+0x2b8],r9
   182c15bf4:	4c 89 85 28 04 00 00 	mov    QWORD PTR [rbp+0x428],r8
   182c15bfb:	48 89 95 40 05 00 00 	mov    QWORD PTR [rbp+0x540],rdx
   182c15c02:	48 8b bd d0 05 00 00 	mov    rdi,QWORD PTR [rbp+0x5d0]
   182c15c09:	48 b8 aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaaa
   182c15c10:	aa aa aa
   182c15c13:	48 89 02             	mov    QWORD PTR [rdx],rax
   182c15c16:	c6 02 00             	mov    BYTE PTR [rdx],0x0
   182c15c19:	0f 57 c0             	xorps  xmm0,xmm0
   182c15c1c:	0f 11 42 08          	movups XMMWORD PTR [rdx+0x8],xmm0
   182c15c20:	0f 11 42 18          	movups XMMWORD PTR [rdx+0x18],xmm0
   182c15c24:	48 c7 42 28 00 00 00 	mov    QWORD PTR [rdx+0x28],0x0
   182c15c2b:	00
   182c15c2c:	48 c7 42 30 0f 00 00 	mov    QWORD PTR [rdx+0x30],0xf
   182c15c33:	00
   182c15c34:	0f 28 35 75 0f 30 06 	movaps xmm6,XMMWORD PTR [rip+0x6300f75]        # 0x188f16bb0
   182c15c3b:	0f 29 b5 40 04 00 00 	movaps XMMWORD PTR [rbp+0x440],xmm6
   182c15c42:	0f 29 b5 30 04 00 00 	movaps XMMWORD PTR [rbp+0x430],xmm6
   182c15c49:	4c 8b 77 10          	mov    r14,QWORD PTR [rdi+0x10]
   182c15c4d:	48 b8 f4 ff ff ff ff 	movabs rax,0x7ffffffffffffff4
   182c15c54:	ff ff 7f
   182c15c57:	49 39 c6             	cmp    r14,rax
   182c15c5a:	0f 8d 0c 18 00 00    	jge    0x182c1746c
   182c15c60:	4c 8b 3f             	mov    r15,QWORD PTR [rdi]
   182c15c63:	48 8b 77 18          	mov    rsi,QWORD PTR [rdi+0x18]
   182c15c67:	0f 29 85 30 04 00 00 	movaps XMMWORD PTR [rbp+0x430],xmm0
   182c15c6e:	4d 8d 6e 0c          	lea    r13,[r14+0xc]
   182c15c72:	49 83 fd 10          	cmp    r13,0x10
   182c15c76:	72 12                	jb     0x182c15c8a
   182c15c78:	49 83 fe f4          	cmp    r14,0xfffffffffffffff4
   182c15c7c:	7d 1a                	jge    0x182c15c98
   182c15c7e:	48 bb ff ff ff ff ff 	movabs rbx,0x7fffffffffffffff
   182c15c85:	ff ff 7f
   182c15c88:	eb 2a                	jmp    0x182c15cb4
   182c15c8a:	4c 8d a5 30 04 00 00 	lea    r12,[rbp+0x430]
   182c15c91:	bb 0f 00 00 00       	mov    ebx,0xf
   182c15c96:	eb 58                	jmp    0x182c15cf0
   182c15c98:	4c 89 e8             	mov    rax,r13
   182c15c9b:	48 83 c8 0f          	or     rax,0xf
   182c15c9f:	48 83 f8 17          	cmp    rax,0x17
   182c15ca3:	bb 16 00 00 00       	mov    ebx,0x16
   182c15ca8:	48 0f 43 d8          	cmovae rbx,rax
   182c15cac:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   182c15cb2:	72 28                	jb     0x182c15cdc
   182c15cb4:	48 8d 4b 28          	lea    rcx,[rbx+0x28]
   182c15cb8:	e8 1f 60 93 04       	call   0x18754bcdc
   182c15cbd:	90                   	nop
   182c15cbe:	49 89 c4             	mov    r12,rax
   182c15cc1:	48 85 c0             	test   rax,rax
   182c15cc4:	0f 84 9c 17 00 00    	je     0x182c17466
   182c15cca:	4c 89 e0             	mov    rax,r12
   182c15ccd:	49 83 c4 27          	add    r12,0x27
   182c15cd1:	49 83 e4 e0          	and    r12,0xffffffffffffffe0
   182c15cd5:	49 89 44 24 f8       	mov    QWORD PTR [r12-0x8],rax
   182c15cda:	eb 0d                	jmp    0x182c15ce9
   182c15cdc:	48 8d 4b 01          	lea    rcx,[rbx+0x1]
   182c15ce0:	e8 f7 5f 93 04       	call   0x18754bcdc
   182c15ce5:	90                   	nop
   182c15ce6:	49 89 c4             	mov    r12,rax
   182c15ce9:	4c 89 a5 30 04 00 00 	mov    QWORD PTR [rbp+0x430],r12
   182c15cf0:	48 83 fe 10          	cmp    rsi,0x10
   182c15cf4:	4c 0f 42 ff          	cmovb  r15,rdi
   182c15cf8:	4c 89 ad 40 04 00 00 	mov    QWORD PTR [rbp+0x440],r13
   182c15cff:	48 89 9d 48 04 00 00 	mov    QWORD PTR [rbp+0x448],rbx
   182c15d06:	48 b8 63 6f 6e 66 69 	movabs rax,0x5f6d7269666e6f63
   182c15d0d:	72 6d 5f
   182c15d10:	49 89 04 24          	mov    QWORD PTR [r12],rax
   182c15d14:	41 c7 44 24 08 69 6d 	mov    DWORD PTR [r12+0x8],0x5f676d69
   182c15d1b:	67 5f
   182c15d1d:	49 8d 4c 24 0c       	lea    rcx,[r12+0xc]
   182c15d22:	4c 89 fa             	mov    rdx,r15
   182c15d25:	4d 89 f0             	mov    r8,r14
   182c15d28:	e8 13 f1 af 04       	call   0x187714e40
   182c15d2d:	43 c6 44 34 0c 00    	mov    BYTE PTR [r12+r14*1+0xc],0x0
   182c15d33:	0f 29 b5 30 03 00 00 	movaps XMMWORD PTR [rbp+0x330],xmm6
   182c15d3a:	0f 29 b5 20 03 00 00 	movaps XMMWORD PTR [rbp+0x320],xmm6
   182c15d41:	0f 57 c0             	xorps  xmm0,xmm0
   182c15d44:	0f 29 45 c0          	movaps XMMWORD PTR [rbp-0x40],xmm0
   182c15d48:	48 c7 45 d0 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
   182c15d4f:	00
   182c15d50:	48 c7 45 d8 0f 00 00 	mov    QWORD PTR [rbp-0x28],0xf
   182c15d57:	00
   182c15d58:	0f 29 85 50 04 00 00 	movaps XMMWORD PTR [rbp+0x450],xmm0
   182c15d5f:	48 c7 85 60 04 00 00 	mov    QWORD PTR [rbp+0x460],0x0
   182c15d66:	00 00 00 00
   182c15d6a:	48 c7 85 68 04 00 00 	mov    QWORD PTR [rbp+0x468],0xf
   182c15d71:	0f 00 00 00
   182c15d75:	4c 8d 7d c0          	lea    r15,[rbp-0x40]
   182c15d79:	4c 89 7c 24 20       	mov    QWORD PTR [rsp+0x20],r15
   182c15d7e:	48 8d 8d 20 03 00 00 	lea    rcx,[rbp+0x320]
   182c15d85:	4c 8d 85 50 04 00 00 	lea    r8,[rbp+0x450]
   182c15d8c:	4c 8d b5 30 04 00 00 	lea    r14,[rbp+0x430]
   182c15d93:	31 d2                	xor    edx,edx
   182c15d95:	4d 89 f1             	mov    r9,r14
   182c15d98:	e8 f3 66 d7 01       	call   0x18498c490
   182c15d9d:	90                   	nop
   182c15d9e:	48 8b 85 68 04 00 00 	mov    rax,QWORD PTR [rbp+0x468]
   182c15da5:	48 83 f8 10          	cmp    rax,0x10
   182c15da9:	48 8b b5 28 04 00 00 	mov    rsi,QWORD PTR [rbp+0x428]
   182c15db0:	72 38                	jb     0x182c15dea
   182c15db2:	48 8b 8d 50 04 00 00 	mov    rcx,QWORD PTR [rbp+0x450]
   182c15db9:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c15dbd:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c15dc4:	72 1f                	jb     0x182c15de5
   182c15dc6:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c15dca:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c15dce:	4c 29 c1             	sub    rcx,r8
   182c15dd1:	48 83 f9 20          	cmp    rcx,0x20
   182c15dd5:	0f 83 8b 16 00 00    	jae    0x182c17466
   182c15ddb:	48 83 c0 28          	add    rax,0x28
   182c15ddf:	48 89 c2             	mov    rdx,rax
   182c15de2:	4c 89 c1             	mov    rcx,r8
   182c15de5:	e8 36 5f 93 04       	call   0x18754bd20
   182c15dea:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
   182c15dee:	48 83 f8 10          	cmp    rax,0x10
   182c15df2:	72 36                	jb     0x182c15e2a
   182c15df4:	48 8b 4d c0          	mov    rcx,QWORD PTR [rbp-0x40]
   182c15df8:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c15dfc:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c15e03:	72 1f                	jb     0x182c15e24
   182c15e05:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c15e09:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c15e0d:	4c 29 c1             	sub    rcx,r8
   182c15e10:	48 83 f9 20          	cmp    rcx,0x20
   182c15e14:	0f 83 4c 16 00 00    	jae    0x182c17466
   182c15e1a:	48 83 c0 28          	add    rax,0x28
   182c15e1e:	48 89 c2             	mov    rdx,rax
   182c15e21:	4c 89 c1             	mov    rcx,r8
   182c15e24:	e8 f7 5e 93 04       	call   0x18754bd20
   182c15e29:	90                   	nop
   182c15e2a:	48 8d 8d 20 03 00 00 	lea    rcx,[rbp+0x320]
   182c15e31:	e8 8a e6 78 fd       	call   0x1803a44c0
   182c15e36:	90                   	nop
   182c15e37:	41 89 c4             	mov    r12d,eax
   182c15e3a:	b9 02 00 00 00       	mov    ecx,0x2
   182c15e3f:	e8 9c 6f 45 fd       	call   0x18006cde0
   182c15e44:	45 84 e4             	test   r12b,r12b
   182c15e47:	0f 84 3b 01 00 00    	je     0x182c15f88
   182c15e4d:	85 c0                	test   eax,eax
   182c15e4f:	0f 84 52 08 00 00    	je     0x182c166a7
   182c15e55:	48 8d bd e0 04 00 00 	lea    rdi,[rbp+0x4e0]
   182c15e5c:	48 89 f9             	mov    rcx,rdi
   182c15e5f:	e8 ac 70 45 fd       	call   0x18006cf10
   182c15e64:	90                   	nop
   182c15e65:	48 83 bd f8 04 00 00 	cmp    QWORD PTR [rbp+0x4f8],0x10
   182c15e6c:	10
   182c15e6d:	72 07                	jb     0x182c15e76
   182c15e6f:	48 8b bd e0 04 00 00 	mov    rdi,QWORD PTR [rbp+0x4e0]
   182c15e76:	48 8d 05 13 7d 95 06 	lea    rax,[rip+0x6957d13]        # 0x18956db90
   182c15e7d:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182c15e82:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182c15e89:	00 00
   182c15e8b:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182c15e90:	c7 44 24 28 5c 0a 00 	mov    DWORD PTR [rsp+0x28],0xa5c
   182c15e97:	00
   182c15e98:	4c 8d 0d c9 36 95 06 	lea    r9,[rip+0x69536c9]        # 0x189569568
   182c15e9f:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c15ea3:	ba 02 00 00 00       	mov    edx,0x2
   182c15ea8:	49 89 f8             	mov    r8,rdi
   182c15eab:	e8 c0 73 45 fd       	call   0x18006d270
   182c15eb0:	90                   	nop
   182c15eb1:	48 83 7e 18 10       	cmp    QWORD PTR [rsi+0x18],0x10
   182c15eb6:	48 89 f0             	mov    rax,rsi
   182c15eb9:	72 03                	jb     0x182c15ebe
   182c15ebb:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182c15ebe:	48 89 85 a0 03 00 00 	mov    QWORD PTR [rbp+0x3a0],rax
   182c15ec5:	c6 85 a8 03 00 00 00 	mov    BYTE PTR [rbp+0x3a8],0x0
   182c15ecc:	0f 57 c0             	xorps  xmm0,xmm0
   182c15ecf:	0f 11 85 b8 04 00 00 	movups XMMWORD PTR [rbp+0x4b8],xmm0
   182c15ed6:	0f 11 85 a8 04 00 00 	movups XMMWORD PTR [rbp+0x4a8],xmm0
   182c15edd:	0f 11 85 98 04 00 00 	movups XMMWORD PTR [rbp+0x498],xmm0
   182c15ee4:	0f 11 85 88 04 00 00 	movups XMMWORD PTR [rbp+0x488],xmm0
   182c15eeb:	0f 11 85 78 04 00 00 	movups XMMWORD PTR [rbp+0x478],xmm0
   182c15ef2:	0f 11 85 68 04 00 00 	movups XMMWORD PTR [rbp+0x468],xmm0
   182c15ef9:	0f 11 85 58 04 00 00 	movups XMMWORD PTR [rbp+0x458],xmm0
   182c15f00:	48 c7 85 c8 04 00 00 	mov    QWORD PTR [rbp+0x4c8],0x0
   182c15f07:	00 00 00 00
   182c15f0b:	48 8d 85 a0 03 00 00 	lea    rax,[rbp+0x3a0]
   182c15f12:	48 89 85 50 04 00 00 	mov    QWORD PTR [rbp+0x450],rax
   182c15f19:	48 8d 15 20 81 95 06 	lea    rdx,[rip+0x6958120]        # 0x18956e040
   182c15f20:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c15f24:	4c 8d 85 50 04 00 00 	lea    r8,[rbp+0x450]
   182c15f2b:	e8 e0 78 45 fd       	call   0x18006d810
   182c15f30:	90                   	nop
   182c15f31:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c15f35:	e8 36 74 45 fd       	call   0x18006d370
   182c15f3a:	48 8b 85 f8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4f8]
   182c15f41:	48 83 f8 10          	cmp    rax,0x10
   182c15f45:	0f 82 5c 07 00 00    	jb     0x182c166a7
   182c15f4b:	48 8b 8d e0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4e0]
   182c15f52:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c15f56:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c15f5d:	72 1f                	jb     0x182c15f7e
   182c15f5f:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c15f63:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c15f67:	4c 29 c1             	sub    rcx,r8
   182c15f6a:	48 83 f9 20          	cmp    rcx,0x20
   182c15f6e:	0f 83 f2 14 00 00    	jae    0x182c17466
   182c15f74:	48 83 c0 28          	add    rax,0x28
   182c15f78:	48 89 c2             	mov    rdx,rax
   182c15f7b:	4c 89 c1             	mov    rcx,r8
   182c15f7e:	e8 9d 5d 93 04       	call   0x18754bd20
   182c15f83:	e9 1f 07 00 00       	jmp    0x182c166a7
   182c15f88:	85 c0                	test   eax,eax
   182c15f8a:	0f 84 2a 01 00 00    	je     0x182c160ba
   182c15f90:	4c 8d a5 e0 04 00 00 	lea    r12,[rbp+0x4e0]
   182c15f97:	4c 89 e1             	mov    rcx,r12
   182c15f9a:	e8 71 6f 45 fd       	call   0x18006cf10
   182c15f9f:	90                   	nop
   182c15fa0:	48 83 bd f8 04 00 00 	cmp    QWORD PTR [rbp+0x4f8],0x10
   182c15fa7:	10
   182c15fa8:	72 07                	jb     0x182c15fb1
   182c15faa:	4c 8b a5 e0 04 00 00 	mov    r12,QWORD PTR [rbp+0x4e0]
   182c15fb1:	48 8d 05 d8 7b 95 06 	lea    rax,[rip+0x6957bd8]        # 0x18956db90
   182c15fb8:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182c15fbd:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182c15fc4:	00 00
   182c15fc6:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182c15fcb:	c7 44 24 28 45 0a 00 	mov    DWORD PTR [rsp+0x28],0xa45
   182c15fd2:	00
   182c15fd3:	4c 8d 0d 8e 35 95 06 	lea    r9,[rip+0x695358e]        # 0x189569568
   182c15fda:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c15fde:	ba 02 00 00 00       	mov    edx,0x2
   182c15fe3:	4d 89 e0             	mov    r8,r12
   182c15fe6:	e8 85 72 45 fd       	call   0x18006d270
   182c15feb:	90                   	nop
   182c15fec:	48 83 7e 18 10       	cmp    QWORD PTR [rsi+0x18],0x10
   182c15ff1:	48 89 f0             	mov    rax,rsi
   182c15ff4:	72 03                	jb     0x182c15ff9
   182c15ff6:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182c15ff9:	48 89 85 a0 03 00 00 	mov    QWORD PTR [rbp+0x3a0],rax
   182c16000:	c6 85 a8 03 00 00 00 	mov    BYTE PTR [rbp+0x3a8],0x0
   182c16007:	0f 57 c0             	xorps  xmm0,xmm0
   182c1600a:	0f 11 85 b8 04 00 00 	movups XMMWORD PTR [rbp+0x4b8],xmm0
   182c16011:	0f 11 85 a8 04 00 00 	movups XMMWORD PTR [rbp+0x4a8],xmm0
   182c16018:	0f 11 85 98 04 00 00 	movups XMMWORD PTR [rbp+0x498],xmm0
   182c1601f:	0f 11 85 88 04 00 00 	movups XMMWORD PTR [rbp+0x488],xmm0
   182c16026:	0f 11 85 78 04 00 00 	movups XMMWORD PTR [rbp+0x478],xmm0
   182c1602d:	0f 11 85 68 04 00 00 	movups XMMWORD PTR [rbp+0x468],xmm0
   182c16034:	0f 11 85 58 04 00 00 	movups XMMWORD PTR [rbp+0x458],xmm0
   182c1603b:	48 c7 85 c8 04 00 00 	mov    QWORD PTR [rbp+0x4c8],0x0
   182c16042:	00 00 00 00
   182c16046:	48 8d 85 a0 03 00 00 	lea    rax,[rbp+0x3a0]
   182c1604d:	48 89 85 50 04 00 00 	mov    QWORD PTR [rbp+0x450],rax
   182c16054:	48 8d 15 15 7d 95 06 	lea    rdx,[rip+0x6957d15]        # 0x18956dd70
   182c1605b:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c1605f:	4c 8d 85 50 04 00 00 	lea    r8,[rbp+0x450]
   182c16066:	e8 a5 77 45 fd       	call   0x18006d810
   182c1606b:	90                   	nop
   182c1606c:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c16070:	e8 fb 72 45 fd       	call   0x18006d370
   182c16075:	48 8b 85 f8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4f8]
   182c1607c:	48 83 f8 10          	cmp    rax,0x10
   182c16080:	72 38                	jb     0x182c160ba
   182c16082:	48 8b 8d e0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4e0]
   182c16089:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c1608d:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c16094:	72 1f                	jb     0x182c160b5
   182c16096:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c1609a:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c1609e:	4c 29 c1             	sub    rcx,r8
   182c160a1:	48 83 f9 20          	cmp    rcx,0x20
   182c160a5:	0f 83 bb 13 00 00    	jae    0x182c17466
   182c160ab:	48 83 c0 28          	add    rax,0x28
   182c160af:	48 89 c2             	mov    rdx,rax
   182c160b2:	4c 89 c1             	mov    rcx,r8
   182c160b5:	e8 66 5c 93 04       	call   0x18754bd20
   182c160ba:	4c 8d 65 28          	lea    r12,[rbp+0x28]
   182c160be:	0f 11 75 48          	movups XMMWORD PTR [rbp+0x48],xmm6
   182c160c2:	0f 11 75 38          	movups XMMWORD PTR [rbp+0x38],xmm6
   182c160c6:	0f 11 75 28          	movups XMMWORD PTR [rbp+0x28],xmm6
   182c160ca:	0f 57 c0             	xorps  xmm0,xmm0
   182c160cd:	0f 29 45 c0          	movaps XMMWORD PTR [rbp-0x40],xmm0
   182c160d1:	48 c7 45 d0 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
   182c160d8:	00
   182c160d9:	48 c7 45 d8 0f 00 00 	mov    QWORD PTR [rbp-0x28],0xf
   182c160e0:	00
   182c160e1:	0f 29 45 e0          	movaps XMMWORD PTR [rbp-0x20],xmm0
   182c160e5:	48 c7 45 f0 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
   182c160ec:	00
   182c160ed:	48 c7 45 f8 0f 00 00 	mov    QWORD PTR [rbp-0x8],0xf
   182c160f4:	00
   182c160f5:	0f 29 45 00          	movaps XMMWORD PTR [rbp+0x0],xmm0
   182c160f9:	48 c7 45 10 00 00 00 	mov    QWORD PTR [rbp+0x10],0x0
   182c16100:	00
   182c16101:	48 c7 45 18 0f 00 00 	mov    QWORD PTR [rbp+0x18],0xf
   182c16108:	00
   182c16109:	48 c7 45 20 00 00 00 	mov    QWORD PTR [rbp+0x20],0x0
   182c16110:	00
   182c16111:	4c 89 e1             	mov    rcx,r12
   182c16114:	e8 47 53 48 fd       	call   0x18009b460
   182c16119:	90                   	nop
   182c1611a:	48 c7 45 48 00 00 00 	mov    QWORD PTR [rbp+0x48],0x0
   182c16121:	00
   182c16122:	66 c7 45 50 00 00    	mov    WORD PTR [rbp+0x50],0x0
   182c16128:	4c 8b ad 40 04 00 00 	mov    r13,QWORD PTR [rbp+0x440]
   182c1612f:	48 83 bd 48 04 00 00 	cmp    QWORD PTR [rbp+0x448],0x10
   182c16136:	10
   182c16137:	72 07                	jb     0x182c16140
   182c16139:	4c 8b b5 30 04 00 00 	mov    r14,QWORD PTR [rbp+0x430]
   182c16140:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
   182c16144:	49 39 c5             	cmp    r13,rax
   182c16147:	48 8d 5d e0          	lea    rbx,[rbp-0x20]
   182c1614b:	76 6d                	jbe    0x182c161ba
   182c1614d:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c16151:	4c 89 ea             	mov    rdx,r13
   182c16154:	4d 89 f1             	mov    r9,r14
   182c16157:	e8 f4 7f 42 fd       	call   0x18003e150
   182c1615c:	90                   	nop
   182c1615d:	4c 8d 7d 00          	lea    r15,[rbp+0x0]
   182c16161:	4c 8b 8d b8 02 00 00 	mov    r9,QWORD PTR [rbp+0x2b8]
   182c16168:	4d 8b 71 10          	mov    r14,QWORD PTR [r9+0x10]
   182c1616c:	49 83 79 18 10       	cmp    QWORD PTR [r9+0x18],0x10
   182c16171:	72 03                	jb     0x182c16176
   182c16173:	4d 8b 09             	mov    r9,QWORD PTR [r9]
   182c16176:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
   182c1617a:	49 39 c6             	cmp    r14,rax
   182c1617d:	76 74                	jbe    0x182c161f3
   182c1617f:	48 89 d9             	mov    rcx,rbx
   182c16182:	4c 89 f2             	mov    rdx,r14
   182c16185:	e8 c6 7f 42 fd       	call   0x18003e150
   182c1618a:	90                   	nop
   182c1618b:	48 8b 5f 10          	mov    rbx,QWORD PTR [rdi+0x10]
   182c1618f:	48 83 7f 18 10       	cmp    QWORD PTR [rdi+0x18],0x10
   182c16194:	72 03                	jb     0x182c16199
   182c16196:	48 8b 3f             	mov    rdi,QWORD PTR [rdi]
   182c16199:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
   182c1619d:	48 39 c3             	cmp    rbx,rax
   182c161a0:	0f 86 82 00 00 00    	jbe    0x182c16228
   182c161a6:	4c 89 f9             	mov    rcx,r15
   182c161a9:	48 89 da             	mov    rdx,rbx
   182c161ac:	49 89 f9             	mov    r9,rdi
   182c161af:	e8 9c 7f 42 fd       	call   0x18003e150
   182c161b4:	90                   	nop
   182c161b5:	e9 8f 00 00 00       	jmp    0x182c16249
   182c161ba:	48 83 f8 10          	cmp    rax,0x10
   182c161be:	72 04                	jb     0x182c161c4
   182c161c0:	4c 8b 7d c0          	mov    r15,QWORD PTR [rbp-0x40]
   182c161c4:	4c 89 6d d0          	mov    QWORD PTR [rbp-0x30],r13
   182c161c8:	4c 89 f9             	mov    rcx,r15
   182c161cb:	4c 89 f2             	mov    rdx,r14
   182c161ce:	4d 89 e8             	mov    r8,r13
   182c161d1:	e8 6a ec af 04       	call   0x187714e40
   182c161d6:	43 c6 04 2f 00       	mov    BYTE PTR [r15+r13*1],0x0
   182c161db:	4c 8d 7d 00          	lea    r15,[rbp+0x0]
   182c161df:	4c 8b 8d b8 02 00 00 	mov    r9,QWORD PTR [rbp+0x2b8]
   182c161e6:	4d 8b 71 10          	mov    r14,QWORD PTR [r9+0x10]
   182c161ea:	49 83 79 18 10       	cmp    QWORD PTR [r9+0x18],0x10
   182c161ef:	73 82                	jae    0x182c16173
   182c161f1:	eb 83                	jmp    0x182c16176
   182c161f3:	48 83 f8 10          	cmp    rax,0x10
   182c161f7:	72 04                	jb     0x182c161fd
   182c161f9:	48 8b 5d e0          	mov    rbx,QWORD PTR [rbp-0x20]
   182c161fd:	4c 89 75 f0          	mov    QWORD PTR [rbp-0x10],r14
   182c16201:	48 89 d9             	mov    rcx,rbx
   182c16204:	4c 89 ca             	mov    rdx,r9
   182c16207:	4d 89 f0             	mov    r8,r14
   182c1620a:	e8 31 ec af 04       	call   0x187714e40
   182c1620f:	42 c6 04 33 00       	mov    BYTE PTR [rbx+r14*1],0x0
   182c16214:	48 8b 5f 10          	mov    rbx,QWORD PTR [rdi+0x10]
   182c16218:	48 83 7f 18 10       	cmp    QWORD PTR [rdi+0x18],0x10
   182c1621d:	0f 83 73 ff ff ff    	jae    0x182c16196
   182c16223:	e9 71 ff ff ff       	jmp    0x182c16199
   182c16228:	48 83 f8 10          	cmp    rax,0x10
   182c1622c:	72 04                	jb     0x182c16232
   182c1622e:	4c 8b 7d 00          	mov    r15,QWORD PTR [rbp+0x0]
   182c16232:	48 89 5d 10          	mov    QWORD PTR [rbp+0x10],rbx
   182c16236:	4c 89 f9             	mov    rcx,r15
   182c16239:	48 89 fa             	mov    rdx,rdi
   182c1623c:	49 89 d8             	mov    r8,rbx
   182c1623f:	e8 fc eb af 04       	call   0x187714e40
   182c16244:	41 c6 04 1f 00       	mov    BYTE PTR [r15+rbx*1],0x0
   182c16249:	8b 85 d8 05 00 00    	mov    eax,DWORD PTR [rbp+0x5d8]
   182c1624f:	89 45 20             	mov    DWORD PTR [rbp+0x20],eax
   182c16252:	48 8d 95 20 03 00 00 	lea    rdx,[rbp+0x320]
   182c16259:	4c 89 e1             	mov    rcx,r12
   182c1625c:	e8 7f 53 48 fd       	call   0x18009b5e0
   182c16261:	90                   	nop
   182c16262:	0f 29 b5 e0 02 00 00 	movaps XMMWORD PTR [rbp+0x2e0],xmm6
   182c16269:	0f 29 b5 d0 02 00 00 	movaps XMMWORD PTR [rbp+0x2d0],xmm6
   182c16270:	48 8d bd e0 04 00 00 	lea    rdi,[rbp+0x4e0]
   182c16277:	48 89 f9             	mov    rcx,rdi
   182c1627a:	e8 a1 0f 43 fd       	call   0x180047220
   182c1627f:	90                   	nop
   182c16280:	48 8b 8d e0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4e0]
   182c16287:	48 8d 95 a0 03 00 00 	lea    rdx,[rbp+0x3a0]
   182c1628e:	e8 3d c1 76 fd       	call   0x1803823d0
   182c16293:	90                   	nop
   182c16294:	48 8b 8d a0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3a0]
   182c1629b:	48 8d 95 50 04 00 00 	lea    rdx,[rbp+0x450]
   182c162a2:	e8 b9 67 75 fd       	call   0x18036ca60
   182c162a7:	90                   	nop
   182c162a8:	48 8b 8d 50 04 00 00 	mov    rcx,QWORD PTR [rbp+0x450]
   182c162af:	e8 fc da 4f fd       	call   0x180113db0
   182c162b4:	90                   	nop
   182c162b5:	48 89 c3             	mov    rbx,rax
   182c162b8:	c7 85 30 05 00 00 00 	mov    DWORD PTR [rbp+0x530],0x0
   182c162bf:	00 00 00
   182c162c2:	48 8d 8d 40 03 00 00 	lea    rcx,[rbp+0x340]
   182c162c9:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   182c162cd:	4c 8d 85 30 05 00 00 	lea    r8,[rbp+0x530]
   182c162d4:	e8 87 f6 ff ff       	call   0x182c15960
   182c162d9:	90                   	nop
   182c162da:	0f 28 85 40 03 00 00 	movaps xmm0,XMMWORD PTR [rbp+0x340]
   182c162e1:	0f 29 85 60 03 00 00 	movaps XMMWORD PTR [rbp+0x360],xmm0
   182c162e8:	0f 57 c0             	xorps  xmm0,xmm0
   182c162eb:	0f 29 85 40 03 00 00 	movaps XMMWORD PTR [rbp+0x340],xmm0
   182c162f2:	c7 85 24 04 00 00 0e 	mov    DWORD PTR [rbp+0x424],0xe
   182c162f9:	00 00 00
   182c162fc:	48 8d 95 d0 02 00 00 	lea    rdx,[rbp+0x2d0]
   182c16303:	4c 8d 85 24 04 00 00 	lea    r8,[rbp+0x424]
   182c1630a:	4c 8d 8d 60 03 00 00 	lea    r9,[rbp+0x360]
   182c16311:	48 89 d9             	mov    rcx,rbx
   182c16314:	e8 07 db 26 fe       	call   0x180e83e20
   182c16319:	90                   	nop
   182c1631a:	48 8b 9d 68 03 00 00 	mov    rbx,QWORD PTR [rbp+0x368]
   182c16321:	48 85 db             	test   rbx,rbx
   182c16324:	74 1d                	je     0x182c16343
   182c16326:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   182c1632a:	75 17                	jne    0x182c16343
   182c1632c:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c1632f:	48 89 d9             	mov    rcx,rbx
   182c16332:	ff 10                	call   QWORD PTR [rax]
   182c16334:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   182c16338:	75 09                	jne    0x182c16343
   182c1633a:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c1633d:	48 89 d9             	mov    rcx,rbx
   182c16340:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c16343:	48 8b 9d 48 03 00 00 	mov    rbx,QWORD PTR [rbp+0x348]
   182c1634a:	48 85 db             	test   rbx,rbx
   182c1634d:	74 1d                	je     0x182c1636c
   182c1634f:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   182c16353:	75 17                	jne    0x182c1636c
   182c16355:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c16358:	48 89 d9             	mov    rcx,rbx
   182c1635b:	ff 10                	call   QWORD PTR [rax]
   182c1635d:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   182c16361:	75 09                	jne    0x182c1636c
   182c16363:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c16366:	48 89 d9             	mov    rcx,rbx
   182c16369:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c1636c:	48 8b 9d 58 04 00 00 	mov    rbx,QWORD PTR [rbp+0x458]
   182c16373:	48 85 db             	test   rbx,rbx
   182c16376:	74 1d                	je     0x182c16395
   182c16378:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   182c1637c:	75 17                	jne    0x182c16395
   182c1637e:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c16381:	48 89 d9             	mov    rcx,rbx
   182c16384:	ff 10                	call   QWORD PTR [rax]
   182c16386:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   182c1638a:	75 09                	jne    0x182c16395
   182c1638c:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c1638f:	48 89 d9             	mov    rcx,rbx
   182c16392:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c16395:	48 8b 9d a8 03 00 00 	mov    rbx,QWORD PTR [rbp+0x3a8]
   182c1639c:	48 85 db             	test   rbx,rbx
   182c1639f:	74 1d                	je     0x182c163be
   182c163a1:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   182c163a5:	75 17                	jne    0x182c163be
   182c163a7:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c163aa:	48 89 d9             	mov    rcx,rbx
   182c163ad:	ff 10                	call   QWORD PTR [rax]
   182c163af:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   182c163b3:	75 09                	jne    0x182c163be
   182c163b5:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c163b8:	48 89 d9             	mov    rcx,rbx
   182c163bb:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c163be:	48 8b 9d e8 04 00 00 	mov    rbx,QWORD PTR [rbp+0x4e8]
   182c163c5:	48 85 db             	test   rbx,rbx
   182c163c8:	74 1d                	je     0x182c163e7
   182c163ca:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   182c163ce:	75 17                	jne    0x182c163e7
   182c163d0:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c163d3:	48 89 d9             	mov    rcx,rbx
   182c163d6:	ff 10                	call   QWORD PTR [rax]
   182c163d8:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   182c163dc:	75 09                	jne    0x182c163e7
   182c163de:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c163e1:	48 89 d9             	mov    rcx,rbx
   182c163e4:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c163e7:	83 bd d8 02 00 00 00 	cmp    DWORD PTR [rbp+0x2d8],0x0
   182c163ee:	0f 84 5e 02 00 00    	je     0x182c16652
   182c163f4:	b9 04 00 00 00       	mov    ecx,0x4
   182c163f9:	e8 e2 69 45 fd       	call   0x18006cde0
   182c163fe:	85 c0                	test   eax,eax
   182c16400:	0f 84 df 01 00 00    	je     0x182c165e5
   182c16406:	48 8d b5 60 03 00 00 	lea    rsi,[rbp+0x360]
   182c1640d:	48 89 f1             	mov    rcx,rsi
   182c16410:	e8 fb 6a 45 fd       	call   0x18006cf10
   182c16415:	90                   	nop
   182c16416:	48 83 bd 78 03 00 00 	cmp    QWORD PTR [rbp+0x378],0x10
   182c1641d:	10
   182c1641e:	72 07                	jb     0x182c16427
   182c16420:	48 8b b5 60 03 00 00 	mov    rsi,QWORD PTR [rbp+0x360]
   182c16427:	48 8d 05 62 77 95 06 	lea    rax,[rip+0x6957762]        # 0x18956db90
   182c1642e:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182c16433:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182c1643a:	00 00
   182c1643c:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182c16441:	c7 44 24 28 52 0a 00 	mov    DWORD PTR [rsp+0x28],0xa52
   182c16448:	00
   182c16449:	4c 8d 0d 18 31 95 06 	lea    r9,[rip+0x6953118]        # 0x189569568
   182c16450:	48 8d 8d 50 04 00 00 	lea    rcx,[rbp+0x450]
   182c16457:	ba 04 00 00 00       	mov    edx,0x4
   182c1645c:	49 89 f0             	mov    r8,rsi
   182c1645f:	e8 0c 6e 45 fd       	call   0x18006d270
   182c16464:	90                   	nop
   182c16465:	8b 8d d8 02 00 00    	mov    ecx,DWORD PTR [rbp+0x2d8]
   182c1646b:	48 c7 85 e0 04 00 00 	mov    QWORD PTR [rbp+0x4e0],0x0
   182c16472:	00 00 00 00
   182c16476:	b8 08 00 00 00       	mov    eax,0x8
   182c1647b:	48 8d 15 ee 0d 30 06 	lea    rdx,[rip+0x6300dee]        # 0x188f17270
   182c16482:	41 89 c8             	mov    r8d,ecx
   182c16485:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
   182c1648c:	00 00 00 00
   182c16490:	4d 63 c8             	movsxd r9,r8d
   182c16493:	4d 69 c1 67 66 66 66 	imul   r8,r9,0x66666667
   182c1649a:	4d 89 c2             	mov    r10,r8
   182c1649d:	49 c1 ea 3f          	shr    r10,0x3f
   182c164a1:	49 c1 f8 22          	sar    r8,0x22
   182c164a5:	45 01 d0             	add    r8d,r10d
   182c164a8:	47 8d 14 00          	lea    r10d,[r8+r8*1]
   182c164ac:	47 8d 14 92          	lea    r10d,[r10+r10*4]
   182c164b0:	41 f7 da             	neg    r10d
   182c164b3:	45 01 ca             	add    r10d,r9d
   182c164b6:	41 83 c2 23          	add    r10d,0x23
   182c164ba:	4d 63 d2             	movsxd r10,r10d
   182c164bd:	45 0f b6 14 12       	movzx  r10d,BYTE PTR [r10+rdx*1]
   182c164c2:	44 88 94 05 e0 04 00 	mov    BYTE PTR [rbp+rax*1+0x4e0],r10b
   182c164c9:	00
   182c164ca:	48 ff c0             	inc    rax
   182c164cd:	41 83 c1 09          	add    r9d,0x9
   182c164d1:	41 83 f9 12          	cmp    r9d,0x12
   182c164d5:	77 b9                	ja     0x182c16490
   182c164d7:	85 c9                	test   ecx,ecx
   182c164d9:	79 0b                	jns    0x182c164e6
   182c164db:	c6 84 05 e0 04 00 00 	mov    BYTE PTR [rbp+rax*1+0x4e0],0x2d
   182c164e2:	2d
   182c164e3:	48 ff c0             	inc    rax
   182c164e6:	48 8d 8d e8 04 00 00 	lea    rcx,[rbp+0x4e8]
   182c164ed:	c6 84 05 e0 04 00 00 	mov    BYTE PTR [rbp+rax*1+0x4e0],0x0
   182c164f4:	00
   182c164f5:	48 83 f8 0a          	cmp    rax,0xa
   182c164f9:	7c 31                	jl     0x182c1652c
   182c164fb:	48 01 e8             	add    rax,rbp
   182c164fe:	48 05 e0 04 00 00    	add    rax,0x4e0
   182c16504:	48 ff c8             	dec    rax
   182c16507:	48 8d 95 e9 04 00 00 	lea    rdx,[rbp+0x4e9]
   182c1650e:	66 90                	xchg   ax,ax
   182c16510:	44 0f b6 00          	movzx  r8d,BYTE PTR [rax]
   182c16514:	44 0f b6 4a ff       	movzx  r9d,BYTE PTR [rdx-0x1]
   182c16519:	44 88 08             	mov    BYTE PTR [rax],r9b
   182c1651c:	44 88 42 ff          	mov    BYTE PTR [rdx-0x1],r8b
   182c16520:	48 ff c8             	dec    rax
   182c16523:	48 39 c2             	cmp    rdx,rax
   182c16526:	48 8d 52 01          	lea    rdx,[rdx+0x1]
   182c1652a:	72 e4                	jb     0x182c16510
   182c1652c:	48 89 8d e0 04 00 00 	mov    QWORD PTR [rbp+0x4e0],rcx
   182c16533:	0f 57 c0             	xorps  xmm0,xmm0
   182c16536:	0f 11 85 08 04 00 00 	movups XMMWORD PTR [rbp+0x408],xmm0
   182c1653d:	0f 11 85 f8 03 00 00 	movups XMMWORD PTR [rbp+0x3f8],xmm0
   182c16544:	0f 11 85 e8 03 00 00 	movups XMMWORD PTR [rbp+0x3e8],xmm0
   182c1654b:	0f 11 85 d8 03 00 00 	movups XMMWORD PTR [rbp+0x3d8],xmm0
   182c16552:	0f 11 85 c8 03 00 00 	movups XMMWORD PTR [rbp+0x3c8],xmm0
   182c16559:	0f 11 85 b8 03 00 00 	movups XMMWORD PTR [rbp+0x3b8],xmm0
   182c16560:	0f 11 85 a8 03 00 00 	movups XMMWORD PTR [rbp+0x3a8],xmm0
   182c16567:	48 c7 85 18 04 00 00 	mov    QWORD PTR [rbp+0x418],0x0
   182c1656e:	00 00 00 00
   182c16572:	48 89 bd a0 03 00 00 	mov    QWORD PTR [rbp+0x3a0],rdi
   182c16579:	48 8d 15 d0 44 95 06 	lea    rdx,[rip+0x69544d0]        # 0x18956aa50
   182c16580:	48 8d 8d 50 04 00 00 	lea    rcx,[rbp+0x450]
   182c16587:	4c 8d 85 a0 03 00 00 	lea    r8,[rbp+0x3a0]
   182c1658e:	e8 7d 72 45 fd       	call   0x18006d810
   182c16593:	90                   	nop
   182c16594:	48 8d 8d 50 04 00 00 	lea    rcx,[rbp+0x450]
   182c1659b:	e8 d0 6d 45 fd       	call   0x18006d370
   182c165a0:	48 8b 85 78 03 00 00 	mov    rax,QWORD PTR [rbp+0x378]
   182c165a7:	48 83 f8 10          	cmp    rax,0x10
   182c165ab:	72 38                	jb     0x182c165e5
   182c165ad:	48 8b 8d 60 03 00 00 	mov    rcx,QWORD PTR [rbp+0x360]
   182c165b4:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c165b8:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c165bf:	72 1f                	jb     0x182c165e0
   182c165c1:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c165c5:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c165c9:	4c 29 c1             	sub    rcx,r8
   182c165cc:	48 83 f9 20          	cmp    rcx,0x20
   182c165d0:	0f 83 90 0e 00 00    	jae    0x182c17466
   182c165d6:	48 83 c0 28          	add    rax,0x28
   182c165da:	48 89 c2             	mov    rdx,rax
   182c165dd:	4c 89 c1             	mov    rcx,r8
   182c165e0:	e8 3b 57 93 04       	call   0x18754bd20
   182c165e5:	8b 95 d8 02 00 00    	mov    edx,DWORD PTR [rbp+0x2d8]
   182c165eb:	48 8d b5 50 04 00 00 	lea    rsi,[rbp+0x450]
   182c165f2:	48 89 f1             	mov    rcx,rsi
   182c165f5:	e8 06 45 48 fd       	call   0x18009ab00
   182c165fa:	90                   	nop
   182c165fb:	4c 8b 85 60 04 00 00 	mov    r8,QWORD PTR [rbp+0x460]
   182c16602:	48 8b 85 68 04 00 00 	mov    rax,QWORD PTR [rbp+0x468]
   182c16609:	48 89 c1             	mov    rcx,rax
   182c1660c:	4c 29 c1             	sub    rcx,r8
   182c1660f:	48 83 f9 20          	cmp    rcx,0x20
   182c16613:	0f 83 8f 08 00 00    	jae    0x182c16ea8
   182c16619:	48 8d 05 30 b5 94 06 	lea    rax,[rip+0x694b530]        # 0x189561b50
   182c16620:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182c16625:	48 c7 44 24 28 20 00 	mov    QWORD PTR [rsp+0x28],0x20
   182c1662c:	00 00
   182c1662e:	48 8d 8d 50 04 00 00 	lea    rcx,[rbp+0x450]
   182c16635:	ba 20 00 00 00       	mov    edx,0x20
   182c1663a:	45 31 c9             	xor    r9d,r9d
   182c1663d:	e8 0e 57 3f fd       	call   0x18000bd50
   182c16642:	90                   	nop
   182c16643:	48 89 c6             	mov    rsi,rax
   182c16646:	4c 8b a5 40 05 00 00 	mov    r12,QWORD PTR [rbp+0x540]
   182c1664d:	e9 f3 08 00 00       	jmp    0x182c16f45
   182c16652:	48 8d 8d 20 03 00 00 	lea    rcx,[rbp+0x320]
   182c16659:	e8 62 de 78 fd       	call   0x1803a44c0
   182c1665e:	90                   	nop
   182c1665f:	84 c0                	test   al,al
   182c16661:	0f 84 e3 0b 00 00    	je     0x182c1724a
   182c16667:	48 8d 05 aa 7f 3b 06 	lea    rax,[rip+0x63b7faa]        # 0x188fce618
   182c1666e:	48 89 85 d0 02 00 00 	mov    QWORD PTR [rbp+0x2d0],rax
   182c16675:	48 8b bd e8 02 00 00 	mov    rdi,QWORD PTR [rbp+0x2e8]
   182c1667c:	48 85 ff             	test   rdi,rdi
   182c1667f:	74 1d                	je     0x182c1669e
   182c16681:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   182c16685:	75 17                	jne    0x182c1669e
   182c16687:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c1668a:	48 89 f9             	mov    rcx,rdi
   182c1668d:	ff 10                	call   QWORD PTR [rax]
   182c1668f:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   182c16693:	75 09                	jne    0x182c1669e
   182c16695:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c16698:	48 89 f9             	mov    rcx,rdi
   182c1669b:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c1669e:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c166a2:	e8 b9 18 00 00       	call   0x182c17f60
   182c166a7:	0f 29 b5 30 05 00 00 	movaps XMMWORD PTR [rbp+0x530],xmm6
   182c166ae:	48 8d 8d 30 05 00 00 	lea    rcx,[rbp+0x530]
   182c166b5:	e8 46 af 16 ff       	call   0x181d81600
   182c166ba:	90                   	nop
   182c166bb:	48 8b 85 30 05 00 00 	mov    rax,QWORD PTR [rbp+0x530]
   182c166c2:	c7 80 18 01 00 00 03 	mov    DWORD PTR [rax+0x118],0x3
   182c166c9:	00 00 00
   182c166cc:	48 8d b8 b0 00 00 00 	lea    rdi,[rax+0xb0]
   182c166d3:	48 39 f7             	cmp    rdi,rsi
   182c166d6:	74 4d                	je     0x182c16725
   182c166d8:	48 8b 5e 10          	mov    rbx,QWORD PTR [rsi+0x10]
   182c166dc:	48 83 7e 18 10       	cmp    QWORD PTR [rsi+0x18],0x10
   182c166e1:	49 89 f1             	mov    r9,rsi
   182c166e4:	72 03                	jb     0x182c166e9
   182c166e6:	4c 8b 0e             	mov    r9,QWORD PTR [rsi]
   182c166e9:	48 8b 88 c8 00 00 00 	mov    rcx,QWORD PTR [rax+0xc8]
   182c166f0:	48 39 cb             	cmp    rbx,rcx
   182c166f3:	76 0e                	jbe    0x182c16703
   182c166f5:	48 89 f9             	mov    rcx,rdi
   182c166f8:	48 89 da             	mov    rdx,rbx
   182c166fb:	e8 50 7a 42 fd       	call   0x18003e150
   182c16700:	90                   	nop
   182c16701:	eb 22                	jmp    0x182c16725
   182c16703:	48 83 f9 10          	cmp    rcx,0x10
   182c16707:	72 03                	jb     0x182c1670c
   182c16709:	48 8b 3f             	mov    rdi,QWORD PTR [rdi]
   182c1670c:	48 89 98 c0 00 00 00 	mov    QWORD PTR [rax+0xc0],rbx
   182c16713:	48 89 f9             	mov    rcx,rdi
   182c16716:	4c 89 ca             	mov    rdx,r9
   182c16719:	49 89 d8             	mov    r8,rbx
   182c1671c:	e8 1f e7 af 04       	call   0x187714e40
   182c16721:	c6 04 1f 00          	mov    BYTE PTR [rdi+rbx*1],0x0
   182c16725:	b9 20 01 00 00       	mov    ecx,0x120
   182c1672a:	48 03 8d 30 05 00 00 	add    rcx,QWORD PTR [rbp+0x530]
   182c16731:	48 8d 95 20 03 00 00 	lea    rdx,[rbp+0x320]
   182c16738:	e8 a3 4e 48 fd       	call   0x18009b5e0
   182c1673d:	90                   	nop
   182c1673e:	48 b8 aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaaa
   182c16745:	aa aa aa
   182c16748:	48 89 85 90 03 00 00 	mov    QWORD PTR [rbp+0x390],rax
   182c1674f:	0f 29 b5 80 03 00 00 	movaps XMMWORD PTR [rbp+0x380],xmm6
   182c16756:	0f 29 b5 70 03 00 00 	movaps XMMWORD PTR [rbp+0x370],xmm6
   182c1675d:	0f 29 b5 60 03 00 00 	movaps XMMWORD PTR [rbp+0x360],xmm6
   182c16764:	48 8d bd a0 03 00 00 	lea    rdi,[rbp+0x3a0]
   182c1676b:	48 89 f9             	mov    rcx,rdi
   182c1676e:	e8 ad 0a 43 fd       	call   0x180047220
   182c16773:	90                   	nop
   182c16774:	48 8b 8d a0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3a0]
   182c1677b:	48 8d 95 50 04 00 00 	lea    rdx,[rbp+0x450]
   182c16782:	e8 49 bc 76 fd       	call   0x1803823d0
   182c16787:	90                   	nop
   182c16788:	48 8b 8d 50 04 00 00 	mov    rcx,QWORD PTR [rbp+0x450]
   182c1678f:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   182c16793:	e8 e8 2a af fd       	call   0x180709280
   182c16798:	90                   	nop
   182c16799:	48 8b 4d c0          	mov    rcx,QWORD PTR [rbp-0x40]
   182c1679d:	0f 57 c0             	xorps  xmm0,xmm0
   182c167a0:	0f 29 85 c0 02 00 00 	movaps XMMWORD PTR [rbp+0x2c0],xmm0
   182c167a7:	48 8b 85 38 05 00 00 	mov    rax,QWORD PTR [rbp+0x538]
   182c167ae:	48 85 c0             	test   rax,rax
   182c167b1:	74 0d                	je     0x182c167c0
   182c167b3:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   182c167b7:	48 8b 85 38 05 00 00 	mov    rax,QWORD PTR [rbp+0x538]
   182c167be:	eb 02                	jmp    0x182c167c2
   182c167c0:	31 c0                	xor    eax,eax
   182c167c2:	48 8b 95 30 05 00 00 	mov    rdx,QWORD PTR [rbp+0x530]
   182c167c9:	48 89 95 c0 02 00 00 	mov    QWORD PTR [rbp+0x2c0],rdx
   182c167d0:	48 89 85 c8 02 00 00 	mov    QWORD PTR [rbp+0x2c8],rax
   182c167d7:	48 8d 95 60 03 00 00 	lea    rdx,[rbp+0x360]
   182c167de:	4c 8d 85 c0 02 00 00 	lea    r8,[rbp+0x2c0]
   182c167e5:	e8 76 d3 b8 fe       	call   0x1817a3b60
   182c167ea:	90                   	nop
   182c167eb:	48 8b 5d c8          	mov    rbx,QWORD PTR [rbp-0x38]
   182c167ef:	48 85 db             	test   rbx,rbx
   182c167f2:	74 1d                	je     0x182c16811
   182c167f4:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   182c167f8:	75 17                	jne    0x182c16811
   182c167fa:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c167fd:	48 89 d9             	mov    rcx,rbx
   182c16800:	ff 10                	call   QWORD PTR [rax]
   182c16802:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   182c16806:	75 09                	jne    0x182c16811
   182c16808:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c1680b:	48 89 d9             	mov    rcx,rbx
   182c1680e:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c16811:	48 8b 9d 58 04 00 00 	mov    rbx,QWORD PTR [rbp+0x458]
   182c16818:	48 85 db             	test   rbx,rbx
   182c1681b:	4c 8b a5 40 05 00 00 	mov    r12,QWORD PTR [rbp+0x540]
   182c16822:	74 1d                	je     0x182c16841
   182c16824:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   182c16828:	75 17                	jne    0x182c16841
   182c1682a:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c1682d:	48 89 d9             	mov    rcx,rbx
   182c16830:	ff 10                	call   QWORD PTR [rax]
   182c16832:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   182c16836:	75 09                	jne    0x182c16841
   182c16838:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c1683b:	48 89 d9             	mov    rcx,rbx
   182c1683e:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c16841:	48 8b 9d a8 03 00 00 	mov    rbx,QWORD PTR [rbp+0x3a8]
   182c16848:	48 85 db             	test   rbx,rbx
   182c1684b:	74 1d                	je     0x182c1686a
   182c1684d:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   182c16851:	75 17                	jne    0x182c1686a
   182c16853:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c16856:	48 89 d9             	mov    rcx,rbx
   182c16859:	ff 10                	call   QWORD PTR [rax]
   182c1685b:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   182c1685f:	75 09                	jne    0x182c1686a
   182c16861:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c16864:	48 89 d9             	mov    rcx,rbx
   182c16867:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c1686a:	8b 85 64 03 00 00    	mov    eax,DWORD PTR [rbp+0x364]
   182c16870:	0b 85 60 03 00 00    	or     eax,DWORD PTR [rbp+0x360]
   182c16876:	0f 84 f8 01 00 00    	je     0x182c16a74
   182c1687c:	b9 04 00 00 00       	mov    ecx,0x4
   182c16881:	e8 5a 65 45 fd       	call   0x18006cde0
   182c16886:	85 c0                	test   eax,eax
   182c16888:	0f 84 84 01 00 00    	je     0x182c16a12
   182c1688e:	48 8d b5 e0 04 00 00 	lea    rsi,[rbp+0x4e0]
   182c16895:	48 89 f1             	mov    rcx,rsi
   182c16898:	e8 73 66 45 fd       	call   0x18006cf10
   182c1689d:	90                   	nop
   182c1689e:	48 83 bd f8 04 00 00 	cmp    QWORD PTR [rbp+0x4f8],0x10
   182c168a5:	10
   182c168a6:	72 07                	jb     0x182c168af
   182c168a8:	48 8b b5 e0 04 00 00 	mov    rsi,QWORD PTR [rbp+0x4e0]
   182c168af:	48 8d 05 da 72 95 06 	lea    rax,[rip+0x69572da]        # 0x18956db90
   182c168b6:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182c168bb:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182c168c2:	00 00
   182c168c4:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182c168c9:	c7 44 24 28 66 0a 00 	mov    DWORD PTR [rsp+0x28],0xa66
   182c168d0:	00
   182c168d1:	4c 8d 0d 90 2c 95 06 	lea    r9,[rip+0x6952c90]        # 0x189569568
   182c168d8:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c168dc:	ba 04 00 00 00       	mov    edx,0x4
   182c168e1:	49 89 f0             	mov    r8,rsi
   182c168e4:	e8 87 69 45 fd       	call   0x18006d270
   182c168e9:	90                   	nop
   182c168ea:	48 8d 8d 60 03 00 00 	lea    rcx,[rbp+0x360]
   182c168f1:	48 8d b5 d0 02 00 00 	lea    rsi,[rbp+0x2d0]
   182c168f8:	48 89 f2             	mov    rdx,rsi
   182c168fb:	e8 60 a3 4f fd       	call   0x180110c60
   182c16900:	90                   	nop
   182c16901:	48 83 bd e8 02 00 00 	cmp    QWORD PTR [rbp+0x2e8],0x10
   182c16908:	10
   182c16909:	72 07                	jb     0x182c16912
   182c1690b:	48 8b b5 d0 02 00 00 	mov    rsi,QWORD PTR [rbp+0x2d0]
   182c16912:	48 89 b5 a0 03 00 00 	mov    QWORD PTR [rbp+0x3a0],rsi
   182c16919:	c6 85 a8 03 00 00 00 	mov    BYTE PTR [rbp+0x3a8],0x0
   182c16920:	0f 57 c0             	xorps  xmm0,xmm0
   182c16923:	0f 11 85 b8 04 00 00 	movups XMMWORD PTR [rbp+0x4b8],xmm0
   182c1692a:	0f 11 85 a8 04 00 00 	movups XMMWORD PTR [rbp+0x4a8],xmm0
   182c16931:	0f 11 85 98 04 00 00 	movups XMMWORD PTR [rbp+0x498],xmm0
   182c16938:	0f 11 85 88 04 00 00 	movups XMMWORD PTR [rbp+0x488],xmm0
   182c1693f:	0f 11 85 78 04 00 00 	movups XMMWORD PTR [rbp+0x478],xmm0
   182c16946:	0f 11 85 68 04 00 00 	movups XMMWORD PTR [rbp+0x468],xmm0
   182c1694d:	0f 11 85 58 04 00 00 	movups XMMWORD PTR [rbp+0x458],xmm0
   182c16954:	48 c7 85 c8 04 00 00 	mov    QWORD PTR [rbp+0x4c8],0x0
   182c1695b:	00 00 00 00
   182c1695f:	48 89 bd 50 04 00 00 	mov    QWORD PTR [rbp+0x450],rdi
   182c16966:	48 8d 15 83 33 95 06 	lea    rdx,[rip+0x6953383]        # 0x189569cf0
   182c1696d:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c16971:	4c 8d 85 50 04 00 00 	lea    r8,[rbp+0x450]
   182c16978:	e8 93 6e 45 fd       	call   0x18006d810
   182c1697d:	90                   	nop
   182c1697e:	48 8b 85 e8 02 00 00 	mov    rax,QWORD PTR [rbp+0x2e8]
   182c16985:	48 83 f8 10          	cmp    rax,0x10
   182c16989:	72 38                	jb     0x182c169c3
   182c1698b:	48 8b 8d d0 02 00 00 	mov    rcx,QWORD PTR [rbp+0x2d0]
   182c16992:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c16996:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c1699d:	72 1f                	jb     0x182c169be
   182c1699f:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c169a3:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c169a7:	4c 29 c1             	sub    rcx,r8
   182c169aa:	48 83 f9 20          	cmp    rcx,0x20
   182c169ae:	0f 83 b2 0a 00 00    	jae    0x182c17466
   182c169b4:	48 83 c0 28          	add    rax,0x28
   182c169b8:	48 89 c2             	mov    rdx,rax
   182c169bb:	4c 89 c1             	mov    rcx,r8
   182c169be:	e8 5d 53 93 04       	call   0x18754bd20
   182c169c3:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c169c7:	e8 a4 69 45 fd       	call   0x18006d370
   182c169cc:	48 8b 85 f8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4f8]
   182c169d3:	48 83 f8 10          	cmp    rax,0x10
   182c169d7:	72 39                	jb     0x182c16a12
   182c169d9:	48 8b 8d e0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4e0]
   182c169e0:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c169e4:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c169eb:	72 1f                	jb     0x182c16a0c
   182c169ed:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c169f1:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c169f5:	4c 29 c1             	sub    rcx,r8
   182c169f8:	48 83 f9 20          	cmp    rcx,0x20
   182c169fc:	0f 83 64 0a 00 00    	jae    0x182c17466
   182c16a02:	48 83 c0 28          	add    rax,0x28
   182c16a06:	48 89 c2             	mov    rdx,rax
   182c16a09:	4c 89 c1             	mov    rcx,r8
   182c16a0c:	e8 0f 53 93 04       	call   0x18754bd20
   182c16a11:	90                   	nop
   182c16a12:	48 8d 8d 60 03 00 00 	lea    rcx,[rbp+0x360]
   182c16a19:	48 8d 75 c0          	lea    rsi,[rbp-0x40]
   182c16a1d:	48 89 f2             	mov    rdx,rsi
   182c16a20:	e8 3b a2 4f fd       	call   0x180110c60
   182c16a25:	90                   	nop
   182c16a26:	4c 8b 45 d0          	mov    r8,QWORD PTR [rbp-0x30]
   182c16a2a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
   182c16a2e:	48 89 c1             	mov    rcx,rax
   182c16a31:	4c 29 c1             	sub    rcx,r8
   182c16a34:	48 83 f9 1a          	cmp    rcx,0x1a
   182c16a38:	0f 83 e9 05 00 00    	jae    0x182c17027
   182c16a3e:	48 8d 05 5b b1 94 06 	lea    rax,[rip+0x694b15b]        # 0x189561ba0
   182c16a45:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182c16a4a:	48 c7 44 24 28 1a 00 	mov    QWORD PTR [rsp+0x28],0x1a
   182c16a51:	00 00
   182c16a53:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c16a57:	ba 1a 00 00 00       	mov    edx,0x1a
   182c16a5c:	45 31 c9             	xor    r9d,r9d
   182c16a5f:	e8 ec 52 3f fd       	call   0x18000bd50
   182c16a64:	90                   	nop
   182c16a65:	48 89 c6             	mov    rsi,rax
   182c16a68:	4c 8b a5 40 05 00 00 	mov    r12,QWORD PTR [rbp+0x540]
   182c16a6f:	e9 4a 06 00 00       	jmp    0x182c170be
   182c16a74:	49 8d 5c 24 08       	lea    rbx,[r12+0x8]
   182c16a79:	41 c6 04 24 01       	mov    BYTE PTR [r12],0x1
   182c16a7e:	48 b8 aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaaa
   182c16a85:	aa aa aa
   182c16a88:	48 89 85 f0 03 00 00 	mov    QWORD PTR [rbp+0x3f0],rax
   182c16a8f:	0f 29 b5 e0 03 00 00 	movaps XMMWORD PTR [rbp+0x3e0],xmm6
   182c16a96:	0f 29 b5 d0 03 00 00 	movaps XMMWORD PTR [rbp+0x3d0],xmm6
   182c16a9d:	0f 29 b5 c0 03 00 00 	movaps XMMWORD PTR [rbp+0x3c0],xmm6
   182c16aa4:	0f 29 b5 b0 03 00 00 	movaps XMMWORD PTR [rbp+0x3b0],xmm6
   182c16aab:	0f 29 b5 a0 03 00 00 	movaps XMMWORD PTR [rbp+0x3a0],xmm6
   182c16ab2:	48 8b 95 88 03 00 00 	mov    rdx,QWORD PTR [rbp+0x388]
   182c16ab9:	c6 85 f0 03 00 00 00 	mov    BYTE PTR [rbp+0x3f0],0x0
   182c16ac0:	80 7a 50 01          	cmp    BYTE PTR [rdx+0x50],0x1
   182c16ac4:	0f 85 34 01 00 00    	jne    0x182c16bfe
   182c16aca:	48 8d 8d a0 03 00 00 	lea    rcx,[rbp+0x3a0]
   182c16ad1:	e8 fa 6c b6 fd       	call   0x18077d7d0
   182c16ad6:	90                   	nop
   182c16ad7:	c6 85 f0 03 00 00 01 	mov    BYTE PTR [rbp+0x3f0],0x1
   182c16ade:	8b 85 c0 03 00 00    	mov    eax,DWORD PTR [rbp+0x3c0]
   182c16ae4:	48 8b 8d 40 05 00 00 	mov    rcx,QWORD PTR [rbp+0x540]
   182c16aeb:	48 89 41 10          	mov    QWORD PTR [rcx+0x10],rax
   182c16aef:	48 8d 15 c2 c6 48 06 	lea    rdx,[rip+0x648c6c2]        # 0x1890a31b8
   182c16af6:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c16afa:	41 b8 f0 02 00 00    	mov    r8d,0x2f0
   182c16b00:	e8 3b e3 af 04       	call   0x187714e40
   182c16b05:	90                   	nop
   182c16b06:	48 8d 8d d0 02 00 00 	lea    rcx,[rbp+0x2d0]
   182c16b0d:	e8 0e 07 43 fd       	call   0x180047220
   182c16b12:	90                   	nop
   182c16b13:	48 8b 8d d0 02 00 00 	mov    rcx,QWORD PTR [rbp+0x2d0]
   182c16b1a:	48 8d 95 e0 04 00 00 	lea    rdx,[rbp+0x4e0]
   182c16b21:	e8 aa b8 76 fd       	call   0x1803823d0
   182c16b26:	90                   	nop
   182c16b27:	48 8b 8d e0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4e0]
   182c16b2e:	48 8d 95 50 04 00 00 	lea    rdx,[rbp+0x450]
   182c16b35:	e8 46 27 af fd       	call   0x180709280
   182c16b3a:	90                   	nop
   182c16b3b:	48 8b 8d 50 04 00 00 	mov    rcx,QWORD PTR [rbp+0x450]
   182c16b42:	8b 85 c0 03 00 00    	mov    eax,DWORD PTR [rbp+0x3c0]
   182c16b48:	44 8b 8d c4 03 00 00 	mov    r9d,DWORD PTR [rbp+0x3c4]
   182c16b4f:	89 44 24 20          	mov    DWORD PTR [rsp+0x20],eax
   182c16b53:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   182c16b57:	49 89 f0             	mov    r8,rsi
   182c16b5a:	e8 31 30 ba fe       	call   0x1817b9b90
   182c16b5f:	90                   	nop
   182c16b60:	48 8b bd 58 04 00 00 	mov    rdi,QWORD PTR [rbp+0x458]
   182c16b67:	48 85 ff             	test   rdi,rdi
   182c16b6a:	74 1d                	je     0x182c16b89
   182c16b6c:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   182c16b70:	75 17                	jne    0x182c16b89
   182c16b72:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c16b75:	48 89 f9             	mov    rcx,rdi
   182c16b78:	ff 10                	call   QWORD PTR [rax]
   182c16b7a:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   182c16b7e:	75 09                	jne    0x182c16b89
   182c16b80:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c16b83:	48 89 f9             	mov    rcx,rdi
   182c16b86:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c16b89:	48 8b bd e8 04 00 00 	mov    rdi,QWORD PTR [rbp+0x4e8]
   182c16b90:	48 85 ff             	test   rdi,rdi
   182c16b93:	4c 8b a5 40 05 00 00 	mov    r12,QWORD PTR [rbp+0x540]
   182c16b9a:	74 1d                	je     0x182c16bb9
   182c16b9c:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   182c16ba0:	75 17                	jne    0x182c16bb9
   182c16ba2:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c16ba5:	48 89 f9             	mov    rcx,rdi
   182c16ba8:	ff 10                	call   QWORD PTR [rax]
   182c16baa:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   182c16bae:	75 09                	jne    0x182c16bb9
   182c16bb0:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c16bb3:	48 89 f9             	mov    rcx,rdi
   182c16bb6:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c16bb9:	48 8b bd d8 02 00 00 	mov    rdi,QWORD PTR [rbp+0x2d8]
   182c16bc0:	48 85 ff             	test   rdi,rdi
   182c16bc3:	74 1d                	je     0x182c16be2
   182c16bc5:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   182c16bc9:	75 17                	jne    0x182c16be2
   182c16bcb:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c16bce:	48 89 f9             	mov    rcx,rdi
   182c16bd1:	ff 10                	call   QWORD PTR [rax]
   182c16bd3:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   182c16bd7:	75 09                	jne    0x182c16be2
   182c16bd9:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c16bdc:	48 89 f9             	mov    rcx,rdi
   182c16bdf:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c16be2:	80 bd a8 02 00 00 00 	cmp    BYTE PTR [rbp+0x2a8],0x0
   182c16be9:	74 13                	je     0x182c16bfe
   182c16beb:	48 8b 85 08 01 00 00 	mov    rax,QWORD PTR [rbp+0x108]
   182c16bf2:	48 89 03             	mov    QWORD PTR [rbx],rax
   182c16bf5:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c16bf9:	e8 42 5a 5b fd       	call   0x1801cc640
   182c16bfe:	b9 02 00 00 00       	mov    ecx,0x2
   182c16c03:	e8 d8 61 45 fd       	call   0x18006cde0
   182c16c08:	85 c0                	test   eax,eax
   182c16c0a:	0f 84 18 02 00 00    	je     0x182c16e28
   182c16c10:	48 8d bd 40 03 00 00 	lea    rdi,[rbp+0x340]
   182c16c17:	48 89 f9             	mov    rcx,rdi
   182c16c1a:	e8 f1 62 45 fd       	call   0x18006cf10
   182c16c1f:	90                   	nop
   182c16c20:	48 83 bd 58 03 00 00 	cmp    QWORD PTR [rbp+0x358],0x10
   182c16c27:	10
   182c16c28:	72 07                	jb     0x182c16c31
   182c16c2a:	48 8b bd 40 03 00 00 	mov    rdi,QWORD PTR [rbp+0x340]
   182c16c31:	48 8d 05 58 6f 95 06 	lea    rax,[rip+0x6956f58]        # 0x18956db90
   182c16c38:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182c16c3d:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182c16c44:	00 00
   182c16c46:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182c16c4b:	c7 44 24 28 74 0a 00 	mov    DWORD PTR [rsp+0x28],0xa74
   182c16c52:	00
   182c16c53:	4c 8d 0d 0e 29 95 06 	lea    r9,[rip+0x695290e]        # 0x189569568
   182c16c5a:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c16c5e:	ba 02 00 00 00       	mov    edx,0x2
   182c16c63:	49 89 f8             	mov    r8,rdi
   182c16c66:	e8 05 66 45 fd       	call   0x18006d270
   182c16c6b:	90                   	nop
   182c16c6c:	4c 8b 0b             	mov    r9,QWORD PTR [rbx]
   182c16c6f:	48 c7 85 e0 04 00 00 	mov    QWORD PTR [rbp+0x4e0],0x0
   182c16c76:	00 00 00 00
   182c16c7a:	41 b8 08 00 00 00    	mov    r8d,0x8
   182c16c80:	49 ba 67 66 66 66 66 	movabs r10,0x6666666666666667
   182c16c87:	66 66 66
   182c16c8a:	4c 8d 1d df 05 30 06 	lea    r11,[rip+0x63005df]        # 0x188f17270
   182c16c91:	4c 89 c9             	mov    rcx,r9
   182c16c94:	66 66 66 2e 0f 1f 84 	data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   182c16c9b:	00 00 00 00 00
   182c16ca0:	48 89 c8             	mov    rax,rcx
   182c16ca3:	49 f7 ea             	imul   r10
   182c16ca6:	48 89 d0             	mov    rax,rdx
   182c16ca9:	48 c1 e8 3f          	shr    rax,0x3f
   182c16cad:	48 c1 fa 02          	sar    rdx,0x2
   182c16cb1:	48 01 c2             	add    rdx,rax
   182c16cb4:	48 8d 04 12          	lea    rax,[rdx+rdx*1]
   182c16cb8:	48 8d 04 80          	lea    rax,[rax+rax*4]
   182c16cbc:	4c 89 de             	mov    rsi,r11
   182c16cbf:	48 29 c6             	sub    rsi,rax
   182c16cc2:	0f b6 44 0e 23       	movzx  eax,BYTE PTR [rsi+rcx*1+0x23]
   182c16cc7:	42 88 84 05 e0 04 00 	mov    BYTE PTR [rbp+r8*1+0x4e0],al
   182c16cce:	00
   182c16ccf:	49 ff c0             	inc    r8
   182c16cd2:	48 83 c1 09          	add    rcx,0x9
   182c16cd6:	48 83 f9 12          	cmp    rcx,0x12
   182c16cda:	48 89 d1             	mov    rcx,rdx
   182c16cdd:	77 c1                	ja     0x182c16ca0
   182c16cdf:	4d 85 c9             	test   r9,r9
   182c16ce2:	79 0c                	jns    0x182c16cf0
   182c16ce4:	42 c6 84 05 e0 04 00 	mov    BYTE PTR [rbp+r8*1+0x4e0],0x2d
   182c16ceb:	00 2d
   182c16ced:	49 ff c0             	inc    r8
   182c16cf0:	4c 8b 95 28 04 00 00 	mov    r10,QWORD PTR [rbp+0x428]
   182c16cf7:	48 8d 85 e8 04 00 00 	lea    rax,[rbp+0x4e8]
   182c16cfe:	42 c6 84 05 e0 04 00 	mov    BYTE PTR [rbp+r8*1+0x4e0],0x0
   182c16d05:	00 00
   182c16d07:	49 83 f8 0a          	cmp    r8,0xa
   182c16d0b:	7c 3f                	jl     0x182c16d4c
   182c16d0d:	49 8d 0c 28          	lea    rcx,[r8+rbp*1]
   182c16d11:	48 81 c1 e0 04 00 00 	add    rcx,0x4e0
   182c16d18:	48 ff c9             	dec    rcx
   182c16d1b:	48 8d 95 e9 04 00 00 	lea    rdx,[rbp+0x4e9]
   182c16d22:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   182c16d29:	1f 84 00 00 00 00 00
   182c16d30:	44 0f b6 01          	movzx  r8d,BYTE PTR [rcx]
   182c16d34:	44 0f b6 4a ff       	movzx  r9d,BYTE PTR [rdx-0x1]
   182c16d39:	44 88 09             	mov    BYTE PTR [rcx],r9b
   182c16d3c:	44 88 42 ff          	mov    BYTE PTR [rdx-0x1],r8b
   182c16d40:	48 ff c9             	dec    rcx
   182c16d43:	48 39 ca             	cmp    rdx,rcx
   182c16d46:	48 8d 52 01          	lea    rdx,[rdx+0x1]
   182c16d4a:	72 e4                	jb     0x182c16d30
   182c16d4c:	48 89 85 e0 04 00 00 	mov    QWORD PTR [rbp+0x4e0],rax
   182c16d53:	49 83 7a 18 10       	cmp    QWORD PTR [r10+0x18],0x10
   182c16d58:	72 03                	jb     0x182c16d5d
   182c16d5a:	4d 8b 12             	mov    r10,QWORD PTR [r10]
   182c16d5d:	4c 89 95 d0 02 00 00 	mov    QWORD PTR [rbp+0x2d0],r10
   182c16d64:	c6 85 d8 02 00 00 00 	mov    BYTE PTR [rbp+0x2d8],0x0
   182c16d6b:	0f 57 c0             	xorps  xmm0,xmm0
   182c16d6e:	0f 11 85 c0 04 00 00 	movups XMMWORD PTR [rbp+0x4c0],xmm0
   182c16d75:	0f 11 85 b0 04 00 00 	movups XMMWORD PTR [rbp+0x4b0],xmm0
   182c16d7c:	0f 11 85 a0 04 00 00 	movups XMMWORD PTR [rbp+0x4a0],xmm0
   182c16d83:	0f 11 85 90 04 00 00 	movups XMMWORD PTR [rbp+0x490],xmm0
   182c16d8a:	0f 11 85 80 04 00 00 	movups XMMWORD PTR [rbp+0x480],xmm0
   182c16d91:	0f 11 85 70 04 00 00 	movups XMMWORD PTR [rbp+0x470],xmm0
   182c16d98:	0f 11 85 60 04 00 00 	movups XMMWORD PTR [rbp+0x460],xmm0
   182c16d9f:	48 8d 85 d0 02 00 00 	lea    rax,[rbp+0x2d0]
   182c16da6:	48 89 85 50 04 00 00 	mov    QWORD PTR [rbp+0x450],rax
   182c16dad:	48 8d 85 e0 04 00 00 	lea    rax,[rbp+0x4e0]
   182c16db4:	48 89 85 58 04 00 00 	mov    QWORD PTR [rbp+0x458],rax
   182c16dbb:	48 8d 15 3e 73 95 06 	lea    rdx,[rip+0x695733e]        # 0x18956e100
   182c16dc2:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c16dc6:	4c 8d 85 50 04 00 00 	lea    r8,[rbp+0x450]
   182c16dcd:	e8 3e 6a 45 fd       	call   0x18006d810
   182c16dd2:	90                   	nop
   182c16dd3:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c16dd7:	e8 94 65 45 fd       	call   0x18006d370
   182c16ddc:	48 8b 85 58 03 00 00 	mov    rax,QWORD PTR [rbp+0x358]
   182c16de3:	48 83 f8 10          	cmp    rax,0x10
   182c16de7:	4c 8b a5 40 05 00 00 	mov    r12,QWORD PTR [rbp+0x540]
   182c16dee:	72 38                	jb     0x182c16e28
   182c16df0:	48 8b 8d 40 03 00 00 	mov    rcx,QWORD PTR [rbp+0x340]
   182c16df7:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c16dfb:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c16e02:	72 1f                	jb     0x182c16e23
   182c16e04:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c16e08:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c16e0c:	4c 29 c1             	sub    rcx,r8
   182c16e0f:	48 83 f9 20          	cmp    rcx,0x20
   182c16e13:	0f 83 4d 06 00 00    	jae    0x182c17466
   182c16e19:	48 83 c0 28          	add    rax,0x28
   182c16e1d:	48 89 c2             	mov    rdx,rax
   182c16e20:	4c 89 c1             	mov    rcx,r8
   182c16e23:	e8 f8 4e 93 04       	call   0x18754bd20
   182c16e28:	80 bd f0 03 00 00 01 	cmp    BYTE PTR [rbp+0x3f0],0x1
   182c16e2f:	0f 85 5c 03 00 00    	jne    0x182c17191
   182c16e35:	48 8b 85 e8 03 00 00 	mov    rax,QWORD PTR [rbp+0x3e8]
   182c16e3c:	48 83 f8 10          	cmp    rax,0x10
   182c16e40:	72 38                	jb     0x182c16e7a
   182c16e42:	48 8b 8d d0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3d0]
   182c16e49:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c16e4d:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c16e54:	72 1f                	jb     0x182c16e75
   182c16e56:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c16e5a:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c16e5e:	4c 29 c1             	sub    rcx,r8
   182c16e61:	48 83 f9 20          	cmp    rcx,0x20
   182c16e65:	0f 83 fb 05 00 00    	jae    0x182c17466
   182c16e6b:	48 83 c0 28          	add    rax,0x28
   182c16e6f:	48 89 c2             	mov    rdx,rax
   182c16e72:	4c 89 c1             	mov    rcx,r8
   182c16e75:	e8 a6 4e 93 04       	call   0x18754bd20
   182c16e7a:	48 8b 85 b8 03 00 00 	mov    rax,QWORD PTR [rbp+0x3b8]
   182c16e81:	48 83 f8 10          	cmp    rax,0x10
   182c16e85:	0f 82 06 03 00 00    	jb     0x182c17191
   182c16e8b:	48 8b 8d a0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3a0]
   182c16e92:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c16e96:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c16e9d:	0f 83 ca 02 00 00    	jae    0x182c1716d
   182c16ea3:	e9 e4 02 00 00       	jmp    0x182c1718c
   182c16ea8:	49 8d 48 20          	lea    rcx,[r8+0x20]
   182c16eac:	48 89 8d 60 04 00 00 	mov    QWORD PTR [rbp+0x460],rcx
   182c16eb3:	48 83 f8 10          	cmp    rax,0x10
   182c16eb7:	48 8b 8d 50 04 00 00 	mov    rcx,QWORD PTR [rbp+0x450]
   182c16ebe:	48 89 f7             	mov    rdi,rsi
   182c16ec1:	48 0f 43 f9          	cmovae rdi,rcx
   182c16ec5:	48 8d 15 a4 ac 94 06 	lea    rdx,[rip+0x694aca4]        # 0x189561b70
   182c16ecc:	48 39 d7             	cmp    rdi,rdx
   182c16ecf:	0f 93 c2             	setae  dl
   182c16ed2:	48 8d 1d 77 ac 94 06 	lea    rbx,[rip+0x694ac77]        # 0x189561b50
   182c16ed9:	4e 8d 0c 07          	lea    r9,[rdi+r8*1]
   182c16edd:	49 39 d9             	cmp    r9,rbx
   182c16ee0:	41 0f 92 c1          	setb   r9b
   182c16ee4:	41 08 d1             	or     r9b,dl
   182c16ee7:	41 be 20 00 00 00    	mov    r14d,0x20
   182c16eed:	41 bf 20 00 00 00    	mov    r15d,0x20
   182c16ef3:	4c 8b a5 40 05 00 00 	mov    r12,QWORD PTR [rbp+0x540]
   182c16efa:	75 0b                	jne    0x182c16f07
   182c16efc:	49 89 ff             	mov    r15,rdi
   182c16eff:	49 29 df             	sub    r15,rbx
   182c16f02:	77 03                	ja     0x182c16f07
   182c16f04:	45 31 ff             	xor    r15d,r15d
   182c16f07:	49 ff c0             	inc    r8
   182c16f0a:	48 83 f8 10          	cmp    rax,0x10
   182c16f0e:	48 0f 42 ce          	cmovb  rcx,rsi
   182c16f12:	48 83 c1 20          	add    rcx,0x20
   182c16f16:	48 89 fa             	mov    rdx,rdi
   182c16f19:	e8 22 df af 04       	call   0x187714e40
   182c16f1e:	48 89 f9             	mov    rcx,rdi
   182c16f21:	48 89 da             	mov    rdx,rbx
   182c16f24:	4d 89 f8             	mov    r8,r15
   182c16f27:	e8 14 df af 04       	call   0x187714e40
   182c16f2c:	4d 29 fe             	sub    r14,r15
   182c16f2f:	49 8d 14 1f          	lea    rdx,[r15+rbx*1]
   182c16f33:	48 83 c2 20          	add    rdx,0x20
   182c16f37:	4c 01 ff             	add    rdi,r15
   182c16f3a:	48 89 f9             	mov    rcx,rdi
   182c16f3d:	4d 89 f0             	mov    r8,r14
   182c16f40:	e8 fb de af 04       	call   0x187714e40
   182c16f45:	0f b6 1e             	movzx  ebx,BYTE PTR [rsi]
   182c16f48:	48 8b 46 08          	mov    rax,QWORD PTR [rsi+0x8]
   182c16f4c:	48 89 85 a7 03 00 00 	mov    QWORD PTR [rbp+0x3a7],rax
   182c16f53:	48 8b 46 01          	mov    rax,QWORD PTR [rsi+0x1]
   182c16f57:	48 89 85 a0 03 00 00 	mov    QWORD PTR [rbp+0x3a0],rax
   182c16f5e:	0f 10 76 10          	movups xmm6,XMMWORD PTR [rsi+0x10]
   182c16f62:	48 c7 46 10 00 00 00 	mov    QWORD PTR [rsi+0x10],0x0
   182c16f69:	00
   182c16f6a:	48 c7 46 18 0f 00 00 	mov    QWORD PTR [rsi+0x18],0xf
   182c16f71:	00
   182c16f72:	c6 06 00             	mov    BYTE PTR [rsi],0x0
   182c16f75:	49 8b 44 24 30       	mov    rax,QWORD PTR [r12+0x30]
   182c16f7a:	48 83 f8 10          	cmp    rax,0x10
   182c16f7e:	72 36                	jb     0x182c16fb6
   182c16f80:	49 8b 4c 24 18       	mov    rcx,QWORD PTR [r12+0x18]
   182c16f85:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c16f89:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c16f90:	72 1f                	jb     0x182c16fb1
   182c16f92:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c16f96:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c16f9a:	4c 29 c1             	sub    rcx,r8
   182c16f9d:	48 83 f9 20          	cmp    rcx,0x20
   182c16fa1:	0f 83 bf 04 00 00    	jae    0x182c17466
   182c16fa7:	48 83 c0 28          	add    rax,0x28
   182c16fab:	48 89 c2             	mov    rdx,rax
   182c16fae:	4c 89 c1             	mov    rcx,r8
   182c16fb1:	e8 6a 4d 93 04       	call   0x18754bd20
   182c16fb6:	41 88 5c 24 18       	mov    BYTE PTR [r12+0x18],bl
   182c16fbb:	48 8b 85 a0 03 00 00 	mov    rax,QWORD PTR [rbp+0x3a0]
   182c16fc2:	48 8b 8d a7 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3a7]
   182c16fc9:	49 89 44 24 19       	mov    QWORD PTR [r12+0x19],rax
   182c16fce:	49 89 4c 24 20       	mov    QWORD PTR [r12+0x20],rcx
   182c16fd3:	41 0f 11 74 24 28    	movups XMMWORD PTR [r12+0x28],xmm6
   182c16fd9:	48 8b 85 68 04 00 00 	mov    rax,QWORD PTR [rbp+0x468]
   182c16fe0:	48 83 f8 10          	cmp    rax,0x10
   182c16fe4:	0f 82 ca 03 00 00    	jb     0x182c173b4
   182c16fea:	48 8b 8d 50 04 00 00 	mov    rcx,QWORD PTR [rbp+0x450]
   182c16ff1:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c16ff5:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c16ffc:	72 1f                	jb     0x182c1701d
   182c16ffe:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c17002:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c17006:	4c 29 c1             	sub    rcx,r8
   182c17009:	48 83 f9 20          	cmp    rcx,0x20
   182c1700d:	0f 83 53 04 00 00    	jae    0x182c17466
   182c17013:	48 83 c0 28          	add    rax,0x28
   182c17017:	48 89 c2             	mov    rdx,rax
   182c1701a:	4c 89 c1             	mov    rcx,r8
   182c1701d:	e8 fe 4c 93 04       	call   0x18754bd20
   182c17022:	e9 8d 03 00 00       	jmp    0x182c173b4
   182c17027:	49 8d 48 1a          	lea    rcx,[r8+0x1a]
   182c1702b:	48 89 4d d0          	mov    QWORD PTR [rbp-0x30],rcx
   182c1702f:	48 83 f8 10          	cmp    rax,0x10
   182c17033:	48 8b 4d c0          	mov    rcx,QWORD PTR [rbp-0x40]
   182c17037:	48 89 f7             	mov    rdi,rsi
   182c1703a:	48 0f 43 f9          	cmovae rdi,rcx
   182c1703e:	48 8d 15 75 ab 94 06 	lea    rdx,[rip+0x694ab75]        # 0x189561bba
   182c17045:	48 39 d7             	cmp    rdi,rdx
   182c17048:	0f 93 c2             	setae  dl
   182c1704b:	48 8d 1d 4e ab 94 06 	lea    rbx,[rip+0x694ab4e]        # 0x189561ba0
   182c17052:	4e 8d 0c 07          	lea    r9,[rdi+r8*1]
   182c17056:	49 39 d9             	cmp    r9,rbx
   182c17059:	41 0f 92 c1          	setb   r9b
   182c1705d:	41 08 d1             	or     r9b,dl
   182c17060:	41 be 1a 00 00 00    	mov    r14d,0x1a
   182c17066:	41 bf 1a 00 00 00    	mov    r15d,0x1a
   182c1706c:	4c 8b a5 40 05 00 00 	mov    r12,QWORD PTR [rbp+0x540]
   182c17073:	75 0b                	jne    0x182c17080
   182c17075:	49 89 ff             	mov    r15,rdi
   182c17078:	49 29 df             	sub    r15,rbx
   182c1707b:	77 03                	ja     0x182c17080
   182c1707d:	45 31 ff             	xor    r15d,r15d
   182c17080:	49 ff c0             	inc    r8
   182c17083:	48 83 f8 10          	cmp    rax,0x10
   182c17087:	48 0f 42 ce          	cmovb  rcx,rsi
   182c1708b:	48 83 c1 1a          	add    rcx,0x1a
   182c1708f:	48 89 fa             	mov    rdx,rdi
   182c17092:	e8 a9 dd af 04       	call   0x187714e40
   182c17097:	48 89 f9             	mov    rcx,rdi
   182c1709a:	48 89 da             	mov    rdx,rbx
   182c1709d:	4d 89 f8             	mov    r8,r15
   182c170a0:	e8 9b dd af 04       	call   0x187714e40
   182c170a5:	4d 29 fe             	sub    r14,r15
   182c170a8:	49 8d 14 1f          	lea    rdx,[r15+rbx*1]
   182c170ac:	48 83 c2 1a          	add    rdx,0x1a
   182c170b0:	4c 01 ff             	add    rdi,r15
   182c170b3:	48 89 f9             	mov    rcx,rdi
   182c170b6:	4d 89 f0             	mov    r8,r14
   182c170b9:	e8 82 dd af 04       	call   0x187714e40
   182c170be:	0f b6 1e             	movzx  ebx,BYTE PTR [rsi]
   182c170c1:	48 8b 46 08          	mov    rax,QWORD PTR [rsi+0x8]
   182c170c5:	48 89 85 57 04 00 00 	mov    QWORD PTR [rbp+0x457],rax
   182c170cc:	48 8b 46 01          	mov    rax,QWORD PTR [rsi+0x1]
   182c170d0:	48 89 85 50 04 00 00 	mov    QWORD PTR [rbp+0x450],rax
   182c170d7:	0f 10 76 10          	movups xmm6,XMMWORD PTR [rsi+0x10]
   182c170db:	48 c7 46 10 00 00 00 	mov    QWORD PTR [rsi+0x10],0x0
   182c170e2:	00
   182c170e3:	48 c7 46 18 0f 00 00 	mov    QWORD PTR [rsi+0x18],0xf
   182c170ea:	00
   182c170eb:	c6 06 00             	mov    BYTE PTR [rsi],0x0
   182c170ee:	49 8b 44 24 30       	mov    rax,QWORD PTR [r12+0x30]
   182c170f3:	48 83 f8 10          	cmp    rax,0x10
   182c170f7:	72 36                	jb     0x182c1712f
   182c170f9:	49 8b 4c 24 18       	mov    rcx,QWORD PTR [r12+0x18]
   182c170fe:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c17102:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c17109:	72 1f                	jb     0x182c1712a
   182c1710b:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c1710f:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c17113:	4c 29 c1             	sub    rcx,r8
   182c17116:	48 83 f9 20          	cmp    rcx,0x20
   182c1711a:	0f 83 46 03 00 00    	jae    0x182c17466
   182c17120:	48 83 c0 28          	add    rax,0x28
   182c17124:	48 89 c2             	mov    rdx,rax
   182c17127:	4c 89 c1             	mov    rcx,r8
   182c1712a:	e8 f1 4b 93 04       	call   0x18754bd20
   182c1712f:	41 88 5c 24 18       	mov    BYTE PTR [r12+0x18],bl
   182c17134:	48 8b 85 50 04 00 00 	mov    rax,QWORD PTR [rbp+0x450]
   182c1713b:	48 8b 8d 57 04 00 00 	mov    rcx,QWORD PTR [rbp+0x457]
   182c17142:	49 89 44 24 19       	mov    QWORD PTR [r12+0x19],rax
   182c17147:	49 89 4c 24 20       	mov    QWORD PTR [r12+0x20],rcx
   182c1714c:	41 0f 11 74 24 28    	movups XMMWORD PTR [r12+0x28],xmm6
   182c17152:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
   182c17156:	48 83 f8 10          	cmp    rax,0x10
   182c1715a:	72 35                	jb     0x182c17191
   182c1715c:	48 8b 4d c0          	mov    rcx,QWORD PTR [rbp-0x40]
   182c17160:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c17164:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c1716b:	72 1f                	jb     0x182c1718c
   182c1716d:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c17171:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c17175:	4c 29 c1             	sub    rcx,r8
   182c17178:	48 83 f9 20          	cmp    rcx,0x20
   182c1717c:	0f 83 e4 02 00 00    	jae    0x182c17466
   182c17182:	48 83 c0 28          	add    rax,0x28
   182c17186:	48 89 c2             	mov    rdx,rax
   182c17189:	4c 89 c1             	mov    rcx,r8
   182c1718c:	e8 8f 4b 93 04       	call   0x18754bd20
   182c17191:	48 8b b5 90 03 00 00 	mov    rsi,QWORD PTR [rbp+0x390]
   182c17198:	48 85 f6             	test   rsi,rsi
   182c1719b:	74 1d                	je     0x182c171ba
   182c1719d:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182c171a1:	75 17                	jne    0x182c171ba
   182c171a3:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182c171a6:	48 89 f1             	mov    rcx,rsi
   182c171a9:	ff 10                	call   QWORD PTR [rax]
   182c171ab:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182c171af:	75 09                	jne    0x182c171ba
   182c171b1:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182c171b4:	48 89 f1             	mov    rcx,rsi
   182c171b7:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c171ba:	48 8b 85 80 03 00 00 	mov    rax,QWORD PTR [rbp+0x380]
   182c171c1:	48 83 f8 10          	cmp    rax,0x10
   182c171c5:	72 38                	jb     0x182c171ff
   182c171c7:	48 8b 8d 68 03 00 00 	mov    rcx,QWORD PTR [rbp+0x368]
   182c171ce:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c171d2:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c171d9:	72 1f                	jb     0x182c171fa
   182c171db:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c171df:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c171e3:	4c 29 c1             	sub    rcx,r8
   182c171e6:	48 83 f9 20          	cmp    rcx,0x20
   182c171ea:	0f 83 76 02 00 00    	jae    0x182c17466
   182c171f0:	48 83 c0 28          	add    rax,0x28
   182c171f4:	48 89 c2             	mov    rdx,rax
   182c171f7:	4c 89 c1             	mov    rcx,r8
   182c171fa:	e8 21 4b 93 04       	call   0x18754bd20
   182c171ff:	48 8b b5 38 05 00 00 	mov    rsi,QWORD PTR [rbp+0x538]
   182c17206:	48 85 f6             	test   rsi,rsi
   182c17209:	74 1d                	je     0x182c17228
   182c1720b:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182c1720f:	75 17                	jne    0x182c17228
   182c17211:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182c17214:	48 89 f1             	mov    rcx,rsi
   182c17217:	ff 10                	call   QWORD PTR [rax]
   182c17219:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182c1721d:	75 09                	jne    0x182c17228
   182c1721f:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182c17222:	48 89 f1             	mov    rcx,rsi
   182c17225:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c17228:	48 8d 8d 20 03 00 00 	lea    rcx,[rbp+0x320]
   182c1722f:	e8 2c 08 3f fd       	call   0x180007a60
   182c17234:	48 8b 85 48 04 00 00 	mov    rax,QWORD PTR [rbp+0x448]
   182c1723b:	48 83 f8 10          	cmp    rax,0x10
   182c1723f:	0f 83 cf 01 00 00    	jae    0x182c17414
   182c17245:	e9 fe 01 00 00       	jmp    0x182c17448
   182c1724a:	b9 04 00 00 00       	mov    ecx,0x4
   182c1724f:	e8 8c 5b 45 fd       	call   0x18006cde0
   182c17254:	85 c0                	test   eax,eax
   182c17256:	0f 84 06 01 00 00    	je     0x182c17362
   182c1725c:	48 8d b5 e0 04 00 00 	lea    rsi,[rbp+0x4e0]
   182c17263:	48 89 f1             	mov    rcx,rsi
   182c17266:	e8 a5 5c 45 fd       	call   0x18006cf10
   182c1726b:	90                   	nop
   182c1726c:	48 83 bd f8 04 00 00 	cmp    QWORD PTR [rbp+0x4f8],0x10
   182c17273:	10
   182c17274:	72 07                	jb     0x182c1727d
   182c17276:	48 8b b5 e0 04 00 00 	mov    rsi,QWORD PTR [rbp+0x4e0]
   182c1727d:	48 8d 05 0c 69 95 06 	lea    rax,[rip+0x695690c]        # 0x18956db90
   182c17284:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182c17289:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182c17290:	00 00
   182c17292:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182c17297:	c7 44 24 28 57 0a 00 	mov    DWORD PTR [rsp+0x28],0xa57
   182c1729e:	00
   182c1729f:	4c 8d 0d c2 22 95 06 	lea    r9,[rip+0x69522c2]        # 0x189569568
   182c172a6:	48 8d 8d 50 04 00 00 	lea    rcx,[rbp+0x450]
   182c172ad:	ba 04 00 00 00       	mov    edx,0x4
   182c172b2:	49 89 f0             	mov    r8,rsi
   182c172b5:	e8 b6 5f 45 fd       	call   0x18006d270
   182c172ba:	90                   	nop
   182c172bb:	0f 57 c0             	xorps  xmm0,xmm0
   182c172be:	0f 29 85 10 04 00 00 	movaps XMMWORD PTR [rbp+0x410],xmm0
   182c172c5:	0f 29 85 00 04 00 00 	movaps XMMWORD PTR [rbp+0x400],xmm0
   182c172cc:	0f 29 85 f0 03 00 00 	movaps XMMWORD PTR [rbp+0x3f0],xmm0
   182c172d3:	0f 29 85 e0 03 00 00 	movaps XMMWORD PTR [rbp+0x3e0],xmm0
   182c172da:	0f 29 85 d0 03 00 00 	movaps XMMWORD PTR [rbp+0x3d0],xmm0
   182c172e1:	0f 29 85 c0 03 00 00 	movaps XMMWORD PTR [rbp+0x3c0],xmm0
   182c172e8:	0f 29 85 b0 03 00 00 	movaps XMMWORD PTR [rbp+0x3b0],xmm0
   182c172ef:	0f 29 85 a0 03 00 00 	movaps XMMWORD PTR [rbp+0x3a0],xmm0
   182c172f6:	48 8d 15 a3 6c 95 06 	lea    rdx,[rip+0x6956ca3]        # 0x18956dfa0
   182c172fd:	48 8d 8d 50 04 00 00 	lea    rcx,[rbp+0x450]
   182c17304:	4c 8d 85 a0 03 00 00 	lea    r8,[rbp+0x3a0]
   182c1730b:	e8 00 65 45 fd       	call   0x18006d810
   182c17310:	90                   	nop
   182c17311:	48 8d 8d 50 04 00 00 	lea    rcx,[rbp+0x450]
   182c17318:	e8 53 60 45 fd       	call   0x18006d370
   182c1731d:	48 8b 85 f8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4f8]
   182c17324:	48 83 f8 10          	cmp    rax,0x10
   182c17328:	72 38                	jb     0x182c17362
   182c1732a:	48 8b 8d e0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4e0]
   182c17331:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c17335:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c1733c:	72 1f                	jb     0x182c1735d
   182c1733e:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c17342:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c17346:	4c 29 c1             	sub    rcx,r8
   182c17349:	48 83 f9 20          	cmp    rcx,0x20
   182c1734d:	0f 83 13 01 00 00    	jae    0x182c17466
   182c17353:	48 83 c0 28          	add    rax,0x28
   182c17357:	48 89 c2             	mov    rdx,rax
   182c1735a:	4c 89 c1             	mov    rcx,r8
   182c1735d:	e8 be 49 93 04       	call   0x18754bd20
   182c17362:	48 8b 8d 40 05 00 00 	mov    rcx,QWORD PTR [rbp+0x540]
   182c17369:	48 83 79 30 24       	cmp    QWORD PTR [rcx+0x30],0x24
   182c1736e:	73 18                	jae    0x182c17388
   182c17370:	48 83 c1 18          	add    rcx,0x18
   182c17374:	4c 8d 0d fd a7 94 06 	lea    r9,[rip+0x694a7fd]        # 0x189561b78
   182c1737b:	ba 24 00 00 00       	mov    edx,0x24
   182c17380:	e8 cb 6d 42 fd       	call   0x18003e150
   182c17385:	90                   	nop
   182c17386:	eb 2c                	jmp    0x182c173b4
   182c17388:	48 8b 41 18          	mov    rax,QWORD PTR [rcx+0x18]
   182c1738c:	48 c7 41 28 24 00 00 	mov    QWORD PTR [rcx+0x28],0x24
   182c17393:	00
   182c17394:	0f 10 05 ed a7 94 06 	movups xmm0,XMMWORD PTR [rip+0x694a7ed]        # 0x189561b88
   182c1739b:	0f 11 40 10          	movups XMMWORD PTR [rax+0x10],xmm0
   182c1739f:	0f 10 05 d2 a7 94 06 	movups xmm0,XMMWORD PTR [rip+0x694a7d2]        # 0x189561b78
   182c173a6:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   182c173a9:	c7 40 20 98 e5 9c a8 	mov    DWORD PTR [rax+0x20],0xa89ce598
   182c173b0:	c6 40 24 00          	mov    BYTE PTR [rax+0x24],0x0
   182c173b4:	48 8d 05 5d 72 3b 06 	lea    rax,[rip+0x63b725d]        # 0x188fce618
   182c173bb:	48 89 85 d0 02 00 00 	mov    QWORD PTR [rbp+0x2d0],rax
   182c173c2:	48 8b b5 e8 02 00 00 	mov    rsi,QWORD PTR [rbp+0x2e8]
   182c173c9:	48 85 f6             	test   rsi,rsi
   182c173cc:	74 1d                	je     0x182c173eb
   182c173ce:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182c173d2:	75 17                	jne    0x182c173eb
   182c173d4:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182c173d7:	48 89 f1             	mov    rcx,rsi
   182c173da:	ff 10                	call   QWORD PTR [rax]
   182c173dc:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182c173e0:	75 09                	jne    0x182c173eb
   182c173e2:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182c173e5:	48 89 f1             	mov    rcx,rsi
   182c173e8:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c173eb:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c173ef:	e8 6c 0b 00 00       	call   0x182c17f60
   182c173f4:	48 8d 8d 20 03 00 00 	lea    rcx,[rbp+0x320]
   182c173fb:	e8 60 06 3f fd       	call   0x180007a60
   182c17400:	48 8b 85 48 04 00 00 	mov    rax,QWORD PTR [rbp+0x448]
   182c17407:	48 83 f8 10          	cmp    rax,0x10
   182c1740b:	4c 8b a5 40 05 00 00 	mov    r12,QWORD PTR [rbp+0x540]
   182c17412:	72 34                	jb     0x182c17448
   182c17414:	48 8b 8d 30 04 00 00 	mov    rcx,QWORD PTR [rbp+0x430]
   182c1741b:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c1741f:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c17426:	72 1b                	jb     0x182c17443
   182c17428:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c1742c:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c17430:	4c 29 c1             	sub    rcx,r8
   182c17433:	48 83 f9 20          	cmp    rcx,0x20
   182c17437:	73 2d                	jae    0x182c17466
   182c17439:	48 83 c0 28          	add    rax,0x28
   182c1743d:	48 89 c2             	mov    rdx,rax
   182c17440:	4c 89 c1             	mov    rcx,r8
   182c17443:	e8 d8 48 93 04       	call   0x18754bd20
   182c17448:	4c 89 e0             	mov    rax,r12
   182c1744b:	0f 28 b5 50 05 00 00 	movaps xmm6,XMMWORD PTR [rbp+0x550]
   182c17452:	48 81 c4 e8 05 00 00 	add    rsp,0x5e8
   182c17459:	5b                   	pop    rbx
   182c1745a:	5f                   	pop    rdi
   182c1745b:	5e                   	pop    rsi
   182c1745c:	41 5c                	pop    r12
   182c1745e:	41 5d                	pop    r13
   182c17460:	41 5e                	pop    r14
   182c17462:	41 5f                	pop    r15
   182c17464:	5d                   	pop    rbp
   182c17465:	c3                   	ret
   182c17466:	e8 21 6d ac 04       	call   0x1876de18c
   182c1746b:	90                   	nop
   182c1746c:	e8 1f 17 3f fd       	call   0x180008b90
   182c17471:	90                   	nop
   182c17472:	cc                   	int3
