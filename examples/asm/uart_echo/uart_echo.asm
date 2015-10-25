
; ********* Sweet32 SoC - UART echo example
; ********* Author: Valentin Angelovski
; ********* Created: 25/08/2014
;
; This program sends TWO characters echoed for every character received
; via Sweet32's UART. Sourcecode provided 'as-is'. Use at your own risk!

LDD R1,#0x70000000  ; Point to UART address 
LDD R6,#0x70000002  ; Point to UART control address 
LDD R0,#0x00000200  ; Data mask for UART RX_READY flag
LDD R3,#0x00000100  ; Data mask for UART TX_READY flag

test_uart:
MOVW  R2,@R1        ; Read data and flags from UART 

TSTSNZ R0,R2        ; Test RX_READY flag
SJMP test_uart      ; Continue to poll UART if no char received

MOVW  @R6,R6        ; Reset UART RX flag 


test_uart2:
MOVW  R2,@R1        ; Read UART flags + data
TSTSNZ R3,R2        ; Test TX_READY flag
SJMP test_uart2     ; Continue to poll UART if TX not ready 

MOVW @R1,R2         ; Echo UART character out

test_uart3:
MOVW  R2,@R1        ; Read UART flags + data
TSTSNZ R3,R2        ; Test TX_READY flag
SJMP test_uart3     ; Continue to poll UART if TX not ready 

MOVW @R1,R2         ; Echo UART character out

SJMP test_uart      ; Go back and wait for another char..

$END


