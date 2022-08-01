;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; SMW Swinging Platform (sprite 5F), by imamelia
;;
;; This is a disassembly of sprite 5F in SMW, the swinging platform.  (Yes, there
;; are almost no comments...I couldn't really make head or tail out of most of the
;; code, and if anyone else would like to, that would be great.)
;;
;; Uses first extra bit: NO
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; defines and tables
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Data1:
db $E0,$F0,$00,$10

Data2:
db $01,$FF

Data3:
db $40,$C0

PlatformTiles:
db $60,$61,$61,$62

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; init routine
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print "INIT ",pc

LDA #$80		;
STA !151C,x	; low byte of the platform angle = 80 (but I thought $1602,x was the low byte...?)
LDA #$01		;
STA !1528,x	; high byte of the platform angle = 01

LDA !E4,x	;
CLC		;
ADC #$78	;
STA !E4,x		; offset the sprite 78 pixels to the right (why?...)
LDA !14E0,x	;
ADC #$00	;
STA !14E0,x	;
LDA !D8,x	;
CLC		;
ADC #$68	;
STA !D8,x	; and offset the sprite 68 pixels down
LDA !14D4,x	;
ADC #$00	;
STA !14D4,x	;

RTL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; main routine wrapper
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print "MAIN ",pc
PHB
PHK
PLB
JSR SwingingPlatformMain
PLB
RTL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; main routine
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SwingingPlatformMain:

LDA #$02
%SubOffScreen()

LDA $9D		;
BNE Skip1		;

LDA $13		;
AND #$03	;
ORA !1602,x	;
BNE Skip1		;

LDA #$01		;
LDY !1504,x	;
BEQ Skip1		;
BMI Inc1504	;
LDA #$FF		;
Inc1504:		;
CLC		;
ADC !1504,x	;
STA !1504,x	;

Skip1:

LDA !151C,x	;
PHA		;
LDA !1528,x	;
PHA		;
LDA #$00		;
SEC		;
SBC !151C,x	;
STA !151C,x	;
LDA #$02		;
SBC !1528,x	;
AND #$01	;
STA !1528,x	;

JSR Sub1		;
JSR Sub2		;
JSR Sub3		;

PLA		;
STA !1528,x	;
PLA		;
STA !151C,x	;

LDA $14B8|!Base2
PHA		;
SEC		;
SBC !C2,x	;
STA $1491|!Base2	;
PLA		;
STA !C2,x	;

LDY !15EA,x	;
LDA $14BA|!Base2	;
SEC		;
SBC $1C		;
SEC		;
SBC #$08		;
STA $0301|!Base2,y	;
LDA $14B8|!Base2	;
SEC		;
SBC $1A		;
SEC		;
SBC #$08		;
STA $0300|!Base2,y	;
LDA #$A2		;
STA $0302|!Base2,y	;
LDA #$31		;
STA $0303|!Base2,y	;
LDY #$00		;
LDA $14BA|!Base2	;
SEC		;
SBC $14B2|!Base2	;
BPL NoInvert1	;
EOR #$FF		;
INC		;
INY		;
NoInvert1:	;
STY $00		;
if !SA1
STA $2252	;
STZ $2251	;
LDA #$01
STA $2250
LDA #$05		;
STA $2253	;
STZ $2254
NOP
BRA $00
LDA $2306	;
STA $02		;
STA $06		;
LDA $2307	;
else
STA $4205	;
STZ $4204	;
LDA #$05		;
STA $4206	;
JSR DoNothing	;
LDA $4214	;
STA $02		;
STA $06		;
LDA $4215	;
endif
STA $03		;
STA $07		;
LDY #$00		;
LDA $14B8|!Base2	;
SEC		;
SBC $14B0|!Base2	;
BPL NoInvert2	;
EOR #$FF		;
INC		;
INY		;
NoInvert2:	;
STY $01		;
if !SA1
STA $2252	;
STZ $2251	;
LDA #$01
STA $2250
LDA #$05		;
STA $2253	;
STZ $2254
NOP
BRA $00
LDA $2306	;
STA $04		;
STA $08		;
LDA $2307	;
else
STA $4205	;
STZ $4204	;
LDA #$05		;
STA $4206	;
JSR DoNothing	;
LDA $4214	;
STA $04		;
STA $08		;
LDA $4215	;
endif
STA $05		;
STA $09		;
LDY !15EA,x	;
INY #4		;
LDA $14B2|!Base2	;
SEC		;
SBC $1C		;
SEC		;
SBC #$08		;
STA $0A		;
STA $0301|!Base2,y	;
LDA $14B0|!Base2	;
SEC		;
SBC $1A		;
SEC		;
SBC #$08		;
STA $0B		;
STA $0300|!Base2,y	;
LDA #$A2		;
STA $0302|!Base2,y	;
LDA #$31		;
STA $0303|!Base2,y	;

