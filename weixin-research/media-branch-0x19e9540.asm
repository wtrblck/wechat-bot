
E:/Tencent/Weixin/4.1.15.56/Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001819e9540 <.text+0x19e8540>:
   1819e9540:	55                   	push   rbp
   1819e9541:	41 57                	push   r15
   1819e9543:	41 56                	push   r14
   1819e9545:	41 54                	push   r12
   1819e9547:	56                   	push   rsi
   1819e9548:	57                   	push   rdi
   1819e9549:	53                   	push   rbx
   1819e954a:	48 81 ec 90 02 00 00 	sub    rsp,0x290
   1819e9551:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   1819e9558:	00 
   1819e9559:	0f 29 b5 00 02 00 00 	movaps XMMWORD PTR [rbp+0x200],xmm6
   1819e9560:	48 c7 85 f8 01 00 00 	mov    QWORD PTR [rbp+0x1f8],0xfffffffffffffffe
   1819e9567:	fe ff ff ff 
   1819e956b:	48 89 ce             	mov    rsi,rcx
   1819e956e:	48 8d 79 08          	lea    rdi,[rcx+0x8]
   1819e9572:	0f 28 35 37 d6 52 07 	movaps xmm6,XMMWORD PTR [rip+0x752d637]        # 0x188f16bb0
   1819e9579:	0f 29 b5 e0 01 00 00 	movaps XMMWORD PTR [rbp+0x1e0],xmm6
   1819e9580:	48 8d 8d e0 01 00 00 	lea    rcx,[rbp+0x1e0]
   1819e9587:	e8 44 0c 00 00       	call   0x1819ea1d0
   1819e958c:	b9 18 01 00 00       	mov    ecx,0x118
   1819e9591:	48 03 8d e0 01 00 00 	add    rcx,QWORD PTR [rbp+0x1e0]
   1819e9598:	48 89 fa             	mov    rdx,rdi
   1819e959b:	e8 e0 08 07 ff       	call   0x180a59e80
   1819e95a0:	90                   	nop
   1819e95a1:	4c 8d 4e 38          	lea    r9,[rsi+0x38]
   1819e95a5:	48 8b 85 e0 01 00 00 	mov    rax,QWORD PTR [rbp+0x1e0]
   1819e95ac:	48 8d 98 b0 00 00 00 	lea    rbx,[rax+0xb0]
   1819e95b3:	4c 39 cb             	cmp    rbx,r9
   1819e95b6:	74 27                	je     0x1819e95df
   1819e95b8:	4c 8b 76 48          	mov    r14,QWORD PTR [rsi+0x48]
   1819e95bc:	48 83 7e 50 10       	cmp    QWORD PTR [rsi+0x50],0x10
   1819e95c1:	72 04                	jb     0x1819e95c7
   1819e95c3:	4c 8b 4e 38          	mov    r9,QWORD PTR [rsi+0x38]
   1819e95c7:	48 8b 88 c8 00 00 00 	mov    rcx,QWORD PTR [rax+0xc8]
   1819e95ce:	49 39 ce             	cmp    r14,rcx
   1819e95d1:	76 2c                	jbe    0x1819e95ff
   1819e95d3:	48 89 d9             	mov    rcx,rbx
   1819e95d6:	4c 89 f2             	mov    rdx,r14
   1819e95d9:	e8 72 4b 65 fe       	call   0x18003e150
   1819e95de:	90                   	nop
   1819e95df:	0f 29 b5 70 01 00 00 	movaps XMMWORD PTR [rbp+0x170],xmm6
   1819e95e6:	48 8b 86 c0 02 00 00 	mov    rax,QWORD PTR [rsi+0x2c0]
   1819e95ed:	48 85 c0             	test   rax,rax
   1819e95f0:	74 43                	je     0x1819e9635
   1819e95f2:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1819e95f6:	48 8b 8e c0 02 00 00 	mov    rcx,QWORD PTR [rsi+0x2c0]
   1819e95fd:	eb 38                	jmp    0x1819e9637
   1819e95ff:	48 83 f9 10          	cmp    rcx,0x10
   1819e9603:	72 03                	jb     0x1819e9608
   1819e9605:	48 8b 1b             	mov    rbx,QWORD PTR [rbx]
   1819e9608:	4c 89 b0 c0 00 00 00 	mov    QWORD PTR [rax+0xc0],r14
   1819e960f:	48 89 d9             	mov    rcx,rbx
   1819e9612:	4c 89 ca             	mov    rdx,r9
   1819e9615:	4d 89 f0             	mov    r8,r14
   1819e9618:	e8 23 b8 d2 05       	call   0x187714e40
   1819e961d:	42 c6 04 33 00       	mov    BYTE PTR [rbx+r14*1],0x0
   1819e9622:	0f 29 b5 70 01 00 00 	movaps XMMWORD PTR [rbp+0x170],xmm6
   1819e9629:	48 8b 86 c0 02 00 00 	mov    rax,QWORD PTR [rsi+0x2c0]
   1819e9630:	48 85 c0             	test   rax,rax
   1819e9633:	75 bd                	jne    0x1819e95f2
   1819e9635:	31 c9                	xor    ecx,ecx
   1819e9637:	48 8b 86 b8 02 00 00 	mov    rax,QWORD PTR [rsi+0x2b8]
   1819e963e:	48 89 85 70 01 00 00 	mov    QWORD PTR [rbp+0x170],rax
   1819e9645:	48 89 8d 78 01 00 00 	mov    QWORD PTR [rbp+0x178],rcx
   1819e964c:	48 85 c0             	test   rax,rax
   1819e964f:	74 50                	je     0x1819e96a1
   1819e9651:	48 8b 48 68          	mov    rcx,QWORD PTR [rax+0x68]
   1819e9655:	48 85 c9             	test   rcx,rcx
   1819e9658:	0f 84 80 00 00 00    	je     0x1819e96de
   1819e965e:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   1819e9662:	48 8b 58 68          	mov    rbx,QWORD PTR [rax+0x68]
   1819e9666:	48 8b 40 60          	mov    rax,QWORD PTR [rax+0x60]
   1819e966a:	48 85 c0             	test   rax,rax
   1819e966d:	74 0f                	je     0x1819e967e
   1819e966f:	8b 00                	mov    eax,DWORD PTR [rax]
   1819e9671:	48 8b 8d e0 01 00 00 	mov    rcx,QWORD PTR [rbp+0x1e0]
   1819e9678:	89 81 9c 00 00 00    	mov    DWORD PTR [rcx+0x9c],eax
   1819e967e:	48 85 db             	test   rbx,rbx
   1819e9681:	74 1e                	je     0x1819e96a1
   1819e9683:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   1819e9687:	75 18                	jne    0x1819e96a1
   1819e9689:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   1819e968c:	48 89 d9             	mov    rcx,rbx
   1819e968f:	ff 10                	call   QWORD PTR [rax]
   1819e9691:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   1819e9695:	75 0a                	jne    0x1819e96a1
   1819e9697:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   1819e969a:	48 89 d9             	mov    rcx,rbx
   1819e969d:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1819e96a0:	90                   	nop
   1819e96a1:	48 89 f9             	mov    rcx,rdi
   1819e96a4:	e8 17 e0 05 ff       	call   0x180a476c0
   1819e96a9:	90                   	nop
   1819e96aa:	84 c0                	test   al,al
   1819e96ac:	0f 84 6e 02 00 00    	je     0x1819e9920
   1819e96b2:	0f 29 b5 d0 01 00 00 	movaps XMMWORD PTR [rbp+0x1d0],xmm6
   1819e96b9:	4c 8b b6 a8 02 00 00 	mov    r14,QWORD PTR [rsi+0x2a8]
   1819e96c0:	4d 85 f6             	test   r14,r14
   1819e96c3:	74 26                	je     0x1819e96eb
   1819e96c5:	48 8b 86 b0 02 00 00 	mov    rax,QWORD PTR [rsi+0x2b0]
   1819e96cc:	48 85 c0             	test   rax,rax
   1819e96cf:	74 28                	je     0x1819e96f9
   1819e96d1:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1819e96d5:	48 8b 9e b0 02 00 00 	mov    rbx,QWORD PTR [rsi+0x2b0]
   1819e96dc:	eb 1d                	jmp    0x1819e96fb
   1819e96de:	31 db                	xor    ebx,ebx
   1819e96e0:	48 8b 40 60          	mov    rax,QWORD PTR [rax+0x60]
   1819e96e4:	48 85 c0             	test   rax,rax
   1819e96e7:	75 86                	jne    0x1819e966f
   1819e96e9:	eb 93                	jmp    0x1819e967e
   1819e96eb:	0f 57 c0             	xorps  xmm0,xmm0
   1819e96ee:	0f 29 85 d0 01 00 00 	movaps XMMWORD PTR [rbp+0x1d0],xmm0
   1819e96f5:	31 db                	xor    ebx,ebx
   1819e96f7:	eb 10                	jmp    0x1819e9709
   1819e96f9:	31 db                	xor    ebx,ebx
   1819e96fb:	4c 89 b5 d0 01 00 00 	mov    QWORD PTR [rbp+0x1d0],r14
   1819e9702:	48 89 9d d8 01 00 00 	mov    QWORD PTR [rbp+0x1d8],rbx
   1819e9709:	49 8d 96 30 01 00 00 	lea    rdx,[r14+0x130]
   1819e9710:	b9 d8 00 00 00       	mov    ecx,0xd8
   1819e9715:	48 03 8d e0 01 00 00 	add    rcx,QWORD PTR [rbp+0x1e0]
   1819e971c:	e8 7f 10 00 00       	call   0x1819ea7a0
   1819e9721:	90                   	nop
   1819e9722:	41 8b 86 60 01 00 00 	mov    eax,DWORD PTR [r14+0x160]
   1819e9729:	48 8b 8d e0 01 00 00 	mov    rcx,QWORD PTR [rbp+0x1e0]
   1819e9730:	89 81 10 01 00 00    	mov    DWORD PTR [rcx+0x110],eax
   1819e9736:	b9 02 00 00 00       	mov    ecx,0x2
   1819e973b:	e8 a0 36 68 fe       	call   0x18006cde0
   1819e9740:	85 c0                	test   eax,eax
   1819e9742:	0f 84 b5 01 00 00    	je     0x1819e98fd
   1819e9748:	48 8d 9d 88 01 00 00 	lea    rbx,[rbp+0x188]
   1819e974f:	48 89 d9             	mov    rcx,rbx
   1819e9752:	e8 b9 37 68 fe       	call   0x18006cf10
   1819e9757:	90                   	nop
   1819e9758:	48 83 bd a0 01 00 00 	cmp    QWORD PTR [rbp+0x1a0],0x10
   1819e975f:	10 
   1819e9760:	72 07                	jb     0x1819e9769
   1819e9762:	48 8b 9d 88 01 00 00 	mov    rbx,QWORD PTR [rbp+0x188]
   1819e9769:	48 8d 05 90 69 90 07 	lea    rax,[rip+0x7906990]        # 0x1892f0100
   1819e9770:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1819e9775:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1819e977c:	00 00 
   1819e977e:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1819e9783:	c7 44 24 28 8f 02 00 	mov    DWORD PTR [rsp+0x28],0x28f
   1819e978a:	00 
   1819e978b:	4c 8d 0d b6 61 90 07 	lea    r9,[rip+0x79061b6]        # 0x1892ef948
   1819e9792:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1819e9796:	ba 02 00 00 00       	mov    edx,0x2
   1819e979b:	49 89 d8             	mov    r8,rbx
   1819e979e:	e8 cd 3a 68 fe       	call   0x18006d270
   1819e97a3:	90                   	nop
   1819e97a4:	48 8b 85 d0 01 00 00 	mov    rax,QWORD PTR [rbp+0x1d0]
   1819e97ab:	48 83 b8 50 01 00 00 	cmp    QWORD PTR [rax+0x150],0x10
   1819e97b2:	10 
   1819e97b3:	72 09                	jb     0x1819e97be
   1819e97b5:	48 8b 80 38 01 00 00 	mov    rax,QWORD PTR [rax+0x138]
   1819e97bc:	eb 06                	jmp    0x1819e97c4
   1819e97be:	48 05 38 01 00 00    	add    rax,0x138
   1819e97c4:	48 89 45 50          	mov    QWORD PTR [rbp+0x50],rax
   1819e97c8:	c6 45 58 00          	mov    BYTE PTR [rbp+0x58],0x0
   1819e97cc:	48 8d 9d a8 01 00 00 	lea    rbx,[rbp+0x1a8]
   1819e97d3:	48 89 f9             	mov    rcx,rdi
   1819e97d6:	48 89 da             	mov    rdx,rbx
   1819e97d9:	e8 32 bb 05 ff       	call   0x180a45310
   1819e97de:	90                   	nop
   1819e97df:	48 83 bd c0 01 00 00 	cmp    QWORD PTR [rbp+0x1c0],0x10
   1819e97e6:	10 
   1819e97e7:	72 07                	jb     0x1819e97f0
   1819e97e9:	48 8b 9d a8 01 00 00 	mov    rbx,QWORD PTR [rbp+0x1a8]
   1819e97f0:	48 89 9d a0 00 00 00 	mov    QWORD PTR [rbp+0xa0],rbx
   1819e97f7:	c6 85 a8 00 00 00 00 	mov    BYTE PTR [rbp+0xa8],0x0
   1819e97fe:	0f 57 c0             	xorps  xmm0,xmm0
   1819e9801:	0f 11 85 60 01 00 00 	movups XMMWORD PTR [rbp+0x160],xmm0
   1819e9808:	0f 11 85 50 01 00 00 	movups XMMWORD PTR [rbp+0x150],xmm0
   1819e980f:	0f 11 85 40 01 00 00 	movups XMMWORD PTR [rbp+0x140],xmm0
   1819e9816:	0f 11 85 30 01 00 00 	movups XMMWORD PTR [rbp+0x130],xmm0
   1819e981d:	0f 11 85 20 01 00 00 	movups XMMWORD PTR [rbp+0x120],xmm0
   1819e9824:	0f 11 85 10 01 00 00 	movups XMMWORD PTR [rbp+0x110],xmm0
   1819e982b:	0f 11 85 00 01 00 00 	movups XMMWORD PTR [rbp+0x100],xmm0
   1819e9832:	48 8d 85 a0 00 00 00 	lea    rax,[rbp+0xa0]
   1819e9839:	48 89 85 f0 00 00 00 	mov    QWORD PTR [rbp+0xf0],rax
   1819e9840:	48 8d 45 50          	lea    rax,[rbp+0x50]
   1819e9844:	48 89 85 f8 00 00 00 	mov    QWORD PTR [rbp+0xf8],rax
   1819e984b:	48 8d 15 d6 61 90 07 	lea    rdx,[rip+0x79061d6]        # 0x1892efa28
   1819e9852:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1819e9856:	4c 8d 85 f0 00 00 00 	lea    r8,[rbp+0xf0]
   1819e985d:	e8 ae 3f 68 fe       	call   0x18006d810
   1819e9862:	90                   	nop
   1819e9863:	48 8b 85 c0 01 00 00 	mov    rax,QWORD PTR [rbp+0x1c0]
   1819e986a:	48 83 f8 10          	cmp    rax,0x10
   1819e986e:	72 38                	jb     0x1819e98a8
   1819e9870:	48 8b 8d a8 01 00 00 	mov    rcx,QWORD PTR [rbp+0x1a8]
   1819e9877:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1819e987b:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1819e9882:	72 1f                	jb     0x1819e98a3
   1819e9884:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1819e9888:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1819e988c:	4c 29 c1             	sub    rcx,r8
   1819e988f:	48 83 f9 20          	cmp    rcx,0x20
   1819e9893:	0f 83 af 04 00 00    	jae    0x1819e9d48
   1819e9899:	48 83 c0 28          	add    rax,0x28
   1819e989d:	48 89 c2             	mov    rdx,rax
   1819e98a0:	4c 89 c1             	mov    rcx,r8
   1819e98a3:	e8 78 24 b6 05       	call   0x18754bd20
   1819e98a8:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1819e98ac:	e8 bf 3a 68 fe       	call   0x18006d370
   1819e98b1:	48 8b 85 a0 01 00 00 	mov    rax,QWORD PTR [rbp+0x1a0]
   1819e98b8:	48 83 f8 10          	cmp    rax,0x10
   1819e98bc:	72 38                	jb     0x1819e98f6
   1819e98be:	48 8b 8d 88 01 00 00 	mov    rcx,QWORD PTR [rbp+0x188]
   1819e98c5:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1819e98c9:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1819e98d0:	72 1f                	jb     0x1819e98f1
   1819e98d2:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1819e98d6:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1819e98da:	4c 29 c1             	sub    rcx,r8
   1819e98dd:	48 83 f9 20          	cmp    rcx,0x20
   1819e98e1:	0f 83 61 04 00 00    	jae    0x1819e9d48
   1819e98e7:	48 83 c0 28          	add    rax,0x28
   1819e98eb:	48 89 c2             	mov    rdx,rax
   1819e98ee:	4c 89 c1             	mov    rcx,r8
   1819e98f1:	e8 2a 24 b6 05       	call   0x18754bd20
   1819e98f6:	48 8b 9d d8 01 00 00 	mov    rbx,QWORD PTR [rbp+0x1d8]
   1819e98fd:	48 85 db             	test   rbx,rbx
   1819e9900:	74 1e                	je     0x1819e9920
   1819e9902:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   1819e9906:	75 18                	jne    0x1819e9920
   1819e9908:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   1819e990b:	48 89 d9             	mov    rcx,rbx
   1819e990e:	ff 10                	call   QWORD PTR [rax]
   1819e9910:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   1819e9914:	75 0a                	jne    0x1819e9920
   1819e9916:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   1819e9919:	48 89 d9             	mov    rcx,rbx
   1819e991c:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1819e991f:	90                   	nop
   1819e9920:	48 8d 9d a0 00 00 00 	lea    rbx,[rbp+0xa0]
   1819e9927:	48 89 d9             	mov    rcx,rbx
   1819e992a:	e8 f1 d8 65 fe       	call   0x180047220
   1819e992f:	90                   	nop
   1819e9930:	48 8b 8d a0 00 00 00 	mov    rcx,QWORD PTR [rbp+0xa0]
   1819e9937:	4c 8d 75 50          	lea    r14,[rbp+0x50]
   1819e993b:	4c 89 f2             	mov    rdx,r14
   1819e993e:	e8 8d 8a 99 fe       	call   0x1803823d0
   1819e9943:	90                   	nop
   1819e9944:	48 8b 4d 50          	mov    rcx,QWORD PTR [rbp+0x50]
   1819e9948:	48 8d 95 f0 00 00 00 	lea    rdx,[rbp+0xf0]
   1819e994f:	e8 2c f9 d1 fe       	call   0x180709280
   1819e9954:	90                   	nop
   1819e9955:	48 8b 8d f0 00 00 00 	mov    rcx,QWORD PTR [rbp+0xf0]
   1819e995c:	0f 57 c0             	xorps  xmm0,xmm0
   1819e995f:	0f 29 85 d0 01 00 00 	movaps XMMWORD PTR [rbp+0x1d0],xmm0
   1819e9966:	48 8b 85 e8 01 00 00 	mov    rax,QWORD PTR [rbp+0x1e8]
   1819e996d:	48 85 c0             	test   rax,rax
   1819e9970:	74 0d                	je     0x1819e997f
   1819e9972:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1819e9976:	48 8b 85 e8 01 00 00 	mov    rax,QWORD PTR [rbp+0x1e8]
   1819e997d:	eb 02                	jmp    0x1819e9981
   1819e997f:	31 c0                	xor    eax,eax
   1819e9981:	48 8b 95 e0 01 00 00 	mov    rdx,QWORD PTR [rbp+0x1e0]
   1819e9988:	48 89 95 d0 01 00 00 	mov    QWORD PTR [rbp+0x1d0],rdx
   1819e998f:	48 89 85 d8 01 00 00 	mov    QWORD PTR [rbp+0x1d8],rax
   1819e9996:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   1819e999a:	4c 8d 85 d0 01 00 00 	lea    r8,[rbp+0x1d0]
   1819e99a1:	e8 ba a1 db ff       	call   0x1817a3b60
   1819e99a6:	90                   	nop
   1819e99a7:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
   1819e99aa:	0b 45 c0             	or     eax,DWORD PTR [rbp-0x40]
   1819e99ad:	41 0f 94 c4          	sete   r12b
   1819e99b1:	4c 8b 7d f0          	mov    r15,QWORD PTR [rbp-0x10]
   1819e99b5:	4d 85 ff             	test   r15,r15
   1819e99b8:	74 1f                	je     0x1819e99d9
   1819e99ba:	f0 41 ff 4f 08       	lock dec DWORD PTR [r15+0x8]
   1819e99bf:	75 18                	jne    0x1819e99d9
   1819e99c1:	49 8b 07             	mov    rax,QWORD PTR [r15]
   1819e99c4:	4c 89 f9             	mov    rcx,r15
   1819e99c7:	ff 10                	call   QWORD PTR [rax]
   1819e99c9:	f0 41 ff 4f 0c       	lock dec DWORD PTR [r15+0xc]
   1819e99ce:	75 09                	jne    0x1819e99d9
   1819e99d0:	49 8b 07             	mov    rax,QWORD PTR [r15]
   1819e99d3:	4c 89 f9             	mov    rcx,r15
   1819e99d6:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1819e99d9:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
   1819e99dd:	48 83 f8 10          	cmp    rax,0x10
   1819e99e1:	72 35                	jb     0x1819e9a18
   1819e99e3:	48 8b 4d c8          	mov    rcx,QWORD PTR [rbp-0x38]
   1819e99e7:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1819e99eb:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1819e99f2:	72 1f                	jb     0x1819e9a13
   1819e99f4:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1819e99f8:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1819e99fc:	4c 29 c1             	sub    rcx,r8
   1819e99ff:	48 83 f9 20          	cmp    rcx,0x20
   1819e9a03:	0f 83 3f 03 00 00    	jae    0x1819e9d48
   1819e9a09:	48 83 c0 28          	add    rax,0x28
   1819e9a0d:	48 89 c2             	mov    rdx,rax
   1819e9a10:	4c 89 c1             	mov    rcx,r8
   1819e9a13:	e8 08 23 b6 05       	call   0x18754bd20
   1819e9a18:	4c 8b bd f8 00 00 00 	mov    r15,QWORD PTR [rbp+0xf8]
   1819e9a1f:	4d 85 ff             	test   r15,r15
   1819e9a22:	74 1f                	je     0x1819e9a43
   1819e9a24:	f0 41 ff 4f 08       	lock dec DWORD PTR [r15+0x8]
   1819e9a29:	75 18                	jne    0x1819e9a43
   1819e9a2b:	49 8b 07             	mov    rax,QWORD PTR [r15]
   1819e9a2e:	4c 89 f9             	mov    rcx,r15
   1819e9a31:	ff 10                	call   QWORD PTR [rax]
   1819e9a33:	f0 41 ff 4f 0c       	lock dec DWORD PTR [r15+0xc]
   1819e9a38:	75 09                	jne    0x1819e9a43
   1819e9a3a:	49 8b 07             	mov    rax,QWORD PTR [r15]
   1819e9a3d:	4c 89 f9             	mov    rcx,r15
   1819e9a40:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1819e9a43:	4c 8b 7d 58          	mov    r15,QWORD PTR [rbp+0x58]
   1819e9a47:	4d 85 ff             	test   r15,r15
   1819e9a4a:	74 1f                	je     0x1819e9a6b
   1819e9a4c:	f0 41 ff 4f 08       	lock dec DWORD PTR [r15+0x8]
   1819e9a51:	75 18                	jne    0x1819e9a6b
   1819e9a53:	49 8b 07             	mov    rax,QWORD PTR [r15]
   1819e9a56:	4c 89 f9             	mov    rcx,r15
   1819e9a59:	ff 10                	call   QWORD PTR [rax]
   1819e9a5b:	f0 41 ff 4f 0c       	lock dec DWORD PTR [r15+0xc]
   1819e9a60:	75 09                	jne    0x1819e9a6b
   1819e9a62:	49 8b 07             	mov    rax,QWORD PTR [r15]
   1819e9a65:	4c 89 f9             	mov    rcx,r15
   1819e9a68:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1819e9a6b:	4c 8b bd a8 00 00 00 	mov    r15,QWORD PTR [rbp+0xa8]
   1819e9a72:	4d 85 ff             	test   r15,r15
   1819e9a75:	74 1f                	je     0x1819e9a96
   1819e9a77:	f0 41 ff 4f 08       	lock dec DWORD PTR [r15+0x8]
   1819e9a7c:	75 18                	jne    0x1819e9a96
   1819e9a7e:	49 8b 07             	mov    rax,QWORD PTR [r15]
   1819e9a81:	4c 89 f9             	mov    rcx,r15
   1819e9a84:	ff 10                	call   QWORD PTR [rax]
   1819e9a86:	f0 41 ff 4f 0c       	lock dec DWORD PTR [r15+0xc]
   1819e9a8b:	75 09                	jne    0x1819e9a96
   1819e9a8d:	49 8b 07             	mov    rax,QWORD PTR [r15]
   1819e9a90:	4c 89 f9             	mov    rcx,r15
   1819e9a93:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1819e9a96:	b9 02 00 00 00       	mov    ecx,0x2
   1819e9a9b:	e8 40 33 68 fe       	call   0x18006cde0
   1819e9aa0:	85 c0                	test   eax,eax
   1819e9aa2:	0f 84 99 01 00 00    	je     0x1819e9c41
   1819e9aa8:	4c 8d bd 88 01 00 00 	lea    r15,[rbp+0x188]
   1819e9aaf:	4c 89 f9             	mov    rcx,r15
   1819e9ab2:	e8 59 34 68 fe       	call   0x18006cf10
   1819e9ab7:	90                   	nop
   1819e9ab8:	48 83 bd a0 01 00 00 	cmp    QWORD PTR [rbp+0x1a0],0x10
   1819e9abf:	10 
   1819e9ac0:	72 07                	jb     0x1819e9ac9
   1819e9ac2:	4c 8b bd 88 01 00 00 	mov    r15,QWORD PTR [rbp+0x188]
   1819e9ac9:	48 8d 05 30 66 90 07 	lea    rax,[rip+0x7906630]        # 0x1892f0100
   1819e9ad0:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1819e9ad5:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1819e9adc:	00 00 
   1819e9ade:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1819e9ae3:	c7 44 24 28 92 02 00 	mov    DWORD PTR [rsp+0x28],0x292
   1819e9aea:	00 
   1819e9aeb:	4c 8d 0d 56 5e 90 07 	lea    r9,[rip+0x7905e56]        # 0x1892ef948
   1819e9af2:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1819e9af6:	ba 02 00 00 00       	mov    edx,0x2
   1819e9afb:	4d 89 f8             	mov    r8,r15
   1819e9afe:	e8 6d 37 68 fe       	call   0x18006d270
   1819e9b03:	90                   	nop
   1819e9b04:	48 8d 05 a5 6e 56 07 	lea    rax,[rip+0x7566ea5]        # 0x188f509b0
   1819e9b0b:	48 8d 0d a6 6e 56 07 	lea    rcx,[rip+0x7566ea6]        # 0x188f509b8
   1819e9b12:	45 84 e4             	test   r12b,r12b
   1819e9b15:	48 0f 45 c8          	cmovne rcx,rax
   1819e9b19:	48 89 4d 50          	mov    QWORD PTR [rbp+0x50],rcx
   1819e9b1d:	c6 45 58 00          	mov    BYTE PTR [rbp+0x58],0x0
   1819e9b21:	4c 8d bd a8 01 00 00 	lea    r15,[rbp+0x1a8]
   1819e9b28:	48 89 f9             	mov    rcx,rdi
   1819e9b2b:	4c 89 fa             	mov    rdx,r15
   1819e9b2e:	e8 dd b7 05 ff       	call   0x180a45310
   1819e9b33:	90                   	nop
   1819e9b34:	48 83 bd c0 01 00 00 	cmp    QWORD PTR [rbp+0x1c0],0x10
   1819e9b3b:	10 
   1819e9b3c:	72 07                	jb     0x1819e9b45
   1819e9b3e:	4c 8b bd a8 01 00 00 	mov    r15,QWORD PTR [rbp+0x1a8]
   1819e9b45:	4c 89 bd a0 00 00 00 	mov    QWORD PTR [rbp+0xa0],r15
   1819e9b4c:	c6 85 a8 00 00 00 00 	mov    BYTE PTR [rbp+0xa8],0x0
   1819e9b53:	0f 57 c0             	xorps  xmm0,xmm0
   1819e9b56:	0f 11 85 60 01 00 00 	movups XMMWORD PTR [rbp+0x160],xmm0
   1819e9b5d:	0f 11 85 50 01 00 00 	movups XMMWORD PTR [rbp+0x150],xmm0
   1819e9b64:	0f 11 85 40 01 00 00 	movups XMMWORD PTR [rbp+0x140],xmm0
   1819e9b6b:	0f 11 85 30 01 00 00 	movups XMMWORD PTR [rbp+0x130],xmm0
   1819e9b72:	0f 11 85 20 01 00 00 	movups XMMWORD PTR [rbp+0x120],xmm0
   1819e9b79:	0f 11 85 10 01 00 00 	movups XMMWORD PTR [rbp+0x110],xmm0
   1819e9b80:	0f 11 85 00 01 00 00 	movups XMMWORD PTR [rbp+0x100],xmm0
   1819e9b87:	48 89 9d f0 00 00 00 	mov    QWORD PTR [rbp+0xf0],rbx
   1819e9b8e:	4c 89 b5 f8 00 00 00 	mov    QWORD PTR [rbp+0xf8],r14
   1819e9b95:	48 8d 15 ac 66 90 07 	lea    rdx,[rip+0x79066ac]        # 0x1892f0248
   1819e9b9c:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1819e9ba0:	4c 8d 85 f0 00 00 00 	lea    r8,[rbp+0xf0]
   1819e9ba7:	e8 64 3c 68 fe       	call   0x18006d810
   1819e9bac:	90                   	nop
   1819e9bad:	48 8b 85 c0 01 00 00 	mov    rax,QWORD PTR [rbp+0x1c0]
   1819e9bb4:	48 83 f8 10          	cmp    rax,0x10
   1819e9bb8:	72 38                	jb     0x1819e9bf2
   1819e9bba:	48 8b 8d a8 01 00 00 	mov    rcx,QWORD PTR [rbp+0x1a8]
   1819e9bc1:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1819e9bc5:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1819e9bcc:	72 1f                	jb     0x1819e9bed
   1819e9bce:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1819e9bd2:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1819e9bd6:	4c 29 c1             	sub    rcx,r8
   1819e9bd9:	48 83 f9 20          	cmp    rcx,0x20
   1819e9bdd:	0f 83 65 01 00 00    	jae    0x1819e9d48
   1819e9be3:	48 83 c0 28          	add    rax,0x28
   1819e9be7:	48 89 c2             	mov    rdx,rax
   1819e9bea:	4c 89 c1             	mov    rcx,r8
   1819e9bed:	e8 2e 21 b6 05       	call   0x18754bd20
   1819e9bf2:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1819e9bf6:	e8 75 37 68 fe       	call   0x18006d370
   1819e9bfb:	48 8b 85 a0 01 00 00 	mov    rax,QWORD PTR [rbp+0x1a0]
   1819e9c02:	48 83 f8 10          	cmp    rax,0x10
   1819e9c06:	72 39                	jb     0x1819e9c41
   1819e9c08:	48 8b 8d 88 01 00 00 	mov    rcx,QWORD PTR [rbp+0x188]
   1819e9c0f:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1819e9c13:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1819e9c1a:	72 1f                	jb     0x1819e9c3b
   1819e9c1c:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1819e9c20:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1819e9c24:	4c 29 c1             	sub    rcx,r8
   1819e9c27:	48 83 f9 20          	cmp    rcx,0x20
   1819e9c2b:	0f 83 17 01 00 00    	jae    0x1819e9d48
   1819e9c31:	48 83 c0 28          	add    rax,0x28
   1819e9c35:	48 89 c2             	mov    rdx,rax
   1819e9c38:	4c 89 c1             	mov    rcx,r8
   1819e9c3b:	e8 e0 20 b6 05       	call   0x18754bd20
   1819e9c40:	90                   	nop
   1819e9c41:	b9 18 01 00 00       	mov    ecx,0x118
   1819e9c46:	e8 91 20 b6 05       	call   0x18754bcdc
   1819e9c4b:	90                   	nop
   1819e9c4c:	48 8d 15 ad 0c 00 00 	lea    rdx,[rip+0xcad]        # 0x1819ea900
   1819e9c53:	4c 8d 05 06 63 67 fe 	lea    r8,[rip+0xfffffffffe676306]        # 0x18005ff60
   1819e9c5a:	48 89 85 c8 01 00 00 	mov    QWORD PTR [rbp+0x1c8],rax
   1819e9c61:	48 89 c1             	mov    rcx,rax
   1819e9c64:	e8 b7 2c 72 fe       	call   0x18010c920
   1819e9c69:	90                   	nop
   1819e9c6a:	48 81 c6 48 04 00 00 	add    rsi,0x448
   1819e9c71:	48 8b 8d c8 01 00 00 	mov    rcx,QWORD PTR [rbp+0x1c8]
   1819e9c78:	48 83 c1 28          	add    rcx,0x28
   1819e9c7c:	48 89 f2             	mov    rdx,rsi
   1819e9c7f:	e8 2c 56 67 fe       	call   0x18005f2b0
   1819e9c84:	90                   	nop
   1819e9c85:	48 8b 85 c8 01 00 00 	mov    rax,QWORD PTR [rbp+0x1c8]
   1819e9c8c:	44 88 a0 10 01 00 00 	mov    BYTE PTR [rax+0x110],r12b
   1819e9c93:	48 89 85 f0 00 00 00 	mov    QWORD PTR [rbp+0xf0],rax
   1819e9c9a:	c6 85 f7 01 00 00 01 	mov    BYTE PTR [rbp+0x1f7],0x1
   1819e9ca1:	48 8d 15 78 c0 56 07 	lea    rdx,[rip+0x756c078]        # 0x188f55d20
   1819e9ca8:	4c 8d 05 99 5c 90 07 	lea    r8,[rip+0x7905c99]        # 0x1892ef948
   1819e9caf:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1819e9cb3:	41 b9 93 02 00 00    	mov    r9d,0x293
   1819e9cb9:	e8 32 7f 7b fe       	call   0x1801a1bf0
   1819e9cbe:	90                   	nop
   1819e9cbf:	c6 85 f7 01 00 00 00 	mov    BYTE PTR [rbp+0x1f7],0x0
   1819e9cc6:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   1819e9cca:	48 8d 95 f0 00 00 00 	lea    rdx,[rbp+0xf0]
   1819e9cd1:	45 31 c0             	xor    r8d,r8d
   1819e9cd4:	45 31 c9             	xor    r9d,r9d
   1819e9cd7:	e8 74 4d 9b fe       	call   0x18039ea50
   1819e9cdc:	90                   	nop
   1819e9cdd:	48 8b b5 78 01 00 00 	mov    rsi,QWORD PTR [rbp+0x178]
   1819e9ce4:	48 85 f6             	test   rsi,rsi
   1819e9ce7:	74 1d                	je     0x1819e9d06
   1819e9ce9:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1819e9ced:	75 17                	jne    0x1819e9d06
   1819e9cef:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1819e9cf2:	48 89 f1             	mov    rcx,rsi
   1819e9cf5:	ff 10                	call   QWORD PTR [rax]
   1819e9cf7:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1819e9cfb:	75 09                	jne    0x1819e9d06
   1819e9cfd:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1819e9d00:	48 89 f1             	mov    rcx,rsi
   1819e9d03:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1819e9d06:	48 8b b5 e8 01 00 00 	mov    rsi,QWORD PTR [rbp+0x1e8]
   1819e9d0d:	48 85 f6             	test   rsi,rsi
   1819e9d10:	74 1d                	je     0x1819e9d2f
   1819e9d12:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1819e9d16:	75 17                	jne    0x1819e9d2f
   1819e9d18:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1819e9d1b:	48 89 f1             	mov    rcx,rsi
   1819e9d1e:	ff 10                	call   QWORD PTR [rax]
   1819e9d20:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1819e9d24:	75 09                	jne    0x1819e9d2f
   1819e9d26:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1819e9d29:	48 89 f1             	mov    rcx,rsi
   1819e9d2c:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1819e9d2f:	0f 28 b5 00 02 00 00 	movaps xmm6,XMMWORD PTR [rbp+0x200]
   1819e9d36:	48 81 c4 90 02 00 00 	add    rsp,0x290
   1819e9d3d:	5b                   	pop    rbx
   1819e9d3e:	5f                   	pop    rdi
   1819e9d3f:	5e                   	pop    rsi
   1819e9d40:	41 5c                	pop    r12
   1819e9d42:	41 5e                	pop    r14
   1819e9d44:	41 5f                	pop    r15
   1819e9d46:	5d                   	pop    rbp
   1819e9d47:	c3                   	ret
   1819e9d48:	e8 3f 44 cf 05       	call   0x1876de18c
   1819e9d4d:	cc                   	int3
