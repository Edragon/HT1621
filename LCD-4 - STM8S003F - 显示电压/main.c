
//ʹ�ñ�����߱��STM8S003F��Ƭ������ʱ��ֱ�����ش��룬Ȼ�������½��ߣ�


//Һ�����߷�ʽ

//PC7----CS
//PC6----WR
//PC5----DA
//PC4----VCC
//PC3----GND


//PD3----AO---AN4


#include "stm8s003f3p.h"
#include "lcd.h"

#define clrwdt()  IWDG_KR = 0xAA;		//���㿴�Ź�

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

//-------------------�˿ڳ�ʼ��-------------��ʹ�õ�IO��Ҫ��Ϊ©����·���

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
	IWDG_KR 	= 0xCC; 		//����IWDG
	IWDG_KR 	= 0x55;   	//��� PR �� RLR ��д����
	IWDG_RLR 	= 0xFF; 		//���Ź���������װ����ֵ        
	IWDG_PR 	= 0x06; 		//��Ƶϵ��Ϊ256�����ʱʱ��Ϊ��1.02S
	IWDG_KR 	= 0xAA; 		//ˢ��IDDG������������Ź���λ��ͬʱ�ָ� PR �� RLR ��д����״̬
}


void ADC_init(void)
{
	ADC_CR1  = 0X40;			//ת��ʱ��8��Ƶ0.25*8=2us  
	ADC_CR2  = 0X28;			//�Ҷ���
	ADC_TDRH = 0xFF;		
	ADC_TDRL = 0xFF;			//��ֹAN4��˼���ش���
	ADON=1;
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
	ADC_init();
	VCC=1;
	GND=0;

	ht1621_init();	//�����ӳ���
	
	dian=1;					//��������ʾ����
	display(8888);	//ȫ����ʾ���ȿ�������ʾ��Ȼ��д��8888
	delay10ms(100);	
	dian=0;					//�رյ���ʾ����
	

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