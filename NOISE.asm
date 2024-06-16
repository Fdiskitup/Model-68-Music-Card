		title	"NOISE"
;		list
;=====================================================
;
; NOISE PROGRAM FOR THE MODEL 68 MUSIC BOARD TEST ROUTINE
; THIS ROUTINE PRODUCES WHITE NOISE
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
		org	$0100		;define the start address of the code 
		ldu	#tbl		;init envelope pointer
		stx	tblp		;
loop2		lda	#$02		;if envelope is
		ldu	tblp		;complete return.
		cmpa	,x
		beq	exit
		ldu	tblp		;else inc. env. pointer
		leax	1,x		;syntax error ***** inx 6800
		stu	tblp
		lda	dura		;output n random values
		sta	durat
loop1		lda	freq		;delay according to 
loop3		deca			;frequency parameter
		bne	loop3
		bsr	rndm		;get random number in a.
		ldx	tblp		;scale amplitudeaccording
		anda	,x		;to env table. 
		sta	mod68		;output to music board.
		dec	durat	
		bne	loop1
		bra	loop2		;process next amplitude.
exit		jmp	mikbug		;your exit may differ!
;					random number generator. 
;					generates 16 bit 
;					value in "NMBER". returns most significant 
;					byte in a.
rndm		lda	msb		;exclusive-or shift
		rora			;register bits 15,14,12,3
		eora	msb		;15 & 14
		rora
		rora
		eora	msb		;12
		rora
		eora	lsb		;3
		rora
		rora
		anda	#$01		;mask bit 0.
		asl	lsb		;shift nmber left.
		rol	msb		;setting bit 0 according
		adda	lsb		;to exclusive-or calc. 
		sta	lsb		;
		rts
;	* amplitude envelope specification:
tbl		fcb	$ff,$ff,$ff,$7f,$7f,$3F
		fcb	$3f,$1f,$0f,$07,$02
;       *
freq		fcb	$30		;noise band parameter
dura		fcb	$ff		;duration parameter
nmber		fcb	$01		;shift register******mod
mod68		equ	$E060		;define the port address of the card 
mikbug		equ	$F800		;monitor re-entry
tblp		rmb	2		;envelope table pointer
durat		rmb	1		;temporary duration count
msb		equ	nmber		;random number routine
lsb		equ 	nmber+1		;"
		nop
		end 

