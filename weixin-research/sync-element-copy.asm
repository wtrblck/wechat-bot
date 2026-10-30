
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

0000000180a824e0 <.text+0xa814e0>:
   180a824e0:	55                   	push   rbp
   180a824e1:	56                   	push   rsi
   180a824e2:	57                   	push   rdi
   180a824e3:	48 81 ec d0 01 00 00 	sub    rsp,0x1d0
   180a824ea:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
   180a824f1:	00
   180a824f2:	48 c7 85 48 01 00 00 	mov    QWORD PTR [rbp+0x148],0xfffffffffffffffe
   180a824f9:	fe ff ff ff
   180a824fd:	48 89 d6             	mov    rsi,rdx
   180a82500:	48 89 cf             	mov    rdi,rcx
   180a82503:	e8 88 1c 61 00       	call   0x181094190
   180a82508:	48 c7 47 70 00 00 00 	mov    QWORD PTR [rdi+0x70],0x0
   180a8250f:	00
   180a82510:	8b 47 48             	mov    eax,DWORD PTR [rdi+0x48]
   180a82513:	85 c0                	test   eax,eax
   180a82515:	0f 85 ff 01 00 00    	jne    0x180a8271a
   180a8251b:	48 89 bd 40 01 00 00 	mov    QWORD PTR [rbp+0x140],rdi
   180a82522:	b9 03 00 00 00       	mov    ecx,0x3
   180a82527:	e8 b4 a8 5e ff       	call   0x18006cde0
   180a8252c:	85 c0                	test   eax,eax
   180a8252e:	0f 84 d0 01 00 00    	je     0x180a82704
   180a82534:	48 8d bd 20 01 00 00 	lea    rdi,[rbp+0x120]
   180a8253b:	48 89 f9             	mov    rcx,rdi
   180a8253e:	e8 cd a9 5e ff       	call   0x18006cf10
   180a82543:	90                   	nop
   180a82544:	48 83 bd 38 01 00 00 	cmp    QWORD PTR [rbp+0x138],0x10
   180a8254b:	10
   180a8254c:	72 07                	jb     0x180a82555
   180a8254e:	48 8b bd 20 01 00 00 	mov    rdi,QWORD PTR [rbp+0x120]
   180a82555:	48 8d 05 24 0b 62 08 	lea    rax,[rip+0x8620b24]        # 0x1890a3080
   180a8255c:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
   180a82561:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
   180a82568:	00 00
   180a8256a:	c6 44 24 30 00       	mov    BYTE PTR [rsp+0x30],0x0
   180a8256f:	c7 44 24 28 1a 00 00 	mov    DWORD PTR [rsp+0x28],0x1a
   180a82576:	00
   180a82577:	4c 8d 0d 52 0b 62 08 	lea    r9,[rip+0x8620b52]        # 0x1890a30d0
   180a8257e:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   180a82582:	ba 03 00 00 00       	mov    edx,0x3
   180a82587:	49 89 f8             	mov    r8,rdi
   180a8258a:	e8 e1 ac 5e ff       	call   0x18006d270
   180a8258f:	90                   	nop
   180a82590:	4c 8b 4e 50          	mov    r9,QWORD PTR [rsi+0x50]
   180a82594:	48 c7 85 d0 00 00 00 	mov    QWORD PTR [rbp+0xd0],0x0
   180a8259b:	00 00 00 00
   180a8259f:	41 b8 08 00 00 00    	mov    r8d,0x8
   180a825a5:	49 ba 67 66 66 66 66 	movabs r10,0x6666666666666667
   180a825ac:	66 66 66
   180a825af:	4c 8d 1d ba 4c 49 08 	lea    r11,[rip+0x8494cba]        # 0x188f17270
   180a825b6:	4c 89 c9             	mov    rcx,r9
   180a825b9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
   180a825c0:	48 89 c8             	mov    rax,rcx
   180a825c3:	49 f7 ea             	imul   r10
   180a825c6:	48 89 d0             	mov    rax,rdx
   180a825c9:	48 c1 e8 3f          	shr    rax,0x3f
   180a825cd:	48 c1 fa 02          	sar    rdx,0x2
   180a825d1:	48 01 c2             	add    rdx,rax
   180a825d4:	48 8d 04 12          	lea    rax,[rdx+rdx*1]
   180a825d8:	48 8d 04 80          	lea    rax,[rax+rax*4]
   180a825dc:	4c 89 de             	mov    rsi,r11
   180a825df:	48 29 c6             	sub    rsi,rax
   180a825e2:	0f b6 44 0e 23       	movzx  eax,BYTE PTR [rsi+rcx*1+0x23]
   180a825e7:	42 88 84 05 d0 00 00 	mov    BYTE PTR [rbp+r8*1+0xd0],al
   180a825ee:	00
   180a825ef:	49 ff c0             	inc    r8
   180a825f2:	48 83 c1 09          	add    rcx,0x9
   180a825f6:	48 83 f9 12          	cmp    rcx,0x12
   180a825fa:	48 89 d1             	mov    rcx,rdx
   180a825fd:	77 c1                	ja     0x180a825c0
   180a825ff:	4d 85 c9             	test   r9,r9
   180a82602:	79 0c                	jns    0x180a82610
   180a82604:	42 c6 84 05 d0 00 00 	mov    BYTE PTR [rbp+r8*1+0xd0],0x2d
   180a8260b:	00 2d
   180a8260d:	49 ff c0             	inc    r8
   180a82610:	48 8d 85 d8 00 00 00 	lea    rax,[rbp+0xd8]
   180a82617:	42 c6 84 05 d0 00 00 	mov    BYTE PTR [rbp+r8*1+0xd0],0x0
   180a8261e:	00 00
   180a82620:	49 83 f8 0a          	cmp    r8,0xa
   180a82624:	7c 36                	jl     0x180a8265c
   180a82626:	49 8d 0c 28          	lea    rcx,[r8+rbp*1]
   180a8262a:	48 81 c1 d0 00 00 00 	add    rcx,0xd0
   180a82631:	48 ff c9             	dec    rcx
   180a82634:	48 8d 95 d9 00 00 00 	lea    rdx,[rbp+0xd9]
   180a8263b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
   180a82640:	44 0f b6 01          	movzx  r8d,BYTE PTR [rcx]
   180a82644:	44 0f b6 4a ff       	movzx  r9d,BYTE PTR [rdx-0x1]
   180a82649:	44 88 09             	mov    BYTE PTR [rcx],r9b
   180a8264c:	44 88 42 ff          	mov    BYTE PTR [rdx-0x1],r8b
   180a82650:	48 ff c9             	dec    rcx
   180a82653:	48 39 ca             	cmp    rdx,rcx
   180a82656:	48 8d 52 01          	lea    rdx,[rdx+0x1]
   180a8265a:	72 e4                	jb     0x180a82640
   180a8265c:	48 89 85 d0 00 00 00 	mov    QWORD PTR [rbp+0xd0],rax
   180a82663:	0f 57 c0             	xorps  xmm0,xmm0
   180a82666:	0f 11 85 b8 00 00 00 	movups XMMWORD PTR [rbp+0xb8],xmm0
   180a8266d:	0f 11 85 a8 00 00 00 	movups XMMWORD PTR [rbp+0xa8],xmm0
   180a82674:	0f 11 85 98 00 00 00 	movups XMMWORD PTR [rbp+0x98],xmm0
   180a8267b:	0f 11 85 88 00 00 00 	movups XMMWORD PTR [rbp+0x88],xmm0
   180a82682:	0f 11 45 78          	movups XMMWORD PTR [rbp+0x78],xmm0
   180a82686:	0f 11 45 68          	movups XMMWORD PTR [rbp+0x68],xmm0
   180a8268a:	0f 11 45 58          	movups XMMWORD PTR [rbp+0x58],xmm0
   180a8268e:	48 c7 85 c8 00 00 00 	mov    QWORD PTR [rbp+0xc8],0x0
   180a82695:	00 00 00 00
   180a82699:	48 8d 85 d0 00 00 00 	lea    rax,[rbp+0xd0]
   180a826a0:	48 89 45 50          	mov    QWORD PTR [rbp+0x50],rax
   180a826a4:	48 8d 15 45 07 62 08 	lea    rdx,[rip+0x8620745]        # 0x1890a2df0
   180a826ab:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   180a826af:	4c 8d 45 50          	lea    r8,[rbp+0x50]
   180a826b3:	e8 58 b1 5e ff       	call   0x18006d810
   180a826b8:	90                   	nop
   180a826b9:	48 8d 4d c0          	lea    rcx,[rbp-0x40]
   180a826bd:	e8 ae ac 5e ff       	call   0x18006d370
   180a826c2:	48 8b 85 38 01 00 00 	mov    rax,QWORD PTR [rbp+0x138]
   180a826c9:	48 83 f8 10          	cmp    rax,0x10
   180a826cd:	72 35                	jb     0x180a82704
   180a826cf:	48 8b 8d 20 01 00 00 	mov    rcx,QWORD PTR [rbp+0x120]
   180a826d6:	48 8d 50 01          	lea    rdx,[rax+0x1]
   180a826da:	48 81 fa 00 10 00 00 	cmp    rdx,0x1000
   180a826e1:	72 1b                	jb     0x180a826fe
   180a826e3:	4c 8b 41 f8          	mov    r8,QWORD PTR [rcx-0x8]
   180a826e7:	48 83 c1 f8          	add    rcx,0xfffffffffffffff8
   180a826eb:	4c 29 c1             	sub    rcx,r8
   180a826ee:	48 83 f9 20          	cmp    rcx,0x20
   180a826f2:	73 41                	jae    0x180a82735
   180a826f4:	48 83 c0 28          	add    rax,0x28
   180a826f8:	48 89 c2             	mov    rdx,rax
   180a826fb:	4c 89 c1             	mov    rcx,r8
   180a826fe:	e8 1d 96 ac 06       	call   0x18754bd20
   180a82703:	90                   	nop
   180a82704:	e8 07 36 5c ff       	call   0x180045d10
   180a82709:	90                   	nop
   180a8270a:	48 89 c1             	mov    rcx,rax
   180a8270d:	e8 5e d8 5c ff       	call   0x18004ff70
   180a82712:	90                   	nop
   180a82713:	48 8b bd 40 01 00 00 	mov    rdi,QWORD PTR [rbp+0x140]
   180a8271a:	89 c0                	mov    eax,eax
   180a8271c:	48 69 c0 e8 03 00 00 	imul   rax,rax,0x3e8
   180a82723:	48 89 47 70          	mov    QWORD PTR [rdi+0x70],rax
   180a82727:	48 89 f8             	mov    rax,rdi
   180a8272a:	48 81 c4 d0 01 00 00 	add    rsp,0x1d0
   180a82731:	5f                   	pop    rdi
   180a82732:	5e                   	pop    rsi
   180a82733:	5d                   	pop    rbp
   180a82734:	c3                   	ret
   180a82735:	e8 52 ba c5 06       	call   0x1876de18c
   180a8273a:	cc                   	int3
