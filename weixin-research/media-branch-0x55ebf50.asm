
E:/Tencent/Weixin/4.1.15.56/Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001855ebf50 <.text+0x55eaf50>:
   1855ebf50:	55                   	push   rbp
   1855ebf51:	41 57                	push   r15
   1855ebf53:	41 56                	push   r14
   1855ebf55:	41 54                	push   r12
   1855ebf57:	56                   	push   rsi
   1855ebf58:	57                   	push   rdi
   1855ebf59:	53                   	push   rbx
   1855ebf5a:	48 81 ec a0 05 00 00 	sub    rsp,0x5a0
   1855ebf61:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   1855ebf68:	00 
   1855ebf69:	0f 29 b5 10 05 00 00 	movaps XMMWORD PTR [rbp+0x510],xmm6
   1855ebf70:	48 c7 85 08 05 00 00 	mov    QWORD PTR [rbp+0x508],0xfffffffffffffffe
   1855ebf77:	fe ff ff ff 
   1855ebf7b:	48 89 ce             	mov    rsi,rcx
   1855ebf7e:	0f 28 35 2b ac 92 03 	movaps xmm6,XMMWORD PTR [rip+0x392ac2b]        # 0x188f16bb0
   1855ebf85:	0f 29 b5 a0 04 00 00 	movaps XMMWORD PTR [rbp+0x4a0],xmm6
   1855ebf8c:	48 8d 8d c0 03 00 00 	lea    rcx,[rbp+0x3c0]
   1855ebf93:	e8 88 b2 a5 fa       	call   0x180047220
   1855ebf98:	48 8b 8d c0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3c0]
   1855ebf9f:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   1855ebfa3:	e8 28 64 d9 fa       	call   0x1803823d0
   1855ebfa8:	90                   	nop
   1855ebfa9:	48 8b 4d c0          	mov    rcx,QWORD PTR [rbp-0x40]
   1855ebfad:	48 8d 95 a0 04 00 00 	lea    rdx,[rbp+0x4a0]
   1855ebfb4:	e8 c7 d2 11 fb       	call   0x180709280
   1855ebfb9:	90                   	nop
   1855ebfba:	48 8b 7d c8          	mov    rdi,QWORD PTR [rbp-0x38]
   1855ebfbe:	48 85 ff             	test   rdi,rdi
   1855ebfc1:	74 1d                	je     0x1855ebfe0
   1855ebfc3:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1855ebfc7:	75 17                	jne    0x1855ebfe0
   1855ebfc9:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855ebfcc:	48 89 f9             	mov    rcx,rdi
   1855ebfcf:	ff 10                	call   QWORD PTR [rax]
   1855ebfd1:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1855ebfd5:	75 09                	jne    0x1855ebfe0
   1855ebfd7:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855ebfda:	48 89 f9             	mov    rcx,rdi
   1855ebfdd:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ebfe0:	48 8b bd c8 03 00 00 	mov    rdi,QWORD PTR [rbp+0x3c8]
   1855ebfe7:	48 85 ff             	test   rdi,rdi
   1855ebfea:	74 1d                	je     0x1855ec009
   1855ebfec:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1855ebff0:	75 17                	jne    0x1855ec009
   1855ebff2:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855ebff5:	48 89 f9             	mov    rcx,rdi
   1855ebff8:	ff 10                	call   QWORD PTR [rax]
   1855ebffa:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1855ebffe:	75 09                	jne    0x1855ec009
   1855ec000:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855ec003:	48 89 f9             	mov    rcx,rdi
   1855ec006:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ec009:	48 8b 8d a0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4a0]
   1855ec010:	48 85 c9             	test   rcx,rcx
   1855ec013:	74 4a                	je     0x1855ec05f
   1855ec015:	48 bf aa aa aa aa aa 	movabs rdi,0xaaaaaaaaaaaaaaaa
   1855ec01c:	aa aa aa 
   1855ec01f:	48 89 bd a0 03 00 00 	mov    QWORD PTR [rbp+0x3a0],rdi
   1855ec026:	0f 29 b5 90 03 00 00 	movaps XMMWORD PTR [rbp+0x390],xmm6
   1855ec02d:	0f 29 b5 80 03 00 00 	movaps XMMWORD PTR [rbp+0x380],xmm6
   1855ec034:	0f 29 b5 70 03 00 00 	movaps XMMWORD PTR [rbp+0x370],xmm6
   1855ec03b:	0f 57 c0             	xorps  xmm0,xmm0
   1855ec03e:	0f 29 85 b0 03 00 00 	movaps XMMWORD PTR [rbp+0x3b0],xmm0
   1855ec045:	48 8b 46 40          	mov    rax,QWORD PTR [rsi+0x40]
   1855ec049:	48 85 c0             	test   rax,rax
   1855ec04c:	0f 84 e4 00 00 00    	je     0x1855ec136
   1855ec052:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1855ec056:	48 8b 46 40          	mov    rax,QWORD PTR [rsi+0x40]
   1855ec05a:	e9 d9 00 00 00       	jmp    0x1855ec138
   1855ec05f:	48 8b 76 08          	mov    rsi,QWORD PTR [rsi+0x8]
   1855ec063:	0f 57 c0             	xorps  xmm0,xmm0
   1855ec066:	0f 29 85 d0 03 00 00 	movaps XMMWORD PTR [rbp+0x3d0],xmm0
   1855ec06d:	0f 29 85 c0 03 00 00 	movaps XMMWORD PTR [rbp+0x3c0],xmm0
   1855ec074:	b9 40 00 00 00       	mov    ecx,0x40
   1855ec079:	e8 5e fc f5 01       	call   0x18754bcdc
   1855ec07e:	90                   	nop
   1855ec07f:	48 89 85 c0 03 00 00 	mov    QWORD PTR [rbp+0x3c0],rax
   1855ec086:	48 c7 85 d0 03 00 00 	mov    QWORD PTR [rbp+0x3d0],0x32
   1855ec08d:	32 00 00 00 
   1855ec091:	48 c7 85 d8 03 00 00 	mov    QWORD PTR [rbp+0x3d8],0x3f
   1855ec098:	3f 00 00 00 
   1855ec09c:	0f 10 05 15 79 41 04 	movups xmm0,XMMWORD PTR [rip+0x4417915]        # 0x189a039b8
   1855ec0a3:	0f 11 40 20          	movups XMMWORD PTR [rax+0x20],xmm0
   1855ec0a7:	0f 10 05 fa 78 41 04 	movups xmm0,XMMWORD PTR [rip+0x44178fa]        # 0x189a039a8
   1855ec0ae:	0f 11 40 10          	movups XMMWORD PTR [rax+0x10],xmm0
   1855ec0b2:	0f 10 05 df 78 41 04 	movups xmm0,XMMWORD PTR [rip+0x44178df]        # 0x189a03998
   1855ec0b9:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   1855ec0bc:	66 c7 40 30 6c 65    	mov    WORD PTR [rax+0x30],0x656c
   1855ec0c2:	c6 40 32 00          	mov    BYTE PTR [rax+0x32],0x0
   1855ec0c6:	0f 29 75 d0          	movaps XMMWORD PTR [rbp-0x30],xmm6
   1855ec0ca:	0f 29 75 e0          	movaps XMMWORD PTR [rbp-0x20],xmm6
   1855ec0ce:	0f 29 75 00          	movaps XMMWORD PTR [rbp+0x0],xmm6
   1855ec0d2:	0f 29 75 c0          	movaps XMMWORD PTR [rbp-0x40],xmm6
   1855ec0d6:	0f 29 75 f0          	movaps XMMWORD PTR [rbp-0x10],xmm6
   1855ec0da:	c6 45 d0 00          	mov    BYTE PTR [rbp-0x30],0x0
   1855ec0de:	c6 45 e0 00          	mov    BYTE PTR [rbp-0x20],0x0
   1855ec0e2:	c6 45 08 00          	mov    BYTE PTR [rbp+0x8],0x0
   1855ec0e6:	c6 45 c0 00          	mov    BYTE PTR [rbp-0x40],0x0
   1855ec0ea:	48 8d 4d e8          	lea    rcx,[rbp-0x18]
   1855ec0ee:	48 8d 95 c0 03 00 00 	lea    rdx,[rbp+0x3c0]
   1855ec0f5:	e8 f6 8e 3a fc       	call   0x181994ff0
   1855ec0fa:	90                   	nop
   1855ec0fb:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   1855ec0ff:	48 89 f1             	mov    rcx,rsi
   1855ec102:	e8 29 67 ff ff       	call   0x1855e2830
   1855ec107:	90                   	nop
   1855ec108:	48 8b 85 d8 03 00 00 	mov    rax,QWORD PTR [rbp+0x3d8]
   1855ec10f:	48 83 f8 10          	cmp    rax,0x10
   1855ec113:	0f 82 6c 08 00 00    	jb     0x1855ec985
   1855ec119:	48 8b 8d c0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3c0]
   1855ec120:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ec124:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ec12b:	0f 83 34 08 00 00    	jae    0x1855ec965
   1855ec131:	e9 4a 08 00 00       	jmp    0x1855ec980
   1855ec136:	31 c0                	xor    eax,eax
   1855ec138:	48 8b 56 38          	mov    rdx,QWORD PTR [rsi+0x38]
   1855ec13c:	48 89 95 b0 03 00 00 	mov    QWORD PTR [rbp+0x3b0],rdx
   1855ec143:	48 89 85 b8 03 00 00 	mov    QWORD PTR [rbp+0x3b8],rax
   1855ec14a:	48 8d 95 70 03 00 00 	lea    rdx,[rbp+0x370]
   1855ec151:	4c 8d 85 b0 03 00 00 	lea    r8,[rbp+0x3b0]
   1855ec158:	e8 03 7a 1b fc       	call   0x1817a3b60
   1855ec15d:	90                   	nop
   1855ec15e:	8b 85 74 03 00 00    	mov    eax,DWORD PTR [rbp+0x374]
   1855ec164:	0b 85 70 03 00 00    	or     eax,DWORD PTR [rbp+0x370]
   1855ec16a:	0f 84 b8 00 00 00    	je     0x1855ec228
   1855ec170:	b9 04 00 00 00       	mov    ecx,0x4
   1855ec175:	e8 66 0c a8 fa       	call   0x18006cde0
   1855ec17a:	85 c0                	test   eax,eax
   1855ec17c:	0f 84 a8 05 00 00    	je     0x1855ec72a
   1855ec182:	48 8d bd b0 02 00 00 	lea    rdi,[rbp+0x2b0]
   1855ec189:	48 89 f9             	mov    rcx,rdi
   1855ec18c:	e8 7f 0d a8 fa       	call   0x18006cf10
   1855ec191:	90                   	nop
   1855ec192:	48 83 bd c8 02 00 00 	cmp    QWORD PTR [rbp+0x2c8],0x10
   1855ec199:	10 
   1855ec19a:	72 07                	jb     0x1855ec1a3
   1855ec19c:	48 8b bd b0 02 00 00 	mov    rdi,QWORD PTR [rbp+0x2b0]
   1855ec1a3:	48 8d 05 c6 aa 41 04 	lea    rax,[rip+0x441aac6]        # 0x189a06c70
   1855ec1aa:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855ec1af:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855ec1b6:	00 00 
   1855ec1b8:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855ec1bd:	c7 44 24 28 20 04 00 	mov    DWORD PTR [rsp+0x28],0x420
   1855ec1c4:	00 
   1855ec1c5:	4c 8d 0d f4 90 41 04 	lea    r9,[rip+0x44190f4]        # 0x189a052c0
   1855ec1cc:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1855ec1d0:	ba 04 00 00 00       	mov    edx,0x4
   1855ec1d5:	49 89 f8             	mov    r8,rdi
   1855ec1d8:	e8 93 10 a8 fa       	call   0x18006d270
   1855ec1dd:	90                   	nop
   1855ec1de:	48 8d 8d 70 03 00 00 	lea    rcx,[rbp+0x370]
   1855ec1e5:	48 8d bd 00 03 00 00 	lea    rdi,[rbp+0x300]
   1855ec1ec:	48 89 fa             	mov    rdx,rdi
   1855ec1ef:	e8 6c 4a b2 fa       	call   0x180110c60
   1855ec1f4:	90                   	nop
   1855ec1f5:	48 83 bd 18 03 00 00 	cmp    QWORD PTR [rbp+0x318],0x10
   1855ec1fc:	10 
   1855ec1fd:	72 07                	jb     0x1855ec206
   1855ec1ff:	48 8b bd 00 03 00 00 	mov    rdi,QWORD PTR [rbp+0x300]
   1855ec206:	48 89 bd 40 04 00 00 	mov    QWORD PTR [rbp+0x440],rdi
   1855ec20d:	c6 85 48 04 00 00 00 	mov    BYTE PTR [rbp+0x448],0x0
   1855ec214:	48 83 7e 30 10       	cmp    QWORD PTR [rsi+0x30],0x10
   1855ec219:	0f 82 fe 03 00 00    	jb     0x1855ec61d
   1855ec21f:	48 8b 46 18          	mov    rax,QWORD PTR [rsi+0x18]
   1855ec223:	e9 f9 03 00 00       	jmp    0x1855ec621
   1855ec228:	0f 29 b5 c0 04 00 00 	movaps XMMWORD PTR [rbp+0x4c0],xmm6
   1855ec22f:	0f 29 b5 d0 04 00 00 	movaps XMMWORD PTR [rbp+0x4d0],xmm6
   1855ec236:	0f 29 b5 f0 04 00 00 	movaps XMMWORD PTR [rbp+0x4f0],xmm6
   1855ec23d:	0f 29 b5 b0 04 00 00 	movaps XMMWORD PTR [rbp+0x4b0],xmm6
   1855ec244:	0f 29 b5 e0 04 00 00 	movaps XMMWORD PTR [rbp+0x4e0],xmm6
   1855ec24b:	c6 85 c0 04 00 00 00 	mov    BYTE PTR [rbp+0x4c0],0x0
   1855ec252:	c6 85 d0 04 00 00 00 	mov    BYTE PTR [rbp+0x4d0],0x0
   1855ec259:	c6 85 f8 04 00 00 00 	mov    BYTE PTR [rbp+0x4f8],0x0
   1855ec260:	c6 85 b0 04 00 00 01 	mov    BYTE PTR [rbp+0x4b0],0x1
   1855ec267:	48 89 bd 90 04 00 00 	mov    QWORD PTR [rbp+0x490],rdi
   1855ec26e:	0f 29 b5 80 04 00 00 	movaps XMMWORD PTR [rbp+0x480],xmm6
   1855ec275:	0f 29 b5 70 04 00 00 	movaps XMMWORD PTR [rbp+0x470],xmm6
   1855ec27c:	0f 29 b5 60 04 00 00 	movaps XMMWORD PTR [rbp+0x460],xmm6
   1855ec283:	0f 29 b5 50 04 00 00 	movaps XMMWORD PTR [rbp+0x450],xmm6
   1855ec28a:	0f 29 b5 40 04 00 00 	movaps XMMWORD PTR [rbp+0x440],xmm6
   1855ec291:	48 8b 95 98 03 00 00 	mov    rdx,QWORD PTR [rbp+0x398]
   1855ec298:	c6 85 90 04 00 00 00 	mov    BYTE PTR [rbp+0x490],0x0
   1855ec29f:	80 7a 50 01          	cmp    BYTE PTR [rdx+0x50],0x1
   1855ec2a3:	0f 85 87 00 00 00    	jne    0x1855ec330
   1855ec2a9:	48 8d 8d 40 04 00 00 	lea    rcx,[rbp+0x440]
   1855ec2b0:	e8 1b 15 19 fb       	call   0x18077d7d0
   1855ec2b5:	90                   	nop
   1855ec2b6:	c6 85 90 04 00 00 01 	mov    BYTE PTR [rbp+0x490],0x1
   1855ec2bd:	8b 9d 60 04 00 00    	mov    ebx,DWORD PTR [rbp+0x460]
   1855ec2c3:	48 89 9d c8 04 00 00 	mov    QWORD PTR [rbp+0x4c8],rbx
   1855ec2ca:	c6 85 d0 04 00 00 01 	mov    BYTE PTR [rbp+0x4d0],0x1
   1855ec2d1:	48 8d 15 e0 6e ab 03 	lea    rdx,[rip+0x3ab6ee0]        # 0x1890a31b8
   1855ec2d8:	48 8d 7d c0          	lea    rdi,[rbp-0x40]
   1855ec2dc:	41 b8 f0 02 00 00    	mov    r8d,0x2f0
   1855ec2e2:	48 89 f9             	mov    rcx,rdi
   1855ec2e5:	e8 56 8b 12 02       	call   0x187714e40
   1855ec2ea:	48 8b 8d a0 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4a0]
   1855ec2f1:	44 8b 8d 64 04 00 00 	mov    r9d,DWORD PTR [rbp+0x464]
   1855ec2f8:	4c 8d 46 48          	lea    r8,[rsi+0x48]
   1855ec2fc:	89 5c 24 20          	mov    DWORD PTR [rsp+0x20],ebx
   1855ec300:	48 89 fa             	mov    rdx,rdi
   1855ec303:	e8 88 d8 1c fc       	call   0x1817b9b90
   1855ec308:	90                   	nop
   1855ec309:	80 bd a8 02 00 00 01 	cmp    BYTE PTR [rbp+0x2a8],0x1
   1855ec310:	75 1e                	jne    0x1855ec330
   1855ec312:	48 8b 85 08 01 00 00 	mov    rax,QWORD PTR [rbp+0x108]
   1855ec319:	48 89 85 b8 04 00 00 	mov    QWORD PTR [rbp+0x4b8],rax
   1855ec320:	c6 85 c0 04 00 00 01 	mov    BYTE PTR [rbp+0x4c0],0x1
   1855ec327:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1855ec32b:	e8 10 03 be fa       	call   0x1801cc640
   1855ec330:	b9 02 00 00 00       	mov    ecx,0x2
   1855ec335:	e8 a6 0a a8 fa       	call   0x18006cde0
   1855ec33a:	85 c0                	test   eax,eax
   1855ec33c:	0f 84 82 00 00 00    	je     0x1855ec3c4
   1855ec342:	48 8d bd 50 03 00 00 	lea    rdi,[rbp+0x350]
   1855ec349:	48 89 f9             	mov    rcx,rdi
   1855ec34c:	e8 bf 0b a8 fa       	call   0x18006cf10
   1855ec351:	90                   	nop
   1855ec352:	48 83 bd 68 03 00 00 	cmp    QWORD PTR [rbp+0x368],0x10
   1855ec359:	10 
   1855ec35a:	72 07                	jb     0x1855ec363
   1855ec35c:	48 8b bd 50 03 00 00 	mov    rdi,QWORD PTR [rbp+0x350]
   1855ec363:	48 8d 05 06 a9 41 04 	lea    rax,[rip+0x441a906]        # 0x189a06c70
   1855ec36a:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855ec36f:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855ec376:	00 00 
   1855ec378:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855ec37d:	c7 44 24 28 2d 04 00 	mov    DWORD PTR [rsp+0x28],0x42d
   1855ec384:	00 
   1855ec385:	4c 8d 0d 34 8f 41 04 	lea    r9,[rip+0x4418f34]        # 0x189a052c0
   1855ec38c:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1855ec390:	ba 02 00 00 00       	mov    edx,0x2
   1855ec395:	49 89 f8             	mov    r8,rdi
   1855ec398:	e8 d3 0e a8 fa       	call   0x18006d270
   1855ec39d:	90                   	nop
   1855ec39e:	48 83 7e 60 10       	cmp    QWORD PTR [rsi+0x60],0x10
   1855ec3a3:	72 4d                	jb     0x1855ec3f2
   1855ec3a5:	48 8b 46 48          	mov    rax,QWORD PTR [rsi+0x48]
   1855ec3a9:	48 89 85 b0 02 00 00 	mov    QWORD PTR [rbp+0x2b0],rax
   1855ec3b0:	c6 85 b8 02 00 00 00 	mov    BYTE PTR [rbp+0x2b8],0x0
   1855ec3b7:	48 83 7e 30 10       	cmp    QWORD PTR [rsi+0x30],0x10
   1855ec3bc:	73 4d                	jae    0x1855ec40b
   1855ec3be:	48 8d 46 18          	lea    rax,[rsi+0x18]
   1855ec3c2:	eb 4b                	jmp    0x1855ec40f
   1855ec3c4:	48 8b 4e 08          	mov    rcx,QWORD PTR [rsi+0x8]
   1855ec3c8:	48 8b 85 d0 04 00 00 	mov    rax,QWORD PTR [rbp+0x4d0]
   1855ec3cf:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
   1855ec3d3:	0f 28 85 b0 04 00 00 	movaps xmm0,XMMWORD PTR [rbp+0x4b0]
   1855ec3da:	0f 28 8d c0 04 00 00 	movaps xmm1,XMMWORD PTR [rbp+0x4c0]
   1855ec3e1:	0f 29 4d d0          	movaps XMMWORD PTR [rbp-0x30],xmm1
   1855ec3e5:	0f 29 45 c0          	movaps XMMWORD PTR [rbp-0x40],xmm0
   1855ec3e9:	c6 45 08 00          	mov    BYTE PTR [rbp+0x8],0x0
   1855ec3ed:	e9 51 01 00 00       	jmp    0x1855ec543
   1855ec3f2:	48 8d 46 48          	lea    rax,[rsi+0x48]
   1855ec3f6:	48 89 85 b0 02 00 00 	mov    QWORD PTR [rbp+0x2b0],rax
   1855ec3fd:	c6 85 b8 02 00 00 00 	mov    BYTE PTR [rbp+0x2b8],0x0
   1855ec404:	48 83 7e 30 10       	cmp    QWORD PTR [rsi+0x30],0x10
   1855ec409:	72 b3                	jb     0x1855ec3be
   1855ec40b:	48 8b 46 18          	mov    rax,QWORD PTR [rsi+0x18]
   1855ec40f:	48 89 85 00 03 00 00 	mov    QWORD PTR [rbp+0x300],rax
   1855ec416:	c6 85 08 03 00 00 00 	mov    BYTE PTR [rbp+0x308],0x0
   1855ec41d:	0f 57 c0             	xorps  xmm0,xmm0
   1855ec420:	0f 11 85 30 04 00 00 	movups XMMWORD PTR [rbp+0x430],xmm0
   1855ec427:	0f 11 85 20 04 00 00 	movups XMMWORD PTR [rbp+0x420],xmm0
   1855ec42e:	0f 11 85 10 04 00 00 	movups XMMWORD PTR [rbp+0x410],xmm0
   1855ec435:	0f 11 85 00 04 00 00 	movups XMMWORD PTR [rbp+0x400],xmm0
   1855ec43c:	0f 11 85 f0 03 00 00 	movups XMMWORD PTR [rbp+0x3f0],xmm0
   1855ec443:	0f 11 85 e0 03 00 00 	movups XMMWORD PTR [rbp+0x3e0],xmm0
   1855ec44a:	0f 11 85 d0 03 00 00 	movups XMMWORD PTR [rbp+0x3d0],xmm0
   1855ec451:	48 8d 85 00 03 00 00 	lea    rax,[rbp+0x300]
   1855ec458:	48 89 85 c0 03 00 00 	mov    QWORD PTR [rbp+0x3c0],rax
   1855ec45f:	48 8d 85 b0 02 00 00 	lea    rax,[rbp+0x2b0]
   1855ec466:	48 89 85 c8 03 00 00 	mov    QWORD PTR [rbp+0x3c8],rax
   1855ec46d:	48 8d 15 b4 a9 41 04 	lea    rdx,[rip+0x441a9b4]        # 0x189a06e28
   1855ec474:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1855ec478:	4c 8d 85 c0 03 00 00 	lea    r8,[rbp+0x3c0]
   1855ec47f:	e8 8c 13 a8 fa       	call   0x18006d810
   1855ec484:	90                   	nop
   1855ec485:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1855ec489:	e8 e2 0e a8 fa       	call   0x18006d370
   1855ec48e:	48 8b 85 68 03 00 00 	mov    rax,QWORD PTR [rbp+0x368]
   1855ec495:	48 83 f8 10          	cmp    rax,0x10
   1855ec499:	72 38                	jb     0x1855ec4d3
   1855ec49b:	48 8b 8d 50 03 00 00 	mov    rcx,QWORD PTR [rbp+0x350]
   1855ec4a2:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ec4a6:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ec4ad:	72 1f                	jb     0x1855ec4ce
   1855ec4af:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ec4b3:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ec4b7:	4c 29 c1             	sub    rcx,r8
   1855ec4ba:	48 83 f9 20          	cmp    rcx,0x20
   1855ec4be:	0f 83 03 05 00 00    	jae    0x1855ec9c7
   1855ec4c4:	48 83 c0 28          	add    rax,0x28
   1855ec4c8:	48 89 c2             	mov    rdx,rax
   1855ec4cb:	4c 89 c1             	mov    rcx,r8
   1855ec4ce:	e8 4d f8 f5 01       	call   0x18754bd20
   1855ec4d3:	0f b6 85 f8 04 00 00 	movzx  eax,BYTE PTR [rbp+0x4f8]
   1855ec4da:	48 8b 4e 08          	mov    rcx,QWORD PTR [rsi+0x8]
   1855ec4de:	0f 28 85 b0 04 00 00 	movaps xmm0,XMMWORD PTR [rbp+0x4b0]
   1855ec4e5:	0f 28 8d c0 04 00 00 	movaps xmm1,XMMWORD PTR [rbp+0x4c0]
   1855ec4ec:	0f 29 45 c0          	movaps XMMWORD PTR [rbp-0x40],xmm0
   1855ec4f0:	0f 29 4d d0          	movaps XMMWORD PTR [rbp-0x30],xmm1
   1855ec4f4:	48 8b 95 d0 04 00 00 	mov    rdx,QWORD PTR [rbp+0x4d0]
   1855ec4fb:	48 89 55 e0          	mov    QWORD PTR [rbp-0x20],rdx
   1855ec4ff:	c6 45 08 00          	mov    BYTE PTR [rbp+0x8],0x0
   1855ec503:	3c 01                	cmp    al,0x1
   1855ec505:	75 3c                	jne    0x1855ec543
   1855ec507:	0f 10 85 d8 04 00 00 	movups xmm0,XMMWORD PTR [rbp+0x4d8]
   1855ec50e:	0f 10 8d e8 04 00 00 	movups xmm1,XMMWORD PTR [rbp+0x4e8]
   1855ec515:	0f 11 4d f8          	movups XMMWORD PTR [rbp-0x8],xmm1
   1855ec519:	0f 11 45 e8          	movups XMMWORD PTR [rbp-0x18],xmm0
   1855ec51d:	48 c7 85 e8 04 00 00 	mov    QWORD PTR [rbp+0x4e8],0x0
   1855ec524:	00 00 00 00 
   1855ec528:	48 c7 85 f0 04 00 00 	mov    QWORD PTR [rbp+0x4f0],0xf
   1855ec52f:	0f 00 00 00 
   1855ec533:	c6 85 d8 04 00 00 00 	mov    BYTE PTR [rbp+0x4d8],0x0
   1855ec53a:	c6 45 08 01          	mov    BYTE PTR [rbp+0x8],0x1
   1855ec53e:	40 b6 01             	mov    sil,0x1
   1855ec541:	eb 02                	jmp    0x1855ec545
   1855ec543:	31 f6                	xor    esi,esi
   1855ec545:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   1855ec549:	e8 e2 62 ff ff       	call   0x1855e2830
   1855ec54e:	90                   	nop
   1855ec54f:	80 bd 90 04 00 00 01 	cmp    BYTE PTR [rbp+0x490],0x1
   1855ec556:	0f 85 8a 00 00 00    	jne    0x1855ec5e6
   1855ec55c:	48 8b 85 88 04 00 00 	mov    rax,QWORD PTR [rbp+0x488]
   1855ec563:	48 83 f8 10          	cmp    rax,0x10
   1855ec567:	72 38                	jb     0x1855ec5a1
   1855ec569:	48 8b 8d 70 04 00 00 	mov    rcx,QWORD PTR [rbp+0x470]
   1855ec570:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ec574:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ec57b:	72 1f                	jb     0x1855ec59c
   1855ec57d:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ec581:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ec585:	4c 29 c1             	sub    rcx,r8
   1855ec588:	48 83 f9 20          	cmp    rcx,0x20
   1855ec58c:	0f 83 35 04 00 00    	jae    0x1855ec9c7
   1855ec592:	48 83 c0 28          	add    rax,0x28
   1855ec596:	48 89 c2             	mov    rdx,rax
   1855ec599:	4c 89 c1             	mov    rcx,r8
   1855ec59c:	e8 7f f7 f5 01       	call   0x18754bd20
   1855ec5a1:	48 8b 85 58 04 00 00 	mov    rax,QWORD PTR [rbp+0x458]
   1855ec5a8:	48 83 f8 10          	cmp    rax,0x10
   1855ec5ac:	72 38                	jb     0x1855ec5e6
   1855ec5ae:	48 8b 8d 40 04 00 00 	mov    rcx,QWORD PTR [rbp+0x440]
   1855ec5b5:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ec5b9:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ec5c0:	72 1f                	jb     0x1855ec5e1
   1855ec5c2:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ec5c6:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ec5ca:	4c 29 c1             	sub    rcx,r8
   1855ec5cd:	48 83 f9 20          	cmp    rcx,0x20
   1855ec5d1:	0f 83 f0 03 00 00    	jae    0x1855ec9c7
   1855ec5d7:	48 83 c0 28          	add    rax,0x28
   1855ec5db:	48 89 c2             	mov    rdx,rax
   1855ec5de:	4c 89 c1             	mov    rcx,r8
   1855ec5e1:	e8 3a f7 f5 01       	call   0x18754bd20
   1855ec5e6:	40 84 f6             	test   sil,sil
   1855ec5e9:	0f 84 2c 03 00 00    	je     0x1855ec91b
   1855ec5ef:	48 8b 85 f0 04 00 00 	mov    rax,QWORD PTR [rbp+0x4f0]
   1855ec5f6:	48 83 f8 10          	cmp    rax,0x10
   1855ec5fa:	0f 82 1b 03 00 00    	jb     0x1855ec91b
   1855ec600:	48 8b 8d d8 04 00 00 	mov    rcx,QWORD PTR [rbp+0x4d8]
   1855ec607:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ec60b:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ec612:	0f 82 fe 02 00 00    	jb     0x1855ec916
   1855ec618:	e9 da 02 00 00       	jmp    0x1855ec8f7
   1855ec61d:	48 8d 46 18          	lea    rax,[rsi+0x18]
   1855ec621:	48 89 85 b0 04 00 00 	mov    QWORD PTR [rbp+0x4b0],rax
   1855ec628:	c6 85 b8 04 00 00 00 	mov    BYTE PTR [rbp+0x4b8],0x0
   1855ec62f:	0f 57 c0             	xorps  xmm0,xmm0
   1855ec632:	0f 11 85 30 04 00 00 	movups XMMWORD PTR [rbp+0x430],xmm0
   1855ec639:	0f 11 85 20 04 00 00 	movups XMMWORD PTR [rbp+0x420],xmm0
   1855ec640:	0f 11 85 10 04 00 00 	movups XMMWORD PTR [rbp+0x410],xmm0
   1855ec647:	0f 11 85 00 04 00 00 	movups XMMWORD PTR [rbp+0x400],xmm0
   1855ec64e:	0f 11 85 f0 03 00 00 	movups XMMWORD PTR [rbp+0x3f0],xmm0
   1855ec655:	0f 11 85 e0 03 00 00 	movups XMMWORD PTR [rbp+0x3e0],xmm0
   1855ec65c:	0f 11 85 d0 03 00 00 	movups XMMWORD PTR [rbp+0x3d0],xmm0
   1855ec663:	48 8d 85 b0 04 00 00 	lea    rax,[rbp+0x4b0]
   1855ec66a:	48 89 85 c0 03 00 00 	mov    QWORD PTR [rbp+0x3c0],rax
   1855ec671:	48 8d 85 40 04 00 00 	lea    rax,[rbp+0x440]
   1855ec678:	48 89 85 c8 03 00 00 	mov    QWORD PTR [rbp+0x3c8],rax
   1855ec67f:	48 8d 15 42 a7 41 04 	lea    rdx,[rip+0x441a742]        # 0x189a06dc8
   1855ec686:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1855ec68a:	4c 8d 85 c0 03 00 00 	lea    r8,[rbp+0x3c0]
   1855ec691:	e8 7a 11 a8 fa       	call   0x18006d810
   1855ec696:	90                   	nop
   1855ec697:	48 8b 85 18 03 00 00 	mov    rax,QWORD PTR [rbp+0x318]
   1855ec69e:	48 83 f8 10          	cmp    rax,0x10
   1855ec6a2:	72 38                	jb     0x1855ec6dc
   1855ec6a4:	48 8b 8d 00 03 00 00 	mov    rcx,QWORD PTR [rbp+0x300]
   1855ec6ab:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ec6af:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ec6b6:	72 1f                	jb     0x1855ec6d7
   1855ec6b8:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ec6bc:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ec6c0:	4c 29 c1             	sub    rcx,r8
   1855ec6c3:	48 83 f9 20          	cmp    rcx,0x20
   1855ec6c7:	0f 83 fa 02 00 00    	jae    0x1855ec9c7
   1855ec6cd:	48 83 c0 28          	add    rax,0x28
   1855ec6d1:	48 89 c2             	mov    rdx,rax
   1855ec6d4:	4c 89 c1             	mov    rcx,r8
   1855ec6d7:	e8 44 f6 f5 01       	call   0x18754bd20
   1855ec6dc:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1855ec6e0:	e8 8b 0c a8 fa       	call   0x18006d370
   1855ec6e5:	48 8b 85 c8 02 00 00 	mov    rax,QWORD PTR [rbp+0x2c8]
   1855ec6ec:	48 83 f8 10          	cmp    rax,0x10
   1855ec6f0:	72 38                	jb     0x1855ec72a
   1855ec6f2:	48 8b 8d b0 02 00 00 	mov    rcx,QWORD PTR [rbp+0x2b0]
   1855ec6f9:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ec6fd:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ec704:	72 1f                	jb     0x1855ec725
   1855ec706:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ec70a:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ec70e:	4c 29 c1             	sub    rcx,r8
   1855ec711:	48 83 f9 20          	cmp    rcx,0x20
   1855ec715:	0f 83 ac 02 00 00    	jae    0x1855ec9c7
   1855ec71b:	48 83 c0 28          	add    rax,0x28
   1855ec71f:	48 89 c2             	mov    rdx,rax
   1855ec722:	4c 89 c1             	mov    rcx,r8
   1855ec725:	e8 f6 f5 f5 01       	call   0x18754bd20
   1855ec72a:	48 8b 76 08          	mov    rsi,QWORD PTR [rsi+0x8]
   1855ec72e:	48 8d 8d 70 03 00 00 	lea    rcx,[rbp+0x370]
   1855ec735:	48 8d bd 40 04 00 00 	lea    rdi,[rbp+0x440]
   1855ec73c:	48 89 fa             	mov    rdx,rdi
   1855ec73f:	e8 1c 45 b2 fa       	call   0x180110c60
   1855ec744:	90                   	nop
   1855ec745:	4c 8b 85 50 04 00 00 	mov    r8,QWORD PTR [rbp+0x450]
   1855ec74c:	48 8b 85 58 04 00 00 	mov    rax,QWORD PTR [rbp+0x458]
   1855ec753:	48 89 c1             	mov    rcx,rax
   1855ec756:	4c 29 c1             	sub    rcx,r8
   1855ec759:	48 83 f9 19          	cmp    rcx,0x19
   1855ec75d:	73 32                	jae    0x1855ec791
   1855ec75f:	48 8d 05 5a 87 41 04 	lea    rax,[rip+0x441875a]        # 0x189a04ec0
   1855ec766:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855ec76b:	48 c7 44 24 28 19 00 	mov    QWORD PTR [rsp+0x28],0x19
   1855ec772:	00 00 
   1855ec774:	48 8d 8d 40 04 00 00 	lea    rcx,[rbp+0x440]
   1855ec77b:	ba 19 00 00 00       	mov    edx,0x19
   1855ec780:	45 31 c9             	xor    r9d,r9d
   1855ec783:	e8 c8 f5 a1 fa       	call   0x18000bd50
   1855ec788:	90                   	nop
   1855ec789:	48 89 c7             	mov    rdi,rax
   1855ec78c:	e9 96 00 00 00       	jmp    0x1855ec827
   1855ec791:	49 8d 48 19          	lea    rcx,[r8+0x19]
   1855ec795:	48 89 8d 50 04 00 00 	mov    QWORD PTR [rbp+0x450],rcx
   1855ec79c:	48 83 f8 10          	cmp    rax,0x10
   1855ec7a0:	48 8b 8d 40 04 00 00 	mov    rcx,QWORD PTR [rbp+0x440]
   1855ec7a7:	48 89 fb             	mov    rbx,rdi
   1855ec7aa:	48 0f 43 d9          	cmovae rbx,rcx
   1855ec7ae:	48 8d 15 24 87 41 04 	lea    rdx,[rip+0x4418724]        # 0x189a04ed9
   1855ec7b5:	48 39 d3             	cmp    rbx,rdx
   1855ec7b8:	0f 93 c2             	setae  dl
   1855ec7bb:	4c 8d 35 fe 86 41 04 	lea    r14,[rip+0x44186fe]        # 0x189a04ec0
   1855ec7c2:	4e 8d 0c 03          	lea    r9,[rbx+r8*1]
   1855ec7c6:	4d 39 f1             	cmp    r9,r14
   1855ec7c9:	41 0f 92 c1          	setb   r9b
   1855ec7cd:	41 08 d1             	or     r9b,dl
   1855ec7d0:	41 bf 19 00 00 00    	mov    r15d,0x19
   1855ec7d6:	41 bc 19 00 00 00    	mov    r12d,0x19
   1855ec7dc:	75 0b                	jne    0x1855ec7e9
   1855ec7de:	49 89 dc             	mov    r12,rbx
   1855ec7e1:	4d 29 f4             	sub    r12,r14
   1855ec7e4:	77 03                	ja     0x1855ec7e9
   1855ec7e6:	45 31 e4             	xor    r12d,r12d
   1855ec7e9:	49 ff c0             	inc    r8
   1855ec7ec:	48 83 f8 10          	cmp    rax,0x10
   1855ec7f0:	48 0f 42 cf          	cmovb  rcx,rdi
   1855ec7f4:	48 83 c1 19          	add    rcx,0x19
   1855ec7f8:	48 89 da             	mov    rdx,rbx
   1855ec7fb:	e8 40 86 12 02       	call   0x187714e40
   1855ec800:	48 89 d9             	mov    rcx,rbx
   1855ec803:	4c 89 f2             	mov    rdx,r14
   1855ec806:	4d 89 e0             	mov    r8,r12
   1855ec809:	e8 32 86 12 02       	call   0x187714e40
   1855ec80e:	4d 29 e7             	sub    r15,r12
   1855ec811:	4b 8d 14 34          	lea    rdx,[r12+r14*1]
   1855ec815:	48 83 c2 19          	add    rdx,0x19
   1855ec819:	4c 01 e3             	add    rbx,r12
   1855ec81c:	48 89 d9             	mov    rcx,rbx
   1855ec81f:	4d 89 f8             	mov    r8,r15
   1855ec822:	e8 19 86 12 02       	call   0x187714e40
   1855ec827:	0f 10 07             	movups xmm0,XMMWORD PTR [rdi]
   1855ec82a:	0f 10 4f 10          	movups xmm1,XMMWORD PTR [rdi+0x10]
   1855ec82e:	0f 29 8d d0 03 00 00 	movaps XMMWORD PTR [rbp+0x3d0],xmm1
   1855ec835:	0f 29 85 c0 03 00 00 	movaps XMMWORD PTR [rbp+0x3c0],xmm0
   1855ec83c:	48 c7 47 10 00 00 00 	mov    QWORD PTR [rdi+0x10],0x0
   1855ec843:	00 
   1855ec844:	48 c7 47 18 0f 00 00 	mov    QWORD PTR [rdi+0x18],0xf
   1855ec84b:	00 
   1855ec84c:	c6 07 00             	mov    BYTE PTR [rdi],0x0
   1855ec84f:	0f 29 75 d0          	movaps XMMWORD PTR [rbp-0x30],xmm6
   1855ec853:	0f 29 75 e0          	movaps XMMWORD PTR [rbp-0x20],xmm6
   1855ec857:	0f 29 75 00          	movaps XMMWORD PTR [rbp+0x0],xmm6
   1855ec85b:	0f 29 75 c0          	movaps XMMWORD PTR [rbp-0x40],xmm6
   1855ec85f:	0f 29 75 f0          	movaps XMMWORD PTR [rbp-0x10],xmm6
   1855ec863:	c6 45 d0 00          	mov    BYTE PTR [rbp-0x30],0x0
   1855ec867:	c6 45 e0 00          	mov    BYTE PTR [rbp-0x20],0x0
   1855ec86b:	c6 45 08 00          	mov    BYTE PTR [rbp+0x8],0x0
   1855ec86f:	c6 45 c0 00          	mov    BYTE PTR [rbp-0x40],0x0
   1855ec873:	48 8d 4d e8          	lea    rcx,[rbp-0x18]
   1855ec877:	48 8d 95 c0 03 00 00 	lea    rdx,[rbp+0x3c0]
   1855ec87e:	e8 6d 87 3a fc       	call   0x181994ff0
   1855ec883:	90                   	nop
   1855ec884:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   1855ec888:	48 89 f1             	mov    rcx,rsi
   1855ec88b:	e8 a0 5f ff ff       	call   0x1855e2830
   1855ec890:	90                   	nop
   1855ec891:	48 8b 85 d8 03 00 00 	mov    rax,QWORD PTR [rbp+0x3d8]
   1855ec898:	48 83 f8 10          	cmp    rax,0x10
   1855ec89c:	72 38                	jb     0x1855ec8d6
   1855ec89e:	48 8b 8d c0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3c0]
   1855ec8a5:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ec8a9:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ec8b0:	72 1f                	jb     0x1855ec8d1
   1855ec8b2:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ec8b6:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ec8ba:	4c 29 c1             	sub    rcx,r8
   1855ec8bd:	48 83 f9 20          	cmp    rcx,0x20
   1855ec8c1:	0f 83 00 01 00 00    	jae    0x1855ec9c7
   1855ec8c7:	48 83 c0 28          	add    rax,0x28
   1855ec8cb:	48 89 c2             	mov    rdx,rax
   1855ec8ce:	4c 89 c1             	mov    rcx,r8
   1855ec8d1:	e8 4a f4 f5 01       	call   0x18754bd20
   1855ec8d6:	48 8b 85 58 04 00 00 	mov    rax,QWORD PTR [rbp+0x458]
   1855ec8dd:	48 83 f8 10          	cmp    rax,0x10
   1855ec8e1:	72 38                	jb     0x1855ec91b
   1855ec8e3:	48 8b 8d 40 04 00 00 	mov    rcx,QWORD PTR [rbp+0x440]
   1855ec8ea:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ec8ee:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ec8f5:	72 1f                	jb     0x1855ec916
   1855ec8f7:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ec8fb:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ec8ff:	4c 29 c1             	sub    rcx,r8
   1855ec902:	48 83 f9 20          	cmp    rcx,0x20
   1855ec906:	0f 83 bb 00 00 00    	jae    0x1855ec9c7
   1855ec90c:	48 83 c0 28          	add    rax,0x28
   1855ec910:	48 89 c2             	mov    rdx,rax
   1855ec913:	4c 89 c1             	mov    rcx,r8
   1855ec916:	e8 05 f4 f5 01       	call   0x18754bd20
   1855ec91b:	48 8b b5 a0 03 00 00 	mov    rsi,QWORD PTR [rbp+0x3a0]
   1855ec922:	48 85 f6             	test   rsi,rsi
   1855ec925:	74 1d                	je     0x1855ec944
   1855ec927:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855ec92b:	75 17                	jne    0x1855ec944
   1855ec92d:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ec930:	48 89 f1             	mov    rcx,rsi
   1855ec933:	ff 10                	call   QWORD PTR [rax]
   1855ec935:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855ec939:	75 09                	jne    0x1855ec944
   1855ec93b:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ec93e:	48 89 f1             	mov    rcx,rsi
   1855ec941:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ec944:	48 8b 85 90 03 00 00 	mov    rax,QWORD PTR [rbp+0x390]
   1855ec94b:	48 83 f8 10          	cmp    rax,0x10
   1855ec94f:	72 34                	jb     0x1855ec985
   1855ec951:	48 8b 8d 78 03 00 00 	mov    rcx,QWORD PTR [rbp+0x378]
   1855ec958:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ec95c:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ec963:	72 1b                	jb     0x1855ec980
   1855ec965:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ec969:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ec96d:	4c 29 c1             	sub    rcx,r8
   1855ec970:	48 83 f9 20          	cmp    rcx,0x20
   1855ec974:	73 51                	jae    0x1855ec9c7
   1855ec976:	48 83 c0 28          	add    rax,0x28
   1855ec97a:	48 89 c2             	mov    rdx,rax
   1855ec97d:	4c 89 c1             	mov    rcx,r8
   1855ec980:	e8 9b f3 f5 01       	call   0x18754bd20
   1855ec985:	48 8b b5 a8 04 00 00 	mov    rsi,QWORD PTR [rbp+0x4a8]
   1855ec98c:	48 85 f6             	test   rsi,rsi
   1855ec98f:	74 1d                	je     0x1855ec9ae
   1855ec991:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855ec995:	75 17                	jne    0x1855ec9ae
   1855ec997:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ec99a:	48 89 f1             	mov    rcx,rsi
   1855ec99d:	ff 10                	call   QWORD PTR [rax]
   1855ec99f:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855ec9a3:	75 09                	jne    0x1855ec9ae
   1855ec9a5:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ec9a8:	48 89 f1             	mov    rcx,rsi
   1855ec9ab:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855ec9ae:	0f 28 b5 10 05 00 00 	movaps xmm6,XMMWORD PTR [rbp+0x510]
   1855ec9b5:	48 81 c4 a0 05 00 00 	add    rsp,0x5a0
   1855ec9bc:	5b                   	pop    rbx
   1855ec9bd:	5f                   	pop    rdi
   1855ec9be:	5e                   	pop    rsi
   1855ec9bf:	41 5c                	pop    r12
   1855ec9c1:	41 5e                	pop    r14
   1855ec9c3:	41 5f                	pop    r15
   1855ec9c5:	5d                   	pop    rbp
   1855ec9c6:	c3                   	ret
   1855ec9c7:	e8 c0 17 0f 02       	call   0x1876de18c
   1855ec9cc:	cc                   	int3
