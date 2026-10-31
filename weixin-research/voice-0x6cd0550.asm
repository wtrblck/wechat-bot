
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

0000000186cd0550 <.text+0x6ccf550>:
   186cd0550:	55                   	push   rbp
   186cd0551:	41 56                	push   r14
   186cd0553:	56                   	push   rsi
   186cd0554:	57                   	push   rdi
   186cd0555:	53                   	push   rbx
   186cd0556:	48 81 ec b0 00 00 00 	sub    rsp,0xb0
   186cd055d:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   186cd0564:	00 
   186cd0565:	0f 29 75 20          	movaps XMMWORD PTR [rbp+0x20],xmm6
   186cd0569:	48 c7 45 18 fe ff ff 	mov    QWORD PTR [rbp+0x18],0xfffffffffffffffe
   186cd0570:	ff 
   186cd0571:	4c 89 c8             	mov    rax,r9
   186cd0574:	48 89 d6             	mov    rsi,rdx
   186cd0577:	48 8b 8d 88 00 00 00 	mov    rcx,QWORD PTR [rbp+0x88]
   186cd057e:	0f 28 35 2b 66 24 02 	movaps xmm6,XMMWORD PTR [rip+0x224662b]        # 0x188f16bb0
   186cd0585:	0f 29 75 e0          	movaps XMMWORD PTR [rbp-0x20],xmm6
   186cd0589:	48 89 4c 24 20       	mov    QWORD PTR [rsp+0x20],rcx
   186cd058e:	48 8d 4d e0          	lea    rcx,[rbp-0x20]
   186cd0592:	4c 8d 8d 80 00 00 00 	lea    r9,[rbp+0x80]
   186cd0599:	48 89 c2             	mov    rdx,rax
   186cd059c:	e8 0f 04 00 00       	call   0x186cd09b0
   186cd05a1:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
   186cd05a5:	c7 80 18 01 00 00 22 	mov    DWORD PTR [rax+0x118],0x22
   186cd05ac:	00 00 00 
   186cd05af:	e8 5c 57 37 f9       	call   0x180045d10
   186cd05b4:	90                   	nop
   186cd05b5:	4c 8b 00             	mov    r8,QWORD PTR [rax]
   186cd05b8:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   186cd05bc:	48 89 c1             	mov    rcx,rax
   186cd05bf:	41 ff 50 60          	call   QWORD PTR [r8+0x60]
   186cd05c3:	90                   	nop
   186cd05c4:	48 8b 4d c0          	mov    rcx,QWORD PTR [rbp-0x40]
   186cd05c8:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   186cd05cb:	48 8d 55 b0          	lea    rdx,[rbp-0x50]
   186cd05cf:	ff 50 30             	call   QWORD PTR [rax+0x30]
   186cd05d2:	90                   	nop
   186cd05d3:	48 8b 4d b0          	mov    rcx,QWORD PTR [rbp-0x50]
   186cd05d7:	48 8d 05 ea 37 35 02 	lea    rax,[rip+0x23537ea]        # 0x189023dc8
   186cd05de:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
   186cd05e2:	0f 29 75 f0          	movaps XMMWORD PTR [rbp-0x10],xmm6
   186cd05e6:	48 8d 55 f0          	lea    rdx,[rbp-0x10]
   186cd05ea:	4c 8d 45 a8          	lea    r8,[rbp-0x58]
   186cd05ee:	e8 7d 5b 4d f9       	call   0x1801a6170
   186cd05f3:	90                   	nop
   186cd05f4:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
   186cd05f8:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
   186cd05fc:	48 85 c9             	test   rcx,rcx
   186cd05ff:	74 34                	je     0x186cd0635
   186cd0601:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   186cd0605:	48 8b 7d f8          	mov    rdi,QWORD PTR [rbp-0x8]
   186cd0609:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
   186cd060d:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
   186cd0611:	48 85 ff             	test   rdi,rdi
   186cd0614:	74 2b                	je     0x186cd0641
   186cd0616:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   186cd061a:	75 25                	jne    0x186cd0641
   186cd061c:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   186cd061f:	48 89 f9             	mov    rcx,rdi
   186cd0622:	ff 10                	call   QWORD PTR [rax]
   186cd0624:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   186cd0628:	75 17                	jne    0x186cd0641
   186cd062a:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   186cd062d:	48 89 f9             	mov    rcx,rdi
   186cd0630:	ff 50 08             	call   QWORD PTR [rax+0x8]
   186cd0633:	eb 0c                	jmp    0x186cd0641
   186cd0635:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
   186cd0639:	48 c7 45 d8 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
   186cd0640:	00 
   186cd0641:	48 8b 7d d0          	mov    rdi,QWORD PTR [rbp-0x30]
   186cd0645:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
   186cd0649:	48 85 c0             	test   rax,rax
   186cd064c:	74 0e                	je     0x186cd065c
   186cd064e:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   186cd0652:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
   186cd0656:	48 89 45 10          	mov    QWORD PTR [rbp+0x10],rax
   186cd065a:	eb 08                	jmp    0x186cd0664
   186cd065c:	48 c7 45 10 00 00 00 	mov    QWORD PTR [rbp+0x10],0x0
   186cd0663:	00 
   186cd0664:	48 8b 5d e0          	mov    rbx,QWORD PTR [rbp-0x20]
   186cd0668:	0f 57 f6             	xorps  xmm6,xmm6
   186cd066b:	0f 29 75 f0          	movaps XMMWORD PTR [rbp-0x10],xmm6
   186cd066f:	48 c7 45 00 00 00 00 	mov    QWORD PTR [rbp+0x0],0x0
   186cd0676:	00 
   186cd0677:	b9 10 00 00 00       	mov    ecx,0x10
   186cd067c:	e8 5b b6 87 00       	call   0x18754bcdc
   186cd0681:	90                   	nop
   186cd0682:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
   186cd0686:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
   186cd068a:	48 89 c1             	mov    rcx,rax
   186cd068d:	48 83 c1 10          	add    rcx,0x10
   186cd0691:	48 89 4d 00          	mov    QWORD PTR [rbp+0x0],rcx
   186cd0695:	0f 11 30             	movups XMMWORD PTR [rax],xmm6
   186cd0698:	48 8b 55 10          	mov    rdx,QWORD PTR [rbp+0x10]
   186cd069c:	48 85 d2             	test   rdx,rdx
   186cd069f:	74 04                	je     0x186cd06a5
   186cd06a1:	f0 ff 42 08          	lock inc DWORD PTR [rdx+0x8]
   186cd06a5:	48 89 18             	mov    QWORD PTR [rax],rbx
   186cd06a8:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
   186cd06ac:	48 89 4d f8          	mov    QWORD PTR [rbp-0x8],rcx
   186cd06b0:	4c 8d 45 f0          	lea    r8,[rbp-0x10]
   186cd06b4:	48 89 f9             	mov    rcx,rdi
   186cd06b7:	48 89 f2             	mov    rdx,rsi
   186cd06ba:	41 b1 01             	mov    r9b,0x1
   186cd06bd:	e8 4e 96 ce fa       	call   0x1819b9d10
   186cd06c2:	90                   	nop
   186cd06c3:	48 8b 7d f0          	mov    rdi,QWORD PTR [rbp-0x10]
   186cd06c7:	48 85 ff             	test   rdi,rdi
   186cd06ca:	0f 84 89 00 00 00    	je     0x186cd0759
   186cd06d0:	4c 8b 75 f8          	mov    r14,QWORD PTR [rbp-0x8]
   186cd06d4:	4c 39 f7             	cmp    rdi,r14
   186cd06d7:	75 20                	jne    0x186cd06f9
   186cd06d9:	48 8b 55 00          	mov    rdx,QWORD PTR [rbp+0x0]
   186cd06dd:	48 29 fa             	sub    rdx,rdi
   186cd06e0:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   186cd06e7:	73 4c                	jae    0x186cd0735
   186cd06e9:	eb 66                	jmp    0x186cd0751
   186cd06eb:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
   186cd06f0:	48 83 c7 10          	add    rdi,0x10
   186cd06f4:	4c 39 f7             	cmp    rdi,r14
   186cd06f7:	74 28                	je     0x186cd0721
   186cd06f9:	48 8b 5f 08          	mov    rbx,QWORD PTR [rdi+0x8]
   186cd06fd:	48 85 db             	test   rbx,rbx
   186cd0700:	74 ee                	je     0x186cd06f0
   186cd0702:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   186cd0706:	75 e8                	jne    0x186cd06f0
   186cd0708:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   186cd070b:	48 89 d9             	mov    rcx,rbx
   186cd070e:	ff 10                	call   QWORD PTR [rax]
   186cd0710:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   186cd0714:	75 da                	jne    0x186cd06f0
   186cd0716:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   186cd0719:	48 89 d9             	mov    rcx,rbx
   186cd071c:	ff 50 08             	call   QWORD PTR [rax+0x8]
   186cd071f:	eb cf                	jmp    0x186cd06f0
   186cd0721:	48 8b 7d f0          	mov    rdi,QWORD PTR [rbp-0x10]
   186cd0725:	48 8b 55 00          	mov    rdx,QWORD PTR [rbp+0x0]
   186cd0729:	48 29 fa             	sub    rdx,rdi
   186cd072c:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   186cd0733:	72 1c                	jb     0x186cd0751
   186cd0735:	48 8b 47 f8          	mov    rax,QWORD PTR [rdi-0x8]
   186cd0739:	48 83 c7 f8          	add    rdi,0xfffffffffffffff8
   186cd073d:	48 29 c7             	sub    rdi,rax
   186cd0740:	48 83 ff 20          	cmp    rdi,0x20
   186cd0744:	0f 83 e2 00 00 00    	jae    0x186cd082c
   186cd074a:	48 83 c2 27          	add    rdx,0x27
   186cd074e:	48 89 c7             	mov    rdi,rax
   186cd0751:	48 89 f9             	mov    rcx,rdi
   186cd0754:	e8 c7 b5 87 00       	call   0x18754bd20
   186cd0759:	48 8b 7d 10          	mov    rdi,QWORD PTR [rbp+0x10]
   186cd075d:	48 85 ff             	test   rdi,rdi
   186cd0760:	74 1d                	je     0x186cd077f
   186cd0762:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   186cd0766:	75 17                	jne    0x186cd077f
   186cd0768:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   186cd076b:	48 89 f9             	mov    rcx,rdi
   186cd076e:	ff 10                	call   QWORD PTR [rax]
   186cd0770:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   186cd0774:	75 09                	jne    0x186cd077f
   186cd0776:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   186cd0779:	48 89 f9             	mov    rcx,rdi
   186cd077c:	ff 50 08             	call   QWORD PTR [rax+0x8]
   186cd077f:	48 8b 7d d8          	mov    rdi,QWORD PTR [rbp-0x28]
   186cd0783:	48 85 ff             	test   rdi,rdi
   186cd0786:	74 1d                	je     0x186cd07a5
   186cd0788:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   186cd078c:	75 17                	jne    0x186cd07a5
   186cd078e:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   186cd0791:	48 89 f9             	mov    rcx,rdi
   186cd0794:	ff 10                	call   QWORD PTR [rax]
   186cd0796:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   186cd079a:	75 09                	jne    0x186cd07a5
   186cd079c:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   186cd079f:	48 89 f9             	mov    rcx,rdi
   186cd07a2:	ff 50 08             	call   QWORD PTR [rax+0x8]
   186cd07a5:	48 8b 7d b8          	mov    rdi,QWORD PTR [rbp-0x48]
   186cd07a9:	48 85 ff             	test   rdi,rdi
   186cd07ac:	74 1d                	je     0x186cd07cb
   186cd07ae:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   186cd07b2:	75 17                	jne    0x186cd07cb
   186cd07b4:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   186cd07b7:	48 89 f9             	mov    rcx,rdi
   186cd07ba:	ff 10                	call   QWORD PTR [rax]
   186cd07bc:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   186cd07c0:	75 09                	jne    0x186cd07cb
   186cd07c2:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   186cd07c5:	48 89 f9             	mov    rcx,rdi
   186cd07c8:	ff 50 08             	call   QWORD PTR [rax+0x8]
   186cd07cb:	48 8b 7d c8          	mov    rdi,QWORD PTR [rbp-0x38]
   186cd07cf:	48 85 ff             	test   rdi,rdi
   186cd07d2:	74 1d                	je     0x186cd07f1
   186cd07d4:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   186cd07d8:	75 17                	jne    0x186cd07f1
   186cd07da:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   186cd07dd:	48 89 f9             	mov    rcx,rdi
   186cd07e0:	ff 10                	call   QWORD PTR [rax]
   186cd07e2:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   186cd07e6:	75 09                	jne    0x186cd07f1
   186cd07e8:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   186cd07eb:	48 89 f9             	mov    rcx,rdi
   186cd07ee:	ff 50 08             	call   QWORD PTR [rax+0x8]
   186cd07f1:	48 8b 7d e8          	mov    rdi,QWORD PTR [rbp-0x18]
   186cd07f5:	48 85 ff             	test   rdi,rdi
   186cd07f8:	74 1d                	je     0x186cd0817
   186cd07fa:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   186cd07fe:	75 17                	jne    0x186cd0817
   186cd0800:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   186cd0803:	48 89 f9             	mov    rcx,rdi
   186cd0806:	ff 10                	call   QWORD PTR [rax]
   186cd0808:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   186cd080c:	75 09                	jne    0x186cd0817
   186cd080e:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   186cd0811:	48 89 f9             	mov    rcx,rdi
   186cd0814:	ff 50 08             	call   QWORD PTR [rax+0x8]
   186cd0817:	48 89 f0             	mov    rax,rsi
   186cd081a:	0f 28 75 20          	movaps xmm6,XMMWORD PTR [rbp+0x20]
   186cd081e:	48 81 c4 b0 00 00 00 	add    rsp,0xb0
   186cd0825:	5b                   	pop    rbx
   186cd0826:	5f                   	pop    rdi
   186cd0827:	5e                   	pop    rsi
   186cd0828:	41 5e                	pop    r14
   186cd082a:	5d                   	pop    rbp
   186cd082b:	c3                   	ret
   186cd082c:	e8 5b d9 a0 00       	call   0x1876de18c
   186cd0831:	cc                   	int3
