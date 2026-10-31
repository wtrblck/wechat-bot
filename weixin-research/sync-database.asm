
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001838e9f80 <.text+0x38e8f80>:
   1838e9f80:	55                   	push   rbp
   1838e9f81:	41 57                	push   r15
   1838e9f83:	41 56                	push   r14
   1838e9f85:	41 55                	push   r13
   1838e9f87:	41 54                	push   r12
   1838e9f89:	56                   	push   rsi
   1838e9f8a:	57                   	push   rdi
   1838e9f8b:	53                   	push   rbx
   1838e9f8c:	48 81 ec 98 0b 00 00 	sub    rsp,0xb98
   1838e9f93:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   1838e9f9a:	00 
   1838e9f9b:	44 0f 29 85 00 0b 00 	movaps XMMWORD PTR [rbp+0xb00],xmm8
   1838e9fa2:	00 
   1838e9fa3:	0f 29 bd f0 0a 00 00 	movaps XMMWORD PTR [rbp+0xaf0],xmm7
   1838e9faa:	0f 29 b5 e0 0a 00 00 	movaps XMMWORD PTR [rbp+0xae0],xmm6
   1838e9fb1:	48 c7 85 d8 0a 00 00 	mov    QWORD PTR [rbp+0xad8],0xfffffffffffffffe
   1838e9fb8:	fe ff ff ff 
   1838e9fbc:	49 89 d6             	mov    r14,rdx
   1838e9fbf:	48 89 8d a8 0a 00 00 	mov    QWORD PTR [rbp+0xaa8],rcx
   1838e9fc6:	49 8b 00             	mov    rax,QWORD PTR [r8]
   1838e9fc9:	49 3b 40 08          	cmp    rax,QWORD PTR [r8+0x8]
   1838e9fcd:	0f 84 a7 00 00 00    	je     0x1838ea07a
   1838e9fd3:	4c 89 c6             	mov    rsi,r8
   1838e9fd6:	0f 28 35 d3 cb 62 05 	movaps xmm6,XMMWORD PTR [rip+0x562cbd3]        # 0x188f16bb0
   1838e9fdd:	0f 29 b5 00 08 00 00 	movaps XMMWORD PTR [rbp+0x800],xmm6
   1838e9fe4:	48 8d 15 cd ae df 05 	lea    rdx,[rip+0x5dfaecd]        # 0x1896e4eb8
   1838e9feb:	4c 8d 05 5e ab df 05 	lea    r8,[rip+0x5dfab5e]        # 0x1896e4b50
   1838e9ff2:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1838e9ff6:	41 b9 61 00 00 00    	mov    r9d,0x61
   1838e9ffc:	e8 ef 7b 8b fc       	call   0x1801a1bf0
   1838ea001:	c7 85 00 08 00 00 02 	mov    DWORD PTR [rbp+0x800],0x2
   1838ea008:	00 00 00 
   1838ea00b:	48 c7 85 10 08 00 00 	mov    QWORD PTR [rbp+0x810],0x0
   1838ea012:	00 00 00 00 
   1838ea016:	0f 28 45 c0          	movaps xmm0,XMMWORD PTR [rbp-0x40]
   1838ea01a:	0f 11 85 18 08 00 00 	movups XMMWORD PTR [rbp+0x818],xmm0
   1838ea021:	0f 57 c0             	xorps  xmm0,xmm0
   1838ea024:	0f 11 85 28 08 00 00 	movups XMMWORD PTR [rbp+0x828],xmm0
   1838ea02b:	48 c7 85 38 08 00 00 	mov    QWORD PTR [rbp+0x838],0x0
   1838ea032:	00 00 00 00 
   1838ea036:	48 c7 85 40 08 00 00 	mov    QWORD PTR [rbp+0x840],0xf
   1838ea03d:	0f 00 00 00 
   1838ea041:	e8 aa fd 0e fd       	call   0x1809d9df0
   1838ea046:	90                   	nop
   1838ea047:	48 89 85 08 08 00 00 	mov    QWORD PTR [rbp+0x808],rax
   1838ea04e:	48 83 bd 40 08 00 00 	cmp    QWORD PTR [rbp+0x840],0x19
   1838ea055:	19 
   1838ea056:	0f 83 aa 01 00 00    	jae    0x1838ea206
   1838ea05c:	4c 8d 0d 8d 78 df 05 	lea    r9,[rip+0x5df788d]        # 0x1896e18f0
   1838ea063:	ba 19 00 00 00       	mov    edx,0x19
   1838ea068:	48 8d 8d 28 08 00 00 	lea    rcx,[rbp+0x828]
   1838ea06f:	e8 dc 40 75 fc       	call   0x18003e150
   1838ea074:	90                   	nop
   1838ea075:	e9 b7 01 00 00       	jmp    0x1838ea231
   1838ea07a:	b9 03 00 00 00       	mov    ecx,0x3
   1838ea07f:	e8 5c 2d 78 fc       	call   0x18006cde0
   1838ea084:	85 c0                	test   eax,eax
   1838ea086:	0f 84 fc 00 00 00    	je     0x1838ea188
   1838ea08c:	48 8d b5 20 0a 00 00 	lea    rsi,[rbp+0xa20]
   1838ea093:	48 89 f1             	mov    rcx,rsi
   1838ea096:	e8 75 2e 78 fc       	call   0x18006cf10
   1838ea09b:	48 83 bd 38 0a 00 00 	cmp    QWORD PTR [rbp+0xa38],0x10
   1838ea0a2:	10 
   1838ea0a3:	72 07                	jb     0x1838ea0ac
   1838ea0a5:	48 8b b5 20 0a 00 00 	mov    rsi,QWORD PTR [rbp+0xa20]
   1838ea0ac:	48 8d 05 85 a8 df 05 	lea    rax,[rip+0x5dfa885]        # 0x1896e4938
   1838ea0b3:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1838ea0b8:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1838ea0bf:	00 00 
   1838ea0c1:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1838ea0c6:	c7 44 24 28 5d 00 00 	mov    DWORD PTR [rsp+0x28],0x5d
   1838ea0cd:	00 
   1838ea0ce:	4c 8d 0d 7b aa df 05 	lea    r9,[rip+0x5dfaa7b]        # 0x1896e4b50
   1838ea0d5:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1838ea0d9:	ba 03 00 00 00       	mov    edx,0x3
   1838ea0de:	49 89 f0             	mov    r8,rsi
   1838ea0e1:	e8 8a 31 78 fc       	call   0x18006d270
   1838ea0e6:	90                   	nop
   1838ea0e7:	0f 57 c0             	xorps  xmm0,xmm0
   1838ea0ea:	0f 29 85 40 09 00 00 	movaps XMMWORD PTR [rbp+0x940],xmm0
   1838ea0f1:	0f 29 85 30 09 00 00 	movaps XMMWORD PTR [rbp+0x930],xmm0
   1838ea0f8:	0f 29 85 20 09 00 00 	movaps XMMWORD PTR [rbp+0x920],xmm0
   1838ea0ff:	0f 29 85 10 09 00 00 	movaps XMMWORD PTR [rbp+0x910],xmm0
   1838ea106:	0f 29 85 00 09 00 00 	movaps XMMWORD PTR [rbp+0x900],xmm0
   1838ea10d:	0f 29 85 f0 08 00 00 	movaps XMMWORD PTR [rbp+0x8f0],xmm0
   1838ea114:	0f 29 85 e0 08 00 00 	movaps XMMWORD PTR [rbp+0x8e0],xmm0
   1838ea11b:	0f 29 85 d0 08 00 00 	movaps XMMWORD PTR [rbp+0x8d0],xmm0
   1838ea122:	48 8d 15 8f aa df 05 	lea    rdx,[rip+0x5dfaa8f]        # 0x1896e4bb8
   1838ea129:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1838ea12d:	4c 8d 85 d0 08 00 00 	lea    r8,[rbp+0x8d0]
   1838ea134:	e8 d7 36 78 fc       	call   0x18006d810
   1838ea139:	90                   	nop
   1838ea13a:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1838ea13e:	e8 2d 32 78 fc       	call   0x18006d370
   1838ea143:	48 8b 85 38 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa38]
   1838ea14a:	48 83 f8 10          	cmp    rax,0x10
   1838ea14e:	72 38                	jb     0x1838ea188
   1838ea150:	48 8b 8d 20 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xa20]
   1838ea157:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838ea15b:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838ea162:	72 1f                	jb     0x1838ea183
   1838ea164:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838ea168:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838ea16c:	4c 29 c1             	sub    rcx,r8
   1838ea16f:	48 83 f9 20          	cmp    rcx,0x20
   1838ea173:	0f 83 62 2b 00 00    	jae    0x1838eccdb
   1838ea179:	48 83 c0 28          	add    rax,0x28
   1838ea17d:	48 89 c2             	mov    rdx,rax
   1838ea180:	4c 89 c1             	mov    rcx,r8
   1838ea183:	e8 98 1b c6 03       	call   0x18754bd20
   1838ea188:	c7 85 d0 08 00 00 00 	mov    DWORD PTR [rbp+0x8d0],0x0
   1838ea18f:	00 00 00 
   1838ea192:	48 8d 75 c0          	lea    rsi,[rbp-0x40]
   1838ea196:	48 8d 95 d0 08 00 00 	lea    rdx,[rbp+0x8d0]
   1838ea19d:	4c 8d 85 20 0a 00 00 	lea    r8,[rbp+0xa20]
   1838ea1a4:	48 89 f1             	mov    rcx,rsi
   1838ea1a7:	e8 24 98 09 00       	call   0x1839839d0
   1838ea1ac:	90                   	nop
   1838ea1ad:	4c 89 f1             	mov    rcx,r14
   1838ea1b0:	48 89 f2             	mov    rdx,rsi
   1838ea1b3:	e8 48 6e f7 fd       	call   0x181861000
   1838ea1b8:	90                   	nop
   1838ea1b9:	41 c6 46 40 01       	mov    BYTE PTR [r14+0x40],0x1
   1838ea1be:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28]
   1838ea1c2:	48 85 c9             	test   rcx,rcx
   1838ea1c5:	74 31                	je     0x1838ea1f8
   1838ea1c7:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
   1838ea1cb:	48 29 ca             	sub    rdx,rcx
   1838ea1ce:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838ea1d5:	72 1c                	jb     0x1838ea1f3
   1838ea1d7:	48 8b 41 f8          	mov    rax,QWORD PTR [rcx-0x8]
   1838ea1db:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838ea1df:	48 29 c1             	sub    rcx,rax
   1838ea1e2:	48 83 f9 20          	cmp    rcx,0x20
   1838ea1e6:	0f 83 ef 2a 00 00    	jae    0x1838eccdb
   1838ea1ec:	48 83 c2 27          	add    rdx,0x27
   1838ea1f0:	48 89 c1             	mov    rcx,rax
   1838ea1f3:	e8 28 1b c6 03       	call   0x18754bd20
   1838ea1f8:	48 8d 4d c8          	lea    rcx,[rbp-0x38]
   1838ea1fc:	e8 4f 0c f6 fd       	call   0x18184ae50
   1838ea201:	e9 a8 2a 00 00       	jmp    0x1838eccae
   1838ea206:	48 8b 85 28 08 00 00 	mov    rax,QWORD PTR [rbp+0x828]
   1838ea20d:	48 c7 85 38 08 00 00 	mov    QWORD PTR [rbp+0x838],0x19
   1838ea214:	19 00 00 00 
   1838ea218:	0f 10 05 da 76 df 05 	movups xmm0,XMMWORD PTR [rip+0x5df76da]        # 0x1896e18f9
   1838ea21f:	0f 11 40 09          	movups XMMWORD PTR [rax+0x9],xmm0
   1838ea223:	0f 10 05 c6 76 df 05 	movups xmm0,XMMWORD PTR [rip+0x5df76c6]        # 0x1896e18f0
   1838ea22a:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   1838ea22d:	c6 40 19 00          	mov    BYTE PTR [rax+0x19],0x0
   1838ea231:	4c 89 b5 98 08 00 00 	mov    QWORD PTR [rbp+0x898],r14
   1838ea238:	c7 85 c0 07 00 00 ff 	mov    DWORD PTR [rbp+0x7c0],0xffffffff
   1838ea23f:	ff ff ff 
   1838ea242:	0f 11 b5 c4 07 00 00 	movups XMMWORD PTR [rbp+0x7c4],xmm6
   1838ea249:	0f 11 b5 d4 07 00 00 	movups XMMWORD PTR [rbp+0x7d4],xmm6
   1838ea250:	0f 11 b5 e4 07 00 00 	movups XMMWORD PTR [rbp+0x7e4],xmm6
   1838ea257:	0f 11 b5 f0 07 00 00 	movups XMMWORD PTR [rbp+0x7f0],xmm6
   1838ea25e:	c7 45 c0 00 00 00 00 	mov    DWORD PTR [rbp-0x40],0x0
   1838ea265:	48 8d 8d c0 07 00 00 	lea    rcx,[rbp+0x7c0]
   1838ea26c:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   1838ea270:	4c 8d 85 d0 08 00 00 	lea    r8,[rbp+0x8d0]
   1838ea277:	e8 54 97 09 00       	call   0x1839839d0
   1838ea27c:	90                   	nop
   1838ea27d:	48 8b 3e             	mov    rdi,QWORD PTR [rsi]
   1838ea280:	48 89 b5 50 08 00 00 	mov    QWORD PTR [rbp+0x850],rsi
   1838ea287:	4c 8b 6e 08          	mov    r13,QWORD PTR [rsi+0x8]
   1838ea28b:	4c 8d 75 c0          	lea    r14,[rbp-0x40]
   1838ea28f:	4c 8d a5 b0 0a 00 00 	lea    r12,[rbp+0xab0]
   1838ea296:	48 8d 9d 58 08 00 00 	lea    rbx,[rbp+0x858]
   1838ea29d:	48 8d b5 d0 09 00 00 	lea    rsi,[rbp+0x9d0]
   1838ea2a4:	0f 57 ff             	xorps  xmm7,xmm7
   1838ea2a7:	eb 17                	jmp    0x1838ea2c0
   1838ea2a9:	49 83 c7 18          	add    r15,0x18
   1838ea2ad:	4c 89 f9             	mov    rcx,r15
   1838ea2b0:	49 89 f8             	mov    r8,rdi
   1838ea2b3:	e8 c8 57 cb fd       	call   0x18159fa80
   1838ea2b8:	90                   	nop
   1838ea2b9:	48 81 c7 e8 02 00 00 	add    rdi,0x2e8
   1838ea2c0:	4c 39 ef             	cmp    rdi,r13
   1838ea2c3:	0f 84 26 02 00 00    	je     0x1838ea4ef
   1838ea2c9:	48 89 f9             	mov    rcx,rdi
   1838ea2cc:	e8 2f 80 19 fd       	call   0x180a82300
   1838ea2d1:	90                   	nop
   1838ea2d2:	48 89 c1             	mov    rcx,rax
   1838ea2d5:	e8 46 3a ca fd       	call   0x18158dd20
   1838ea2da:	90                   	nop
   1838ea2db:	89 85 b0 0a 00 00    	mov    DWORD PTR [rbp+0xab0],eax
   1838ea2e1:	ff c8                	dec    eax
   1838ea2e3:	83 f8 01             	cmp    eax,0x1
   1838ea2e6:	77 48                	ja     0x1838ea330
   1838ea2e8:	48 8d 8d c0 07 00 00 	lea    rcx,[rbp+0x7c0]
   1838ea2ef:	4c 89 f2             	mov    rdx,r14
   1838ea2f2:	4d 89 e0             	mov    r8,r12
   1838ea2f5:	e8 06 69 f7 fd       	call   0x181860c00
   1838ea2fa:	90                   	nop
   1838ea2fb:	4c 8b 7d c0          	mov    r15,QWORD PTR [rbp-0x40]
   1838ea2ff:	49 8b 57 20          	mov    rdx,QWORD PTR [r15+0x20]
   1838ea303:	49 3b 57 28          	cmp    rdx,QWORD PTR [r15+0x28]
   1838ea307:	74 a0                	je     0x1838ea2a9
   1838ea309:	48 89 d1             	mov    rcx,rdx
   1838ea30c:	48 89 fa             	mov    rdx,rdi
   1838ea30f:	e8 1c 15 8e fc       	call   0x1801cb830
   1838ea314:	90                   	nop
   1838ea315:	49 81 47 20 e8 02 00 	add    QWORD PTR [r15+0x20],0x2e8
   1838ea31c:	00 
   1838ea31d:	48 81 c7 e8 02 00 00 	add    rdi,0x2e8
   1838ea324:	eb 9a                	jmp    0x1838ea2c0
   1838ea326:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
   1838ea32d:	00 00 00 
   1838ea330:	b9 03 00 00 00       	mov    ecx,0x3
   1838ea335:	e8 a6 2a 78 fc       	call   0x18006cde0
   1838ea33a:	85 c0                	test   eax,eax
   1838ea33c:	0f 84 77 ff ff ff    	je     0x1838ea2b9
   1838ea342:	48 89 d9             	mov    rcx,rbx
   1838ea345:	e8 c6 2b 78 fc       	call   0x18006cf10
   1838ea34a:	90                   	nop
   1838ea34b:	48 83 bd 70 08 00 00 	cmp    QWORD PTR [rbp+0x870],0x10
   1838ea352:	10 
   1838ea353:	49 89 d8             	mov    r8,rbx
   1838ea356:	72 07                	jb     0x1838ea35f
   1838ea358:	4c 8b 85 58 08 00 00 	mov    r8,QWORD PTR [rbp+0x858]
   1838ea35f:	48 8d 05 d2 a5 df 05 	lea    rax,[rip+0x5dfa5d2]        # 0x1896e4938
   1838ea366:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1838ea36b:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1838ea372:	00 00 
   1838ea374:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1838ea379:	c7 44 24 28 69 00 00 	mov    DWORD PTR [rsp+0x28],0x69
   1838ea380:	00 
   1838ea381:	4c 89 f1             	mov    rcx,r14
   1838ea384:	ba 03 00 00 00       	mov    edx,0x3
   1838ea389:	4c 8d 0d c0 a7 df 05 	lea    r9,[rip+0x5dfa7c0]        # 0x1896e4b50
   1838ea390:	e8 db 2e 78 fc       	call   0x18006d270
   1838ea395:	90                   	nop
   1838ea396:	48 c7 85 20 0a 00 00 	mov    QWORD PTR [rbp+0xa20],0x0
   1838ea39d:	00 00 00 00 
   1838ea3a1:	44 8b 8d b0 0a 00 00 	mov    r9d,DWORD PTR [rbp+0xab0]
   1838ea3a8:	ba 41 00 00 00       	mov    edx,0x41
   1838ea3ad:	4c 8d bd 28 0a 00 00 	lea    r15,[rbp+0xa28]
   1838ea3b4:	4c 89 f9             	mov    rcx,r15
   1838ea3b7:	4c 8d 05 ce 8d 66 05 	lea    r8,[rip+0x5668dce]        # 0x188f5318c
   1838ea3be:	e8 9d 48 77 fc       	call   0x18005ec60
   1838ea3c3:	4c 89 bd 20 0a 00 00 	mov    QWORD PTR [rbp+0xa20],r15
   1838ea3ca:	48 89 f9             	mov    rcx,rdi
   1838ea3cd:	48 89 f2             	mov    rdx,rsi
   1838ea3d0:	e8 1b 8e 19 fd       	call   0x180a831f0
   1838ea3d5:	90                   	nop
   1838ea3d6:	48 83 bd e8 09 00 00 	cmp    QWORD PTR [rbp+0x9e8],0x10
   1838ea3dd:	10 
   1838ea3de:	48 89 f0             	mov    rax,rsi
   1838ea3e1:	72 07                	jb     0x1838ea3ea
   1838ea3e3:	48 8b 85 d0 09 00 00 	mov    rax,QWORD PTR [rbp+0x9d0]
   1838ea3ea:	48 89 85 60 09 00 00 	mov    QWORD PTR [rbp+0x960],rax
   1838ea3f1:	c6 85 68 09 00 00 00 	mov    BYTE PTR [rbp+0x968],0x0
   1838ea3f8:	48 8d 85 e0 08 00 00 	lea    rax,[rbp+0x8e0]
   1838ea3ff:	0f 11 78 60          	movups XMMWORD PTR [rax+0x60],xmm7
   1838ea403:	0f 11 78 50          	movups XMMWORD PTR [rax+0x50],xmm7
   1838ea407:	0f 11 78 40          	movups XMMWORD PTR [rax+0x40],xmm7
   1838ea40b:	0f 11 78 30          	movups XMMWORD PTR [rax+0x30],xmm7
   1838ea40f:	0f 11 78 20          	movups XMMWORD PTR [rax+0x20],xmm7
   1838ea413:	0f 11 78 10          	movups XMMWORD PTR [rax+0x10],xmm7
   1838ea417:	0f 11 38             	movups XMMWORD PTR [rax],xmm7
   1838ea41a:	48 8d 85 60 09 00 00 	lea    rax,[rbp+0x960]
   1838ea421:	48 89 85 d0 08 00 00 	mov    QWORD PTR [rbp+0x8d0],rax
   1838ea428:	48 8d 85 20 0a 00 00 	lea    rax,[rbp+0xa20]
   1838ea42f:	48 89 85 d8 08 00 00 	mov    QWORD PTR [rbp+0x8d8],rax
   1838ea436:	4c 89 f1             	mov    rcx,r14
   1838ea439:	48 8d 15 a8 a4 df 05 	lea    rdx,[rip+0x5dfa4a8]        # 0x1896e48e8
   1838ea440:	4c 8d 85 d0 08 00 00 	lea    r8,[rbp+0x8d0]
   1838ea447:	e8 c4 33 78 fc       	call   0x18006d810
   1838ea44c:	90                   	nop
   1838ea44d:	48 8b 85 e8 09 00 00 	mov    rax,QWORD PTR [rbp+0x9e8]
   1838ea454:	48 83 f8 10          	cmp    rax,0x10
   1838ea458:	72 38                	jb     0x1838ea492
   1838ea45a:	48 8b 8d d0 09 00 00 	mov    rcx,QWORD PTR [rbp+0x9d0]
   1838ea461:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838ea465:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838ea46c:	72 1f                	jb     0x1838ea48d
   1838ea46e:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838ea472:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838ea476:	4c 29 c1             	sub    rcx,r8
   1838ea479:	48 83 f9 20          	cmp    rcx,0x20
   1838ea47d:	0f 83 58 28 00 00    	jae    0x1838eccdb
   1838ea483:	48 83 c0 28          	add    rax,0x28
   1838ea487:	48 89 c2             	mov    rdx,rax
   1838ea48a:	4c 89 c1             	mov    rcx,r8
   1838ea48d:	e8 8e 18 c6 03       	call   0x18754bd20
   1838ea492:	4c 89 f1             	mov    rcx,r14
   1838ea495:	e8 d6 2e 78 fc       	call   0x18006d370
   1838ea49a:	48 8b 85 70 08 00 00 	mov    rax,QWORD PTR [rbp+0x870]
   1838ea4a1:	48 83 f8 10          	cmp    rax,0x10
   1838ea4a5:	0f 82 0e fe ff ff    	jb     0x1838ea2b9
   1838ea4ab:	48 8b 8d 58 08 00 00 	mov    rcx,QWORD PTR [rbp+0x858]
   1838ea4b2:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838ea4b6:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838ea4bd:	72 1f                	jb     0x1838ea4de
   1838ea4bf:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838ea4c3:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838ea4c7:	4c 29 c1             	sub    rcx,r8
   1838ea4ca:	48 83 f9 20          	cmp    rcx,0x20
   1838ea4ce:	0f 83 07 28 00 00    	jae    0x1838eccdb
   1838ea4d4:	48 83 c0 28          	add    rax,0x28
   1838ea4d8:	48 89 c2             	mov    rdx,rax
   1838ea4db:	4c 89 c1             	mov    rcx,r8
   1838ea4de:	e8 3d 18 c6 03       	call   0x18754bd20
   1838ea4e3:	48 81 c7 e8 02 00 00 	add    rdi,0x2e8
   1838ea4ea:	e9 d1 fd ff ff       	jmp    0x1838ea2c0
   1838ea4ef:	c7 85 58 08 00 00 ff 	mov    DWORD PTR [rbp+0x858],0xffffffff
   1838ea4f6:	ff ff ff 
   1838ea4f9:	0f 11 b5 5c 08 00 00 	movups XMMWORD PTR [rbp+0x85c],xmm6
   1838ea500:	0f 11 b5 6c 08 00 00 	movups XMMWORD PTR [rbp+0x86c],xmm6
   1838ea507:	0f 11 b5 7c 08 00 00 	movups XMMWORD PTR [rbp+0x87c],xmm6
   1838ea50e:	0f 11 b5 88 08 00 00 	movups XMMWORD PTR [rbp+0x888],xmm6
   1838ea515:	c7 45 c0 00 00 00 00 	mov    DWORD PTR [rbp-0x40],0x0
   1838ea51c:	48 8d 8d 58 08 00 00 	lea    rcx,[rbp+0x858]
   1838ea523:	4c 8d 75 c0          	lea    r14,[rbp-0x40]
   1838ea527:	4c 8d bd d0 08 00 00 	lea    r15,[rbp+0x8d0]
   1838ea52e:	4c 89 f2             	mov    rdx,r14
   1838ea531:	4d 89 f8             	mov    r8,r15
   1838ea534:	e8 37 f5 a9 fc       	call   0x180389a70
   1838ea539:	90                   	nop
   1838ea53a:	48 8b 85 d0 07 00 00 	mov    rax,QWORD PTR [rbp+0x7d0]
   1838ea541:	48 85 c0             	test   rax,rax
   1838ea544:	78 0a                	js     0x1838ea550
   1838ea546:	0f 57 c0             	xorps  xmm0,xmm0
   1838ea549:	f3 48 0f 2a c0       	cvtsi2ss xmm0,rax
   1838ea54e:	eb 18                	jmp    0x1838ea568
   1838ea550:	48 89 c1             	mov    rcx,rax
   1838ea553:	48 d1 e9             	shr    rcx,1
   1838ea556:	83 e0 01             	and    eax,0x1
   1838ea559:	48 09 c8             	or     rax,rcx
   1838ea55c:	0f 57 c0             	xorps  xmm0,xmm0
   1838ea55f:	f3 48 0f 2a c0       	cvtsi2ss xmm0,rax
   1838ea564:	f3 0f 58 c0          	addss  xmm0,xmm0
   1838ea568:	f3 0f 10 bd 58 08 00 	movss  xmm7,DWORD PTR [rbp+0x858]
   1838ea56f:	00 
   1838ea570:	f3 0f 5e c7          	divss  xmm0,xmm7
   1838ea574:	e8 97 e3 df 03       	call   0x1876e8910
   1838ea579:	f3 48 0f 2c c0       	cvttss2si rax,xmm0
   1838ea57e:	48 89 c1             	mov    rcx,rax
   1838ea581:	48 c1 f9 3f          	sar    rcx,0x3f
   1838ea585:	f3 44 0f 10 05 52 69 	movss  xmm8,DWORD PTR [rip+0x5666952]        # 0x188f50ee0
   1838ea58c:	66 05 
   1838ea58e:	f3 41 0f 5c c0       	subss  xmm0,xmm8
   1838ea593:	f3 48 0f 2c f0       	cvttss2si rsi,xmm0
   1838ea598:	48 21 ce             	and    rsi,rcx
   1838ea59b:	48 09 c6             	or     rsi,rax
   1838ea59e:	48 8b 85 68 08 00 00 	mov    rax,QWORD PTR [rbp+0x868]
   1838ea5a5:	48 85 c0             	test   rax,rax
   1838ea5a8:	78 0a                	js     0x1838ea5b4
   1838ea5aa:	0f 57 c0             	xorps  xmm0,xmm0
   1838ea5ad:	f3 48 0f 2a c0       	cvtsi2ss xmm0,rax
   1838ea5b2:	eb 18                	jmp    0x1838ea5cc
   1838ea5b4:	48 89 c1             	mov    rcx,rax
   1838ea5b7:	48 d1 e9             	shr    rcx,1
   1838ea5ba:	83 e0 01             	and    eax,0x1
   1838ea5bd:	48 09 c8             	or     rax,rcx
   1838ea5c0:	0f 57 c0             	xorps  xmm0,xmm0
   1838ea5c3:	f3 48 0f 2a c0       	cvtsi2ss xmm0,rax
   1838ea5c8:	f3 0f 58 c0          	addss  xmm0,xmm0
   1838ea5cc:	f3 0f 5e c7          	divss  xmm0,xmm7
   1838ea5d0:	e8 3b e3 df 03       	call   0x1876e8910
   1838ea5d5:	f3 48 0f 2c c0       	cvttss2si rax,xmm0
   1838ea5da:	48 89 c1             	mov    rcx,rax
   1838ea5dd:	48 c1 f9 3f          	sar    rcx,0x3f
   1838ea5e1:	f3 41 0f 5c c0       	subss  xmm0,xmm8
   1838ea5e6:	f3 48 0f 2c d0       	cvttss2si rdx,xmm0
   1838ea5eb:	48 21 ca             	and    rdx,rcx
   1838ea5ee:	48 09 c2             	or     rdx,rax
   1838ea5f1:	48 39 d6             	cmp    rsi,rdx
   1838ea5f4:	48 0f 47 d6          	cmova  rdx,rsi
   1838ea5f8:	48 3b 95 90 08 00 00 	cmp    rdx,QWORD PTR [rbp+0x890]
   1838ea5ff:	76 0d                	jbe    0x1838ea60e
   1838ea601:	48 8d 8d 58 08 00 00 	lea    rcx,[rbp+0x858]
   1838ea608:	e8 83 2a 77 fc       	call   0x18005d090
   1838ea60d:	90                   	nop
   1838ea60e:	48 8b 9d c8 07 00 00 	mov    rbx,QWORD PTR [rbp+0x7c8]
   1838ea615:	0f 57 ff             	xorps  xmm7,xmm7
   1838ea618:	48 8d bd d0 09 00 00 	lea    rdi,[rbp+0x9d0]
   1838ea61f:	49 bd cd cc cc cc cc 	movabs r13,0xcccccccccccccccd
   1838ea626:	cc cc cc 
   1838ea629:	4c 8d 25 40 cc 62 05 	lea    r12,[rip+0x562cc40]        # 0x188f17270
   1838ea630:	48 89 9d 48 08 00 00 	mov    QWORD PTR [rbp+0x848],rbx
   1838ea637:	eb 0e                	jmp    0x1838ea647
   1838ea639:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
   1838ea640:	48 8d bd d0 09 00 00 	lea    rdi,[rbp+0x9d0]
   1838ea647:	48 8b 1b             	mov    rbx,QWORD PTR [rbx]
   1838ea64a:	48 3b 9d 48 08 00 00 	cmp    rbx,QWORD PTR [rbp+0x848]
   1838ea651:	0f 84 45 18 00 00    	je     0x1838ebe9c
   1838ea657:	8b 43 10             	mov    eax,DWORD PTR [rbx+0x10]
   1838ea65a:	89 85 74 0a 00 00    	mov    DWORD PTR [rbp+0xa74],eax
   1838ea660:	b9 02 00 00 00       	mov    ecx,0x2
   1838ea665:	e8 76 27 78 fc       	call   0x18006cde0
   1838ea66a:	85 c0                	test   eax,eax
   1838ea66c:	0f 84 d8 01 00 00    	je     0x1838ea84a
   1838ea672:	48 89 f9             	mov    rcx,rdi
   1838ea675:	e8 96 28 78 fc       	call   0x18006cf10
   1838ea67a:	90                   	nop
   1838ea67b:	48 83 bd e8 09 00 00 	cmp    QWORD PTR [rbp+0x9e8],0x10
   1838ea682:	10 
   1838ea683:	49 89 f8             	mov    r8,rdi
   1838ea686:	72 07                	jb     0x1838ea68f
   1838ea688:	4c 8b 85 d0 09 00 00 	mov    r8,QWORD PTR [rbp+0x9d0]
   1838ea68f:	48 8d 05 a2 a2 df 05 	lea    rax,[rip+0x5dfa2a2]        # 0x1896e4938
   1838ea696:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1838ea69b:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1838ea6a2:	00 00 
   1838ea6a4:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1838ea6a9:	c7 44 24 28 74 00 00 	mov    DWORD PTR [rsp+0x28],0x74
   1838ea6b0:	00 
   1838ea6b1:	4c 89 f1             	mov    rcx,r14
   1838ea6b4:	ba 02 00 00 00       	mov    edx,0x2
   1838ea6b9:	4c 8d 0d 90 a4 df 05 	lea    r9,[rip+0x5dfa490]        # 0x1896e4b50
   1838ea6c0:	e8 ab 2b 78 fc       	call   0x18006d270
   1838ea6c5:	90                   	nop
   1838ea6c6:	48 8b 4b 20          	mov    rcx,QWORD PTR [rbx+0x20]
   1838ea6ca:	48 2b 4b 18          	sub    rcx,QWORD PTR [rbx+0x18]
   1838ea6ce:	48 c1 f9 03          	sar    rcx,0x3
   1838ea6d2:	48 b8 f5 d3 4f 3f fd 	movabs rax,0x4fd3f4fd3f4fd3f5
   1838ea6d9:	f4 d3 4f 
   1838ea6dc:	48 0f af c8          	imul   rcx,rax
   1838ea6e0:	48 c7 85 20 0a 00 00 	mov    QWORD PTR [rbp+0xa20],0x0
   1838ea6e7:	00 00 00 00 
   1838ea6eb:	41 b9 07 00 00 00    	mov    r9d,0x7
   1838ea6f1:	4c 8d 85 27 0a 00 00 	lea    r8,[rbp+0xa27]
   1838ea6f8:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
   1838ea6ff:	00 
   1838ea700:	48 89 c8             	mov    rax,rcx
   1838ea703:	49 f7 e5             	mul    r13
   1838ea706:	48 c1 ea 03          	shr    rdx,0x3
   1838ea70a:	48 8d 04 12          	lea    rax,[rdx+rdx*1]
   1838ea70e:	48 8d 04 80          	lea    rax,[rax+rax*4]
   1838ea712:	4d 89 e2             	mov    r10,r12
   1838ea715:	49 29 c2             	sub    r10,rax
   1838ea718:	41 0f b6 44 0a 23    	movzx  eax,BYTE PTR [r10+rcx*1+0x23]
   1838ea71e:	41 88 40 01          	mov    BYTE PTR [r8+0x1],al
   1838ea722:	49 ff c0             	inc    r8
   1838ea725:	49 ff c1             	inc    r9
   1838ea728:	48 83 f9 09          	cmp    rcx,0x9
   1838ea72c:	48 89 d1             	mov    rcx,rdx
   1838ea72f:	77 cf                	ja     0x1838ea700
   1838ea731:	41 c6 40 01 00       	mov    BYTE PTR [r8+0x1],0x0
   1838ea736:	49 83 f9 09          	cmp    r9,0x9
   1838ea73a:	72 2e                	jb     0x1838ea76a
   1838ea73c:	48 8d 85 29 0a 00 00 	lea    rax,[rbp+0xa29]
   1838ea743:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   1838ea74a:	84 00 00 00 00 00 
   1838ea750:	41 0f b6 08          	movzx  ecx,BYTE PTR [r8]
   1838ea754:	0f b6 50 ff          	movzx  edx,BYTE PTR [rax-0x1]
   1838ea758:	41 88 10             	mov    BYTE PTR [r8],dl
   1838ea75b:	49 ff c8             	dec    r8
   1838ea75e:	88 48 ff             	mov    BYTE PTR [rax-0x1],cl
   1838ea761:	4c 39 c0             	cmp    rax,r8
   1838ea764:	48 8d 40 01          	lea    rax,[rax+0x1]
   1838ea768:	72 e6                	jb     0x1838ea750
   1838ea76a:	48 8d 85 28 0a 00 00 	lea    rax,[rbp+0xa28]
   1838ea771:	48 89 85 20 0a 00 00 	mov    QWORD PTR [rbp+0xa20],rax
   1838ea778:	48 c7 85 60 09 00 00 	mov    QWORD PTR [rbp+0x960],0x0
   1838ea77f:	00 00 00 00 
   1838ea783:	44 8b 8d 74 0a 00 00 	mov    r9d,DWORD PTR [rbp+0xa74]
   1838ea78a:	ba 41 00 00 00       	mov    edx,0x41
   1838ea78f:	48 8d b5 68 09 00 00 	lea    rsi,[rbp+0x968]
   1838ea796:	48 89 f1             	mov    rcx,rsi
   1838ea799:	4c 8d 05 ec 89 66 05 	lea    r8,[rip+0x56689ec]        # 0x188f5318c
   1838ea7a0:	e8 bb 44 77 fc       	call   0x18005ec60
   1838ea7a5:	48 89 b5 60 09 00 00 	mov    QWORD PTR [rbp+0x960],rsi
   1838ea7ac:	48 8d 85 e0 08 00 00 	lea    rax,[rbp+0x8e0]
   1838ea7b3:	0f 11 78 60          	movups XMMWORD PTR [rax+0x60],xmm7
   1838ea7b7:	0f 11 78 50          	movups XMMWORD PTR [rax+0x50],xmm7
   1838ea7bb:	0f 11 78 40          	movups XMMWORD PTR [rax+0x40],xmm7
   1838ea7bf:	0f 11 78 30          	movups XMMWORD PTR [rax+0x30],xmm7
   1838ea7c3:	0f 11 78 20          	movups XMMWORD PTR [rax+0x20],xmm7
   1838ea7c7:	0f 11 78 10          	movups XMMWORD PTR [rax+0x10],xmm7
   1838ea7cb:	0f 11 38             	movups XMMWORD PTR [rax],xmm7
   1838ea7ce:	48 8d 85 60 09 00 00 	lea    rax,[rbp+0x960]
   1838ea7d5:	48 89 85 d0 08 00 00 	mov    QWORD PTR [rbp+0x8d0],rax
   1838ea7dc:	48 8d 85 20 0a 00 00 	lea    rax,[rbp+0xa20]
   1838ea7e3:	48 89 85 d8 08 00 00 	mov    QWORD PTR [rbp+0x8d8],rax
   1838ea7ea:	4c 89 f1             	mov    rcx,r14
   1838ea7ed:	48 8d 15 cc a9 df 05 	lea    rdx,[rip+0x5dfa9cc]        # 0x1896e51c0
   1838ea7f4:	4d 89 f8             	mov    r8,r15
   1838ea7f7:	e8 14 30 78 fc       	call   0x18006d810
   1838ea7fc:	90                   	nop
   1838ea7fd:	4c 89 f1             	mov    rcx,r14
   1838ea800:	e8 6b 2b 78 fc       	call   0x18006d370
   1838ea805:	48 8b 85 e8 09 00 00 	mov    rax,QWORD PTR [rbp+0x9e8]
   1838ea80c:	48 83 f8 10          	cmp    rax,0x10
   1838ea810:	72 38                	jb     0x1838ea84a
   1838ea812:	48 8b 8d d0 09 00 00 	mov    rcx,QWORD PTR [rbp+0x9d0]
   1838ea819:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838ea81d:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838ea824:	72 1f                	jb     0x1838ea845
   1838ea826:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838ea82a:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838ea82e:	4c 29 c1             	sub    rcx,r8
   1838ea831:	48 83 f9 20          	cmp    rcx,0x20
   1838ea835:	0f 83 a0 24 00 00    	jae    0x1838eccdb
   1838ea83b:	48 83 c0 28          	add    rax,0x28
   1838ea83f:	48 89 c2             	mov    rdx,rax
   1838ea842:	4c 89 c1             	mov    rcx,r8
   1838ea845:	e8 d6 14 c6 03       	call   0x18754bd20
   1838ea84a:	8b 85 74 0a 00 00    	mov    eax,DWORD PTR [rbp+0xa74]
   1838ea850:	83 f8 02             	cmp    eax,0x2
   1838ea853:	0f 84 07 02 00 00    	je     0x1838eaa60
   1838ea859:	83 f8 01             	cmp    eax,0x1
   1838ea85c:	0f 85 e5 fd ff ff    	jne    0x1838ea647
   1838ea862:	e8 a9 b4 75 fc       	call   0x180045d10
   1838ea867:	90                   	nop
   1838ea868:	48 89 c1             	mov    rcx,rax
   1838ea86b:	48 8d 95 c0 08 00 00 	lea    rdx,[rbp+0x8c0]
   1838ea872:	e8 99 ca 75 fc       	call   0x180047310
   1838ea877:	90                   	nop
   1838ea878:	48 8b b5 c0 08 00 00 	mov    rsi,QWORD PTR [rbp+0x8c0]
   1838ea87f:	48 8b 85 a8 0a 00 00 	mov    rax,QWORD PTR [rbp+0xaa8]
   1838ea886:	48 89 85 b0 09 00 00 	mov    QWORD PTR [rbp+0x9b0],rax
   1838ea88d:	48 8b 4b 28          	mov    rcx,QWORD PTR [rbx+0x28]
   1838ea891:	48 c7 43 28 00 00 00 	mov    QWORD PTR [rbx+0x28],0x0
   1838ea898:	00 
   1838ea899:	48 8b 53 18          	mov    rdx,QWORD PTR [rbx+0x18]
   1838ea89d:	48 8b 7b 20          	mov    rdi,QWORD PTR [rbx+0x20]
   1838ea8a1:	0f 11 7b 18          	movups XMMWORD PTR [rbx+0x18],xmm7
   1838ea8a5:	48 89 95 d0 0a 00 00 	mov    QWORD PTR [rbp+0xad0],rdx
   1838ea8ac:	48 89 95 b8 09 00 00 	mov    QWORD PTR [rbp+0x9b8],rdx
   1838ea8b3:	48 89 bd c0 09 00 00 	mov    QWORD PTR [rbp+0x9c0],rdi
   1838ea8ba:	48 89 8d 78 0a 00 00 	mov    QWORD PTR [rbp+0xa78],rcx
   1838ea8c1:	48 89 8d c8 09 00 00 	mov    QWORD PTR [rbp+0x9c8],rcx
   1838ea8c8:	48 8d 8d a0 08 00 00 	lea    rcx,[rbp+0x8a0]
   1838ea8cf:	48 8d 15 e2 a5 df 05 	lea    rdx,[rip+0x5dfa5e2]        # 0x1896e4eb8
   1838ea8d6:	4c 8d 05 73 a2 df 05 	lea    r8,[rip+0x5dfa273]        # 0x1896e4b50
   1838ea8dd:	41 b9 76 00 00 00    	mov    r9d,0x76
   1838ea8e3:	e8 08 73 8b fc       	call   0x1801a1bf0
   1838ea8e8:	90                   	nop
   1838ea8e9:	48 8b 4e 10          	mov    rcx,QWORD PTR [rsi+0x10]
   1838ea8ed:	48 85 c9             	test   rcx,rcx
   1838ea8f0:	0f 85 0f 01 00 00    	jne    0x1838eaa05
   1838ea8f6:	b9 04 00 00 00       	mov    ecx,0x4
   1838ea8fb:	e8 e0 24 78 fc       	call   0x18006cde0
   1838ea900:	85 c0                	test   eax,eax
   1838ea902:	0f 84 f4 00 00 00    	je     0x1838ea9fc
   1838ea908:	48 8d 8d 20 0a 00 00 	lea    rcx,[rbp+0xa20]
   1838ea90f:	e8 fc 25 78 fc       	call   0x18006cf10
   1838ea914:	90                   	nop
   1838ea915:	48 83 bd 38 0a 00 00 	cmp    QWORD PTR [rbp+0xa38],0x10
   1838ea91c:	10 
   1838ea91d:	4c 8d 85 20 0a 00 00 	lea    r8,[rbp+0xa20]
   1838ea924:	72 07                	jb     0x1838ea92d
   1838ea926:	4c 8b 85 20 0a 00 00 	mov    r8,QWORD PTR [rbp+0xa20]
   1838ea92d:	48 8d 05 64 89 6e 05 	lea    rax,[rip+0x56e8964]        # 0x188fd3298
   1838ea934:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1838ea939:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1838ea940:	00 00 
   1838ea942:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1838ea947:	c7 44 24 28 3c 00 00 	mov    DWORD PTR [rsp+0x28],0x3c
   1838ea94e:	00 
   1838ea94f:	4c 89 f1             	mov    rcx,r14
   1838ea952:	ba 04 00 00 00       	mov    edx,0x4
   1838ea957:	4c 8d 0d ea 88 6e 05 	lea    r9,[rip+0x56e88ea]        # 0x188fd3248
   1838ea95e:	e8 0d 29 78 fc       	call   0x18006d270
   1838ea963:	90                   	nop
   1838ea964:	0f 29 bd 40 09 00 00 	movaps XMMWORD PTR [rbp+0x940],xmm7
   1838ea96b:	0f 29 bd 30 09 00 00 	movaps XMMWORD PTR [rbp+0x930],xmm7
   1838ea972:	0f 29 bd 20 09 00 00 	movaps XMMWORD PTR [rbp+0x920],xmm7
   1838ea979:	0f 29 bd 10 09 00 00 	movaps XMMWORD PTR [rbp+0x910],xmm7
   1838ea980:	0f 29 bd 00 09 00 00 	movaps XMMWORD PTR [rbp+0x900],xmm7
   1838ea987:	0f 29 bd f0 08 00 00 	movaps XMMWORD PTR [rbp+0x8f0],xmm7
   1838ea98e:	0f 29 bd e0 08 00 00 	movaps XMMWORD PTR [rbp+0x8e0],xmm7
   1838ea995:	0f 29 bd d0 08 00 00 	movaps XMMWORD PTR [rbp+0x8d0],xmm7
   1838ea99c:	4c 89 f1             	mov    rcx,r14
   1838ea99f:	48 8d 15 22 f8 6d 05 	lea    rdx,[rip+0x56df822]        # 0x188fca1c8
   1838ea9a6:	4d 89 f8             	mov    r8,r15
   1838ea9a9:	e8 62 2e 78 fc       	call   0x18006d810
   1838ea9ae:	90                   	nop
   1838ea9af:	4c 89 f1             	mov    rcx,r14
   1838ea9b2:	e8 b9 29 78 fc       	call   0x18006d370
   1838ea9b7:	48 8b 85 38 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa38]
   1838ea9be:	48 83 f8 10          	cmp    rax,0x10
   1838ea9c2:	72 38                	jb     0x1838ea9fc
   1838ea9c4:	48 8b 8d 20 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xa20]
   1838ea9cb:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838ea9cf:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838ea9d6:	72 1f                	jb     0x1838ea9f7
   1838ea9d8:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838ea9dc:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838ea9e0:	4c 29 c1             	sub    rcx,r8
   1838ea9e3:	48 83 f9 20          	cmp    rcx,0x20
   1838ea9e7:	0f 83 ee 22 00 00    	jae    0x1838eccdb
   1838ea9ed:	48 83 c0 28          	add    rax,0x28
   1838ea9f1:	48 89 c2             	mov    rdx,rax
   1838ea9f4:	4c 89 c1             	mov    rcx,r8
   1838ea9f7:	e8 24 13 c6 03       	call   0x18754bd20
   1838ea9fc:	48 8b 4e 10          	mov    rcx,QWORD PTR [rsi+0x10]
   1838eaa00:	48 85 c9             	test   rcx,rcx
   1838eaa03:	74 12                	je     0x1838eaa17
   1838eaa05:	48 83 c1 08          	add    rcx,0x8
   1838eaa09:	e8 c2 0e 4c fd       	call   0x180dab8d0
   1838eaa0e:	90                   	nop
   1838eaa0f:	84 c0                	test   al,al
   1838eaa11:	0f 84 39 02 00 00    	je     0x1838eac50
   1838eaa17:	0f 29 b5 b0 0a 00 00 	movaps XMMWORD PTR [rbp+0xab0],xmm6
   1838eaa1e:	48 8d 8d b0 0a 00 00 	lea    rcx,[rbp+0xab0]
   1838eaa25:	e8 86 0e 77 fc       	call   0x18005b8b0
   1838eaa2a:	90                   	nop
   1838eaa2b:	0f 29 bd 90 0a 00 00 	movaps XMMWORD PTR [rbp+0xa90],xmm7
   1838eaa32:	48 8b 85 b8 0a 00 00 	mov    rax,QWORD PTR [rbp+0xab8]
   1838eaa39:	48 85 c0             	test   rax,rax
   1838eaa3c:	0f 84 44 05 00 00    	je     0x1838eaf86
   1838eaa42:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1838eaa46:	48 8b 85 b8 0a 00 00 	mov    rax,QWORD PTR [rbp+0xab8]
   1838eaa4d:	e9 36 05 00 00       	jmp    0x1838eaf88
   1838eaa52:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   1838eaa59:	1f 84 00 00 00 00 00 
   1838eaa60:	e8 ab b2 75 fc       	call   0x180045d10
   1838eaa65:	90                   	nop
   1838eaa66:	48 89 c1             	mov    rcx,rax
   1838eaa69:	48 8d 95 c0 08 00 00 	lea    rdx,[rbp+0x8c0]
   1838eaa70:	e8 9b c8 75 fc       	call   0x180047310
   1838eaa75:	90                   	nop
   1838eaa76:	48 8b b5 c0 08 00 00 	mov    rsi,QWORD PTR [rbp+0x8c0]
   1838eaa7d:	48 8b 85 a8 0a 00 00 	mov    rax,QWORD PTR [rbp+0xaa8]
   1838eaa84:	48 89 85 b0 09 00 00 	mov    QWORD PTR [rbp+0x9b0],rax
   1838eaa8b:	48 8b 4b 28          	mov    rcx,QWORD PTR [rbx+0x28]
   1838eaa8f:	48 c7 43 28 00 00 00 	mov    QWORD PTR [rbx+0x28],0x0
   1838eaa96:	00 
   1838eaa97:	48 8b 53 18          	mov    rdx,QWORD PTR [rbx+0x18]
   1838eaa9b:	48 8b 7b 20          	mov    rdi,QWORD PTR [rbx+0x20]
   1838eaa9f:	0f 11 7b 18          	movups XMMWORD PTR [rbx+0x18],xmm7
   1838eaaa3:	48 89 95 d0 0a 00 00 	mov    QWORD PTR [rbp+0xad0],rdx
   1838eaaaa:	48 89 95 b8 09 00 00 	mov    QWORD PTR [rbp+0x9b8],rdx
   1838eaab1:	48 89 bd c0 09 00 00 	mov    QWORD PTR [rbp+0x9c0],rdi
   1838eaab8:	48 89 8d 78 0a 00 00 	mov    QWORD PTR [rbp+0xa78],rcx
   1838eaabf:	48 89 8d c8 09 00 00 	mov    QWORD PTR [rbp+0x9c8],rcx
   1838eaac6:	48 8d 8d a0 08 00 00 	lea    rcx,[rbp+0x8a0]
   1838eaacd:	48 8d 15 e4 a3 df 05 	lea    rdx,[rip+0x5dfa3e4]        # 0x1896e4eb8
   1838eaad4:	4c 8d 05 75 a0 df 05 	lea    r8,[rip+0x5dfa075]        # 0x1896e4b50
   1838eaadb:	41 b9 7a 00 00 00    	mov    r9d,0x7a
   1838eaae1:	e8 0a 71 8b fc       	call   0x1801a1bf0
   1838eaae6:	90                   	nop
   1838eaae7:	48 8b 4e 10          	mov    rcx,QWORD PTR [rsi+0x10]
   1838eaaeb:	48 85 c9             	test   rcx,rcx
   1838eaaee:	0f 85 0f 01 00 00    	jne    0x1838eac03
   1838eaaf4:	b9 04 00 00 00       	mov    ecx,0x4
   1838eaaf9:	e8 e2 22 78 fc       	call   0x18006cde0
   1838eaafe:	85 c0                	test   eax,eax
   1838eab00:	0f 84 f4 00 00 00    	je     0x1838eabfa
   1838eab06:	48 8d 8d 20 0a 00 00 	lea    rcx,[rbp+0xa20]
   1838eab0d:	e8 fe 23 78 fc       	call   0x18006cf10
   1838eab12:	90                   	nop
   1838eab13:	48 83 bd 38 0a 00 00 	cmp    QWORD PTR [rbp+0xa38],0x10
   1838eab1a:	10 
   1838eab1b:	4c 8d 85 20 0a 00 00 	lea    r8,[rbp+0xa20]
   1838eab22:	72 07                	jb     0x1838eab2b
   1838eab24:	4c 8b 85 20 0a 00 00 	mov    r8,QWORD PTR [rbp+0xa20]
   1838eab2b:	48 8d 05 66 87 6e 05 	lea    rax,[rip+0x56e8766]        # 0x188fd3298
   1838eab32:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1838eab37:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1838eab3e:	00 00 
   1838eab40:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1838eab45:	c7 44 24 28 3c 00 00 	mov    DWORD PTR [rsp+0x28],0x3c
   1838eab4c:	00 
   1838eab4d:	4c 89 f1             	mov    rcx,r14
   1838eab50:	ba 04 00 00 00       	mov    edx,0x4
   1838eab55:	4c 8d 0d ec 86 6e 05 	lea    r9,[rip+0x56e86ec]        # 0x188fd3248
   1838eab5c:	e8 0f 27 78 fc       	call   0x18006d270
   1838eab61:	90                   	nop
   1838eab62:	0f 29 bd 40 09 00 00 	movaps XMMWORD PTR [rbp+0x940],xmm7
   1838eab69:	0f 29 bd 30 09 00 00 	movaps XMMWORD PTR [rbp+0x930],xmm7
   1838eab70:	0f 29 bd 20 09 00 00 	movaps XMMWORD PTR [rbp+0x920],xmm7
   1838eab77:	0f 29 bd 10 09 00 00 	movaps XMMWORD PTR [rbp+0x910],xmm7
   1838eab7e:	0f 29 bd 00 09 00 00 	movaps XMMWORD PTR [rbp+0x900],xmm7
   1838eab85:	0f 29 bd f0 08 00 00 	movaps XMMWORD PTR [rbp+0x8f0],xmm7
   1838eab8c:	0f 29 bd e0 08 00 00 	movaps XMMWORD PTR [rbp+0x8e0],xmm7
   1838eab93:	0f 29 bd d0 08 00 00 	movaps XMMWORD PTR [rbp+0x8d0],xmm7
   1838eab9a:	4c 89 f1             	mov    rcx,r14
   1838eab9d:	48 8d 15 24 f6 6d 05 	lea    rdx,[rip+0x56df624]        # 0x188fca1c8
   1838eaba4:	4d 89 f8             	mov    r8,r15
   1838eaba7:	e8 64 2c 78 fc       	call   0x18006d810
   1838eabac:	90                   	nop
   1838eabad:	4c 89 f1             	mov    rcx,r14
   1838eabb0:	e8 bb 27 78 fc       	call   0x18006d370
   1838eabb5:	48 8b 85 38 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa38]
   1838eabbc:	48 83 f8 10          	cmp    rax,0x10
   1838eabc0:	72 38                	jb     0x1838eabfa
   1838eabc2:	48 8b 8d 20 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xa20]
   1838eabc9:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838eabcd:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838eabd4:	72 1f                	jb     0x1838eabf5
   1838eabd6:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838eabda:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838eabde:	4c 29 c1             	sub    rcx,r8
   1838eabe1:	48 83 f9 20          	cmp    rcx,0x20
   1838eabe5:	0f 83 f0 20 00 00    	jae    0x1838eccdb
   1838eabeb:	48 83 c0 28          	add    rax,0x28
   1838eabef:	48 89 c2             	mov    rdx,rax
   1838eabf2:	4c 89 c1             	mov    rcx,r8
   1838eabf5:	e8 26 11 c6 03       	call   0x18754bd20
   1838eabfa:	48 8b 4e 10          	mov    rcx,QWORD PTR [rsi+0x10]
   1838eabfe:	48 85 c9             	test   rcx,rcx
   1838eac01:	74 12                	je     0x1838eac15
   1838eac03:	48 83 c1 08          	add    rcx,0x8
   1838eac07:	e8 c4 0c 4c fd       	call   0x180dab8d0
   1838eac0c:	90                   	nop
   1838eac0d:	84 c0                	test   al,al
   1838eac0f:	0f 84 9b 00 00 00    	je     0x1838eacb0
   1838eac15:	0f 29 b5 b0 0a 00 00 	movaps XMMWORD PTR [rbp+0xab0],xmm6
   1838eac1c:	48 8d 8d b0 0a 00 00 	lea    rcx,[rbp+0xab0]
   1838eac23:	e8 88 0c 77 fc       	call   0x18005b8b0
   1838eac28:	90                   	nop
   1838eac29:	0f 29 bd 90 0a 00 00 	movaps XMMWORD PTR [rbp+0xa90],xmm7
   1838eac30:	48 8b 85 b8 0a 00 00 	mov    rax,QWORD PTR [rbp+0xab8]
   1838eac37:	48 85 c0             	test   rax,rax
   1838eac3a:	0f 84 76 05 00 00    	je     0x1838eb1b6
   1838eac40:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1838eac44:	48 8b 85 b8 0a 00 00 	mov    rax,QWORD PTR [rbp+0xab8]
   1838eac4b:	e9 68 05 00 00       	jmp    0x1838eb1b8
   1838eac50:	48 8b 46 10          	mov    rax,QWORD PTR [rsi+0x10]
   1838eac54:	48 89 85 58 09 00 00 	mov    QWORD PTR [rbp+0x958],rax
   1838eac5b:	48 8d 8d d0 09 00 00 	lea    rcx,[rbp+0x9d0]
   1838eac62:	48 8d 95 a0 08 00 00 	lea    rdx,[rbp+0x8a0]
   1838eac69:	e8 02 51 a2 fc       	call   0x18030fd70
   1838eac6e:	90                   	nop
   1838eac6f:	48 8b 85 e0 09 00 00 	mov    rax,QWORD PTR [rbp+0x9e0]
   1838eac76:	48 8b 8d e8 09 00 00 	mov    rcx,QWORD PTR [rbp+0x9e8]
   1838eac7d:	48 39 c1             	cmp    rcx,rax
   1838eac80:	0f 85 8a 00 00 00    	jne    0x1838ead10
   1838eac86:	48 c7 44 24 20 01 00 	mov    QWORD PTR [rsp+0x20],0x1
   1838eac8d:	00 00 
   1838eac8f:	ba 01 00 00 00       	mov    edx,0x1
   1838eac94:	48 8d 8d d0 09 00 00 	lea    rcx,[rbp+0x9d0]
   1838eac9b:	4c 8d 0d 32 e4 62 05 	lea    r9,[rip+0x562e432]        # 0x188f190d4
   1838eaca2:	e8 19 e7 71 fc       	call   0x1800093c0
   1838eaca7:	90                   	nop
   1838eaca8:	48 89 c6             	mov    rsi,rax
   1838eacab:	e9 8c 00 00 00       	jmp    0x1838ead3c
   1838eacb0:	48 8b 46 10          	mov    rax,QWORD PTR [rsi+0x10]
   1838eacb4:	48 89 85 58 09 00 00 	mov    QWORD PTR [rbp+0x958],rax
   1838eacbb:	48 8d 8d d0 09 00 00 	lea    rcx,[rbp+0x9d0]
   1838eacc2:	48 8d 95 a0 08 00 00 	lea    rdx,[rbp+0x8a0]
   1838eacc9:	e8 a2 50 a2 fc       	call   0x18030fd70
   1838eacce:	90                   	nop
   1838eaccf:	48 8b 85 e0 09 00 00 	mov    rax,QWORD PTR [rbp+0x9e0]
   1838eacd6:	48 8b 8d e8 09 00 00 	mov    rcx,QWORD PTR [rbp+0x9e8]
   1838eacdd:	48 39 c1             	cmp    rcx,rax
   1838eace0:	0f 85 b5 00 00 00    	jne    0x1838ead9b
   1838eace6:	48 c7 44 24 20 01 00 	mov    QWORD PTR [rsp+0x20],0x1
   1838eaced:	00 00 
   1838eacef:	ba 01 00 00 00       	mov    edx,0x1
   1838eacf4:	48 8d 8d d0 09 00 00 	lea    rcx,[rbp+0x9d0]
   1838eacfb:	4c 8d 0d d2 e3 62 05 	lea    r9,[rip+0x562e3d2]        # 0x188f190d4
   1838ead02:	e8 b9 e6 71 fc       	call   0x1800093c0
   1838ead07:	90                   	nop
   1838ead08:	48 89 c6             	mov    rsi,rax
   1838ead0b:	e9 b7 00 00 00       	jmp    0x1838eadc7
   1838ead10:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838ead14:	48 89 95 e0 09 00 00 	mov    QWORD PTR [rbp+0x9e0],rdx
   1838ead1b:	48 8d 95 d0 09 00 00 	lea    rdx,[rbp+0x9d0]
   1838ead22:	48 83 f9 10          	cmp    rcx,0x10
   1838ead26:	72 07                	jb     0x1838ead2f
   1838ead28:	48 8b 95 d0 09 00 00 	mov    rdx,QWORD PTR [rbp+0x9d0]
   1838ead2f:	66 c7 04 02 3a 00    	mov    WORD PTR [rdx+rax*1],0x3a
   1838ead35:	48 8d b5 d0 09 00 00 	lea    rsi,[rbp+0x9d0]
   1838ead3c:	0f 29 bd b0 0a 00 00 	movaps XMMWORD PTR [rbp+0xab0],xmm7
   1838ead43:	48 c7 85 c0 0a 00 00 	mov    QWORD PTR [rbp+0xac0],0x1
   1838ead4a:	01 00 00 00 
   1838ead4e:	48 c7 85 c8 0a 00 00 	mov    QWORD PTR [rbp+0xac8],0xf
   1838ead55:	0f 00 00 00 
   1838ead59:	c6 85 b0 0a 00 00 31 	mov    BYTE PTR [rbp+0xab0],0x31
   1838ead60:	48 8b 46 10          	mov    rax,QWORD PTR [rsi+0x10]
   1838ead64:	48 8b 4e 18          	mov    rcx,QWORD PTR [rsi+0x18]
   1838ead68:	48 39 c1             	cmp    rcx,rax
   1838ead6b:	0f 85 b5 00 00 00    	jne    0x1838eae26
   1838ead71:	48 c7 44 24 20 01 00 	mov    QWORD PTR [rsp+0x20],0x1
   1838ead78:	00 00 
   1838ead7a:	ba 01 00 00 00       	mov    edx,0x1
   1838ead7f:	48 89 f1             	mov    rcx,rsi
   1838ead82:	4c 8d 8d b0 0a 00 00 	lea    r9,[rbp+0xab0]
   1838ead89:	e8 32 e6 71 fc       	call   0x1800093c0
   1838ead8e:	90                   	nop
   1838ead8f:	48 89 c6             	mov    rsi,rax
   1838ead92:	4c 8d 75 c0          	lea    r14,[rbp-0x40]
   1838ead96:	e9 a5 00 00 00       	jmp    0x1838eae40
   1838ead9b:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838ead9f:	48 89 95 e0 09 00 00 	mov    QWORD PTR [rbp+0x9e0],rdx
   1838eada6:	48 8d 95 d0 09 00 00 	lea    rdx,[rbp+0x9d0]
   1838eadad:	48 83 f9 10          	cmp    rcx,0x10
   1838eadb1:	72 07                	jb     0x1838eadba
   1838eadb3:	48 8b 95 d0 09 00 00 	mov    rdx,QWORD PTR [rbp+0x9d0]
   1838eadba:	66 c7 04 02 3a 00    	mov    WORD PTR [rdx+rax*1],0x3a
   1838eadc0:	48 8d b5 d0 09 00 00 	lea    rsi,[rbp+0x9d0]
   1838eadc7:	0f 29 bd b0 0a 00 00 	movaps XMMWORD PTR [rbp+0xab0],xmm7
   1838eadce:	48 c7 85 c0 0a 00 00 	mov    QWORD PTR [rbp+0xac0],0x1
   1838eadd5:	01 00 00 00 
   1838eadd9:	48 c7 85 c8 0a 00 00 	mov    QWORD PTR [rbp+0xac8],0xf
   1838eade0:	0f 00 00 00 
   1838eade4:	c6 85 b0 0a 00 00 31 	mov    BYTE PTR [rbp+0xab0],0x31
   1838eadeb:	48 8b 46 10          	mov    rax,QWORD PTR [rsi+0x10]
   1838eadef:	48 8b 4e 18          	mov    rcx,QWORD PTR [rsi+0x18]
   1838eadf3:	48 39 c1             	cmp    rcx,rax
   1838eadf6:	0f 85 94 00 00 00    	jne    0x1838eae90
   1838eadfc:	48 c7 44 24 20 01 00 	mov    QWORD PTR [rsp+0x20],0x1
   1838eae03:	00 00 
   1838eae05:	ba 01 00 00 00       	mov    edx,0x1
   1838eae0a:	48 89 f1             	mov    rcx,rsi
   1838eae0d:	4c 8d 8d b0 0a 00 00 	lea    r9,[rbp+0xab0]
   1838eae14:	e8 a7 e5 71 fc       	call   0x1800093c0
   1838eae19:	90                   	nop
   1838eae1a:	48 89 c6             	mov    rsi,rax
   1838eae1d:	4c 8d 75 c0          	lea    r14,[rbp-0x40]
   1838eae21:	e9 84 00 00 00       	jmp    0x1838eaeaa
   1838eae26:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838eae2a:	48 89 56 10          	mov    QWORD PTR [rsi+0x10],rdx
   1838eae2e:	48 89 f2             	mov    rdx,rsi
   1838eae31:	48 83 f9 10          	cmp    rcx,0x10
   1838eae35:	72 03                	jb     0x1838eae3a
   1838eae37:	48 8b 16             	mov    rdx,QWORD PTR [rsi]
   1838eae3a:	66 c7 04 02 31 00    	mov    WORD PTR [rdx+rax*1],0x31
   1838eae40:	0f 29 bd 30 0a 00 00 	movaps XMMWORD PTR [rbp+0xa30],xmm7
   1838eae47:	0f 29 bd 20 0a 00 00 	movaps XMMWORD PTR [rbp+0xa20],xmm7
   1838eae4e:	4c 8b 7e 10          	mov    r15,QWORD PTR [rsi+0x10]
   1838eae52:	48 83 7e 18 10       	cmp    QWORD PTR [rsi+0x18],0x10
   1838eae57:	72 03                	jb     0x1838eae5c
   1838eae59:	48 8b 36             	mov    rsi,QWORD PTR [rsi]
   1838eae5c:	4d 85 ff             	test   r15,r15
   1838eae5f:	0f 88 82 1e 00 00    	js     0x1838ecce7
   1838eae65:	49 83 ff 0f          	cmp    r15,0xf
   1838eae69:	0f 87 87 00 00 00    	ja     0x1838eaef6
   1838eae6f:	4c 89 bd 30 0a 00 00 	mov    QWORD PTR [rbp+0xa30],r15
   1838eae76:	48 c7 85 38 0a 00 00 	mov    QWORD PTR [rbp+0xa38],0xf
   1838eae7d:	0f 00 00 00 
   1838eae81:	0f 10 06             	movups xmm0,XMMWORD PTR [rsi]
   1838eae84:	0f 29 85 20 0a 00 00 	movaps XMMWORD PTR [rbp+0xa20],xmm0
   1838eae8b:	e9 b6 05 00 00       	jmp    0x1838eb446
   1838eae90:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838eae94:	48 89 56 10          	mov    QWORD PTR [rsi+0x10],rdx
   1838eae98:	48 89 f2             	mov    rdx,rsi
   1838eae9b:	48 83 f9 10          	cmp    rcx,0x10
   1838eae9f:	72 03                	jb     0x1838eaea4
   1838eaea1:	48 8b 16             	mov    rdx,QWORD PTR [rsi]
   1838eaea4:	66 c7 04 02 31 00    	mov    WORD PTR [rdx+rax*1],0x31
   1838eaeaa:	0f 29 bd 30 0a 00 00 	movaps XMMWORD PTR [rbp+0xa30],xmm7
   1838eaeb1:	0f 29 bd 20 0a 00 00 	movaps XMMWORD PTR [rbp+0xa20],xmm7
   1838eaeb8:	4c 8b 7e 10          	mov    r15,QWORD PTR [rsi+0x10]
   1838eaebc:	48 83 7e 18 10       	cmp    QWORD PTR [rsi+0x18],0x10
   1838eaec1:	72 03                	jb     0x1838eaec6
   1838eaec3:	48 8b 36             	mov    rsi,QWORD PTR [rsi]
   1838eaec6:	4d 85 ff             	test   r15,r15
   1838eaec9:	0f 88 12 1e 00 00    	js     0x1838ecce1
   1838eaecf:	49 83 ff 0f          	cmp    r15,0xf
   1838eaed3:	77 69                	ja     0x1838eaf3e
   1838eaed5:	4c 89 bd 30 0a 00 00 	mov    QWORD PTR [rbp+0xa30],r15
   1838eaedc:	48 c7 85 38 0a 00 00 	mov    QWORD PTR [rbp+0xa38],0xf
   1838eaee3:	0f 00 00 00 
   1838eaee7:	0f 10 06             	movups xmm0,XMMWORD PTR [rsi]
   1838eaeea:	0f 29 85 20 0a 00 00 	movaps XMMWORD PTR [rbp+0xa20],xmm0
   1838eaef1:	e9 99 0a 00 00       	jmp    0x1838eb98f
   1838eaef6:	4c 89 f8             	mov    rax,r15
   1838eaef9:	48 83 c8 0f          	or     rax,0xf
   1838eaefd:	48 83 f8 17          	cmp    rax,0x17
   1838eaf01:	41 be 16 00 00 00    	mov    r14d,0x16
   1838eaf07:	4c 0f 43 f0          	cmovae r14,rax
   1838eaf0b:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   1838eaf11:	0f 82 fb 04 00 00    	jb     0x1838eb412
   1838eaf17:	49 8d 4e 28          	lea    rcx,[r14+0x28]
   1838eaf1b:	e8 bc 0d c6 03       	call   0x18754bcdc
   1838eaf20:	90                   	nop
   1838eaf21:	48 85 c0             	test   rax,rax
   1838eaf24:	0f 84 b1 1d 00 00    	je     0x1838eccdb
   1838eaf2a:	48 89 c1             	mov    rcx,rax
   1838eaf2d:	48 83 c0 27          	add    rax,0x27
   1838eaf31:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
   1838eaf35:	48 89 48 f8          	mov    QWORD PTR [rax-0x8],rcx
   1838eaf39:	e9 de 04 00 00       	jmp    0x1838eb41c
   1838eaf3e:	4c 89 f8             	mov    rax,r15
   1838eaf41:	48 83 c8 0f          	or     rax,0xf
   1838eaf45:	48 83 f8 17          	cmp    rax,0x17
   1838eaf49:	41 be 16 00 00 00    	mov    r14d,0x16
   1838eaf4f:	4c 0f 43 f0          	cmovae r14,rax
   1838eaf53:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   1838eaf59:	0f 82 fc 09 00 00    	jb     0x1838eb95b
   1838eaf5f:	49 8d 4e 28          	lea    rcx,[r14+0x28]
   1838eaf63:	e8 74 0d c6 03       	call   0x18754bcdc
   1838eaf68:	90                   	nop
   1838eaf69:	48 85 c0             	test   rax,rax
   1838eaf6c:	0f 84 69 1d 00 00    	je     0x1838eccdb
   1838eaf72:	48 89 c1             	mov    rcx,rax
   1838eaf75:	48 83 c0 27          	add    rax,0x27
   1838eaf79:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
   1838eaf7d:	48 89 48 f8          	mov    QWORD PTR [rax-0x8],rcx
   1838eaf81:	e9 df 09 00 00       	jmp    0x1838eb965
   1838eaf86:	31 c0                	xor    eax,eax
   1838eaf88:	48 8b 8d b0 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xab0]
   1838eaf8f:	48 89 8d 90 0a 00 00 	mov    QWORD PTR [rbp+0xa90],rcx
   1838eaf96:	48 89 85 98 0a 00 00 	mov    QWORD PTR [rbp+0xa98],rax
   1838eaf9d:	0f 29 b5 70 09 00 00 	movaps XMMWORD PTR [rbp+0x970],xmm6
   1838eafa4:	0f 29 b5 60 09 00 00 	movaps XMMWORD PTR [rbp+0x960],xmm6
   1838eafab:	4c 89 f1             	mov    rcx,r14
   1838eafae:	e8 8d 59 d6 fc       	call   0x180650940
   1838eafb3:	90                   	nop
   1838eafb4:	4c 89 f1             	mov    rcx,r14
   1838eafb7:	48 8d 95 60 09 00 00 	lea    rdx,[rbp+0x960]
   1838eafbe:	e8 2d 5a d6 fc       	call   0x1806509f0
   1838eafc3:	90                   	nop
   1838eafc4:	b9 04 00 00 00       	mov    ecx,0x4
   1838eafc9:	e8 12 1e 78 fc       	call   0x18006cde0
   1838eafce:	85 c0                	test   eax,eax
   1838eafd0:	0f 84 19 01 00 00    	je     0x1838eb0ef
   1838eafd6:	48 8d b5 d0 09 00 00 	lea    rsi,[rbp+0x9d0]
   1838eafdd:	48 89 f1             	mov    rcx,rsi
   1838eafe0:	e8 2b 1f 78 fc       	call   0x18006cf10
   1838eafe5:	90                   	nop
   1838eafe6:	48 83 bd e8 09 00 00 	cmp    QWORD PTR [rbp+0x9e8],0x10
   1838eafed:	10 
   1838eafee:	72 07                	jb     0x1838eaff7
   1838eaff0:	48 8b b5 d0 09 00 00 	mov    rsi,QWORD PTR [rbp+0x9d0]
   1838eaff7:	48 8d 05 32 2c e0 05 	lea    rax,[rip+0x5e02c32]        # 0x1896edc30
   1838eaffe:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1838eb003:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1838eb00a:	00 00 
   1838eb00c:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1838eb011:	c7 44 24 28 45 00 00 	mov    DWORD PTR [rsp+0x28],0x45
   1838eb018:	00 
   1838eb019:	4c 89 f1             	mov    rcx,r14
   1838eb01c:	ba 04 00 00 00       	mov    edx,0x4
   1838eb021:	49 89 f0             	mov    r8,rsi
   1838eb024:	4c 8d 0d 1d 82 6e 05 	lea    r9,[rip+0x56e821d]        # 0x188fd3248
   1838eb02b:	e8 40 22 78 fc       	call   0x18006d270
   1838eb030:	90                   	nop
   1838eb031:	48 83 bd 78 09 00 00 	cmp    QWORD PTR [rbp+0x978],0x10
   1838eb038:	10 
   1838eb039:	48 8d 85 60 09 00 00 	lea    rax,[rbp+0x960]
   1838eb040:	72 07                	jb     0x1838eb049
   1838eb042:	48 8b 85 60 09 00 00 	mov    rax,QWORD PTR [rbp+0x960]
   1838eb049:	48 89 85 20 0a 00 00 	mov    QWORD PTR [rbp+0xa20],rax
   1838eb050:	c6 85 28 0a 00 00 00 	mov    BYTE PTR [rbp+0xa28],0x0
   1838eb057:	48 8d 85 f8 08 00 00 	lea    rax,[rbp+0x8f8]
   1838eb05e:	0f 11 78 40          	movups XMMWORD PTR [rax+0x40],xmm7
   1838eb062:	0f 11 78 30          	movups XMMWORD PTR [rax+0x30],xmm7
   1838eb066:	0f 11 78 20          	movups XMMWORD PTR [rax+0x20],xmm7
   1838eb06a:	0f 11 78 10          	movups XMMWORD PTR [rax+0x10],xmm7
   1838eb06e:	0f 11 38             	movups XMMWORD PTR [rax],xmm7
   1838eb071:	0f 11 78 f0          	movups XMMWORD PTR [rax-0x10],xmm7
   1838eb075:	0f 11 78 e0          	movups XMMWORD PTR [rax-0x20],xmm7
   1838eb079:	48 c7 40 50 00 00 00 	mov    QWORD PTR [rax+0x50],0x0
   1838eb080:	00 
   1838eb081:	48 8d 85 20 0a 00 00 	lea    rax,[rbp+0xa20]
   1838eb088:	48 89 85 d0 08 00 00 	mov    QWORD PTR [rbp+0x8d0],rax
   1838eb08f:	4c 89 f1             	mov    rcx,r14
   1838eb092:	48 8d 15 17 7b 6e 05 	lea    rdx,[rip+0x56e7b17]        # 0x188fd2bb0
   1838eb099:	4d 89 f8             	mov    r8,r15
   1838eb09c:	e8 6f 27 78 fc       	call   0x18006d810
   1838eb0a1:	90                   	nop
   1838eb0a2:	4c 89 f1             	mov    rcx,r14
   1838eb0a5:	e8 c6 22 78 fc       	call   0x18006d370
   1838eb0aa:	48 8b 85 e8 09 00 00 	mov    rax,QWORD PTR [rbp+0x9e8]
   1838eb0b1:	48 83 f8 10          	cmp    rax,0x10
   1838eb0b5:	72 38                	jb     0x1838eb0ef
   1838eb0b7:	48 8b 8d d0 09 00 00 	mov    rcx,QWORD PTR [rbp+0x9d0]
   1838eb0be:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838eb0c2:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838eb0c9:	72 1f                	jb     0x1838eb0ea
   1838eb0cb:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838eb0cf:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838eb0d3:	4c 29 c1             	sub    rcx,r8
   1838eb0d6:	48 83 f9 20          	cmp    rcx,0x20
   1838eb0da:	0f 83 fb 1b 00 00    	jae    0x1838eccdb
   1838eb0e0:	48 83 c0 28          	add    rax,0x28
   1838eb0e4:	48 89 c2             	mov    rdx,rax
   1838eb0e7:	4c 89 c1             	mov    rcx,r8
   1838eb0ea:	e8 31 0c c6 03       	call   0x18754bd20
   1838eb0ef:	48 8b 85 78 09 00 00 	mov    rax,QWORD PTR [rbp+0x978]
   1838eb0f6:	48 83 f8 10          	cmp    rax,0x10
   1838eb0fa:	72 38                	jb     0x1838eb134
   1838eb0fc:	48 8b 8d 60 09 00 00 	mov    rcx,QWORD PTR [rbp+0x960]
   1838eb103:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838eb107:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838eb10e:	72 1f                	jb     0x1838eb12f
   1838eb110:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838eb114:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838eb118:	4c 29 c1             	sub    rcx,r8
   1838eb11b:	48 83 f9 20          	cmp    rcx,0x20
   1838eb11f:	0f 83 b6 1b 00 00    	jae    0x1838eccdb
   1838eb125:	48 83 c0 28          	add    rax,0x28
   1838eb129:	48 89 c2             	mov    rdx,rax
   1838eb12c:	4c 89 c1             	mov    rcx,r8
   1838eb12f:	e8 ec 0b c6 03       	call   0x18754bd20
   1838eb134:	48 8b b5 98 0a 00 00 	mov    rsi,QWORD PTR [rbp+0xa98]
   1838eb13b:	48 85 f6             	test   rsi,rsi
   1838eb13e:	74 1d                	je     0x1838eb15d
   1838eb140:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1838eb144:	75 17                	jne    0x1838eb15d
   1838eb146:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838eb149:	48 89 f1             	mov    rcx,rsi
   1838eb14c:	ff 10                	call   QWORD PTR [rax]
   1838eb14e:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1838eb152:	75 09                	jne    0x1838eb15d
   1838eb154:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838eb157:	48 89 f1             	mov    rcx,rsi
   1838eb15a:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1838eb15d:	48 8b 85 b8 0a 00 00 	mov    rax,QWORD PTR [rbp+0xab8]
   1838eb164:	48 85 c0             	test   rax,rax
   1838eb167:	0f 84 75 02 00 00    	je     0x1838eb3e2
   1838eb16d:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1838eb171:	48 8b b5 b8 0a 00 00 	mov    rsi,QWORD PTR [rbp+0xab8]
   1838eb178:	0f 28 85 b0 0a 00 00 	movaps xmm0,XMMWORD PTR [rbp+0xab0]
   1838eb17f:	0f 29 45 c0          	movaps XMMWORD PTR [rbp-0x40],xmm0
   1838eb183:	48 85 f6             	test   rsi,rsi
   1838eb186:	0f 84 d7 06 00 00    	je     0x1838eb863
   1838eb18c:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1838eb190:	0f 85 cd 06 00 00    	jne    0x1838eb863
   1838eb196:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838eb199:	48 89 f1             	mov    rcx,rsi
   1838eb19c:	ff 10                	call   QWORD PTR [rax]
   1838eb19e:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1838eb1a2:	0f 85 bb 06 00 00    	jne    0x1838eb863
   1838eb1a8:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838eb1ab:	48 89 f1             	mov    rcx,rsi
   1838eb1ae:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1838eb1b1:	e9 ad 06 00 00       	jmp    0x1838eb863
   1838eb1b6:	31 c0                	xor    eax,eax
   1838eb1b8:	48 8b 8d b0 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xab0]
   1838eb1bf:	48 89 8d 90 0a 00 00 	mov    QWORD PTR [rbp+0xa90],rcx
   1838eb1c6:	48 89 85 98 0a 00 00 	mov    QWORD PTR [rbp+0xa98],rax
   1838eb1cd:	0f 29 b5 70 09 00 00 	movaps XMMWORD PTR [rbp+0x970],xmm6
   1838eb1d4:	0f 29 b5 60 09 00 00 	movaps XMMWORD PTR [rbp+0x960],xmm6
   1838eb1db:	4c 89 f1             	mov    rcx,r14
   1838eb1de:	e8 5d 57 d6 fc       	call   0x180650940
   1838eb1e3:	90                   	nop
   1838eb1e4:	4c 89 f1             	mov    rcx,r14
   1838eb1e7:	48 8d 95 60 09 00 00 	lea    rdx,[rbp+0x960]
   1838eb1ee:	e8 fd 57 d6 fc       	call   0x1806509f0
   1838eb1f3:	90                   	nop
   1838eb1f4:	b9 04 00 00 00       	mov    ecx,0x4
   1838eb1f9:	e8 e2 1b 78 fc       	call   0x18006cde0
   1838eb1fe:	85 c0                	test   eax,eax
   1838eb200:	0f 84 19 01 00 00    	je     0x1838eb31f
   1838eb206:	48 8d b5 d0 09 00 00 	lea    rsi,[rbp+0x9d0]
   1838eb20d:	48 89 f1             	mov    rcx,rsi
   1838eb210:	e8 fb 1c 78 fc       	call   0x18006cf10
   1838eb215:	90                   	nop
   1838eb216:	48 83 bd e8 09 00 00 	cmp    QWORD PTR [rbp+0x9e8],0x10
   1838eb21d:	10 
   1838eb21e:	72 07                	jb     0x1838eb227
   1838eb220:	48 8b b5 d0 09 00 00 	mov    rsi,QWORD PTR [rbp+0x9d0]
   1838eb227:	48 8d 05 92 2b e0 05 	lea    rax,[rip+0x5e02b92]        # 0x1896eddc0
   1838eb22e:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1838eb233:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1838eb23a:	00 00 
   1838eb23c:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1838eb241:	c7 44 24 28 45 00 00 	mov    DWORD PTR [rsp+0x28],0x45
   1838eb248:	00 
   1838eb249:	4c 89 f1             	mov    rcx,r14
   1838eb24c:	ba 04 00 00 00       	mov    edx,0x4
   1838eb251:	49 89 f0             	mov    r8,rsi
   1838eb254:	4c 8d 0d ed 7f 6e 05 	lea    r9,[rip+0x56e7fed]        # 0x188fd3248
   1838eb25b:	e8 10 20 78 fc       	call   0x18006d270
   1838eb260:	90                   	nop
   1838eb261:	48 83 bd 78 09 00 00 	cmp    QWORD PTR [rbp+0x978],0x10
   1838eb268:	10 
   1838eb269:	48 8d 85 60 09 00 00 	lea    rax,[rbp+0x960]
   1838eb270:	72 07                	jb     0x1838eb279
   1838eb272:	48 8b 85 60 09 00 00 	mov    rax,QWORD PTR [rbp+0x960]
   1838eb279:	48 89 85 20 0a 00 00 	mov    QWORD PTR [rbp+0xa20],rax
   1838eb280:	c6 85 28 0a 00 00 00 	mov    BYTE PTR [rbp+0xa28],0x0
   1838eb287:	48 8d 85 f8 08 00 00 	lea    rax,[rbp+0x8f8]
   1838eb28e:	0f 11 78 40          	movups XMMWORD PTR [rax+0x40],xmm7
   1838eb292:	0f 11 78 30          	movups XMMWORD PTR [rax+0x30],xmm7
   1838eb296:	0f 11 78 20          	movups XMMWORD PTR [rax+0x20],xmm7
   1838eb29a:	0f 11 78 10          	movups XMMWORD PTR [rax+0x10],xmm7
   1838eb29e:	0f 11 38             	movups XMMWORD PTR [rax],xmm7
   1838eb2a1:	0f 11 78 f0          	movups XMMWORD PTR [rax-0x10],xmm7
   1838eb2a5:	0f 11 78 e0          	movups XMMWORD PTR [rax-0x20],xmm7
   1838eb2a9:	48 c7 40 50 00 00 00 	mov    QWORD PTR [rax+0x50],0x0
   1838eb2b0:	00 
   1838eb2b1:	48 8d 85 20 0a 00 00 	lea    rax,[rbp+0xa20]
   1838eb2b8:	48 89 85 d0 08 00 00 	mov    QWORD PTR [rbp+0x8d0],rax
   1838eb2bf:	4c 89 f1             	mov    rcx,r14
   1838eb2c2:	48 8d 15 e7 78 6e 05 	lea    rdx,[rip+0x56e78e7]        # 0x188fd2bb0
   1838eb2c9:	4d 89 f8             	mov    r8,r15
   1838eb2cc:	e8 3f 25 78 fc       	call   0x18006d810
   1838eb2d1:	90                   	nop
   1838eb2d2:	4c 89 f1             	mov    rcx,r14
   1838eb2d5:	e8 96 20 78 fc       	call   0x18006d370
   1838eb2da:	48 8b 85 e8 09 00 00 	mov    rax,QWORD PTR [rbp+0x9e8]
   1838eb2e1:	48 83 f8 10          	cmp    rax,0x10
   1838eb2e5:	72 38                	jb     0x1838eb31f
   1838eb2e7:	48 8b 8d d0 09 00 00 	mov    rcx,QWORD PTR [rbp+0x9d0]
   1838eb2ee:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838eb2f2:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838eb2f9:	72 1f                	jb     0x1838eb31a
   1838eb2fb:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838eb2ff:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838eb303:	4c 29 c1             	sub    rcx,r8
   1838eb306:	48 83 f9 20          	cmp    rcx,0x20
   1838eb30a:	0f 83 cb 19 00 00    	jae    0x1838eccdb
   1838eb310:	48 83 c0 28          	add    rax,0x28
   1838eb314:	48 89 c2             	mov    rdx,rax
   1838eb317:	4c 89 c1             	mov    rcx,r8
   1838eb31a:	e8 01 0a c6 03       	call   0x18754bd20
   1838eb31f:	48 8b 85 78 09 00 00 	mov    rax,QWORD PTR [rbp+0x978]
   1838eb326:	48 83 f8 10          	cmp    rax,0x10
   1838eb32a:	72 38                	jb     0x1838eb364
   1838eb32c:	48 8b 8d 60 09 00 00 	mov    rcx,QWORD PTR [rbp+0x960]
   1838eb333:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838eb337:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838eb33e:	72 1f                	jb     0x1838eb35f
   1838eb340:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838eb344:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838eb348:	4c 29 c1             	sub    rcx,r8
   1838eb34b:	48 83 f9 20          	cmp    rcx,0x20
   1838eb34f:	0f 83 86 19 00 00    	jae    0x1838eccdb
   1838eb355:	48 83 c0 28          	add    rax,0x28
   1838eb359:	48 89 c2             	mov    rdx,rax
   1838eb35c:	4c 89 c1             	mov    rcx,r8
   1838eb35f:	e8 bc 09 c6 03       	call   0x18754bd20
   1838eb364:	48 8b b5 98 0a 00 00 	mov    rsi,QWORD PTR [rbp+0xa98]
   1838eb36b:	48 85 f6             	test   rsi,rsi
   1838eb36e:	74 1d                	je     0x1838eb38d
   1838eb370:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1838eb374:	75 17                	jne    0x1838eb38d
   1838eb376:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838eb379:	48 89 f1             	mov    rcx,rsi
   1838eb37c:	ff 10                	call   QWORD PTR [rax]
   1838eb37e:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1838eb382:	75 09                	jne    0x1838eb38d
   1838eb384:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838eb387:	48 89 f1             	mov    rcx,rsi
   1838eb38a:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1838eb38d:	48 8b 85 b8 0a 00 00 	mov    rax,QWORD PTR [rbp+0xab8]
   1838eb394:	48 85 c0             	test   rax,rax
   1838eb397:	74 61                	je     0x1838eb3fa
   1838eb399:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1838eb39d:	48 8b b5 b8 0a 00 00 	mov    rsi,QWORD PTR [rbp+0xab8]
   1838eb3a4:	0f 28 85 b0 0a 00 00 	movaps xmm0,XMMWORD PTR [rbp+0xab0]
   1838eb3ab:	0f 29 45 c0          	movaps XMMWORD PTR [rbp-0x40],xmm0
   1838eb3af:	48 85 f6             	test   rsi,rsi
   1838eb3b2:	0f 84 f4 09 00 00    	je     0x1838ebdac
   1838eb3b8:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1838eb3bc:	0f 85 ea 09 00 00    	jne    0x1838ebdac
   1838eb3c2:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838eb3c5:	48 89 f1             	mov    rcx,rsi
   1838eb3c8:	ff 10                	call   QWORD PTR [rax]
   1838eb3ca:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1838eb3ce:	0f 85 d8 09 00 00    	jne    0x1838ebdac
   1838eb3d4:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838eb3d7:	48 89 f1             	mov    rcx,rsi
   1838eb3da:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1838eb3dd:	e9 ca 09 00 00       	jmp    0x1838ebdac
   1838eb3e2:	48 8b 85 b0 0a 00 00 	mov    rax,QWORD PTR [rbp+0xab0]
   1838eb3e9:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
   1838eb3ed:	48 c7 45 c8 00 00 00 	mov    QWORD PTR [rbp-0x38],0x0
   1838eb3f4:	00 
   1838eb3f5:	e9 69 04 00 00       	jmp    0x1838eb863
   1838eb3fa:	48 8b 85 b0 0a 00 00 	mov    rax,QWORD PTR [rbp+0xab0]
   1838eb401:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
   1838eb405:	48 c7 45 c8 00 00 00 	mov    QWORD PTR [rbp-0x38],0x0
   1838eb40c:	00 
   1838eb40d:	e9 9a 09 00 00       	jmp    0x1838ebdac
   1838eb412:	49 8d 4e 01          	lea    rcx,[r14+0x1]
   1838eb416:	e8 c1 08 c6 03       	call   0x18754bcdc
   1838eb41b:	90                   	nop
   1838eb41c:	48 89 85 20 0a 00 00 	mov    QWORD PTR [rbp+0xa20],rax
   1838eb423:	4c 89 bd 30 0a 00 00 	mov    QWORD PTR [rbp+0xa30],r15
   1838eb42a:	4c 89 b5 38 0a 00 00 	mov    QWORD PTR [rbp+0xa38],r14
   1838eb431:	49 ff c7             	inc    r15
   1838eb434:	48 89 c1             	mov    rcx,rax
   1838eb437:	48 89 f2             	mov    rdx,rsi
   1838eb43a:	4d 89 f8             	mov    r8,r15
   1838eb43d:	e8 fe 99 e2 03       	call   0x187714e40
   1838eb442:	4c 8d 75 c0          	lea    r14,[rbp-0x40]
   1838eb446:	48 8d 85 40 0a 00 00 	lea    rax,[rbp+0xa40]
   1838eb44d:	0f 11 38             	movups XMMWORD PTR [rax],xmm7
   1838eb450:	48 c7 40 10 00 00 00 	mov    QWORD PTR [rax+0x10],0x0
   1838eb457:	00 
   1838eb458:	48 b8 ff ff ff ff 00 	movabs rax,0x80000000ffffffff
   1838eb45f:	00 00 80 
   1838eb462:	48 89 85 58 0a 00 00 	mov    QWORD PTR [rbp+0xa58],rax
   1838eb469:	48 8d 85 20 0a 00 00 	lea    rax,[rbp+0xa20]
   1838eb470:	48 89 85 60 09 00 00 	mov    QWORD PTR [rbp+0x960],rax
   1838eb477:	48 8b 85 a8 0a 00 00 	mov    rax,QWORD PTR [rbp+0xaa8]
   1838eb47e:	48 89 85 68 09 00 00 	mov    QWORD PTR [rbp+0x968],rax
   1838eb485:	48 8d 85 b8 09 00 00 	lea    rax,[rbp+0x9b8]
   1838eb48c:	0f 11 38             	movups XMMWORD PTR [rax],xmm7
   1838eb48f:	48 c7 40 10 00 00 00 	mov    QWORD PTR [rax+0x10],0x0
   1838eb496:	00 
   1838eb497:	48 8b 85 d0 0a 00 00 	mov    rax,QWORD PTR [rbp+0xad0]
   1838eb49e:	48 89 85 70 09 00 00 	mov    QWORD PTR [rbp+0x970],rax
   1838eb4a5:	48 89 bd 78 09 00 00 	mov    QWORD PTR [rbp+0x978],rdi
   1838eb4ac:	48 8b 85 78 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa78]
   1838eb4b3:	48 89 85 80 09 00 00 	mov    QWORD PTR [rbp+0x980],rax
   1838eb4ba:	48 8b 85 58 09 00 00 	mov    rax,QWORD PTR [rbp+0x958]
   1838eb4c1:	48 89 85 88 09 00 00 	mov    QWORD PTR [rbp+0x988],rax
   1838eb4c8:	0f 29 b5 80 0a 00 00 	movaps XMMWORD PTR [rbp+0xa80],xmm6
   1838eb4cf:	48 8d 8d 80 0a 00 00 	lea    rcx,[rbp+0xa80]
   1838eb4d6:	e8 d5 03 77 fc       	call   0x18005b8b0
   1838eb4db:	90                   	nop
   1838eb4dc:	4c 8d bd d0 08 00 00 	lea    r15,[rbp+0x8d0]
   1838eb4e3:	0f 29 bd 10 0a 00 00 	movaps XMMWORD PTR [rbp+0xa10],xmm7
   1838eb4ea:	48 8b 85 88 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa88]
   1838eb4f1:	48 85 c0             	test   rax,rax
   1838eb4f4:	74 0d                	je     0x1838eb503
   1838eb4f6:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1838eb4fa:	48 8b 8d 88 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xa88]
   1838eb501:	eb 02                	jmp    0x1838eb505
   1838eb503:	31 c9                	xor    ecx,ecx
   1838eb505:	48 8b 85 80 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa80]
   1838eb50c:	48 89 85 10 0a 00 00 	mov    QWORD PTR [rbp+0xa10],rax
   1838eb513:	48 89 8d 18 0a 00 00 	mov    QWORD PTR [rbp+0xa18],rcx
   1838eb51a:	0f 29 b5 90 0a 00 00 	movaps XMMWORD PTR [rbp+0xa90],xmm6
   1838eb521:	48 8b 95 a8 0a 00 00 	mov    rdx,QWORD PTR [rbp+0xaa8]
   1838eb528:	48 89 55 c0          	mov    QWORD PTR [rbp-0x40],rdx
   1838eb52c:	48 8d 95 68 09 00 00 	lea    rdx,[rbp+0x968]
   1838eb533:	0f 11 7a 08          	movups XMMWORD PTR [rdx+0x8],xmm7
   1838eb537:	48 c7 42 18 00 00 00 	mov    QWORD PTR [rdx+0x18],0x0
   1838eb53e:	00 
   1838eb53f:	48 85 c9             	test   rcx,rcx
   1838eb542:	74 14                	je     0x1838eb558
   1838eb544:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   1838eb548:	48 8b 85 10 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa10]
   1838eb54f:	48 8b b5 18 0a 00 00 	mov    rsi,QWORD PTR [rbp+0xa18]
   1838eb556:	eb 02                	jmp    0x1838eb55a
   1838eb558:	31 f6                	xor    esi,esi
   1838eb55a:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
   1838eb55e:	48 89 75 e8          	mov    QWORD PTR [rbp-0x18],rsi
   1838eb562:	48 c7 85 08 09 00 00 	mov    QWORD PTR [rbp+0x908],0x0
   1838eb569:	00 00 00 00 
   1838eb56d:	48 8d 0d c4 6e df 05 	lea    rcx,[rip+0x5df6ec4]        # 0x1896e2438
   1838eb574:	48 89 8d d0 08 00 00 	mov    QWORD PTR [rbp+0x8d0],rcx
   1838eb57b:	48 8b 8d a8 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xaa8]
   1838eb582:	48 89 8d d8 08 00 00 	mov    QWORD PTR [rbp+0x8d8],rcx
   1838eb589:	48 8d 4d c8          	lea    rcx,[rbp-0x38]
   1838eb58d:	0f 11 39             	movups XMMWORD PTR [rcx],xmm7
   1838eb590:	48 c7 41 10 00 00 00 	mov    QWORD PTR [rcx+0x10],0x0
   1838eb597:	00 
   1838eb598:	48 8b 8d d0 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xad0]
   1838eb59f:	48 89 8d e0 08 00 00 	mov    QWORD PTR [rbp+0x8e0],rcx
   1838eb5a6:	48 89 bd e8 08 00 00 	mov    QWORD PTR [rbp+0x8e8],rdi
   1838eb5ad:	48 8b 8d 78 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xa78]
   1838eb5b4:	48 89 8d f0 08 00 00 	mov    QWORD PTR [rbp+0x8f0],rcx
   1838eb5bb:	48 8d 8d f8 08 00 00 	lea    rcx,[rbp+0x8f8]
   1838eb5c2:	0f 11 39             	movups XMMWORD PTR [rcx],xmm7
   1838eb5c5:	48 85 f6             	test   rsi,rsi
   1838eb5c8:	74 04                	je     0x1838eb5ce
   1838eb5ca:	f0 ff 46 08          	lock inc DWORD PTR [rsi+0x8]
   1838eb5ce:	48 89 85 f8 08 00 00 	mov    QWORD PTR [rbp+0x8f8],rax
   1838eb5d5:	48 89 b5 00 09 00 00 	mov    QWORD PTR [rbp+0x900],rsi
   1838eb5dc:	4c 89 bd 08 09 00 00 	mov    QWORD PTR [rbp+0x908],r15
   1838eb5e3:	48 8b 8d 58 09 00 00 	mov    rcx,QWORD PTR [rbp+0x958]
   1838eb5ea:	48 8d 95 90 0a 00 00 	lea    rdx,[rbp+0xa90]
   1838eb5f1:	4c 8d 85 20 0a 00 00 	lea    r8,[rbp+0xa20]
   1838eb5f8:	4d 89 f9             	mov    r9,r15
   1838eb5fb:	e8 20 02 ae fc       	call   0x1803cb820
   1838eb600:	90                   	nop
   1838eb601:	48 85 f6             	test   rsi,rsi
   1838eb604:	74 1d                	je     0x1838eb623
   1838eb606:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1838eb60a:	75 17                	jne    0x1838eb623
   1838eb60c:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838eb60f:	48 89 f1             	mov    rcx,rsi
   1838eb612:	ff 10                	call   QWORD PTR [rax]
   1838eb614:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1838eb618:	75 09                	jne    0x1838eb623
   1838eb61a:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838eb61d:	48 89 f1             	mov    rcx,rsi
   1838eb620:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1838eb623:	4c 8b 85 98 0a 00 00 	mov    r8,QWORD PTR [rbp+0xa98]
   1838eb62a:	4d 85 c0             	test   r8,r8
   1838eb62d:	74 13                	je     0x1838eb642
   1838eb62f:	48 8b 85 90 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa90]
   1838eb636:	f0 41 ff 40 0c       	lock inc DWORD PTR [r8+0xc]
   1838eb63b:	f0 41 ff 40 0c       	lock inc DWORD PTR [r8+0xc]
   1838eb640:	eb 02                	jmp    0x1838eb644
   1838eb642:	31 c0                	xor    eax,eax
   1838eb644:	48 8b 8d 10 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xa10]
   1838eb64b:	48 8d 15 06 71 df 05 	lea    rdx,[rip+0x5df7106]        # 0x1896e2758
   1838eb652:	48 89 55 c0          	mov    QWORD PTR [rbp-0x40],rdx
   1838eb656:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
   1838eb65a:	4c 89 85 d0 0a 00 00 	mov    QWORD PTR [rbp+0xad0],r8
   1838eb661:	4c 89 45 d0          	mov    QWORD PTR [rbp-0x30],r8
   1838eb665:	4c 89 75 f8          	mov    QWORD PTR [rbp-0x8],r14
   1838eb669:	4c 89 f2             	mov    rdx,r14
   1838eb66c:	e8 2f 81 ac fc       	call   0x1803b37a0
   1838eb671:	90                   	nop
   1838eb672:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
   1838eb676:	48 85 c9             	test   rcx,rcx
   1838eb679:	4c 8d 75 c0          	lea    r14,[rbp-0x40]
   1838eb67d:	74 0c                	je     0x1838eb68b
   1838eb67f:	4c 39 f1             	cmp    rcx,r14
   1838eb682:	0f 95 c2             	setne  dl
   1838eb685:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   1838eb688:	ff 50 20             	call   QWORD PTR [rax+0x20]
   1838eb68b:	48 8b 8d d0 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xad0]
   1838eb692:	48 85 c9             	test   rcx,rcx
   1838eb695:	74 0c                	je     0x1838eb6a3
   1838eb697:	f0 ff 49 0c          	lock dec DWORD PTR [rcx+0xc]
   1838eb69b:	75 06                	jne    0x1838eb6a3
   1838eb69d:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   1838eb6a0:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1838eb6a3:	48 8b b5 98 0a 00 00 	mov    rsi,QWORD PTR [rbp+0xa98]
   1838eb6aa:	48 85 f6             	test   rsi,rsi
   1838eb6ad:	74 1d                	je     0x1838eb6cc
   1838eb6af:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1838eb6b3:	75 17                	jne    0x1838eb6cc
   1838eb6b5:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838eb6b8:	48 89 f1             	mov    rcx,rsi
   1838eb6bb:	ff 10                	call   QWORD PTR [rax]
   1838eb6bd:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1838eb6c1:	75 09                	jne    0x1838eb6cc
   1838eb6c3:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838eb6c6:	48 89 f1             	mov    rcx,rsi
   1838eb6c9:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1838eb6cc:	48 8b b5 18 0a 00 00 	mov    rsi,QWORD PTR [rbp+0xa18]
   1838eb6d3:	48 85 f6             	test   rsi,rsi
   1838eb6d6:	74 1d                	je     0x1838eb6f5
   1838eb6d8:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1838eb6dc:	75 17                	jne    0x1838eb6f5
   1838eb6de:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838eb6e1:	48 89 f1             	mov    rcx,rsi
   1838eb6e4:	ff 10                	call   QWORD PTR [rax]
   1838eb6e6:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1838eb6ea:	75 09                	jne    0x1838eb6f5
   1838eb6ec:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838eb6ef:	48 89 f1             	mov    rcx,rsi
   1838eb6f2:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1838eb6f5:	48 8b 85 88 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa88]
   1838eb6fc:	48 85 c0             	test   rax,rax
   1838eb6ff:	74 68                	je     0x1838eb769
   1838eb701:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1838eb705:	48 8b b5 88 0a 00 00 	mov    rsi,QWORD PTR [rbp+0xa88]
   1838eb70c:	0f 28 85 80 0a 00 00 	movaps xmm0,XMMWORD PTR [rbp+0xa80]
   1838eb713:	0f 29 45 c0          	movaps XMMWORD PTR [rbp-0x40],xmm0
   1838eb717:	48 85 f6             	test   rsi,rsi
   1838eb71a:	74 1d                	je     0x1838eb739
   1838eb71c:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1838eb720:	75 17                	jne    0x1838eb739
   1838eb722:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838eb725:	48 89 f1             	mov    rcx,rsi
   1838eb728:	ff 10                	call   QWORD PTR [rax]
   1838eb72a:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1838eb72e:	75 09                	jne    0x1838eb739
   1838eb730:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838eb733:	48 89 f1             	mov    rcx,rsi
   1838eb736:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1838eb739:	48 8b 85 38 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa38]
   1838eb740:	48 83 f8 10          	cmp    rax,0x10
   1838eb744:	73 43                	jae    0x1838eb789
   1838eb746:	48 8b 85 c8 0a 00 00 	mov    rax,QWORD PTR [rbp+0xac8]
   1838eb74d:	48 83 f8 10          	cmp    rax,0x10
   1838eb751:	73 7b                	jae    0x1838eb7ce
   1838eb753:	48 8b 85 e8 09 00 00 	mov    rax,QWORD PTR [rbp+0x9e8]
   1838eb75a:	48 83 f8 10          	cmp    rax,0x10
   1838eb75e:	0f 83 af 00 00 00    	jae    0x1838eb813
   1838eb764:	e9 e2 00 00 00       	jmp    0x1838eb84b
   1838eb769:	48 8b 85 80 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa80]
   1838eb770:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
   1838eb774:	48 c7 45 c8 00 00 00 	mov    QWORD PTR [rbp-0x38],0x0
   1838eb77b:	00 
   1838eb77c:	48 8b 85 38 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa38]
   1838eb783:	48 83 f8 10          	cmp    rax,0x10
   1838eb787:	72 bd                	jb     0x1838eb746
   1838eb789:	48 8b 8d 20 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xa20]
   1838eb790:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838eb794:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838eb79b:	72 1f                	jb     0x1838eb7bc
   1838eb79d:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838eb7a1:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838eb7a5:	4c 29 c1             	sub    rcx,r8
   1838eb7a8:	48 83 f9 20          	cmp    rcx,0x20
   1838eb7ac:	0f 83 29 15 00 00    	jae    0x1838eccdb
   1838eb7b2:	48 83 c0 28          	add    rax,0x28
   1838eb7b6:	48 89 c2             	mov    rdx,rax
   1838eb7b9:	4c 89 c1             	mov    rcx,r8
   1838eb7bc:	e8 5f 05 c6 03       	call   0x18754bd20
   1838eb7c1:	48 8b 85 c8 0a 00 00 	mov    rax,QWORD PTR [rbp+0xac8]
   1838eb7c8:	48 83 f8 10          	cmp    rax,0x10
   1838eb7cc:	72 85                	jb     0x1838eb753
   1838eb7ce:	48 8b 8d b0 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xab0]
   1838eb7d5:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838eb7d9:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838eb7e0:	72 1f                	jb     0x1838eb801
   1838eb7e2:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838eb7e6:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838eb7ea:	4c 29 c1             	sub    rcx,r8
   1838eb7ed:	48 83 f9 20          	cmp    rcx,0x20
   1838eb7f1:	0f 83 e4 14 00 00    	jae    0x1838eccdb
   1838eb7f7:	48 83 c0 28          	add    rax,0x28
   1838eb7fb:	48 89 c2             	mov    rdx,rax
   1838eb7fe:	4c 89 c1             	mov    rcx,r8
   1838eb801:	e8 1a 05 c6 03       	call   0x18754bd20
   1838eb806:	48 8b 85 e8 09 00 00 	mov    rax,QWORD PTR [rbp+0x9e8]
   1838eb80d:	48 83 f8 10          	cmp    rax,0x10
   1838eb811:	72 38                	jb     0x1838eb84b
   1838eb813:	48 8b 8d d0 09 00 00 	mov    rcx,QWORD PTR [rbp+0x9d0]
   1838eb81a:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838eb81e:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838eb825:	72 1f                	jb     0x1838eb846
   1838eb827:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838eb82b:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838eb82f:	4c 29 c1             	sub    rcx,r8
   1838eb832:	48 83 f9 20          	cmp    rcx,0x20
   1838eb836:	0f 83 9f 14 00 00    	jae    0x1838eccdb
   1838eb83c:	48 83 c0 28          	add    rax,0x28
   1838eb840:	48 89 c2             	mov    rdx,rax
   1838eb843:	4c 89 c1             	mov    rcx,r8
   1838eb846:	e8 d5 04 c6 03       	call   0x18754bd20
   1838eb84b:	48 c7 85 78 0a 00 00 	mov    QWORD PTR [rbp+0xa78],0x0
   1838eb852:	00 00 00 00 
   1838eb856:	31 ff                	xor    edi,edi
   1838eb858:	48 c7 85 d0 0a 00 00 	mov    QWORD PTR [rbp+0xad0],0x0
   1838eb85f:	00 00 00 00 
   1838eb863:	48 8d 8d 58 08 00 00 	lea    rcx,[rbp+0x858]
   1838eb86a:	4c 89 fa             	mov    rdx,r15
   1838eb86d:	4c 8d 85 74 0a 00 00 	lea    r8,[rbp+0xa74]
   1838eb874:	4d 89 f1             	mov    r9,r14
   1838eb877:	e8 64 d1 60 fd       	call   0x180ef89e0
   1838eb87c:	90                   	nop
   1838eb87d:	48 8b 75 c8          	mov    rsi,QWORD PTR [rbp-0x38]
   1838eb881:	48 85 f6             	test   rsi,rsi
   1838eb884:	74 2a                	je     0x1838eb8b0
   1838eb886:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1838eb88a:	75 24                	jne    0x1838eb8b0
   1838eb88c:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838eb88f:	48 89 f1             	mov    rcx,rsi
   1838eb892:	ff 10                	call   QWORD PTR [rax]
   1838eb894:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1838eb898:	75 16                	jne    0x1838eb8b0
   1838eb89a:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838eb89d:	48 89 f1             	mov    rcx,rsi
   1838eb8a0:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1838eb8a3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   1838eb8aa:	84 00 00 00 00 00 
   1838eb8b0:	48 8b 85 d0 0a 00 00 	mov    rax,QWORD PTR [rbp+0xad0]
   1838eb8b7:	48 85 c0             	test   rax,rax
   1838eb8ba:	74 65                	je     0x1838eb921
   1838eb8bc:	48 39 f8             	cmp    rax,rdi
   1838eb8bf:	74 25                	je     0x1838eb8e6
   1838eb8c1:	48 8b b5 d0 0a 00 00 	mov    rsi,QWORD PTR [rbp+0xad0]
   1838eb8c8:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
   1838eb8cf:	00 
   1838eb8d0:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838eb8d3:	48 89 f1             	mov    rcx,rsi
   1838eb8d6:	31 d2                	xor    edx,edx
   1838eb8d8:	ff 10                	call   QWORD PTR [rax]
   1838eb8da:	48 81 c6 e8 02 00 00 	add    rsi,0x2e8
   1838eb8e1:	48 39 fe             	cmp    rsi,rdi
   1838eb8e4:	75 ea                	jne    0x1838eb8d0
   1838eb8e6:	48 8b 95 78 0a 00 00 	mov    rdx,QWORD PTR [rbp+0xa78]
   1838eb8ed:	48 8b 8d d0 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xad0]
   1838eb8f4:	48 29 ca             	sub    rdx,rcx
   1838eb8f7:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838eb8fe:	72 1c                	jb     0x1838eb91c
   1838eb900:	48 8b 41 f8          	mov    rax,QWORD PTR [rcx-0x8]
   1838eb904:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838eb908:	48 29 c1             	sub    rcx,rax
   1838eb90b:	48 83 f9 20          	cmp    rcx,0x20
   1838eb90f:	0f 83 c6 13 00 00    	jae    0x1838eccdb
   1838eb915:	48 83 c2 27          	add    rdx,0x27
   1838eb919:	48 89 c1             	mov    rcx,rax
   1838eb91c:	e8 ff 03 c6 03       	call   0x18754bd20
   1838eb921:	48 8b b5 c8 08 00 00 	mov    rsi,QWORD PTR [rbp+0x8c8]
   1838eb928:	48 85 f6             	test   rsi,rsi
   1838eb92b:	0f 84 0f ed ff ff    	je     0x1838ea640
   1838eb931:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1838eb935:	0f 85 05 ed ff ff    	jne    0x1838ea640
   1838eb93b:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838eb93e:	48 89 f1             	mov    rcx,rsi
   1838eb941:	ff 10                	call   QWORD PTR [rax]
   1838eb943:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1838eb947:	0f 85 f3 ec ff ff    	jne    0x1838ea640
   1838eb94d:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838eb950:	48 89 f1             	mov    rcx,rsi
   1838eb953:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1838eb956:	e9 e5 ec ff ff       	jmp    0x1838ea640
   1838eb95b:	49 8d 4e 01          	lea    rcx,[r14+0x1]
   1838eb95f:	e8 78 03 c6 03       	call   0x18754bcdc
   1838eb964:	90                   	nop
   1838eb965:	48 89 85 20 0a 00 00 	mov    QWORD PTR [rbp+0xa20],rax
   1838eb96c:	4c 89 bd 30 0a 00 00 	mov    QWORD PTR [rbp+0xa30],r15
   1838eb973:	4c 89 b5 38 0a 00 00 	mov    QWORD PTR [rbp+0xa38],r14
   1838eb97a:	49 ff c7             	inc    r15
   1838eb97d:	48 89 c1             	mov    rcx,rax
   1838eb980:	48 89 f2             	mov    rdx,rsi
   1838eb983:	4d 89 f8             	mov    r8,r15
   1838eb986:	e8 b5 94 e2 03       	call   0x187714e40
   1838eb98b:	4c 8d 75 c0          	lea    r14,[rbp-0x40]
   1838eb98f:	48 8d 85 40 0a 00 00 	lea    rax,[rbp+0xa40]
   1838eb996:	0f 11 38             	movups XMMWORD PTR [rax],xmm7
   1838eb999:	48 c7 40 10 00 00 00 	mov    QWORD PTR [rax+0x10],0x0
   1838eb9a0:	00 
   1838eb9a1:	48 b8 ff ff ff ff 00 	movabs rax,0x80000000ffffffff
   1838eb9a8:	00 00 80 
   1838eb9ab:	48 89 85 58 0a 00 00 	mov    QWORD PTR [rbp+0xa58],rax
   1838eb9b2:	48 8d 85 20 0a 00 00 	lea    rax,[rbp+0xa20]
   1838eb9b9:	48 89 85 60 09 00 00 	mov    QWORD PTR [rbp+0x960],rax
   1838eb9c0:	48 8b 85 a8 0a 00 00 	mov    rax,QWORD PTR [rbp+0xaa8]
   1838eb9c7:	48 89 85 68 09 00 00 	mov    QWORD PTR [rbp+0x968],rax
   1838eb9ce:	48 8d 85 b8 09 00 00 	lea    rax,[rbp+0x9b8]
   1838eb9d5:	0f 11 38             	movups XMMWORD PTR [rax],xmm7
   1838eb9d8:	48 c7 40 10 00 00 00 	mov    QWORD PTR [rax+0x10],0x0
   1838eb9df:	00 
   1838eb9e0:	48 8b 85 d0 0a 00 00 	mov    rax,QWORD PTR [rbp+0xad0]
   1838eb9e7:	48 89 85 70 09 00 00 	mov    QWORD PTR [rbp+0x970],rax
   1838eb9ee:	48 89 bd 78 09 00 00 	mov    QWORD PTR [rbp+0x978],rdi
   1838eb9f5:	48 8b 85 78 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa78]
   1838eb9fc:	48 89 85 80 09 00 00 	mov    QWORD PTR [rbp+0x980],rax
   1838eba03:	48 8b 85 58 09 00 00 	mov    rax,QWORD PTR [rbp+0x958]
   1838eba0a:	48 89 85 88 09 00 00 	mov    QWORD PTR [rbp+0x988],rax
   1838eba11:	0f 29 b5 80 0a 00 00 	movaps XMMWORD PTR [rbp+0xa80],xmm6
   1838eba18:	48 8d 8d 80 0a 00 00 	lea    rcx,[rbp+0xa80]
   1838eba1f:	e8 8c fe 76 fc       	call   0x18005b8b0
   1838eba24:	90                   	nop
   1838eba25:	4c 8d bd d0 08 00 00 	lea    r15,[rbp+0x8d0]
   1838eba2c:	0f 29 bd 10 0a 00 00 	movaps XMMWORD PTR [rbp+0xa10],xmm7
   1838eba33:	48 8b 85 88 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa88]
   1838eba3a:	48 85 c0             	test   rax,rax
   1838eba3d:	74 0d                	je     0x1838eba4c
   1838eba3f:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1838eba43:	48 8b 8d 88 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xa88]
   1838eba4a:	eb 02                	jmp    0x1838eba4e
   1838eba4c:	31 c9                	xor    ecx,ecx
   1838eba4e:	48 8b 85 80 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa80]
   1838eba55:	48 89 85 10 0a 00 00 	mov    QWORD PTR [rbp+0xa10],rax
   1838eba5c:	48 89 8d 18 0a 00 00 	mov    QWORD PTR [rbp+0xa18],rcx
   1838eba63:	0f 29 b5 90 0a 00 00 	movaps XMMWORD PTR [rbp+0xa90],xmm6
   1838eba6a:	48 8b 95 a8 0a 00 00 	mov    rdx,QWORD PTR [rbp+0xaa8]
   1838eba71:	48 89 55 c0          	mov    QWORD PTR [rbp-0x40],rdx
   1838eba75:	48 8d 95 68 09 00 00 	lea    rdx,[rbp+0x968]
   1838eba7c:	0f 11 7a 08          	movups XMMWORD PTR [rdx+0x8],xmm7
   1838eba80:	48 c7 42 18 00 00 00 	mov    QWORD PTR [rdx+0x18],0x0
   1838eba87:	00 
   1838eba88:	48 85 c9             	test   rcx,rcx
   1838eba8b:	74 14                	je     0x1838ebaa1
   1838eba8d:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   1838eba91:	48 8b 85 10 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa10]
   1838eba98:	48 8b b5 18 0a 00 00 	mov    rsi,QWORD PTR [rbp+0xa18]
   1838eba9f:	eb 02                	jmp    0x1838ebaa3
   1838ebaa1:	31 f6                	xor    esi,esi
   1838ebaa3:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
   1838ebaa7:	48 89 75 e8          	mov    QWORD PTR [rbp-0x18],rsi
   1838ebaab:	48 c7 85 08 09 00 00 	mov    QWORD PTR [rbp+0x908],0x0
   1838ebab2:	00 00 00 00 
   1838ebab6:	48 8d 0d 3b 6d df 05 	lea    rcx,[rip+0x5df6d3b]        # 0x1896e27f8
   1838ebabd:	48 89 8d d0 08 00 00 	mov    QWORD PTR [rbp+0x8d0],rcx
   1838ebac4:	48 8b 8d a8 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xaa8]
   1838ebacb:	48 89 8d d8 08 00 00 	mov    QWORD PTR [rbp+0x8d8],rcx
   1838ebad2:	48 8d 4d c8          	lea    rcx,[rbp-0x38]
   1838ebad6:	0f 11 39             	movups XMMWORD PTR [rcx],xmm7
   1838ebad9:	48 c7 41 10 00 00 00 	mov    QWORD PTR [rcx+0x10],0x0
   1838ebae0:	00 
   1838ebae1:	48 8b 8d d0 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xad0]
   1838ebae8:	48 89 8d e0 08 00 00 	mov    QWORD PTR [rbp+0x8e0],rcx
   1838ebaef:	48 89 bd e8 08 00 00 	mov    QWORD PTR [rbp+0x8e8],rdi
   1838ebaf6:	48 8b 8d 78 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xa78]
   1838ebafd:	48 89 8d f0 08 00 00 	mov    QWORD PTR [rbp+0x8f0],rcx
   1838ebb04:	48 8d 8d f8 08 00 00 	lea    rcx,[rbp+0x8f8]
   1838ebb0b:	0f 11 39             	movups XMMWORD PTR [rcx],xmm7
   1838ebb0e:	48 85 f6             	test   rsi,rsi
   1838ebb11:	74 04                	je     0x1838ebb17
   1838ebb13:	f0 ff 46 08          	lock inc DWORD PTR [rsi+0x8]
   1838ebb17:	48 89 85 f8 08 00 00 	mov    QWORD PTR [rbp+0x8f8],rax
   1838ebb1e:	48 89 b5 00 09 00 00 	mov    QWORD PTR [rbp+0x900],rsi
   1838ebb25:	4c 89 bd 08 09 00 00 	mov    QWORD PTR [rbp+0x908],r15
   1838ebb2c:	48 8b 8d 58 09 00 00 	mov    rcx,QWORD PTR [rbp+0x958]
   1838ebb33:	48 8d 95 90 0a 00 00 	lea    rdx,[rbp+0xa90]
   1838ebb3a:	4c 8d 85 20 0a 00 00 	lea    r8,[rbp+0xa20]
   1838ebb41:	4d 89 f9             	mov    r9,r15
   1838ebb44:	e8 d7 fc ad fc       	call   0x1803cb820
   1838ebb49:	90                   	nop
   1838ebb4a:	48 85 f6             	test   rsi,rsi
   1838ebb4d:	74 1d                	je     0x1838ebb6c
   1838ebb4f:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1838ebb53:	75 17                	jne    0x1838ebb6c
   1838ebb55:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838ebb58:	48 89 f1             	mov    rcx,rsi
   1838ebb5b:	ff 10                	call   QWORD PTR [rax]
   1838ebb5d:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1838ebb61:	75 09                	jne    0x1838ebb6c
   1838ebb63:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838ebb66:	48 89 f1             	mov    rcx,rsi
   1838ebb69:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1838ebb6c:	4c 8b 85 98 0a 00 00 	mov    r8,QWORD PTR [rbp+0xa98]
   1838ebb73:	4d 85 c0             	test   r8,r8
   1838ebb76:	74 13                	je     0x1838ebb8b
   1838ebb78:	48 8b 85 90 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa90]
   1838ebb7f:	f0 41 ff 40 0c       	lock inc DWORD PTR [r8+0xc]
   1838ebb84:	f0 41 ff 40 0c       	lock inc DWORD PTR [r8+0xc]
   1838ebb89:	eb 02                	jmp    0x1838ebb8d
   1838ebb8b:	31 c0                	xor    eax,eax
   1838ebb8d:	48 8b 8d 10 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xa10]
   1838ebb94:	48 8d 15 3d 6e df 05 	lea    rdx,[rip+0x5df6e3d]        # 0x1896e29d8
   1838ebb9b:	48 89 55 c0          	mov    QWORD PTR [rbp-0x40],rdx
   1838ebb9f:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
   1838ebba3:	4c 89 85 d0 0a 00 00 	mov    QWORD PTR [rbp+0xad0],r8
   1838ebbaa:	4c 89 45 d0          	mov    QWORD PTR [rbp-0x30],r8
   1838ebbae:	4c 89 75 f8          	mov    QWORD PTR [rbp-0x8],r14
   1838ebbb2:	4c 89 f2             	mov    rdx,r14
   1838ebbb5:	e8 e6 7b ac fc       	call   0x1803b37a0
   1838ebbba:	90                   	nop
   1838ebbbb:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
   1838ebbbf:	48 85 c9             	test   rcx,rcx
   1838ebbc2:	4c 8d 75 c0          	lea    r14,[rbp-0x40]
   1838ebbc6:	74 0c                	je     0x1838ebbd4
   1838ebbc8:	4c 39 f1             	cmp    rcx,r14
   1838ebbcb:	0f 95 c2             	setne  dl
   1838ebbce:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   1838ebbd1:	ff 50 20             	call   QWORD PTR [rax+0x20]
   1838ebbd4:	48 8b 8d d0 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xad0]
   1838ebbdb:	48 85 c9             	test   rcx,rcx
   1838ebbde:	74 0c                	je     0x1838ebbec
   1838ebbe0:	f0 ff 49 0c          	lock dec DWORD PTR [rcx+0xc]
   1838ebbe4:	75 06                	jne    0x1838ebbec
   1838ebbe6:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   1838ebbe9:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1838ebbec:	48 8b b5 98 0a 00 00 	mov    rsi,QWORD PTR [rbp+0xa98]
   1838ebbf3:	48 85 f6             	test   rsi,rsi
   1838ebbf6:	74 1d                	je     0x1838ebc15
   1838ebbf8:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1838ebbfc:	75 17                	jne    0x1838ebc15
   1838ebbfe:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838ebc01:	48 89 f1             	mov    rcx,rsi
   1838ebc04:	ff 10                	call   QWORD PTR [rax]
   1838ebc06:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1838ebc0a:	75 09                	jne    0x1838ebc15
   1838ebc0c:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838ebc0f:	48 89 f1             	mov    rcx,rsi
   1838ebc12:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1838ebc15:	48 8b b5 18 0a 00 00 	mov    rsi,QWORD PTR [rbp+0xa18]
   1838ebc1c:	48 85 f6             	test   rsi,rsi
   1838ebc1f:	74 1d                	je     0x1838ebc3e
   1838ebc21:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1838ebc25:	75 17                	jne    0x1838ebc3e
   1838ebc27:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838ebc2a:	48 89 f1             	mov    rcx,rsi
   1838ebc2d:	ff 10                	call   QWORD PTR [rax]
   1838ebc2f:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1838ebc33:	75 09                	jne    0x1838ebc3e
   1838ebc35:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838ebc38:	48 89 f1             	mov    rcx,rsi
   1838ebc3b:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1838ebc3e:	48 8b 85 88 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa88]
   1838ebc45:	48 85 c0             	test   rax,rax
   1838ebc48:	74 68                	je     0x1838ebcb2
   1838ebc4a:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1838ebc4e:	48 8b b5 88 0a 00 00 	mov    rsi,QWORD PTR [rbp+0xa88]
   1838ebc55:	0f 28 85 80 0a 00 00 	movaps xmm0,XMMWORD PTR [rbp+0xa80]
   1838ebc5c:	0f 29 45 c0          	movaps XMMWORD PTR [rbp-0x40],xmm0
   1838ebc60:	48 85 f6             	test   rsi,rsi
   1838ebc63:	74 1d                	je     0x1838ebc82
   1838ebc65:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1838ebc69:	75 17                	jne    0x1838ebc82
   1838ebc6b:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838ebc6e:	48 89 f1             	mov    rcx,rsi
   1838ebc71:	ff 10                	call   QWORD PTR [rax]
   1838ebc73:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1838ebc77:	75 09                	jne    0x1838ebc82
   1838ebc79:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838ebc7c:	48 89 f1             	mov    rcx,rsi
   1838ebc7f:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1838ebc82:	48 8b 85 38 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa38]
   1838ebc89:	48 83 f8 10          	cmp    rax,0x10
   1838ebc8d:	73 43                	jae    0x1838ebcd2
   1838ebc8f:	48 8b 85 c8 0a 00 00 	mov    rax,QWORD PTR [rbp+0xac8]
   1838ebc96:	48 83 f8 10          	cmp    rax,0x10
   1838ebc9a:	73 7b                	jae    0x1838ebd17
   1838ebc9c:	48 8b 85 e8 09 00 00 	mov    rax,QWORD PTR [rbp+0x9e8]
   1838ebca3:	48 83 f8 10          	cmp    rax,0x10
   1838ebca7:	0f 83 af 00 00 00    	jae    0x1838ebd5c
   1838ebcad:	e9 e2 00 00 00       	jmp    0x1838ebd94
   1838ebcb2:	48 8b 85 80 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa80]
   1838ebcb9:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
   1838ebcbd:	48 c7 45 c8 00 00 00 	mov    QWORD PTR [rbp-0x38],0x0
   1838ebcc4:	00 
   1838ebcc5:	48 8b 85 38 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa38]
   1838ebccc:	48 83 f8 10          	cmp    rax,0x10
   1838ebcd0:	72 bd                	jb     0x1838ebc8f
   1838ebcd2:	48 8b 8d 20 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xa20]
   1838ebcd9:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838ebcdd:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838ebce4:	72 1f                	jb     0x1838ebd05
   1838ebce6:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838ebcea:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838ebcee:	4c 29 c1             	sub    rcx,r8
   1838ebcf1:	48 83 f9 20          	cmp    rcx,0x20
   1838ebcf5:	0f 83 e0 0f 00 00    	jae    0x1838eccdb
   1838ebcfb:	48 83 c0 28          	add    rax,0x28
   1838ebcff:	48 89 c2             	mov    rdx,rax
   1838ebd02:	4c 89 c1             	mov    rcx,r8
   1838ebd05:	e8 16 00 c6 03       	call   0x18754bd20
   1838ebd0a:	48 8b 85 c8 0a 00 00 	mov    rax,QWORD PTR [rbp+0xac8]
   1838ebd11:	48 83 f8 10          	cmp    rax,0x10
   1838ebd15:	72 85                	jb     0x1838ebc9c
   1838ebd17:	48 8b 8d b0 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xab0]
   1838ebd1e:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838ebd22:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838ebd29:	72 1f                	jb     0x1838ebd4a
   1838ebd2b:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838ebd2f:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838ebd33:	4c 29 c1             	sub    rcx,r8
   1838ebd36:	48 83 f9 20          	cmp    rcx,0x20
   1838ebd3a:	0f 83 9b 0f 00 00    	jae    0x1838eccdb
   1838ebd40:	48 83 c0 28          	add    rax,0x28
   1838ebd44:	48 89 c2             	mov    rdx,rax
   1838ebd47:	4c 89 c1             	mov    rcx,r8
   1838ebd4a:	e8 d1 ff c5 03       	call   0x18754bd20
   1838ebd4f:	48 8b 85 e8 09 00 00 	mov    rax,QWORD PTR [rbp+0x9e8]
   1838ebd56:	48 83 f8 10          	cmp    rax,0x10
   1838ebd5a:	72 38                	jb     0x1838ebd94
   1838ebd5c:	48 8b 8d d0 09 00 00 	mov    rcx,QWORD PTR [rbp+0x9d0]
   1838ebd63:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838ebd67:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838ebd6e:	72 1f                	jb     0x1838ebd8f
   1838ebd70:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838ebd74:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838ebd78:	4c 29 c1             	sub    rcx,r8
   1838ebd7b:	48 83 f9 20          	cmp    rcx,0x20
   1838ebd7f:	0f 83 56 0f 00 00    	jae    0x1838eccdb
   1838ebd85:	48 83 c0 28          	add    rax,0x28
   1838ebd89:	48 89 c2             	mov    rdx,rax
   1838ebd8c:	4c 89 c1             	mov    rcx,r8
   1838ebd8f:	e8 8c ff c5 03       	call   0x18754bd20
   1838ebd94:	48 c7 85 78 0a 00 00 	mov    QWORD PTR [rbp+0xa78],0x0
   1838ebd9b:	00 00 00 00 
   1838ebd9f:	31 ff                	xor    edi,edi
   1838ebda1:	48 c7 85 d0 0a 00 00 	mov    QWORD PTR [rbp+0xad0],0x0
   1838ebda8:	00 00 00 00 
   1838ebdac:	48 8d 8d 58 08 00 00 	lea    rcx,[rbp+0x858]
   1838ebdb3:	4c 89 fa             	mov    rdx,r15
   1838ebdb6:	4c 8d 85 74 0a 00 00 	lea    r8,[rbp+0xa74]
   1838ebdbd:	4d 89 f1             	mov    r9,r14
   1838ebdc0:	e8 1b cc 60 fd       	call   0x180ef89e0
   1838ebdc5:	90                   	nop
   1838ebdc6:	48 8b 75 c8          	mov    rsi,QWORD PTR [rbp-0x38]
   1838ebdca:	48 85 f6             	test   rsi,rsi
   1838ebdcd:	74 21                	je     0x1838ebdf0
   1838ebdcf:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1838ebdd3:	75 1b                	jne    0x1838ebdf0
   1838ebdd5:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838ebdd8:	48 89 f1             	mov    rcx,rsi
   1838ebddb:	ff 10                	call   QWORD PTR [rax]
   1838ebddd:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1838ebde1:	75 0d                	jne    0x1838ebdf0
   1838ebde3:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838ebde6:	48 89 f1             	mov    rcx,rsi
   1838ebde9:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1838ebdec:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
   1838ebdf0:	48 8b 85 d0 0a 00 00 	mov    rax,QWORD PTR [rbp+0xad0]
   1838ebdf7:	48 85 c0             	test   rax,rax
   1838ebdfa:	74 65                	je     0x1838ebe61
   1838ebdfc:	48 39 f8             	cmp    rax,rdi
   1838ebdff:	74 25                	je     0x1838ebe26
   1838ebe01:	48 8b b5 d0 0a 00 00 	mov    rsi,QWORD PTR [rbp+0xad0]
   1838ebe08:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
   1838ebe0f:	00 
   1838ebe10:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838ebe13:	48 89 f1             	mov    rcx,rsi
   1838ebe16:	31 d2                	xor    edx,edx
   1838ebe18:	ff 10                	call   QWORD PTR [rax]
   1838ebe1a:	48 81 c6 e8 02 00 00 	add    rsi,0x2e8
   1838ebe21:	48 39 fe             	cmp    rsi,rdi
   1838ebe24:	75 ea                	jne    0x1838ebe10
   1838ebe26:	48 8b 95 78 0a 00 00 	mov    rdx,QWORD PTR [rbp+0xa78]
   1838ebe2d:	48 8b 8d d0 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xad0]
   1838ebe34:	48 29 ca             	sub    rdx,rcx
   1838ebe37:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838ebe3e:	72 1c                	jb     0x1838ebe5c
   1838ebe40:	48 8b 41 f8          	mov    rax,QWORD PTR [rcx-0x8]
   1838ebe44:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838ebe48:	48 29 c1             	sub    rcx,rax
   1838ebe4b:	48 83 f9 20          	cmp    rcx,0x20
   1838ebe4f:	0f 83 86 0e 00 00    	jae    0x1838eccdb
   1838ebe55:	48 83 c2 27          	add    rdx,0x27
   1838ebe59:	48 89 c1             	mov    rcx,rax
   1838ebe5c:	e8 bf fe c5 03       	call   0x18754bd20
   1838ebe61:	48 8b b5 c8 08 00 00 	mov    rsi,QWORD PTR [rbp+0x8c8]
   1838ebe68:	48 85 f6             	test   rsi,rsi
   1838ebe6b:	74 23                	je     0x1838ebe90
   1838ebe6d:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1838ebe71:	75 1d                	jne    0x1838ebe90
   1838ebe73:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838ebe76:	48 89 f1             	mov    rcx,rsi
   1838ebe79:	ff 10                	call   QWORD PTR [rax]
   1838ebe7b:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1838ebe7f:	75 0f                	jne    0x1838ebe90
   1838ebe81:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1838ebe84:	48 89 f1             	mov    rcx,rsi
   1838ebe87:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1838ebe8a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
   1838ebe90:	48 8d bd d0 09 00 00 	lea    rdi,[rbp+0x9d0]
   1838ebe97:	e9 ab e7 ff ff       	jmp    0x1838ea647
   1838ebe9c:	c7 85 d0 09 00 00 ff 	mov    DWORD PTR [rbp+0x9d0],0xffffffff
   1838ebea3:	ff ff ff 
   1838ebea6:	0f 11 b5 d4 09 00 00 	movups XMMWORD PTR [rbp+0x9d4],xmm6
   1838ebead:	0f 11 b5 e4 09 00 00 	movups XMMWORD PTR [rbp+0x9e4],xmm6
   1838ebeb4:	0f 11 b5 f4 09 00 00 	movups XMMWORD PTR [rbp+0x9f4],xmm6
   1838ebebb:	0f 11 b5 00 0a 00 00 	movups XMMWORD PTR [rbp+0xa00],xmm6
   1838ebec2:	c7 45 c0 00 00 00 00 	mov    DWORD PTR [rbp-0x40],0x0
   1838ebec9:	48 8d 8d d0 09 00 00 	lea    rcx,[rbp+0x9d0]
   1838ebed0:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   1838ebed4:	4c 8d 85 d0 08 00 00 	lea    r8,[rbp+0x8d0]
   1838ebedb:	e8 f0 7a 09 00       	call   0x1839839d0
   1838ebee0:	90                   	nop
   1838ebee1:	48 8b 9d 60 08 00 00 	mov    rbx,QWORD PTR [rbp+0x860]
   1838ebee8:	c6 85 a8 0a 00 00 01 	mov    BYTE PTR [rbp+0xaa8],0x1
   1838ebeef:	0f 57 ff             	xorps  xmm7,xmm7
   1838ebef2:	4c 8d 75 c0          	lea    r14,[rbp-0x40]
   1838ebef6:	48 8d 85 b0 09 00 00 	lea    rax,[rbp+0x9b0]
   1838ebefd:	48 89 85 d0 0a 00 00 	mov    QWORD PTR [rbp+0xad0],rax
   1838ebf04:	48 89 de             	mov    rsi,rbx
   1838ebf07:	eb 12                	jmp    0x1838ebf1b
   1838ebf09:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
   1838ebf10:	40 20 bd a8 0a 00 00 	and    BYTE PTR [rbp+0xaa8],dil
   1838ebf17:	4c 8d 75 c0          	lea    r14,[rbp-0x40]
   1838ebf1b:	48 8b 36             	mov    rsi,QWORD PTR [rsi]
   1838ebf1e:	48 39 de             	cmp    rsi,rbx
   1838ebf21:	0f 84 15 04 00 00    	je     0x1838ec33c
   1838ebf27:	0f 29 bd b0 09 00 00 	movaps XMMWORD PTR [rbp+0x9b0],xmm7
   1838ebf2e:	48 8b 46 20          	mov    rax,QWORD PTR [rsi+0x20]
   1838ebf32:	48 85 c0             	test   rax,rax
   1838ebf35:	74 19                	je     0x1838ebf50
   1838ebf37:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1838ebf3b:	48 8b 46 20          	mov    rax,QWORD PTR [rsi+0x20]
   1838ebf3f:	eb 11                	jmp    0x1838ebf52
   1838ebf41:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   1838ebf48:	0f 1f 84 00 00 00 00 
   1838ebf4f:	00 
   1838ebf50:	31 c0                	xor    eax,eax
   1838ebf52:	48 8b 4e 18          	mov    rcx,QWORD PTR [rsi+0x18]
   1838ebf56:	48 89 8d b0 09 00 00 	mov    QWORD PTR [rbp+0x9b0],rcx
   1838ebf5d:	48 89 85 b8 09 00 00 	mov    QWORD PTR [rbp+0x9b8],rax
   1838ebf64:	4c 89 f1             	mov    rcx,r14
   1838ebf67:	48 8d 95 b0 09 00 00 	lea    rdx,[rbp+0x9b0]
   1838ebf6e:	e8 ed 23 00 00       	call   0x1838ee360
   1838ebf73:	90                   	nop
   1838ebf74:	49 89 c7             	mov    r15,rax
   1838ebf77:	0f b6 78 18          	movzx  edi,BYTE PTR [rax+0x18]
   1838ebf7b:	40 84 ff             	test   dil,dil
   1838ebf7e:	0f 84 2c 02 00 00    	je     0x1838ec1b0
   1838ebf84:	b9 02 00 00 00       	mov    ecx,0x2
   1838ebf89:	e8 52 0e 78 fc       	call   0x18006cde0
   1838ebf8e:	85 c0                	test   eax,eax
   1838ebf90:	0f 84 f3 01 00 00    	je     0x1838ec189
   1838ebf96:	48 8d 8d b0 0a 00 00 	lea    rcx,[rbp+0xab0]
   1838ebf9d:	e8 6e 0f 78 fc       	call   0x18006cf10
   1838ebfa2:	90                   	nop
   1838ebfa3:	48 83 bd c8 0a 00 00 	cmp    QWORD PTR [rbp+0xac8],0x10
   1838ebfaa:	10 
   1838ebfab:	4c 8d 85 b0 0a 00 00 	lea    r8,[rbp+0xab0]
   1838ebfb2:	72 07                	jb     0x1838ebfbb
   1838ebfb4:	4c 8b 85 b0 0a 00 00 	mov    r8,QWORD PTR [rbp+0xab0]
   1838ebfbb:	48 8d 05 76 89 df 05 	lea    rax,[rip+0x5df8976]        # 0x1896e4938
   1838ebfc2:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1838ebfc7:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1838ebfce:	00 00 
   1838ebfd0:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1838ebfd5:	c7 44 24 28 89 00 00 	mov    DWORD PTR [rsp+0x28],0x89
   1838ebfdc:	00 
   1838ebfdd:	4c 89 f1             	mov    rcx,r14
   1838ebfe0:	ba 02 00 00 00       	mov    edx,0x2
   1838ebfe5:	4c 8d 0d 64 8b df 05 	lea    r9,[rip+0x5df8b64]        # 0x1896e4b50
   1838ebfec:	e8 7f 12 78 fc       	call   0x18006d270
   1838ebff1:	90                   	nop
   1838ebff2:	49 8b 4f 08          	mov    rcx,QWORD PTR [r15+0x8]
   1838ebff6:	49 2b 0f             	sub    rcx,QWORD PTR [r15]
   1838ebff9:	48 c1 f9 03          	sar    rcx,0x3
   1838ebffd:	48 b8 f5 d3 4f 3f fd 	movabs rax,0x4fd3f4fd3f4fd3f5
   1838ec004:	f4 d3 4f 
   1838ec007:	48 0f af c8          	imul   rcx,rax
   1838ec00b:	48 c7 85 20 0a 00 00 	mov    QWORD PTR [rbp+0xa20],0x0
   1838ec012:	00 00 00 00 
   1838ec016:	41 b9 07 00 00 00    	mov    r9d,0x7
   1838ec01c:	4c 8d 85 27 0a 00 00 	lea    r8,[rbp+0xa27]
   1838ec023:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   1838ec02a:	84 00 00 00 00 00 
   1838ec030:	48 89 c8             	mov    rax,rcx
   1838ec033:	49 f7 e5             	mul    r13
   1838ec036:	48 c1 ea 03          	shr    rdx,0x3
   1838ec03a:	48 8d 04 12          	lea    rax,[rdx+rdx*1]
   1838ec03e:	48 8d 04 80          	lea    rax,[rax+rax*4]
   1838ec042:	4d 89 e2             	mov    r10,r12
   1838ec045:	49 29 c2             	sub    r10,rax
   1838ec048:	41 0f b6 44 0a 23    	movzx  eax,BYTE PTR [r10+rcx*1+0x23]
   1838ec04e:	41 88 40 01          	mov    BYTE PTR [r8+0x1],al
   1838ec052:	49 ff c0             	inc    r8
   1838ec055:	49 ff c1             	inc    r9
   1838ec058:	48 83 f9 09          	cmp    rcx,0x9
   1838ec05c:	48 89 d1             	mov    rcx,rdx
   1838ec05f:	77 cf                	ja     0x1838ec030
   1838ec061:	49 89 de             	mov    r14,rbx
   1838ec064:	41 c6 40 01 00       	mov    BYTE PTR [r8+0x1],0x0
   1838ec069:	49 83 f9 09          	cmp    r9,0x9
   1838ec06d:	72 2b                	jb     0x1838ec09a
   1838ec06f:	48 8d 85 29 0a 00 00 	lea    rax,[rbp+0xa29]
   1838ec076:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
   1838ec07d:	00 00 00 
   1838ec080:	41 0f b6 08          	movzx  ecx,BYTE PTR [r8]
   1838ec084:	0f b6 50 ff          	movzx  edx,BYTE PTR [rax-0x1]
   1838ec088:	41 88 10             	mov    BYTE PTR [r8],dl
   1838ec08b:	49 ff c8             	dec    r8
   1838ec08e:	88 48 ff             	mov    BYTE PTR [rax-0x1],cl
   1838ec091:	4c 39 c0             	cmp    rax,r8
   1838ec094:	48 8d 40 01          	lea    rax,[rax+0x1]
   1838ec098:	72 e6                	jb     0x1838ec080
   1838ec09a:	48 8d 85 28 0a 00 00 	lea    rax,[rbp+0xa28]
   1838ec0a1:	48 89 85 20 0a 00 00 	mov    QWORD PTR [rbp+0xa20],rax
   1838ec0a8:	48 c7 85 60 09 00 00 	mov    QWORD PTR [rbp+0x960],0x0
   1838ec0af:	00 00 00 00 
   1838ec0b3:	48 8d 46 10          	lea    rax,[rsi+0x10]
   1838ec0b7:	44 8b 08             	mov    r9d,DWORD PTR [rax]
   1838ec0ba:	ba 41 00 00 00       	mov    edx,0x41
   1838ec0bf:	48 8d 9d 68 09 00 00 	lea    rbx,[rbp+0x968]
   1838ec0c6:	48 89 d9             	mov    rcx,rbx
   1838ec0c9:	4c 8d 05 bc 70 66 05 	lea    r8,[rip+0x56670bc]        # 0x188f5318c
   1838ec0d0:	e8 8b 2b 77 fc       	call   0x18005ec60
   1838ec0d5:	48 89 9d 60 09 00 00 	mov    QWORD PTR [rbp+0x960],rbx
   1838ec0dc:	48 8d 85 e0 08 00 00 	lea    rax,[rbp+0x8e0]
   1838ec0e3:	0f 11 78 60          	movups XMMWORD PTR [rax+0x60],xmm7
   1838ec0e7:	0f 11 78 50          	movups XMMWORD PTR [rax+0x50],xmm7
   1838ec0eb:	0f 11 78 40          	movups XMMWORD PTR [rax+0x40],xmm7
   1838ec0ef:	0f 11 78 30          	movups XMMWORD PTR [rax+0x30],xmm7
   1838ec0f3:	0f 11 78 20          	movups XMMWORD PTR [rax+0x20],xmm7
   1838ec0f7:	0f 11 78 10          	movups XMMWORD PTR [rax+0x10],xmm7
   1838ec0fb:	0f 11 38             	movups XMMWORD PTR [rax],xmm7
   1838ec0fe:	48 8d 85 60 09 00 00 	lea    rax,[rbp+0x960]
   1838ec105:	48 89 85 d0 08 00 00 	mov    QWORD PTR [rbp+0x8d0],rax
   1838ec10c:	48 8d 85 20 0a 00 00 	lea    rax,[rbp+0xa20]
   1838ec113:	48 89 85 d8 08 00 00 	mov    QWORD PTR [rbp+0x8d8],rax
   1838ec11a:	48 8d 5d c0          	lea    rbx,[rbp-0x40]
   1838ec11e:	48 89 d9             	mov    rcx,rbx
   1838ec121:	48 8d 15 30 93 df 05 	lea    rdx,[rip+0x5df9330]        # 0x1896e5458
   1838ec128:	4c 8d 85 d0 08 00 00 	lea    r8,[rbp+0x8d0]
   1838ec12f:	e8 dc 16 78 fc       	call   0x18006d810
   1838ec134:	90                   	nop
   1838ec135:	48 89 d9             	mov    rcx,rbx
   1838ec138:	e8 33 12 78 fc       	call   0x18006d370
   1838ec13d:	48 8b 85 c8 0a 00 00 	mov    rax,QWORD PTR [rbp+0xac8]
   1838ec144:	48 83 f8 10          	cmp    rax,0x10
   1838ec148:	4c 89 f3             	mov    rbx,r14
   1838ec14b:	72 38                	jb     0x1838ec185
   1838ec14d:	48 8b 8d b0 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xab0]
   1838ec154:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838ec158:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838ec15f:	72 1f                	jb     0x1838ec180
   1838ec161:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838ec165:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838ec169:	4c 29 c1             	sub    rcx,r8
   1838ec16c:	48 83 f9 20          	cmp    rcx,0x20
   1838ec170:	0f 83 65 0b 00 00    	jae    0x1838eccdb
   1838ec176:	48 83 c0 28          	add    rax,0x28
   1838ec17a:	48 89 c2             	mov    rdx,rax
   1838ec17d:	4c 89 c1             	mov    rcx,r8
   1838ec180:	e8 9b fb c5 03       	call   0x18754bd20
   1838ec185:	4c 8d 75 c0          	lea    r14,[rbp-0x40]
   1838ec189:	48 8d 8d d0 09 00 00 	lea    rcx,[rbp+0x9d0]
   1838ec190:	4c 89 f2             	mov    rdx,r14
   1838ec193:	4c 8d 46 10          	lea    r8,[rsi+0x10]
   1838ec197:	4d 89 f9             	mov    r9,r15
   1838ec19a:	e8 21 23 00 00       	call   0x1838ee4c0
   1838ec19f:	90                   	nop
   1838ec1a0:	e9 5b 01 00 00       	jmp    0x1838ec300
   1838ec1a5:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
   1838ec1ac:	00 00 00 00 
   1838ec1b0:	b9 04 00 00 00       	mov    ecx,0x4
   1838ec1b5:	e8 26 0c 78 fc       	call   0x18006cde0
   1838ec1ba:	85 c0                	test   eax,eax
   1838ec1bc:	0f 84 3e 01 00 00    	je     0x1838ec300
   1838ec1c2:	48 8d 8d 60 09 00 00 	lea    rcx,[rbp+0x960]
   1838ec1c9:	e8 42 0d 78 fc       	call   0x18006cf10
   1838ec1ce:	90                   	nop
   1838ec1cf:	48 83 bd 78 09 00 00 	cmp    QWORD PTR [rbp+0x978],0x10
   1838ec1d6:	10 
   1838ec1d7:	4c 8d 85 60 09 00 00 	lea    r8,[rbp+0x960]
   1838ec1de:	72 07                	jb     0x1838ec1e7
   1838ec1e0:	4c 8b 85 60 09 00 00 	mov    r8,QWORD PTR [rbp+0x960]
   1838ec1e7:	48 8d 05 4a 87 df 05 	lea    rax,[rip+0x5df874a]        # 0x1896e4938
   1838ec1ee:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1838ec1f3:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1838ec1fa:	00 00 
   1838ec1fc:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1838ec201:	c7 44 24 28 87 00 00 	mov    DWORD PTR [rsp+0x28],0x87
   1838ec208:	00 
   1838ec209:	4c 89 f1             	mov    rcx,r14
   1838ec20c:	ba 04 00 00 00       	mov    edx,0x4
   1838ec211:	4c 8d 0d 38 89 df 05 	lea    r9,[rip+0x5df8938]        # 0x1896e4b50
   1838ec218:	e8 53 10 78 fc       	call   0x18006d270
   1838ec21d:	90                   	nop
   1838ec21e:	4d 89 f7             	mov    r15,r14
   1838ec221:	48 c7 85 20 0a 00 00 	mov    QWORD PTR [rbp+0xa20],0x0
   1838ec228:	00 00 00 00 
   1838ec22c:	48 8d 46 10          	lea    rax,[rsi+0x10]
   1838ec230:	44 8b 08             	mov    r9d,DWORD PTR [rax]
   1838ec233:	ba 41 00 00 00       	mov    edx,0x41
   1838ec238:	4c 8d b5 28 0a 00 00 	lea    r14,[rbp+0xa28]
   1838ec23f:	4c 89 f1             	mov    rcx,r14
   1838ec242:	4c 8d 05 43 6f 66 05 	lea    r8,[rip+0x5666f43]        # 0x188f5318c
   1838ec249:	e8 12 2a 77 fc       	call   0x18005ec60
   1838ec24e:	4c 89 b5 20 0a 00 00 	mov    QWORD PTR [rbp+0xa20],r14
   1838ec255:	48 8d 85 f8 08 00 00 	lea    rax,[rbp+0x8f8]
   1838ec25c:	0f 11 78 40          	movups XMMWORD PTR [rax+0x40],xmm7
   1838ec260:	0f 11 78 30          	movups XMMWORD PTR [rax+0x30],xmm7
   1838ec264:	0f 11 78 20          	movups XMMWORD PTR [rax+0x20],xmm7
   1838ec268:	0f 11 78 10          	movups XMMWORD PTR [rax+0x10],xmm7
   1838ec26c:	0f 11 38             	movups XMMWORD PTR [rax],xmm7
   1838ec26f:	0f 11 78 f0          	movups XMMWORD PTR [rax-0x10],xmm7
   1838ec273:	0f 11 78 e0          	movups XMMWORD PTR [rax-0x20],xmm7
   1838ec277:	48 c7 40 50 00 00 00 	mov    QWORD PTR [rax+0x50],0x0
   1838ec27e:	00 
   1838ec27f:	48 8d 85 20 0a 00 00 	lea    rax,[rbp+0xa20]
   1838ec286:	48 89 85 d0 08 00 00 	mov    QWORD PTR [rbp+0x8d0],rax
   1838ec28d:	4c 89 f9             	mov    rcx,r15
   1838ec290:	48 8d 15 69 90 df 05 	lea    rdx,[rip+0x5df9069]        # 0x1896e5300
   1838ec297:	4c 8d 85 d0 08 00 00 	lea    r8,[rbp+0x8d0]
   1838ec29e:	e8 6d 15 78 fc       	call   0x18006d810
   1838ec2a3:	90                   	nop
   1838ec2a4:	4c 89 f9             	mov    rcx,r15
   1838ec2a7:	e8 c4 10 78 fc       	call   0x18006d370
   1838ec2ac:	48 8b 85 78 09 00 00 	mov    rax,QWORD PTR [rbp+0x978]
   1838ec2b3:	48 83 f8 10          	cmp    rax,0x10
   1838ec2b7:	72 47                	jb     0x1838ec300
   1838ec2b9:	48 8b 8d 60 09 00 00 	mov    rcx,QWORD PTR [rbp+0x960]
   1838ec2c0:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838ec2c4:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838ec2cb:	72 1f                	jb     0x1838ec2ec
   1838ec2cd:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838ec2d1:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838ec2d5:	4c 29 c1             	sub    rcx,r8
   1838ec2d8:	48 83 f9 20          	cmp    rcx,0x20
   1838ec2dc:	0f 83 f9 09 00 00    	jae    0x1838eccdb
   1838ec2e2:	48 83 c0 28          	add    rax,0x28
   1838ec2e6:	48 89 c2             	mov    rdx,rax
   1838ec2e9:	4c 89 c1             	mov    rcx,r8
   1838ec2ec:	e8 2f fa c5 03       	call   0x18754bd20
   1838ec2f1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   1838ec2f8:	0f 1f 84 00 00 00 00 
   1838ec2ff:	00 
   1838ec300:	4c 8b b5 b8 09 00 00 	mov    r14,QWORD PTR [rbp+0x9b8]
   1838ec307:	4d 85 f6             	test   r14,r14
   1838ec30a:	0f 84 00 fc ff ff    	je     0x1838ebf10
   1838ec310:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1838ec315:	0f 85 f5 fb ff ff    	jne    0x1838ebf10
   1838ec31b:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1838ec31e:	4c 89 f1             	mov    rcx,r14
   1838ec321:	ff 10                	call   QWORD PTR [rax]
   1838ec323:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1838ec328:	0f 85 e2 fb ff ff    	jne    0x1838ebf10
   1838ec32e:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1838ec331:	4c 89 f1             	mov    rcx,r14
   1838ec334:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1838ec337:	e9 d4 fb ff ff       	jmp    0x1838ebf10
   1838ec33c:	48 b8 aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaaa
   1838ec343:	aa aa aa 
   1838ec346:	48 89 85 b0 00 00 00 	mov    QWORD PTR [rbp+0xb0],rax
   1838ec34d:	0f 29 b5 a0 00 00 00 	movaps XMMWORD PTR [rbp+0xa0],xmm6
   1838ec354:	0f 29 b5 90 00 00 00 	movaps XMMWORD PTR [rbp+0x90],xmm6
   1838ec35b:	0f 29 b5 80 00 00 00 	movaps XMMWORD PTR [rbp+0x80],xmm6
   1838ec362:	0f 29 75 70          	movaps XMMWORD PTR [rbp+0x70],xmm6
   1838ec366:	0f 29 75 60          	movaps XMMWORD PTR [rbp+0x60],xmm6
   1838ec36a:	0f 29 75 50          	movaps XMMWORD PTR [rbp+0x50],xmm6
   1838ec36e:	0f 29 75 40          	movaps XMMWORD PTR [rbp+0x40],xmm6
   1838ec372:	0f 29 75 30          	movaps XMMWORD PTR [rbp+0x30],xmm6
   1838ec376:	0f 29 75 20          	movaps XMMWORD PTR [rbp+0x20],xmm6
   1838ec37a:	0f 29 75 10          	movaps XMMWORD PTR [rbp+0x10],xmm6
   1838ec37e:	0f 29 75 00          	movaps XMMWORD PTR [rbp+0x0],xmm6
   1838ec382:	0f 29 75 f0          	movaps XMMWORD PTR [rbp-0x10],xmm6
   1838ec386:	0f 29 75 e0          	movaps XMMWORD PTR [rbp-0x20],xmm6
   1838ec38a:	0f 29 75 d0          	movaps XMMWORD PTR [rbp-0x30],xmm6
   1838ec38e:	0f 29 75 c0          	movaps XMMWORD PTR [rbp-0x40],xmm6
   1838ec392:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1838ec396:	ba 01 00 00 00       	mov    edx,0x1
   1838ec39b:	e8 50 4f 79 fc       	call   0x1800812f0
   1838ec3a0:	90                   	nop
   1838ec3a1:	48 8d 75 d0          	lea    rsi,[rbp-0x30]
   1838ec3a5:	48 8d 15 d8 11 7b 05 	lea    rdx,[rip+0x57b11d8]        # 0x18909d584
   1838ec3ac:	48 89 f1             	mov    rcx,rsi
   1838ec3af:	e8 ac 51 79 fc       	call   0x180081560
   1838ec3b4:	90                   	nop
   1838ec3b5:	48 8b bd d8 09 00 00 	mov    rdi,QWORD PTR [rbp+0x9d8]
   1838ec3bc:	48 8d 1d c9 5c aa 05 	lea    rbx,[rip+0x5aa5cc9]        # 0x18939208c
   1838ec3c3:	4c 8d 35 a6 66 df 05 	lea    r14,[rip+0x5df66a6]        # 0x1896e2a70
   1838ec3ca:	4c 8d 3d f3 a8 62 05 	lea    r15,[rip+0x562a8f3]        # 0x188f16cc4
   1838ec3d1:	49 89 fc             	mov    r12,rdi
   1838ec3d4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   1838ec3db:	00 00 00 00 00 
   1838ec3e0:	4d 8b 24 24          	mov    r12,QWORD PTR [r12]
   1838ec3e4:	49 39 fc             	cmp    r12,rdi
   1838ec3e7:	74 59                	je     0x1838ec442
   1838ec3e9:	48 89 f1             	mov    rcx,rsi
   1838ec3ec:	48 89 da             	mov    rdx,rbx
   1838ec3ef:	e8 6c 51 79 fc       	call   0x180081560
   1838ec3f4:	90                   	nop
   1838ec3f5:	41 8b 54 24 10       	mov    edx,DWORD PTR [r12+0x10]
   1838ec3fa:	48 89 c1             	mov    rcx,rax
   1838ec3fd:	e8 ee fd 80 fc       	call   0x1800fc1f0
   1838ec402:	90                   	nop
   1838ec403:	48 89 c1             	mov    rcx,rax
   1838ec406:	4c 89 f2             	mov    rdx,r14
   1838ec409:	e8 52 51 79 fc       	call   0x180081560
   1838ec40e:	90                   	nop
   1838ec40f:	49 8b 54 24 20       	mov    rdx,QWORD PTR [r12+0x20]
   1838ec414:	49 2b 54 24 18       	sub    rdx,QWORD PTR [r12+0x18]
   1838ec419:	48 c1 fa 03          	sar    rdx,0x3
   1838ec41d:	48 b9 f5 d3 4f 3f fd 	movabs rcx,0x4fd3f4fd3f4fd3f5
   1838ec424:	f4 d3 4f 
   1838ec427:	48 0f af d1          	imul   rdx,rcx
   1838ec42b:	48 89 c1             	mov    rcx,rax
   1838ec42e:	e8 ed 03 81 fc       	call   0x1800fc820
   1838ec433:	90                   	nop
   1838ec434:	48 89 c1             	mov    rcx,rax
   1838ec437:	4c 89 fa             	mov    rdx,r15
   1838ec43a:	e8 21 51 79 fc       	call   0x180081560
   1838ec43f:	90                   	nop
   1838ec440:	eb 9e                	jmp    0x1838ec3e0
   1838ec442:	48 8d 15 33 23 6e 05 	lea    rdx,[rip+0x56e2333]        # 0x188fce77c
   1838ec449:	48 89 f1             	mov    rcx,rsi
   1838ec44c:	e8 0f 51 79 fc       	call   0x180081560
   1838ec451:	90                   	nop
   1838ec452:	0f 57 c0             	xorps  xmm0,xmm0
   1838ec455:	0f 29 85 d0 08 00 00 	movaps XMMWORD PTR [rbp+0x8d0],xmm0
   1838ec45c:	48 c7 85 e0 08 00 00 	mov    QWORD PTR [rbp+0x8e0],0x0
   1838ec463:	00 00 00 00 
   1838ec467:	48 c7 85 e8 08 00 00 	mov    QWORD PTR [rbp+0x8e8],0xf
   1838ec46e:	0f 00 00 00 
   1838ec472:	8b 45 48             	mov    eax,DWORD PTR [rbp+0x48]
   1838ec475:	89 c1                	mov    ecx,eax
   1838ec477:	83 e1 22             	and    ecx,0x22
   1838ec47a:	83 f9 02             	cmp    ecx,0x2
   1838ec47d:	74 28                	je     0x1838ec4a7
   1838ec47f:	48 8b 4d 18          	mov    rcx,QWORD PTR [rbp+0x18]
   1838ec483:	48 8b 31             	mov    rsi,QWORD PTR [rcx]
   1838ec486:	48 85 f6             	test   rsi,rsi
   1838ec489:	74 1c                	je     0x1838ec4a7
   1838ec48b:	48 8d 45 f8          	lea    rax,[rbp-0x8]
   1838ec48f:	48 8b 4d 40          	mov    rcx,QWORD PTR [rbp+0x40]
   1838ec493:	48 39 ce             	cmp    rsi,rcx
   1838ec496:	48 0f 42 f1          	cmovb  rsi,rcx
   1838ec49a:	48 8b 00             	mov    rax,QWORD PTR [rax]
   1838ec49d:	4c 8b 08             	mov    r9,QWORD PTR [rax]
   1838ec4a0:	4d 85 c9             	test   r9,r9
   1838ec4a3:	75 2b                	jne    0x1838ec4d0
   1838ec4a5:	eb 65                	jmp    0x1838ec50c
   1838ec4a7:	a8 04                	test   al,0x4
   1838ec4a9:	75 61                	jne    0x1838ec50c
   1838ec4ab:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
   1838ec4af:	48 8b 30             	mov    rsi,QWORD PTR [rax]
   1838ec4b2:	48 85 f6             	test   rsi,rsi
   1838ec4b5:	74 55                	je     0x1838ec50c
   1838ec4b7:	48 8d 45 f0          	lea    rax,[rbp-0x10]
   1838ec4bb:	48 8b 4d 28          	mov    rcx,QWORD PTR [rbp+0x28]
   1838ec4bf:	48 63 09             	movsxd rcx,DWORD PTR [rcx]
   1838ec4c2:	48 01 ce             	add    rsi,rcx
   1838ec4c5:	48 8b 00             	mov    rax,QWORD PTR [rax]
   1838ec4c8:	4c 8b 08             	mov    r9,QWORD PTR [rax]
   1838ec4cb:	4d 85 c9             	test   r9,r9
   1838ec4ce:	74 3c                	je     0x1838ec50c
   1838ec4d0:	4c 29 ce             	sub    rsi,r9
   1838ec4d3:	48 83 fe 0f          	cmp    rsi,0xf
   1838ec4d7:	76 12                	jbe    0x1838ec4eb
   1838ec4d9:	48 8d 8d d0 08 00 00 	lea    rcx,[rbp+0x8d0]
   1838ec4e0:	48 89 f2             	mov    rdx,rsi
   1838ec4e3:	e8 68 1c 75 fc       	call   0x18003e150
   1838ec4e8:	90                   	nop
   1838ec4e9:	eb 21                	jmp    0x1838ec50c
   1838ec4eb:	48 89 b5 e0 08 00 00 	mov    QWORD PTR [rbp+0x8e0],rsi
   1838ec4f2:	48 8d 8d d0 08 00 00 	lea    rcx,[rbp+0x8d0]
   1838ec4f9:	4c 89 ca             	mov    rdx,r9
   1838ec4fc:	49 89 f0             	mov    r8,rsi
   1838ec4ff:	e8 3c 89 e2 03       	call   0x187714e40
   1838ec504:	c6 84 35 d0 08 00 00 	mov    BYTE PTR [rbp+rsi*1+0x8d0],0x0
   1838ec50b:	00 
   1838ec50c:	48 8d 75 58          	lea    rsi,[rbp+0x58]
   1838ec510:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
   1838ec514:	48 63 40 04          	movsxd rax,DWORD PTR [rax+0x4]
   1838ec518:	48 8d 0d 29 d9 66 05 	lea    rcx,[rip+0x566d929]        # 0x188f59e48
   1838ec51f:	48 89 4c 05 c0       	mov    QWORD PTR [rbp+rax*1-0x40],rcx
   1838ec524:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
   1838ec528:	48 63 40 04          	movsxd rax,DWORD PTR [rax+0x4]
   1838ec52c:	8d 88 68 ff ff ff    	lea    ecx,[rax-0x98]
   1838ec532:	89 4c 05 bc          	mov    DWORD PTR [rbp+rax*1-0x44],ecx
   1838ec536:	48 8d 4d d8          	lea    rcx,[rbp-0x28]
   1838ec53a:	e8 c1 73 79 fc       	call   0x180083900
   1838ec53f:	48 8d 05 1a dc 66 05 	lea    rax,[rip+0x566dc1a]        # 0x188f5a160
   1838ec546:	48 89 45 58          	mov    QWORD PTR [rbp+0x58],rax
   1838ec54a:	48 89 f1             	mov    rcx,rsi
   1838ec54d:	e8 c2 40 c6 03       	call   0x187550614
   1838ec552:	90                   	nop
   1838ec553:	48 8b 85 50 08 00 00 	mov    rax,QWORD PTR [rbp+0x850]
   1838ec55a:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
   1838ec55e:	48 2b 08             	sub    rcx,QWORD PTR [rax]
   1838ec561:	48 c1 f9 03          	sar    rcx,0x3
   1838ec565:	48 b8 f5 d3 4f 3f fd 	movabs rax,0x4fd3f4fd3f4fd3f5
   1838ec56c:	f4 d3 4f 
   1838ec56f:	48 0f af c8          	imul   rcx,rax
   1838ec573:	48 8d 9d c5 0a 00 00 	lea    rbx,[rbp+0xac5]
   1838ec57a:	48 b8 aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaaa
   1838ec581:	aa aa aa 
   1838ec584:	48 89 85 bd 0a 00 00 	mov    QWORD PTR [rbp+0xabd],rax
   1838ec58b:	0f 29 b5 b0 0a 00 00 	movaps XMMWORD PTR [rbp+0xab0],xmm6
   1838ec592:	31 f6                	xor    esi,esi
   1838ec594:	66 66 66 2e 0f 1f 84 	data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   1838ec59b:	00 00 00 00 00 
   1838ec5a0:	48 89 c8             	mov    rax,rcx
   1838ec5a3:	49 f7 e5             	mul    r13
   1838ec5a6:	48 c1 ea 03          	shr    rdx,0x3
   1838ec5aa:	8d 04 12             	lea    eax,[rdx+rdx*1]
   1838ec5ad:	8d 04 80             	lea    eax,[rax+rax*4]
   1838ec5b0:	41 89 c8             	mov    r8d,ecx
   1838ec5b3:	41 29 c0             	sub    r8d,eax
   1838ec5b6:	41 80 c8 30          	or     r8b,0x30
   1838ec5ba:	44 88 43 ff          	mov    BYTE PTR [rbx-0x1],r8b
   1838ec5be:	48 ff cb             	dec    rbx
   1838ec5c1:	48 ff c6             	inc    rsi
   1838ec5c4:	48 83 f9 09          	cmp    rcx,0x9
   1838ec5c8:	48 89 d1             	mov    rcx,rdx
   1838ec5cb:	77 d3                	ja     0x1838ec5a0
   1838ec5cd:	0f 57 c0             	xorps  xmm0,xmm0
   1838ec5d0:	0f 29 85 60 09 00 00 	movaps XMMWORD PTR [rbp+0x960],xmm0
   1838ec5d7:	48 85 f6             	test   rsi,rsi
   1838ec5da:	0f 88 0d 07 00 00    	js     0x1838ecced
   1838ec5e0:	48 83 fe 10          	cmp    rsi,0x10
   1838ec5e4:	4c 8b ad 98 08 00 00 	mov    r13,QWORD PTR [rbp+0x898]
   1838ec5eb:	73 0e                	jae    0x1838ec5fb
   1838ec5ed:	4c 8d b5 60 09 00 00 	lea    r14,[rbp+0x960]
   1838ec5f4:	bf 0f 00 00 00       	mov    edi,0xf
   1838ec5f9:	eb 57                	jmp    0x1838ec652
   1838ec5fb:	48 89 f0             	mov    rax,rsi
   1838ec5fe:	48 83 c8 0f          	or     rax,0xf
   1838ec602:	48 83 f8 17          	cmp    rax,0x17
   1838ec606:	bf 16 00 00 00       	mov    edi,0x16
   1838ec60b:	48 0f 43 f8          	cmovae rdi,rax
   1838ec60f:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   1838ec615:	72 27                	jb     0x1838ec63e
   1838ec617:	48 8d 4f 28          	lea    rcx,[rdi+0x28]
   1838ec61b:	e8 bc f6 c5 03       	call   0x18754bcdc
   1838ec620:	90                   	nop
   1838ec621:	49 89 c6             	mov    r14,rax
   1838ec624:	48 85 c0             	test   rax,rax
   1838ec627:	0f 84 ae 06 00 00    	je     0x1838eccdb
   1838ec62d:	4c 89 f0             	mov    rax,r14
   1838ec630:	49 83 c6 27          	add    r14,0x27
   1838ec634:	49 83 e6 e0          	and    r14,0xffffffffffffffe0
   1838ec638:	49 89 46 f8          	mov    QWORD PTR [r14-0x8],rax
   1838ec63c:	eb 0d                	jmp    0x1838ec64b
   1838ec63e:	48 8d 4f 01          	lea    rcx,[rdi+0x1]
   1838ec642:	e8 95 f6 c5 03       	call   0x18754bcdc
   1838ec647:	90                   	nop
   1838ec648:	49 89 c6             	mov    r14,rax
   1838ec64b:	4c 89 b5 60 09 00 00 	mov    QWORD PTR [rbp+0x960],r14
   1838ec652:	48 89 b5 70 09 00 00 	mov    QWORD PTR [rbp+0x970],rsi
   1838ec659:	48 89 bd 78 09 00 00 	mov    QWORD PTR [rbp+0x978],rdi
   1838ec660:	4c 89 f1             	mov    rcx,r14
   1838ec663:	48 89 da             	mov    rdx,rbx
   1838ec666:	49 89 f0             	mov    r8,rsi
   1838ec669:	e8 d2 87 e2 03       	call   0x187714e40
   1838ec66e:	41 c6 04 36 00       	mov    BYTE PTR [r14+rsi*1],0x0
   1838ec673:	0f b6 95 a8 0a 00 00 	movzx  edx,BYTE PTR [rbp+0xaa8]
   1838ec67a:	48 8d b5 a0 08 00 00 	lea    rsi,[rbp+0x8a0]
   1838ec681:	48 89 f1             	mov    rcx,rsi
   1838ec684:	e8 77 e4 7a fc       	call   0x18009ab00
   1838ec689:	90                   	nop
   1838ec68a:	4c 8b 85 b0 08 00 00 	mov    r8,QWORD PTR [rbp+0x8b0]
   1838ec691:	48 8b 85 b8 08 00 00 	mov    rax,QWORD PTR [rbp+0x8b8]
   1838ec698:	48 89 c1             	mov    rcx,rax
   1838ec69b:	4c 29 c1             	sub    rcx,r8
   1838ec69e:	48 8d 1d 83 52 df 05 	lea    rbx,[rip+0x5df5283]        # 0x1896e1928
   1838ec6a5:	48 83 f9 27          	cmp    rcx,0x27
   1838ec6a9:	73 2b                	jae    0x1838ec6d6
   1838ec6ab:	48 89 5c 24 20       	mov    QWORD PTR [rsp+0x20],rbx
   1838ec6b0:	48 c7 44 24 28 27 00 	mov    QWORD PTR [rsp+0x28],0x27
   1838ec6b7:	00 00 
   1838ec6b9:	48 8d 8d a0 08 00 00 	lea    rcx,[rbp+0x8a0]
   1838ec6c0:	ba 27 00 00 00       	mov    edx,0x27
   1838ec6c5:	45 31 c9             	xor    r9d,r9d
   1838ec6c8:	e8 83 f6 71 fc       	call   0x18000bd50
   1838ec6cd:	90                   	nop
   1838ec6ce:	48 89 c6             	mov    rsi,rax
   1838ec6d1:	e9 8f 00 00 00       	jmp    0x1838ec765
   1838ec6d6:	49 8d 48 27          	lea    rcx,[r8+0x27]
   1838ec6da:	48 89 8d b0 08 00 00 	mov    QWORD PTR [rbp+0x8b0],rcx
   1838ec6e1:	48 83 f8 10          	cmp    rax,0x10
   1838ec6e5:	48 8b 8d a0 08 00 00 	mov    rcx,QWORD PTR [rbp+0x8a0]
   1838ec6ec:	49 89 f6             	mov    r14,rsi
   1838ec6ef:	4c 0f 43 f1          	cmovae r14,rcx
   1838ec6f3:	48 8d 15 55 52 df 05 	lea    rdx,[rip+0x5df5255]        # 0x1896e194f
   1838ec6fa:	49 39 d6             	cmp    r14,rdx
   1838ec6fd:	0f 93 c2             	setae  dl
   1838ec700:	4f 8d 0c 06          	lea    r9,[r14+r8*1]
   1838ec704:	49 39 d9             	cmp    r9,rbx
   1838ec707:	41 0f 92 c1          	setb   r9b
   1838ec70b:	41 08 d1             	or     r9b,dl
   1838ec70e:	41 bf 27 00 00 00    	mov    r15d,0x27
   1838ec714:	41 bc 27 00 00 00    	mov    r12d,0x27
   1838ec71a:	75 0b                	jne    0x1838ec727
   1838ec71c:	4d 89 f4             	mov    r12,r14
   1838ec71f:	49 29 dc             	sub    r12,rbx
   1838ec722:	77 03                	ja     0x1838ec727
   1838ec724:	45 31 e4             	xor    r12d,r12d
   1838ec727:	49 ff c0             	inc    r8
   1838ec72a:	48 83 f8 10          	cmp    rax,0x10
   1838ec72e:	48 0f 42 ce          	cmovb  rcx,rsi
   1838ec732:	48 83 c1 27          	add    rcx,0x27
   1838ec736:	4c 89 f2             	mov    rdx,r14
   1838ec739:	e8 02 87 e2 03       	call   0x187714e40
   1838ec73e:	4c 89 f1             	mov    rcx,r14
   1838ec741:	48 89 da             	mov    rdx,rbx
   1838ec744:	4d 89 e0             	mov    r8,r12
   1838ec747:	e8 f4 86 e2 03       	call   0x187714e40
   1838ec74c:	4d 29 e7             	sub    r15,r12
   1838ec74f:	49 8d 14 1c          	lea    rdx,[r12+rbx*1]
   1838ec753:	48 83 c2 27          	add    rdx,0x27
   1838ec757:	4d 01 e6             	add    r14,r12
   1838ec75a:	4c 89 f1             	mov    rcx,r14
   1838ec75d:	4d 89 f8             	mov    r8,r15
   1838ec760:	e8 db 86 e2 03       	call   0x187714e40
   1838ec765:	0f 10 06             	movups xmm0,XMMWORD PTR [rsi]
   1838ec768:	0f 10 4e 10          	movups xmm1,XMMWORD PTR [rsi+0x10]
   1838ec76c:	0f 29 8d c0 09 00 00 	movaps XMMWORD PTR [rbp+0x9c0],xmm1
   1838ec773:	0f 29 85 b0 09 00 00 	movaps XMMWORD PTR [rbp+0x9b0],xmm0
   1838ec77a:	48 c7 46 10 00 00 00 	mov    QWORD PTR [rsi+0x10],0x0
   1838ec781:	00 
   1838ec782:	48 c7 46 18 0f 00 00 	mov    QWORD PTR [rsi+0x18],0xf
   1838ec789:	00 
   1838ec78a:	c6 06 00             	mov    BYTE PTR [rsi],0x0
   1838ec78d:	48 8b 85 c0 09 00 00 	mov    rax,QWORD PTR [rbp+0x9c0]
   1838ec794:	48 8b 8d c8 09 00 00 	mov    rcx,QWORD PTR [rbp+0x9c8]
   1838ec79b:	48 89 ca             	mov    rdx,rcx
   1838ec79e:	48 29 c2             	sub    rdx,rax
   1838ec7a1:	48 83 fa 16          	cmp    rdx,0x16
   1838ec7a5:	73 2a                	jae    0x1838ec7d1
   1838ec7a7:	48 c7 44 24 20 16 00 	mov    QWORD PTR [rsp+0x20],0x16
   1838ec7ae:	00 00 
   1838ec7b0:	4c 8d 0d 59 51 df 05 	lea    r9,[rip+0x5df5159]        # 0x1896e1910
   1838ec7b7:	48 8d 8d b0 09 00 00 	lea    rcx,[rbp+0x9b0]
   1838ec7be:	ba 16 00 00 00       	mov    edx,0x16
   1838ec7c3:	e8 f8 cb 71 fc       	call   0x1800093c0
   1838ec7c8:	48 89 85 d0 0a 00 00 	mov    QWORD PTR [rbp+0xad0],rax
   1838ec7cf:	eb 3e                	jmp    0x1838ec80f
   1838ec7d1:	48 8d 50 16          	lea    rdx,[rax+0x16]
   1838ec7d5:	48 89 95 c0 09 00 00 	mov    QWORD PTR [rbp+0x9c0],rdx
   1838ec7dc:	48 8d 95 b0 09 00 00 	lea    rdx,[rbp+0x9b0]
   1838ec7e3:	48 83 f9 10          	cmp    rcx,0x10
   1838ec7e7:	72 07                	jb     0x1838ec7f0
   1838ec7e9:	48 8b 95 b0 09 00 00 	mov    rdx,QWORD PTR [rbp+0x9b0]
   1838ec7f0:	0f 10 05 19 51 df 05 	movups xmm0,XMMWORD PTR [rip+0x5df5119]        # 0x1896e1910
   1838ec7f7:	0f 11 04 02          	movups XMMWORD PTR [rdx+rax*1],xmm0
   1838ec7fb:	48 b9 65 20 63 6f 75 	movabs rcx,0x3a746e756f632065
   1838ec802:	6e 74 3a 
   1838ec805:	48 89 4c 02 0e       	mov    QWORD PTR [rdx+rax*1+0xe],rcx
   1838ec80a:	c6 44 02 16 00       	mov    BYTE PTR [rdx+rax*1+0x16],0x0
   1838ec80f:	48 8b 85 d0 0a 00 00 	mov    rax,QWORD PTR [rbp+0xad0]
   1838ec816:	0f 10 00             	movups xmm0,XMMWORD PTR [rax]
   1838ec819:	0f 10 48 10          	movups xmm1,XMMWORD PTR [rax+0x10]
   1838ec81d:	0f 29 8d c0 0a 00 00 	movaps XMMWORD PTR [rbp+0xac0],xmm1
   1838ec824:	0f 29 85 b0 0a 00 00 	movaps XMMWORD PTR [rbp+0xab0],xmm0
   1838ec82b:	48 c7 40 10 00 00 00 	mov    QWORD PTR [rax+0x10],0x0
   1838ec832:	00 
   1838ec833:	48 c7 40 18 0f 00 00 	mov    QWORD PTR [rax+0x18],0xf
   1838ec83a:	00 
   1838ec83b:	c6 00 00             	mov    BYTE PTR [rax],0x0
   1838ec83e:	48 8d b5 20 0a 00 00 	lea    rsi,[rbp+0xa20]
   1838ec845:	4c 8d 85 b0 0a 00 00 	lea    r8,[rbp+0xab0]
   1838ec84c:	4c 8d 8d 60 09 00 00 	lea    r9,[rbp+0x960]
   1838ec853:	48 89 f1             	mov    rcx,rsi
   1838ec856:	e8 75 7a 79 fc       	call   0x1800842d0
   1838ec85b:	90                   	nop
   1838ec85c:	48 8b 85 30 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa30]
   1838ec863:	48 8b 8d 38 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xa38]
   1838ec86a:	48 89 ca             	mov    rdx,rcx
   1838ec86d:	48 29 c2             	sub    rdx,rax
   1838ec870:	48 83 fa 06          	cmp    rdx,0x6
   1838ec874:	73 27                	jae    0x1838ec89d
   1838ec876:	48 c7 44 24 20 06 00 	mov    QWORD PTR [rsp+0x20],0x6
   1838ec87d:	00 00 
   1838ec87f:	4c 8d 0d 16 52 91 05 	lea    r9,[rip+0x5915216]        # 0x189201a9c
   1838ec886:	48 8d 8d 20 0a 00 00 	lea    rcx,[rbp+0xa20]
   1838ec88d:	ba 06 00 00 00       	mov    edx,0x6
   1838ec892:	e8 29 cb 71 fc       	call   0x1800093c0
   1838ec897:	90                   	nop
   1838ec898:	48 89 c6             	mov    rsi,rax
   1838ec89b:	eb 2e                	jmp    0x1838ec8cb
   1838ec89d:	48 8d 50 06          	lea    rdx,[rax+0x6]
   1838ec8a1:	48 89 95 30 0a 00 00 	mov    QWORD PTR [rbp+0xa30],rdx
   1838ec8a8:	48 89 f2             	mov    rdx,rsi
   1838ec8ab:	48 83 f9 10          	cmp    rcx,0x10
   1838ec8af:	72 07                	jb     0x1838ec8b8
   1838ec8b1:	48 8b 95 20 0a 00 00 	mov    rdx,QWORD PTR [rbp+0xa20]
   1838ec8b8:	66 c7 44 02 04 74 3a 	mov    WORD PTR [rdx+rax*1+0x4],0x3a74
   1838ec8bf:	c7 04 02 2c 20 72 65 	mov    DWORD PTR [rdx+rax*1],0x6572202c
   1838ec8c6:	c6 44 02 06 00       	mov    BYTE PTR [rdx+rax*1+0x6],0x0
   1838ec8cb:	0f 10 06             	movups xmm0,XMMWORD PTR [rsi]
   1838ec8ce:	0f 10 4e 10          	movups xmm1,XMMWORD PTR [rsi+0x10]
   1838ec8d2:	0f 29 4d d0          	movaps XMMWORD PTR [rbp-0x30],xmm1
   1838ec8d6:	0f 29 45 c0          	movaps XMMWORD PTR [rbp-0x40],xmm0
   1838ec8da:	48 c7 46 10 00 00 00 	mov    QWORD PTR [rsi+0x10],0x0
   1838ec8e1:	00 
   1838ec8e2:	48 c7 46 18 0f 00 00 	mov    QWORD PTR [rsi+0x18],0xf
   1838ec8e9:	00 
   1838ec8ea:	c6 06 00             	mov    BYTE PTR [rsi],0x0
   1838ec8ed:	48 8d 8d a0 07 00 00 	lea    rcx,[rbp+0x7a0]
   1838ec8f4:	4c 8d 45 c0          	lea    r8,[rbp-0x40]
   1838ec8f8:	4c 8d 8d d0 08 00 00 	lea    r9,[rbp+0x8d0]
   1838ec8ff:	e8 cc 79 79 fc       	call   0x1800842d0
   1838ec904:	90                   	nop
   1838ec905:	48 8d 8d 00 08 00 00 	lea    rcx,[rbp+0x800]
   1838ec90c:	48 8d 95 a0 07 00 00 	lea    rdx,[rbp+0x7a0]
   1838ec913:	41 b8 32 00 00 00    	mov    r8d,0x32
   1838ec919:	e8 b2 be 6f fd       	call   0x180fe87d0
   1838ec91e:	90                   	nop
   1838ec91f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
   1838ec923:	48 83 f8 10          	cmp    rax,0x10
   1838ec927:	72 35                	jb     0x1838ec95e
   1838ec929:	48 8b 4d c0          	mov    rcx,QWORD PTR [rbp-0x40]
   1838ec92d:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838ec931:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838ec938:	72 1f                	jb     0x1838ec959
   1838ec93a:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838ec93e:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838ec942:	4c 29 c1             	sub    rcx,r8
   1838ec945:	48 83 f9 20          	cmp    rcx,0x20
   1838ec949:	0f 83 8c 03 00 00    	jae    0x1838eccdb
   1838ec94f:	48 83 c0 28          	add    rax,0x28
   1838ec953:	48 89 c2             	mov    rdx,rax
   1838ec956:	4c 89 c1             	mov    rcx,r8
   1838ec959:	e8 c2 f3 c5 03       	call   0x18754bd20
   1838ec95e:	48 8b 85 38 0a 00 00 	mov    rax,QWORD PTR [rbp+0xa38]
   1838ec965:	48 83 f8 10          	cmp    rax,0x10
   1838ec969:	72 38                	jb     0x1838ec9a3
   1838ec96b:	48 8b 8d 20 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xa20]
   1838ec972:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838ec976:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838ec97d:	72 1f                	jb     0x1838ec99e
   1838ec97f:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838ec983:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838ec987:	4c 29 c1             	sub    rcx,r8
   1838ec98a:	48 83 f9 20          	cmp    rcx,0x20
   1838ec98e:	0f 83 47 03 00 00    	jae    0x1838eccdb
   1838ec994:	48 83 c0 28          	add    rax,0x28
   1838ec998:	48 89 c2             	mov    rdx,rax
   1838ec99b:	4c 89 c1             	mov    rcx,r8
   1838ec99e:	e8 7d f3 c5 03       	call   0x18754bd20
   1838ec9a3:	48 8b 85 c8 0a 00 00 	mov    rax,QWORD PTR [rbp+0xac8]
   1838ec9aa:	48 83 f8 10          	cmp    rax,0x10
   1838ec9ae:	72 38                	jb     0x1838ec9e8
   1838ec9b0:	48 8b 8d b0 0a 00 00 	mov    rcx,QWORD PTR [rbp+0xab0]
   1838ec9b7:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838ec9bb:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838ec9c2:	72 1f                	jb     0x1838ec9e3
   1838ec9c4:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838ec9c8:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838ec9cc:	4c 29 c1             	sub    rcx,r8
   1838ec9cf:	48 83 f9 20          	cmp    rcx,0x20
   1838ec9d3:	0f 83 02 03 00 00    	jae    0x1838eccdb
   1838ec9d9:	48 83 c0 28          	add    rax,0x28
   1838ec9dd:	48 89 c2             	mov    rdx,rax
   1838ec9e0:	4c 89 c1             	mov    rcx,r8
   1838ec9e3:	e8 38 f3 c5 03       	call   0x18754bd20
   1838ec9e8:	48 8b 85 c8 09 00 00 	mov    rax,QWORD PTR [rbp+0x9c8]
   1838ec9ef:	48 83 f8 10          	cmp    rax,0x10
   1838ec9f3:	72 38                	jb     0x1838eca2d
   1838ec9f5:	48 8b 8d b0 09 00 00 	mov    rcx,QWORD PTR [rbp+0x9b0]
   1838ec9fc:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838eca00:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838eca07:	72 1f                	jb     0x1838eca28
   1838eca09:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838eca0d:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838eca11:	4c 29 c1             	sub    rcx,r8
   1838eca14:	48 83 f9 20          	cmp    rcx,0x20
   1838eca18:	0f 83 bd 02 00 00    	jae    0x1838eccdb
   1838eca1e:	48 83 c0 28          	add    rax,0x28
   1838eca22:	48 89 c2             	mov    rdx,rax
   1838eca25:	4c 89 c1             	mov    rcx,r8
   1838eca28:	e8 f3 f2 c5 03       	call   0x18754bd20
   1838eca2d:	48 8b 85 b8 08 00 00 	mov    rax,QWORD PTR [rbp+0x8b8]
   1838eca34:	48 83 f8 10          	cmp    rax,0x10
   1838eca38:	72 38                	jb     0x1838eca72
   1838eca3a:	48 8b 8d a0 08 00 00 	mov    rcx,QWORD PTR [rbp+0x8a0]
   1838eca41:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838eca45:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838eca4c:	72 1f                	jb     0x1838eca6d
   1838eca4e:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838eca52:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838eca56:	4c 29 c1             	sub    rcx,r8
   1838eca59:	48 83 f9 20          	cmp    rcx,0x20
   1838eca5d:	0f 83 78 02 00 00    	jae    0x1838eccdb
   1838eca63:	48 83 c0 28          	add    rax,0x28
   1838eca67:	48 89 c2             	mov    rdx,rax
   1838eca6a:	4c 89 c1             	mov    rcx,r8
   1838eca6d:	e8 ae f2 c5 03       	call   0x18754bd20
   1838eca72:	48 8b 85 78 09 00 00 	mov    rax,QWORD PTR [rbp+0x978]
   1838eca79:	48 83 f8 10          	cmp    rax,0x10
   1838eca7d:	72 38                	jb     0x1838ecab7
   1838eca7f:	48 8b 8d 60 09 00 00 	mov    rcx,QWORD PTR [rbp+0x960]
   1838eca86:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838eca8a:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838eca91:	72 1f                	jb     0x1838ecab2
   1838eca93:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838eca97:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838eca9b:	4c 29 c1             	sub    rcx,r8
   1838eca9e:	48 83 f9 20          	cmp    rcx,0x20
   1838ecaa2:	0f 83 33 02 00 00    	jae    0x1838eccdb
   1838ecaa8:	48 83 c0 28          	add    rax,0x28
   1838ecaac:	48 89 c2             	mov    rdx,rax
   1838ecaaf:	4c 89 c1             	mov    rcx,r8
   1838ecab2:	e8 69 f2 c5 03       	call   0x18754bd20
   1838ecab7:	48 8b 85 e8 08 00 00 	mov    rax,QWORD PTR [rbp+0x8e8]
   1838ecabe:	48 83 f8 10          	cmp    rax,0x10
   1838ecac2:	72 39                	jb     0x1838ecafd
   1838ecac4:	48 8b 8d d0 08 00 00 	mov    rcx,QWORD PTR [rbp+0x8d0]
   1838ecacb:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838ecacf:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838ecad6:	72 1f                	jb     0x1838ecaf7
   1838ecad8:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838ecadc:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838ecae0:	4c 29 c1             	sub    rcx,r8
   1838ecae3:	48 83 f9 20          	cmp    rcx,0x20
   1838ecae7:	0f 83 ee 01 00 00    	jae    0x1838eccdb
   1838ecaed:	48 83 c0 28          	add    rax,0x28
   1838ecaf1:	48 89 c2             	mov    rdx,rax
   1838ecaf4:	4c 89 c1             	mov    rcx,r8
   1838ecaf7:	e8 24 f2 c5 03       	call   0x18754bd20
   1838ecafc:	90                   	nop
   1838ecafd:	48 8d 95 d0 09 00 00 	lea    rdx,[rbp+0x9d0]
   1838ecb04:	4c 89 e9             	mov    rcx,r13
   1838ecb07:	e8 f4 44 f7 fd       	call   0x181861000
   1838ecb0c:	90                   	nop
   1838ecb0d:	4c 8b b5 98 08 00 00 	mov    r14,QWORD PTR [rbp+0x898]
   1838ecb14:	0f b6 85 a8 0a 00 00 	movzx  eax,BYTE PTR [rbp+0xaa8]
   1838ecb1b:	41 88 46 40          	mov    BYTE PTR [r14+0x40],al
   1838ecb1f:	48 8b 8d e8 09 00 00 	mov    rcx,QWORD PTR [rbp+0x9e8]
   1838ecb26:	48 85 c9             	test   rcx,rcx
   1838ecb29:	74 34                	je     0x1838ecb5f
   1838ecb2b:	48 8b 95 f8 09 00 00 	mov    rdx,QWORD PTR [rbp+0x9f8]
   1838ecb32:	48 29 ca             	sub    rdx,rcx
   1838ecb35:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838ecb3c:	72 1c                	jb     0x1838ecb5a
   1838ecb3e:	48 8b 41 f8          	mov    rax,QWORD PTR [rcx-0x8]
   1838ecb42:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838ecb46:	48 29 c1             	sub    rcx,rax
   1838ecb49:	48 83 f9 20          	cmp    rcx,0x20
   1838ecb4d:	0f 83 88 01 00 00    	jae    0x1838eccdb
   1838ecb53:	48 83 c2 27          	add    rdx,0x27
   1838ecb57:	48 89 c1             	mov    rcx,rax
   1838ecb5a:	e8 c1 f1 c5 03       	call   0x18754bd20
   1838ecb5f:	48 8d 8d d8 09 00 00 	lea    rcx,[rbp+0x9d8]
   1838ecb66:	e8 e5 e2 f5 fd       	call   0x18184ae50
   1838ecb6b:	48 8b 8d 70 08 00 00 	mov    rcx,QWORD PTR [rbp+0x870]
   1838ecb72:	48 85 c9             	test   rcx,rcx
   1838ecb75:	74 34                	je     0x1838ecbab
   1838ecb77:	48 8b 95 80 08 00 00 	mov    rdx,QWORD PTR [rbp+0x880]
   1838ecb7e:	48 29 ca             	sub    rdx,rcx
   1838ecb81:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838ecb88:	72 1c                	jb     0x1838ecba6
   1838ecb8a:	48 8b 41 f8          	mov    rax,QWORD PTR [rcx-0x8]
   1838ecb8e:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838ecb92:	48 29 c1             	sub    rcx,rax
   1838ecb95:	48 83 f9 20          	cmp    rcx,0x20
   1838ecb99:	0f 83 3c 01 00 00    	jae    0x1838eccdb
   1838ecb9f:	48 83 c2 27          	add    rdx,0x27
   1838ecba3:	48 89 c1             	mov    rcx,rax
   1838ecba6:	e8 75 f1 c5 03       	call   0x18754bd20
   1838ecbab:	48 8b 85 60 08 00 00 	mov    rax,QWORD PTR [rbp+0x860]
   1838ecbb2:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
   1838ecbb6:	48 c7 01 00 00 00 00 	mov    QWORD PTR [rcx],0x0
   1838ecbbd:	48 8b 18             	mov    rbx,QWORD PTR [rax]
   1838ecbc0:	eb 1b                	jmp    0x1838ecbdd
   1838ecbc2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   1838ecbc9:	1f 84 00 00 00 00 00 
   1838ecbd0:	ba 28 00 00 00       	mov    edx,0x28
   1838ecbd5:	48 89 f1             	mov    rcx,rsi
   1838ecbd8:	e8 43 f1 c5 03       	call   0x18754bd20
   1838ecbdd:	48 85 db             	test   rbx,rbx
   1838ecbe0:	74 2e                	je     0x1838ecc10
   1838ecbe2:	48 89 de             	mov    rsi,rbx
   1838ecbe5:	48 8b 1b             	mov    rbx,QWORD PTR [rbx]
   1838ecbe8:	48 8b 7e 20          	mov    rdi,QWORD PTR [rsi+0x20]
   1838ecbec:	48 85 ff             	test   rdi,rdi
   1838ecbef:	74 df                	je     0x1838ecbd0
   1838ecbf1:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1838ecbf5:	75 d9                	jne    0x1838ecbd0
   1838ecbf7:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1838ecbfa:	48 89 f9             	mov    rcx,rdi
   1838ecbfd:	ff 10                	call   QWORD PTR [rax]
   1838ecbff:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1838ecc03:	75 cb                	jne    0x1838ecbd0
   1838ecc05:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1838ecc08:	48 89 f9             	mov    rcx,rdi
   1838ecc0b:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1838ecc0e:	eb c0                	jmp    0x1838ecbd0
   1838ecc10:	48 8b 8d 60 08 00 00 	mov    rcx,QWORD PTR [rbp+0x860]
   1838ecc17:	ba 28 00 00 00       	mov    edx,0x28
   1838ecc1c:	e8 ff f0 c5 03       	call   0x18754bd20
   1838ecc21:	48 8b 8d d8 07 00 00 	mov    rcx,QWORD PTR [rbp+0x7d8]
   1838ecc28:	48 85 c9             	test   rcx,rcx
   1838ecc2b:	74 34                	je     0x1838ecc61
   1838ecc2d:	48 8b 95 e8 07 00 00 	mov    rdx,QWORD PTR [rbp+0x7e8]
   1838ecc34:	48 29 ca             	sub    rdx,rcx
   1838ecc37:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838ecc3e:	72 1c                	jb     0x1838ecc5c
   1838ecc40:	48 8b 41 f8          	mov    rax,QWORD PTR [rcx-0x8]
   1838ecc44:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838ecc48:	48 29 c1             	sub    rcx,rax
   1838ecc4b:	48 83 f9 20          	cmp    rcx,0x20
   1838ecc4f:	0f 83 86 00 00 00    	jae    0x1838eccdb
   1838ecc55:	48 83 c2 27          	add    rdx,0x27
   1838ecc59:	48 89 c1             	mov    rcx,rax
   1838ecc5c:	e8 bf f0 c5 03       	call   0x18754bd20
   1838ecc61:	48 8d 8d c8 07 00 00 	lea    rcx,[rbp+0x7c8]
   1838ecc68:	e8 e3 e1 f5 fd       	call   0x18184ae50
   1838ecc6d:	48 8b 85 40 08 00 00 	mov    rax,QWORD PTR [rbp+0x840]
   1838ecc74:	48 83 f8 10          	cmp    rax,0x10
   1838ecc78:	72 34                	jb     0x1838eccae
   1838ecc7a:	48 8b 8d 28 08 00 00 	mov    rcx,QWORD PTR [rbp+0x828]
   1838ecc81:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1838ecc85:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1838ecc8c:	72 1b                	jb     0x1838ecca9
   1838ecc8e:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1838ecc92:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1838ecc96:	4c 29 c1             	sub    rcx,r8
   1838ecc99:	48 83 f9 20          	cmp    rcx,0x20
   1838ecc9d:	73 3c                	jae    0x1838eccdb
   1838ecc9f:	48 83 c0 28          	add    rax,0x28
   1838ecca3:	48 89 c2             	mov    rdx,rax
   1838ecca6:	4c 89 c1             	mov    rcx,r8
   1838ecca9:	e8 72 f0 c5 03       	call   0x18754bd20
   1838eccae:	4c 89 f0             	mov    rax,r14
   1838eccb1:	0f 28 b5 e0 0a 00 00 	movaps xmm6,XMMWORD PTR [rbp+0xae0]
   1838eccb8:	0f 28 bd f0 0a 00 00 	movaps xmm7,XMMWORD PTR [rbp+0xaf0]
   1838eccbf:	44 0f 28 85 00 0b 00 	movaps xmm8,XMMWORD PTR [rbp+0xb00]
   1838eccc6:	00 
   1838eccc7:	48 81 c4 98 0b 00 00 	add    rsp,0xb98
   1838eccce:	5b                   	pop    rbx
   1838ecccf:	5f                   	pop    rdi
   1838eccd0:	5e                   	pop    rsi
   1838eccd1:	41 5c                	pop    r12
   1838eccd3:	41 5d                	pop    r13
   1838eccd5:	41 5e                	pop    r14
   1838eccd7:	41 5f                	pop    r15
   1838eccd9:	5d                   	pop    rbp
   1838eccda:	c3                   	ret
   1838eccdb:	e8 ac 14 df 03       	call   0x1876de18c
   1838ecce0:	90                   	nop
   1838ecce1:	e8 aa be 71 fc       	call   0x180008b90
   1838ecce6:	90                   	nop
   1838ecce7:	e8 a4 be 71 fc       	call   0x180008b90
   1838eccec:	90                   	nop
   1838ecced:	e8 9e be 71 fc       	call   0x180008b90
   1838eccf2:	90                   	nop
   1838eccf3:	cc                   	int3