LDX #$03		;
Loop1:		;
INY #4		;
LDA $00		;
BNE Subtract1	;
LDA $0A		;
CLC		;
ADC $07		;
STA $0301|!Base2,y	;
BRA Continue1	;
Subtract1:	;
LDA $0A		;
SEC		;
SBC $07		;
STA $0301|!Base2,y	;
Continue1:
LDA $06		;
CLC		;
ADC $02		;
STA $06		;
LDA $07		;
ADC $03		;
STA $07		;
LDA $01		;
BNE Subtract2	;
LDA $0B		;
CLC		;
ADC $09		;
STA $0300|!Base2,y	;
BRA Continue2	;
Subtract2:	;
LDA $0B		;
SEC		;
SBC $09		;
STA $0300|!Base2,y	;
Continue2:	;
LDA $08		;
CLC		;
ADC $04		;
STA $08		;
LDA $09		;
ADC $05		;
STA $09		;
LDA #$A2		;
STA $0302|!Base2,y	;
LDA #$31		;
STA $0303|!Base2,y	;
DEX		;
BPL Loop1	;

LDX #$03		;
Loop2:		;
STX $02		;
INY #4		;
LDA $14BA|!Base2	;
SEC		;
SBC $1C		;
SEC		;
SBC #$10		;
STA $0301|!Base2,y	;
LDA $14B8|!Base2	;
SEC		;
SBC $1A		;
CLC		;
ADC Data1,x	;
STA $0300|!Base2,y	;
LDA PlatformTiles,x	;
STA $0302|!Base2,y	;
LDA #$31		;
STA $0303|!Base2,y	;
DEX		;
BPL Loop2	;

LDX $15E9|!Base2	;
LDA #$09		;
STA $08		;
LDA $14B2|!Base2	;
SEC		;
SBC #$08		;
STA $00		;
LDA $14B3|!Base2	;
SBC #$00		;
STA $01		;
LDA $14B0|!Base2	;
SEC		;
SBC #$08		;
STA $02		;
LDA $14B1|!Base2	;
SBC #$00		;
STA $03		;
LDY !15EA,x	;
LDA $0305|!Base2,y	;
STA $06		;
LDA $0304|!Base2,y	;
STA $07		;

Loop3:		;

TYA		;
LSR #2		;
TAX		;
LDA #$02		;
STA $0460|!Base2,x	;
LDX #$00		;
LDA $0300|!Base2,y	;
SEC		;
SBC $07		;
BPL NoDex1	;
DEX		;
NoDex1:		;
CLC		;
ADC $02		;
STA $04		;
TXA		;
ADC $03		;
STA $05		;
JSR Sub5		;
BCC NotOffscreen1	;
TYA		;
LSR #2		;
TAX		;
LDA #$03		;
STA $0460|!Base2,x	;
NotOffscreen1:	;
LDX #$00		;
LDA $0301|!Base2,y	;
SEC		;
SBC $06		;
BPL NoDex2	;
DEX		;
NoDex2:		;
CLC		;
ADC $00		;
STA $09		;
TXA		;
ADC $01		;
STA $0A		;
JSR Sub6		;
BCC NotOffscreen2	;
LDA #$F0		;
STA $0301|!Base2,y	;
NotOffscreen2:	;
LDA $08		;
CMP #$09		;
BNE SkipStore1	;
LDA $04		;
STA $14B8|!Base2	;
LDA $05		;
STA $14B9|!Base2	;
LDA $09		;
STA $14BA|!Base2	;
LDA $0A		;
STA $14BB|!Base2	;
SkipStore1:	;
INY #4		;
DEC $08		;
BPL Loop3	;

LDX $15E9|!Base2	;
LDY !15EA,x	;
LDA #$F0		;
STA $0305|!Base2,y	;
LDA $9D		;
BNE Return00	;

JSR Sub7		;
BRA Continue3	;

Return00:		;
RTS

Label00:		;

LDA !160E,x	;
BEQ Return00	;
STZ !160E,x	;
Label01:		;
PHX		;
JSL $00E2BD	;
PLX		;
STX $15E9|!Base2	;
RTS

Continue3:	;

LDA $14B9|!Base2	;
XBA		;
LDA $14B8|!Base2	;
REP #$20		;
SEC		;
SBC $1A		;
CLC		;
ADC.w #$0010	;
CMP #$0120	;
SEP #$20		;
ROL		;
AND #$01	;
STA !15C4,x	;
BNE Return00	;

