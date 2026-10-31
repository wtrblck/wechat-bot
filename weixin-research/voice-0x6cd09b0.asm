
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

0000000186cd09b0 <.text+0x6ccf9b0>:
   186cd09b0:	55                   	push   rbp
   186cd09b1:	41 57                	push   r15
   186cd09b3:	41 56                	push   r14
   186cd09b5:	41 54                	push   r12
   186cd09b7:	56                   	push   rsi
   186cd09b8:	57                   	push   rdi
   186cd09b9:	53                   	push   rbx
   186cd09ba:	48 83 ec 40          	sub    rsp,0x40
   186cd09be:	48 8d 6c 24 40       	lea    rbp,[rsp+0x40]
   186cd09c3:	48 c7 45 f8 fe ff ff 	mov    QWORD PTR [rbp-0x8],0xfffffffffffffffe
   186cd09ca:	ff 
   186cd09cb:	4c 89 cb             	mov    rbx,r9
   186cd09ce:	4d 89 c6             	mov    r14,r8
   186cd09d1:	49 89 d7             	mov    r15,rdx
   186cd09d4:	48 89 ce             	mov    rsi,rcx
   186cd09d7:	4c 8b 65 60          	mov    r12,QWORD PTR [rbp+0x60]
   186cd09db:	b9 c8 07 00 00       	mov    ecx,0x7c8
   186cd09e0:	e8 f7 b2 87 00       	call   0x18754bcdc
   186cd09e5:	48 b9 01 00 00 00 01 	movabs rcx,0x100000001
   186cd09ec:	00 00 00 
   186cd09ef:	48 89 48 08          	mov    QWORD PTR [rax+0x8],rcx
   186cd09f3:	48 8d 0d 8e ed 02 03 	lea    rcx,[rip+0x302ed8e]        # 0x189cff788
   186cd09fa:	48 89 08             	mov    QWORD PTR [rax],rcx
   186cd09fd:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
   186cd0a01:	48 8d 78 10          	lea    rdi,[rax+0x10]
   186cd0a05:	44 8b 0b             	mov    r9d,DWORD PTR [rbx]
   186cd0a08:	4c 89 64 24 20       	mov    QWORD PTR [rsp+0x20],r12
   186cd0a0d:	48 89 f9             	mov    rcx,rdi
   186cd0a10:	4c 89 fa             	mov    rdx,r15
   186cd0a13:	4d 89 f0             	mov    r8,r14
   186cd0a16:	e8 b5 11 00 00       	call   0x186cd1bd0
   186cd0a1b:	90                   	nop
   186cd0a1c:	48 89 3e             	mov    QWORD PTR [rsi],rdi
   186cd0a1f:	48 8b 5d f0          	mov    rbx,QWORD PTR [rbp-0x10]
   186cd0a23:	48 89 5e 08          	mov    QWORD PTR [rsi+0x8],rbx
   186cd0a27:	48 8b 4b 20          	mov    rcx,QWORD PTR [rbx+0x20]
   186cd0a2b:	48 85 c9             	test   rcx,rcx
   186cd0a2e:	74 06                	je     0x186cd0a36
   186cd0a30:	83 79 08 00          	cmp    DWORD PTR [rcx+0x8],0x0
   186cd0a34:	75 66                	jne    0x186cd0a9c
   186cd0a36:	48 85 db             	test   rbx,rbx
   186cd0a39:	74 1b                	je     0x186cd0a56
   186cd0a3b:	f0 ff 43 08          	lock inc DWORD PTR [rbx+0x8]
   186cd0a3f:	f0 ff 43 0c          	lock inc DWORD PTR [rbx+0xc]
   186cd0a43:	48 8b 4b 20          	mov    rcx,QWORD PTR [rbx+0x20]
   186cd0a47:	48 89 7b 18          	mov    QWORD PTR [rbx+0x18],rdi
   186cd0a4b:	48 89 5b 20          	mov    QWORD PTR [rbx+0x20],rbx
   186cd0a4f:	48 85 c9             	test   rcx,rcx
   186cd0a52:	75 11                	jne    0x186cd0a65
   186cd0a54:	eb 1b                	jmp    0x186cd0a71
   186cd0a56:	31 ff                	xor    edi,edi
   186cd0a58:	48 89 7b 18          	mov    QWORD PTR [rbx+0x18],rdi
   186cd0a5c:	48 89 5b 20          	mov    QWORD PTR [rbx+0x20],rbx
   186cd0a60:	48 85 c9             	test   rcx,rcx
   186cd0a63:	74 0c                	je     0x186cd0a71
   186cd0a65:	f0 ff 49 0c          	lock dec DWORD PTR [rcx+0xc]
   186cd0a69:	75 06                	jne    0x186cd0a71
   186cd0a6b:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   186cd0a6e:	ff 50 08             	call   QWORD PTR [rax+0x8]
   186cd0a71:	48 85 db             	test   rbx,rbx
   186cd0a74:	74 26                	je     0x186cd0a9c
   186cd0a76:	48 8d 43 08          	lea    rax,[rbx+0x8]
   186cd0a7a:	f0 ff 08             	lock dec DWORD PTR [rax]
   186cd0a7d:	75 1d                	jne    0x186cd0a9c
   186cd0a7f:	48 89 df             	mov    rdi,rbx
   186cd0a82:	48 83 c7 0c          	add    rdi,0xc
   186cd0a86:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   186cd0a89:	48 89 d9             	mov    rcx,rbx
   186cd0a8c:	ff 10                	call   QWORD PTR [rax]
   186cd0a8e:	f0 ff 0f             	lock dec DWORD PTR [rdi]
   186cd0a91:	75 09                	jne    0x186cd0a9c
   186cd0a93:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   186cd0a96:	48 89 d9             	mov    rcx,rbx
   186cd0a99:	ff 50 08             	call   QWORD PTR [rax+0x8]
   186cd0a9c:	48 89 f0             	mov    rax,rsi
   186cd0a9f:	48 83 c4 40          	add    rsp,0x40
   186cd0aa3:	5b                   	pop    rbx
   186cd0aa4:	5f                   	pop    rdi
   186cd0aa5:	5e                   	pop    rsi
   186cd0aa6:	41 5c                	pop    r12
   186cd0aa8:	41 5e                	pop    r14
   186cd0aaa:	41 5f                	pop    r15
   186cd0aac:	5d                   	pop    rbp
   186cd0aad:	c3                   	ret
