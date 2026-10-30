
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

000000018180c4c0 <.text+0x180b4c0>:
   18180c4c0:	55                   	push   rbp
   18180c4c1:	56                   	push   rsi
   18180c4c2:	57                   	push   rdi
   18180c4c3:	48 81 ec 80 00 00 00 	sub    rsp,0x80
   18180c4ca:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   18180c4d1:	00
   18180c4d2:	48 c7 45 f8 fe ff ff 	mov    QWORD PTR [rbp-0x8],0xfffffffffffffffe
   18180c4d9:	ff
   18180c4da:	48 89 d7             	mov    rdi,rdx
   18180c4dd:	48 89 ce             	mov    rsi,rcx
   18180c4e0:	48 8b 12             	mov    rdx,QWORD PTR [rdx]
   18180c4e3:	48 85 d2             	test   rdx,rdx
   18180c4e6:	0f 84 a2 00 00 00    	je     0x18180c58e
   18180c4ec:	48 89 7d f0          	mov    QWORD PTR [rbp-0x10],rdi
   18180c4f0:	48 8d 4d a0          	lea    rcx,[rbp-0x60]
   18180c4f4:	e8 97 e8 ad 00       	call   0x1822ead90
   18180c4f9:	90                   	nop
   18180c4fa:	48 8d 55 a0          	lea    rdx,[rbp-0x60]
   18180c4fe:	48 89 f1             	mov    rcx,rsi
   18180c501:	e8 6a 1d 04 00       	call   0x18184e270
   18180c506:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
   18180c50a:	48 83 f8 10          	cmp    rax,0x10
   18180c50e:	48 8b 7d f0          	mov    rdi,QWORD PTR [rbp-0x10]
   18180c512:	72 35                	jb     0x18180c549
   18180c514:	48 8b 4d d0          	mov    rcx,QWORD PTR [rbp-0x30]
   18180c518:	48 8d 50 01          	lea    rdx,[rax+0x1]
   18180c51c:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   18180c523:	72 1f                	jb     0x18180c544
   18180c525:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   18180c529:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   18180c52d:	4c 29 c1             	sub    rcx,r8
   18180c530:	48 83 f9 20          	cmp    rcx,0x20
   18180c534:	0f 83 05 01 00 00    	jae    0x18180c63f
   18180c53a:	48 83 c0 28          	add    rax,0x28
   18180c53e:	48 89 c2             	mov    rdx,rax
   18180c541:	4c 89 c1             	mov    rcx,r8
   18180c544:	e8 d7 f7 d3 05       	call   0x18754bd20
   18180c549:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
   18180c54d:	48 83 f8 10          	cmp    rax,0x10
   18180c551:	0f 82 b6 00 00 00    	jb     0x18180c60d
   18180c557:	48 8b 4d a0          	mov    rcx,QWORD PTR [rbp-0x60]
   18180c55b:	48 8d 50 01          	lea    rdx,[rax+0x1]
   18180c55f:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   18180c566:	72 1f                	jb     0x18180c587
   18180c568:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   18180c56c:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   18180c570:	4c 29 c1             	sub    rcx,r8
   18180c573:	48 83 f9 20          	cmp    rcx,0x20
   18180c577:	0f 83 c2 00 00 00    	jae    0x18180c63f
   18180c57d:	48 83 c0 28          	add    rax,0x28
   18180c581:	48 89 c2             	mov    rdx,rax
   18180c584:	4c 89 c1             	mov    rcx,r8
   18180c587:	e8 94 f7 d3 05       	call   0x18754bd20
   18180c58c:	eb 7f                	jmp    0x18180c60d
   18180c58e:	80 7e 50 01          	cmp    BYTE PTR [rsi+0x50],0x1
   18180c592:	75 79                	jne    0x18180c60d
   18180c594:	48 8b 46 48          	mov    rax,QWORD PTR [rsi+0x48]
   18180c598:	48 83 f8 10          	cmp    rax,0x10
   18180c59c:	72 31                	jb     0x18180c5cf
   18180c59e:	48 8b 4e 30          	mov    rcx,QWORD PTR [rsi+0x30]
   18180c5a2:	48 8d 50 01          	lea    rdx,[rax+0x1]
   18180c5a6:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   18180c5ad:	72 1b                	jb     0x18180c5ca
   18180c5af:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   18180c5b3:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   18180c5b7:	4c 29 c1             	sub    rcx,r8
   18180c5ba:	48 83 f9 20          	cmp    rcx,0x20
   18180c5be:	73 7f                	jae    0x18180c63f
   18180c5c0:	48 83 c0 28          	add    rax,0x28
   18180c5c4:	48 89 c2             	mov    rdx,rax
   18180c5c7:	4c 89 c1             	mov    rcx,r8
   18180c5ca:	e8 51 f7 d3 05       	call   0x18754bd20
   18180c5cf:	48 8b 46 18          	mov    rax,QWORD PTR [rsi+0x18]
   18180c5d3:	48 83 f8 10          	cmp    rax,0x10
   18180c5d7:	72 30                	jb     0x18180c609
   18180c5d9:	48 8b 0e             	mov    rcx,QWORD PTR [rsi]
   18180c5dc:	48 8d 50 01          	lea    rdx,[rax+0x1]
   18180c5e0:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   18180c5e7:	72 1b                	jb     0x18180c604
   18180c5e9:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   18180c5ed:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   18180c5f1:	4c 29 c1             	sub    rcx,r8
   18180c5f4:	48 83 f9 20          	cmp    rcx,0x20
   18180c5f8:	73 45                	jae    0x18180c63f
   18180c5fa:	48 83 c0 28          	add    rax,0x28
   18180c5fe:	48 89 c2             	mov    rdx,rax
   18180c601:	4c 89 c1             	mov    rcx,r8
   18180c604:	e8 17 f7 d3 05       	call   0x18754bd20
   18180c609:	c6 46 50 00          	mov    BYTE PTR [rsi+0x50],0x0
   18180c60d:	48 8b 77 08          	mov    rsi,QWORD PTR [rdi+0x8]
   18180c611:	48 85 f6             	test   rsi,rsi
   18180c614:	74 1e                	je     0x18180c634
   18180c616:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   18180c61a:	75 18                	jne    0x18180c634
   18180c61c:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   18180c61f:	48 89 f1             	mov    rcx,rsi
   18180c622:	ff 10                	call   QWORD PTR [rax]
   18180c624:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   18180c628:	75 0a                	jne    0x18180c634
   18180c62a:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   18180c62d:	48 89 f1             	mov    rcx,rsi
   18180c630:	ff 50 08             	call   QWORD PTR [rax+0x8]
   18180c633:	90                   	nop
   18180c634:	48 81 c4 80 00 00 00 	add    rsp,0x80
   18180c63b:	5f                   	pop    rdi
   18180c63c:	5e                   	pop    rsi
   18180c63d:	5d                   	pop    rbp
   18180c63e:	c3                   	ret
   18180c63f:	e8 48 1b ed 05       	call   0x1876de18c
   18180c644:	cc                   	int3
