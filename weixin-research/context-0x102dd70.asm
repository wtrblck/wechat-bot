
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

000000018102dd70 <.text+0x102cd70>:
   18102dd70:	55                   	push   rbp
   18102dd71:	41 57                	push   r15
   18102dd73:	41 56                	push   r14
   18102dd75:	41 54                	push   r12
   18102dd77:	56                   	push   rsi
   18102dd78:	57                   	push   rdi
   18102dd79:	53                   	push   rbx
   18102dd7a:	48 81 ec f0 05 00 00 	sub    rsp,0x5f0
   18102dd81:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   18102dd88:	00 
   18102dd89:	0f 29 b5 60 05 00 00 	movaps XMMWORD PTR [rbp+0x560],xmm6
   18102dd90:	48 c7 85 58 05 00 00 	mov    QWORD PTR [rbp+0x558],0xfffffffffffffffe
   18102dd97:	fe ff ff ff 
   18102dd9b:	48 89 d6             	mov    rsi,rdx
   18102dd9e:	49 83 78 10 00       	cmp    QWORD PTR [r8+0x10],0x0
   18102dda3:	74 55                	je     0x18102ddfa
   18102dda5:	4c 89 c7             	mov    rdi,r8
   18102dda8:	49 89 ce             	mov    r14,rcx
   18102ddab:	4c 89 c1             	mov    rcx,r8
   18102ddae:	e8 9d 94 b9 ff       	call   0x180bc7250
   18102ddb3:	84 c0                	test   al,al
   18102ddb5:	74 4e                	je     0x18102de05
   18102ddb7:	48 8d 8d 30 04 00 00 	lea    rcx,[rbp+0x430]
   18102ddbe:	e8 5d 94 01 ff       	call   0x180047220
   18102ddc3:	48 8b 8d 30 04 00 00 	mov    rcx,QWORD PTR [rbp+0x430]
   18102ddca:	48 8d 95 98 04 00 00 	lea    rdx,[rbp+0x498]
   18102ddd1:	e8 fa 45 35 ff       	call   0x1803823d0
   18102ddd6:	90                   	nop
   18102ddd7:	48 8b 8d 98 04 00 00 	mov    rcx,QWORD PTR [rbp+0x498]
   18102ddde:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   18102dde2:	e8 99 0b 6f ff       	call   0x18071e980
   18102dde7:	90                   	nop
   18102dde8:	48 8b 4d c0          	mov    rcx,QWORD PTR [rbp-0x40]
   18102ddec:	48 89 f2             	mov    rdx,rsi
   18102ddef:	49 89 f8             	mov    r8,rdi
   18102ddf2:	e8 49 eb 8a 00       	call   0x1818dc940
   18102ddf7:	90                   	nop
   18102ddf8:	eb 5c                	jmp    0x18102de56
   18102ddfa:	0f 57 c0             	xorps  xmm0,xmm0
   18102ddfd:	0f 11 06             	movups XMMWORD PTR [rsi],xmm0
   18102de00:	e9 6e 0a 00 00       	jmp    0x18102e873
   18102de05:	48 89 f9             	mov    rcx,rdi
   18102de08:	e8 f3 81 b9 ff       	call   0x180bc6000
   18102de0d:	84 c0                	test   al,al
   18102de0f:	0f 84 a5 00 00 00    	je     0x18102deba
   18102de15:	48 8d 8d 30 04 00 00 	lea    rcx,[rbp+0x430]
   18102de1c:	e8 ff 93 01 ff       	call   0x180047220
   18102de21:	48 8b 8d 30 04 00 00 	mov    rcx,QWORD PTR [rbp+0x430]
   18102de28:	48 8d 95 98 04 00 00 	lea    rdx,[rbp+0x498]
   18102de2f:	e8 9c 45 35 ff       	call   0x1803823d0
   18102de34:	90                   	nop
   18102de35:	48 8b 8d 98 04 00 00 	mov    rcx,QWORD PTR [rbp+0x498]
   18102de3c:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   18102de40:	e8 8b be 74 ff       	call   0x180779cd0
   18102de45:	90                   	nop
   18102de46:	48 8b 4d c0          	mov    rcx,QWORD PTR [rbp-0x40]
   18102de4a:	48 89 f2             	mov    rdx,rsi
   18102de4d:	49 89 f8             	mov    r8,rdi
   18102de50:	e8 3b 4c a3 00       	call   0x181a62a90
   18102de55:	90                   	nop
   18102de56:	48 8b 7d c8          	mov    rdi,QWORD PTR [rbp-0x38]
   18102de5a:	48 85 ff             	test   rdi,rdi
   18102de5d:	74 1d                	je     0x18102de7c
   18102de5f:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   18102de63:	75 17                	jne    0x18102de7c
   18102de65:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   18102de68:	48 89 f9             	mov    rcx,rdi
   18102de6b:	ff 10                	call   QWORD PTR [rax]
   18102de6d:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   18102de71:	75 09                	jne    0x18102de7c
   18102de73:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   18102de76:	48 89 f9             	mov    rcx,rdi
   18102de79:	ff 50 08             	call   QWORD PTR [rax+0x8]
   18102de7c:	48 8b bd a0 04 00 00 	mov    rdi,QWORD PTR [rbp+0x4a0]
   18102de83:	48 85 ff             	test   rdi,rdi
   18102de86:	74 1d                	je     0x18102dea5
   18102de88:	f0 ff 4f 08          	lock dec DWORD PTR [rdi+0x8]
   18102de8c:	75 17                	jne    0x18102dea5
   18102de8e:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   18102de91:	48 89 f9             	mov    rcx,rdi
   18102de94:	ff 10                	call   QWORD PTR [rax]
   18102de96:	f0 ff 4f 0c          	lock dec DWORD PTR [rdi+0xc]
   18102de9a:	75 09                	jne    0x18102dea5
   18102de9c:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   18102de9f:	48 89 f9             	mov    rcx,rdi
   18102dea2:	ff 50 08             	call   QWORD PTR [rax+0x8]
   18102dea5:	48 8b bd 38 04 00 00 	mov    rdi,QWORD PTR [rbp+0x438]
   18102deac:	48 85 ff             	test   rdi,rdi
   18102deaf:	0f 85 a1 09 00 00    	jne    0x18102e856
   18102deb5:	e9 b9 09 00 00       	jmp    0x18102e873
   18102deba:	0f 28 35 ef 8c ee 07 	movaps xmm6,XMMWORD PTR [rip+0x7ee8cef]        # 0x188f16bb0
   18102dec1:	0f 29 b5 20 05 00 00 	movaps XMMWORD PTR [rbp+0x520],xmm6
   18102dec8:	e8 43 7e 01 ff       	call   0x180045d10
   18102decd:	4c 8b 00             	mov    r8,QWORD PTR [rax]
   18102ded0:	48 8d 95 38 05 00 00 	lea    rdx,[rbp+0x538]
   18102ded7:	48 89 c1             	mov    rcx,rax
   18102deda:	41 ff 50 60          	call   QWORD PTR [r8+0x60]
   18102dede:	48 8b 8d 38 05 00 00 	mov    rcx,QWORD PTR [rbp+0x538]
   18102dee5:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   18102dee8:	48 8d 9d 30 04 00 00 	lea    rbx,[rbp+0x430]
   18102deef:	48 89 da             	mov    rdx,rbx
   18102def2:	ff 50 38             	call   QWORD PTR [rax+0x38]
   18102def5:	90                   	nop
   18102def6:	48 8b 8d 30 04 00 00 	mov    rcx,QWORD PTR [rbp+0x430]
   18102defd:	4c 8d 25 a4 5a fa 07 	lea    r12,[rip+0x7fa5aa4]        # 0x188fd39a8
   18102df04:	4c 89 a5 80 04 00 00 	mov    QWORD PTR [rbp+0x480],r12
   18102df0b:	0f 29 75 c0          	movaps XMMWORD PTR [rbp-0x40],xmm6
   18102df0f:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   18102df13:	4c 8d 85 80 04 00 00 	lea    r8,[rbp+0x480]
   18102df1a:	e8 c1 9c 39 ff       	call   0x1803c7be0
   18102df1f:	90                   	nop
   18102df20:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
   18102df24:	48 8b 4d c8          	mov    rcx,QWORD PTR [rbp-0x38]
   18102df28:	48 85 c9             	test   rcx,rcx
   18102df2b:	74 3c                	je     0x18102df69
   18102df2d:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   18102df31:	4c 8b 7d c8          	mov    r15,QWORD PTR [rbp-0x38]
   18102df35:	48 89 85 98 04 00 00 	mov    QWORD PTR [rbp+0x498],rax
   18102df3c:	4c 89 bd a0 04 00 00 	mov    QWORD PTR [rbp+0x4a0],r15
   18102df43:	4d 85 ff             	test   r15,r15
   18102df46:	74 33                	je     0x18102df7b
   18102df48:	f0 41 ff 4f 08       	lock dec DWORD PTR [r15+0x8]
   18102df4d:	75 2c                	jne    0x18102df7b
   18102df4f:	49 8b 07             	mov    rax,QWORD PTR [r15]
   18102df52:	4c 89 f9             	mov    rcx,r15
   18102df55:	ff 10                	call   QWORD PTR [rax]
   18102df57:	f0 41 ff 4f 0c       	lock dec DWORD PTR [r15+0xc]
   18102df5c:	75 1d                	jne    0x18102df7b
   18102df5e:	49 8b 07             	mov    rax,QWORD PTR [r15]
   18102df61:	4c 89 f9             	mov    rcx,r15
   18102df64:	ff 50 08             	call   QWORD PTR [rax+0x8]
   18102df67:	eb 12                	jmp    0x18102df7b
   18102df69:	48 89 85 98 04 00 00 	mov    QWORD PTR [rbp+0x498],rax
   18102df70:	48 c7 85 a0 04 00 00 	mov    QWORD PTR [rbp+0x4a0],0x0
   18102df77:	00 00 00 00 
   18102df7b:	48 8b 8d 98 04 00 00 	mov    rcx,QWORD PTR [rbp+0x498]
   18102df82:	48 8d 95 20 05 00 00 	lea    rdx,[rbp+0x520]
   18102df89:	49 89 f8             	mov    r8,rdi
   18102df8c:	e8 2f f1 f1 ff       	call   0x180f4d0c0
   18102df91:	90                   	nop
   18102df92:	4c 8b bd a0 04 00 00 	mov    r15,QWORD PTR [rbp+0x4a0]
   18102df99:	4d 85 ff             	test   r15,r15
   18102df9c:	74 1f                	je     0x18102dfbd
   18102df9e:	f0 41 ff 4f 08       	lock dec DWORD PTR [r15+0x8]
   18102dfa3:	75 18                	jne    0x18102dfbd
   18102dfa5:	49 8b 07             	mov    rax,QWORD PTR [r15]
   18102dfa8:	4c 89 f9             	mov    rcx,r15
   18102dfab:	ff 10                	call   QWORD PTR [rax]
   18102dfad:	f0 41 ff 4f 0c       	lock dec DWORD PTR [r15+0xc]
   18102dfb2:	75 09                	jne    0x18102dfbd
   18102dfb4:	49 8b 07             	mov    rax,QWORD PTR [r15]
   18102dfb7:	4c 89 f9             	mov    rcx,r15
   18102dfba:	ff 50 08             	call   QWORD PTR [rax+0x8]
   18102dfbd:	4c 8b bd 38 04 00 00 	mov    r15,QWORD PTR [rbp+0x438]
   18102dfc4:	4d 85 ff             	test   r15,r15
   18102dfc7:	74 1f                	je     0x18102dfe8
   18102dfc9:	f0 41 ff 4f 08       	lock dec DWORD PTR [r15+0x8]
   18102dfce:	75 18                	jne    0x18102dfe8
   18102dfd0:	49 8b 07             	mov    rax,QWORD PTR [r15]
   18102dfd3:	4c 89 f9             	mov    rcx,r15
   18102dfd6:	ff 10                	call   QWORD PTR [rax]
   18102dfd8:	f0 41 ff 4f 0c       	lock dec DWORD PTR [r15+0xc]
   18102dfdd:	75 09                	jne    0x18102dfe8
   18102dfdf:	49 8b 07             	mov    rax,QWORD PTR [r15]
   18102dfe2:	4c 89 f9             	mov    rcx,r15
   18102dfe5:	ff 50 08             	call   QWORD PTR [rax+0x8]
   18102dfe8:	4c 8b bd 40 05 00 00 	mov    r15,QWORD PTR [rbp+0x540]
   18102dfef:	4d 85 ff             	test   r15,r15
   18102dff2:	74 1f                	je     0x18102e013
   18102dff4:	f0 41 ff 4f 08       	lock dec DWORD PTR [r15+0x8]
   18102dff9:	75 18                	jne    0x18102e013
   18102dffb:	49 8b 07             	mov    rax,QWORD PTR [r15]
   18102dffe:	4c 89 f9             	mov    rcx,r15
   18102e001:	ff 10                	call   QWORD PTR [rax]
   18102e003:	f0 41 ff 4f 0c       	lock dec DWORD PTR [r15+0xc]
   18102e008:	75 09                	jne    0x18102e013
   18102e00a:	49 8b 07             	mov    rax,QWORD PTR [r15]
   18102e00d:	4c 89 f9             	mov    rcx,r15
   18102e010:	ff 50 08             	call   QWORD PTR [rax+0x8]
   18102e013:	48 8b 8d 20 05 00 00 	mov    rcx,QWORD PTR [rbp+0x520]
   18102e01a:	48 85 c9             	test   rcx,rcx
   18102e01d:	0f 84 91 00 00 00    	je     0x18102e0b4
   18102e023:	48 83 c1 08          	add    rcx,0x8
   18102e027:	e8 34 94 b9 ff       	call   0x180bc7460
   18102e02c:	90                   	nop
   18102e02d:	84 c0                	test   al,al
   18102e02f:	0f 84 71 01 00 00    	je     0x18102e1a6
   18102e035:	48 8d 7d c0          	lea    rdi,[rbp-0x40]
   18102e039:	41 b8 60 04 00 00    	mov    r8d,0x460
   18102e03f:	48 89 f9             	mov    rcx,rdi
   18102e042:	b2 aa                	mov    dl,0xaa
   18102e044:	e8 97 74 6e 06       	call   0x1877154e0
   18102e049:	48 8b 95 20 05 00 00 	mov    rdx,QWORD PTR [rbp+0x520]
   18102e050:	48 89 f9             	mov    rcx,rdi
   18102e053:	e8 c8 f5 6d ff       	call   0x18070d620
   18102e058:	90                   	nop
   18102e059:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   18102e05d:	e8 9e 33 00 00       	call   0x181031400
   18102e062:	90                   	nop
   18102e063:	b9 70 04 00 00       	mov    ecx,0x470
   18102e068:	e8 6f dc 51 06       	call   0x18754bcdc
   18102e06d:	90                   	nop
   18102e06e:	48 89 c7             	mov    rdi,rax
   18102e071:	48 b8 01 00 00 00 01 	movabs rax,0x100000001
   18102e078:	00 00 00 
   18102e07b:	48 89 47 08          	mov    QWORD PTR [rdi+0x8],rax
   18102e07f:	48 8d 05 22 0c 16 08 	lea    rax,[rip+0x8160c22]        # 0x18918eca8
   18102e086:	48 89 07             	mov    QWORD PTR [rdi],rax
   18102e089:	48 89 bd 28 04 00 00 	mov    QWORD PTR [rbp+0x428],rdi
   18102e090:	48 83 c7 10          	add    rdi,0x10
   18102e094:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   18102e098:	48 89 f9             	mov    rcx,rdi
   18102e09b:	e8 80 f5 6d ff       	call   0x18070d620
   18102e0a0:	90                   	nop
   18102e0a1:	48 89 3e             	mov    QWORD PTR [rsi],rdi
   18102e0a4:	48 8b 85 28 04 00 00 	mov    rax,QWORD PTR [rbp+0x428]
   18102e0ab:	48 89 46 08          	mov    QWORD PTR [rsi+0x8],rax
   18102e0af:	e9 f3 02 00 00       	jmp    0x18102e3a7
   18102e0b4:	0f 29 b5 80 04 00 00 	movaps XMMWORD PTR [rbp+0x480],xmm6
   18102e0bb:	49 8b 8e a8 01 00 00 	mov    rcx,QWORD PTR [r14+0x1a8]
   18102e0c2:	48 8d 95 80 04 00 00 	lea    rdx,[rbp+0x480]
   18102e0c9:	49 89 f8             	mov    r8,rdi
   18102e0cc:	e8 2f aa fe 01       	call   0x183018b00
   18102e0d1:	90                   	nop
   18102e0d2:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   18102e0d6:	48 8d 95 80 04 00 00 	lea    rdx,[rbp+0x480]
   18102e0dd:	e8 6e 7c ff ff       	call   0x181025d50
   18102e0e2:	90                   	nop
   18102e0e3:	49 89 c6             	mov    r14,rax
   18102e0e6:	80 b8 60 04 00 00 01 	cmp    BYTE PTR [rax+0x460],0x1
   18102e0ed:	0f 85 0c 01 00 00    	jne    0x18102e1ff
   18102e0f3:	4c 89 f2             	mov    rdx,r14
   18102e0f6:	e8 05 33 00 00       	call   0x181031400
   18102e0fb:	90                   	nop
   18102e0fc:	e8 0f 7c 01 ff       	call   0x180045d10
   18102e101:	90                   	nop
   18102e102:	4c 8b 00             	mov    r8,QWORD PTR [rax]
   18102e105:	48 8d 95 38 05 00 00 	lea    rdx,[rbp+0x538]
   18102e10c:	48 89 c1             	mov    rcx,rax
   18102e10f:	41 ff 50 60          	call   QWORD PTR [r8+0x60]
   18102e113:	90                   	nop
   18102e114:	48 8b 8d 38 05 00 00 	mov    rcx,QWORD PTR [rbp+0x538]
   18102e11b:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   18102e11e:	48 8d 95 30 04 00 00 	lea    rdx,[rbp+0x430]
   18102e125:	ff 50 38             	call   QWORD PTR [rax+0x38]
   18102e128:	90                   	nop
   18102e129:	48 8b 8d 30 04 00 00 	mov    rcx,QWORD PTR [rbp+0x430]
   18102e130:	4c 89 a5 18 05 00 00 	mov    QWORD PTR [rbp+0x518],r12
   18102e137:	0f 29 75 c0          	movaps XMMWORD PTR [rbp-0x40],xmm6
   18102e13b:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   18102e13f:	4c 8d 85 18 05 00 00 	lea    r8,[rbp+0x518]
   18102e146:	e8 95 9a 39 ff       	call   0x1803c7be0
   18102e14b:	90                   	nop
   18102e14c:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
   18102e150:	48 8b 4d c8          	mov    rcx,QWORD PTR [rbp-0x38]
   18102e154:	48 85 c9             	test   rcx,rcx
   18102e157:	0f 84 d1 03 00 00    	je     0x18102e52e
   18102e15d:	f0 ff 41 08          	lock inc DWORD PTR [rcx+0x8]
   18102e161:	48 8b 5d c8          	mov    rbx,QWORD PTR [rbp-0x38]
   18102e165:	48 89 85 98 04 00 00 	mov    QWORD PTR [rbp+0x498],rax
   18102e16c:	48 89 9d a0 04 00 00 	mov    QWORD PTR [rbp+0x4a0],rbx
   18102e173:	48 85 db             	test   rbx,rbx
   18102e176:	0f 84 c4 03 00 00    	je     0x18102e540
   18102e17c:	f0 ff 4b 08          	lock dec DWORD PTR [rbx+0x8]
   18102e180:	0f 85 ba 03 00 00    	jne    0x18102e540
   18102e186:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   18102e189:	48 89 d9             	mov    rcx,rbx
   18102e18c:	ff 10                	call   QWORD PTR [rax]
   18102e18e:	f0 ff 4b 0c          	lock dec DWORD PTR [rbx+0xc]
   18102e192:	0f 85 a8 03 00 00    	jne    0x18102e540
   18102e198:	48 8b 03             	mov    rax,QWORD PTR [rbx]
   18102e19b:	48 89 d9             	mov    rcx,rbx
   18102e19e:	ff 50 08             	call   QWORD PTR [rax+0x8]
   18102e1a1:	e9 9a 03 00 00       	jmp    0x18102e540
   18102e1a6:	48 8b 8d 20 05 00 00 	mov    rcx,QWORD PTR [rbp+0x520]
   18102e1ad:	48 83 c1 08          	add    rcx,0x8
   18102e1b1:	e8 5a 96 b9 ff       	call   0x180bc7810
   18102e1b6:	90                   	nop
   18102e1b7:	84 c0                	test   al,al
   18102e1b9:	0f 84 94 01 00 00    	je     0x18102e353
   18102e1bf:	48 8d 7d c0          	lea    rdi,[rbp-0x40]
   18102e1c3:	41 b8 60 04 00 00    	mov    r8d,0x460
   18102e1c9:	48 89 f9             	mov    rcx,rdi
   18102e1cc:	b2 aa                	mov    dl,0xaa
   18102e1ce:	e8 0d 73 6e 06       	call   0x1877154e0
   18102e1d3:	48 8b 95 20 05 00 00 	mov    rdx,QWORD PTR [rbp+0x520]
   18102e1da:	48 89 f9             	mov    rcx,rdi
   18102e1dd:	e8 3e f4 6d ff       	call   0x18070d620
   18102e1e2:	90                   	nop
   18102e1e3:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   18102e1e7:	e8 f4 34 00 00       	call   0x1810316e0
   18102e1ec:	90                   	nop
   18102e1ed:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
   18102e1f1:	48 89 f1             	mov    rcx,rsi
   18102e1f4:	e8 47 34 00 00       	call   0x181031640
   18102e1f9:	90                   	nop
   18102e1fa:	e9 a8 01 00 00       	jmp    0x18102e3a7
   18102e1ff:	48 89 f9             	mov    rcx,rdi
   18102e202:	e8 09 a1 b9 ff       	call   0x180bc8310
   18102e207:	90                   	nop
   18102e208:	84 c0                	test   al,al
   18102e20a:	0f 84 a5 01 00 00    	je     0x18102e3b5
   18102e210:	b9 02 00 00 00       	mov    ecx,0x2
   18102e215:	e8 c6 eb 03 ff       	call   0x18006cde0
   18102e21a:	85 c0                	test   eax,eax
   18102e21c:	0f 84 ea 00 00 00    	je     0x18102e30c
   18102e222:	4c 8d b5 38 05 00 00 	lea    r14,[rbp+0x538]
   18102e229:	4c 89 f1             	mov    rcx,r14
   18102e22c:	e8 df ec 03 ff       	call   0x18006cf10
   18102e231:	90                   	nop
   18102e232:	48 83 bd 50 05 00 00 	cmp    QWORD PTR [rbp+0x550],0x10
   18102e239:	10 
   18102e23a:	72 07                	jb     0x18102e243
   18102e23c:	4c 8b b5 38 05 00 00 	mov    r14,QWORD PTR [rbp+0x538]
   18102e243:	48 8d 05 fe 3b 16 08 	lea    rax,[rip+0x8163bfe]        # 0x189191e48
   18102e24a:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   18102e24f:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   18102e256:	00 00 
   18102e258:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   18102e25d:	c7 44 24 28 78 02 00 	mov    DWORD PTR [rsp+0x28],0x278
   18102e264:	00 
   18102e265:	4c 8d 0d 94 32 16 08 	lea    r9,[rip+0x8163294]        # 0x189191500
   18102e26c:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   18102e270:	ba 02 00 00 00       	mov    edx,0x2
   18102e275:	4d 89 f0             	mov    r8,r14
   18102e278:	e8 f3 ef 03 ff       	call   0x18006d270
   18102e27d:	90                   	nop
   18102e27e:	48 83 7f 18 10       	cmp    QWORD PTR [rdi+0x18],0x10
   18102e283:	48 89 f8             	mov    rax,rdi
   18102e286:	72 03                	jb     0x18102e28b
   18102e288:	48 8b 07             	mov    rax,QWORD PTR [rdi]
   18102e28b:	48 89 85 30 04 00 00 	mov    QWORD PTR [rbp+0x430],rax
   18102e292:	c6 85 38 04 00 00 00 	mov    BYTE PTR [rbp+0x438],0x0
   18102e299:	0f 57 c0             	xorps  xmm0,xmm0
   18102e29c:	0f 11 85 00 05 00 00 	movups XMMWORD PTR [rbp+0x500],xmm0
   18102e2a3:	0f 11 85 f0 04 00 00 	movups XMMWORD PTR [rbp+0x4f0],xmm0
   18102e2aa:	0f 11 85 e0 04 00 00 	movups XMMWORD PTR [rbp+0x4e0],xmm0
   18102e2b1:	0f 11 85 d0 04 00 00 	movups XMMWORD PTR [rbp+0x4d0],xmm0
   18102e2b8:	0f 11 85 c0 04 00 00 	movups XMMWORD PTR [rbp+0x4c0],xmm0
   18102e2bf:	0f 11 85 b0 04 00 00 	movups XMMWORD PTR [rbp+0x4b0],xmm0
   18102e2c6:	0f 11 85 a0 04 00 00 	movups XMMWORD PTR [rbp+0x4a0],xmm0
   18102e2cd:	48 c7 85 10 05 00 00 	mov    QWORD PTR [rbp+0x510],0x0
   18102e2d4:	00 00 00 00 
   18102e2d8:	48 89 9d 98 04 00 00 	mov    QWORD PTR [rbp+0x498],rbx
   18102e2df:	48 8d 15 c2 3b 16 08 	lea    rdx,[rip+0x8163bc2]        # 0x189191ea8
   18102e2e6:	48                   	rex.W
   18102e2e7:	8d                   	.byte 0x8d
