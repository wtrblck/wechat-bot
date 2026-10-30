
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

0000000180047220 <.text+0x46220>:
   180047220:	56                   	push   rsi
   180047221:	48 83 ec 40          	sub    rsp,0x40
   180047225:	48 89 ce             	mov    rsi,rcx
   180047228:	48 8b 05 11 b6 2d 0b 	mov    rax,QWORD PTR [rip+0xb2db611]        # 0x18b322840
   18004722f:	48 31 e0             	xor    rax,rsp
   180047232:	48 89 44 24 38       	mov    QWORD PTR [rsp+0x38],rax
   180047237:	48 8b 0d 62 bd b4 0b 	mov    rcx,QWORD PTR [rip+0xbb4bd62]        # 0x18bb92fa0
   18004723e:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   180047241:	48 8d 54 24 20       	lea    rdx,[rsp+0x20]
   180047246:	ff 50 60             	call   QWORD PTR [rax+0x60]
   180047249:	0f 28 44 24 20       	movaps xmm0,XMMWORD PTR [rsp+0x20]
   18004724e:	0f 11 06             	movups XMMWORD PTR [rsi],xmm0
   180047251:	48 8b 44 24 38       	mov    rax,QWORD PTR [rsp+0x38]
   180047256:	48 31 e0             	xor    rax,rsp
   180047259:	48 8b 0d e0 b5 2d 0b 	mov    rcx,QWORD PTR [rip+0xb2db5e0]        # 0x18b322840
   180047260:	48 39 c1             	cmp    rcx,rax
   180047263:	75 09                	jne    0x18004726e
   180047265:	48 89 f0             	mov    rax,rsi
   180047268:	48 83 c4 40          	add    rsp,0x40
   18004726c:	5e                   	pop    rsi
   18004726d:	c3                   	ret
   18004726e:	48 8b 4c 24 38       	mov    rcx,QWORD PTR [rsp+0x38]
   180047273:	48 31 e1             	xor    rcx,rsp
   180047276:	e8 25 4c 50 07       	call   0x18754bea0
   18004727b:	cc                   	int3
