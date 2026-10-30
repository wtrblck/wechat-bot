
E:/Tencent/Weixin/4.1.15.56/Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001855e4060 <.text+0x55e3060>:
   1855e4060:	55                   	push   rbp
   1855e4061:	41 57                	push   r15
   1855e4063:	41 56                	push   r14
   1855e4065:	41 54                	push   r12
   1855e4067:	56                   	push   rsi
   1855e4068:	57                   	push   rdi
   1855e4069:	53                   	push   rbx
   1855e406a:	48 81 ec e0 05 00 00 	sub    rsp,0x5e0
   1855e4071:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   1855e4078:	00
   1855e4079:	0f 29 b5 50 05 00 00 	movaps XMMWORD PTR [rbp+0x550],xmm6
   1855e4080:	48 c7 85 48 05 00 00 	mov    QWORD PTR [rbp+0x548],0xfffffffffffffffe
   1855e4087:	fe ff ff ff
   1855e408b:	48 89 ce             	mov    rsi,rcx
   1855e408e:	48 bf aa aa aa aa aa 	movabs rdi,0xaaaaaaaaaaaaaaaa
   1855e4095:	aa aa aa
   1855e4098:	48 89 bd 70 04 00 00 	mov    QWORD PTR [rbp+0x470],rdi
   1855e409f:	0f 28 35 0a 2b 93 03 	movaps xmm6,XMMWORD PTR [rip+0x3932b0a]        # 0x188f16bb0
   1855e40a6:	0f 29 b5 60 04 00 00 	movaps XMMWORD PTR [rbp+0x460],xmm6
   1855e40ad:	0f 29 b5 50 04 00 00 	movaps XMMWORD PTR [rbp+0x450],xmm6
   1855e40b4:	0f 29 b5 40 04 00 00 	movaps XMMWORD PTR [rbp+0x440],xmm6
   1855e40bb:	48 8b 49 70          	mov    rcx,QWORD PTR [rcx+0x70]
   1855e40bf:	0f 57 c0             	xorps  xmm0,xmm0
   1855e40c2:	0f 29 85 80 04 00 00 	movaps XMMWORD PTR [rbp+0x480],xmm0
   1855e40c9:	48 8b 46 40          	mov    rax,QWORD PTR [rsi+0x40]
   1855e40cd:	48 85 c0             	test   rax,rax
   1855e40d0:	74 0a                	je     0x1855e40dc
   1855e40d2:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1855e40d6:	48 8b 46 40          	mov    rax,QWORD PTR [rsi+0x40]
   1855e40da:	eb 02                	jmp    0x1855e40de
   1855e40dc:	31 c0                	xor    eax,eax
   1855e40de:	48 8b 56 38          	mov    rdx,QWORD PTR [rsi+0x38]
   1855e40e2:	48 89 95 80 04 00 00 	mov    QWORD PTR [rbp+0x480],rdx
   1855e40e9:	48 89 85 88 04 00 00 	mov    QWORD PTR [rbp+0x488],rax
   1855e40f0:	48 8d 95 40 04 00 00 	lea    rdx,[rbp+0x440]
   1855e40f7:	4c 8d 85 80 04 00 00 	lea    r8,[rbp+0x480]
   1855e40fe:	e8 5d fa 1b fc       	call   0x1817a3b60
   1855e4103:	8b 85 44 04 00 00    	mov    eax,DWORD PTR [rbp+0x444]
   1855e4109:	0b 85 40 04 00 00    	or     eax,DWORD PTR [rbp+0x440]
   1855e410f:	0f 84 b8 00 00 00    	je     0x1855e41cd
   1855e4115:	b9 04 00 00 00       	mov    ecx,0x4
   1855e411a:	e8 c1 8c a8 fa       	call   0x18006cde0
   1855e411f:	85 c0                	test   eax,eax
   1855e4121:	0f 84 71 06 00 00    	je     0x1855e4798
   1855e4127:	48 8d bd 70 03 00 00 	lea    rdi,[rbp+0x370]
   1855e412e:	48 89 f9             	mov    rcx,rdi
   1855e4131:	e8 da 8d a8 fa       	call   0x18006cf10
   1855e4136:	90                   	nop
   1855e4137:	48 83 bd 88 03 00 00 	cmp    QWORD PTR [rbp+0x388],0x10
   1855e413e:	10
   1855e413f:	72 07                	jb     0x1855e4148
   1855e4141:	48 8b bd 70 03 00 00 	mov    rdi,QWORD PTR [rbp+0x370]
   1855e4148:	48 8d 05 b1 26 42 04 	lea    rax,[rip+0x44226b1]        # 0x189a06800
   1855e414f:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855e4154:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855e415b:	00 00
   1855e415d:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855e4162:	c7 44 24 28 86 01 00 	mov    DWORD PTR [rsp+0x28],0x186
   1855e4169:	00
   1855e416a:	4c 8d 0d 4f 11 42 04 	lea    r9,[rip+0x442114f]        # 0x189a052c0
   1855e4171:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855e4175:	ba 04 00 00 00       	mov    edx,0x4
   1855e417a:	49 89 f8             	mov    r8,rdi
   1855e417d:	e8 ee 90 a8 fa       	call   0x18006d270
   1855e4182:	90                   	nop
   1855e4183:	48 8d 8d 40 04 00 00 	lea    rcx,[rbp+0x440]
   1855e418a:	48 8d bd 00 03 00 00 	lea    rdi,[rbp+0x300]
   1855e4191:	48 89 fa             	mov    rdx,rdi
   1855e4194:	e8 c7 ca b2 fa       	call   0x180110c60
   1855e4199:	90                   	nop
   1855e419a:	48 83 bd 18 03 00 00 	cmp    QWORD PTR [rbp+0x318],0x10
   1855e41a1:	10
   1855e41a2:	72 07                	jb     0x1855e41ab
   1855e41a4:	48 8b bd 00 03 00 00 	mov    rdi,QWORD PTR [rbp+0x300]
   1855e41ab:	48 89 bd 90 04 00 00 	mov    QWORD PTR [rbp+0x490],rdi
   1855e41b2:	c6 85 98 04 00 00 00 	mov    BYTE PTR [rbp+0x498],0x0
   1855e41b9:	48 83 7e 30 10       	cmp    QWORD PTR [rsi+0x30],0x10
   1855e41be:	0f 82 c7 04 00 00    	jb     0x1855e468b
   1855e41c4:	48 8b 46 18          	mov    rax,QWORD PTR [rsi+0x18]
   1855e41c8:	e9 c2 04 00 00       	jmp    0x1855e468f
   1855e41cd:	0f 29 b5 00 05 00 00 	movaps XMMWORD PTR [rbp+0x500],xmm6
   1855e41d4:	0f 29 b5 10 05 00 00 	movaps XMMWORD PTR [rbp+0x510],xmm6
   1855e41db:	0f 29 b5 30 05 00 00 	movaps XMMWORD PTR [rbp+0x530],xmm6
   1855e41e2:	0f 29 b5 f0 04 00 00 	movaps XMMWORD PTR [rbp+0x4f0],xmm6
   1855e41e9:	0f 29 b5 20 05 00 00 	movaps XMMWORD PTR [rbp+0x520],xmm6
   1855e41f0:	c6 85 00 05 00 00 00 	mov    BYTE PTR [rbp+0x500],0x0
   1855e41f7:	c6 85 10 05 00 00 00 	mov    BYTE PTR [rbp+0x510],0x0
   1855e41fe:	c6 85 38 05 00 00 00 	mov    BYTE PTR [rbp+0x538],0x0
   1855e4205:	c6 85 f0 04 00 00 01 	mov    BYTE PTR [rbp+0x4f0],0x1
   1855e420c:	48 89 bd e0 04 00 00 	mov    QWORD PTR [rbp+0x4e0],rdi
   1855e4213:	0f 29 b5 d0 04 00 00 	movaps XMMWORD PTR [rbp+0x4d0],xmm6
   1855e421a:	0f 29 b5 c0 04 00 00 	movaps XMMWORD PTR [rbp+0x4c0],xmm6
   1855e4221:	0f 29 b5 b0 04 00 00 	movaps XMMWORD PTR [rbp+0x4b0],xmm6
   1855e4228:	0f 29 b5 a0 04 00 00 	movaps XMMWORD PTR [rbp+0x4a0],xmm6
   1855e422f:	0f 29 b5 90 04 00 00 	movaps XMMWORD PTR [rbp+0x490],xmm6
   1855e4236:	48 8b 95 68 04 00 00 	mov    rdx,QWORD PTR [rbp+0x468]
   1855e423d:	c6 85 e0 04 00 00 00 	mov    BYTE PTR [rbp+0x4e0],0x0
   1855e4244:	80 7a 50 01          	cmp    BYTE PTR [rdx+0x50],0x1
   1855e4248:	0f 85 84 00 00 00    	jne    0x1855e42d2
   1855e424e:	48 8d 8d 90 04 00 00 	lea    rcx,[rbp+0x490]
   1855e4255:	e8 76 95 19 fb       	call   0x18077d7d0
   1855e425a:	90                   	nop
   1855e425b:	c6 85 e0 04 00 00 01 	mov    BYTE PTR [rbp+0x4e0],0x1
   1855e4262:	8b 9d b0 04 00 00    	mov    ebx,DWORD PTR [rbp+0x4b0]
   1855e4268:	48 89 9d 08 05 00 00 	mov    QWORD PTR [rbp+0x508],rbx
   1855e426f:	c6 85 10 05 00 00 01 	mov    BYTE PTR [rbp+0x510],0x1
   1855e4276:	48 8d 15 3b ef ab 03 	lea    rdx,[rip+0x3abef3b]        # 0x1890a31b8
   1855e427d:	48 8d 7d 10          	lea    rdi,[rbp+0x10]
   1855e4281:	41 b8 f0 02 00 00    	mov    r8d,0x2f0
   1855e4287:	48 89 f9             	mov    rcx,rdi
   1855e428a:	e8 b1 0b 13 02       	call   0x187714e40
   1855e428f:	48 8b 4e 70          	mov    rcx,QWORD PTR [rsi+0x70]
   1855e4293:	44 8b 8d b4 04 00 00 	mov    r9d,DWORD PTR [rbp+0x4b4]
   1855e429a:	4c 8d 46 48          	lea    r8,[rsi+0x48]
   1855e429e:	89 5c 24 20          	mov    DWORD PTR [rsp+0x20],ebx
   1855e42a2:	48 89 fa             	mov    rdx,rdi
   1855e42a5:	e8 e6 58 1d fc       	call   0x1817b9b90
   1855e42aa:	90                   	nop
   1855e42ab:	80 bd f8 02 00 00 01 	cmp    BYTE PTR [rbp+0x2f8],0x1
   1855e42b2:	75 1e                	jne    0x1855e42d2
   1855e42b4:	48 8b 85 58 01 00 00 	mov    rax,QWORD PTR [rbp+0x158]
   1855e42bb:	48 89 85 f8 04 00 00 	mov    QWORD PTR [rbp+0x4f8],rax
   1855e42c2:	c6 85 00 05 00 00 01 	mov    BYTE PTR [rbp+0x500],0x1
   1855e42c9:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855e42cd:	e8 6e 83 be fa       	call   0x1801cc640
   1855e42d2:	b9 02 00 00 00       	mov    ecx,0x2
   1855e42d7:	e8 04 8b a8 fa       	call   0x18006cde0
   1855e42dc:	85 c0                	test   eax,eax
   1855e42de:	0f 84 45 01 00 00    	je     0x1855e4429
   1855e42e4:	48 8d bd 50 03 00 00 	lea    rdi,[rbp+0x350]
   1855e42eb:	48 89 f9             	mov    rcx,rdi
   1855e42ee:	e8 1d 8c a8 fa       	call   0x18006cf10
   1855e42f3:	90                   	nop
   1855e42f4:	48 83 bd 68 03 00 00 	cmp    QWORD PTR [rbp+0x368],0x10
   1855e42fb:	10
   1855e42fc:	72 07                	jb     0x1855e4305
   1855e42fe:	48 8b bd 50 03 00 00 	mov    rdi,QWORD PTR [rbp+0x350]
   1855e4305:	48 8d 05 f4 24 42 04 	lea    rax,[rip+0x44224f4]        # 0x189a06800
   1855e430c:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855e4311:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855e4318:	00 00
   1855e431a:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855e431f:	c7 44 24 28 93 01 00 	mov    DWORD PTR [rsp+0x28],0x193
   1855e4326:	00
   1855e4327:	4c 8d 0d 92 0f 42 04 	lea    r9,[rip+0x4420f92]        # 0x189a052c0
   1855e432e:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855e4332:	ba 02 00 00 00       	mov    edx,0x2
   1855e4337:	49 89 f8             	mov    r8,rdi
   1855e433a:	e8 31 8f a8 fa       	call   0x18006d270
   1855e433f:	90                   	nop
   1855e4340:	8b 4e 68             	mov    ecx,DWORD PTR [rsi+0x68]
   1855e4343:	48 c7 85 70 03 00 00 	mov    QWORD PTR [rbp+0x370],0x0
   1855e434a:	00 00 00 00
   1855e434e:	b8 08 00 00 00       	mov    eax,0x8
   1855e4353:	48 8d 15 16 2f 93 03 	lea    rdx,[rip+0x3932f16]        # 0x188f17270
   1855e435a:	41 89 c8             	mov    r8d,ecx
   1855e435d:	0f 1f 00             	nop    DWORD PTR [rax]
   1855e4360:	4d 63 c8             	movsxd r9,r8d
   1855e4363:	4d 69 c1 67 66 66 66 	imul   r8,r9,0x66666667
   1855e436a:	4d 89 c2             	mov    r10,r8
   1855e436d:	49 c1 ea 3f          	shr    r10,0x3f
   1855e4371:	49 c1 f8 22          	sar    r8,0x22
   1855e4375:	45 01 d0             	add    r8d,r10d
   1855e4378:	47 8d 14 00          	lea    r10d,[r8+r8*1]
   1855e437c:	47 8d 14 92          	lea    r10d,[r10+r10*4]
   1855e4380:	41 f7 da             	neg    r10d
   1855e4383:	45 01 ca             	add    r10d,r9d
   1855e4386:	41 83 c2 23          	add    r10d,0x23
   1855e438a:	4d 63 d2             	movsxd r10,r10d
   1855e438d:	45 0f b6 14 12       	movzx  r10d,BYTE PTR [r10+rdx*1]
   1855e4392:	44 88 94 05 70 03 00 	mov    BYTE PTR [rbp+rax*1+0x370],r10b
   1855e4399:	00
   1855e439a:	48 ff c0             	inc    rax
   1855e439d:	41 83 c1 09          	add    r9d,0x9
   1855e43a1:	41 83 f9 12          	cmp    r9d,0x12
   1855e43a5:	77 b9                	ja     0x1855e4360
   1855e43a7:	85 c9                	test   ecx,ecx
   1855e43a9:	79 0b                	jns    0x1855e43b6
   1855e43ab:	c6 84 05 70 03 00 00 	mov    BYTE PTR [rbp+rax*1+0x370],0x2d
   1855e43b2:	2d
   1855e43b3:	48 ff c0             	inc    rax
   1855e43b6:	48 8d 8d 78 03 00 00 	lea    rcx,[rbp+0x378]
   1855e43bd:	c6 84 05 70 03 00 00 	mov    BYTE PTR [rbp+rax*1+0x370],0x0
   1855e43c4:	00
   1855e43c5:	48 83 f8 0a          	cmp    rax,0xa
   1855e43c9:	7c 31                	jl     0x1855e43fc
   1855e43cb:	48 01 e8             	add    rax,rbp
   1855e43ce:	48 05 70 03 00 00    	add    rax,0x370
   1855e43d4:	48 ff c8             	dec    rax
   1855e43d7:	48 8d 95 79 03 00 00 	lea    rdx,[rbp+0x379]
   1855e43de:	66 90                	xchg   ax,ax
   1855e43e0:	44 0f b6 00          	movzx  r8d,BYTE PTR [rax]
   1855e43e4:	44 0f b6 4a ff       	movzx  r9d,BYTE PTR [rdx-0x1]
   1855e43e9:	44 88 08             	mov    BYTE PTR [rax],r9b
   1855e43ec:	44 88 42 ff          	mov    BYTE PTR [rdx-0x1],r8b
   1855e43f0:	48 ff c8             	dec    rax
   1855e43f3:	48 39 c2             	cmp    rdx,rax
   1855e43f6:	48 8d 52 01          	lea    rdx,[rdx+0x1]
   1855e43fa:	72 e4                	jb     0x1855e43e0
   1855e43fc:	48 89 8d 70 03 00 00 	mov    QWORD PTR [rbp+0x370],rcx
   1855e4403:	48 83 7e 60 10       	cmp    QWORD PTR [rsi+0x60],0x10
   1855e4408:	72 4d                	jb     0x1855e4457
   1855e440a:	48 8b 46 48          	mov    rax,QWORD PTR [rsi+0x48]
   1855e440e:	48 89 85 00 03 00 00 	mov    QWORD PTR [rbp+0x300],rax
   1855e4415:	c6 85 08 03 00 00 00 	mov    BYTE PTR [rbp+0x308],0x0
   1855e441c:	48 83 7e 30 10       	cmp    QWORD PTR [rsi+0x30],0x10
   1855e4421:	73 4d                	jae    0x1855e4470
   1855e4423:	48 8d 46 18          	lea    rax,[rsi+0x18]
   1855e4427:	eb 4b                	jmp    0x1855e4474
   1855e4429:	48 8b 4e 08          	mov    rcx,QWORD PTR [rsi+0x8]
   1855e442d:	48 8b 85 10 05 00 00 	mov    rax,QWORD PTR [rbp+0x510]
   1855e4434:	48 89 45 30          	mov    QWORD PTR [rbp+0x30],rax
   1855e4438:	0f 28 85 f0 04 00 00 	movaps xmm0,XMMWORD PTR [rbp+0x4f0]
   1855e443f:	0f 28 8d 00 05 00 00 	movaps xmm1,XMMWORD PTR [rbp+0x500]
   1855e4446:	0f 29 4d 20          	movaps XMMWORD PTR [rbp+0x20],xmm1
   1855e444a:	0f 29 45 10          	movaps XMMWORD PTR [rbp+0x10],xmm0
   1855e444e:	c6 45 58 00          	mov    BYTE PTR [rbp+0x58],0x0
   1855e4452:	e9 5a 01 00 00       	jmp    0x1855e45b1
   1855e4457:	48 8d 46 48          	lea    rax,[rsi+0x48]
   1855e445b:	48 89 85 00 03 00 00 	mov    QWORD PTR [rbp+0x300],rax
   1855e4462:	c6 85 08 03 00 00 00 	mov    BYTE PTR [rbp+0x308],0x0
   1855e4469:	48 83 7e 30 10       	cmp    QWORD PTR [rsi+0x30],0x10
   1855e446e:	72 b3                	jb     0x1855e4423
   1855e4470:	48 8b 46 18          	mov    rax,QWORD PTR [rsi+0x18]
   1855e4474:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
   1855e4478:	c6 45 c8 00          	mov    BYTE PTR [rbp-0x38],0x0
   1855e447c:	0f 57 c0             	xorps  xmm0,xmm0
   1855e447f:	0f 11 85 28 04 00 00 	movups XMMWORD PTR [rbp+0x428],xmm0
   1855e4486:	0f 11 85 18 04 00 00 	movups XMMWORD PTR [rbp+0x418],xmm0
   1855e448d:	0f 11 85 08 04 00 00 	movups XMMWORD PTR [rbp+0x408],xmm0
   1855e4494:	0f 11 85 f8 03 00 00 	movups XMMWORD PTR [rbp+0x3f8],xmm0
   1855e449b:	0f 11 85 e8 03 00 00 	movups XMMWORD PTR [rbp+0x3e8],xmm0
   1855e44a2:	0f 11 85 d8 03 00 00 	movups XMMWORD PTR [rbp+0x3d8],xmm0
   1855e44a9:	48 c7 85 38 04 00 00 	mov    QWORD PTR [rbp+0x438],0x0
   1855e44b0:	00 00 00 00
   1855e44b4:	48 8d 45 c0          	lea    rax,[rbp-0x40]
   1855e44b8:	48 89 85 c0 03 00 00 	mov    QWORD PTR [rbp+0x3c0],rax
   1855e44bf:	48 8d 85 00 03 00 00 	lea    rax,[rbp+0x300]
   1855e44c6:	48 89 85 c8 03 00 00 	mov    QWORD PTR [rbp+0x3c8],rax
   1855e44cd:	48 8d 85 70 03 00 00 	lea    rax,[rbp+0x370]
   1855e44d4:	48 89 85 d0 03 00 00 	mov    QWORD PTR [rbp+0x3d0],rax
   1855e44db:	48 8d 15 56 16 42 04 	lea    rdx,[rip+0x4421656]        # 0x189a05b38
   1855e44e2:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855e44e6:	4c 8d 85 c0 03 00 00 	lea    r8,[rbp+0x3c0]
   1855e44ed:	e8 1e 93 a8 fa       	call   0x18006d810
   1855e44f2:	90                   	nop
   1855e44f3:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855e44f7:	e8 74 8e a8 fa       	call   0x18006d370
   1855e44fc:	48 8b 85 68 03 00 00 	mov    rax,QWORD PTR [rbp+0x368]
   1855e4503:	48 83 f8 10          	cmp    rax,0x10
   1855e4507:	72 38                	jb     0x1855e4541
   1855e4509:	48 8b 8d 50 03 00 00 	mov    rcx,QWORD PTR [rbp+0x350]
   1855e4510:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855e4514:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855e451b:	72 1f                	jb     0x1855e453c
   1855e451d:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855e4521:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855e4525:	4c 29 c1             	sub    rcx,r8
   1855e4528:	48 83 f9 20          	cmp    rcx,0x20
   1855e452c:	0f 83 e2 04 00 00    	jae    0x1855e4a14
   1855e4532:	48 83 c0 28          	add    rax,0x28
   1855e4536:	48 89 c2             	mov    rdx,rax
   1855e4539:	4c 89 c1             	mov    rcx,r8
   1855e453c:	e8 df 77 f6 01       	call   0x18754bd20
   1855e4541:	0f b6 85 38 05 00 00 	movzx  eax,BYTE PTR [rbp+0x538]
   1855e4548:	48 8b 4e 08          	mov    rcx,QWORD PTR [rsi+0x8]
   1855e454c:	0f 28 85 f0 04 00 00 	movaps xmm0,XMMWORD PTR [rbp+0x4f0]
   1855e4553:	0f 28 8d 00 05 00 00 	movaps xmm1,XMMWORD PTR [rbp+0x500]
   1855e455a:	0f 29 45 10          	movaps XMMWORD PTR [rbp+0x10],xmm0
   1855e455e:	0f 29 4d 20          	movaps XMMWORD PTR [rbp+0x20],xmm1
   1855e4562:	48 8b 95 10 05 00 00 	mov    rdx,QWORD PTR [rbp+0x510]
   1855e4569:	48 89 55 30          	mov    QWORD PTR [rbp+0x30],rdx
   1855e456d:	c6 45 58 00          	mov    BYTE PTR [rbp+0x58],0x0
   1855e4571:	3c 01                	cmp    al,0x1
   1855e4573:	75 3c                	jne    0x1855e45b1
   1855e4575:	0f 10 85 18 05 00 00 	movups xmm0,XMMWORD PTR [rbp+0x518]
   1855e457c:	0f 10 8d 28 05 00 00 	movups xmm1,XMMWORD PTR [rbp+0x528]
   1855e4583:	0f 11 4d 48          	movups XMMWORD PTR [rbp+0x48],xmm1
   1855e4587:	0f 11 45 38          	movups XMMWORD PTR [rbp+0x38],xmm0
   1855e458b:	48 c7 85 28 05 00 00 	mov    QWORD PTR [rbp+0x528],0x0
   1855e4592:	00 00 00 00
   1855e4596:	48 c7 85 30 05 00 00 	mov    QWORD PTR [rbp+0x530],0xf
   1855e459d:	0f 00 00 00
   1855e45a1:	c6 85 18 05 00 00 00 	mov    BYTE PTR [rbp+0x518],0x0
   1855e45a8:	c6 45 58 01          	mov    BYTE PTR [rbp+0x58],0x1
   1855e45ac:	40 b6 01             	mov    sil,0x1
   1855e45af:	eb 02                	jmp    0x1855e45b3
   1855e45b1:	31 f6                	xor    esi,esi
   1855e45b3:	48 8d 55 10          	lea    rdx,[rbp+0x10]
   1855e45b7:	e8 d4 f6 ff ff       	call   0x1855e3c90
   1855e45bc:	90                   	nop
   1855e45bd:	80 bd e0 04 00 00 01 	cmp    BYTE PTR [rbp+0x4e0],0x1
   1855e45c4:	0f 85 8a 00 00 00    	jne    0x1855e4654
   1855e45ca:	48 8b 85 d8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4d8]
   1855e45d1:	48 83 f8 10          	cmp    rax,0x10
   1855e45d5:	72 38                	jb     0x1855e460f
   1855e45d7:	48 8b 8d c0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4c0]
   1855e45de:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855e45e2:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855e45e9:	72 1f                	jb     0x1855e460a
   1855e45eb:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855e45ef:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855e45f3:	4c 29 c1             	sub    rcx,r8
   1855e45f6:	48 83 f9 20          	cmp    rcx,0x20
   1855e45fa:	0f 83 14 04 00 00    	jae    0x1855e4a14
   1855e4600:	48 83 c0 28          	add    rax,0x28
   1855e4604:	48 89 c2             	mov    rdx,rax
   1855e4607:	4c 89 c1             	mov    rcx,r8
   1855e460a:	e8 11 77 f6 01       	call   0x18754bd20
   1855e460f:	48 8b 85 a8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4a8]
   1855e4616:	48 83 f8 10          	cmp    rax,0x10
   1855e461a:	72 38                	jb     0x1855e4654
   1855e461c:	48 8b 8d 90 04 00 00 	mov    rcx,QWORD PTR [rbp+0x490]
   1855e4623:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855e4627:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855e462e:	72 1f                	jb     0x1855e464f
   1855e4630:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855e4634:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855e4638:	4c 29 c1             	sub    rcx,r8
   1855e463b:	48 83 f9 20          	cmp    rcx,0x20
   1855e463f:	0f 83 cf 03 00 00    	jae    0x1855e4a14
   1855e4645:	48 83 c0 28          	add    rax,0x28
   1855e4649:	48 89 c2             	mov    rdx,rax
   1855e464c:	4c 89 c1             	mov    rcx,r8
   1855e464f:	e8 cc 76 f6 01       	call   0x18754bd20
   1855e4654:	40 84 f6             	test   sil,sil
   1855e4657:	0f 84 34 03 00 00    	je     0x1855e4991
   1855e465d:	48 8b 85 30 05 00 00 	mov    rax,QWORD PTR [rbp+0x530]
   1855e4664:	48 83 f8 10          	cmp    rax,0x10
   1855e4668:	0f 82 23 03 00 00    	jb     0x1855e4991
   1855e466e:	48 8b 8d 18 05 00 00 	mov    rcx,QWORD PTR [rbp+0x518]
   1855e4675:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855e4679:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855e4680:	0f 82 06 03 00 00    	jb     0x1855e498c
   1855e4686:	e9 e2 02 00 00       	jmp    0x1855e496d
   1855e468b:	48 8d 46 18          	lea    rax,[rsi+0x18]
   1855e468f:	48 89 85 f0 04 00 00 	mov    QWORD PTR [rbp+0x4f0],rax
   1855e4696:	c6 85 f8 04 00 00 00 	mov    BYTE PTR [rbp+0x4f8],0x0
   1855e469d:	0f 57 c0             	xorps  xmm0,xmm0
   1855e46a0:	0f 11 85 30 04 00 00 	movups XMMWORD PTR [rbp+0x430],xmm0
   1855e46a7:	0f 11 85 20 04 00 00 	movups XMMWORD PTR [rbp+0x420],xmm0
   1855e46ae:	0f 11 85 10 04 00 00 	movups XMMWORD PTR [rbp+0x410],xmm0
   1855e46b5:	0f 11 85 00 04 00 00 	movups XMMWORD PTR [rbp+0x400],xmm0
   1855e46bc:	0f 11 85 f0 03 00 00 	movups XMMWORD PTR [rbp+0x3f0],xmm0
   1855e46c3:	0f 11 85 e0 03 00 00 	movups XMMWORD PTR [rbp+0x3e0],xmm0
   1855e46ca:	0f 11 85 d0 03 00 00 	movups XMMWORD PTR [rbp+0x3d0],xmm0
   1855e46d1:	48 8d 85 f0 04 00 00 	lea    rax,[rbp+0x4f0]
   1855e46d8:	48 89 85 c0 03 00 00 	mov    QWORD PTR [rbp+0x3c0],rax
   1855e46df:	48 8d 85 90 04 00 00 	lea    rax,[rbp+0x490]
   1855e46e6:	48 89 85 c8 03 00 00 	mov    QWORD PTR [rbp+0x3c8],rax
   1855e46ed:	48 8d 15 24 22 42 04 	lea    rdx,[rip+0x4422224]        # 0x189a06918
   1855e46f4:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855e46f8:	4c 8d 85 c0 03 00 00 	lea    r8,[rbp+0x3c0]
   1855e46ff:	e8 0c 91 a8 fa       	call   0x18006d810
   1855e4704:	90                   	nop
   1855e4705:	48 8b 85 18 03 00 00 	mov    rax,QWORD PTR [rbp+0x318]
   1855e470c:	48 83 f8 10          	cmp    rax,0x10
   1855e4710:	72 38                	jb     0x1855e474a
   1855e4712:	48 8b 8d 00 03 00 00 	mov    rcx,QWORD PTR [rbp+0x300]
   1855e4719:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855e471d:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855e4724:	72 1f                	jb     0x1855e4745
   1855e4726:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855e472a:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855e472e:	4c 29 c1             	sub    rcx,r8
   1855e4731:	48 83 f9 20          	cmp    rcx,0x20
   1855e4735:	0f 83 d9 02 00 00    	jae    0x1855e4a14
   1855e473b:	48 83 c0 28          	add    rax,0x28
   1855e473f:	48 89 c2             	mov    rdx,rax
   1855e4742:	4c 89 c1             	mov    rcx,r8
   1855e4745:	e8 d6 75 f6 01       	call   0x18754bd20
   1855e474a:	48 8d 4d 10          	lea    rcx,[rbp+0x10]
   1855e474e:	e8 1d 8c a8 fa       	call   0x18006d370
   1855e4753:	48 8b 85 88 03 00 00 	mov    rax,QWORD PTR [rbp+0x388]
   1855e475a:	48 83 f8 10          	cmp    rax,0x10
   1855e475e:	72 38                	jb     0x1855e4798
   1855e4760:	48 8b 8d 70 03 00 00 	mov    rcx,QWORD PTR [rbp+0x370]
   1855e4767:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855e476b:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855e4772:	72 1f                	jb     0x1855e4793
   1855e4774:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855e4778:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855e477c:	4c 29 c1             	sub    rcx,r8
   1855e477f:	48 83 f9 20          	cmp    rcx,0x20
   1855e4783:	0f 83 8b 02 00 00    	jae    0x1855e4a14
   1855e4789:	48 83 c0 28          	add    rax,0x28
   1855e478d:	48 89 c2             	mov    rdx,rax
   1855e4790:	4c 89 c1             	mov    rcx,r8
   1855e4793:	e8 88 75 f6 01       	call   0x18754bd20
   1855e4798:	48 8b 76 08          	mov    rsi,QWORD PTR [rsi+0x8]
   1855e479c:	48 8d 8d 40 04 00 00 	lea    rcx,[rbp+0x440]
   1855e47a3:	48 8d bd 90 04 00 00 	lea    rdi,[rbp+0x490]
   1855e47aa:	48 89 fa             	mov    rdx,rdi
   1855e47ad:	e8 ae c4 b2 fa       	call   0x180110c60
   1855e47b2:	90                   	nop
   1855e47b3:	4c 8b 85 a0 04 00 00 	mov    r8,QWORD PTR [rbp+0x4a0]
   1855e47ba:	48 8b 85 a8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4a8]
   1855e47c1:	48 89 c1             	mov    rcx,rax
   1855e47c4:	4c 29 c1             	sub    rcx,r8
   1855e47c7:	48 83 f9 18          	cmp    rcx,0x18
   1855e47cb:	73 32                	jae    0x1855e47ff
   1855e47cd:	48 8d 05 8c f5 41 04 	lea    rax,[rip+0x441f58c]        # 0x189a03d60
   1855e47d4:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855e47d9:	48 c7 44 24 28 18 00 	mov    QWORD PTR [rsp+0x28],0x18
   1855e47e0:	00 00
   1855e47e2:	48 8d 8d 90 04 00 00 	lea    rcx,[rbp+0x490]
   1855e47e9:	ba 18 00 00 00       	mov    edx,0x18
   1855e47ee:	45 31 c9             	xor    r9d,r9d
   1855e47f1:	e8 5a 75 a2 fa       	call   0x18000bd50
   1855e47f6:	90                   	nop
   1855e47f7:	48 89 c7             	mov    rdi,rax
   1855e47fa:	e9 9e 00 00 00       	jmp    0x1855e489d
   1855e47ff:	48 8d 8d a8 04 00 00 	lea    rcx,[rbp+0x4a8]
   1855e4806:	49 8d 50 18          	lea    rdx,[r8+0x18]
   1855e480a:	48 89 95 a0 04 00 00 	mov    QWORD PTR [rbp+0x4a0],rdx
   1855e4811:	48 83 f8 10          	cmp    rax,0x10
   1855e4815:	48 8b 95 90 04 00 00 	mov    rdx,QWORD PTR [rbp+0x490]
   1855e481c:	48 89 fb             	mov    rbx,rdi
   1855e481f:	48 0f 43 da          	cmovae rbx,rdx
   1855e4823:	4c 8d 0d 4e f5 41 04 	lea    r9,[rip+0x441f54e]        # 0x189a03d78
   1855e482a:	4c 39 cb             	cmp    rbx,r9
   1855e482d:	41 0f 93 c1          	setae  r9b
   1855e4831:	4c 8d 35 28 f5 41 04 	lea    r14,[rip+0x441f528]        # 0x189a03d60
   1855e4838:	4e 8d 14 03          	lea    r10,[rbx+r8*1]
   1855e483c:	4d 39 f2             	cmp    r10,r14
   1855e483f:	41 0f 92 c2          	setb   r10b
   1855e4843:	45 08 ca             	or     r10b,r9b
   1855e4846:	41 bf 18 00 00 00    	mov    r15d,0x18
   1855e484c:	41 bc 18 00 00 00    	mov    r12d,0x18
   1855e4852:	75 0b                	jne    0x1855e485f
   1855e4854:	49 89 dc             	mov    r12,rbx
   1855e4857:	4d 29 f4             	sub    r12,r14
   1855e485a:	77 03                	ja     0x1855e485f
   1855e485c:	45 31 e4             	xor    r12d,r12d
   1855e485f:	49 ff c0             	inc    r8
   1855e4862:	48 83 c2 18          	add    rdx,0x18
   1855e4866:	48 83 f8 10          	cmp    rax,0x10
   1855e486a:	48 0f 43 ca          	cmovae rcx,rdx
   1855e486e:	48 89 da             	mov    rdx,rbx
   1855e4871:	e8 ca 05 13 02       	call   0x187714e40
   1855e4876:	48 89 d9             	mov    rcx,rbx
   1855e4879:	4c 89 f2             	mov    rdx,r14
   1855e487c:	4d 89 e0             	mov    r8,r12
   1855e487f:	e8 bc 05 13 02       	call   0x187714e40
   1855e4884:	4d 29 e7             	sub    r15,r12
   1855e4887:	4b 8d 14 34          	lea    rdx,[r12+r14*1]
   1855e488b:	48 83 c2 18          	add    rdx,0x18
   1855e488f:	4c 01 e3             	add    rbx,r12
   1855e4892:	48 89 d9             	mov    rcx,rbx
   1855e4895:	4d 89 f8             	mov    r8,r15
   1855e4898:	e8 a3 05 13 02       	call   0x187714e40
   1855e489d:	0f 10 07             	movups xmm0,XMMWORD PTR [rdi]
   1855e48a0:	0f 10 4f 10          	movups xmm1,XMMWORD PTR [rdi+0x10]
   1855e48a4:	0f 29 8d d0 03 00 00 	movaps XMMWORD PTR [rbp+0x3d0],xmm1
   1855e48ab:	0f 29 85 c0 03 00 00 	movaps XMMWORD PTR [rbp+0x3c0],xmm0
   1855e48b2:	48 c7 47 10 00 00 00 	mov    QWORD PTR [rdi+0x10],0x0
   1855e48b9:	00
   1855e48ba:	48 c7 47 18 0f 00 00 	mov    QWORD PTR [rdi+0x18],0xf
   1855e48c1:	00
   1855e48c2:	c6 07 00             	mov    BYTE PTR [rdi],0x0
   1855e48c5:	0f 29 75 20          	movaps XMMWORD PTR [rbp+0x20],xmm6
   1855e48c9:	0f 29 75 30          	movaps XMMWORD PTR [rbp+0x30],xmm6
   1855e48cd:	0f 29 75 50          	movaps XMMWORD PTR [rbp+0x50],xmm6
   1855e48d1:	0f 29 75 10          	movaps XMMWORD PTR [rbp+0x10],xmm6
   1855e48d5:	0f 29 75 40          	movaps XMMWORD PTR [rbp+0x40],xmm6
   1855e48d9:	c6 45 20 00          	mov    BYTE PTR [rbp+0x20],0x0
   1855e48dd:	c6 45 30 00          	mov    BYTE PTR [rbp+0x30],0x0
   1855e48e1:	c6 45 58 00          	mov    BYTE PTR [rbp+0x58],0x0
   1855e48e5:	c6 45 10 00          	mov    BYTE PTR [rbp+0x10],0x0
   1855e48e9:	48 8d 4d 38          	lea    rcx,[rbp+0x38]
   1855e48ed:	48 8d 95 c0 03 00 00 	lea    rdx,[rbp+0x3c0]
   1855e48f4:	e8 f7 06 3b fc       	call   0x181994ff0
   1855e48f9:	90                   	nop
   1855e48fa:	48 8d 55 10          	lea    rdx,[rbp+0x10]
   1855e48fe:	48 89 f1             	mov    rcx,rsi
   1855e4901:	e8 8a f3 ff ff       	call   0x1855e3c90
   1855e4906:	90                   	nop
   1855e4907:	48 8b 85 d8 03 00 00 	mov    rax,QWORD PTR [rbp+0x3d8]
   1855e490e:	48 83 f8 10          	cmp    rax,0x10
   1855e4912:	72 38                	jb     0x1855e494c
   1855e4914:	48 8b 8d c0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3c0]
   1855e491b:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855e491f:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855e4926:	72 1f                	jb     0x1855e4947
   1855e4928:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855e492c:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855e4930:	4c 29 c1             	sub    rcx,r8
   1855e4933:	48 83 f9 20          	cmp    rcx,0x20
   1855e4937:	0f 83 d7 00 00 00    	jae    0x1855e4a14
   1855e493d:	48 83 c0 28          	add    rax,0x28
   1855e4941:	48 89 c2             	mov    rdx,rax
   1855e4944:	4c 89 c1             	mov    rcx,r8
   1855e4947:	e8 d4 73 f6 01       	call   0x18754bd20
   1855e494c:	48 8b 85 a8 04 00 00 	mov    rax,QWORD PTR [rbp+0x4a8]
   1855e4953:	48 83 f8 10          	cmp    rax,0x10
   1855e4957:	72 38                	jb     0x1855e4991
   1855e4959:	48 8b 8d 90 04 00 00 	mov    rcx,QWORD PTR [rbp+0x490]
   1855e4960:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855e4964:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855e496b:	72 1f                	jb     0x1855e498c
   1855e496d:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855e4971:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855e4975:	4c 29 c1             	sub    rcx,r8
   1855e4978:	48 83 f9 20          	cmp    rcx,0x20
   1855e497c:	0f 83 92 00 00 00    	jae    0x1855e4a14
   1855e4982:	48 83 c0 28          	add    rax,0x28
   1855e4986:	48 89 c2             	mov    rdx,rax
   1855e4989:	4c 89 c1             	mov    rcx,r8
   1855e498c:	e8 8f 73 f6 01       	call   0x18754bd20
   1855e4991:	48 8b b5 70 04 00 00 	mov    rsi,QWORD PTR [rbp+0x470]
   1855e4998:	48 85 f6             	test   rsi,rsi
   1855e499b:	74 1d                	je     0x1855e49ba
   1855e499d:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855e49a1:	75 17                	jne    0x1855e49ba
   1855e49a3:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855e49a6:	48 89 f1             	mov    rcx,rsi
   1855e49a9:	ff 10                	call   QWORD PTR [rax]
   1855e49ab:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855e49af:	75 09                	jne    0x1855e49ba
   1855e49b1:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855e49b4:	48 89 f1             	mov    rcx,rsi
   1855e49b7:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855e49ba:	48 8b 85 60 04 00 00 	mov    rax,QWORD PTR [rbp+0x460]
   1855e49c1:	48 83 f8 10          	cmp    rax,0x10
   1855e49c5:	72 34                	jb     0x1855e49fb
   1855e49c7:	48 8b 8d 48 04 00 00 	mov    rcx,QWORD PTR [rbp+0x448]
   1855e49ce:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855e49d2:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855e49d9:	72 1b                	jb     0x1855e49f6
   1855e49db:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855e49df:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855e49e3:	4c 29 c1             	sub    rcx,r8
   1855e49e6:	48 83 f9 20          	cmp    rcx,0x20
   1855e49ea:	73 28                	jae    0x1855e4a14
   1855e49ec:	48 83 c0 28          	add    rax,0x28
   1855e49f0:	48 89 c2             	mov    rdx,rax
   1855e49f3:	4c 89 c1             	mov    rcx,r8
   1855e49f6:	e8 25 73 f6 01       	call   0x18754bd20
   1855e49fb:	0f 28 b5 50 05 00 00 	movaps xmm6,XMMWORD PTR [rbp+0x550]
   1855e4a02:	48 81 c4 e0 05 00 00 	add    rsp,0x5e0
   1855e4a09:	5b                   	pop    rbx
   1855e4a0a:	5f                   	pop    rdi
   1855e4a0b:	5e                   	pop    rsi
   1855e4a0c:	41 5c                	pop    r12
   1855e4a0e:	41 5e                	pop    r14
   1855e4a10:	41 5f                	pop    r15
   1855e4a12:	5d                   	pop    rbp
   1855e4a13:	c3                   	ret
   1855e4a14:	e8 73 97 0f 02       	call   0x1876de18c
   1855e4a19:	cc                   	int3
