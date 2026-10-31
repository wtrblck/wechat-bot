
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

0000000180474de0 <.text+0x473de0>:
   180474de0:	55                   	push   rbp
   180474de1:	56                   	push   rsi
   180474de2:	57                   	push   rdi
   180474de3:	48 81 ec 90 00 00 00 	sub    rsp,0x90
   180474dea:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   180474df1:	00 
   180474df2:	0f 29 75 00          	movaps XMMWORD PTR [rbp+0x0],xmm6
   180474df6:	48 c7 45 f8 fe ff ff 	mov    QWORD PTR [rbp-0x8],0xfffffffffffffffe
   180474dfd:	ff 
   180474dfe:	48 89 d6             	mov    rsi,rdx
   180474e01:	48 89 cf             	mov    rdi,rcx
   180474e04:	48 8d 05 9d 79 b6 08 	lea    rax,[rip+0x8b6799d]        # 0x188fdc7a8
   180474e0b:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
   180474e0f:	0f 28 35 9a 1d aa 08 	movaps xmm6,XMMWORD PTR [rip+0x8aa1d9a]        # 0x188f16bb0
   180474e16:	0f 29 75 b0          	movaps XMMWORD PTR [rbp-0x50],xmm6
   180474e1a:	0f 29 75 a0          	movaps XMMWORD PTR [rbp-0x60],xmm6
   180474e1e:	48 8d 55 a0          	lea    rdx,[rbp-0x60]
   180474e22:	4c 8d 45 d8          	lea    r8,[rbp-0x28]
   180474e26:	e8 55 ab eb ff       	call   0x18032f980
   180474e2b:	0f 29 75 c0          	movaps XMMWORD PTR [rbp-0x40],xmm6
   180474e2f:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   180474e33:	e8 98 d1 02 00       	call   0x1804a1fd0
   180474e38:	90                   	nop
   180474e39:	80 7d b8 01          	cmp    BYTE PTR [rbp-0x48],0x1
   180474e3d:	75 17                	jne    0x180474e56
   180474e3f:	48 8d 4d e0          	lea    rcx,[rbp-0x20]
   180474e43:	48 8d 55 a0          	lea    rdx,[rbp-0x60]
   180474e47:	e8 84 60 be ff       	call   0x18005aed0
   180474e4c:	90                   	nop
   180474e4d:	0f 28 45 e0          	movaps xmm0,XMMWORD PTR [rbp-0x20]
   180474e51:	0f 11 06             	movups XMMWORD PTR [rsi],xmm0
   180474e54:	eb 60                	jmp    0x180474eb6
   180474e56:	0f 29 75 e0          	movaps XMMWORD PTR [rbp-0x20],xmm6
   180474e5a:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
   180474e5e:	4c 8d 45 d8          	lea    r8,[rbp-0x28]
   180474e62:	48 89 f9             	mov    rcx,rdi
   180474e65:	e8 76 99 eb ff       	call   0x18032e7e0
   180474e6a:	90                   	nop
   180474e6b:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
   180474e6f:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
   180474e73:	48 85 c9             	test   rcx,rcx
   180474e76:	74 33                	je     0x180474eab
   180474e78:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   180474e7c:	48 8b 7d e8          	mov    rdi,QWORD PTR [rbp-0x18]
   180474e80:	48 89 06             	mov    QWORD PTR [rsi],rax
   180474e83:	48 89 7e 08          	mov    QWORD PTR [rsi+0x8],rdi
   180474e87:	48 85 ff             	test   rdi,rdi
   180474e8a:	74 2a                	je     0x180474eb6
   180474e8c:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   180474e90:	75 24                	jne    0x180474eb6
   180474e92:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   180474e95:	48 89 f9             	mov    rcx,rdi
   180474e98:	ff 10                	call   QWORD PTR [rax]
   180474e9a:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   180474e9e:	75 16                	jne    0x180474eb6
   180474ea0:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   180474ea3:	48 89 f9             	mov    rcx,rdi
   180474ea6:	ff 50 08             	call   QWORD PTR [rax+0x8]
   180474ea9:	eb 0b                	jmp    0x180474eb6
   180474eab:	48 89 06             	mov    QWORD PTR [rsi],rax
   180474eae:	48 c7 46 08 00 00 00 	mov    QWORD PTR [rsi+0x8],0x0
   180474eb5:	00 
   180474eb6:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   180474eba:	e8 f1 d1 02 00       	call   0x1804a20b0
   180474ebf:	80 7d b8 01          	cmp    BYTE PTR [rbp-0x48],0x1
   180474ec3:	75 26                	jne    0x180474eeb
   180474ec5:	48 8b 7d a8          	mov    rdi,QWORD PTR [rbp-0x58]
   180474ec9:	48 85 ff             	test   rdi,rdi
   180474ecc:	74 1d                	je     0x180474eeb
   180474ece:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   180474ed2:	75 17                	jne    0x180474eeb
   180474ed4:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   180474ed7:	48 89 f9             	mov    rcx,rdi
   180474eda:	ff 10                	call   QWORD PTR [rax]
   180474edc:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   180474ee0:	75 09                	jne    0x180474eeb
   180474ee2:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   180474ee5:	48 89 f9             	mov    rcx,rdi
   180474ee8:	ff 50 08             	call   QWORD PTR [rax+0x8]
   180474eeb:	48 89 f0             	mov    rax,rsi
   180474eee:	0f 28 75 00          	movaps xmm6,XMMWORD PTR [rbp+0x0]
   180474ef2:	48 81 c4 90 00 00 00 	add    rsp,0x90
   180474ef9:	5f                   	pop    rdi
   180474efa:	5e                   	pop    rsi
   180474efb:	5d                   	pop    rbp
   180474efc:	c3                   	ret
