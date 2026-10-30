
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

0000000185e09640 <.text+0x5e08640>:
   185e09640:	55                   	push   rbp
   185e09641:	41 57                	push   r15
   185e09643:	41 56                	push   r14
   185e09645:	41 55                	push   r13
   185e09647:	41 54                	push   r12
   185e09649:	56                   	push   rsi
   185e0964a:	57                   	push   rdi
   185e0964b:	53                   	push   rbx
   185e0964c:	48 81 ec 68 02 00 00 	sub    rsp,0x268
   185e09653:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   185e0965a:	00
   185e0965b:	48 c7 85 e0 01 00 00 	mov    QWORD PTR [rbp+0x1e0],0xfffffffffffffffe
   185e09662:	fe ff ff ff
   185e09666:	48 83 7a 18 00       	cmp    QWORD PTR [rdx+0x18],0x0
   185e0966b:	0f 84 86 05 00 00    	je     0x185e09bf7
   185e09671:	49 89 d6             	mov    r14,rdx
   185e09674:	48 89 ce             	mov    rsi,rcx
   185e09677:	80 b9 73 01 00 00 01 	cmp    BYTE PTR [rcx+0x173],0x1
   185e0967e:	75 0a                	jne    0x185e0968a
   185e09680:	48 89 f1             	mov    rcx,rsi
   185e09683:	31 d2                	xor    edx,edx
   185e09685:	e8 e6 e8 ff ff       	call   0x185e07f70
   185e0968a:	c6 86 72 01 00 00 01 	mov    BYTE PTR [rsi+0x172],0x1
   185e09691:	e8 7a c6 23 fa       	call   0x180045d10
   185e09696:	4c 8b 00             	mov    r8,QWORD PTR [rax]
   185e09699:	48 8d 95 60 01 00 00 	lea    rdx,[rbp+0x160]
   185e096a0:	48 89 c1             	mov    rcx,rax
   185e096a3:	41 ff 50 60          	call   QWORD PTR [r8+0x60]
   185e096a7:	48 8b 8d 60 01 00 00 	mov    rcx,QWORD PTR [rbp+0x160]
   185e096ae:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   185e096b1:	48 8d 95 50 01 00 00 	lea    rdx,[rbp+0x150]
   185e096b8:	ff 50 30             	call   QWORD PTR [rax+0x30]
   185e096bb:	90                   	nop
   185e096bc:	48 8b 8d 50 01 00 00 	mov    rcx,QWORD PTR [rbp+0x150]
   185e096c3:	48 8d 05 fe 48 d0 03 	lea    rax,[rip+0x3d048fe]        # 0x189b0dfc8
   185e096ca:	48 89 85 18 01 00 00 	mov    QWORD PTR [rbp+0x118],rax
   185e096d1:	0f 28 05 d8 d4 10 03 	movaps xmm0,XMMWORD PTR [rip+0x310d4d8]        # 0x188f16bb0
   185e096d8:	0f 29 85 80 00 00 00 	movaps XMMWORD PTR [rbp+0x80],xmm0
   185e096df:	48 8d 95 80 00 00 00 	lea    rdx,[rbp+0x80]
   185e096e6:	48 8d bd 18 01 00 00 	lea    rdi,[rbp+0x118]
   185e096ed:	49 89 f8             	mov    r8,rdi
   185e096f0:	e8 7b ca 39 fa       	call   0x1801a6170
   185e096f5:	90                   	nop
   185e096f6:	4d 8d 46 08          	lea    r8,[r14+0x8]
   185e096fa:	48 8b 85 80 00 00 00 	mov    rax,QWORD PTR [rbp+0x80]
   185e09701:	48 8b 8d 88 00 00 00 	mov    rcx,QWORD PTR [rbp+0x88]
   185e09708:	48 85 c9             	test   rcx,rcx
   185e0970b:	74 46                	je     0x185e09753
   185e0970d:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   185e09711:	48 8b 9d 88 00 00 00 	mov    rbx,QWORD PTR [rbp+0x88]
   185e09718:	48 89 85 c8 01 00 00 	mov    QWORD PTR [rbp+0x1c8],rax
   185e0971f:	48 89 9d d0 01 00 00 	mov    QWORD PTR [rbp+0x1d0],rbx
   185e09726:	48 85 db             	test   rbx,rbx
   185e09729:	74 3a                	je     0x185e09765
   185e0972b:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   185e0972f:	75 34                	jne    0x185e09765
   185e09731:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   185e09734:	48 89 d9             	mov    rcx,rbx
   185e09737:	4d 89 c7             	mov    r15,r8
   185e0973a:	ff 10                	call   QWORD PTR [rax]
   185e0973c:	4d 89 f8             	mov    r8,r15
   185e0973f:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   185e09743:	75 20                	jne    0x185e09765
   185e09745:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   185e09748:	48 89 d9             	mov    rcx,rbx
   185e0974b:	ff 50 08             	call   QWORD PTR [rax+0x8]
   185e0974e:	4d 89 f8             	mov    r8,r15
   185e09751:	eb 12                	jmp    0x185e09765
   185e09753:	48 89 85 c8 01 00 00 	mov    QWORD PTR [rbp+0x1c8],rax
   185e0975a:	48 c7 85 d0 01 00 00 	mov    QWORD PTR [rbp+0x1d0],0x0
   185e09761:	00 00 00 00
   185e09765:	48 8b 8d c8 01 00 00 	mov    rcx,QWORD PTR [rbp+0x1c8]
   185e0976c:	48 c7 85 28 01 00 00 	mov    QWORD PTR [rbp+0x128],0x0
   185e09773:	00 00 00 00
   185e09777:	48 b8 04 00 00 00 03 	movabs rax,0x300000004
   185e0977e:	00 00 00
   185e09781:	48 89 85 18 01 00 00 	mov    QWORD PTR [rbp+0x118],rax
   185e09788:	48 c7 85 20 01 00 00 	mov    QWORD PTR [rbp+0x120],0x7530
   185e0978f:	30 75 00 00
   185e09793:	0f 57 c0             	xorps  xmm0,xmm0
   185e09796:	0f 11 85 30 01 00 00 	movups XMMWORD PTR [rbp+0x130],xmm0
   185e0979d:	48 c7 85 40 01 00 00 	mov    QWORD PTR [rbp+0x140],0x0
   185e097a4:	00 00 00 00
   185e097a8:	48 c7 85 48 01 00 00 	mov    QWORD PTR [rbp+0x148],0xf
   185e097af:	0f 00 00 00
   185e097b3:	41 8b 06             	mov    eax,DWORD PTR [r14]
   185e097b6:	41 0f af 46 04       	imul   eax,DWORD PTR [r14+0x4]
   185e097bb:	48 8d 9e 48 02 00 00 	lea    rbx,[rsi+0x248]
   185e097c2:	48 89 7c 24 28       	mov    QWORD PTR [rsp+0x28],rdi
   185e097c7:	89 44 24 20          	mov    DWORD PTR [rsp+0x20],eax
   185e097cb:	48 8d 95 80 00 00 00 	lea    rdx,[rbp+0x80]
   185e097d2:	49 89 d9             	mov    r9,rbx
   185e097d5:	e8 76 6d ec 00       	call   0x186cd0550
   185e097da:	90                   	nop
   185e097db:	48 8d 15 8e 70 d0 03 	lea    rdx,[rip+0x3d0708e]        # 0x189b10870
   185e097e2:	4c 8d 05 37 65 d0 03 	lea    r8,[rip+0x3d06537]        # 0x189b0fd20
   185e097e9:	48 8d 7d e0          	lea    rdi,[rbp-0x20]
   185e097ed:	48 89 f9             	mov    rcx,rdi
   185e097f0:	41 b9 cb 01 00 00    	mov    r9d,0x1cb
   185e097f6:	e8 f5 83 39 fa       	call   0x1801a1bf0
   185e097fb:	90                   	nop
   185e097fc:	48 c7 45 38 00 00 00 	mov    QWORD PTR [rbp+0x38],0x0
   185e09803:	00
   185e09804:	48 8b 86 50 01 00 00 	mov    rax,QWORD PTR [rsi+0x150]
   185e0980b:	48 83 f8 02          	cmp    rax,0x2
   185e0980f:	0f 94 85 a0 01 00 00 	sete   BYTE PTR [rbp+0x1a0]
   185e09816:	41 8b 0e             	mov    ecx,DWORD PTR [r14]
   185e09819:	41 0f af 4e 04       	imul   ecx,DWORD PTR [r14+0x4]
   185e0981e:	89 8d a4 01 00 00    	mov    DWORD PTR [rbp+0x1a4],ecx
   185e09824:	0f 57 c0             	xorps  xmm0,xmm0
   185e09827:	0f 11 85 a8 01 00 00 	movups XMMWORD PTR [rbp+0x1a8],xmm0
   185e0982e:	0f 11 85 b8 01 00 00 	movups XMMWORD PTR [rbp+0x1b8],xmm0
   185e09835:	48 8b 96 48 02 00 00 	mov    rdx,QWORD PTR [rsi+0x248]
   185e0983c:	4c 8b be 58 02 00 00 	mov    r15,QWORD PTR [rsi+0x258]
   185e09843:	4c 8b 86 60 02 00 00 	mov    r8,QWORD PTR [rsi+0x260]
   185e0984a:	49 83 f8 10          	cmp    r8,0x10
   185e0984e:	49 89 dc             	mov    r12,rbx
   185e09851:	4c 0f 43 e2          	cmovae r12,rdx
   185e09855:	4d 85 ff             	test   r15,r15
   185e09858:	0f 88 ad 03 00 00    	js     0x185e09c0b
   185e0985e:	4c 8d ad a8 01 00 00 	lea    r13,[rbp+0x1a8]
   185e09865:	49 83 ff 0f          	cmp    r15,0xf
   185e09869:	77 21                	ja     0x185e0988c
   185e0986b:	4c 89 bd b8 01 00 00 	mov    QWORD PTR [rbp+0x1b8],r15
   185e09872:	48 c7 85 c0 01 00 00 	mov    QWORD PTR [rbp+0x1c0],0xf
   185e09879:	0f 00 00 00
   185e0987d:	41 0f 10 04 24       	movups xmm0,XMMWORD PTR [r12]
   185e09882:	41 0f 11 45 00       	movups XMMWORD PTR [r13+0x0],xmm0
   185e09887:	e9 a6 00 00 00       	jmp    0x185e09932
   185e0988c:	4c 89 f8             	mov    rax,r15
   185e0988f:	48 83 c8 0f          	or     rax,0xf
   185e09893:	48 83 f8 17          	cmp    rax,0x17
   185e09897:	bf 16 00 00 00       	mov    edi,0x16
   185e0989c:	48 0f 43 f8          	cmovae rdi,rax
   185e098a0:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   185e098a6:	72 2b                	jb     0x185e098d3
   185e098a8:	48 8d 4f 28          	lea    rcx,[rdi+0x28]
   185e098ac:	c6 85 de 01 00 00 01 	mov    BYTE PTR [rbp+0x1de],0x1
   185e098b3:	e8 24 24 74 01       	call   0x18754bcdc
   185e098b8:	90                   	nop
   185e098b9:	48 85 c0             	test   rax,rax
   185e098bc:	0f 84 63 03 00 00    	je     0x185e09c25
   185e098c2:	48 89 c1             	mov    rcx,rax
   185e098c5:	48 83 c0 27          	add    rax,0x27
   185e098c9:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
   185e098cd:	48 89 48 f8          	mov    QWORD PTR [rax-0x8],rcx
   185e098d1:	eb 11                	jmp    0x185e098e4
   185e098d3:	48 8d 4f 01          	lea    rcx,[rdi+0x1]
   185e098d7:	c6 85 de 01 00 00 01 	mov    BYTE PTR [rbp+0x1de],0x1
   185e098de:	e8 f9 23 74 01       	call   0x18754bcdc
   185e098e3:	90                   	nop
   185e098e4:	48 89 85 a8 01 00 00 	mov    QWORD PTR [rbp+0x1a8],rax
   185e098eb:	4c 89 bd b8 01 00 00 	mov    QWORD PTR [rbp+0x1b8],r15
   185e098f2:	48 89 bd c0 01 00 00 	mov    QWORD PTR [rbp+0x1c0],rdi
   185e098f9:	49 ff c7             	inc    r15
   185e098fc:	48 89 c1             	mov    rcx,rax
   185e098ff:	4c 89 e2             	mov    rdx,r12
   185e09902:	4d 89 f8             	mov    r8,r15
   185e09905:	e8 36 b5 90 01       	call   0x187714e40
   185e0990a:	48 8b 86 50 01 00 00 	mov    rax,QWORD PTR [rsi+0x150]
   185e09911:	48 8b 96 48 02 00 00 	mov    rdx,QWORD PTR [rsi+0x248]
   185e09918:	41 8b 0e             	mov    ecx,DWORD PTR [r14]
   185e0991b:	4c 8b be 58 02 00 00 	mov    r15,QWORD PTR [rsi+0x258]
   185e09922:	4c 8b 86 60 02 00 00 	mov    r8,QWORD PTR [rsi+0x260]
   185e09929:	41 0f af 4e 04       	imul   ecx,DWORD PTR [r14+0x4]
   185e0992e:	48 8d 7d e0          	lea    rdi,[rbp-0x20]
   185e09932:	4c 8d 0d 6f 48 d0 03 	lea    r9,[rip+0x3d0486f]        # 0x189b0e1a8
   185e09939:	4c 89 8d d8 00 00 00 	mov    QWORD PTR [rbp+0xd8],r9
   185e09940:	4c 8b 8d a0 01 00 00 	mov    r9,QWORD PTR [rbp+0x1a0]
   185e09947:	4c 89 8d e0 00 00 00 	mov    QWORD PTR [rbp+0xe0],r9
   185e0994e:	41 0f 10 45 00       	movups xmm0,XMMWORD PTR [r13+0x0]
   185e09953:	41 0f 10 4d 10       	movups xmm1,XMMWORD PTR [r13+0x10]
   185e09958:	0f 11 85 e8 00 00 00 	movups XMMWORD PTR [rbp+0xe8],xmm0
   185e0995f:	0f 11 8d f8 00 00 00 	movups XMMWORD PTR [rbp+0xf8],xmm1
   185e09966:	48 c7 85 b8 01 00 00 	mov    QWORD PTR [rbp+0x1b8],0x0
   185e0996d:	00 00 00 00
   185e09971:	48 c7 85 c0 01 00 00 	mov    QWORD PTR [rbp+0x1c0],0xf
   185e09978:	0f 00 00 00
   185e0997c:	c6 85 a8 01 00 00 00 	mov    BYTE PTR [rbp+0x1a8],0x0
   185e09983:	4c 8d 8d d8 00 00 00 	lea    r9,[rbp+0xd8]
   185e0998a:	4c 89 8d 10 01 00 00 	mov    QWORD PTR [rbp+0x110],r9
   185e09991:	48 83 f8 02          	cmp    rax,0x2
   185e09995:	0f 94 85 70 01 00 00 	sete   BYTE PTR [rbp+0x170]
   185e0999c:	89 8d 74 01 00 00    	mov    DWORD PTR [rbp+0x174],ecx
   185e099a2:	0f 57 c0             	xorps  xmm0,xmm0
   185e099a5:	0f 11 85 78 01 00 00 	movups XMMWORD PTR [rbp+0x178],xmm0
   185e099ac:	0f 11 85 88 01 00 00 	movups XMMWORD PTR [rbp+0x188],xmm0
   185e099b3:	49 83 f8 10          	cmp    r8,0x10
   185e099b7:	48 0f 43 da          	cmovae rbx,rdx
   185e099bb:	4d 85 ff             	test   r15,r15
   185e099be:	0f 88 54 02 00 00    	js     0x185e09c18
   185e099c4:	4c 8d b5 78 01 00 00 	lea    r14,[rbp+0x178]
   185e099cb:	49 83 ff 0f          	cmp    r15,0xf
   185e099cf:	77 1e                	ja     0x185e099ef
   185e099d1:	4c 89 bd 88 01 00 00 	mov    QWORD PTR [rbp+0x188],r15
   185e099d8:	48 c7 85 90 01 00 00 	mov    QWORD PTR [rbp+0x190],0xf
   185e099df:	0f 00 00 00
   185e099e3:	0f 10 03             	movups xmm0,XMMWORD PTR [rbx]
   185e099e6:	41 0f 11 06          	movups XMMWORD PTR [r14],xmm0
   185e099ea:	e9 84 00 00 00       	jmp    0x185e09a73
   185e099ef:	49 89 fc             	mov    r12,rdi
   185e099f2:	4c 89 f8             	mov    rax,r15
   185e099f5:	48 83 c8 0f          	or     rax,0xf
   185e099f9:	48 83 f8 17          	cmp    rax,0x17
   185e099fd:	bf 16 00 00 00       	mov    edi,0x16
   185e09a02:	48 0f 43 f8          	cmovae rdi,rax
   185e09a06:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   185e09a0c:	72 2b                	jb     0x185e09a39
   185e09a0e:	48 8d 4f 28          	lea    rcx,[rdi+0x28]
   185e09a12:	c6 85 df 01 00 00 01 	mov    BYTE PTR [rbp+0x1df],0x1
   185e09a19:	e8 be 22 74 01       	call   0x18754bcdc
   185e09a1e:	90                   	nop
   185e09a1f:	48 85 c0             	test   rax,rax
   185e09a22:	0f 84 fd 01 00 00    	je     0x185e09c25
   185e09a28:	48 89 c1             	mov    rcx,rax
   185e09a2b:	48 83 c0 27          	add    rax,0x27
   185e09a2f:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
   185e09a33:	48 89 48 f8          	mov    QWORD PTR [rax-0x8],rcx
   185e09a37:	eb 11                	jmp    0x185e09a4a
   185e09a39:	48 8d 4f 01          	lea    rcx,[rdi+0x1]
   185e09a3d:	c6 85 df 01 00 00 01 	mov    BYTE PTR [rbp+0x1df],0x1
   185e09a44:	e8 93 22 74 01       	call   0x18754bcdc
   185e09a49:	90                   	nop
   185e09a4a:	48 89 85 78 01 00 00 	mov    QWORD PTR [rbp+0x178],rax
   185e09a51:	4c 89 bd 88 01 00 00 	mov    QWORD PTR [rbp+0x188],r15
   185e09a58:	48 89 bd 90 01 00 00 	mov    QWORD PTR [rbp+0x190],rdi
   185e09a5f:	49 ff c7             	inc    r15
   185e09a62:	48 89 c1             	mov    rcx,rax
   185e09a65:	48 89 da             	mov    rdx,rbx
   185e09a68:	4d 89 f8             	mov    r8,r15
   185e09a6b:	e8 d0 b3 90 01       	call   0x187714e40
   185e09a70:	4c 89 e7             	mov    rdi,r12
   185e09a73:	48 89 b5 98 01 00 00 	mov    QWORD PTR [rbp+0x198],rsi
   185e09a7a:	48 8d 05 67 46 d0 03 	lea    rax,[rip+0x3d04667]        # 0x189b0e0e8
   185e09a81:	48 89 45 40          	mov    QWORD PTR [rbp+0x40],rax
   185e09a85:	48 8b 85 70 01 00 00 	mov    rax,QWORD PTR [rbp+0x170]
   185e09a8c:	48 89 45 48          	mov    QWORD PTR [rbp+0x48],rax
   185e09a90:	41 0f 10 06          	movups xmm0,XMMWORD PTR [r14]
   185e09a94:	41 0f 10 4e 10       	movups xmm1,XMMWORD PTR [r14+0x10]
   185e09a99:	0f 11 45 50          	movups XMMWORD PTR [rbp+0x50],xmm0
   185e09a9d:	0f 11 4d 60          	movups XMMWORD PTR [rbp+0x60],xmm1
   185e09aa1:	48 c7 85 88 01 00 00 	mov    QWORD PTR [rbp+0x188],0x0
   185e09aa8:	00 00 00 00
   185e09aac:	48 c7 85 90 01 00 00 	mov    QWORD PTR [rbp+0x190],0xf
   185e09ab3:	0f 00 00 00
   185e09ab7:	c6 85 78 01 00 00 00 	mov    BYTE PTR [rbp+0x178],0x0
   185e09abe:	48 89 75 70          	mov    QWORD PTR [rbp+0x70],rsi
   185e09ac2:	4c 8d 45 40          	lea    r8,[rbp+0x40]
   185e09ac6:	4c 89 45 78          	mov    QWORD PTR [rbp+0x78],r8
   185e09aca:	48 89 7c 24 28       	mov    QWORD PTR [rsp+0x28],rdi
   185e09acf:	48 89 e8             	mov    rax,rbp
   185e09ad2:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   185e09ad7:	48 8d bd 80 00 00 00 	lea    rdi,[rbp+0x80]
   185e09ade:	48 8d 55 b8          	lea    rdx,[rbp-0x48]
   185e09ae2:	4c 8d 8d d8 00 00 00 	lea    r9,[rbp+0xd8]
   185e09ae9:	48 89 f9             	mov    rcx,rdi
   185e09aec:	e8 6f b5 bd fb       	call   0x1819e5060
   185e09af1:	90                   	nop
   185e09af2:	48 81 c6 70 02 00 00 	add    rsi,0x270
   185e09af9:	48 8d 55 b8          	lea    rdx,[rbp-0x48]
   185e09afd:	48 89 f1             	mov    rcx,rsi
   185e09b00:	e8 7b f3 b1 fa       	call   0x180928e80
   185e09b05:	90                   	nop
   185e09b06:	48 8b 8d c8 00 00 00 	mov    rcx,QWORD PTR [rbp+0xc8]
   185e09b0d:	48 85 c9             	test   rcx,rcx
   185e09b10:	74 0c                	je     0x185e09b1e
   185e09b12:	f0 ff 49 0c          	lock dec DWORD PTR [rcx+0xc]
   185e09b16:	75 06                	jne    0x185e09b1e
   185e09b18:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   185e09b1b:	ff 50 08             	call   QWORD PTR [rax+0x8]
   185e09b1e:	48 8b 8d b8 00 00 00 	mov    rcx,QWORD PTR [rbp+0xb8]
   185e09b25:	48 85 c9             	test   rcx,rcx
   185e09b28:	74 0c                	je     0x185e09b36
   185e09b2a:	48 39 f9             	cmp    rcx,rdi
   185e09b2d:	0f 95 c2             	setne  dl
   185e09b30:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   185e09b33:	ff 50 20             	call   QWORD PTR [rax+0x20]
   185e09b36:	48 8b 85 48 01 00 00 	mov    rax,QWORD PTR [rbp+0x148]
   185e09b3d:	48 83 f8 10          	cmp    rax,0x10
   185e09b41:	72 38                	jb     0x185e09b7b
   185e09b43:	48 8b 8d 30 01 00 00 	mov    rcx,QWORD PTR [rbp+0x130]
   185e09b4a:	48 8d 50 01          	lea    rdx,[rax+0x1]
   185e09b4e:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   185e09b55:	72 1f                	jb     0x185e09b76
   185e09b57:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   185e09b5b:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   185e09b5f:	4c 29 c1             	sub    rcx,r8
   185e09b62:	48 83 f9 20          	cmp    rcx,0x20
   185e09b66:	0f 83 b9 00 00 00    	jae    0x185e09c25
   185e09b6c:	48 83 c0 28          	add    rax,0x28
   185e09b70:	48 89 c2             	mov    rdx,rax
   185e09b73:	4c 89 c1             	mov    rcx,r8
   185e09b76:	e8 a5 21 74 01       	call   0x18754bd20
   185e09b7b:	48 8b b5 d0 01 00 00 	mov    rsi,QWORD PTR [rbp+0x1d0]
   185e09b82:	48 85 f6             	test   rsi,rsi
   185e09b85:	74 1d                	je     0x185e09ba4
   185e09b87:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   185e09b8b:	75 17                	jne    0x185e09ba4
   185e09b8d:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   185e09b90:	48 89 f1             	mov    rcx,rsi
   185e09b93:	ff 10                	call   QWORD PTR [rax]
   185e09b95:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   185e09b99:	75 09                	jne    0x185e09ba4
   185e09b9b:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   185e09b9e:	48 89 f1             	mov    rcx,rsi
   185e09ba1:	ff 50 08             	call   QWORD PTR [rax+0x8]
   185e09ba4:	48 8b b5 58 01 00 00 	mov    rsi,QWORD PTR [rbp+0x158]
   185e09bab:	48 85 f6             	test   rsi,rsi
   185e09bae:	74 1d                	je     0x185e09bcd
   185e09bb0:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   185e09bb4:	75 17                	jne    0x185e09bcd
   185e09bb6:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   185e09bb9:	48 89 f1             	mov    rcx,rsi
   185e09bbc:	ff 10                	call   QWORD PTR [rax]
   185e09bbe:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   185e09bc2:	75 09                	jne    0x185e09bcd
   185e09bc4:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   185e09bc7:	48 89 f1             	mov    rcx,rsi
   185e09bca:	ff 50 08             	call   QWORD PTR [rax+0x8]
   185e09bcd:	48 8b b5 68 01 00 00 	mov    rsi,QWORD PTR [rbp+0x168]
   185e09bd4:	48 85 f6             	test   rsi,rsi
   185e09bd7:	74 1e                	je     0x185e09bf7
   185e09bd9:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   185e09bdd:	75 18                	jne    0x185e09bf7
   185e09bdf:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   185e09be2:	48 89 f1             	mov    rcx,rsi
   185e09be5:	ff 10                	call   QWORD PTR [rax]
   185e09be7:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   185e09beb:	75 0a                	jne    0x185e09bf7
   185e09bed:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   185e09bf0:	48 89 f1             	mov    rcx,rsi
   185e09bf3:	ff 50 08             	call   QWORD PTR [rax+0x8]
   185e09bf6:	90                   	nop
   185e09bf7:	48 81 c4 68 02 00 00 	add    rsp,0x268
   185e09bfe:	5b                   	pop    rbx
   185e09bff:	5f                   	pop    rdi
   185e09c00:	5e                   	pop    rsi
   185e09c01:	41 5c                	pop    r12
   185e09c03:	41 5d                	pop    r13
   185e09c05:	41 5e                	pop    r14
   185e09c07:	41 5f                	pop    r15
   185e09c09:	5d                   	pop    rbp
   185e09c0a:	c3                   	ret
   185e09c0b:	c6 85 de 01 00 00 01 	mov    BYTE PTR [rbp+0x1de],0x1
   185e09c12:	e8 79 ef 1f fa       	call   0x180008b90
   185e09c17:	90                   	nop
   185e09c18:	c6 85 df 01 00 00 01 	mov    BYTE PTR [rbp+0x1df],0x1
   185e09c1f:	e8 6c ef 1f fa       	call   0x180008b90
   185e09c24:	90                   	nop
   185e09c25:	e8 62 45 8d 01       	call   0x1876de18c
   185e09c2a:	cc                   	int3
