
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

0000000180eb7100 <.text+0xeb6100>:
   180eb7100:	55                   	push   rbp
   180eb7101:	56                   	push   rsi
   180eb7102:	57                   	push   rdi
   180eb7103:	48 81 ec 90 00 00 00 	sub    rsp,0x90
   180eb710a:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   180eb7111:	00
   180eb7112:	0f 29 75 00          	movaps XMMWORD PTR [rbp+0x0],xmm6
   180eb7116:	48 c7 45 f8 fe ff ff 	mov    QWORD PTR [rbp-0x8],0xfffffffffffffffe
   180eb711d:	ff
   180eb711e:	48 89 d6             	mov    rsi,rdx
   180eb7121:	48 89 cf             	mov    rdi,rcx
   180eb7124:	48 8d 05 ed 01 2b 08 	lea    rax,[rip+0x82b01ed]        # 0x189167318
   180eb712b:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
   180eb712f:	0f 28 35 7a fa 05 08 	movaps xmm6,XMMWORD PTR [rip+0x805fa7a]        # 0x188f16bb0
   180eb7136:	0f 29 75 b0          	movaps XMMWORD PTR [rbp-0x50],xmm6
   180eb713a:	0f 29 75 a0          	movaps XMMWORD PTR [rbp-0x60],xmm6
   180eb713e:	48 8d 55 a0          	lea    rdx,[rbp-0x60]
   180eb7142:	4c 8d 45 d8          	lea    r8,[rbp-0x28]
   180eb7146:	e8 35 88 47 ff       	call   0x18032f980
   180eb714b:	0f 29 75 c0          	movaps XMMWORD PTR [rbp-0x40],xmm6
   180eb714f:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   180eb7153:	e8 78 ae 5e ff       	call   0x1804a1fd0
   180eb7158:	90                   	nop
   180eb7159:	80 7d b8 01          	cmp    BYTE PTR [rbp-0x48],0x1
   180eb715d:	75 17                	jne    0x180eb7176
   180eb715f:	48 8d 4d e0          	lea    rcx,[rbp-0x20]
   180eb7163:	48 8d 55 a0          	lea    rdx,[rbp-0x60]
   180eb7167:	e8 64 3d 1a ff       	call   0x18005aed0
   180eb716c:	90                   	nop
   180eb716d:	0f 28 45 e0          	movaps xmm0,XMMWORD PTR [rbp-0x20]
   180eb7171:	0f 11 06             	movups XMMWORD PTR [rsi],xmm0
   180eb7174:	eb 60                	jmp    0x180eb71d6
   180eb7176:	0f 29 75 e0          	movaps XMMWORD PTR [rbp-0x20],xmm6
   180eb717a:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
   180eb717e:	4c 8d 45 d8          	lea    r8,[rbp-0x28]
   180eb7182:	48 89 f9             	mov    rcx,rdi
   180eb7185:	e8 56 76 47 ff       	call   0x18032e7e0
   180eb718a:	90                   	nop
   180eb718b:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
   180eb718f:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
   180eb7193:	48 85 c9             	test   rcx,rcx
   180eb7196:	74 33                	je     0x180eb71cb
   180eb7198:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   180eb719c:	48 8b 7d e8          	mov    rdi,QWORD PTR [rbp-0x18]
   180eb71a0:	48 89 06             	mov    QWORD PTR [rsi],rax
   180eb71a3:	48 89 7e 08          	mov    QWORD PTR [rsi+0x8],rdi
   180eb71a7:	48 85 ff             	test   rdi,rdi
   180eb71aa:	74 2a                	je     0x180eb71d6
   180eb71ac:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   180eb71b0:	75 24                	jne    0x180eb71d6
   180eb71b2:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   180eb71b5:	48 89 f9             	mov    rcx,rdi
   180eb71b8:	ff 10                	call   QWORD PTR [rax]
   180eb71ba:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   180eb71be:	75 16                	jne    0x180eb71d6
   180eb71c0:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   180eb71c3:	48 89 f9             	mov    rcx,rdi
   180eb71c6:	ff 50 08             	call   QWORD PTR [rax+0x8]
   180eb71c9:	eb 0b                	jmp    0x180eb71d6
   180eb71cb:	48 89 06             	mov    QWORD PTR [rsi],rax
   180eb71ce:	48 c7 46 08 00 00 00 	mov    QWORD PTR [rsi+0x8],0x0
   180eb71d5:	00
   180eb71d6:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   180eb71da:	e8 d1 ae 5e ff       	call   0x1804a20b0
   180eb71df:	80 7d b8 01          	cmp    BYTE PTR [rbp-0x48],0x1
   180eb71e3:	75 26                	jne    0x180eb720b
   180eb71e5:	48 8b 7d a8          	mov    rdi,QWORD PTR [rbp-0x58]
   180eb71e9:	48 85 ff             	test   rdi,rdi
   180eb71ec:	74 1d                	je     0x180eb720b
   180eb71ee:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   180eb71f2:	75 17                	jne    0x180eb720b
   180eb71f4:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   180eb71f7:	48 89 f9             	mov    rcx,rdi
   180eb71fa:	ff 10                	call   QWORD PTR [rax]
   180eb71fc:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   180eb7200:	75 09                	jne    0x180eb720b
   180eb7202:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   180eb7205:	48 89 f9             	mov    rcx,rdi
   180eb7208:	ff 50 08             	call   QWORD PTR [rax+0x8]
   180eb720b:	48 89 f0             	mov    rax,rsi
   180eb720e:	0f 28 75 00          	movaps xmm6,XMMWORD PTR [rbp+0x0]
   180eb7212:	48 81 c4 90 00 00 00 	add    rsp,0x90
   180eb7219:	5f                   	pop    rdi
   180eb721a:	5e                   	pop    rsi
   180eb721b:	5d                   	pop    rbp
   180eb721c:	c3                   	ret
