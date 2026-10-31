
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001817a87b0 <.text+0x17a77b0>:
   1817a87b0:	55                   	push   rbp
   1817a87b1:	41 57                	push   r15
   1817a87b3:	41 56                	push   r14
   1817a87b5:	41 55                	push   r13
   1817a87b7:	41 54                	push   r12
   1817a87b9:	56                   	push   rsi
   1817a87ba:	57                   	push   rdi
   1817a87bb:	53                   	push   rbx
   1817a87bc:	48 81 ec 78 04 00 00 	sub    rsp,0x478
   1817a87c3:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   1817a87ca:	00 
   1817a87cb:	0f 29 b5 e0 03 00 00 	movaps XMMWORD PTR [rbp+0x3e0],xmm6
   1817a87d2:	48 c7 85 d8 03 00 00 	mov    QWORD PTR [rbp+0x3d8],0xfffffffffffffffe
   1817a87d9:	fe ff ff ff 
   1817a87dd:	48 89 d7             	mov    rdi,rdx
   1817a87e0:	48 89 ce             	mov    rsi,rcx
   1817a87e3:	48 8b 5a 10          	mov    rbx,QWORD PTR [rdx+0x10]
   1817a87e7:	48 83 7a 18 10       	cmp    QWORD PTR [rdx+0x18],0x10
   1817a87ec:	49 89 d6             	mov    r14,rdx
   1817a87ef:	72 03                	jb     0x1817a87f4
   1817a87f1:	4c 8b 37             	mov    r14,QWORD PTR [rdi]
   1817a87f4:	48 8b 86 f8 0b 00 00 	mov    rax,QWORD PTR [rsi+0xbf8]
   1817a87fb:	48 85 db             	test   rbx,rbx
   1817a87fe:	74 24                	je     0x1817a8824
   1817a8800:	89 d9                	mov    ecx,ebx
   1817a8802:	83 e1 03             	and    ecx,0x3
   1817a8805:	49 b8 b3 01 00 00 00 	movabs r8,0x100000001b3
   1817a880c:	01 00 00 
   1817a880f:	48 83 fb 04          	cmp    rbx,0x4
   1817a8813:	73 1e                	jae    0x1817a8833
   1817a8815:	48 ba 25 23 22 84 e4 	movabs rdx,0xcbf29ce484222325
   1817a881c:	9c f2 cb 
   1817a881f:	45 31 c9             	xor    r9d,r9d
   1817a8822:	eb 6d                	jmp    0x1817a8891
   1817a8824:	48 ba 25 23 22 84 e4 	movabs rdx,0xcbf29ce484222325
   1817a882b:	9c f2 cb 
   1817a882e:	e9 81 00 00 00       	jmp    0x1817a88b4
   1817a8833:	49 89 da             	mov    r10,rbx
   1817a8836:	49 83 e2 fc          	and    r10,0xfffffffffffffffc
   1817a883a:	48 ba 25 23 22 84 e4 	movabs rdx,0xcbf29ce484222325
   1817a8841:	9c f2 cb 
   1817a8844:	45 31 c9             	xor    r9d,r9d
   1817a8847:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
   1817a884e:	00 00 
   1817a8850:	47 0f b6 1c 0e       	movzx  r11d,BYTE PTR [r14+r9*1]
   1817a8855:	4c 31 da             	xor    rdx,r11
   1817a8858:	49 0f af d0          	imul   rdx,r8
   1817a885c:	47 0f b6 5c 0e 01    	movzx  r11d,BYTE PTR [r14+r9*1+0x1]
   1817a8862:	49 31 d3             	xor    r11,rdx
   1817a8865:	4d 0f af d8          	imul   r11,r8
   1817a8869:	47 0f b6 7c 0e 02    	movzx  r15d,BYTE PTR [r14+r9*1+0x2]
   1817a886f:	4d 31 df             	xor    r15,r11
   1817a8872:	4d 0f af f8          	imul   r15,r8
   1817a8876:	43 0f b6 54 0e 03    	movzx  edx,BYTE PTR [r14+r9*1+0x3]
   1817a887c:	4c 31 fa             	xor    rdx,r15
   1817a887f:	49 0f af d0          	imul   rdx,r8
   1817a8883:	49 83 c1 04          	add    r9,0x4
   1817a8887:	4d 39 ca             	cmp    r10,r9
   1817a888a:	75 c4                	jne    0x1817a8850
   1817a888c:	48 85 c9             	test   rcx,rcx
   1817a888f:	74 23                	je     0x1817a88b4
   1817a8891:	4d 01 f1             	add    r9,r14
   1817a8894:	45 31 d2             	xor    r10d,r10d
   1817a8897:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
   1817a889e:	00 00 
   1817a88a0:	47 0f b6 1c 11       	movzx  r11d,BYTE PTR [r9+r10*1]
   1817a88a5:	4c 31 da             	xor    rdx,r11
   1817a88a8:	49 0f af d0          	imul   rdx,r8
   1817a88ac:	49 ff c2             	inc    r10
   1817a88af:	4c 39 d1             	cmp    rcx,r10
   1817a88b2:	75 ec                	jne    0x1817a88a0
   1817a88b4:	48 23 90 c0 00 00 00 	and    rdx,QWORD PTR [rax+0xc0]
   1817a88bb:	4c 8b a0 98 00 00 00 	mov    r12,QWORD PTR [rax+0x98]
   1817a88c2:	48 8b 80 a8 00 00 00 	mov    rax,QWORD PTR [rax+0xa8]
   1817a88c9:	48 c1 e2 04          	shl    rdx,0x4
   1817a88cd:	4c 8b 7c 10 08       	mov    r15,QWORD PTR [rax+rdx*1+0x8]
   1817a88d2:	4d 39 e7             	cmp    r15,r12
   1817a88d5:	0f 84 cd 11 00 00    	je     0x1817a9aa8
   1817a88db:	4c 8b 2c 10          	mov    r13,QWORD PTR [rax+rdx*1]
   1817a88df:	48 85 db             	test   rbx,rbx
   1817a88e2:	74 69                	je     0x1817a894d
   1817a88e4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   1817a88eb:	00 00 00 00 00 
   1817a88f0:	49 3b 5f 20          	cmp    rbx,QWORD PTR [r15+0x20]
   1817a88f4:	75 2d                	jne    0x1817a8923
   1817a88f6:	49 83 7f 28 10       	cmp    QWORD PTR [r15+0x28],0x10
   1817a88fb:	72 13                	jb     0x1817a8910
   1817a88fd:	49 8b 57 10          	mov    rdx,QWORD PTR [r15+0x10]
   1817a8901:	eb 11                	jmp    0x1817a8914
   1817a8903:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   1817a890a:	84 00 00 00 00 00 
   1817a8910:	49 8d 57 10          	lea    rdx,[r15+0x10]
   1817a8914:	4c 89 f1             	mov    rcx,r14
   1817a8917:	49 89 d8             	mov    r8,rbx
   1817a891a:	e8 21 c4 f6 05       	call   0x187714d40
   1817a891f:	85 c0                	test   eax,eax
   1817a8921:	74 31                	je     0x1817a8954
   1817a8923:	4d 39 ef             	cmp    r15,r13
   1817a8926:	0f 84 7c 11 00 00    	je     0x1817a9aa8
   1817a892c:	4d 8b 7f 08          	mov    r15,QWORD PTR [r15+0x8]
   1817a8930:	49 3b 5f 20          	cmp    rbx,QWORD PTR [r15+0x20]
   1817a8934:	74 c0                	je     0x1817a88f6
   1817a8936:	eb eb                	jmp    0x1817a8923
   1817a8938:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
   1817a893f:	00 
   1817a8940:	4d 39 ef             	cmp    r15,r13
   1817a8943:	0f 84 5f 11 00 00    	je     0x1817a9aa8
   1817a8949:	4d 8b 7f 08          	mov    r15,QWORD PTR [r15+0x8]
   1817a894d:	49 83 7f 20 00       	cmp    QWORD PTR [r15+0x20],0x0
   1817a8952:	75 ec                	jne    0x1817a8940
   1817a8954:	4d 85 ff             	test   r15,r15
   1817a8957:	0f 84 4b 11 00 00    	je     0x1817a9aa8
   1817a895d:	4d 39 e7             	cmp    r15,r12
   1817a8960:	0f 84 42 11 00 00    	je     0x1817a9aa8
   1817a8966:	0f 57 c0             	xorps  xmm0,xmm0
   1817a8969:	0f 29 85 c0 03 00 00 	movaps XMMWORD PTR [rbp+0x3c0],xmm0
   1817a8970:	4d 8b 77 30          	mov    r14,QWORD PTR [r15+0x30]
   1817a8974:	49 8b 5f 38          	mov    rbx,QWORD PTR [r15+0x38]
   1817a8978:	49 39 de             	cmp    r14,rbx
   1817a897b:	0f 84 18 04 00 00    	je     0x1817a8d99
   1817a8981:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   1817a8988:	0f 1f 84 00 00 00 00 
   1817a898f:	00 
   1817a8990:	49 8b 0e             	mov    rcx,QWORD PTR [r14]
   1817a8993:	e8 c8 c4 79 ff       	call   0x180f44e60
   1817a8998:	90                   	nop
   1817a8999:	85 c0                	test   eax,eax
   1817a899b:	74 0e                	je     0x1817a89ab
   1817a899d:	49 8b 0e             	mov    rcx,QWORD PTR [r14]
   1817a89a0:	e8 bb c4 79 ff       	call   0x180f44e60
   1817a89a5:	90                   	nop
   1817a89a6:	83 f8 03             	cmp    eax,0x3
   1817a89a9:	76 71                	jbe    0x1817a8a1c
   1817a89ab:	49 8b 0e             	mov    rcx,QWORD PTR [r14]
   1817a89ae:	e8 ad c4 79 ff       	call   0x180f44e60
   1817a89b3:	90                   	nop
   1817a89b4:	85 c0                	test   eax,eax
   1817a89b6:	74 0e                	je     0x1817a89c6
   1817a89b8:	49 83 c6 10          	add    r14,0x10
   1817a89bc:	49 39 de             	cmp    r14,rbx
   1817a89bf:	75 cf                	jne    0x1817a8990
   1817a89c1:	e9 d3 03 00 00       	jmp    0x1817a8d99
   1817a89c6:	49 8b 46 08          	mov    rax,QWORD PTR [r14+0x8]
   1817a89ca:	48 85 c0             	test   rax,rax
   1817a89cd:	0f 84 d3 01 00 00    	je     0x1817a8ba6
   1817a89d3:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1817a89d7:	48 8b 9d c8 03 00 00 	mov    rbx,QWORD PTR [rbp+0x3c8]
   1817a89de:	41 0f 10 06          	movups xmm0,XMMWORD PTR [r14]
   1817a89e2:	0f 29 85 c0 03 00 00 	movaps XMMWORD PTR [rbp+0x3c0],xmm0
   1817a89e9:	48 85 db             	test   rbx,rbx
   1817a89ec:	0f 84 c9 01 00 00    	je     0x1817a8bbb
   1817a89f2:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   1817a89f6:	0f 85 bf 01 00 00    	jne    0x1817a8bbb
   1817a89fc:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   1817a89ff:	48 89 d9             	mov    rcx,rbx
   1817a8a02:	ff 10                	call   QWORD PTR [rax]
   1817a8a04:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   1817a8a08:	0f 85 ad 01 00 00    	jne    0x1817a8bbb
   1817a8a0e:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   1817a8a11:	48 89 d9             	mov    rcx,rbx
   1817a8a14:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1817a8a17:	e9 9f 01 00 00       	jmp    0x1817a8bbb
   1817a8a1c:	b9 02 00 00 00       	mov    ecx,0x2
   1817a8a21:	e8 ba 43 8c fe       	call   0x18006cde0
   1817a8a26:	85 c0                	test   eax,eax
   1817a8a28:	0f 84 51 10 00 00    	je     0x1817a9a7f
   1817a8a2e:	48 8d b5 90 02 00 00 	lea    rsi,[rbp+0x290]
   1817a8a35:	48 89 f1             	mov    rcx,rsi
   1817a8a38:	e8 d3 44 8c fe       	call   0x18006cf10
   1817a8a3d:	90                   	nop
   1817a8a3e:	48 83 bd a8 02 00 00 	cmp    QWORD PTR [rbp+0x2a8],0x10
   1817a8a45:	10 
   1817a8a46:	72 07                	jb     0x1817a8a4f
   1817a8a48:	48 8b b5 90 02 00 00 	mov    rsi,QWORD PTR [rbp+0x290]
   1817a8a4f:	48 8d 05 ba e0 b0 07 	lea    rax,[rip+0x7b0e0ba]        # 0x1892b6b10
   1817a8a56:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1817a8a5b:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1817a8a62:	00 00 
   1817a8a64:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1817a8a69:	c7 44 24 28 2d 10 00 	mov    DWORD PTR [rsp+0x28],0x102d
   1817a8a70:	00 
   1817a8a71:	4c 8d 0d 08 b1 b0 07 	lea    r9,[rip+0x7b0b108]        # 0x1892b3b80
   1817a8a78:	48 8d 8d 60 01 00 00 	lea    rcx,[rbp+0x160]
   1817a8a7f:	ba 02 00 00 00       	mov    edx,0x2
   1817a8a84:	49 89 f0             	mov    r8,rsi
   1817a8a87:	e8 e4 47 8c fe       	call   0x18006d270
   1817a8a8c:	90                   	nop
   1817a8a8d:	49 8b 0e             	mov    rcx,QWORD PTR [r14]
   1817a8a90:	48 8d b5 f0 01 00 00 	lea    rsi,[rbp+0x1f0]
   1817a8a97:	48 89 f2             	mov    rdx,rsi
   1817a8a9a:	e8 c1 44 23 02       	call   0x1839dcf60
   1817a8a9f:	90                   	nop
   1817a8aa0:	48 83 bd 08 02 00 00 	cmp    QWORD PTR [rbp+0x208],0x10
   1817a8aa7:	10 
   1817a8aa8:	72 07                	jb     0x1817a8ab1
   1817a8aaa:	48 8b b5 f0 01 00 00 	mov    rsi,QWORD PTR [rbp+0x1f0]
   1817a8ab1:	48 89 b5 40 02 00 00 	mov    QWORD PTR [rbp+0x240],rsi
   1817a8ab8:	c6 85 48 02 00 00 00 	mov    BYTE PTR [rbp+0x248],0x0
   1817a8abf:	0f 57 c0             	xorps  xmm0,xmm0
   1817a8ac2:	0f 11 85 88 03 00 00 	movups XMMWORD PTR [rbp+0x388],xmm0
   1817a8ac9:	0f 11 85 78 03 00 00 	movups XMMWORD PTR [rbp+0x378],xmm0
   1817a8ad0:	0f 11 85 68 03 00 00 	movups XMMWORD PTR [rbp+0x368],xmm0
   1817a8ad7:	0f 11 85 58 03 00 00 	movups XMMWORD PTR [rbp+0x358],xmm0
   1817a8ade:	0f 11 85 48 03 00 00 	movups XMMWORD PTR [rbp+0x348],xmm0
   1817a8ae5:	0f 11 85 38 03 00 00 	movups XMMWORD PTR [rbp+0x338],xmm0
   1817a8aec:	0f 11 85 28 03 00 00 	movups XMMWORD PTR [rbp+0x328],xmm0
   1817a8af3:	48 c7 85 98 03 00 00 	mov    QWORD PTR [rbp+0x398],0x0
   1817a8afa:	00 00 00 00 
   1817a8afe:	48 8d 85 40 02 00 00 	lea    rax,[rbp+0x240]
   1817a8b05:	48 89 85 20 03 00 00 	mov    QWORD PTR [rbp+0x320],rax
   1817a8b0c:	48 8d 15 15 5f b1 07 	lea    rdx,[rip+0x7b15f15]        # 0x1892bea28
   1817a8b13:	48 8d 8d 60 01 00 00 	lea    rcx,[rbp+0x160]
   1817a8b1a:	4c 8d 85 20 03 00 00 	lea    r8,[rbp+0x320]
   1817a8b21:	e8 ea 4c 8c fe       	call   0x18006d810
   1817a8b26:	90                   	nop
   1817a8b27:	48 8b 85 08 02 00 00 	mov    rax,QWORD PTR [rbp+0x208]
   1817a8b2e:	48 83 f8 10          	cmp    rax,0x10
   1817a8b32:	72 38                	jb     0x1817a8b6c
   1817a8b34:	48 8b 8d f0 01 00 00 	mov    rcx,QWORD PTR [rbp+0x1f0]
   1817a8b3b:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1817a8b3f:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1817a8b46:	72 1f                	jb     0x1817a8b67
   1817a8b48:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1817a8b4c:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1817a8b50:	4c 29 c1             	sub    rcx,r8
   1817a8b53:	48 83 f9 20          	cmp    rcx,0x20
   1817a8b57:	0f 83 cb 13 00 00    	jae    0x1817a9f28
   1817a8b5d:	48 83 c0 28          	add    rax,0x28
   1817a8b61:	48 89 c2             	mov    rdx,rax
   1817a8b64:	4c 89 c1             	mov    rcx,r8
   1817a8b67:	e8 b4 31 da 05       	call   0x18754bd20
   1817a8b6c:	48 8d 8d 60 01 00 00 	lea    rcx,[rbp+0x160]
   1817a8b73:	e8 f8 47 8c fe       	call   0x18006d370
   1817a8b78:	48 8b 85 a8 02 00 00 	mov    rax,QWORD PTR [rbp+0x2a8]
   1817a8b7f:	48 83 f8 10          	cmp    rax,0x10
   1817a8b83:	0f 82 f6 0e 00 00    	jb     0x1817a9a7f
   1817a8b89:	48 8b 8d 90 02 00 00 	mov    rcx,QWORD PTR [rbp+0x290]
   1817a8b90:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1817a8b94:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1817a8b9b:	0f 83 f0 02 00 00    	jae    0x1817a8e91
   1817a8ba1:	e9 0a 03 00 00       	jmp    0x1817a8eb0
   1817a8ba6:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1817a8ba9:	48 89 85 c0 03 00 00 	mov    QWORD PTR [rbp+0x3c0],rax
   1817a8bb0:	48 c7 85 c8 03 00 00 	mov    QWORD PTR [rbp+0x3c8],0x0
   1817a8bb7:	00 00 00 00 
   1817a8bbb:	b9 02 00 00 00       	mov    ecx,0x2
   1817a8bc0:	e8 1b 42 8c fe       	call   0x18006cde0
   1817a8bc5:	85 c0                	test   eax,eax
   1817a8bc7:	0f 84 98 01 00 00    	je     0x1817a8d65
   1817a8bcd:	48 8d 9d 90 02 00 00 	lea    rbx,[rbp+0x290]
   1817a8bd4:	48 89 d9             	mov    rcx,rbx
   1817a8bd7:	e8 34 43 8c fe       	call   0x18006cf10
   1817a8bdc:	90                   	nop
   1817a8bdd:	48 83 bd a8 02 00 00 	cmp    QWORD PTR [rbp+0x2a8],0x10
   1817a8be4:	10 
   1817a8be5:	72 07                	jb     0x1817a8bee
   1817a8be7:	48 8b 9d 90 02 00 00 	mov    rbx,QWORD PTR [rbp+0x290]
   1817a8bee:	48 8d 05 1b df b0 07 	lea    rax,[rip+0x7b0df1b]        # 0x1892b6b10
   1817a8bf5:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1817a8bfa:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1817a8c01:	00 00 
   1817a8c03:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1817a8c08:	c7 44 24 28 34 10 00 	mov    DWORD PTR [rsp+0x28],0x1034
   1817a8c0f:	00 
   1817a8c10:	4c 8d 0d 69 af b0 07 	lea    r9,[rip+0x7b0af69]        # 0x1892b3b80
   1817a8c17:	48 8d 8d 60 01 00 00 	lea    rcx,[rbp+0x160]
   1817a8c1e:	ba 02 00 00 00       	mov    edx,0x2
   1817a8c23:	49 89 d8             	mov    r8,rbx
   1817a8c26:	e8 45 46 8c fe       	call   0x18006d270
   1817a8c2b:	90                   	nop
   1817a8c2c:	48 8b 9d c0 03 00 00 	mov    rbx,QWORD PTR [rbp+0x3c0]
   1817a8c33:	4c 8d b5 f0 01 00 00 	lea    r14,[rbp+0x1f0]
   1817a8c3a:	48 89 d9             	mov    rcx,rbx
   1817a8c3d:	4c 89 f2             	mov    rdx,r14
   1817a8c40:	e8 1b 43 23 02       	call   0x1839dcf60
   1817a8c45:	90                   	nop
   1817a8c46:	48 83 bd 08 02 00 00 	cmp    QWORD PTR [rbp+0x208],0x10
   1817a8c4d:	10 
   1817a8c4e:	72 07                	jb     0x1817a8c57
   1817a8c50:	4c 8b b5 f0 01 00 00 	mov    r14,QWORD PTR [rbp+0x1f0]
   1817a8c57:	4c 89 b5 40 02 00 00 	mov    QWORD PTR [rbp+0x240],r14
   1817a8c5e:	c6 85 48 02 00 00 00 	mov    BYTE PTR [rbp+0x248],0x0
   1817a8c65:	0f 57 c0             	xorps  xmm0,xmm0
   1817a8c68:	0f 11 85 88 03 00 00 	movups XMMWORD PTR [rbp+0x388],xmm0
   1817a8c6f:	0f 11 85 78 03 00 00 	movups XMMWORD PTR [rbp+0x378],xmm0
   1817a8c76:	0f 11 85 68 03 00 00 	movups XMMWORD PTR [rbp+0x368],xmm0
   1817a8c7d:	0f 11 85 58 03 00 00 	movups XMMWORD PTR [rbp+0x358],xmm0
   1817a8c84:	0f 11 85 48 03 00 00 	movups XMMWORD PTR [rbp+0x348],xmm0
   1817a8c8b:	0f 11 85 38 03 00 00 	movups XMMWORD PTR [rbp+0x338],xmm0
   1817a8c92:	0f 11 85 28 03 00 00 	movups XMMWORD PTR [rbp+0x328],xmm0
   1817a8c99:	48 c7 85 98 03 00 00 	mov    QWORD PTR [rbp+0x398],0x0
   1817a8ca0:	00 00 00 00 
   1817a8ca4:	48 8d 85 40 02 00 00 	lea    rax,[rbp+0x240]
   1817a8cab:	48 89 85 20 03 00 00 	mov    QWORD PTR [rbp+0x320],rax
   1817a8cb2:	48 8d 15 af 5d b1 07 	lea    rdx,[rip+0x7b15daf]        # 0x1892bea68
   1817a8cb9:	48 8d 8d 60 01 00 00 	lea    rcx,[rbp+0x160]
   1817a8cc0:	4c 8d 85 20 03 00 00 	lea    r8,[rbp+0x320]
   1817a8cc7:	e8 44 4b 8c fe       	call   0x18006d810
   1817a8ccc:	90                   	nop
   1817a8ccd:	48 8b 85 08 02 00 00 	mov    rax,QWORD PTR [rbp+0x208]
   1817a8cd4:	48 83 f8 10          	cmp    rax,0x10
   1817a8cd8:	72 38                	jb     0x1817a8d12
   1817a8cda:	48 8b 8d f0 01 00 00 	mov    rcx,QWORD PTR [rbp+0x1f0]
   1817a8ce1:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1817a8ce5:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1817a8cec:	72 1f                	jb     0x1817a8d0d
   1817a8cee:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1817a8cf2:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1817a8cf6:	4c 29 c1             	sub    rcx,r8
   1817a8cf9:	48 83 f9 20          	cmp    rcx,0x20
   1817a8cfd:	0f 83 25 12 00 00    	jae    0x1817a9f28
   1817a8d03:	48 83 c0 28          	add    rax,0x28
   1817a8d07:	48 89 c2             	mov    rdx,rax
   1817a8d0a:	4c 89 c1             	mov    rcx,r8
   1817a8d0d:	e8 0e 30 da 05       	call   0x18754bd20
   1817a8d12:	48 8d 8d 60 01 00 00 	lea    rcx,[rbp+0x160]
   1817a8d19:	e8 52 46 8c fe       	call   0x18006d370
   1817a8d1e:	48 8b 85 a8 02 00 00 	mov    rax,QWORD PTR [rbp+0x2a8]
   1817a8d25:	48 83 f8 10          	cmp    rax,0x10
   1817a8d29:	72 41                	jb     0x1817a8d6c
   1817a8d2b:	48 8b 8d 90 02 00 00 	mov    rcx,QWORD PTR [rbp+0x290]
   1817a8d32:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1817a8d36:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1817a8d3d:	72 1f                	jb     0x1817a8d5e
   1817a8d3f:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1817a8d43:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1817a8d47:	4c 29 c1             	sub    rcx,r8
   1817a8d4a:	48 83 f9 20          	cmp    rcx,0x20
   1817a8d4e:	0f 83 d4 11 00 00    	jae    0x1817a9f28
   1817a8d54:	48 83 c0 28          	add    rax,0x28
   1817a8d58:	48 89 c2             	mov    rdx,rax
   1817a8d5b:	4c 89 c1             	mov    rcx,r8
   1817a8d5e:	e8 bd 2f da 05       	call   0x18754bd20
   1817a8d63:	eb 07                	jmp    0x1817a8d6c
   1817a8d65:	48 8b 9d c0 03 00 00 	mov    rbx,QWORD PTR [rbp+0x3c0]
   1817a8d6c:	48 85 db             	test   rbx,rbx
   1817a8d6f:	74 28                	je     0x1817a8d99
   1817a8d71:	0f 28 35 38 de 76 07 	movaps xmm6,XMMWORD PTR [rip+0x776de38]        # 0x188f16bb0
   1817a8d78:	0f 29 b5 b0 03 00 00 	movaps XMMWORD PTR [rbp+0x3b0],xmm6
   1817a8d7f:	48 8b 43 20          	mov    rax,QWORD PTR [rbx+0x20]
   1817a8d83:	48 85 c0             	test   rax,rax
   1817a8d86:	0f 84 2e 01 00 00    	je     0x1817a8eba
   1817a8d8c:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1817a8d90:	48 8b 43 20          	mov    rax,QWORD PTR [rbx+0x20]
   1817a8d94:	e9 23 01 00 00       	jmp    0x1817a8ebc
   1817a8d99:	b9 02 00 00 00       	mov    ecx,0x2
   1817a8d9e:	e8 3d 40 8c fe       	call   0x18006cde0
   1817a8da3:	85 c0                	test   eax,eax
   1817a8da5:	0f 84 d4 0c 00 00    	je     0x1817a9a7f
   1817a8dab:	48 8d b5 40 02 00 00 	lea    rsi,[rbp+0x240]
   1817a8db2:	48 89 f1             	mov    rcx,rsi
   1817a8db5:	e8 56 41 8c fe       	call   0x18006cf10
   1817a8dba:	90                   	nop
   1817a8dbb:	48 83 bd 58 02 00 00 	cmp    QWORD PTR [rbp+0x258],0x10
   1817a8dc2:	10 
   1817a8dc3:	72 07                	jb     0x1817a8dcc
   1817a8dc5:	48 8b b5 40 02 00 00 	mov    rsi,QWORD PTR [rbp+0x240]
   1817a8dcc:	48 8d 05 3d dd b0 07 	lea    rax,[rip+0x7b0dd3d]        # 0x1892b6b10
   1817a8dd3:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1817a8dd8:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1817a8ddf:	00 00 
   1817a8de1:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1817a8de6:	c7 44 24 28 3a 10 00 	mov    DWORD PTR [rsp+0x28],0x103a
   1817a8ded:	00 
   1817a8dee:	4c 8d 0d 8b ad b0 07 	lea    r9,[rip+0x7b0ad8b]        # 0x1892b3b80
   1817a8df5:	48 8d 8d 60 01 00 00 	lea    rcx,[rbp+0x160]
   1817a8dfc:	ba 02 00 00 00       	mov    edx,0x2
   1817a8e01:	49 89 f0             	mov    r8,rsi
   1817a8e04:	e8 67 44 8c fe       	call   0x18006d270
   1817a8e09:	90                   	nop
   1817a8e0a:	0f 57 c0             	xorps  xmm0,xmm0
   1817a8e0d:	0f 29 85 90 03 00 00 	movaps XMMWORD PTR [rbp+0x390],xmm0
   1817a8e14:	0f 29 85 80 03 00 00 	movaps XMMWORD PTR [rbp+0x380],xmm0
   1817a8e1b:	0f 29 85 70 03 00 00 	movaps XMMWORD PTR [rbp+0x370],xmm0
   1817a8e22:	0f 29 85 60 03 00 00 	movaps XMMWORD PTR [rbp+0x360],xmm0
   1817a8e29:	0f 29 85 50 03 00 00 	movaps XMMWORD PTR [rbp+0x350],xmm0
   1817a8e30:	0f 29 85 40 03 00 00 	movaps XMMWORD PTR [rbp+0x340],xmm0
   1817a8e37:	0f 29 85 30 03 00 00 	movaps XMMWORD PTR [rbp+0x330],xmm0
   1817a8e3e:	0f 29 85 20 03 00 00 	movaps XMMWORD PTR [rbp+0x320],xmm0
   1817a8e45:	48 8d 15 04 b5 b0 07 	lea    rdx,[rip+0x7b0b504]        # 0x1892b4350
   1817a8e4c:	48 8d 8d 60 01 00 00 	lea    rcx,[rbp+0x160]
   1817a8e53:	4c 8d 85 20 03 00 00 	lea    r8,[rbp+0x320]
   1817a8e5a:	e8 b1 49 8c fe       	call   0x18006d810
   1817a8e5f:	90                   	nop
   1817a8e60:	48 8d 8d 60 01 00 00 	lea    rcx,[rbp+0x160]
   1817a8e67:	e8 04 45 8c fe       	call   0x18006d370
   1817a8e6c:	48 8b 85 58 02 00 00 	mov    rax,QWORD PTR [rbp+0x258]
   1817a8e73:	48 83 f8 10          	cmp    rax,0x10
   1817a8e77:	0f 82 02 0c 00 00    	jb     0x1817a9a7f
   1817a8e7d:	48 8b 8d 40 02 00 00 	mov    rcx,QWORD PTR [rbp+0x240]
   1817a8e84:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1817a8e88:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1817a8e8f:	72 1f                	jb     0x1817a8eb0
   1817a8e91:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1817a8e95:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1817a8e99:	4c 29 c1             	sub    rcx,r8
   1817a8e9c:	48 83 f9 20          	cmp    rcx,0x20
   1817a8ea0:	0f 83 82 10 00 00    	jae    0x1817a9f28
   1817a8ea6:	48 83 c0 28          	add    rax,0x28
   1817a8eaa:	48 89 c2             	mov    rdx,rax
   1817a8ead:	4c 89 c1             	mov    rcx,r8
   1817a8eb0:	e8 6b 2e da 05       	call   0x18754bd20
   1817a8eb5:	e9 c5 0b 00 00       	jmp    0x1817a9a7f
   1817a8eba:	31 c0                	xor    eax,eax
   1817a8ebc:	48 8b 4b 18          	mov    rcx,QWORD PTR [rbx+0x18]
   1817a8ec0:	48 89 8d b0 03 00 00 	mov    QWORD PTR [rbp+0x3b0],rcx
   1817a8ec7:	48 89 85 b8 03 00 00 	mov    QWORD PTR [rbp+0x3b8],rax
   1817a8ece:	b9 02 00 00 00       	mov    ecx,0x2
   1817a8ed3:	e8 08 3f 8c fe       	call   0x18006cde0
   1817a8ed8:	85 c0                	test   eax,eax
   1817a8eda:	0f 84 e5 02 00 00    	je     0x1817a91c5
   1817a8ee0:	48 8d 5d 08          	lea    rbx,[rbp+0x8]
   1817a8ee4:	48 89 d9             	mov    rcx,rbx
   1817a8ee7:	e8 24 40 8c fe       	call   0x18006cf10
   1817a8eec:	90                   	nop
   1817a8eed:	48 83 7d 20 10       	cmp    QWORD PTR [rbp+0x20],0x10
   1817a8ef2:	72 04                	jb     0x1817a8ef8
   1817a8ef4:	48 8b 5d 08          	mov    rbx,QWORD PTR [rbp+0x8]
   1817a8ef8:	48 8d 05 11 dc b0 07 	lea    rax,[rip+0x7b0dc11]        # 0x1892b6b10
   1817a8eff:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1817a8f04:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1817a8f0b:	00 00 
   1817a8f0d:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1817a8f12:	c7 44 24 28 40 10 00 	mov    DWORD PTR [rsp+0x28],0x1040
   1817a8f19:	00 
   1817a8f1a:	4c 8d 0d 5f ac b0 07 	lea    r9,[rip+0x7b0ac5f]        # 0x1892b3b80
   1817a8f21:	48 8d 8d 60 01 00 00 	lea    rcx,[rbp+0x160]
   1817a8f28:	ba 02 00 00 00       	mov    edx,0x2
   1817a8f2d:	49 89 d8             	mov    r8,rbx
   1817a8f30:	e8 3b 43 8c fe       	call   0x18006d270
   1817a8f35:	90                   	nop
   1817a8f36:	48 8b 8d b0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3b0]
   1817a8f3d:	48 85 c9             	test   rcx,rcx
   1817a8f40:	74 05                	je     0x1817a8f47
   1817a8f42:	8b 51 10             	mov    edx,DWORD PTR [rcx+0x10]
   1817a8f45:	eb 02                	jmp    0x1817a8f49
   1817a8f47:	31 d2                	xor    edx,edx
   1817a8f49:	48 c7 85 40 02 00 00 	mov    QWORD PTR [rbp+0x240],0x0
   1817a8f50:	00 00 00 00 
   1817a8f54:	41 b8 07 00 00 00    	mov    r8d,0x7
   1817a8f5a:	4c 8d 8d 47 02 00 00 	lea    r9,[rbp+0x247]
   1817a8f61:	41 ba cd cc cc cc    	mov    r10d,0xcccccccd
   1817a8f67:	48 8d 05 02 e3 76 07 	lea    rax,[rip+0x776e302]        # 0x188f17270
   1817a8f6e:	66 90                	xchg   ax,ax
   1817a8f70:	41 89 d3             	mov    r11d,edx
   1817a8f73:	4d 0f af da          	imul   r11,r10
   1817a8f77:	49 c1 eb 23          	shr    r11,0x23
   1817a8f7b:	43 8d 1c 1b          	lea    ebx,[r11+r11*1]
   1817a8f7f:	8d 1c 9b             	lea    ebx,[rbx+rbx*4]
   1817a8f82:	f7 db                	neg    ebx
   1817a8f84:	01 d3                	add    ebx,edx
   1817a8f86:	83 c3 23             	add    ebx,0x23
   1817a8f89:	0f b6 1c 03          	movzx  ebx,BYTE PTR [rbx+rax*1]
   1817a8f8d:	41 88 59 01          	mov    BYTE PTR [r9+0x1],bl
   1817a8f91:	49 ff c1             	inc    r9
   1817a8f94:	49 ff c0             	inc    r8
   1817a8f97:	83 fa 09             	cmp    edx,0x9
   1817a8f9a:	44 89 da             	mov    edx,r11d
   1817a8f9d:	77 d1                	ja     0x1817a8f70
   1817a8f9f:	48 8d 95 48 02 00 00 	lea    rdx,[rbp+0x248]
   1817a8fa6:	41 c6 41 01 00       	mov    BYTE PTR [r9+0x1],0x0
   1817a8fab:	49 83 f8 09          	cmp    r8,0x9
   1817a8faf:	72 2b                	jb     0x1817a8fdc
   1817a8fb1:	4c 8d 85 49 02 00 00 	lea    r8,[rbp+0x249]
   1817a8fb8:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
   1817a8fbf:	00 
   1817a8fc0:	45 0f b6 11          	movzx  r10d,BYTE PTR [r9]
   1817a8fc4:	45 0f b6 58 ff       	movzx  r11d,BYTE PTR [r8-0x1]
   1817a8fc9:	45 88 19             	mov    BYTE PTR [r9],r11b
   1817a8fcc:	49 ff c9             	dec    r9
   1817a8fcf:	45 88 50 ff          	mov    BYTE PTR [r8-0x1],r10b
   1817a8fd3:	4d 39 c8             	cmp    r8,r9
   1817a8fd6:	4d 8d 40 01          	lea    r8,[r8+0x1]
   1817a8fda:	72 e4                	jb     0x1817a8fc0
   1817a8fdc:	48 89 95 40 02 00 00 	mov    QWORD PTR [rbp+0x240],rdx
   1817a8fe3:	48 85 c9             	test   rcx,rcx
   1817a8fe6:	74 05                	je     0x1817a8fed
   1817a8fe8:	8b 49 0c             	mov    ecx,DWORD PTR [rcx+0xc]
   1817a8feb:	eb 02                	jmp    0x1817a8fef
   1817a8fed:	31 c9                	xor    ecx,ecx
   1817a8fef:	48 c7 85 90 02 00 00 	mov    QWORD PTR [rbp+0x290],0x0
   1817a8ff6:	00 00 00 00 
   1817a8ffa:	ba 07 00 00 00       	mov    edx,0x7
   1817a8fff:	4c 8d 85 97 02 00 00 	lea    r8,[rbp+0x297]
   1817a9006:	41 b9 cd cc cc cc    	mov    r9d,0xcccccccd
   1817a900c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
   1817a9010:	41 89 ca             	mov    r10d,ecx
   1817a9013:	4d 0f af d1          	imul   r10,r9
   1817a9017:	49 c1 ea 23          	shr    r10,0x23
   1817a901b:	47 8d 1c 12          	lea    r11d,[r10+r10*1]
   1817a901f:	47 8d 1c 9b          	lea    r11d,[r11+r11*4]
   1817a9023:	41 f7 db             	neg    r11d
   1817a9026:	41 01 cb             	add    r11d,ecx
   1817a9029:	41 83 c3 23          	add    r11d,0x23
   1817a902d:	45 0f b6 1c 03       	movzx  r11d,BYTE PTR [r11+rax*1]
   1817a9032:	45 88 58 01          	mov    BYTE PTR [r8+0x1],r11b
   1817a9036:	49 ff c0             	inc    r8
   1817a9039:	48 ff c2             	inc    rdx
   1817a903c:	83 f9 09             	cmp    ecx,0x9
   1817a903f:	44 89 d1             	mov    ecx,r10d
   1817a9042:	77 cc                	ja     0x1817a9010
   1817a9044:	48 8d 85 98 02 00 00 	lea    rax,[rbp+0x298]
   1817a904b:	41 c6 40 01 00       	mov    BYTE PTR [r8+0x1],0x0
   1817a9050:	48 83 fa 09          	cmp    rdx,0x9
   1817a9054:	72 25                	jb     0x1817a907b
   1817a9056:	48 8d 8d 99 02 00 00 	lea    rcx,[rbp+0x299]
   1817a905d:	0f 1f 00             	nop    DWORD PTR [rax]
   1817a9060:	41 0f b6 10          	movzx  edx,BYTE PTR [r8]
   1817a9064:	44 0f b6 49 ff       	movzx  r9d,BYTE PTR [rcx-0x1]
   1817a9069:	45 88 08             	mov    BYTE PTR [r8],r9b
   1817a906c:	49 ff c8             	dec    r8
   1817a906f:	88 51 ff             	mov    BYTE PTR [rcx-0x1],dl
   1817a9072:	4c 39 c1             	cmp    rcx,r8
   1817a9075:	48 8d 49 01          	lea    rcx,[rcx+0x1]
   1817a9079:	72 e5                	jb     0x1817a9060
   1817a907b:	48 89 85 90 02 00 00 	mov    QWORD PTR [rbp+0x290],rax
   1817a9082:	48 8b 8d c0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3c0]
   1817a9089:	48 8d 9d e0 02 00 00 	lea    rbx,[rbp+0x2e0]
   1817a9090:	48 89 da             	mov    rdx,rbx
   1817a9093:	e8 c8 3e 23 02       	call   0x1839dcf60
   1817a9098:	90                   	nop
   1817a9099:	48 83 bd f8 02 00 00 	cmp    QWORD PTR [rbp+0x2f8],0x10
   1817a90a0:	10 
   1817a90a1:	72 07                	jb     0x1817a90aa
   1817a90a3:	48 8b 9d e0 02 00 00 	mov    rbx,QWORD PTR [rbp+0x2e0]
   1817a90aa:	48 89 9d f0 01 00 00 	mov    QWORD PTR [rbp+0x1f0],rbx
   1817a90b1:	c6 85 f8 01 00 00 00 	mov    BYTE PTR [rbp+0x1f8],0x0
   1817a90b8:	0f 57 c0             	xorps  xmm0,xmm0
   1817a90bb:	0f 11 85 88 03 00 00 	movups XMMWORD PTR [rbp+0x388],xmm0
   1817a90c2:	0f 11 85 78 03 00 00 	movups XMMWORD PTR [rbp+0x378],xmm0
   1817a90c9:	0f 11 85 68 03 00 00 	movups XMMWORD PTR [rbp+0x368],xmm0
   1817a90d0:	0f 11 85 58 03 00 00 	movups XMMWORD PTR [rbp+0x358],xmm0
   1817a90d7:	0f 11 85 48 03 00 00 	movups XMMWORD PTR [rbp+0x348],xmm0
   1817a90de:	0f 11 85 38 03 00 00 	movups XMMWORD PTR [rbp+0x338],xmm0
   1817a90e5:	48 c7 85 98 03 00 00 	mov    QWORD PTR [rbp+0x398],0x0
   1817a90ec:	00 00 00 00 
   1817a90f0:	48 8d 85 f0 01 00 00 	lea    rax,[rbp+0x1f0]
   1817a90f7:	48 89 85 20 03 00 00 	mov    QWORD PTR [rbp+0x320],rax
   1817a90fe:	48 8d 85 90 02 00 00 	lea    rax,[rbp+0x290]
   1817a9105:	48 89 85 28 03 00 00 	mov    QWORD PTR [rbp+0x328],rax
   1817a910c:	48 8d 85 40 02 00 00 	lea    rax,[rbp+0x240]
   1817a9113:	48 89 85 30 03 00 00 	mov    QWORD PTR [rbp+0x330],rax
   1817a911a:	48 8d 15 3f c3 b0 07 	lea    rdx,[rip+0x7b0c33f]        # 0x1892b5460
   1817a9121:	48 8d 8d 60 01 00 00 	lea    rcx,[rbp+0x160]
   1817a9128:	4c 8d 85 20 03 00 00 	lea    r8,[rbp+0x320]
   1817a912f:	e8 dc 46 8c fe       	call   0x18006d810
   1817a9134:	90                   	nop
   1817a9135:	48 8b 85 f8 02 00 00 	mov    rax,QWORD PTR [rbp+0x2f8]
   1817a913c:	48 83 f8 10          	cmp    rax,0x10
   1817a9140:	72 38                	jb     0x1817a917a
   1817a9142:	48 8b 8d e0 02 00 00 	mov    rcx,QWORD PTR [rbp+0x2e0]
   1817a9149:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1817a914d:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1817a9154:	72 1f                	jb     0x1817a9175
   1817a9156:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1817a915a:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1817a915e:	4c 29 c1             	sub    rcx,r8
   1817a9161:	48 83 f9 20          	cmp    rcx,0x20
   1817a9165:	0f 83 bd 0d 00 00    	jae    0x1817a9f28
   1817a916b:	48 83 c0 28          	add    rax,0x28
   1817a916f:	48 89 c2             	mov    rdx,rax
   1817a9172:	4c 89 c1             	mov    rcx,r8
   1817a9175:	e8 a6 2b da 05       	call   0x18754bd20
   1817a917a:	48 8d 8d 60 01 00 00 	lea    rcx,[rbp+0x160]
   1817a9181:	e8 ea 41 8c fe       	call   0x18006d370
   1817a9186:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
   1817a918a:	48 83 f8 10          	cmp    rax,0x10
   1817a918e:	72 35                	jb     0x1817a91c5
   1817a9190:	48 8b 4d 08          	mov    rcx,QWORD PTR [rbp+0x8]
   1817a9194:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1817a9198:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1817a919f:	72 1f                	jb     0x1817a91c0
   1817a91a1:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1817a91a5:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1817a91a9:	4c 29 c1             	sub    rcx,r8
   1817a91ac:	48 83 f9 20          	cmp    rcx,0x20
   1817a91b0:	0f 83 72 0d 00 00    	jae    0x1817a9f28
   1817a91b6:	48 83 c0 28          	add    rax,0x28
   1817a91ba:	48 89 c2             	mov    rdx,rax
   1817a91bd:	4c 89 c1             	mov    rcx,r8
   1817a91c0:	e8 5b 2b da 05       	call   0x18754bd20
   1817a91c5:	48 b8 aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaaa
   1817a91cc:	aa aa aa 
   1817a91cf:	48 89 85 10 03 00 00 	mov    QWORD PTR [rbp+0x310],rax
   1817a91d6:	0f 29 b5 00 03 00 00 	movaps XMMWORD PTR [rbp+0x300],xmm6
   1817a91dd:	0f 29 b5 f0 02 00 00 	movaps XMMWORD PTR [rbp+0x2f0],xmm6
   1817a91e4:	0f 29 b5 e0 02 00 00 	movaps XMMWORD PTR [rbp+0x2e0],xmm6
   1817a91eb:	0f 57 c0             	xorps  xmm0,xmm0
   1817a91ee:	0f 29 85 20 01 00 00 	movaps XMMWORD PTR [rbp+0x120],xmm0
   1817a91f5:	48 8b 85 c8 03 00 00 	mov    rax,QWORD PTR [rbp+0x3c8]
   1817a91fc:	48 85 c0             	test   rax,rax
   1817a91ff:	74 0d                	je     0x1817a920e
   1817a9201:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1817a9205:	48 8b 85 c8 03 00 00 	mov    rax,QWORD PTR [rbp+0x3c8]
   1817a920c:	eb 02                	jmp    0x1817a9210
   1817a920e:	31 c0                	xor    eax,eax
   1817a9210:	48 8b 9d c0 03 00 00 	mov    rbx,QWORD PTR [rbp+0x3c0]
   1817a9217:	48 89 9d 20 01 00 00 	mov    QWORD PTR [rbp+0x120],rbx
   1817a921e:	48 89 85 28 01 00 00 	mov    QWORD PTR [rbp+0x128],rax
   1817a9225:	48 8d 95 e0 02 00 00 	lea    rdx,[rbp+0x2e0]
   1817a922c:	4c 8d 85 20 01 00 00 	lea    r8,[rbp+0x120]
   1817a9233:	48 89 f1             	mov    rcx,rsi
   1817a9236:	e8 25 f3 05 00       	call   0x181808560
   1817a923b:	90                   	nop
   1817a923c:	48 8b 43 20          	mov    rax,QWORD PTR [rbx+0x20]
   1817a9240:	48 85 c0             	test   rax,rax
   1817a9243:	74 1a                	je     0x1817a925f
   1817a9245:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1817a9249:	48 8b 43 18          	mov    rax,QWORD PTR [rbx+0x18]
   1817a924d:	48 8b 5b 20          	mov    rbx,QWORD PTR [rbx+0x20]
   1817a9251:	48 85 db             	test   rbx,rbx
   1817a9254:	74 0d                	je     0x1817a9263
   1817a9256:	f0 ff 43 08          	lock inc DWORD PTR [rbx+0x8]
   1817a925a:	45 31 ff             	xor    r15d,r15d
   1817a925d:	eb 09                	jmp    0x1817a9268
   1817a925f:	48 8b 43 18          	mov    rax,QWORD PTR [rbx+0x18]
   1817a9263:	41 b7 01             	mov    r15b,0x1
   1817a9266:	31 db                	xor    ebx,ebx
   1817a9268:	48 89 85 b0 03 00 00 	mov    QWORD PTR [rbp+0x3b0],rax
   1817a926f:	4c 8b b5 b8 03 00 00 	mov    r14,QWORD PTR [rbp+0x3b8]
   1817a9276:	48 89 9d b8 03 00 00 	mov    QWORD PTR [rbp+0x3b8],rbx
   1817a927d:	4d 85 f6             	test   r14,r14
   1817a9280:	74 1f                	je     0x1817a92a1
   1817a9282:	f0 41 ff 4e 08       	lock dec DWORD PTR [r14+0x8]
   1817a9287:	75 18                	jne    0x1817a92a1
   1817a9289:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1817a928c:	4c 89 f1             	mov    rcx,r14
   1817a928f:	ff 10                	call   QWORD PTR [rax]
   1817a9291:	f0 41 ff 4e 0c       	lock dec DWORD PTR [r14+0xc]
   1817a9296:	75 09                	jne    0x1817a92a1
   1817a9298:	49 8b 06             	mov    rax,QWORD PTR [r14]
   1817a929b:	4c 89 f1             	mov    rcx,r14
   1817a929e:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1817a92a1:	45 84 ff             	test   r15b,r15b
   1817a92a4:	75 1d                	jne    0x1817a92c3
   1817a92a6:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   1817a92aa:	75 17                	jne    0x1817a92c3
   1817a92ac:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   1817a92af:	48 89 d9             	mov    rcx,rbx
   1817a92b2:	ff 10                	call   QWORD PTR [rax]
   1817a92b4:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   1817a92b8:	75 09                	jne    0x1817a92c3
   1817a92ba:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   1817a92bd:	48 89 d9             	mov    rcx,rbx
   1817a92c0:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1817a92c3:	b9 02 00 00 00       	mov    ecx,0x2
   1817a92c8:	e8 13 3b 8c fe       	call   0x18006cde0
   1817a92cd:	85 c0                	test   eax,eax
   1817a92cf:	0f 84 9c 00 00 00    	je     0x1817a9371
   1817a92d5:	48 8d 9d 98 00 00 00 	lea    rbx,[rbp+0x98]
   1817a92dc:	48 89 d9             	mov    rcx,rbx
   1817a92df:	e8 2c 3c 8c fe       	call   0x18006cf10
   1817a92e4:	90                   	nop
   1817a92e5:	48 83 bd b0 00 00 00 	cmp    QWORD PTR [rbp+0xb0],0x10
   1817a92ec:	10 
   1817a92ed:	72 07                	jb     0x1817a92f6
   1817a92ef:	48 8b 9d 98 00 00 00 	mov    rbx,QWORD PTR [rbp+0x98]
   1817a92f6:	48 8d 05 13 d8 b0 07 	lea    rax,[rip+0x7b0d813]        # 0x1892b6b10
   1817a92fd:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1817a9302:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1817a9309:	00 00 
   1817a930b:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1817a9310:	c7 44 24 28 44 10 00 	mov    DWORD PTR [rsp+0x28],0x1044
   1817a9317:	00 
   1817a9318:	4c 8d 0d 61 a8 b0 07 	lea    r9,[rip+0x7b0a861]        # 0x1892b3b80
   1817a931f:	48 8d 8d 60 01 00 00 	lea    rcx,[rbp+0x160]
   1817a9326:	ba 02 00 00 00       	mov    edx,0x2
   1817a932b:	49 89 d8             	mov    r8,rbx
   1817a932e:	e8 3d 3f 8c fe       	call   0x18006d270
   1817a9333:	90                   	nop
   1817a9334:	8b 85 e4 02 00 00    	mov    eax,DWORD PTR [rbp+0x2e4]
   1817a933a:	0b 85 e0 02 00 00    	or     eax,DWORD PTR [rbp+0x2e0]
   1817a9340:	48 8d 05 71 76 7a 07 	lea    rax,[rip+0x77a7671]        # 0x188f509b8
   1817a9347:	48 8d 0d 62 76 7a 07 	lea    rcx,[rip+0x77a7662]        # 0x188f509b0
   1817a934e:	48 0f 44 c8          	cmove  rcx,rax
   1817a9352:	48 89 8d 40 02 00 00 	mov    QWORD PTR [rbp+0x240],rcx
   1817a9359:	c6 85 48 02 00 00 00 	mov    BYTE PTR [rbp+0x248],0x0
   1817a9360:	48 8b 8d b0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3b0]
   1817a9367:	48 85 c9             	test   rcx,rcx
   1817a936a:	74 11                	je     0x1817a937d
   1817a936c:	8b 51 10             	mov    edx,DWORD PTR [rcx+0x10]
   1817a936f:	eb 0e                	jmp    0x1817a937f
   1817a9371:	48 8b 9d c0 03 00 00 	mov    rbx,QWORD PTR [rbp+0x3c0]
   1817a9378:	e9 8b 02 00 00       	jmp    0x1817a9608
   1817a937d:	31 d2                	xor    edx,edx
   1817a937f:	48 c7 85 90 02 00 00 	mov    QWORD PTR [rbp+0x290],0x0
   1817a9386:	00 00 00 00 
   1817a938a:	41 b8 07 00 00 00    	mov    r8d,0x7
   1817a9390:	4c 8d 8d 97 02 00 00 	lea    r9,[rbp+0x297]
   1817a9397:	41 ba cd cc cc cc    	mov    r10d,0xcccccccd
   1817a939d:	48 8d 05 cc de 76 07 	lea    rax,[rip+0x776decc]        # 0x188f17270
   1817a93a4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
   1817a93ab:	00 00 00 00 00 
   1817a93b0:	41 89 d3             	mov    r11d,edx
   1817a93b3:	4d 0f af da          	imul   r11,r10
   1817a93b7:	49 c1 eb 23          	shr    r11,0x23
   1817a93bb:	43 8d 1c 1b          	lea    ebx,[r11+r11*1]
   1817a93bf:	8d 1c 9b             	lea    ebx,[rbx+rbx*4]
   1817a93c2:	f7 db                	neg    ebx
   1817a93c4:	01 d3                	add    ebx,edx
   1817a93c6:	83 c3 23             	add    ebx,0x23
   1817a93c9:	0f b6 1c 03          	movzx  ebx,BYTE PTR [rbx+rax*1]
   1817a93cd:	41 88 59 01          	mov    BYTE PTR [r9+0x1],bl
   1817a93d1:	49 ff c1             	inc    r9
   1817a93d4:	49 ff c0             	inc    r8
   1817a93d7:	83 fa 09             	cmp    edx,0x9
   1817a93da:	44 89 da             	mov    edx,r11d
   1817a93dd:	77 d1                	ja     0x1817a93b0
   1817a93df:	48 8d 95 98 02 00 00 	lea    rdx,[rbp+0x298]
   1817a93e6:	41 c6 41 01 00       	mov    BYTE PTR [r9+0x1],0x0
   1817a93eb:	49 83 f8 09          	cmp    r8,0x9
   1817a93ef:	72 2b                	jb     0x1817a941c
   1817a93f1:	4c 8d 85 99 02 00 00 	lea    r8,[rbp+0x299]
   1817a93f8:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
   1817a93ff:	00 
   1817a9400:	45 0f b6 11          	movzx  r10d,BYTE PTR [r9]
   1817a9404:	45 0f b6 58 ff       	movzx  r11d,BYTE PTR [r8-0x1]
   1817a9409:	45 88 19             	mov    BYTE PTR [r9],r11b
   1817a940c:	49 ff c9             	dec    r9
   1817a940f:	45 88 50 ff          	mov    BYTE PTR [r8-0x1],r10b
   1817a9413:	4d 39 c8             	cmp    r8,r9
   1817a9416:	4d 8d 40 01          	lea    r8,[r8+0x1]
   1817a941a:	72 e4                	jb     0x1817a9400
   1817a941c:	48 89 95 90 02 00 00 	mov    QWORD PTR [rbp+0x290],rdx
   1817a9423:	48 85 c9             	test   rcx,rcx
   1817a9426:	74 05                	je     0x1817a942d
   1817a9428:	8b 49 0c             	mov    ecx,DWORD PTR [rcx+0xc]
   1817a942b:	eb 02                	jmp    0x1817a942f
   1817a942d:	31 c9                	xor    ecx,ecx
   1817a942f:	48 c7 85 f0 01 00 00 	mov    QWORD PTR [rbp+0x1f0],0x0
   1817a9436:	00 00 00 00 
   1817a943a:	ba 07 00 00 00       	mov    edx,0x7
   1817a943f:	4c 8d 85 f7 01 00 00 	lea    r8,[rbp+0x1f7]
   1817a9446:	41 b9 cd cc cc cc    	mov    r9d,0xcccccccd
   1817a944c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
   1817a9450:	41 89 ca             	mov    r10d,ecx
   1817a9453:	4d 0f af d1          	imul   r10,r9
   1817a9457:	49 c1 ea 23          	shr    r10,0x23
   1817a945b:	47 8d 1c 12          	lea    r11d,[r10+r10*1]
   1817a945f:	47 8d 1c 9b          	lea    r11d,[r11+r11*4]
   1817a9463:	41 f7 db             	neg    r11d
   1817a9466:	41 01 cb             	add    r11d,ecx
   1817a9469:	41 83 c3 23          	add    r11d,0x23
   1817a946d:	45 0f b6 1c 03       	movzx  r11d,BYTE PTR [r11+rax*1]
   1817a9472:	45 88 58 01          	mov    BYTE PTR [r8+0x1],r11b
   1817a9476:	49 ff c0             	inc    r8
   1817a9479:	48 ff c2             	inc    rdx
   1817a947c:	83 f9 09             	cmp    ecx,0x9
   1817a947f:	44 89 d1             	mov    ecx,r10d
   1817a9482:	77 cc                	ja     0x1817a9450
   1817a9484:	48 8d 85 f8 01 00 00 	lea    rax,[rbp+0x1f8]
   1817a948b:	41 c6 40 01 00       	mov    BYTE PTR [r8+0x1],0x0
   1817a9490:	48 83 fa 09          	cmp    rdx,0x9
   1817a9494:	72 25                	jb     0x1817a94bb
   1817a9496:	48 8d 8d f9 01 00 00 	lea    rcx,[rbp+0x1f9]
   1817a949d:	0f 1f 00             	nop    DWORD PTR [rax]
   1817a94a0:	41 0f b6 10          	movzx  edx,BYTE PTR [r8]
   1817a94a4:	44 0f b6 49 ff       	movzx  r9d,BYTE PTR [rcx-0x1]
   1817a94a9:	45 88 08             	mov    BYTE PTR [r8],r9b
   1817a94ac:	49 ff c8             	dec    r8
   1817a94af:	88 51 ff             	mov    BYTE PTR [rcx-0x1],dl
   1817a94b2:	4c 39 c1             	cmp    rcx,r8
   1817a94b5:	48 8d 49 01          	lea    rcx,[rcx+0x1]
   1817a94b9:	72 e5                	jb     0x1817a94a0
   1817a94bb:	48 89 85 f0 01 00 00 	mov    QWORD PTR [rbp+0x1f0],rax
   1817a94c2:	48 8b 9d c0 03 00 00 	mov    rbx,QWORD PTR [rbp+0x3c0]
   1817a94c9:	4c 8d b5 b8 00 00 00 	lea    r14,[rbp+0xb8]
   1817a94d0:	48 89 d9             	mov    rcx,rbx
   1817a94d3:	4c 89 f2             	mov    rdx,r14
   1817a94d6:	e8 85 3a 23 02       	call   0x1839dcf60
   1817a94db:	90                   	nop
   1817a94dc:	48 83 bd d0 00 00 00 	cmp    QWORD PTR [rbp+0xd0],0x10
   1817a94e3:	10 
   1817a94e4:	72 07                	jb     0x1817a94ed
   1817a94e6:	4c 8b b5 b8 00 00 00 	mov    r14,QWORD PTR [rbp+0xb8]
   1817a94ed:	4c 89 75 08          	mov    QWORD PTR [rbp+0x8],r14
   1817a94f1:	c6 45 10 00          	mov    BYTE PTR [rbp+0x10],0x0
   1817a94f5:	0f 57 c0             	xorps  xmm0,xmm0
   1817a94f8:	0f 11 85 90 03 00 00 	movups XMMWORD PTR [rbp+0x390],xmm0
   1817a94ff:	0f 11 85 80 03 00 00 	movups XMMWORD PTR [rbp+0x380],xmm0
   1817a9506:	0f 11 85 70 03 00 00 	movups XMMWORD PTR [rbp+0x370],xmm0
   1817a950d:	0f 11 85 60 03 00 00 	movups XMMWORD PTR [rbp+0x360],xmm0
   1817a9514:	0f 11 85 50 03 00 00 	movups XMMWORD PTR [rbp+0x350],xmm0
   1817a951b:	0f 11 85 40 03 00 00 	movups XMMWORD PTR [rbp+0x340],xmm0
   1817a9522:	48 8d 45 08          	lea    rax,[rbp+0x8]
   1817a9526:	48 89 85 20 03 00 00 	mov    QWORD PTR [rbp+0x320],rax
   1817a952d:	48 8d 85 f0 01 00 00 	lea    rax,[rbp+0x1f0]
   1817a9534:	48 89 85 28 03 00 00 	mov    QWORD PTR [rbp+0x328],rax
   1817a953b:	48 8d 85 90 02 00 00 	lea    rax,[rbp+0x290]
   1817a9542:	48 89 85 30 03 00 00 	mov    QWORD PTR [rbp+0x330],rax
   1817a9549:	48 8d 85 40 02 00 00 	lea    rax,[rbp+0x240]
   1817a9550:	48 89 85 38 03 00 00 	mov    QWORD PTR [rbp+0x338],rax
   1817a9557:	48 8d 15 12 57 b1 07 	lea    rdx,[rip+0x7b15712]        # 0x1892bec70
   1817a955e:	48 8d 8d 60 01 00 00 	lea    rcx,[rbp+0x160]
   1817a9565:	4c 8d 85 20 03 00 00 	lea    r8,[rbp+0x320]
   1817a956c:	e8 9f 42 8c fe       	call   0x18006d810
   1817a9571:	90                   	nop
   1817a9572:	48 8b 85 d0 00 00 00 	mov    rax,QWORD PTR [rbp+0xd0]
   1817a9579:	48 83 f8 10          	cmp    rax,0x10
   1817a957d:	72 38                	jb     0x1817a95b7
   1817a957f:	48 8b 8d b8 00 00 00 	mov    rcx,QWORD PTR [rbp+0xb8]
   1817a9586:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1817a958a:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1817a9591:	72 1f                	jb     0x1817a95b2
   1817a9593:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1817a9597:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1817a959b:	4c 29 c1             	sub    rcx,r8
   1817a959e:	48 83 f9 20          	cmp    rcx,0x20
   1817a95a2:	0f 83 80 09 00 00    	jae    0x1817a9f28
   1817a95a8:	48 83 c0 28          	add    rax,0x28
   1817a95ac:	48 89 c2             	mov    rdx,rax
   1817a95af:	4c 89 c1             	mov    rcx,r8
   1817a95b2:	e8 69 27 da 05       	call   0x18754bd20
   1817a95b7:	48 8d 8d 60 01 00 00 	lea    rcx,[rbp+0x160]
   1817a95be:	e8 ad 3d 8c fe       	call   0x18006d370
   1817a95c3:	48 8b 85 b0 00 00 00 	mov    rax,QWORD PTR [rbp+0xb0]
   1817a95ca:	48 83 f8 10          	cmp    rax,0x10
   1817a95ce:	72 38                	jb     0x1817a9608
   1817a95d0:	48 8b 8d 98 00 00 00 	mov    rcx,QWORD PTR [rbp+0x98]
   1817a95d7:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1817a95db:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1817a95e2:	72 1f                	jb     0x1817a9603
   1817a95e4:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1817a95e8:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1817a95ec:	4c 29 c1             	sub    rcx,r8
   1817a95ef:	48 83 f9 20          	cmp    rcx,0x20
   1817a95f3:	0f 83 2f 09 00 00    	jae    0x1817a9f28
   1817a95f9:	48 83 c0 28          	add    rax,0x28
   1817a95fd:	48 89 c2             	mov    rdx,rax
   1817a9600:	4c 89 c1             	mov    rcx,r8
   1817a9603:	e8 18 27 da 05       	call   0x18754bd20
   1817a9608:	4c 8d 4b 38          	lea    r9,[rbx+0x38]
   1817a960c:	0f 57 c0             	xorps  xmm0,xmm0
   1817a960f:	0f 29 85 30 01 00 00 	movaps XMMWORD PTR [rbp+0x130],xmm0
   1817a9616:	48 8b 85 c8 03 00 00 	mov    rax,QWORD PTR [rbp+0x3c8]
   1817a961d:	48 85 c0             	test   rax,rax
   1817a9620:	74 14                	je     0x1817a9636
   1817a9622:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1817a9626:	48 8b 9d c0 03 00 00 	mov    rbx,QWORD PTR [rbp+0x3c0]
   1817a962d:	48 8b 85 c8 03 00 00 	mov    rax,QWORD PTR [rbp+0x3c8]
   1817a9634:	eb 02                	jmp    0x1817a9638
   1817a9636:	31 c0                	xor    eax,eax
   1817a9638:	48 89 9d 30 01 00 00 	mov    QWORD PTR [rbp+0x130],rbx
   1817a963f:	48 89 85 38 01 00 00 	mov    QWORD PTR [rbp+0x138],rax
   1817a9646:	ba 90 00 00 00       	mov    edx,0x90
   1817a964b:	48 03 96 f8 0b 00 00 	add    rdx,QWORD PTR [rsi+0xbf8]
   1817a9652:	4c 8d 85 30 01 00 00 	lea    r8,[rbp+0x130]
   1817a9659:	e8 52 af 05 00       	call   0x1818045b0
   1817a965e:	90                   	nop
   1817a965f:	8b 85 e4 02 00 00    	mov    eax,DWORD PTR [rbp+0x2e4]
   1817a9665:	0b 85 e0 02 00 00    	or     eax,DWORD PTR [rbp+0x2e0]
   1817a966b:	75 63                	jne    0x1817a96d0
   1817a966d:	48 89 d9             	mov    rcx,rbx
   1817a9670:	e8 5b 4d 23 02       	call   0x1839de3d0
   1817a9675:	90                   	nop
   1817a9676:	84 c0                	test   al,al
   1817a9678:	74 56                	je     0x1817a96d0
   1817a967a:	48 8b 9d c0 03 00 00 	mov    rbx,QWORD PTR [rbp+0x3c0]
   1817a9681:	48 89 d9             	mov    rcx,rbx
   1817a9684:	ba 04 00 00 00       	mov    edx,0x4
   1817a9689:	e8 32 4d 23 02       	call   0x1839de3c0
   1817a968e:	90                   	nop
   1817a968f:	48 8d 95 60 01 00 00 	lea    rdx,[rbp+0x160]
   1817a9696:	48 89 d9             	mov    rcx,rbx
   1817a9699:	e8 02 4d 23 02       	call   0x1839de3a0
   1817a969e:	90                   	nop
   1817a969f:	0f 57 c0             	xorps  xmm0,xmm0
   1817a96a2:	0f 29 85 50 01 00 00 	movaps XMMWORD PTR [rbp+0x150],xmm0
   1817a96a9:	48 8b 85 c8 03 00 00 	mov    rax,QWORD PTR [rbp+0x3c8]
   1817a96b0:	48 85 c0             	test   rax,rax
   1817a96b3:	0f 84 0a 04 00 00    	je     0x1817a9ac3
   1817a96b9:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1817a96bd:	48 8b 9d c0 03 00 00 	mov    rbx,QWORD PTR [rbp+0x3c0]
   1817a96c4:	4c 8b b5 c8 03 00 00 	mov    r14,QWORD PTR [rbp+0x3c8]
   1817a96cb:	e9 f6 03 00 00       	jmp    0x1817a9ac6
   1817a96d0:	b9 04 00 00 00       	mov    ecx,0x4
   1817a96d5:	e8 06 37 8c fe       	call   0x18006cde0
   1817a96da:	85 c0                	test   eax,eax
   1817a96dc:	0f 84 93 01 00 00    	je     0x1817a9875
   1817a96e2:	48 8d 9d 90 02 00 00 	lea    rbx,[rbp+0x290]
   1817a96e9:	48 89 d9             	mov    rcx,rbx
   1817a96ec:	e8 1f 38 8c fe       	call   0x18006cf10
   1817a96f1:	90                   	nop
   1817a96f2:	48 83 bd a8 02 00 00 	cmp    QWORD PTR [rbp+0x2a8],0x10
   1817a96f9:	10 
   1817a96fa:	72 07                	jb     0x1817a9703
   1817a96fc:	48 8b 9d 90 02 00 00 	mov    rbx,QWORD PTR [rbp+0x290]
   1817a9703:	48 8d 05 06 d4 b0 07 	lea    rax,[rip+0x7b0d406]        # 0x1892b6b10
   1817a970a:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1817a970f:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   1817a9716:	00 00 
   1817a9718:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   1817a971d:	c7 44 24 28 47 10 00 	mov    DWORD PTR [rsp+0x28],0x1047
   1817a9724:	00 
   1817a9725:	4c 8d 0d 54 a4 b0 07 	lea    r9,[rip+0x7b0a454]        # 0x1892b3b80
   1817a972c:	48 8d 8d 60 01 00 00 	lea    rcx,[rbp+0x160]
   1817a9733:	ba 04 00 00 00       	mov    edx,0x4
   1817a9738:	49 89 d8             	mov    r8,rbx
   1817a973b:	e8 30 3b 8c fe       	call   0x18006d270
   1817a9740:	90                   	nop
   1817a9741:	48 8b 8d c0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3c0]
   1817a9748:	48 8d 9d f0 01 00 00 	lea    rbx,[rbp+0x1f0]
   1817a974f:	48 89 da             	mov    rdx,rbx
   1817a9752:	e8 09 38 23 02       	call   0x1839dcf60
   1817a9757:	90                   	nop
   1817a9758:	48 83 bd 08 02 00 00 	cmp    QWORD PTR [rbp+0x208],0x10
   1817a975f:	10 
   1817a9760:	72 07                	jb     0x1817a9769
   1817a9762:	48 8b 9d f0 01 00 00 	mov    rbx,QWORD PTR [rbp+0x1f0]
   1817a9769:	48 89 9d 40 02 00 00 	mov    QWORD PTR [rbp+0x240],rbx
   1817a9770:	c6 85 48 02 00 00 00 	mov    BYTE PTR [rbp+0x248],0x0
   1817a9777:	0f 57 c0             	xorps  xmm0,xmm0
   1817a977a:	0f 11 85 88 03 00 00 	movups XMMWORD PTR [rbp+0x388],xmm0
   1817a9781:	0f 11 85 78 03 00 00 	movups XMMWORD PTR [rbp+0x378],xmm0
   1817a9788:	0f 11 85 68 03 00 00 	movups XMMWORD PTR [rbp+0x368],xmm0
   1817a978f:	0f 11 85 58 03 00 00 	movups XMMWORD PTR [rbp+0x358],xmm0
   1817a9796:	0f 11 85 48 03 00 00 	movups XMMWORD PTR [rbp+0x348],xmm0
   1817a979d:	0f 11 85 38 03 00 00 	movups XMMWORD PTR [rbp+0x338],xmm0
   1817a97a4:	0f 11 85 28 03 00 00 	movups XMMWORD PTR [rbp+0x328],xmm0
   1817a97ab:	48 c7 85 98 03 00 00 	mov    QWORD PTR [rbp+0x398],0x0
   1817a97b2:	00 00 00 00 
   1817a97b6:	48 8d 85 40 02 00 00 	lea    rax,[rbp+0x240]
   1817a97bd:	48 89 85 20 03 00 00 	mov    QWORD PTR [rbp+0x320],rax
   1817a97c4:	48 8d 15 5d 55 b1 07 	lea    rdx,[rip+0x7b1555d]        # 0x1892bed28
   1817a97cb:	48 8d 8d 60 01 00 00 	lea    rcx,[rbp+0x160]
   1817a97d2:	4c 8d 85 20 03 00 00 	lea    r8,[rbp+0x320]
   1817a97d9:	e8 32 40 8c fe       	call   0x18006d810
   1817a97de:	90                   	nop
   1817a97df:	48 8b 85 08 02 00 00 	mov    rax,QWORD PTR [rbp+0x208]
   1817a97e6:	48 83 f8 10          	cmp    rax,0x10
   1817a97ea:	72 38                	jb     0x1817a9824
   1817a97ec:	48 8b 8d f0 01 00 00 	mov    rcx,QWORD PTR [rbp+0x1f0]
   1817a97f3:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1817a97f7:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1817a97fe:	72 1f                	jb     0x1817a981f
   1817a9800:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1817a9804:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1817a9808:	4c 29 c1             	sub    rcx,r8
   1817a980b:	48 83 f9 20          	cmp    rcx,0x20
   1817a980f:	0f 83 13 07 00 00    	jae    0x1817a9f28
   1817a9815:	48 83 c0 28          	add    rax,0x28
   1817a9819:	48 89 c2             	mov    rdx,rax
   1817a981c:	4c 89 c1             	mov    rcx,r8
   1817a981f:	e8 fc 24 da 05       	call   0x18754bd20
   1817a9824:	48 8d 8d 60 01 00 00 	lea    rcx,[rbp+0x160]
   1817a982b:	e8 40 3b 8c fe       	call   0x18006d370
   1817a9830:	48 8b 85 a8 02 00 00 	mov    rax,QWORD PTR [rbp+0x2a8]
   1817a9837:	48 83 f8 10          	cmp    rax,0x10
   1817a983b:	72 38                	jb     0x1817a9875
   1817a983d:	48 8b 8d 90 02 00 00 	mov    rcx,QWORD PTR [rbp+0x290]
   1817a9844:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1817a9848:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1817a984f:	72 1f                	jb     0x1817a9870
   1817a9851:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1817a9855:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1817a9859:	4c 29 c1             	sub    rcx,r8
   1817a985c:	48 83 f9 20          	cmp    rcx,0x20
   1817a9860:	0f 83 c2 06 00 00    	jae    0x1817a9f28
   1817a9866:	48 83 c0 28          	add    rax,0x28
   1817a986a:	48 89 c2             	mov    rdx,rax
   1817a986d:	4c 89 c1             	mov    rcx,r8
   1817a9870:	e8 ab 24 da 05       	call   0x18754bd20
   1817a9875:	48 8b 85 e0 02 00 00 	mov    rax,QWORD PTR [rbp+0x2e0]
   1817a987c:	48 8b 9d f8 02 00 00 	mov    rbx,QWORD PTR [rbp+0x2f8]
   1817a9883:	48 89 85 d8 00 00 00 	mov    QWORD PTR [rbp+0xd8],rax
   1817a988a:	0f 57 c0             	xorps  xmm0,xmm0
   1817a988d:	0f 11 85 e0 00 00 00 	movups XMMWORD PTR [rbp+0xe0],xmm0
   1817a9894:	0f 11 85 f0 00 00 00 	movups XMMWORD PTR [rbp+0xf0],xmm0
   1817a989b:	48 83 bd 00 03 00 00 	cmp    QWORD PTR [rbp+0x300],0x10
   1817a98a2:	10 
   1817a98a3:	72 09                	jb     0x1817a98ae
   1817a98a5:	4c 8b b5 e8 02 00 00 	mov    r14,QWORD PTR [rbp+0x2e8]
   1817a98ac:	eb 07                	jmp    0x1817a98b5
   1817a98ae:	4c 8d b5 e8 02 00 00 	lea    r14,[rbp+0x2e8]
   1817a98b5:	48 85 db             	test   rbx,rbx
   1817a98b8:	0f 88 70 06 00 00    	js     0x1817a9f2e
   1817a98be:	48 83 fb 0f          	cmp    rbx,0xf
   1817a98c2:	77 22                	ja     0x1817a98e6
   1817a98c4:	48 8d 85 e0 00 00 00 	lea    rax,[rbp+0xe0]
   1817a98cb:	48 89 9d f0 00 00 00 	mov    QWORD PTR [rbp+0xf0],rbx
   1817a98d2:	48 c7 85 f8 00 00 00 	mov    QWORD PTR [rbp+0xf8],0xf
   1817a98d9:	0f 00 00 00 
   1817a98dd:	41 0f 10 06          	movups xmm0,XMMWORD PTR [r14]
   1817a98e1:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   1817a98e4:	eb 71                	jmp    0x1817a9957
   1817a98e6:	48 89 d8             	mov    rax,rbx
   1817a98e9:	48 83 c8 0f          	or     rax,0xf
   1817a98ed:	48 83 f8 17          	cmp    rax,0x17
   1817a98f1:	41 bf 16 00 00 00    	mov    r15d,0x16
   1817a98f7:	4c 0f 43 f8          	cmovae r15,rax
   1817a98fb:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   1817a9901:	72 24                	jb     0x1817a9927
   1817a9903:	49 8d 4f 28          	lea    rcx,[r15+0x28]
   1817a9907:	e8 d0 23 da 05       	call   0x18754bcdc
   1817a990c:	90                   	nop
   1817a990d:	48 85 c0             	test   rax,rax
   1817a9910:	0f 84 12 06 00 00    	je     0x1817a9f28
   1817a9916:	48 89 c1             	mov    rcx,rax
   1817a9919:	48 83 c0 27          	add    rax,0x27
   1817a991d:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
   1817a9921:	48 89 48 f8          	mov    QWORD PTR [rax-0x8],rcx
   1817a9925:	eb 0a                	jmp    0x1817a9931
   1817a9927:	49 8d 4f 01          	lea    rcx,[r15+0x1]
   1817a992b:	e8 ac 23 da 05       	call   0x18754bcdc
   1817a9930:	90                   	nop
   1817a9931:	48 89 85 e0 00 00 00 	mov    QWORD PTR [rbp+0xe0],rax
   1817a9938:	48 89 9d f0 00 00 00 	mov    QWORD PTR [rbp+0xf0],rbx
   1817a993f:	4c 89 bd f8 00 00 00 	mov    QWORD PTR [rbp+0xf8],r15
   1817a9946:	48 ff c3             	inc    rbx
   1817a9949:	48 89 c1             	mov    rcx,rax
   1817a994c:	4c 89 f2             	mov    rdx,r14
   1817a994f:	49 89 d8             	mov    r8,rbx
   1817a9952:	e8 e9 b4 f6 05       	call   0x187714e40
   1817a9957:	0f 57 c0             	xorps  xmm0,xmm0
   1817a995a:	0f 11 85 00 01 00 00 	movups XMMWORD PTR [rbp+0x100],xmm0
   1817a9961:	48 8b 85 10 03 00 00 	mov    rax,QWORD PTR [rbp+0x310]
   1817a9968:	48 85 c0             	test   rax,rax
   1817a996b:	74 0d                	je     0x1817a997a
   1817a996d:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1817a9971:	48 8b 85 10 03 00 00 	mov    rax,QWORD PTR [rbp+0x310]
   1817a9978:	eb 02                	jmp    0x1817a997c
   1817a997a:	31 c0                	xor    eax,eax
   1817a997c:	48 8b 8d 08 03 00 00 	mov    rcx,QWORD PTR [rbp+0x308]
   1817a9983:	48 89 8d 00 01 00 00 	mov    QWORD PTR [rbp+0x100],rcx
   1817a998a:	48 89 85 08 01 00 00 	mov    QWORD PTR [rbp+0x108],rax
   1817a9991:	0f 29 85 40 01 00 00 	movaps XMMWORD PTR [rbp+0x140],xmm0
   1817a9998:	48 8b 85 c8 03 00 00 	mov    rax,QWORD PTR [rbp+0x3c8]
   1817a999f:	48 85 c0             	test   rax,rax
   1817a99a2:	74 0d                	je     0x1817a99b1
   1817a99a4:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1817a99a8:	48 8b 85 c8 03 00 00 	mov    rax,QWORD PTR [rbp+0x3c8]
   1817a99af:	eb 02                	jmp    0x1817a99b3
   1817a99b1:	31 c0                	xor    eax,eax
   1817a99b3:	48 8b 8d c0 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3c0]
   1817a99ba:	48 89 8d 40 01 00 00 	mov    QWORD PTR [rbp+0x140],rcx
   1817a99c1:	48 89 85 48 01 00 00 	mov    QWORD PTR [rbp+0x148],rax
   1817a99c8:	48 8d 8d 40 01 00 00 	lea    rcx,[rbp+0x140]
   1817a99cf:	48 8d 95 d8 00 00 00 	lea    rdx,[rbp+0xd8]
   1817a99d6:	e8 35 06 b8 00       	call   0x18232a010
   1817a99db:	90                   	nop
   1817a99dc:	48 89 f1             	mov    rcx,rsi
   1817a99df:	48 89 fa             	mov    rdx,rdi
   1817a99e2:	e8 c9 ed ff ff       	call   0x1817a87b0
   1817a99e7:	90                   	nop
   1817a99e8:	48 8b b5 10 03 00 00 	mov    rsi,QWORD PTR [rbp+0x310]
   1817a99ef:	48 85 f6             	test   rsi,rsi
   1817a99f2:	74 1d                	je     0x1817a9a11
   1817a99f4:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1817a99f8:	75 17                	jne    0x1817a9a11
   1817a99fa:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1817a99fd:	48 89 f1             	mov    rcx,rsi
   1817a9a00:	ff 10                	call   QWORD PTR [rax]
   1817a9a02:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1817a9a06:	75 09                	jne    0x1817a9a11
   1817a9a08:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1817a9a0b:	48 89 f1             	mov    rcx,rsi
   1817a9a0e:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1817a9a11:	48 8b 85 00 03 00 00 	mov    rax,QWORD PTR [rbp+0x300]
   1817a9a18:	48 83 f8 10          	cmp    rax,0x10
   1817a9a1c:	72 38                	jb     0x1817a9a56
   1817a9a1e:	48 8b 8d e8 02 00 00 	mov    rcx,QWORD PTR [rbp+0x2e8]
   1817a9a25:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1817a9a29:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1817a9a30:	72 1f                	jb     0x1817a9a51
   1817a9a32:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1817a9a36:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1817a9a3a:	4c 29 c1             	sub    rcx,r8
   1817a9a3d:	48 83 f9 20          	cmp    rcx,0x20
   1817a9a41:	0f 83 e1 04 00 00    	jae    0x1817a9f28
   1817a9a47:	48 83 c0 28          	add    rax,0x28
   1817a9a4b:	48 89 c2             	mov    rdx,rax
   1817a9a4e:	4c 89 c1             	mov    rcx,r8
   1817a9a51:	e8 ca 22 da 05       	call   0x18754bd20
   1817a9a56:	48 8b b5 b8 03 00 00 	mov    rsi,QWORD PTR [rbp+0x3b8]
   1817a9a5d:	48 85 f6             	test   rsi,rsi
   1817a9a60:	74 1d                	je     0x1817a9a7f
   1817a9a62:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1817a9a66:	75 17                	jne    0x1817a9a7f
   1817a9a68:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1817a9a6b:	48 89 f1             	mov    rcx,rsi
   1817a9a6e:	ff 10                	call   QWORD PTR [rax]
   1817a9a70:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1817a9a74:	75 09                	jne    0x1817a9a7f
   1817a9a76:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1817a9a79:	48 89 f1             	mov    rcx,rsi
   1817a9a7c:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1817a9a7f:	48 8b b5 c8 03 00 00 	mov    rsi,QWORD PTR [rbp+0x3c8]
   1817a9a86:	48 85 f6             	test   rsi,rsi
   1817a9a89:	74 1d                	je     0x1817a9aa8
   1817a9a8b:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1817a9a8f:	75 17                	jne    0x1817a9aa8
   1817a9a91:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1817a9a94:	48 89 f1             	mov    rcx,rsi
   1817a9a97:	ff 10                	call   QWORD PTR [rax]
   1817a9a99:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1817a9a9d:	75 09                	jne    0x1817a9aa8
   1817a9a9f:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1817a9aa2:	48 89 f1             	mov    rcx,rsi
   1817a9aa5:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1817a9aa8:	0f 28 b5 e0 03 00 00 	movaps xmm6,XMMWORD PTR [rbp+0x3e0]
   1817a9aaf:	48 81 c4 78 04 00 00 	add    rsp,0x478
   1817a9ab6:	5b                   	pop    rbx
   1817a9ab7:	5f                   	pop    rdi
   1817a9ab8:	5e                   	pop    rsi
   1817a9ab9:	41 5c                	pop    r12
   1817a9abb:	41 5d                	pop    r13
   1817a9abd:	41 5e                	pop    r14
   1817a9abf:	41 5f                	pop    r15
   1817a9ac1:	5d                   	pop    rbp
   1817a9ac2:	c3                   	ret
   1817a9ac3:	45 31 f6             	xor    r14d,r14d
   1817a9ac6:	48 89 9d 50 01 00 00 	mov    QWORD PTR [rbp+0x150],rbx
   1817a9acd:	4c 89 b5 58 01 00 00 	mov    QWORD PTR [rbp+0x158],r14
   1817a9ad4:	ba d0 00 00 00       	mov    edx,0xd0
   1817a9ad9:	48 03 96 f8 0b 00 00 	add    rdx,QWORD PTR [rsi+0xbf8]
   1817a9ae0:	4c 8d 85 50 01 00 00 	lea    r8,[rbp+0x150]
   1817a9ae7:	4c 8d 8d 60 01 00 00 	lea    r9,[rbp+0x160]
   1817a9aee:	e8 7d e0 ff ff       	call   0x1817a7b70
   1817a9af3:	90                   	nop
   1817a9af4:	48 8b 85 78 01 00 00 	mov    rax,QWORD PTR [rbp+0x178]
   1817a9afb:	48 83 f8 10          	cmp    rax,0x10
   1817a9aff:	72 38                	jb     0x1817a9b39
   1817a9b01:	48 8b 8d 60 01 00 00 	mov    rcx,QWORD PTR [rbp+0x160]
   1817a9b08:	48 8d 50 01          	lea    rdx,[rax+0x1]
   1817a9b0c:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   1817a9b13:	72 1f                	jb     0x1817a9b34
   1817a9b15:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   1817a9b19:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   1817a9b1d:	4c 29 c1             	sub    rcx,r8
   1817a9b20:	48 83 f9 20          	cmp    rcx,0x20
   1817a9b24:	0f 83 fe 03 00 00    	jae    0x1817a9f28
   1817a9b2a:	48 83 c0 28          	add    rax,0x28
   1817a9b2e:	48 89 c2             	mov    rdx,rax
   1817a9b31:	4c 89 c1             	mov    rcx,r8
   1817a9b34:	e8 e7 21 da 05       	call   0x18754bd20
   1817a9b39:	0f 29 b5 40 02 00 00 	movaps XMMWORD PTR [rbp+0x240],xmm6
   1817a9b40:	e8 cb c1 89 fe       	call   0x180045d10
   1817a9b45:	90                   	nop
   1817a9b46:	48 8d 95 90 02 00 00 	lea    rdx,[rbp+0x290]
   1817a9b4d:	48 89 c1             	mov    rcx,rax
   1817a9b50:	e8 bb d7 89 fe       	call   0x180047310
   1817a9b55:	90                   	nop
   1817a9b56:	48 8b 95 90 02 00 00 	mov    rdx,QWORD PTR [rbp+0x290]
   1817a9b5d:	4d 85 f6             	test   r14,r14
   1817a9b60:	74 15                	je     0x1817a9b77
   1817a9b62:	f0 41 ff 46 08       	lock inc DWORD PTR [r14+0x8]
   1817a9b67:	48 8b 9d c0 03 00 00 	mov    rbx,QWORD PTR [rbp+0x3c0]
   1817a9b6e:	48 8b 85 c8 03 00 00 	mov    rax,QWORD PTR [rbp+0x3c8]
   1817a9b75:	eb 02                	jmp    0x1817a9b79
   1817a9b77:	31 c0                	xor    eax,eax
   1817a9b79:	48 8d 0d 28 82 b0 07 	lea    rcx,[rip+0x7b08228]        # 0x1892b1da8
   1817a9b80:	48 89 4d 58          	mov    QWORD PTR [rbp+0x58],rcx
   1817a9b84:	48 89 5d 60          	mov    QWORD PTR [rbp+0x60],rbx
   1817a9b88:	48 89 45 68          	mov    QWORD PTR [rbp+0x68],rax
   1817a9b8c:	48 89 75 70          	mov    QWORD PTR [rbp+0x70],rsi
   1817a9b90:	48 8d 4d 58          	lea    rcx,[rbp+0x58]
   1817a9b94:	48 89 8d 90 00 00 00 	mov    QWORD PTR [rbp+0x90],rcx
   1817a9b9b:	0f 57 c0             	xorps  xmm0,xmm0
   1817a9b9e:	0f 29 85 60 01 00 00 	movaps XMMWORD PTR [rbp+0x160],xmm0
   1817a9ba5:	48 85 c0             	test   rax,rax
   1817a9ba8:	74 14                	je     0x1817a9bbe
   1817a9baa:	f0 ff 40 08          	lock inc DWORD PTR [rax+0x8]
   1817a9bae:	48 8b 9d c0 03 00 00 	mov    rbx,QWORD PTR [rbp+0x3c0]
   1817a9bb5:	4c 8b b5 c8 03 00 00 	mov    r14,QWORD PTR [rbp+0x3c8]
   1817a9bbc:	eb 03                	jmp    0x1817a9bc1
   1817a9bbe:	45 31 f6             	xor    r14d,r14d
   1817a9bc1:	48 89 9d 60 01 00 00 	mov    QWORD PTR [rbp+0x160],rbx
   1817a9bc8:	4c 89 b5 68 01 00 00 	mov    QWORD PTR [rbp+0x168],r14
   1817a9bcf:	48 89 b5 70 01 00 00 	mov    QWORD PTR [rbp+0x170],rsi
   1817a9bd6:	0f 11 85 78 01 00 00 	movups XMMWORD PTR [rbp+0x178],xmm0
   1817a9bdd:	0f 11 85 88 01 00 00 	movups XMMWORD PTR [rbp+0x188],xmm0
   1817a9be4:	4c 8b 67 10          	mov    r12,QWORD PTR [rdi+0x10]
   1817a9be8:	48 83 7f 18 10       	cmp    QWORD PTR [rdi+0x18],0x10
   1817a9bed:	72 03                	jb     0x1817a9bf2
   1817a9bef:	48 8b 3f             	mov    rdi,QWORD PTR [rdi]
   1817a9bf2:	4d 85 e4             	test   r12,r12
   1817a9bf5:	0f 88 39 03 00 00    	js     0x1817a9f34
   1817a9bfb:	4c 8d ad 78 01 00 00 	lea    r13,[rbp+0x178]
   1817a9c02:	49 83 fc 0f          	cmp    r12,0xf
   1817a9c06:	48 89 95 10 01 00 00 	mov    QWORD PTR [rbp+0x110],rdx
   1817a9c0d:	77 22                	ja     0x1817a9c31
   1817a9c0f:	4c 89 a5 88 01 00 00 	mov    QWORD PTR [rbp+0x188],r12
   1817a9c16:	48 c7 85 90 01 00 00 	mov    QWORD PTR [rbp+0x190],0xf
   1817a9c1d:	0f 00 00 00 
   1817a9c21:	0f 10 07             	movups xmm0,XMMWORD PTR [rdi]
   1817a9c24:	41 0f 11 45 00       	movups XMMWORD PTR [r13+0x0],xmm0
   1817a9c29:	41 bf 0f 00 00 00    	mov    r15d,0xf
   1817a9c2f:	eb 70                	jmp    0x1817a9ca1
   1817a9c31:	4c 89 e0             	mov    rax,r12
   1817a9c34:	48 83 c8 0f          	or     rax,0xf
   1817a9c38:	48 83 f8 17          	cmp    rax,0x17
   1817a9c3c:	41 bf 16 00 00 00    	mov    r15d,0x16
   1817a9c42:	4c 0f 43 f8          	cmovae r15,rax
   1817a9c46:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   1817a9c4c:	72 24                	jb     0x1817a9c72
   1817a9c4e:	49 8d 4f 28          	lea    rcx,[r15+0x28]
   1817a9c52:	e8 85 20 da 05       	call   0x18754bcdc
   1817a9c57:	90                   	nop
   1817a9c58:	48 85 c0             	test   rax,rax
   1817a9c5b:	0f 84 c7 02 00 00    	je     0x1817a9f28
   1817a9c61:	48 89 c1             	mov    rcx,rax
   1817a9c64:	48 83 c0 27          	add    rax,0x27
   1817a9c68:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
   1817a9c6c:	48 89 48 f8          	mov    QWORD PTR [rax-0x8],rcx
   1817a9c70:	eb 0a                	jmp    0x1817a9c7c
   1817a9c72:	49 8d 4f 01          	lea    rcx,[r15+0x1]
   1817a9c76:	e8 61 20 da 05       	call   0x18754bcdc
   1817a9c7b:	90                   	nop
   1817a9c7c:	48 89 85 78 01 00 00 	mov    QWORD PTR [rbp+0x178],rax
   1817a9c83:	4c 89 a5 88 01 00 00 	mov    QWORD PTR [rbp+0x188],r12
   1817a9c8a:	4c 89 bd 90 01 00 00 	mov    QWORD PTR [rbp+0x190],r15
   1817a9c91:	4d 8d 44 24 01       	lea    r8,[r12+0x1]
   1817a9c96:	48 89 c1             	mov    rcx,rax
   1817a9c99:	48 89 fa             	mov    rdx,rdi
   1817a9c9c:	e8 9f b1 f6 05       	call   0x187714e40
   1817a9ca1:	48 c7 45 00 00 00 00 	mov    QWORD PTR [rbp+0x0],0x0
   1817a9ca8:	00 
   1817a9ca9:	b9 40 00 00 00       	mov    ecx,0x40
   1817a9cae:	e8 29 20 da 05       	call   0x18754bcdc
   1817a9cb3:	90                   	nop
   1817a9cb4:	48 89 c7             	mov    rdi,rax
   1817a9cb7:	48 8d 05 4a 80 b0 07 	lea    rax,[rip+0x7b0804a]        # 0x1892b1d08
   1817a9cbe:	48 89 07             	mov    QWORD PTR [rdi],rax
   1817a9cc1:	48 89 5f 08          	mov    QWORD PTR [rdi+0x8],rbx
   1817a9cc5:	4c 89 77 10          	mov    QWORD PTR [rdi+0x10],r14
   1817a9cc9:	0f 57 c0             	xorps  xmm0,xmm0
   1817a9ccc:	0f 29 85 60 01 00 00 	movaps XMMWORD PTR [rbp+0x160],xmm0
   1817a9cd3:	48 89 77 18          	mov    QWORD PTR [rdi+0x18],rsi
   1817a9cd7:	0f 11 47 20          	movups XMMWORD PTR [rdi+0x20],xmm0
   1817a9cdb:	0f 11 47 30          	movups XMMWORD PTR [rdi+0x30],xmm0
   1817a9cdf:	49 83 ff 10          	cmp    r15,0x10
   1817a9ce3:	48 8b b5 78 01 00 00 	mov    rsi,QWORD PTR [rbp+0x178]
   1817a9cea:	4c 0f 43 ee          	cmovae r13,rsi
   1817a9cee:	49 83 fc 0f          	cmp    r12,0xf
   1817a9cf2:	77 20                	ja     0x1817a9d14
   1817a9cf4:	48 89 f8             	mov    rax,rdi
   1817a9cf7:	48 83 c0 20          	add    rax,0x20
   1817a9cfb:	4c 89 67 30          	mov    QWORD PTR [rdi+0x30],r12
   1817a9cff:	48 c7 47 38 0f 00 00 	mov    QWORD PTR [rdi+0x38],0xf
   1817a9d06:	00 
   1817a9d07:	41 0f 10 45 00       	movups xmm0,XMMWORD PTR [r13+0x0]
   1817a9d0c:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   1817a9d0f:	e9 83 00 00 00       	jmp    0x1817a9d97
   1817a9d14:	48 89 bd a8 03 00 00 	mov    QWORD PTR [rbp+0x3a8],rdi
   1817a9d1b:	48 8d 47 08          	lea    rax,[rdi+0x8]
   1817a9d1f:	48 89 85 18 01 00 00 	mov    QWORD PTR [rbp+0x118],rax
   1817a9d26:	4c 89 e0             	mov    rax,r12
   1817a9d29:	48 83 c8 0f          	or     rax,0xf
   1817a9d2d:	48 83 f8 17          	cmp    rax,0x17
   1817a9d31:	bf 16 00 00 00       	mov    edi,0x16
   1817a9d36:	48 0f 43 f8          	cmovae rdi,rax
   1817a9d3a:	48 3d ff 0f 00 00    	cmp    rax,0xfff
   1817a9d40:	72 24                	jb     0x1817a9d66
   1817a9d42:	48 8d 4f 28          	lea    rcx,[rdi+0x28]
   1817a9d46:	e8 91 1f da 05       	call   0x18754bcdc
   1817a9d4b:	90                   	nop
   1817a9d4c:	48 85 c0             	test   rax,rax
   1817a9d4f:	0f 84 d3 01 00 00    	je     0x1817a9f28
   1817a9d55:	48 89 c1             	mov    rcx,rax
   1817a9d58:	48 83 c0 27          	add    rax,0x27
   1817a9d5c:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
   1817a9d60:	48 89 48 f8          	mov    QWORD PTR [rax-0x8],rcx
   1817a9d64:	eb 0a                	jmp    0x1817a9d70
   1817a9d66:	48 8d 4f 01          	lea    rcx,[rdi+0x1]
   1817a9d6a:	e8 6d 1f da 05       	call   0x18754bcdc
   1817a9d6f:	90                   	nop
   1817a9d70:	48 8b 8d a8 03 00 00 	mov    rcx,QWORD PTR [rbp+0x3a8]
   1817a9d77:	48 89 41 20          	mov    QWORD PTR [rcx+0x20],rax
   1817a9d7b:	4c 89 61 30          	mov    QWORD PTR [rcx+0x30],r12
   1817a9d7f:	48 89 79 38          	mov    QWORD PTR [rcx+0x38],rdi
   1817a9d83:	48 89 cf             	mov    rdi,rcx
   1817a9d86:	49 ff c4             	inc    r12
   1817a9d89:	48 89 c1             	mov    rcx,rax
   1817a9d8c:	4c 89 ea             	mov    rdx,r13
   1817a9d8f:	4d 89 e0             	mov    r8,r12
   1817a9d92:	e8 a9 b0 f6 05       	call   0x187714e40
   1817a9d97:	48 89 7d 00          	mov    QWORD PTR [rbp+0x0],rdi
   1817a9d9b:	c6 85 d7 03 00 00 01 	mov    BYTE PTR [rbp+0x3d7],0x1
   1817a9da2:	48 8d 15 37 50 b1 07 	lea    rdx,[rip+0x7b15037]        # 0x1892bede0
   1817a9da9:	4c 8d 05 d0 9d b0 07 	lea    r8,[rip+0x7b09dd0]        # 0x1892b3b80
   1817a9db0:	48 8d 8d 20 03 00 00 	lea    rcx,[rbp+0x320]
   1817a9db7:	41 b9 51 10 00 00    	mov    r9d,0x1051
   1817a9dbd:	e8 2e 7e 9f fe       	call   0x1801a1bf0
   1817a9dc2:	90                   	nop
   1817a9dc3:	c6 85 d7 03 00 00 00 	mov    BYTE PTR [rbp+0x3d7],0x0
   1817a9dca:	48 8d 45 58          	lea    rax,[rbp+0x58]
   1817a9dce:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   1817a9dd3:	c7 44 24 28 00 00 00 	mov    DWORD PTR [rsp+0x28],0x0
   1817a9dda:	00 
   1817a9ddb:	48 8d 95 40 02 00 00 	lea    rdx,[rbp+0x240]
   1817a9de2:	4c 8d 85 20 03 00 00 	lea    r8,[rbp+0x320]
   1817a9de9:	4c 8d 4d c8          	lea    r9,[rbp-0x38]
   1817a9ded:	48 8b 8d 10 01 00 00 	mov    rcx,QWORD PTR [rbp+0x110]
   1817a9df4:	e8 f7 5b b6 fe       	call   0x18030f9f0
   1817a9df9:	90                   	nop
   1817a9dfa:	49 83 ff 10          	cmp    r15,0x10
   1817a9dfe:	72 35                	jb     0x1817a9e35
   1817a9e00:	49 81 ff ff 0f 00 00 	cmp    r15,0xfff
   1817a9e07:	72 1e                	jb     0x1817a9e27
   1817a9e09:	48 8b 46 f8          	mov    rax,QWORD PTR [rsi-0x8]
   1817a9e0d:	48 83 c6 f8          	add    rsi,0xfffffffffffffff8
   1817a9e11:	48 29 c6             	sub    rsi,rax
   1817a9e14:	48 83 fe 20          	cmp    rsi,0x20
   1817a9e18:	0f 83 0a 01 00 00    	jae    0x1817a9f28
   1817a9e1e:	49 83 c7 28          	add    r15,0x28
   1817a9e22:	48 89 c6             	mov    rsi,rax
   1817a9e25:	eb 03                	jmp    0x1817a9e2a
   1817a9e27:	49 ff c7             	inc    r15
   1817a9e2a:	48 89 f1             	mov    rcx,rsi
   1817a9e2d:	4c 89 fa             	mov    rdx,r15
   1817a9e30:	e8 eb 1e da 05       	call   0x18754bd20
   1817a9e35:	48 8b b5 98 02 00 00 	mov    rsi,QWORD PTR [rbp+0x298]
   1817a9e3c:	48 85 f6             	test   rsi,rsi
   1817a9e3f:	74 1d                	je     0x1817a9e5e
   1817a9e41:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1817a9e45:	75 17                	jne    0x1817a9e5e
   1817a9e47:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1817a9e4a:	48 89 f1             	mov    rcx,rsi
   1817a9e4d:	ff 10                	call   QWORD PTR [rax]
   1817a9e4f:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1817a9e53:	75 09                	jne    0x1817a9e5e
   1817a9e55:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1817a9e58:	48 89 f1             	mov    rcx,rsi
   1817a9e5b:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1817a9e5e:	48 8b 85 c0 03 00 00 	mov    rax,QWORD PTR [rbp+0x3c0]
   1817a9e65:	48 8b 8d 48 02 00 00 	mov    rcx,QWORD PTR [rbp+0x248]
   1817a9e6c:	48 85 c9             	test   rcx,rcx
   1817a9e6f:	74 1f                	je     0x1817a9e90
   1817a9e71:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   1817a9e75:	48 8b 8d 40 02 00 00 	mov    rcx,QWORD PTR [rbp+0x240]
   1817a9e7c:	48 8b b5 48 02 00 00 	mov    rsi,QWORD PTR [rbp+0x248]
   1817a9e83:	48 85 f6             	test   rsi,rsi
   1817a9e86:	74 13                	je     0x1817a9e9b
   1817a9e88:	f0 ff 46 08          	lock inc DWORD PTR [rsi+0x8]
   1817a9e8c:	31 db                	xor    ebx,ebx
   1817a9e8e:	eb 0f                	jmp    0x1817a9e9f
   1817a9e90:	b3 01                	mov    bl,0x1
   1817a9e92:	48 8b 8d 40 02 00 00 	mov    rcx,QWORD PTR [rbp+0x240]
   1817a9e99:	eb 02                	jmp    0x1817a9e9d
   1817a9e9b:	b3 01                	mov    bl,0x1
   1817a9e9d:	31 f6                	xor    esi,esi
   1817a9e9f:	48 89 48 58          	mov    QWORD PTR [rax+0x58],rcx
   1817a9ea3:	48 8b 78 60          	mov    rdi,QWORD PTR [rax+0x60]
   1817a9ea7:	48 89 70 60          	mov    QWORD PTR [rax+0x60],rsi
   1817a9eab:	48 85 ff             	test   rdi,rdi
   1817a9eae:	74 1d                	je     0x1817a9ecd
   1817a9eb0:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   1817a9eb4:	75 17                	jne    0x1817a9ecd
   1817a9eb6:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1817a9eb9:	48 89 f9             	mov    rcx,rdi
   1817a9ebc:	ff 10                	call   QWORD PTR [rax]
   1817a9ebe:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   1817a9ec2:	75 09                	jne    0x1817a9ecd
   1817a9ec4:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   1817a9ec7:	48 89 f9             	mov    rcx,rdi
   1817a9eca:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1817a9ecd:	84 db                	test   bl,bl
   1817a9ecf:	75 1d                	jne    0x1817a9eee
   1817a9ed1:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1817a9ed5:	75 17                	jne    0x1817a9eee
   1817a9ed7:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1817a9eda:	48 89 f1             	mov    rcx,rsi
   1817a9edd:	ff 10                	call   QWORD PTR [rax]
   1817a9edf:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1817a9ee3:	75 09                	jne    0x1817a9eee
   1817a9ee5:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1817a9ee8:	48 89 f1             	mov    rcx,rsi
   1817a9eeb:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1817a9eee:	48 8b b5 48 02 00 00 	mov    rsi,QWORD PTR [rbp+0x248]
   1817a9ef5:	48 85 f6             	test   rsi,rsi
   1817a9ef8:	0f 84 ea fa ff ff    	je     0x1817a99e8
   1817a9efe:	f0 ff 4e 08          	lock dec DWORD PTR [rsi+0x8]
   1817a9f02:	0f 85 e0 fa ff ff    	jne    0x1817a99e8
   1817a9f08:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1817a9f0b:	48 89 f1             	mov    rcx,rsi
   1817a9f0e:	ff 10                	call   QWORD PTR [rax]
   1817a9f10:	f0 ff 4e 0c          	lock dec DWORD PTR [rsi+0xc]
   1817a9f14:	0f 85 ce fa ff ff    	jne    0x1817a99e8
   1817a9f1a:	48 8b 06             	mov    rax,QWORD PTR [rsi]
   1817a9f1d:	48 89 f1             	mov    rcx,rsi
   1817a9f20:	ff 50 08             	call   QWORD PTR [rax+0x8]
   1817a9f23:	e9 c0 fa ff ff       	jmp    0x1817a99e8
   1817a9f28:	e8 5f 42 f3 05       	call   0x1876de18c
   1817a9f2d:	90                   	nop
   1817a9f2e:	e8 5d ec 85 fe       	call   0x180008b90
   1817a9f33:	90                   	nop
   1817a9f34:	e8 57 ec 85 fe       	call   0x180008b90
   1817a9f39:	90                   	nop
   1817a9f3a:	cc                   	int3
