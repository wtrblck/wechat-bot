
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

000000018010ca70 <.text+0x10ba70>:
   18010ca70:	55                   	push   rbp
   18010ca71:	48 83 ec 30          	sub    rsp,0x30
   18010ca75:	48 8d 6c 24 30       	lea    rbp,[rsp+0x30]
   18010ca7a:	48 c7 45 f8 fe ff ff 	mov    QWORD PTR [rbp-0x8],0xfffffffffffffffe
   18010ca81:	ff 
   18010ca82:	48 8b 09             	mov    rcx,QWORD PTR [rcx]
   18010ca85:	48 85 c9             	test   rcx,rcx
   18010ca88:	74 09                	je     0x18010ca93
   18010ca8a:	f0 ff 09             	lock dec DWORD PTR [rcx]
   18010ca8d:	75 04                	jne    0x18010ca93
   18010ca8f:	ff 51 10             	call   QWORD PTR [rcx+0x10]
   18010ca92:	90                   	nop
   18010ca93:	48 83 c4 30          	add    rsp,0x30
   18010ca97:	5d                   	pop    rbp
   18010ca98:	c3                   	ret
