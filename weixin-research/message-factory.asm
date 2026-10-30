
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

0000000180709160 <.text+0x708160>:
   180709160:	55                   	push   rbp
   180709161:	56                   	push   rsi
   180709162:	57                   	push   rdi
   180709163:	53                   	push   rbx
   180709164:	48 83 ec 38          	sub    rsp,0x38
   180709168:	48 8d 6c 24 30       	lea    rbp,[rsp+0x30]
   18070916d:	48 c7 45 00 fe ff ff 	mov    QWORD PTR [rbp+0x0],0xfffffffffffffffe
   180709174:	ff
   180709175:	48 89 ce             	mov    rsi,rcx
   180709178:	b9 a8 07 00 00       	mov    ecx,0x7a8
   18070917d:	e8 5a 2b e4 06       	call   0x18754bcdc
   180709182:	48 b9 01 00 00 00 01 	movabs rcx,0x100000001
   180709189:	00 00 00
   18070918c:	48 89 48 08          	mov    QWORD PTR [rax+0x8],rcx
   180709190:	48 8d 0d 21 d9 91 08 	lea    rcx,[rip+0x891d921]        # 0x189026ab8
   180709197:	48 89 08             	mov    QWORD PTR [rax],rcx
   18070919a:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
   18070919e:	48 8d 78 10          	lea    rdi,[rax+0x10]
   1807091a2:	41 b8 98 07 00 00    	mov    r8d,0x798
   1807091a8:	48 89 f9             	mov    rcx,rdi
   1807091ab:	31 d2                	xor    edx,edx
   1807091ad:	e8 2e c3 00 07       	call   0x1877154e0
   1807091b2:	90                   	nop
   1807091b3:	48 89 f9             	mov    rcx,rdi
   1807091b6:	e8 b5 19 07 00       	call   0x18077ab70
   1807091bb:	90                   	nop
   1807091bc:	48 89 3e             	mov    QWORD PTR [rsi],rdi
   1807091bf:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
   1807091c3:	48 89 5e 08          	mov    QWORD PTR [rsi+0x8],rbx
   1807091c7:	48 8b 4b 20          	mov    rcx,QWORD PTR [rbx+0x20]
   1807091cb:	48 85 c9             	test   rcx,rcx
   1807091ce:	74 06                	je     0x1807091d6
   1807091d0:	83 79 08 00          	cmp    DWORD PTR [rcx+0x8],0x0
   1807091d4:	75 66                	jne    0x18070923c
   1807091d6:	48 85 db             	test   rbx,rbx
   1807091d9:	74 1b                	je     0x1807091f6
   1807091db:	f0 ff 43 08          	lock inc DWORD PTR [rbx+0x8]
   1807091df:	f0 ff 43 0c          	lock inc DWORD PTR [rbx+0xc]
   1807091e3:	48 8b 4b 20          	mov    rcx,QWORD PTR [rbx+0x20]
   1807091e7:	48 89 7b 18          	mov    QWORD PTR [rbx+0x18],rdi
   1807091eb:	48 89 5b 20          	mov    QWORD PTR [rbx+0x20],rbx
   1807091ef:	48 85 c9             	test   rcx,rcx
   1807091f2:	75 11                	jne    0x180709205
   1807091f4:	eb 1b                	jmp    0x180709211
   1807091f6:	31 ff                	xor    edi,edi
   1807091f8:	48 89 7b 18          	mov    QWORD PTR [rbx+0x18],rdi
   1807091fc:	48 89 5b 20          	mov    QWORD PTR [rbx+0x20],rbx
   180709200:	48 85 c9             	test   rcx,rcx
   180709203:	74 0c                	je     0x180709211
   180709205:	f0 ff 49 0c          	lock dec DWORD PTR [rcx+0xc]
   180709209:	75 06                	jne    0x180709211
   18070920b:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   18070920e:	ff 50 08             	call   QWORD PTR [rax+0x8]
   180709211:	48 85 db             	test   rbx,rbx
   180709214:	74 26                	je     0x18070923c
   180709216:	48 8d 43 08          	lea    rax,[rbx+0x8]
   18070921a:	f0 ff 08             	lock dec DWORD PTR [rax]
   18070921d:	75 1d                	jne    0x18070923c
   18070921f:	48 89 df             	mov    rdi,rbx
   180709222:	48 83 c7 0c          	add    rdi,0xc
   180709226:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   180709229:	48 89 d9             	mov    rcx,rbx
   18070922c:	ff 10                	call   QWORD PTR [rax]
   18070922e:	f0 ff 0f             	lock dec DWORD PTR [rdi]
   180709231:	75 09                	jne    0x18070923c
   180709233:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   180709236:	48 89 d9             	mov    rcx,rbx
   180709239:	ff 50 08             	call   QWORD PTR [rax+0x8]
   18070923c:	48 89 f0             	mov    rax,rsi
   18070923f:	48 83 c4 38          	add    rsp,0x38
   180709243:	5b                   	pop    rbx
   180709244:	5f                   	pop    rdi
   180709245:	5e                   	pop    rsi
   180709246:	5d                   	pop    rbp
   180709247:	c3                   	ret
   180709248:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
   18070924f:	00
   180709250:	48 89 54 24 10       	mov    QWORD PTR [rsp+0x10],rdx
   180709255:	55                   	push   rbp
   180709256:	56                   	push   rsi
   180709257:	57                   	push   rdi
   180709258:	53                   	push   rbx
   180709259:	48 83 ec 28          	sub    rsp,0x28
   18070925d:	48 8d 6a 30          	lea    rbp,[rdx+0x30]
   180709261:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
   180709265:	e8 ae 2a e4 06       	call   0x18754bd18
   18070926a:	90                   	nop
   18070926b:	48 83 c4 28          	add    rsp,0x28
   18070926f:	5b                   	pop    rbx
   180709270:	5f                   	pop    rdi
   180709271:	5e                   	pop    rsi
   180709272:	5d                   	pop    rbp
   180709273:	c3                   	ret
   180709274:	cc                   	int3
   180709275:	cc                   	int3
   180709276:	cc                   	int3
   180709277:	cc                   	int3
   180709278:	cc                   	int3
   180709279:	cc                   	int3
   18070927a:	cc                   	int3
   18070927b:	cc                   	int3
   18070927c:	cc                   	int3
   18070927d:	cc                   	int3
   18070927e:	cc                   	int3
   18070927f:	cc                   	int3
