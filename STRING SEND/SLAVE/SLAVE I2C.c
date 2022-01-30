#include<pic.h>
#include"LCD 4 BIT.h"
#include<htc.h>

char Rx_Data;
char a[]={'S','R','I','D','H','A','R'};

void Start()
{
	SEN = 1;
	while(!SSPIF);
	SSPIF = 0;
}

void Receive_I2C_Data(unsigned char Data)
{
	Data = SSPBUF;
	while(SSPIF  ==0);
	SSPIF=0;
}

void Restart()
{
	RSEN = 1;
	while(!SSPIF);
	SSPIF=0;
}

void Stop()
{
	PEN = 1;
	while(SSPIF == 0);
	SSPIF = 0;
}

char Receive()
{
	char Ch;
	Ch = SSPBUF;
	if(SSPIF == 1)
	return Ch;
}

void Slave_I2C_Initialization()
{
	TRISC3=1;		
	TRISC4=1;

	SSPCON=0X26;		
	SSPCON2=0X00;		
	SSPSTAT=0X84;		
	SSPADD=0X24;

	PEIE=1;
	SSPIE=1;
	SSPBUF=0;
}

void main()
{
	TRISD=0X00;
	PORTD=0X00;
	
	Lcd_Intialization();
	
	Slave_I2C_Initialization();

	Lcd_Command(0x80);
	Lcd_String("LYCA SOFT");

	while(1)
	{
		Start();

		for(int u=0;u<7;u++)
		{
			if(ACKSTAT==0)
			{
				Rx_Data = Receive();
				
				if(Rx_Data == 'S')
				{
					Lcd_Command(0xC0);
					Lcd_Data(Rx_Data);

					SSPBUF=0;
					ACKDT=1;
					CKP=1;
					Stop();
				}
			}
		}
	}
}