JSR Interact	; set up clipping values to interact with the player
STZ !1602,x	;
BCC Label00	;

LDA #$01		;
STA !160E,x	;
LDA $14BA|!Base2	;
SEC		;
SBC $1C		;
STA $03		;
SEC		;
SBC #$08		;
STA $0E		;
LDA $80		;
CLC		;
ADC #$18	;
CMP $0E		;
BCS Return00	;
LDA $7D		;
BMI Label01	;
STZ $7D		;
LDA #$03		;
STA $1471|!Base2	;
STA !1602,x	;
LDA #$28		;
LDY $187A|!Base2	;
BEQ Store1	;
LDA #$38		;
Store1:		;
STA $0F		;
LDA $14BA|!Base2	;
SEC		;
SBC $0F		;
STA $96		;
LDA $14BB|!Base2	;
SBC #$00		;
STA $97		;
LDA $77		;
AND #$03	;
BNE Skip2		;
LDY #$00		;
LDA $1491|!Base2	;
BPL NoDey1	;
DEY		;
NoDey1:		;
CLC		;
ADC $94		;
STA $94		;
TYA		;
ADC $95		;
STA $95		;
Skip2:		;
JSR Label01	;
LDA $16		;
BMI NoHide	;
LDA #$FF		;
STA $78		;
NoHide:		;
LDA $13		;
LSR		;
BCC Return01	;
LDA !151C,x	;
CLC		;
ADC #$80	;
LDA !1528,x	;
ADC #$00	;
AND #$01	;
TAY		;
LDA !1504,x	;
CMP Data3,y	;
BEQ Return01	;
CLC		;
ADC Data2,y	;
STA !1504,x	;

Return01:		;
RTS		;

Sub1:

LDA #$50		;
STA $14BC|!Base2	;
STZ $14BF|!Base2	;
STZ $14BD|!Base2	;
STZ $14C0|!Base2	;
LDA !E4,x	;
STA $14B4|!Base2	;
LDA !14E0,x	;
STA $14B5|!Base2	;
LDA $14B4|!Base2	;
SEC		;
SBC $14BC|!Base2	;
STA $14B0|!Base2	;
LDA $14B5|!Base2	;
SBC $14BD|!Base2	;
STA $14B1|!Base2	;
LDA !D8,x	;
STA $14B6|!Base2	;
LDA !14D4,x	;
STA $14B7|!Base2	;
LDA $14B6|!Base2	;
SEC		;
SBC $14BF|!Base2	;
STA $14B2|!Base2	;
LDA $14B7|!Base2	;
SBC $14C0|!Base2	;
STA $14B3|!Base2	;
LDA !151C,x	;
STA $36		;
LDA !1528,x	;
STA $37		;
RTS

Sub2:

LDA $37		;
STA $1866|!Base2	;
PHX		;
REP #$30		;
LDA $36		;
ASL		;
AND #$01FF	;
TAX		;
LDA $07F7DB,x	;
STA $14C2|!Base2	;
LDA $36		;
CLC		;
ADC #$0080	;
STA $00		;
ASL		;
AND #$01FF	;
TAX		;
LDA $07F7DB,x	;
STA $14C5|!Base2	;
SEP #$30		;
LDA $01		;
STA $1867|!Base2	;
PLX		;
RTS		;

Sub3:

REP #$20		;
LDA $14C5|!Base2	;
STA $02		;
LDA $14BC|!Base2	;
STA $00		;
SEP #$20		;
JSR Sub4		;
LDA $1867|!Base2	;
LSR		;
REP #$20		;
LDA $04		;
BCC NoInvert3	;
EOR #$FFFF	;
INC		;
NoInvert3:	;
STA $08		;
LDA $06		;
BCC NoInvert4	;
EOR #$FFFF	;
INC		;
NoInvert4:	;
STA $0A		;
LDA $14C2|!Base2	;
STA $02		;
LDA $14BF|!Base2	;
STA $00		;
SEP #$20		;
JSR Sub4		;
LDA $1866|!Base2	;
LSR		;
REP #$20		;
LDA $04		;
BCC NoInvert5	;
EOR #$FFFF	;
INC		;
NoInvert5:	;
STA $04		;
LDA $06		;
BCC NoInvert6	;
EOR #$FFFF	;
INC		;
NoInvert6:	;
STA $06		;
LDA $04		;
CLC		;
ADC $08		;
STA $04		;
LDA $06		;
ADC $0A		;
STA $06		;
LDA $05		;
CLC		;
ADC $14B0|!Base2	;
STA $14B8|!Base2	;
LDA $14C5|!Base2	;
STA $02		;
LDA $14BF|!Base2	;
STA $00		;
SEP #$20		;
JSR Sub4		;
LDA $1867|!Base2	;
LSR		;
REP #$20		;
LDA $04		;
BCC NoInvert7	;
EOR #$FFFF	;
INC		;
NoInvert7:	;
STA $08		;
LDA $06		;
BCC NoInvert8	;
EOR #$FFFF	;
INC		;
NoInvert8:	;
STA $0A		;
LDA $14C2|!Base2	;
STA $02		;
LDA $14BC|!Base2	;
STA $00		;
SEP #$20		;
JSR Sub4		;
LDA $1866|!Base2	;
LSR		;
REP #$20		;
LDA $04		;
BCC NoInvert9	;
EOR #$FFFF	;
INC		;
NoInvert9:	;
STA $04		;
LDA $06		;
BCC NoInvert10	;
EOR #$FFFF	;
INC		;
NoInvert10:	;
STA $06		;
LDA $04		;
SEC		;
SBC $08		;
STA $04		;
LDA $06		;
SBC $0A		;
STA $06		;
LDA $14B2|!Base2	;
SEC		;
SBC $05		;
STA $14BA|!Base2	;
SEP #$20		;
RTS

