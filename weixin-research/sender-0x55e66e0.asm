
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001855e66e0 <.text+0x55e56e0>:
   1855e66e0:	55                   	push   rbp
   1855e66e1:	56                   	push   rsi
   1855e66e2:	57                   	push   rdi
   1855e66e3:	48 81 ec 50 01 00 00 	sub    rsp,0x150
   1855e66ea:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   1855e66f1:	00 
   1855e66f2:	0f 29 b5 c0 00 00 00 	movaps XMMWORD PTR [rbp+0xc0],xmm6
   1855e66f9:	48 c7 85 b8 00 00 00 	mov    QWORD PTR [rbp+0xb8],0xfffffffffffffffe
   1855e6700:	fe ff ff ff 
   1855e6704:	48 89 ce             	mov    rsi,rcx
   1855e6707:	48 b8 aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaaa
   1855e670e:	aa aa aa 
   1855e6711:	48 89 45 40          	mov    QWORD PTR [rbp+0x40],rax
   1855e6715:	0f 28 35 94 04 93 03 	movaps xmm6,XMMWORD PTR [rip+0x3930494]        # 0x188f16bb0
   1855e671c:	0f 29 75 30          	movaps XMMWORD PTR [rbp+0x30],xmm6
   1855e6720:	0f 29 75 20          	movaps XMMWORD PTR [rbp+0x20],xmm6
   1855e6724:	0f 29 75 10          	movaps XMMWORD PTR [rbp+0x10],xmm6
   1855e6728:	48 8d 4d 50          	lea    rcx,[rbp+0x50]
   1855e672c:	e8 ef 0a a6 fa       	call   0x180047220
   1855e6731:	48 8b 4d 50          	mov    rcx,QWORD PTR [rbp+0x50]
   1855e6735:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   1855e6739:	e8 92 bc d9 fa       	call   0x1803823d0
   1855e673e:	90                   	nop
   1855e673f:	48 8b 4d c0          	mov    rcx,QWORD PTR [rbp-0x40]
   1855e6743:	48 8d 55 60          	lea    rdx,[rbp+0x60]
   1855e6747:	e8 b4 09 8d fb       	call   0x180eb7100
   1855e674c:	90                   	nop
   1855e674d:	48 8b 4d 60          	mov    rcx,QWORD PTR [rbp+0x60]
   1855e6751:	48 8d 86 98 00 00 00 	lea    rax,[rsi+0x98]
   1855e6758:	48 8d 56 78          	lea    rdx,[rsi+0x78]
   1855e675c:	4c 8d 56 58          	lea    r10,[rsi+0x58]
   1855e6760:	4c 8d 4e 38          	lea    r9,[rsi+0x38]
   1855e6764:	4c 8d 46 18          	lea    r8,[rsi+0x18]
   1855e6768:	48 89 44 24 30       	mov    QWORD PTR [rsp+0x30],rax
   1855e676d:	48 89 54 24 28       	mov    QWORD PTR [rsp+0x28],rdx
   1855e6772:	4c 89 54 24 20       	mov    QWORD PTR [rsp+0x20],r10
   1855e6777:	48 8d 55 10          	lea    rdx,[rbp+0x10]
   1855e677b:	e8 30 2f 63 fd       	call   0x182c196b0
   1855e6780:	90                   	nop
   1855e6781:	48 8b 7d 68          	mov    rdi,QWORD PTR [rbp+0x68]
   1855e6785:	48 85 ff             	test   rdi,rdi
   1855e6788:	74 1d                	je     0x1855e67a7
   1855e678a:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1855e678e:	75 17                	jne    0x1855e67a7
   1855e6790:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855e6793:	48 89 f9             	mov    rcx,rdi
   1855e6796:	ff 10                	call   QWORD PTR [rax]
   1855e6798:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1855e679c:	75 09                	jne    0x1855e67a7
   1855e679e:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855e67a1:	48 89 f9             	mov    rcx,rdi
   1855e67a4:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855e67a7:	48 8b 7d c8          	mov    rdi,QWORD PTR [rbp-0x38]
   1855e67ab:	48 85 ff             	test   rdi,rdi
   1855e67ae:	74 1d                	je     0x1855e67cd
   1855e67b0:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1855e67b4:	75 17                	jne    0x1855e67cd
   1855e67b6:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855e67b9:	48 89 f9             	mov    rcx,rdi
   1855e67bc:	ff 10                	call   QWORD PTR [rax]
   1855e67be:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1855e67c2:	75 09                	jne    0x1855e67cd
   1855e67c4:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855e67c7:	48 89 f9             	mov    rcx,rdi
   1855e67ca:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855e67cd:	48 8b 7d 58          	mov    rdi,QWORD PTR [rbp+0x58]
   1855e67d1:	48 85 ff             	test   rdi,rdi
   1855e67d4:	74 1d                	je     0x1855e67f3
   1855e67d6:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1855e67da:	75 17                	jne    0x1855e67f3
   1855e67dc:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855e67df:	48 89 f9             	mov    rcx,rdi
   1855e67e2:	ff 10                	call   QWORD PTR [rax]
   1855e67e4:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1855e67e8:	75 09                	jne    0x1855e67f3
   1855e67ea:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855e67ed:	48 89 f9             	mov    rcx,rdi
   1855e67f0:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855e67f3:	f6 45 10 01          	test   BYTE PTR [rbp+0x10],0x1
   1855e67f7:	0f 84 96 00 00 00    	je     0x1855e6893
   1855e67fd:	0f 29 b5 a0 00 00 00 	movaps XMMWORD PTR [rbp+0xa0],xmm6
   1855e6804:	0f 29 75 60          	movaps XMMWORD PTR [rbp+0x60],xmm6
   1855e6808:	0f 29 75 70          	movaps XMMWORD PTR [rbp+0x70],xmm6
   1855e680c:	0f 29 b5 80 00 00 00 	movaps XMMWORD PTR [rbp+0x80],xmm6
   1855e6813:	0f 29 b5 90 00 00 00 	movaps XMMWORD PTR [rbp+0x90],xmm6
   1855e681a:	c6 85 a8 00 00 00 00 	mov    BYTE PTR [rbp+0xa8],0x0
   1855e6821:	c6 45 60 01          	mov    BYTE PTR [rbp+0x60],0x1
   1855e6825:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
   1855e6829:	48 8b 4d 20          	mov    rcx,QWORD PTR [rbp+0x20]
   1855e682d:	48 89 45 68          	mov    QWORD PTR [rbp+0x68],rax
   1855e6831:	c6 45 70 01          	mov    BYTE PTR [rbp+0x70],0x1
   1855e6835:	48 89 4d 78          	mov    QWORD PTR [rbp+0x78],rcx
   1855e6839:	c6 85 80 00 00 00 01 	mov    BYTE PTR [rbp+0x80],0x1
   1855e6840:	48 8b 4e 08          	mov    rcx,QWORD PTR [rsi+0x8]
   1855e6844:	0f b6 45 70          	movzx  eax,BYTE PTR [rbp+0x70]
   1855e6848:	88 45 d0             	mov    BYTE PTR [rbp-0x30],al
   1855e684b:	8b 45 71             	mov    eax,DWORD PTR [rbp+0x71]
   1855e684e:	89 45 d1             	mov    DWORD PTR [rbp-0x2f],eax
   1855e6851:	0f b7 45 75          	movzx  eax,WORD PTR [rbp+0x75]
   1855e6855:	66 89 45 d5          	mov    WORD PTR [rbp-0x2b],ax
   1855e6859:	0f b6 45 77          	movzx  eax,BYTE PTR [rbp+0x77]
   1855e685d:	88 45 d7             	mov    BYTE PTR [rbp-0x29],al
   1855e6860:	48 8b 45 78          	mov    rax,QWORD PTR [rbp+0x78]
   1855e6864:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
   1855e6868:	48 8b 85 80 00 00 00 	mov    rax,QWORD PTR [rbp+0x80]
   1855e686f:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
   1855e6873:	48 8b 45 60          	mov    rax,QWORD PTR [rbp+0x60]
   1855e6877:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
   1855e687b:	48 8b 45 68          	mov    rax,QWORD PTR [rbp+0x68]
   1855e687f:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
   1855e6883:	c6 45 08 00          	mov    BYTE PTR [rbp+0x8],0x0
   1855e6887:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   1855e688b:	e8 a0 bf ff ff       	call   0x1855e2830
   1855e6890:	90                   	nop
   1855e6891:	eb 55                	jmp    0x1855e68e8
   1855e6893:	48 8b 76 08          	mov    rsi,QWORD PTR [rsi+0x8]
   1855e6897:	48 8d 55 28          	lea    rdx,[rbp+0x28]
   1855e689b:	0f 29 75 70          	movaps XMMWORD PTR [rbp+0x70],xmm6
   1855e689f:	0f 29 b5 80 00 00 00 	movaps XMMWORD PTR [rbp+0x80],xmm6
   1855e68a6:	0f 29 b5 a0 00 00 00 	movaps XMMWORD PTR [rbp+0xa0],xmm6
   1855e68ad:	0f 29 75 60          	movaps XMMWORD PTR [rbp+0x60],xmm6
   1855e68b1:	0f 29 b5 90 00 00 00 	movaps XMMWORD PTR [rbp+0x90],xmm6
   1855e68b8:	c6 45 70 00          	mov    BYTE PTR [rbp+0x70],0x0
   1855e68bc:	c6 85 80 00 00 00 00 	mov    BYTE PTR [rbp+0x80],0x0
   1855e68c3:	c6 85 a8 00 00 00 00 	mov    BYTE PTR [rbp+0xa8],0x0
   1855e68ca:	c6 45 60 00          	mov    BYTE PTR [rbp+0x60],0x0
   1855e68ce:	48 8d 8d 88 00 00 00 	lea    rcx,[rbp+0x88]
   1855e68d5:	e8 16 e7 3a fc       	call   0x181994ff0
   1855e68da:	90                   	nop
   1855e68db:	48 8d 55 60          	lea    rdx,[rbp+0x60]
   1855e68df:	48 89 f1             	mov    rcx,rsi
   1855e68e2:	e8 49 bf ff ff       	call   0x1855e2830
   1855e68e7:	90                   	nop
   1855e68e8:	48 8b 45 40          	mov    rax,QWORD PTR [rbp+0x40]
   1855e68ec:	48 83 f8 10          	cmp    rax,0x10
   1855e68f0:	72 31                	jb     0x1855e6923
   1855e68f2:	48 8b 4d 28          	mov    rcx,QWORD PTR [rbp+0x28]
   1855e68f6:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855e68fa:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855e6901:	72 1b                	jb     0x1855e691e
   1855e6903:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855e6907:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855e690b:	4c 29 c1             	sub    rcx,r8
   1855e690e:	48 83 f9 20          	cmp    rcx,0x20
   1855e6912:	73 21                	jae    0x1855e6935
   1855e6914:	48 83 c0 28          	add    rax,0x28
   1855e6918:	48 89 c2             	mov    rdx,rax
   1855e691b:	4c 89 c1             	mov    rcx,r8
   1855e691e:	e8 fd 53 f6 01       	call   0x18754bd20
   1855e6923:	0f 28 b5 c0 00 00 00 	movaps xmm6,XMMWORD PTR [rbp+0xc0]
   1855e692a:	48 81 c4 50 01 00 00 	add    rsp,0x150
   1855e6931:	5f                   	pop    rdi
   1855e6932:	5e                   	pop    rsi
   1855e6933:	5d                   	pop    rbp
   1855e6934:	c3                   	ret
   1855e6935:	e8 52 78 0f 02       	call   0x1876de18c
   1855e693a:	cc                   	int3
