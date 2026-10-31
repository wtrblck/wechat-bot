
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001803823d0 <.text+0x3813d0>:
   1803823d0:	48 89 d0             	mov    rax,rdx
   1803823d3:	48 8b 51 30          	mov    rdx,QWORD PTR [rcx+0x30]
   1803823d7:	48 85 d2             	test   rdx,rdx
   1803823da:	74 14                	je     0x1803823f0
   1803823dc:	f0 ff 42 08          	lock inc DWORD PTR [rdx+0x8]
   1803823e0:	48 8b 51 30          	mov    rdx,QWORD PTR [rcx+0x30]
   1803823e4:	48 8b 49 28          	mov    rcx,QWORD PTR [rcx+0x28]
   1803823e8:	48 89 08             	mov    QWORD PTR [rax],rcx
   1803823eb:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
   1803823ef:	c3                   	ret
   1803823f0:	31 d2                	xor    edx,edx
   1803823f2:	48 8b 49 28          	mov    rcx,QWORD PTR [rcx+0x28]
   1803823f6:	48 89 08             	mov    QWORD PTR [rax],rcx
   1803823f9:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
   1803823fd:	c3                   	ret
   1803823fe:	cc                   	int3
   1803823ff:	cc                   	int3
   180382400:	48 89 d0             	mov    rax,rdx
   180382403:	48 8b 91 48 04 00 00 	mov    rdx,QWORD PTR [rcx+0x448]
   18038240a:	48 85 d2             	test   rdx,rdx
   18038240d:	74 1a                	je     0x180382429
   18038240f:	f0 ff 42 08          	lock inc DWORD PTR [rdx+0x8]
   180382413:	48 8b 91 48 04 00 00 	mov    rdx,QWORD PTR [rcx+0x448]
   18038241a:	48 8b 89 40 04 00 00 	mov    rcx,QWORD PTR [rcx+0x440]
   180382421:	48 89 08             	mov    QWORD PTR [rax],rcx
   180382424:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
   180382428:	c3                   	ret
   180382429:	31 d2                	xor    edx,edx
   18038242b:	48 8b 89 40 04 00 00 	mov    rcx,QWORD PTR [rcx+0x440]
   180382432:	48 89 08             	mov    QWORD PTR [rax],rcx
   180382435:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
   180382439:	c3                   	ret
   18038243a:	cc                   	int3
   18038243b:	cc                   	int3
   18038243c:	cc                   	int3
   18038243d:	cc                   	int3
   18038243e:	cc                   	int3
   18038243f:	cc                   	int3
   180382440:	56                   	push   rsi
   180382441:	57                   	push   rdi
   180382442:	53                   	push   rbx
   180382443:	48 83 ec 40          	sub    rsp,0x40
   180382447:	48 89 d6             	mov    rsi,rdx
   18038244a:	48 89 cf             	mov    rdi,rcx
   18038244d:	48 8b 05 ec 03 fa 0a 	mov    rax,QWORD PTR [rip+0xafa03ec]        # 0x18b322840
   180382454:	48 31 e0             	xor    rax,rsp
   180382457:	48 89 44 24 38       	mov    QWORD PTR [rsp+0x38],rax
   18038245c:	48 83 b9 60 04 00 00 	cmp    QWORD PTR [rcx+0x460],0x0
   180382463:	00 
   180382464:	74 1d                	je     0x180382483
   180382466:	48 8b 87 68 04 00 00 	mov    rax,QWORD PTR [rdi+0x468]
   18038246d:	48 85 c0             	test   rax,rax
