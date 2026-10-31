
E:\Tencent\Weixin\4.1.15.56\Weixin.dll:     file format pei-x86-64


Disassembly of section .text:

0000000181094220 <.text+0x1093220>:
   181094220:	55                   	push   rbp
   181094221:	41 57                	push   r15
   181094223:	41 56                	push   r14
   181094225:	56                   	push   rsi
   181094226:	57                   	push   rdi
   181094227:	53                   	push   rbx
   181094228:	48 83 ec 78          	sub    rsp,0x78
   18109422c:	48 8d 6c 24 70       	lea    rbp,[rsp+0x70]
   181094231:	48 c7 45 00 fe ff ff 	mov    QWORD PTR [rbp+0x0],0xfffffffffffffffe
   181094238:	ff 
   181094239:	48 89 d7             	mov    rdi,rdx
   18109423c:	48 89 ce             	mov    rsi,rcx
   18109423f:	48 39 ca             	cmp    rdx,rcx
   181094242:	74 0c                	je     0x181094250
   181094244:	8b 47 6c             	mov    eax,DWORD PTR [rdi+0x6c]
   181094247:	84 c0                	test   al,al
   181094249:	75 55                	jne    0x1810942a0
   18109424b:	e9 fc 00 00 00       	jmp    0x18109434c
   181094250:	4c 8d 05 b9 28 10 08 	lea    r8,[rip+0x81028b9]        # 0x189196b10
   181094257:	48 8d 5d b8          	lea    rbx,[rbp-0x48]
   18109425b:	48 89 d9             	mov    rcx,rbx
   18109425e:	ba 03 00 00 00       	mov    edx,0x3
   181094263:	41 b9 d0 07 00 00    	mov    r9d,0x7d0
   181094269:	e8 22 0d 58 00       	call   0x181614f90
   18109426e:	90                   	nop
   18109426f:	48 8d 15 92 b9 f7 07 	lea    rdx,[rip+0x7f7b992]        # 0x18900fc08
   181094276:	48 89 d9             	mov    rcx,rbx
   181094279:	e8 42 0d 58 00       	call   0x181614fc0
   18109427e:	90                   	nop
   18109427f:	48 8d 4d f7          	lea    rcx,[rbp-0x9]
   181094283:	48 89 c2             	mov    rdx,rax
   181094286:	e8 55 0f 58 00       	call   0x1816151e0
   18109428b:	90                   	nop
   18109428c:	48 8d 4d b8          	lea    rcx,[rbp-0x48]
   181094290:	e8 5b 0f 58 00       	call   0x1816151f0
   181094295:	8b 47 6c             	mov    eax,DWORD PTR [rdi+0x6c]
   181094298:	84 c0                	test   al,al
   18109429a:	0f 84 ac 00 00 00    	je     0x18109434c
   1810942a0:	a8 01                	test   al,0x1
   1810942a2:	74 0d                	je     0x1810942b1
   1810942a4:	8b 47 10             	mov    eax,DWORD PTR [rdi+0x10]
   1810942a7:	83 4e 6c 01          	or     DWORD PTR [rsi+0x6c],0x1
   1810942ab:	89 46 10             	mov    DWORD PTR [rsi+0x10],eax
   1810942ae:	8b 47 6c             	mov    eax,DWORD PTR [rdi+0x6c]
   1810942b1:	a8 02                	test   al,0x2
   1810942b3:	74 26                	je     0x1810942db
   1810942b5:	80 4e 6c 02          	or     BYTE PTR [rsi+0x6c],0x2
   1810942b9:	48 8b 4e 08          	mov    rcx,QWORD PTR [rsi+0x8]
   1810942bd:	48 85 c9             	test   rcx,rcx
   1810942c0:	0f 84 f0 01 00 00    	je     0x1810944b6
   1810942c6:	48 8b 57 08          	mov    rdx,QWORD PTR [rdi+0x8]
   1810942ca:	48 85 d2             	test   rdx,rdx
   1810942cd:	0f 84 10 02 00 00    	je     0x1810944e3
   1810942d3:	e8 78 bc 5f ff       	call   0x18068ff50
   1810942d8:	8b 47 6c             	mov    eax,DWORD PTR [rdi+0x6c]
   1810942db:	a8 04                	test   al,0x4
   1810942dd:	74 26                	je     0x181094305
   1810942df:	80 4e 6c 04          	or     BYTE PTR [rsi+0x6c],0x4
   1810942e3:	48 8b 4e 18          	mov    rcx,QWORD PTR [rsi+0x18]
   1810942e7:	48 85 c9             	test   rcx,rcx
   1810942ea:	0f 84 03 02 00 00    	je     0x1810944f3
   1810942f0:	48 8b 57 18          	mov    rdx,QWORD PTR [rdi+0x18]
   1810942f4:	48 85 d2             	test   rdx,rdx
   1810942f7:	0f 84 23 02 00 00    	je     0x181094520
   1810942fd:	e8 4e bc 5f ff       	call   0x18068ff50
   181094302:	8b 47 6c             	mov    eax,DWORD PTR [rdi+0x6c]
   181094305:	a8 08                	test   al,0x8
   181094307:	74 0d                	je     0x181094316
   181094309:	8b 47 14             	mov    eax,DWORD PTR [rdi+0x14]
   18109430c:	83 4e 6c 08          	or     DWORD PTR [rsi+0x6c],0x8
   181094310:	89 46 14             	mov    DWORD PTR [rsi+0x14],eax
   181094313:	8b 47 6c             	mov    eax,DWORD PTR [rdi+0x6c]
   181094316:	a8 10                	test   al,0x10
   181094318:	74 26                	je     0x181094340
   18109431a:	80 4e 6c 10          	or     BYTE PTR [rsi+0x6c],0x10
   18109431e:	48 8b 4e 20          	mov    rcx,QWORD PTR [rsi+0x20]
   181094322:	48 85 c9             	test   rcx,rcx
   181094325:	0f 84 05 02 00 00    	je     0x181094530
   18109432b:	48 8b 57 20          	mov    rdx,QWORD PTR [rdi+0x20]
   18109432f:	48 85 d2             	test   rdx,rdx
   181094332:	0f 84 25 02 00 00    	je     0x18109455d
   181094338:	e8 13 bc 5f ff       	call   0x18068ff50
   18109433d:	8b 47 6c             	mov    eax,DWORD PTR [rdi+0x6c]
   181094340:	a8 20                	test   al,0x20
   181094342:	75 14                	jne    0x181094358
   181094344:	a8 40                	test   al,0x40
   181094346:	75 21                	jne    0x181094369
   181094348:	84 c0                	test   al,al
   18109434a:	78 2e                	js     0x18109437a
   18109434c:	a9 00 ff 00 00       	test   eax,0xff00
   181094351:	75 58                	jne    0x1810943ab
   181094353:	e9 d2 02 00 00       	jmp    0x18109462a
   181094358:	8b 47 28             	mov    eax,DWORD PTR [rdi+0x28]
   18109435b:	83 4e 6c 20          	or     DWORD PTR [rsi+0x6c],0x20
   18109435f:	89 46 28             	mov    DWORD PTR [rsi+0x28],eax
   181094362:	8b 47 6c             	mov    eax,DWORD PTR [rdi+0x6c]
   181094365:	a8 40                	test   al,0x40
   181094367:	74 df                	je     0x181094348
   181094369:	8b 47 2c             	mov    eax,DWORD PTR [rdi+0x2c]
   18109436c:	83 4e 6c 40          	or     DWORD PTR [rsi+0x6c],0x40
   181094370:	89 46 2c             	mov    DWORD PTR [rsi+0x2c],eax
   181094373:	8b 47 6c             	mov    eax,DWORD PTR [rdi+0x6c]
   181094376:	84 c0                	test   al,al
   181094378:	79 d2                	jns    0x18109434c
   18109437a:	80 4e 6c 80          	or     BYTE PTR [rsi+0x6c],0x80
   18109437e:	48 8b 4e 30          	mov    rcx,QWORD PTR [rsi+0x30]
   181094382:	48 85 c9             	test   rcx,rcx
   181094385:	0f 84 e2 01 00 00    	je     0x18109456d
   18109438b:	48 8b 57 30          	mov    rdx,QWORD PTR [rdi+0x30]
   18109438f:	48 85 d2             	test   rdx,rdx
   181094392:	0f 84 02 02 00 00    	je     0x18109459a
   181094398:	e8 53 b6 5f ff       	call   0x18068f9f0
   18109439d:	8b 47 6c             	mov    eax,DWORD PTR [rdi+0x6c]
   1810943a0:	a9 00 ff 00 00       	test   eax,0xff00
   1810943a5:	0f 84 7f 02 00 00    	je     0x18109462a
   1810943ab:	a9 00 01 00 00       	test   eax,0x100
   1810943b0:	74 10                	je     0x1810943c2
   1810943b2:	8b 47 48             	mov    eax,DWORD PTR [rdi+0x48]
   1810943b5:	81 4e 6c 00 01 00 00 	or     DWORD PTR [rsi+0x6c],0x100
   1810943bc:	89 46 48             	mov    DWORD PTR [rsi+0x48],eax
   1810943bf:	8b 47 6c             	mov    eax,DWORD PTR [rdi+0x6c]
   1810943c2:	a9 00 02 00 00       	test   eax,0x200
   1810943c7:	74 6d                	je     0x181094436
   1810943c9:	48 8b 5f 38          	mov    rbx,QWORD PTR [rdi+0x38]
   1810943cd:	81 4e 6c 00 02 00 00 	or     DWORD PTR [rsi+0x6c],0x200
   1810943d4:	48 8b 46 38          	mov    rax,QWORD PTR [rsi+0x38]
   1810943d8:	48 8d 0d 91 34 b0 0a 	lea    rcx,[rip+0xab03491]        # 0x18bb97870
   1810943df:	48 39 c8             	cmp    rax,rcx
   1810943e2:	75 24                	jne    0x181094408
   1810943e4:	b9 20 00 00 00       	mov    ecx,0x20
   1810943e9:	e8 ee 78 4b 06       	call   0x18754bcdc
   1810943ee:	0f 57 c0             	xorps  xmm0,xmm0
   1810943f1:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   1810943f4:	48 c7 40 10 00 00 00 	mov    QWORD PTR [rax+0x10],0x0
   1810943fb:	00 
   1810943fc:	48 c7 40 18 0f 00 00 	mov    QWORD PTR [rax+0x18],0xf
   181094403:	00 
   181094404:	48 89 46 38          	mov    QWORD PTR [rsi+0x38],rax
   181094408:	48 39 d8             	cmp    rax,rbx
   18109440b:	74 29                	je     0x181094436
   18109440d:	4c 8b 73 10          	mov    r14,QWORD PTR [rbx+0x10]
   181094411:	48 83 7b 18 10       	cmp    QWORD PTR [rbx+0x18],0x10
   181094416:	72 03                	jb     0x18109441b
   181094418:	48 8b 1b             	mov    rbx,QWORD PTR [rbx]
   18109441b:	48 8b 48 18          	mov    rcx,QWORD PTR [rax+0x18]
   18109441f:	49 39 ce             	cmp    r14,rcx
   181094422:	0f 86 82 01 00 00    	jbe    0x1810945aa
   181094428:	48 89 c1             	mov    rcx,rax
   18109442b:	4c 89 f2             	mov    rdx,r14
   18109442e:	49 89 d9             	mov    r9,rbx
   181094431:	e8 1a 9d fa fe       	call   0x18003e150
   181094436:	f6 47 6d 04          	test   BYTE PTR [rdi+0x6d],0x4
   18109443a:	0f 84 bc 01 00 00    	je     0x1810945fc
   181094440:	48 8b 5f 40          	mov    rbx,QWORD PTR [rdi+0x40]
   181094444:	81 4e 6c 00 04 00 00 	or     DWORD PTR [rsi+0x6c],0x400
   18109444b:	48 8b 46 40          	mov    rax,QWORD PTR [rsi+0x40]
   18109444f:	48 8d 0d 1a 34 b0 0a 	lea    rcx,[rip+0xab0341a]        # 0x18bb97870
   181094456:	48 39 c8             	cmp    rax,rcx
   181094459:	75 24                	jne    0x18109447f
   18109445b:	b9 20 00 00 00       	mov    ecx,0x20
   181094460:	e8 77 78 4b 06       	call   0x18754bcdc
   181094465:	0f 57 c0             	xorps  xmm0,xmm0
   181094468:	0f 11 00             	movups XMMWORD PTR [rax],xmm0
   18109446b:	48 c7 40 10 00 00 00 	mov    QWORD PTR [rax+0x10],0x0
   181094472:	00 
   181094473:	48 c7 40 18 0f 00 00 	mov    QWORD PTR [rax+0x18],0xf
   18109447a:	00 
   18109447b:	48 89 46 40          	mov    QWORD PTR [rsi+0x40],rax
   18109447f:	48 39 d8             	cmp    rax,rbx
   181094482:	0f 84 74 01 00 00    	je     0x1810945fc
   181094488:	4c 8b 73 10          	mov    r14,QWORD PTR [rbx+0x10]
   18109448c:	48 83 7b 18 10       	cmp    QWORD PTR [rbx+0x18],0x10
   181094491:	72 03                	jb     0x181094496
   181094493:	48 8b 1b             	mov    rbx,QWORD PTR [rbx]
   181094496:	48 8b 48 18          	mov    rcx,QWORD PTR [rax+0x18]
   18109449a:	49 39 ce             	cmp    r14,rcx
   18109449d:	0f 86 36 01 00 00    	jbe    0x1810945d9
   1810944a3:	48 89 c1             	mov    rcx,rax
   1810944a6:	4c 89 f2             	mov    rdx,r14
   1810944a9:	49 89 d9             	mov    r9,rbx
   1810944ac:	e8 9f 9c fa fe       	call   0x18003e150
   1810944b1:	e9 46 01 00 00       	jmp    0x1810945fc
   1810944b6:	b9 18 00 00 00       	mov    ecx,0x18
   1810944bb:	e8 1c 78 4b 06       	call   0x18754bcdc
   1810944c0:	90                   	nop
   1810944c1:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
   1810944c5:	48 89 c1             	mov    rcx,rax
   1810944c8:	e8 e3 9c 5f ff       	call   0x18068e1b0
   1810944cd:	90                   	nop
   1810944ce:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
   1810944d2:	48 89 4e 08          	mov    QWORD PTR [rsi+0x8],rcx
   1810944d6:	48 8b 57 08          	mov    rdx,QWORD PTR [rdi+0x8]
   1810944da:	48 85 d2             	test   rdx,rdx
   1810944dd:	0f 85 f0 fd ff ff    	jne    0x1810942d3
   1810944e3:	48 8b 05 76 3f b1 0a 	mov    rax,QWORD PTR [rip+0xab13f76]        # 0x18bba8460
   1810944ea:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
   1810944ee:	e9 e0 fd ff ff       	jmp    0x1810942d3
   1810944f3:	b9 18 00 00 00       	mov    ecx,0x18
   1810944f8:	e8 df 77 4b 06       	call   0x18754bcdc
   1810944fd:	90                   	nop
   1810944fe:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
   181094502:	48 89 c1             	mov    rcx,rax
   181094505:	e8 a6 9c 5f ff       	call   0x18068e1b0
   18109450a:	90                   	nop
   18109450b:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
   18109450f:	48 89 4e 18          	mov    QWORD PTR [rsi+0x18],rcx
   181094513:	48 8b 57 18          	mov    rdx,QWORD PTR [rdi+0x18]
   181094517:	48 85 d2             	test   rdx,rdx
   18109451a:	0f 85 dd fd ff ff    	jne    0x1810942fd
   181094520:	48 8b 05 39 3f b1 0a 	mov    rax,QWORD PTR [rip+0xab13f39]        # 0x18bba8460
   181094527:	48 8b 50 18          	mov    rdx,QWORD PTR [rax+0x18]
   18109452b:	e9 cd fd ff ff       	jmp    0x1810942fd
   181094530:	b9 18 00 00 00       	mov    ecx,0x18
   181094535:	e8 a2 77 4b 06       	call   0x18754bcdc
   18109453a:	90                   	nop
   18109453b:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
   18109453f:	48 89 c1             	mov    rcx,rax
   181094542:	e8 69 9c 5f ff       	call   0x18068e1b0
   181094547:	90                   	nop
   181094548:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
   18109454c:	48 89 4e 20          	mov    QWORD PTR [rsi+0x20],rcx
   181094550:	48 8b 57 20          	mov    rdx,QWORD PTR [rdi+0x20]
   181094554:	48 85 d2             	test   rdx,rdx
   181094557:	0f 85 db fd ff ff    	jne    0x181094338
   18109455d:	48 8b 05 fc 3e b1 0a 	mov    rax,QWORD PTR [rip+0xab13efc]        # 0x18bba8460
   181094564:	48 8b 50 20          	mov    rdx,QWORD PTR [rax+0x20]
   181094568:	e9 cb fd ff ff       	jmp    0x181094338
   18109456d:	b9 20 00 00 00       	mov    ecx,0x20
   181094572:	e8 65 77 4b 06       	call   0x18754bcdc
   181094577:	90                   	nop
   181094578:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
   18109457c:	48 89 c1             	mov    rcx,rax
   18109457f:	e8 fc 9b 5f ff       	call   0x18068e180
   181094584:	90                   	nop
   181094585:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
   181094589:	48 89 4e 30          	mov    QWORD PTR [rsi+0x30],rcx
   18109458d:	48 8b 57 30          	mov    rdx,QWORD PTR [rdi+0x30]
   181094591:	48 85 d2             	test   rdx,rdx
   181094594:	0f 85 fe fd ff ff    	jne    0x181094398
   18109459a:	48 8b 05 bf 3e b1 0a 	mov    rax,QWORD PTR [rip+0xab13ebf]        # 0x18bba8460
   1810945a1:	48 8b 50 30          	mov    rdx,QWORD PTR [rax+0x30]
   1810945a5:	e9 ee fd ff ff       	jmp    0x181094398
   1810945aa:	49 89 c7             	mov    r15,rax
   1810945ad:	48 83 f9 10          	cmp    rcx,0x10
   1810945b1:	72 03                	jb     0x1810945b6
   1810945b3:	4c 8b 38             	mov    r15,QWORD PTR [rax]
   1810945b6:	4c 89 70 10          	mov    QWORD PTR [rax+0x10],r14
   1810945ba:	4c 89 f9             	mov    rcx,r15
   1810945bd:	48 89 da             	mov    rdx,rbx
   1810945c0:	4d 89 f0             	mov    r8,r14
   1810945c3:	e8 78 08 68 06       	call   0x187714e40
   1810945c8:	43 c6 04 37 00       	mov    BYTE PTR [r15+r14*1],0x0
   1810945cd:	f6 47 6d 04          	test   BYTE PTR [rdi+0x6d],0x4
   1810945d1:	0f 85 69 fe ff ff    	jne    0x181094440
   1810945d7:	eb 23                	jmp    0x1810945fc
   1810945d9:	49 89 c7             	mov    r15,rax
   1810945dc:	48 83 f9 10          	cmp    rcx,0x10
   1810945e0:	72 03                	jb     0x1810945e5
   1810945e2:	4c 8b 38             	mov    r15,QWORD PTR [rax]
   1810945e5:	4c 89 70 10          	mov    QWORD PTR [rax+0x10],r14
   1810945e9:	4c 89 f9             	mov    rcx,r15
   1810945ec:	48 89 da             	mov    rdx,rbx
   1810945ef:	4d 89 f0             	mov    r8,r14
   1810945f2:	e8 49 08 68 06       	call   0x187714e40
   1810945f7:	43 c6 04 37 00       	mov    BYTE PTR [r15+r14*1],0x0
   1810945fc:	8b 47 6c             	mov    eax,DWORD PTR [rdi+0x6c]
   1810945ff:	a9 00 08 00 00       	test   eax,0x800
   181094604:	75 31                	jne    0x181094637
   181094606:	a9 00 10 00 00       	test   eax,0x1000
   18109460b:	75 43                	jne    0x181094650
   18109460d:	a9 00 20 00 00       	test   eax,0x2000
   181094612:	75 53                	jne    0x181094667
   181094614:	a9 00 40 00 00       	test   eax,0x4000
   181094619:	74 0f                	je     0x18109462a
   18109461b:	48 8b 47 60          	mov    rax,QWORD PTR [rdi+0x60]
   18109461f:	81 4e 6c 00 40 00 00 	or     DWORD PTR [rsi+0x6c],0x4000
   181094626:	48 89 46 60          	mov    QWORD PTR [rsi+0x60],rax
   18109462a:	48 83 c4 78          	add    rsp,0x78
   18109462e:	5b                   	pop    rbx
   18109462f:	5f                   	pop    rdi
   181094630:	5e                   	pop    rsi
   181094631:	41 5e                	pop    r14
   181094633:	41 5f                	pop    r15
   181094635:	5d                   	pop    rbp
   181094636:	c3                   	ret
   181094637:	48 8b 47 50          	mov    rax,QWORD PTR [rdi+0x50]
   18109463b:	81 4e 6c 00 08 00 00 	or     DWORD PTR [rsi+0x6c],0x800
   181094642:	48 89 46 50          	mov    QWORD PTR [rsi+0x50],rax
   181094646:	8b 47 6c             	mov    eax,DWORD PTR [rdi+0x6c]
   181094649:	a9 00 10 00 00       	test   eax,0x1000
   18109464e:	74 bd                	je     0x18109460d
   181094650:	8b 47 4c             	mov    eax,DWORD PTR [rdi+0x4c]
   181094653:	81 4e 6c 00 10 00 00 	or     DWORD PTR [rsi+0x6c],0x1000
   18109465a:	89 46 4c             	mov    DWORD PTR [rsi+0x4c],eax
   18109465d:	8b 47 6c             	mov    eax,DWORD PTR [rdi+0x6c]
   181094660:	a9 00 20 00 00       	test   eax,0x2000
   181094665:	74 ad                	je     0x181094614
   181094667:	80 4e 6d 20          	or     BYTE PTR [rsi+0x6d],0x20
   18109466b:	48 8b 4e 58          	mov    rcx,QWORD PTR [rsi+0x58]
   18109466f:	48 85 c9             	test   rcx,rcx
   181094672:	74 1a                	je     0x18109468e
   181094674:	48 8b 57 58          	mov    rdx,QWORD PTR [rdi+0x58]
   181094678:	48 85 d2             	test   rdx,rdx
   18109467b:	74 3a                	je     0x1810946b7
   18109467d:	e8 6e b3 5f ff       	call   0x18068f9f0
   181094682:	8b 47 6c             	mov    eax,DWORD PTR [rdi+0x6c]
   181094685:	a9 00 40 00 00       	test   eax,0x4000
   18109468a:	75 8f                	jne    0x18109461b
   18109468c:	eb 9c                	jmp    0x18109462a
   18109468e:	b9 20 00 00 00       	mov    ecx,0x20
   181094693:	e8 44 76 4b 06       	call   0x18754bcdc
   181094698:	90                   	nop
   181094699:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
   18109469d:	48 89 c1             	mov    rcx,rax
   1810946a0:	e8 db 9a 5f ff       	call   0x18068e180
   1810946a5:	90                   	nop
   1810946a6:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
   1810946aa:	48 89 4e 58          	mov    QWORD PTR [rsi+0x58],rcx
   1810946ae:	48 8b 57 58          	mov    rdx,QWORD PTR [rdi+0x58]
   1810946b2:	48 85 d2             	test   rdx,rdx
   1810946b5:	75 c6                	jne    0x18109467d
   1810946b7:	48 8b 05 a2 3d b1 0a 	mov    rax,QWORD PTR [rip+0xab13da2]        # 0x18bba8460
   1810946be:	48 8b 50 58          	mov    rdx,QWORD PTR [rax+0x58]
   1810946c2:	eb b9                	jmp    0x18109467d
