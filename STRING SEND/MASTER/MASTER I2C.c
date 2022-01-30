#include<pic.h>
#include"LCD 4 BIT.h"
#include<htc.h>

char m[]={'S','R','I','D','H','A','R'};	

void Start()
{
	SEN = 1;
	SSPIF = 0;
	__delay_ms(100);
}

void Send_I2C_Data(unsigned char Data)
{
	SSPBUF == 0;
	while(SSPIF  ==0);
	SSPIF=0;
	SSPBUF = Data;
}

void Stop()
{
	PEN = 1;
	while(SSPIF == 0);
	SSPIF = 0;
	__delay_ms(100);
}

void Master_I2C_Initialization()
{
	TRISC3=1;		
	TRISC4=1;

	SSPCON=0XA8;		
	SSPCON2=0X80;		
	SSPSTAT=0X84;		
	SSPADD=9;
}

void main()
{
	TRISD=0X00;
	PORTD=0X00;
	
	Lcd_Intialization();
	
	Master_I2C_Initialization();

	Lcd_Command(0x80);
	Lcd_String("LYCA SOFT");

	while(1)
	{
		Start();
		Send_I2C_Data(0X24);

		if(ACKSTAT==0)
		{
			for(int u=0;u<7;u++)
			{
				Send_I2C_Data(m[u]);
				SSPBUF=0;
				__delay_ms(5);
			}
		}

		if(ACKSTAT==0)
		{
			while(SSPIF==0);
			SSPIF=0;
			Stop();
			__delay_ms(5);
		}
	}
}