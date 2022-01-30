opt subtitle "HI-TECH Software Omniscient Code Generator (Lite mode) build 10920"

opt pagewidth 120

	opt lm

	processor	16F877A
clrc	macro
	bcf	3,0
	endm
clrz	macro
	bcf	3,2
	endm
setc	macro
	bsf	3,0
	endm
setz	macro
	bsf	3,2
	endm
skipc	macro
	btfss	3,0
	endm
skipz	macro
	btfss	3,2
	endm
skipnc	macro
	btfsc	3,0
	endm
skipnz	macro
	btfsc	3,2
	endm
indf	equ	0
indf0	equ	0
pc	equ	2
pcl	equ	2
status	equ	3
fsr	equ	4
fsr0	equ	4
c	equ	1
z	equ	0
pclath	equ	10
# 2 "E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\LCD 4 BIT.h"
	psect config,class=CONFIG,delta=2 ;#
# 2 "E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\LCD 4 BIT.h"
	dw 0X3F3A ;#
	FNCALL	_main,_Lcd_Intialization
	FNCALL	_main,_Master_I2C_Initialization
	FNCALL	_main,_Lcd_Command
	FNCALL	_main,_Lcd_String
	FNCALL	_main,_Start
	FNCALL	_main,_Send_I2C_Data
	FNCALL	_main,_Stop
	FNCALL	_Lcd_Intialization,_Lcd_Command
	FNCALL	_Lcd_String,_Lcd_Data
	FNROOT	_main
	global	_m
psect	idataBANK0,class=CODE,space=0,delta=2
global __pidataBANK0
__pidataBANK0:
	file	"E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\MASTER I2C.c"
	line	5

;initializer for _m
	retlw	053h
	retlw	052h
	retlw	049h
	retlw	044h
	retlw	048h
	retlw	041h
	retlw	052h
	global	_PORTD
_PORTD	set	8
	global	_SSPBUF
_SSPBUF	set	19
	global	_SSPCON
_SSPCON	set	20
	global	_CARRY
_CARRY	set	24
	global	_GIE
_GIE	set	95
	global	_RD2
_RD2	set	66
	global	_RD3
_RD3	set	67
	global	_SSPIF
_SSPIF	set	99
	global	_SSPADD
_SSPADD	set	147
	global	_SSPCON2
_SSPCON2	set	145
	global	_SSPSTAT
_SSPSTAT	set	148
	global	_TRISD
_TRISD	set	136
	global	_ACKSTAT
_ACKSTAT	set	1166
	global	_PEN
_PEN	set	1162
	global	_SEN
_SEN	set	1160
	global	_TRISC3
_TRISC3	set	1083
	global	_TRISC4
_TRISC4	set	1084
	global	_EEADR
_EEADR	set	269
	global	_EEDATA
_EEDATA	set	268
	global	_EECON1
_EECON1	set	396
	global	_EECON2
_EECON2	set	397
	global	_RD
_RD	set	3168
	global	_WR
_WR	set	3169
	global	_WREN
_WREN	set	3170
psect	strings,class=STRING,delta=2
global __pstrings
__pstrings:
;	global	stringdir,stringtab,__stringbase
stringtab:
;	String table - string pointers are 1 byte each
stringcode:stringdir:
movlw high(stringdir)
movwf pclath
movf fsr,w
incf fsr
	addwf pc
__stringbase:
	retlw	0
psect	strings
	
STR_1:	
	retlw	76	;'L'
	retlw	89	;'Y'
	retlw	67	;'C'
	retlw	65	;'A'
	retlw	32	;' '
	retlw	83	;'S'
	retlw	79	;'O'
	retlw	70	;'F'
	retlw	84	;'T'
	retlw	0
psect	strings
	file	"MASTER I2C.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

psect	dataBANK0,class=BANK0,space=1
global __pdataBANK0
__pdataBANK0:
	file	"E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\MASTER I2C.c"
_m:
       ds      7

global btemp
psect inittext,class=CODE,delta=2
global init_fetch,btemp
;	Called with low address in FSR and high address in W
init_fetch:
	movf btemp,w
	movwf pclath
	movf btemp+1,w
	movwf pc
global init_ram
;Called with:
;	high address of idata address in btemp 
;	low address of idata address in btemp+1 
;	low address of data in FSR
;	high address + 1 of data in btemp-1
init_ram:
	fcall init_fetch
	movwf indf,f
	incf fsr,f
	movf fsr,w
	xorwf btemp-1,w
	btfsc status,2
	retlw 0
	incf btemp+1,f
	btfsc status,2
	incf btemp,f
	goto init_ram
