
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001855f0380 <.text+0x55ef380>:
   1855f0380:	55                   	push   rbp
   1855f0381:	41 57                	push   r15
   1855f0383:	41 56                	push   r14
   1855f0385:	41 55                	push   r13
   1855f0387:	41 54                	push   r12
   1855f0389:	56                   	push   rsi
   1855f038a:	57                   	push   rdi
   1855f038b:	53                   	push   rbx
   1855f038c:	48 81 ec 18 03 00 00 	sub    rsp,0x318
   1855f0393:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   1855f039a:	00 
   1855f039b:	0f 29 b5 80 02 00 00 	movaps XMMWORD PTR [rbp+0x280],xmm6
   1855f03a2:	48 c7 85 78 02 00 00 	mov    QWORD PTR [rbp+0x278],0xfffffffffffffffe
   1855f03a9:	fe ff ff ff 
   1855f03ad:	4c 89 8d 58 02 00 00 	mov    QWORD PTR [rbp+0x258],r9
   1855f03b4:	4c 89 c6             	mov    rsi,r8
   1855f03b7:	48 89 d3             	mov    rbx,rdx
   1855f03ba:	0f 28 35 ef 67 92 03 	movaps xmm6,XMMWORD PTR [rip+0x39267ef]        # 0x188f16bb0
   1855f03c1:	0f 29 b5 00 01 00 00 	movaps XMMWORD PTR [rbp+0x100],xmm6
   1855f03c8:	48 8d bd b0 00 00 00 	lea    rdi,[rbp+0xb0]
   1855f03cf:	48 89 f9             	mov    rcx,rdi
   1855f03d2:	e8 49 6e a5 fa       	call   0x180047220
   1855f03d7:	90                   	nop
   1855f03d8:	48 8b 8d b0 00 00 00 	mov    rcx,QWORD PTR [rbp+0xb0]
   1855f03df:	48 8d 95 10 01 00 00 	lea    rdx,[rbp+0x110]
   1855f03e6:	e8 e5 1f d9 fa       	call   0x1803823d0
   1855f03eb:	90                   	nop
   1855f03ec:	48 8b 8d 10 01 00 00 	mov    rcx,QWORD PTR [rbp+0x110]
   1855f03f3:	48 8d 95 90 01 00 00 	lea    rdx,[rbp+0x190]
   1855f03fa:	e8 e1 49 e8 fa       	call   0x180474de0
   1855f03ff:	90                   	nop
   1855f0400:	48 8b 8d 90 01 00 00 	mov    rcx,QWORD PTR [rbp+0x190]
   1855f0407:	48 8d 95 00 01 00 00 	lea    rdx,[rbp+0x100]
   1855f040e:	49 89 d8             	mov    r8,rbx
   1855f0411:	e8 5a d9 a3 fb       	call   0x18102dd70
   1855f0416:	90                   	nop
   1855f0417:	4c 8b b5 98 01 00 00 	mov    r14,QWORD PTR [rbp+0x198]
   1855f041e:	4d 85 f6             	test   r14,r14
   1855f0421:	74 1f                	je     0x1855f0442
   1855f0423:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1855f0428:	75 18                	jne    0x1855f0442
   1855f042a:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855f042d:	4c 89 f1             	mov    rcx,r14
   1855f0430:	ff 10                	call   QWORD PTR [rax]
   1855f0432:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1855f0437:	75 09                	jne    0x1855f0442
   1855f0439:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855f043c:	4c 89 f1             	mov    rcx,r14
   1855f043f:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855f0442:	4c 8b b5 18 01 00 00 	mov    r14,QWORD PTR [rbp+0x118]
   1855f0449:	4d 85 f6             	test   r14,r14
   1855f044c:	74 1f                	je     0x1855f046d
   1855f044e:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1855f0453:	75 18                	jne    0x1855f046d
   1855f0455:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855f0458:	4c 89 f1             	mov    rcx,r14
   1855f045b:	ff 10                	call   QWORD PTR [rax]
   1855f045d:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1855f0462:	75 09                	jne    0x1855f046d
   1855f0464:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855f0467:	4c 89 f1             	mov    rcx,r14
   1855f046a:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855f046d:	4c 8b b5 b8 00 00 00 	mov    r14,QWORD PTR [rbp+0xb8]
   1855f0474:	4d 85 f6             	test   r14,r14
   1855f0477:	74 1f                	je     0x1855f0498
   1855f0479:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1855f047e:	75 18                	jne    0x1855f0498
   1855f0480:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855f0483:	4c 89 f1             	mov    rcx,r14
   1855f0486:	ff 10                	call   QWORD PTR [rax]
   1855f0488:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1855f048d:	75 09                	jne    0x1855f0498
   1855f048f:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1855f0492:	4c 89 f1             	mov    rcx,r14
   1855f0495:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855f0498:	48 83 bd 00 01 00 00 	cmp    QWORD PTR [rbp+0x100],0x0
   1855f049f:	00 
   1855f04a0:	74 7c                	je     0x1855f051e
   1855f04a2:	0f 29 b5 20 02 00 00 	movaps XMMWORD PTR [rbp+0x220],xmm6
   1855f04a9:	48 8d 8d 20 02 00 00 	lea    rcx,[rbp+0x220]
   1855f04b0:	e8 ab 8c 11 fb       	call   0x180709160
   1855f04b5:	90                   	nop
   1855f04b6:	48 8b 85 20 02 00 00 	mov    rax,QWORD PTR [rbp+0x220]
   1855f04bd:	c7 80 18 01 00 00 01 	mov    DWORD PTR [rax+0x118],0x1
   1855f04c4:	00 00 00 
   1855f04c7:	4c 8d 4b 20          	lea    r9,[rbx+0x20]
   1855f04cb:	4c 8d b0 58 07 00 00 	lea    r14,[rax+0x758]
   1855f04d2:	4d 39 ce             	cmp    r14,r9
   1855f04d5:	74 2b                	je     0x1855f0502
   1855f04d7:	4c 8b 7b 30          	mov    r15,QWORD PTR [rbx+0x30]
   1855f04db:	48 83 7b 38 10       	cmp    QWORD PTR [rbx+0x38],0x10
   1855f04e0:	72 04                	jb     0x1855f04e6
   1855f04e2:	4c 8b 4b 20          	mov    r9,QWORD PTR [rbx+0x20]
   1855f04e6:	48 8b 88 70 07 00 00 	mov    rcx,QWORD PTR [rax+0x770]
   1855f04ed:	49 39 cf             	cmp    r15,rcx
   1855f04f0:	0f 86 c0 02 00 00    	jbe    0x1855f07b6
   1855f04f6:	4c 89 f1             	mov    rcx,r14
   1855f04f9:	4c 89 fa             	mov    rdx,r15
   1855f04fc:	e8 4f dc a4 fa       	call   0x18003e150
   1855f0501:	90                   	nop
   1855f0502:	48 8b 85 20 02 00 00 	mov    rax,QWORD PTR [rbp+0x220]
   1855f0509:	4c 8d b0 b0 00 00 00 	lea    r14,[rax+0xb0]
   1855f0510:	49 39 de             	cmp    r14,rbx
   1855f0513:	0f 85 d3 02 00 00    	jne    0x1855f07ec
   1855f0519:	e9 1c 03 00 00       	jmp    0x1855f083a
   1855f051e:	b9 03 00 00 00       	mov    ecx,0x3
   1855f0523:	e8 b8 c8 a7 fa       	call   0x18006cde0
   1855f0528:	85 c0                	test   eax,eax
   1855f052a:	0f 84 3b 01 00 00    	je     0x1855f066b
   1855f0530:	4c 8d b5 20 02 00 00 	lea    r14,[rbp+0x220]
   1855f0537:	4c 89 f1             	mov    rcx,r14
   1855f053a:	e8 d1 c9 a7 fa       	call   0x18006cf10
   1855f053f:	90                   	nop
   1855f0540:	48 83 bd 38 02 00 00 	cmp    QWORD PTR [rbp+0x238],0x10
   1855f0547:	10 
   1855f0548:	72 07                	jb     0x1855f0551
   1855f054a:	4c 8b b5 20 02 00 00 	mov    r14,QWORD PTR [rbp+0x220]
   1855f0551:	48 8d 05 28 70 41 04 	lea    rax,[rip+0x4417028]        # 0x189a07580
   1855f0558:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855f055d:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855f0564:	00 00 
   1855f0566:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855f056b:	c7 44 24 28 79 00 00 	mov    DWORD PTR [rsp+0x28],0x79
   1855f0572:	00 
   1855f0573:	4c 8d 0d 56 6d 41 04 	lea    r9,[rip+0x4416d56]        # 0x189a072d0
   1855f057a:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855f0581:	ba 03 00 00 00       	mov    edx,0x3
   1855f0586:	4d 89 f0             	mov    r8,r14
   1855f0589:	e8 e2 cc a7 fa       	call   0x18006d270
   1855f058e:	90                   	nop
   1855f058f:	48 83 7b 18 10       	cmp    QWORD PTR [rbx+0x18],0x10
   1855f0594:	72 03                	jb     0x1855f0599
   1855f0596:	48 8b 1b             	mov    rbx,QWORD PTR [rbx]
   1855f0599:	48 89 9d b0 00 00 00 	mov    QWORD PTR [rbp+0xb0],rbx
   1855f05a0:	c6 85 b8 00 00 00 00 	mov    BYTE PTR [rbp+0xb8],0x0
   1855f05a7:	48 83 7e 18 10       	cmp    QWORD PTR [rsi+0x18],0x10
   1855f05ac:	72 03                	jb     0x1855f05b1
   1855f05ae:	48 8b 36             	mov    rsi,QWORD PTR [rsi]
   1855f05b1:	48 89 75 40          	mov    QWORD PTR [rbp+0x40],rsi
   1855f05b5:	c6 45 48 00          	mov    BYTE PTR [rbp+0x48],0x0
   1855f05b9:	0f 57 c0             	xorps  xmm0,xmm0
   1855f05bc:	0f 11 85 80 01 00 00 	movups XMMWORD PTR [rbp+0x180],xmm0
   1855f05c3:	0f 11 85 70 01 00 00 	movups XMMWORD PTR [rbp+0x170],xmm0
   1855f05ca:	0f 11 85 60 01 00 00 	movups XMMWORD PTR [rbp+0x160],xmm0
   1855f05d1:	0f 11 85 50 01 00 00 	movups XMMWORD PTR [rbp+0x150],xmm0
   1855f05d8:	0f 11 85 40 01 00 00 	movups XMMWORD PTR [rbp+0x140],xmm0
   1855f05df:	0f 11 85 30 01 00 00 	movups XMMWORD PTR [rbp+0x130],xmm0
   1855f05e6:	0f 11 85 20 01 00 00 	movups XMMWORD PTR [rbp+0x120],xmm0
   1855f05ed:	48 8d 45 40          	lea    rax,[rbp+0x40]
   1855f05f1:	48 89 85 10 01 00 00 	mov    QWORD PTR [rbp+0x110],rax
   1855f05f8:	48 89 bd 18 01 00 00 	mov    QWORD PTR [rbp+0x118],rdi
   1855f05ff:	48 8d 15 d2 52 41 04 	lea    rdx,[rip+0x44152d2]        # 0x189a058d8
   1855f0606:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855f060d:	4c 8d 85 10 01 00 00 	lea    r8,[rbp+0x110]
   1855f0614:	e8 f7 d1 a7 fa       	call   0x18006d810
   1855f0619:	90                   	nop
   1855f061a:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855f0621:	e8 4a cd a7 fa       	call   0x18006d370
   1855f0626:	48 8b 85 38 02 00 00 	mov    rax,QWORD PTR [rbp+0x238]
   1855f062d:	48 83 f8 10          	cmp    rax,0x10
   1855f0631:	72 38                	jb     0x1855f066b
   1855f0633:	48 8b 8d 20 02 00 00 	mov    rcx,QWORD PTR [rbp+0x220]
   1855f063a:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855f063e:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855f0645:	72 1f                	jb     0x1855f0666
   1855f0647:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855f064b:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855f064f:	4c 29 c1             	sub    rcx,r8
   1855f0652:	48 83 f9 20          	cmp    rcx,0x20
   1855f0656:	0f 83 65 0a 00 00    	jae    0x1855f10c1
   1855f065c:	48 83 c0 28          	add    rax,0x28
   1855f0660:	48 89 c2             	mov    rdx,rax
   1855f0663:	4c 89 c1             	mov    rcx,r8
   1855f0666:	e8 b5 b6 f5 01       	call   0x18754bd20
   1855f066b:	0f 57 c0             	xorps  xmm0,xmm0
   1855f066e:	0f 29 85 20 01 00 00 	movaps XMMWORD PTR [rbp+0x120],xmm0
   1855f0675:	0f 29 85 10 01 00 00 	movaps XMMWORD PTR [rbp+0x110],xmm0
   1855f067c:	b9 20 00 00 00       	mov    ecx,0x20
   1855f0681:	e8 56 b6 f5 01       	call   0x18754bcdc
   1855f0686:	90                   	nop
   1855f0687:	48 89 85 10 01 00 00 	mov    QWORD PTR [rbp+0x110],rax
   1855f068e:	48 c7 85 20 01 00 00 	mov    QWORD PTR [rbp+0x120],0x11
   1855f0695:	11 00 00 00 
   1855f0699:	48 c7 85 28 01 00 00 	mov    QWORD PTR [rbp+0x128],0x1f
   1855f06a0:	1f 00 00 00 
   1855f06a4:	0f 10 05 7d 32 41 04 	movups xmm0,XMMWORD PTR [rip+0x441327d]        # 0x189a03928 ; Contact not found
   1855f06ab:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   1855f06ae:	66 c7 40 10 64 00    	mov    WORD PTR [rax+0x10],0x64
   1855f06b4:	0f 29 b5 b0 01 00 00 	movaps XMMWORD PTR [rbp+0x1b0],xmm6
   1855f06bb:	0f 29 b5 90 01 00 00 	movaps XMMWORD PTR [rbp+0x190],xmm6
   1855f06c2:	0f 29 b5 a0 01 00 00 	movaps XMMWORD PTR [rbp+0x1a0],xmm6
   1855f06c9:	c6 85 b8 01 00 00 00 	mov    BYTE PTR [rbp+0x1b8],0x0
   1855f06d0:	c6 85 90 01 00 00 00 	mov    BYTE PTR [rbp+0x190],0x0
   1855f06d7:	48 8d 8d 98 01 00 00 	lea    rcx,[rbp+0x198]
   1855f06de:	48 8d 95 10 01 00 00 	lea    rdx,[rbp+0x110]
   1855f06e5:	e8 06 49 3a fc       	call   0x181994ff0
   1855f06ea:	90                   	nop
   1855f06eb:	48 8b 85 58 02 00 00 	mov    rax,QWORD PTR [rbp+0x258]
   1855f06f2:	48 8b 08             	mov    rcx,QWORD PTR [rax]
   1855f06f5:	48 89 8d b0 00 00 00 	mov    QWORD PTR [rbp+0xb0],rcx
   1855f06fc:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
   1855f0703:	48 8d 95 90 01 00 00 	lea    rdx,[rbp+0x190]
   1855f070a:	ff 51 08             	call   QWORD PTR [rcx+0x8]
   1855f070d:	90                   	nop
   1855f070e:	48 8d 8d b0 00 00 00 	lea    rcx,[rbp+0xb0]
   1855f0715:	e8 56 c3 b1 fa       	call   0x18010ca70
   1855f071a:	80 bd b8 01 00 00 01 	cmp    BYTE PTR [rbp+0x1b8],0x1
   1855f0721:	75 45                	jne    0x1855f0768
   1855f0723:	48 8b 85 b0 01 00 00 	mov    rax,QWORD PTR [rbp+0x1b0]
   1855f072a:	48 83 f8 10          	cmp    rax,0x10
   1855f072e:	72 38                	jb     0x1855f0768
   1855f0730:	48 8b 8d 98 01 00 00 	mov    rcx,QWORD PTR [rbp+0x198]
   1855f0737:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855f073b:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855f0742:	72 1f                	jb     0x1855f0763
   1855f0744:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855f0748:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855f074c:	4c 29 c1             	sub    rcx,r8
   1855f074f:	48 83 f9 20          	cmp    rcx,0x20
   1855f0753:	0f 83 68 09 00 00    	jae    0x1855f10c1
   1855f0759:	48 83 c0 28          	add    rax,0x28
   1855f075d:	48 89 c2             	mov    rdx,rax
   1855f0760:	4c 89 c1             	mov    rcx,r8
   1855f0763:	e8 b8 b5 f5 01       	call   0x18754bd20
   1855f0768:	48 8b 85 28 01 00 00 	mov    rax,QWORD PTR [rbp+0x128]
   1855f076f:	48 83 f8 10          	cmp    rax,0x10
   1855f0773:	0f 82 f8 08 00 00    	jb     0x1855f1071
   1855f0779:	48 8b 8d 10 01 00 00 	mov    rcx,QWORD PTR [rbp+0x110]
   1855f0780:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855f0784:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855f078b:	72 1f                	jb     0x1855f07ac
   1855f078d:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855f0791:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855f0795:	4c 29 c1             	sub    rcx,r8
   1855f0798:	48 83 f9 20          	cmp    rcx,0x20
   1855f079c:	0f 83 1f 09 00 00    	jae    0x1855f10c1
   1855f07a2:	48 83 c0 28          	add    rax,0x28
   1855f07a6:	48 89 c2             	mov    rdx,rax
   1855f07a9:	4c 89 c1             	mov    rcx,r8
   1855f07ac:	e8 6f b5 f5 01       	call   0x18754bd20
   1855f07b1:	e9 bb 08 00 00       	jmp    0x1855f1071
   1855f07b6:	48 83 f9 10          	cmp    rcx,0x10
   1855f07ba:	72 03                	jb     0x1855f07bf
   1855f07bc:	4d 8b 36             	mov    r14,QWORD PTR [r14]
   1855f07bf:	4c 89 b8 68 07 00 00 	mov    QWORD PTR [rax+0x768],r15
   1855f07c6:	4c 89 f1             	mov    rcx,r14
   1855f07c9:	4c 89 ca             	mov    rdx,r9
   1855f07cc:	4d 89 f8             	mov    r8,r15
   1855f07cf:	e8 6c 46 12 02       	call   0x187714e40
   1855f07d4:	43 c6 04 3e 00       	mov    BYTE PTR [r14+r15*1],0x0
   1855f07d9:	48 8b 85 20 02 00 00 	mov    rax,QWORD PTR [rbp+0x220]
   1855f07e0:	4c 8d b0 b0 00 00 00 	lea    r14,[rax+0xb0]
   1855f07e7:	49 39 de             	cmp    r14,rbx
   1855f07ea:	74 4e                	je     0x1855f083a
   1855f07ec:	4c 8b 7b 10          	mov    r15,QWORD PTR [rbx+0x10]
   1855f07f0:	48 83 7b 18 10       	cmp    QWORD PTR [rbx+0x18],0x10
   1855f07f5:	72 03                	jb     0x1855f07fa
   1855f07f7:	48 8b 1b             	mov    rbx,QWORD PTR [rbx]
   1855f07fa:	48 8b 88 c8 00 00 00 	mov    rcx,QWORD PTR [rax+0xc8]
   1855f0801:	49 39 cf             	cmp    r15,rcx
   1855f0804:	76 11                	jbe    0x1855f0817
   1855f0806:	4c 89 f1             	mov    rcx,r14
   1855f0809:	4c 89 fa             	mov    rdx,r15
   1855f080c:	49 89 d9             	mov    r9,rbx
   1855f080f:	e8 3c d9 a4 fa       	call   0x18003e150
   1855f0814:	90                   	nop
   1855f0815:	eb 23                	jmp    0x1855f083a
   1855f0817:	48 83 f9 10          	cmp    rcx,0x10
   1855f081b:	72 03                	jb     0x1855f0820
   1855f081d:	4d 8b 36             	mov    r14,QWORD PTR [r14]
   1855f0820:	4c 89 b8 c0 00 00 00 	mov    QWORD PTR [rax+0xc0],r15
   1855f0827:	4c 89 f1             	mov    rcx,r14
   1855f082a:	48 89 da             	mov    rdx,rbx
   1855f082d:	4d 89 f8             	mov    r8,r15
   1855f0830:	e8 0b 46 12 02       	call   0x187714e40
   1855f0835:	43 c6 04 3e 00       	mov    BYTE PTR [r14+r15*1],0x0
   1855f083a:	0f 29 b5 40 02 00 00 	movaps XMMWORD PTR [rbp+0x240],xmm6
   1855f0841:	48 8d 8d 10 01 00 00 	lea    rcx,[rbp+0x110]
   1855f0848:	e8 d3 69 a5 fa       	call   0x180047220
   1855f084d:	90                   	nop
   1855f084e:	48 8b 8d 10 01 00 00 	mov    rcx,QWORD PTR [rbp+0x110]
   1855f0855:	48 8d 95 90 01 00 00 	lea    rdx,[rbp+0x190]
   1855f085c:	e8 6f 1b d9 fa       	call   0x1803823d0
   1855f0861:	90                   	nop
   1855f0862:	48 8b 8d 90 01 00 00 	mov    rcx,QWORD PTR [rbp+0x190]
   1855f0869:	48 8d 95 40 02 00 00 	lea    rdx,[rbp+0x240]
   1855f0870:	e8 0b 8a 11 fb       	call   0x180709280
   1855f0875:	90                   	nop
   1855f0876:	48 8b 9d 98 01 00 00 	mov    rbx,QWORD PTR [rbp+0x198]
   1855f087d:	48 85 db             	test   rbx,rbx
   1855f0880:	74 1d                	je     0x1855f089f
   1855f0882:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   1855f0886:	75 17                	jne    0x1855f089f
   1855f0888:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   1855f088b:	48 89 d9             	mov    rcx,rbx
   1855f088e:	ff 10                	call   QWORD PTR [rax]
   1855f0890:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   1855f0894:	75 09                	jne    0x1855f089f
   1855f0896:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   1855f0899:	48 89 d9             	mov    rcx,rbx
   1855f089c:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855f089f:	48 8b 9d 18 01 00 00 	mov    rbx,QWORD PTR [rbp+0x118]
   1855f08a6:	48 85 db             	test   rbx,rbx
   1855f08a9:	74 1d                	je     0x1855f08c8
   1855f08ab:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   1855f08af:	75 17                	jne    0x1855f08c8
   1855f08b1:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   1855f08b4:	48 89 d9             	mov    rcx,rbx
   1855f08b7:	ff 10                	call   QWORD PTR [rax]
   1855f08b9:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   1855f08bd:	75 09                	jne    0x1855f08c8
   1855f08bf:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   1855f08c2:	48 89 d9             	mov    rcx,rbx
   1855f08c5:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855f08c8:	48 83 bd 40 02 00 00 	cmp    QWORD PTR [rbp+0x240],0x0
   1855f08cf:	00 
   1855f08d0:	0f 84 ef 01 00 00    	je     0x1855f0ac5
   1855f08d6:	b9 20 00 00 00       	mov    ecx,0x20
   1855f08db:	e8 fc b3 f5 01       	call   0x18754bcdc
   1855f08e0:	90                   	nop
   1855f08e1:	48 b9 01 00 00 00 01 	movabs rcx,0x100000001
   1855f08e8:	00 00 00 
   1855f08eb:	48 89 48 08          	mov    QWORD PTR [rax+0x8],rcx
   1855f08ef:	48 8d 0d 12 67 41 04 	lea    rcx,[rip+0x4416712]        # 0x189a07008
   1855f08f6:	48 89 08             	mov    QWORD PTR [rax],rcx
   1855f08f9:	0f 57 c0             	xorps  xmm0,xmm0
   1855f08fc:	0f 11 40 10          	movups XMMWORD PTR [rax+0x10],xmm0
   1855f0900:	48 89 85 68 02 00 00 	mov    QWORD PTR [rbp+0x268],rax
   1855f0907:	48 8d 48 18          	lea    rcx,[rax+0x18]
   1855f090b:	48 8b 95 58 02 00 00 	mov    rdx,QWORD PTR [rbp+0x258]
   1855f0912:	e8 59 c0 b1 fa       	call   0x18010c970
   1855f0917:	90                   	nop
   1855f0918:	48 8d 8d b0 00 00 00 	lea    rcx,[rbp+0xb0]
   1855f091f:	e8 fc 68 a5 fa       	call   0x180047220
   1855f0924:	90                   	nop
   1855f0925:	48 8b 8d b0 00 00 00 	mov    rcx,QWORD PTR [rbp+0xb0]
   1855f092c:	48 8d 95 10 01 00 00 	lea    rdx,[rbp+0x110]
   1855f0933:	e8 98 1a d9 fa       	call   0x1803823d0
   1855f0938:	90                   	nop
   1855f0939:	48 8b 8d 10 01 00 00 	mov    rcx,QWORD PTR [rbp+0x110]
   1855f0940:	48 8d 95 90 01 00 00 	lea    rdx,[rbp+0x190]
   1855f0947:	e8 b4 6a 8c fb       	call   0x180eb7400
   1855f094c:	90                   	nop
   1855f094d:	48 8b 95 68 02 00 00 	mov    rdx,QWORD PTR [rbp+0x268]
   1855f0954:	4c 8d 7a 08          	lea    r15,[rdx+0x8]
   1855f0958:	4c 8d 62 10          	lea    r12,[rdx+0x10]
   1855f095c:	48 8b 8d 90 01 00 00 	mov    rcx,QWORD PTR [rbp+0x190]
   1855f0963:	48 85 d2             	test   rdx,rdx
   1855f0966:	74 04                	je     0x1855f096c
   1855f0968:	f0 41 ff 07          	lock inc DWORD PTR [r15]
   1855f096c:	48 8d 05 25 67 41 04 	lea    rax,[rip+0x4416725]        # 0x189a07098
   1855f0973:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
   1855f0977:	4c 89 65 c8          	mov    QWORD PTR [rbp-0x38],r12
   1855f097b:	48 89 55 d0          	mov    QWORD PTR [rbp-0x30],rdx
   1855f097f:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   1855f0983:	48 89 55 f8          	mov    QWORD PTR [rbp-0x8],rdx
   1855f0987:	e8 54 32 85 fd       	call   0x182e43be0
   1855f098c:	90                   	nop
   1855f098d:	48 8b bd 98 01 00 00 	mov    rdi,QWORD PTR [rbp+0x198]
   1855f0994:	48 85 ff             	test   rdi,rdi
   1855f0997:	74 1d                	je     0x1855f09b6
   1855f0999:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1855f099d:	75 17                	jne    0x1855f09b6
   1855f099f:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855f09a2:	48 89 f9             	mov    rcx,rdi
   1855f09a5:	ff 10                	call   QWORD PTR [rax]
   1855f09a7:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1855f09ab:	75 09                	jne    0x1855f09b6
   1855f09ad:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855f09b0:	48 89 f9             	mov    rcx,rdi
   1855f09b3:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855f09b6:	48 8b bd 18 01 00 00 	mov    rdi,QWORD PTR [rbp+0x118]
   1855f09bd:	48 85 ff             	test   rdi,rdi
   1855f09c0:	74 1d                	je     0x1855f09df
   1855f09c2:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1855f09c6:	75 17                	jne    0x1855f09df
   1855f09c8:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855f09cb:	48 89 f9             	mov    rcx,rdi
   1855f09ce:	ff 10                	call   QWORD PTR [rax]
   1855f09d0:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1855f09d4:	75 09                	jne    0x1855f09df
   1855f09d6:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855f09d9:	48 89 f9             	mov    rcx,rdi
   1855f09dc:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855f09df:	48 8b bd b8 00 00 00 	mov    rdi,QWORD PTR [rbp+0xb8]
   1855f09e6:	48 85 ff             	test   rdi,rdi
   1855f09e9:	74 1e                	je     0x1855f0a09
   1855f09eb:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1855f09ef:	75 18                	jne    0x1855f0a09
   1855f09f1:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855f09f4:	48 89 f9             	mov    rcx,rdi
   1855f09f7:	ff 10                	call   QWORD PTR [rax]
   1855f09f9:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1855f09fd:	75 0a                	jne    0x1855f0a09
   1855f09ff:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855f0a02:	48 89 f9             	mov    rcx,rdi
   1855f0a05:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855f0a08:	90                   	nop
   1855f0a09:	e8 02 53 a5 fa       	call   0x180045d10
   1855f0a0e:	90                   	nop
   1855f0a0f:	48 8d 95 b0 00 00 00 	lea    rdx,[rbp+0xb0]
   1855f0a16:	48 89 c1             	mov    rcx,rax
   1855f0a19:	e8 f2 68 a5 fa       	call   0x180047310
   1855f0a1e:	90                   	nop
   1855f0a1f:	48 8b bd b0 00 00 00 	mov    rdi,QWORD PTR [rbp+0xb0]
   1855f0a26:	48 8b 85 68 02 00 00 	mov    rax,QWORD PTR [rbp+0x268]
   1855f0a2d:	48 85 c0             	test   rax,rax
   1855f0a30:	74 04                	je     0x1855f0a36
   1855f0a32:	f0 41 ff 07          	lock inc DWORD PTR [r15]
   1855f0a36:	4c 89 a5 90 01 00 00 	mov    QWORD PTR [rbp+0x190],r12
   1855f0a3d:	48 89 85 98 01 00 00 	mov    QWORD PTR [rbp+0x198],rax
   1855f0a44:	0f 57 c0             	xorps  xmm0,xmm0
   1855f0a47:	0f 11 85 a0 01 00 00 	movups XMMWORD PTR [rbp+0x1a0],xmm0
   1855f0a4e:	0f 11 85 b0 01 00 00 	movups XMMWORD PTR [rbp+0x1b0],xmm0
   1855f0a55:	48 8b 5e 10          	mov    rbx,QWORD PTR [rsi+0x10]
   1855f0a59:	48 83 7e 18 10       	cmp    QWORD PTR [rsi+0x18],0x10
   1855f0a5e:	72 03                	jb     0x1855f0a63
   1855f0a60:	48 8b 36             	mov    rsi,QWORD PTR [rsi]
   1855f0a63:	48 85 db             	test   rbx,rbx
   1855f0a66:	0f 88 5b 06 00 00    	js     0x1855f10c7
   1855f0a6c:	48 8d 85 a0 01 00 00 	lea    rax,[rbp+0x1a0]
   1855f0a73:	48 83 fb 0f          	cmp    rbx,0xf
   1855f0a77:	0f 86 e1 02 00 00    	jbe    0x1855f0d5e
   1855f0a7d:	48 89 d8             	mov    rax,rbx
   1855f0a80:	48 83 c8 0f          	or     rax,0xf
   1855f0a84:	48 83 f8 17          	cmp    rax,0x17
   1855f0a88:	41 be 16 00 00 00    	mov    r14d,0x16
   1855f0a8e:	4c 0f 43 f0          	cmovae r14,rax
   1855f0a92:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   1855f0a98:	0f 82 f1 02 00 00    	jb     0x1855f0d8f
   1855f0a9e:	49 8d 4e 28          	lea    rcx,[r14+0x28]
   1855f0aa2:	e8 35 b2 f5 01       	call   0x18754bcdc
   1855f0aa7:	90                   	nop
   1855f0aa8:	48 85 c0             	test   rax,rax
   1855f0aab:	0f 84 10 06 00 00    	je     0x1855f10c1
   1855f0ab1:	48 89 c1             	mov    rcx,rax
   1855f0ab4:	48 83 c0 27          	add    rax,0x27
   1855f0ab8:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
   1855f0abc:	48 89 48 f8          	mov    QWORD PTR [rax-0x8],rcx
   1855f0ac0:	e9 d4 02 00 00       	jmp    0x1855f0d99
   1855f0ac5:	b9 04 00 00 00       	mov    ecx,0x4
   1855f0aca:	e8 11 c3 a7 fa       	call   0x18006cde0
   1855f0acf:	85 c0                	test   eax,eax
   1855f0ad1:	0f 84 1a 01 00 00    	je     0x1855f0bf1
   1855f0ad7:	48 8d 5d 40          	lea    rbx,[rbp+0x40]
   1855f0adb:	48 89 d9             	mov    rcx,rbx
   1855f0ade:	e8 2d c4 a7 fa       	call   0x18006cf10
   1855f0ae3:	90                   	nop
   1855f0ae4:	48 83 7d 58 10       	cmp    QWORD PTR [rbp+0x58],0x10
   1855f0ae9:	72 04                	jb     0x1855f0aef
   1855f0aeb:	48 8b 5d 40          	mov    rbx,QWORD PTR [rbp+0x40]
   1855f0aef:	48 8d 05 8a 6a 41 04 	lea    rax,[rip+0x4416a8a]        # 0x189a07580
   1855f0af6:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1855f0afb:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1855f0b02:	00 00 
   1855f0b04:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1855f0b09:	c7 44 24 28 87 00 00 	mov    DWORD PTR [rsp+0x28],0x87
   1855f0b10:	00 
   1855f0b11:	4c 8d 0d b8 67 41 04 	lea    r9,[rip+0x44167b8]        # 0x189a072d0
   1855f0b18:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855f0b1f:	ba 04 00 00 00       	mov    edx,0x4
   1855f0b24:	49 89 d8             	mov    r8,rbx
   1855f0b27:	e8 44 c7 a7 fa       	call   0x18006d270
   1855f0b2c:	90                   	nop
   1855f0b2d:	48 83 7e 18 10       	cmp    QWORD PTR [rsi+0x18],0x10
   1855f0b32:	72 03                	jb     0x1855f0b37
   1855f0b34:	48 8b 36             	mov    rsi,QWORD PTR [rsi]
   1855f0b37:	48 89 b5 b0 00 00 00 	mov    QWORD PTR [rbp+0xb0],rsi
   1855f0b3e:	c6 85 b8 00 00 00 00 	mov    BYTE PTR [rbp+0xb8],0x0
   1855f0b45:	0f 57 c0             	xorps  xmm0,xmm0
   1855f0b48:	0f 11 85 78 01 00 00 	movups XMMWORD PTR [rbp+0x178],xmm0
   1855f0b4f:	0f 11 85 68 01 00 00 	movups XMMWORD PTR [rbp+0x168],xmm0
   1855f0b56:	0f 11 85 58 01 00 00 	movups XMMWORD PTR [rbp+0x158],xmm0
   1855f0b5d:	0f 11 85 48 01 00 00 	movups XMMWORD PTR [rbp+0x148],xmm0
   1855f0b64:	0f 11 85 38 01 00 00 	movups XMMWORD PTR [rbp+0x138],xmm0
   1855f0b6b:	0f 11 85 28 01 00 00 	movups XMMWORD PTR [rbp+0x128],xmm0
   1855f0b72:	0f 11 85 18 01 00 00 	movups XMMWORD PTR [rbp+0x118],xmm0
   1855f0b79:	48 c7 85 88 01 00 00 	mov    QWORD PTR [rbp+0x188],0x0
   1855f0b80:	00 00 00 00 
   1855f0b84:	48 89 bd 10 01 00 00 	mov    QWORD PTR [rbp+0x110],rdi
   1855f0b8b:	48 8d 15 be 03 41 04 	lea    rdx,[rip+0x44103be]        # 0x189a00f50
   1855f0b92:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855f0b99:	4c 8d 85 10 01 00 00 	lea    r8,[rbp+0x110]
   1855f0ba0:	e8 6b cc a7 fa       	call   0x18006d810
   1855f0ba5:	90                   	nop
   1855f0ba6:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855f0bad:	e8 be c7 a7 fa       	call   0x18006d370
   1855f0bb2:	48 8b 45 58          	mov    rax,QWORD PTR [rbp+0x58]
   1855f0bb6:	48 83 f8 10          	cmp    rax,0x10
   1855f0bba:	72 35                	jb     0x1855f0bf1
   1855f0bbc:	48 8b 4d 40          	mov    rcx,QWORD PTR [rbp+0x40]
   1855f0bc0:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855f0bc4:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855f0bcb:	72 1f                	jb     0x1855f0bec
   1855f0bcd:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855f0bd1:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855f0bd5:	4c 29 c1             	sub    rcx,r8
   1855f0bd8:	48 83 f9 20          	cmp    rcx,0x20
   1855f0bdc:	0f 83 df 04 00 00    	jae    0x1855f10c1
   1855f0be2:	48 83 c0 28          	add    rax,0x28
   1855f0be6:	48 89 c2             	mov    rdx,rax
   1855f0be9:	4c 89 c1             	mov    rcx,r8
   1855f0bec:	e8 2f b1 f5 01       	call   0x18754bd20
   1855f0bf1:	0f 57 c0             	xorps  xmm0,xmm0
   1855f0bf4:	0f 29 85 20 01 00 00 	movaps XMMWORD PTR [rbp+0x120],xmm0
   1855f0bfb:	0f 29 85 10 01 00 00 	movaps XMMWORD PTR [rbp+0x110],xmm0
   1855f0c02:	b9 40 00 00 00       	mov    ecx,0x40
   1855f0c07:	e8 d0 b0 f5 01       	call   0x18754bcdc
   1855f0c0c:	90                   	nop
   1855f0c0d:	48 89 85 10 01 00 00 	mov    QWORD PTR [rbp+0x110],rax
   1855f0c14:	48 c7 85 20 01 00 00 	mov    QWORD PTR [rbp+0x120],0x37
   1855f0c1b:	37 00 00 00 
   1855f0c1f:	48 c7 85 28 01 00 00 	mov    QWORD PTR [rbp+0x128],0x3f
   1855f0c26:	3f 00 00 00 
   1855f0c2a:	0f 10 05 b7 63 41 04 	movups xmm0,XMMWORD PTR [rip+0x44163b7]        # 0x189a06fe8 ; eManager is unavailable
   1855f0c31:	0f 11 40 20          	movups XMMWORD PTR [rax+0x20],xmm0
   1855f0c35:	0f 10 05 9c 63 41 04 	movups xmm0,XMMWORD PTR [rip+0x441639c]        # 0x189a06fd8 ; e_failed: MessageManager is unavailable
   1855f0c3c:	0f 11 40 10          	movups XMMWORD PTR [rax+0x10],xmm0
   1855f0c40:	0f 10 05 81 63 41 04 	movups xmm0,XMMWORD PTR [rip+0x4416381]        # 0x189a06fc8 ; send_text_message_failed: MessageManager is unavailable
   1855f0c47:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   1855f0c4a:	48 b9 76 61 69 6c 61 	movabs rcx,0x656c62616c696176
   1855f0c51:	62 6c 65 
   1855f0c54:	48 89 48 2f          	mov    QWORD PTR [rax+0x2f],rcx
   1855f0c58:	c6 40 37 00          	mov    BYTE PTR [rax+0x37],0x0
   1855f0c5c:	0f 29 b5 b0 01 00 00 	movaps XMMWORD PTR [rbp+0x1b0],xmm6
   1855f0c63:	0f 29 b5 90 01 00 00 	movaps XMMWORD PTR [rbp+0x190],xmm6
   1855f0c6a:	0f 29 b5 a0 01 00 00 	movaps XMMWORD PTR [rbp+0x1a0],xmm6
   1855f0c71:	c6 85 b8 01 00 00 00 	mov    BYTE PTR [rbp+0x1b8],0x0
   1855f0c78:	c6 85 90 01 00 00 00 	mov    BYTE PTR [rbp+0x190],0x0
   1855f0c7f:	48 8d 8d 98 01 00 00 	lea    rcx,[rbp+0x198]
   1855f0c86:	48 8d 95 10 01 00 00 	lea    rdx,[rbp+0x110]
   1855f0c8d:	e8 5e 43 3a fc       	call   0x181994ff0
   1855f0c92:	90                   	nop
   1855f0c93:	48 8b 85 58 02 00 00 	mov    rax,QWORD PTR [rbp+0x258]
   1855f0c9a:	48 8b 08             	mov    rcx,QWORD PTR [rax]
   1855f0c9d:	48 89 8d b0 00 00 00 	mov    QWORD PTR [rbp+0xb0],rcx
   1855f0ca4:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
   1855f0cab:	48 8d 95 90 01 00 00 	lea    rdx,[rbp+0x190]
   1855f0cb2:	ff 51 08             	call   QWORD PTR [rcx+0x8]
   1855f0cb5:	90                   	nop
   1855f0cb6:	48 8d 8d b0 00 00 00 	lea    rcx,[rbp+0xb0]
   1855f0cbd:	e8 ae bd b1 fa       	call   0x18010ca70
   1855f0cc2:	80 bd b8 01 00 00 01 	cmp    BYTE PTR [rbp+0x1b8],0x1
   1855f0cc9:	75 45                	jne    0x1855f0d10
   1855f0ccb:	48 8b 85 b0 01 00 00 	mov    rax,QWORD PTR [rbp+0x1b0]
   1855f0cd2:	48 83 f8 10          	cmp    rax,0x10
   1855f0cd6:	72 38                	jb     0x1855f0d10
   1855f0cd8:	48 8b 8d 98 01 00 00 	mov    rcx,QWORD PTR [rbp+0x198]
   1855f0cdf:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855f0ce3:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855f0cea:	72 1f                	jb     0x1855f0d0b
   1855f0cec:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855f0cf0:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855f0cf4:	4c 29 c1             	sub    rcx,r8
   1855f0cf7:	48 83 f9 20          	cmp    rcx,0x20
   1855f0cfb:	0f 83 c0 03 00 00    	jae    0x1855f10c1
   1855f0d01:	48 83 c0 28          	add    rax,0x28
   1855f0d05:	48 89 c2             	mov    rdx,rax
   1855f0d08:	4c 89 c1             	mov    rcx,r8
   1855f0d0b:	e8 10 b0 f5 01       	call   0x18754bd20
   1855f0d10:	48 8b 85 28 01 00 00 	mov    rax,QWORD PTR [rbp+0x128]
   1855f0d17:	48 83 f8 10          	cmp    rax,0x10
   1855f0d1b:	0f 82 fe 02 00 00    	jb     0x1855f101f
   1855f0d21:	48 8b 8d 10 01 00 00 	mov    rcx,QWORD PTR [rbp+0x110]
   1855f0d28:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1855f0d2c:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1855f0d33:	72 1f                	jb     0x1855f0d54
   1855f0d35:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1855f0d39:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1855f0d3d:	4c 29 c1             	sub    rcx,r8
   1855f0d40:	48 83 f9 20          	cmp    rcx,0x20
   1855f0d44:	0f 83 77 03 00 00    	jae    0x1855f10c1
   1855f0d4a:	48 83 c0 28          	add    rax,0x28
   1855f0d4e:	48 89 c2             	mov    rdx,rax
   1855f0d51:	4c 89 c1             	mov    rcx,r8
   1855f0d54:	e8 c7 af f5 01       	call   0x18754bd20
   1855f0d59:	e9 c1 02 00 00       	jmp    0x1855f101f
   1855f0d5e:	48 89 9d b0 01 00 00 	mov    QWORD PTR [rbp+0x1b0],rbx
   1855f0d65:	48 c7 85 b8 01 00 00 	mov    QWORD PTR [rbp+0x1b8],0xf
   1855f0d6c:	0f 00 00 00 
   1855f0d70:	0f 10 06             	movups xmm0,XMMWORD PTR [rsi]
   1855f0d73:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   1855f0d76:	48 8b 85 28 02 00 00 	mov    rax,QWORD PTR [rbp+0x228]
   1855f0d7d:	48 85 c0             	test   rax,rax
   1855f0d80:	74 47                	je     0x1855f0dc9
   1855f0d82:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1855f0d86:	4c 8b ad 28 02 00 00 	mov    r13,QWORD PTR [rbp+0x228]
   1855f0d8d:	eb 3d                	jmp    0x1855f0dcc
   1855f0d8f:	49 8d 4e 01          	lea    rcx,[r14+0x1]
   1855f0d93:	e8 44 af f5 01       	call   0x18754bcdc
   1855f0d98:	90                   	nop
   1855f0d99:	48 89 85 a0 01 00 00 	mov    QWORD PTR [rbp+0x1a0],rax
   1855f0da0:	48 89 9d b0 01 00 00 	mov    QWORD PTR [rbp+0x1b0],rbx
   1855f0da7:	4c 89 b5 b8 01 00 00 	mov    QWORD PTR [rbp+0x1b8],r14
   1855f0dae:	4c 8d 43 01          	lea    r8,[rbx+0x1]
   1855f0db2:	48 89 c1             	mov    rcx,rax
   1855f0db5:	48 89 f2             	mov    rdx,rsi
   1855f0db8:	e8 83 40 12 02       	call   0x187714e40
   1855f0dbd:	48 8b 85 28 02 00 00 	mov    rax,QWORD PTR [rbp+0x228]
   1855f0dc4:	48 85 c0             	test   rax,rax
   1855f0dc7:	75 b9                	jne    0x1855f0d82
   1855f0dc9:	45 31 ed             	xor    r13d,r13d
   1855f0dcc:	4c 89 e6             	mov    rsi,r12
   1855f0dcf:	4c 8b b5 20 02 00 00 	mov    r14,QWORD PTR [rbp+0x220]
   1855f0dd6:	4c 89 b5 c0 01 00 00 	mov    QWORD PTR [rbp+0x1c0],r14
   1855f0ddd:	4c 89 ad c8 01 00 00 	mov    QWORD PTR [rbp+0x1c8],r13
   1855f0de4:	48 8b 85 48 02 00 00 	mov    rax,QWORD PTR [rbp+0x248]
   1855f0deb:	48 85 c0             	test   rax,rax
   1855f0dee:	4c 89 bd a0 00 00 00 	mov    QWORD PTR [rbp+0xa0],r15
   1855f0df5:	74 0d                	je     0x1855f0e04
   1855f0df7:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1855f0dfb:	4c 8b a5 48 02 00 00 	mov    r12,QWORD PTR [rbp+0x248]
   1855f0e02:	eb 03                	jmp    0x1855f0e07
   1855f0e04:	45 31 e4             	xor    r12d,r12d
   1855f0e07:	4c 8b bd 40 02 00 00 	mov    r15,QWORD PTR [rbp+0x240]
   1855f0e0e:	4c 89 bd d0 01 00 00 	mov    QWORD PTR [rbp+0x1d0],r15
   1855f0e15:	4c 89 a5 d8 01 00 00 	mov    QWORD PTR [rbp+0x1d8],r12
   1855f0e1c:	48 c7 45 38 00 00 00 	mov    QWORD PTR [rbp+0x38],0x0
   1855f0e23:	00 
   1855f0e24:	b9 58 00 00 00       	mov    ecx,0x58
   1855f0e29:	e8 ae ae f5 01       	call   0x18754bcdc
   1855f0e2e:	90                   	nop
   1855f0e2f:	48 89 c2             	mov    rdx,rax
   1855f0e32:	48 8d 05 4f 63 41 04 	lea    rax,[rip+0x441634f]        # 0x189a07188
   1855f0e39:	48 89 02             	mov    QWORD PTR [rdx],rax
   1855f0e3c:	48 89 72 08          	mov    QWORD PTR [rdx+0x8],rsi
   1855f0e40:	48 8b 85 68 02 00 00 	mov    rax,QWORD PTR [rbp+0x268]
   1855f0e47:	48 89 42 10          	mov    QWORD PTR [rdx+0x10],rax
   1855f0e4b:	0f 57 c0             	xorps  xmm0,xmm0
   1855f0e4e:	0f 29 85 90 01 00 00 	movaps XMMWORD PTR [rbp+0x190],xmm0
   1855f0e55:	0f 11 42 28          	movups XMMWORD PTR [rdx+0x28],xmm0
   1855f0e59:	0f 11 42 18          	movups XMMWORD PTR [rdx+0x18],xmm0
   1855f0e5d:	48 83 fb 0f          	cmp    rbx,0xf
   1855f0e61:	76 55                	jbe    0x1855f0eb8
   1855f0e63:	48 89 95 60 02 00 00 	mov    QWORD PTR [rbp+0x260],rdx
   1855f0e6a:	48 89 bd a8 00 00 00 	mov    QWORD PTR [rbp+0xa8],rdi
   1855f0e71:	48 8b b5 a0 01 00 00 	mov    rsi,QWORD PTR [rbp+0x1a0]
   1855f0e78:	48 89 d8             	mov    rax,rbx
   1855f0e7b:	48 83 c8 0f          	or     rax,0xf
   1855f0e7f:	48 83 f8 17          	cmp    rax,0x17
   1855f0e83:	bf 16 00 00 00       	mov    edi,0x16
   1855f0e88:	48 0f 43 f8          	cmovae rdi,rax
   1855f0e8c:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   1855f0e92:	72 46                	jb     0x1855f0eda
   1855f0e94:	48 8d 4f 28          	lea    rcx,[rdi+0x28]
   1855f0e98:	e8 3f ae f5 01       	call   0x18754bcdc
   1855f0e9d:	90                   	nop
   1855f0e9e:	48 85 c0             	test   rax,rax
   1855f0ea1:	0f 84 1a 02 00 00    	je     0x1855f10c1
   1855f0ea7:	48 89 c1             	mov    rcx,rax
   1855f0eaa:	48 83 c0 27          	add    rax,0x27
   1855f0eae:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
   1855f0eb2:	48 89 48 f8          	mov    QWORD PTR [rax-0x8],rcx
   1855f0eb6:	eb 2c                	jmp    0x1855f0ee4
   1855f0eb8:	48 89 d0             	mov    rax,rdx
   1855f0ebb:	48 83 c0 18          	add    rax,0x18
   1855f0ebf:	48 89 5a 28          	mov    QWORD PTR [rdx+0x28],rbx
   1855f0ec3:	48 c7 42 30 0f 00 00 	mov    QWORD PTR [rdx+0x30],0xf
   1855f0eca:	00 
   1855f0ecb:	48 8d 8d a0 01 00 00 	lea    rcx,[rbp+0x1a0]
   1855f0ed2:	0f 10 01             	movups xmm0,XMMWORD PTR [rcx]
   1855f0ed5:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   1855f0ed8:	eb 3c                	jmp    0x1855f0f16
   1855f0eda:	48 8d 4f 01          	lea    rcx,[rdi+0x1]
   1855f0ede:	e8 f9 ad f5 01       	call   0x18754bcdc
   1855f0ee3:	90                   	nop
   1855f0ee4:	48 8b 8d 60 02 00 00 	mov    rcx,QWORD PTR [rbp+0x260]
   1855f0eeb:	48 89 41 18          	mov    QWORD PTR [rcx+0x18],rax
   1855f0eef:	48 89 59 28          	mov    QWORD PTR [rcx+0x28],rbx
   1855f0ef3:	48 89 79 30          	mov    QWORD PTR [rcx+0x30],rdi
   1855f0ef7:	48 ff c3             	inc    rbx
   1855f0efa:	48 89 c1             	mov    rcx,rax
   1855f0efd:	48 89 f2             	mov    rdx,rsi
   1855f0f00:	49 89 d8             	mov    r8,rbx
   1855f0f03:	e8 38 3f 12 02       	call   0x187714e40
   1855f0f08:	48 8b 95 60 02 00 00 	mov    rdx,QWORD PTR [rbp+0x260]
   1855f0f0f:	48 8b bd a8 00 00 00 	mov    rdi,QWORD PTR [rbp+0xa8]
   1855f0f16:	48 8d 85 c0 01 00 00 	lea    rax,[rbp+0x1c0]
   1855f0f1d:	4c 89 72 38          	mov    QWORD PTR [rdx+0x38],r14
   1855f0f21:	4c 89 6a 40          	mov    QWORD PTR [rdx+0x40],r13
   1855f0f25:	0f 57 c0             	xorps  xmm0,xmm0
   1855f0f28:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   1855f0f2b:	4c 89 7a 48          	mov    QWORD PTR [rdx+0x48],r15
   1855f0f2f:	4c 89 62 50          	mov    QWORD PTR [rdx+0x50],r12
   1855f0f33:	0f 11 40 10          	movups XMMWORD PTR [rax+0x10],xmm0
   1855f0f37:	48 89 55 38          	mov    QWORD PTR [rbp+0x38],rdx
   1855f0f3b:	c6 85 77 02 00 00 01 	mov    BYTE PTR [rbp+0x277],0x1
   1855f0f42:	48 8d 15 67 78 40 04 	lea    rdx,[rip+0x4407867]        # 0x1899f87b0
   1855f0f49:	4c 8d 05 80 63 41 04 	lea    r8,[rip+0x4416380]        # 0x189a072d0
   1855f0f50:	48 8d 8d 10 01 00 00 	lea    rcx,[rbp+0x110]
   1855f0f57:	41 b9 95 00 00 00    	mov    r9d,0x95
   1855f0f5d:	e8 8e 0c bb fa       	call   0x1801a1bf0
   1855f0f62:	90                   	nop
   1855f0f63:	c6 85 77 02 00 00 00 	mov    BYTE PTR [rbp+0x277],0x0
   1855f0f6a:	c7 44 24 20 01 00 00 	mov    DWORD PTR [rsp+0x20],0x1
   1855f0f71:	00 
   1855f0f72:	48 8d 95 90 00 00 00 	lea    rdx,[rbp+0x90]
   1855f0f79:	4c 8d 85 10 01 00 00 	lea    r8,[rbp+0x110]
   1855f0f80:	49 89 e9             	mov    r9,rbp
   1855f0f83:	48 89 f9             	mov    rcx,rdi
   1855f0f86:	e8 c5 e4 d1 fa       	call   0x18030f450
   1855f0f8b:	90                   	nop
   1855f0f8c:	48 8b b5 98 00 00 00 	mov    rsi,QWORD PTR [rbp+0x98]
   1855f0f93:	48 85 f6             	test   rsi,rsi
   1855f0f96:	48 8b 9d a0 00 00 00 	mov    rbx,QWORD PTR [rbp+0xa0]
   1855f0f9d:	74 1d                	je     0x1855f0fbc
   1855f0f9f:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855f0fa3:	75 17                	jne    0x1855f0fbc
   1855f0fa5:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855f0fa8:	48 89 f1             	mov    rcx,rsi
   1855f0fab:	ff 10                	call   QWORD PTR [rax]
   1855f0fad:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855f0fb1:	75 09                	jne    0x1855f0fbc
   1855f0fb3:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855f0fb6:	48 89 f1             	mov    rcx,rsi
   1855f0fb9:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855f0fbc:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855f0fc3:	e8 88 0a 00 00       	call   0x1855f1a50
   1855f0fc8:	48 8b b5 b8 00 00 00 	mov    rsi,QWORD PTR [rbp+0xb8]
   1855f0fcf:	48 85 f6             	test   rsi,rsi
   1855f0fd2:	48 8b bd 68 02 00 00 	mov    rdi,QWORD PTR [rbp+0x268]
   1855f0fd9:	74 1d                	je     0x1855f0ff8
   1855f0fdb:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855f0fdf:	75 17                	jne    0x1855f0ff8
   1855f0fe1:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855f0fe4:	48 89 f1             	mov    rcx,rsi
   1855f0fe7:	ff 10                	call   QWORD PTR [rax]
   1855f0fe9:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855f0fed:	75 09                	jne    0x1855f0ff8
   1855f0fef:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855f0ff2:	48 89 f1             	mov    rcx,rsi
   1855f0ff5:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855f0ff8:	48 85 ff             	test   rdi,rdi
   1855f0ffb:	74 22                	je     0x1855f101f
   1855f0ffd:	f0 ff 0b             	lock dec DWORD PTR [rbx]
   1855f1000:	75 1d                	jne    0x1855f101f
   1855f1002:	48 89 fe             	mov    rsi,rdi
   1855f1005:	48 83 c6 0c          	add    rsi,0xc
   1855f1009:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855f100c:	48 89 f9             	mov    rcx,rdi
   1855f100f:	ff 10                	call   QWORD PTR [rax]
   1855f1011:	f0 ff 0e             	lock dec DWORD PTR [rsi]
   1855f1014:	75 09                	jne    0x1855f101f
   1855f1016:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1855f1019:	48 89 f9             	mov    rcx,rdi
   1855f101c:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855f101f:	48 8b b5 48 02 00 00 	mov    rsi,QWORD PTR [rbp+0x248]
   1855f1026:	48 85 f6             	test   rsi,rsi
   1855f1029:	74 1d                	je     0x1855f1048
   1855f102b:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855f102f:	75 17                	jne    0x1855f1048
   1855f1031:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855f1034:	48 89 f1             	mov    rcx,rsi
   1855f1037:	ff 10                	call   QWORD PTR [rax]
   1855f1039:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855f103d:	75 09                	jne    0x1855f1048
   1855f103f:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855f1042:	48 89 f1             	mov    rcx,rsi
   1855f1045:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855f1048:	48 8b b5 28 02 00 00 	mov    rsi,QWORD PTR [rbp+0x228]
   1855f104f:	48 85 f6             	test   rsi,rsi
   1855f1052:	74 1d                	je     0x1855f1071
   1855f1054:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855f1058:	75 17                	jne    0x1855f1071
   1855f105a:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855f105d:	48 89 f1             	mov    rcx,rsi
   1855f1060:	ff 10                	call   QWORD PTR [rax]
   1855f1062:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855f1066:	75 09                	jne    0x1855f1071
   1855f1068:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855f106b:	48 89 f1             	mov    rcx,rsi
   1855f106e:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855f1071:	48 8b b5 08 01 00 00 	mov    rsi,QWORD PTR [rbp+0x108]
   1855f1078:	48 85 f6             	test   rsi,rsi
   1855f107b:	74 1d                	je     0x1855f109a
   1855f107d:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1855f1081:	75 17                	jne    0x1855f109a
   1855f1083:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855f1086:	48 89 f1             	mov    rcx,rsi
   1855f1089:	ff 10                	call   QWORD PTR [rax]
   1855f108b:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1855f108f:	75 09                	jne    0x1855f109a
   1855f1091:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1855f1094:	48 89 f1             	mov    rcx,rsi
   1855f1097:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1855f109a:	48 8b 8d 58 02 00 00 	mov    rcx,QWORD PTR [rbp+0x258]
   1855f10a1:	e8 ca b9 b1 fa       	call   0x18010ca70
   1855f10a6:	0f 28 b5 80 02 00 00 	movaps xmm6,XMMWORD PTR [rbp+0x280]
   1855f10ad:	48 81 c4 18 03 00 00 	add    rsp,0x318
   1855f10b4:	5b                   	pop    rbx
   1855f10b5:	5f                   	pop    rdi
   1855f10b6:	5e                   	pop    rsi
   1855f10b7:	41 5c                	pop    r12
   1855f10b9:	41 5d                	pop    r13
   1855f10bb:	41 5e                	pop    r14
   1855f10bd:	41 5f                	pop    r15
   1855f10bf:	5d                   	pop    rbp
   1855f10c0:	c3                   	ret
   1855f10c1:	e8 c6 d0 0e 02       	call   0x1876de18c
   1855f10c6:	90                   	nop
   1855f10c7:	e8 c4 7a a1 fa       	call   0x180008b90
   1855f10cc:	90                   	nop
   1855f10cd:	cc                   	int3
   1855f10ce:	66 90                	xchg   ax,ax
   1855f10d0:	48 89 54 24 10       	mov    QWORD PTR [rsp+0x10],rdx
   1855f10d5:	55                   	push   rbp
   1855f10d6:	41 57                	push   r15
   1855f10d8:	41 56                	push   r14
   1855f10da:	41 55                	push   r13
   1855f10dc:	41 54                	push   r12
   1855f10de:	56                   	push   rsi
   1855f10df:	57                   	push   rdi
   1855f10e0:	53                   	push   rbx
   1855f10e1:	48 83 ec 58          	sub    rsp,0x58
   1855f10e5:	48 8d aa 80 00 00 00 	lea    rbp,[rdx+0x80]
   1855f10ec:	0f 29 74 24 40       	movaps XMMWORD PTR [rsp+0x40],xmm6
   1855f10f1:	48 8d 8d 90 01 00 00 	lea    rcx,[rbp+0x190]
   1855f10f8:	e8 63 0f a1 fa       	call   0x180002060
   1855f10fd:	0f 28 74 24 40       	movaps xmm6,XMMWORD PTR [rsp+0x40]
   1855f1102:	48 83 c4 58          	add    rsp,0x58
   1855f1106:	5b                   	pop    rbx
   1855f1107:	5f                   	pop    rdi
   1855f1108:	5e                   	pop    rsi
   1855f1109:	41 5c                	pop    r12
   1855f110b:	41 5d                	pop    r13
   1855f110d:	41 5e                	pop    r14
   1855f110f:	41 5f                	pop    r15
   1855f1111:	5d                   	pop    rbp
   1855f1112:	c3                   	ret
   1855f1113:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   1855f111a:	84 00 00 00 00 00 
   1855f1120:	48 89 54 24 10       	mov    QWORD PTR [rsp+0x10],rdx
   1855f1125:	55                   	push   rbp
   1855f1126:	41 57                	push   r15
   1855f1128:	41 56                	push   r14
   1855f112a:	41 55                	push   r13
   1855f112c:	41 54                	push   r12
   1855f112e:	56                   	push   rsi
   1855f112f:	57                   	push   rdi
   1855f1130:	53                   	push   rbx
   1855f1131:	48 83 ec 58          	sub    rsp,0x58
   1855f1135:	48 8d aa 80 00 00 00 	lea    rbp,[rdx+0x80]
   1855f113c:	0f 29 74 24 40       	movaps XMMWORD PTR [rsp+0x40],xmm6
   1855f1141:	48 8d 8d 10 01 00 00 	lea    rcx,[rbp+0x110]
   1855f1148:	e8 13 0f a1 fa       	call   0x180002060
   1855f114d:	0f 28 74 24 40       	movaps xmm6,XMMWORD PTR [rsp+0x40]
   1855f1152:	48 83 c4 58          	add    rsp,0x58
   1855f1156:	5b                   	pop    rbx
   1855f1157:	5f                   	pop    rdi
   1855f1158:	5e                   	pop    rsi
   1855f1159:	41 5c                	pop    r12
   1855f115b:	41 5d                	pop    r13
   1855f115d:	41 5e                	pop    r14
   1855f115f:	41 5f                	pop    r15
   1855f1161:	5d                   	pop    rbp
   1855f1162:	c3                   	ret
   1855f1163:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   1855f116a:	84 00 00 00 00 00 