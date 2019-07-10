   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator (Limited) V4.4.6 - 08 Feb 2017
2493                     ; 26 void GPIO_init(void)
2493                     ; 27 {
2495                     	switch	.text
2496  0000               _GPIO_init:
2500                     ; 28 	CLK_CKDIVR	=	0X10;	//4M
2502  0000 351050c6      	mov	_CLK_CKDIVR,#16
2503                     ; 30 	PA_DDR	=	0XFF;
2505  0004 35ff5002      	mov	_PA_DDR,#255
2506                     ; 31 	PA_CR1	=	0XFF;
2508  0008 35ff5003      	mov	_PA_CR1,#255
2509                     ; 33 	PB_DDR	=	0XFF;
2511  000c 35ff5007      	mov	_PB_DDR,#255
2512                     ; 34 	PB_CR1	=	0XFF;
2514  0010 35ff5008      	mov	_PB_CR1,#255
2515                     ; 36 	PC_DDR	=	0XFF;	//OUT=PC5.6.7
2517  0014 35ff500c      	mov	_PC_DDR,#255
2518                     ; 37 	PC_CR1	=	0XFF;	//OUT=PC5.6.7
2520  0018 35ff500d      	mov	_PC_CR1,#255
2521                     ; 39 	PD_DDR	=	0XFF;
2523  001c 35ff5011      	mov	_PD_DDR,#255
2524                     ; 40 	PD_CR1	=	0XFF;
2526  0020 35ff5012      	mov	_PD_CR1,#255
2527                     ; 41 }
2530  0024 81            	ret
2556                     ; 43 void IWDG_init(void)
2556                     ; 44 {
2557                     	switch	.text
2558  0025               _IWDG_init:
2562                     ; 45 	IWDG_KR 	= 0xCC; 		//启动IWDG
2564  0025 35cc50e0      	mov	_IWDG_KR,#204
2565                     ; 46 	IWDG_KR 	= 0x55;   	//解除 PR 及 RLR 的写保护
2567  0029 355550e0      	mov	_IWDG_KR,#85
2568                     ; 47 	IWDG_RLR 	= 0xFF; 		//看门狗计数器重装载数值        
2570  002d 35ff50e2      	mov	_IWDG_RLR,#255
2571                     ; 48 	IWDG_PR 	= 0x06; 		//分频系数为256，最长超时时间为：1.02S
2573  0031 350650e1      	mov	_IWDG_PR,#6
2574                     ; 49 	IWDG_KR 	= 0xAA; 		//刷新IDDG，避免产生看门狗复位，同时恢复 PR 及 RLR 的写保护状态
2576  0035 35aa50e0      	mov	_IWDG_KR,#170
2577                     ; 50 }
2580  0039 81            	ret
2633                     ; 54 void delay10ms(unsigned int x)
2633                     ; 55 {
2634                     	switch	.text
2635  003a               _delay10ms:
2637  003a 5204          	subw	sp,#4
2638       00000004      OFST:	set	4
2641                     ; 58 	for(a=x;a>0;a--)
2643  003c 1f01          	ldw	(OFST-3,sp),x
2646  003e 201b          	jra	L3461
2647  0040               L7361:
2648                     ; 60 		for(b=2800;b>0;b--)
2650  0040 ae0af0        	ldw	x,#2800
2651  0043 1f03          	ldw	(OFST-1,sp),x
2653  0045               L7461:
2654                     ; 61 		clrwdt()
2656  0045 35aa50e0      	mov	_IWDG_KR,#170
2657                     ; 60 		for(b=2800;b>0;b--)
2659  0049 1e03          	ldw	x,(OFST-1,sp)
2660  004b 1d0001        	subw	x,#1
2661  004e 1f03          	ldw	(OFST-1,sp),x
2665  0050 1e03          	ldw	x,(OFST-1,sp)
2666  0052 26f1          	jrne	L7461
2667                     ; 58 	for(a=x;a>0;a--)
2669  0054 1e01          	ldw	x,(OFST-3,sp)
2670  0056 1d0001        	subw	x,#1
2671  0059 1f01          	ldw	(OFST-3,sp),x
2673  005b               L3461:
2676  005b 1e01          	ldw	x,(OFST-3,sp)
2677  005d 26e1          	jrne	L7361
2678                     ; 63 }
2681  005f 5b04          	addw	sp,#4
2682  0061 81            	ret
2716                     ; 70 void main(void)
2716                     ; 71 {
2717                     	switch	.text
2718  0062               _main:
2722                     ; 72 	_asm("sim");
2725  0062 9b            sim
2727                     ; 73 	GPIO_init();
2729  0063 ad9b          	call	_GPIO_init
2731                     ; 74 	IWDG_init();
2733  0065 adbe          	call	_IWDG_init
2735                     ; 76 	VCC=1;
2737  0067 7218500a      	bset	_VCC
2738                     ; 77 	GND=0;
2740  006b 7217500a      	bres	_GND
2741                     ; 78 	ht1621_init();	//调用子程序
2743  006f cd0000        	call	_ht1621_init
2745                     ; 80 	dian=1;					//开启点显示功能
2747  0072 72100000      	bset	_dian
2748                     ; 81 	display(8888);	//全屏显示，先开启点显示，然后写入8888
2750  0076 ae22b8        	ldw	x,#8888
2751  0079 cd0000        	call	_display
2753                     ; 82 	delay10ms(200);	//2s
2755  007c ae00c8        	ldw	x,#200
2756  007f adb9          	call	_delay10ms
2758                     ; 83 	dian=0;					//关闭点显示功能
2760  0081 72110000      	bres	_dian
2761                     ; 85 	number=0;
2763  0085 5f            	clrw	x
2764  0086 bf00          	ldw	_number,x
2765  0088               L5661:
2766                     ; 89 		number++;
2768  0088 be00          	ldw	x,_number
2769  008a 1c0001        	addw	x,#1
2770  008d bf00          	ldw	_number,x
2771                     ; 90 		if(number==9999)
2773  008f be00          	ldw	x,_number
2774  0091 a3270f        	cpw	x,#9999
2775  0094 2603          	jrne	L1761
2776                     ; 91 		number=0;
2778  0096 5f            	clrw	x
2779  0097 bf00          	ldw	_number,x
2780  0099               L1761:
2781                     ; 93 		display(number);	//调用显示子程序
2783  0099 be00          	ldw	x,_number
2784  009b cd0000        	call	_display
2786                     ; 94 		delay10ms(100);		//1s
2788  009e ae0064        	ldw	x,#100
2789  00a1 ad97          	call	_delay10ms
2791                     ; 95 		clrwdt();
2793  00a3 35aa50e0      	mov	_IWDG_KR,#170
2796  00a7 20df          	jra	L5661
2900                     	xdef	_main
2901                     	xdef	_delay10ms
2902                     	xdef	_IWDG_init
2903                     	xdef	_GPIO_init
2904                     .bit:	section	.data,bit
2905  0000               _dian:
2906  0000 00            	ds.b	1
2907                     	xdef	_dian
2908                     	switch	.ubsct
2909  0000               _number:
2910  0000 0000          	ds.b	2
2911                     	xdef	_number
2912                     	xref	_display
2913                     	xref	_ht1621_init
2933                     	end
