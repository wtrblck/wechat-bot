
E:/Tencent/Weixin/4.1.15.56/Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001855ead40 <.text+0x55e9d40>:
   1855ead40:	55                   	push   rbp
   1855ead41:	41 57                	push   r15
   1855ead43:	41 56                	push   r14
   1855ead45:	41 54                	push   r12
   1855ead47:	56                   	push   rsi
   1855ead48:	57                   	push   rdi
   1855ead49:	53                   	push   rbx
   1855ead4a:	48 81 ec a0 05 00 00 	sub    rsp,0x5a0
   1855ead51:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   1855ead58:	00
   1855ead59:	0f 29 b5 10 05 00 00 	movaps XMMWORD PTR [rbp+0x510],xmm6
   1855ead60:	48 c7 85 08 05 00 00 	mov    QWORD PTR [rbp+0x508],0xfffffffffffffffe
   1855ead67:	fe ff ff ff
   1855ead6b:	48 89 ce             	mov    rsi,rcx
   1855ead6e:	0f 28 35 3b be 92 03 	movaps xmm6,XMMWORD PTR [rip+0x392be3b]        # 0x188f16bb0
   1855ead75:	0f 29 b5 a0 04 00 00 	movaps XMMWORD PTR [rbp+0x4a0],xmm6
   1855ead7c:	48 8d 8d c0 03 00 00 	lea    rcx,[rbp+0x3c0]
   1855ead83:	e8 98 c4 a5 fa       	call   0x180047220
   1855ead88:	48 8b 8d c0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3c0]
   1855ead8f:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   1855ead93:	e8 38 76 d9 fa       	call   0x1803823d0
   1855ead98:	90                   	nop
   1855ead99:	48 8b 4d c0          	mov    rcx,QWORD PTR [rbp-0x40]
   1855ead9d:	48 8d 95 a0 04 00 00 	lea    rdx,[rbp+0x4a0]
   1855eada4:	e8 d7 e4 11 fb       	call   0x180709280
   1855eada9:	90                   	nop
   1855eadaa:	48 8b 7d c8          	mov    rdi,QWORD PTR [rbp-0x38]
   1855eadae:	48 85 ff             	test   rdi,rdi
   1855eadb1:	74 1d                	je     0x1855eadd0
   1855eadb3:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1855eadb7:	75 17                	jne    0x1855eadd0
   1855eadb9:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855eadbc:	48 89 f9             	mov    rcx,rdi
   1855eadbf:	ff 10                	call   QWORD PTR [rax]
   1855eadc1:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1855eadc5:	75 09                	jne    0x1855eadd0
   1855eadc7:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855eadca:	48 89 f9             	mov    rcx,rdi
   1855eadcd:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855eadd0:	48 8b bd c8 03 00 00 	mov    rdi,QWORD PTR [rbp+0x3c8]
   1855eadd7:	48 85 ff             	test   rdi,rdi
   1855eadda:	74 1d                	je     0x1855eadf9
   1855eaddc:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1855eade0:	75 17                	jne    0x1855eadf9
   1855eade2:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855eade5:	48 89 f9             	mov    rcx,rdi
   1855eade8:	ff 10                	call   QWORD PTR [rax]
   1855eadea:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1855eadee:	75 09                	jne    0x1855eadf9
   1855eadf0:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855eadf3:	48 89 f9             	mov    rcx,rdi
   1855eadf6:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855eadf9:	48 8b 8d a0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4a0]
   1855eae00:	48 85 c9             	test   rcx,rcx
   1855eae03:	74 4a                	je     0x1855eae4f
   1855eae05:	48 bf aa aa aa aa aa 	movabs rdi,0xaaaaaaaaaaaaaaaa
   1855eae0c:	aa aa aa
   1855eae0f:	48 89 bd a0 03 00 00 	mov    QWORD PTR [rbp+0x3a0],rdi
   1855eae16:	0f 29 b5 90 03 00 00 	movaps XMMWORD PTR [rbp+0x390],xmm6
   1855eae1d:	0f 29 b5 80 03 00 00 	movaps XMMWORD PTR [rbp+0x380],xmm6
   1855eae24:	0f 29 b5 70 03 00 00 	movaps XMMWORD PTR [rbp+0x370],xmm6
   1855eae2b:	0f 57 c0             	xorps  xmm0,xmm0
   1855eae2e:	0f 29 85 b0 03 00 00 	movaps XMMWORD PTR [rbp+0x3b0],xmm0
   1855eae35:	48 8b 46 40          	mov    rax,QWORD PTR [rsi+0x40]
   1855eae39:	48 85 c0             	test   rax,rax
   1855eae3c:	0f 84 e4 00 00 00    	je     0x1855eaf26
   1855eae42:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1855eae46:	48 8b 46 40          	mov    rax,QWORD PTR [rsi+0x40]
   1855eae4a:	e9 d9 00 00 00       	jmp    0x1855eaf28
   1855eae4f:	48 8b 76 08          	mov    rsi,QWORD PTR [rsi+0x8]
   1855eae53:	0f 57 c0             	xorps  xmm0,xmm0
   1855eae56:	0f 29 85 d0 03 00 00 	movaps XMMWORD PTR [rbp+0x3d0],xmm0
   1855eae5d:	0f 29 85 c0 03 00 00 	movaps XMMWORD PTR [rbp+0x3c0],xmm0
   1855eae64:	b9 40 00 00 00       	mov    ecx,0x40
   1855eae69:	e8 6e 0e f6 01       	call   0x18754bcdc
   1855eae6e:	90                   	nop
   1855eae6f:	48 89 85 c0 03 00 00 	mov    QWORD PTR [rbp+0x3c0],rax
   1855eae76:	48 c7 85 d0 03 00 00 	mov    QWORD PTR [rbp+0x3d0],0x32
   1855eae7d:	32 00 00 00
   1855eae81:	48 c7 85 d8 03 00 00 	mov    QWORD PTR [rbp+0x3d8],0x3f
   1855eae88:	3f 00 00 00
   1855eae8c:	0f 10 05 25 8b 41 04 	movups xmm0,XMMWORD PTR [rip+0x4418b25]        # 0x189a039b8
   1855eae93:	0f 11 40 20          	movups XMMWORD PTR [rax+0x20],xmm0
   1855eae97:	0f 10 05 0a 8b 41 04 	movups xmm0,XMMWORD PTR [rip+0x4418b0a]        # 0x189a039a8
   1855eae9e:	0f 11 40 10          	movups XMMWORD PTR [rax+0x10],xmm0
   1855eaea2:	0f 10 05 ef 8a 41 04 	movups xmm0,XMMWORD PTR [rip+0x4418aef]        # 0x189a03998
   1855eaea9:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   1855eaeac:	66 c7 40 30 6c 65    	mov    WORD PTR [rax+0x30],0x656c
   1855eaeb2:	c6 40 32 00          	mov    BYTE PTR [rax+0x32],0x0
   1855eaeb6:	0f 29 75 d0          	movaps XMMWORD PTR [rbp-0x30],xmm6
   1855eaeba:	0f 29 75 e0          	movaps XMMWORD PTR [rbp-0x20],xmm6
   1855eaebe:	0f 29 75 00          	movaps XMMWORD PTR [rbp+0x0],xmm6
   1855eaec2:	0f 29 75 c0          	movaps XMMWORD PTR [rbp-0x40],xmm6
   1855eaec6:	0f 29 75 f0          	movaps XMMWORD PTR [rbp-0x10],xmm6
   1855eaeca:	c6 45 d0 00          	mov    BYTE PTR [rbp-0x30],0x0
   1855eaece:	c6 45 e0 00          	mov    BYTE PTR [rbp-0x20],0x0
   1855eaed2:	c6 45 08 00          	mov    BYTE PTR [rbp+0x8],0x0
   1855eaed6:	c6 45 c0 00          	mov    BYTE PTR [rbp-0x40],0x0
   1855eaeda:	48 8d 4d e8          	lea    rcx,[rbp-0x18]
   1855eaede:	48 8d 95 c0 03 00 00 	lea    rdx,[rbp+0x3c0]
   1855eaee5:	e8 06 a1 3a fc       	call   0x181994ff0
   1855eaeea:	90                   	nop
   1855eaeeb:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   1855eaeef:	48 89 f1             	mov    rcx,rsi
   1855eaef2:	e8 39 79 ff ff       	call   0x1855e2830
   1855eaef7:	90                   	nop
   1855eaef8:	48 8b 85 d8 03 00 00 	mov    rax,QWORD PTR [rbp+0x3d8]
   1855eaeff:	48 83 f8 10          	cmp    rax,0x10
   1855eaf03:	0f 82 6c 08 00 00    	jb     0x1855eb775
   1855eaf09:	48 8b 8d c0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3c0]
   1855eaf10:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855eaf14:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855eaf1b:	0f 83 34 08 00 00    	jae    0x1855eb755
   1855eaf21:	e9 4a 08 00 00       	jmp    0x1855eb770
   1855eaf26:	31 c0                	xor    eax,eax
   1855eaf28:	48 8b 56 38          	mov    rdx,QWORD PTR [rsi+0x38]
   1855eaf2c:	48 89 95 b0 03 00 00 	mov    QWORD PTR [rbp+0x3b0],rdx
   1855eaf33:	48 89 85 b8 03 00 00 	mov    QWORD PTR [rbp+0x3b8],rax
   1855eaf3a:	48 8d 95 70 03 00 00 	lea    rdx,[rbp+0x370]
   1855eaf41:	4c 8d 85 b0 03 00 00 	lea    r8,[rbp+0x3b0]
   1855eaf48:	e8 13 8c 1b fc       	call   0x1817a3b60
   1855eaf4d:	90                   	nop
   1855eaf4e:	8b 85 74 03 00 00    	mov    eax,DWORD PTR [rbp+0x374]
   1855eaf54:	0b 85 70 03 00 00    	or     eax,DWORD PTR [rbp+0x370]
   1855eaf5a:	0f 84 b8 00 00 00    	je     0x1855eb018
   1855eaf60:	b9 04 00 00 00       	mov    ecx,0x4
   1855eaf65:	e8 76 1e a8 fa       	call   0x18006cde0
   1855eaf6a:	85 c0                	test   eax,eax
   1855eaf6c:	0f 84 a8 05 00 00    	je     0x1855eb51a
   1855eaf72:	48 8d bd b0 02 00 00 	lea    rdi,[rbp+0x2b0]
   1855eaf79:	48 89 f9             	mov    rcx,rdi
   1855eaf7c:	e8 8f 1f a8 fa       	call   0x18006cf10
   1855eaf81:	90                   	nop
   1855eaf82:	48 83 bd c8 02 00 00 	cmp    QWORD PTR [rbp+0x2c8],0x10
   1855eaf89:	10
   1855eaf8a:	72 07                	jb     0x1855eaf93
   1855eaf8c:	48 8b bd b0 02 00 00 	mov    rdi,QWORD PTR [rbp+0x2b0]
   1855eaf93:	48 8d 05 b6 ba 41 04 	lea    rax,[rip+0x441bab6]        # 0x189a06a50
   1855eaf9a:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855eaf9f:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855eafa6:	00 00
   1855eafa8:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855eafad:	c7 44 24 28 ad 03 00 	mov    DWORD PTR [rsp+0x28],0x3ad
   1855eafb4:	00
   1855eafb5:	4c 8d 0d 04 a3 41 04 	lea    r9,[rip+0x441a304]        # 0x189a052c0
   1855eafbc:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1855eafc0:	ba 04 00 00 00       	mov    edx,0x4
   1855eafc5:	49 89 f8             	mov    r8,rdi
   1855eafc8:	e8 a3 22 a8 fa       	call   0x18006d270
   1855eafcd:	90                   	nop
   1855eafce:	48 8d 8d 70 03 00 00 	lea    rcx,[rbp+0x370]
   1855eafd5:	48 8d bd 00 03 00 00 	lea    rdi,[rbp+0x300]
   1855eafdc:	48 89 fa             	mov    rdx,rdi
   1855eafdf:	e8 7c 5c b2 fa       	call   0x180110c60
   1855eafe4:	90                   	nop
   1855eafe5:	48 83 bd 18 03 00 00 	cmp    QWORD PTR [rbp+0x318],0x10
   1855eafec:	10
   1855eafed:	72 07                	jb     0x1855eaff6
   1855eafef:	48 8b bd 00 03 00 00 	mov    rdi,QWORD PTR [rbp+0x300]
   1855eaff6:	48 89 bd 40 04 00 00 	mov    QWORD PTR [rbp+0x440],rdi
   1855eaffd:	c6 85 48 04 00 00 00 	mov    BYTE PTR [rbp+0x448],0x0
   1855eb004:	48 83 7e 30 10       	cmp    QWORD PTR [rsi+0x30],0x10
   1855eb009:	0f 82 fe 03 00 00    	jb     0x1855eb40d
   1855eb00f:	48 8b 46 18          	mov    rax,QWORD PTR [rsi+0x18]
   1855eb013:	e9 f9 03 00 00       	jmp    0x1855eb411
   1855eb018:	0f 29 b5 c0 04 00 00 	movaps XMMWORD PTR [rbp+0x4c0],xmm6
   1855eb01f:	0f 29 b5 d0 04 00 00 	movaps XMMWORD PTR [rbp+0x4d0],xmm6
   1855eb026:	0f 29 b5 f0 04 00 00 	movaps XMMWORD PTR [rbp+0x4f0],xmm6
   1855eb02d:	0f 29 b5 b0 04 00 00 	movaps XMMWORD PTR [rbp+0x4b0],xmm6
   1855eb034:	0f 29 b5 e0 04 00 00 	movaps XMMWORD PTR [rbp+0x4e0],xmm6
   1855eb03b:	c6 85 c0 04 00 00 00 	mov    BYTE PTR [rbp+0x4c0],0x0
   1855eb042:	c6 85 d0 04 00 00 00 	mov    BYTE PTR [rbp+0x4d0],0x0
   1855eb049:	c6 85 f8 04 00 00 00 	mov    BYTE PTR [rbp+0x4f8],0x0
   1855eb050:	c6 85 b0 04 00 00 01 	mov    BYTE PTR [rbp+0x4b0],0x1
   1855eb057:	48 89 bd 90 04 00 00 	mov    QWORD PTR [rbp+0x490],rdi
   1855eb05e:	0f 29 b5 80 04 00 00 	movaps XMMWORD PTR [rbp+0x480],xmm6
   1855eb065:	0f 29 b5 70 04 00 00 	movaps XMMWORD PTR [rbp+0x470],xmm6
   1855eb06c:	0f 29 b5 60 04 00 00 	movaps XMMWORD PTR [rbp+0x460],xmm6
   1855eb073:	0f 29 b5 50 04 00 00 	movaps XMMWORD PTR [rbp+0x450],xmm6
   1855eb07a:	0f 29 b5 40 04 00 00 	movaps XMMWORD PTR [rbp+0x440],xmm6
   1855eb081:	48 8b 95 98 03 00 00 	mov    rdx,QWORD PTR [rbp+0x398]
   1855eb088:	c6 85 90 04 00 00 00 	mov    BYTE PTR [rbp+0x490],0x0
   1855eb08f:	80 7a 50 01          	cmp    BYTE PTR [rdx+0x50],0x1
   1855eb093:	0f 85 87 00 00 00    	jne    0x1855eb120
   1855eb099:	48 8d 8d 40 04 00 00 	lea    rcx,[rbp+0x440]
   1855eb0a0:	e8 2b 27 19 fb       	call   0x18077d7d0
   1855eb0a5:	90                   	nop
   1855eb0a6:	c6 85 90 04 00 00 01 	mov    BYTE PTR [rbp+0x490],0x1
   1855eb0ad:	8b 9d 60 04 00 00    	mov    ebx,DWORD PTR [rbp+0x460]
   1855eb0b3:	48 89 9d c8 04 00 00 	mov    QWORD PTR [rbp+0x4c8],rbx
   1855eb0ba:	c6 85 d0 04 00 00 01 	mov    BYTE PTR [rbp+0x4d0],0x1
   1855eb0c1:	48 8d 15 f0 80 ab 03 	lea    rdx,[rip+0x3ab80f0]        # 0x1890a31b8
   1855eb0c8:	48 8d 7d c0          	lea    rdi,[rbp-0x40]
   1855eb0cc:	41 b8 f0 02 00 00    	mov    r8d,0x2f0
   1855eb0d2:	48 89 f9             	mov    rcx,rdi
   1855eb0d5:	e8 66 9d 12 02       	call   0x187714e40
   1855eb0da:	48 8b 8d a0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4a0]
   1855eb0e1:	44 8b 8d 64 04 00 00 	mov    r9d,DWORD PTR [rbp+0x464]
   1855eb0e8:	4c 8d 46 48          	lea    r8,[rsi+0x48]
   1855eb0ec:	89 5c 24 20          	mov    DWORD PTR [rsp+0x20],ebx
   1855eb0f0:	48 89 fa             	mov    rdx,rdi
   1855eb0f3:	e8 98 ea 1c fc       	call   0x1817b9b90
   1855eb0f8:	90                   	nop
   1855eb0f9:	80 bd a8 02 00 00 01 	cmp    BYTE PTR [rbp+0x2a8],0x1
   1855eb100:	75 1e                	jne    0x1855eb120
   1855eb102:	48 8b 85 08 01 00 00 	mov    rax,QWORD PTR [rbp+0x108]
   1855eb109:	48 89 85 b8 04 00 00 	mov    QWORD PTR [rbp+0x4b8],rax
   1855eb110:	c6 85 c0 04 00 00 01 	mov    BYTE PTR [rbp+0x4c0],0x1
   1855eb117:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1855eb11b:	e8 20 15 be fa       	call   0x1801cc640
   1855eb120:	b9 02 00 00 00       	mov    ecx,0x2
   1855eb125:	e8 b6 1c a8 fa       	call   0x18006cde0
   1855eb12a:	85 c0                	test   eax,eax
   1855eb12c:	0f 84 82 00 00 00    	je     0x1855eb1b4
   1855eb132:	48 8d bd 50 03 00 00 	lea    rdi,[rbp+0x350]
   1855eb139:	48 89 f9             	mov    rcx,rdi
   1855eb13c:	e8 cf 1d a8 fa       	call   0x18006cf10
   1855eb141:	90                   	nop
   1855eb142:	48 83 bd 68 03 00 00 	cmp    QWORD PTR [rbp+0x368],0x10
   1855eb149:	10
   1855eb14a:	72 07                	jb     0x1855eb153
   1855eb14c:	48 8b bd 50 03 00 00 	mov    rdi,QWORD PTR [rbp+0x350]
   1855eb153:	48 8d 05 f6 b8 41 04 	lea    rax,[rip+0x441b8f6]        # 0x189a06a50
   1855eb15a:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855eb15f:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855eb166:	00 00
   1855eb168:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855eb16d:	c7 44 24 28 ba 03 00 	mov    DWORD PTR [rsp+0x28],0x3ba
   1855eb174:	00
   1855eb175:	4c 8d 0d 44 a1 41 04 	lea    r9,[rip+0x441a144]        # 0x189a052c0
   1855eb17c:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1855eb180:	ba 02 00 00 00       	mov    edx,0x2
   1855eb185:	49 89 f8             	mov    r8,rdi
   1855eb188:	e8 e3 20 a8 fa       	call   0x18006d270
   1855eb18d:	90                   	nop
   1855eb18e:	48 83 7e 60 10       	cmp    QWORD PTR [rsi+0x60],0x10
   1855eb193:	72 4d                	jb     0x1855eb1e2
   1855eb195:	48 8b 46 48          	mov    rax,QWORD PTR [rsi+0x48]
   1855eb199:	48 89 85 b0 02 00 00 	mov    QWORD PTR [rbp+0x2b0],rax
   1855eb1a0:	c6 85 b8 02 00 00 00 	mov    BYTE PTR [rbp+0x2b8],0x0
   1855eb1a7:	48 83 7e 30 10       	cmp    QWORD PTR [rsi+0x30],0x10
   1855eb1ac:	73 4d                	jae    0x1855eb1fb
   1855eb1ae:	48 8d 46 18          	lea    rax,[rsi+0x18]
   1855eb1b2:	eb 4b                	jmp    0x1855eb1ff
   1855eb1b4:	48 8b 4e 08          	mov    rcx,QWORD PTR [rsi+0x8]
   1855eb1b8:	48 8b 85 d0 04 00 00 	mov    rax,QWORD PTR [rbp+0x4d0]
   1855eb1bf:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
   1855eb1c3:	0f 28 85 b0 04 00 00 	movaps xmm0,XMMWORD PTR [rbp+0x4b0]
   1855eb1ca:	0f 28 8d c0 04 00 00 	movaps xmm1,XMMWORD PTR [rbp+0x4c0]
   1855eb1d1:	0f 29 4d d0          	movaps XMMWORD PTR [rbp-0x30],xmm1
   1855eb1d5:	0f 29 45 c0          	movaps XMMWORD PTR [rbp-0x40],xmm0
   1855eb1d9:	c6 45 08 00          	mov    BYTE PTR [rbp+0x8],0x0
   1855eb1dd:	e9 51 01 00 00       	jmp    0x1855eb333
   1855eb1e2:	48 8d 46 48          	lea    rax,[rsi+0x48]
   1855eb1e6:	48 89 85 b0 02 00 00 	mov    QWORD PTR [rbp+0x2b0],rax
   1855eb1ed:	c6 85 b8 02 00 00 00 	mov    BYTE PTR [rbp+0x2b8],0x0
   1855eb1f4:	48 83 7e 30 10       	cmp    QWORD PTR [rsi+0x30],0x10
   1855eb1f9:	72 b3                	jb     0x1855eb1ae
   1855eb1fb:	48 8b 46 18          	mov    rax,QWORD PTR [rsi+0x18]
   1855eb1ff:	48 89 85 00 03 00 00 	mov    QWORD PTR [rbp+0x300],rax
   1855eb206:	c6 85 08 03 00 00 00 	mov    BYTE PTR [rbp+0x308],0x0
   1855eb20d:	0f 57 c0             	xorps  xmm0,xmm0
   1855eb210:	0f 11 85 30 04 00 00 	movups XMMWORD PTR [rbp+0x430],xmm0
   1855eb217:	0f 11 85 20 04 00 00 	movups XMMWORD PTR [rbp+0x420],xmm0
   1855eb21e:	0f 11 85 10 04 00 00 	movups XMMWORD PTR [rbp+0x410],xmm0
   1855eb225:	0f 11 85 00 04 00 00 	movups XMMWORD PTR [rbp+0x400],xmm0
   1855eb22c:	0f 11 85 f0 03 00 00 	movups XMMWORD PTR [rbp+0x3f0],xmm0
   1855eb233:	0f 11 85 e0 03 00 00 	movups XMMWORD PTR [rbp+0x3e0],xmm0
   1855eb23a:	0f 11 85 d0 03 00 00 	movups XMMWORD PTR [rbp+0x3d0],xmm0
   1855eb241:	48 8d 85 00 03 00 00 	lea    rax,[rbp+0x300]
   1855eb248:	48 89 85 c0 03 00 00 	mov    QWORD PTR [rbp+0x3c0],rax
   1855eb24f:	48 8d 85 b0 02 00 00 	lea    rax,[rbp+0x2b0]
   1855eb256:	48 89 85 c8 03 00 00 	mov    QWORD PTR [rbp+0x3c8],rax
   1855eb25d:	48 8d 15 a4 b9 41 04 	lea    rdx,[rip+0x441b9a4]        # 0x189a06c08
   1855eb264:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1855eb268:	4c 8d 85 c0 03 00 00 	lea    r8,[rbp+0x3c0]
   1855eb26f:	e8 9c 25 a8 fa       	call   0x18006d810
   1855eb274:	90                   	nop
   1855eb275:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1855eb279:	e8 f2 20 a8 fa       	call   0x18006d370
   1855eb27e:	48 8b 85 68 03 00 00 	mov    rax,QWORD PTR [rbp+0x368]
   1855eb285:	48 83 f8 10          	cmp    rax,0x10
   1855eb289:	72 38                	jb     0x1855eb2c3
   1855eb28b:	48 8b 8d 50 03 00 00 	mov    rcx,QWORD PTR [rbp+0x350]
   1855eb292:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855eb296:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855eb29d:	72 1f                	jb     0x1855eb2be
   1855eb29f:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855eb2a3:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855eb2a7:	4c 29 c1             	sub    rcx,r8
   1855eb2aa:	48 83 f9 20          	cmp    rcx,0x20
   1855eb2ae:	0f 83 03 05 00 00    	jae    0x1855eb7b7
   1855eb2b4:	48 83 c0 28          	add    rax,0x28
   1855eb2b8:	48 89 c2             	mov    rdx,rax
   1855eb2bb:	4c 89 c1             	mov    rcx,r8
   1855eb2be:	e8 5d 0a f6 01       	call   0x18754bd20
   1855eb2c3:	0f b6 85 f8 04 00 00 	movzx  eax,BYTE PTR [rbp+0x4f8]
   1855eb2ca:	48 8b 4e 08          	mov    rcx,QWORD PTR [rsi+0x8]
   1855eb2ce:	0f 28 85 b0 04 00 00 	movaps xmm0,XMMWORD PTR [rbp+0x4b0]
   1855eb2d5:	0f 28 8d c0 04 00 00 	movaps xmm1,XMMWORD PTR [rbp+0x4c0]
   1855eb2dc:	0f 29 45 c0          	movaps XMMWORD PTR [rbp-0x40],xmm0
   1855eb2e0:	0f 29 4d d0          	movaps XMMWORD PTR [rbp-0x30],xmm1
   1855eb2e4:	48 8b 95 d0 04 00 00 	mov    rdx,QWORD PTR [rbp+0x4d0]
   1855eb2eb:	48 89 55 e0          	mov    QWORD PTR [rbp-0x20],rdx
   1855eb2ef:	c6 45 08 00          	mov    BYTE PTR [rbp+0x8],0x0
   1855eb2f3:	3c 01                	cmp    al,0x1
   1855eb2f5:	75 3c                	jne    0x1855eb333
   1855eb2f7:	0f 10 85 d8 04 00 00 	movups xmm0,XMMWORD PTR [rbp+0x4d8]
   1855eb2fe:	0f 10 8d e8 04 00 00 	movups xmm1,XMMWORD PTR [rbp+0x4e8]
   1855eb305:	0f 11 4d f8          	movups XMMWORD PTR [rbp-0x8],xmm1
   1855eb309:	0f 11 45 e8          	movups XMMWORD PTR [rbp-0x18],xmm0
   1855eb30d:	48 c7 85 e8 04 00 00 	mov    QWORD PTR [rbp+0x4e8],0x0
   1855eb314:	00 00 00 00
   1855eb318:	48 c7 85 f0 04 00 00 	mov    QWORD PTR [rbp+0x4f0],0xf
   1855eb31f:	0f 00 00 00
   1855eb323:	c6 85 d8 04 00 00 00 	mov    BYTE PTR [rbp+0x4d8],0x0
   1855eb32a:	c6 45 08 01          	mov    BYTE PTR [rbp+0x8],0x1
   1855eb32e:	40 b6 01             	mov    sil,0x1
   1855eb331:	eb 02                	jmp    0x1855eb335
   1855eb333:	31 f6                	xor    esi,esi
   1855eb335:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   1855eb339:	e8 f2 74 ff ff       	call   0x1855e2830
   1855eb33e:	90                   	nop
   1855eb33f:	80 bd 90 04 00 00 01 	cmp    BYTE PTR [rbp+0x490],0x1
   1855eb346:	0f 85 8a 00 00 00    	jne    0x1855eb3d6
   1855eb34c:	48 8b 85 88 04 00 00 	mov    rax,QWORD PTR [rbp+0x488]
   1855eb353:	48 83 f8 10          	cmp    rax,0x10
   1855eb357:	72 38                	jb     0x1855eb391
   1855eb359:	48 8b 8d 70 04 00 00 	mov    rcx,QWORD PTR [rbp+0x470]
   1855eb360:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855eb364:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855eb36b:	72 1f                	jb     0x1855eb38c
   1855eb36d:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855eb371:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855eb375:	4c 29 c1             	sub    rcx,r8
   1855eb378:	48 83 f9 20          	cmp    rcx,0x20
   1855eb37c:	0f 83 35 04 00 00    	jae    0x1855eb7b7
   1855eb382:	48 83 c0 28          	add    rax,0x28
   1855eb386:	48 89 c2             	mov    rdx,rax
   1855eb389:	4c 89 c1             	mov    rcx,r8
   1855eb38c:	e8 8f 09 f6 01       	call   0x18754bd20
   1855eb391:	48 8b 85 58 04 00 00 	mov    rax,QWORD PTR [rbp+0x458]
   1855eb398:	48 83 f8 10          	cmp    rax,0x10
   1855eb39c:	72 38                	jb     0x1855eb3d6
   1855eb39e:	48 8b 8d 40 04 00 00 	mov    rcx,QWORD PTR [rbp+0x440]
   1855eb3a5:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855eb3a9:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855eb3b0:	72 1f                	jb     0x1855eb3d1
   1855eb3b2:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855eb3b6:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855eb3ba:	4c 29 c1             	sub    rcx,r8
   1855eb3bd:	48 83 f9 20          	cmp    rcx,0x20
   1855eb3c1:	0f 83 f0 03 00 00    	jae    0x1855eb7b7
   1855eb3c7:	48 83 c0 28          	add    rax,0x28
   1855eb3cb:	48 89 c2             	mov    rdx,rax
   1855eb3ce:	4c 89 c1             	mov    rcx,r8
   1855eb3d1:	e8 4a 09 f6 01       	call   0x18754bd20
   1855eb3d6:	40 84 f6             	test   sil,sil
   1855eb3d9:	0f 84 2c 03 00 00    	je     0x1855eb70b
   1855eb3df:	48 8b 85 f0 04 00 00 	mov    rax,QWORD PTR [rbp+0x4f0]
   1855eb3e6:	48 83 f8 10          	cmp    rax,0x10
   1855eb3ea:	0f 82 1b 03 00 00    	jb     0x1855eb70b
   1855eb3f0:	48 8b 8d d8 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4d8]
   1855eb3f7:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855eb3fb:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855eb402:	0f 82 fe 02 00 00    	jb     0x1855eb706
   1855eb408:	e9 da 02 00 00       	jmp    0x1855eb6e7
   1855eb40d:	48 8d 46 18          	lea    rax,[rsi+0x18]
   1855eb411:	48 89 85 b0 04 00 00 	mov    QWORD PTR [rbp+0x4b0],rax
   1855eb418:	c6 85 b8 04 00 00 00 	mov    BYTE PTR [rbp+0x4b8],0x0
   1855eb41f:	0f 57 c0             	xorps  xmm0,xmm0
   1855eb422:	0f 11 85 30 04 00 00 	movups XMMWORD PTR [rbp+0x430],xmm0
   1855eb429:	0f 11 85 20 04 00 00 	movups XMMWORD PTR [rbp+0x420],xmm0
   1855eb430:	0f 11 85 10 04 00 00 	movups XMMWORD PTR [rbp+0x410],xmm0
   1855eb437:	0f 11 85 00 04 00 00 	movups XMMWORD PTR [rbp+0x400],xmm0
   1855eb43e:	0f 11 85 f0 03 00 00 	movups XMMWORD PTR [rbp+0x3f0],xmm0
   1855eb445:	0f 11 85 e0 03 00 00 	movups XMMWORD PTR [rbp+0x3e0],xmm0
   1855eb44c:	0f 11 85 d0 03 00 00 	movups XMMWORD PTR [rbp+0x3d0],xmm0
   1855eb453:	48 8d 85 b0 04 00 00 	lea    rax,[rbp+0x4b0]
   1855eb45a:	48 89 85 c0 03 00 00 	mov    QWORD PTR [rbp+0x3c0],rax
   1855eb461:	48 8d 85 40 04 00 00 	lea    rax,[rbp+0x440]
   1855eb468:	48 89 85 c8 03 00 00 	mov    QWORD PTR [rbp+0x3c8],rax
   1855eb46f:	48 8d 15 32 b7 41 04 	lea    rdx,[rip+0x441b732]        # 0x189a06ba8
   1855eb476:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1855eb47a:	4c 8d 85 c0 03 00 00 	lea    r8,[rbp+0x3c0]
   1855eb481:	e8 8a 23 a8 fa       	call   0x18006d810
   1855eb486:	90                   	nop
   1855eb487:	48 8b 85 18 03 00 00 	mov    rax,QWORD PTR [rbp+0x318]
   1855eb48e:	48 83 f8 10          	cmp    rax,0x10
   1855eb492:	72 38                	jb     0x1855eb4cc
   1855eb494:	48 8b 8d 00 03 00 00 	mov    rcx,QWORD PTR [rbp+0x300]
   1855eb49b:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855eb49f:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855eb4a6:	72 1f                	jb     0x1855eb4c7
   1855eb4a8:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855eb4ac:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855eb4b0:	4c 29 c1             	sub    rcx,r8
   1855eb4b3:	48 83 f9 20          	cmp    rcx,0x20
   1855eb4b7:	0f 83 fa 02 00 00    	jae    0x1855eb7b7
   1855eb4bd:	48 83 c0 28          	add    rax,0x28
   1855eb4c1:	48 89 c2             	mov    rdx,rax
   1855eb4c4:	4c 89 c1             	mov    rcx,r8
   1855eb4c7:	e8 54 08 f6 01       	call   0x18754bd20
   1855eb4cc:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1855eb4d0:	e8 9b 1e a8 fa       	call   0x18006d370
   1855eb4d5:	48 8b 85 c8 02 00 00 	mov    rax,QWORD PTR [rbp+0x2c8]
   1855eb4dc:	48 83 f8 10          	cmp    rax,0x10
   1855eb4e0:	72 38                	jb     0x1855eb51a
   1855eb4e2:	48 8b 8d b0 02 00 00 	mov    rcx,QWORD PTR [rbp+0x2b0]
   1855eb4e9:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855eb4ed:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855eb4f4:	72 1f                	jb     0x1855eb515
   1855eb4f6:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855eb4fa:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855eb4fe:	4c 29 c1             	sub    rcx,r8
   1855eb501:	48 83 f9 20          	cmp    rcx,0x20
   1855eb505:	0f 83 ac 02 00 00    	jae    0x1855eb7b7
   1855eb50b:	48 83 c0 28          	add    rax,0x28
   1855eb50f:	48 89 c2             	mov    rdx,rax
   1855eb512:	4c 89 c1             	mov    rcx,r8
   1855eb515:	e8 06 08 f6 01       	call   0x18754bd20
   1855eb51a:	48 8b 76 08          	mov    rsi,QWORD PTR [rsi+0x8]
   1855eb51e:	48 8d 8d 70 03 00 00 	lea    rcx,[rbp+0x370]
   1855eb525:	48 8d bd 40 04 00 00 	lea    rdi,[rbp+0x440]
   1855eb52c:	48 89 fa             	mov    rdx,rdi
   1855eb52f:	e8 2c 57 b2 fa       	call   0x180110c60
   1855eb534:	90                   	nop
   1855eb535:	4c 8b 85 50 04 00 00 	mov    r8,QWORD PTR [rbp+0x450]
   1855eb53c:	48 8b 85 58 04 00 00 	mov    rax,QWORD PTR [rbp+0x458]
   1855eb543:	48 89 c1             	mov    rcx,rax
   1855eb546:	4c 29 c1             	sub    rcx,r8
   1855eb549:	48 83 f9 1b          	cmp    rcx,0x1b
   1855eb54d:	73 32                	jae    0x1855eb581
   1855eb54f:	48 8d 05 7a 97 41 04 	lea    rax,[rip+0x441977a]        # 0x189a04cd0
   1855eb556:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855eb55b:	48 c7 44 24 28 1b 00 	mov    QWORD PTR [rsp+0x28],0x1b
   1855eb562:	00 00
   1855eb564:	48 8d 8d 40 04 00 00 	lea    rcx,[rbp+0x440]
   1855eb56b:	ba 1b 00 00 00       	mov    edx,0x1b
   1855eb570:	45 31 c9             	xor    r9d,r9d
   1855eb573:	e8 d8 07 a2 fa       	call   0x18000bd50
   1855eb578:	90                   	nop
   1855eb579:	48 89 c7             	mov    rdi,rax
   1855eb57c:	e9 96 00 00 00       	jmp    0x1855eb617
   1855eb581:	49 8d 48 1b          	lea    rcx,[r8+0x1b]
   1855eb585:	48 89 8d 50 04 00 00 	mov    QWORD PTR [rbp+0x450],rcx
   1855eb58c:	48 83 f8 10          	cmp    rax,0x10
   1855eb590:	48 8b 8d 40 04 00 00 	mov    rcx,QWORD PTR [rbp+0x440]
   1855eb597:	48 89 fb             	mov    rbx,rdi
   1855eb59a:	48 0f 43 d9          	cmovae rbx,rcx
   1855eb59e:	48 8d 15 46 97 41 04 	lea    rdx,[rip+0x4419746]        # 0x189a04ceb
   1855eb5a5:	48 39 d3             	cmp    rbx,rdx
   1855eb5a8:	0f 93 c2             	setae  dl
   1855eb5ab:	4c 8d 35 1e 97 41 04 	lea    r14,[rip+0x441971e]        # 0x189a04cd0
   1855eb5b2:	4e 8d 0c 03          	lea    r9,[rbx+r8*1]
   1855eb5b6:	4d 39 f1             	cmp    r9,r14
   1855eb5b9:	41 0f 92 c1          	setb   r9b
   1855eb5bd:	41 08 d1             	or     r9b,dl
   1855eb5c0:	41 bf 1b 00 00 00    	mov    r15d,0x1b
   1855eb5c6:	41 bc 1b 00 00 00    	mov    r12d,0x1b
   1855eb5cc:	75 0b                	jne    0x1855eb5d9
   1855eb5ce:	49 89 dc             	mov    r12,rbx
   1855eb5d1:	4d 29 f4             	sub    r12,r14
   1855eb5d4:	77 03                	ja     0x1855eb5d9
   1855eb5d6:	45 31 e4             	xor    r12d,r12d
   1855eb5d9:	49 ff c0             	inc    r8
   1855eb5dc:	48 83 f8 10          	cmp    rax,0x10
   1855eb5e0:	48 0f 42 cf          	cmovb  rcx,rdi
   1855eb5e4:	48 83 c1 1b          	add    rcx,0x1b
   1855eb5e8:	48 89 da             	mov    rdx,rbx
   1855eb5eb:	e8 50 98 12 02       	call   0x187714e40
   1855eb5f0:	48 89 d9             	mov    rcx,rbx
   1855eb5f3:	4c 89 f2             	mov    rdx,r14
   1855eb5f6:	4d 89 e0             	mov    r8,r12
   1855eb5f9:	e8 42 98 12 02       	call   0x187714e40
   1855eb5fe:	4d 29 e7             	sub    r15,r12
   1855eb601:	4b 8d 14 34          	lea    rdx,[r12+r14*1]
   1855eb605:	48 83 c2 1b          	add    rdx,0x1b
   1855eb609:	4c 01 e3             	add    rbx,r12
   1855eb60c:	48 89 d9             	mov    rcx,rbx
   1855eb60f:	4d 89 f8             	mov    r8,r15
   1855eb612:	e8 29 98 12 02       	call   0x187714e40
   1855eb617:	0f 10 07             	movups xmm0,XMMWORD PTR [rdi]
   1855eb61a:	0f 10 4f 10          	movups xmm1,XMMWORD PTR [rdi+0x10]
   1855eb61e:	0f 29 8d d0 03 00 00 	movaps XMMWORD PTR [rbp+0x3d0],xmm1
   1855eb625:	0f 29 85 c0 03 00 00 	movaps XMMWORD PTR [rbp+0x3c0],xmm0
   1855eb62c:	48 c7 47 10 00 00 00 	mov    QWORD PTR [rdi+0x10],0x0
   1855eb633:	00
   1855eb634:	48 c7 47 18 0f 00 00 	mov    QWORD PTR [rdi+0x18],0xf
   1855eb63b:	00
   1855eb63c:	c6 07 00             	mov    BYTE PTR [rdi],0x0
   1855eb63f:	0f 29 75 d0          	movaps XMMWORD PTR [rbp-0x30],xmm6
   1855eb643:	0f 29 75 e0          	movaps XMMWORD PTR [rbp-0x20],xmm6
   1855eb647:	0f 29 75 00          	movaps XMMWORD PTR [rbp+0x0],xmm6
   1855eb64b:	0f 29 75 c0          	movaps XMMWORD PTR [rbp-0x40],xmm6
   1855eb64f:	0f 29 75 f0          	movaps XMMWORD PTR [rbp-0x10],xmm6
   1855eb653:	c6 45 d0 00          	mov    BYTE PTR [rbp-0x30],0x0
   1855eb657:	c6 45 e0 00          	mov    BYTE PTR [rbp-0x20],0x0
   1855eb65b:	c6 45 08 00          	mov    BYTE PTR [rbp+0x8],0x0
   1855eb65f:	c6 45 c0 00          	mov    BYTE PTR [rbp-0x40],0x0
   1855eb663:	48 8d 4d e8          	lea    rcx,[rbp-0x18]
   1855eb667:	48 8d 95 c0 03 00 00 	lea    rdx,[rbp+0x3c0]
   1855eb66e:	e8 7d 99 3a fc       	call   0x181994ff0
   1855eb673:	90                   	nop
   1855eb674:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   1855eb678:	48 89 f1             	mov    rcx,rsi
   1855eb67b:	e8 b0 71 ff ff       	call   0x1855e2830
   1855eb680:	90                   	nop
   1855eb681:	48 8b 85 d8 03 00 00 	mov    rax,QWORD PTR [rbp+0x3d8]
   1855eb688:	48 83 f8 10          	cmp    rax,0x10
   1855eb68c:	72 38                	jb     0x1855eb6c6
   1855eb68e:	48 8b 8d c0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3c0]
   1855eb695:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855eb699:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855eb6a0:	72 1f                	jb     0x1855eb6c1
   1855eb6a2:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855eb6a6:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855eb6aa:	4c 29 c1             	sub    rcx,r8
   1855eb6ad:	48 83 f9 20          	cmp    rcx,0x20
   1855eb6b1:	0f 83 00 01 00 00    	jae    0x1855eb7b7
   1855eb6b7:	48 83 c0 28          	add    rax,0x28
   1855eb6bb:	48 89 c2             	mov    rdx,rax
   1855eb6be:	4c 89 c1             	mov    rcx,r8
   1855eb6c1:	e8 5a 06 f6 01       	call   0x18754bd20
   1855eb6c6:	48 8b 85 58 04 00 00 	mov    rax,QWORD PTR [rbp+0x458]
   1855eb6cd:	48 83 f8 10          	cmp    rax,0x10
   1855eb6d1:	72 38                	jb     0x1855eb70b
   1855eb6d3:	48 8b 8d 40 04 00 00 	mov    rcx,QWORD PTR [rbp+0x440]
   1855eb6da:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855eb6de:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855eb6e5:	72 1f                	jb     0x1855eb706
   1855eb6e7:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855eb6eb:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855eb6ef:	4c 29 c1             	sub    rcx,r8
   1855eb6f2:	48 83 f9 20          	cmp    rcx,0x20
   1855eb6f6:	0f 83 bb 00 00 00    	jae    0x1855eb7b7
   1855eb6fc:	48 83 c0 28          	add    rax,0x28
   1855eb700:	48 89 c2             	mov    rdx,rax
   1855eb703:	4c 89 c1             	mov    rcx,r8
   1855eb706:	e8 15 06 f6 01       	call   0x18754bd20
   1855eb70b:	48 8b b5 a0 03 00 00 	mov    rsi,QWORD PTR [rbp+0x3a0]
   1855eb712:	48 85 f6             	test   rsi,rsi
   1855eb715:	74 1d                	je     0x1855eb734
   1855eb717:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855eb71b:	75 17                	jne    0x1855eb734
   1855eb71d:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855eb720:	48 89 f1             	mov    rcx,rsi
   1855eb723:	ff 10                	call   QWORD PTR [rax]
   1855eb725:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855eb729:	75 09                	jne    0x1855eb734
   1855eb72b:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855eb72e:	48 89 f1             	mov    rcx,rsi
   1855eb731:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855eb734:	48 8b 85 90 03 00 00 	mov    rax,QWORD PTR [rbp+0x390]
   1855eb73b:	48 83 f8 10          	cmp    rax,0x10
   1855eb73f:	72 34                	jb     0x1855eb775
   1855eb741:	48 8b 8d 78 03 00 00 	mov    rcx,QWORD PTR [rbp+0x378]
   1855eb748:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855eb74c:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855eb753:	72 1b                	jb     0x1855eb770
   1855eb755:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855eb759:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855eb75d:	4c 29 c1             	sub    rcx,r8
   1855eb760:	48 83 f9 20          	cmp    rcx,0x20
   1855eb764:	73 51                	jae    0x1855eb7b7
   1855eb766:	48 83 c0 28          	add    rax,0x28
   1855eb76a:	48 89 c2             	mov    rdx,rax
   1855eb76d:	4c 89 c1             	mov    rcx,r8
   1855eb770:	e8 ab 05 f6 01       	call   0x18754bd20
   1855eb775:	48 8b b5 a8 04 00 00 	mov    rsi,QWORD PTR [rbp+0x4a8]
   1855eb77c:	48 85 f6             	test   rsi,rsi
   1855eb77f:	74 1d                	je     0x1855eb79e
   1855eb781:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855eb785:	75 17                	jne    0x1855eb79e
   1855eb787:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855eb78a:	48 89 f1             	mov    rcx,rsi
   1855eb78d:	ff 10                	call   QWORD PTR [rax]
   1855eb78f:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855eb793:	75 09                	jne    0x1855eb79e
   1855eb795:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855eb798:	48 89 f1             	mov    rcx,rsi
   1855eb79b:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855eb79e:	0f 28 b5 10 05 00 00 	movaps xmm6,XMMWORD PTR [rbp+0x510]
   1855eb7a5:	48 81 c4 a0 05 00 00 	add    rsp,0x5a0
   1855eb7ac:	5b                   	pop    rbx
   1855eb7ad:	5f                   	pop    rdi
   1855eb7ae:	5e                   	pop    rsi
   1855eb7af:	41 5c                	pop    r12
   1855eb7b1:	41 5e                	pop    r14
   1855eb7b3:	41 5f                	pop    r15
   1855eb7b5:	5d                   	pop    rbp
   1855eb7b6:	c3                   	ret
   1855eb7b7:	e8 d0 29 0f 02       	call   0x1876de18c
   1855eb7bc:	cc                   	int3
