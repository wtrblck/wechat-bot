
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001839de3c0 <.text+0x39dd3c0>:
   1839de3c0:	89 91 bc 00 00 00    	mov    DWORD PTR [rcx+0xbc],edx
   1839de3c6:	c3                   	ret
   1839de3c7:	cc                   	int3
   1839de3c8:	cc                   	int3
   1839de3c9:	cc                   	int3
   1839de3ca:	cc                   	int3
   1839de3cb:	cc                   	int3
   1839de3cc:	cc                   	int3
   1839de3cd:	cc                   	int3
   1839de3ce:	cc                   	int3
   1839de3cf:	cc                   	int3
   1839de3d0:	0f b6 81 b8 00 00 00 	movzx  eax,BYTE PTR [rcx+0xb8]
   1839de3d7:	c3                   	ret
   1839de3d8:	cc                   	int3
   1839de3d9:	cc                   	int3
   1839de3da:	cc                   	int3
   1839de3db:	cc                   	int3
   1839de3dc:	cc                   	int3
   1839de3dd:	cc                   	int3
   1839de3de:	cc                   	int3
   1839de3df:	cc                   	int3
   1839de3e0:	55                   	push   rbp
   1839de3e1:	56                   	push   rsi
   1839de3e2:	57                   	push   rdi
   1839de3e3:	53                   	push   rbx
   1839de3e4:	48 83 ec 78          	sub    rsp,0x78
   1839de3e8:	48 8d 6c 24 70       	lea    rbp,[rsp+0x70]
   1839de3ed:	48 c7 45 00 fe ff ff 	mov    QWORD PTR [rbp+0x0],0xfffffffffffffffe
   1839de3f4:	ff
   1839de3f5:	49 89 d1             	mov    r9,rdx
   1839de3f8:	48 89 ce             	mov    rsi,rcx
   1839de3fb:	0f 57 c0             	xorps  xmm0,xmm0
   1839de3fe:	0f 29 45 b0          	movaps XMMWORD PTR [rbp-0x50],xmm0
   1839de402:	48 8b 42 08          	mov    rax,QWORD PTR [rdx+0x8]
   1839de406:	48 85 c0             	test   rax,rax
   1839de409:	74 0a                	je     0x1839de415
   1839de40b:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1839de40f:	49 8b 41 08          	mov    rax,QWORD PTR [r9+0x8]
   1839de413:	eb 02                	jmp    0x1839de417
   1839de415:	31 c0                	xor    eax,eax
   1839de417:	49 8b 09             	mov    rcx,QWORD PTR [r9]
   1839de41a:	48 89 4d b0          	mov    QWORD PTR [rbp-0x50],rcx
   1839de41e:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
   1839de422:	48 8d 55 b0          	lea    rdx,[rbp-0x50]
   1839de426:	48 89 f1             	mov    rcx,rsi
   1839de429:	45 31 c0             	xor    r8d,r8d
   1839de42c:	4c 89 4d f8          	mov    QWORD PTR [rbp-0x8],r9
   1839de430:	e8 8b ae ff ff       	call   0x1839d92c0
   1839de435:	90                   	nop
   1839de436:	48 8d 05 fb 47 d1 05 	lea    rax,[rip+0x5d147fb]        # 0x1896f2c38
   1839de43d:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
   1839de441:	48 89 06             	mov    QWORD PTR [rsi],rax
   1839de444:	0f 28 05 65 87 53 05 	movaps xmm0,XMMWORD PTR [rip+0x5538765]        # 0x188f16bb0
   1839de44b:	0f 29 45 c0          	movaps XMMWORD PTR [rbp-0x40],xmm0
   1839de44f:	ba 18 01 00 00       	mov    edx,0x118
   1839de454:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
   1839de458:	48 03 10             	add    rdx,QWORD PTR [rax]
   1839de45b:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1839de45f:	e8                   	.byte 0xe8
