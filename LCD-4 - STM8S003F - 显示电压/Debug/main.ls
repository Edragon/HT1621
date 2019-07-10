   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
2493                     ; 41 void GPIO_init(void)
2493                     ; 42 {
2495                     	switch	.text
2496  0000               _GPIO_init:
2500                     ; 43 	CLK_CKDIVR	=	0X10;	//4M
2502  0000 351050c6      	mov	_CLK_CKDIVR,#16
2503                     ; 45 	PA_DDR	=	0B11111111;
2505  0004 35ff5002      	mov	_PA_DDR,#255
2506                     ; 46 	PA_CR1	=	0B11111111;
2508  0008 35ff5003      	mov	_PA_CR1,#255
2509                     ; 48 	PB_DDR	=	0B11111111;
2511  000c 35ff5007      	mov	_PB_DDR,#255
2512                     ; 49 	PB_CR1	=	0B11111111;
2514  0010 35ff5008      	mov	_PB_CR1,#255
2515                     ; 51 	PC_DDR	=	0B11111111;
2517  0014 35ff500c      	mov	_PC_DDR,#255
2518                     ; 52 	PC_CR1	=	0B11111111;
2520  0018 35ff500d      	mov	_PC_CR1,#255
2521                     ; 54 	PD_DDR	=	0B11101111;
2523  001c 35ef5011      	mov	_PD_DDR,#239
2524                     ; 55 	PD_CR1	=	0B11101111;
2526  0020 35ef5012      	mov	_PD_CR1,#239
2527                     ; 56 }
2530  0024 81            	ret
2556                     ; 58 void IWDG_init(void)
2556                     ; 59 {
2557                     	switch	.text
2558  0025               _IWDG_init:
2562                     ; 60 	IWDG_KR 	= 0xCC; 		//启动IWDG
2564  0025 35cc50e0      	mov	_IWDG_KR,#204
2565                     ; 61 	IWDG_KR 	= 0x55;   	//解除 PR 及 RLR 的写保护
2567  0029 355550e0      	mov	_IWDG_KR,#85
2568                     ; 62 	IWDG_RLR 	= 0xFF; 		//看门狗计数器重装载数值        
2570  002d 35ff50e2      	mov	_IWDG_RLR,#255
2571                     ; 63 	IWDG_PR 	= 0x06; 		//分频系数为256，最长超时时间为：1.02S
2573  0031 350650e1      	mov	_IWDG_PR,#6
2574                     ; 64 	IWDG_KR 	= 0xAA; 		//刷新IDDG，避免产生看门狗复位，同时恢复 PR 及 RLR 的写保护状态
2576  0035 35aa50e0      	mov	_IWDG_KR,#170
2577                     ; 65 }
2580  0039 81            	ret
2608                     ; 68 void ADC_init(void)
2608                     ; 69 {
2609                     	switch	.text
2610  003a               _ADC_init:
2614                     ; 70 	ADC_CR1  = 0X40;			//转换时间8分频0.25*8=2us  
2616  003a 35405401      	mov	_ADC_CR1,#64
2617                     ; 71 	ADC_CR2  = 0X28;			//右对齐
2619  003e 35285402      	mov	_ADC_CR2,#40
2620                     ; 72 	ADC_TDRH = 0xFF;		
2622  0042 35ff5406      	mov	_ADC_TDRH,#255
2623                     ; 73 	ADC_TDRL = 0xFF;			//禁止AN4的思密特触发
2625  0046 35ff5407      	mov	_ADC_TDRL,#255
2626                     ; 74 	ADON=1;
2628  004a 72105401      	bset	_ADON
2629                     ; 75 }
2632  004e 81            	ret
2685                     ; 80 void delay10ms(unsigned int x)
2685                     ; 81 {
2686                     	switch	.text
2687  004f               _delay10ms:
2689  004f 5204          	subw	sp,#4
2690       00000004      OFST:	set	4
2693                     ; 84 	for(a=x;a>0;a--)
2695  0051 1f01          	ldw	(OFST-3,sp),x
2697  0053 201b          	jra	L3561
2698  0055               L7461:
2699                     ; 86 		for(b=2800;b>0;b--)
2701  0055 ae0af0        	ldw	x,#2800
2702  0058 1f03          	ldw	(OFST-1,sp),x
2703  005a               L7561:
2704                     ; 87 		clrwdt()
2706  005a 35aa50e0      	mov	_IWDG_KR,#170
2707                     ; 86 		for(b=2800;b>0;b--)
2709  005e 1e03          	ldw	x,(OFST-1,sp)
2710  0060 1d0001        	subw	x,#1
2711  0063 1f03          	ldw	(OFST-1,sp),x
2714  0065 1e03          	ldw	x,(OFST-1,sp)
2715  0067 26f1          	jrne	L7561
2716                     ; 84 	for(a=x;a>0;a--)
2718  0069 1e01          	ldw	x,(OFST-3,sp)
2719  006b 1d0001        	subw	x,#1
2720  006e 1f01          	ldw	(OFST-3,sp),x
2721  0070               L3561:
2724  0070 1e01          	ldw	x,(OFST-3,sp)
2725  0072 26e1          	jrne	L7461
2726                     ; 89 }
2729  0074 5b04          	addw	sp,#4
2730  0076 81            	ret
2764                     ; 96 void main(void)
2764                     ; 97 {
2765                     	switch	.text
2766  0077               _main:
2770                     ; 98 	_asm("sim");
2773  0077 9b            sim
2775                     ; 100 	GPIO_init();
2777  0078 ad86          	call	_GPIO_init
2779                     ; 101 	IWDG_init();
2781  007a ada9          	call	_IWDG_init
2783                     ; 102 	ADC_init();
2785  007c adbc          	call	_ADC_init
2787                     ; 103 	VCC=1;
2789  007e 7218500a      	bset	_VCC
2790                     ; 104 	GND=0;
2792  0082 7217500a      	bres	_GND
2793                     ; 106 	ht1621_init();	//调用子程序
2795  0086 cd0000        	call	_ht1621_init
2797                     ; 108 	dian=1;					//开启点显示功能
2799  0089 72100000      	bset	_dian
2800                     ; 109 	display(8888);	//全屏显示，先开启点显示，然后写入8888
2802  008d ae22b8        	ldw	x,#8888
2803  0090 cd0000        	call	_display
2805                     ; 110 	delay10ms(100);	
2807  0093 ae0064        	ldw	x,#100
2808  0096 adb7          	call	_delay10ms
2810                     ; 111 	dian=0;					//关闭点显示功能
2812  0098 72110000      	bres	_dian
2813  009c               L5761:
2814                     ; 116 		display(get_vcc());	
2816  009c ad0a          	call	_get_vcc
2818  009e cd0000        	call	_display
2820                     ; 117 		delay10ms(50);
2822  00a1 ae0032        	ldw	x,#50
2823  00a4 ada9          	call	_delay10ms
2826  00a6 20f4          	jra	L5761
2892                     ; 121 unsigned int get_vcc(void)
2892                     ; 122 {
2893                     	switch	.text
2894  00a8               _get_vcc:
2896  00a8 5204          	subw	sp,#4
2897       00000004      OFST:	set	4
2900                     ; 125 	ADC_CSR = 4;
2902  00aa 35045400      	mov	_ADC_CSR,#4
2903                     ; 127 	ADON=1; 
2905  00ae 72105401      	bset	_ADON
2907  00b2               L7371:
2908                     ; 128 	while(!EOC);
2910                     	btst	_EOC
2911  00b7 24f9          	jruge	L7371
2912                     ; 129 	EOC=0;
2914  00b9 721f5400      	bres	_EOC
2915                     ; 131 	ad_l = ADC_DRL;
2917  00bd c65405        	ld	a,_ADC_DRL
2918  00c0 5f            	clrw	x
2919  00c1 97            	ld	xl,a
2920  00c2 1f01          	ldw	(OFST-3,sp),x
2921                     ; 132 	ad_h = ADC_DRH;
2923  00c4 c65404        	ld	a,_ADC_DRH
2924  00c7 5f            	clrw	x
2925  00c8 97            	ld	xl,a
2926  00c9 1f03          	ldw	(OFST-1,sp),x
2927                     ; 133 	ad = ((ad_h<<8) + ad_l);
2929  00cb 1e03          	ldw	x,(OFST-1,sp)
2930  00cd 4f            	clr	a
2931  00ce 02            	rlwa	x,a
2932  00cf 72fb01        	addw	x,(OFST-3,sp)
2933  00d2 1f03          	ldw	(OFST-1,sp),x
2934                     ; 134 	vcc = (unsigned int)(ad*(3.3/1024.0*100*3));
2936  00d4 1e03          	ldw	x,(OFST-1,sp)
2937  00d6 cd0000        	call	c_uitof
2939  00d9 ae0000        	ldw	x,#L7471
2940  00dc cd0000        	call	c_fmul
2942  00df cd0000        	call	c_ftoi
2944  00e2 1f03          	ldw	(OFST-1,sp),x
2945                     ; 136 	return(vcc);
2947  00e4 1e03          	ldw	x,(OFST-1,sp)
2950  00e6 5b04          	addw	sp,#4
2951  00e8 81            	ret
3055                     	xdef	_main
3056                     	xdef	_delay10ms
3057                     	xdef	_ADC_init
3058                     	xdef	_IWDG_init
3059                     	xdef	_GPIO_init
3060                     	xdef	_get_vcc
3061                     .bit:	section	.data,bit
3062  0000               _dian:
3063  0000 00            	ds.b	1
3064                     	xdef	_dian
3065                     	switch	.ubsct
3066  0000               _temp:
3067  0000 0000          	ds.b	2
3068                     	xdef	_temp
3069                     	xref	_display
3070                     	xref	_ht1621_init
3071                     .const:	section	.text
3072  0000               L7471:
3073  0000 3f778000      	dc.w	16247,-32768
3074                     	xref.b	c_x
3094                     	xref	c_ftoi
3095                     	xref	c_fmul
3096                     	xref	c_uitof
3097                     	end
