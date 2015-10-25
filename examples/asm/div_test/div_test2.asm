; ********* Sweet32 SoC - Software division routine test program
; ********* Author: Valentin Angelovski
; ********* Created: 11/11/2014
;
; This program prints a 16/16 unsigned division result to 
; the UART based on 16bit constants loaded into R2 and R3
;
; Note: This program uses a simple 2-level deep stack in the form of 
; CPU core registers R15 and R14


; Setup Division input values
	LDW 	R3,#0x8768 		; Dividend value
	LDW 	R2,#0x1234  	; Divisor value

; 
	LDD 	R10,#0x70000000  	; Point to UART address 
	LDB 	R13,#0x0F 	; Nibble mask flag
	LDB 	R12,#0x30 	; Nibble mask flag

	LDD 	R11,#0x0A 	; ASCII mask flag


	GETPC 	R14,#3			; Get current program counter
	MJMP  	Divide_U1616  	; Call 16/16 unsigned division

	LDB 	R5,#0x0D
	GETPC 	R15,#3				; Get current program counter
	MJMP  	ascii_charsend  ; Print CR char
	LDB 	R5,#0x0A
	GETPC 	R15, #3			; Get current program counter
	MJMP  	ascii_charsend  ; Print LF char

	GETPC	R14, #3		  	; Get current program counter
	MJMP  	hex2ascii_32bit ; Print Quotient

	LDB 	R5,#0x0D
	GETPC 	R15, #3			; Get current program counter
	MJMP  	ascii_charsend  ; Print CR char
	LDB 	R5,#0x0A
	GETPC 	R15, #3			; Get current program counter
	MJMP  	ascii_charsend  ; Print LF char

	INCS 	R0,R1,#0

	GETPC	R14, #3		  	; Get current program counter
	MJMP  hex2ascii_32bit 	; Print Remainder

program_halt:
	SJMP program_halt
; ************* Program ends (halts) here! ****************
	

;*** Sweet32 unsigned 16/16 division routine ***
; Registers R0-R7 are used by this routine (R7 being a temporary register)
; R0 = Remainder reg
; R1 = Quotient reg
; R2 = Divisor reg
; R3 = Dividend reg
; R4 = # of bits to divide by (set to 8, note must also set the initial divisor shifted value)
; R5 = quotient bitwise-OR mask value
; R6 = mask value for XOR-driven NOT
; R7 = Temp reg

Divide_U1616:
	LDD 	R5,#0x10000 	; Mask value for quotient bitwise OR-add

	LDB 	R4,#17    		; Number of bits to divide by + 1
	LDB 	R0,#0x0   		; Clear Quotient reg

; Actual division routine begins here:
	SWAPW 	R2,R2     	; Prepare Divisor (ie Divisor << 16)	

Division_loop:
	SUBSLT 	R7,R3,R2 	; compare (subtract) shifted divisor with dividend
	SJMP 	does_go  	; shifted dividend < divisor	
	LSR 	R2,R2 		; Shift the divisor down by 1
	LSR 	R5,R5 		; Shift the quotient bitmask down by 1
	INCS 	R4,R4,#-1 	; Decrement bit count
	TSTSNZ 	R4,R4 		; Have we reached the end of our divide routine?
	SJMP 	Division_done
	SJMP 	Division_loop

does_go:
    	MOV     R3,R7
	ADD 	R0,R0,R5    ; Set the appropriate bit of the quotient
	LSR 	R2,R2 		; Shift the divisor down by 1
	LSR 	R5,R5 		; Shift the quotient bitmask down by 1
	INCS 	R4,R4,#-1 	; Decrement bit count
	TSTSZ 	R4,R4 		; Have we reached the end of our divide routine?
	SJMP 	Division_loop

Division_done:
	MOV 	R1,R3	  	; Move to result reg

	LJMP R14			; exit routine
; ************* End routine ****************
	
	
; ********* 32bit HEX value to ASCII routine ********
hex2ascii_32bit:
	SWAPW 	R3,R0
	SWAPB 	R5,R3
	LSR 	R5,R5
	LSR 	R5,R5
	LSR 	R5,R5
	LSR 	R5,R5
	AND 	R5,R5,R13
	ADD  	R5,R5,R12
	GETPC	R15,#3		; Get current program counter
	MJMP  	character_send

	SWAPB 	R5,R3
	AND 	R5,R5,R13
	ADD  	R5,R5,R12
	GETPC	R15,#3		; Get current program counter
	MJMP  	character_send

	INCS 	R5,R3,#0
	LSR 	R5,R5
	LSR 	R5,R5
	LSR 	R5,R5
	LSR 	R5,R5
	AND 	R5,R5,R13
	ADD  	R5,R5,R12
	GETPC	R15,#3		; Get current program counter
	MJMP  	character_send

	INCS 	R5,R3,#0
	AND 	R5,R5,R13
	ADD  	R5,R5,R12
	GETPC	R15, #3		; Get current program counter
	MJMP  	character_send


	SWAPB 	R5,R0
	LSR 	R5,R5
	LSR 	R5,R5
	LSR 	R5,R5
	LSR 	R5,R5
	AND 	R5,R5,R13
	ADD  	R5,R5,R12
	GETPC	R15, #3		; Get current program counter
	MJMP  	character_send

	SWAPB 	R5,R0
	AND 	R5,R5,R13
	ADD  	R5,R5,R12
	GETPC	R15, #3		; Get current program counter
	MJMP  	character_send

	INCS 	R5,R0,#0
	LSR 	R5,R5
	LSR 	R5,R5
	LSR 	R5,R5
	LSR 	R5,R5
	AND 	R5,R5,R13
	ADD  	R5,R5,R12
	GETPC	R15, #3		; Get current program counter
	MJMP  	character_send

	INCS 	R5,R0,#0
	AND 	R5,R5,R13
	ADD  	R5,R5,R12
	GETPC	R15, #3		; Get current program counter
	MJMP  	character_send

	LJMP    R14		; exit routine
; ************* End routine ****************


; **** UART numeric-hex ASCII character send routine ****
character_send:
	MOVW  	R8,@R10		; Read UART flags + data
	BITSNZ 	R8,#8		; Test TX_READY flag
	SJMP	character_send	; Continue to poll UART if TX not ready 

    AND     R6,R5,R13 
    SUBSLT  R6,R6,R11  
    INCS    R5,R5,#7
	MOVW 	@R10,R5		; Echo UART character out
    LJMP    R15
; ************* End routine ****************


; **** UART raw ASCII character send routine ****
ascii_charsend:
	MOVW  	R8,@R10			; Read UART flags + data
	BITSNZ 	R8,#8			; Test TX_READY flag
	SJMP 	ascii_charsend	; Continue to poll UART if TX not ready 

	MOVW 	@R10,R5			; Echo UART character out
    LJMP    R15
; ************* End routine ****************

$END

