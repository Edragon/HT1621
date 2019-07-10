#include "lcd.h"
#include "stm8s003f3p.h"


_Bool		DATA		@	PC_ODR:5;		//�����޸Ķ�Ӧ��IO��
_Bool		WR		  @	PC_ODR:6;
_Bool		CS			@	PC_ODR:7;


#define		SYSEN			0X02	//��ϵͳ����
#define		LCDON			0X06	//��LCDƫѹ������
#define 	BIAS 			0X52	//1/3ƫѹ��4��������
#define		TIMERDIS	0X08	//��ֹʱ�����
#define		WDTDIS1		0X0a	//��ֹWDT���


const unsigned char num[10]={0xeb,0x0a,0xad,0x8f,0x4e,0xc7,0xe7,0x8a,0xef,0xcf}; //0--9
extern _Bool dian;

//*********HT1621д�뿪������***********//

void ht1621_init(void)
{
	write_com(SYSEN);
	write_com(BIAS);
	write_com(LCDON);
	write_com(TIMERDIS);
	write_com(WDTDIS1);
}

//*********HT1621��ʼ***********//

void start(void)
{
	CS=1;
	WR=1;
	DATA=1;
	_asm("nop");_asm("nop");_asm("nop");
	CS=0;
	_asm("nop");_asm("nop");_asm("nop");
	WR=0;
}

//*********HT1621д����***********//

void write_com(unsigned char com)
{
	start();
	write(0x80,4);	  //д����ģʽ�������Ϊ12λ
	write(com,8);			//д������
}

//*********HT1621д��ַ***********//

void write_data(unsigned char data)
{
	start();
	write(0xa0,3);		//д��������
	write(data,6);		//д��RAM ��ַ0--31
}

//*********HT1621д����***********//

void write(unsigned char dat,unsigned char m)		
{
	unsigned char	x;
	for(x=0;x<m;x++)
	{
		if((dat&0x80)==0x00)
		DATA=0;
		else
		DATA=1;
		_asm("nop");_asm("nop");_asm("nop");
		WR=1;
		_asm("nop");_asm("nop");_asm("nop");
		WR=0;
		_asm("nop");_asm("nop");_asm("nop");
		dat=(unsigned char)(dat<<1);
	}
}


//*********HT1621��ʾ***********//

void display(unsigned int data)	
{
	unsigned char i,y;
	
	write_data(0);		//��RAM  0��ʼװ��
	
	i=(unsigned char)(data/1000);
	y=num[i];
	if(dian)
	write(y+0x10,8);	//ǧλ
	else
	write(y,8);				//ǧλ
	
	i=(unsigned char)((data%1000)/100);
	y=num[i];
	if(dian)
	write(y+0x10,8);	//��λ
	else
	write(y,8);				//��λ
	
	i=(unsigned char)((data%100)/10);
	y=num[i];
	if(!dian)
	write(y+0x10,8);	//ʮλ
	else
	write(y,8);				//ʮλ
	
	i=(unsigned char)(data%10);
	y=num[i];
	if(dian)
	write(y+0x10,8);	//��λ
	else
	write(y,8);				//��λ
}