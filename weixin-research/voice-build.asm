
E:/Tencent/Weixin/4.1.15.56/Weixin.dll:     file format pei-x86-64


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
   186cd0aae:	66 90                	xchg   ax,ax
   186cd0ab0:	48 89 54 24 10       	mov    QWORD PTR [rsp+0x10],rdx
   186cd0ab5:	55                   	push   rbp
   186cd0ab6:	41 57                	push   r15
   186cd0ab8:	41 56                	push   r14
   186cd0aba:	41 54                	push   r12
   186cd0abc:	56                   	push   rsi
   186cd0abd:	57                   	push   rdi
   186cd0abe:	53                   	push   rbx
   186cd0abf:	48 83 ec 30          	sub    rsp,0x30
   186cd0ac3:	48 8d 6a 40          	lea    rbp,[rdx+0x40]
   186cd0ac7:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
   186cd0acb:	e8 48 b2 87 00       	call   0x18754bd18
   186cd0ad0:	90                   	nop
   186cd0ad1:	48 83 c4 30          	add    rsp,0x30
   186cd0ad5:	5b                   	pop    rbx
   186cd0ad6:	5f                   	pop    rdi
   186cd0ad7:	5e                   	pop    rsi
   186cd0ad8:	41 5c                	pop    r12
   186cd0ada:	41 5e                	pop    r14
   186cd0adc:	41 5f                	pop    r15
   186cd0ade:	5d                   	pop    rbp
   186cd0adf:	c3                   	ret
   186cd0ae0:	55                   	push   rbp
   186cd0ae1:	41 57                	push   r15
   186cd0ae3:	41 56                	push   r14
   186cd0ae5:	56                   	push   rsi
   186cd0ae6:	57                   	push   rdi
   186cd0ae7:	53                   	push   rbx
   186cd0ae8:	48 83 ec 38          	sub    rsp,0x38
   186cd0aec:	48 8d 6c 24 30       	lea    rbp,[rsp+0x30]
   186cd0af1:	48 c7 45 00 fe ff ff 	mov    QWORD PTR [rbp+0x0],0xfffffffffffffffe
   186cd0af8:	ff 
   186cd0af9:	4c 89 c6             	mov    rsi,r8
   186cd0afc:	48 89 d3             	mov    rbx,rdx
   186cd0aff:	b9 a0 00 00 00       	mov    ecx,0xa0
   186cd0b04:	e8 d3 b1 87 00       	call   0x18754bcdc
   186cd0b09:	48 89 c7             	mov    rdi,rax
   186cd0b0c:	49 89 c7             	mov    r15,rax
   186cd0b0f:	48 b8 01 00 00 00 01 	movabs rax,0x100000001
   186cd0b16:	00 00 00 
   186cd0b19:	48 89 47 08          	mov    QWORD PTR [rdi+0x8],rax
   186cd0b1d:	48 8d 05 a4 ed 02 03 	lea    rax,[rip+0x302eda4]        # 0x189cff8c8
   186cd0b24:	48 89 07             	mov    QWORD PTR [rdi],rax
   186cd0b27:	48 8d 4f 10          	lea    rcx,[rdi+0x10]
   186cd0b2b:	0f 57 c0             	xorps  xmm0,xmm0
   186cd0b2e:	0f 11 47 20          	movups XMMWORD PTR [rdi+0x20],xmm0
   186cd0b32:	0f 11 47 40          	movups XMMWORD PTR [rdi+0x40],xmm0
   186cd0b36:	0f 11 47 60          	movups XMMWORD PTR [rdi+0x60],xmm0
   186cd0b3a:	0f 11 47 70          	movups XMMWORD PTR [rdi+0x70],xmm0
   186cd0b3e:	0f 11 47 10          	movups XMMWORD PTR [rdi+0x10],xmm0
   186cd0b42:	48 c7 47 28 0f 00 00 	mov    QWORD PTR [rdi+0x28],0xf
   186cd0b49:	00 
   186cd0b4a:	0f 11 47 30          	movups XMMWORD PTR [rdi+0x30],xmm0
   186cd0b4e:	48 c7 47 40 00 00 00 	mov    QWORD PTR [rdi+0x40],0x0
   186cd0b55:	00 
   186cd0b56:	48 c7 47 48 0f 00 00 	mov    QWORD PTR [rdi+0x48],0xf
   186cd0b5d:	00 
   186cd0b5e:	0f 11 47 50          	movups XMMWORD PTR [rdi+0x50],xmm0
   186cd0b62:	48 c7 47 60 00 00 00 	mov    QWORD PTR [rdi+0x60],0x0
   186cd0b69:	00 
   186cd0b6a:	48 c7 47 68 0f 00 00 	mov    QWORD PTR [rdi+0x68],0xf
   186cd0b71:	00 
   186cd0b72:	0f 11 87 80 00 00 00 	movups XMMWORD PTR [rdi+0x80],xmm0
   186cd0b79:	48 c7 87 90 00 00 00 	mov    QWORD PTR [rdi+0x90],0x0
   186cd0b80:	00 00 00 00 
   186cd0b84:	48 c7 47 75 00 00 00 	mov    QWORD PTR [rdi+0x75],0x0
   186cd0b8b:	00 
   186cd0b8c:	48 c7 47 70 00 00 00 	mov    QWORD PTR [rdi+0x70],0x0
   186cd0b93:	00 
   186cd0b94:	48 c7 87 98 00 00 00 	mov    QWORD PTR [rdi+0x98],0xf
   186cd0b9b:	0f 00 00 00 
   186cd0b9f:	48 89 0b             	mov    QWORD PTR [rbx],rcx
   186cd0ba2:	48 89 5d f8          	mov    QWORD PTR [rbp-0x8],rbx
   186cd0ba6:	48 89 7b 08          	mov    QWORD PTR [rbx+0x8],rdi
   186cd0baa:	48 39 f1             	cmp    rcx,rsi
   186cd0bad:	74 20                	je     0x186cd0bcf
   186cd0baf:	48 8b 5e 10          	mov    rbx,QWORD PTR [rsi+0x10]
   186cd0bb3:	48 83 7e 18 10       	cmp    QWORD PTR [rsi+0x18],0x10
   186cd0bb8:	49 89 f1             	mov    r9,rsi
   186cd0bbb:	72 03                	jb     0x186cd0bc0
   186cd0bbd:	4c 8b 0e             	mov    r9,QWORD PTR [rsi]
   186cd0bc0:	48 83 fb 0f          	cmp    rbx,0xf
   186cd0bc4:	76 1b                	jbe    0x186cd0be1
   186cd0bc6:	48 89 da             	mov    rdx,rbx
   186cd0bc9:	e8 82 d5 36 f9       	call   0x18003e150
   186cd0bce:	90                   	nop
   186cd0bcf:	4c 8d 8e 18 01 00 00 	lea    r9,[rsi+0x118]
   186cd0bd6:	48 8d 5f 30          	lea    rbx,[rdi+0x30]
   186cd0bda:	4c 39 cb             	cmp    rbx,r9
   186cd0bdd:	75 27                	jne    0x186cd0c06
   186cd0bdf:	eb 52                	jmp    0x186cd0c33
   186cd0be1:	49 89 5f 20          	mov    QWORD PTR [r15+0x20],rbx
   186cd0be5:	4c 89 ca             	mov    rdx,r9
   186cd0be8:	49 89 d8             	mov    r8,rbx
   186cd0beb:	e8 50 42 a4 00       	call   0x187714e40
   186cd0bf0:	41 c6 44 1f 10 00    	mov    BYTE PTR [r15+rbx*1+0x10],0x0
   186cd0bf6:	4c 8d 8e 18 01 00 00 	lea    r9,[rsi+0x118]
   186cd0bfd:	48 8d 5f 30          	lea    rbx,[rdi+0x30]
   186cd0c01:	4c 39 cb             	cmp    rbx,r9
   186cd0c04:	74 2d                	je     0x186cd0c33
   186cd0c06:	4c 8b b6 28 01 00 00 	mov    r14,QWORD PTR [rsi+0x128]
   186cd0c0d:	48 83 be 30 01 00 00 	cmp    QWORD PTR [rsi+0x130],0x10
   186cd0c14:	10 
   186cd0c15:	72 07                	jb     0x186cd0c1e
   186cd0c17:	4c 8b 8e 18 01 00 00 	mov    r9,QWORD PTR [rsi+0x118]
   186cd0c1e:	49 8b 47 48          	mov    rax,QWORD PTR [r15+0x48]
   186cd0c22:	49 39 c6             	cmp    r14,rax
   186cd0c25:	76 1e                	jbe    0x186cd0c45
   186cd0c27:	48 89 d9             	mov    rcx,rbx
   186cd0c2a:	4c 89 f2             	mov    rdx,r14
   186cd0c2d:	e8 1e d5 36 f9       	call   0x18003e150
   186cd0c32:	90                   	nop
   186cd0c33:	4c 8d 8e 38 01 00 00 	lea    r9,[rsi+0x138]
   186cd0c3a:	48 83 c7 50          	add    rdi,0x50
   186cd0c3e:	4c 39 cf             	cmp    rdi,r9
   186cd0c41:	75 32                	jne    0x186cd0c75
   186cd0c43:	eb 7e                	jmp    0x186cd0cc3
   186cd0c45:	48 83 f8 10          	cmp    rax,0x10
   186cd0c49:	72 03                	jb     0x186cd0c4e
   186cd0c4b:	48 8b 1b             	mov    rbx,QWORD PTR [rbx]
   186cd0c4e:	4d 89 77 40          	mov    QWORD PTR [r15+0x40],r14
   186cd0c52:	48 89 d9             	mov    rcx,rbx
   186cd0c55:	4c 89 ca             	mov    rdx,r9
   186cd0c58:	4d 89 f0             	mov    r8,r14
   186cd0c5b:	e8 e0 41 a4 00       	call   0x187714e40
   186cd0c60:	42 c6 04 33 00       	mov    BYTE PTR [rbx+r14*1],0x0
   186cd0c65:	4c 8d 8e 38 01 00 00 	lea    r9,[rsi+0x138]
   186cd0c6c:	48 83 c7 50          	add    rdi,0x50
   186cd0c70:	4c 39 cf             	cmp    rdi,r9
   186cd0c73:	74 4e                	je     0x186cd0cc3
   186cd0c75:	48 8b 9e 48 01 00 00 	mov    rbx,QWORD PTR [rsi+0x148]
   186cd0c7c:	48 83 be 50 01 00 00 	cmp    QWORD PTR [rsi+0x150],0x10
   186cd0c83:	10 
   186cd0c84:	72 07                	jb     0x186cd0c8d
   186cd0c86:	4c 8b 8e 38 01 00 00 	mov    r9,QWORD PTR [rsi+0x138]
   186cd0c8d:	49 8b 47 68          	mov    rax,QWORD PTR [r15+0x68]
   186cd0c91:	48 39 c3             	cmp    rbx,rax
   186cd0c94:	76 0e                	jbe    0x186cd0ca4
   186cd0c96:	48 89 f9             	mov    rcx,rdi
   186cd0c99:	48 89 da             	mov    rdx,rbx
   186cd0c9c:	e8 af d4 36 f9       	call   0x18003e150
   186cd0ca1:	90                   	nop
   186cd0ca2:	eb 1f                	jmp    0x186cd0cc3
   186cd0ca4:	48 83 f8 10          	cmp    rax,0x10
   186cd0ca8:	72 03                	jb     0x186cd0cad
   186cd0caa:	48 8b 3f             	mov    rdi,QWORD PTR [rdi]
   186cd0cad:	49 89 5f 60          	mov    QWORD PTR [r15+0x60],rbx
   186cd0cb1:	48 89 f9             	mov    rcx,rdi
   186cd0cb4:	4c 89 ca             	mov    rdx,r9
   186cd0cb7:	49 89 d8             	mov    r8,rbx
   186cd0cba:	e8 81 41 a4 00       	call   0x187714e40
   186cd0cbf:	c6 04 1f 00          	mov    BYTE PTR [rdi+rbx*1],0x0
   186cd0cc3:	8b 46 50             	mov    eax,DWORD PTR [rsi+0x50]
   186cd0cc6:	41 89 47 70          	mov    DWORD PTR [r15+0x70],eax
   186cd0cca:	8b 86 58 01 00 00    	mov    eax,DWORD PTR [rsi+0x158]
   186cd0cd0:	41 89 47 78          	mov    DWORD PTR [r15+0x78],eax
   186cd0cd4:	85 c0                	test   eax,eax
   186cd0cd6:	0f 94 c0             	sete   al
   186cd0cd9:	22 86 5c 01 00 00    	and    al,BYTE PTR [rsi+0x15c]
   186cd0cdf:	41 88 47 7c          	mov    BYTE PTR [r15+0x7c],al
   186cd0ce3:	8b 86 08 01 00 00    	mov    eax,DWORD PTR [rsi+0x108]
   186cd0ce9:	41 89 47 74          	mov    DWORD PTR [r15+0x74],eax
   186cd0ced:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
   186cd0cf1:	48 83 c4 38          	add    rsp,0x38
   186cd0cf5:	5b                   	pop    rbx
   186cd0cf6:	5f                   	pop    rdi
   186cd0cf7:	5e                   	pop    rsi
   186cd0cf8:	41 5e                	pop    r14
   186cd0cfa:	41 5f                	pop    r15
   186cd0cfc:	5d                   	pop    rbp
   186cd0cfd:	c3                   	ret
   186cd0cfe:	66 90                	xchg   ax,ax
   186cd0d00:	48 89 54 24 10       	mov    QWORD PTR [rsp+0x10],rdx
   186cd0d05:	55                   	push   rbp
   186cd0d06:	41 57                	push   r15
   186cd0d08:	41 56                	push   r14
   186cd0d0a:	56                   	push   rsi
   186cd0d0b:	57                   	push   rdi
   186cd0d0c:	53                   	push   rbx
   186cd0d0d:	48 83 ec 28          	sub    rsp,0x28
   186cd0d11:	48 8d 6a 30          	lea    rbp,[rdx+0x30]
   186cd0d15:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
   186cd0d19:	e8 42 13 33 f9       	call   0x180002060
   186cd0d1e:	90                   	nop
   186cd0d1f:	48 83 c4 28          	add    rsp,0x28
   186cd0d23:	5b                   	pop    rbx
   186cd0d24:	5f                   	pop    rdi
   186cd0d25:	5e                   	pop    rsi
   186cd0d26:	41 5e                	pop    r14
   186cd0d28:	41 5f                	pop    r15
   186cd0d2a:	5d                   	pop    rbp
   186cd0d2b:	c3                   	ret
   186cd0d2c:	cc                   	int3
   186cd0d2d:	cc                   	int3
   186cd0d2e:	cc                   	int3
   186cd0d2f:	cc                   	int3
   186cd0d30:	55                   	push   rbp
   186cd0d31:	56                   	push   rsi
   186cd0d32:	57                   	push   rdi
   186cd0d33:	53                   	push   rbx
   186cd0d34:	48 83 ec 38          	sub    rsp,0x38
   186cd0d38:	48 8d 6c 24 30       	lea    rbp,[rsp+0x30]
   186cd0d3d:	48 c7 45 00 fe ff ff 	mov    QWORD PTR [rbp+0x0],0xfffffffffffffffe
   186cd0d44:	ff 
   186cd0d45:	48 89 ce             	mov    rsi,rcx
   186cd0d48:	b9 70 00 00 00       	mov    ecx,0x70
   186cd0d4d:	e8 8a af 87 00       	call   0x18754bcdc
   186cd0d52:	48 b9 01 00 00 00 01 	movabs rcx,0x100000001
   186cd0d59:	00 00 00 
   186cd0d5c:	48 89 48 08          	mov    QWORD PTR [rax+0x8],rcx
   186cd0d60:	48 8d 0d 61 e4 02 03 	lea    rcx,[rip+0x302e461]        # 0x189cff1c8
   186cd0d67:	48 89 08             	mov    QWORD PTR [rax],rcx
   186cd0d6a:	48 8d 78 10          	lea    rdi,[rax+0x10]
   186cd0d6e:	0f 57 c0             	xorps  xmm0,xmm0
   186cd0d71:	0f 11 40 10          	movups XMMWORD PTR [rax+0x10],xmm0
   186cd0d75:	0f 11 40 20          	movups XMMWORD PTR [rax+0x20],xmm0
   186cd0d79:	0f 11 40 30          	movups XMMWORD PTR [rax+0x30],xmm0
   186cd0d7d:	0f 11 40 40          	movups XMMWORD PTR [rax+0x40],xmm0
   186cd0d81:	0f 11 40 50          	movups XMMWORD PTR [rax+0x50],xmm0
   186cd0d85:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
   186cd0d89:	0f 11 40 60          	movups XMMWORD PTR [rax+0x60],xmm0
   186cd0d8d:	48 89 f9             	mov    rcx,rdi
   186cd0d90:	e8 cb 00 00 00       	call   0x186cd0e60
   186cd0d95:	90                   	nop
   186cd0d96:	48 8d 05 bb e4 02 03 	lea    rax,[rip+0x302e4bb]        # 0x189cff258
   186cd0d9d:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
   186cd0da1:	48 89 43 10          	mov    QWORD PTR [rbx+0x10],rax
   186cd0da5:	48 89 3e             	mov    QWORD PTR [rsi],rdi
   186cd0da8:	48 89 5e 08          	mov    QWORD PTR [rsi+0x8],rbx
   186cd0dac:	48 8b 4b 20          	mov    rcx,QWORD PTR [rbx+0x20]
   186cd0db0:	48 85 c9             	test   rcx,rcx
   186cd0db3:	74 06                	je     0x186cd0dbb
   186cd0db5:	83 79 08 00          	cmp    DWORD PTR [rcx+0x8],0x0
   186cd0db9:	75 66                	jne    0x186cd0e21
   186cd0dbb:	48 85 db             	test   rbx,rbx
   186cd0dbe:	74 1b                	je     0x186cd0ddb
   186cd0dc0:	f0 ff 43 08          	lock inc DWORD PTR [rbx+0x8]
   186cd0dc4:	f0 ff 43 0c          	lock inc DWORD PTR [rbx+0xc]
   186cd0dc8:	48 8b 4b 20          	mov    rcx,QWORD PTR [rbx+0x20]
   186cd0dcc:	48 89 7b 18          	mov    QWORD PTR [rbx+0x18],rdi
   186cd0dd0:	48 89 5b 20          	mov    QWORD PTR [rbx+0x20],rbx
   186cd0dd4:	48 85 c9             	test   rcx,rcx
   186cd0dd7:	75 11                	jne    0x186cd0dea
   186cd0dd9:	eb 1b                	jmp    0x186cd0df6
   186cd0ddb:	31 ff                	xor    edi,edi
   186cd0ddd:	48 89 7b 18          	mov    QWORD PTR [rbx+0x18],rdi
   186cd0de1:	48 89 5b 20          	mov    QWORD PTR [rbx+0x20],rbx
   186cd0de5:	48 85 c9             	test   rcx,rcx
   186cd0de8:	74 0c                	je     0x186cd0df6
   186cd0dea:	f0 ff 49 0c          	lock dec DWORD PTR [rcx+0xc]
   186cd0dee:	75 06                	jne    0x186cd0df6
   186cd0df0:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   186cd0df3:	ff 50 08             	call   QWORD PTR [rax+0x8]
   186cd0df6:	48 85 db             	test   rbx,rbx
   186cd0df9:	74 26                	je     0x186cd0e21
   186cd0dfb:	48 8d 43 08          	lea    rax,[rbx+0x8]
   186cd0dff:	f0 ff 08             	lock dec DWORD PTR [rax]
   186cd0e02:	75 1d                	jne    0x186cd0e21
   186cd0e04:	48 89 df             	mov    rdi,rbx
   186cd0e07:	48 83 c7 0c          	add    rdi,0xc
   186cd0e0b:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   186cd0e0e:	48 89 d9             	mov    rcx,rbx
   186cd0e11:	ff 10                	call   QWORD PTR [rax]
   186cd0e13:	f0 ff 0f             	lock dec DWORD PTR [rdi]
   186cd0e16:	75 09                	jne    0x186cd0e21
   186cd0e18:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   186cd0e1b:	48 89 d9             	mov    rcx,rbx
   186cd0e1e:	ff 50 08             	call   QWORD PTR [rax+0x8]
   186cd0e21:	48 89 f0             	mov    rax,rsi
   186cd0e24:	48 83 c4 38          	add    rsp,0x38
   186cd0e28:	5b                   	pop    rbx
   186cd0e29:	5f                   	pop    rdi
   186cd0e2a:	5e                   	pop    rsi
   186cd0e2b:	5d                   	pop    rbp
   186cd0e2c:	c3                   	ret
   186cd0e2d:	0f 1f 00             	nop    DWORD PTR [rax]
   186cd0e30:	48 89 54 24 10       	mov    QWORD PTR [rsp+0x10],rdx
   186cd0e35:	55                   	push   rbp
   186cd0e36:	56                   	push   rsi
   186cd0e37:	57                   	push   rdi
   186cd0e38:	53                   	push   rbx
   186cd0e39:	48 83 ec 28          	sub    rsp,0x28
   186cd0e3d:	48 8d 6a 30          	lea    rbp,[rdx+0x30]
   186cd0e41:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
   186cd0e45:	e8 ce ae 87 00       	call   0x18754bd18
   186cd0e4a:	90                   	nop
   186cd0e4b:	48 83 c4 28          	add    rsp,0x28
   186cd0e4f:	5b                   	pop    rbx
   186cd0e50:	5f                   	pop    rdi
   186cd0e51:	5e                   	pop    rsi
   186cd0e52:	5d                   	pop    rbp
   186cd0e53:	c3                   	ret
   186cd0e54:	cc                   	int3
   186cd0e55:	cc                   	int3
   186cd0e56:	cc                   	int3
   186cd0e57:	cc                   	int3
   186cd0e58:	cc                   	int3
   186cd0e59:	cc                   	int3
   186cd0e5a:	cc                   	int3
   186cd0e5b:	cc                   	int3
   186cd0e5c:	cc                   	int3
   186cd0e5d:	cc                   	int3
   186cd0e5e:	cc                   	int3
   186cd0e5f:	cc                   	int3
   186cd0e60:	55                   	push   rbp
   186cd0e61:	48 83 ec 60          	sub    rsp,0x60
   186cd0e65:	48 8d 6c 24 60       	lea    rbp,[rsp+0x60]
   186cd0e6a:	0f 29 75 f0          	movaps XMMWORD PTR [rbp-0x10],xmm6
   186cd0e6e:	48 c7 45 e8 fe ff ff 	mov    QWORD PTR [rbp-0x18],0xfffffffffffffffe
   186cd0e75:	ff 
   186cd0e76:	0f 57 f6             	xorps  xmm6,xmm6
   186cd0e79:	0f 11 71 08          	movups XMMWORD PTR [rcx+0x8],xmm6
   186cd0e7d:	48 8d 05 f4 e4 02 03 	lea    rax,[rip+0x302e4f4]        # 0x189cff378
   186cd0e84:	48 89 01             	mov    QWORD PTR [rcx],rax
   186cd0e87:	48 89 4d e0          	mov    QWORD PTR [rbp-0x20],rcx
   186cd0e8b:	0f 11 71 18          	movups XMMWORD PTR [rcx+0x18],xmm6
   186cd0e8f:	b9 38 00 00 00       	mov    ecx,0x38
   186cd0e94:	e8 43 ae 87 00       	call   0x18754bcdc
   186cd0e99:	90                   	nop
   186cd0e9a:	48 8b 4d e0          	mov    rcx,QWORD PTR [rbp-0x20]
   186cd0e9e:	48 8d 51 18          	lea    rdx,[rcx+0x18]
   186cd0ea2:	48 89 55 c8          	mov    QWORD PTR [rbp-0x38],rdx
   186cd0ea6:	48 89 00             	mov    QWORD PTR [rax],rax
   186cd0ea9:	48 89 40 08          	mov    QWORD PTR [rax+0x8],rax
   186cd0ead:	48 89 40 10          	mov    QWORD PTR [rax+0x10],rax
   186cd0eb1:	66 c7 40 18 01 01    	mov    WORD PTR [rax+0x18],0x101
   186cd0eb7:	48 89 41 18          	mov    QWORD PTR [rcx+0x18],rax
   186cd0ebb:	0f 11 71 28          	movups XMMWORD PTR [rcx+0x28],xmm6
   186cd0ebf:	b9 38 00 00 00       	mov    ecx,0x38
   186cd0ec4:	e8 13 ae 87 00       	call   0x18754bcdc
   186cd0ec9:	90                   	nop
   186cd0eca:	48 8b 4d e0          	mov    rcx,QWORD PTR [rbp-0x20]
   186cd0ece:	48 8d 51 28          	lea    rdx,[rcx+0x28]
   186cd0ed2:	48 89 55 d0          	mov    QWORD PTR [rbp-0x30],rdx
   186cd0ed6:	48 89 00             	mov    QWORD PTR [rax],rax
   186cd0ed9:	48 89 40 08          	mov    QWORD PTR [rax+0x8],rax
   186cd0edd:	48 89 40 10          	mov    QWORD PTR [rax+0x10],rax
   186cd0ee1:	66 c7 40 18 01 01    	mov    WORD PTR [rax+0x18],0x101
   186cd0ee7:	48 89 41 28          	mov    QWORD PTR [rcx+0x28],rax
   186cd0eeb:	0f 57 c0             	xorps  xmm0,xmm0
   186cd0eee:	0f 11 41 38          	movups XMMWORD PTR [rcx+0x38],xmm0
   186cd0ef2:	b9 38 00 00 00       	mov    ecx,0x38
   186cd0ef7:	e8 e0 ad 87 00       	call   0x18754bcdc
   186cd0efc:	90                   	nop
   186cd0efd:	48 8b 4d e0          	mov    rcx,QWORD PTR [rbp-0x20]
   186cd0f01:	48 8d 51 38          	lea    rdx,[rcx+0x38]
   186cd0f05:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
   186cd0f09:	48 89 00             	mov    QWORD PTR [rax],rax
   186cd0f0c:	48 89 40 08          	mov    QWORD PTR [rax+0x8],rax
   186cd0f10:	48 89 40 10          	mov    QWORD PTR [rax+0x10],rax
   186cd0f14:	66 c7 40 18 01 01    	mov    WORD PTR [rax+0x18],0x101
   186cd0f1a:	48 89 41 38          	mov    QWORD PTR [rcx+0x38],rax
   186cd0f1e:	c6 41 48 00          	mov    BYTE PTR [rcx+0x48],0x0
   186cd0f22:	b9 18 00 00 00       	mov    ecx,0x18
   186cd0f27:	e8 b0 ad 87 00       	call   0x18754bcdc
   186cd0f2c:	90                   	nop
   186cd0f2d:	48 b9 01 00 00 00 01 	movabs rcx,0x100000001
   186cd0f34:	00 00 00 
   186cd0f37:	48 89 48 08          	mov    QWORD PTR [rax+0x8],rcx
   186cd0f3b:	48 8d 0d 06 71 24 02 	lea    rcx,[rip+0x2247106]        # 0x188f18048
   186cd0f42:	48 89 08             	mov    QWORD PTR [rax],rcx
   186cd0f45:	48 89 c1             	mov    rcx,rax
   186cd0f48:	48 83 c1 10          	add    rcx,0x10
   186cd0f4c:	c6 40 10 01          	mov    BYTE PTR [rax+0x10],0x1
   186cd0f50:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
   186cd0f54:	48 89 4a 50          	mov    QWORD PTR [rdx+0x50],rcx
   186cd0f58:	48 89 42 58          	mov    QWORD PTR [rdx+0x58],rax
   186cd0f5c:	48 89 d0             	mov    rax,rdx
   186cd0f5f:	0f 28 75 f0          	movaps xmm6,XMMWORD PTR [rbp-0x10]
   186cd0f63:	48 83 c4 60          	add    rsp,0x60
   186cd0f67:	5d                   	pop    rbp
   186cd0f68:	c3                   	ret
   186cd0f69:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
   186cd0f70:	48 89 54 24 10       	mov    QWORD PTR [rsp+0x10],rdx
   186cd0f75:	55                   	push   rbp
   186cd0f76:	48 83 ec 30          	sub    rsp,0x30
   186cd0f7a:	48 8d 6a 60          	lea    rbp,[rdx+0x60]
   186cd0f7e:	0f                   	.byte 0xf
   186cd0f7f:	29                   	.byte 0x29
