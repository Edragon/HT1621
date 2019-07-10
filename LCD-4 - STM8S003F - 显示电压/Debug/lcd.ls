   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
2443                     .const:	section	.text
2444  0000               _num:
2445  0000 eb            	dc.b	235
2446  0001 0a            	dc.b	10
2447  0002 ad            	dc.b	173
2448  0003 8f            	dc.b	143
2449  0004 4e            	dc.b	78
2450  0005 c7            	dc.b	199
2451  0006 e7            	dc.b	231
2452  0007 8a            	dc.b	138
2453  0008 ef            	dc.b	239
2454  0009 cf            	dc.b	207
2485                     ; 22 void ht1621_init(void)
2485                     ; 23 {
2487                     	switch	.text
2488  0000               _ht1621_init:
2492                     ; 24 	write_com(SYSEN);
2494  0000 a602          	ld	a,#2
2495  0002 ad2c          	call	_write_com
2497                     ; 25 	write_com(BIAS);
2499  0004 a652          	ld	a,#82
2500  0006 ad28          	call	_write_com
2502                     ; 26 	write_com(LCDON);
2504  0008 a606          	ld	a,#6
2505  000a ad24          	call	_write_com
2507                     ; 27 	write_com(TIMERDIS);
2509  000c a608          	ld	a,#8
2510  000e ad20          	call	_write_com
2512                     ; 28 	write_com(WDTDIS1);
2514  0010 a60a          	ld	a,#10
2515  0012 ad1c          	call	_write_com
2517                     ; 29 }
2520  0014 81            	ret
2547                     ; 33 void start(void)
2547                     ; 34 {
2548                     	switch	.text
2549  0015               _start:
2553                     ; 35 	CS=1;
2555  0015 721e500a      	bset	_CS
2556                     ; 36 	WR=1;
2558  0019 721c500a      	bset	_WR
2559                     ; 37 	DATA=1;
2561  001d 721a500a      	bset	_DATA
2562                     ; 38 	_asm("nop");_asm("nop");_asm("nop");
2565  0021 9d            nop
2570  0022 9d            nop
2575  0023 9d            nop
2577                     ; 39 	CS=0;
2579  0024 721f500a      	bres	_CS
2580                     ; 40 	_asm("nop");_asm("nop");_asm("nop");
2583  0028 9d            nop
2588  0029 9d            nop
2593  002a 9d            nop
2595                     ; 41 	WR=0;
2597  002b 721d500a      	bres	_WR
2598                     ; 42 }
2601  002f 81            	ret
2637                     ; 46 void write_com(unsigned char com)
2637                     ; 47 {
2638                     	switch	.text
2639  0030               _write_com:
2641  0030 88            	push	a
2642       00000000      OFST:	set	0
2645                     ; 48 	start();
2647  0031 ade2          	call	_start
2649                     ; 49 	write(0x80,4);	  //写命令模式，命令长度为12位
2651  0033 ae0004        	ldw	x,#4
2652  0036 a680          	ld	a,#128
2653  0038 95            	ld	xh,a
2654  0039 ad1f          	call	_write
2656                     ; 50 	write(com,8);			//写入命令
2658  003b ae0008        	ldw	x,#8
2659  003e 7b01          	ld	a,(OFST+1,sp)
2660  0040 95            	ld	xh,a
2661  0041 ad17          	call	_write
2663                     ; 51 }
2666  0043 84            	pop	a
2667  0044 81            	ret
2703                     ; 55 void write_data(unsigned char data)
2703                     ; 56 {
2704                     	switch	.text
2705  0045               _write_data:
2707  0045 88            	push	a
2708       00000000      OFST:	set	0
2711                     ; 57 	start();
2713  0046 adcd          	call	_start
2715                     ; 58 	write(0xa0,3);		//写数据命令
2717  0048 ae0003        	ldw	x,#3
2718  004b a6a0          	ld	a,#160
2719  004d 95            	ld	xh,a
2720  004e ad0a          	call	_write
2722                     ; 59 	write(data,6);		//写入RAM 地址0--31
2724  0050 ae0006        	ldw	x,#6
2725  0053 7b01          	ld	a,(OFST+1,sp)
2726  0055 95            	ld	xh,a
2727  0056 ad02          	call	_write
2729                     ; 60 }
2732  0058 84            	pop	a
2733  0059 81            	ret
2788                     ; 64 void write(unsigned char dat,unsigned char m)		
2788                     ; 65 {
2789                     	switch	.text
2790  005a               _write:
2792  005a 89            	pushw	x
2793  005b 88            	push	a
2794       00000001      OFST:	set	1
2797                     ; 67 	for(x=0;x<m;x++)
2799  005c 0f01          	clr	(OFST+0,sp)
2801  005e 2025          	jra	L7761
2802  0060               L3761:
2803                     ; 69 		if((dat&0x80)==0x00)
2805  0060 7b02          	ld	a,(OFST+1,sp)
2806  0062 a580          	bcp	a,#128
2807  0064 2606          	jrne	L3071
2808                     ; 70 		DATA=0;
2810  0066 721b500a      	bres	_DATA
2812  006a 2004          	jra	L5071
2813  006c               L3071:
2814                     ; 72 		DATA=1;
2816  006c 721a500a      	bset	_DATA
2817  0070               L5071:
2818                     ; 73 		_asm("nop");_asm("nop");_asm("nop");
2821  0070 9d            nop
2826  0071 9d            nop
2831  0072 9d            nop
2833                     ; 74 		WR=1;
2835  0073 721c500a      	bset	_WR
2836                     ; 75 		_asm("nop");_asm("nop");_asm("nop");
2839  0077 9d            nop
2844  0078 9d            nop
2849  0079 9d            nop
2851                     ; 76 		WR=0;
2853  007a 721d500a      	bres	_WR
2854                     ; 77 		_asm("nop");_asm("nop");_asm("nop");
2857  007e 9d            nop
2862  007f 9d            nop
2867  0080 9d            nop
2869                     ; 78 		dat=(unsigned char)(dat<<1);
2871  0081 0802          	sll	(OFST+1,sp)
2872                     ; 67 	for(x=0;x<m;x++)
2874  0083 0c01          	inc	(OFST+0,sp)
2875  0085               L7761:
2878  0085 7b01          	ld	a,(OFST+0,sp)
2879  0087 1103          	cp	a,(OFST+2,sp)
2880  0089 25d5          	jrult	L3761
2881                     ; 80 }
2884  008b 5b03          	addw	sp,#3
2885  008d 81            	ret
2941                     ; 85 void display(unsigned int data)	
2941                     ; 86 {
2942                     	switch	.text
2943  008e               _display:
2945  008e 89            	pushw	x
2946  008f 88            	push	a
2947       00000001      OFST:	set	1
2950                     ; 89 	write_data(0);		//从RAM  0开始装入
2952  0090 4f            	clr	a
2953  0091 adb2          	call	_write_data
2955                     ; 91 	i=(unsigned char)(data/1000);
2957  0093 1e02          	ldw	x,(OFST+1,sp)
2958  0095 90ae03e8      	ldw	y,#1000
2959  0099 65            	divw	x,y
2960  009a 9f            	ld	a,xl
2961  009b 6b01          	ld	(OFST+0,sp),a
2962                     ; 92 	y=num[i];
2964  009d 7b01          	ld	a,(OFST+0,sp)
2965  009f 5f            	clrw	x
2966  00a0 97            	ld	xl,a
2967  00a1 d60000        	ld	a,(_num,x)
2968  00a4 6b01          	ld	(OFST+0,sp),a
2969                     ; 93 	if(dian)
2971                     	btst	_dian
2972  00ab 240c          	jruge	L5371
2973                     ; 94 	write(y+0x10,8);	//千位
2975  00ad ae0008        	ldw	x,#8
2976  00b0 7b01          	ld	a,(OFST+0,sp)
2977  00b2 ab10          	add	a,#16
2978  00b4 95            	ld	xh,a
2979  00b5 ada3          	call	_write
2982  00b7 2008          	jra	L7371
2983  00b9               L5371:
2984                     ; 96 	write(y,8);				//千位
2986  00b9 ae0008        	ldw	x,#8
2987  00bc 7b01          	ld	a,(OFST+0,sp)
2988  00be 95            	ld	xh,a
2989  00bf ad99          	call	_write
2991  00c1               L7371:
2992                     ; 98 	i=(unsigned char)((data%1000)/100);
2994  00c1 1e02          	ldw	x,(OFST+1,sp)
2995  00c3 90ae03e8      	ldw	y,#1000
2996  00c7 65            	divw	x,y
2997  00c8 51            	exgw	x,y
2998  00c9 90ae0064      	ldw	y,#100
2999  00cd 65            	divw	x,y
3000  00ce 9f            	ld	a,xl
3001  00cf 6b01          	ld	(OFST+0,sp),a
3002                     ; 99 	y=num[i];
3004  00d1 7b01          	ld	a,(OFST+0,sp)
3005  00d3 5f            	clrw	x
3006  00d4 97            	ld	xl,a
3007  00d5 d60000        	ld	a,(_num,x)
3008  00d8 6b01          	ld	(OFST+0,sp),a
3009                     ; 100 	if(dian)
3011                     	btst	_dian
3012  00df 240d          	jruge	L1471
3013                     ; 101 	write(y+0x10,8);	//百位
3015  00e1 ae0008        	ldw	x,#8
3016  00e4 7b01          	ld	a,(OFST+0,sp)
3017  00e6 ab10          	add	a,#16
3018  00e8 95            	ld	xh,a
3019  00e9 cd005a        	call	_write
3022  00ec 2009          	jra	L3471
3023  00ee               L1471:
3024                     ; 103 	write(y,8);				//百位
3026  00ee ae0008        	ldw	x,#8
3027  00f1 7b01          	ld	a,(OFST+0,sp)
3028  00f3 95            	ld	xh,a
3029  00f4 cd005a        	call	_write
3031  00f7               L3471:
3032                     ; 105 	i=(unsigned char)((data%100)/10);
3034  00f7 1e02          	ldw	x,(OFST+1,sp)
3035  00f9 90ae0064      	ldw	y,#100
3036  00fd 65            	divw	x,y
3037  00fe 51            	exgw	x,y
3038  00ff 90ae000a      	ldw	y,#10
3039  0103 65            	divw	x,y
3040  0104 9f            	ld	a,xl
3041  0105 6b01          	ld	(OFST+0,sp),a
3042                     ; 106 	y=num[i];
3044  0107 7b01          	ld	a,(OFST+0,sp)
3045  0109 5f            	clrw	x
3046  010a 97            	ld	xl,a
3047  010b d60000        	ld	a,(_num,x)
3048  010e 6b01          	ld	(OFST+0,sp),a
3049                     ; 107 	if(!dian)
3051                     	btst	_dian
3052  0115 250d          	jrult	L5471
3053                     ; 108 	write(y+0x10,8);	//十位
3055  0117 ae0008        	ldw	x,#8
3056  011a 7b01          	ld	a,(OFST+0,sp)
3057  011c ab10          	add	a,#16
3058  011e 95            	ld	xh,a
3059  011f cd005a        	call	_write
3062  0122 2009          	jra	L7471
3063  0124               L5471:
3064                     ; 110 	write(y,8);				//十位
3066  0124 ae0008        	ldw	x,#8
3067  0127 7b01          	ld	a,(OFST+0,sp)
3068  0129 95            	ld	xh,a
3069  012a cd005a        	call	_write
3071  012d               L7471:
3072                     ; 112 	i=(unsigned char)(data%10);
3074  012d 1e02          	ldw	x,(OFST+1,sp)
3075  012f 90ae000a      	ldw	y,#10
3076  0133 65            	divw	x,y
3077  0134 51            	exgw	x,y
3078  0135 9f            	ld	a,xl
3079  0136 6b01          	ld	(OFST+0,sp),a
3080                     ; 113 	y=num[i];
3082  0138 7b01          	ld	a,(OFST+0,sp)
3083  013a 5f            	clrw	x
3084  013b 97            	ld	xl,a
3085  013c d60000        	ld	a,(_num,x)
3086  013f 6b01          	ld	(OFST+0,sp),a
3087                     ; 114 	if(dian)
3089                     	btst	_dian
3090  0146 240d          	jruge	L1571
3091                     ; 115 	write(y+0x10,8);	//个位
3093  0148 ae0008        	ldw	x,#8
3094  014b 7b01          	ld	a,(OFST+0,sp)
3095  014d ab10          	add	a,#16
3096  014f 95            	ld	xh,a
3097  0150 cd005a        	call	_write
3100  0153 2009          	jra	L3571
3101  0155               L1571:
3102                     ; 117 	write(y,8);				//个位
3104  0155 ae0008        	ldw	x,#8
3105  0158 7b01          	ld	a,(OFST+0,sp)
3106  015a 95            	ld	xh,a
3107  015b cd005a        	call	_write
3109  015e               L3571:
3110                     ; 118 }
3113  015e 5b03          	addw	sp,#3
3114  0160 81            	ret
3169                     	xbit	_dian
3170                     	xdef	_num
3171                     	xdef	_write
3172                     	xdef	_write_data
3173                     	xdef	_write_com
3174                     	xdef	_start
3175                     	xdef	_display
3176                     	xdef	_ht1621_init
3195                     	end