; Initialize objects allocated to BANK0
psect cinit,class=CODE,delta=2
global init_ram, __pidataBANK0
	bcf	status, 7	;select IRP bank0
	movlw low(__pdataBANK0+7)
	movwf btemp-1,f
	movlw high(__pidataBANK0)
	movwf btemp,f
	movlw low(__pidataBANK0)
	movwf btemp+1,f
	movlw low(__pdataBANK0)
	movwf fsr,f
	fcall init_ram
psect cinit,class=CODE,delta=2
global end_of_initialization

;End of C runtime variable initialization code

end_of_initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackCOMMON,class=COMMON,space=1
global __pcstackCOMMON
__pcstackCOMMON:
	global	?_Lcd_Command
?_Lcd_Command:	; 0 bytes @ 0x0
	global	??_Lcd_Command
??_Lcd_Command:	; 0 bytes @ 0x0
	global	?_Lcd_Data
?_Lcd_Data:	; 0 bytes @ 0x0
	global	??_Lcd_Data
??_Lcd_Data:	; 0 bytes @ 0x0
	global	?_Lcd_String
?_Lcd_String:	; 0 bytes @ 0x0
	global	?_Lcd_Intialization
?_Lcd_Intialization:	; 0 bytes @ 0x0
	global	?_Start
?_Start:	; 0 bytes @ 0x0
	global	??_Start
??_Start:	; 0 bytes @ 0x0
	global	?_Send_I2C_Data
?_Send_I2C_Data:	; 0 bytes @ 0x0
	global	??_Send_I2C_Data
??_Send_I2C_Data:	; 0 bytes @ 0x0
	global	?_Stop
?_Stop:	; 0 bytes @ 0x0
	global	??_Stop
??_Stop:	; 0 bytes @ 0x0
	global	?_Master_I2C_Initialization
?_Master_I2C_Initialization:	; 0 bytes @ 0x0
	global	??_Master_I2C_Initialization
??_Master_I2C_Initialization:	; 0 bytes @ 0x0
	global	?_main
?_main:	; 0 bytes @ 0x0
	global	Send_I2C_Data@Data
Send_I2C_Data@Data:	; 1 bytes @ 0x0
	ds	2
	global	Lcd_Command@cmd
Lcd_Command@cmd:	; 1 bytes @ 0x2
	global	Lcd_Data@Data
Lcd_Data@Data:	; 1 bytes @ 0x2
	ds	1
	global	??_Lcd_String
??_Lcd_String:	; 0 bytes @ 0x3
	global	??_Lcd_Intialization
??_Lcd_Intialization:	; 0 bytes @ 0x3
	ds	1
	global	Lcd_String@Str
Lcd_String@Str:	; 1 bytes @ 0x4
	ds	1
	global	??_main
??_main:	; 0 bytes @ 0x5
	ds	2
	global	main@u
main@u:	; 2 bytes @ 0x7
	ds	2
;;Data sizes: Strings 10, constant 0, data 7, bss 0, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14      9       9
;; BANK0           80      0       7
;; BANK1           80      0       0
;; BANK3           96      0       0
;; BANK2           96      0       0

;;
;; Pointer list with targets:

;; Lcd_String@Str	PTR const unsigned char  size(1) Largest target is 10
;;		 -> STR_1(CODE[10]), 
;;


;;
;; Critical Paths under _main in COMMON
;;
;;   _main->_Lcd_String
;;   _Lcd_Intialization->_Lcd_Command
;;   _Lcd_String->_Lcd_Data
;;
;; Critical Paths under _main in BANK0
;;
;;   None.
;;
;; Critical Paths under _main in BANK1
;;
;;   None.
;;
;; Critical Paths under _main in BANK3
;;
;;   None.
;;
;; Critical Paths under _main in BANK2
;;
;;   None.

;;
;;Main: autosize = 0, tempsize = 2, incstack = 0, save=0
;;

