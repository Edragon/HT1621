//�ϵ����ȫ����ʾ2��
//LCD��ʾ���򣬼��1�룬�Զ��ݼӣ��ӵ�9999���Զ����㡣

#include "stm8s003f3p.h"
#include "lcd.h"

#define clrwdt()  IWDG_KR = 0xAA;		//���㿴�Ź�

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

//-------------------�˿ڳ�ʼ��-------------��ʹ�õ�IO��Ҫ��Ϊ©����·���

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
	IWDG_KR 	= 0xCC; 		//����IWDG
	IWDG_KR 	= 0x55;   	//��� PR �� RLR ��д����
	IWDG_RLR 	= 0xFF; 		//���Ź���������װ����ֵ        
	IWDG_PR 	= 0x06; 		//��Ƶϵ��Ϊ256�����ʱʱ��Ϊ��1.02S
	IWDG_KR 	= 0xAA; 		//ˢ��IDDG������������Ź���λ��ͬʱ�ָ� PR �� RLR ��д����״̬
}

//--------------��ʱ 10ms----------------------
	
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
	ht1621_init();	//�����ӳ���
	
	dian=1;					//��������ʾ����
	display(8888);	//ȫ����ʾ���ȿ�������ʾ��Ȼ��д��8888
	delay10ms(200);	//2s
	dian=0;					//�رյ���ʾ����
	
	number=0;
	
	while(1)
	{
		number++;
		if(number==9999)
		number=0;
		
		display(number);	//������ʾ�ӳ���
		delay10ms(100);		//1s
		clrwdt();
	}
}