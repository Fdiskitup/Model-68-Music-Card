		title	"PHASOR"
;		list
;=====================================================
;
; PHASOR PROGRAM FOR THE MODEL 68 MUSIC BOARD TEST ROUTINE
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
;	
		org	$0100		;define the start address of the code 
start		lda	sweepn		;initiate sweep count
		sta	sweeps		;
nexts		lda	#0		;exit if sweeps count = 0
		cmpa	sweeps		;else decrement count & 
		beq	exit		;do one sweep.
		dec	sweeps
		lda	firstf		;init.freq.parameter.
		sta	freq
		lda	rate		;get sweep rate parameter.
loop3		deca			;decrement a
		bne	loop1		;if N.E.0 branch
		inc	freq		;else decrease freq.
		lda	lastf		;if lowest frequency
		cmpa	freq		;then sweep is done so
		beq	nexts		;go to next sweep.
		lda	rate		;else restore rate param.
		bra	loop2	
loop1		com	,x		;waste time
		com 	,x		;waste time
		nop
loop2		ldb	freq		;half-wave timeout
loop4		decb
		bne	loop4
		com	toggle		;output complement to 	
		ldb	toggle		;music board. 
		stb	mod68
		bra	loop3
exit		jmp	mikbug		;monitor entry point
mod68		equ	$E060		;music board address
sweepn		fcb	$0d		;desired number of sweeps
sweeps		rmb	1		;temporary sweep count
firstf		fcb	$01		;starting sweep param.
lastf		fcb	$ff		;ending sweep param.
freq		rmb	1		;temporary freq.param. 
rate		fcb	$01		;sweep rate parameter. TRY 04
toggle		fcb	0
mikbug		equ	$f800		;monitor entry point
		nop
		end
