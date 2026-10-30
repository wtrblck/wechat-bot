
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001822ead90 <.text+0x22e9d90>:
   1822ead90:	55                   	push   rbp
   1822ead91:	41 57                	push   r15
   1822ead93:	41 56                	push   r14
   1822ead95:	56                   	push   rsi
   1822ead96:	57                   	push   rdi
   1822ead97:	53                   	push   rbx
   1822ead98:	48 83 ec 38          	sub    rsp,0x38
   1822ead9c:	48 8d 6c 24 30       	lea    rbp,[rsp+0x30]
   1822eada1:	48 c7 45 00 fe ff ff 	mov    QWORD PTR [rbp+0x0],0xfffffffffffffffe
   1822eada8:	ff
   1822eada9:	48 89 d6             	mov    rsi,rdx
   1822eadac:	49 89 cf             	mov    r15,rcx
   1822eadaf:	48 89 d1             	mov    rcx,rdx
   1822eadb2:	e8 49 75 79 fe       	call   0x180a82300
   1822eadb7:	48 89 c7             	mov    rdi,rax
   1822eadba:	0f 57 c0             	xorps  xmm0,xmm0
   1822eadbd:	41 0f 11 07          	movups XMMWORD PTR [r15],xmm0
   1822eadc1:	41 0f 11 47 10       	movups XMMWORD PTR [r15+0x10],xmm0
   1822eadc6:	48 8b 58 10          	mov    rbx,QWORD PTR [rax+0x10]
   1822eadca:	48 83 78 18 10       	cmp    QWORD PTR [rax+0x18],0x10
   1822eadcf:	72 03                	jb     0x1822eadd4
   1822eadd1:	48 8b 3f             	mov    rdi,QWORD PTR [rdi]
   1822eadd4:	48 85 db             	test   rbx,rbx
   1822eadd7:	0f 88 6f 01 00 00    	js     0x1822eaf4c
   1822eaddd:	48 83 fb 0f          	cmp    rbx,0xf
   1822eade1:	77 15                	ja     0x1822eadf8
   1822eade3:	49 89 5f 10          	mov    QWORD PTR [r15+0x10],rbx
   1822eade7:	49 c7 47 18 0f 00 00 	mov    QWORD PTR [r15+0x18],0xf
   1822eadee:	00
   1822eadef:	0f 10 07             	movups xmm0,XMMWORD PTR [rdi]
   1822eadf2:	41 0f 11 07          	movups XMMWORD PTR [r15],xmm0
   1822eadf6:	eb 65                	jmp    0x1822eae5d
   1822eadf8:	48 89 d8             	mov    rax,rbx
   1822eadfb:	48 83 c8 0f          	or     rax,0xf
   1822eadff:	48 83 f8 17          	cmp    rax,0x17
   1822eae03:	41 be 16 00 00 00    	mov    r14d,0x16
   1822eae09:	4c 0f 43 f0          	cmovae r14,rax
   1822eae0d:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   1822eae13:	72 23                	jb     0x1822eae38
   1822eae15:	49 8d 4e 28          	lea    rcx,[r14+0x28]
   1822eae19:	e8 be 0e 26 05       	call   0x18754bcdc
   1822eae1e:	48 85 c0             	test   rax,rax
   1822eae21:	0f 84 35 01 00 00    	je     0x1822eaf5c
   1822eae27:	48 89 c1             	mov    rcx,rax
   1822eae2a:	48 83 c0 27          	add    rax,0x27
   1822eae2e:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
   1822eae32:	48 89 48 f8          	mov    QWORD PTR [rax-0x8],rcx
   1822eae36:	eb 09                	jmp    0x1822eae41
   1822eae38:	49 8d 4e 01          	lea    rcx,[r14+0x1]
   1822eae3c:	e8 9b 0e 26 05       	call   0x18754bcdc
   1822eae41:	49 89 07             	mov    QWORD PTR [r15],rax
   1822eae44:	49 89 5f 10          	mov    QWORD PTR [r15+0x10],rbx
   1822eae48:	4d 89 77 18          	mov    QWORD PTR [r15+0x18],r14
   1822eae4c:	48 ff c3             	inc    rbx
   1822eae4f:	48 89 c1             	mov    rcx,rax
   1822eae52:	48 89 fa             	mov    rdx,rdi
   1822eae55:	49 89 d8             	mov    r8,rbx
   1822eae58:	e8 e3 9f 42 05       	call   0x187714e40
   1822eae5d:	8b 86 64 01 00 00    	mov    eax,DWORD PTR [rsi+0x164]
   1822eae63:	41 89 47 20          	mov    DWORD PTR [r15+0x20],eax
   1822eae67:	8b 86 44 01 00 00    	mov    eax,DWORD PTR [rsi+0x144]
   1822eae6d:	41 89 47 24          	mov    DWORD PTR [r15+0x24],eax
   1822eae71:	48 8b 86 50 01 00 00 	mov    rax,QWORD PTR [rsi+0x150]
   1822eae78:	49 89 47 28          	mov    QWORD PTR [r15+0x28],rax
   1822eae7c:	0f 57 c0             	xorps  xmm0,xmm0
   1822eae7f:	41 0f 11 47 30       	movups XMMWORD PTR [r15+0x30],xmm0
   1822eae84:	41 0f 11 47 40       	movups XMMWORD PTR [r15+0x40],xmm0
   1822eae89:	48 8b be d8 02 00 00 	mov    rdi,QWORD PTR [rsi+0x2d8]
   1822eae90:	48 83 be e0 02 00 00 	cmp    QWORD PTR [rsi+0x2e0],0x10
   1822eae97:	10
   1822eae98:	72 09                	jb     0x1822eaea3
   1822eae9a:	48 8b b6 c8 02 00 00 	mov    rsi,QWORD PTR [rsi+0x2c8]
   1822eaea1:	eb 07                	jmp    0x1822eaeaa
   1822eaea3:	48 81 c6 c8 02 00 00 	add    rsi,0x2c8
   1822eaeaa:	48 85 ff             	test   rdi,rdi
   1822eaead:	0f 88 9f 00 00 00    	js     0x1822eaf52
   1822eaeb3:	48 83 ff 0f          	cmp    rdi,0xf
   1822eaeb7:	77 18                	ja     0x1822eaed1
   1822eaeb9:	49 8d 47 30          	lea    rax,[r15+0x30]
   1822eaebd:	49 89 7f 40          	mov    QWORD PTR [r15+0x40],rdi
   1822eaec1:	49 c7 47 48 0f 00 00 	mov    QWORD PTR [r15+0x48],0xf
   1822eaec8:	00
   1822eaec9:	0f 10 06             	movups xmm0,XMMWORD PTR [rsi]
   1822eaecc:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   1822eaecf:	eb 6b                	jmp    0x1822eaf3c
   1822eaed1:	4c 89 7d f8          	mov    QWORD PTR [rbp-0x8],r15
   1822eaed5:	48 89 f8             	mov    rax,rdi
   1822eaed8:	48 83 c8 0f          	or     rax,0xf
   1822eaedc:	48 83 f8 17          	cmp    rax,0x17
   1822eaee0:	bb 16 00 00 00       	mov    ebx,0x16
   1822eaee5:	48 0f 43 d8          	cmovae rbx,rax
   1822eaee9:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   1822eaeef:	72 20                	jb     0x1822eaf11
   1822eaef1:	48 8d 4b 28          	lea    rcx,[rbx+0x28]
   1822eaef5:	e8 e2 0d 26 05       	call   0x18754bcdc
   1822eaefa:	90                   	nop
   1822eaefb:	48 85 c0             	test   rax,rax
   1822eaefe:	74 5c                	je     0x1822eaf5c
   1822eaf00:	48 89 c1             	mov    rcx,rax
   1822eaf03:	48 83 c0 27          	add    rax,0x27
   1822eaf07:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
   1822eaf0b:	48 89 48 f8          	mov    QWORD PTR [rax-0x8],rcx
   1822eaf0f:	eb 0a                	jmp    0x1822eaf1b
   1822eaf11:	48 8d 4b 01          	lea    rcx,[rbx+0x1]
   1822eaf15:	e8 c2 0d 26 05       	call   0x18754bcdc
   1822eaf1a:	90                   	nop
   1822eaf1b:	4c 8b 7d f8          	mov    r15,QWORD PTR [rbp-0x8]
   1822eaf1f:	49 89 47 30          	mov    QWORD PTR [r15+0x30],rax
   1822eaf23:	49 89 7f 40          	mov    QWORD PTR [r15+0x40],rdi
   1822eaf27:	49 89 5f 48          	mov    QWORD PTR [r15+0x48],rbx
   1822eaf2b:	48 ff c7             	inc    rdi
   1822eaf2e:	48 89 c1             	mov    rcx,rax
   1822eaf31:	48 89 f2             	mov    rdx,rsi
   1822eaf34:	49 89 f8             	mov    r8,rdi
   1822eaf37:	e8 04 9f 42 05       	call   0x187714e40
   1822eaf3c:	4c 89 f8             	mov    rax,r15
   1822eaf3f:	48 83 c4 38          	add    rsp,0x38
   1822eaf43:	5b                   	pop    rbx
   1822eaf44:	5f                   	pop    rdi
   1822eaf45:	5e                   	pop    rsi
   1822eaf46:	41 5e                	pop    r14
   1822eaf48:	41 5f                	pop    r15
   1822eaf4a:	5d                   	pop    rbp
   1822eaf4b:	c3                   	ret
   1822eaf4c:	e8 3f dc d1 fd       	call   0x180008b90
   1822eaf51:	90                   	nop
   1822eaf52:	4c 89 7d f8          	mov    QWORD PTR [rbp-0x8],r15
   1822eaf56:	e8 35 dc d1 fd       	call   0x180008b90
   1822eaf5b:	90                   	nop
   1822eaf5c:	e8 2b 32 3f 05       	call   0x1876de18c
   1822eaf61:	cc                   	int3
