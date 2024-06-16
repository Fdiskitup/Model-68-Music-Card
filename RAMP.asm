		title	"RAMP"
;		list
;=====================================================
;
; RAMP PROGRAM FOR THE MODEL 68 MUSIC BOARD TEST ROUTINE
; THIS ROUTINE PRODUCES A TRIANGULAR RAMP OF 319 HZ 
; ON A 6800 COMPUTER SYSTEM RUNNING AT 0.89855 MHZ 
; (FREQUENCY IS DEPENDING ON SYSTEM CLOCK) 
;
; Modified by MATT SPENCE, SPENCEMA@HOTMAIL.COM in
; JUNE 2024 to learn how the assembler works.
; Also made it compatible with the AS09
; assembler.
;
; Memory map note:
; THIS PROGRAM CAN BE PLACED ANYWHERE
; THE I/O SLOT ADDRESS WILLDEPEND ON YOUR SYSTEM 8010 = SLOT 4 IN 6800
; E060 = SLOT 6 IN 6809, ETC
; hex code 4C B7 E060 20 FA 
; The program has no commands and will run an infinite loop
; exit using Reset or Int
	
mod68		equ	$e060		;define the port address of the card 
		org	$0100		;define the start address of the code 
ramp		inca			;2-calculate next step
		sta	mod68		;5-output to music board
		bra	ramp		;4-loop
		end 