;;
;;Call Graph Tables:
;;
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (0) _main                                                 4     4      0     267
;;                                              5 COMMON     4     4      0
;;                  _Lcd_Intialization
;;          _Master_I2C_Initialization
;;                        _Lcd_Command
;;                         _Lcd_String
;;                              _Start
;;                      _Send_I2C_Data
;;                               _Stop
;; ---------------------------------------------------------------------------------
;; (1) _Lcd_Intialization                                    0     0      0      44
;;                        _Lcd_Command
;; ---------------------------------------------------------------------------------
;; (1) _Lcd_String                                           2     2      0      89
;;                                              3 COMMON     2     2      0
;;                           _Lcd_Data
;; ---------------------------------------------------------------------------------
;; (1) _Stop                                                 3     3      0       0
;;                                              0 COMMON     3     3      0
;; ---------------------------------------------------------------------------------
;; (1) _Start                                                3     3      0       0
;;                                              0 COMMON     3     3      0
;; ---------------------------------------------------------------------------------
;; (2) _Lcd_Data                                             3     3      0      44
;;                                              0 COMMON     3     3      0
;; ---------------------------------------------------------------------------------
;; (1) _Lcd_Command                                          3     3      0      44
;;                                              0 COMMON     3     3      0
;; ---------------------------------------------------------------------------------
;; (1) _Master_I2C_Initialization                            0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _Send_I2C_Data                                        1     1      0      22
;;                                              0 COMMON     1     1      0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 2
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   _Lcd_Intialization
;;     _Lcd_Command
;;   _Master_I2C_Initialization
;;   _Lcd_Command
;;   _Lcd_String
;;     _Lcd_Data
;;   _Start
;;   _Send_I2C_Data
;;   _Stop
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BANK3               60      0       0       9        0.0%
;;BITBANK3            60      0       0       8        0.0%
;;SFR3                 0      0       0       4        0.0%
;;BITSFR3              0      0       0       4        0.0%
;;BANK2               60      0       0      11        0.0%
;;BITBANK2            60      0       0      10        0.0%
;;SFR2                 0      0       0       5        0.0%
;;BITSFR2              0      0       0       5        0.0%
;;SFR1                 0      0       0       2        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;BANK1               50      0       0       7        0.0%
;;BITBANK1            50      0       0       6        0.0%
;;CODE                 0      0       0       0        0.0%
;;DATA                 0      0      12      12        0.0%
;;ABS                  0      0      10       3        0.0%
;;NULL                 0      0       0       0        0.0%
;;STACK                0      0       2       2        0.0%
;;BANK0               50      0       7       5        8.8%
;;BITBANK0            50      0       0       4        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR0              0      0       0       1        0.0%
;;COMMON               E      9       9       1       64.3%
;;BITCOMMON            E      0       0       0        0.0%
;;EEDATA             100      0       0       0        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 42 in file "E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\MASTER I2C.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  u               2    7[COMMON] int 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         2       0       0       0       0
;;      Temps:          2       0       0       0       0
;;      Totals:         4       0       0       0       0
;;Total ram usage:        4 bytes
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_Lcd_Intialization
;;		_Master_I2C_Initialization
;;		_Lcd_Command
;;		_Lcd_String
;;		_Start
;;		_Send_I2C_Data
;;		_Stop
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\MASTER I2C.c"
	line	42
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 6
; Regs used in _main: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	43
	
l2807:	
;MASTER I2C.c: 43: TRISD=0X00;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	clrf	(136)^080h	;volatile
	line	44
;MASTER I2C.c: 44: PORTD=0X00;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(8)	;volatile
	line	46
	
l2809:	
;MASTER I2C.c: 46: Lcd_Intialization();
	fcall	_Lcd_Intialization
	line	48
	
l2811:	
;MASTER I2C.c: 48: Master_I2C_Initialization();
	fcall	_Master_I2C_Initialization
	line	50
	
l2813:	
;MASTER I2C.c: 50: Lcd_Command(0x80);
	movlw	(080h)
	fcall	_Lcd_Command
	line	51
	
l2815:	
;MASTER I2C.c: 51: Lcd_String("LYCA SOFT");
	movlw	((STR_1-__stringbase))&0ffh
	fcall	_Lcd_String
	goto	l2817
	line	53
;MASTER I2C.c: 53: while(1)
	
l722:	
	line	55
	
