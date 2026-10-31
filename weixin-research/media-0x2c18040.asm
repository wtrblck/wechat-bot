
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

0000000182c18040 <.text+0x2c17040>:
   182c18040:	55                   	push   rbp
   182c18041:	41 57                	push   r15
   182c18043:	41 56                	push   r14
   182c18045:	41 55                	push   r13
   182c18047:	41 54                	push   r12
   182c18049:	56                   	push   rsi
   182c1804a:	57                   	push   rdi
   182c1804b:	53                   	push   rbx
   182c1804c:	48 81 ec 78 05 00 00 	sub    rsp,0x578
   182c18053:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   182c1805a:	00 
   182c1805b:	0f 29 b5 e0 04 00 00 	movaps XMMWORD PTR [rbp+0x4e0],xmm6
   182c18062:	48 c7 85 d8 04 00 00 	mov    QWORD PTR [rbp+0x4d8],0xfffffffffffffffe
   182c18069:	fe ff ff ff 
   182c1806d:	4c 89 cf             	mov    rdi,r9
   182c18070:	4c 89 c6             	mov    rsi,r8
   182c18073:	49 be aa aa aa aa aa 	movabs r14,0xaaaaaaaaaaaaaaaa
   182c1807a:	aa aa aa 
   182c1807d:	4c 89 32             	mov    QWORD PTR [rdx],r14
   182c18080:	c6 02 00             	mov    BYTE PTR [rdx],0x0
   182c18083:	0f 57 c0             	xorps  xmm0,xmm0
   182c18086:	0f 11 42 08          	movups XMMWORD PTR [rdx+0x8],xmm0
   182c1808a:	0f 11 42 18          	movups XMMWORD PTR [rdx+0x18],xmm0
   182c1808e:	48 c7 42 28 00 00 00 	mov    QWORD PTR [rdx+0x28],0x0
   182c18095:	00 
   182c18096:	48 89 95 d0 04 00 00 	mov    QWORD PTR [rbp+0x4d0],rdx
   182c1809d:	48 c7 42 30 0f 00 00 	mov    QWORD PTR [rdx+0x30],0xf
   182c180a4:	00 
   182c180a5:	0f 28 35 04 eb 2f 06 	movaps xmm6,XMMWORD PTR [rip+0x62feb04]        # 0x188f16bb0
   182c180ac:	0f 29 b5 30 03 00 00 	movaps XMMWORD PTR [rbp+0x330],xmm6
   182c180b3:	0f 29 b5 20 03 00 00 	movaps XMMWORD PTR [rbp+0x320],xmm6
   182c180ba:	0f 29 45 c0          	movaps XMMWORD PTR [rbp-0x40],xmm0
   182c180be:	48 c7 45 d0 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
   182c180c5:	00 
   182c180c6:	48 c7 45 d8 0f 00 00 	mov    QWORD PTR [rbp-0x28],0xf
   182c180cd:	00 
   182c180ce:	48 8d 8d 20 03 00 00 	lea    rcx,[rbp+0x320]
   182c180d5:	48 8d 5d c0          	lea    rbx,[rbp-0x40]
   182c180d9:	4c 89 ca             	mov    rdx,r9
   182c180dc:	49 89 d8             	mov    r8,rbx
   182c180df:	e8 2c 0a e2 fd       	call   0x180a38b10
   182c180e4:	90                   	nop
   182c180e5:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
   182c180e9:	48 83 f8 10          	cmp    rax,0x10
   182c180ed:	72 36                	jb     0x182c18125
   182c180ef:	48 8b 4d c0          	mov    rcx,QWORD PTR [rbp-0x40]
   182c180f3:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c180f7:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c180fe:	72 1f                	jb     0x182c1811f
   182c18100:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c18104:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c18108:	4c 29 c1             	sub    rcx,r8
   182c1810b:	48 83 f9 20          	cmp    rcx,0x20
   182c1810f:	0f 83 75 0e 00 00    	jae    0x182c18f8a
   182c18115:	48 83 c0 28          	add    rax,0x28
   182c18119:	48 89 c2             	mov    rdx,rax
   182c1811c:	4c 89 c1             	mov    rcx,r8
   182c1811f:	e8 fc 3b 93 04       	call   0x18754bd20
   182c18124:	90                   	nop
   182c18125:	48 8d 8d 20 03 00 00 	lea    rcx,[rbp+0x320]
   182c1812c:	e8 8f c3 78 fd       	call   0x1803a44c0
   182c18131:	90                   	nop
   182c18132:	84 c0                	test   al,al
   182c18134:	0f 84 a3 01 00 00    	je     0x182c182dd
   182c1813a:	b9 02 00 00 00       	mov    ecx,0x2
   182c1813f:	e8 9c 4c 45 fd       	call   0x18006cde0
   182c18144:	85 c0                	test   eax,eax
   182c18146:	0f 84 2a 01 00 00    	je     0x182c18276
   182c1814c:	48 8d bd 50 03 00 00 	lea    rdi,[rbp+0x350]
   182c18153:	48 89 f9             	mov    rcx,rdi
   182c18156:	e8 b5 4d 45 fd       	call   0x18006cf10
   182c1815b:	90                   	nop
   182c1815c:	48 83 bd 68 03 00 00 	cmp    QWORD PTR [rbp+0x368],0x10
   182c18163:	10 
   182c18164:	72 07                	jb     0x182c1816d
   182c18166:	48 8b bd 50 03 00 00 	mov    rdi,QWORD PTR [rbp+0x350]
   182c1816d:	48 8d 05 3c 60 95 06 	lea    rax,[rip+0x695603c]        # 0x18956e1b0
   182c18174:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182c18179:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182c18180:	00 00 
   182c18182:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182c18187:	c7 44 24 28 83 0a 00 	mov    DWORD PTR [rsp+0x28],0xa83
   182c1818e:	00 
   182c1818f:	4c 8d 0d d2 13 95 06 	lea    r9,[rip+0x69513d2]        # 0x189569568
   182c18196:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c1819a:	ba 02 00 00 00       	mov    edx,0x2
   182c1819f:	49 89 f8             	mov    r8,rdi
   182c181a2:	e8 c9 50 45 fd       	call   0x18006d270
   182c181a7:	90                   	nop
   182c181a8:	48 83 7e 18 10       	cmp    QWORD PTR [rsi+0x18],0x10
   182c181ad:	48 89 f0             	mov    rax,rsi
   182c181b0:	72 03                	jb     0x182c181b5
   182c181b2:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182c181b5:	48 89 85 a0 03 00 00 	mov    QWORD PTR [rbp+0x3a0],rax
   182c181bc:	c6 85 a8 03 00 00 00 	mov    BYTE PTR [rbp+0x3a8],0x0
   182c181c3:	0f 57 c0             	xorps  xmm0,xmm0
   182c181c6:	0f 11 85 a8 04 00 00 	movups XMMWORD PTR [rbp+0x4a8],xmm0
   182c181cd:	0f 11 85 98 04 00 00 	movups XMMWORD PTR [rbp+0x498],xmm0
   182c181d4:	0f 11 85 88 04 00 00 	movups XMMWORD PTR [rbp+0x488],xmm0
   182c181db:	0f 11 85 78 04 00 00 	movups XMMWORD PTR [rbp+0x478],xmm0
   182c181e2:	0f 11 85 68 04 00 00 	movups XMMWORD PTR [rbp+0x468],xmm0
   182c181e9:	0f 11 85 58 04 00 00 	movups XMMWORD PTR [rbp+0x458],xmm0
   182c181f0:	0f 11 85 48 04 00 00 	movups XMMWORD PTR [rbp+0x448],xmm0
   182c181f7:	48 c7 85 b8 04 00 00 	mov    QWORD PTR [rbp+0x4b8],0x0
   182c181fe:	00 00 00 00 
   182c18202:	48 8d 85 a0 03 00 00 	lea    rax,[rbp+0x3a0]
   182c18209:	48 89 85 40 04 00 00 	mov    QWORD PTR [rbp+0x440],rax
   182c18210:	48 8d 15 51 61 95 06 	lea    rdx,[rip+0x6956151]        # 0x18956e368
   182c18217:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c1821b:	4c 8d 85 40 04 00 00 	lea    r8,[rbp+0x440]
   182c18222:	e8 e9 55 45 fd       	call   0x18006d810
   182c18227:	90                   	nop
   182c18228:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c1822c:	e8 3f 51 45 fd       	call   0x18006d370
   182c18231:	48 8b 85 68 03 00 00 	mov    rax,QWORD PTR [rbp+0x368]
   182c18238:	48 83 f8 10          	cmp    rax,0x10
   182c1823c:	72 38                	jb     0x182c18276
   182c1823e:	48 8b 8d 50 03 00 00 	mov    rcx,QWORD PTR [rbp+0x350]
   182c18245:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c18249:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c18250:	72 1f                	jb     0x182c18271
   182c18252:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c18256:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c1825a:	4c 29 c1             	sub    rcx,r8
   182c1825d:	48 83 f9 20          	cmp    rcx,0x20
   182c18261:	0f 83 23 0d 00 00    	jae    0x182c18f8a
   182c18267:	48 83 c0 28          	add    rax,0x28
   182c1826b:	48 89 c2             	mov    rdx,rax
   182c1826e:	4c 89 c1             	mov    rcx,r8
   182c18271:	e8 aa 3a 93 04       	call   0x18754bd20
   182c18276:	0f 29 b5 c0 04 00 00 	movaps XMMWORD PTR [rbp+0x4c0],xmm6
   182c1827d:	48 8d 8d c0 04 00 00 	lea    rcx,[rbp+0x4c0]
   182c18284:	e8 77 93 16 ff       	call   0x181d81600
   182c18289:	90                   	nop
   182c1828a:	48 8b 85 c0 04 00 00 	mov    rax,QWORD PTR [rbp+0x4c0]
   182c18291:	c7 80 18 01 00 00 03 	mov    DWORD PTR [rax+0x118],0x3
   182c18298:	00 00 00 
   182c1829b:	48 8d b8 b0 00 00 00 	lea    rdi,[rax+0xb0]
   182c182a2:	48 39 f7             	cmp    rdi,rsi
   182c182a5:	0f 84 60 02 00 00    	je     0x182c1850b
   182c182ab:	48 8b 5e 10          	mov    rbx,QWORD PTR [rsi+0x10]
   182c182af:	48 83 7e 18 10       	cmp    QWORD PTR [rsi+0x18],0x10
   182c182b4:	49 89 f1             	mov    r9,rsi
   182c182b7:	72 03                	jb     0x182c182bc
   182c182b9:	4c 8b 0e             	mov    r9,QWORD PTR [rsi]
   182c182bc:	48 8b 88 c8 00 00 00 	mov    rcx,QWORD PTR [rax+0xc8]
   182c182c3:	48 39 cb             	cmp    rbx,rcx
   182c182c6:	0f 86 1d 02 00 00    	jbe    0x182c184e9
   182c182cc:	48 89 f9             	mov    rcx,rdi
   182c182cf:	48 89 da             	mov    rdx,rbx
   182c182d2:	e8 79 5e 42 fd       	call   0x18003e150
   182c182d7:	90                   	nop
   182c182d8:	e9 2e 02 00 00       	jmp    0x182c1850b
   182c182dd:	b9 04 00 00 00       	mov    ecx,0x4
   182c182e2:	e8 f9 4a 45 fd       	call   0x18006cde0
   182c182e7:	85 c0                	test   eax,eax
   182c182e9:	0f 84 a8 01 00 00    	je     0x182c18497
   182c182ef:	48 8d b5 d0 02 00 00 	lea    rsi,[rbp+0x2d0]
   182c182f6:	48 89 f1             	mov    rcx,rsi
   182c182f9:	e8 12 4c 45 fd       	call   0x18006cf10
   182c182fe:	90                   	nop
   182c182ff:	48 83 bd e8 02 00 00 	cmp    QWORD PTR [rbp+0x2e8],0x10
   182c18306:	10 
   182c18307:	72 07                	jb     0x182c18310
   182c18309:	48 8b b5 d0 02 00 00 	mov    rsi,QWORD PTR [rbp+0x2d0]
   182c18310:	48 8d 05 99 5e 95 06 	lea    rax,[rip+0x6955e99]        # 0x18956e1b0
   182c18317:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182c1831c:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182c18323:	00 00 
   182c18325:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182c1832a:	c7 44 24 28 7e 0a 00 	mov    DWORD PTR [rsp+0x28],0xa7e
   182c18331:	00 
   182c18332:	4c 8d 0d 2f 12 95 06 	lea    r9,[rip+0x695122f]        # 0x189569568
   182c18339:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c1833d:	ba 04 00 00 00       	mov    edx,0x4
   182c18342:	49 89 f0             	mov    r8,rsi
   182c18345:	e8 26 4f 45 fd       	call   0x18006d270
   182c1834a:	90                   	nop
   182c1834b:	48 8d 8d 20 03 00 00 	lea    rcx,[rbp+0x320]
   182c18352:	48 8d b5 00 04 00 00 	lea    rsi,[rbp+0x400]
   182c18359:	48 89 f2             	mov    rdx,rsi
   182c1835c:	e8 1f 77 48 fd       	call   0x18009fa80
   182c18361:	90                   	nop
   182c18362:	48 83 bd 18 04 00 00 	cmp    QWORD PTR [rbp+0x418],0x10
   182c18369:	10 
   182c1836a:	72 07                	jb     0x182c18373
   182c1836c:	48 8b b5 00 04 00 00 	mov    rsi,QWORD PTR [rbp+0x400]
   182c18373:	48 89 b5 a0 03 00 00 	mov    QWORD PTR [rbp+0x3a0],rsi
   182c1837a:	c6 85 a8 03 00 00 00 	mov    BYTE PTR [rbp+0x3a8],0x0
   182c18381:	48 83 7f 18 10       	cmp    QWORD PTR [rdi+0x18],0x10
   182c18386:	48 89 f8             	mov    rax,rdi
   182c18389:	72 03                	jb     0x182c1838e
   182c1838b:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c1838e:	48 89 85 50 03 00 00 	mov    QWORD PTR [rbp+0x350],rax
   182c18395:	c6 85 58 03 00 00 00 	mov    BYTE PTR [rbp+0x358],0x0
   182c1839c:	0f 57 c0             	xorps  xmm0,xmm0
   182c1839f:	0f 11 85 b0 04 00 00 	movups XMMWORD PTR [rbp+0x4b0],xmm0
   182c183a6:	0f 11 85 a0 04 00 00 	movups XMMWORD PTR [rbp+0x4a0],xmm0
   182c183ad:	0f 11 85 90 04 00 00 	movups XMMWORD PTR [rbp+0x490],xmm0
   182c183b4:	0f 11 85 80 04 00 00 	movups XMMWORD PTR [rbp+0x480],xmm0
   182c183bb:	0f 11 85 70 04 00 00 	movups XMMWORD PTR [rbp+0x470],xmm0
   182c183c2:	0f 11 85 60 04 00 00 	movups XMMWORD PTR [rbp+0x460],xmm0
   182c183c9:	0f 11 85 50 04 00 00 	movups XMMWORD PTR [rbp+0x450],xmm0
   182c183d0:	48 8d 85 50 03 00 00 	lea    rax,[rbp+0x350]
   182c183d7:	48 89 85 40 04 00 00 	mov    QWORD PTR [rbp+0x440],rax
   182c183de:	48 8d 85 a0 03 00 00 	lea    rax,[rbp+0x3a0]
   182c183e5:	48 89 85 48 04 00 00 	mov    QWORD PTR [rbp+0x448],rax
   182c183ec:	48 8d 15 bd 5e 95 06 	lea    rdx,[rip+0x6955ebd]        # 0x18956e2b0
   182c183f3:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c183f7:	4c 8d 85 40 04 00 00 	lea    r8,[rbp+0x440]
   182c183fe:	e8 0d 54 45 fd       	call   0x18006d810
   182c18403:	90                   	nop
   182c18404:	48 8b 85 18 04 00 00 	mov    rax,QWORD PTR [rbp+0x418]
   182c1840b:	48 83 f8 10          	cmp    rax,0x10
   182c1840f:	72 38                	jb     0x182c18449
   182c18411:	48 8b 8d 00 04 00 00 	mov    rcx,QWORD PTR [rbp+0x400]
   182c18418:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c1841c:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c18423:	72 1f                	jb     0x182c18444
   182c18425:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c18429:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c1842d:	4c 29 c1             	sub    rcx,r8
   182c18430:	48 83 f9 20          	cmp    rcx,0x20
   182c18434:	0f 83 50 0b 00 00    	jae    0x182c18f8a
   182c1843a:	48 83 c0 28          	add    rax,0x28
   182c1843e:	48 89 c2             	mov    rdx,rax
   182c18441:	4c 89 c1             	mov    rcx,r8
   182c18444:	e8 d7 38 93 04       	call   0x18754bd20
   182c18449:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c1844d:	e8 1e 4f 45 fd       	call   0x18006d370
   182c18452:	48 8b 85 e8 02 00 00 	mov    rax,QWORD PTR [rbp+0x2e8]
   182c18459:	48 83 f8 10          	cmp    rax,0x10
   182c1845d:	72 38                	jb     0x182c18497
   182c1845f:	48 8b 8d d0 02 00 00 	mov    rcx,QWORD PTR [rbp+0x2d0]
   182c18466:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c1846a:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c18471:	72 1f                	jb     0x182c18492
   182c18473:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c18477:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c1847b:	4c 29 c1             	sub    rcx,r8
   182c1847e:	48 83 f9 20          	cmp    rcx,0x20
   182c18482:	0f 83 02 0b 00 00    	jae    0x182c18f8a
   182c18488:	48 83 c0 28          	add    rax,0x28
   182c1848c:	48 89 c2             	mov    rdx,rax
   182c1848f:	4c 89 c1             	mov    rcx,r8
   182c18492:	e8 89 38 93 04       	call   0x18754bd20
   182c18497:	48 8b 77 10          	mov    rsi,QWORD PTR [rdi+0x10]
   182c1849b:	48 b8 ef ff ff ff ff 	movabs rax,0x7fffffffffffffef
   182c184a2:	ff ff 7f 
   182c184a5:	48 39 c6             	cmp    rsi,rax
   182c184a8:	0f 8d e2 0a 00 00    	jge    0x182c18f90
   182c184ae:	4c 8b 37             	mov    r14,QWORD PTR [rdi]
   182c184b1:	4c 8b 7f 18          	mov    r15,QWORD PTR [rdi+0x18]
   182c184b5:	0f 57 c0             	xorps  xmm0,xmm0
   182c184b8:	0f 29 45 c0          	movaps XMMWORD PTR [rbp-0x40],xmm0
   182c184bc:	4c 8d 66 11          	lea    r12,[rsi+0x11]
   182c184c0:	41 bd 0f 00 00 00    	mov    r13d,0xf
   182c184c6:	49 83 fc 10          	cmp    r12,0x10
   182c184ca:	0f 82 0a 0a 00 00    	jb     0x182c18eda
   182c184d0:	48 83 fe ef          	cmp    rsi,0xffffffffffffffef
   182c184d4:	0f 8d 9a 07 00 00    	jge    0x182c18c74
   182c184da:	49 bd ff ff ff ff ff 	movabs r13,0x7fffffffffffffff
   182c184e1:	ff ff 7f 
   182c184e4:	e9 ac 07 00 00       	jmp    0x182c18c95
   182c184e9:	48 83 f9 10          	cmp    rcx,0x10
   182c184ed:	72 03                	jb     0x182c184f2
   182c184ef:	48 8b 3f             	mov    rdi,QWORD PTR [rdi]
   182c184f2:	48 89 98 c0 00 00 00 	mov    QWORD PTR [rax+0xc0],rbx
   182c184f9:	48 89 f9             	mov    rcx,rdi
   182c184fc:	4c 89 ca             	mov    rdx,r9
   182c184ff:	49 89 d8             	mov    r8,rbx
   182c18502:	e8 39 c9 af 04       	call   0x187714e40
   182c18507:	c6 04 1f 00          	mov    BYTE PTR [rdi+rbx*1],0x0
   182c1850b:	b9 20 01 00 00       	mov    ecx,0x120
   182c18510:	48 03 8d c0 04 00 00 	add    rcx,QWORD PTR [rbp+0x4c0]
   182c18517:	48 8d 95 20 03 00 00 	lea    rdx,[rbp+0x320]
   182c1851e:	e8 bd 30 48 fd       	call   0x18009b5e0
   182c18523:	90                   	nop
   182c18524:	4c 89 b5 30 04 00 00 	mov    QWORD PTR [rbp+0x430],r14
   182c1852b:	0f 29 b5 20 04 00 00 	movaps XMMWORD PTR [rbp+0x420],xmm6
   182c18532:	0f 29 b5 10 04 00 00 	movaps XMMWORD PTR [rbp+0x410],xmm6
   182c18539:	0f 29 b5 00 04 00 00 	movaps XMMWORD PTR [rbp+0x400],xmm6
   182c18540:	48 8d bd a0 03 00 00 	lea    rdi,[rbp+0x3a0]
   182c18547:	48 89 f9             	mov    rcx,rdi
   182c1854a:	e8 d1 ec 42 fd       	call   0x180047220
   182c1854f:	90                   	nop
   182c18550:	48 8b 8d a0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3a0]
   182c18557:	48 8d 95 40 04 00 00 	lea    rdx,[rbp+0x440]
   182c1855e:	e8 6d 9e 76 fd       	call   0x1803823d0
   182c18563:	90                   	nop
   182c18564:	48 8b 8d 40 04 00 00 	mov    rcx,QWORD PTR [rbp+0x440]
   182c1856b:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   182c1856f:	e8 0c 0d af fd       	call   0x180709280
   182c18574:	90                   	nop
   182c18575:	48 8b 4d c0          	mov    rcx,QWORD PTR [rbp-0x40]
   182c18579:	0f 57 c0             	xorps  xmm0,xmm0
   182c1857c:	0f 29 85 40 03 00 00 	movaps XMMWORD PTR [rbp+0x340],xmm0
   182c18583:	48 8b 85 c8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4c8]
   182c1858a:	48 85 c0             	test   rax,rax
   182c1858d:	74 0d                	je     0x182c1859c
   182c1858f:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   182c18593:	48 8b 85 c8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4c8]
   182c1859a:	eb 02                	jmp    0x182c1859e
   182c1859c:	31 c0                	xor    eax,eax
   182c1859e:	48 8b 95 c0 04 00 00 	mov    rdx,QWORD PTR [rbp+0x4c0]
   182c185a5:	48 89 95 40 03 00 00 	mov    QWORD PTR [rbp+0x340],rdx
   182c185ac:	48 89 85 48 03 00 00 	mov    QWORD PTR [rbp+0x348],rax
   182c185b3:	48 8d 95 00 04 00 00 	lea    rdx,[rbp+0x400]
   182c185ba:	4c 8d 85 40 03 00 00 	lea    r8,[rbp+0x340]
   182c185c1:	e8 9a b5 b8 fe       	call   0x1817a3b60
   182c185c6:	90                   	nop
   182c185c7:	48 8b 5d c8          	mov    rbx,QWORD PTR [rbp-0x38]
   182c185cb:	48 85 db             	test   rbx,rbx
   182c185ce:	74 1d                	je     0x182c185ed
   182c185d0:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   182c185d4:	75 17                	jne    0x182c185ed
   182c185d6:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c185d9:	48 89 d9             	mov    rcx,rbx
   182c185dc:	ff 10                	call   QWORD PTR [rax]
   182c185de:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   182c185e2:	75 09                	jne    0x182c185ed
   182c185e4:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c185e7:	48 89 d9             	mov    rcx,rbx
   182c185ea:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c185ed:	48 8b 9d 48 04 00 00 	mov    rbx,QWORD PTR [rbp+0x448]
   182c185f4:	48 85 db             	test   rbx,rbx
   182c185f7:	74 1d                	je     0x182c18616
   182c185f9:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   182c185fd:	75 17                	jne    0x182c18616
   182c185ff:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c18602:	48 89 d9             	mov    rcx,rbx
   182c18605:	ff 10                	call   QWORD PTR [rax]
   182c18607:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   182c1860b:	75 09                	jne    0x182c18616
   182c1860d:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c18610:	48 89 d9             	mov    rcx,rbx
   182c18613:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c18616:	48 8b 9d a8 03 00 00 	mov    rbx,QWORD PTR [rbp+0x3a8]
   182c1861d:	48 85 db             	test   rbx,rbx
   182c18620:	74 1d                	je     0x182c1863f
   182c18622:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   182c18626:	75 17                	jne    0x182c1863f
   182c18628:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c1862b:	48 89 d9             	mov    rcx,rbx
   182c1862e:	ff 10                	call   QWORD PTR [rax]
   182c18630:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   182c18634:	75 09                	jne    0x182c1863f
   182c18636:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   182c18639:	48 89 d9             	mov    rcx,rbx
   182c1863c:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c1863f:	8b 85 04 04 00 00    	mov    eax,DWORD PTR [rbp+0x404]
   182c18645:	0b 85 00 04 00 00    	or     eax,DWORD PTR [rbp+0x400]
   182c1864b:	0f 84 f1 01 00 00    	je     0x182c18842
   182c18651:	b9 04 00 00 00       	mov    ecx,0x4
   182c18656:	e8 85 47 45 fd       	call   0x18006cde0
   182c1865b:	85 c0                	test   eax,eax
   182c1865d:	0f 84 84 01 00 00    	je     0x182c187e7
   182c18663:	48 8d b5 50 03 00 00 	lea    rsi,[rbp+0x350]
   182c1866a:	48 89 f1             	mov    rcx,rsi
   182c1866d:	e8 9e 48 45 fd       	call   0x18006cf10
   182c18672:	90                   	nop
   182c18673:	48 83 bd 68 03 00 00 	cmp    QWORD PTR [rbp+0x368],0x10
   182c1867a:	10 
   182c1867b:	72 07                	jb     0x182c18684
   182c1867d:	48 8b b5 50 03 00 00 	mov    rsi,QWORD PTR [rbp+0x350]
   182c18684:	48 8d 05 25 5b 95 06 	lea    rax,[rip+0x6955b25]        # 0x18956e1b0
   182c1868b:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182c18690:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182c18697:	00 00 
   182c18699:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182c1869e:	c7 44 24 28 8c 0a 00 	mov    DWORD PTR [rsp+0x28],0xa8c
   182c186a5:	00 
   182c186a6:	4c 8d 0d bb 0e 95 06 	lea    r9,[rip+0x6950ebb]        # 0x189569568
   182c186ad:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c186b1:	ba 04 00 00 00       	mov    edx,0x4
   182c186b6:	49 89 f0             	mov    r8,rsi
   182c186b9:	e8 b2 4b 45 fd       	call   0x18006d270
   182c186be:	90                   	nop
   182c186bf:	48 8d 8d 00 04 00 00 	lea    rcx,[rbp+0x400]
   182c186c6:	48 8d b5 d0 02 00 00 	lea    rsi,[rbp+0x2d0]
   182c186cd:	48 89 f2             	mov    rdx,rsi
   182c186d0:	e8 8b 85 4f fd       	call   0x180110c60
   182c186d5:	90                   	nop
   182c186d6:	48 83 bd e8 02 00 00 	cmp    QWORD PTR [rbp+0x2e8],0x10
   182c186dd:	10 
   182c186de:	72 07                	jb     0x182c186e7
   182c186e0:	48 8b b5 d0 02 00 00 	mov    rsi,QWORD PTR [rbp+0x2d0]
   182c186e7:	48 89 b5 a0 03 00 00 	mov    QWORD PTR [rbp+0x3a0],rsi
   182c186ee:	c6 85 a8 03 00 00 00 	mov    BYTE PTR [rbp+0x3a8],0x0
   182c186f5:	0f 57 c0             	xorps  xmm0,xmm0
   182c186f8:	0f 11 85 a8 04 00 00 	movups XMMWORD PTR [rbp+0x4a8],xmm0
   182c186ff:	0f 11 85 98 04 00 00 	movups XMMWORD PTR [rbp+0x498],xmm0
   182c18706:	0f 11 85 88 04 00 00 	movups XMMWORD PTR [rbp+0x488],xmm0
   182c1870d:	0f 11 85 78 04 00 00 	movups XMMWORD PTR [rbp+0x478],xmm0
   182c18714:	0f 11 85 68 04 00 00 	movups XMMWORD PTR [rbp+0x468],xmm0
   182c1871b:	0f 11 85 58 04 00 00 	movups XMMWORD PTR [rbp+0x458],xmm0
   182c18722:	0f 11 85 48 04 00 00 	movups XMMWORD PTR [rbp+0x448],xmm0
   182c18729:	48 c7 85 b8 04 00 00 	mov    QWORD PTR [rbp+0x4b8],0x0
   182c18730:	00 00 00 00 
   182c18734:	48 89 bd 40 04 00 00 	mov    QWORD PTR [rbp+0x440],rdi
   182c1873b:	48 8d 15 7e 5c 95 06 	lea    rdx,[rip+0x6955c7e]        # 0x18956e3c0
   182c18742:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c18746:	4c 8d 85 40 04 00 00 	lea    r8,[rbp+0x440]
   182c1874d:	e8 be 50 45 fd       	call   0x18006d810
   182c18752:	90                   	nop
   182c18753:	48 8b 85 e8 02 00 00 	mov    rax,QWORD PTR [rbp+0x2e8]
   182c1875a:	48 83 f8 10          	cmp    rax,0x10
   182c1875e:	72 38                	jb     0x182c18798
   182c18760:	48 8b 8d d0 02 00 00 	mov    rcx,QWORD PTR [rbp+0x2d0]
   182c18767:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c1876b:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c18772:	72 1f                	jb     0x182c18793
   182c18774:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c18778:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c1877c:	4c 29 c1             	sub    rcx,r8
   182c1877f:	48 83 f9 20          	cmp    rcx,0x20
   182c18783:	0f 83 01 08 00 00    	jae    0x182c18f8a
   182c18789:	48 83 c0 28          	add    rax,0x28
   182c1878d:	48 89 c2             	mov    rdx,rax
   182c18790:	4c 89 c1             	mov    rcx,r8
   182c18793:	e8 88 35 93 04       	call   0x18754bd20
   182c18798:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c1879c:	e8 cf 4b 45 fd       	call   0x18006d370
   182c187a1:	48 8b 85 68 03 00 00 	mov    rax,QWORD PTR [rbp+0x368]
   182c187a8:	48 83 f8 10          	cmp    rax,0x10
   182c187ac:	72 39                	jb     0x182c187e7
   182c187ae:	48 8b 8d 50 03 00 00 	mov    rcx,QWORD PTR [rbp+0x350]
   182c187b5:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c187b9:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c187c0:	72 1f                	jb     0x182c187e1
   182c187c2:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c187c6:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c187ca:	4c 29 c1             	sub    rcx,r8
   182c187cd:	48 83 f9 20          	cmp    rcx,0x20
   182c187d1:	0f 83 b3 07 00 00    	jae    0x182c18f8a
   182c187d7:	48 83 c0 28          	add    rax,0x28
   182c187db:	48 89 c2             	mov    rdx,rax
   182c187de:	4c 89 c1             	mov    rcx,r8
   182c187e1:	e8 3a 35 93 04       	call   0x18754bd20
   182c187e6:	90                   	nop
   182c187e7:	48 8d 8d 00 04 00 00 	lea    rcx,[rbp+0x400]
   182c187ee:	48 8d 75 c0          	lea    rsi,[rbp-0x40]
   182c187f2:	48 89 f2             	mov    rdx,rsi
   182c187f5:	e8 66 84 4f fd       	call   0x180110c60
   182c187fa:	90                   	nop
   182c187fb:	4c 8b 45 d0          	mov    r8,QWORD PTR [rbp-0x30]
   182c187ff:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
   182c18803:	48 89 c1             	mov    rcx,rax
   182c18806:	4c 29 c1             	sub    rcx,r8
   182c18809:	48 83 f9 13          	cmp    rcx,0x13
   182c1880d:	0f 83 ac 04 00 00    	jae    0x182c18cbf
   182c18813:	48 8d 05 be 93 94 06 	lea    rax,[rip+0x69493be]        # 0x189561bd8
   182c1881a:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182c1881f:	48 c7 44 24 28 13 00 	mov    QWORD PTR [rsp+0x28],0x13
   182c18826:	00 00 
   182c18828:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c1882c:	ba 13 00 00 00       	mov    edx,0x13
   182c18831:	45 31 c9             	xor    r9d,r9d
   182c18834:	e8 17 35 3f fd       	call   0x18000bd50
   182c18839:	90                   	nop
   182c1883a:	48 89 c6             	mov    rsi,rax
   182c1883d:	e9 0d 05 00 00       	jmp    0x182c18d4f
   182c18842:	48 8b 85 d0 04 00 00 	mov    rax,QWORD PTR [rbp+0x4d0]
   182c18849:	48 8d 58 08          	lea    rbx,[rax+0x8]
   182c1884d:	c6 00 01             	mov    BYTE PTR [rax],0x1
   182c18850:	4c 89 b5 f0 03 00 00 	mov    QWORD PTR [rbp+0x3f0],r14
   182c18857:	0f 29 b5 e0 03 00 00 	movaps XMMWORD PTR [rbp+0x3e0],xmm6
   182c1885e:	0f 29 b5 d0 03 00 00 	movaps XMMWORD PTR [rbp+0x3d0],xmm6
   182c18865:	0f 29 b5 c0 03 00 00 	movaps XMMWORD PTR [rbp+0x3c0],xmm6
   182c1886c:	0f 29 b5 b0 03 00 00 	movaps XMMWORD PTR [rbp+0x3b0],xmm6
   182c18873:	0f 29 b5 a0 03 00 00 	movaps XMMWORD PTR [rbp+0x3a0],xmm6
   182c1887a:	48 8b 95 28 04 00 00 	mov    rdx,QWORD PTR [rbp+0x428]
   182c18881:	c6 85 f0 03 00 00 00 	mov    BYTE PTR [rbp+0x3f0],0x0
   182c18888:	80 7a 50 01          	cmp    BYTE PTR [rdx+0x50],0x1
   182c1888c:	0f 85 2d 01 00 00    	jne    0x182c189bf
   182c18892:	48 8d 8d a0 03 00 00 	lea    rcx,[rbp+0x3a0]
   182c18899:	e8 32 4f b6 fd       	call   0x18077d7d0
   182c1889e:	90                   	nop
   182c1889f:	c6 85 f0 03 00 00 01 	mov    BYTE PTR [rbp+0x3f0],0x1
   182c188a6:	8b 85 c0 03 00 00    	mov    eax,DWORD PTR [rbp+0x3c0]
   182c188ac:	48 8b 8d d0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4d0]
   182c188b3:	48 89 41 10          	mov    QWORD PTR [rcx+0x10],rax
   182c188b7:	48 8d 15 fa a8 48 06 	lea    rdx,[rip+0x648a8fa]        # 0x1890a31b8
   182c188be:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c188c2:	41 b8 f0 02 00 00    	mov    r8d,0x2f0
   182c188c8:	e8 73 c5 af 04       	call   0x187714e40
   182c188cd:	90                   	nop
   182c188ce:	48 8d 8d d0 02 00 00 	lea    rcx,[rbp+0x2d0]
   182c188d5:	e8 46 e9 42 fd       	call   0x180047220
   182c188da:	90                   	nop
   182c188db:	48 8b 8d d0 02 00 00 	mov    rcx,QWORD PTR [rbp+0x2d0]
   182c188e2:	48 8d 95 50 03 00 00 	lea    rdx,[rbp+0x350]
   182c188e9:	e8 e2 9a 76 fd       	call   0x1803823d0
   182c188ee:	90                   	nop
   182c188ef:	48 8b 8d 50 03 00 00 	mov    rcx,QWORD PTR [rbp+0x350]
   182c188f6:	48 8d 95 40 04 00 00 	lea    rdx,[rbp+0x440]
   182c188fd:	e8 7e 09 af fd       	call   0x180709280
   182c18902:	90                   	nop
   182c18903:	48 8b 8d 40 04 00 00 	mov    rcx,QWORD PTR [rbp+0x440]
   182c1890a:	8b 85 c0 03 00 00    	mov    eax,DWORD PTR [rbp+0x3c0]
   182c18910:	44 8b 8d c4 03 00 00 	mov    r9d,DWORD PTR [rbp+0x3c4]
   182c18917:	89 44 24 20          	mov    DWORD PTR [rsp+0x20],eax
   182c1891b:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   182c1891f:	49 89 f0             	mov    r8,rsi
   182c18922:	e8 69 12 ba fe       	call   0x1817b9b90
   182c18927:	90                   	nop
   182c18928:	48 8b bd 48 04 00 00 	mov    rdi,QWORD PTR [rbp+0x448]
   182c1892f:	48 85 ff             	test   rdi,rdi
   182c18932:	74 1d                	je     0x182c18951
   182c18934:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   182c18938:	75 17                	jne    0x182c18951
   182c1893a:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c1893d:	48 89 f9             	mov    rcx,rdi
   182c18940:	ff 10                	call   QWORD PTR [rax]
   182c18942:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   182c18946:	75 09                	jne    0x182c18951
   182c18948:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c1894b:	48 89 f9             	mov    rcx,rdi
   182c1894e:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c18951:	48 8b bd 58 03 00 00 	mov    rdi,QWORD PTR [rbp+0x358]
   182c18958:	48 85 ff             	test   rdi,rdi
   182c1895b:	74 1d                	je     0x182c1897a
   182c1895d:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   182c18961:	75 17                	jne    0x182c1897a
   182c18963:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c18966:	48 89 f9             	mov    rcx,rdi
   182c18969:	ff 10                	call   QWORD PTR [rax]
   182c1896b:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   182c1896f:	75 09                	jne    0x182c1897a
   182c18971:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c18974:	48 89 f9             	mov    rcx,rdi
   182c18977:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c1897a:	48 8b bd d8 02 00 00 	mov    rdi,QWORD PTR [rbp+0x2d8]
   182c18981:	48 85 ff             	test   rdi,rdi
   182c18984:	74 1d                	je     0x182c189a3
   182c18986:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   182c1898a:	75 17                	jne    0x182c189a3
   182c1898c:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c1898f:	48 89 f9             	mov    rcx,rdi
   182c18992:	ff 10                	call   QWORD PTR [rax]
   182c18994:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   182c18998:	75 09                	jne    0x182c189a3
   182c1899a:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   182c1899d:	48 89 f9             	mov    rcx,rdi
   182c189a0:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c189a3:	80 bd a8 02 00 00 00 	cmp    BYTE PTR [rbp+0x2a8],0x0
   182c189aa:	74 13                	je     0x182c189bf
   182c189ac:	48 8b 85 08 01 00 00 	mov    rax,QWORD PTR [rbp+0x108]
   182c189b3:	48 89 03             	mov    QWORD PTR [rbx],rax
   182c189b6:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c189ba:	e8 81 3c 5b fd       	call   0x1801cc640
   182c189bf:	b9 02 00 00 00       	mov    ecx,0x2
   182c189c4:	e8 17 44 45 fd       	call   0x18006cde0
   182c189c9:	85 c0                	test   eax,eax
   182c189cb:	0f 84 00 02 00 00    	je     0x182c18bd1
   182c189d1:	48 8d bd b0 02 00 00 	lea    rdi,[rbp+0x2b0]
   182c189d8:	48 89 f9             	mov    rcx,rdi
   182c189db:	e8 30 45 45 fd       	call   0x18006cf10
   182c189e0:	90                   	nop
   182c189e1:	48 83 bd c8 02 00 00 	cmp    QWORD PTR [rbp+0x2c8],0x10
   182c189e8:	10 
   182c189e9:	72 07                	jb     0x182c189f2
   182c189eb:	48 8b bd b0 02 00 00 	mov    rdi,QWORD PTR [rbp+0x2b0]
   182c189f2:	48 8d 05 b7 57 95 06 	lea    rax,[rip+0x69557b7]        # 0x18956e1b0
   182c189f9:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   182c189fe:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   182c18a05:	00 00 
   182c18a07:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   182c18a0c:	c7 44 24 28 9a 0a 00 	mov    DWORD PTR [rsp+0x28],0xa9a
   182c18a13:	00 
   182c18a14:	4c 8d 0d 4d 0b 95 06 	lea    r9,[rip+0x6950b4d]        # 0x189569568
   182c18a1b:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c18a1f:	ba 02 00 00 00       	mov    edx,0x2
   182c18a24:	49 89 f8             	mov    r8,rdi
   182c18a27:	e8 44 48 45 fd       	call   0x18006d270
   182c18a2c:	90                   	nop
   182c18a2d:	4c 8b 0b             	mov    r9,QWORD PTR [rbx]
   182c18a30:	48 c7 85 50 03 00 00 	mov    QWORD PTR [rbp+0x350],0x0
   182c18a37:	00 00 00 00 
   182c18a3b:	41 b8 08 00 00 00    	mov    r8d,0x8
   182c18a41:	49 ba 67 66 66 66 66 	movabs r10,0x6666666666666667
   182c18a48:	66 66 66 
   182c18a4b:	4c 8d 1d 1e e8 2f 06 	lea    r11,[rip+0x62fe81e]        # 0x188f17270
   182c18a52:	4c 89 c9             	mov    rcx,r9
   182c18a55:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
   182c18a5c:	00 00 00 00 
   182c18a60:	48 89 c8             	mov    rax,rcx
   182c18a63:	49 f7 ea             	imul   r10
   182c18a66:	48 89 d0             	mov    rax,rdx
   182c18a69:	48 c1 e8 3f          	shr    rax,0x3f
   182c18a6d:	48 c1 fa 02          	sar    rdx,0x2
   182c18a71:	48 01 c2             	add    rdx,rax
   182c18a74:	48 8d 04 12          	lea    rax,[rdx+rdx*1]
   182c18a78:	48 8d 04 80          	lea    rax,[rax+rax*4]
   182c18a7c:	4c 89 df             	mov    rdi,r11
   182c18a7f:	48 29 c7             	sub    rdi,rax
   182c18a82:	0f b6 44 0f 23       	movzx  eax,BYTE PTR [rdi+rcx*1+0x23]
   182c18a87:	42 88 84 05 50 03 00 	mov    BYTE PTR [rbp+r8*1+0x350],al
   182c18a8e:	00 
   182c18a8f:	49 ff c0             	inc    r8
   182c18a92:	48 83 c1 09          	add    rcx,0x9
   182c18a96:	48 83 f9 12          	cmp    rcx,0x12
   182c18a9a:	48 89 d1             	mov    rcx,rdx
   182c18a9d:	77 c1                	ja     0x182c18a60
   182c18a9f:	4d 85 c9             	test   r9,r9
   182c18aa2:	79 0c                	jns    0x182c18ab0
   182c18aa4:	42 c6 84 05 50 03 00 	mov    BYTE PTR [rbp+r8*1+0x350],0x2d
   182c18aab:	00 2d 
   182c18aad:	49 ff c0             	inc    r8
   182c18ab0:	48 8d 85 58 03 00 00 	lea    rax,[rbp+0x358]
   182c18ab7:	42 c6 84 05 50 03 00 	mov    BYTE PTR [rbp+r8*1+0x350],0x0
   182c18abe:	00 00 
   182c18ac0:	49 83 f8 0a          	cmp    r8,0xa
   182c18ac4:	7c 36                	jl     0x182c18afc
   182c18ac6:	49 8d 0c 28          	lea    rcx,[r8+rbp*1]
   182c18aca:	48 81 c1 50 03 00 00 	add    rcx,0x350
   182c18ad1:	48 ff c9             	dec    rcx
   182c18ad4:	48 8d 95 59 03 00 00 	lea    rdx,[rbp+0x359]
   182c18adb:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
   182c18ae0:	44 0f b6 01          	movzx  r8d,BYTE PTR [rcx]
   182c18ae4:	44 0f b6 4a ff       	movzx  r9d,BYTE PTR [rdx-0x1]
   182c18ae9:	44 88 09             	mov    BYTE PTR [rcx],r9b
   182c18aec:	44 88 42 ff          	mov    BYTE PTR [rdx-0x1],r8b
   182c18af0:	48 ff c9             	dec    rcx
   182c18af3:	48 39 ca             	cmp    rdx,rcx
   182c18af6:	48 8d 52 01          	lea    rdx,[rdx+0x1]
   182c18afa:	72 e4                	jb     0x182c18ae0
   182c18afc:	48 89 85 50 03 00 00 	mov    QWORD PTR [rbp+0x350],rax
   182c18b03:	48 83 7e 18 10       	cmp    QWORD PTR [rsi+0x18],0x10
   182c18b08:	72 03                	jb     0x182c18b0d
   182c18b0a:	48 8b 36             	mov    rsi,QWORD PTR [rsi]
   182c18b0d:	48 89 b5 d0 02 00 00 	mov    QWORD PTR [rbp+0x2d0],rsi
   182c18b14:	c6 85 d8 02 00 00 00 	mov    BYTE PTR [rbp+0x2d8],0x0
   182c18b1b:	0f 57 c0             	xorps  xmm0,xmm0
   182c18b1e:	0f 11 85 b0 04 00 00 	movups XMMWORD PTR [rbp+0x4b0],xmm0
   182c18b25:	0f 11 85 a0 04 00 00 	movups XMMWORD PTR [rbp+0x4a0],xmm0
   182c18b2c:	0f 11 85 90 04 00 00 	movups XMMWORD PTR [rbp+0x490],xmm0
   182c18b33:	0f 11 85 80 04 00 00 	movups XMMWORD PTR [rbp+0x480],xmm0
   182c18b3a:	0f 11 85 70 04 00 00 	movups XMMWORD PTR [rbp+0x470],xmm0
   182c18b41:	0f 11 85 60 04 00 00 	movups XMMWORD PTR [rbp+0x460],xmm0
   182c18b48:	0f 11 85 50 04 00 00 	movups XMMWORD PTR [rbp+0x450],xmm0
   182c18b4f:	48 8d 85 d0 02 00 00 	lea    rax,[rbp+0x2d0]
   182c18b56:	48 89 85 40 04 00 00 	mov    QWORD PTR [rbp+0x440],rax
   182c18b5d:	48 8d 85 50 03 00 00 	lea    rax,[rbp+0x350]
   182c18b64:	48 89 85 48 04 00 00 	mov    QWORD PTR [rbp+0x448],rax
   182c18b6b:	48 8d 15 7e 58 95 06 	lea    rdx,[rip+0x695587e]        # 0x18956e3f0
   182c18b72:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c18b76:	4c 8d 85 40 04 00 00 	lea    r8,[rbp+0x440]
   182c18b7d:	e8 8e 4c 45 fd       	call   0x18006d810
   182c18b82:	90                   	nop
   182c18b83:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   182c18b87:	e8 e4 47 45 fd       	call   0x18006d370
   182c18b8c:	48 8b 85 c8 02 00 00 	mov    rax,QWORD PTR [rbp+0x2c8]
   182c18b93:	48 83 f8 10          	cmp    rax,0x10
   182c18b97:	72 38                	jb     0x182c18bd1
   182c18b99:	48 8b 8d b0 02 00 00 	mov    rcx,QWORD PTR [rbp+0x2b0]
   182c18ba0:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c18ba4:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c18bab:	72 1f                	jb     0x182c18bcc
   182c18bad:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c18bb1:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c18bb5:	4c 29 c1             	sub    rcx,r8
   182c18bb8:	48 83 f9 20          	cmp    rcx,0x20
   182c18bbc:	0f 83 c8 03 00 00    	jae    0x182c18f8a
   182c18bc2:	48 83 c0 28          	add    rax,0x28
   182c18bc6:	48 89 c2             	mov    rdx,rax
   182c18bc9:	4c 89 c1             	mov    rcx,r8
   182c18bcc:	e8 4f 31 93 04       	call   0x18754bd20
   182c18bd1:	80 bd f0 03 00 00 01 	cmp    BYTE PTR [rbp+0x3f0],0x1
   182c18bd8:	0f 85 8a 00 00 00    	jne    0x182c18c68
   182c18bde:	48 8b 85 e8 03 00 00 	mov    rax,QWORD PTR [rbp+0x3e8]
   182c18be5:	48 83 f8 10          	cmp    rax,0x10
   182c18be9:	72 38                	jb     0x182c18c23
   182c18beb:	48 8b 8d d0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3d0]
   182c18bf2:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c18bf6:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c18bfd:	72 1f                	jb     0x182c18c1e
   182c18bff:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c18c03:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c18c07:	4c 29 c1             	sub    rcx,r8
   182c18c0a:	48 83 f9 20          	cmp    rcx,0x20
   182c18c0e:	0f 83 76 03 00 00    	jae    0x182c18f8a
   182c18c14:	48 83 c0 28          	add    rax,0x28
   182c18c18:	48 89 c2             	mov    rdx,rax
   182c18c1b:	4c 89 c1             	mov    rcx,r8
   182c18c1e:	e8 fd 30 93 04       	call   0x18754bd20
   182c18c23:	48 8b 85 b8 03 00 00 	mov    rax,QWORD PTR [rbp+0x3b8]
   182c18c2a:	48 83 f8 10          	cmp    rax,0x10
   182c18c2e:	72 38                	jb     0x182c18c68
   182c18c30:	48 8b 8d a0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3a0]
   182c18c37:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c18c3b:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c18c42:	72 1f                	jb     0x182c18c63
   182c18c44:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c18c48:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c18c4c:	4c 29 c1             	sub    rcx,r8
   182c18c4f:	48 83 f9 20          	cmp    rcx,0x20
   182c18c53:	0f 83 31 03 00 00    	jae    0x182c18f8a
   182c18c59:	48 83 c0 28          	add    rax,0x28
   182c18c5d:	48 89 c2             	mov    rdx,rax
   182c18c60:	4c 89 c1             	mov    rcx,r8
   182c18c63:	e8 b8 30 93 04       	call   0x18754bd20
   182c18c68:	48 8b bd d0 04 00 00 	mov    rdi,QWORD PTR [rbp+0x4d0]
   182c18c6f:	e9 ad 01 00 00       	jmp    0x182c18e21
   182c18c74:	4c 89 e0             	mov    rax,r12
   182c18c77:	48 83 c8 0f          	or     rax,0xf
   182c18c7b:	48 83 f8 17          	cmp    rax,0x17
   182c18c7f:	41 bd 16 00 00 00    	mov    r13d,0x16
   182c18c85:	4c 0f 43 e8          	cmovae r13,rax
   182c18c89:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   182c18c8f:	0f 82 34 02 00 00    	jb     0x182c18ec9
   182c18c95:	49 8d 4d 28          	lea    rcx,[r13+0x28]
   182c18c99:	e8 3e 30 93 04       	call   0x18754bcdc
   182c18c9e:	90                   	nop
   182c18c9f:	48 89 c3             	mov    rbx,rax
   182c18ca2:	48 85 c0             	test   rax,rax
   182c18ca5:	0f 84 df 02 00 00    	je     0x182c18f8a
   182c18cab:	48 89 d8             	mov    rax,rbx
   182c18cae:	48 83 c3 27          	add    rbx,0x27
   182c18cb2:	48 83 e3 e0          	and    rbx,0xffffffffffffffe0
   182c18cb6:	48 89 43 f8          	mov    QWORD PTR [rbx-0x8],rax
   182c18cba:	e9 17 02 00 00       	jmp    0x182c18ed6
   182c18cbf:	49 8d 48 13          	lea    rcx,[r8+0x13]
   182c18cc3:	48 89 4d d0          	mov    QWORD PTR [rbp-0x30],rcx
   182c18cc7:	48 83 f8 10          	cmp    rax,0x10
   182c18ccb:	48 8b 4d c0          	mov    rcx,QWORD PTR [rbp-0x40]
   182c18ccf:	48 89 f7             	mov    rdi,rsi
   182c18cd2:	48 0f 43 f9          	cmovae rdi,rcx
   182c18cd6:	48 8d 15 0e 8f 94 06 	lea    rdx,[rip+0x6948f0e]        # 0x189561beb
   182c18cdd:	48 39 d7             	cmp    rdi,rdx
   182c18ce0:	0f 93 c2             	setae  dl
   182c18ce3:	48 8d 1d ee 8e 94 06 	lea    rbx,[rip+0x6948eee]        # 0x189561bd8
   182c18cea:	4e 8d 0c 07          	lea    r9,[rdi+r8*1]
   182c18cee:	49 39 d9             	cmp    r9,rbx
   182c18cf1:	41 0f 92 c1          	setb   r9b
   182c18cf5:	41 08 d1             	or     r9b,dl
   182c18cf8:	41 be 13 00 00 00    	mov    r14d,0x13
   182c18cfe:	41 bf 13 00 00 00    	mov    r15d,0x13
   182c18d04:	75 0b                	jne    0x182c18d11
   182c18d06:	49 89 ff             	mov    r15,rdi
   182c18d09:	49 29 df             	sub    r15,rbx
   182c18d0c:	77 03                	ja     0x182c18d11
   182c18d0e:	45 31 ff             	xor    r15d,r15d
   182c18d11:	49 ff c0             	inc    r8
   182c18d14:	48 83 f8 10          	cmp    rax,0x10
   182c18d18:	48 0f 42 ce          	cmovb  rcx,rsi
   182c18d1c:	48 83 c1 13          	add    rcx,0x13
   182c18d20:	48 89 fa             	mov    rdx,rdi
   182c18d23:	e8 18 c1 af 04       	call   0x187714e40
   182c18d28:	48 89 f9             	mov    rcx,rdi
   182c18d2b:	48 89 da             	mov    rdx,rbx
   182c18d2e:	4d 89 f8             	mov    r8,r15
   182c18d31:	e8 0a c1 af 04       	call   0x187714e40
   182c18d36:	4d 29 fe             	sub    r14,r15
   182c18d39:	49 8d 14 1f          	lea    rdx,[r15+rbx*1]
   182c18d3d:	48 83 c2 13          	add    rdx,0x13
   182c18d41:	4c 01 ff             	add    rdi,r15
   182c18d44:	48 89 f9             	mov    rcx,rdi
   182c18d47:	4d 89 f0             	mov    r8,r14
   182c18d4a:	e8 f1 c0 af 04       	call   0x187714e40
   182c18d4f:	0f b6 1e             	movzx  ebx,BYTE PTR [rsi]
   182c18d52:	48 8b 46 08          	mov    rax,QWORD PTR [rsi+0x8]
   182c18d56:	48 89 85 47 04 00 00 	mov    QWORD PTR [rbp+0x447],rax
   182c18d5d:	48 8b 46 01          	mov    rax,QWORD PTR [rsi+0x1]
   182c18d61:	48 89 85 40 04 00 00 	mov    QWORD PTR [rbp+0x440],rax
   182c18d68:	0f 10 76 10          	movups xmm6,XMMWORD PTR [rsi+0x10]
   182c18d6c:	48 c7 46 10 00 00 00 	mov    QWORD PTR [rsi+0x10],0x0
   182c18d73:	00 
   182c18d74:	48 c7 46 18 0f 00 00 	mov    QWORD PTR [rsi+0x18],0xf
   182c18d7b:	00 
   182c18d7c:	c6 06 00             	mov    BYTE PTR [rsi],0x0
   182c18d7f:	48 8b bd d0 04 00 00 	mov    rdi,QWORD PTR [rbp+0x4d0]
   182c18d86:	48 8b 47 30          	mov    rax,QWORD PTR [rdi+0x30]
   182c18d8a:	48 83 f8 10          	cmp    rax,0x10
   182c18d8e:	72 35                	jb     0x182c18dc5
   182c18d90:	48 8b 4f 18          	mov    rcx,QWORD PTR [rdi+0x18]
   182c18d94:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c18d98:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c18d9f:	72 1f                	jb     0x182c18dc0
   182c18da1:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c18da5:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c18da9:	4c 29 c1             	sub    rcx,r8
   182c18dac:	48 83 f9 20          	cmp    rcx,0x20
   182c18db0:	0f 83 d4 01 00 00    	jae    0x182c18f8a
   182c18db6:	48 83 c0 28          	add    rax,0x28
   182c18dba:	48 89 c2             	mov    rdx,rax
   182c18dbd:	4c 89 c1             	mov    rcx,r8
   182c18dc0:	e8 5b 2f 93 04       	call   0x18754bd20
   182c18dc5:	88 5f 18             	mov    BYTE PTR [rdi+0x18],bl
   182c18dc8:	48 8b 85 40 04 00 00 	mov    rax,QWORD PTR [rbp+0x440]
   182c18dcf:	48 8b 8d 47 04 00 00 	mov    rcx,QWORD PTR [rbp+0x447]
   182c18dd6:	48 89 47 19          	mov    QWORD PTR [rdi+0x19],rax
   182c18dda:	48 89 4f 20          	mov    QWORD PTR [rdi+0x20],rcx
   182c18dde:	0f 11 77 28          	movups XMMWORD PTR [rdi+0x28],xmm6
   182c18de2:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
   182c18de6:	48 83 f8 10          	cmp    rax,0x10
   182c18dea:	72 35                	jb     0x182c18e21
   182c18dec:	48 8b 4d c0          	mov    rcx,QWORD PTR [rbp-0x40]
   182c18df0:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c18df4:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c18dfb:	72 1f                	jb     0x182c18e1c
   182c18dfd:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c18e01:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c18e05:	4c 29 c1             	sub    rcx,r8
   182c18e08:	48 83 f9 20          	cmp    rcx,0x20
   182c18e0c:	0f 83 78 01 00 00    	jae    0x182c18f8a
   182c18e12:	48 83 c0 28          	add    rax,0x28
   182c18e16:	48 89 c2             	mov    rdx,rax
   182c18e19:	4c 89 c1             	mov    rcx,r8
   182c18e1c:	e8 ff 2e 93 04       	call   0x18754bd20
   182c18e21:	48 8b b5 30 04 00 00 	mov    rsi,QWORD PTR [rbp+0x430]
   182c18e28:	48 85 f6             	test   rsi,rsi
   182c18e2b:	74 1d                	je     0x182c18e4a
   182c18e2d:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182c18e31:	75 17                	jne    0x182c18e4a
   182c18e33:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182c18e36:	48 89 f1             	mov    rcx,rsi
   182c18e39:	ff 10                	call   QWORD PTR [rax]
   182c18e3b:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182c18e3f:	75 09                	jne    0x182c18e4a
   182c18e41:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182c18e44:	48 89 f1             	mov    rcx,rsi
   182c18e47:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c18e4a:	48 8b 85 20 04 00 00 	mov    rax,QWORD PTR [rbp+0x420]
   182c18e51:	48 83 f8 10          	cmp    rax,0x10
   182c18e55:	72 38                	jb     0x182c18e8f
   182c18e57:	48 8b 8d 08 04 00 00 	mov    rcx,QWORD PTR [rbp+0x408]
   182c18e5e:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c18e62:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c18e69:	72 1f                	jb     0x182c18e8a
   182c18e6b:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c18e6f:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c18e73:	4c 29 c1             	sub    rcx,r8
   182c18e76:	48 83 f9 20          	cmp    rcx,0x20
   182c18e7a:	0f 83 0a 01 00 00    	jae    0x182c18f8a
   182c18e80:	48 83 c0 28          	add    rax,0x28
   182c18e84:	48 89 c2             	mov    rdx,rax
   182c18e87:	4c 89 c1             	mov    rcx,r8
   182c18e8a:	e8 91 2e 93 04       	call   0x18754bd20
   182c18e8f:	48 8b b5 c8 04 00 00 	mov    rsi,QWORD PTR [rbp+0x4c8]
   182c18e96:	48 85 f6             	test   rsi,rsi
   182c18e99:	0f 84 c1 00 00 00    	je     0x182c18f60
   182c18e9f:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   182c18ea3:	0f 85 b7 00 00 00    	jne    0x182c18f60
   182c18ea9:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182c18eac:	48 89 f1             	mov    rcx,rsi
   182c18eaf:	ff 10                	call   QWORD PTR [rax]
   182c18eb1:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   182c18eb5:	0f 85 a5 00 00 00    	jne    0x182c18f60
   182c18ebb:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   182c18ebe:	48 89 f1             	mov    rcx,rsi
   182c18ec1:	ff 50 08             	call   QWORD PTR [rax+0x8]
   182c18ec4:	e9 97 00 00 00       	jmp    0x182c18f60
   182c18ec9:	49 8d 4d 01          	lea    rcx,[r13+0x1]
   182c18ecd:	e8 0a 2e 93 04       	call   0x18754bcdc
   182c18ed2:	90                   	nop
   182c18ed3:	48 89 c3             	mov    rbx,rax
   182c18ed6:	48 89 5d c0          	mov    QWORD PTR [rbp-0x40],rbx
   182c18eda:	49 83 ff 10          	cmp    r15,0x10
   182c18ede:	49 0f 43 fe          	cmovae rdi,r14
   182c18ee2:	4c 89 65 d0          	mov    QWORD PTR [rbp-0x30],r12
   182c18ee6:	4c 89 6d d8          	mov    QWORD PTR [rbp-0x28],r13
   182c18eea:	0f 10 05 cf 8c 94 06 	movups xmm0,XMMWORD PTR [rip+0x6948ccf]        # 0x189561bc0
   182c18ef1:	0f 11 03             	movups XMMWORD PTR [rbx],xmm0
   182c18ef4:	c6 43 10 20          	mov    BYTE PTR [rbx+0x10],0x20
   182c18ef8:	48 8d 4b 11          	lea    rcx,[rbx+0x11]
   182c18efc:	48 89 fa             	mov    rdx,rdi
   182c18eff:	49 89 f0             	mov    r8,rsi
   182c18f02:	e8 39 bf af 04       	call   0x187714e40
   182c18f07:	c6 44 33 11 00       	mov    BYTE PTR [rbx+rsi*1+0x11],0x0
   182c18f0c:	48 8b bd d0 04 00 00 	mov    rdi,QWORD PTR [rbp+0x4d0]
   182c18f13:	48 8d 77 18          	lea    rsi,[rdi+0x18]
   182c18f17:	48 8b 47 30          	mov    rax,QWORD PTR [rdi+0x30]
   182c18f1b:	48 83 f8 10          	cmp    rax,0x10
   182c18f1f:	72 30                	jb     0x182c18f51
   182c18f21:	48 8b 0e             	mov    rcx,QWORD PTR [rsi]
   182c18f24:	48 8d 50 01          	lea    rdx,[rax+0x1]
   182c18f28:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   182c18f2f:	72 1b                	jb     0x182c18f4c
   182c18f31:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   182c18f35:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   182c18f39:	4c 29 c1             	sub    rcx,r8
   182c18f3c:	48 83 f9 20          	cmp    rcx,0x20
   182c18f40:	73 48                	jae    0x182c18f8a
   182c18f42:	48 83 c0 28          	add    rax,0x28
   182c18f46:	48 89 c2             	mov    rdx,rax
   182c18f49:	4c 89 c1             	mov    rcx,r8
   182c18f4c:	e8 cf 2d 93 04       	call   0x18754bd20
   182c18f51:	0f 28 45 c0          	movaps xmm0,XMMWORD PTR [rbp-0x40]
   182c18f55:	0f 28 4d d0          	movaps xmm1,XMMWORD PTR [rbp-0x30]
   182c18f59:	0f 11 4e 10          	movups XMMWORD PTR [rsi+0x10],xmm1
   182c18f5d:	0f 11 06             	movups XMMWORD PTR [rsi],xmm0
   182c18f60:	48 8d 8d 20 03 00 00 	lea    rcx,[rbp+0x320]
   182c18f67:	e8 f4 ea 3e fd       	call   0x180007a60
   182c18f6c:	48 89 f8             	mov    rax,rdi
   182c18f6f:	0f 28 b5 e0 04 00 00 	movaps xmm6,XMMWORD PTR [rbp+0x4e0]
   182c18f76:	48 81 c4 78 05 00 00 	add    rsp,0x578
   182c18f7d:	5b                   	pop    rbx
   182c18f7e:	5f                   	pop    rdi
   182c18f7f:	5e                   	pop    rsi
   182c18f80:	41 5c                	pop    r12
   182c18f82:	41 5d                	pop    r13
   182c18f84:	41 5e                	pop    r14
   182c18f86:	41 5f                	pop    r15
   182c18f88:	5d                   	pop    rbp
   182c18f89:	c3                   	ret
   182c18f8a:	e8 fd 51 ac 04       	call   0x1876de18c
   182c18f8f:	90                   	nop
   182c18f90:	e8 fb fb 3e fd       	call   0x180008b90
   182c18f95:	90                   	nop
   182c18f96:	cc                   	int3
