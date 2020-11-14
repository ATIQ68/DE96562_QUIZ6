 
			#include<p18F4550.inc>

lp_cnt1 set 0x10
lp_cnt2 set 0x11

			org 0x00
			goto start
			org 0x08
			retfie
			org 0x18
			retfie
;************************************************************
dup_nop 	macro kk ;macro function will execute duplication
				 	 ;dup_nop it means duplicate no operation
			variable i ;kk times
i=0
			while i < kk
			nop
i+=1
			endw
			endm

;;***********************************************
; HOW TO CREATE A DELAY OF 65 mili sec
; with a crystal of 20MHz
;************************************************'
; subroutine for delay 65mili sec
;*************************************************

delay65msec 	movlw D'100' 
				movwf lp_cnt1,A
again1 			movlw D'100'
				movwf lp_cnt2,A
again2 			dup_nop D'28' ;29 instruction cycle
				decfsz lp_cnt2, F,A ;1 instruction cycle
				bra again2 ;2 instruction cyle
				decfsz lp_cnt1, F, A ;total 31 instruction cycle
				bra again1
				return

;; (100 x 100 x (28+1+2) = 310 000 i.c
;****************************************************
start 	call delay65msec
		end