l2817:	
;MASTER I2C.c: 54: {
;MASTER I2C.c: 55: Start();
	fcall	_Start
	line	56
	
l2819:	
;MASTER I2C.c: 56: Send_I2C_Data(0X24);
	movlw	(024h)
	fcall	_Send_I2C_Data
	line	58
	
l2821:	
;MASTER I2C.c: 58: if(ACKSTAT==0)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	btfsc	(1166/8)^080h,(1166)&7
	goto	u2371
	goto	u2370
u2371:
	goto	l723
u2370:
	line	60
	
l2823:	
;MASTER I2C.c: 59: {
;MASTER I2C.c: 60: for(int u=0;u<7;u++)
	clrf	(main@u)
	clrf	(main@u+1)
	
l2825:	
	movf	(main@u+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(07h))^80h
	subwf	btemp+1,w
	skipz
	goto	u2385
	movlw	low(07h)
	subwf	(main@u),w
u2385:

	skipc
	goto	u2381
	goto	u2380
u2381:
	goto	l2829
u2380:
	goto	l723
	
l2827:	
	goto	l723
	line	61
	
l724:	
	line	62
	
l2829:	
;MASTER I2C.c: 61: {
;MASTER I2C.c: 62: Send_I2C_Data(m[u]);
	movf	(main@u),w
	addlw	_m&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	fcall	_Send_I2C_Data
	line	63
	
l2831:	
;MASTER I2C.c: 63: SSPBUF=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(19)	;volatile
	line	64
	
l2833:	
;MASTER I2C.c: 64: _delay((unsigned long)((5)*(20e6/4000.0)));
	opt asmopt_off
movlw	33
movwf	((??_main+0)+0+1),f
	movlw	118
movwf	((??_main+0)+0),f
u2427:
	decfsz	((??_main+0)+0),f
	goto	u2427
	decfsz	((??_main+0)+0+1),f
	goto	u2427
	clrwdt
opt asmopt_on

	line	60
	
l2835:	
	movlw	low(01h)
	addwf	(main@u),f
	skipnc
	incf	(main@u+1),f
	movlw	high(01h)
	addwf	(main@u+1),f
	
l2837:	
	movf	(main@u+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(07h))^80h
	subwf	btemp+1,w
	skipz
	goto	u2395
	movlw	low(07h)
	subwf	(main@u),w
u2395:

	skipc
	goto	u2391
	goto	u2390
u2391:
	goto	l2829
u2390:
	goto	l723
	
l725:	
	line	66
	
l723:	
	line	68
;MASTER I2C.c: 65: }
;MASTER I2C.c: 66: }
;MASTER I2C.c: 68: if(ACKSTAT==0)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	btfsc	(1166/8)^080h,(1166)&7
	goto	u2401
	goto	u2400
u2401:
	goto	l2817
u2400:
	goto	l727
	line	70
	
l2839:	
;MASTER I2C.c: 69: {
;MASTER I2C.c: 70: while(SSPIF==0);
	goto	l727
	
l728:	
	
l727:	
	bcf	status, 5	;RP0=0, select bank0
	btfss	(99/8),(99)&7
	goto	u2411
	goto	u2410
u2411:
	goto	l727
u2410:
	
l729:	
	line	71
;MASTER I2C.c: 71: SSPIF=0;
	bcf	(99/8),(99)&7
	line	72
	
l2841:	
;MASTER I2C.c: 72: Stop();
	fcall	_Stop
	line	73
	
l2843:	
;MASTER I2C.c: 73: _delay((unsigned long)((5)*(20e6/4000.0)));
	opt asmopt_off
movlw	33
movwf	((??_main+0)+0+1),f
	movlw	118
movwf	((??_main+0)+0),f
u2437:
	decfsz	((??_main+0)+0),f
	goto	u2437
	decfsz	((??_main+0)+0+1),f
	goto	u2437
	clrwdt
opt asmopt_on

	goto	l2817
	line	74
	
l726:	
	goto	l2817
	line	75
	
l730:	
	line	53
	goto	l2817
	
l731:	
	line	76
	
l732:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,88
	global	_Lcd_Intialization
psect	text245,local,class=CODE,delta=2
global __ptext245
__ptext245:

;; *************** function _Lcd_Intialization *****************
;; Defined at:
;;		line 49 in file "E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\LCD 4 BIT.h"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_Lcd_Command
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text245
	file	"E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\LCD 4 BIT.h"
	line	49
	global	__size_of_Lcd_Intialization
	__size_of_Lcd_Intialization	equ	__end_of_Lcd_Intialization-_Lcd_Intialization
	
_Lcd_Intialization:	
	opt	stack 6
; Regs used in _Lcd_Intialization: [wreg+status,2+status,0+pclath+cstack]
	line	50
	
l2805:	
;LCD 4 BIT.h: 50: Lcd_Command(0x02);
	movlw	(02h)
	fcall	_Lcd_Command
	line	51
;LCD 4 BIT.h: 51: Lcd_Command(0x28);
	movlw	(028h)
	fcall	_Lcd_Command
	line	52
;LCD 4 BIT.h: 52: Lcd_Command(0x0c);
	movlw	(0Ch)
	fcall	_Lcd_Command
	line	53
	
l701:	
	return
	opt stack 0
GLOBAL	__end_of_Lcd_Intialization
	__end_of_Lcd_Intialization:
;; =============== function _Lcd_Intialization ends ============

	signat	_Lcd_Intialization,88
	global	_Lcd_String
psect	text246,local,class=CODE,delta=2
global __ptext246
__ptext246:

;; *************** function _Lcd_String *****************
;; Defined at:
;;		line 41 in file "E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\LCD 4 BIT.h"
;; Parameters:    Size  Location     Type
;;  Str             1    wreg     PTR const unsigned char 
;;		 -> STR_1(10), 
;; Auto vars:     Size  Location     Type
;;  Str             1    4[COMMON] PTR const unsigned char 
;;		 -> STR_1(10), 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         2       0       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_Lcd_Data
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text246
	file	"E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\LCD 4 BIT.h"
	line	41
	global	__size_of_Lcd_String
	__size_of_Lcd_String	equ	__end_of_Lcd_String-_Lcd_String
	
_Lcd_String:	
	opt	stack 6
; Regs used in _Lcd_String: [wreg-fsr0h+status,2+status,0+pclath+cstack]
;Lcd_String@Str stored from wreg
	movwf	(Lcd_String@Str)
	line	42
	
l2797:	
;LCD 4 BIT.h: 42: while(*Str != 0)
	goto	l2803
	
l696:	
	line	44
	
l2799:	
;LCD 4 BIT.h: 43: {
;LCD 4 BIT.h: 44: Lcd_Data(*Str++);
	movf	(Lcd_String@Str),w
	movwf	fsr0
	fcall	stringdir
	fcall	_Lcd_Data
	
l2801:	
	movlw	(01h)
	movwf	(??_Lcd_String+0)+0
	movf	(??_Lcd_String+0)+0,w
	addwf	(Lcd_String@Str),f
	goto	l2803
	line	45
	
l695:	
	line	42
	
l2803:	
	movf	(Lcd_String@Str),w
	movwf	fsr0
	fcall	stringdir
	iorlw	0
	skipz
	goto	u2361
	goto	u2360
u2361:
	goto	l2799
u2360:
	goto	l698
	
l697:	
	line	46
	
l698:	
	return
	opt stack 0
GLOBAL	__end_of_Lcd_String
	__end_of_Lcd_String:
;; =============== function _Lcd_String ends ============

	signat	_Lcd_String,4216
	global	_Stop
psect	text247,local,class=CODE,delta=2
global __ptext247
__ptext247:

;; *************** function _Stop *****************
;; Defined at:
;;		line 23 in file "E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\MASTER I2C.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          3       0       0       0       0
;;      Totals:         3       0       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text247
	file	"E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\MASTER I2C.c"
	line	23
	global	__size_of_Stop
	__size_of_Stop	equ	__end_of_Stop-_Stop
	
_Stop:	
	opt	stack 7
; Regs used in _Stop: [wreg]
	line	24
	
l2793:	
;MASTER I2C.c: 24: PEN = 1;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1162/8)^080h,(1162)&7
	line	25
;MASTER I2C.c: 25: while(SSPIF == 0);
	goto	l713
	
l714:	
	
l713:	
	bcf	status, 5	;RP0=0, select bank0
	btfss	(99/8),(99)&7
	goto	u2351
	goto	u2350
u2351:
	goto	l713
u2350:
	
l715:	
	line	26
;MASTER I2C.c: 26: SSPIF = 0;
	bcf	(99/8),(99)&7
	line	27
	
l2795:	
;MASTER I2C.c: 27: _delay((unsigned long)((100)*(20e6/4000.0)));
	opt asmopt_off
movlw  3
movwf	((??_Stop+0)+0+2),f
movlw	138
movwf	((??_Stop+0)+0+1),f
	movlw	86
movwf	((??_Stop+0)+0),f
u2447:
	decfsz	((??_Stop+0)+0),f
	goto	u2447
	decfsz	((??_Stop+0)+0+1),f
	goto	u2447
	decfsz	((??_Stop+0)+0+2),f
	goto	u2447
	nop2
opt asmopt_on

	line	28
	
l716:	
	return
	opt stack 0
GLOBAL	__end_of_Stop
	__end_of_Stop:
;; =============== function _Stop ends ============

	signat	_Stop,88
	global	_Start
psect	text248,local,class=CODE,delta=2
global __ptext248
__ptext248:

;; *************** function _Start *****************
;; Defined at:
;;		line 8 in file "E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\MASTER I2C.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          3       0       0       0       0
;;      Totals:         3       0       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text248
	file	"E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\MASTER I2C.c"
	line	8
	global	__size_of_Start
	__size_of_Start	equ	__end_of_Start-_Start
	
_Start:	
	opt	stack 7
; Regs used in _Start: [wreg]
	line	9
	
l2789:	
;MASTER I2C.c: 9: SEN = 1;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1160/8)^080h,(1160)&7
	line	10
;MASTER I2C.c: 10: SSPIF = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(99/8),(99)&7
	line	11
	
l2791:	
;MASTER I2C.c: 11: _delay((unsigned long)((100)*(20e6/4000.0)));
	opt asmopt_off
movlw  3
movwf	((??_Start+0)+0+2),f
movlw	138
movwf	((??_Start+0)+0+1),f
	movlw	86
movwf	((??_Start+0)+0),f
u2457:
	decfsz	((??_Start+0)+0),f
	goto	u2457
	decfsz	((??_Start+0)+0+1),f
	goto	u2457
	decfsz	((??_Start+0)+0+2),f
	goto	u2457
	nop2
opt asmopt_on

	line	12
	
l704:	
	return
	opt stack 0
GLOBAL	__end_of_Start
	__end_of_Start:
;; =============== function _Start ends ============

	signat	_Start,88
	global	_Lcd_Data
psect	text249,local,class=CODE,delta=2
global __ptext249
__ptext249:

;; *************** function _Lcd_Data *****************
;; Defined at:
;;		line 26 in file "E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\LCD 4 BIT.h"
;; Parameters:    Size  Location     Type
;;  Data            1    wreg     const unsigned char 
;; Auto vars:     Size  Location     Type
;;  Data            1    2[COMMON] const unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          2       0       0       0       0
;;      Totals:         3       0       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_Lcd_String
;; This function uses a non-reentrant model
;;
psect	text249
	file	"E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\LCD 4 BIT.h"
	line	26
	global	__size_of_Lcd_Data
	__size_of_Lcd_Data	equ	__end_of_Lcd_Data-_Lcd_Data
	
_Lcd_Data:	
	opt	stack 6
; Regs used in _Lcd_Data: [wreg+status,2+status,0]
;Lcd_Data@Data stored from wreg
	movwf	(Lcd_Data@Data)
	line	27
	
l2769:	
;LCD 4 BIT.h: 27: PORTD = (Data & 0XF0);
	movf	(Lcd_Data@Data),w
	andlw	0F0h
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(8)	;volatile
	line	28
	
l2771:	
;LCD 4 BIT.h: 28: RD2 = 1;
	bsf	(66/8),(66)&7
	line	29
	
l2773:	
;LCD 4 BIT.h: 29: RD3 = 1;
	bsf	(67/8),(67)&7
	line	30
	
l2775:	
;LCD 4 BIT.h: 30: _delay((unsigned long)((5)*(20e6/4000.0)));
	opt asmopt_off
movlw	33
movwf	((??_Lcd_Data+0)+0+1),f
	movlw	118
movwf	((??_Lcd_Data+0)+0),f
u2467:
	decfsz	((??_Lcd_Data+0)+0),f
	goto	u2467
	decfsz	((??_Lcd_Data+0)+0+1),f
	goto	u2467
	clrwdt
opt asmopt_on

	line	31
	
l2777:	
;LCD 4 BIT.h: 31: RD3 = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(67/8),(67)&7
	line	33
	
l2779:	
;LCD 4 BIT.h: 33: PORTD = ((Data<<4) & 0xF0);
	movf	(Lcd_Data@Data),w
	movwf	(??_Lcd_Data+0)+0
	movlw	(04h)-1
u2345:
	clrc
	rlf	(??_Lcd_Data+0)+0,f
	addlw	-1
	skipz
	goto	u2345
	clrc
	rlf	(??_Lcd_Data+0)+0,w
	andlw	0F0h
	movwf	(8)	;volatile
	line	34
	
l2781:	
;LCD 4 BIT.h: 34: RD2 = 1;
	bsf	(66/8),(66)&7
	line	35
	
l2783:	
;LCD 4 BIT.h: 35: RD3 = 1;
	bsf	(67/8),(67)&7
	line	36
	
l2785:	
;LCD 4 BIT.h: 36: _delay((unsigned long)((5)*(20e6/4000.0)));
	opt asmopt_off
movlw	33
movwf	((??_Lcd_Data+0)+0+1),f
	movlw	118
movwf	((??_Lcd_Data+0)+0),f
u2477:
	decfsz	((??_Lcd_Data+0)+0),f
	goto	u2477
	decfsz	((??_Lcd_Data+0)+0+1),f
	goto	u2477
	clrwdt
opt asmopt_on

	line	37
	
l2787:	
;LCD 4 BIT.h: 37: RD3 = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(67/8),(67)&7
	line	38
	
l692:	
	return
	opt stack 0
GLOBAL	__end_of_Lcd_Data
	__end_of_Lcd_Data:
;; =============== function _Lcd_Data ends ============

	signat	_Lcd_Data,4216
	global	_Lcd_Command
psect	text250,local,class=CODE,delta=2
global __ptext250
__ptext250:

;; *************** function _Lcd_Command *****************
;; Defined at:
;;		line 11 in file "E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\LCD 4 BIT.h"
;; Parameters:    Size  Location     Type
;;  cmd             1    wreg     const unsigned char 
;; Auto vars:     Size  Location     Type
;;  cmd             1    2[COMMON] const unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          2       0       0       0       0
;;      Totals:         3       0       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_Lcd_Intialization
;;		_main
;; This function uses a non-reentrant model
;;
psect	text250
	file	"E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\LCD 4 BIT.h"
	line	11
	global	__size_of_Lcd_Command
	__size_of_Lcd_Command	equ	__end_of_Lcd_Command-_Lcd_Command
	
_Lcd_Command:	
	opt	stack 7
; Regs used in _Lcd_Command: [wreg+status,2+status,0]
;Lcd_Command@cmd stored from wreg
	movwf	(Lcd_Command@cmd)
	line	12
	
l2749:	
;LCD 4 BIT.h: 12: PORTD = (cmd & 0XF0);
	movf	(Lcd_Command@cmd),w
	andlw	0F0h
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(8)	;volatile
	line	13
	
l2751:	
;LCD 4 BIT.h: 13: RD2 = 0;
	bcf	(66/8),(66)&7
	line	14
	
l2753:	
;LCD 4 BIT.h: 14: RD3 = 1;
	bsf	(67/8),(67)&7
	line	15
	
l2755:	
;LCD 4 BIT.h: 15: _delay((unsigned long)((5)*(20e6/4000.0)));
	opt asmopt_off
movlw	33
movwf	((??_Lcd_Command+0)+0+1),f
	movlw	118
movwf	((??_Lcd_Command+0)+0),f
u2487:
	decfsz	((??_Lcd_Command+0)+0),f
	goto	u2487
	decfsz	((??_Lcd_Command+0)+0+1),f
	goto	u2487
	clrwdt
opt asmopt_on

	line	16
	
l2757:	
;LCD 4 BIT.h: 16: RD3 = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(67/8),(67)&7
	line	18
	
l2759:	
;LCD 4 BIT.h: 18: PORTD = ((cmd<<4) & 0xF0);
	movf	(Lcd_Command@cmd),w
	movwf	(??_Lcd_Command+0)+0
	movlw	(04h)-1
u2335:
	clrc
	rlf	(??_Lcd_Command+0)+0,f
	addlw	-1
	skipz
	goto	u2335
	clrc
	rlf	(??_Lcd_Command+0)+0,w
	andlw	0F0h
	movwf	(8)	;volatile
	line	19
	
l2761:	
;LCD 4 BIT.h: 19: RD2 = 0;
	bcf	(66/8),(66)&7
	line	20
	
l2763:	
;LCD 4 BIT.h: 20: RD3 = 1;
	bsf	(67/8),(67)&7
	line	21
	
l2765:	
;LCD 4 BIT.h: 21: _delay((unsigned long)((5)*(20e6/4000.0)));
	opt asmopt_off
movlw	33
movwf	((??_Lcd_Command+0)+0+1),f
	movlw	118
movwf	((??_Lcd_Command+0)+0),f
u2497:
	decfsz	((??_Lcd_Command+0)+0),f
	goto	u2497
	decfsz	((??_Lcd_Command+0)+0+1),f
	goto	u2497
	clrwdt
opt asmopt_on

	line	22
	
l2767:	
;LCD 4 BIT.h: 22: RD3 = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(67/8),(67)&7
	line	23
	
l689:	
	return
	opt stack 0
GLOBAL	__end_of_Lcd_Command
	__end_of_Lcd_Command:
;; =============== function _Lcd_Command ends ============

	signat	_Lcd_Command,4216
	global	_Master_I2C_Initialization
psect	text251,local,class=CODE,delta=2
global __ptext251
__ptext251:

;; *************** function _Master_I2C_Initialization *****************
;; Defined at:
;;		line 31 in file "E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\MASTER I2C.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text251
	file	"E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\MASTER I2C.c"
	line	31
	global	__size_of_Master_I2C_Initialization
	__size_of_Master_I2C_Initialization	equ	__end_of_Master_I2C_Initialization-_Master_I2C_Initialization
	
_Master_I2C_Initialization:	
	opt	stack 7
; Regs used in _Master_I2C_Initialization: [wreg]
	line	32
	
l2745:	
;MASTER I2C.c: 32: TRISC3=1;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1083/8)^080h,(1083)&7
	line	33
