//上电后先全屏显示2秒
//LCD显示程序，间隔1秒，自动递加，加到9999后自动清零。

#include "stm8s003f3p.h"
#include "lcd.h"

#define clrwdt()  IWDG_KR = 0xAA;		//清零看门狗

_Bool  	ADON			@		ADC_CR1:0;
_Bool  	EOC				@		ADC_CSR:7;
_Bool  	IWDGF			@ 	RST_SR:1;
_Bool		TIM4_CEN	@		TIM4_CR1:0;
_Bool		TIM2_CEN	@		TIM2_CR1:0;

//*******************************************//

_Bool		GND			@	PC_ODR:3;
_Bool		VCC			@	PC_ODR:4;


unsigned int number;
_Bool dian;

//-------------------端口初始化-------------不使用的IO口要设为漏极开路输出

void GPIO_init(void)
{
	CLK_CKDIVR	=	0X10;	//4M
	
	PA_DDR	=	0XFF;
	PA_CR1	=	0XFF;
	
	PB_DDR	=	0XFF;
	PB_CR1	=	0XFF;
	
	PC_DDR	=	0XFF;	//OUT=PC5.6.7
	PC_CR1	=	0XFF;	//OUT=PC5.6.7

	PD_DDR	=	0XFF;
	PD_CR1	=	0XFF;
}

void IWDG_init(void)
{
	IWDG_KR 	= 0xCC; 		//启动IWDG
	IWDG_KR 	= 0x55;   	//解除 PR 及 RLR 的写保护
	IWDG_RLR 	= 0xFF; 		//看门狗计数器重装载数值        
	IWDG_PR 	= 0x06; 		//分频系数为256，最长超时时间为：1.02S
	IWDG_KR 	= 0xAA; 		//刷新IDDG，避免产生看门狗复位，同时恢复 PR 及 RLR 的写保护状态
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
	
	VCC=1;
	GND=0;
	ht1621_init();	//调用子程序
	
	dian=1;					//开启点显示功能
	display(8888);	//全屏显示，先开启点显示，然后写入8888
	delay10ms(200);	//2s
	dian=0;					//关闭点显示功能
	
	number=0;
	
	while(1)
	{
		number++;
		if(number==9999)
		number=0;
		
		display(number);	//调用显示子程序
		delay10ms(100);		//1s
		clrwdt();
	}
}