
E:/Tencent/Weixin/4.1.15.56/Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001855dae00 <.text+0x55d9e00>:
   1855dae00:	55                   	push   rbp
   1855dae01:	41 57                	push   r15
   1855dae03:	41 56                	push   r14
   1855dae05:	41 55                	push   r13
   1855dae07:	41 54                	push   r12
   1855dae09:	56                   	push   rsi
   1855dae0a:	57                   	push   rdi
   1855dae0b:	53                   	push   rbx
   1855dae0c:	b8 e8 10 00 00       	mov    eax,0x10e8
   1855dae11:	e8 ca 20 f7 01       	call   0x18754cee0
   1855dae16:	48 29 c4             	sub    rsp,rax
   1855dae19:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   1855dae20:	00
   1855dae21:	66 44 0f 7f 8d 50 10 	movdqa XMMWORD PTR [rbp+0x1050],xmm9
   1855dae28:	00 00
   1855dae2a:	66 44 0f 7f 85 40 10 	movdqa XMMWORD PTR [rbp+0x1040],xmm8
   1855dae31:	00 00
   1855dae33:	0f 29 bd 30 10 00 00 	movaps XMMWORD PTR [rbp+0x1030],xmm7
   1855dae3a:	0f 29 b5 20 10 00 00 	movaps XMMWORD PTR [rbp+0x1020],xmm6
   1855dae41:	48 c7 85 18 10 00 00 	mov    QWORD PTR [rbp+0x1018],0xfffffffffffffffe
   1855dae48:	fe ff ff ff
   1855dae4c:	4c 89 cf             	mov    rdi,r9
   1855dae4f:	4c 89 c3             	mov    rbx,r8
   1855dae52:	48 89 95 08 10 00 00 	mov    QWORD PTR [rbp+0x1008],rdx
   1855dae59:	0f 28 35 50 bd 93 03 	movaps xmm6,XMMWORD PTR [rip+0x393bd50]        # 0x188f16bb0
   1855dae60:	0f 29 b5 c0 0c 00 00 	movaps XMMWORD PTR [rbp+0xcc0],xmm6
   1855dae67:	0f 29 b5 b0 0c 00 00 	movaps XMMWORD PTR [rbp+0xcb0],xmm6
   1855dae6e:	66 0f ef c0          	pxor   xmm0,xmm0
   1855dae72:	66 0f 7f 85 70 06 00 	movdqa XMMWORD PTR [rbp+0x670],xmm0
   1855dae79:	00
   1855dae7a:	48 c7 85 80 06 00 00 	mov    QWORD PTR [rbp+0x680],0x4
   1855dae81:	04 00 00 00
   1855dae85:	48 c7 85 88 06 00 00 	mov    QWORD PTR [rbp+0x688],0xf
   1855dae8c:	0f 00 00 00
   1855dae90:	c7 85 70 06 00 00 74 	mov    DWORD PTR [rbp+0x670],0x65707974
   1855dae97:	79 70 65
   1855dae9a:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855daea1:	48 8d b5 70 06 00 00 	lea    rsi,[rbp+0x670]
   1855daea8:	4c 89 c2             	mov    rdx,r8
   1855daeab:	49 89 f0             	mov    r8,rsi
   1855daeae:	e8 4d d1 3d ff       	call   0x1849b8000
   1855daeb3:	90                   	nop
   1855daeb4:	48 8d 8d b0 0c 00 00 	lea    rcx,[rbp+0xcb0]
   1855daebb:	48 8d 95 90 01 00 00 	lea    rdx,[rbp+0x190]
   1855daec2:	e8 f9 cd 3d ff       	call   0x1849b7cc0
   1855daec7:	90                   	nop
   1855daec8:	48 8b 85 a8 01 00 00 	mov    rax,QWORD PTR [rbp+0x1a8]
   1855daecf:	48 83 f8 10          	cmp    rax,0x10
   1855daed3:	72 38                	jb     0x1855daf0d
   1855daed5:	48 8b 8d 90 01 00 00 	mov    rcx,QWORD PTR [rbp+0x190]
   1855daedc:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855daee0:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855daee7:	72 1f                	jb     0x1855daf08
   1855daee9:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855daeed:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855daef1:	4c 29 c1             	sub    rcx,r8
   1855daef4:	48 83 f9 20          	cmp    rcx,0x20
   1855daef8:	0f 83 af 48 00 00    	jae    0x1855df7ad
   1855daefe:	48 83 c0 28          	add    rax,0x28
   1855daf02:	48 89 c2             	mov    rdx,rax
   1855daf05:	4c 89 c1             	mov    rcx,r8
   1855daf08:	e8 13 0e f7 01       	call   0x18754bd20
   1855daf0d:	48 83 bd c0 0c 00 00 	cmp    QWORD PTR [rbp+0xcc0],0x0
   1855daf14:	00
   1855daf15:	48 89 bd d0 0d 00 00 	mov    QWORD PTR [rbp+0xdd0],rdi
   1855daf1c:	74 25                	je     0x1855daf43
   1855daf1e:	48 8d 8d b0 0c 00 00 	lea    rcx,[rbp+0xcb0]
   1855daf25:	31 d2                	xor    edx,edx
   1855daf27:	e8 b4 68 c5 fa       	call   0x1802317e0
   1855daf2c:	90                   	nop
   1855daf2d:	49 89 c6             	mov    r14,rax
   1855daf30:	41 83 fe 33          	cmp    r14d,0x33
   1855daf34:	0f 84 f8 00 00 00    	je     0x1855db032
   1855daf3a:	45 85 f6             	test   r14d,r14d
   1855daf3d:	0f 85 67 04 00 00    	jne    0x1855db3aa
   1855daf43:	0f 29 b5 a0 01 00 00 	movaps XMMWORD PTR [rbp+0x1a0],xmm6
   1855daf4a:	0f 29 b5 90 01 00 00 	movaps XMMWORD PTR [rbp+0x190],xmm6
   1855daf51:	48 c7 85 78 06 00 00 	mov    QWORD PTR [rbp+0x678],0x0
   1855daf58:	00 00 00 00
   1855daf5c:	48 c7 85 80 06 00 00 	mov    QWORD PTR [rbp+0x680],0x8
   1855daf63:	08 00 00 00
   1855daf67:	48 c7 85 88 06 00 00 	mov    QWORD PTR [rbp+0x688],0xf
   1855daf6e:	0f 00 00 00
   1855daf72:	48 b8 63 61 74 65 67 	movabs rax,0x79726f6765746163
   1855daf79:	6f 72 79
   1855daf7c:	48 89 85 70 06 00 00 	mov    QWORD PTR [rbp+0x670],rax
   1855daf83:	48 8d b5 90 01 00 00 	lea    rsi,[rbp+0x190]
   1855daf8a:	4c 8d 85 70 06 00 00 	lea    r8,[rbp+0x670]
   1855daf91:	48 89 f1             	mov    rcx,rsi
   1855daf94:	48 89 da             	mov    rdx,rbx
   1855daf97:	e8 64 d0 3d ff       	call   0x1849b8000
   1855daf9c:	90                   	nop
   1855daf9d:	48 8b 8d 90 01 00 00 	mov    rcx,QWORD PTR [rbp+0x190]
   1855dafa4:	48 8b 85 a8 01 00 00 	mov    rax,QWORD PTR [rbp+0x1a8]
   1855dafab:	45 31 f6             	xor    r14d,r14d
   1855dafae:	48 83 bd a0 01 00 00 	cmp    QWORD PTR [rbp+0x1a0],0x15
   1855dafb5:	15
   1855dafb6:	75 3a                	jne    0x1855daff2
   1855dafb8:	48 83 f8 10          	cmp    rax,0x10
   1855dafbc:	48 0f 43 f1          	cmovae rsi,rcx
   1855dafc0:	f3 0f 6f 06          	movdqu xmm0,XMMWORD PTR [rsi]
   1855dafc4:	f3 0f 6f 4e 05       	movdqu xmm1,XMMWORD PTR [rsi+0x5]
   1855dafc9:	66 0f 74 0d 0f 88 42 	pcmpeqb xmm1,XMMWORD PTR [rip+0x442880f]        # 0x189a037e0
   1855dafd0:	04
   1855dafd1:	66 0f 74 05 17 88 42 	pcmpeqb xmm0,XMMWORD PTR [rip+0x4428817]        # 0x189a037f0
   1855dafd8:	04
   1855dafd9:	66 0f db c1          	pand   xmm0,xmm1
   1855dafdd:	66 0f d7 d0          	pmovmskb edx,xmm0
   1855dafe1:	45 31 c0             	xor    r8d,r8d
   1855dafe4:	81 fa ff ff 00 00    	cmp    edx,0xffff
   1855dafea:	41 0f 94 c0          	sete   r8b
   1855dafee:	47 8d 34 80          	lea    r14d,[r8+r8*4]
   1855daff2:	48 83 f8 10          	cmp    rax,0x10
   1855daff6:	0f 82 ae 03 00 00    	jb     0x1855db3aa
   1855daffc:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855db000:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855db007:	72 1f                	jb     0x1855db028
   1855db009:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855db00d:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855db011:	4c 29 c1             	sub    rcx,r8
   1855db014:	48 83 f9 20          	cmp    rcx,0x20
   1855db018:	0f 83 8f 47 00 00    	jae    0x1855df7ad
   1855db01e:	48 83 c0 28          	add    rax,0x28
   1855db022:	48 89 c2             	mov    rdx,rax
   1855db025:	4c 89 c1             	mov    rcx,r8
   1855db028:	e8 f3 0c f7 01       	call   0x18754bd20
   1855db02d:	e9 78 03 00 00       	jmp    0x1855db3aa
   1855db032:	0f 29 b5 50 02 00 00 	movaps XMMWORD PTR [rbp+0x250],xmm6
   1855db039:	0f 29 b5 40 02 00 00 	movaps XMMWORD PTR [rbp+0x240],xmm6
   1855db040:	0f 29 b5 30 02 00 00 	movaps XMMWORD PTR [rbp+0x230],xmm6
   1855db047:	0f 29 b5 20 02 00 00 	movaps XMMWORD PTR [rbp+0x220],xmm6
   1855db04e:	0f 29 b5 10 02 00 00 	movaps XMMWORD PTR [rbp+0x210],xmm6
   1855db055:	0f 29 b5 00 02 00 00 	movaps XMMWORD PTR [rbp+0x200],xmm6
   1855db05c:	0f 29 b5 f0 01 00 00 	movaps XMMWORD PTR [rbp+0x1f0],xmm6
   1855db063:	0f 29 b5 e0 01 00 00 	movaps XMMWORD PTR [rbp+0x1e0],xmm6
   1855db06a:	0f 29 b5 d0 01 00 00 	movaps XMMWORD PTR [rbp+0x1d0],xmm6
   1855db071:	0f 29 b5 c0 01 00 00 	movaps XMMWORD PTR [rbp+0x1c0],xmm6
   1855db078:	0f 29 b5 b0 01 00 00 	movaps XMMWORD PTR [rbp+0x1b0],xmm6
   1855db07f:	0f 29 b5 a0 01 00 00 	movaps XMMWORD PTR [rbp+0x1a0],xmm6
   1855db086:	0f 29 b5 90 01 00 00 	movaps XMMWORD PTR [rbp+0x190],xmm6
   1855db08d:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855db094:	e8 47 17 09 fb       	call   0x18066c7e0
   1855db099:	90                   	nop
   1855db09a:	48 8d 95 90 01 00 00 	lea    rdx,[rbp+0x190]
   1855db0a1:	48 89 d9             	mov    rcx,rbx
   1855db0a4:	e8 87 67 9e fb       	call   0x180fc1830
   1855db0a9:	90                   	nop
   1855db0aa:	84 c0                	test   al,al
   1855db0ac:	0f 84 e6 02 00 00    	je     0x1855db398
   1855db0b2:	48 b8 aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaaa
   1855db0b9:	aa aa aa
   1855db0bc:	48 89 85 c0 0e 00 00 	mov    QWORD PTR [rbp+0xec0],rax
   1855db0c3:	48 83 bd 90 01 00 00 	cmp    QWORD PTR [rbp+0x190],0x0
   1855db0ca:	00
   1855db0cb:	0f 84 95 02 00 00    	je     0x1855db366
   1855db0d1:	48 89 85 60 09 00 00 	mov    QWORD PTR [rbp+0x960],rax
   1855db0d8:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855db0df:	48 8d 95 60 09 00 00 	lea    rdx,[rbp+0x960]
   1855db0e6:	e8 65 be 08 fb       	call   0x180666f50
   1855db0eb:	90                   	nop
   1855db0ec:	48 8b 85 60 09 00 00 	mov    rax,QWORD PTR [rbp+0x960]
   1855db0f3:	48 85 c0             	test   rax,rax
   1855db0f6:	0f 84 5b 02 00 00    	je     0x1855db357
   1855db0fc:	4c 8d b5 60 09 00 00 	lea    r14,[rbp+0x960]
   1855db103:	0f 57 ff             	xorps  xmm7,xmm7
   1855db106:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
   1855db10d:	00 00 00
   1855db110:	48 3b 85 90 01 00 00 	cmp    rax,QWORD PTR [rbp+0x190]
   1855db117:	0f 84 3a 02 00 00    	je     0x1855db357
   1855db11d:	4c 89 f1             	mov    rcx,r14
   1855db120:	e8 bb bf 08 fb       	call   0x1806670e0
   1855db125:	90                   	nop
   1855db126:	49 89 c4             	mov    r12,rax
   1855db129:	0f 29 bd 70 06 00 00 	movaps XMMWORD PTR [rbp+0x670],xmm7
   1855db130:	48 89 c1             	mov    rcx,rax
   1855db133:	e8 68 a2 11 02       	call   0x1876f53a0
   1855db138:	48 85 c0             	test   rax,rax
   1855db13b:	0f 88 a0 46 00 00    	js     0x1855df7e1
   1855db141:	49 89 c5             	mov    r13,rax
   1855db144:	bf 0f 00 00 00       	mov    edi,0xf
   1855db149:	49 89 f7             	mov    r15,rsi
   1855db14c:	48 83 f8 10          	cmp    rax,0x10
   1855db150:	72 57                	jb     0x1855db1a9
   1855db152:	4c 89 e8             	mov    rax,r13
   1855db155:	48 83 c8 0f          	or     rax,0xf
   1855db159:	48 83 f8 17          	cmp    rax,0x17
   1855db15d:	bf 16 00 00 00       	mov    edi,0x16
   1855db162:	48 0f 43 f8          	cmovae rdi,rax
   1855db166:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   1855db16c:	72 27                	jb     0x1855db195
   1855db16e:	48 8d 4f 28          	lea    rcx,[rdi+0x28]
   1855db172:	e8 65 0b f7 01       	call   0x18754bcdc
   1855db177:	90                   	nop
   1855db178:	49 89 c7             	mov    r15,rax
   1855db17b:	48 85 c0             	test   rax,rax
   1855db17e:	0f 84 29 46 00 00    	je     0x1855df7ad
   1855db184:	4c 89 f8             	mov    rax,r15
   1855db187:	49 83 c7 27          	add    r15,0x27
   1855db18b:	49 83 e7 e0          	and    r15,0xffffffffffffffe0
   1855db18f:	49 89 47 f8          	mov    QWORD PTR [r15-0x8],rax
   1855db193:	eb 0d                	jmp    0x1855db1a2
   1855db195:	48 8d 4f 01          	lea    rcx,[rdi+0x1]
   1855db199:	e8 3e 0b f7 01       	call   0x18754bcdc
   1855db19e:	90                   	nop
   1855db19f:	49 89 c7             	mov    r15,rax
   1855db1a2:	4c 89 bd 70 06 00 00 	mov    QWORD PTR [rbp+0x670],r15
   1855db1a9:	4c 89 ad 80 06 00 00 	mov    QWORD PTR [rbp+0x680],r13
   1855db1b0:	48 89 bd 88 06 00 00 	mov    QWORD PTR [rbp+0x688],rdi
   1855db1b7:	4c 89 f9             	mov    rcx,r15
   1855db1ba:	4c 89 e2             	mov    rdx,r12
   1855db1bd:	4d 89 e8             	mov    r8,r13
   1855db1c0:	e8 7b 9c 13 02       	call   0x187714e40
   1855db1c5:	43 c6 04 2f 00       	mov    BYTE PTR [r15+r13*1],0x0
   1855db1ca:	48 8b 8d 70 06 00 00 	mov    rcx,QWORD PTR [rbp+0x670]
   1855db1d1:	48 8b 85 88 06 00 00 	mov    rax,QWORD PTR [rbp+0x688]
   1855db1d8:	48 83 bd 80 06 00 00 	cmp    QWORD PTR [rbp+0x680],0xa
   1855db1df:	0a
   1855db1e0:	75 3e                	jne    0x1855db220
   1855db1e2:	48 83 f8 10          	cmp    rax,0x10
   1855db1e6:	48 89 f2             	mov    rdx,rsi
   1855db1e9:	48 0f 43 d1          	cmovae rdx,rcx
   1855db1ed:	4c 8b 02             	mov    r8,QWORD PTR [rdx]
   1855db1f0:	49 b9 66 69 6e 64 65 	movabs r9,0x65467265646e6966
   1855db1f7:	72 46 65
   1855db1fa:	4d 31 c8             	xor    r8,r9
   1855db1fd:	0f b7 52 08          	movzx  edx,WORD PTR [rdx+0x8]
   1855db201:	48 81 f2 65 64 00 00 	xor    rdx,0x6465
   1855db208:	4c 09 c2             	or     rdx,r8
   1855db20b:	40 0f 94 c7          	sete   dil
   1855db20f:	48 83 f8 10          	cmp    rax,0x10
   1855db213:	73 13                	jae    0x1855db228
   1855db215:	eb 42                	jmp    0x1855db259
   1855db217:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
   1855db21e:	00 00
   1855db220:	31 ff                	xor    edi,edi
   1855db222:	48 83 f8 10          	cmp    rax,0x10
   1855db226:	72 31                	jb     0x1855db259
   1855db228:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855db22c:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855db233:	72 1f                	jb     0x1855db254
   1855db235:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855db239:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855db23d:	4c 29 c1             	sub    rcx,r8
   1855db240:	48 83 f9 20          	cmp    rcx,0x20
   1855db244:	0f 83 63 45 00 00    	jae    0x1855df7ad
   1855db24a:	48 83 c0 28          	add    rax,0x28
   1855db24e:	48 89 c2             	mov    rdx,rax
   1855db251:	4c 89 c1             	mov    rcx,r8
   1855db254:	e8 c7 0a f7 01       	call   0x18754bd20
   1855db259:	40 84 ff             	test   dil,dil
   1855db25c:	0f 85 13 01 00 00    	jne    0x1855db375
   1855db262:	4c 89 f1             	mov    rcx,r14
   1855db265:	48 89 f2             	mov    rdx,rsi
   1855db268:	e8 e3 bc 08 fb       	call   0x180666f50
   1855db26d:	90                   	nop
   1855db26e:	48 89 f1             	mov    rcx,rsi
   1855db271:	e8 ba bc 08 fb       	call   0x180666f30
   1855db276:	90                   	nop
   1855db277:	48 85 c0             	test   rax,rax
   1855db27a:	74 11                	je     0x1855db28d
   1855db27c:	4c 89 f1             	mov    rcx,r14
   1855db27f:	48 89 f2             	mov    rdx,rsi
   1855db282:	e8 c9 bc 08 fb       	call   0x180666f50
   1855db287:	90                   	nop
   1855db288:	e9 b3 00 00 00       	jmp    0x1855db340
   1855db28d:	4c 89 f1             	mov    rcx,r14
   1855db290:	48 89 f2             	mov    rdx,rsi
   1855db293:	e8 18 cc 08 fb       	call   0x180667eb0
   1855db298:	90                   	nop
   1855db299:	48 89 f1             	mov    rcx,rsi
   1855db29c:	e8 8f bc 08 fb       	call   0x180666f30
   1855db2a1:	90                   	nop
   1855db2a2:	48 85 c0             	test   rax,rax
   1855db2a5:	74 11                	je     0x1855db2b8
   1855db2a7:	4c 89 f1             	mov    rcx,r14
   1855db2aa:	48 89 f2             	mov    rdx,rsi
   1855db2ad:	e8 fe cb 08 fb       	call   0x180667eb0
   1855db2b2:	90                   	nop
   1855db2b3:	e9 88 00 00 00       	jmp    0x1855db340
   1855db2b8:	4c 89 f1             	mov    rcx,r14
   1855db2bb:	48 89 f2             	mov    rdx,rsi
   1855db2be:	e8 ed cb 08 fb       	call   0x180667eb0
   1855db2c3:	90                   	nop
   1855db2c4:	48 89 f1             	mov    rcx,rsi
   1855db2c7:	e8 c4 76 c4 fa       	call   0x180222990
   1855db2cc:	90                   	nop
   1855db2cd:	0f 1f 00             	nop    DWORD PTR [rax]
   1855db2d0:	84 c0                	test   al,al
   1855db2d2:	74 41                	je     0x1855db315
   1855db2d4:	48 8b 85 60 09 00 00 	mov    rax,QWORD PTR [rbp+0x960]
   1855db2db:	48 3b 85 90 01 00 00 	cmp    rax,QWORD PTR [rbp+0x190]
   1855db2e2:	74 6a                	je     0x1855db34e
   1855db2e4:	4c 89 f1             	mov    rcx,r14
   1855db2e7:	48 89 f2             	mov    rdx,rsi
   1855db2ea:	e8 e1 cb 08 fb       	call   0x180667ed0
   1855db2ef:	90                   	nop
   1855db2f0:	48 8b 85 70 06 00 00 	mov    rax,QWORD PTR [rbp+0x670]
   1855db2f7:	48 89 85 60 09 00 00 	mov    QWORD PTR [rbp+0x960],rax
   1855db2fe:	4c 89 f1             	mov    rcx,r14
   1855db301:	48 89 f2             	mov    rdx,rsi
   1855db304:	e8 a7 cb 08 fb       	call   0x180667eb0
   1855db309:	90                   	nop
   1855db30a:	48 89 f1             	mov    rcx,rsi
   1855db30d:	e8 7e 76 c4 fa       	call   0x180222990
   1855db312:	90                   	nop
   1855db313:	eb bb                	jmp    0x1855db2d0
   1855db315:	48 8b 85 60 09 00 00 	mov    rax,QWORD PTR [rbp+0x960]
   1855db31c:	48 3b 85 90 01 00 00 	cmp    rax,QWORD PTR [rbp+0x190]
   1855db323:	74 29                	je     0x1855db34e
   1855db325:	4c 89 f1             	mov    rcx,r14
   1855db328:	48 89 f2             	mov    rdx,rsi
   1855db32b:	e8 80 cb 08 fb       	call   0x180667eb0
   1855db330:	90                   	nop
   1855db331:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   1855db338:	0f 1f 84 00 00 00 00
   1855db33f:	00
   1855db340:	48 8b 85 70 06 00 00 	mov    rax,QWORD PTR [rbp+0x670]
   1855db347:	48 89 85 60 09 00 00 	mov    QWORD PTR [rbp+0x960],rax
   1855db34e:	48 85 c0             	test   rax,rax
   1855db351:	0f 85 b9 fd ff ff    	jne    0x1855db110
   1855db357:	48 8d 8d c0 0e 00 00 	lea    rcx,[rbp+0xec0]
   1855db35e:	e8 5d 19 b3 fa       	call   0x18010ccc0
   1855db363:	90                   	nop
   1855db364:	eb 1d                	jmp    0x1855db383
   1855db366:	48 8d 8d c0 0e 00 00 	lea    rcx,[rbp+0xec0]
   1855db36d:	e8 4e 19 b3 fa       	call   0x18010ccc0
   1855db372:	90                   	nop
   1855db373:	eb 0e                	jmp    0x1855db383
   1855db375:	48 8b 85 60 09 00 00 	mov    rax,QWORD PTR [rbp+0x960]
   1855db37c:	48 89 85 c0 0e 00 00 	mov    QWORD PTR [rbp+0xec0],rax
   1855db383:	48 8d 8d c0 0e 00 00 	lea    rcx,[rbp+0xec0]
   1855db38a:	e8 01 76 c4 fa       	call   0x180222990
   1855db38f:	90                   	nop
   1855db390:	84 c0                	test   al,al
   1855db392:	0f 84 93 08 00 00    	je     0x1855dbc2b
   1855db398:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855db39f:	e8 ac 14 09 fb       	call   0x18066c850
   1855db3a4:	41 be 33 00 00 00    	mov    r14d,0x33
   1855db3aa:	48 8d 15 9f 32 ac 03 	lea    rdx,[rip+0x3ac329f]        # 0x18909e650
   1855db3b1:	48 8d 8d 70 06 00 00 	lea    rcx,[rbp+0x670]
   1855db3b8:	41 b8 e8 02 00 00    	mov    r8d,0x2e8
   1855db3be:	e8 7d 9a 13 02       	call   0x187714e40
   1855db3c3:	90                   	nop
   1855db3c4:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855db3cb:	e8 40 9e fb fa       	call   0x180595210
   1855db3d0:	90                   	nop
   1855db3d1:	48 8d 8d 70 06 00 00 	lea    rcx,[rbp+0x670]
   1855db3d8:	48 8d 95 90 01 00 00 	lea    rdx,[rbp+0x190]
   1855db3df:	e8 2c f2 d9 ff       	call   0x18537a610
   1855db3e4:	90                   	nop
   1855db3e5:	48 8b 85 a8 01 00 00 	mov    rax,QWORD PTR [rbp+0x1a8]
   1855db3ec:	48 83 f8 10          	cmp    rax,0x10
   1855db3f0:	72 39                	jb     0x1855db42b
   1855db3f2:	48 8b 8d 90 01 00 00 	mov    rcx,QWORD PTR [rbp+0x190]
   1855db3f9:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855db3fd:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855db404:	72 1f                	jb     0x1855db425
   1855db406:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855db40a:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855db40e:	4c 29 c1             	sub    rcx,r8
   1855db411:	48 83 f9 20          	cmp    rcx,0x20
   1855db415:	0f 83 92 43 00 00    	jae    0x1855df7ad
   1855db41b:	48 83 c0 28          	add    rax,0x28
   1855db41f:	48 89 c2             	mov    rdx,rax
   1855db422:	4c 89 c1             	mov    rcx,r8
   1855db425:	e8 f6 08 f7 01       	call   0x18754bd20
   1855db42a:	90                   	nop
   1855db42b:	48 8d 8d 70 06 00 00 	lea    rcx,[rbp+0x670]
   1855db432:	ba 31 00 00 00       	mov    edx,0x31
   1855db437:	e8 c4 3b 4a fb       	call   0x180a7f000
   1855db43c:	90                   	nop
   1855db43d:	48 8d 8d 70 06 00 00 	lea    rcx,[rbp+0x670]
   1855db444:	44 89 f2             	mov    edx,r14d
   1855db447:	e8 94 49 4a fb       	call   0x180a7fde0
   1855db44c:	90                   	nop
   1855db44d:	c6 85 30 09 00 00 00 	mov    BYTE PTR [rbp+0x930],0x0
   1855db454:	48 8b 73 10          	mov    rsi,QWORD PTR [rbx+0x10]
   1855db458:	48 83 7b 18 10       	cmp    QWORD PTR [rbx+0x18],0x10
   1855db45d:	49 89 d9             	mov    r9,rbx
   1855db460:	72 03                	jb     0x1855db465
   1855db462:	4c 8b 0b             	mov    r9,QWORD PTR [rbx]
   1855db465:	4c 8d bd f0 07 00 00 	lea    r15,[rbp+0x7f0]
   1855db46c:	48 8b 85 08 08 00 00 	mov    rax,QWORD PTR [rbp+0x808]
   1855db473:	48 39 c6             	cmp    rsi,rax
   1855db476:	76 0e                	jbe    0x1855db486
   1855db478:	4c 89 f9             	mov    rcx,r15
   1855db47b:	48 89 f2             	mov    rdx,rsi
   1855db47e:	e8 cd 2c a6 fa       	call   0x18003e150
   1855db483:	90                   	nop
   1855db484:	eb 27                	jmp    0x1855db4ad
   1855db486:	48 83 f8 10          	cmp    rax,0x10
   1855db48a:	72 07                	jb     0x1855db493
   1855db48c:	4c 8b bd f0 07 00 00 	mov    r15,QWORD PTR [rbp+0x7f0]
   1855db493:	48 89 b5 00 08 00 00 	mov    QWORD PTR [rbp+0x800],rsi
   1855db49a:	4c 89 f9             	mov    rcx,r15
   1855db49d:	4c 89 ca             	mov    rdx,r9
   1855db4a0:	49 89 f0             	mov    r8,rsi
   1855db4a3:	e8 98 99 13 02       	call   0x187714e40
   1855db4a8:	41 c6 04 37 00       	mov    BYTE PTR [r15+rsi*1],0x0
   1855db4ad:	e8 5e a8 a6 fa       	call   0x180045d10
   1855db4b2:	90                   	nop
   1855db4b3:	48 8b 10             	mov    rdx,QWORD PTR [rax]
   1855db4b6:	48 89 c1             	mov    rcx,rax
   1855db4b9:	ff 52 20             	call   QWORD PTR [rdx+0x20]
   1855db4bc:	90                   	nop
   1855db4bd:	4c 8d bd 88 06 00 00 	lea    r15,[rbp+0x688]
   1855db4c4:	49 39 c7             	cmp    r15,rax
   1855db4c7:	74 2d                	je     0x1855db4f6
   1855db4c9:	48 8b 70 10          	mov    rsi,QWORD PTR [rax+0x10]
   1855db4cd:	48 83 78 18 10       	cmp    QWORD PTR [rax+0x18],0x10
   1855db4d2:	72 03                	jb     0x1855db4d7
   1855db4d4:	48 8b 00             	mov    rax,QWORD PTR [rax]
   1855db4d7:	48 8b 8d a0 06 00 00 	mov    rcx,QWORD PTR [rbp+0x6a0]
   1855db4de:	48 39 ce             	cmp    rsi,rcx
   1855db4e1:	0f 86 4e 01 00 00    	jbe    0x1855db635
   1855db4e7:	4c 89 f9             	mov    rcx,r15
   1855db4ea:	48 89 f2             	mov    rdx,rsi
   1855db4ed:	49 89 c1             	mov    r9,rax
   1855db4f0:	e8 5b 2c a6 fa       	call   0x18003e150
   1855db4f5:	90                   	nop
   1855db4f6:	4c 8b 8d 08 10 00 00 	mov    r9,QWORD PTR [rbp+0x1008]
   1855db4fd:	49 8b 71 10          	mov    rsi,QWORD PTR [r9+0x10]
   1855db501:	49 83 79 18 10       	cmp    QWORD PTR [r9+0x18],0x10
   1855db506:	72 0a                	jb     0x1855db512
   1855db508:	48 8b 85 08 10 00 00 	mov    rax,QWORD PTR [rbp+0x1008]
   1855db50f:	4c 8b 08             	mov    r9,QWORD PTR [rax]
   1855db512:	4c 8d bd a8 06 00 00 	lea    r15,[rbp+0x6a8]
   1855db519:	48 8b 85 c0 06 00 00 	mov    rax,QWORD PTR [rbp+0x6c0]
   1855db520:	48 39 c6             	cmp    rsi,rax
   1855db523:	76 0e                	jbe    0x1855db533
   1855db525:	4c 89 f9             	mov    rcx,r15
   1855db528:	48 89 f2             	mov    rdx,rsi
   1855db52b:	e8 20 2c a6 fa       	call   0x18003e150
   1855db530:	90                   	nop
   1855db531:	eb 27                	jmp    0x1855db55a
   1855db533:	48 83 f8 10          	cmp    rax,0x10
   1855db537:	72 07                	jb     0x1855db540
   1855db539:	4c 8b bd a8 06 00 00 	mov    r15,QWORD PTR [rbp+0x6a8]
   1855db540:	48 89 b5 b8 06 00 00 	mov    QWORD PTR [rbp+0x6b8],rsi
   1855db547:	4c 89 f9             	mov    rcx,r15
   1855db54a:	4c 89 ca             	mov    rdx,r9
   1855db54d:	49 89 f0             	mov    r8,rsi
   1855db550:	e8 eb 98 13 02       	call   0x187714e40
   1855db555:	41 c6 04 37 00       	mov    BYTE PTR [r15+rsi*1],0x0
   1855db55a:	48 8d 8d 70 06 00 00 	lea    rcx,[rbp+0x670]
   1855db561:	e8 ea 9e 4a fb       	call   0x180a85450
   1855db566:	90                   	nop
   1855db567:	41 83 fe 31          	cmp    r14d,0x31
   1855db56b:	7f 69                	jg     0x1855db5d6
   1855db56d:	41 83 fe 05          	cmp    r14d,0x5
   1855db571:	0f 84 00 01 00 00    	je     0x1855db677
   1855db577:	41 83 fe 21          	cmp    r14d,0x21
   1855db57b:	0f 85 7a 1f 00 00    	jne    0x1855dd4fb
   1855db581:	0f 29 b5 60 09 00 00 	movaps XMMWORD PTR [rbp+0x960],xmm6
   1855db588:	48 8b 8d f8 08 00 00 	mov    rcx,QWORD PTR [rbp+0x8f8]
   1855db58f:	c7 44 24 20 00 00 00 	mov    DWORD PTR [rsp+0x20],0x0
   1855db596:	00
   1855db597:	4c 8d 05 22 3b d4 05 	lea    r8,[rip+0x5d43b22]        # 0x18b31f0c0
   1855db59e:	4c 8d 0d 4b 3b d4 05 	lea    r9,[rip+0x5d43b4b]        # 0x18b31f0f0
   1855db5a5:	31 d2                	xor    edx,edx
   1855db5a7:	e8 40 92 0e 02       	call   0x1876c47ec
   1855db5ac:	90                   	nop
   1855db5ad:	48 85 c0             	test   rax,rax
   1855db5b0:	0f 84 fc 01 00 00    	je     0x1855db7b2
   1855db5b6:	48 8b 8d 00 09 00 00 	mov    rcx,QWORD PTR [rbp+0x900]
   1855db5bd:	48 85 c9             	test   rcx,rcx
   1855db5c0:	0f 84 4e 09 00 00    	je     0x1855dbf14
   1855db5c6:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   1855db5ca:	48 8b 8d 00 09 00 00 	mov    rcx,QWORD PTR [rbp+0x900]
   1855db5d1:	e9 40 09 00 00       	jmp    0x1855dbf16
   1855db5d6:	41 83 fe 32          	cmp    r14d,0x32
   1855db5da:	0f 85 7a 01 00 00    	jne    0x1855db75a
   1855db5e0:	0f 29 b5 e0 0d 00 00 	movaps XMMWORD PTR [rbp+0xde0],xmm6
   1855db5e7:	48 8b 8d f8 08 00 00 	mov    rcx,QWORD PTR [rbp+0x8f8]
   1855db5ee:	c7 44 24 20 00 00 00 	mov    DWORD PTR [rsp+0x20],0x0
   1855db5f5:	00
   1855db5f6:	4c 8d 05 c3 3a d4 05 	lea    r8,[rip+0x5d43ac3]        # 0x18b31f0c0
   1855db5fd:	4c 8d 0d ec 3a d4 05 	lea    r9,[rip+0x5d43aec]        # 0x18b31f0f0
   1855db604:	31 d2                	xor    edx,edx
   1855db606:	e8 e1 91 0e 02       	call   0x1876c47ec
   1855db60b:	90                   	nop
   1855db60c:	48 85 c0             	test   rax,rax
   1855db60f:	0f 84 e6 1e 00 00    	je     0x1855dd4fb
   1855db615:	48 8b 8d 00 09 00 00 	mov    rcx,QWORD PTR [rbp+0x900]
   1855db61c:	48 85 c9             	test   rcx,rcx
   1855db61f:	0f 84 54 09 00 00    	je     0x1855dbf79
   1855db625:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   1855db629:	48 8b 8d 00 09 00 00 	mov    rcx,QWORD PTR [rbp+0x900]
   1855db630:	e9 46 09 00 00       	jmp    0x1855dbf7b
   1855db635:	48 83 f9 10          	cmp    rcx,0x10
   1855db639:	72 07                	jb     0x1855db642
   1855db63b:	4c 8b bd 88 06 00 00 	mov    r15,QWORD PTR [rbp+0x688]
   1855db642:	48 89 b5 98 06 00 00 	mov    QWORD PTR [rbp+0x698],rsi
   1855db649:	4c 89 f9             	mov    rcx,r15
   1855db64c:	48 89 c2             	mov    rdx,rax
   1855db64f:	49 89 f0             	mov    r8,rsi
   1855db652:	e8 e9 97 13 02       	call   0x187714e40
   1855db657:	41 c6 04 37 00       	mov    BYTE PTR [r15+rsi*1],0x0
   1855db65c:	4c 8b 8d 08 10 00 00 	mov    r9,QWORD PTR [rbp+0x1008]
   1855db663:	49 8b 71 10          	mov    rsi,QWORD PTR [r9+0x10]
   1855db667:	49 83 79 18 10       	cmp    QWORD PTR [r9+0x18],0x10
   1855db66c:	0f 83 96 fe ff ff    	jae    0x1855db508
   1855db672:	e9 9b fe ff ff       	jmp    0x1855db512
   1855db677:	0f 29 b5 d0 0e 00 00 	movaps XMMWORD PTR [rbp+0xed0],xmm6
   1855db67e:	0f 29 b5 c0 0e 00 00 	movaps XMMWORD PTR [rbp+0xec0],xmm6
   1855db685:	48 c7 85 98 01 00 00 	mov    QWORD PTR [rbp+0x198],0x0
   1855db68c:	00 00 00 00
   1855db690:	48 c7 85 a0 01 00 00 	mov    QWORD PTR [rbp+0x1a0],0x8
   1855db697:	08 00 00 00
   1855db69b:	48 c7 85 a8 01 00 00 	mov    QWORD PTR [rbp+0x1a8],0xf
   1855db6a2:	0f 00 00 00
   1855db6a6:	48 b8 63 61 74 65 67 	movabs rax,0x79726f6765746163
   1855db6ad:	6f 72 79
   1855db6b0:	48 89 85 90 01 00 00 	mov    QWORD PTR [rbp+0x190],rax
   1855db6b7:	48 8d b5 c0 0e 00 00 	lea    rsi,[rbp+0xec0]
   1855db6be:	4c 8d 85 90 01 00 00 	lea    r8,[rbp+0x190]
   1855db6c5:	48 89 f1             	mov    rcx,rsi
   1855db6c8:	48 89 da             	mov    rdx,rbx
   1855db6cb:	e8 30 c9 3d ff       	call   0x1849b8000
   1855db6d0:	90                   	nop
   1855db6d1:	48 8b 85 d8 0e 00 00 	mov    rax,QWORD PTR [rbp+0xed8]
   1855db6d8:	48 83 bd d0 0e 00 00 	cmp    QWORD PTR [rbp+0xed0],0x15
   1855db6df:	15
   1855db6e0:	75 3a                	jne    0x1855db71c
   1855db6e2:	48 83 f8 10          	cmp    rax,0x10
   1855db6e6:	72 07                	jb     0x1855db6ef
   1855db6e8:	48 8b b5 c0 0e 00 00 	mov    rsi,QWORD PTR [rbp+0xec0]
   1855db6ef:	f3 0f 6f 06          	movdqu xmm0,XMMWORD PTR [rsi]
   1855db6f3:	f3 0f 6f 4e 05       	movdqu xmm1,XMMWORD PTR [rsi+0x5]
   1855db6f8:	66 0f 74 0d e0 80 42 	pcmpeqb xmm1,XMMWORD PTR [rip+0x44280e0]        # 0x189a037e0
   1855db6ff:	04
   1855db700:	66 0f 74 05 e8 80 42 	pcmpeqb xmm0,XMMWORD PTR [rip+0x44280e8]        # 0x189a037f0
   1855db707:	04
   1855db708:	66 0f db c1          	pand   xmm0,xmm1
   1855db70c:	66 0f d7 c8          	pmovmskb ecx,xmm0
   1855db710:	81 f9 ff ff 00 00    	cmp    ecx,0xffff
   1855db716:	0f 84 9d 0b 00 00    	je     0x1855dc2b9
   1855db71c:	48 83 f8 10          	cmp    rax,0x10
   1855db720:	72 38                	jb     0x1855db75a
   1855db722:	48 8b 8d c0 0e 00 00 	mov    rcx,QWORD PTR [rbp+0xec0]
   1855db729:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855db72d:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855db734:	72 1f                	jb     0x1855db755
   1855db736:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855db73a:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855db73e:	4c 29 c1             	sub    rcx,r8
   1855db741:	48 83 f9 20          	cmp    rcx,0x20
   1855db745:	0f 83 62 40 00 00    	jae    0x1855df7ad
   1855db74b:	48 83 c0 28          	add    rax,0x28
   1855db74f:	48 89 c2             	mov    rdx,rax
   1855db752:	4c 89 c1             	mov    rcx,r8
   1855db755:	e8 c6 05 f7 01       	call   0x18754bd20
   1855db75a:	41 83 fe 6f          	cmp    r14d,0x6f
   1855db75e:	0f 85 97 1d 00 00    	jne    0x1855dd4fb
   1855db764:	0f 29 b5 c0 0e 00 00 	movaps XMMWORD PTR [rbp+0xec0],xmm6
   1855db76b:	48 8b 8d f8 08 00 00 	mov    rcx,QWORD PTR [rbp+0x8f8]
   1855db772:	c7 44 24 20 00 00 00 	mov    DWORD PTR [rsp+0x20],0x0
   1855db779:	00
   1855db77a:	4c 8d 05 3f 39 d4 05 	lea    r8,[rip+0x5d4393f]        # 0x18b31f0c0
   1855db781:	4c 8d 0d 68 39 d4 05 	lea    r9,[rip+0x5d43968]        # 0x18b31f0f0
   1855db788:	31 d2                	xor    edx,edx
   1855db78a:	e8 5d 90 0e 02       	call   0x1876c47ec
   1855db78f:	90                   	nop
   1855db790:	48 85 c0             	test   rax,rax
   1855db793:	0f 84 62 1d 00 00    	je     0x1855dd4fb
   1855db799:	48 8b 8d 00 09 00 00 	mov    rcx,QWORD PTR [rbp+0x900]
   1855db7a0:	48 85 c9             	test   rcx,rcx
   1855db7a3:	74 1e                	je     0x1855db7c3
   1855db7a5:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   1855db7a9:	48 8b 8d 00 09 00 00 	mov    rcx,QWORD PTR [rbp+0x900]
   1855db7b0:	eb 13                	jmp    0x1855db7c5
   1855db7b2:	66 0f ef c0          	pxor   xmm0,xmm0
   1855db7b6:	66 0f 7f 85 60 09 00 	movdqa XMMWORD PTR [rbp+0x960],xmm0
   1855db7bd:	00
   1855db7be:	e9 61 07 00 00       	jmp    0x1855dbf24
   1855db7c3:	31 c9                	xor    ecx,ecx
   1855db7c5:	48 89 85 c0 0e 00 00 	mov    QWORD PTR [rbp+0xec0],rax
   1855db7cc:	48 89 8d c8 0e 00 00 	mov    QWORD PTR [rbp+0xec8],rcx
   1855db7d3:	0f 29 b5 90 0f 00 00 	movaps XMMWORD PTR [rbp+0xf90],xmm6
   1855db7da:	48 8b 88 90 06 00 00 	mov    rcx,QWORD PTR [rax+0x690]
   1855db7e1:	48 85 c9             	test   rcx,rcx
   1855db7e4:	74 0d                	je     0x1855db7f3
   1855db7e6:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   1855db7ea:	4c 8b b0 90 06 00 00 	mov    r14,QWORD PTR [rax+0x690]
   1855db7f1:	eb 03                	jmp    0x1855db7f6
   1855db7f3:	45 31 f6             	xor    r14d,r14d
   1855db7f6:	48 8b 80 88 06 00 00 	mov    rax,QWORD PTR [rax+0x688]
   1855db7fd:	48 89 85 90 0f 00 00 	mov    QWORD PTR [rbp+0xf90],rax
   1855db804:	4c 89 b5 98 0f 00 00 	mov    QWORD PTR [rbp+0xf98],r14
   1855db80b:	48 85 c0             	test   rax,rax
   1855db80e:	0f 85 76 0b 00 00    	jne    0x1855dc38a
   1855db814:	b9 e8 03 00 00       	mov    ecx,0x3e8
   1855db819:	e8 be 04 f7 01       	call   0x18754bcdc
   1855db81e:	90                   	nop
   1855db81f:	48 b9 01 00 00 00 01 	movabs rcx,0x100000001
   1855db826:	00 00 00
   1855db829:	48 89 48 08          	mov    QWORD PTR [rax+0x8],rcx
   1855db82d:	48 8d 0d 14 5b 99 03 	lea    rcx,[rip+0x3995b14]        # 0x188f71348
   1855db834:	48 89 08             	mov    QWORD PTR [rax],rcx
   1855db837:	48 89 c1             	mov    rcx,rax
   1855db83a:	48 83 c1 10          	add    rcx,0x10
   1855db83e:	66 0f ef c0          	pxor   xmm0,xmm0
   1855db842:	f3 0f 7f 40 10       	movdqu XMMWORD PTR [rax+0x10],xmm0
   1855db847:	48 c7 40 20 00 00 00 	mov    QWORD PTR [rax+0x20],0x0
   1855db84e:	00
   1855db84f:	48 c7 40 28 0f 00 00 	mov    QWORD PTR [rax+0x28],0xf
   1855db856:	00
   1855db857:	f3 0f 7f 40 30       	movdqu XMMWORD PTR [rax+0x30],xmm0
   1855db85c:	48 c7 40 40 00 00 00 	mov    QWORD PTR [rax+0x40],0x0
   1855db863:	00
   1855db864:	48 c7 40 48 0f 00 00 	mov    QWORD PTR [rax+0x48],0xf
   1855db86b:	00
   1855db86c:	f3 0f 7f 40 50       	movdqu XMMWORD PTR [rax+0x50],xmm0
   1855db871:	48 c7 40 60 00 00 00 	mov    QWORD PTR [rax+0x60],0x0
   1855db878:	00
   1855db879:	48 c7 40 68 0f 00 00 	mov    QWORD PTR [rax+0x68],0xf
   1855db880:	00
   1855db881:	f3 0f 7f 40 70       	movdqu XMMWORD PTR [rax+0x70],xmm0
   1855db886:	48 c7 80 80 00 00 00 	mov    QWORD PTR [rax+0x80],0x0
   1855db88d:	00 00 00 00
   1855db891:	48 c7 80 88 00 00 00 	mov    QWORD PTR [rax+0x88],0xf
   1855db898:	0f 00 00 00
   1855db89c:	f3 0f 7f 80 90 00 00 	movdqu XMMWORD PTR [rax+0x90],xmm0
   1855db8a3:	00
   1855db8a4:	48 c7 80 a0 00 00 00 	mov    QWORD PTR [rax+0xa0],0x0
   1855db8ab:	00 00 00 00
   1855db8af:	48 c7 80 a8 00 00 00 	mov    QWORD PTR [rax+0xa8],0xf
   1855db8b6:	0f 00 00 00
   1855db8ba:	f3 0f 7f 80 b0 00 00 	movdqu XMMWORD PTR [rax+0xb0],xmm0
   1855db8c1:	00
   1855db8c2:	48 c7 80 c0 00 00 00 	mov    QWORD PTR [rax+0xc0],0x0
   1855db8c9:	00 00 00 00
   1855db8cd:	48 c7 80 c8 00 00 00 	mov    QWORD PTR [rax+0xc8],0xf
   1855db8d4:	0f 00 00 00
   1855db8d8:	f3 0f 7f 80 d0 00 00 	movdqu XMMWORD PTR [rax+0xd0],xmm0
   1855db8df:	00
   1855db8e0:	48 c7 80 e0 00 00 00 	mov    QWORD PTR [rax+0xe0],0x0
   1855db8e7:	00 00 00 00
   1855db8eb:	48 c7 80 e8 00 00 00 	mov    QWORD PTR [rax+0xe8],0xf
   1855db8f2:	0f 00 00 00
   1855db8f6:	f3 0f 7f 80 f0 00 00 	movdqu XMMWORD PTR [rax+0xf0],xmm0
   1855db8fd:	00
   1855db8fe:	48 c7 80 00 01 00 00 	mov    QWORD PTR [rax+0x100],0x0
   1855db905:	00 00 00 00
   1855db909:	48 c7 80 08 01 00 00 	mov    QWORD PTR [rax+0x108],0xf
   1855db910:	0f 00 00 00
   1855db914:	f3 0f 7f 80 10 01 00 	movdqu XMMWORD PTR [rax+0x110],xmm0
   1855db91b:	00
   1855db91c:	48 c7 80 20 01 00 00 	mov    QWORD PTR [rax+0x120],0x0
   1855db923:	00 00 00 00
   1855db927:	48 c7 80 28 01 00 00 	mov    QWORD PTR [rax+0x128],0xf
   1855db92e:	0f 00 00 00
   1855db932:	f3 0f 7f 80 30 01 00 	movdqu XMMWORD PTR [rax+0x130],xmm0
   1855db939:	00
   1855db93a:	48 c7 80 40 01 00 00 	mov    QWORD PTR [rax+0x140],0x0
   1855db941:	00 00 00 00
   1855db945:	48 c7 80 48 01 00 00 	mov    QWORD PTR [rax+0x148],0xf
   1855db94c:	0f 00 00 00
   1855db950:	f3 0f 7f 80 50 01 00 	movdqu XMMWORD PTR [rax+0x150],xmm0
   1855db957:	00
   1855db958:	48 c7 80 60 01 00 00 	mov    QWORD PTR [rax+0x160],0x0
   1855db95f:	00 00 00 00
   1855db963:	48 c7 80 68 01 00 00 	mov    QWORD PTR [rax+0x168],0xf
   1855db96a:	0f 00 00 00
   1855db96e:	f3 0f 7f 80 70 01 00 	movdqu XMMWORD PTR [rax+0x170],xmm0
   1855db975:	00
   1855db976:	48 c7 80 80 01 00 00 	mov    QWORD PTR [rax+0x180],0x0
   1855db97d:	00 00 00 00
   1855db981:	48 c7 80 88 01 00 00 	mov    QWORD PTR [rax+0x188],0xf
   1855db988:	0f 00 00 00
   1855db98c:	f3 0f 7f 80 90 01 00 	movdqu XMMWORD PTR [rax+0x190],xmm0
   1855db993:	00
   1855db994:	48 c7 80 a0 01 00 00 	mov    QWORD PTR [rax+0x1a0],0x0
   1855db99b:	00 00 00 00
   1855db99f:	48 c7 80 a8 01 00 00 	mov    QWORD PTR [rax+0x1a8],0xf
   1855db9a6:	0f 00 00 00
   1855db9aa:	f3 0f 7f 80 b0 01 00 	movdqu XMMWORD PTR [rax+0x1b0],xmm0
   1855db9b1:	00
   1855db9b2:	48 c7 80 c0 01 00 00 	mov    QWORD PTR [rax+0x1c0],0x0
   1855db9b9:	00 00 00 00
   1855db9bd:	48 c7 80 c8 01 00 00 	mov    QWORD PTR [rax+0x1c8],0xf
   1855db9c4:	0f 00 00 00
   1855db9c8:	f3 0f 7f 80 d0 01 00 	movdqu XMMWORD PTR [rax+0x1d0],xmm0
   1855db9cf:	00
   1855db9d0:	48 c7 80 e0 01 00 00 	mov    QWORD PTR [rax+0x1e0],0x0
   1855db9d7:	00 00 00 00
   1855db9db:	48 c7 80 e8 01 00 00 	mov    QWORD PTR [rax+0x1e8],0xf
   1855db9e2:	0f 00 00 00
   1855db9e6:	f3 0f 7f 80 f0 01 00 	movdqu XMMWORD PTR [rax+0x1f0],xmm0
   1855db9ed:	00
   1855db9ee:	48 c7 80 00 02 00 00 	mov    QWORD PTR [rax+0x200],0x0
   1855db9f5:	00 00 00 00
   1855db9f9:	48 c7 80 08 02 00 00 	mov    QWORD PTR [rax+0x208],0xf
   1855dba00:	0f 00 00 00
   1855dba04:	f3 0f 7f 80 10 02 00 	movdqu XMMWORD PTR [rax+0x210],xmm0
   1855dba0b:	00
   1855dba0c:	48 c7 80 20 02 00 00 	mov    QWORD PTR [rax+0x220],0x0
   1855dba13:	00 00 00 00
   1855dba17:	48 c7 80 28 02 00 00 	mov    QWORD PTR [rax+0x228],0xf
   1855dba1e:	0f 00 00 00
   1855dba22:	f3 0f 7f 80 30 02 00 	movdqu XMMWORD PTR [rax+0x230],xmm0
   1855dba29:	00
   1855dba2a:	48 c7 80 40 02 00 00 	mov    QWORD PTR [rax+0x240],0x0
   1855dba31:	00 00 00 00
   1855dba35:	48 c7 80 48 02 00 00 	mov    QWORD PTR [rax+0x248],0xf
   1855dba3c:	0f 00 00 00
   1855dba40:	f3 0f 7f 80 50 02 00 	movdqu XMMWORD PTR [rax+0x250],xmm0
   1855dba47:	00
   1855dba48:	48 c7 80 60 02 00 00 	mov    QWORD PTR [rax+0x260],0x0
   1855dba4f:	00 00 00 00
   1855dba53:	48 c7 80 68 02 00 00 	mov    QWORD PTR [rax+0x268],0xf
   1855dba5a:	0f 00 00 00
   1855dba5e:	f3 0f 7f 80 70 02 00 	movdqu XMMWORD PTR [rax+0x270],xmm0
   1855dba65:	00
   1855dba66:	48 c7 80 80 02 00 00 	mov    QWORD PTR [rax+0x280],0x0
   1855dba6d:	00 00 00 00
   1855dba71:	48 c7 80 88 02 00 00 	mov    QWORD PTR [rax+0x288],0xf
   1855dba78:	0f 00 00 00
   1855dba7c:	f3 0f 7f 80 90 02 00 	movdqu XMMWORD PTR [rax+0x290],xmm0
   1855dba83:	00
   1855dba84:	48 c7 80 a0 02 00 00 	mov    QWORD PTR [rax+0x2a0],0x0
   1855dba8b:	00 00 00 00
   1855dba8f:	48 c7 80 a8 02 00 00 	mov    QWORD PTR [rax+0x2a8],0xf
   1855dba96:	0f 00 00 00
   1855dba9a:	f3 0f 7f 80 b0 02 00 	movdqu XMMWORD PTR [rax+0x2b0],xmm0
   1855dbaa1:	00
   1855dbaa2:	48 c7 80 c0 02 00 00 	mov    QWORD PTR [rax+0x2c0],0x0
   1855dbaa9:	00 00 00 00
   1855dbaad:	48 c7 80 c8 02 00 00 	mov    QWORD PTR [rax+0x2c8],0xf
   1855dbab4:	0f 00 00 00
   1855dbab8:	f3 0f 7f 80 d0 02 00 	movdqu XMMWORD PTR [rax+0x2d0],xmm0
   1855dbabf:	00
   1855dbac0:	48 c7 80 e0 02 00 00 	mov    QWORD PTR [rax+0x2e0],0x0
   1855dbac7:	00 00 00 00
   1855dbacb:	48 c7 80 e8 02 00 00 	mov    QWORD PTR [rax+0x2e8],0xf
   1855dbad2:	0f 00 00 00
   1855dbad6:	f3 0f 7f 80 f0 02 00 	movdqu XMMWORD PTR [rax+0x2f0],xmm0
   1855dbadd:	00
   1855dbade:	48 c7 80 00 03 00 00 	mov    QWORD PTR [rax+0x300],0x0
   1855dbae5:	00 00 00 00
   1855dbae9:	48 c7 80 08 03 00 00 	mov    QWORD PTR [rax+0x308],0xf
   1855dbaf0:	0f 00 00 00
   1855dbaf4:	f3 0f 7f 80 10 03 00 	movdqu XMMWORD PTR [rax+0x310],xmm0
   1855dbafb:	00
   1855dbafc:	48 c7 80 20 03 00 00 	mov    QWORD PTR [rax+0x320],0x0
   1855dbb03:	00 00 00 00
   1855dbb07:	48 c7 80 28 03 00 00 	mov    QWORD PTR [rax+0x328],0xf
   1855dbb0e:	0f 00 00 00
   1855dbb12:	f3 0f 7f 80 30 03 00 	movdqu XMMWORD PTR [rax+0x330],xmm0
   1855dbb19:	00
   1855dbb1a:	48 c7 80 40 03 00 00 	mov    QWORD PTR [rax+0x340],0x0
   1855dbb21:	00 00 00 00
   1855dbb25:	48 c7 80 48 03 00 00 	mov    QWORD PTR [rax+0x348],0xf
   1855dbb2c:	0f 00 00 00
   1855dbb30:	f3 0f 7f 80 50 03 00 	movdqu XMMWORD PTR [rax+0x350],xmm0
   1855dbb37:	00
   1855dbb38:	48 c7 80 60 03 00 00 	mov    QWORD PTR [rax+0x360],0x0
   1855dbb3f:	00 00 00 00
   1855dbb43:	48 c7 80 68 03 00 00 	mov    QWORD PTR [rax+0x368],0xf
   1855dbb4a:	0f 00 00 00
   1855dbb4e:	f3 0f 7f 80 70 03 00 	movdqu XMMWORD PTR [rax+0x370],xmm0
   1855dbb55:	00
   1855dbb56:	48 c7 80 80 03 00 00 	mov    QWORD PTR [rax+0x380],0x0
   1855dbb5d:	00 00 00 00
   1855dbb61:	48 c7 80 88 03 00 00 	mov    QWORD PTR [rax+0x388],0xf
   1855dbb68:	0f 00 00 00
   1855dbb6c:	f3 0f 7f 80 90 03 00 	movdqu XMMWORD PTR [rax+0x390],xmm0
   1855dbb73:	00
   1855dbb74:	48 c7 80 a0 03 00 00 	mov    QWORD PTR [rax+0x3a0],0x0
   1855dbb7b:	00 00 00 00
   1855dbb7f:	48 c7 80 a8 03 00 00 	mov    QWORD PTR [rax+0x3a8],0xf
   1855dbb86:	0f 00 00 00
   1855dbb8a:	f3 0f 7f 80 b0 03 00 	movdqu XMMWORD PTR [rax+0x3b0],xmm0
   1855dbb91:	00
   1855dbb92:	48 c7 80 c0 03 00 00 	mov    QWORD PTR [rax+0x3c0],0x0
   1855dbb99:	00 00 00 00
   1855dbb9d:	48 c7 80 c8 03 00 00 	mov    QWORD PTR [rax+0x3c8],0xf
   1855dbba4:	0f 00 00 00
   1855dbba8:	f3 0f 7f 80 d0 03 00 	movdqu XMMWORD PTR [rax+0x3d0],xmm0
   1855dbbaf:	00
   1855dbbb0:	48 c7 80 e0 03 00 00 	mov    QWORD PTR [rax+0x3e0],0x0
   1855dbbb7:	00 00 00 00
   1855dbbbb:	48 89 8d 90 0f 00 00 	mov    QWORD PTR [rbp+0xf90],rcx
   1855dbbc2:	48 89 85 98 0f 00 00 	mov    QWORD PTR [rbp+0xf98],rax
   1855dbbc9:	4d 85 f6             	test   r14,r14
   1855dbbcc:	74 26                	je     0x1855dbbf4
   1855dbbce:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1855dbbd3:	75 18                	jne    0x1855dbbed
   1855dbbd5:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855dbbd8:	4c 89 f1             	mov    rcx,r14
   1855dbbdb:	ff 10                	call   QWORD PTR [rax]
   1855dbbdd:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1855dbbe2:	75 09                	jne    0x1855dbbed
   1855dbbe4:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855dbbe7:	4c 89 f1             	mov    rcx,r14
   1855dbbea:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dbbed:	48 8b 85 98 0f 00 00 	mov    rax,QWORD PTR [rbp+0xf98]
   1855dbbf4:	48 8b 8d c0 0e 00 00 	mov    rcx,QWORD PTR [rbp+0xec0]
   1855dbbfb:	48 85 c0             	test   rax,rax
   1855dbbfe:	0f 84 0a 07 00 00    	je     0x1855dc30e
   1855dbc04:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1855dbc08:	48 8b 85 90 0f 00 00 	mov    rax,QWORD PTR [rbp+0xf90]
   1855dbc0f:	4c 8b b5 98 0f 00 00 	mov    r14,QWORD PTR [rbp+0xf98]
   1855dbc16:	4d 85 f6             	test   r14,r14
   1855dbc19:	0f 84 0a 07 00 00    	je     0x1855dc329
   1855dbc1f:	f0 41 ff 46 08       	lock inc DWORD PTR [r14+0x8]
   1855dbc24:	31 ff                	xor    edi,edi
   1855dbc26:	e9 04 07 00 00       	jmp    0x1855dc32f
   1855dbc2b:	0f 29 b5 80 06 00 00 	movaps XMMWORD PTR [rbp+0x680],xmm6
   1855dbc32:	0f 29 b5 70 06 00 00 	movaps XMMWORD PTR [rbp+0x670],xmm6
   1855dbc39:	4c 8d 05 48 56 e6 03 	lea    r8,[rip+0x3e65648]        # 0x189441288
   1855dbc40:	48 8d 8d c0 0e 00 00 	lea    rcx,[rbp+0xec0]
   1855dbc47:	48 8d 95 50 0c 00 00 	lea    rdx,[rbp+0xc50]
   1855dbc4e:	e8 4d c1 08 fb       	call   0x180667da0
   1855dbc53:	90                   	nop
   1855dbc54:	48 8b 95 50 0c 00 00 	mov    rdx,QWORD PTR [rbp+0xc50]
   1855dbc5b:	48 8d 8d 70 06 00 00 	lea    rcx,[rbp+0x670]
   1855dbc62:	e8 49 5c 9e fb       	call   0x180fc18b0
   1855dbc67:	90                   	nop
   1855dbc68:	0f 29 b5 70 09 00 00 	movaps XMMWORD PTR [rbp+0x970],xmm6
   1855dbc6f:	0f 29 b5 60 09 00 00 	movaps XMMWORD PTR [rbp+0x960],xmm6
   1855dbc76:	4c 8d 05 fb 55 e6 03 	lea    r8,[rip+0x3e655fb]        # 0x189441278
   1855dbc7d:	4c 8d ad c0 0e 00 00 	lea    r13,[rbp+0xec0]
   1855dbc84:	48 8d 95 58 0c 00 00 	lea    rdx,[rbp+0xc58]
   1855dbc8b:	4c 89 e9             	mov    rcx,r13
   1855dbc8e:	e8 0d c1 08 fb       	call   0x180667da0
   1855dbc93:	90                   	nop
   1855dbc94:	48 8b 95 58 0c 00 00 	mov    rdx,QWORD PTR [rbp+0xc58]
   1855dbc9b:	48 8d 8d 60 09 00 00 	lea    rcx,[rbp+0x960]
   1855dbca2:	e8 09 5c 9e fb       	call   0x180fc18b0
   1855dbca7:	90                   	nop
   1855dbca8:	48 83 bd 80 06 00 00 	cmp    QWORD PTR [rbp+0x680],0x0
   1855dbcaf:	00
   1855dbcb0:	40 0f 95 c6          	setne  sil
   1855dbcb4:	48 8b 85 78 09 00 00 	mov    rax,QWORD PTR [rbp+0x978]
   1855dbcbb:	48 83 bd 70 09 00 00 	cmp    QWORD PTR [rbp+0x970],0x0
   1855dbcc2:	00
   1855dbcc3:	41 0f 94 c6          	sete   r14b
   1855dbcc7:	48 83 f8 10          	cmp    rax,0x10
   1855dbccb:	4c 8b a5 d0 0d 00 00 	mov    r12,QWORD PTR [rbp+0xdd0]
   1855dbcd2:	72 38                	jb     0x1855dbd0c
   1855dbcd4:	48 8b 8d 60 09 00 00 	mov    rcx,QWORD PTR [rbp+0x960]
   1855dbcdb:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855dbcdf:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855dbce6:	72 1f                	jb     0x1855dbd07
   1855dbce8:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855dbcec:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855dbcf0:	4c 29 c1             	sub    rcx,r8
   1855dbcf3:	48 83 f9 20          	cmp    rcx,0x20
   1855dbcf7:	0f 83 b0 3a 00 00    	jae    0x1855df7ad
   1855dbcfd:	48 83 c0 28          	add    rax,0x28
   1855dbd01:	48 89 c2             	mov    rdx,rax
   1855dbd04:	4c 89 c1             	mov    rcx,r8
   1855dbd07:	e8 14 00 f7 01       	call   0x18754bd20
   1855dbd0c:	48 8b 85 88 06 00 00 	mov    rax,QWORD PTR [rbp+0x688]
   1855dbd13:	48 83 f8 10          	cmp    rax,0x10
   1855dbd17:	49 bf aa aa aa aa aa 	movabs r15,0xaaaaaaaaaaaaaaaa
   1855dbd1e:	aa aa aa
   1855dbd21:	72 38                	jb     0x1855dbd5b
   1855dbd23:	48 8b 8d 70 06 00 00 	mov    rcx,QWORD PTR [rbp+0x670]
   1855dbd2a:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855dbd2e:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855dbd35:	72 1f                	jb     0x1855dbd56
   1855dbd37:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855dbd3b:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855dbd3f:	4c 29 c1             	sub    rcx,r8
   1855dbd42:	48 83 f9 20          	cmp    rcx,0x20
   1855dbd46:	0f 83 61 3a 00 00    	jae    0x1855df7ad
   1855dbd4c:	48 83 c0 28          	add    rax,0x28
   1855dbd50:	48 89 c2             	mov    rdx,rax
   1855dbd53:	4c 89 c1             	mov    rcx,r8
   1855dbd56:	e8 c5 ff f6 01       	call   0x18754bd20
   1855dbd5b:	44 20 f6             	and    sil,r14b
   1855dbd5e:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855dbd65:	e8 e6 0a 09 fb       	call   0x18066c850
   1855dbd6a:	41 be 33 00 00 00    	mov    r14d,0x33
   1855dbd70:	40 84 f6             	test   sil,sil
   1855dbd73:	0f 84 31 f6 ff ff    	je     0x1855db3aa
   1855dbd79:	b9 20 00 00 00       	mov    ecx,0x20
   1855dbd7e:	e8 59 ff f6 01       	call   0x18754bcdc
   1855dbd83:	90                   	nop
   1855dbd84:	48 b9 01 00 00 00 01 	movabs rcx,0x100000001
   1855dbd8b:	00 00 00
   1855dbd8e:	48 89 48 08          	mov    QWORD PTR [rax+0x8],rcx
   1855dbd92:	48 8d 0d 2f 84 42 04 	lea    rcx,[rip+0x442842f]        # 0x189a041c8
   1855dbd99:	48 89 08             	mov    QWORD PTR [rax],rcx
   1855dbd9c:	66 0f ef c0          	pxor   xmm0,xmm0
   1855dbda0:	f3 0f 7f 40 10       	movdqu XMMWORD PTR [rax+0x10],xmm0
   1855dbda5:	48 89 85 00 10 00 00 	mov    QWORD PTR [rbp+0x1000],rax
   1855dbdac:	48 8d 48 18          	lea    rcx,[rax+0x18]
   1855dbdb0:	48 8b 95 d0 10 00 00 	mov    rdx,QWORD PTR [rbp+0x10d0]
   1855dbdb7:	e8 b4 0b b3 fa       	call   0x18010c970
   1855dbdbc:	90                   	nop
   1855dbdbd:	48 8d 8d 60 09 00 00 	lea    rcx,[rbp+0x960]
   1855dbdc4:	e8 57 b4 a6 fa       	call   0x180047220
   1855dbdc9:	90                   	nop
   1855dbdca:	48 8b 8d 60 09 00 00 	mov    rcx,QWORD PTR [rbp+0x960]
   1855dbdd1:	48 8d 95 70 06 00 00 	lea    rdx,[rbp+0x670]
   1855dbdd8:	e8 f3 65 da fa       	call   0x1803823d0
   1855dbddd:	90                   	nop
   1855dbdde:	48 8b 8d 70 06 00 00 	mov    rcx,QWORD PTR [rbp+0x670]
   1855dbde5:	48 8d 95 90 01 00 00 	lea    rdx,[rbp+0x190]
   1855dbdec:	e8 0f b6 8d fb       	call   0x180eb7400
   1855dbdf1:	90                   	nop
   1855dbdf2:	48 8b 95 00 10 00 00 	mov    rdx,QWORD PTR [rbp+0x1000]
   1855dbdf9:	48 8d 7a 08          	lea    rdi,[rdx+0x8]
   1855dbdfd:	4c 8d 72 10          	lea    r14,[rdx+0x10]
   1855dbe01:	48 8b 8d 90 01 00 00 	mov    rcx,QWORD PTR [rbp+0x190]
   1855dbe08:	48 85 d2             	test   rdx,rdx
   1855dbe0b:	74 03                	je     0x1855dbe10
   1855dbe0d:	f0 ff 07             	lock inc DWORD PTR [rdi]
   1855dbe10:	48 8d 05 41 84 42 04 	lea    rax,[rip+0x4428441]        # 0x189a04258
   1855dbe17:	48 89 45 70          	mov    QWORD PTR [rbp+0x70],rax
   1855dbe1b:	4c 89 75 78          	mov    QWORD PTR [rbp+0x78],r14
   1855dbe1f:	48 89 95 80 00 00 00 	mov    QWORD PTR [rbp+0x80],rdx
   1855dbe26:	48 8d 55 70          	lea    rdx,[rbp+0x70]
   1855dbe2a:	48 89 95 a8 00 00 00 	mov    QWORD PTR [rbp+0xa8],rdx
   1855dbe31:	e8 aa 7d 86 fd       	call   0x182e43be0
   1855dbe36:	90                   	nop
   1855dbe37:	48 8b b5 98 01 00 00 	mov    rsi,QWORD PTR [rbp+0x198]
   1855dbe3e:	48 85 f6             	test   rsi,rsi
   1855dbe41:	74 1d                	je     0x1855dbe60
   1855dbe43:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855dbe47:	75 17                	jne    0x1855dbe60
   1855dbe49:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dbe4c:	48 89 f1             	mov    rcx,rsi
   1855dbe4f:	ff 10                	call   QWORD PTR [rax]
   1855dbe51:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855dbe55:	75 09                	jne    0x1855dbe60
   1855dbe57:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dbe5a:	48 89 f1             	mov    rcx,rsi
   1855dbe5d:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dbe60:	48 8b b5 78 06 00 00 	mov    rsi,QWORD PTR [rbp+0x678]
   1855dbe67:	48 85 f6             	test   rsi,rsi
   1855dbe6a:	74 1d                	je     0x1855dbe89
   1855dbe6c:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855dbe70:	75 17                	jne    0x1855dbe89
   1855dbe72:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dbe75:	48 89 f1             	mov    rcx,rsi
   1855dbe78:	ff 10                	call   QWORD PTR [rax]
   1855dbe7a:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855dbe7e:	75 09                	jne    0x1855dbe89
   1855dbe80:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dbe83:	48 89 f1             	mov    rcx,rsi
   1855dbe86:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dbe89:	48 8b b5 68 09 00 00 	mov    rsi,QWORD PTR [rbp+0x968]
   1855dbe90:	48 85 f6             	test   rsi,rsi
   1855dbe93:	74 1d                	je     0x1855dbeb2
   1855dbe95:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855dbe99:	75 17                	jne    0x1855dbeb2
   1855dbe9b:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dbe9e:	48 89 f1             	mov    rcx,rsi
   1855dbea1:	ff 10                	call   QWORD PTR [rax]
   1855dbea3:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855dbea7:	75 09                	jne    0x1855dbeb2
   1855dbea9:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dbeac:	48 89 f1             	mov    rcx,rsi
   1855dbeaf:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dbeb2:	4c 89 bd b0 0e 00 00 	mov    QWORD PTR [rbp+0xeb0],r15
   1855dbeb9:	0f 29 b5 a0 0e 00 00 	movaps XMMWORD PTR [rbp+0xea0],xmm6
   1855dbec0:	0f 29 b5 90 0e 00 00 	movaps XMMWORD PTR [rbp+0xe90],xmm6
   1855dbec7:	0f 29 b5 80 0e 00 00 	movaps XMMWORD PTR [rbp+0xe80],xmm6
   1855dbece:	48 8d 8d 80 0e 00 00 	lea    rcx,[rbp+0xe80]
   1855dbed5:	e8 96 78 3d 01       	call   0x1869b3770
   1855dbeda:	90                   	nop
   1855dbedb:	8b 85 a0 0e 00 00    	mov    eax,DWORD PTR [rbp+0xea0]
   1855dbee1:	8b 95 a4 0e 00 00    	mov    edx,DWORD PTR [rbp+0xea4]
   1855dbee7:	39 d0                	cmp    eax,edx
   1855dbee9:	48 89 bd a8 0c 00 00 	mov    QWORD PTR [rbp+0xca8],rdi
   1855dbef0:	0f 8d ef 07 00 00    	jge    0x1855dc6e5
   1855dbef6:	48 63 c8             	movsxd rcx,eax
   1855dbef9:	48 8b 95 98 0e 00 00 	mov    rdx,QWORD PTR [rbp+0xe98]
   1855dbf00:	ff c0                	inc    eax
   1855dbf02:	89 85 a0 0e 00 00    	mov    DWORD PTR [rbp+0xea0],eax
   1855dbf08:	48 8b 04 ca          	mov    rax,QWORD PTR [rdx+rcx*8]
   1855dbf0c:	4c 89 e7             	mov    rdi,r12
   1855dbf0f:	e9 9f 1e 00 00       	jmp    0x1855dddb3
   1855dbf14:	31 c9                	xor    ecx,ecx
   1855dbf16:	48 89 85 60 09 00 00 	mov    QWORD PTR [rbp+0x960],rax
   1855dbf1d:	48 89 8d 68 09 00 00 	mov    QWORD PTR [rbp+0x968],rcx
   1855dbf24:	0f 29 b5 c0 0e 00 00 	movaps XMMWORD PTR [rbp+0xec0],xmm6
   1855dbf2b:	48 8b 8d f8 08 00 00 	mov    rcx,QWORD PTR [rbp+0x8f8]
   1855dbf32:	c7 44 24 20 00 00 00 	mov    DWORD PTR [rsp+0x20],0x0
   1855dbf39:	00
   1855dbf3a:	4c 8d 05 7f 31 d4 05 	lea    r8,[rip+0x5d4317f]        # 0x18b31f0c0
   1855dbf41:	4c 8d 0d a8 31 d4 05 	lea    r9,[rip+0x5d431a8]        # 0x18b31f0f0
   1855dbf48:	31 d2                	xor    edx,edx
   1855dbf4a:	e8 9d 88 0e 02       	call   0x1876c47ec
   1855dbf4f:	90                   	nop
   1855dbf50:	48 85 c0             	test   rax,rax
   1855dbf53:	0f 84 a2 0d 00 00    	je     0x1855dccfb
   1855dbf59:	48 8b 8d 00 09 00 00 	mov    rcx,QWORD PTR [rbp+0x900]
   1855dbf60:	48 85 c9             	test   rcx,rcx
   1855dbf63:	0f 84 2e 02 00 00    	je     0x1855dc197
   1855dbf69:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   1855dbf6d:	48 8b 8d 00 09 00 00 	mov    rcx,QWORD PTR [rbp+0x900]
   1855dbf74:	e9 20 02 00 00       	jmp    0x1855dc199
   1855dbf79:	31 c9                	xor    ecx,ecx
   1855dbf7b:	48 89 85 e0 0d 00 00 	mov    QWORD PTR [rbp+0xde0],rax
   1855dbf82:	48 89 8d e8 0d 00 00 	mov    QWORD PTR [rbp+0xde8],rcx
   1855dbf89:	0f 29 b5 40 0e 00 00 	movaps XMMWORD PTR [rbp+0xe40],xmm6
   1855dbf90:	48 8b 88 f8 08 00 00 	mov    rcx,QWORD PTR [rax+0x8f8]
   1855dbf97:	48 85 c9             	test   rcx,rcx
   1855dbf9a:	74 0d                	je     0x1855dbfa9
   1855dbf9c:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   1855dbfa0:	4c 8b b0 f8 08 00 00 	mov    r14,QWORD PTR [rax+0x8f8]
   1855dbfa7:	eb 03                	jmp    0x1855dbfac
   1855dbfa9:	45 31 f6             	xor    r14d,r14d
   1855dbfac:	48 8b 80 f0 08 00 00 	mov    rax,QWORD PTR [rax+0x8f0]
   1855dbfb3:	48 89 85 40 0e 00 00 	mov    QWORD PTR [rbp+0xe40],rax
   1855dbfba:	4c 89 b5 48 0e 00 00 	mov    QWORD PTR [rbp+0xe48],r14
   1855dbfc1:	48 85 c0             	test   rax,rax
   1855dbfc4:	0f 85 93 08 00 00    	jne    0x1855dc85d
   1855dbfca:	b9 38 01 00 00       	mov    ecx,0x138
   1855dbfcf:	e8 08 fd f6 01       	call   0x18754bcdc
   1855dbfd4:	90                   	nop
   1855dbfd5:	48 b9 01 00 00 00 01 	movabs rcx,0x100000001
   1855dbfdc:	00 00 00
   1855dbfdf:	48 89 48 08          	mov    QWORD PTR [rax+0x8],rcx
   1855dbfe3:	48 8d 0d de 4c 99 03 	lea    rcx,[rip+0x3994cde]        # 0x188f70cc8
   1855dbfea:	48 89 08             	mov    QWORD PTR [rax],rcx
   1855dbfed:	48 89 c1             	mov    rcx,rax
   1855dbff0:	48 83 c1 10          	add    rcx,0x10
   1855dbff4:	66 0f ef c0          	pxor   xmm0,xmm0
   1855dbff8:	f3 0f 7f 40 20       	movdqu XMMWORD PTR [rax+0x20],xmm0
   1855dbffd:	f3 0f 7f 40 40       	movdqu XMMWORD PTR [rax+0x40],xmm0
   1855dc002:	f3 0f 7f 40 60       	movdqu XMMWORD PTR [rax+0x60],xmm0
   1855dc007:	f3 0f 7f 40 10       	movdqu XMMWORD PTR [rax+0x10],xmm0
   1855dc00c:	f3 0f 7f 40 70       	movdqu XMMWORD PTR [rax+0x70],xmm0
   1855dc011:	f3 0f 7f 80 80 00 00 	movdqu XMMWORD PTR [rax+0x80],xmm0
   1855dc018:	00
   1855dc019:	f3 0f 7f 80 90 00 00 	movdqu XMMWORD PTR [rax+0x90],xmm0
   1855dc020:	00
   1855dc021:	f3 0f 7f 80 a0 00 00 	movdqu XMMWORD PTR [rax+0xa0],xmm0
   1855dc028:	00
   1855dc029:	f3 0f 7f 80 b0 00 00 	movdqu XMMWORD PTR [rax+0xb0],xmm0
   1855dc030:	00
   1855dc031:	f3 0f 7f 80 c0 00 00 	movdqu XMMWORD PTR [rax+0xc0],xmm0
   1855dc038:	00
   1855dc039:	f3 0f 7f 40 50       	movdqu XMMWORD PTR [rax+0x50],xmm0
   1855dc03e:	48 c7 80 d0 00 00 00 	mov    QWORD PTR [rax+0xd0],0x0
   1855dc045:	00 00 00 00
   1855dc049:	48 c7 40 28 0f 00 00 	mov    QWORD PTR [rax+0x28],0xf
   1855dc050:	00
   1855dc051:	f3 0f 7f 40 30       	movdqu XMMWORD PTR [rax+0x30],xmm0
   1855dc056:	48 c7 40 40 00 00 00 	mov    QWORD PTR [rax+0x40],0x0
   1855dc05d:	00
   1855dc05e:	48 c7 40 48 0f 00 00 	mov    QWORD PTR [rax+0x48],0xf
   1855dc065:	00
   1855dc066:	48 c7 40 60 00 00 00 	mov    QWORD PTR [rax+0x60],0x0
   1855dc06d:	00
   1855dc06e:	48 c7 40 68 0f 00 00 	mov    QWORD PTR [rax+0x68],0xf
   1855dc075:	00
   1855dc076:	f3 0f 7f 40 70       	movdqu XMMWORD PTR [rax+0x70],xmm0
   1855dc07b:	48 c7 80 80 00 00 00 	mov    QWORD PTR [rax+0x80],0x0
   1855dc082:	00 00 00 00
   1855dc086:	48 c7 80 88 00 00 00 	mov    QWORD PTR [rax+0x88],0xf
   1855dc08d:	0f 00 00 00
   1855dc091:	f3 0f 7f 80 90 00 00 	movdqu XMMWORD PTR [rax+0x90],xmm0
   1855dc098:	00
   1855dc099:	48 c7 80 a0 00 00 00 	mov    QWORD PTR [rax+0xa0],0x0
   1855dc0a0:	00 00 00 00
   1855dc0a4:	48 c7 80 a8 00 00 00 	mov    QWORD PTR [rax+0xa8],0xf
   1855dc0ab:	0f 00 00 00
   1855dc0af:	f3 0f 7f 80 b0 00 00 	movdqu XMMWORD PTR [rax+0xb0],xmm0
   1855dc0b6:	00
   1855dc0b7:	48 c7 80 c0 00 00 00 	mov    QWORD PTR [rax+0xc0],0x0
   1855dc0be:	00 00 00 00
   1855dc0c2:	48 c7 80 c8 00 00 00 	mov    QWORD PTR [rax+0xc8],0xf
   1855dc0c9:	0f 00 00 00
   1855dc0cd:	f3 0f 7f 80 d8 00 00 	movdqu XMMWORD PTR [rax+0xd8],xmm0
   1855dc0d4:	00
   1855dc0d5:	48 c7 80 e8 00 00 00 	mov    QWORD PTR [rax+0xe8],0x0
   1855dc0dc:	00 00 00 00
   1855dc0e0:	48 c7 80 f0 00 00 00 	mov    QWORD PTR [rax+0xf0],0xf
   1855dc0e7:	0f 00 00 00
   1855dc0eb:	f3 0f 7f 80 f8 00 00 	movdqu XMMWORD PTR [rax+0xf8],xmm0
   1855dc0f2:	00
   1855dc0f3:	48 c7 80 08 01 00 00 	mov    QWORD PTR [rax+0x108],0x0
   1855dc0fa:	00 00 00 00
   1855dc0fe:	48 c7 80 10 01 00 00 	mov    QWORD PTR [rax+0x110],0xf
   1855dc105:	0f 00 00 00
   1855dc109:	f3 0f 7f 80 18 01 00 	movdqu XMMWORD PTR [rax+0x118],xmm0
   1855dc110:	00
   1855dc111:	48 c7 80 28 01 00 00 	mov    QWORD PTR [rax+0x128],0x0
   1855dc118:	00 00 00 00
   1855dc11c:	48 c7 80 30 01 00 00 	mov    QWORD PTR [rax+0x130],0xf
   1855dc123:	0f 00 00 00
   1855dc127:	48 89 8d 40 0e 00 00 	mov    QWORD PTR [rbp+0xe40],rcx
   1855dc12e:	48 89 85 48 0e 00 00 	mov    QWORD PTR [rbp+0xe48],rax
   1855dc135:	4d 85 f6             	test   r14,r14
   1855dc138:	74 26                	je     0x1855dc160
   1855dc13a:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1855dc13f:	75 18                	jne    0x1855dc159
   1855dc141:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855dc144:	4c 89 f1             	mov    rcx,r14
   1855dc147:	ff 10                	call   QWORD PTR [rax]
   1855dc149:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1855dc14e:	75 09                	jne    0x1855dc159
   1855dc150:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855dc153:	4c 89 f1             	mov    rcx,r14
   1855dc156:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dc159:	48 8b 85 48 0e 00 00 	mov    rax,QWORD PTR [rbp+0xe48]
   1855dc160:	48 8b 8d e0 0d 00 00 	mov    rcx,QWORD PTR [rbp+0xde0]
   1855dc167:	48 85 c0             	test   rax,rax
   1855dc16a:	0f 84 aa 01 00 00    	je     0x1855dc31a
   1855dc170:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1855dc174:	48 8b 85 40 0e 00 00 	mov    rax,QWORD PTR [rbp+0xe40]
   1855dc17b:	4c 8b b5 48 0e 00 00 	mov    r14,QWORD PTR [rbp+0xe48]
   1855dc182:	4d 85 f6             	test   r14,r14
   1855dc185:	0f 84 71 06 00 00    	je     0x1855dc7fc
   1855dc18b:	f0 41 ff 46 08       	lock inc DWORD PTR [r14+0x8]
   1855dc190:	31 ff                	xor    edi,edi
   1855dc192:	e9 6b 06 00 00       	jmp    0x1855dc802
   1855dc197:	31 c9                	xor    ecx,ecx
   1855dc199:	48 89 85 c0 0e 00 00 	mov    QWORD PTR [rbp+0xec0],rax
   1855dc1a0:	48 89 8d c8 0e 00 00 	mov    QWORD PTR [rbp+0xec8],rcx
   1855dc1a7:	0f 29 b5 90 0f 00 00 	movaps XMMWORD PTR [rbp+0xf90],xmm6
   1855dc1ae:	48 8b 88 48 08 00 00 	mov    rcx,QWORD PTR [rax+0x848]
   1855dc1b5:	48 85 c9             	test   rcx,rcx
   1855dc1b8:	74 0d                	je     0x1855dc1c7
   1855dc1ba:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   1855dc1be:	48 8b 98 48 08 00 00 	mov    rbx,QWORD PTR [rax+0x848]
   1855dc1c5:	eb 02                	jmp    0x1855dc1c9
   1855dc1c7:	31 db                	xor    ebx,ebx
   1855dc1c9:	48 8b 80 40 08 00 00 	mov    rax,QWORD PTR [rax+0x840]
   1855dc1d0:	48 89 85 90 0f 00 00 	mov    QWORD PTR [rbp+0xf90],rax
   1855dc1d7:	48 89 9d 98 0f 00 00 	mov    QWORD PTR [rbp+0xf98],rbx
   1855dc1de:	48 85 c0             	test   rax,rax
   1855dc1e1:	0f 84 c9 0a 00 00    	je     0x1855dccb0
   1855dc1e7:	48 83 78 10 00       	cmp    QWORD PTR [rax+0x10],0x0
   1855dc1ec:	0f 85 be 0a 00 00    	jne    0x1855dccb0
   1855dc1f2:	0f 29 b5 40 0f 00 00 	movaps XMMWORD PTR [rbp+0xf40],xmm6
   1855dc1f9:	e8 12 9b a6 fa       	call   0x180045d10
   1855dc1fe:	90                   	nop
   1855dc1ff:	4c 8b 00             	mov    r8,QWORD PTR [rax]
   1855dc202:	48 8d 95 80 0e 00 00 	lea    rdx,[rbp+0xe80]
   1855dc209:	48 89 c1             	mov    rcx,rax
   1855dc20c:	41 ff 50 60          	call   QWORD PTR [r8+0x60]
   1855dc210:	90                   	nop
   1855dc211:	48 8b 8d 80 0e 00 00 	mov    rcx,QWORD PTR [rbp+0xe80]
   1855dc218:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   1855dc21b:	48 8d 95 20 0d 00 00 	lea    rdx,[rbp+0xd20]
   1855dc222:	ff 50 38             	call   QWORD PTR [rax+0x38]
   1855dc225:	90                   	nop
   1855dc226:	48 8b 8d 20 0d 00 00 	mov    rcx,QWORD PTR [rbp+0xd20]
   1855dc22d:	48 8d 05 44 ef a4 03 	lea    rax,[rip+0x3a4ef44]        # 0x18902b178
   1855dc234:	48 89 85 e0 0d 00 00 	mov    QWORD PTR [rbp+0xde0],rax
   1855dc23b:	0f 29 b5 90 01 00 00 	movaps XMMWORD PTR [rbp+0x190],xmm6
   1855dc242:	48 8d 95 90 01 00 00 	lea    rdx,[rbp+0x190]
   1855dc249:	4c 8d 85 e0 0d 00 00 	lea    r8,[rbp+0xde0]
   1855dc250:	e8 8b b9 de fa       	call   0x1803c7be0
   1855dc255:	90                   	nop
   1855dc256:	48 8b 85 90 01 00 00 	mov    rax,QWORD PTR [rbp+0x190]
   1855dc25d:	48 8b 8d 98 01 00 00 	mov    rcx,QWORD PTR [rbp+0x198]
   1855dc264:	48 85 c9             	test   rcx,rcx
   1855dc267:	0f 84 3e 09 00 00    	je     0x1855dcbab
   1855dc26d:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   1855dc271:	48 8b b5 98 01 00 00 	mov    rsi,QWORD PTR [rbp+0x198]
   1855dc278:	48 89 85 70 0d 00 00 	mov    QWORD PTR [rbp+0xd70],rax
   1855dc27f:	48 89 b5 78 0d 00 00 	mov    QWORD PTR [rbp+0xd78],rsi
   1855dc286:	48 85 f6             	test   rsi,rsi
   1855dc289:	0f 84 2e 09 00 00    	je     0x1855dcbbd
   1855dc28f:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855dc293:	0f 85 24 09 00 00    	jne    0x1855dcbbd
   1855dc299:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dc29c:	48 89 f1             	mov    rcx,rsi
   1855dc29f:	ff 10                	call   QWORD PTR [rax]
   1855dc2a1:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855dc2a5:	0f 85 12 09 00 00    	jne    0x1855dcbbd
   1855dc2ab:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dc2ae:	48 89 f1             	mov    rcx,rsi
   1855dc2b1:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dc2b4:	e9 04 09 00 00       	jmp    0x1855dcbbd
   1855dc2b9:	0f 29 b5 80 0e 00 00 	movaps XMMWORD PTR [rbp+0xe80],xmm6
   1855dc2c0:	48 8b 8d f8 08 00 00 	mov    rcx,QWORD PTR [rbp+0x8f8]
   1855dc2c7:	c7 44 24 20 00 00 00 	mov    DWORD PTR [rsp+0x20],0x0
   1855dc2ce:	00
   1855dc2cf:	4c 8d 05 ea 2d d4 05 	lea    r8,[rip+0x5d42dea]        # 0x18b31f0c0
   1855dc2d6:	4c 8d 0d 13 2e d4 05 	lea    r9,[rip+0x5d42e13]        # 0x18b31f0f0
   1855dc2dd:	31 d2                	xor    edx,edx
   1855dc2df:	e8 08 85 0e 02       	call   0x1876c47ec
   1855dc2e4:	90                   	nop
   1855dc2e5:	48 85 c0             	test   rax,rax
   1855dc2e8:	0f 84 a9 34 00 00    	je     0x1855df797
   1855dc2ee:	48 8b 8d 00 09 00 00 	mov    rcx,QWORD PTR [rbp+0x900]
   1855dc2f5:	48 85 c9             	test   rcx,rcx
   1855dc2f8:	0f 84 12 0a 00 00    	je     0x1855dcd10
   1855dc2fe:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   1855dc302:	4c 8b bd 00 09 00 00 	mov    r15,QWORD PTR [rbp+0x900]
   1855dc309:	e9 05 0a 00 00       	jmp    0x1855dcd13
   1855dc30e:	40 b7 01             	mov    dil,0x1
   1855dc311:	48 8b 85 90 0f 00 00 	mov    rax,QWORD PTR [rbp+0xf90]
   1855dc318:	eb 12                	jmp    0x1855dc32c
   1855dc31a:	40 b7 01             	mov    dil,0x1
   1855dc31d:	48 8b 85 40 0e 00 00 	mov    rax,QWORD PTR [rbp+0xe40]
   1855dc324:	e9 d6 04 00 00       	jmp    0x1855dc7ff
   1855dc329:	40 b7 01             	mov    dil,0x1
   1855dc32c:	45 31 f6             	xor    r14d,r14d
   1855dc32f:	48 89 81 88 06 00 00 	mov    QWORD PTR [rcx+0x688],rax
   1855dc336:	48 8b b1 90 06 00 00 	mov    rsi,QWORD PTR [rcx+0x690]
   1855dc33d:	4c 89 b1 90 06 00 00 	mov    QWORD PTR [rcx+0x690],r14
   1855dc344:	48 85 f6             	test   rsi,rsi
   1855dc347:	74 1d                	je     0x1855dc366
   1855dc349:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855dc34d:	75 17                	jne    0x1855dc366
   1855dc34f:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dc352:	48 89 f1             	mov    rcx,rsi
   1855dc355:	ff 10                	call   QWORD PTR [rax]
   1855dc357:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855dc35b:	75 09                	jne    0x1855dc366
   1855dc35d:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dc360:	48 89 f1             	mov    rcx,rsi
   1855dc363:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dc366:	40 84 ff             	test   dil,dil
   1855dc369:	75 1f                	jne    0x1855dc38a
   1855dc36b:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1855dc370:	75 18                	jne    0x1855dc38a
   1855dc372:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855dc375:	4c 89 f1             	mov    rcx,r14
   1855dc378:	ff 10                	call   QWORD PTR [rax]
   1855dc37a:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1855dc37f:	75 09                	jne    0x1855dc38a
   1855dc381:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855dc384:	4c 89 f1             	mov    rcx,r14
   1855dc387:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dc38a:	0f 29 b5 50 02 00 00 	movaps XMMWORD PTR [rbp+0x250],xmm6
   1855dc391:	0f 29 b5 40 02 00 00 	movaps XMMWORD PTR [rbp+0x240],xmm6
   1855dc398:	0f 29 b5 30 02 00 00 	movaps XMMWORD PTR [rbp+0x230],xmm6
   1855dc39f:	0f 29 b5 20 02 00 00 	movaps XMMWORD PTR [rbp+0x220],xmm6
   1855dc3a6:	0f 29 b5 10 02 00 00 	movaps XMMWORD PTR [rbp+0x210],xmm6
   1855dc3ad:	0f 29 b5 00 02 00 00 	movaps XMMWORD PTR [rbp+0x200],xmm6
   1855dc3b4:	0f 29 b5 f0 01 00 00 	movaps XMMWORD PTR [rbp+0x1f0],xmm6
   1855dc3bb:	0f 29 b5 e0 01 00 00 	movaps XMMWORD PTR [rbp+0x1e0],xmm6
   1855dc3c2:	0f 29 b5 d0 01 00 00 	movaps XMMWORD PTR [rbp+0x1d0],xmm6
   1855dc3c9:	0f 29 b5 c0 01 00 00 	movaps XMMWORD PTR [rbp+0x1c0],xmm6
   1855dc3d0:	0f 29 b5 b0 01 00 00 	movaps XMMWORD PTR [rbp+0x1b0],xmm6
   1855dc3d7:	0f 29 b5 a0 01 00 00 	movaps XMMWORD PTR [rbp+0x1a0],xmm6
   1855dc3de:	0f 29 b5 90 01 00 00 	movaps XMMWORD PTR [rbp+0x190],xmm6
   1855dc3e5:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855dc3ec:	e8 ef 03 09 fb       	call   0x18066c7e0
   1855dc3f1:	90                   	nop
   1855dc3f2:	48 8d 95 90 01 00 00 	lea    rdx,[rbp+0x190]
   1855dc3f9:	48 89 d9             	mov    rcx,rbx
   1855dc3fc:	e8 2f 54 9e fb       	call   0x180fc1830
   1855dc401:	90                   	nop
   1855dc402:	84 c0                	test   al,al
   1855dc404:	0f 84 a8 03 00 00    	je     0x1855dc7b2
   1855dc40a:	48 b8 aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaaa
   1855dc411:	aa aa aa
   1855dc414:	48 89 85 70 0d 00 00 	mov    QWORD PTR [rbp+0xd70],rax
   1855dc41b:	48 83 bd 90 01 00 00 	cmp    QWORD PTR [rbp+0x190],0x0
   1855dc422:	00
   1855dc423:	0f 84 ad 02 00 00    	je     0x1855dc6d6
   1855dc429:	48 89 85 40 0f 00 00 	mov    QWORD PTR [rbp+0xf40],rax
   1855dc430:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855dc437:	48 8d 95 40 0f 00 00 	lea    rdx,[rbp+0xf40]
   1855dc43e:	e8 0d ab 08 fb       	call   0x180666f50
   1855dc443:	90                   	nop
   1855dc444:	48 8b 85 40 0f 00 00 	mov    rax,QWORD PTR [rbp+0xf40]
   1855dc44b:	48 85 c0             	test   rax,rax
   1855dc44e:	0f 84 73 02 00 00    	je     0x1855dc6c7
   1855dc454:	48 8d 9d 40 0f 00 00 	lea    rbx,[rbp+0xf40]
   1855dc45b:	0f 57 ff             	xorps  xmm7,xmm7
   1855dc45e:	4c 8d b5 60 09 00 00 	lea    r14,[rbp+0x960]
   1855dc465:	66 44 0f 6f 05 92 73 	movdqa xmm8,XMMWORD PTR [rip+0x4427392]        # 0x189a03800
   1855dc46c:	42 04
   1855dc46e:	66 44 0f 6f 0d 99 73 	movdqa xmm9,XMMWORD PTR [rip+0x4427399]        # 0x189a03810
   1855dc475:	42 04
   1855dc477:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
   1855dc47e:	00 00
   1855dc480:	48 3b 85 90 01 00 00 	cmp    rax,QWORD PTR [rbp+0x190]
   1855dc487:	0f 84 3a 02 00 00    	je     0x1855dc6c7
   1855dc48d:	48 89 d9             	mov    rcx,rbx
   1855dc490:	e8 4b ac 08 fb       	call   0x1806670e0
   1855dc495:	90                   	nop
   1855dc496:	49 89 c7             	mov    r15,rax
   1855dc499:	0f 29 bd 60 09 00 00 	movaps XMMWORD PTR [rbp+0x960],xmm7
   1855dc4a0:	48 89 c1             	mov    rcx,rax
   1855dc4a3:	e8 f8 8e 11 02       	call   0x1876f53a0
   1855dc4a8:	48 85 c0             	test   rax,rax
   1855dc4ab:	0f 88 36 33 00 00    	js     0x1855df7e7
   1855dc4b1:	49 89 c4             	mov    r12,rax
   1855dc4b4:	bf 0f 00 00 00       	mov    edi,0xf
   1855dc4b9:	4c 89 f6             	mov    rsi,r14
   1855dc4bc:	48 83 f8 10          	cmp    rax,0x10
   1855dc4c0:	72 57                	jb     0x1855dc519
   1855dc4c2:	4c 89 e0             	mov    rax,r12
   1855dc4c5:	48 83 c8 0f          	or     rax,0xf
   1855dc4c9:	48 83 f8 17          	cmp    rax,0x17
   1855dc4cd:	bf 16 00 00 00       	mov    edi,0x16
   1855dc4d2:	48 0f 43 f8          	cmovae rdi,rax
   1855dc4d6:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   1855dc4dc:	72 27                	jb     0x1855dc505
   1855dc4de:	48 8d 4f 28          	lea    rcx,[rdi+0x28]
   1855dc4e2:	e8 f5 f7 f6 01       	call   0x18754bcdc
   1855dc4e7:	90                   	nop
   1855dc4e8:	48 89 c6             	mov    rsi,rax
   1855dc4eb:	48 85 c0             	test   rax,rax
   1855dc4ee:	0f 84 b9 32 00 00    	je     0x1855df7ad
   1855dc4f4:	48 89 f0             	mov    rax,rsi
   1855dc4f7:	48 83 c6 27          	add    rsi,0x27
   1855dc4fb:	48 83 e6 e0          	and    rsi,0xffffffffffffffe0
   1855dc4ff:	48 89 46 f8          	mov    QWORD PTR [rsi-0x8],rax
   1855dc503:	eb 0d                	jmp    0x1855dc512
   1855dc505:	48 8d 4f 01          	lea    rcx,[rdi+0x1]
   1855dc509:	e8 ce f7 f6 01       	call   0x18754bcdc
   1855dc50e:	90                   	nop
   1855dc50f:	48 89 c6             	mov    rsi,rax
   1855dc512:	48 89 b5 60 09 00 00 	mov    QWORD PTR [rbp+0x960],rsi
   1855dc519:	4c 89 a5 70 09 00 00 	mov    QWORD PTR [rbp+0x970],r12
   1855dc520:	48 89 bd 78 09 00 00 	mov    QWORD PTR [rbp+0x978],rdi
   1855dc527:	48 89 f1             	mov    rcx,rsi
   1855dc52a:	4c 89 fa             	mov    rdx,r15
   1855dc52d:	4d 89 e0             	mov    r8,r12
   1855dc530:	e8 0b 89 13 02       	call   0x187714e40
   1855dc535:	42 c6 04 26 00       	mov    BYTE PTR [rsi+r12*1],0x0
   1855dc53a:	48 8b 8d 60 09 00 00 	mov    rcx,QWORD PTR [rbp+0x960]
   1855dc541:	48 8b 85 78 09 00 00 	mov    rax,QWORD PTR [rbp+0x978]
   1855dc548:	48 83 bd 70 09 00 00 	cmp    QWORD PTR [rbp+0x970],0x15
   1855dc54f:	15
   1855dc550:	75 38                	jne    0x1855dc58a
   1855dc552:	48 83 f8 10          	cmp    rax,0x10
   1855dc556:	4c 89 f2             	mov    rdx,r14
   1855dc559:	48 0f 43 d1          	cmovae rdx,rcx
   1855dc55d:	f3 0f 6f 02          	movdqu xmm0,XMMWORD PTR [rdx]
   1855dc561:	66 41 0f 74 c1       	pcmpeqb xmm0,xmm9
   1855dc566:	f3 0f 6f 4a 05       	movdqu xmm1,XMMWORD PTR [rdx+0x5]
   1855dc56b:	66 41 0f 74 c8       	pcmpeqb xmm1,xmm8
   1855dc570:	66 0f db c8          	pand   xmm1,xmm0
   1855dc574:	66 0f d7 d1          	pmovmskb edx,xmm1
   1855dc578:	81 fa ff ff 00 00    	cmp    edx,0xffff
   1855dc57e:	40 0f 94 c6          	sete   sil
   1855dc582:	48 83 f8 10          	cmp    rax,0x10
   1855dc586:	73 0a                	jae    0x1855dc592
   1855dc588:	eb 39                	jmp    0x1855dc5c3
   1855dc58a:	31 f6                	xor    esi,esi
   1855dc58c:	48 83 f8 10          	cmp    rax,0x10
   1855dc590:	72 31                	jb     0x1855dc5c3
   1855dc592:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855dc596:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855dc59d:	72 1f                	jb     0x1855dc5be
   1855dc59f:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855dc5a3:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855dc5a7:	4c 29 c1             	sub    rcx,r8
   1855dc5aa:	48 83 f9 20          	cmp    rcx,0x20
   1855dc5ae:	0f 83 f9 31 00 00    	jae    0x1855df7ad
   1855dc5b4:	48 83 c0 28          	add    rax,0x28
   1855dc5b8:	48 89 c2             	mov    rdx,rax
   1855dc5bb:	4c 89 c1             	mov    rcx,r8
   1855dc5be:	e8 5d f7 f6 01       	call   0x18754bd20
   1855dc5c3:	40 84 f6             	test   sil,sil
   1855dc5c6:	0f 85 42 01 00 00    	jne    0x1855dc70e
   1855dc5cc:	48 89 d9             	mov    rcx,rbx
   1855dc5cf:	4c 89 f2             	mov    rdx,r14
   1855dc5d2:	e8 79 a9 08 fb       	call   0x180666f50
   1855dc5d7:	90                   	nop
   1855dc5d8:	4c 89 f1             	mov    rcx,r14
   1855dc5db:	e8 50 a9 08 fb       	call   0x180666f30
   1855dc5e0:	90                   	nop
   1855dc5e1:	48 85 c0             	test   rax,rax
   1855dc5e4:	74 11                	je     0x1855dc5f7
   1855dc5e6:	48 89 d9             	mov    rcx,rbx
   1855dc5e9:	4c 89 f2             	mov    rdx,r14
   1855dc5ec:	e8 5f a9 08 fb       	call   0x180666f50
   1855dc5f1:	90                   	nop
   1855dc5f2:	e9 b9 00 00 00       	jmp    0x1855dc6b0
   1855dc5f7:	48 89 d9             	mov    rcx,rbx
   1855dc5fa:	4c 89 f2             	mov    rdx,r14
   1855dc5fd:	e8 ae b8 08 fb       	call   0x180667eb0
   1855dc602:	90                   	nop
   1855dc603:	4c 89 f1             	mov    rcx,r14
   1855dc606:	e8 25 a9 08 fb       	call   0x180666f30
   1855dc60b:	90                   	nop
   1855dc60c:	48 85 c0             	test   rax,rax
   1855dc60f:	74 11                	je     0x1855dc622
   1855dc611:	48 89 d9             	mov    rcx,rbx
   1855dc614:	4c 89 f2             	mov    rdx,r14
   1855dc617:	e8 94 b8 08 fb       	call   0x180667eb0
   1855dc61c:	90                   	nop
   1855dc61d:	e9 8e 00 00 00       	jmp    0x1855dc6b0
   1855dc622:	48 89 d9             	mov    rcx,rbx
   1855dc625:	4c 89 f2             	mov    rdx,r14
   1855dc628:	e8 83 b8 08 fb       	call   0x180667eb0
   1855dc62d:	90                   	nop
   1855dc62e:	4c 89 f1             	mov    rcx,r14
   1855dc631:	e8 5a 63 c4 fa       	call   0x180222990
   1855dc636:	90                   	nop
   1855dc637:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
   1855dc63e:	00 00
   1855dc640:	84 c0                	test   al,al
   1855dc642:	74 41                	je     0x1855dc685
   1855dc644:	48 8b 85 40 0f 00 00 	mov    rax,QWORD PTR [rbp+0xf40]
   1855dc64b:	48 3b 85 90 01 00 00 	cmp    rax,QWORD PTR [rbp+0x190]
   1855dc652:	74 6a                	je     0x1855dc6be
   1855dc654:	48 89 d9             	mov    rcx,rbx
   1855dc657:	4c 89 f2             	mov    rdx,r14
   1855dc65a:	e8 71 b8 08 fb       	call   0x180667ed0
   1855dc65f:	90                   	nop
   1855dc660:	48 8b 85 60 09 00 00 	mov    rax,QWORD PTR [rbp+0x960]
   1855dc667:	48 89 85 40 0f 00 00 	mov    QWORD PTR [rbp+0xf40],rax
   1855dc66e:	48 89 d9             	mov    rcx,rbx
   1855dc671:	4c 89 f2             	mov    rdx,r14
   1855dc674:	e8 37 b8 08 fb       	call   0x180667eb0
   1855dc679:	90                   	nop
   1855dc67a:	4c 89 f1             	mov    rcx,r14
   1855dc67d:	e8 0e 63 c4 fa       	call   0x180222990
   1855dc682:	90                   	nop
   1855dc683:	eb bb                	jmp    0x1855dc640
   1855dc685:	48 8b 85 40 0f 00 00 	mov    rax,QWORD PTR [rbp+0xf40]
   1855dc68c:	48 3b 85 90 01 00 00 	cmp    rax,QWORD PTR [rbp+0x190]
   1855dc693:	74 29                	je     0x1855dc6be
   1855dc695:	48 89 d9             	mov    rcx,rbx
   1855dc698:	4c 89 f2             	mov    rdx,r14
   1855dc69b:	e8 10 b8 08 fb       	call   0x180667eb0
   1855dc6a0:	90                   	nop
   1855dc6a1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   1855dc6a8:	0f 1f 84 00 00 00 00
   1855dc6af:	00
   1855dc6b0:	48 8b 85 60 09 00 00 	mov    rax,QWORD PTR [rbp+0x960]
   1855dc6b7:	48 89 85 40 0f 00 00 	mov    QWORD PTR [rbp+0xf40],rax
   1855dc6be:	48 85 c0             	test   rax,rax
   1855dc6c1:	0f 85 b9 fd ff ff    	jne    0x1855dc480
   1855dc6c7:	48 8d 8d 70 0d 00 00 	lea    rcx,[rbp+0xd70]
   1855dc6ce:	e8 ed 05 b3 fa       	call   0x18010ccc0
   1855dc6d3:	90                   	nop
   1855dc6d4:	eb 46                	jmp    0x1855dc71c
   1855dc6d6:	48 8d 8d 70 0d 00 00 	lea    rcx,[rbp+0xd70]
   1855dc6dd:	e8 de 05 b3 fa       	call   0x18010ccc0
   1855dc6e2:	90                   	nop
   1855dc6e3:	eb 37                	jmp    0x1855dc71c
   1855dc6e5:	3b 95 a8 0e 00 00    	cmp    edx,DWORD PTR [rbp+0xea8]
   1855dc6eb:	0f 85 94 16 00 00    	jne    0x1855ddd85
   1855dc6f1:	48 8d 8d 98 0e 00 00 	lea    rcx,[rbp+0xe98]
   1855dc6f8:	ff c2                	inc    edx
   1855dc6fa:	e8 41 8d 7f fb       	call   0x180dd5440
   1855dc6ff:	90                   	nop
   1855dc700:	4c 89 e7             	mov    rdi,r12
   1855dc703:	8b 95 a4 0e 00 00    	mov    edx,DWORD PTR [rbp+0xea4]
   1855dc709:	e9 7a 16 00 00       	jmp    0x1855ddd88
   1855dc70e:	48 8b 85 40 0f 00 00 	mov    rax,QWORD PTR [rbp+0xf40]
   1855dc715:	48 89 85 70 0d 00 00 	mov    QWORD PTR [rbp+0xd70],rax
   1855dc71c:	48 8d 8d 70 0d 00 00 	lea    rcx,[rbp+0xd70]
   1855dc723:	e8 68 62 c4 fa       	call   0x180222990
   1855dc728:	90                   	nop
   1855dc729:	84 c0                	test   al,al
   1855dc72b:	0f 85 81 00 00 00    	jne    0x1855dc7b2
   1855dc731:	4c 8d 05 b0 4f e6 03 	lea    r8,[rip+0x3e64fb0]        # 0x1894416e8
   1855dc738:	48 8d 8d 70 0d 00 00 	lea    rcx,[rbp+0xd70]
   1855dc73f:	48 8d 95 60 09 00 00 	lea    rdx,[rbp+0x960]
   1855dc746:	e8 55 b6 08 fb       	call   0x180667da0
   1855dc74b:	90                   	nop
   1855dc74c:	48 8d 8d 60 09 00 00 	lea    rcx,[rbp+0x960]
   1855dc753:	e8 38 62 c4 fa       	call   0x180222990
   1855dc758:	90                   	nop
   1855dc759:	84 c0                	test   al,al
   1855dc75b:	74 41                	je     0x1855dc79e
   1855dc75d:	4c 8d 05 84 4f e6 03 	lea    r8,[rip+0x3e64f84]        # 0x1894416e8
   1855dc764:	48 8d 8d 70 0d 00 00 	lea    rcx,[rbp+0xd70]
   1855dc76b:	48 8d 95 40 0f 00 00 	lea    rdx,[rbp+0xf40]
   1855dc772:	e8 19 be 08 fb       	call   0x180668590
   1855dc777:	90                   	nop
   1855dc778:	48 8d 8d 40 0f 00 00 	lea    rcx,[rbp+0xf40]
   1855dc77f:	48 8d 95 60 09 00 00 	lea    rdx,[rbp+0x960]
   1855dc786:	e8 95 b7 08 fb       	call   0x180667f20
   1855dc78b:	90                   	nop
   1855dc78c:	48 8d 8d 60 09 00 00 	lea    rcx,[rbp+0x960]
   1855dc793:	ba 01 00 00 00       	mov    edx,0x1
   1855dc798:	e8 63 f9 08 fb       	call   0x18066c100
   1855dc79d:	90                   	nop
   1855dc79e:	48 8b 8d 90 0f 00 00 	mov    rcx,QWORD PTR [rbp+0xf90]
   1855dc7a5:	48 8b 95 70 0d 00 00 	mov    rdx,QWORD PTR [rbp+0xd70]
   1855dc7ac:	e8 ef f8 e2 fc       	call   0x18240c0a0
   1855dc7b1:	90                   	nop
   1855dc7b2:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855dc7b9:	e8 92 00 09 fb       	call   0x18066c850
   1855dc7be:	48 8b b5 98 0f 00 00 	mov    rsi,QWORD PTR [rbp+0xf98]
   1855dc7c5:	48 85 f6             	test   rsi,rsi
   1855dc7c8:	74 1d                	je     0x1855dc7e7
   1855dc7ca:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855dc7ce:	75 17                	jne    0x1855dc7e7
   1855dc7d0:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dc7d3:	48 89 f1             	mov    rcx,rsi
   1855dc7d6:	ff 10                	call   QWORD PTR [rax]
   1855dc7d8:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855dc7dc:	75 09                	jne    0x1855dc7e7
   1855dc7de:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dc7e1:	48 89 f1             	mov    rcx,rsi
   1855dc7e4:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dc7e7:	48 8b b5 c8 0e 00 00 	mov    rsi,QWORD PTR [rbp+0xec8]
   1855dc7ee:	48 85 f6             	test   rsi,rsi
   1855dc7f1:	0f 85 e7 0c 00 00    	jne    0x1855dd4de
   1855dc7f7:	e9 ff 0c 00 00       	jmp    0x1855dd4fb
   1855dc7fc:	40 b7 01             	mov    dil,0x1
   1855dc7ff:	45 31 f6             	xor    r14d,r14d
   1855dc802:	48 89 81 f0 08 00 00 	mov    QWORD PTR [rcx+0x8f0],rax
   1855dc809:	48 8b b1 f8 08 00 00 	mov    rsi,QWORD PTR [rcx+0x8f8]
   1855dc810:	4c 89 b1 f8 08 00 00 	mov    QWORD PTR [rcx+0x8f8],r14
   1855dc817:	48 85 f6             	test   rsi,rsi
   1855dc81a:	74 1d                	je     0x1855dc839
   1855dc81c:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855dc820:	75 17                	jne    0x1855dc839
   1855dc822:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dc825:	48 89 f1             	mov    rcx,rsi
   1855dc828:	ff 10                	call   QWORD PTR [rax]
   1855dc82a:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855dc82e:	75 09                	jne    0x1855dc839
   1855dc830:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dc833:	48 89 f1             	mov    rcx,rsi
   1855dc836:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dc839:	40 84 ff             	test   dil,dil
   1855dc83c:	75 1f                	jne    0x1855dc85d
   1855dc83e:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1855dc843:	75 18                	jne    0x1855dc85d
   1855dc845:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855dc848:	4c 89 f1             	mov    rcx,r14
   1855dc84b:	ff 10                	call   QWORD PTR [rax]
   1855dc84d:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1855dc852:	75 09                	jne    0x1855dc85d
   1855dc854:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855dc857:	4c 89 f1             	mov    rcx,r14
   1855dc85a:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dc85d:	0f 29 b5 50 02 00 00 	movaps XMMWORD PTR [rbp+0x250],xmm6
   1855dc864:	0f 29 b5 40 02 00 00 	movaps XMMWORD PTR [rbp+0x240],xmm6
   1855dc86b:	0f 29 b5 30 02 00 00 	movaps XMMWORD PTR [rbp+0x230],xmm6
   1855dc872:	0f 29 b5 20 02 00 00 	movaps XMMWORD PTR [rbp+0x220],xmm6
   1855dc879:	0f 29 b5 10 02 00 00 	movaps XMMWORD PTR [rbp+0x210],xmm6
   1855dc880:	0f 29 b5 00 02 00 00 	movaps XMMWORD PTR [rbp+0x200],xmm6
   1855dc887:	0f 29 b5 f0 01 00 00 	movaps XMMWORD PTR [rbp+0x1f0],xmm6
   1855dc88e:	0f 29 b5 e0 01 00 00 	movaps XMMWORD PTR [rbp+0x1e0],xmm6
   1855dc895:	0f 29 b5 d0 01 00 00 	movaps XMMWORD PTR [rbp+0x1d0],xmm6
   1855dc89c:	0f 29 b5 c0 01 00 00 	movaps XMMWORD PTR [rbp+0x1c0],xmm6
   1855dc8a3:	0f 29 b5 b0 01 00 00 	movaps XMMWORD PTR [rbp+0x1b0],xmm6
   1855dc8aa:	0f 29 b5 a0 01 00 00 	movaps XMMWORD PTR [rbp+0x1a0],xmm6
   1855dc8b1:	0f 29 b5 90 01 00 00 	movaps XMMWORD PTR [rbp+0x190],xmm6
   1855dc8b8:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855dc8bf:	e8 1c ff 08 fb       	call   0x18066c7e0
   1855dc8c4:	90                   	nop
   1855dc8c5:	48 8d 95 90 01 00 00 	lea    rdx,[rbp+0x190]
   1855dc8cc:	48 89 d9             	mov    rcx,rbx
   1855dc8cf:	e8 5c 4f 9e fb       	call   0x180fc1830
   1855dc8d4:	90                   	nop
   1855dc8d5:	84 c0                	test   al,al
   1855dc8d7:	0f 84 c0 0b 00 00    	je     0x1855dd49d
   1855dc8dd:	48 b8 aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaaa
   1855dc8e4:	aa aa aa
   1855dc8e7:	48 89 85 f0 0f 00 00 	mov    QWORD PTR [rbp+0xff0],rax
   1855dc8ee:	48 83 bd 90 01 00 00 	cmp    QWORD PTR [rbp+0x190],0x0
   1855dc8f5:	00
   1855dc8f6:	0f 84 9d 02 00 00    	je     0x1855dcb99
   1855dc8fc:	48 89 85 c0 0e 00 00 	mov    QWORD PTR [rbp+0xec0],rax
   1855dc903:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855dc90a:	48 8d 95 c0 0e 00 00 	lea    rdx,[rbp+0xec0]
   1855dc911:	e8 3a a6 08 fb       	call   0x180666f50
   1855dc916:	90                   	nop
   1855dc917:	48 8b 85 c0 0e 00 00 	mov    rax,QWORD PTR [rbp+0xec0]
   1855dc91e:	48 85 c0             	test   rax,rax
   1855dc921:	0f 84 60 02 00 00    	je     0x1855dcb87
   1855dc927:	48 8d 9d c0 0e 00 00 	lea    rbx,[rbp+0xec0]
   1855dc92e:	0f 57 ff             	xorps  xmm7,xmm7
   1855dc931:	4c 8d b5 60 09 00 00 	lea    r14,[rbp+0x960]
   1855dc938:	49 bd 6e 61 6d 65 63 	movabs r13,0x64726163656d616e
   1855dc93f:	61 72 64
   1855dc942:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   1855dc949:	1f 84 00 00 00 00 00
   1855dc950:	48 3b 85 90 01 00 00 	cmp    rax,QWORD PTR [rbp+0x190]
   1855dc957:	0f 84 2a 02 00 00    	je     0x1855dcb87
   1855dc95d:	48 89 d9             	mov    rcx,rbx
   1855dc960:	e8 7b a7 08 fb       	call   0x1806670e0
   1855dc965:	90                   	nop
   1855dc966:	49 89 c7             	mov    r15,rax
   1855dc969:	0f 29 bd 60 09 00 00 	movaps XMMWORD PTR [rbp+0x960],xmm7
   1855dc970:	48 89 c1             	mov    rcx,rax
   1855dc973:	e8 28 8a 11 02       	call   0x1876f53a0
   1855dc978:	48 85 c0             	test   rax,rax
   1855dc97b:	0f 88 6c 2e 00 00    	js     0x1855df7ed
   1855dc981:	49 89 c4             	mov    r12,rax
   1855dc984:	bf 0f 00 00 00       	mov    edi,0xf
   1855dc989:	4c 89 f6             	mov    rsi,r14
   1855dc98c:	48 83 f8 10          	cmp    rax,0x10
   1855dc990:	72 57                	jb     0x1855dc9e9
   1855dc992:	4c 89 e0             	mov    rax,r12
   1855dc995:	48 83 c8 0f          	or     rax,0xf
   1855dc999:	48 83 f8 17          	cmp    rax,0x17
   1855dc99d:	bf 16 00 00 00       	mov    edi,0x16
   1855dc9a2:	48 0f 43 f8          	cmovae rdi,rax
   1855dc9a6:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   1855dc9ac:	72 27                	jb     0x1855dc9d5
   1855dc9ae:	48 8d 4f 28          	lea    rcx,[rdi+0x28]
   1855dc9b2:	e8 25 f3 f6 01       	call   0x18754bcdc
   1855dc9b7:	90                   	nop
   1855dc9b8:	48 89 c6             	mov    rsi,rax
   1855dc9bb:	48 85 c0             	test   rax,rax
   1855dc9be:	0f 84 e9 2d 00 00    	je     0x1855df7ad
   1855dc9c4:	48 89 f0             	mov    rax,rsi
   1855dc9c7:	48 83 c6 27          	add    rsi,0x27
   1855dc9cb:	48 83 e6 e0          	and    rsi,0xffffffffffffffe0
   1855dc9cf:	48 89 46 f8          	mov    QWORD PTR [rsi-0x8],rax
   1855dc9d3:	eb 0d                	jmp    0x1855dc9e2
   1855dc9d5:	48 8d 4f 01          	lea    rcx,[rdi+0x1]
   1855dc9d9:	e8 fe f2 f6 01       	call   0x18754bcdc
   1855dc9de:	90                   	nop
   1855dc9df:	48 89 c6             	mov    rsi,rax
   1855dc9e2:	48 89 b5 60 09 00 00 	mov    QWORD PTR [rbp+0x960],rsi
   1855dc9e9:	4c 89 a5 70 09 00 00 	mov    QWORD PTR [rbp+0x970],r12
   1855dc9f0:	48 89 bd 78 09 00 00 	mov    QWORD PTR [rbp+0x978],rdi
   1855dc9f7:	48 89 f1             	mov    rcx,rsi
   1855dc9fa:	4c 89 fa             	mov    rdx,r15
   1855dc9fd:	4d 89 e0             	mov    r8,r12
   1855dca00:	e8 3b 84 13 02       	call   0x187714e40
   1855dca05:	42 c6 04 26 00       	mov    BYTE PTR [rsi+r12*1],0x0
   1855dca0a:	48 8b 8d 60 09 00 00 	mov    rcx,QWORD PTR [rbp+0x960]
   1855dca11:	48 8b 85 78 09 00 00 	mov    rax,QWORD PTR [rbp+0x978]
   1855dca18:	48 83 bd 70 09 00 00 	cmp    QWORD PTR [rbp+0x970],0xe
   1855dca1f:	0e
   1855dca20:	75 31                	jne    0x1855dca53
   1855dca22:	48 83 f8 10          	cmp    rax,0x10
   1855dca26:	4c 89 f2             	mov    rdx,r14
   1855dca29:	48 0f 43 d1          	cmovae rdx,rcx
   1855dca2d:	4c 8b 02             	mov    r8,QWORD PTR [rdx]
   1855dca30:	49 b9 66 69 6e 64 65 	movabs r9,0x616e7265646e6966
   1855dca37:	72 6e 61
   1855dca3a:	4d 31 c8             	xor    r8,r9
   1855dca3d:	48 8b 52 06          	mov    rdx,QWORD PTR [rdx+0x6]
   1855dca41:	4c 31 ea             	xor    rdx,r13
   1855dca44:	4c 09 c2             	or     rdx,r8
   1855dca47:	40 0f 94 c6          	sete   sil
   1855dca4b:	48 83 f8 10          	cmp    rax,0x10
   1855dca4f:	73 0a                	jae    0x1855dca5b
   1855dca51:	eb 39                	jmp    0x1855dca8c
   1855dca53:	31 f6                	xor    esi,esi
   1855dca55:	48 83 f8 10          	cmp    rax,0x10
   1855dca59:	72 31                	jb     0x1855dca8c
   1855dca5b:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855dca5f:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855dca66:	72 1f                	jb     0x1855dca87
   1855dca68:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855dca6c:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855dca70:	4c 29 c1             	sub    rcx,r8
   1855dca73:	48 83 f9 20          	cmp    rcx,0x20
   1855dca77:	0f 83 30 2d 00 00    	jae    0x1855df7ad
   1855dca7d:	48 83 c0 28          	add    rax,0x28
   1855dca81:	48 89 c2             	mov    rdx,rax
   1855dca84:	4c 89 c1             	mov    rcx,r8
   1855dca87:	e8 94 f2 f6 01       	call   0x18754bd20
   1855dca8c:	40 84 f6             	test   sil,sil
   1855dca8f:	0f 85 b1 05 00 00    	jne    0x1855dd046
   1855dca95:	48 89 d9             	mov    rcx,rbx
   1855dca98:	4c 89 f2             	mov    rdx,r14
   1855dca9b:	e8 b0 a4 08 fb       	call   0x180666f50
   1855dcaa0:	90                   	nop
   1855dcaa1:	4c 89 f1             	mov    rcx,r14
   1855dcaa4:	e8 87 a4 08 fb       	call   0x180666f30
   1855dcaa9:	90                   	nop
   1855dcaaa:	48 85 c0             	test   rax,rax
   1855dcaad:	74 11                	je     0x1855dcac0
   1855dcaaf:	48 89 d9             	mov    rcx,rbx
   1855dcab2:	4c 89 f2             	mov    rdx,r14
   1855dcab5:	e8 96 a4 08 fb       	call   0x180666f50
   1855dcaba:	90                   	nop
   1855dcabb:	e9 b0 00 00 00       	jmp    0x1855dcb70
   1855dcac0:	48 89 d9             	mov    rcx,rbx
   1855dcac3:	4c 89 f2             	mov    rdx,r14
   1855dcac6:	e8 e5 b3 08 fb       	call   0x180667eb0
   1855dcacb:	90                   	nop
   1855dcacc:	4c 89 f1             	mov    rcx,r14
   1855dcacf:	e8 5c a4 08 fb       	call   0x180666f30
   1855dcad4:	90                   	nop
   1855dcad5:	48 85 c0             	test   rax,rax
   1855dcad8:	74 11                	je     0x1855dcaeb
   1855dcada:	48 89 d9             	mov    rcx,rbx
   1855dcadd:	4c 89 f2             	mov    rdx,r14
   1855dcae0:	e8 cb b3 08 fb       	call   0x180667eb0
   1855dcae5:	90                   	nop
   1855dcae6:	e9 85 00 00 00       	jmp    0x1855dcb70
   1855dcaeb:	48 89 d9             	mov    rcx,rbx
   1855dcaee:	4c 89 f2             	mov    rdx,r14
   1855dcaf1:	e8 ba b3 08 fb       	call   0x180667eb0
   1855dcaf6:	90                   	nop
   1855dcaf7:	4c 89 f1             	mov    rcx,r14
   1855dcafa:	e8 91 5e c4 fa       	call   0x180222990
   1855dcaff:	90                   	nop
   1855dcb00:	84 c0                	test   al,al
   1855dcb02:	74 41                	je     0x1855dcb45
   1855dcb04:	48 8b 85 c0 0e 00 00 	mov    rax,QWORD PTR [rbp+0xec0]
   1855dcb0b:	48 3b 85 90 01 00 00 	cmp    rax,QWORD PTR [rbp+0x190]
   1855dcb12:	74 6a                	je     0x1855dcb7e
   1855dcb14:	48 89 d9             	mov    rcx,rbx
   1855dcb17:	4c 89 f2             	mov    rdx,r14
   1855dcb1a:	e8 b1 b3 08 fb       	call   0x180667ed0
   1855dcb1f:	90                   	nop
   1855dcb20:	48 8b 85 60 09 00 00 	mov    rax,QWORD PTR [rbp+0x960]
   1855dcb27:	48 89 85 c0 0e 00 00 	mov    QWORD PTR [rbp+0xec0],rax
   1855dcb2e:	48 89 d9             	mov    rcx,rbx
   1855dcb31:	4c 89 f2             	mov    rdx,r14
   1855dcb34:	e8 77 b3 08 fb       	call   0x180667eb0
   1855dcb39:	90                   	nop
   1855dcb3a:	4c 89 f1             	mov    rcx,r14
   1855dcb3d:	e8 4e 5e c4 fa       	call   0x180222990
   1855dcb42:	90                   	nop
   1855dcb43:	eb bb                	jmp    0x1855dcb00
   1855dcb45:	48 8b 85 c0 0e 00 00 	mov    rax,QWORD PTR [rbp+0xec0]
   1855dcb4c:	48 3b 85 90 01 00 00 	cmp    rax,QWORD PTR [rbp+0x190]
   1855dcb53:	74 29                	je     0x1855dcb7e
   1855dcb55:	48 89 d9             	mov    rcx,rbx
   1855dcb58:	4c 89 f2             	mov    rdx,r14
   1855dcb5b:	e8 50 b3 08 fb       	call   0x180667eb0
   1855dcb60:	90                   	nop
   1855dcb61:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   1855dcb68:	0f 1f 84 00 00 00 00
   1855dcb6f:	00
   1855dcb70:	48 8b 85 60 09 00 00 	mov    rax,QWORD PTR [rbp+0x960]
   1855dcb77:	48 89 85 c0 0e 00 00 	mov    QWORD PTR [rbp+0xec0],rax
   1855dcb7e:	48 85 c0             	test   rax,rax
   1855dcb81:	0f 85 c9 fd ff ff    	jne    0x1855dc950
   1855dcb87:	48 8d 8d f0 0f 00 00 	lea    rcx,[rbp+0xff0]
   1855dcb8e:	e8 2d 01 b3 fa       	call   0x18010ccc0
   1855dcb93:	90                   	nop
   1855dcb94:	e9 bb 04 00 00       	jmp    0x1855dd054
   1855dcb99:	48 8d 8d f0 0f 00 00 	lea    rcx,[rbp+0xff0]
   1855dcba0:	e8 1b 01 b3 fa       	call   0x18010ccc0
   1855dcba5:	90                   	nop
   1855dcba6:	e9 a9 04 00 00       	jmp    0x1855dd054
   1855dcbab:	48 89 85 70 0d 00 00 	mov    QWORD PTR [rbp+0xd70],rax
   1855dcbb2:	48 c7 85 78 0d 00 00 	mov    QWORD PTR [rbp+0xd78],0x0
   1855dcbb9:	00 00 00 00
   1855dcbbd:	48 8b 8d 70 0d 00 00 	mov    rcx,QWORD PTR [rbp+0xd70]
   1855dcbc4:	4c 8b 85 90 0f 00 00 	mov    r8,QWORD PTR [rbp+0xf90]
   1855dcbcb:	49 83 c0 20          	add    r8,0x20
   1855dcbcf:	48 8d 95 40 0f 00 00 	lea    rdx,[rbp+0xf40]
   1855dcbd6:	41 b9 01 00 00 00    	mov    r9d,0x1
   1855dcbdc:	e8 2f 80 4c fc       	call   0x181aa4c10
   1855dcbe1:	90                   	nop
   1855dcbe2:	48 8b b5 78 0d 00 00 	mov    rsi,QWORD PTR [rbp+0xd78]
   1855dcbe9:	48 85 f6             	test   rsi,rsi
   1855dcbec:	74 1d                	je     0x1855dcc0b
   1855dcbee:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855dcbf2:	75 17                	jne    0x1855dcc0b
   1855dcbf4:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dcbf7:	48 89 f1             	mov    rcx,rsi
   1855dcbfa:	ff 10                	call   QWORD PTR [rax]
   1855dcbfc:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855dcc00:	75 09                	jne    0x1855dcc0b
   1855dcc02:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dcc05:	48 89 f1             	mov    rcx,rsi
   1855dcc08:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dcc0b:	48 8b b5 28 0d 00 00 	mov    rsi,QWORD PTR [rbp+0xd28]
   1855dcc12:	48 85 f6             	test   rsi,rsi
   1855dcc15:	74 1d                	je     0x1855dcc34
   1855dcc17:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855dcc1b:	75 17                	jne    0x1855dcc34
   1855dcc1d:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dcc20:	48 89 f1             	mov    rcx,rsi
   1855dcc23:	ff 10                	call   QWORD PTR [rax]
   1855dcc25:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855dcc29:	75 09                	jne    0x1855dcc34
   1855dcc2b:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dcc2e:	48 89 f1             	mov    rcx,rsi
   1855dcc31:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dcc34:	48 8b b5 88 0e 00 00 	mov    rsi,QWORD PTR [rbp+0xe88]
   1855dcc3b:	48 85 f6             	test   rsi,rsi
   1855dcc3e:	74 1d                	je     0x1855dcc5d
   1855dcc40:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855dcc44:	75 17                	jne    0x1855dcc5d
   1855dcc46:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dcc49:	48 89 f1             	mov    rcx,rsi
   1855dcc4c:	ff 10                	call   QWORD PTR [rax]
   1855dcc4e:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855dcc52:	75 09                	jne    0x1855dcc5d
   1855dcc54:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dcc57:	48 89 f1             	mov    rcx,rsi
   1855dcc5a:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dcc5d:	48 8b 95 40 0f 00 00 	mov    rdx,QWORD PTR [rbp+0xf40]
   1855dcc64:	48 85 d2             	test   rdx,rdx
   1855dcc67:	74 17                	je     0x1855dcc80
   1855dcc69:	48 8b b5 90 0f 00 00 	mov    rsi,QWORD PTR [rbp+0xf90]
   1855dcc70:	48 89 f1             	mov    rcx,rsi
   1855dcc73:	e8 18 99 1c fb       	call   0x1807a6590
   1855dcc78:	90                   	nop
   1855dcc79:	c7 46 60 02 00 00 00 	mov    DWORD PTR [rsi+0x60],0x2
   1855dcc80:	48 8b b5 48 0f 00 00 	mov    rsi,QWORD PTR [rbp+0xf48]
   1855dcc87:	48 85 f6             	test   rsi,rsi
   1855dcc8a:	74 1d                	je     0x1855dcca9
   1855dcc8c:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855dcc90:	75 17                	jne    0x1855dcca9
   1855dcc92:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dcc95:	48 89 f1             	mov    rcx,rsi
   1855dcc98:	ff 10                	call   QWORD PTR [rax]
   1855dcc9a:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855dcc9e:	75 09                	jne    0x1855dcca9
   1855dcca0:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dcca3:	48 89 f1             	mov    rcx,rsi
   1855dcca6:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dcca9:	48 8b 9d 98 0f 00 00 	mov    rbx,QWORD PTR [rbp+0xf98]
   1855dccb0:	48 85 db             	test   rbx,rbx
   1855dccb3:	74 1d                	je     0x1855dccd2
   1855dccb5:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   1855dccb9:	75 17                	jne    0x1855dccd2
   1855dccbb:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   1855dccbe:	48 89 d9             	mov    rcx,rbx
   1855dccc1:	ff 10                	call   QWORD PTR [rax]
   1855dccc3:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   1855dccc7:	75 09                	jne    0x1855dccd2
   1855dccc9:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   1855dcccc:	48 89 d9             	mov    rcx,rbx
   1855dcccf:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dccd2:	48 8b b5 c8 0e 00 00 	mov    rsi,QWORD PTR [rbp+0xec8]
   1855dccd9:	48 85 f6             	test   rsi,rsi
   1855dccdc:	74 1d                	je     0x1855dccfb
   1855dccde:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855dcce2:	75 17                	jne    0x1855dccfb
   1855dcce4:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dcce7:	48 89 f1             	mov    rcx,rsi
   1855dccea:	ff 10                	call   QWORD PTR [rax]
   1855dccec:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855dccf0:	75 09                	jne    0x1855dccfb
   1855dccf2:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dccf5:	48 89 f1             	mov    rcx,rsi
   1855dccf8:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dccfb:	48 8b b5 68 09 00 00 	mov    rsi,QWORD PTR [rbp+0x968]
   1855dcd02:	48 85 f6             	test   rsi,rsi
   1855dcd05:	0f 85 d3 07 00 00    	jne    0x1855dd4de
   1855dcd0b:	e9 eb 07 00 00       	jmp    0x1855dd4fb
   1855dcd10:	45 31 ff             	xor    r15d,r15d
   1855dcd13:	48 89 85 80 0e 00 00 	mov    QWORD PTR [rbp+0xe80],rax
   1855dcd1a:	4c 89 bd 88 0e 00 00 	mov    QWORD PTR [rbp+0xe88],r15
   1855dcd21:	0f 29 b5 50 02 00 00 	movaps XMMWORD PTR [rbp+0x250],xmm6
   1855dcd28:	0f 29 b5 40 02 00 00 	movaps XMMWORD PTR [rbp+0x240],xmm6
   1855dcd2f:	0f 29 b5 30 02 00 00 	movaps XMMWORD PTR [rbp+0x230],xmm6
   1855dcd36:	0f 29 b5 20 02 00 00 	movaps XMMWORD PTR [rbp+0x220],xmm6
   1855dcd3d:	0f 29 b5 10 02 00 00 	movaps XMMWORD PTR [rbp+0x210],xmm6
   1855dcd44:	0f 29 b5 00 02 00 00 	movaps XMMWORD PTR [rbp+0x200],xmm6
   1855dcd4b:	0f 29 b5 f0 01 00 00 	movaps XMMWORD PTR [rbp+0x1f0],xmm6
   1855dcd52:	0f 29 b5 e0 01 00 00 	movaps XMMWORD PTR [rbp+0x1e0],xmm6
   1855dcd59:	0f 29 b5 d0 01 00 00 	movaps XMMWORD PTR [rbp+0x1d0],xmm6
   1855dcd60:	0f 29 b5 c0 01 00 00 	movaps XMMWORD PTR [rbp+0x1c0],xmm6
   1855dcd67:	0f 29 b5 b0 01 00 00 	movaps XMMWORD PTR [rbp+0x1b0],xmm6
   1855dcd6e:	0f 29 b5 a0 01 00 00 	movaps XMMWORD PTR [rbp+0x1a0],xmm6
   1855dcd75:	0f 29 b5 90 01 00 00 	movaps XMMWORD PTR [rbp+0x190],xmm6
   1855dcd7c:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855dcd83:	e8 58 fa 08 fb       	call   0x18066c7e0
   1855dcd88:	90                   	nop
   1855dcd89:	48 8d 95 90 01 00 00 	lea    rdx,[rbp+0x190]
   1855dcd90:	48 89 d9             	mov    rcx,rbx
   1855dcd93:	e8 98 4a 9e fb       	call   0x180fc1830
   1855dcd98:	90                   	nop
   1855dcd99:	84 c0                	test   al,al
   1855dcd9b:	0f 84 c6 29 00 00    	je     0x1855df767
   1855dcda1:	48 b8 aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaaa
   1855dcda8:	aa aa aa
   1855dcdab:	48 89 85 40 0e 00 00 	mov    QWORD PTR [rbp+0xe40],rax
   1855dcdb2:	48 83 bd 90 01 00 00 	cmp    QWORD PTR [rbp+0x190],0x0
   1855dcdb9:	00
   1855dcdba:	0f 84 be 17 00 00    	je     0x1855de57e
   1855dcdc0:	48 89 85 90 0f 00 00 	mov    QWORD PTR [rbp+0xf90],rax
   1855dcdc7:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855dcdce:	48 8d 95 90 0f 00 00 	lea    rdx,[rbp+0xf90]
   1855dcdd5:	e8 76 a1 08 fb       	call   0x180666f50
   1855dcdda:	90                   	nop
   1855dcddb:	48 8b 85 90 0f 00 00 	mov    rax,QWORD PTR [rbp+0xf90]
   1855dcde2:	48 85 c0             	test   rax,rax
   1855dcde5:	0f 84 49 02 00 00    	je     0x1855dd034
   1855dcdeb:	0f 57 ff             	xorps  xmm7,xmm7
   1855dcdee:	4c 8d a5 60 09 00 00 	lea    r12,[rbp+0x960]
   1855dcdf5:	48 3b 85 90 01 00 00 	cmp    rax,QWORD PTR [rbp+0x190]
   1855dcdfc:	0f 84 32 02 00 00    	je     0x1855dd034
   1855dce02:	48 8d 8d 90 0f 00 00 	lea    rcx,[rbp+0xf90]
   1855dce09:	e8 d2 a2 08 fb       	call   0x1806670e0
   1855dce0e:	90                   	nop
   1855dce0f:	49 89 c5             	mov    r13,rax
   1855dce12:	0f 29 bd 60 09 00 00 	movaps XMMWORD PTR [rbp+0x960],xmm7
   1855dce19:	48 89 c1             	mov    rcx,rax
   1855dce1c:	e8 7f 85 11 02       	call   0x1876f53a0
   1855dce21:	48 85 c0             	test   rax,rax
   1855dce24:	0f 88 c9 29 00 00    	js     0x1855df7f3
   1855dce2a:	49 89 c7             	mov    r15,rax
   1855dce2d:	bf 0f 00 00 00       	mov    edi,0xf
   1855dce32:	4c 89 e6             	mov    rsi,r12
   1855dce35:	48 83 f8 10          	cmp    rax,0x10
   1855dce39:	72 57                	jb     0x1855dce92
   1855dce3b:	4c 89 f8             	mov    rax,r15
   1855dce3e:	48 83 c8 0f          	or     rax,0xf
   1855dce42:	48 83 f8 17          	cmp    rax,0x17
   1855dce46:	bf 16 00 00 00       	mov    edi,0x16
   1855dce4b:	48 0f 43 f8          	cmovae rdi,rax
   1855dce4f:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   1855dce55:	72 27                	jb     0x1855dce7e
   1855dce57:	48 8d 4f 28          	lea    rcx,[rdi+0x28]
   1855dce5b:	e8 7c ee f6 01       	call   0x18754bcdc
   1855dce60:	90                   	nop
   1855dce61:	48 89 c6             	mov    rsi,rax
   1855dce64:	48 85 c0             	test   rax,rax
   1855dce67:	0f 84 40 29 00 00    	je     0x1855df7ad
   1855dce6d:	48 89 f0             	mov    rax,rsi
   1855dce70:	48 83 c6 27          	add    rsi,0x27
   1855dce74:	48 83 e6 e0          	and    rsi,0xffffffffffffffe0
   1855dce78:	48 89 46 f8          	mov    QWORD PTR [rsi-0x8],rax
   1855dce7c:	eb 0d                	jmp    0x1855dce8b
   1855dce7e:	48 8d 4f 01          	lea    rcx,[rdi+0x1]
   1855dce82:	e8 55 ee f6 01       	call   0x18754bcdc
   1855dce87:	90                   	nop
   1855dce88:	48 89 c6             	mov    rsi,rax
   1855dce8b:	48 89 b5 60 09 00 00 	mov    QWORD PTR [rbp+0x960],rsi
   1855dce92:	4c 89 bd 70 09 00 00 	mov    QWORD PTR [rbp+0x970],r15
   1855dce99:	48 89 bd 78 09 00 00 	mov    QWORD PTR [rbp+0x978],rdi
   1855dcea0:	48 89 f1             	mov    rcx,rsi
   1855dcea3:	4c 89 ea             	mov    rdx,r13
   1855dcea6:	4d 89 f8             	mov    r8,r15
   1855dcea9:	e8 92 7f 13 02       	call   0x187714e40
   1855dceae:	42 c6 04 3e 00       	mov    BYTE PTR [rsi+r15*1],0x0
   1855dceb3:	48 8b 8d 60 09 00 00 	mov    rcx,QWORD PTR [rbp+0x960]
   1855dceba:	48 8b 85 78 09 00 00 	mov    rax,QWORD PTR [rbp+0x978]
   1855dcec1:	48 83 bd 70 09 00 00 	cmp    QWORD PTR [rbp+0x970],0x8
   1855dcec8:	08
   1855dcec9:	75 24                	jne    0x1855dceef
   1855dcecb:	48 83 f8 10          	cmp    rax,0x10
   1855dcecf:	4c 89 e2             	mov    rdx,r12
   1855dced2:	48 0f 43 d1          	cmovae rdx,rcx
   1855dced6:	49 b8 72 65 61 6c 5f 	movabs r8,0x6c6d785f6c616572
   1855dcedd:	78 6d 6c
   1855dcee0:	4c 39 02             	cmp    QWORD PTR [rdx],r8
   1855dcee3:	40 0f 94 c6          	sete   sil
   1855dcee7:	48 83 f8 10          	cmp    rax,0x10
   1855dceeb:	73 0a                	jae    0x1855dcef7
   1855dceed:	eb 39                	jmp    0x1855dcf28
   1855dceef:	31 f6                	xor    esi,esi
   1855dcef1:	48 83 f8 10          	cmp    rax,0x10
   1855dcef5:	72 31                	jb     0x1855dcf28
   1855dcef7:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855dcefb:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855dcf02:	72 1f                	jb     0x1855dcf23
   1855dcf04:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855dcf08:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855dcf0c:	4c 29 c1             	sub    rcx,r8
   1855dcf0f:	48 83 f9 20          	cmp    rcx,0x20
   1855dcf13:	0f 83 94 28 00 00    	jae    0x1855df7ad
   1855dcf19:	48 83 c0 28          	add    rax,0x28
   1855dcf1d:	48 89 c2             	mov    rdx,rax
   1855dcf20:	4c 89 c1             	mov    rcx,r8
   1855dcf23:	e8 f8 ed f6 01       	call   0x18754bd20
   1855dcf28:	40 84 f6             	test   sil,sil
   1855dcf2b:	0f 85 05 24 00 00    	jne    0x1855df336
   1855dcf31:	48 8d 8d 90 0f 00 00 	lea    rcx,[rbp+0xf90]
   1855dcf38:	4c 89 e2             	mov    rdx,r12
   1855dcf3b:	e8 10 a0 08 fb       	call   0x180666f50
   1855dcf40:	90                   	nop
   1855dcf41:	4c 89 e1             	mov    rcx,r12
   1855dcf44:	e8 e7 9f 08 fb       	call   0x180666f30
   1855dcf49:	90                   	nop
   1855dcf4a:	48 85 c0             	test   rax,rax
   1855dcf4d:	74 15                	je     0x1855dcf64
   1855dcf4f:	48 8d 8d 90 0f 00 00 	lea    rcx,[rbp+0xf90]
   1855dcf56:	4c 89 e2             	mov    rdx,r12
   1855dcf59:	e8 f2 9f 08 fb       	call   0x180666f50
   1855dcf5e:	90                   	nop
   1855dcf5f:	e9 b9 00 00 00       	jmp    0x1855dd01d
   1855dcf64:	48 8d 8d 90 0f 00 00 	lea    rcx,[rbp+0xf90]
   1855dcf6b:	4c 89 e2             	mov    rdx,r12
   1855dcf6e:	e8 3d af 08 fb       	call   0x180667eb0
   1855dcf73:	90                   	nop
   1855dcf74:	4c 89 e1             	mov    rcx,r12
   1855dcf77:	e8 b4 9f 08 fb       	call   0x180666f30
   1855dcf7c:	90                   	nop
   1855dcf7d:	48 85 c0             	test   rax,rax
   1855dcf80:	74 15                	je     0x1855dcf97
   1855dcf82:	48 8d 8d 90 0f 00 00 	lea    rcx,[rbp+0xf90]
   1855dcf89:	4c 89 e2             	mov    rdx,r12
   1855dcf8c:	e8 1f af 08 fb       	call   0x180667eb0
   1855dcf91:	90                   	nop
   1855dcf92:	e9 86 00 00 00       	jmp    0x1855dd01d
   1855dcf97:	48 8d 8d 90 0f 00 00 	lea    rcx,[rbp+0xf90]
   1855dcf9e:	4c 89 e2             	mov    rdx,r12
   1855dcfa1:	e8 0a af 08 fb       	call   0x180667eb0
   1855dcfa6:	90                   	nop
   1855dcfa7:	4c 89 e1             	mov    rcx,r12
   1855dcfaa:	e8 e1 59 c4 fa       	call   0x180222990
   1855dcfaf:	90                   	nop
   1855dcfb0:	84 c0                	test   al,al
   1855dcfb2:	74 49                	je     0x1855dcffd
   1855dcfb4:	48 8b 85 90 0f 00 00 	mov    rax,QWORD PTR [rbp+0xf90]
   1855dcfbb:	48 3b 85 90 01 00 00 	cmp    rax,QWORD PTR [rbp+0x190]
   1855dcfc2:	74 67                	je     0x1855dd02b
   1855dcfc4:	48 8d 8d 90 0f 00 00 	lea    rcx,[rbp+0xf90]
   1855dcfcb:	4c 89 e2             	mov    rdx,r12
   1855dcfce:	e8 fd ae 08 fb       	call   0x180667ed0
   1855dcfd3:	90                   	nop
   1855dcfd4:	48 8b 85 60 09 00 00 	mov    rax,QWORD PTR [rbp+0x960]
   1855dcfdb:	48 89 85 90 0f 00 00 	mov    QWORD PTR [rbp+0xf90],rax
   1855dcfe2:	48 8d 8d 90 0f 00 00 	lea    rcx,[rbp+0xf90]
   1855dcfe9:	4c 89 e2             	mov    rdx,r12
   1855dcfec:	e8 bf ae 08 fb       	call   0x180667eb0
   1855dcff1:	90                   	nop
   1855dcff2:	4c 89 e1             	mov    rcx,r12
   1855dcff5:	e8 96 59 c4 fa       	call   0x180222990
   1855dcffa:	90                   	nop
   1855dcffb:	eb b3                	jmp    0x1855dcfb0
   1855dcffd:	48 8b 85 90 0f 00 00 	mov    rax,QWORD PTR [rbp+0xf90]
   1855dd004:	48 3b 85 90 01 00 00 	cmp    rax,QWORD PTR [rbp+0x190]
   1855dd00b:	74 1e                	je     0x1855dd02b
   1855dd00d:	48 8d 8d 90 0f 00 00 	lea    rcx,[rbp+0xf90]
   1855dd014:	4c 89 e2             	mov    rdx,r12
   1855dd017:	e8 94 ae 08 fb       	call   0x180667eb0
   1855dd01c:	90                   	nop
   1855dd01d:	48 8b 85 60 09 00 00 	mov    rax,QWORD PTR [rbp+0x960]
   1855dd024:	48 89 85 90 0f 00 00 	mov    QWORD PTR [rbp+0xf90],rax
   1855dd02b:	48 85 c0             	test   rax,rax
   1855dd02e:	0f 85 c1 fd ff ff    	jne    0x1855dcdf5
   1855dd034:	48 8d 8d 40 0e 00 00 	lea    rcx,[rbp+0xe40]
   1855dd03b:	e8 80 fc b2 fa       	call   0x18010ccc0
   1855dd040:	90                   	nop
   1855dd041:	e9 fe 22 00 00       	jmp    0x1855df344
   1855dd046:	48 8b 85 c0 0e 00 00 	mov    rax,QWORD PTR [rbp+0xec0]
   1855dd04d:	48 89 85 f0 0f 00 00 	mov    QWORD PTR [rbp+0xff0],rax
   1855dd054:	48 8d 8d f0 0f 00 00 	lea    rcx,[rbp+0xff0]
   1855dd05b:	e8 30 59 c4 fa       	call   0x180222990
   1855dd060:	90                   	nop
   1855dd061:	84 c0                	test   al,al
   1855dd063:	0f 85 34 04 00 00    	jne    0x1855dd49d
   1855dd069:	0f 29 b5 70 09 00 00 	movaps XMMWORD PTR [rbp+0x970],xmm6
   1855dd070:	0f 29 b5 60 09 00 00 	movaps XMMWORD PTR [rbp+0x960],xmm6
   1855dd077:	4c 8d 05 ee 02 aa 03 	lea    r8,[rip+0x3aa02ee]        # 0x18907d36c
   1855dd07e:	48 8d 8d f0 0f 00 00 	lea    rcx,[rbp+0xff0]
   1855dd085:	48 8d 95 60 0c 00 00 	lea    rdx,[rbp+0xc60]
   1855dd08c:	e8 0f ad 08 fb       	call   0x180667da0
   1855dd091:	90                   	nop
   1855dd092:	48 8b 95 60 0c 00 00 	mov    rdx,QWORD PTR [rbp+0xc60]
   1855dd099:	48 8d 8d 60 09 00 00 	lea    rcx,[rbp+0x960]
   1855dd0a0:	e8 0b 48 9e fb       	call   0x180fc18b0
   1855dd0a5:	90                   	nop
   1855dd0a6:	48 83 bd 70 09 00 00 	cmp    QWORD PTR [rbp+0x970],0x0
   1855dd0ad:	00
   1855dd0ae:	74 14                	je     0x1855dd0c4
   1855dd0b0:	48 8b 8d 40 0e 00 00 	mov    rcx,QWORD PTR [rbp+0xe40]
   1855dd0b7:	48 8d 95 60 09 00 00 	lea    rdx,[rbp+0x960]
   1855dd0be:	e8 ed a2 d4 fc       	call   0x1823273b0
   1855dd0c3:	90                   	nop
   1855dd0c4:	0f 29 b5 d0 0e 00 00 	movaps XMMWORD PTR [rbp+0xed0],xmm6
   1855dd0cb:	0f 29 b5 c0 0e 00 00 	movaps XMMWORD PTR [rbp+0xec0],xmm6
   1855dd0d2:	4c 8d 05 ff 03 30 04 	lea    r8,[rip+0x43003ff]        # 0x1898dd4d8
   1855dd0d9:	48 8d 8d f0 0f 00 00 	lea    rcx,[rbp+0xff0]
   1855dd0e0:	48 8d 95 68 0c 00 00 	lea    rdx,[rbp+0xc68]
   1855dd0e7:	e8 b4 ac 08 fb       	call   0x180667da0
   1855dd0ec:	90                   	nop
   1855dd0ed:	48 8b 95 68 0c 00 00 	mov    rdx,QWORD PTR [rbp+0xc68]
   1855dd0f4:	48 8d 8d c0 0e 00 00 	lea    rcx,[rbp+0xec0]
   1855dd0fb:	e8 b0 47 9e fb       	call   0x180fc18b0
   1855dd100:	90                   	nop
   1855dd101:	48 83 bd d0 0e 00 00 	cmp    QWORD PTR [rbp+0xed0],0x0
   1855dd108:	00
   1855dd109:	74 14                	je     0x1855dd11f
   1855dd10b:	48 8b 8d 40 0e 00 00 	mov    rcx,QWORD PTR [rbp+0xe40]
   1855dd112:	48 8d 95 c0 0e 00 00 	lea    rdx,[rbp+0xec0]
   1855dd119:	e8 52 87 49 fc       	call   0x181a75870
   1855dd11e:	90                   	nop
   1855dd11f:	0f 29 b5 a0 0f 00 00 	movaps XMMWORD PTR [rbp+0xfa0],xmm6
   1855dd126:	0f 29 b5 90 0f 00 00 	movaps XMMWORD PTR [rbp+0xf90],xmm6
   1855dd12d:	4c 8d 05 a4 41 e6 03 	lea    r8,[rip+0x3e641a4]        # 0x1894412d8
   1855dd134:	48 8d 8d f0 0f 00 00 	lea    rcx,[rbp+0xff0]
   1855dd13b:	48 8d 95 70 0c 00 00 	lea    rdx,[rbp+0xc70]
   1855dd142:	e8 59 ac 08 fb       	call   0x180667da0
   1855dd147:	90                   	nop
   1855dd148:	48 8b 95 70 0c 00 00 	mov    rdx,QWORD PTR [rbp+0xc70]
   1855dd14f:	48 8d 8d 90 0f 00 00 	lea    rcx,[rbp+0xf90]
   1855dd156:	e8 55 47 9e fb       	call   0x180fc18b0
   1855dd15b:	90                   	nop
   1855dd15c:	48 83 bd a0 0f 00 00 	cmp    QWORD PTR [rbp+0xfa0],0x0
   1855dd163:	00
   1855dd164:	74 14                	je     0x1855dd17a
   1855dd166:	48 8b 8d 40 0e 00 00 	mov    rcx,QWORD PTR [rbp+0xe40]
   1855dd16d:	48 8d 95 90 0f 00 00 	lea    rdx,[rbp+0xf90]
   1855dd174:	e8 67 aa a8 fb       	call   0x181067be0
   1855dd179:	90                   	nop
   1855dd17a:	0f 29 b5 50 0f 00 00 	movaps XMMWORD PTR [rbp+0xf50],xmm6
   1855dd181:	0f 29 b5 40 0f 00 00 	movaps XMMWORD PTR [rbp+0xf40],xmm6
   1855dd188:	4c 8d 05 99 6e 23 04 	lea    r8,[rip+0x4236e99]        # 0x189814028
   1855dd18f:	48 8d 8d f0 0f 00 00 	lea    rcx,[rbp+0xff0]
   1855dd196:	48 8d 95 78 0c 00 00 	lea    rdx,[rbp+0xc78]
   1855dd19d:	e8 fe ab 08 fb       	call   0x180667da0
   1855dd1a2:	90                   	nop
   1855dd1a3:	48 8b 95 78 0c 00 00 	mov    rdx,QWORD PTR [rbp+0xc78]
   1855dd1aa:	48 8d 8d 40 0f 00 00 	lea    rcx,[rbp+0xf40]
   1855dd1b1:	e8 fa 46 9e fb       	call   0x180fc18b0
   1855dd1b6:	90                   	nop
   1855dd1b7:	48 83 bd 50 0f 00 00 	cmp    QWORD PTR [rbp+0xf50],0x0
   1855dd1be:	00
   1855dd1bf:	74 14                	je     0x1855dd1d5
   1855dd1c1:	48 8b 8d 40 0e 00 00 	mov    rcx,QWORD PTR [rbp+0xe40]
   1855dd1c8:	48 8d 95 40 0f 00 00 	lea    rdx,[rbp+0xf40]
   1855dd1cf:	e8 ac a2 d4 fc       	call   0x182327480
   1855dd1d4:	90                   	nop
   1855dd1d5:	0f 29 b5 80 0d 00 00 	movaps XMMWORD PTR [rbp+0xd80],xmm6
   1855dd1dc:	0f 29 b5 70 0d 00 00 	movaps XMMWORD PTR [rbp+0xd70],xmm6
   1855dd1e3:	4c 8d 05 be f8 2f 04 	lea    r8,[rip+0x42ff8be]        # 0x1898dcaa8
   1855dd1ea:	48 8d 8d f0 0f 00 00 	lea    rcx,[rbp+0xff0]
   1855dd1f1:	48 8d 95 80 0c 00 00 	lea    rdx,[rbp+0xc80]
   1855dd1f8:	e8 a3 ab 08 fb       	call   0x180667da0
   1855dd1fd:	90                   	nop
   1855dd1fe:	48 8b 95 80 0c 00 00 	mov    rdx,QWORD PTR [rbp+0xc80]
   1855dd205:	48 8d 8d 70 0d 00 00 	lea    rcx,[rbp+0xd70]
   1855dd20c:	e8 9f 46 9e fb       	call   0x180fc18b0
   1855dd211:	90                   	nop
   1855dd212:	48 83 bd 80 0d 00 00 	cmp    QWORD PTR [rbp+0xd80],0x0
   1855dd219:	00
   1855dd21a:	0f 84 24 01 00 00    	je     0x1855dd344
   1855dd220:	0f 29 b5 20 0e 00 00 	movaps XMMWORD PTR [rbp+0xe20],xmm6
   1855dd227:	48 8d 8d 20 0e 00 00 	lea    rcx,[rbp+0xe20]
   1855dd22e:	48 8d 95 70 0d 00 00 	lea    rdx,[rbp+0xd70]
   1855dd235:	e8 56 eb 07 fb       	call   0x18065bd90
   1855dd23a:	90                   	nop
   1855dd23b:	80 bd 20 0e 00 00 09 	cmp    BYTE PTR [rbp+0xe20],0x9
   1855dd242:	0f 84 f0 00 00 00    	je     0x1855dd338
   1855dd248:	0f 29 b5 30 0d 00 00 	movaps XMMWORD PTR [rbp+0xd30],xmm6
   1855dd24f:	0f 29 b5 20 0d 00 00 	movaps XMMWORD PTR [rbp+0xd20],xmm6
   1855dd256:	48 8d 15 98 99 93 03 	lea    rdx,[rip+0x3939998]        # 0x188f16bf5
   1855dd25d:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855dd261:	e8 6a b8 aa fa       	call   0x180088ad0
   1855dd266:	90                   	nop
   1855dd267:	4c 8d 05 ea e1 ac 03 	lea    r8,[rip+0x3ace1ea]        # 0x1890ab458
   1855dd26e:	48 8d 8d 20 0d 00 00 	lea    rcx,[rbp+0xd20]
   1855dd275:	48 8d 95 20 0e 00 00 	lea    rdx,[rbp+0xe20]
   1855dd27c:	4c 8d 4d 10          	lea    r9,[rbp+0x10]
   1855dd280:	e8 9b f2 07 fb       	call   0x18065c520
   1855dd285:	90                   	nop
   1855dd286:	48 83 bd 30 0d 00 00 	cmp    QWORD PTR [rbp+0xd30],0x0
   1855dd28d:	00
   1855dd28e:	0f 84 98 00 00 00    	je     0x1855dd32c
   1855dd294:	0f 29 b5 f0 0c 00 00 	movaps XMMWORD PTR [rbp+0xcf0],xmm6
   1855dd29b:	48 8d 8d f0 0c 00 00 	lea    rcx,[rbp+0xcf0]
   1855dd2a2:	48 8d 95 20 0d 00 00 	lea    rdx,[rbp+0xd20]
   1855dd2a9:	e8 e2 ea 07 fb       	call   0x18065bd90
   1855dd2ae:	90                   	nop
   1855dd2af:	80 bd f0 0c 00 00 09 	cmp    BYTE PTR [rbp+0xcf0],0x9
   1855dd2b6:	74 68                	je     0x1855dd320
   1855dd2b8:	0f 29 b5 90 0e 00 00 	movaps XMMWORD PTR [rbp+0xe90],xmm6
   1855dd2bf:	0f 29 b5 80 0e 00 00 	movaps XMMWORD PTR [rbp+0xe80],xmm6
   1855dd2c6:	48 8d 15 28 99 93 03 	lea    rdx,[rip+0x3939928]        # 0x188f16bf5
   1855dd2cd:	48 8d 4d 30          	lea    rcx,[rbp+0x30]
   1855dd2d1:	e8 fa b7 aa fa       	call   0x180088ad0
   1855dd2d6:	90                   	nop
   1855dd2d7:	4c 8d 05 5a 02 30 04 	lea    r8,[rip+0x430025a]        # 0x1898dd538
   1855dd2de:	48 8d 8d 80 0e 00 00 	lea    rcx,[rbp+0xe80]
   1855dd2e5:	48 8d 95 f0 0c 00 00 	lea    rdx,[rbp+0xcf0]
   1855dd2ec:	4c 8d 4d 30          	lea    r9,[rbp+0x30]
   1855dd2f0:	e8 2b f2 07 fb       	call   0x18065c520
   1855dd2f5:	90                   	nop
   1855dd2f6:	48 83 bd 90 0e 00 00 	cmp    QWORD PTR [rbp+0xe90],0x0
   1855dd2fd:	00
   1855dd2fe:	74 14                	je     0x1855dd314
   1855dd300:	48 8b 8d 40 0e 00 00 	mov    rcx,QWORD PTR [rbp+0xe40]
   1855dd307:	48 8d 95 80 0e 00 00 	lea    rdx,[rbp+0xe80]
   1855dd30e:	e8 7d 92 1c fb       	call   0x1807a6590
   1855dd313:	90                   	nop
   1855dd314:	48 8d 8d 80 0e 00 00 	lea    rcx,[rbp+0xe80]
   1855dd31b:	e8 f0 4c a2 fa       	call   0x180002010
   1855dd320:	48 8d 8d f0 0c 00 00 	lea    rcx,[rbp+0xcf0]
   1855dd327:	e8 f4 d9 a2 fa       	call   0x18000ad20
   1855dd32c:	48 8d 8d 20 0d 00 00 	lea    rcx,[rbp+0xd20]
   1855dd333:	e8 d8 4c a2 fa       	call   0x180002010
   1855dd338:	48 8d 8d 20 0e 00 00 	lea    rcx,[rbp+0xe20]
   1855dd33f:	e8 dc d9 a2 fa       	call   0x18000ad20
   1855dd344:	48 8b 85 88 0d 00 00 	mov    rax,QWORD PTR [rbp+0xd88]
   1855dd34b:	48 83 f8 10          	cmp    rax,0x10
   1855dd34f:	72 38                	jb     0x1855dd389
   1855dd351:	48 8b 8d 70 0d 00 00 	mov    rcx,QWORD PTR [rbp+0xd70]
   1855dd358:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855dd35c:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855dd363:	72 1f                	jb     0x1855dd384
   1855dd365:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855dd369:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855dd36d:	4c 29 c1             	sub    rcx,r8
   1855dd370:	48 83 f9 20          	cmp    rcx,0x20
   1855dd374:	0f 83 33 24 00 00    	jae    0x1855df7ad
   1855dd37a:	48 83 c0 28          	add    rax,0x28
   1855dd37e:	48 89 c2             	mov    rdx,rax
   1855dd381:	4c 89 c1             	mov    rcx,r8
   1855dd384:	e8 97 e9 f6 01       	call   0x18754bd20
   1855dd389:	48 8b 85 58 0f 00 00 	mov    rax,QWORD PTR [rbp+0xf58]
   1855dd390:	48 83 f8 10          	cmp    rax,0x10
   1855dd394:	72 38                	jb     0x1855dd3ce
   1855dd396:	48 8b 8d 40 0f 00 00 	mov    rcx,QWORD PTR [rbp+0xf40]
   1855dd39d:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855dd3a1:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855dd3a8:	72 1f                	jb     0x1855dd3c9
   1855dd3aa:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855dd3ae:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855dd3b2:	4c 29 c1             	sub    rcx,r8
   1855dd3b5:	48 83 f9 20          	cmp    rcx,0x20
   1855dd3b9:	0f 83 ee 23 00 00    	jae    0x1855df7ad
   1855dd3bf:	48 83 c0 28          	add    rax,0x28
   1855dd3c3:	48 89 c2             	mov    rdx,rax
   1855dd3c6:	4c 89 c1             	mov    rcx,r8
   1855dd3c9:	e8 52 e9 f6 01       	call   0x18754bd20
   1855dd3ce:	48 8b 85 a8 0f 00 00 	mov    rax,QWORD PTR [rbp+0xfa8]
   1855dd3d5:	48 83 f8 10          	cmp    rax,0x10
   1855dd3d9:	72 38                	jb     0x1855dd413
   1855dd3db:	48 8b 8d 90 0f 00 00 	mov    rcx,QWORD PTR [rbp+0xf90]
   1855dd3e2:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855dd3e6:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855dd3ed:	72 1f                	jb     0x1855dd40e
   1855dd3ef:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855dd3f3:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855dd3f7:	4c 29 c1             	sub    rcx,r8
   1855dd3fa:	48 83 f9 20          	cmp    rcx,0x20
   1855dd3fe:	0f 83 a9 23 00 00    	jae    0x1855df7ad
   1855dd404:	48 83 c0 28          	add    rax,0x28
   1855dd408:	48 89 c2             	mov    rdx,rax
   1855dd40b:	4c 89 c1             	mov    rcx,r8
   1855dd40e:	e8 0d e9 f6 01       	call   0x18754bd20
   1855dd413:	48 8b 85 d8 0e 00 00 	mov    rax,QWORD PTR [rbp+0xed8]
   1855dd41a:	48 83 f8 10          	cmp    rax,0x10
   1855dd41e:	72 38                	jb     0x1855dd458
   1855dd420:	48 8b 8d c0 0e 00 00 	mov    rcx,QWORD PTR [rbp+0xec0]
   1855dd427:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855dd42b:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855dd432:	72 1f                	jb     0x1855dd453
   1855dd434:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855dd438:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855dd43c:	4c 29 c1             	sub    rcx,r8
   1855dd43f:	48 83 f9 20          	cmp    rcx,0x20
   1855dd443:	0f 83 64 23 00 00    	jae    0x1855df7ad
   1855dd449:	48 83 c0 28          	add    rax,0x28
   1855dd44d:	48 89 c2             	mov    rdx,rax
   1855dd450:	4c 89 c1             	mov    rcx,r8
   1855dd453:	e8 c8 e8 f6 01       	call   0x18754bd20
   1855dd458:	48 8b 85 78 09 00 00 	mov    rax,QWORD PTR [rbp+0x978]
   1855dd45f:	48 83 f8 10          	cmp    rax,0x10
   1855dd463:	72 38                	jb     0x1855dd49d
   1855dd465:	48 8b 8d 60 09 00 00 	mov    rcx,QWORD PTR [rbp+0x960]
   1855dd46c:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855dd470:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855dd477:	72 1f                	jb     0x1855dd498
   1855dd479:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855dd47d:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855dd481:	4c 29 c1             	sub    rcx,r8
   1855dd484:	48 83 f9 20          	cmp    rcx,0x20
   1855dd488:	0f 83 1f 23 00 00    	jae    0x1855df7ad
   1855dd48e:	48 83 c0 28          	add    rax,0x28
   1855dd492:	48 89 c2             	mov    rdx,rax
   1855dd495:	4c 89 c1             	mov    rcx,r8
   1855dd498:	e8 83 e8 f6 01       	call   0x18754bd20
   1855dd49d:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855dd4a4:	e8 a7 f3 08 fb       	call   0x18066c850
   1855dd4a9:	48 8b b5 48 0e 00 00 	mov    rsi,QWORD PTR [rbp+0xe48]
   1855dd4b0:	48 85 f6             	test   rsi,rsi
   1855dd4b3:	74 1d                	je     0x1855dd4d2
   1855dd4b5:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855dd4b9:	75 17                	jne    0x1855dd4d2
   1855dd4bb:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dd4be:	48 89 f1             	mov    rcx,rsi
   1855dd4c1:	ff 10                	call   QWORD PTR [rax]
   1855dd4c3:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855dd4c7:	75 09                	jne    0x1855dd4d2
   1855dd4c9:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dd4cc:	48 89 f1             	mov    rcx,rsi
   1855dd4cf:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dd4d2:	48 8b b5 e8 0d 00 00 	mov    rsi,QWORD PTR [rbp+0xde8]
   1855dd4d9:	48 85 f6             	test   rsi,rsi
   1855dd4dc:	74 1d                	je     0x1855dd4fb
   1855dd4de:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855dd4e2:	75 17                	jne    0x1855dd4fb
   1855dd4e4:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dd4e7:	48 89 f1             	mov    rcx,rsi
   1855dd4ea:	ff 10                	call   QWORD PTR [rax]
   1855dd4ec:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855dd4f0:	75 09                	jne    0x1855dd4fb
   1855dd4f2:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dd4f5:	48 89 f1             	mov    rcx,rsi
   1855dd4f8:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dd4fb:	48 8d 15 9e 33 ac 03 	lea    rdx,[rip+0x3ac339e]        # 0x1890a08a0
   1855dd502:	48 8d b5 90 01 00 00 	lea    rsi,[rbp+0x190]
   1855dd509:	41 b8 40 04 00 00    	mov    r8d,0x440
   1855dd50f:	48 89 f1             	mov    rcx,rsi
   1855dd512:	e8 29 79 13 02       	call   0x187714e40
   1855dd517:	90                   	nop
   1855dd518:	48 8d 8d 70 06 00 00 	lea    rcx,[rbp+0x670]
   1855dd51f:	48 89 f2             	mov    rdx,rsi
   1855dd522:	e8 19 87 4a fb       	call   0x180a85c40
   1855dd527:	90                   	nop
   1855dd528:	0f 29 b5 40 0f 00 00 	movaps XMMWORD PTR [rbp+0xf40],xmm6
   1855dd52f:	48 8d 8d 40 0f 00 00 	lea    rcx,[rbp+0xf40]
   1855dd536:	e8 c5 15 c6 fc       	call   0x18223eb00
   1855dd53b:	90                   	nop
   1855dd53c:	b9 18 01 00 00       	mov    ecx,0x118
   1855dd541:	48 03 8d 40 0f 00 00 	add    rcx,QWORD PTR [rbp+0xf40]
   1855dd548:	48 8d 95 90 01 00 00 	lea    rdx,[rbp+0x190]
   1855dd54f:	e8 2c c9 47 fb       	call   0x180a59e80
   1855dd554:	90                   	nop
   1855dd555:	48 8b 85 40 0f 00 00 	mov    rax,QWORD PTR [rbp+0xf40]
   1855dd55c:	48 8d 98 b0 00 00 00 	lea    rbx,[rax+0xb0]
   1855dd563:	48 3b 9d 08 10 00 00 	cmp    rbx,QWORD PTR [rbp+0x1008]
   1855dd56a:	74 58                	je     0x1855dd5c4
   1855dd56c:	4c 8b 8d 08 10 00 00 	mov    r9,QWORD PTR [rbp+0x1008]
   1855dd573:	49 8b 71 10          	mov    rsi,QWORD PTR [r9+0x10]
   1855dd577:	49 83 79 18 10       	cmp    QWORD PTR [r9+0x18],0x10
   1855dd57c:	72 0a                	jb     0x1855dd588
   1855dd57e:	48 8b 8d 08 10 00 00 	mov    rcx,QWORD PTR [rbp+0x1008]
   1855dd585:	4c 8b 09             	mov    r9,QWORD PTR [rcx]
   1855dd588:	48 8b 88 c8 00 00 00 	mov    rcx,QWORD PTR [rax+0xc8]
   1855dd58f:	48 39 ce             	cmp    rsi,rcx
   1855dd592:	76 0e                	jbe    0x1855dd5a2
   1855dd594:	48 89 d9             	mov    rcx,rbx
   1855dd597:	48 89 f2             	mov    rdx,rsi
   1855dd59a:	e8 b1 0b a6 fa       	call   0x18003e150
   1855dd59f:	90                   	nop
   1855dd5a0:	eb 22                	jmp    0x1855dd5c4
   1855dd5a2:	48 83 f9 10          	cmp    rcx,0x10
   1855dd5a6:	72 03                	jb     0x1855dd5ab
   1855dd5a8:	48 8b 1b             	mov    rbx,QWORD PTR [rbx]
   1855dd5ab:	48 89 b0 c0 00 00 00 	mov    QWORD PTR [rax+0xc0],rsi
   1855dd5b2:	48 89 d9             	mov    rcx,rbx
   1855dd5b5:	4c 89 ca             	mov    rdx,r9
   1855dd5b8:	49 89 f0             	mov    r8,rsi
   1855dd5bb:	e8 80 78 13 02       	call   0x187714e40
   1855dd5c0:	c6 04 33 00          	mov    BYTE PTR [rbx+rsi*1],0x0
   1855dd5c4:	b9 20 00 00 00       	mov    ecx,0x20
   1855dd5c9:	e8 0e e7 f6 01       	call   0x18754bcdc
   1855dd5ce:	90                   	nop
   1855dd5cf:	48 b9 01 00 00 00 01 	movabs rcx,0x100000001
   1855dd5d6:	00 00 00
   1855dd5d9:	48 89 48 08          	mov    QWORD PTR [rax+0x8],rcx
   1855dd5dd:	48 8d 0d 34 73 42 04 	lea    rcx,[rip+0x4427334]        # 0x189a04918
   1855dd5e4:	48 89 08             	mov    QWORD PTR [rax],rcx
   1855dd5e7:	66 0f ef c0          	pxor   xmm0,xmm0
   1855dd5eb:	f3 0f 7f 40 10       	movdqu XMMWORD PTR [rax+0x10],xmm0
   1855dd5f0:	48 89 85 00 10 00 00 	mov    QWORD PTR [rbp+0x1000],rax
   1855dd5f7:	48 8d 48 18          	lea    rcx,[rax+0x18]
   1855dd5fb:	48 8b 95 d0 10 00 00 	mov    rdx,QWORD PTR [rbp+0x10d0]
   1855dd602:	e8 69 f3 b2 fa       	call   0x18010c970
   1855dd607:	90                   	nop
   1855dd608:	48 8d 8d 90 0f 00 00 	lea    rcx,[rbp+0xf90]
   1855dd60f:	e8 0c 9c a6 fa       	call   0x180047220
   1855dd614:	90                   	nop
   1855dd615:	48 8b 8d 90 0f 00 00 	mov    rcx,QWORD PTR [rbp+0xf90]
   1855dd61c:	48 8d 9d c0 0e 00 00 	lea    rbx,[rbp+0xec0]
   1855dd623:	48 89 da             	mov    rdx,rbx
   1855dd626:	e8 a5 4d da fa       	call   0x1803823d0
   1855dd62b:	90                   	nop
   1855dd62c:	48 8b 8d c0 0e 00 00 	mov    rcx,QWORD PTR [rbp+0xec0]
   1855dd633:	48 8d 95 60 09 00 00 	lea    rdx,[rbp+0x960]
   1855dd63a:	e8 c1 9d 8d fb       	call   0x180eb7400
   1855dd63f:	90                   	nop
   1855dd640:	48 8b 95 00 10 00 00 	mov    rdx,QWORD PTR [rbp+0x1000]
   1855dd647:	4c 8d 7a 08          	lea    r15,[rdx+0x8]
   1855dd64b:	4c 8d 62 10          	lea    r12,[rdx+0x10]
   1855dd64f:	48 8b 8d 60 09 00 00 	mov    rcx,QWORD PTR [rbp+0x960]
   1855dd656:	48 85 d2             	test   rdx,rdx
   1855dd659:	74 04                	je     0x1855dd65f
   1855dd65b:	f0 41 ff 07          	lock inc DWORD PTR [r15]
   1855dd65f:	48 8d 05 42 73 42 04 	lea    rax,[rip+0x4427342]        # 0x189a049a8
   1855dd666:	48 89 85 b0 00 00 00 	mov    QWORD PTR [rbp+0xb0],rax
   1855dd66d:	4c 89 a5 b8 00 00 00 	mov    QWORD PTR [rbp+0xb8],r12
   1855dd674:	48 89 95 c0 00 00 00 	mov    QWORD PTR [rbp+0xc0],rdx
   1855dd67b:	48 8d 95 b0 00 00 00 	lea    rdx,[rbp+0xb0]
   1855dd682:	48 89 95 e8 00 00 00 	mov    QWORD PTR [rbp+0xe8],rdx
   1855dd689:	e8 52 65 86 fd       	call   0x182e43be0
   1855dd68e:	90                   	nop
   1855dd68f:	48 8b b5 68 09 00 00 	mov    rsi,QWORD PTR [rbp+0x968]
   1855dd696:	48 85 f6             	test   rsi,rsi
   1855dd699:	74 1d                	je     0x1855dd6b8
   1855dd69b:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855dd69f:	75 17                	jne    0x1855dd6b8
   1855dd6a1:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dd6a4:	48 89 f1             	mov    rcx,rsi
   1855dd6a7:	ff 10                	call   QWORD PTR [rax]
   1855dd6a9:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855dd6ad:	75 09                	jne    0x1855dd6b8
   1855dd6af:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dd6b2:	48 89 f1             	mov    rcx,rsi
   1855dd6b5:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dd6b8:	48 8b b5 c8 0e 00 00 	mov    rsi,QWORD PTR [rbp+0xec8]
   1855dd6bf:	48 85 f6             	test   rsi,rsi
   1855dd6c2:	74 1d                	je     0x1855dd6e1
   1855dd6c4:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855dd6c8:	75 17                	jne    0x1855dd6e1
   1855dd6ca:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dd6cd:	48 89 f1             	mov    rcx,rsi
   1855dd6d0:	ff 10                	call   QWORD PTR [rax]
   1855dd6d2:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855dd6d6:	75 09                	jne    0x1855dd6e1
   1855dd6d8:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dd6db:	48 89 f1             	mov    rcx,rsi
   1855dd6de:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dd6e1:	48 8b b5 98 0f 00 00 	mov    rsi,QWORD PTR [rbp+0xf98]
   1855dd6e8:	48 85 f6             	test   rsi,rsi
   1855dd6eb:	74 1d                	je     0x1855dd70a
   1855dd6ed:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855dd6f1:	75 17                	jne    0x1855dd70a
   1855dd6f3:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dd6f6:	48 89 f1             	mov    rcx,rsi
   1855dd6f9:	ff 10                	call   QWORD PTR [rax]
   1855dd6fb:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855dd6ff:	75 09                	jne    0x1855dd70a
   1855dd701:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855dd704:	48 89 f1             	mov    rcx,rsi
   1855dd707:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855dd70a:	66 0f ef c0          	pxor   xmm0,xmm0
   1855dd70e:	66 0f 7f 85 d0 0e 00 	movdqa XMMWORD PTR [rbp+0xed0],xmm0
   1855dd715:	00
   1855dd716:	66 0f 7f 85 c0 0e 00 	movdqa XMMWORD PTR [rbp+0xec0],xmm0
   1855dd71d:	00
   1855dd71e:	48 8b 85 08 10 00 00 	mov    rax,QWORD PTR [rbp+0x1008]
   1855dd725:	4c 8b 70 10          	mov    r14,QWORD PTR [rax+0x10]
   1855dd729:	48 83 78 18 10       	cmp    QWORD PTR [rax+0x18],0x10
   1855dd72e:	72 0a                	jb     0x1855dd73a
   1855dd730:	48 8b 00             	mov    rax,QWORD PTR [rax]
   1855dd733:	48 89 85 08 10 00 00 	mov    QWORD PTR [rbp+0x1008],rax
   1855dd73a:	4d 85 f6             	test   r14,r14
   1855dd73d:	0f 88 70 20 00 00    	js     0x1855df7b3
   1855dd743:	49 83 fe 0f          	cmp    r14,0xf
   1855dd747:	77 27                	ja     0x1855dd770
   1855dd749:	4c 89 b5 d0 0e 00 00 	mov    QWORD PTR [rbp+0xed0],r14
   1855dd750:	48 c7 85 d8 0e 00 00 	mov    QWORD PTR [rbp+0xed8],0xf
   1855dd757:	0f 00 00 00
   1855dd75b:	48 8b 85 08 10 00 00 	mov    rax,QWORD PTR [rbp+0x1008]
   1855dd762:	f3 0f 6f 00          	movdqu xmm0,XMMWORD PTR [rax]
   1855dd766:	66 0f 7f 85 c0 0e 00 	movdqa XMMWORD PTR [rbp+0xec0],xmm0
   1855dd76d:	00
   1855dd76e:	eb 75                	jmp    0x1855dd7e5
   1855dd770:	4c 89 f0             	mov    rax,r14
   1855dd773:	48 83 c8 0f          	or     rax,0xf
   1855dd777:	48 83 f8 17          	cmp    rax,0x17
   1855dd77b:	be 16 00 00 00       	mov    esi,0x16
   1855dd780:	48 0f 43 f0          	cmovae rsi,rax
   1855dd784:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   1855dd78a:	72 24                	jb     0x1855dd7b0
   1855dd78c:	48 8d 4e 28          	lea    rcx,[rsi+0x28]
   1855dd790:	e8 47 e5 f6 01       	call   0x18754bcdc
   1855dd795:	90                   	nop
   1855dd796:	48 85 c0             	test   rax,rax
   1855dd799:	0f 84 0e 20 00 00    	je     0x1855df7ad
   1855dd79f:	48 89 c1             	mov    rcx,rax
   1855dd7a2:	48 83 c0 27          	add    rax,0x27
   1855dd7a6:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
   1855dd7aa:	48 89 48 f8          	mov    QWORD PTR [rax-0x8],rcx
   1855dd7ae:	eb 0a                	jmp    0x1855dd7ba
   1855dd7b0:	48 8d 4e 01          	lea    rcx,[rsi+0x1]
   1855dd7b4:	e8 23 e5 f6 01       	call   0x18754bcdc
   1855dd7b9:	90                   	nop
   1855dd7ba:	48 89 85 c0 0e 00 00 	mov    QWORD PTR [rbp+0xec0],rax
   1855dd7c1:	4c 89 b5 d0 0e 00 00 	mov    QWORD PTR [rbp+0xed0],r14
   1855dd7c8:	48 89 b5 d8 0e 00 00 	mov    QWORD PTR [rbp+0xed8],rsi
   1855dd7cf:	49 ff c6             	inc    r14
   1855dd7d2:	48 89 c1             	mov    rcx,rax
   1855dd7d5:	48 8b 95 08 10 00 00 	mov    rdx,QWORD PTR [rbp+0x1008]
   1855dd7dc:	4d 89 f0             	mov    r8,r14
   1855dd7df:	e8 5c 76 13 02       	call   0x187714e40
   1855dd7e4:	90                   	nop
   1855dd7e5:	e8 26 85 a6 fa       	call   0x180045d10
   1855dd7ea:	90                   	nop
   1855dd7eb:	48 8d 95 70 0d 00 00 	lea    rdx,[rbp+0xd70]
   1855dd7f2:	48 89 c1             	mov    rcx,rax
   1855dd7f5:	e8 16 9b a6 fa       	call   0x180047310
   1855dd7fa:	90                   	nop
   1855dd7fb:	48 8b bd 70 0d 00 00 	mov    rdi,QWORD PTR [rbp+0xd70]
   1855dd802:	66 0f ef c0          	pxor   xmm0,xmm0
   1855dd806:	66 0f 7f 85 60 09 00 	movdqa XMMWORD PTR [rbp+0x960],xmm0
   1855dd80d:	00
   1855dd80e:	48 8b 95 00 10 00 00 	mov    rdx,QWORD PTR [rbp+0x1000]
   1855dd815:	48 85 d2             	test   rdx,rdx
   1855dd818:	74 04                	je     0x1855dd81e
   1855dd81a:	f0 41 ff 07          	lock inc DWORD PTR [r15]
   1855dd81e:	4c 89 a5 60 09 00 00 	mov    QWORD PTR [rbp+0x960],r12
   1855dd825:	48 89 95 68 09 00 00 	mov    QWORD PTR [rbp+0x968],rdx
   1855dd82c:	66 0f 7f 85 70 09 00 	movdqa XMMWORD PTR [rbp+0x970],xmm0
   1855dd833:	00
   1855dd834:	66 0f 7f 85 80 09 00 	movdqa XMMWORD PTR [rbp+0x980],xmm0
   1855dd83b:	00
   1855dd83c:	48 8b 85 d0 0d 00 00 	mov    rax,QWORD PTR [rbp+0xdd0]
   1855dd843:	4c 8b 70 10          	mov    r14,QWORD PTR [rax+0x10]
   1855dd847:	48 83 78 18 10       	cmp    QWORD PTR [rax+0x18],0x10
   1855dd84c:	72 0a                	jb     0x1855dd858
   1855dd84e:	48 8b 00             	mov    rax,QWORD PTR [rax]
   1855dd851:	48 89 85 d0 0d 00 00 	mov    QWORD PTR [rbp+0xdd0],rax
   1855dd858:	4d 85 f6             	test   r14,r14
   1855dd85b:	0f 88 58 1f 00 00    	js     0x1855df7b9
   1855dd861:	4c 8d ad 70 09 00 00 	lea    r13,[rbp+0x970]
   1855dd868:	49 83 fe 0f          	cmp    r14,0xf
   1855dd86c:	77 28                	ja     0x1855dd896
   1855dd86e:	4c 89 b5 80 09 00 00 	mov    QWORD PTR [rbp+0x980],r14
   1855dd875:	48 c7 85 88 09 00 00 	mov    QWORD PTR [rbp+0x988],0xf
   1855dd87c:	0f 00 00 00
   1855dd880:	48 8b 85 d0 0d 00 00 	mov    rax,QWORD PTR [rbp+0xdd0]
   1855dd887:	f3 0f 6f 00          	movdqu xmm0,XMMWORD PTR [rax]
   1855dd88b:	66 41 0f 7f 45 00    	movdqa XMMWORD PTR [r13+0x0],xmm0
   1855dd891:	e9 82 00 00 00       	jmp    0x1855dd918
   1855dd896:	4c 89 f0             	mov    rax,r14
   1855dd899:	48 83 c8 0f          	or     rax,0xf
   1855dd89d:	48 83 f8 17          	cmp    rax,0x17
   1855dd8a1:	be 16 00 00 00       	mov    esi,0x16
   1855dd8a6:	48 0f 43 f0          	cmovae rsi,rax
   1855dd8aa:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   1855dd8b0:	72 2b                	jb     0x1855dd8dd
   1855dd8b2:	48 8d 4e 28          	lea    rcx,[rsi+0x28]
   1855dd8b6:	48 89 95 c8 0d 00 00 	mov    QWORD PTR [rbp+0xdc8],rdx
   1855dd8bd:	e8 1a e4 f6 01       	call   0x18754bcdc
   1855dd8c2:	90                   	nop
   1855dd8c3:	48 85 c0             	test   rax,rax
   1855dd8c6:	0f 84 e1 1e 00 00    	je     0x1855df7ad
   1855dd8cc:	48 89 c1             	mov    rcx,rax
   1855dd8cf:	48 83 c0 27          	add    rax,0x27
   1855dd8d3:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
   1855dd8d7:	48 89 48 f8          	mov    QWORD PTR [rax-0x8],rcx
   1855dd8db:	eb 11                	jmp    0x1855dd8ee
   1855dd8dd:	48 8d 4e 01          	lea    rcx,[rsi+0x1]
   1855dd8e1:	48 89 95 c8 0d 00 00 	mov    QWORD PTR [rbp+0xdc8],rdx
   1855dd8e8:	e8 ef e3 f6 01       	call   0x18754bcdc
   1855dd8ed:	90                   	nop
   1855dd8ee:	48 89 85 70 09 00 00 	mov    QWORD PTR [rbp+0x970],rax
   1855dd8f5:	4c 89 b5 80 09 00 00 	mov    QWORD PTR [rbp+0x980],r14
   1855dd8fc:	48 89 b5 88 09 00 00 	mov    QWORD PTR [rbp+0x988],rsi
   1855dd903:	49 ff c6             	inc    r14
   1855dd906:	48 89 c1             	mov    rcx,rax
   1855dd909:	48 8b 95 d0 0d 00 00 	mov    rdx,QWORD PTR [rbp+0xdd0]
   1855dd910:	4d 89 f0             	mov    r8,r14
   1855dd913:	e8 28 75 13 02       	call   0x187714e40
   1855dd918:	66 0f ef c0          	pxor   xmm0,xmm0
   1855dd91c:	66 0f 7f 85 90 09 00 	movdqa XMMWORD PTR [rbp+0x990],xmm0
   1855dd923:	00
   1855dd924:	48 8b 85 48 0f 00 00 	mov    rax,QWORD PTR [rbp+0xf48]
   1855dd92b:	48 85 c0             	test   rax,rax
   1855dd92e:	74 0d                	je     0x1855dd93d
   1855dd930:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1855dd934:	4c 8b b5 48 0f 00 00 	mov    r14,QWORD PTR [rbp+0xf48]
   1855dd93b:	eb 03                	jmp    0x1855dd940
   1855dd93d:	45 31 f6             	xor    r14d,r14d
   1855dd940:	4c 8b a5 40 0f 00 00 	mov    r12,QWORD PTR [rbp+0xf40]
   1855dd947:	4c 89 a5 90 09 00 00 	mov    QWORD PTR [rbp+0x990],r12
   1855dd94e:	4c 89 b5 98 09 00 00 	mov    QWORD PTR [rbp+0x998],r14
   1855dd955:	66 0f 7f 85 a0 09 00 	movdqa XMMWORD PTR [rbp+0x9a0],xmm0
   1855dd95c:	00
   1855dd95d:	66 0f 7f 85 b0 09 00 	movdqa XMMWORD PTR [rbp+0x9b0],xmm0
   1855dd964:	00
   1855dd965:	48 8b b5 d0 0e 00 00 	mov    rsi,QWORD PTR [rbp+0xed0]
   1855dd96c:	48 83 bd d8 0e 00 00 	cmp    QWORD PTR [rbp+0xed8],0x10
   1855dd973:	10
   1855dd974:	72 07                	jb     0x1855dd97d
   1855dd976:	48 8b 9d c0 0e 00 00 	mov    rbx,QWORD PTR [rbp+0xec0]
   1855dd97d:	48 85 f6             	test   rsi,rsi
   1855dd980:	0f 88 40 1e 00 00    	js     0x1855df7c6
   1855dd986:	48 8d 85 a0 09 00 00 	lea    rax,[rbp+0x9a0]
   1855dd98d:	48 83 fe 0f          	cmp    rsi,0xf
   1855dd991:	77 1f                	ja     0x1855dd9b2
   1855dd993:	48 89 b5 b0 09 00 00 	mov    QWORD PTR [rbp+0x9b0],rsi
   1855dd99a:	48 c7 85 b8 09 00 00 	mov    QWORD PTR [rbp+0x9b8],0xf
   1855dd9a1:	0f 00 00 00
   1855dd9a5:	f3 0f 6f 03          	movdqu xmm0,XMMWORD PTR [rbx]
   1855dd9a9:	66 0f 7f 00          	movdqa XMMWORD PTR [rax],xmm0
   1855dd9ad:	e9 84 00 00 00       	jmp    0x1855dda36
   1855dd9b2:	49 89 fd             	mov    r13,rdi
   1855dd9b5:	4c 89 ff             	mov    rdi,r15
   1855dd9b8:	48 89 f0             	mov    rax,rsi
   1855dd9bb:	48 83 c8 0f          	or     rax,0xf
   1855dd9bf:	48 83 f8 17          	cmp    rax,0x17
   1855dd9c3:	41 bf 16 00 00 00    	mov    r15d,0x16
   1855dd9c9:	4c 0f 43 f8          	cmovae r15,rax
   1855dd9cd:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   1855dd9d3:	72 24                	jb     0x1855dd9f9
   1855dd9d5:	49 8d 4f 28          	lea    rcx,[r15+0x28]
   1855dd9d9:	e8 fe e2 f6 01       	call   0x18754bcdc
   1855dd9de:	90                   	nop
   1855dd9df:	48 85 c0             	test   rax,rax
   1855dd9e2:	0f 84 c5 1d 00 00    	je     0x1855df7ad
   1855dd9e8:	48 89 c1             	mov    rcx,rax
   1855dd9eb:	48 83 c0 27          	add    rax,0x27
   1855dd9ef:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
   1855dd9f3:	48 89 48 f8          	mov    QWORD PTR [rax-0x8],rcx
   1855dd9f7:	eb 0a                	jmp    0x1855dda03
   1855dd9f9:	49 8d 4f 01          	lea    rcx,[r15+0x1]
   1855dd9fd:	e8 da e2 f6 01       	call   0x18754bcdc
   1855dda02:	90                   	nop
   1855dda03:	48 89 85 a0 09 00 00 	mov    QWORD PTR [rbp+0x9a0],rax
   1855dda0a:	48 89 b5 b0 09 00 00 	mov    QWORD PTR [rbp+0x9b0],rsi
   1855dda11:	4c 89 bd b8 09 00 00 	mov    QWORD PTR [rbp+0x9b8],r15
   1855dda18:	48 ff c6             	inc    rsi
   1855dda1b:	48 89 c1             	mov    rcx,rax
   1855dda1e:	48 89 da             	mov    rdx,rbx
   1855dda21:	49 89 f0             	mov    r8,rsi
   1855dda24:	e8 17 74 13 02       	call   0x187714e40
   1855dda29:	49 89 ff             	mov    r15,rdi
   1855dda2c:	4c 89 ef             	mov    rdi,r13
   1855dda2f:	4c 8d ad 70 09 00 00 	lea    r13,[rbp+0x970]
   1855dda36:	48 c7 85 78 01 00 00 	mov    QWORD PTR [rbp+0x178],0x0
   1855dda3d:	00 00 00 00
   1855dda41:	b9 68 00 00 00       	mov    ecx,0x68
   1855dda46:	e8 91 e2 f6 01       	call   0x18754bcdc
   1855dda4b:	90                   	nop
   1855dda4c:	48 89 c3             	mov    rbx,rax
   1855dda4f:	48 8d 05 f2 6f 42 04 	lea    rax,[rip+0x4426ff2]        # 0x189a04a48
   1855dda56:	48 89 03             	mov    QWORD PTR [rbx],rax
   1855dda59:	66 0f 6f 8d 60 09 00 	movdqa xmm1,XMMWORD PTR [rbp+0x960]
   1855dda60:	00
   1855dda61:	f3 0f 7f 4b 08       	movdqu XMMWORD PTR [rbx+0x8],xmm1
   1855dda66:	66 0f ef c0          	pxor   xmm0,xmm0
   1855dda6a:	66 0f 7f 85 60 09 00 	movdqa XMMWORD PTR [rbp+0x960],xmm0
   1855dda71:	00
   1855dda72:	f3 0f 7f 43 28       	movdqu XMMWORD PTR [rbx+0x28],xmm0
   1855dda77:	f3 0f 7f 43 18       	movdqu XMMWORD PTR [rbx+0x18],xmm0
   1855dda7c:	48 8b b5 80 09 00 00 	mov    rsi,QWORD PTR [rbp+0x980]
   1855dda83:	48 83 bd 88 09 00 00 	cmp    QWORD PTR [rbp+0x988],0x10
   1855dda8a:	10
   1855dda8b:	72 07                	jb     0x1855dda94
   1855dda8d:	4c 8b ad 70 09 00 00 	mov    r13,QWORD PTR [rbp+0x970]
   1855dda94:	48 85 f6             	test   rsi,rsi
   1855dda97:	0f 88 2f 1d 00 00    	js     0x1855df7cc
   1855dda9d:	48 83 fe 0f          	cmp    rsi,0xf
   1855ddaa1:	77 22                	ja     0x1855ddac5
   1855ddaa3:	48 89 d8             	mov    rax,rbx
   1855ddaa6:	48 83 c0 18          	add    rax,0x18
   1855ddaaa:	48 89 73 28          	mov    QWORD PTR [rbx+0x28],rsi
   1855ddaae:	48 c7 43 30 0f 00 00 	mov    QWORD PTR [rbx+0x30],0xf
   1855ddab5:	00
   1855ddab6:	f3 41 0f 6f 45 00    	movdqu xmm0,XMMWORD PTR [r13+0x0]
   1855ddabc:	f3 0f 7f 00          	movdqu XMMWORD PTR [rax],xmm0
   1855ddac0:	e9 80 00 00 00       	jmp    0x1855ddb45
   1855ddac5:	66 0f 7f 8d d0 0d 00 	movdqa XMMWORD PTR [rbp+0xdd0],xmm1
   1855ddacc:	00
   1855ddacd:	48 89 9d 08 10 00 00 	mov    QWORD PTR [rbp+0x1008],rbx
   1855ddad4:	48 89 f0             	mov    rax,rsi
   1855ddad7:	48 83 c8 0f          	or     rax,0xf
   1855ddadb:	48 83 f8 17          	cmp    rax,0x17
   1855ddadf:	bb 16 00 00 00       	mov    ebx,0x16
   1855ddae4:	48 0f 43 d8          	cmovae rbx,rax
   1855ddae8:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   1855ddaee:	72 24                	jb     0x1855ddb14
   1855ddaf0:	48 8d 4b 28          	lea    rcx,[rbx+0x28]
   1855ddaf4:	e8 e3 e1 f6 01       	call   0x18754bcdc
   1855ddaf9:	90                   	nop
   1855ddafa:	48 85 c0             	test   rax,rax
   1855ddafd:	0f 84 aa 1c 00 00    	je     0x1855df7ad
   1855ddb03:	48 89 c1             	mov    rcx,rax
   1855ddb06:	48 83 c0 27          	add    rax,0x27
   1855ddb0a:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
   1855ddb0e:	48 89 48 f8          	mov    QWORD PTR [rax-0x8],rcx
   1855ddb12:	eb 0a                	jmp    0x1855ddb1e
   1855ddb14:	48 8d 4b 01          	lea    rcx,[rbx+0x1]
   1855ddb18:	e8 bf e1 f6 01       	call   0x18754bcdc
   1855ddb1d:	90                   	nop
   1855ddb1e:	48 8b 8d 08 10 00 00 	mov    rcx,QWORD PTR [rbp+0x1008]
   1855ddb25:	48 89 41 18          	mov    QWORD PTR [rcx+0x18],rax
   1855ddb29:	48 89 71 28          	mov    QWORD PTR [rcx+0x28],rsi
   1855ddb2d:	48 89 59 30          	mov    QWORD PTR [rcx+0x30],rbx
   1855ddb31:	48 89 cb             	mov    rbx,rcx
   1855ddb34:	48 ff c6             	inc    rsi
   1855ddb37:	48 89 c1             	mov    rcx,rax
   1855ddb3a:	4c 89 ea             	mov    rdx,r13
   1855ddb3d:	49 89 f0             	mov    r8,rsi
   1855ddb40:	e8 fb 72 13 02       	call   0x187714e40
   1855ddb45:	4c 89 63 38          	mov    QWORD PTR [rbx+0x38],r12
   1855ddb49:	4c 89 73 40          	mov    QWORD PTR [rbx+0x40],r14
   1855ddb4d:	66 0f ef c0          	pxor   xmm0,xmm0
   1855ddb51:	48 8d 85 90 09 00 00 	lea    rax,[rbp+0x990]
   1855ddb58:	66 0f 7f 00          	movdqa XMMWORD PTR [rax],xmm0
   1855ddb5c:	48 8d 85 a0 09 00 00 	lea    rax,[rbp+0x9a0]
   1855ddb63:	66 0f 6f 00          	movdqa xmm0,XMMWORD PTR [rax]
   1855ddb67:	66 0f 6f 48 10       	movdqa xmm1,XMMWORD PTR [rax+0x10]
   1855ddb6c:	f3 0f 7f 4b 58       	movdqu XMMWORD PTR [rbx+0x58],xmm1
   1855ddb71:	f3 0f 7f 43 48       	movdqu XMMWORD PTR [rbx+0x48],xmm0
   1855ddb76:	48 c7 85 b0 09 00 00 	mov    QWORD PTR [rbp+0x9b0],0x0
   1855ddb7d:	00 00 00 00
   1855ddb81:	48 c7 85 b8 09 00 00 	mov    QWORD PTR [rbp+0x9b8],0xf
   1855ddb88:	0f 00 00 00
   1855ddb8c:	c6 85 a0 09 00 00 00 	mov    BYTE PTR [rbp+0x9a0],0x0
   1855ddb93:	48 89 9d 78 01 00 00 	mov    QWORD PTR [rbp+0x178],rbx
   1855ddb9a:	c6 85 17 10 00 00 01 	mov    BYTE PTR [rbp+0x1017],0x1
   1855ddba1:	48 8d 15 d8 87 42 04 	lea    rdx,[rip+0x44287d8]        # 0x189a06380
   1855ddba8:	4c 8d 05 11 77 42 04 	lea    r8,[rip+0x4427711]        # 0x189a052c0
   1855ddbaf:	48 8d 8d 90 0f 00 00 	lea    rcx,[rbp+0xf90]
   1855ddbb6:	41 b9 47 03 00 00    	mov    r9d,0x347
   1855ddbbc:	e8 2f 40 bc fa       	call   0x1801a1bf0
   1855ddbc1:	90                   	nop
   1855ddbc2:	c6 85 17 10 00 00 00 	mov    BYTE PTR [rbp+0x1017],0x0
   1855ddbc9:	c7 44 24 20 01 00 00 	mov    DWORD PTR [rsp+0x20],0x1
   1855ddbd0:	00
   1855ddbd1:	48 8d 95 80 01 00 00 	lea    rdx,[rbp+0x180]
   1855ddbd8:	4c 8d 85 90 0f 00 00 	lea    r8,[rbp+0xf90]
   1855ddbdf:	4c 8d 8d 40 01 00 00 	lea    r9,[rbp+0x140]
   1855ddbe6:	48 89 f9             	mov    rcx,rdi
   1855ddbe9:	e8 62 18 d3 fa       	call   0x18030f450
   1855ddbee:	90                   	nop
   1855ddbef:	48 8b b5 88 01 00 00 	mov    rsi,QWORD PTR [rbp+0x188]
   1855ddbf6:	48 85 f6             	test   rsi,rsi
   1855ddbf9:	74 1d                	je     0x1855ddc18
   1855ddbfb:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855ddbff:	75 17                	jne    0x1855ddc18
   1855ddc01:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ddc04:	48 89 f1             	mov    rcx,rsi
   1855ddc07:	ff 10                	call   QWORD PTR [rax]
   1855ddc09:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855ddc0d:	75 09                	jne    0x1855ddc18
   1855ddc0f:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ddc12:	48 89 f1             	mov    rcx,rsi
   1855ddc15:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ddc18:	48 8d 8d 60 09 00 00 	lea    rcx,[rbp+0x960]
   1855ddc1f:	e8 bc 02 3d fe       	call   0x1839adee0
   1855ddc24:	48 8b b5 78 0d 00 00 	mov    rsi,QWORD PTR [rbp+0xd78]
   1855ddc2b:	48 85 f6             	test   rsi,rsi
   1855ddc2e:	48 8b bd 00 10 00 00 	mov    rdi,QWORD PTR [rbp+0x1000]
   1855ddc35:	74 1d                	je     0x1855ddc54
   1855ddc37:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855ddc3b:	75 17                	jne    0x1855ddc54
   1855ddc3d:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ddc40:	48 89 f1             	mov    rcx,rsi
   1855ddc43:	ff 10                	call   QWORD PTR [rax]
   1855ddc45:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855ddc49:	75 09                	jne    0x1855ddc54
   1855ddc4b:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ddc4e:	48 89 f1             	mov    rcx,rsi
   1855ddc51:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ddc54:	48 8b 85 d8 0e 00 00 	mov    rax,QWORD PTR [rbp+0xed8]
   1855ddc5b:	48 83 f8 10          	cmp    rax,0x10
   1855ddc5f:	72 38                	jb     0x1855ddc99
   1855ddc61:	48 8b 8d c0 0e 00 00 	mov    rcx,QWORD PTR [rbp+0xec0]
   1855ddc68:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ddc6c:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ddc73:	72 1f                	jb     0x1855ddc94
   1855ddc75:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ddc79:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ddc7d:	4c 29 c1             	sub    rcx,r8
   1855ddc80:	48 83 f9 20          	cmp    rcx,0x20
   1855ddc84:	0f 83 23 1b 00 00    	jae    0x1855df7ad
   1855ddc8a:	48 83 c0 28          	add    rax,0x28
   1855ddc8e:	48 89 c2             	mov    rdx,rax
   1855ddc91:	4c 89 c1             	mov    rcx,r8
   1855ddc94:	e8 87 e0 f6 01       	call   0x18754bd20
   1855ddc99:	48 85 ff             	test   rdi,rdi
   1855ddc9c:	74 23                	je     0x1855ddcc1
   1855ddc9e:	f0 41 ff 0f          	lock dec DWORD PTR [r15]
   1855ddca2:	75 1d                	jne    0x1855ddcc1
   1855ddca4:	48 89 fe             	mov    rsi,rdi
   1855ddca7:	48 83 c6 0c          	add    rsi,0xc
   1855ddcab:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855ddcae:	48 89 f9             	mov    rcx,rdi
   1855ddcb1:	ff 10                	call   QWORD PTR [rax]
   1855ddcb3:	f0 ff 0e             	lock dec DWORD PTR [rsi]
   1855ddcb6:	75 09                	jne    0x1855ddcc1
   1855ddcb8:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855ddcbb:	48 89 f9             	mov    rcx,rdi
   1855ddcbe:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ddcc1:	48 8b b5 48 0f 00 00 	mov    rsi,QWORD PTR [rbp+0xf48]
   1855ddcc8:	48 85 f6             	test   rsi,rsi
   1855ddccb:	74 1d                	je     0x1855ddcea
   1855ddccd:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855ddcd1:	75 17                	jne    0x1855ddcea
   1855ddcd3:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ddcd6:	48 89 f1             	mov    rcx,rsi
   1855ddcd9:	ff 10                	call   QWORD PTR [rax]
   1855ddcdb:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855ddcdf:	75 09                	jne    0x1855ddcea
   1855ddce1:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ddce4:	48 89 f1             	mov    rcx,rsi
   1855ddce7:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ddcea:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855ddcf1:	e8 fa 87 bd fa       	call   0x1801b64f0
   1855ddcf6:	48 8d 8d 70 06 00 00 	lea    rcx,[rbp+0x670]
   1855ddcfd:	e8 de c9 d9 ff       	call   0x18537a6e0
   1855ddd02:	48 8b 85 c8 0c 00 00 	mov    rax,QWORD PTR [rbp+0xcc8]
   1855ddd09:	48 83 f8 10          	cmp    rax,0x10
   1855ddd0d:	72 38                	jb     0x1855ddd47
   1855ddd0f:	48 8b 8d b0 0c 00 00 	mov    rcx,QWORD PTR [rbp+0xcb0]
   1855ddd16:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ddd1a:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ddd21:	72 1f                	jb     0x1855ddd42
   1855ddd23:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ddd27:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ddd2b:	4c 29 c1             	sub    rcx,r8
   1855ddd2e:	48 83 f9 20          	cmp    rcx,0x20
   1855ddd32:	0f 83 75 1a 00 00    	jae    0x1855df7ad
   1855ddd38:	48 83 c0 28          	add    rax,0x28
   1855ddd3c:	48 89 c2             	mov    rdx,rax
   1855ddd3f:	4c 89 c1             	mov    rcx,r8
   1855ddd42:	e8 d9 df f6 01       	call   0x18754bd20
   1855ddd47:	48 8b 8d d0 10 00 00 	mov    rcx,QWORD PTR [rbp+0x10d0]
   1855ddd4e:	e8 1d ed b2 fa       	call   0x18010ca70
   1855ddd53:	0f 28 b5 20 10 00 00 	movaps xmm6,XMMWORD PTR [rbp+0x1020]
   1855ddd5a:	0f 28 bd 30 10 00 00 	movaps xmm7,XMMWORD PTR [rbp+0x1030]
   1855ddd61:	44 0f 28 85 40 10 00 	movaps xmm8,XMMWORD PTR [rbp+0x1040]
   1855ddd68:	00
   1855ddd69:	44 0f 28 8d 50 10 00 	movaps xmm9,XMMWORD PTR [rbp+0x1050]
   1855ddd70:	00
   1855ddd71:	48 81 c4 e8 10 00 00 	add    rsp,0x10e8
   1855ddd78:	5b                   	pop    rbx
   1855ddd79:	5f                   	pop    rdi
   1855ddd7a:	5e                   	pop    rsi
   1855ddd7b:	41 5c                	pop    r12
   1855ddd7d:	41 5d                	pop    r13
   1855ddd7f:	41 5e                	pop    r14
   1855ddd81:	41 5f                	pop    r15
   1855ddd83:	5d                   	pop    rbp
   1855ddd84:	c3                   	ret
   1855ddd85:	4c 89 e7             	mov    rdi,r12
   1855ddd88:	ff c2                	inc    edx
   1855ddd8a:	89 95 a4 0e 00 00    	mov    DWORD PTR [rbp+0xea4],edx
   1855ddd90:	e8 4b 77 7f fb       	call   0x180dd54e0
   1855ddd95:	90                   	nop
   1855ddd96:	48 8b 8d 98 0e 00 00 	mov    rcx,QWORD PTR [rbp+0xe98]
   1855ddd9d:	48 63 95 a0 0e 00 00 	movsxd rdx,DWORD PTR [rbp+0xea0]
   1855ddda4:	44 8d 42 01          	lea    r8d,[rdx+0x1]
   1855ddda8:	44 89 85 a0 0e 00 00 	mov    DWORD PTR [rbp+0xea0],r8d
   1855dddaf:	48 89 04 d1          	mov    QWORD PTR [rcx+rdx*8],rax
   1855dddb3:	48 39 d8             	cmp    rax,rbx
   1855dddb6:	74 60                	je     0x1855dde18
   1855dddb8:	48 8b 73 10          	mov    rsi,QWORD PTR [rbx+0x10]
   1855dddbc:	48 83 7b 18 10       	cmp    QWORD PTR [rbx+0x18],0x10
   1855dddc1:	49 89 d9             	mov    r9,rbx
   1855dddc4:	72 03                	jb     0x1855dddc9
   1855dddc6:	4c 8b 0b             	mov    r9,QWORD PTR [rbx]
   1855dddc9:	48 8b 48 18          	mov    rcx,QWORD PTR [rax+0x18]
   1855dddcd:	48 39 ce             	cmp    rsi,rcx
   1855dddd0:	76 0e                	jbe    0x1855ddde0
   1855dddd2:	48 89 c1             	mov    rcx,rax
   1855dddd5:	48 89 f2             	mov    rdx,rsi
   1855dddd8:	e8 73 03 a6 fa       	call   0x18003e150
   1855ddddd:	90                   	nop
   1855dddde:	eb 38                	jmp    0x1855dde18
   1855ddde0:	4c 89 ef             	mov    rdi,r13
   1855ddde3:	4d 89 fd             	mov    r13,r15
   1855ddde6:	4d 89 f7             	mov    r15,r14
   1855ddde9:	49 89 c6             	mov    r14,rax
   1855dddec:	48 83 f9 10          	cmp    rcx,0x10
   1855dddf0:	72 03                	jb     0x1855dddf5
   1855dddf2:	4c 8b 30             	mov    r14,QWORD PTR [rax]
   1855dddf5:	48 89 70 10          	mov    QWORD PTR [rax+0x10],rsi
   1855dddf9:	4c 89 f1             	mov    rcx,r14
   1855dddfc:	4c 89 ca             	mov    rdx,r9
   1855dddff:	49 89 f0             	mov    r8,rsi
   1855dde02:	e8 39 70 13 02       	call   0x187714e40
   1855dde07:	41 c6 04 36 00       	mov    BYTE PTR [r14+rsi*1],0x0
   1855dde0c:	4d 89 fe             	mov    r14,r15
   1855dde0f:	4d 89 ef             	mov    r15,r13
   1855dde12:	49 89 fd             	mov    r13,rdi
   1855dde15:	4c 89 e7             	mov    rdi,r12
   1855dde18:	b9 02 00 00 00       	mov    ecx,0x2
   1855dde1d:	e8 be ef a8 fa       	call   0x18006cde0
   1855dde22:	85 c0                	test   eax,eax
   1855dde24:	0f 84 e0 01 00 00    	je     0x1855de00a
   1855dde2a:	48 8d b5 90 0f 00 00 	lea    rsi,[rbp+0xf90]
   1855dde31:	48 89 f1             	mov    rcx,rsi
   1855dde34:	e8 d7 f0 a8 fa       	call   0x18006cf10
   1855dde39:	90                   	nop
   1855dde3a:	48 83 bd a8 0f 00 00 	cmp    QWORD PTR [rbp+0xfa8],0x10
   1855dde41:	10
   1855dde42:	72 07                	jb     0x1855dde4b
   1855dde44:	48 8b b5 90 0f 00 00 	mov    rsi,QWORD PTR [rbp+0xf90]
   1855dde4b:	48 8d 05 6e 7d 42 04 	lea    rax,[rip+0x4427d6e]        # 0x189a05bc0
   1855dde52:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855dde57:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855dde5e:	00 00
   1855dde60:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855dde65:	c7 44 24 28 49 02 00 	mov    DWORD PTR [rsp+0x28],0x249
   1855dde6c:	00
   1855dde6d:	4c 8d 0d 4c 74 42 04 	lea    r9,[rip+0x442744c]        # 0x189a052c0
   1855dde74:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855dde7b:	ba 02 00 00 00       	mov    edx,0x2
   1855dde80:	49 89 f0             	mov    r8,rsi
   1855dde83:	e8 e8 f3 a8 fa       	call   0x18006d270
   1855dde88:	90                   	nop
   1855dde89:	48 8b 4b 10          	mov    rcx,QWORD PTR [rbx+0x10]
   1855dde8d:	48 c7 85 60 09 00 00 	mov    QWORD PTR [rbp+0x960],0x0
   1855dde94:	00 00 00 00
   1855dde98:	41 b9 07 00 00 00    	mov    r9d,0x7
   1855dde9e:	4c 8d 85 67 09 00 00 	lea    r8,[rbp+0x967]
   1855ddea5:	49 ba cd cc cc cc cc 	movabs r10,0xcccccccccccccccd
   1855ddeac:	cc cc cc
   1855ddeaf:	4c 8d 1d ba 93 93 03 	lea    r11,[rip+0x39393ba]        # 0x188f17270
   1855ddeb6:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
   1855ddebd:	00 00 00
   1855ddec0:	48 89 c8             	mov    rax,rcx
   1855ddec3:	49 f7 e2             	mul    r10
   1855ddec6:	48 c1 ea 03          	shr    rdx,0x3
   1855ddeca:	48 8d 04 12          	lea    rax,[rdx+rdx*1]
   1855ddece:	48 8d 04 80          	lea    rax,[rax+rax*4]
   1855dded2:	4c 89 de             	mov    rsi,r11
   1855dded5:	48 29 c6             	sub    rsi,rax
   1855dded8:	0f b6 44 0e 23       	movzx  eax,BYTE PTR [rsi+rcx*1+0x23]
   1855ddedd:	41 88 40 01          	mov    BYTE PTR [r8+0x1],al
   1855ddee1:	49 ff c0             	inc    r8
   1855ddee4:	49 ff c1             	inc    r9
   1855ddee7:	48 83 f9 09          	cmp    rcx,0x9
   1855ddeeb:	48 89 d1             	mov    rcx,rdx
   1855ddeee:	77 d0                	ja     0x1855ddec0
   1855ddef0:	48 8d 85 68 09 00 00 	lea    rax,[rbp+0x968]
   1855ddef7:	41 c6 40 01 00       	mov    BYTE PTR [r8+0x1],0x0
   1855ddefc:	49 83 f9 09          	cmp    r9,0x9
   1855ddf00:	72 29                	jb     0x1855ddf2b
   1855ddf02:	48 8d 8d 69 09 00 00 	lea    rcx,[rbp+0x969]
   1855ddf09:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
   1855ddf10:	41 0f b6 10          	movzx  edx,BYTE PTR [r8]
   1855ddf14:	44 0f b6 49 ff       	movzx  r9d,BYTE PTR [rcx-0x1]
   1855ddf19:	45 88 08             	mov    BYTE PTR [r8],r9b
   1855ddf1c:	49 ff c8             	dec    r8
   1855ddf1f:	88 51 ff             	mov    BYTE PTR [rcx-0x1],dl
   1855ddf22:	4c 39 c1             	cmp    rcx,r8
   1855ddf25:	48 8d 49 01          	lea    rcx,[rcx+0x1]
   1855ddf29:	72 e5                	jb     0x1855ddf10
   1855ddf2b:	48 89 85 60 09 00 00 	mov    QWORD PTR [rbp+0x960],rax
   1855ddf32:	48 83 7f 18 10       	cmp    QWORD PTR [rdi+0x18],0x10
   1855ddf37:	48 89 f8             	mov    rax,rdi
   1855ddf3a:	72 03                	jb     0x1855ddf3f
   1855ddf3c:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855ddf3f:	48 89 85 c0 0e 00 00 	mov    QWORD PTR [rbp+0xec0],rax
   1855ddf46:	c6 85 c8 0e 00 00 00 	mov    BYTE PTR [rbp+0xec8],0x0
   1855ddf4d:	66 0f ef c0          	pxor   xmm0,xmm0
   1855ddf51:	f3 0f 7f 85 e0 06 00 	movdqu XMMWORD PTR [rbp+0x6e0],xmm0
   1855ddf58:	00
   1855ddf59:	f3 0f 7f 85 d0 06 00 	movdqu XMMWORD PTR [rbp+0x6d0],xmm0
   1855ddf60:	00
   1855ddf61:	f3 0f 7f 85 c0 06 00 	movdqu XMMWORD PTR [rbp+0x6c0],xmm0
   1855ddf68:	00
   1855ddf69:	f3 0f 7f 85 b0 06 00 	movdqu XMMWORD PTR [rbp+0x6b0],xmm0
   1855ddf70:	00
   1855ddf71:	f3 0f 7f 85 a0 06 00 	movdqu XMMWORD PTR [rbp+0x6a0],xmm0
   1855ddf78:	00
   1855ddf79:	f3 0f 7f 85 90 06 00 	movdqu XMMWORD PTR [rbp+0x690],xmm0
   1855ddf80:	00
   1855ddf81:	f3 0f 7f 85 80 06 00 	movdqu XMMWORD PTR [rbp+0x680],xmm0
   1855ddf88:	00
   1855ddf89:	4c 89 ad 70 06 00 00 	mov    QWORD PTR [rbp+0x670],r13
   1855ddf90:	48 8d 85 60 09 00 00 	lea    rax,[rbp+0x960]
   1855ddf97:	48 89 85 78 06 00 00 	mov    QWORD PTR [rbp+0x678],rax
   1855ddf9e:	48 8d 15 3b 80 42 04 	lea    rdx,[rip+0x442803b]        # 0x189a05fe0
   1855ddfa5:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855ddfac:	4c 8d 85 70 06 00 00 	lea    r8,[rbp+0x670]
   1855ddfb3:	e8 58 f8 a8 fa       	call   0x18006d810
   1855ddfb8:	90                   	nop
   1855ddfb9:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855ddfc0:	e8 ab f3 a8 fa       	call   0x18006d370
   1855ddfc5:	48 8b 85 a8 0f 00 00 	mov    rax,QWORD PTR [rbp+0xfa8]
   1855ddfcc:	48 83 f8 10          	cmp    rax,0x10
   1855ddfd0:	72 38                	jb     0x1855de00a
   1855ddfd2:	48 8b 8d 90 0f 00 00 	mov    rcx,QWORD PTR [rbp+0xf90]
   1855ddfd9:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ddfdd:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ddfe4:	72 1f                	jb     0x1855de005
   1855ddfe6:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ddfea:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ddfee:	4c 29 c1             	sub    rcx,r8
   1855ddff1:	48 83 f9 20          	cmp    rcx,0x20
   1855ddff5:	0f 83 b2 17 00 00    	jae    0x1855df7ad
   1855ddffb:	48 83 c0 28          	add    rax,0x28
   1855ddfff:	48 89 c2             	mov    rdx,rax
   1855de002:	4c 89 c1             	mov    rcx,r8
   1855de005:	e8 16 dd f6 01       	call   0x18754bd20
   1855de00a:	4c 89 bd 10 0e 00 00 	mov    QWORD PTR [rbp+0xe10],r15
   1855de011:	0f 29 b5 00 0e 00 00 	movaps XMMWORD PTR [rbp+0xe00],xmm6
   1855de018:	0f 29 b5 f0 0d 00 00 	movaps XMMWORD PTR [rbp+0xdf0],xmm6
   1855de01f:	0f 29 b5 e0 0d 00 00 	movaps XMMWORD PTR [rbp+0xde0],xmm6
   1855de026:	48 b8 00 00 00 00 c0 	movabs rax,0x1d4c000000000
   1855de02d:	d4 01 00
   1855de030:	48 89 85 90 01 00 00 	mov    QWORD PTR [rbp+0x190],rax
   1855de037:	66 0f ef c0          	pxor   xmm0,xmm0
   1855de03b:	f3 0f 7f 85 98 01 00 	movdqu XMMWORD PTR [rbp+0x198],xmm0
   1855de042:	00
   1855de043:	48 c7 85 a8 01 00 00 	mov    QWORD PTR [rbp+0x1a8],0x0
   1855de04a:	00 00 00 00
   1855de04e:	48 c7 85 b0 01 00 00 	mov    QWORD PTR [rbp+0x1b0],0xf
   1855de055:	0f 00 00 00
   1855de059:	c6 85 b8 01 00 00 00 	mov    BYTE PTR [rbp+0x1b8],0x0
   1855de060:	c7 85 bc 01 00 00 00 	mov    DWORD PTR [rbp+0x1bc],0x0
   1855de067:	00 00 00
   1855de06a:	66 0f 7f 85 70 06 00 	movdqa XMMWORD PTR [rbp+0x670],xmm0
   1855de071:	00
   1855de072:	48 c7 85 80 06 00 00 	mov    QWORD PTR [rbp+0x680],0x0
   1855de079:	00 00 00 00
   1855de07d:	48 c7 85 88 06 00 00 	mov    QWORD PTR [rbp+0x688],0xf
   1855de084:	0f 00 00 00
   1855de088:	e8 83 7c a6 fa       	call   0x180045d10
   1855de08d:	90                   	nop
   1855de08e:	48 8b 10             	mov    rdx,QWORD PTR [rax]
   1855de091:	48 89 c1             	mov    rcx,rax
   1855de094:	ff 52 10             	call   QWORD PTR [rdx+0x10]
   1855de097:	90                   	nop
   1855de098:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855de09f:	48 89 4c 24 20       	mov    QWORD PTR [rsp+0x20],rcx
   1855de0a4:	48 8d 8d e0 0d 00 00 	lea    rcx,[rbp+0xde0]
   1855de0ab:	4c 8d 85 80 0e 00 00 	lea    r8,[rbp+0xe80]
   1855de0b2:	4c 8d 8d 70 06 00 00 	lea    r9,[rbp+0x670]
   1855de0b9:	48 89 c2             	mov    rdx,rax
   1855de0bc:	e8 af 49 00 00       	call   0x1855e2a70
   1855de0c1:	90                   	nop
   1855de0c2:	48 8b 85 88 06 00 00 	mov    rax,QWORD PTR [rbp+0x688]
   1855de0c9:	48 83 f8 10          	cmp    rax,0x10
   1855de0cd:	72 38                	jb     0x1855de107
   1855de0cf:	48 8b 8d 70 06 00 00 	mov    rcx,QWORD PTR [rbp+0x670]
   1855de0d6:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855de0da:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855de0e1:	72 1f                	jb     0x1855de102
   1855de0e3:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855de0e7:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855de0eb:	4c 29 c1             	sub    rcx,r8
   1855de0ee:	48 83 f9 20          	cmp    rcx,0x20
   1855de0f2:	0f 83 b5 16 00 00    	jae    0x1855df7ad
   1855de0f8:	48 83 c0 28          	add    rax,0x28
   1855de0fc:	48 89 c2             	mov    rdx,rax
   1855de0ff:	4c 89 c1             	mov    rcx,r8
   1855de102:	e8 19 dc f6 01       	call   0x18754bd20
   1855de107:	48 8b 85 b0 01 00 00 	mov    rax,QWORD PTR [rbp+0x1b0]
   1855de10e:	48 83 f8 10          	cmp    rax,0x10
   1855de112:	72 38                	jb     0x1855de14c
   1855de114:	48 8b 8d 98 01 00 00 	mov    rcx,QWORD PTR [rbp+0x198]
   1855de11b:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855de11f:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855de126:	72 1f                	jb     0x1855de147
   1855de128:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855de12c:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855de130:	4c 29 c1             	sub    rcx,r8
   1855de133:	48 83 f9 20          	cmp    rcx,0x20
   1855de137:	0f 83 70 16 00 00    	jae    0x1855df7ad
   1855de13d:	48 83 c0 28          	add    rax,0x28
   1855de141:	48 89 c2             	mov    rdx,rax
   1855de144:	4c 89 c1             	mov    rcx,r8
   1855de147:	e8 d4 db f6 01       	call   0x18754bd20
   1855de14c:	4d 89 f4             	mov    r12,r14
   1855de14f:	8b 85 e4 0d 00 00    	mov    eax,DWORD PTR [rbp+0xde4]
   1855de155:	0b 85 e0 0d 00 00    	or     eax,DWORD PTR [rbp+0xde0]
   1855de15b:	75 6f                	jne    0x1855de1cc
   1855de15d:	48 8b 85 08 0e 00 00 	mov    rax,QWORD PTR [rbp+0xe08]
   1855de164:	83 78 18 00          	cmp    DWORD PTR [rax+0x18],0x0
   1855de168:	74 62                	je     0x1855de1cc
   1855de16a:	4d 89 ee             	mov    r14,r13
   1855de16d:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
   1855de171:	48 8b 18             	mov    rbx,QWORD PTR [rax]
   1855de174:	66 0f ef c0          	pxor   xmm0,xmm0
   1855de178:	66 0f 7f 85 30 0e 00 	movdqa XMMWORD PTR [rbp+0xe30],xmm0
   1855de17f:	00
   1855de180:	66 0f 7f 85 20 0e 00 	movdqa XMMWORD PTR [rbp+0xe20],xmm0
   1855de187:	00
   1855de188:	4c 8b 6b 10          	mov    r13,QWORD PTR [rbx+0x10]
   1855de18c:	48 83 7b 18 10       	cmp    QWORD PTR [rbx+0x18],0x10
   1855de191:	72 03                	jb     0x1855de196
   1855de193:	48 8b 1b             	mov    rbx,QWORD PTR [rbx]
   1855de196:	4d 85 ed             	test   r13,r13
   1855de199:	0f 88 5a 16 00 00    	js     0x1855df7f9
   1855de19f:	49 83 fd 0f          	cmp    r13,0xf
   1855de1a3:	0f 87 e7 03 00 00    	ja     0x1855de590
   1855de1a9:	4c 89 ad 30 0e 00 00 	mov    QWORD PTR [rbp+0xe30],r13
   1855de1b0:	48 c7 85 38 0e 00 00 	mov    QWORD PTR [rbp+0xe38],0xf
   1855de1b7:	0f 00 00 00
   1855de1bb:	f3 0f 6f 03          	movdqu xmm0,XMMWORD PTR [rbx]
   1855de1bf:	66 0f 7f 85 20 0e 00 	movdqa XMMWORD PTR [rbp+0xe20],xmm0
   1855de1c6:	00
   1855de1c7:	e9 34 04 00 00       	jmp    0x1855de600
   1855de1cc:	b9 04 00 00 00       	mov    ecx,0x4
   1855de1d1:	e8 0a ec a8 fa       	call   0x18006cde0
   1855de1d6:	85 c0                	test   eax,eax
   1855de1d8:	0f 84 b0 01 00 00    	je     0x1855de38e
   1855de1de:	48 8d b5 90 0f 00 00 	lea    rsi,[rbp+0xf90]
   1855de1e5:	48 89 f1             	mov    rcx,rsi
   1855de1e8:	e8 23 ed a8 fa       	call   0x18006cf10
   1855de1ed:	90                   	nop
   1855de1ee:	48 83 bd a8 0f 00 00 	cmp    QWORD PTR [rbp+0xfa8],0x10
   1855de1f5:	10
   1855de1f6:	72 07                	jb     0x1855de1ff
   1855de1f8:	48 8b b5 90 0f 00 00 	mov    rsi,QWORD PTR [rbp+0xf90]
   1855de1ff:	48 8d 05 ba 79 42 04 	lea    rax,[rip+0x44279ba]        # 0x189a05bc0
   1855de206:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855de20b:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855de212:	00 00
   1855de214:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855de219:	c7 44 24 28 4e 02 00 	mov    DWORD PTR [rsp+0x28],0x24e
   1855de220:	00
   1855de221:	4c 8d 0d 98 70 42 04 	lea    r9,[rip+0x4427098]        # 0x189a052c0
   1855de228:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855de22f:	ba 04 00 00 00       	mov    edx,0x4
   1855de234:	49 89 f0             	mov    r8,rsi
   1855de237:	e8 34 f0 a8 fa       	call   0x18006d270
   1855de23c:	90                   	nop
   1855de23d:	48 8d 8d e0 0d 00 00 	lea    rcx,[rbp+0xde0]
   1855de244:	48 8d b5 40 0f 00 00 	lea    rsi,[rbp+0xf40]
   1855de24b:	48 89 f2             	mov    rdx,rsi
   1855de24e:	e8 0d 2a b3 fa       	call   0x180110c60
   1855de253:	90                   	nop
   1855de254:	48 83 bd 58 0f 00 00 	cmp    QWORD PTR [rbp+0xf58],0x10
   1855de25b:	10
   1855de25c:	72 07                	jb     0x1855de265
   1855de25e:	48 8b b5 40 0f 00 00 	mov    rsi,QWORD PTR [rbp+0xf40]
   1855de265:	48 89 b5 60 09 00 00 	mov    QWORD PTR [rbp+0x960],rsi
   1855de26c:	c6 85 68 09 00 00 00 	mov    BYTE PTR [rbp+0x968],0x0
   1855de273:	48 83 7f 18 10       	cmp    QWORD PTR [rdi+0x18],0x10
   1855de278:	72 03                	jb     0x1855de27d
   1855de27a:	48 8b 3f             	mov    rdi,QWORD PTR [rdi]
   1855de27d:	48 89 bd c0 0e 00 00 	mov    QWORD PTR [rbp+0xec0],rdi
   1855de284:	c6 85 c8 0e 00 00 00 	mov    BYTE PTR [rbp+0xec8],0x0
   1855de28b:	66 0f ef c0          	pxor   xmm0,xmm0
   1855de28f:	f3 0f 7f 85 e0 06 00 	movdqu XMMWORD PTR [rbp+0x6e0],xmm0
   1855de296:	00
   1855de297:	f3 0f 7f 85 d0 06 00 	movdqu XMMWORD PTR [rbp+0x6d0],xmm0
   1855de29e:	00
   1855de29f:	f3 0f 7f 85 c0 06 00 	movdqu XMMWORD PTR [rbp+0x6c0],xmm0
   1855de2a6:	00
   1855de2a7:	f3 0f 7f 85 b0 06 00 	movdqu XMMWORD PTR [rbp+0x6b0],xmm0
   1855de2ae:	00
   1855de2af:	f3 0f 7f 85 a0 06 00 	movdqu XMMWORD PTR [rbp+0x6a0],xmm0
   1855de2b6:	00
   1855de2b7:	f3 0f 7f 85 90 06 00 	movdqu XMMWORD PTR [rbp+0x690],xmm0
   1855de2be:	00
   1855de2bf:	f3 0f 7f 85 80 06 00 	movdqu XMMWORD PTR [rbp+0x680],xmm0
   1855de2c6:	00
   1855de2c7:	4c 89 ad 70 06 00 00 	mov    QWORD PTR [rbp+0x670],r13
   1855de2ce:	48 8d 85 60 09 00 00 	lea    rax,[rbp+0x960]
   1855de2d5:	48 89 85 78 06 00 00 	mov    QWORD PTR [rbp+0x678],rax
   1855de2dc:	48 8d 15 7d 7d 42 04 	lea    rdx,[rip+0x4427d7d]        # 0x189a06060
   1855de2e3:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855de2ea:	4c 8d 85 70 06 00 00 	lea    r8,[rbp+0x670]
   1855de2f1:	e8 1a f5 a8 fa       	call   0x18006d810
   1855de2f6:	90                   	nop
   1855de2f7:	48 8b 85 58 0f 00 00 	mov    rax,QWORD PTR [rbp+0xf58]
   1855de2fe:	48 83 f8 10          	cmp    rax,0x10
   1855de302:	72 38                	jb     0x1855de33c
   1855de304:	48 8b 8d 40 0f 00 00 	mov    rcx,QWORD PTR [rbp+0xf40]
   1855de30b:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855de30f:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855de316:	72 1f                	jb     0x1855de337
   1855de318:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855de31c:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855de320:	4c 29 c1             	sub    rcx,r8
   1855de323:	48 83 f9 20          	cmp    rcx,0x20
   1855de327:	0f 83 80 14 00 00    	jae    0x1855df7ad
   1855de32d:	48 83 c0 28          	add    rax,0x28
   1855de331:	48 89 c2             	mov    rdx,rax
   1855de334:	4c 89 c1             	mov    rcx,r8
   1855de337:	e8 e4 d9 f6 01       	call   0x18754bd20
   1855de33c:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855de343:	e8 28 f0 a8 fa       	call   0x18006d370
   1855de348:	48 8b 85 a8 0f 00 00 	mov    rax,QWORD PTR [rbp+0xfa8]
   1855de34f:	48 83 f8 10          	cmp    rax,0x10
   1855de353:	72 39                	jb     0x1855de38e
   1855de355:	48 8b 8d 90 0f 00 00 	mov    rcx,QWORD PTR [rbp+0xf90]
   1855de35c:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855de360:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855de367:	72 1f                	jb     0x1855de388
   1855de369:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855de36d:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855de371:	4c 29 c1             	sub    rcx,r8
   1855de374:	48 83 f9 20          	cmp    rcx,0x20
   1855de378:	0f 83 2f 14 00 00    	jae    0x1855df7ad
   1855de37e:	48 83 c0 28          	add    rax,0x28
   1855de382:	48 89 c2             	mov    rdx,rax
   1855de385:	4c 89 c1             	mov    rcx,r8
   1855de388:	e8 93 d9 f6 01       	call   0x18754bd20
   1855de38d:	90                   	nop
   1855de38e:	48 8d 8d e0 0d 00 00 	lea    rcx,[rbp+0xde0]
   1855de395:	48 8d b5 70 06 00 00 	lea    rsi,[rbp+0x670]
   1855de39c:	48 89 f2             	mov    rdx,rsi
   1855de39f:	e8 bc 28 b3 fa       	call   0x180110c60
   1855de3a4:	90                   	nop
   1855de3a5:	4c 8b 85 80 06 00 00 	mov    r8,QWORD PTR [rbp+0x680]
   1855de3ac:	48 8b 85 88 06 00 00 	mov    rax,QWORD PTR [rbp+0x688]
   1855de3b3:	48 89 c1             	mov    rcx,rax
   1855de3b6:	4c 29 c1             	sub    rcx,r8
   1855de3b9:	48 8d 3d 88 56 42 04 	lea    rdi,[rip+0x4425688]        # 0x189a03a48
   1855de3c0:	48 83 f9 1e          	cmp    rcx,0x1e
   1855de3c4:	73 2e                	jae    0x1855de3f4
   1855de3c6:	48 89 7c 24 20       	mov    QWORD PTR [rsp+0x20],rdi
   1855de3cb:	48 c7 44 24 28 1e 00 	mov    QWORD PTR [rsp+0x28],0x1e
   1855de3d2:	00 00
   1855de3d4:	48 8d 8d 70 06 00 00 	lea    rcx,[rbp+0x670]
   1855de3db:	ba 1e 00 00 00       	mov    edx,0x1e
   1855de3e0:	45 31 c9             	xor    r9d,r9d
   1855de3e3:	e8 68 d9 a2 fa       	call   0x18000bd50
   1855de3e8:	90                   	nop
   1855de3e9:	48 89 c6             	mov    rsi,rax
   1855de3ec:	4d 89 e5             	mov    r13,r12
   1855de3ef:	e9 92 00 00 00       	jmp    0x1855de486
   1855de3f4:	4d 89 e5             	mov    r13,r12
   1855de3f7:	49 8d 48 1e          	lea    rcx,[r8+0x1e]
   1855de3fb:	48 89 8d 80 06 00 00 	mov    QWORD PTR [rbp+0x680],rcx
   1855de402:	48 83 f8 10          	cmp    rax,0x10
   1855de406:	48 8b 8d 70 06 00 00 	mov    rcx,QWORD PTR [rbp+0x670]
   1855de40d:	48 89 f3             	mov    rbx,rsi
   1855de410:	48 0f 43 d9          	cmovae rbx,rcx
   1855de414:	48 8d 15 4b 56 42 04 	lea    rdx,[rip+0x442564b]        # 0x189a03a66
   1855de41b:	48 39 d3             	cmp    rbx,rdx
   1855de41e:	0f 93 c2             	setae  dl
   1855de421:	4e 8d 0c 03          	lea    r9,[rbx+r8*1]
   1855de425:	49 39 f9             	cmp    r9,rdi
   1855de428:	41 0f 92 c1          	setb   r9b
   1855de42c:	41 08 d1             	or     r9b,dl
   1855de42f:	41 bf 1e 00 00 00    	mov    r15d,0x1e
   1855de435:	41 bc 1e 00 00 00    	mov    r12d,0x1e
   1855de43b:	75 0b                	jne    0x1855de448
   1855de43d:	49 89 dc             	mov    r12,rbx
   1855de440:	49 29 fc             	sub    r12,rdi
   1855de443:	77 03                	ja     0x1855de448
   1855de445:	45 31 e4             	xor    r12d,r12d
   1855de448:	49 ff c0             	inc    r8
   1855de44b:	48 83 f8 10          	cmp    rax,0x10
   1855de44f:	48 0f 42 ce          	cmovb  rcx,rsi
   1855de453:	48 83 c1 1e          	add    rcx,0x1e
   1855de457:	48 89 da             	mov    rdx,rbx
   1855de45a:	e8 e1 69 13 02       	call   0x187714e40
   1855de45f:	48 89 d9             	mov    rcx,rbx
   1855de462:	48 89 fa             	mov    rdx,rdi
   1855de465:	4d 89 e0             	mov    r8,r12
   1855de468:	e8 d3 69 13 02       	call   0x187714e40
   1855de46d:	4d 29 e7             	sub    r15,r12
   1855de470:	49 8d 14 3c          	lea    rdx,[r12+rdi*1]
   1855de474:	48 83 c2 1e          	add    rdx,0x1e
   1855de478:	4c 01 e3             	add    rbx,r12
   1855de47b:	48 89 d9             	mov    rcx,rbx
   1855de47e:	4d 89 f8             	mov    r8,r15
   1855de481:	e8 ba 69 13 02       	call   0x187714e40
   1855de486:	f3 0f 6f 06          	movdqu xmm0,XMMWORD PTR [rsi]
   1855de48a:	f3 0f 6f 4e 10       	movdqu xmm1,XMMWORD PTR [rsi+0x10]
   1855de48f:	66 0f 7f 8d a0 01 00 	movdqa XMMWORD PTR [rbp+0x1a0],xmm1
   1855de496:	00
   1855de497:	66 0f 7f 85 90 01 00 	movdqa XMMWORD PTR [rbp+0x190],xmm0
   1855de49e:	00
   1855de49f:	48 c7 46 10 00 00 00 	mov    QWORD PTR [rsi+0x10],0x0
   1855de4a6:	00
   1855de4a7:	48 c7 46 18 0f 00 00 	mov    QWORD PTR [rsi+0x18],0xf
   1855de4ae:	00
   1855de4af:	c6 06 00             	mov    BYTE PTR [rsi],0x0
   1855de4b2:	0f 29 b5 e0 05 00 00 	movaps XMMWORD PTR [rbp+0x5e0],xmm6
   1855de4b9:	0f 29 b5 f0 05 00 00 	movaps XMMWORD PTR [rbp+0x5f0],xmm6
   1855de4c0:	0f 29 b5 10 06 00 00 	movaps XMMWORD PTR [rbp+0x610],xmm6
   1855de4c7:	0f 29 b5 d0 05 00 00 	movaps XMMWORD PTR [rbp+0x5d0],xmm6
   1855de4ce:	0f 29 b5 00 06 00 00 	movaps XMMWORD PTR [rbp+0x600],xmm6
   1855de4d5:	c6 85 e0 05 00 00 00 	mov    BYTE PTR [rbp+0x5e0],0x0
   1855de4dc:	c6 85 f0 05 00 00 00 	mov    BYTE PTR [rbp+0x5f0],0x0
   1855de4e3:	c6 85 18 06 00 00 00 	mov    BYTE PTR [rbp+0x618],0x0
   1855de4ea:	c6 85 d0 05 00 00 00 	mov    BYTE PTR [rbp+0x5d0],0x0
   1855de4f1:	48 8d 8d f8 05 00 00 	lea    rcx,[rbp+0x5f8]
   1855de4f8:	48 8d 95 90 01 00 00 	lea    rdx,[rbp+0x190]
   1855de4ff:	e8 ec 6a 3b fc       	call   0x181994ff0
   1855de504:	90                   	nop
   1855de505:	48 8d 95 d0 05 00 00 	lea    rdx,[rbp+0x5d0]
   1855de50c:	4c 89 e9             	mov    rcx,r13
   1855de50f:	e8 1c 43 00 00       	call   0x1855e2830
   1855de514:	90                   	nop
   1855de515:	48 8b 85 a8 01 00 00 	mov    rax,QWORD PTR [rbp+0x1a8]
   1855de51c:	48 83 f8 10          	cmp    rax,0x10
   1855de520:	48 8b bd 00 10 00 00 	mov    rdi,QWORD PTR [rbp+0x1000]
   1855de527:	72 38                	jb     0x1855de561
   1855de529:	48 8b 8d 90 01 00 00 	mov    rcx,QWORD PTR [rbp+0x190]
   1855de530:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855de534:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855de53b:	72 1f                	jb     0x1855de55c
   1855de53d:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855de541:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855de545:	4c 29 c1             	sub    rcx,r8
   1855de548:	48 83 f9 20          	cmp    rcx,0x20
   1855de54c:	0f 83 5b 12 00 00    	jae    0x1855df7ad
   1855de552:	48 83 c0 28          	add    rax,0x28
   1855de556:	48 89 c2             	mov    rdx,rax
   1855de559:	4c 89 c1             	mov    rcx,r8
   1855de55c:	e8 bf d7 f6 01       	call   0x18754bd20
   1855de561:	48 8b 85 88 06 00 00 	mov    rax,QWORD PTR [rbp+0x688]
   1855de568:	48 83 f8 10          	cmp    rax,0x10
   1855de56c:	0f 82 0b 0d 00 00    	jb     0x1855df27d
   1855de572:	48 8b 8d 70 06 00 00 	mov    rcx,QWORD PTR [rbp+0x670]
   1855de579:	e9 ce 0c 00 00       	jmp    0x1855df24c
   1855de57e:	48 8d 8d 40 0e 00 00 	lea    rcx,[rbp+0xe40]
   1855de585:	e8 36 e7 b2 fa       	call   0x18010ccc0
   1855de58a:	90                   	nop
   1855de58b:	e9 b4 0d 00 00       	jmp    0x1855df344
   1855de590:	4c 89 e8             	mov    rax,r13
   1855de593:	48 83 c8 0f          	or     rax,0xf
   1855de597:	48 83 f8 17          	cmp    rax,0x17
   1855de59b:	be 16 00 00 00       	mov    esi,0x16
   1855de5a0:	48 0f 43 f0          	cmovae rsi,rax
   1855de5a4:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   1855de5aa:	72 24                	jb     0x1855de5d0
   1855de5ac:	48 8d 4e 28          	lea    rcx,[rsi+0x28]
   1855de5b0:	e8 27 d7 f6 01       	call   0x18754bcdc
   1855de5b5:	90                   	nop
   1855de5b6:	48 85 c0             	test   rax,rax
   1855de5b9:	0f 84 ee 11 00 00    	je     0x1855df7ad
   1855de5bf:	48 89 c1             	mov    rcx,rax
   1855de5c2:	48 83 c0 27          	add    rax,0x27
   1855de5c6:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
   1855de5ca:	48 89 48 f8          	mov    QWORD PTR [rax-0x8],rcx
   1855de5ce:	eb 0a                	jmp    0x1855de5da
   1855de5d0:	48 8d 4e 01          	lea    rcx,[rsi+0x1]
   1855de5d4:	e8 03 d7 f6 01       	call   0x18754bcdc
   1855de5d9:	90                   	nop
   1855de5da:	48 89 85 20 0e 00 00 	mov    QWORD PTR [rbp+0xe20],rax
   1855de5e1:	4c 89 ad 30 0e 00 00 	mov    QWORD PTR [rbp+0xe30],r13
   1855de5e8:	48 89 b5 38 0e 00 00 	mov    QWORD PTR [rbp+0xe38],rsi
   1855de5ef:	49 ff c5             	inc    r13
   1855de5f2:	48 89 c1             	mov    rcx,rax
   1855de5f5:	48 89 da             	mov    rdx,rbx
   1855de5f8:	4d 89 e8             	mov    r8,r13
   1855de5fb:	e8 40 68 13 02       	call   0x187714e40
   1855de600:	b9 02 00 00 00       	mov    ecx,0x2
   1855de605:	e8 d6 e7 a8 fa       	call   0x18006cde0
   1855de60a:	85 c0                	test   eax,eax
   1855de60c:	4c 89 f3             	mov    rbx,r14
   1855de60f:	4d 89 e6             	mov    r14,r12
   1855de612:	0f 84 d2 01 00 00    	je     0x1855de7ea
   1855de618:	48 8d b5 90 0f 00 00 	lea    rsi,[rbp+0xf90]
   1855de61f:	48 89 f1             	mov    rcx,rsi
   1855de622:	e8 e9 e8 a8 fa       	call   0x18006cf10
   1855de627:	90                   	nop
   1855de628:	48 83 bd a8 0f 00 00 	cmp    QWORD PTR [rbp+0xfa8],0x10
   1855de62f:	10
   1855de630:	72 07                	jb     0x1855de639
   1855de632:	48 8b b5 90 0f 00 00 	mov    rsi,QWORD PTR [rbp+0xf90]
   1855de639:	48 8d 05 80 75 42 04 	lea    rax,[rip+0x4427580]        # 0x189a05bc0
   1855de640:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855de645:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855de64c:	00 00
   1855de64e:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855de653:	c7 44 24 28 54 02 00 	mov    DWORD PTR [rsp+0x28],0x254
   1855de65a:	00
   1855de65b:	4c 8d 0d 5e 6c 42 04 	lea    r9,[rip+0x4426c5e]        # 0x189a052c0
   1855de662:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855de669:	ba 02 00 00 00       	mov    edx,0x2
   1855de66e:	49 89 f0             	mov    r8,rsi
   1855de671:	e8 fa eb a8 fa       	call   0x18006d270
   1855de676:	90                   	nop
   1855de677:	48 8b 8d 30 0e 00 00 	mov    rcx,QWORD PTR [rbp+0xe30]
   1855de67e:	48 c7 85 60 09 00 00 	mov    QWORD PTR [rbp+0x960],0x0
   1855de685:	00 00 00 00
   1855de689:	41 b9 07 00 00 00    	mov    r9d,0x7
   1855de68f:	4c 8d 85 67 09 00 00 	lea    r8,[rbp+0x967]
   1855de696:	49 ba cd cc cc cc cc 	movabs r10,0xcccccccccccccccd
   1855de69d:	cc cc cc
   1855de6a0:	4c 8d 1d c9 8b 93 03 	lea    r11,[rip+0x3938bc9]        # 0x188f17270
   1855de6a7:	48 89 c8             	mov    rax,rcx
   1855de6aa:	49 f7 e2             	mul    r10
   1855de6ad:	48 c1 ea 03          	shr    rdx,0x3
   1855de6b1:	48 8d 04 12          	lea    rax,[rdx+rdx*1]
   1855de6b5:	48 8d 04 80          	lea    rax,[rax+rax*4]
   1855de6b9:	4c 89 de             	mov    rsi,r11
   1855de6bc:	48 29 c6             	sub    rsi,rax
   1855de6bf:	0f b6 44 0e 23       	movzx  eax,BYTE PTR [rsi+rcx*1+0x23]
   1855de6c4:	41 88 40 01          	mov    BYTE PTR [r8+0x1],al
   1855de6c8:	49 ff c0             	inc    r8
   1855de6cb:	49 ff c1             	inc    r9
   1855de6ce:	48 83 f9 09          	cmp    rcx,0x9
   1855de6d2:	48 89 d1             	mov    rcx,rdx
   1855de6d5:	77 d0                	ja     0x1855de6a7
   1855de6d7:	48 8d 85 68 09 00 00 	lea    rax,[rbp+0x968]
   1855de6de:	41 c6 40 01 00       	mov    BYTE PTR [r8+0x1],0x0
   1855de6e3:	49 83 f9 09          	cmp    r9,0x9
   1855de6e7:	72 22                	jb     0x1855de70b
   1855de6e9:	48 8d 8d 69 09 00 00 	lea    rcx,[rbp+0x969]
   1855de6f0:	41 0f b6 10          	movzx  edx,BYTE PTR [r8]
   1855de6f4:	44 0f b6 49 ff       	movzx  r9d,BYTE PTR [rcx-0x1]
   1855de6f9:	45 88 08             	mov    BYTE PTR [r8],r9b
   1855de6fc:	49 ff c8             	dec    r8
   1855de6ff:	88 51 ff             	mov    BYTE PTR [rcx-0x1],dl
   1855de702:	4c 39 c1             	cmp    rcx,r8
   1855de705:	48 8d 49 01          	lea    rcx,[rcx+0x1]
   1855de709:	72 e5                	jb     0x1855de6f0
   1855de70b:	48 89 85 60 09 00 00 	mov    QWORD PTR [rbp+0x960],rax
   1855de712:	48 83 7f 18 10       	cmp    QWORD PTR [rdi+0x18],0x10
   1855de717:	48 89 f8             	mov    rax,rdi
   1855de71a:	72 03                	jb     0x1855de71f
   1855de71c:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855de71f:	48 89 85 c0 0e 00 00 	mov    QWORD PTR [rbp+0xec0],rax
   1855de726:	c6 85 c8 0e 00 00 00 	mov    BYTE PTR [rbp+0xec8],0x0
   1855de72d:	66 0f ef c0          	pxor   xmm0,xmm0
   1855de731:	f3 0f 7f 85 e0 06 00 	movdqu XMMWORD PTR [rbp+0x6e0],xmm0
   1855de738:	00
   1855de739:	f3 0f 7f 85 d0 06 00 	movdqu XMMWORD PTR [rbp+0x6d0],xmm0
   1855de740:	00
   1855de741:	f3 0f 7f 85 c0 06 00 	movdqu XMMWORD PTR [rbp+0x6c0],xmm0
   1855de748:	00
   1855de749:	f3 0f 7f 85 b0 06 00 	movdqu XMMWORD PTR [rbp+0x6b0],xmm0
   1855de750:	00
   1855de751:	f3 0f 7f 85 a0 06 00 	movdqu XMMWORD PTR [rbp+0x6a0],xmm0
   1855de758:	00
   1855de759:	f3 0f 7f 85 90 06 00 	movdqu XMMWORD PTR [rbp+0x690],xmm0
   1855de760:	00
   1855de761:	f3 0f 7f 85 80 06 00 	movdqu XMMWORD PTR [rbp+0x680],xmm0
   1855de768:	00
   1855de769:	48 89 9d 70 06 00 00 	mov    QWORD PTR [rbp+0x670],rbx
   1855de770:	48 8d 85 60 09 00 00 	lea    rax,[rbp+0x960]
   1855de777:	48 89 85 78 06 00 00 	mov    QWORD PTR [rbp+0x678],rax
   1855de77e:	48 8d 15 9b 7a 42 04 	lea    rdx,[rip+0x4427a9b]        # 0x189a06220
   1855de785:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855de78c:	4c 8d 85 70 06 00 00 	lea    r8,[rbp+0x670]
   1855de793:	e8 78 f0 a8 fa       	call   0x18006d810
   1855de798:	90                   	nop
   1855de799:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855de7a0:	e8 cb eb a8 fa       	call   0x18006d370
   1855de7a5:	48 8b 85 a8 0f 00 00 	mov    rax,QWORD PTR [rbp+0xfa8]
   1855de7ac:	48 83 f8 10          	cmp    rax,0x10
   1855de7b0:	72 38                	jb     0x1855de7ea
   1855de7b2:	48 8b 8d 90 0f 00 00 	mov    rcx,QWORD PTR [rbp+0xf90]
   1855de7b9:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855de7bd:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855de7c4:	72 1f                	jb     0x1855de7e5
   1855de7c6:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855de7ca:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855de7ce:	4c 29 c1             	sub    rcx,r8
   1855de7d1:	48 83 f9 20          	cmp    rcx,0x20
   1855de7d5:	0f 83 d2 0f 00 00    	jae    0x1855df7ad
   1855de7db:	48 83 c0 28          	add    rax,0x28
   1855de7df:	48 89 c2             	mov    rdx,rax
   1855de7e2:	4c 89 c1             	mov    rcx,r8
   1855de7e5:	e8 36 d5 f6 01       	call   0x18754bd20
   1855de7ea:	48 8d 15 5f fe ab 03 	lea    rdx,[rip+0x3abfe5f]        # 0x18909e650
   1855de7f1:	48 8d 8d 60 09 00 00 	lea    rcx,[rbp+0x960]
   1855de7f8:	41 b8 e8 02 00 00    	mov    r8d,0x2e8
   1855de7fe:	e8 3d 66 13 02       	call   0x187714e40
   1855de803:	90                   	nop
   1855de804:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855de80b:	e8 00 6a fb fa       	call   0x180595210
   1855de810:	90                   	nop
   1855de811:	48 8d 8d 60 09 00 00 	lea    rcx,[rbp+0x960]
   1855de818:	48 8d 95 90 01 00 00 	lea    rdx,[rbp+0x190]
   1855de81f:	e8 ec bd d9 ff       	call   0x18537a610
   1855de824:	90                   	nop
   1855de825:	48 8b 85 a8 01 00 00 	mov    rax,QWORD PTR [rbp+0x1a8]
   1855de82c:	48 83 f8 10          	cmp    rax,0x10
   1855de830:	72 39                	jb     0x1855de86b
   1855de832:	48 8b 8d 90 01 00 00 	mov    rcx,QWORD PTR [rbp+0x190]
   1855de839:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855de83d:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855de844:	72 1f                	jb     0x1855de865
   1855de846:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855de84a:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855de84e:	4c 29 c1             	sub    rcx,r8
   1855de851:	48 83 f9 20          	cmp    rcx,0x20
   1855de855:	0f 83 52 0f 00 00    	jae    0x1855df7ad
   1855de85b:	48 83 c0 28          	add    rax,0x28
   1855de85f:	48 89 c2             	mov    rdx,rax
   1855de862:	4c 89 c1             	mov    rcx,r8
   1855de865:	e8 b6 d4 f6 01       	call   0x18754bd20
   1855de86a:	90                   	nop
   1855de86b:	48 8d 8d 60 09 00 00 	lea    rcx,[rbp+0x960]
   1855de872:	ba 31 00 00 00       	mov    edx,0x31
   1855de877:	e8 84 07 4a fb       	call   0x180a7f000
   1855de87c:	90                   	nop
   1855de87d:	48 8d 8d 60 09 00 00 	lea    rcx,[rbp+0x960]
   1855de884:	ba 33 00 00 00       	mov    edx,0x33
   1855de889:	e8 52 15 4a fb       	call   0x180a7fde0
   1855de88e:	90                   	nop
   1855de88f:	c6 85 20 0c 00 00 00 	mov    BYTE PTR [rbp+0xc20],0x0
   1855de896:	48 8b b5 30 0e 00 00 	mov    rsi,QWORD PTR [rbp+0xe30]
   1855de89d:	48 83 bd 38 0e 00 00 	cmp    QWORD PTR [rbp+0xe38],0x10
   1855de8a4:	10
   1855de8a5:	72 09                	jb     0x1855de8b0
   1855de8a7:	4c 8b 8d 20 0e 00 00 	mov    r9,QWORD PTR [rbp+0xe20]
   1855de8ae:	eb 07                	jmp    0x1855de8b7
   1855de8b0:	4c 8d 8d 20 0e 00 00 	lea    r9,[rbp+0xe20]
   1855de8b7:	48 8d 9d e0 0a 00 00 	lea    rbx,[rbp+0xae0]
   1855de8be:	48 8b 85 f8 0a 00 00 	mov    rax,QWORD PTR [rbp+0xaf8]
   1855de8c5:	48 39 c6             	cmp    rsi,rax
   1855de8c8:	76 0e                	jbe    0x1855de8d8
   1855de8ca:	48 89 d9             	mov    rcx,rbx
   1855de8cd:	48 89 f2             	mov    rdx,rsi
   1855de8d0:	e8 7b f8 a5 fa       	call   0x18003e150
   1855de8d5:	90                   	nop
   1855de8d6:	eb 26                	jmp    0x1855de8fe
   1855de8d8:	48 83 f8 10          	cmp    rax,0x10
   1855de8dc:	72 07                	jb     0x1855de8e5
   1855de8de:	48 8b 9d e0 0a 00 00 	mov    rbx,QWORD PTR [rbp+0xae0]
   1855de8e5:	48 89 b5 f0 0a 00 00 	mov    QWORD PTR [rbp+0xaf0],rsi
   1855de8ec:	48 89 d9             	mov    rcx,rbx
   1855de8ef:	4c 89 ca             	mov    rdx,r9
   1855de8f2:	49 89 f0             	mov    r8,rsi
   1855de8f5:	e8 46 65 13 02       	call   0x187714e40
   1855de8fa:	c6 04 33 00          	mov    BYTE PTR [rbx+rsi*1],0x0
   1855de8fe:	e8 0d 74 a6 fa       	call   0x180045d10
   1855de903:	90                   	nop
   1855de904:	48 8b 10             	mov    rdx,QWORD PTR [rax]
   1855de907:	48 89 c1             	mov    rcx,rax
   1855de90a:	ff 52 20             	call   QWORD PTR [rdx+0x20]
   1855de90d:	90                   	nop
   1855de90e:	48 8d 9d 78 09 00 00 	lea    rbx,[rbp+0x978]
   1855de915:	48 39 c3             	cmp    rbx,rax
   1855de918:	74 51                	je     0x1855de96b
   1855de91a:	48 8b 70 10          	mov    rsi,QWORD PTR [rax+0x10]
   1855de91e:	48 83 78 18 10       	cmp    QWORD PTR [rax+0x18],0x10
   1855de923:	72 03                	jb     0x1855de928
   1855de925:	48 8b 00             	mov    rax,QWORD PTR [rax]
   1855de928:	48 8b 8d 90 09 00 00 	mov    rcx,QWORD PTR [rbp+0x990]
   1855de92f:	48 39 ce             	cmp    rsi,rcx
   1855de932:	76 11                	jbe    0x1855de945
   1855de934:	48 89 d9             	mov    rcx,rbx
   1855de937:	48 89 f2             	mov    rdx,rsi
   1855de93a:	49 89 c1             	mov    r9,rax
   1855de93d:	e8 0e f8 a5 fa       	call   0x18003e150
   1855de942:	90                   	nop
   1855de943:	eb 26                	jmp    0x1855de96b
   1855de945:	48 83 f9 10          	cmp    rcx,0x10
   1855de949:	72 07                	jb     0x1855de952
   1855de94b:	48 8b 9d 78 09 00 00 	mov    rbx,QWORD PTR [rbp+0x978]
   1855de952:	48 89 b5 88 09 00 00 	mov    QWORD PTR [rbp+0x988],rsi
   1855de959:	48 89 d9             	mov    rcx,rbx
   1855de95c:	48 89 c2             	mov    rdx,rax
   1855de95f:	49 89 f0             	mov    r8,rsi
   1855de962:	e8 d9 64 13 02       	call   0x187714e40
   1855de967:	c6 04 33 00          	mov    BYTE PTR [rbx+rsi*1],0x0
   1855de96b:	4c 8b 8d 08 10 00 00 	mov    r9,QWORD PTR [rbp+0x1008]
   1855de972:	49 8b 71 10          	mov    rsi,QWORD PTR [r9+0x10]
   1855de976:	49 83 79 18 10       	cmp    QWORD PTR [r9+0x18],0x10
   1855de97b:	72 0a                	jb     0x1855de987
   1855de97d:	48 8b 85 08 10 00 00 	mov    rax,QWORD PTR [rbp+0x1008]
   1855de984:	4c 8b 08             	mov    r9,QWORD PTR [rax]
   1855de987:	48 8d 9d 98 09 00 00 	lea    rbx,[rbp+0x998]
   1855de98e:	48 8b 85 b0 09 00 00 	mov    rax,QWORD PTR [rbp+0x9b0]
   1855de995:	48 39 c6             	cmp    rsi,rax
   1855de998:	76 0e                	jbe    0x1855de9a8
   1855de99a:	48 89 d9             	mov    rcx,rbx
   1855de99d:	48 89 f2             	mov    rdx,rsi
   1855de9a0:	e8 ab f7 a5 fa       	call   0x18003e150
   1855de9a5:	90                   	nop
   1855de9a6:	eb 26                	jmp    0x1855de9ce
   1855de9a8:	48 83 f8 10          	cmp    rax,0x10
   1855de9ac:	72 07                	jb     0x1855de9b5
   1855de9ae:	48 8b 9d 98 09 00 00 	mov    rbx,QWORD PTR [rbp+0x998]
   1855de9b5:	48 89 b5 a8 09 00 00 	mov    QWORD PTR [rbp+0x9a8],rsi
   1855de9bc:	48 89 d9             	mov    rcx,rbx
   1855de9bf:	4c 89 ca             	mov    rdx,r9
   1855de9c2:	49 89 f0             	mov    r8,rsi
   1855de9c5:	e8 76 64 13 02       	call   0x187714e40
   1855de9ca:	c6 04 33 00          	mov    BYTE PTR [rbx+rsi*1],0x0
   1855de9ce:	48 8d 8d 60 09 00 00 	lea    rcx,[rbp+0x960]
   1855de9d5:	e8 76 6a 4a fb       	call   0x180a85450
   1855de9da:	90                   	nop
   1855de9db:	48 8d 15 be 1e ac 03 	lea    rdx,[rip+0x3ac1ebe]        # 0x1890a08a0
   1855de9e2:	48 8d b5 90 01 00 00 	lea    rsi,[rbp+0x190]
   1855de9e9:	41 b8 40 04 00 00    	mov    r8d,0x440
   1855de9ef:	48 89 f1             	mov    rcx,rsi
   1855de9f2:	e8 49 64 13 02       	call   0x187714e40
   1855de9f7:	90                   	nop
   1855de9f8:	48 8d 8d 60 09 00 00 	lea    rcx,[rbp+0x960]
   1855de9ff:	48 89 f2             	mov    rdx,rsi
   1855dea02:	e8 39 72 4a fb       	call   0x180a85c40
   1855dea07:	90                   	nop
   1855dea08:	0f 29 b5 f0 0f 00 00 	movaps XMMWORD PTR [rbp+0xff0],xmm6
   1855dea0f:	48 8d 8d f0 0f 00 00 	lea    rcx,[rbp+0xff0]
   1855dea16:	e8 e5 00 c6 fc       	call   0x18223eb00
   1855dea1b:	90                   	nop
   1855dea1c:	b9 18 01 00 00       	mov    ecx,0x118
   1855dea21:	48 03 8d f0 0f 00 00 	add    rcx,QWORD PTR [rbp+0xff0]
   1855dea28:	48 8d 95 90 01 00 00 	lea    rdx,[rbp+0x190]
   1855dea2f:	e8 4c b4 47 fb       	call   0x180a59e80
   1855dea34:	90                   	nop
   1855dea35:	48 8b 85 f0 0f 00 00 	mov    rax,QWORD PTR [rbp+0xff0]
   1855dea3c:	48 8d 98 b0 00 00 00 	lea    rbx,[rax+0xb0]
   1855dea43:	48 3b 9d 08 10 00 00 	cmp    rbx,QWORD PTR [rbp+0x1008]
   1855dea4a:	74 58                	je     0x1855deaa4
   1855dea4c:	4c 8b 8d 08 10 00 00 	mov    r9,QWORD PTR [rbp+0x1008]
   1855dea53:	49 8b 71 10          	mov    rsi,QWORD PTR [r9+0x10]
   1855dea57:	49 83 79 18 10       	cmp    QWORD PTR [r9+0x18],0x10
   1855dea5c:	72 0a                	jb     0x1855dea68
   1855dea5e:	48 8b 8d 08 10 00 00 	mov    rcx,QWORD PTR [rbp+0x1008]
   1855dea65:	4c 8b 09             	mov    r9,QWORD PTR [rcx]
   1855dea68:	48 8b 88 c8 00 00 00 	mov    rcx,QWORD PTR [rax+0xc8]
   1855dea6f:	48 39 ce             	cmp    rsi,rcx
   1855dea72:	76 0e                	jbe    0x1855dea82
   1855dea74:	48 89 d9             	mov    rcx,rbx
   1855dea77:	48 89 f2             	mov    rdx,rsi
   1855dea7a:	e8 d1 f6 a5 fa       	call   0x18003e150
   1855dea7f:	90                   	nop
   1855dea80:	eb 22                	jmp    0x1855deaa4
   1855dea82:	48 83 f9 10          	cmp    rcx,0x10
   1855dea86:	72 03                	jb     0x1855dea8b
   1855dea88:	48 8b 1b             	mov    rbx,QWORD PTR [rbx]
   1855dea8b:	48 89 b0 c0 00 00 00 	mov    QWORD PTR [rax+0xc0],rsi
   1855dea92:	48 89 d9             	mov    rcx,rbx
   1855dea95:	4c 89 ca             	mov    rdx,r9
   1855dea98:	49 89 f0             	mov    r8,rsi
   1855dea9b:	e8 a0 63 13 02       	call   0x187714e40
   1855deaa0:	c6 04 33 00          	mov    BYTE PTR [rbx+rsi*1],0x0
   1855deaa4:	0f 29 b5 10 0d 00 00 	movaps XMMWORD PTR [rbp+0xd10],xmm6
   1855deaab:	48 8d 8d c0 0e 00 00 	lea    rcx,[rbp+0xec0]
   1855deab2:	e8 69 87 a6 fa       	call   0x180047220
   1855deab7:	90                   	nop
   1855deab8:	48 8b 8d c0 0e 00 00 	mov    rcx,QWORD PTR [rbp+0xec0]
   1855deabf:	48 8d 95 70 06 00 00 	lea    rdx,[rbp+0x670]
   1855deac6:	e8 05 39 da fa       	call   0x1803823d0
   1855deacb:	90                   	nop
   1855deacc:	48 8b 8d 70 06 00 00 	mov    rcx,QWORD PTR [rbp+0x670]
   1855dead3:	48 8d 95 10 0d 00 00 	lea    rdx,[rbp+0xd10]
   1855deada:	e8 a1 a7 12 fb       	call   0x180709280
   1855deadf:	90                   	nop
   1855deae0:	48 8b b5 78 06 00 00 	mov    rsi,QWORD PTR [rbp+0x678]
   1855deae7:	48 85 f6             	test   rsi,rsi
   1855deaea:	74 1d                	je     0x1855deb09
   1855deaec:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855deaf0:	75 17                	jne    0x1855deb09
   1855deaf2:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855deaf5:	48 89 f1             	mov    rcx,rsi
   1855deaf8:	ff 10                	call   QWORD PTR [rax]
   1855deafa:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855deafe:	75 09                	jne    0x1855deb09
   1855deb00:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855deb03:	48 89 f1             	mov    rcx,rsi
   1855deb06:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855deb09:	48 8b b5 c8 0e 00 00 	mov    rsi,QWORD PTR [rbp+0xec8]
   1855deb10:	48 85 f6             	test   rsi,rsi
   1855deb13:	74 1d                	je     0x1855deb32
   1855deb15:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855deb19:	75 17                	jne    0x1855deb32
   1855deb1b:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855deb1e:	48 89 f1             	mov    rcx,rsi
   1855deb21:	ff 10                	call   QWORD PTR [rax]
   1855deb23:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855deb27:	75 09                	jne    0x1855deb32
   1855deb29:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855deb2c:	48 89 f1             	mov    rcx,rsi
   1855deb2f:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855deb32:	48 8b 8d 10 0d 00 00 	mov    rcx,QWORD PTR [rbp+0xd10]
   1855deb39:	48 85 c9             	test   rcx,rcx
   1855deb3c:	74 48                	je     0x1855deb86
   1855deb3e:	4c 89 bd 70 0e 00 00 	mov    QWORD PTR [rbp+0xe70],r15
   1855deb45:	0f 29 b5 60 0e 00 00 	movaps XMMWORD PTR [rbp+0xe60],xmm6
   1855deb4c:	0f 29 b5 50 0e 00 00 	movaps XMMWORD PTR [rbp+0xe50],xmm6
   1855deb53:	0f 29 b5 40 0e 00 00 	movaps XMMWORD PTR [rbp+0xe40],xmm6
   1855deb5a:	66 0f ef c0          	pxor   xmm0,xmm0
   1855deb5e:	66 0f 7f 85 d0 0c 00 	movdqa XMMWORD PTR [rbp+0xcd0],xmm0
   1855deb65:	00
   1855deb66:	48 8b 85 f8 0f 00 00 	mov    rax,QWORD PTR [rbp+0xff8]
   1855deb6d:	48 85 c0             	test   rax,rax
   1855deb70:	0f 84 ff 00 00 00    	je     0x1855dec75
   1855deb76:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1855deb7a:	48 8b 85 f8 0f 00 00 	mov    rax,QWORD PTR [rbp+0xff8]
   1855deb81:	e9 f1 00 00 00       	jmp    0x1855dec77
   1855deb86:	66 0f ef c0          	pxor   xmm0,xmm0
   1855deb8a:	66 0f 7f 85 80 06 00 	movdqa XMMWORD PTR [rbp+0x680],xmm0
   1855deb91:	00
   1855deb92:	66 0f 7f 85 70 06 00 	movdqa XMMWORD PTR [rbp+0x670],xmm0
   1855deb99:	00
   1855deb9a:	b9 40 00 00 00       	mov    ecx,0x40
   1855deb9f:	e8 38 d1 f6 01       	call   0x18754bcdc
   1855deba4:	90                   	nop
   1855deba5:	48 89 85 70 06 00 00 	mov    QWORD PTR [rbp+0x670],rax
   1855debac:	48 c7 85 80 06 00 00 	mov    QWORD PTR [rbp+0x680],0x32
   1855debb3:	32 00 00 00
   1855debb7:	48 c7 85 88 06 00 00 	mov    QWORD PTR [rbp+0x688],0x3f
   1855debbe:	3f 00 00 00
   1855debc2:	0f 10 05 ef 4d 42 04 	movups xmm0,XMMWORD PTR [rip+0x4424def]        # 0x189a039b8
   1855debc9:	0f 11 40 20          	movups XMMWORD PTR [rax+0x20],xmm0
   1855debcd:	0f 10 05 d4 4d 42 04 	movups xmm0,XMMWORD PTR [rip+0x4424dd4]        # 0x189a039a8
   1855debd4:	0f 11 40 10          	movups XMMWORD PTR [rax+0x10],xmm0
   1855debd8:	f3 0f 6f 05 b8 4d 42 	movdqu xmm0,XMMWORD PTR [rip+0x4424db8]        # 0x189a03998
   1855debdf:	04
   1855debe0:	f3 0f 7f 00          	movdqu XMMWORD PTR [rax],xmm0
   1855debe4:	66 c7 40 30 6c 65    	mov    WORD PTR [rax+0x30],0x656c
   1855debea:	c6 40 32 00          	mov    BYTE PTR [rax+0x32],0x0
   1855debee:	0f 29 b5 30 06 00 00 	movaps XMMWORD PTR [rbp+0x630],xmm6
   1855debf5:	0f 29 b5 40 06 00 00 	movaps XMMWORD PTR [rbp+0x640],xmm6
   1855debfc:	0f 29 b5 60 06 00 00 	movaps XMMWORD PTR [rbp+0x660],xmm6
   1855dec03:	0f 29 b5 20 06 00 00 	movaps XMMWORD PTR [rbp+0x620],xmm6
   1855dec0a:	0f 29 b5 50 06 00 00 	movaps XMMWORD PTR [rbp+0x650],xmm6
   1855dec11:	c6 85 30 06 00 00 00 	mov    BYTE PTR [rbp+0x630],0x0
   1855dec18:	c6 85 40 06 00 00 00 	mov    BYTE PTR [rbp+0x640],0x0
   1855dec1f:	c6 85 68 06 00 00 00 	mov    BYTE PTR [rbp+0x668],0x0
   1855dec26:	c6 85 20 06 00 00 00 	mov    BYTE PTR [rbp+0x620],0x0
   1855dec2d:	48 8d 8d 48 06 00 00 	lea    rcx,[rbp+0x648]
   1855dec34:	48 8d 95 70 06 00 00 	lea    rdx,[rbp+0x670]
   1855dec3b:	e8 b0 63 3b fc       	call   0x181994ff0
   1855dec40:	90                   	nop
   1855dec41:	48 8d 95 20 06 00 00 	lea    rdx,[rbp+0x620]
   1855dec48:	4c 89 f1             	mov    rcx,r14
   1855dec4b:	e8 e0 3b 00 00       	call   0x1855e2830
   1855dec50:	90                   	nop
   1855dec51:	48 8b 85 88 06 00 00 	mov    rax,QWORD PTR [rbp+0x688]
   1855dec58:	48 83 f8 10          	cmp    rax,0x10
   1855dec5c:	48 8b bd 00 10 00 00 	mov    rdi,QWORD PTR [rbp+0x1000]
   1855dec63:	0f 82 65 05 00 00    	jb     0x1855df1ce
   1855dec69:	48 8b 8d 70 06 00 00 	mov    rcx,QWORD PTR [rbp+0x670]
   1855dec70:	e9 28 05 00 00       	jmp    0x1855df19d
   1855dec75:	31 c0                	xor    eax,eax
   1855dec77:	48 8b 95 f0 0f 00 00 	mov    rdx,QWORD PTR [rbp+0xff0]
   1855dec7e:	48 89 95 d0 0c 00 00 	mov    QWORD PTR [rbp+0xcd0],rdx
   1855dec85:	48 89 85 d8 0c 00 00 	mov    QWORD PTR [rbp+0xcd8],rax
   1855dec8c:	48 8d 95 40 0e 00 00 	lea    rdx,[rbp+0xe40]
   1855dec93:	4c 8d 85 d0 0c 00 00 	lea    r8,[rbp+0xcd0]
   1855dec9a:	e8 c1 4e 1c fc       	call   0x1817a3b60
   1855dec9f:	90                   	nop
   1855deca0:	8b 85 44 0e 00 00    	mov    eax,DWORD PTR [rbp+0xe44]
   1855deca6:	0b 85 40 0e 00 00    	or     eax,DWORD PTR [rbp+0xe40]
   1855decac:	0f 84 c1 01 00 00    	je     0x1855dee73
   1855decb2:	b9 04 00 00 00       	mov    ecx,0x4
   1855decb7:	e8 24 e1 a8 fa       	call   0x18006cde0
   1855decbc:	85 c0                	test   eax,eax
   1855decbe:	0f 84 45 01 00 00    	je     0x1855dee09
   1855decc4:	48 8d b5 70 0d 00 00 	lea    rsi,[rbp+0xd70]
   1855deccb:	48 89 f1             	mov    rcx,rsi
   1855decce:	e8 3d e2 a8 fa       	call   0x18006cf10
   1855decd3:	90                   	nop
   1855decd4:	48 83 bd 88 0d 00 00 	cmp    QWORD PTR [rbp+0xd88],0x10
   1855decdb:	10
   1855decdc:	72 07                	jb     0x1855dece5
   1855decde:	48 8b b5 70 0d 00 00 	mov    rsi,QWORD PTR [rbp+0xd70]
   1855dece5:	48 8d 05 d4 6e 42 04 	lea    rax,[rip+0x4426ed4]        # 0x189a05bc0
   1855decec:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855decf1:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855decf8:	00 00
   1855decfa:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855decff:	c7 44 24 28 6c 02 00 	mov    DWORD PTR [rsp+0x28],0x26c
   1855ded06:	00
   1855ded07:	4c 8d 0d b2 65 42 04 	lea    r9,[rip+0x44265b2]        # 0x189a052c0
   1855ded0e:	48 8d 8d 70 06 00 00 	lea    rcx,[rbp+0x670]
   1855ded15:	ba 04 00 00 00       	mov    edx,0x4
   1855ded1a:	49 89 f0             	mov    r8,rsi
   1855ded1d:	e8 4e e5 a8 fa       	call   0x18006d270
   1855ded22:	90                   	nop
   1855ded23:	48 8d 8d 40 0e 00 00 	lea    rcx,[rbp+0xe40]
   1855ded2a:	48 8d b5 20 0d 00 00 	lea    rsi,[rbp+0xd20]
   1855ded31:	48 89 f2             	mov    rdx,rsi
   1855ded34:	e8 27 1f b3 fa       	call   0x180110c60
   1855ded39:	90                   	nop
   1855ded3a:	48 83 bd 38 0d 00 00 	cmp    QWORD PTR [rbp+0xd38],0x10
   1855ded41:	10
   1855ded42:	72 07                	jb     0x1855ded4b
   1855ded44:	48 8b b5 20 0d 00 00 	mov    rsi,QWORD PTR [rbp+0xd20]
   1855ded4b:	48 89 b5 90 0f 00 00 	mov    QWORD PTR [rbp+0xf90],rsi
   1855ded52:	c6 85 98 0f 00 00 00 	mov    BYTE PTR [rbp+0xf98],0x0
   1855ded59:	48 83 7f 18 10       	cmp    QWORD PTR [rdi+0x18],0x10
   1855ded5e:	72 03                	jb     0x1855ded63
   1855ded60:	48 8b 3f             	mov    rdi,QWORD PTR [rdi]
   1855ded63:	48 89 bd 40 0f 00 00 	mov    QWORD PTR [rbp+0xf40],rdi
   1855ded6a:	c6 85 48 0f 00 00 00 	mov    BYTE PTR [rbp+0xf48],0x0
   1855ded71:	66 0f ef c0          	pxor   xmm0,xmm0
   1855ded75:	f3 0f 7f 85 30 0f 00 	movdqu XMMWORD PTR [rbp+0xf30],xmm0
   1855ded7c:	00
   1855ded7d:	f3 0f 7f 85 20 0f 00 	movdqu XMMWORD PTR [rbp+0xf20],xmm0
   1855ded84:	00
   1855ded85:	f3 0f 7f 85 10 0f 00 	movdqu XMMWORD PTR [rbp+0xf10],xmm0
   1855ded8c:	00
   1855ded8d:	f3 0f 7f 85 00 0f 00 	movdqu XMMWORD PTR [rbp+0xf00],xmm0
   1855ded94:	00
   1855ded95:	f3 0f 7f 85 f0 0e 00 	movdqu XMMWORD PTR [rbp+0xef0],xmm0
   1855ded9c:	00
   1855ded9d:	f3 0f 7f 85 e0 0e 00 	movdqu XMMWORD PTR [rbp+0xee0],xmm0
   1855deda4:	00
   1855deda5:	f3 0f 7f 85 d0 0e 00 	movdqu XMMWORD PTR [rbp+0xed0],xmm0
   1855dedac:	00
   1855dedad:	48 8d 85 40 0f 00 00 	lea    rax,[rbp+0xf40]
   1855dedb4:	48 89 85 c0 0e 00 00 	mov    QWORD PTR [rbp+0xec0],rax
   1855dedbb:	48 8d 85 90 0f 00 00 	lea    rax,[rbp+0xf90]
   1855dedc2:	48 89 85 c8 0e 00 00 	mov    QWORD PTR [rbp+0xec8],rax
   1855dedc9:	48 8d 15 e0 74 42 04 	lea    rdx,[rip+0x44274e0]        # 0x189a062b0
   1855dedd0:	48 8d 8d 70 06 00 00 	lea    rcx,[rbp+0x670]
   1855dedd7:	4c 8d 85 c0 0e 00 00 	lea    r8,[rbp+0xec0]
   1855dedde:	e8 2d ea a8 fa       	call   0x18006d810
   1855dede3:	90                   	nop
   1855dede4:	48 8d 8d 20 0d 00 00 	lea    rcx,[rbp+0xd20]
   1855dedeb:	e8 20 32 a2 fa       	call   0x180002010
   1855dedf0:	48 8d 8d 70 06 00 00 	lea    rcx,[rbp+0x670]
   1855dedf7:	e8 74 e5 a8 fa       	call   0x18006d370
   1855dedfc:	48 8d 8d 70 0d 00 00 	lea    rcx,[rbp+0xd70]
   1855dee03:	e8 08 32 a2 fa       	call   0x180002010
   1855dee08:	90                   	nop
   1855dee09:	48 8d 8d 40 0e 00 00 	lea    rcx,[rbp+0xe40]
   1855dee10:	48 8d 95 c0 0e 00 00 	lea    rdx,[rbp+0xec0]
   1855dee17:	e8 44 1e b3 fa       	call   0x180110c60
   1855dee1c:	90                   	nop
   1855dee1d:	48 8d 15 44 4c 42 04 	lea    rdx,[rip+0x4424c44]        # 0x189a03a68
   1855dee24:	48 8d 8d 70 06 00 00 	lea    rcx,[rbp+0x670]
   1855dee2b:	4c 8d 85 c0 0e 00 00 	lea    r8,[rbp+0xec0]
   1855dee32:	e8 69 c4 c1 fa       	call   0x1801fb2a0
   1855dee37:	90                   	nop
   1855dee38:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1855dee3c:	48 8d 95 70 06 00 00 	lea    rdx,[rbp+0x670]
   1855dee43:	e8 98 30 ff ff       	call   0x1855d1ee0
   1855dee48:	90                   	nop
   1855dee49:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   1855dee4d:	4c 89 f1             	mov    rcx,r14
   1855dee50:	e8 db 39 00 00       	call   0x1855e2830
   1855dee55:	90                   	nop
   1855dee56:	48 8d 8d 70 06 00 00 	lea    rcx,[rbp+0x670]
   1855dee5d:	e8 ae 31 a2 fa       	call   0x180002010
   1855dee62:	48 8d 8d c0 0e 00 00 	lea    rcx,[rbp+0xec0]
   1855dee69:	e8 a2 31 a2 fa       	call   0x180002010
   1855dee6e:	e9 e6 02 00 00       	jmp    0x1855df159
   1855dee73:	0f 29 b5 50 0f 00 00 	movaps XMMWORD PTR [rbp+0xf50],xmm6
   1855dee7a:	0f 29 b5 60 0f 00 00 	movaps XMMWORD PTR [rbp+0xf60],xmm6
   1855dee81:	0f 29 b5 80 0f 00 00 	movaps XMMWORD PTR [rbp+0xf80],xmm6
   1855dee88:	0f 29 b5 40 0f 00 00 	movaps XMMWORD PTR [rbp+0xf40],xmm6
   1855dee8f:	0f 29 b5 70 0f 00 00 	movaps XMMWORD PTR [rbp+0xf70],xmm6
   1855dee96:	c6 85 50 0f 00 00 00 	mov    BYTE PTR [rbp+0xf50],0x0
   1855dee9d:	c6 85 60 0f 00 00 00 	mov    BYTE PTR [rbp+0xf60],0x0
   1855deea4:	c6 85 88 0f 00 00 00 	mov    BYTE PTR [rbp+0xf88],0x0
   1855deeab:	c6 85 40 0f 00 00 01 	mov    BYTE PTR [rbp+0xf40],0x1
   1855deeb2:	4c 89 bd e0 0f 00 00 	mov    QWORD PTR [rbp+0xfe0],r15
   1855deeb9:	0f 29 b5 d0 0f 00 00 	movaps XMMWORD PTR [rbp+0xfd0],xmm6
   1855deec0:	0f 29 b5 c0 0f 00 00 	movaps XMMWORD PTR [rbp+0xfc0],xmm6
   1855deec7:	0f 29 b5 b0 0f 00 00 	movaps XMMWORD PTR [rbp+0xfb0],xmm6
   1855deece:	0f 29 b5 a0 0f 00 00 	movaps XMMWORD PTR [rbp+0xfa0],xmm6
   1855deed5:	0f 29 b5 90 0f 00 00 	movaps XMMWORD PTR [rbp+0xf90],xmm6
   1855deedc:	48 8b 8d 68 0e 00 00 	mov    rcx,QWORD PTR [rbp+0xe68]
   1855deee3:	48 8d 95 90 0f 00 00 	lea    rdx,[rbp+0xf90]
   1855deeea:	e8 71 4a 00 00       	call   0x1855e3960
   1855deeef:	90                   	nop
   1855deef0:	80 bd e0 0f 00 00 01 	cmp    BYTE PTR [rbp+0xfe0],0x1
   1855deef7:	75 7c                	jne    0x1855def75
   1855deef9:	8b bd b0 0f 00 00    	mov    edi,DWORD PTR [rbp+0xfb0]
   1855deeff:	48 89 bd 58 0f 00 00 	mov    QWORD PTR [rbp+0xf58],rdi
   1855def06:	c6 85 60 0f 00 00 01 	mov    BYTE PTR [rbp+0xf60],0x1
   1855def0d:	48 8d 15 a4 42 ac 03 	lea    rdx,[rip+0x3ac42a4]        # 0x1890a31b8
   1855def14:	48 8d b5 70 06 00 00 	lea    rsi,[rbp+0x670]
   1855def1b:	41 b8 f0 02 00 00    	mov    r8d,0x2f0
   1855def21:	48 89 f1             	mov    rcx,rsi
   1855def24:	e8 17 5f 13 02       	call   0x187714e40
   1855def29:	48 8b 8d 10 0d 00 00 	mov    rcx,QWORD PTR [rbp+0xd10]
   1855def30:	44 8b 8d b4 0f 00 00 	mov    r9d,DWORD PTR [rbp+0xfb4]
   1855def37:	89 7c 24 20          	mov    DWORD PTR [rsp+0x20],edi
   1855def3b:	48 89 f2             	mov    rdx,rsi
   1855def3e:	4c 8b 85 08 10 00 00 	mov    r8,QWORD PTR [rbp+0x1008]
   1855def45:	e8 46 ac 1d fc       	call   0x1817b9b90
   1855def4a:	90                   	nop
   1855def4b:	80 bd 58 09 00 00 01 	cmp    BYTE PTR [rbp+0x958],0x1
   1855def52:	75 21                	jne    0x1855def75
   1855def54:	48 8b 85 b8 07 00 00 	mov    rax,QWORD PTR [rbp+0x7b8]
   1855def5b:	48 89 85 48 0f 00 00 	mov    QWORD PTR [rbp+0xf48],rax
   1855def62:	c6 85 50 0f 00 00 01 	mov    BYTE PTR [rbp+0xf50],0x1
   1855def69:	48 8d 8d 70 06 00 00 	lea    rcx,[rbp+0x670]
   1855def70:	e8 cb d6 be fa       	call   0x1801cc640
   1855def75:	b9 02 00 00 00       	mov    ecx,0x2
   1855def7a:	e8 61 de a8 fa       	call   0x18006cde0
   1855def7f:	85 c0                	test   eax,eax
   1855def81:	0f 84 28 01 00 00    	je     0x1855df0af
   1855def87:	48 8d b5 f0 0c 00 00 	lea    rsi,[rbp+0xcf0]
   1855def8e:	48 89 f1             	mov    rcx,rsi
   1855def91:	e8 7a df a8 fa       	call   0x18006cf10
   1855def96:	90                   	nop
   1855def97:	48 83 bd 08 0d 00 00 	cmp    QWORD PTR [rbp+0xd08],0x10
   1855def9e:	10
   1855def9f:	72 07                	jb     0x1855defa8
   1855defa1:	48 8b b5 f0 0c 00 00 	mov    rsi,QWORD PTR [rbp+0xcf0]
   1855defa8:	48 8d 05 11 6c 42 04 	lea    rax,[rip+0x4426c11]        # 0x189a05bc0
   1855defaf:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855defb4:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855defbb:	00 00
   1855defbd:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855defc2:	c7 44 24 28 79 02 00 	mov    DWORD PTR [rsp+0x28],0x279
   1855defc9:	00
   1855defca:	4c 8d 0d ef 62 42 04 	lea    r9,[rip+0x44262ef]        # 0x189a052c0
   1855defd1:	48 8d 8d 70 06 00 00 	lea    rcx,[rbp+0x670]
   1855defd8:	ba 02 00 00 00       	mov    edx,0x2
   1855defdd:	49 89 f0             	mov    r8,rsi
   1855defe0:	e8 8b e2 a8 fa       	call   0x18006d270
   1855defe5:	90                   	nop
   1855defe6:	48 8b 85 d0 0d 00 00 	mov    rax,QWORD PTR [rbp+0xdd0]
   1855defed:	48 8b 8d 08 10 00 00 	mov    rcx,QWORD PTR [rbp+0x1008]
   1855deff4:	48 83 79 18 10       	cmp    QWORD PTR [rcx+0x18],0x10
   1855deff9:	72 03                	jb     0x1855deffe
   1855deffb:	48 8b 09             	mov    rcx,QWORD PTR [rcx]
   1855deffe:	48 89 8d 70 0d 00 00 	mov    QWORD PTR [rbp+0xd70],rcx
   1855df005:	c6 85 78 0d 00 00 00 	mov    BYTE PTR [rbp+0xd78],0x0
   1855df00c:	48 83 78 18 10       	cmp    QWORD PTR [rax+0x18],0x10
   1855df011:	72 03                	jb     0x1855df016
   1855df013:	48 8b 00             	mov    rax,QWORD PTR [rax]
   1855df016:	48 89 85 20 0d 00 00 	mov    QWORD PTR [rbp+0xd20],rax
   1855df01d:	c6 85 28 0d 00 00 00 	mov    BYTE PTR [rbp+0xd28],0x0
   1855df024:	66 0f ef c0          	pxor   xmm0,xmm0
   1855df028:	f3 0f 7f 85 30 0f 00 	movdqu XMMWORD PTR [rbp+0xf30],xmm0
   1855df02f:	00
   1855df030:	f3 0f 7f 85 20 0f 00 	movdqu XMMWORD PTR [rbp+0xf20],xmm0
   1855df037:	00
   1855df038:	f3 0f 7f 85 10 0f 00 	movdqu XMMWORD PTR [rbp+0xf10],xmm0
   1855df03f:	00
   1855df040:	f3 0f 7f 85 00 0f 00 	movdqu XMMWORD PTR [rbp+0xf00],xmm0
   1855df047:	00
   1855df048:	f3 0f 7f 85 f0 0e 00 	movdqu XMMWORD PTR [rbp+0xef0],xmm0
   1855df04f:	00
   1855df050:	f3 0f 7f 85 e0 0e 00 	movdqu XMMWORD PTR [rbp+0xee0],xmm0
   1855df057:	00
   1855df058:	f3 0f 7f 85 d0 0e 00 	movdqu XMMWORD PTR [rbp+0xed0],xmm0
   1855df05f:	00
   1855df060:	48 8d 85 20 0d 00 00 	lea    rax,[rbp+0xd20]
   1855df067:	48 89 85 c0 0e 00 00 	mov    QWORD PTR [rbp+0xec0],rax
   1855df06e:	48 8d 85 70 0d 00 00 	lea    rax,[rbp+0xd70]
   1855df075:	48 89 85 c8 0e 00 00 	mov    QWORD PTR [rbp+0xec8],rax
   1855df07c:	48 8d 15 95 72 42 04 	lea    rdx,[rip+0x4427295]        # 0x189a06318
   1855df083:	48 8d 8d 70 06 00 00 	lea    rcx,[rbp+0x670]
   1855df08a:	4c 8d 85 c0 0e 00 00 	lea    r8,[rbp+0xec0]
   1855df091:	e8 7a e7 a8 fa       	call   0x18006d810
   1855df096:	90                   	nop
   1855df097:	48 8d 8d 70 06 00 00 	lea    rcx,[rbp+0x670]
   1855df09e:	e8 cd e2 a8 fa       	call   0x18006d370
   1855df0a3:	48 8d 8d f0 0c 00 00 	lea    rcx,[rbp+0xcf0]
   1855df0aa:	e8 61 2f a2 fa       	call   0x180002010
   1855df0af:	48 8b 85 60 0f 00 00 	mov    rax,QWORD PTR [rbp+0xf60]
   1855df0b6:	48 89 85 10 01 00 00 	mov    QWORD PTR [rbp+0x110],rax
   1855df0bd:	66 0f 6f 85 40 0f 00 	movdqa xmm0,XMMWORD PTR [rbp+0xf40]
   1855df0c4:	00
   1855df0c5:	66 0f 6f 8d 50 0f 00 	movdqa xmm1,XMMWORD PTR [rbp+0xf50]
   1855df0cc:	00
   1855df0cd:	66 0f 7f 8d 00 01 00 	movdqa XMMWORD PTR [rbp+0x100],xmm1
   1855df0d4:	00
   1855df0d5:	66 0f 7f 85 f0 00 00 	movdqa XMMWORD PTR [rbp+0xf0],xmm0
   1855df0dc:	00
   1855df0dd:	c6 85 38 01 00 00 00 	mov    BYTE PTR [rbp+0x138],0x0
   1855df0e4:	80 bd 88 0f 00 00 01 	cmp    BYTE PTR [rbp+0xf88],0x1
   1855df0eb:	75 44                	jne    0x1855df131
   1855df0ed:	f3 0f 6f 85 68 0f 00 	movdqu xmm0,XMMWORD PTR [rbp+0xf68]
   1855df0f4:	00
   1855df0f5:	f3 0f 6f 8d 78 0f 00 	movdqu xmm1,XMMWORD PTR [rbp+0xf78]
   1855df0fc:	00
   1855df0fd:	f3 0f 7f 8d 28 01 00 	movdqu XMMWORD PTR [rbp+0x128],xmm1
   1855df104:	00
   1855df105:	f3 0f 7f 85 18 01 00 	movdqu XMMWORD PTR [rbp+0x118],xmm0
   1855df10c:	00
   1855df10d:	48 c7 85 78 0f 00 00 	mov    QWORD PTR [rbp+0xf78],0x0
   1855df114:	00 00 00 00
   1855df118:	48 c7 85 80 0f 00 00 	mov    QWORD PTR [rbp+0xf80],0xf
   1855df11f:	0f 00 00 00
   1855df123:	c6 85 68 0f 00 00 00 	mov    BYTE PTR [rbp+0xf68],0x0
   1855df12a:	c6 85 38 01 00 00 01 	mov    BYTE PTR [rbp+0x138],0x1
   1855df131:	48 8d 95 f0 00 00 00 	lea    rdx,[rbp+0xf0]
   1855df138:	4c 89 f1             	mov    rcx,r14
   1855df13b:	e8 f0 36 00 00       	call   0x1855e2830
   1855df140:	90                   	nop
   1855df141:	48 8d 8d 90 0f 00 00 	lea    rcx,[rbp+0xf90]
   1855df148:	e8 b3 c9 19 fb       	call   0x18077bb00
   1855df14d:	48 8d 8d 40 0f 00 00 	lea    rcx,[rbp+0xf40]
   1855df154:	e8 f7 2d ff ff       	call   0x1855d1f50
   1855df159:	48 8b b5 70 0e 00 00 	mov    rsi,QWORD PTR [rbp+0xe70]
   1855df160:	48 85 f6             	test   rsi,rsi
   1855df163:	48 8b bd 00 10 00 00 	mov    rdi,QWORD PTR [rbp+0x1000]
   1855df16a:	74 1d                	je     0x1855df189
   1855df16c:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855df170:	75 17                	jne    0x1855df189
   1855df172:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855df175:	48 89 f1             	mov    rcx,rsi
   1855df178:	ff 10                	call   QWORD PTR [rax]
   1855df17a:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855df17e:	75 09                	jne    0x1855df189
   1855df180:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855df183:	48 89 f1             	mov    rcx,rsi
   1855df186:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855df189:	48 8b 85 60 0e 00 00 	mov    rax,QWORD PTR [rbp+0xe60]
   1855df190:	48 83 f8 10          	cmp    rax,0x10
   1855df194:	72 38                	jb     0x1855df1ce
   1855df196:	48 8b 8d 48 0e 00 00 	mov    rcx,QWORD PTR [rbp+0xe48]
   1855df19d:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855df1a1:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855df1a8:	72 1f                	jb     0x1855df1c9
   1855df1aa:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855df1ae:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855df1b2:	4c 29 c1             	sub    rcx,r8
   1855df1b5:	48 83 f9 20          	cmp    rcx,0x20
   1855df1b9:	0f 83 ee 05 00 00    	jae    0x1855df7ad
   1855df1bf:	48 83 c0 28          	add    rax,0x28
   1855df1c3:	48 89 c2             	mov    rdx,rax
   1855df1c6:	4c 89 c1             	mov    rcx,r8
   1855df1c9:	e8 52 cb f6 01       	call   0x18754bd20
   1855df1ce:	48 8b b5 18 0d 00 00 	mov    rsi,QWORD PTR [rbp+0xd18]
   1855df1d5:	48 85 f6             	test   rsi,rsi
   1855df1d8:	74 1d                	je     0x1855df1f7
   1855df1da:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855df1de:	75 17                	jne    0x1855df1f7
   1855df1e0:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855df1e3:	48 89 f1             	mov    rcx,rsi
   1855df1e6:	ff 10                	call   QWORD PTR [rax]
   1855df1e8:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855df1ec:	75 09                	jne    0x1855df1f7
   1855df1ee:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855df1f1:	48 89 f1             	mov    rcx,rsi
   1855df1f4:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855df1f7:	48 8b b5 f8 0f 00 00 	mov    rsi,QWORD PTR [rbp+0xff8]
   1855df1fe:	48 85 f6             	test   rsi,rsi
   1855df201:	74 1d                	je     0x1855df220
   1855df203:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855df207:	75 17                	jne    0x1855df220
   1855df209:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855df20c:	48 89 f1             	mov    rcx,rsi
   1855df20f:	ff 10                	call   QWORD PTR [rax]
   1855df211:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855df215:	75 09                	jne    0x1855df220
   1855df217:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855df21a:	48 89 f1             	mov    rcx,rsi
   1855df21d:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855df220:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855df227:	e8 c4 72 bd fa       	call   0x1801b64f0
   1855df22c:	48 8d 8d 60 09 00 00 	lea    rcx,[rbp+0x960]
   1855df233:	e8 a8 b4 d9 ff       	call   0x18537a6e0
   1855df238:	48 8b 85 38 0e 00 00 	mov    rax,QWORD PTR [rbp+0xe38]
   1855df23f:	48 83 f8 10          	cmp    rax,0x10
   1855df243:	72 38                	jb     0x1855df27d
   1855df245:	48 8b 8d 20 0e 00 00 	mov    rcx,QWORD PTR [rbp+0xe20]
   1855df24c:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855df250:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855df257:	72 1f                	jb     0x1855df278
   1855df259:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855df25d:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855df261:	4c 29 c1             	sub    rcx,r8
   1855df264:	48 83 f9 20          	cmp    rcx,0x20
   1855df268:	0f 83 3f 05 00 00    	jae    0x1855df7ad
   1855df26e:	48 83 c0 28          	add    rax,0x28
   1855df272:	48 89 c2             	mov    rdx,rax
   1855df275:	4c 89 c1             	mov    rcx,r8
   1855df278:	e8 a3 ca f6 01       	call   0x18754bd20
   1855df27d:	48 8b b5 10 0e 00 00 	mov    rsi,QWORD PTR [rbp+0xe10]
   1855df284:	48 85 f6             	test   rsi,rsi
   1855df287:	74 1d                	je     0x1855df2a6
   1855df289:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855df28d:	75 17                	jne    0x1855df2a6
   1855df28f:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855df292:	48 89 f1             	mov    rcx,rsi
   1855df295:	ff 10                	call   QWORD PTR [rax]
   1855df297:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855df29b:	75 09                	jne    0x1855df2a6
   1855df29d:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855df2a0:	48 89 f1             	mov    rcx,rsi
   1855df2a3:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855df2a6:	48 8b 85 00 0e 00 00 	mov    rax,QWORD PTR [rbp+0xe00]
   1855df2ad:	48 83 f8 10          	cmp    rax,0x10
   1855df2b1:	72 38                	jb     0x1855df2eb
   1855df2b3:	48 8b 8d e8 0d 00 00 	mov    rcx,QWORD PTR [rbp+0xde8]
   1855df2ba:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855df2be:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855df2c5:	72 1f                	jb     0x1855df2e6
   1855df2c7:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855df2cb:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855df2cf:	4c 29 c1             	sub    rcx,r8
   1855df2d2:	48 83 f9 20          	cmp    rcx,0x20
   1855df2d6:	0f 83 d1 04 00 00    	jae    0x1855df7ad
   1855df2dc:	48 83 c0 28          	add    rax,0x28
   1855df2e0:	48 89 c2             	mov    rdx,rax
   1855df2e3:	4c 89 c1             	mov    rcx,r8
   1855df2e6:	e8 35 ca f6 01       	call   0x18754bd20
   1855df2eb:	48 8d 8d 80 0e 00 00 	lea    rcx,[rbp+0xe80]
   1855df2f2:	e8 29 47 3d 01       	call   0x1869b3a20
   1855df2f7:	48 85 ff             	test   rdi,rdi
   1855df2fa:	0f 84 02 ea ff ff    	je     0x1855ddd02
   1855df300:	48 8b 85 a8 0c 00 00 	mov    rax,QWORD PTR [rbp+0xca8]
   1855df307:	f0 ff 08             	lock dec DWORD PTR [rax]
   1855df30a:	0f 85 f2 e9 ff ff    	jne    0x1855ddd02
   1855df310:	48 89 fe             	mov    rsi,rdi
   1855df313:	48 83 c6 0c          	add    rsi,0xc
   1855df317:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855df31a:	48 89 f9             	mov    rcx,rdi
   1855df31d:	ff 10                	call   QWORD PTR [rax]
   1855df31f:	f0 ff 0e             	lock dec DWORD PTR [rsi]
   1855df322:	0f 85 da e9 ff ff    	jne    0x1855ddd02
   1855df328:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855df32b:	48 89 f9             	mov    rcx,rdi
   1855df32e:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855df331:	e9 cc e9 ff ff       	jmp    0x1855ddd02
   1855df336:	48 8b 85 90 0f 00 00 	mov    rax,QWORD PTR [rbp+0xf90]
   1855df33d:	48 89 85 40 0e 00 00 	mov    QWORD PTR [rbp+0xe40],rax
   1855df344:	48 8d 8d 40 0e 00 00 	lea    rcx,[rbp+0xe40]
   1855df34b:	e8 40 36 c4 fa       	call   0x180222990
   1855df350:	90                   	nop
   1855df351:	84 c0                	test   al,al
   1855df353:	0f 85 07 04 00 00    	jne    0x1855df760
   1855df359:	0f 29 b5 70 09 00 00 	movaps XMMWORD PTR [rbp+0x970],xmm6
   1855df360:	0f 29 b5 60 09 00 00 	movaps XMMWORD PTR [rbp+0x960],xmm6
   1855df367:	4c 8d 05 fe df a9 03 	lea    r8,[rip+0x3a9dffe]        # 0x18907d36c
   1855df36e:	48 8d 8d 40 0e 00 00 	lea    rcx,[rbp+0xe40]
   1855df375:	48 8d 95 88 0c 00 00 	lea    rdx,[rbp+0xc88]
   1855df37c:	e8 1f 8a 08 fb       	call   0x180667da0
   1855df381:	90                   	nop
   1855df382:	48 8b 95 88 0c 00 00 	mov    rdx,QWORD PTR [rbp+0xc88]
   1855df389:	48 8d 8d 60 09 00 00 	lea    rcx,[rbp+0x960]
   1855df390:	e8 1b 25 9e fb       	call   0x180fc18b0
   1855df395:	90                   	nop
   1855df396:	48 83 bd 70 09 00 00 	cmp    QWORD PTR [rbp+0x970],0x0
   1855df39d:	00
   1855df39e:	74 14                	je     0x1855df3b4
   1855df3a0:	48 8b 8d 80 0e 00 00 	mov    rcx,QWORD PTR [rbp+0xe80]
   1855df3a7:	48 8d 95 60 09 00 00 	lea    rdx,[rbp+0x960]
   1855df3ae:	e8 2d 9d 26 fc       	call   0x1818490e0
   1855df3b3:	90                   	nop
   1855df3b4:	0f 29 b5 a0 0f 00 00 	movaps XMMWORD PTR [rbp+0xfa0],xmm6
   1855df3bb:	0f 29 b5 90 0f 00 00 	movaps XMMWORD PTR [rbp+0xf90],xmm6
   1855df3c2:	4c 8d 05 17 ef 2f 04 	lea    r8,[rip+0x42fef17]        # 0x1898de2e0
   1855df3c9:	48 8d 8d 40 0e 00 00 	lea    rcx,[rbp+0xe40]
   1855df3d0:	48 8d 95 90 0c 00 00 	lea    rdx,[rbp+0xc90]
   1855df3d7:	e8 c4 89 08 fb       	call   0x180667da0
   1855df3dc:	90                   	nop
   1855df3dd:	48 8b 95 90 0c 00 00 	mov    rdx,QWORD PTR [rbp+0xc90]
   1855df3e4:	48 8d 8d 90 0f 00 00 	lea    rcx,[rbp+0xf90]
   1855df3eb:	e8 c0 24 9e fb       	call   0x180fc18b0
   1855df3f0:	90                   	nop
   1855df3f1:	48 83 bd a0 0f 00 00 	cmp    QWORD PTR [rbp+0xfa0],0x0
   1855df3f8:	00
   1855df3f9:	74 14                	je     0x1855df40f
   1855df3fb:	48 8b 8d 80 0e 00 00 	mov    rcx,QWORD PTR [rbp+0xe80]
   1855df402:	48 8d 95 90 0f 00 00 	lea    rdx,[rbp+0xf90]
   1855df409:	e8 b2 45 00 00       	call   0x1855e39c0
   1855df40e:	90                   	nop
   1855df40f:	0f 29 b5 50 0f 00 00 	movaps XMMWORD PTR [rbp+0xf50],xmm6
   1855df416:	0f 29 b5 40 0f 00 00 	movaps XMMWORD PTR [rbp+0xf40],xmm6
   1855df41d:	4c 8d 05 b0 44 a1 03 	lea    r8,[rip+0x3a144b0]        # 0x188ff38d4
   1855df424:	48 8d 8d 40 0e 00 00 	lea    rcx,[rbp+0xe40]
   1855df42b:	48 8d 95 98 0c 00 00 	lea    rdx,[rbp+0xc98]
   1855df432:	e8 69 89 08 fb       	call   0x180667da0
   1855df437:	90                   	nop
   1855df438:	48 8b 95 98 0c 00 00 	mov    rdx,QWORD PTR [rbp+0xc98]
   1855df43f:	48 8d 8d 40 0f 00 00 	lea    rcx,[rbp+0xf40]
   1855df446:	e8 65 24 9e fb       	call   0x180fc18b0
   1855df44b:	90                   	nop
   1855df44c:	0f 29 b5 80 0d 00 00 	movaps XMMWORD PTR [rbp+0xd80],xmm6
   1855df453:	0f 29 b5 70 0d 00 00 	movaps XMMWORD PTR [rbp+0xd70],xmm6
   1855df45a:	4c 8d 05 47 d6 2f 04 	lea    r8,[rip+0x42fd647]        # 0x1898dcaa8
   1855df461:	48 8d 8d 40 0e 00 00 	lea    rcx,[rbp+0xe40]
   1855df468:	48 8d 95 a0 0c 00 00 	lea    rdx,[rbp+0xca0]
   1855df46f:	e8 2c 89 08 fb       	call   0x180667da0
   1855df474:	90                   	nop
   1855df475:	48 8b 95 a0 0c 00 00 	mov    rdx,QWORD PTR [rbp+0xca0]
   1855df47c:	48 8d 8d 70 0d 00 00 	lea    rcx,[rbp+0xd70]
   1855df483:	e8 28 24 9e fb       	call   0x180fc18b0
   1855df488:	90                   	nop
   1855df489:	48 83 bd 80 0d 00 00 	cmp    QWORD PTR [rbp+0xd80],0x0
   1855df490:	00
   1855df491:	0f 84 a5 00 00 00    	je     0x1855df53c
   1855df497:	0f 29 b5 e0 0d 00 00 	movaps XMMWORD PTR [rbp+0xde0],xmm6
   1855df49e:	48 8d 8d e0 0d 00 00 	lea    rcx,[rbp+0xde0]
   1855df4a5:	48 8d 95 70 0d 00 00 	lea    rdx,[rbp+0xd70]
   1855df4ac:	e8 df c8 07 fb       	call   0x18065bd90
   1855df4b1:	90                   	nop
   1855df4b2:	80 bd e0 0d 00 00 09 	cmp    BYTE PTR [rbp+0xde0],0x9
   1855df4b9:	74 68                	je     0x1855df523
   1855df4bb:	0f 29 b5 30 0d 00 00 	movaps XMMWORD PTR [rbp+0xd30],xmm6
   1855df4c2:	0f 29 b5 20 0d 00 00 	movaps XMMWORD PTR [rbp+0xd20],xmm6
   1855df4c9:	48 8d 15 25 77 93 03 	lea    rdx,[rip+0x3937725]        # 0x188f16bf5
   1855df4d0:	48 8d 4d 50          	lea    rcx,[rbp+0x50]
   1855df4d4:	e8 f7 95 aa fa       	call   0x180088ad0
   1855df4d9:	90                   	nop
   1855df4da:	4c 8d 05 1f 65 27 04 	lea    r8,[rip+0x427651f]        # 0x189855a00
   1855df4e1:	48 8d 8d 20 0d 00 00 	lea    rcx,[rbp+0xd20]
   1855df4e8:	48 8d 95 e0 0d 00 00 	lea    rdx,[rbp+0xde0]
   1855df4ef:	4c 8d 4d 50          	lea    r9,[rbp+0x50]
   1855df4f3:	e8 28 d0 07 fb       	call   0x18065c520
   1855df4f8:	90                   	nop
   1855df4f9:	48 83 bd 30 0d 00 00 	cmp    QWORD PTR [rbp+0xd30],0x0
   1855df500:	00
   1855df501:	74 14                	je     0x1855df517
   1855df503:	48 8b 8d 80 0e 00 00 	mov    rcx,QWORD PTR [rbp+0xe80]
   1855df50a:	48 8d 95 20 0d 00 00 	lea    rdx,[rbp+0xd20]
   1855df511:	e8 4a 86 d4 fc       	call   0x182327b60
   1855df516:	90                   	nop
   1855df517:	48 8d 8d 20 0d 00 00 	lea    rcx,[rbp+0xd20]
   1855df51e:	e8 ed 2a a2 fa       	call   0x180002010
   1855df523:	48 8d 8d e0 0d 00 00 	lea    rcx,[rbp+0xde0]
   1855df52a:	e8 f1 b7 a2 fa       	call   0x18000ad20
   1855df52f:	48 83 bd 80 0d 00 00 	cmp    QWORD PTR [rbp+0xd80],0x0
   1855df536:	00
   1855df537:	0f 94 c0             	sete   al
   1855df53a:	eb 02                	jmp    0x1855df53e
   1855df53c:	b0 01                	mov    al,0x1
   1855df53e:	48 83 bd 50 0f 00 00 	cmp    QWORD PTR [rbp+0xf50],0x0
   1855df545:	00
   1855df546:	75 08                	jne    0x1855df550
   1855df548:	84 c0                	test   al,al
   1855df54a:	0f 85 e0 01 00 00    	jne    0x1855df730
   1855df550:	0f 29 b5 20 0d 00 00 	movaps XMMWORD PTR [rbp+0xd20],xmm6
   1855df557:	48 8b 85 80 0e 00 00 	mov    rax,QWORD PTR [rbp+0xe80]
   1855df55e:	48 8b 88 50 06 00 00 	mov    rcx,QWORD PTR [rax+0x650]
   1855df565:	48 85 c9             	test   rcx,rcx
   1855df568:	74 0d                	je     0x1855df577
   1855df56a:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   1855df56e:	48 8b 88 50 06 00 00 	mov    rcx,QWORD PTR [rax+0x650]
   1855df575:	eb 02                	jmp    0x1855df579
   1855df577:	31 c9                	xor    ecx,ecx
   1855df579:	48 8b 80 48 06 00 00 	mov    rax,QWORD PTR [rax+0x648]
   1855df580:	48 89 85 20 0d 00 00 	mov    QWORD PTR [rbp+0xd20],rax
   1855df587:	48 89 8d 28 0d 00 00 	mov    QWORD PTR [rbp+0xd28],rcx
   1855df58e:	48 85 c0             	test   rax,rax
   1855df591:	0f 85 f0 00 00 00    	jne    0x1855df687
   1855df597:	b9 98 00 00 00       	mov    ecx,0x98
   1855df59c:	e8 3b c7 f6 01       	call   0x18754bcdc
   1855df5a1:	90                   	nop
   1855df5a2:	48 b9 01 00 00 00 01 	movabs rcx,0x100000001
   1855df5a9:	00 00 00
   1855df5ac:	48 89 48 08          	mov    QWORD PTR [rax+0x8],rcx
   1855df5b0:	48 8d 0d a1 c9 ac 03 	lea    rcx,[rip+0x3acc9a1]        # 0x1890abf58
   1855df5b7:	48 89 08             	mov    QWORD PTR [rax],rcx
   1855df5ba:	48 89 c1             	mov    rcx,rax
   1855df5bd:	48 83 c1 10          	add    rcx,0x10
   1855df5c1:	0f 57 ff             	xorps  xmm7,xmm7
   1855df5c4:	0f 11 78 50          	movups XMMWORD PTR [rax+0x50],xmm7
   1855df5c8:	0f 11 78 60          	movups XMMWORD PTR [rax+0x60],xmm7
   1855df5cc:	0f 11 78 70          	movups XMMWORD PTR [rax+0x70],xmm7
   1855df5d0:	0f 11 b8 80 00 00 00 	movups XMMWORD PTR [rax+0x80],xmm7
   1855df5d7:	0f 11 78 10          	movups XMMWORD PTR [rax+0x10],xmm7
   1855df5db:	0f 11 78 20          	movups XMMWORD PTR [rax+0x20],xmm7
   1855df5df:	0f 11 78 30          	movups XMMWORD PTR [rax+0x30],xmm7
   1855df5e3:	0f 11 78 40          	movups XMMWORD PTR [rax+0x40],xmm7
   1855df5e7:	48 c7 80 90 00 00 00 	mov    QWORD PTR [rax+0x90],0x0
   1855df5ee:	00 00 00 00
   1855df5f2:	48 c7 40 58 0f 00 00 	mov    QWORD PTR [rax+0x58],0xf
   1855df5f9:	00
   1855df5fa:	0f 11 78 68          	movups XMMWORD PTR [rax+0x68],xmm7
   1855df5fe:	48 c7 40 78 00 00 00 	mov    QWORD PTR [rax+0x78],0x0
   1855df605:	00
   1855df606:	48 c7 80 80 00 00 00 	mov    QWORD PTR [rax+0x80],0xf
   1855df60d:	0f 00 00 00
   1855df611:	48 89 8d e0 0d 00 00 	mov    QWORD PTR [rbp+0xde0],rcx
   1855df618:	48 89 85 e8 0d 00 00 	mov    QWORD PTR [rbp+0xde8],rax
   1855df61f:	48 8d 8d 20 0d 00 00 	lea    rcx,[rbp+0xd20]
   1855df626:	48 8d b5 e0 0d 00 00 	lea    rsi,[rbp+0xde0]
   1855df62d:	48 89 f2             	mov    rdx,rsi
   1855df630:	e8 eb 52 4a fb       	call   0x180a84920
   1855df635:	48 89 f1             	mov    rcx,rsi
   1855df638:	e8 23 2a a2 fa       	call   0x180002060
   1855df63d:	48 8b 8d 80 0e 00 00 	mov    rcx,QWORD PTR [rbp+0xe80]
   1855df644:	0f 29 bd e0 0c 00 00 	movaps XMMWORD PTR [rbp+0xce0],xmm7
   1855df64b:	48 8b 85 28 0d 00 00 	mov    rax,QWORD PTR [rbp+0xd28]
   1855df652:	48 85 c0             	test   rax,rax
   1855df655:	74 0d                	je     0x1855df664
   1855df657:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1855df65b:	48 8b 85 28 0d 00 00 	mov    rax,QWORD PTR [rbp+0xd28]
   1855df662:	eb 02                	jmp    0x1855df666
   1855df664:	31 c0                	xor    eax,eax
   1855df666:	48 8b 95 20 0d 00 00 	mov    rdx,QWORD PTR [rbp+0xd20]
   1855df66d:	48 89 95 e0 0c 00 00 	mov    QWORD PTR [rbp+0xce0],rdx
   1855df674:	48 89 85 e8 0c 00 00 	mov    QWORD PTR [rbp+0xce8],rax
   1855df67b:	48 8d 95 e0 0c 00 00 	lea    rdx,[rbp+0xce0]
   1855df682:	e8 a9 43 00 00       	call   0x1855e3a30
   1855df687:	48 83 bd 50 0f 00 00 	cmp    QWORD PTR [rbp+0xf50],0x0
   1855df68e:	00
   1855df68f:	74 14                	je     0x1855df6a5
   1855df691:	48 8b 8d 20 0d 00 00 	mov    rcx,QWORD PTR [rbp+0xd20]
   1855df698:	48 8d 95 40 0f 00 00 	lea    rdx,[rbp+0xf40]
   1855df69f:	e8 2c b7 4f fb       	call   0x180adadd0
   1855df6a4:	90                   	nop
   1855df6a5:	48 83 bd 80 0d 00 00 	cmp    QWORD PTR [rbp+0xd80],0x0
   1855df6ac:	00
   1855df6ad:	74 56                	je     0x1855df705
   1855df6af:	0f 29 b5 e0 0d 00 00 	movaps XMMWORD PTR [rbp+0xde0],xmm6
   1855df6b6:	48 8d 8d e0 0d 00 00 	lea    rcx,[rbp+0xde0]
   1855df6bd:	48 8d 95 70 0d 00 00 	lea    rdx,[rbp+0xd70]
   1855df6c4:	e8 c7 c6 07 fb       	call   0x18065bd90
   1855df6c9:	90                   	nop
   1855df6ca:	80 bd e0 0d 00 00 09 	cmp    BYTE PTR [rbp+0xde0],0x9
   1855df6d1:	74 26                	je     0x1855df6f9
   1855df6d3:	48 8d 15 ae 43 42 04 	lea    rdx,[rip+0x44243ae]        # 0x189a03a88
   1855df6da:	48 8d 8d e0 0d 00 00 	lea    rcx,[rbp+0xde0]
   1855df6e1:	45 31 c0             	xor    r8d,r8d
   1855df6e4:	e8 d7 cc 07 fb       	call   0x18065c3c0
   1855df6e9:	90                   	nop
   1855df6ea:	48 85 c0             	test   rax,rax
   1855df6ed:	7e 0a                	jle    0x1855df6f9
   1855df6ef:	48 8b 8d 20 0d 00 00 	mov    rcx,QWORD PTR [rbp+0xd20]
   1855df6f6:	48 89 01             	mov    QWORD PTR [rcx],rax
   1855df6f9:	48 8d 8d e0 0d 00 00 	lea    rcx,[rbp+0xde0]
   1855df700:	e8 1b b6 a2 fa       	call   0x18000ad20
   1855df705:	48 8b 85 20 0d 00 00 	mov    rax,QWORD PTR [rbp+0xd20]
   1855df70c:	48 b9 01 00 00 00 a0 	movabs rcx,0xa000000001
   1855df713:	00 00 00
   1855df716:	48 89 48 78          	mov    QWORD PTR [rax+0x78],rcx
   1855df71a:	c7 80 80 00 00 00 a0 	mov    DWORD PTR [rax+0x80],0xa0
   1855df721:	00 00 00
   1855df724:	48 8d 8d 20 0d 00 00 	lea    rcx,[rbp+0xd20]
   1855df72b:	e8 30 29 a2 fa       	call   0x180002060
   1855df730:	48 8d 8d 70 0d 00 00 	lea    rcx,[rbp+0xd70]
   1855df737:	e8 d4 28 a2 fa       	call   0x180002010
   1855df73c:	48 8d 8d 40 0f 00 00 	lea    rcx,[rbp+0xf40]
   1855df743:	e8 c8 28 a2 fa       	call   0x180002010
   1855df748:	48 8d 8d 90 0f 00 00 	lea    rcx,[rbp+0xf90]
   1855df74f:	e8 bc 28 a2 fa       	call   0x180002010
   1855df754:	48 8d 8d 60 09 00 00 	lea    rcx,[rbp+0x960]
   1855df75b:	e8 b0 28 a2 fa       	call   0x180002010
   1855df760:	4c 8b bd 88 0e 00 00 	mov    r15,QWORD PTR [rbp+0xe88]
   1855df767:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855df76e:	e8 dd d0 08 fb       	call   0x18066c850
   1855df773:	4d 85 ff             	test   r15,r15
   1855df776:	74 1f                	je     0x1855df797
   1855df778:	f0 41 ff 4f 08       	lock dec DWORD PTR [r15+0x8]
   1855df77d:	75 18                	jne    0x1855df797
   1855df77f:	49 8b 07             	mov    rax,QWORD PTR [r15]
   1855df782:	4c 89 f9             	mov    rcx,r15
   1855df785:	ff 10                	call   QWORD PTR [rax]
   1855df787:	f0 41 ff 4f 0c       	lock dec DWORD PTR [r15+0xc]
   1855df78c:	75 09                	jne    0x1855df797
   1855df78e:	49 8b 07             	mov    rax,QWORD PTR [r15]
   1855df791:	4c 89 f9             	mov    rcx,r15
   1855df794:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855df797:	48 8b 85 d8 0e 00 00 	mov    rax,QWORD PTR [rbp+0xed8]
   1855df79e:	48 83 f8 10          	cmp    rax,0x10
   1855df7a2:	0f 83 7a bf ff ff    	jae    0x1855db722
   1855df7a8:	e9 ad bf ff ff       	jmp    0x1855db75a
   1855df7ad:	e8 da e9 0f 02       	call   0x1876de18c
   1855df7b2:	90                   	nop
   1855df7b3:	e8 d8 93 a2 fa       	call   0x180008b90
   1855df7b8:	90                   	nop
   1855df7b9:	48 89 95 c8 0d 00 00 	mov    QWORD PTR [rbp+0xdc8],rdx
   1855df7c0:	e8 cb 93 a2 fa       	call   0x180008b90
   1855df7c5:	90                   	nop
   1855df7c6:	e8 c5 93 a2 fa       	call   0x180008b90
   1855df7cb:	90                   	nop
   1855df7cc:	66 0f 7f 8d d0 0d 00 	movdqa XMMWORD PTR [rbp+0xdd0],xmm1
   1855df7d3:	00
   1855df7d4:	48 89 9d 08 10 00 00 	mov    QWORD PTR [rbp+0x1008],rbx
   1855df7db:	e8 b0 93 a2 fa       	call   0x180008b90
   1855df7e0:	90                   	nop
   1855df7e1:	e8 aa 93 a2 fa       	call   0x180008b90
   1855df7e6:	90                   	nop
   1855df7e7:	e8 a4 93 a2 fa       	call   0x180008b90
   1855df7ec:	90                   	nop
   1855df7ed:	e8 9e 93 a2 fa       	call   0x180008b90
   1855df7f2:	90                   	nop
   1855df7f3:	e8 98 93 a2 fa       	call   0x180008b90
   1855df7f8:	90                   	nop
   1855df7f9:	e8 92 93 a2 fa       	call   0x180008b90
   1855df7fe:	90                   	nop
   1855df7ff:	cc                   	int3