;MASTER I2C.c: 33: TRISC4=1;
	bsf	(1084/8)^080h,(1084)&7
	line	35
	
l2747:	
;MASTER I2C.c: 35: SSPCON=0XA8;
	movlw	(0A8h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(20)	;volatile
	line	36
;MASTER I2C.c: 36: SSPCON2=0X80;
	movlw	(080h)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(145)^080h	;volatile
	line	37
;MASTER I2C.c: 37: SSPSTAT=0X84;
	movlw	(084h)
	movwf	(148)^080h	;volatile
	line	38
;MASTER I2C.c: 38: SSPADD=9;
	movlw	(09h)
	movwf	(147)^080h	;volatile
	line	39
	
l719:	
	return
	opt stack 0
GLOBAL	__end_of_Master_I2C_Initialization
	__end_of_Master_I2C_Initialization:
;; =============== function _Master_I2C_Initialization ends ============

	signat	_Master_I2C_Initialization,88
	global	_Send_I2C_Data
psect	text252,local,class=CODE,delta=2
global __ptext252
__ptext252:

;; *************** function _Send_I2C_Data *****************
;; Defined at:
;;		line 15 in file "E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\MASTER I2C.c"
;; Parameters:    Size  Location     Type
;;  Data            1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  Data            1    0[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         1       0       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text252
	file	"E:\02-CODING\05-LYCASOFT CODING\02-CODING\01-PIC16F877A\33-I2C\STRING SEND\MASTER\MASTER I2C.c"
	line	15
	global	__size_of_Send_I2C_Data
	__size_of_Send_I2C_Data	equ	__end_of_Send_I2C_Data-_Send_I2C_Data
	
_Send_I2C_Data:	
	opt	stack 7
; Regs used in _Send_I2C_Data: [wreg]
;Send_I2C_Data@Data stored from wreg
	movwf	(Send_I2C_Data@Data)
	line	16
	
l2741:	
;MASTER I2C.c: 16: SSPBUF == 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(19),w	;volatile
	line	17
;MASTER I2C.c: 17: while(SSPIF ==0);
	goto	l707
	
l708:	
	
l707:	
	btfss	(99/8),(99)&7
	goto	u2321
	goto	u2320
u2321:
	goto	l707
u2320:
	
l709:	
	line	18
;MASTER I2C.c: 18: SSPIF=0;
	bcf	(99/8),(99)&7
	line	19
	
l2743:	
;MASTER I2C.c: 19: SSPBUF = Data;
	movf	(Send_I2C_Data@Data),w
	movwf	(19)	;volatile
	line	20
	
l710:	
	return
	opt stack 0
GLOBAL	__end_of_Send_I2C_Data
	__end_of_Send_I2C_Data:
;; =============== function _Send_I2C_Data ends ============

	signat	_Send_I2C_Data,4216
psect	text253,local,class=CODE,delta=2
global __ptext253
__ptext253:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
