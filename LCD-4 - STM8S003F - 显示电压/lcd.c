#include "lcd.h"
#include "stm8s003f3p.h"


_Bool		DATA		@	PC_ODR:5;		//这里修改对应的IO口
_Bool		WR		  @	PC_ODR:6;
_Bool		CS			@	PC_ODR:7;


#define		SYSEN			0X02	//打开系统振荡器
#define		LCDON			0X06	//打开LCD偏压发生器
#define 	BIAS 			0X52	//1/3偏压，4个公共口
#define		TIMERDIS	0X08	//禁止时基输出
#define		WDTDIS1		0X0a	//禁止WDT输出


const unsigned char num[10]={0xeb,0x0a,0xad,0x8f,0x4e,0xc7,0xe7,0x8a,0xef,0xcf}; //0--9
extern _Bool dian;

//*********HT1621写入开机命令***********//

void ht1621_init(void)
{
	write_com(SYSEN);
	write_com(BIAS);
	write_com(LCDON);
	write_com(TIMERDIS);
	write_com(WDTDIS1);
}

//*********HT1621开始***********//

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

//*********HT1621写命令***********//

void write_com(unsigned char com)
{
	start();
	write(0x80,4);	  //写命令模式，命令长度为12位
	write(com,8);			//写入命令
}

//*********HT1621写地址***********//

void write_data(unsigned char data)
{
	start();
	write(0xa0,3);		//写数据命令
	write(data,6);		//写入RAM 地址0--31
}

//*********HT1621写数据***********//

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


//*********HT1621显示***********//

void display(unsigned int data)	
{
	unsigned char i,y;
	
	write_data(0);		//从RAM  0开始装入
	
	i=(unsigned char)(data/1000);
	y=num[i];
	if(dian)
	write(y+0x10,8);	//千位
	else
	write(y,8);				//千位
	
	i=(unsigned char)((data%1000)/100);
	y=num[i];
	if(dian)
	write(y+0x10,8);	//百位
	else
	write(y,8);				//百位
	
	i=(unsigned char)((data%100)/10);
	y=num[i];
	if(!dian)
	write(y+0x10,8);	//十位
	else
	write(y,8);				//十位
	
	i=(unsigned char)(data%10);
	y=num[i];
	if(dian)
	write(y+0x10,8);	//个位
	else
	write(y,8);				//个位
}