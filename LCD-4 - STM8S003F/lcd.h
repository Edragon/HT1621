#ifndef	__LCD_H__
#define	__LCD_H__


void ht1621_init(void);							//��ʼ��LCD����ֲ����󣬱����ȵ��ó�ʼ������Ȼ���ڵ�����ʾ����������ϵ�ʱ�����
void display(unsigned int data);		//д����ʾ����

void start(void);
void write_com(unsigned char com);
void write_data(unsigned char data);
void write(unsigned char dat,unsigned char m)	;


#endif