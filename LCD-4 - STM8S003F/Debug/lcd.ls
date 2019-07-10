   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator (Limited) V4.4.6 - 08 Feb 2017
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
2651  0033 ae8004        	ldw	x,#32772
2652  0036 ad1c          	call	_write
2654                     ; 50 	write(com,8);			//写入命令
2656  0038 7b01          	ld	a,(OFST+1,sp)
2657  003a ae0008        	ldw	x,#8
2658  003d 95            	ld	xh,a
2659  003e ad14          	call	_write
2661                     ; 51 }
2664  0040 84            	pop	a
2665  0041 81            	ret
2701                     ; 55 void write_data(unsigned char data)
2701                     ; 56 {
2702                     	switch	.text
2703  0042               _write_data:
2705  0042 88            	push	a
2706       00000000      OFST:	set	0
2709                     ; 57 	start();
2711  0043 add0          	call	_start
2713                     ; 58 	write(0xa0,3);		//写数据命令
2715  0045 aea003        	ldw	x,#40963
2716  0048 ad0a          	call	_write
2718                     ; 59 	write(data,6);		//写入RAM 地址0--31
2720  004a 7b01          	ld	a,(OFST+1,sp)
2721  004c ae0006        	ldw	x,#6
2722  004f 95            	ld	xh,a
2723  0050 ad02          	call	_write
2725                     ; 60 }
2728  0052 84            	pop	a
2729  0053 81            	ret
2784                     ; 64 void write(unsigned char dat,unsigned char m)		
2784                     ; 65 {
2785                     	switch	.text
2786  0054               _write:
2788  0054 89            	pushw	x
2789  0055 88            	push	a
2790       00000001      OFST:	set	1
2793                     ; 67 	for(x=0;x<m;x++)
2795  0056 0f01          	clr	(OFST+0,sp)
2798  0058 2025          	jra	L7761
2799  005a               L3761:
2800                     ; 69 		if((dat&0x80)==0x00)
2802  005a 7b02          	ld	a,(OFST+1,sp)
2803  005c a580          	bcp	a,#128
2804  005e 2606          	jrne	L3071
2805                     ; 70 		DATA=0;
2807  0060 721b500a      	bres	_DATA
2809  0064 2004          	jra	L5071
2810  0066               L3071:
2811                     ; 72 		DATA=1;
2813  0066 721a500a      	bset	_DATA
2814  006a               L5071:
2815                     ; 73 		_asm("nop");_asm("nop");_asm("nop");
2818  006a 9d            nop
2823  006b 9d            nop
2828  006c 9d            nop
2830                     ; 74 		WR=1;
2832  006d 721c500a      	bset	_WR
2833                     ; 75 		_asm("nop");_asm("nop");_asm("nop");
2836  0071 9d            nop
2841  0072 9d            nop
2846  0073 9d            nop
2848                     ; 76 		WR=0;
2850  0074 721d500a      	bres	_WR
2851                     ; 77 		_asm("nop");_asm("nop");_asm("nop");
2854  0078 9d            nop
2859  0079 9d            nop
2864  007a 9d            nop
2866                     ; 78 		dat=(unsigned char)(dat<<1);
2868  007b 0802          	sll	(OFST+1,sp)
2869                     ; 67 	for(x=0;x<m;x++)
2871  007d 0c01          	inc	(OFST+0,sp)
2873  007f               L7761:
2876  007f 7b01          	ld	a,(OFST+0,sp)
2877  0081 1103          	cp	a,(OFST+2,sp)
2878  0083 25d5          	jrult	L3761
2879                     ; 80 }
2882  0085 5b03          	addw	sp,#3
2883  0087 81            	ret
2939                     ; 85 void display(unsigned int data)	
2939                     ; 86 {
2940                     	switch	.text
2941  0088               _display:
2943  0088 89            	pushw	x
2944  0089 88            	push	a
2945       00000001      OFST:	set	1
2948                     ; 89 	write_data(0);		//从RAM  0开始装入
2950  008a 4f            	clr	a
2951  008b adb5          	call	_write_data
2953                     ; 91 	i=(unsigned char)(data/1000);
2955  008d 1e02          	ldw	x,(OFST+1,sp)
2956  008f 90ae03e8      	ldw	y,#1000
2957  0093 65            	divw	x,y
2958  0094 9f            	ld	a,xl
2959  0095 6b01          	ld	(OFST+0,sp),a
2961                     ; 92 	y=num[i];
2963  0097 7b01          	ld	a,(OFST+0,sp)
2964  0099 5f            	clrw	x
2965  009a 97            	ld	xl,a
2966  009b d60000        	ld	a,(_num,x)
2967  009e 6b01          	ld	(OFST+0,sp),a
2969                     ; 93 	if(dian)
2971                     	btst	_dian
2972  00a5 240c          	jruge	L5371
2973                     ; 94 	write(y+0x10,8);	//千位
2975  00a7 7b01          	ld	a,(OFST+0,sp)
2976  00a9 ab10          	add	a,#16
2977  00ab ae0008        	ldw	x,#8
2978  00ae 95            	ld	xh,a
2979  00af ada3          	call	_write
2982  00b1 2008          	jra	L7371
2983  00b3               L5371:
2984                     ; 96 	write(y,8);				//千位
2986  00b3 7b01          	ld	a,(OFST+0,sp)
2987  00b5 ae0008        	ldw	x,#8
2988  00b8 95            	ld	xh,a
2989  00b9 ad99          	call	_write
2991  00bb               L7371:
2992                     ; 98 	i=(unsigned char)((data%1000)/100);
2994  00bb 1e02          	ldw	x,(OFST+1,sp)
2995  00bd 90ae03e8      	ldw	y,#1000
2996  00c1 65            	divw	x,y
2997  00c2 51            	exgw	x,y
2998  00c3 a664          	ld	a,#100
2999  00c5 62            	div	x,a
3000  00c6 9f            	ld	a,xl
3001  00c7 6b01          	ld	(OFST+0,sp),a
3003                     ; 99 	y=num[i];
3005  00c9 7b01          	ld	a,(OFST+0,sp)
3006  00cb 5f            	clrw	x
3007  00cc 97            	ld	xl,a
3008  00cd d60000        	ld	a,(_num,x)
3009  00d0 6b01          	ld	(OFST+0,sp),a
3011                     ; 100 	if(dian)
3013                     	btst	_dian
3014  00d7 240d          	jruge	L1471
3015                     ; 101 	write(y+0x10,8);	//百位
3017  00d9 7b01          	ld	a,(OFST+0,sp)
3018  00db ab10          	add	a,#16
3019  00dd ae0008        	ldw	x,#8
3020  00e0 95            	ld	xh,a
3021  00e1 cd0054        	call	_write
3024  00e4 2009          	jra	L3471
3025  00e6               L1471:
3026                     ; 103 	write(y,8);				//百位
3028  00e6 7b01          	ld	a,(OFST+0,sp)
3029  00e8 ae0008        	ldw	x,#8
3030  00eb 95            	ld	xh,a
3031  00ec cd0054        	call	_write
3033  00ef               L3471:
3034                     ; 105 	i=(unsigned char)((data%100)/10);
3036  00ef 1e02          	ldw	x,(OFST+1,sp)
3037  00f1 a664          	ld	a,#100
3038  00f3 62            	div	x,a
3039  00f4 5f            	clrw	x
3040  00f5 97            	ld	xl,a
3041  00f6 a60a          	ld	a,#10
3042  00f8 62            	div	x,a
3043  00f9 9f            	ld	a,xl
3044  00fa 6b01          	ld	(OFST+0,sp),a
3046                     ; 106 	y=num[i];
3048  00fc 7b01          	ld	a,(OFST+0,sp)
3049  00fe 5f            	clrw	x
3050  00ff 97            	ld	xl,a
3051  0100 d60000        	ld	a,(_num,x)
3052  0103 6b01          	ld	(OFST+0,sp),a
3054                     ; 107 	if(dian)
3056                     	btst	_dian
3057  010a 240d          	jruge	L5471
3058                     ; 108 	write(y+0x10,8);	//十位
3060  010c 7b01          	ld	a,(OFST+0,sp)
3061  010e ab10          	add	a,#16
3062  0110 ae0008        	ldw	x,#8
3063  0113 95            	ld	xh,a
3064  0114 cd0054        	call	_write
3067  0117 2009          	jra	L7471
3068  0119               L5471:
3069                     ; 110 	write(y,8);				//十位
3071  0119 7b01          	ld	a,(OFST+0,sp)
3072  011b ae0008        	ldw	x,#8
3073  011e 95            	ld	xh,a
3074  011f cd0054        	call	_write
3076  0122               L7471:
3077                     ; 112 	i=(unsigned char)(data%10);
3079  0122 1e02          	ldw	x,(OFST+1,sp)
3080  0124 a60a          	ld	a,#10
3081  0126 62            	div	x,a
3082  0127 5f            	clrw	x
3083  0128 97            	ld	xl,a
3084  0129 9f            	ld	a,xl
3085  012a 6b01          	ld	(OFST+0,sp),a
3087                     ; 113 	y=num[i];
3089  012c 7b01          	ld	a,(OFST+0,sp)
3090  012e 5f            	clrw	x
3091  012f 97            	ld	xl,a
3092  0130 d60000        	ld	a,(_num,x)
3093  0133 6b01          	ld	(OFST+0,sp),a
3095                     ; 114 	if(dian)
3097                     	btst	_dian
3098  013a 240d          	jruge	L1571
3099                     ; 115 	write(y+0x10,8);	//个位
3101  013c 7b01          	ld	a,(OFST+0,sp)
3102  013e ab10          	add	a,#16
3103  0140 ae0008        	ldw	x,#8
3104  0143 95            	ld	xh,a
3105  0144 cd0054        	call	_write
3108  0147 2009          	jra	L3571
3109  0149               L1571:
3110                     ; 117 	write(y,8);				//个位
3112  0149 7b01          	ld	a,(OFST+0,sp)
3113  014b ae0008        	ldw	x,#8
3114  014e 95            	ld	xh,a
3115  014f cd0054        	call	_write
3117  0152               L3571:
3118                     ; 118 }
3121  0152 5b03          	addw	sp,#3
3122  0154 81            	ret
3177                     	xbit	_dian
3178                     	xdef	_num
3179                     	xdef	_write
3180                     	xdef	_write_data
3181                     	xdef	_write_com
3182                     	xdef	_start
3183                     	xdef	_display
3184                     	xdef	_ht1621_init
3203                     	end
