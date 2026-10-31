
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

0000000181094190 <.text+0x1093190>:
   181094190:	55                   	push   rbp
   181094191:	48 83 ec 30          	sub    rsp,0x30
   181094195:	48 8d 6c 24 30       	lea    rbp,[rsp+0x30]
   18109419a:	48 c7 45 f8 fe ff ff 	mov    QWORD PTR [rbp-0x8],0xfffffffffffffffe
   1810941a1:	ff 
   1810941a2:	48 8d 05 bf 2b 10 08 	lea    rax,[rip+0x8102bbf]        # 0x189196d68
   1810941a9:	48 89 01             	mov    QWORD PTR [rcx],rax
   1810941ac:	48 c7 41 68 00 00 00 	mov    QWORD PTR [rcx+0x68],0x0
   1810941b3:	00 
   1810941b4:	c7 41 48 00 00 00 00 	mov    DWORD PTR [rcx+0x48],0x0
   1810941bb:	0f 57 c0             	xorps  xmm0,xmm0
   1810941be:	0f 11 41 08          	movups XMMWORD PTR [rcx+0x8],xmm0
   1810941c2:	0f 11 41 18          	movups XMMWORD PTR [rcx+0x18],xmm0
   1810941c6:	0f 11 41 28          	movups XMMWORD PTR [rcx+0x28],xmm0
   1810941ca:	48 8d 05 9f 36 b0 0a 	lea    rax,[rip+0xab0369f]        # 0x18bb97870
   1810941d1:	48 89 41 38          	mov    QWORD PTR [rcx+0x38],rax
   1810941d5:	48 89 41 40          	mov    QWORD PTR [rcx+0x40],rax
   1810941d9:	0f 11 41 4c          	movups XMMWORD PTR [rcx+0x4c],xmm0
   1810941dd:	0f 11 41 58          	movups XMMWORD PTR [rcx+0x58],xmm0
   1810941e1:	48 89 4d f0          	mov    QWORD PTR [rbp-0x10],rcx
   1810941e5:	e8 36 00 00 00       	call   0x181094220
   1810941ea:	90                   	nop
   1810941eb:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
   1810941ef:	48 83 c4 30          	add    rsp,0x30
   1810941f3:	5d                   	pop    rbp
   1810941f4:	c3                   	ret
