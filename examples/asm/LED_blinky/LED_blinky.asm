; ------------------------------------------------------------------------
	GETPC	R14, #0		; Get current program counter
	LDD	R15,$blink_led	; Load our desired IRQ handler address
	ADD	R15,R15,R14	    ; Base + offset
	SETIV 	R15           ; Set our IRQ handler address

; *** Setup Timer0
; ****************
	LDD 	R4,#0x70000020  ; Point to Timer0 reload reg
	LDW 	R5,#0x7000      ;
	MOVW 	@R4,R5         	; Set new Timer0 reload value

	LDD 	R4,#0x70000022  ; Point to Timer0 control reg
	LDB 	R5,#0x01        ;
	MOVW 	@R4,R5         	; reset Timer0 overflow flag, start Timer0

; *** Enable our IRQ
; ------------------
	LDB R0, #0x01 	        ; Enable our IRQ 
	SETCW  R0           	;

; *** Main program loop (UART echo) begins here!
; ----------------------------------------------

	LDD 	R4,#0x70000000  ; Point to UART address 
	LDD 	R6,#0x70000002  ; Point to UART control address 
	LDD 	R5,#0x00000200  ; Data mask for UART RX_READY flag
	LDD 	R3,#0x00000100  ; Data mask for UART TX_READY flag
	LDB 	R10,#0x00       ; Clear temp reg

test_uart:
	MOVW  	R2,@R4        	; Read data and flags from UART 
	TSTSNZ 	R5,R2        	; Test RX_READY flag
	SJMP 	test_uart 	; Continue to poll UART if no char received

	MOVW  	@R6,R6        	; Reset UART RX flag 


test_uart2:
	MOVW  	R2,@R4        	; Read UART flags + data
	TSTSNZ 	R3,R2        	; Test TX_READY flag
	SJMP 	test_uart2      ; Continue to poll UART if TX not ready 

	MOVW 	@R4,R2         	; Echo UART character out

	SJMP 	test_uart  	; Go back and wait for another char..


; *** IRQ Interrupt handler for Timer0 (Sends incremented nibble of data to user LEDs)
; ------------------------------------------------------------------------------------
blink_led:
	LDD 	R0,#0x70000022  ; Point to Timer0 overflow event reg
	LDW 	R1,#0x0001      ;
	MOVW 	@R0,R1         	; reset Timer0 overflow flag, keep Timer0 running

	LDD 	R0,#0x70000082  ; Point to GPIO port direction mode
	LDW 	R1,#0xFFFF      ;
	MOVW 	@R0,R1         	; set GPIO port pins for output

	LDD 	R1,#0x70000030  ; Point to user output port
	INCS  	R10, R10, #1  	; Increment LED counter


	SWAPB 	R11,R10       	; grab our 2nd byte count to send to LEDs..
	MOVW  	@R1,R11       	; Update user LEDs on output port

	LDD 	R1,#0x70000080  ; Point to GPIO bidirectional port..
	MOVW  	@R1,R11       	; ..copy LED data there as well

	RETI                	; Exit our interrupt handler

$END

