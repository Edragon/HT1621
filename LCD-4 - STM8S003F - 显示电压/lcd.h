#ifndef	__LCD_H__
#define	__LCD_H__


void ht1621_init(void);							//初始化LCD，移植程序后，必须先调用初始化程序，然后在调用显示程序，最好在上电时候调用
void display(unsigned int data);		//写入显示内容

void start(void);
void write_com(unsigned char com);
void write_data(unsigned char data);
void write(unsigned char dat,unsigned char m)	;


#endif