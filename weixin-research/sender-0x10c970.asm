
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

000000018010c970 <.text+0x10b970>:
   18010c970:	55                   	push   rbp
   18010c971:	56                   	push   rsi
   18010c972:	48 83 ec 28          	sub    rsp,0x28
   18010c976:	48 8d 6c 24 20       	lea    rbp,[rsp+0x20]
   18010c97b:	48 c7 45 00 fe ff ff 	mov    QWORD PTR [rbp+0x0],0xfffffffffffffffe
   18010c982:	ff 
   18010c983:	48 89 ce             	mov    rsi,rcx
   18010c986:	48 8b 02             	mov    rax,QWORD PTR [rdx]
   18010c989:	48 c7 02 00 00 00 00 	mov    QWORD PTR [rdx],0x0
   18010c990:	48 8b 09             	mov    rcx,QWORD PTR [rcx]
   18010c993:	48 89 06             	mov    QWORD PTR [rsi],rax
   18010c996:	48 85 c9             	test   rcx,rcx
   18010c999:	74 09                	je     0x18010c9a4
   18010c99b:	f0 ff 09             	lock dec DWORD PTR [rcx]
   18010c99e:	75 04                	jne    0x18010c9a4
   18010c9a0:	ff 51 10             	call   QWORD PTR [rcx+0x10]
   18010c9a3:	90                   	nop
   18010c9a4:	48 89 f0             	mov    rax,rsi
   18010c9a7:	48 83 c4 28          	add    rsp,0x28
   18010c9ab:	5e                   	pop    rsi
   18010c9ac:	5d                   	pop    rbp
   18010c9ad:	c3                   	ret