Sub4:
if !SA1
STZ $2250
LDA $00		;
STA $2251	;
STZ $2252
LDA $02		;
STA $2253	;
STZ $2254
NOP
BRA $00
LDA $2306	;
STA $04		;
LDA $2307	;
else
LDA $00		;
STA $4202	;
LDA $02		;
STA $4203	;
JSR DoNothing	;
LDA $4216	;
STA $04		;
LDA $4217	;
endif
STA $05		;
if !SA1
STZ $2250
LDA $00		;
STA $2251	;
STZ $2252
LDA $03		;
STA $2253	;
STZ $2254
NOP
BRA $00
LDA $2306	;
CLC		;
ADC $05		;
STA $05		;
LDA $2307	;
else
LDA $00		;
STA $4202	;
LDA $03		;
STA $4203	;
JSR DoNothing	;
LDA $4216	;
CLC		;
ADC $05		;
STA $05		;
LDA $4217	;
endif
ADC #$00	;
STA $06		;
if !SA1
STZ $2250
LDA $01		;
STA $2251	;
STZ $2252
LDA $02		;
STA $2253	;
STZ $2254
NOP
BRA $00
LDA $2306	;
CLC		;
ADC $05		;
STA $05		;
LDA $2307	;
else
LDA $01		;
STA $4202	;
LDA $02		;
STA $4203	;
JSR DoNothing	;
LDA $4216	;
CLC		;
ADC $05		;
STA $05		;
LDA $4217	;
endif
ADC $06		;
STA $06		;
if !SA1
STZ $2250
LDA $01		;
STA $2251	;
STZ $2252
LDA $03		;
STA $2253	;
STZ $2254
NOP
BRA $00
LDA $2306	;
CLC		;
ADC $06		;
STA $06		;
LDA $2307	;
else
LDA $01		;
STA $4202	;
LDA $03		;
STA $4203	;
JSR DoNothing	;
LDA $4216	;
CLC		;
ADC $06		;
STA $06		;
LDA $4217	;
endif
ADC #$00	;
STA $07		;
RTS		;

Sub5:

REP #$20		;
LDA $04		;
SEC		;
SBC $1A		;
CMP #$0100	;
SEP #$20		;
RTS		;

Sub6:

REP #$20		;
LDA $09		;
PHA		;
CLC		;
ADC.w #$0010	;
STA $09		;
SEC		;
SBC $1C		;
CMP #$0100	;
PLA		;
STA $09		;
SEP #$20		;
RTS		;

Sub7:		;

LDA !1504,x	;
ASL #4		;
CLC		;
ADC !1510,x	;
STA !1510,x	;
PHP		;
LDY #$00		;
LDA !1504,x	;
LSR #4		;
CMP #$08		;
BCC Label02	;
ORA #$F0		;
DEY		;
Label02:		;
PLP		;
ADC !151C,x	;
STA !151C,x	;
TYA		;
ADC !1528,x	;
STA !1528,x	;
RTS

DoNothing:
NOP #8		; do absolutely nothing; just wait for the arithmetic registers to do their work
RTS		;

Interact:		;

LDA $14B8|!Base2	;
SEC		;
SBC #$18		;
STA $04		;
LDA $14B9|!Base2	;
SBC #$00		;
STA $0A		;
LDA #$40		;
STA $06		;
LDA $14BA|!Base2	;
SEC		;
SBC #$0C		;
STA $05		;
LDA $14BB|!Base2	;
SBC #$00		;
STA $0B		;
LDA #$13		;
STA $07		;
JSL $03B664	;
JSL $03B72B	;
RTS		;
