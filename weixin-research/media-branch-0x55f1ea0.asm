
E:/Tencent/Weixin/4.1.15.56/Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001855f1ea0 <.text+0x55f0ea0>:
   1855f1ea0:	55                   	push   rbp
   1855f1ea1:	41 57                	push   r15
   1855f1ea3:	41 56                	push   r14
   1855f1ea5:	41 54                	push   r12
   1855f1ea7:	56                   	push   rsi
   1855f1ea8:	57                   	push   rdi
   1855f1ea9:	53                   	push   rbx
   1855f1eaa:	48 81 ec a0 02 00 00 	sub    rsp,0x2a0
   1855f1eb1:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   1855f1eb8:	00
   1855f1eb9:	0f 29 b5 10 02 00 00 	movaps XMMWORD PTR [rbp+0x210],xmm6
   1855f1ec0:	48 c7 85 08 02 00 00 	mov    QWORD PTR [rbp+0x208],0xfffffffffffffffe
   1855f1ec7:	fe ff ff ff
   1855f1ecb:	48 89 ce             	mov    rsi,rcx
   1855f1ece:	48 b8 aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaaa
   1855f1ed5:	aa aa aa
   1855f1ed8:	48 89 85 c0 01 00 00 	mov    QWORD PTR [rbp+0x1c0],rax
   1855f1edf:	0f 28 35 ca 4c 92 03 	movaps xmm6,XMMWORD PTR [rip+0x3924cca]        # 0x188f16bb0
   1855f1ee6:	0f 29 b5 b0 01 00 00 	movaps XMMWORD PTR [rbp+0x1b0],xmm6
   1855f1eed:	0f 29 b5 a0 01 00 00 	movaps XMMWORD PTR [rbp+0x1a0],xmm6
   1855f1ef4:	0f 29 b5 90 01 00 00 	movaps XMMWORD PTR [rbp+0x190],xmm6
   1855f1efb:	48 8b 49 48          	mov    rcx,QWORD PTR [rcx+0x48]
   1855f1eff:	0f 57 c0             	xorps  xmm0,xmm0
   1855f1f02:	0f 29 85 d0 01 00 00 	movaps XMMWORD PTR [rbp+0x1d0],xmm0
   1855f1f09:	48 8b 46 40          	mov    rax,QWORD PTR [rsi+0x40]
   1855f1f0d:	48 85 c0             	test   rax,rax
   1855f1f10:	74 0a                	je     0x1855f1f1c
   1855f1f12:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1855f1f16:	48 8b 46 40          	mov    rax,QWORD PTR [rsi+0x40]
   1855f1f1a:	eb 02                	jmp    0x1855f1f1e
   1855f1f1c:	31 c0                	xor    eax,eax
   1855f1f1e:	48 8b 56 38          	mov    rdx,QWORD PTR [rsi+0x38]
   1855f1f22:	48 89 95 d0 01 00 00 	mov    QWORD PTR [rbp+0x1d0],rdx
   1855f1f29:	48 89 85 d8 01 00 00 	mov    QWORD PTR [rbp+0x1d8],rax
   1855f1f30:	48 8d 95 90 01 00 00 	lea    rdx,[rbp+0x190]
   1855f1f37:	4c 8d 85 d0 01 00 00 	lea    r8,[rbp+0x1d0]
   1855f1f3e:	e8 1d 1c 1b fc       	call   0x1817a3b60
   1855f1f43:	8b 85 94 01 00 00    	mov    eax,DWORD PTR [rbp+0x194]
   1855f1f49:	0b 85 90 01 00 00    	or     eax,DWORD PTR [rbp+0x190]
   1855f1f4f:	0f 84 b8 00 00 00    	je     0x1855f200d
   1855f1f55:	b9 04 00 00 00       	mov    ecx,0x4
   1855f1f5a:	e8 81 ae a7 fa       	call   0x18006cde0
   1855f1f5f:	85 c0                	test   eax,eax
   1855f1f61:	0f 84 49 03 00 00    	je     0x1855f22b0
   1855f1f67:	48 8d bd e8 01 00 00 	lea    rdi,[rbp+0x1e8]
   1855f1f6e:	48 89 f9             	mov    rcx,rdi
   1855f1f71:	e8 9a af a7 fa       	call   0x18006cf10
   1855f1f76:	90                   	nop
   1855f1f77:	48 83 bd 00 02 00 00 	cmp    QWORD PTR [rbp+0x200],0x10
   1855f1f7e:	10
   1855f1f7f:	72 07                	jb     0x1855f1f88
   1855f1f81:	48 8b bd e8 01 00 00 	mov    rdi,QWORD PTR [rbp+0x1e8]
   1855f1f88:	48 8d 05 91 56 41 04 	lea    rax,[rip+0x4415691]        # 0x189a07620
   1855f1f8f:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855f1f94:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855f1f9b:	00 00
   1855f1f9d:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855f1fa2:	c7 44 24 28 9a 00 00 	mov    DWORD PTR [rsp+0x28],0x9a
   1855f1fa9:	00
   1855f1faa:	4c 8d 0d 1f 53 41 04 	lea    r9,[rip+0x441531f]        # 0x189a072d0
   1855f1fb1:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855f1fb5:	ba 04 00 00 00       	mov    edx,0x4
   1855f1fba:	49 89 f8             	mov    r8,rdi
   1855f1fbd:	e8 ae b2 a7 fa       	call   0x18006d270
   1855f1fc2:	90                   	nop
   1855f1fc3:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855f1fca:	48 8d bd f0 00 00 00 	lea    rdi,[rbp+0xf0]
   1855f1fd1:	48 89 fa             	mov    rdx,rdi
   1855f1fd4:	e8 87 ec b1 fa       	call   0x180110c60
   1855f1fd9:	90                   	nop
   1855f1fda:	48 83 bd 08 01 00 00 	cmp    QWORD PTR [rbp+0x108],0x10
   1855f1fe1:	10
   1855f1fe2:	72 07                	jb     0x1855f1feb
   1855f1fe4:	48 8b bd f0 00 00 00 	mov    rdi,QWORD PTR [rbp+0xf0]
   1855f1feb:	48 89 bd a0 00 00 00 	mov    QWORD PTR [rbp+0xa0],rdi
   1855f1ff2:	c6 85 a8 00 00 00 00 	mov    BYTE PTR [rbp+0xa8],0x0
   1855f1ff9:	48 83 7e 30 10       	cmp    QWORD PTR [rsi+0x30],0x10
   1855f1ffe:	0f 82 a8 01 00 00    	jb     0x1855f21ac
   1855f2004:	48 8b 46 18          	mov    rax,QWORD PTR [rsi+0x18]
   1855f2008:	e9 a3 01 00 00       	jmp    0x1855f21b0
   1855f200d:	b9 02 00 00 00       	mov    ecx,0x2
   1855f2012:	e8 c9 ad a7 fa       	call   0x18006cde0
   1855f2017:	85 c0                	test   eax,eax
   1855f2019:	0f 84 66 01 00 00    	je     0x1855f2185
   1855f201f:	48 8d bd e8 01 00 00 	lea    rdi,[rbp+0x1e8]
   1855f2026:	48 89 f9             	mov    rcx,rdi
   1855f2029:	e8 e2 ae a7 fa       	call   0x18006cf10
   1855f202e:	90                   	nop
   1855f202f:	48 83 bd 00 02 00 00 	cmp    QWORD PTR [rbp+0x200],0x10
   1855f2036:	10
   1855f2037:	72 07                	jb     0x1855f2040
   1855f2039:	48 8b bd e8 01 00 00 	mov    rdi,QWORD PTR [rbp+0x1e8]
   1855f2040:	48 8d 05 d9 55 41 04 	lea    rax,[rip+0x44155d9]        # 0x189a07620
   1855f2047:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855f204c:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855f2053:	00 00
   1855f2055:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855f205a:	c7 44 24 28 9f 00 00 	mov    DWORD PTR [rsp+0x28],0x9f
   1855f2061:	00
   1855f2062:	4c 8d 0d 67 52 41 04 	lea    r9,[rip+0x4415267]        # 0x189a072d0
   1855f2069:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855f206d:	ba 02 00 00 00       	mov    edx,0x2
   1855f2072:	49 89 f8             	mov    r8,rdi
   1855f2075:	e8 f6 b1 a7 fa       	call   0x18006d270
   1855f207a:	90                   	nop
   1855f207b:	48 8b 46 38          	mov    rax,QWORD PTR [rsi+0x38]
   1855f207f:	48 83 b8 c8 00 00 00 	cmp    QWORD PTR [rax+0xc8],0x10
   1855f2086:	10
   1855f2087:	72 22                	jb     0x1855f20ab
   1855f2089:	48 8b 80 b0 00 00 00 	mov    rax,QWORD PTR [rax+0xb0]
   1855f2090:	48 89 85 a0 00 00 00 	mov    QWORD PTR [rbp+0xa0],rax
   1855f2097:	c6 85 a8 00 00 00 00 	mov    BYTE PTR [rbp+0xa8],0x0
   1855f209e:	48 83 7e 30 10       	cmp    QWORD PTR [rsi+0x30],0x10
   1855f20a3:	73 21                	jae    0x1855f20c6
   1855f20a5:	48 8d 46 18          	lea    rax,[rsi+0x18]
   1855f20a9:	eb 1f                	jmp    0x1855f20ca
   1855f20ab:	48 05 b0 00 00 00    	add    rax,0xb0
   1855f20b1:	48 89 85 a0 00 00 00 	mov    QWORD PTR [rbp+0xa0],rax
   1855f20b8:	c6 85 a8 00 00 00 00 	mov    BYTE PTR [rbp+0xa8],0x0
   1855f20bf:	48 83 7e 30 10       	cmp    QWORD PTR [rsi+0x30],0x10
   1855f20c4:	72 df                	jb     0x1855f20a5
   1855f20c6:	48 8b 46 18          	mov    rax,QWORD PTR [rsi+0x18]
   1855f20ca:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
   1855f20ce:	c6 45 c8 00          	mov    BYTE PTR [rbp-0x38],0x0
   1855f20d2:	0f 57 c0             	xorps  xmm0,xmm0
   1855f20d5:	0f 11 85 80 01 00 00 	movups XMMWORD PTR [rbp+0x180],xmm0
   1855f20dc:	0f 11 85 70 01 00 00 	movups XMMWORD PTR [rbp+0x170],xmm0
   1855f20e3:	0f 11 85 60 01 00 00 	movups XMMWORD PTR [rbp+0x160],xmm0
   1855f20ea:	0f 11 85 50 01 00 00 	movups XMMWORD PTR [rbp+0x150],xmm0
   1855f20f1:	0f 11 85 40 01 00 00 	movups XMMWORD PTR [rbp+0x140],xmm0
   1855f20f8:	0f 11 85 30 01 00 00 	movups XMMWORD PTR [rbp+0x130],xmm0
   1855f20ff:	0f 11 85 20 01 00 00 	movups XMMWORD PTR [rbp+0x120],xmm0
   1855f2106:	48 8d 45 c0          	lea    rax,[rbp-0x40]
   1855f210a:	48 89 85 10 01 00 00 	mov    QWORD PTR [rbp+0x110],rax
   1855f2111:	48 8d 85 a0 00 00 00 	lea    rax,[rbp+0xa0]
   1855f2118:	48 89 85 18 01 00 00 	mov    QWORD PTR [rbp+0x118],rax
   1855f211f:	48 8d 15 1a 56 41 04 	lea    rdx,[rip+0x441561a]        # 0x189a07740
   1855f2126:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855f212a:	4c 8d 85 10 01 00 00 	lea    r8,[rbp+0x110]
   1855f2131:	e8 da b6 a7 fa       	call   0x18006d810
   1855f2136:	90                   	nop
   1855f2137:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855f213b:	e8 30 b2 a7 fa       	call   0x18006d370
   1855f2140:	48 8b 85 00 02 00 00 	mov    rax,QWORD PTR [rbp+0x200]
   1855f2147:	48 83 f8 10          	cmp    rax,0x10
   1855f214b:	72 38                	jb     0x1855f2185
   1855f214d:	48 8b 8d e8 01 00 00 	mov    rcx,QWORD PTR [rbp+0x1e8]
   1855f2154:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855f2158:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855f215f:	72 1f                	jb     0x1855f2180
   1855f2161:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855f2165:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855f2169:	4c 29 c1             	sub    rcx,r8
   1855f216c:	48 83 f9 20          	cmp    rcx,0x20
   1855f2170:	0f 83 9e 03 00 00    	jae    0x1855f2514
   1855f2176:	48 83 c0 28          	add    rax,0x28
   1855f217a:	48 89 c2             	mov    rdx,rax
   1855f217d:	4c 89 c1             	mov    rcx,r8
   1855f2180:	e8 9b 9b f5 01       	call   0x18754bd20
   1855f2185:	48 8b 4e 08          	mov    rcx,QWORD PTR [rsi+0x8]
   1855f2189:	0f 29 75 30          	movaps XMMWORD PTR [rbp+0x30],xmm6
   1855f218d:	0f 29 75 10          	movaps XMMWORD PTR [rbp+0x10],xmm6
   1855f2191:	0f 29 75 20          	movaps XMMWORD PTR [rbp+0x20],xmm6
   1855f2195:	c6 45 38 00          	mov    BYTE PTR [rbp+0x38],0x0
   1855f2199:	c6 45 10 01          	mov    BYTE PTR [rbp+0x10],0x1
   1855f219d:	48 8d 55 10          	lea    rdx,[rbp+0x10]
   1855f21a1:	e8 3a 43 f7 ff       	call   0x1855664e0
   1855f21a6:	90                   	nop
   1855f21a7:	e9 e5 02 00 00       	jmp    0x1855f2491
   1855f21ac:	48 8d 46 18          	lea    rax,[rsi+0x18]
   1855f21b0:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
   1855f21b4:	c6 45 c8 00          	mov    BYTE PTR [rbp-0x38],0x0
   1855f21b8:	0f 57 c0             	xorps  xmm0,xmm0
   1855f21bb:	0f 11 85 80 01 00 00 	movups XMMWORD PTR [rbp+0x180],xmm0
   1855f21c2:	0f 11 85 70 01 00 00 	movups XMMWORD PTR [rbp+0x170],xmm0
   1855f21c9:	0f 11 85 60 01 00 00 	movups XMMWORD PTR [rbp+0x160],xmm0
   1855f21d0:	0f 11 85 50 01 00 00 	movups XMMWORD PTR [rbp+0x150],xmm0
   1855f21d7:	0f 11 85 40 01 00 00 	movups XMMWORD PTR [rbp+0x140],xmm0
   1855f21de:	0f 11 85 30 01 00 00 	movups XMMWORD PTR [rbp+0x130],xmm0
   1855f21e5:	0f 11 85 20 01 00 00 	movups XMMWORD PTR [rbp+0x120],xmm0
   1855f21ec:	48 8d 45 c0          	lea    rax,[rbp-0x40]
   1855f21f0:	48 89 85 10 01 00 00 	mov    QWORD PTR [rbp+0x110],rax
   1855f21f7:	48 8d 85 a0 00 00 00 	lea    rax,[rbp+0xa0]
   1855f21fe:	48 89 85 18 01 00 00 	mov    QWORD PTR [rbp+0x118],rax
   1855f2205:	48 8d 15 d4 51 41 04 	lea    rdx,[rip+0x44151d4]        # 0x189a073e0
   1855f220c:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855f2210:	4c 8d 85 10 01 00 00 	lea    r8,[rbp+0x110]
   1855f2217:	e8 f4 b5 a7 fa       	call   0x18006d810
   1855f221c:	90                   	nop
   1855f221d:	48 8b 85 08 01 00 00 	mov    rax,QWORD PTR [rbp+0x108]
   1855f2224:	48 83 f8 10          	cmp    rax,0x10
   1855f2228:	72 38                	jb     0x1855f2262
   1855f222a:	48 8b 8d f0 00 00 00 	mov    rcx,QWORD PTR [rbp+0xf0]
   1855f2231:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855f2235:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855f223c:	72 1f                	jb     0x1855f225d
   1855f223e:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855f2242:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855f2246:	4c 29 c1             	sub    rcx,r8
   1855f2249:	48 83 f9 20          	cmp    rcx,0x20
   1855f224d:	0f 83 c1 02 00 00    	jae    0x1855f2514
   1855f2253:	48 83 c0 28          	add    rax,0x28
   1855f2257:	48 89 c2             	mov    rdx,rax
   1855f225a:	4c 89 c1             	mov    rcx,r8
   1855f225d:	e8 be 9a f5 01       	call   0x18754bd20
   1855f2262:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855f2266:	e8 05 b1 a7 fa       	call   0x18006d370
   1855f226b:	48 8b 85 00 02 00 00 	mov    rax,QWORD PTR [rbp+0x200]
   1855f2272:	48 83 f8 10          	cmp    rax,0x10
   1855f2276:	72 38                	jb     0x1855f22b0
   1855f2278:	48 8b 8d e8 01 00 00 	mov    rcx,QWORD PTR [rbp+0x1e8]
   1855f227f:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855f2283:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855f228a:	72 1f                	jb     0x1855f22ab
   1855f228c:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855f2290:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855f2294:	4c 29 c1             	sub    rcx,r8
   1855f2297:	48 83 f9 20          	cmp    rcx,0x20
   1855f229b:	0f 83 73 02 00 00    	jae    0x1855f2514
   1855f22a1:	48 83 c0 28          	add    rax,0x28
   1855f22a5:	48 89 c2             	mov    rdx,rax
   1855f22a8:	4c 89 c1             	mov    rcx,r8
   1855f22ab:	e8 70 9a f5 01       	call   0x18754bd20
   1855f22b0:	48 8b 76 08          	mov    rsi,QWORD PTR [rsi+0x8]
   1855f22b4:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855f22bb:	48 8d bd a0 00 00 00 	lea    rdi,[rbp+0xa0]
   1855f22c2:	48 89 fa             	mov    rdx,rdi
   1855f22c5:	e8 96 e9 b1 fa       	call   0x180110c60
   1855f22ca:	90                   	nop
   1855f22cb:	4c 8b 85 b0 00 00 00 	mov    r8,QWORD PTR [rbp+0xb0]
   1855f22d2:	48 8b 85 b8 00 00 00 	mov    rax,QWORD PTR [rbp+0xb8]
   1855f22d9:	48 89 c1             	mov    rcx,rax
   1855f22dc:	4c 29 c1             	sub    rcx,r8
   1855f22df:	48 83 f9 1d          	cmp    rcx,0x1d
   1855f22e3:	73 32                	jae    0x1855f2317
   1855f22e5:	48 8d 05 34 4f 41 04 	lea    rax,[rip+0x4414f34]        # 0x189a07220
   1855f22ec:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855f22f1:	48 c7 44 24 28 1d 00 	mov    QWORD PTR [rsp+0x28],0x1d
   1855f22f8:	00 00
   1855f22fa:	48 8d 8d a0 00 00 00 	lea    rcx,[rbp+0xa0]
   1855f2301:	ba 1d 00 00 00       	mov    edx,0x1d
   1855f2306:	45 31 c9             	xor    r9d,r9d
   1855f2309:	e8 42 9a a1 fa       	call   0x18000bd50
   1855f230e:	90                   	nop
   1855f230f:	48 89 c7             	mov    rdi,rax
   1855f2312:	e9 96 00 00 00       	jmp    0x1855f23ad
   1855f2317:	49 8d 48 1d          	lea    rcx,[r8+0x1d]
   1855f231b:	48 89 8d b0 00 00 00 	mov    QWORD PTR [rbp+0xb0],rcx
   1855f2322:	48 83 f8 10          	cmp    rax,0x10
   1855f2326:	48 8b 8d a0 00 00 00 	mov    rcx,QWORD PTR [rbp+0xa0]
   1855f232d:	48 89 fb             	mov    rbx,rdi
   1855f2330:	48 0f 43 d9          	cmovae rbx,rcx
   1855f2334:	48 8d 15 02 4f 41 04 	lea    rdx,[rip+0x4414f02]        # 0x189a0723d
   1855f233b:	48 39 d3             	cmp    rbx,rdx
   1855f233e:	0f 93 c2             	setae  dl
   1855f2341:	4c 8d 35 d8 4e 41 04 	lea    r14,[rip+0x4414ed8]        # 0x189a07220
   1855f2348:	4e 8d 0c 03          	lea    r9,[rbx+r8*1]
   1855f234c:	4d 39 f1             	cmp    r9,r14
   1855f234f:	41 0f 92 c1          	setb   r9b
   1855f2353:	41 08 d1             	or     r9b,dl
   1855f2356:	41 bf 1d 00 00 00    	mov    r15d,0x1d
   1855f235c:	41 bc 1d 00 00 00    	mov    r12d,0x1d
   1855f2362:	75 0b                	jne    0x1855f236f
   1855f2364:	49 89 dc             	mov    r12,rbx
   1855f2367:	4d 29 f4             	sub    r12,r14
   1855f236a:	77 03                	ja     0x1855f236f
   1855f236c:	45 31 e4             	xor    r12d,r12d
   1855f236f:	49 ff c0             	inc    r8
   1855f2372:	48 83 f8 10          	cmp    rax,0x10
   1855f2376:	48 0f 42 cf          	cmovb  rcx,rdi
   1855f237a:	48 83 c1 1d          	add    rcx,0x1d
   1855f237e:	48 89 da             	mov    rdx,rbx
   1855f2381:	e8 ba 2a 12 02       	call   0x187714e40
   1855f2386:	48 89 d9             	mov    rcx,rbx
   1855f2389:	4c 89 f2             	mov    rdx,r14
   1855f238c:	4d 89 e0             	mov    r8,r12
   1855f238f:	e8 ac 2a 12 02       	call   0x187714e40
   1855f2394:	4d 29 e7             	sub    r15,r12
   1855f2397:	4b 8d 14 34          	lea    rdx,[r12+r14*1]
   1855f239b:	48 83 c2 1d          	add    rdx,0x1d
   1855f239f:	4c 01 e3             	add    rbx,r12
   1855f23a2:	48 89 d9             	mov    rcx,rbx
   1855f23a5:	4d 89 f8             	mov    r8,r15
   1855f23a8:	e8 93 2a 12 02       	call   0x187714e40
   1855f23ad:	0f 10 07             	movups xmm0,XMMWORD PTR [rdi]
   1855f23b0:	0f 10 4f 10          	movups xmm1,XMMWORD PTR [rdi+0x10]
   1855f23b4:	0f 29 8d 20 01 00 00 	movaps XMMWORD PTR [rbp+0x120],xmm1
   1855f23bb:	0f 29 85 10 01 00 00 	movaps XMMWORD PTR [rbp+0x110],xmm0
   1855f23c2:	48 c7 47 10 00 00 00 	mov    QWORD PTR [rdi+0x10],0x0
   1855f23c9:	00
   1855f23ca:	48 c7 47 18 0f 00 00 	mov    QWORD PTR [rdi+0x18],0xf
   1855f23d1:	00
   1855f23d2:	c6 07 00             	mov    BYTE PTR [rdi],0x0
   1855f23d5:	0f 29 75 30          	movaps XMMWORD PTR [rbp+0x30],xmm6
   1855f23d9:	0f 29 75 10          	movaps XMMWORD PTR [rbp+0x10],xmm6
   1855f23dd:	0f 29 75 20          	movaps XMMWORD PTR [rbp+0x20],xmm6
   1855f23e1:	c6 45 38 00          	mov    BYTE PTR [rbp+0x38],0x0
   1855f23e5:	c6 45 10 00          	mov    BYTE PTR [rbp+0x10],0x0
   1855f23e9:	48 8d 4d 18          	lea    rcx,[rbp+0x18]
   1855f23ed:	48 8d 95 10 01 00 00 	lea    rdx,[rbp+0x110]
   1855f23f4:	e8 f7 2b 3a fc       	call   0x181994ff0
   1855f23f9:	90                   	nop
   1855f23fa:	48 8d 55 10          	lea    rdx,[rbp+0x10]
   1855f23fe:	48 89 f1             	mov    rcx,rsi
   1855f2401:	e8 da 40 f7 ff       	call   0x1855664e0
   1855f2406:	90                   	nop
   1855f2407:	48 8b 85 28 01 00 00 	mov    rax,QWORD PTR [rbp+0x128]
   1855f240e:	48 83 f8 10          	cmp    rax,0x10
   1855f2412:	72 38                	jb     0x1855f244c
   1855f2414:	48 8b 8d 10 01 00 00 	mov    rcx,QWORD PTR [rbp+0x110]
   1855f241b:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855f241f:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855f2426:	72 1f                	jb     0x1855f2447
   1855f2428:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855f242c:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855f2430:	4c 29 c1             	sub    rcx,r8
   1855f2433:	48 83 f9 20          	cmp    rcx,0x20
   1855f2437:	0f 83 d7 00 00 00    	jae    0x1855f2514
   1855f243d:	48 83 c0 28          	add    rax,0x28
   1855f2441:	48 89 c2             	mov    rdx,rax
   1855f2444:	4c 89 c1             	mov    rcx,r8
   1855f2447:	e8 d4 98 f5 01       	call   0x18754bd20
   1855f244c:	48 8b 85 b8 00 00 00 	mov    rax,QWORD PTR [rbp+0xb8]
   1855f2453:	48 83 f8 10          	cmp    rax,0x10
   1855f2457:	72 38                	jb     0x1855f2491
   1855f2459:	48 8b 8d a0 00 00 00 	mov    rcx,QWORD PTR [rbp+0xa0]
   1855f2460:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855f2464:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855f246b:	72 1f                	jb     0x1855f248c
   1855f246d:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855f2471:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855f2475:	4c 29 c1             	sub    rcx,r8
   1855f2478:	48 83 f9 20          	cmp    rcx,0x20
   1855f247c:	0f 83 92 00 00 00    	jae    0x1855f2514
   1855f2482:	48 83 c0 28          	add    rax,0x28
   1855f2486:	48 89 c2             	mov    rdx,rax
   1855f2489:	4c 89 c1             	mov    rcx,r8
   1855f248c:	e8 8f 98 f5 01       	call   0x18754bd20
   1855f2491:	48 8b b5 c0 01 00 00 	mov    rsi,QWORD PTR [rbp+0x1c0]
   1855f2498:	48 85 f6             	test   rsi,rsi
   1855f249b:	74 1d                	je     0x1855f24ba
   1855f249d:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855f24a1:	75 17                	jne    0x1855f24ba
   1855f24a3:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855f24a6:	48 89 f1             	mov    rcx,rsi
   1855f24a9:	ff 10                	call   QWORD PTR [rax]
   1855f24ab:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855f24af:	75 09                	jne    0x1855f24ba
   1855f24b1:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855f24b4:	48 89 f1             	mov    rcx,rsi
   1855f24b7:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855f24ba:	48 8b 85 b0 01 00 00 	mov    rax,QWORD PTR [rbp+0x1b0]
   1855f24c1:	48 83 f8 10          	cmp    rax,0x10
   1855f24c5:	72 34                	jb     0x1855f24fb
   1855f24c7:	48 8b 8d 98 01 00 00 	mov    rcx,QWORD PTR [rbp+0x198]
   1855f24ce:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855f24d2:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855f24d9:	72 1b                	jb     0x1855f24f6
   1855f24db:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855f24df:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855f24e3:	4c 29 c1             	sub    rcx,r8
   1855f24e6:	48 83 f9 20          	cmp    rcx,0x20
   1855f24ea:	73 28                	jae    0x1855f2514
   1855f24ec:	48 83 c0 28          	add    rax,0x28
   1855f24f0:	48 89 c2             	mov    rdx,rax
   1855f24f3:	4c 89 c1             	mov    rcx,r8
   1855f24f6:	e8 25 98 f5 01       	call   0x18754bd20
   1855f24fb:	0f 28 b5 10 02 00 00 	movaps xmm6,XMMWORD PTR [rbp+0x210]
   1855f2502:	48 81 c4 a0 02 00 00 	add    rsp,0x2a0
   1855f2509:	5b                   	pop    rbx
   1855f250a:	5f                   	pop    rdi
   1855f250b:	5e                   	pop    rsi
   1855f250c:	41 5c                	pop    r12
   1855f250e:	41 5e                	pop    r14
   1855f2510:	41 5f                	pop    r15
   1855f2512:	5d                   	pop    rbp
   1855f2513:	c3                   	ret
   1855f2514:	e8 73 bc 0e 02       	call   0x1876de18c
   1855f2519:	cc                   	int3
