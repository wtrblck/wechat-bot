
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001855f1a50 <.text+0x55f0a50>:
   1855f1a50:	56                   	push   rsi
   1855f1a51:	57                   	push   rdi
   1855f1a52:	48 83 ec 28          	sub    rsp,0x28
   1855f1a56:	48 89 ce             	mov    rsi,rcx
   1855f1a59:	48 8b 79 48          	mov    rdi,QWORD PTR [rcx+0x48]
   1855f1a5d:	48 85 ff             	test   rdi,rdi
   1855f1a60:	74 1d                	je     0x1855f1a7f
   1855f1a62:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1855f1a66:	75 17                	jne    0x1855f1a7f
   1855f1a68:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855f1a6b:	48 89 f9             	mov    rcx,rdi
   1855f1a6e:	ff 10                	call   QWORD PTR [rax]
   1855f1a70:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1855f1a74:	75 09                	jne    0x1855f1a7f
   1855f1a76:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855f1a79:	48 89 f9             	mov    rcx,rdi
   1855f1a7c:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855f1a7f:	48 8b 7e 38          	mov    rdi,QWORD PTR [rsi+0x38]
   1855f1a83:	48 85 ff             	test   rdi,rdi
   1855f1a86:	74 1d                	je     0x1855f1aa5
   1855f1a88:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1855f1a8c:	75 17                	jne    0x1855f1aa5
   1855f1a8e:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855f1a91:	48 89 f9             	mov    rcx,rdi
   1855f1a94:	ff 10                	call   QWORD PTR [rax]
   1855f1a96:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1855f1a9a:	75 09                	jne    0x1855f1aa5
   1855f1a9c:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855f1a9f:	48 89 f9             	mov    rcx,rdi
   1855f1aa2:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855f1aa5:	48 8b 46 28          	mov    rax,QWORD PTR [rsi+0x28]
   1855f1aa9:	48 83 f8 10          	cmp    rax,0x10
   1855f1aad:	72 31                	jb     0x1855f1ae0
   1855f1aaf:	48 8b 4e 10          	mov    rcx,QWORD PTR [rsi+0x10]
   1855f1ab3:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855f1ab7:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855f1abe:	72 1b                	jb     0x1855f1adb
   1855f1ac0:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855f1ac4:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855f1ac8:	4c 29 c1             	sub    rcx,r8
   1855f1acb:	48 83 f9 20          	cmp    rcx,0x20
   1855f1acf:	73 43                	jae    0x1855f1b14
   1855f1ad1:	48 83 c0 28          	add    rax,0x28
   1855f1ad5:	48 89 c2             	mov    rdx,rax
   1855f1ad8:	4c 89 c1             	mov    rcx,r8
   1855f1adb:	e8 40 a2 f5 01       	call   0x18754bd20
   1855f1ae0:	48 8b 76 08          	mov    rsi,QWORD PTR [rsi+0x8]
   1855f1ae4:	48 85 f6             	test   rsi,rsi
   1855f1ae7:	74 24                	je     0x1855f1b0d
   1855f1ae9:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855f1aed:	75 1e                	jne    0x1855f1b0d
   1855f1aef:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855f1af2:	48 89 f1             	mov    rcx,rsi
   1855f1af5:	ff 10                	call   QWORD PTR [rax]
   1855f1af7:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855f1afb:	75 10                	jne    0x1855f1b0d
   1855f1afd:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855f1b00:	48 89 f1             	mov    rcx,rsi
   1855f1b03:	48 83 c4 28          	add    rsp,0x28
   1855f1b07:	5f                   	pop    rdi
   1855f1b08:	5e                   	pop    rsi
   1855f1b09:	48 ff 60 08          	rex.W jmp QWORD PTR [rax+0x8]
   1855f1b0d:	48 83 c4 28          	add    rsp,0x28
   1855f1b11:	5f                   	pop    rdi
   1855f1b12:	5e                   	pop    rsi
   1855f1b13:	c3                   	ret
   1855f1b14:	e8 73 c6 0e 02       	call   0x1876de18c
   1855f1b19:	cc                   	int3
