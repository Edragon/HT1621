
//使用本店或者别的STM8S003F单片机驱动时，直接下载代码，然后按照如下接线：


//液晶接线方式

//PC7----CS
//PC6----WR
//PC5----DA
//PC4----VCC
//PC3----GND


//PD3----AO---AN4


#include "stm8s003f3p.h"
#include "lcd.h"

#define clrwdt()  IWDG_KR = 0xAA;		//清零看门狗

_Bool  	ADON			@		ADC_CR1:0;
_Bool  	EOC				@		ADC_CSR:7;
_Bool  	IWDGF			@ 	RST_SR:1;
_Bool		TIM4_CEN	@		TIM4_CR1:0;
_Bool		TIM2_CEN	@		TIM2_CR1:0;

//*******************************************//

unsigned int temp;

_Bool dian;

_Bool		VCC		@	PC_ODR:4;		
_Bool		GND		@	PC_ODR:3;

unsigned int get_vcc(void);

//-------------------端口初始化-------------不使用的IO口要设为漏极开路输出

void GPIO_init(void)
{
	CLK_CKDIVR	=	0X10;	//4M
	
	PA_DDR	=	0B11111111;
	PA_CR1	=	0B11111111;
	
	PB_DDR	=	0B11111111;
	PB_CR1	=	0B11111111;
	
	PC_DDR	=	0B11111111;
	PC_CR1	=	0B11111111;

	PD_DDR	=	0B11101111;
	PD_CR1	=	0B11101111;
}

void IWDG_init(void)
{
	IWDG_KR 	= 0xCC; 		//启动IWDG
	IWDG_KR 	= 0x55;   	//解除 PR 及 RLR 的写保护
	IWDG_RLR 	= 0xFF; 		//看门狗计数器重装载数值        
	IWDG_PR 	= 0x06; 		//分频系数为256，最长超时时间为：1.02S
	IWDG_KR 	= 0xAA; 		//刷新IDDG，避免产生看门狗复位，同时恢复 PR 及 RLR 的写保护状态
}


void ADC_init(void)
{
	ADC_CR1  = 0X40;			//转换时间8分频0.25*8=2us  
	ADC_CR2  = 0X28;			//右对齐
	ADC_TDRH = 0xFF;		
	ADC_TDRL = 0xFF;			//禁止AN4的思密特触发
	ADON=1;
}


//--------------延时 10ms----------------------
	
void delay10ms(unsigned int x)
{
	unsigned int a,b;
	
	for(a=x;a>0;a--)
	{
		for(b=2800;b>0;b--)
		clrwdt()
	}
}


/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////


void main(void)
{
	_asm("sim");
	
	GPIO_init();
	IWDG_init();
	ADC_init();
	VCC=1;
	GND=0;

	ht1621_init();	//调用子程序
	
	dian=1;					//开启点显示功能
	display(8888);	//全屏显示，先开启点显示，然后写入8888
	delay10ms(100);	
	dian=0;					//关闭点显示功能
	

	while(1)
	{
		display(get_vcc());	
		delay10ms(50);
	}
}

unsigned int get_vcc(void)
{
	unsigned int vcc,ad,ad_h,ad_l;
	
	ADC_CSR = 4;
	
	ADON=1; 
	while(!EOC);
	EOC=0;
	
	ad_l = ADC_DRL;
	ad_h = ADC_DRH;
	ad = ((ad_h<<8) + ad_l);
	vcc = (unsigned int)(ad*(3.3/1024.0*100*3));

	return(vcc);
}