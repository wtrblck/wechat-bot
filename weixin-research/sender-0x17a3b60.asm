
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001817a3b60 <.text+0x17a2b60>:
   1817a3b60:	55                   	push   rbp
   1817a3b61:	56                   	push   rsi
   1817a3b62:	57                   	push   rdi
   1817a3b63:	48 83 ec 40          	sub    rsp,0x40
   1817a3b67:	48 8d 6c 24 40       	lea    rbp,[rsp+0x40]
   1817a3b6c:	48 c7 45 f8 fe ff ff 	mov    QWORD PTR [rbp-0x8],0xfffffffffffffffe
   1817a3b73:	ff
   1817a3b74:	48 89 d6             	mov    rsi,rdx
   1817a3b77:	0f 57 c0             	xorps  xmm0,xmm0
   1817a3b7a:	0f 29 45 e0          	movaps XMMWORD PTR [rbp-0x20],xmm0
   1817a3b7e:	49 8b 40 08          	mov    rax,QWORD PTR [r8+0x8]
   1817a3b82:	48 85 c0             	test   rax,rax
   1817a3b85:	74 0a                	je     0x1817a3b91
   1817a3b87:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1817a3b8b:	49 8b 40 08          	mov    rax,QWORD PTR [r8+0x8]
   1817a3b8f:	eb 02                	jmp    0x1817a3b93
   1817a3b91:	31 c0                	xor    eax,eax
   1817a3b93:	49 8b 10             	mov    rdx,QWORD PTR [r8]
   1817a3b96:	48 89 55 e0          	mov    QWORD PTR [rbp-0x20],rdx
   1817a3b9a:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
   1817a3b9e:	4c 89 45 f0          	mov    QWORD PTR [rbp-0x10],r8
   1817a3ba2:	4c 8d 45 e0          	lea    r8,[rbp-0x20]
   1817a3ba6:	48 89 f2             	mov    rdx,rsi
   1817a3ba9:	41 b1 01             	mov    r9b,0x1
   1817a3bac:	e8 6f 00 00 00       	call   0x1817a3c20
   1817a3bb1:	90                   	nop
   1817a3bb2:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
   1817a3bb6:	48 8b 78 08          	mov    rdi,QWORD PTR [rax+0x8]
   1817a3bba:	48 85 ff             	test   rdi,rdi
   1817a3bbd:	74 1d                	je     0x1817a3bdc
   1817a3bbf:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1817a3bc3:	75 17                	jne    0x1817a3bdc
   1817a3bc5:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1817a3bc8:	48 89 f9             	mov    rcx,rdi
   1817a3bcb:	ff 10                	call   QWORD PTR [rax]
   1817a3bcd:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1817a3bd1:	75 09                	jne    0x1817a3bdc
   1817a3bd3:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1817a3bd6:	48 89 f9             	mov    rcx,rdi
   1817a3bd9:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1817a3bdc:	48 89 f0             	mov    rax,rsi
   1817a3bdf:	48 83 c4 40          	add    rsp,0x40
   1817a3be3:	5f                   	pop    rdi
   1817a3be4:	5e                   	pop    rsi
   1817a3be5:	5d                   	pop    rbp
   1817a3be6:	c3                   	ret
