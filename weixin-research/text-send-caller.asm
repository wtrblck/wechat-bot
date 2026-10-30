
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001855eeec0 <.text+0x55edec0>:
   1855eeec0:	55                   	push   rbp
   1855eeec1:	56                   	push   rsi
   1855eeec2:	57                   	push   rdi
   1855eeec3:	53                   	push   rbx
   1855eeec4:	48 81 ec 28 02 00 00 	sub    rsp,0x228
   1855eeecb:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   1855eeed2:	00
   1855eeed3:	48 c7 85 a0 01 00 00 	mov    QWORD PTR [rbp+0x1a0],0xfffffffffffffffe
   1855eeeda:	fe ff ff ff
   1855eeede:	4c 89 8d 98 01 00 00 	mov    QWORD PTR [rbp+0x198],r9
   1855eeee5:	4c 89 c6             	mov    rsi,r8
   1855eeee8:	48 89 d7             	mov    rdi,rdx
   1855eeeeb:	b9 02 00 00 00       	mov    ecx,0x2
   1855eeef0:	e8 eb de a7 fa       	call   0x18006cde0
   1855eeef5:	85 c0                	test   eax,eax
   1855eeef7:	0f 84 21 01 00 00    	je     0x1855ef01e
   1855eeefd:	48 8d 9d 40 01 00 00 	lea    rbx,[rbp+0x140]
   1855eef04:	48 89 d9             	mov    rcx,rbx
   1855eef07:	e8 04 e0 a7 fa       	call   0x18006cf10
   1855eef0c:	90                   	nop
   1855eef0d:	48 83 bd 58 01 00 00 	cmp    QWORD PTR [rbp+0x158],0x10
   1855eef14:	10
   1855eef15:	72 07                	jb     0x1855eef1e
   1855eef17:	48 8b 9d 40 01 00 00 	mov    rbx,QWORD PTR [rbp+0x140]
   1855eef1e:	48 8d 05 1b 83 41 04 	lea    rax,[rip+0x441831b]        # 0x189a07240
   1855eef25:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855eef2a:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855eef31:	00 00
   1855eef33:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855eef38:	c7 44 24 28 40 00 00 	mov    DWORD PTR [rsp+0x28],0x40
   1855eef3f:	00
   1855eef40:	4c 8d 0d 89 83 41 04 	lea    r9,[rip+0x4418389]        # 0x189a072d0
   1855eef47:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1855eef4b:	ba 02 00 00 00       	mov    edx,0x2
   1855eef50:	49 89 d8             	mov    r8,rbx
   1855eef53:	e8 18 e3 a7 fa       	call   0x18006d270
   1855eef58:	90                   	nop
   1855eef59:	48 83 7e 18 10       	cmp    QWORD PTR [rsi+0x18],0x10
   1855eef5e:	48 89 f0             	mov    rax,rsi
   1855eef61:	72 03                	jb     0x1855eef66
   1855eef63:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855eef66:	48 89 45 50          	mov    QWORD PTR [rbp+0x50],rax
   1855eef6a:	c6 45 58 00          	mov    BYTE PTR [rbp+0x58],0x0
   1855eef6e:	0f 57 c0             	xorps  xmm0,xmm0
   1855eef71:	0f 11 85 08 01 00 00 	movups XMMWORD PTR [rbp+0x108],xmm0
   1855eef78:	0f 11 85 f8 00 00 00 	movups XMMWORD PTR [rbp+0xf8],xmm0
   1855eef7f:	0f 11 85 e8 00 00 00 	movups XMMWORD PTR [rbp+0xe8],xmm0
   1855eef86:	0f 11 85 d8 00 00 00 	movups XMMWORD PTR [rbp+0xd8],xmm0
   1855eef8d:	0f 11 85 c8 00 00 00 	movups XMMWORD PTR [rbp+0xc8],xmm0
   1855eef94:	0f 11 85 b8 00 00 00 	movups XMMWORD PTR [rbp+0xb8],xmm0
   1855eef9b:	0f 11 85 a8 00 00 00 	movups XMMWORD PTR [rbp+0xa8],xmm0
   1855eefa2:	48 c7 85 18 01 00 00 	mov    QWORD PTR [rbp+0x118],0x0
   1855eefa9:	00 00 00 00
   1855eefad:	48 8d 45 50          	lea    rax,[rbp+0x50]
   1855eefb1:	48 89 85 a0 00 00 00 	mov    QWORD PTR [rbp+0xa0],rax
   1855eefb8:	48 8d 15 09 96 40 04 	lea    rdx,[rip+0x4409609]        # 0x1899f85c8
   1855eefbf:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1855eefc3:	4c 8d 85 a0 00 00 00 	lea    r8,[rbp+0xa0]
   1855eefca:	e8 41 e8 a7 fa       	call   0x18006d810
   1855eefcf:	90                   	nop
   1855eefd0:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1855eefd4:	e8 97 e3 a7 fa       	call   0x18006d370
   1855eefd9:	48 8b 85 58 01 00 00 	mov    rax,QWORD PTR [rbp+0x158]
   1855eefe0:	48 83 f8 10          	cmp    rax,0x10
   1855eefe4:	72 38                	jb     0x1855ef01e
   1855eefe6:	48 8b 8d 40 01 00 00 	mov    rcx,QWORD PTR [rbp+0x140]
   1855eefed:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855eeff1:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855eeff8:	72 1f                	jb     0x1855ef019
   1855eeffa:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855eeffe:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ef002:	4c 29 c1             	sub    rcx,r8
   1855ef005:	48 83 f9 20          	cmp    rcx,0x20
   1855ef009:	0f 83 84 02 00 00    	jae    0x1855ef293
   1855ef00f:	48 83 c0 28          	add    rax,0x28
   1855ef013:	48 89 c2             	mov    rdx,rax
   1855ef016:	4c 89 c1             	mov    rcx,r8
   1855ef019:	e8 02 cd f5 01       	call   0x18754bd20
   1855ef01e:	48 b8 aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaaa
   1855ef025:	aa aa aa
   1855ef028:	48 89 85 80 01 00 00 	mov    QWORD PTR [rbp+0x180],rax
   1855ef02f:	0f 28 05 7a 7b 92 03 	movaps xmm0,XMMWORD PTR [rip+0x3927b7a]        # 0x188f16bb0
   1855ef036:	0f 29 85 70 01 00 00 	movaps XMMWORD PTR [rbp+0x170],xmm0
   1855ef03d:	0f 29 85 60 01 00 00 	movaps XMMWORD PTR [rbp+0x160],xmm0
   1855ef044:	0f 29 85 50 01 00 00 	movaps XMMWORD PTR [rbp+0x150],xmm0
   1855ef04b:	0f 29 85 40 01 00 00 	movaps XMMWORD PTR [rbp+0x140],xmm0
   1855ef052:	48 8d 95 40 01 00 00 	lea    rdx,[rbp+0x140]
   1855ef059:	49 89 f8             	mov    r8,rdi
   1855ef05c:	4c 8b 8d 98 01 00 00 	mov    r9,QWORD PTR [rbp+0x198]
   1855ef063:	e8 88 03 00 00       	call   0x1855ef3f0
   1855ef068:	90                   	nop
   1855ef069:	80 bd 80 01 00 00 01 	cmp    BYTE PTR [rbp+0x180],0x1
   1855ef070:	0f 85 fe 01 00 00    	jne    0x1855ef274
   1855ef076:	b9 02 00 00 00       	mov    ecx,0x2
   1855ef07b:	e8 60 dd a7 fa       	call   0x18006cde0
   1855ef080:	85 c0                	test   eax,eax
   1855ef082:	0f 84 21 01 00 00    	je     0x1855ef1a9
   1855ef088:	48 8d bd 20 01 00 00 	lea    rdi,[rbp+0x120]
   1855ef08f:	48 89 f9             	mov    rcx,rdi
   1855ef092:	e8 79 de a7 fa       	call   0x18006cf10
   1855ef097:	90                   	nop
   1855ef098:	48 83 bd 38 01 00 00 	cmp    QWORD PTR [rbp+0x138],0x10
   1855ef09f:	10
   1855ef0a0:	72 07                	jb     0x1855ef0a9
   1855ef0a2:	48 8b bd 20 01 00 00 	mov    rdi,QWORD PTR [rbp+0x120]
   1855ef0a9:	48 8d 05 90 81 41 04 	lea    rax,[rip+0x4418190]        # 0x189a07240
   1855ef0b0:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855ef0b5:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855ef0bc:	00 00
   1855ef0be:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855ef0c3:	c7 44 24 28 49 00 00 	mov    DWORD PTR [rsp+0x28],0x49
   1855ef0ca:	00
   1855ef0cb:	4c 8d 0d fe 81 41 04 	lea    r9,[rip+0x44181fe]        # 0x189a072d0
   1855ef0d2:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1855ef0d6:	ba 02 00 00 00       	mov    edx,0x2
   1855ef0db:	49 89 f8             	mov    r8,rdi
   1855ef0de:	e8 8d e1 a7 fa       	call   0x18006d270
   1855ef0e3:	90                   	nop
   1855ef0e4:	48 83 7e 18 10       	cmp    QWORD PTR [rsi+0x18],0x10
   1855ef0e9:	48 89 f0             	mov    rax,rsi
   1855ef0ec:	72 03                	jb     0x1855ef0f1
   1855ef0ee:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855ef0f1:	48 89 45 50          	mov    QWORD PTR [rbp+0x50],rax
   1855ef0f5:	c6 45 58 00          	mov    BYTE PTR [rbp+0x58],0x0
   1855ef0f9:	0f 57 c0             	xorps  xmm0,xmm0
   1855ef0fc:	0f 11 85 08 01 00 00 	movups XMMWORD PTR [rbp+0x108],xmm0
   1855ef103:	0f 11 85 f8 00 00 00 	movups XMMWORD PTR [rbp+0xf8],xmm0
   1855ef10a:	0f 11 85 e8 00 00 00 	movups XMMWORD PTR [rbp+0xe8],xmm0
   1855ef111:	0f 11 85 d8 00 00 00 	movups XMMWORD PTR [rbp+0xd8],xmm0
   1855ef118:	0f 11 85 c8 00 00 00 	movups XMMWORD PTR [rbp+0xc8],xmm0
   1855ef11f:	0f 11 85 b8 00 00 00 	movups XMMWORD PTR [rbp+0xb8],xmm0
   1855ef126:	0f 11 85 a8 00 00 00 	movups XMMWORD PTR [rbp+0xa8],xmm0
   1855ef12d:	48 c7 85 18 01 00 00 	mov    QWORD PTR [rbp+0x118],0x0
   1855ef134:	00 00 00 00
   1855ef138:	48 8d 45 50          	lea    rax,[rbp+0x50]
   1855ef13c:	48 89 85 a0 00 00 00 	mov    QWORD PTR [rbp+0xa0],rax
   1855ef143:	48 8d 15 3e 95 40 04 	lea    rdx,[rip+0x440953e]        # 0x1899f8688
   1855ef14a:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1855ef14e:	4c 8d 85 a0 00 00 00 	lea    r8,[rbp+0xa0]
   1855ef155:	e8 b6 e6 a7 fa       	call   0x18006d810
   1855ef15a:	90                   	nop
   1855ef15b:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1855ef15f:	e8 0c e2 a7 fa       	call   0x18006d370
   1855ef164:	48 8b 85 38 01 00 00 	mov    rax,QWORD PTR [rbp+0x138]
   1855ef16b:	48 83 f8 10          	cmp    rax,0x10
   1855ef16f:	72 38                	jb     0x1855ef1a9
   1855ef171:	48 8b 8d 20 01 00 00 	mov    rcx,QWORD PTR [rbp+0x120]
   1855ef178:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ef17c:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ef183:	72 1f                	jb     0x1855ef1a4
   1855ef185:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ef189:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ef18d:	4c 29 c1             	sub    rcx,r8
   1855ef190:	48 83 f9 20          	cmp    rcx,0x20
   1855ef194:	0f 83 f9 00 00 00    	jae    0x1855ef293
   1855ef19a:	48 83 c0 28          	add    rax,0x28
   1855ef19e:	48 89 c2             	mov    rdx,rax
   1855ef1a1:	4c 89 c1             	mov    rcx,r8
   1855ef1a4:	e8 77 cb f5 01       	call   0x18754bd20
   1855ef1a9:	48 8b 8d 98 01 00 00 	mov    rcx,QWORD PTR [rbp+0x198]
   1855ef1b0:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   1855ef1b3:	48 89 85 90 01 00 00 	mov    QWORD PTR [rbp+0x190],rax
   1855ef1ba:	48 c7 01 00 00 00 00 	mov    QWORD PTR [rcx],0x0
   1855ef1c1:	f6 85 80 01 00 00 01 	test   BYTE PTR [rbp+0x180],0x1
   1855ef1c8:	0f 84 bf 00 00 00    	je     0x1855ef28d
   1855ef1ce:	48 8d 95 40 01 00 00 	lea    rdx,[rbp+0x140]
   1855ef1d5:	4c 8d 8d 90 01 00 00 	lea    r9,[rbp+0x190]
   1855ef1dc:	49 89 f0             	mov    r8,rsi
   1855ef1df:	e8 9c 11 00 00       	call   0x1855f0380
   1855ef1e4:	90                   	nop
   1855ef1e5:	80 bd 80 01 00 00 01 	cmp    BYTE PTR [rbp+0x180],0x1
   1855ef1ec:	0f 85 82 00 00 00    	jne    0x1855ef274
   1855ef1f2:	48 8b 85 78 01 00 00 	mov    rax,QWORD PTR [rbp+0x178]
   1855ef1f9:	48 83 f8 10          	cmp    rax,0x10
   1855ef1fd:	72 34                	jb     0x1855ef233
   1855ef1ff:	48 8b 8d 60 01 00 00 	mov    rcx,QWORD PTR [rbp+0x160]
   1855ef206:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ef20a:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ef211:	72 1b                	jb     0x1855ef22e
   1855ef213:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ef217:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ef21b:	4c 29 c1             	sub    rcx,r8
   1855ef21e:	48 83 f9 20          	cmp    rcx,0x20
   1855ef222:	73 6f                	jae    0x1855ef293
   1855ef224:	48 83 c0 28          	add    rax,0x28
   1855ef228:	48 89 c2             	mov    rdx,rax
   1855ef22b:	4c 89 c1             	mov    rcx,r8
   1855ef22e:	e8 ed ca f5 01       	call   0x18754bd20
   1855ef233:	48 8b 85 58 01 00 00 	mov    rax,QWORD PTR [rbp+0x158]
   1855ef23a:	48 83 f8 10          	cmp    rax,0x10
   1855ef23e:	72 34                	jb     0x1855ef274
   1855ef240:	48 8b 8d 40 01 00 00 	mov    rcx,QWORD PTR [rbp+0x140]
   1855ef247:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855ef24b:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855ef252:	72 1b                	jb     0x1855ef26f
   1855ef254:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855ef258:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855ef25c:	4c 29 c1             	sub    rcx,r8
   1855ef25f:	48 83 f9 20          	cmp    rcx,0x20
   1855ef263:	73 2e                	jae    0x1855ef293
   1855ef265:	48 83 c0 28          	add    rax,0x28
   1855ef269:	48 89 c2             	mov    rdx,rax
   1855ef26c:	4c 89 c1             	mov    rcx,r8
   1855ef26f:	e8 ac ca f5 01       	call   0x18754bd20
   1855ef274:	48 8b 8d 98 01 00 00 	mov    rcx,QWORD PTR [rbp+0x198]
   1855ef27b:	e8 f0 d7 b1 fa       	call   0x18010ca70
   1855ef280:	90                   	nop
   1855ef281:	48 81 c4 28 02 00 00 	add    rsp,0x228
   1855ef288:	5b                   	pop    rbx
   1855ef289:	5f                   	pop    rdi
   1855ef28a:	5e                   	pop    rsi
   1855ef28b:	5d                   	pop    rbp
   1855ef28c:	c3                   	ret
   1855ef28d:	e8 be eb e8 fa       	call   0x18047de50
   1855ef292:	90                   	nop
   1855ef293:	e8 f4 ee 0e 02       	call   0x1876de18c
   1855ef298:	cc                   	int3
