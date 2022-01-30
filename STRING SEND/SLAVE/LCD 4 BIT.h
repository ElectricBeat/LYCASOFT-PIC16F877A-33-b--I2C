#define _XTAL_FREQ 20e6
__CONFIG(0X3F3A);

#define RS RD2
#define EN RD3

#define ON 1
#define OFF 0

void Lcd_Command(const unsigned char cmd)
{
	PORTD = (cmd & 0XF0);
	RS = OFF;
	EN = ON;
	__delay_ms(5);
	EN = OFF;

	PORTD = ((cmd<<4) & 0xF0);
	RS = OFF;
	EN = ON;
	__delay_ms(5);
	EN = OFF;
}

void Lcd_Data(const unsigned char Data)
{
	PORTD = (Data & 0XF0);
	RS = ON;
	EN = ON;
	__delay_ms(5);
	EN = OFF;

	PORTD = ((Data<<4) & 0xF0);
	RS = ON;
	EN = ON;
	__delay_ms(5);
	EN = OFF;
}

void Lcd_String(const unsigned char *Str)
{
	while(*Str != 0)
	{
		Lcd_Data(*Str++);
	}	
}

void Lcd_Intialization()
{
	Lcd_Command(0x02);
	Lcd_Command(0x28);
	Lcd_Command(0x0c);
}
