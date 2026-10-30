
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

00000001839dcf60 <.text+0x39dbf60>:
   1839dcf60:	55                   	push   rbp
   1839dcf61:	56                   	push   rsi
   1839dcf62:	57                   	push   rdi
   1839dcf63:	53                   	push   rbx
   1839dcf64:	48 81 ec 28 01 00 00 	sub    rsp,0x128
   1839dcf6b:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   1839dcf72:	00
   1839dcf73:	48 c7 85 a0 00 00 00 	mov    QWORD PTR [rbp+0xa0],0xfffffffffffffffe
   1839dcf7a:	fe ff ff ff
   1839dcf7e:	48 89 d3             	mov    rbx,rdx
   1839dcf81:	48 89 ce             	mov    rsi,rcx
   1839dcf84:	48 b8 aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaaa
   1839dcf8b:	aa aa aa
   1839dcf8e:	48 89 85 90 00 00 00 	mov    QWORD PTR [rbp+0x90],rax
   1839dcf95:	0f 28 05 14 9c 53 05 	movaps xmm0,XMMWORD PTR [rip+0x5539c14]        # 0x188f16bb0
   1839dcf9c:	0f 29 85 80 00 00 00 	movaps XMMWORD PTR [rbp+0x80],xmm0
   1839dcfa3:	0f 29 45 70          	movaps XMMWORD PTR [rbp+0x70],xmm0
   1839dcfa7:	0f 29 45 60          	movaps XMMWORD PTR [rbp+0x60],xmm0
   1839dcfab:	0f 29 45 50          	movaps XMMWORD PTR [rbp+0x50],xmm0
   1839dcfaf:	0f 29 45 40          	movaps XMMWORD PTR [rbp+0x40],xmm0
   1839dcfb3:	0f 29 45 30          	movaps XMMWORD PTR [rbp+0x30],xmm0
   1839dcfb7:	0f 29 45 20          	movaps XMMWORD PTR [rbp+0x20],xmm0
   1839dcfbb:	0f 29 45 10          	movaps XMMWORD PTR [rbp+0x10],xmm0
   1839dcfbf:	0f 29 45 00          	movaps XMMWORD PTR [rbp+0x0],xmm0
   1839dcfc3:	0f 29 45 f0          	movaps XMMWORD PTR [rbp-0x10],xmm0
   1839dcfc7:	0f 29 45 e0          	movaps XMMWORD PTR [rbp-0x20],xmm0
   1839dcfcb:	0f 29 45 d0          	movaps XMMWORD PTR [rbp-0x30],xmm0
   1839dcfcf:	0f 29 45 c0          	movaps XMMWORD PTR [rbp-0x40],xmm0
   1839dcfd3:	0f 29 45 b0          	movaps XMMWORD PTR [rbp-0x50],xmm0
   1839dcfd7:	0f 29 45 a0          	movaps XMMWORD PTR [rbp-0x60],xmm0
   1839dcfdb:	48 8d 7d b0          	lea    rdi,[rbp-0x50]
   1839dcfdf:	48 8d 4d a0          	lea    rcx,[rbp-0x60]
   1839dcfe3:	ba 01 00 00 00       	mov    edx,0x1
   1839dcfe8:	e8 03 43 6a fc       	call   0x1800812f0
   1839dcfed:	90                   	nop
   1839dcfee:	48 8d 15 1b 5c d1 05 	lea    rdx,[rip+0x5d15c1b]        # 0x1896f2c10
   1839dcff5:	48 89 f9             	mov    rcx,rdi
   1839dcff8:	e8 63 45 6a fc       	call   0x180081560
   1839dcffd:	90                   	nop
   1839dcffe:	4c 8b 46 48          	mov    r8,QWORD PTR [rsi+0x48]
   1839dd002:	48 83 7e 50 10       	cmp    QWORD PTR [rsi+0x50],0x10
   1839dd007:	72 06                	jb     0x1839dd00f
   1839dd009:	48 8b 56 38          	mov    rdx,QWORD PTR [rsi+0x38]
   1839dd00d:	eb 04                	jmp    0x1839dd013
   1839dd00f:	48 8d 56 38          	lea    rdx,[rsi+0x38]
   1839dd013:	48 89 c1             	mov    rcx,rax
   1839dd016:	e8 a5 6a 6a fc       	call   0x180083ac0
   1839dd01b:	90                   	nop
   1839dd01c:	48 8d 15 d1 d2 5e 05 	lea    rdx,[rip+0x55ed2d1]        # 0x188fca2f4
   1839dd023:	48 89 c1             	mov    rcx,rax
   1839dd026:	e8 35 45 6a fc       	call   0x180081560
   1839dd02b:	90                   	nop
   1839dd02c:	48 8b 4e 18          	mov    rcx,QWORD PTR [rsi+0x18]
   1839dd030:	8b 91 64 01 00 00    	mov    edx,DWORD PTR [rcx+0x164]
   1839dd036:	48 89 c1             	mov    rcx,rax
   1839dd039:	e8 b2 f1 71 fc       	call   0x1800fc1f0
   1839dd03e:	90                   	nop
   1839dd03f:	48 8d 15 ae d2 5e 05 	lea    rdx,[rip+0x55ed2ae]        # 0x188fca2f4
   1839dd046:	48 89 c1             	mov    rcx,rax
   1839dd049:	e8 12 45 6a fc       	call   0x180081560
   1839dd04e:	90                   	nop
   1839dd04f:	48 8b 4e 18          	mov    rcx,QWORD PTR [rsi+0x18]
   1839dd053:	8b 91 44 01 00 00    	mov    edx,DWORD PTR [rcx+0x144]
   1839dd059:	48 89 c1             	mov    rcx,rax
   1839dd05c:	e8 8f f1 71 fc       	call   0x1800fc1f0
   1839dd061:	90                   	nop
   1839dd062:	48 83 7e 08 00       	cmp    QWORD PTR [rsi+0x8],0x0
   1839dd067:	74 29                	je     0x1839dd092
   1839dd069:	48 8d 15 84 d2 5e 05 	lea    rdx,[rip+0x55ed284]        # 0x188fca2f4
   1839dd070:	48 89 f9             	mov    rcx,rdi
   1839dd073:	e8 e8 44 6a fc       	call   0x180081560
   1839dd078:	90                   	nop
   1839dd079:	48 89 c7             	mov    rdi,rax
   1839dd07c:	48 8b 4e 08          	mov    rcx,QWORD PTR [rsi+0x8]
   1839dd080:	48 8b 01             	mov    rax,QWORD PTR [rcx]
   1839dd083:	ff 50 18             	call   QWORD PTR [rax+0x18]
   1839dd086:	90                   	nop
   1839dd087:	48 89 f9             	mov    rcx,rdi
   1839dd08a:	89 c2                	mov    edx,eax
   1839dd08c:	e8 9f fa 71 fc       	call   0x1800fcb30
   1839dd091:	90                   	nop
   1839dd092:	0f 57 c0             	xorps  xmm0,xmm0
   1839dd095:	0f 11 03             	movups XMMWORD PTR [rbx],xmm0
   1839dd098:	48 c7 43 10 00 00 00 	mov    QWORD PTR [rbx+0x10],0x0
   1839dd09f:	00
   1839dd0a0:	48 89 9d 98 00 00 00 	mov    QWORD PTR [rbp+0x98],rbx
   1839dd0a7:	48 c7 43 18 0f 00 00 	mov    QWORD PTR [rbx+0x18],0xf
   1839dd0ae:	00
   1839dd0af:	8b 45 28             	mov    eax,DWORD PTR [rbp+0x28]
   1839dd0b2:	89 c1                	mov    ecx,eax
   1839dd0b4:	83 e1 22             	and    ecx,0x22
   1839dd0b7:	83 f9 02             	cmp    ecx,0x2
   1839dd0ba:	74 28                	je     0x1839dd0e4
   1839dd0bc:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
   1839dd0c0:	48 8b 31             	mov    rsi,QWORD PTR [rcx]
   1839dd0c3:	48 85 f6             	test   rsi,rsi
   1839dd0c6:	74 1c                	je     0x1839dd0e4
   1839dd0c8:	48 8d 45 d8          	lea    rax,[rbp-0x28]
   1839dd0cc:	48 8b 4d 20          	mov    rcx,QWORD PTR [rbp+0x20]
   1839dd0d0:	48 39 ce             	cmp    rsi,rcx
   1839dd0d3:	48 0f 42 f1          	cmovb  rsi,rcx
   1839dd0d7:	48 8b 00             	mov    rax,QWORD PTR [rax]
   1839dd0da:	4c 8b 08             	mov    r9,QWORD PTR [rax]
   1839dd0dd:	4d 85 c9             	test   r9,r9
   1839dd0e0:	75 2b                	jne    0x1839dd10d
   1839dd0e2:	eb 61                	jmp    0x1839dd145
   1839dd0e4:	a8 04                	test   al,0x4
   1839dd0e6:	75 5d                	jne    0x1839dd145
   1839dd0e8:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
   1839dd0ec:	48 8b 30             	mov    rsi,QWORD PTR [rax]
   1839dd0ef:	48 85 f6             	test   rsi,rsi
   1839dd0f2:	74 51                	je     0x1839dd145
   1839dd0f4:	48 8d 45 d0          	lea    rax,[rbp-0x30]
   1839dd0f8:	48 8b 4d 08          	mov    rcx,QWORD PTR [rbp+0x8]
   1839dd0fc:	48 63 09             	movsxd rcx,DWORD PTR [rcx]
   1839dd0ff:	48 01 ce             	add    rsi,rcx
   1839dd102:	48 8b 00             	mov    rax,QWORD PTR [rax]
   1839dd105:	4c 8b 08             	mov    r9,QWORD PTR [rax]
   1839dd108:	4d 85 c9             	test   r9,r9
   1839dd10b:	74 38                	je     0x1839dd145
   1839dd10d:	4c 29 ce             	sub    rsi,r9
   1839dd110:	48 83 fe 0f          	cmp    rsi,0xf
   1839dd114:	76 12                	jbe    0x1839dd128
   1839dd116:	48 8b 8d 98 00 00 00 	mov    rcx,QWORD PTR [rbp+0x98]
   1839dd11d:	48 89 f2             	mov    rdx,rsi
   1839dd120:	e8 2b 10 66 fc       	call   0x18003e150
   1839dd125:	90                   	nop
   1839dd126:	eb 1d                	jmp    0x1839dd145
   1839dd128:	48 8b bd 98 00 00 00 	mov    rdi,QWORD PTR [rbp+0x98]
   1839dd12f:	48 89 77 10          	mov    QWORD PTR [rdi+0x10],rsi
   1839dd133:	48 89 f9             	mov    rcx,rdi
   1839dd136:	4c 89 ca             	mov    rdx,r9
   1839dd139:	49 89 f0             	mov    r8,rsi
   1839dd13c:	e8 ff 7c d3 03       	call   0x187714e40
   1839dd141:	c6 04 37 00          	mov    BYTE PTR [rdi+rsi*1],0x0
   1839dd145:	48 8d 75 38          	lea    rsi,[rbp+0x38]
   1839dd149:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
   1839dd14d:	48 63 40 04          	movsxd rax,DWORD PTR [rax+0x4]
   1839dd151:	48 8d 0d f0 cc 57 05 	lea    rcx,[rip+0x557ccf0]        # 0x188f59e48
   1839dd158:	48 89 4c 05 a0       	mov    QWORD PTR [rbp+rax*1-0x60],rcx
   1839dd15d:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
   1839dd161:	48 63 40 04          	movsxd rax,DWORD PTR [rax+0x4]
   1839dd165:	8d 88 68 ff ff ff    	lea    ecx,[rax-0x98]
   1839dd16b:	89 4c 05 9c          	mov    DWORD PTR [rbp+rax*1-0x64],ecx
   1839dd16f:	48 8d 4d b8          	lea    rcx,[rbp-0x48]
   1839dd173:	e8 88 67 6a fc       	call   0x180083900
   1839dd178:	48 8d 05 e1 cf 57 05 	lea    rax,[rip+0x557cfe1]        # 0x188f5a160
   1839dd17f:	48 89 45 38          	mov    QWORD PTR [rbp+0x38],rax
   1839dd183:	48 89 f1             	mov    rcx,rsi
   1839dd186:	e8 89 34 b7 03       	call   0x187550614
   1839dd18b:	90                   	nop
   1839dd18c:	48 8b 85 98 00 00 00 	mov    rax,QWORD PTR [rbp+0x98]
   1839dd193:	48 81 c4 28 01 00 00 	add    rsp,0x128
   1839dd19a:	5b                   	pop    rbx
   1839dd19b:	5f                   	pop    rdi
   1839dd19c:	5e                   	pop    rsi
   1839dd19d:	5d                   	pop    rbp
   1839dd19e:	c3                   	ret
