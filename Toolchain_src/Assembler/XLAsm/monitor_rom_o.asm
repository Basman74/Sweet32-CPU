; ********* Sweet32-Mon SoC - ROM Bootloader/Monitor
; ********* Author: Valentin Angelovski
; ********* Tweaked mercilessly by: Xark
; ********* Created: 25/08/2014
;
; <insert monitor info here...>
;
; Sourcecode provided 'as-is'. Use at your own risk!

; General Register usage:
;
; R0  = temp
; R1  = temp
; R2  = return value / temp
; R3  = argument1 / temp
; R4  = argument2 / preserved
; R5  = argument3 / preserved
; R6  = argument4 / preserved (program word size saved)
; R7  = preserved (program word size counter)
; R8  = preserved (program RAM pointer)
; R9  = preserved
; R10 = preserved
; R11 = preserved
; R12 = preserved (In this code, used for global hardware I/O base)
; R13 = program base (for relocatable code/data)
; R14 = stack pointer
; R15 = Return address
;

;
; entry code
;
monbegin:
			GETPC	R13,#0
			JMP	skiptracevec
			DD		0				; trace vector (if running at address 0x0)
skiptracevec:
			LD		R14,$reg_save
			ADD		R14,R14,R13

			MOVD	@R14,R0			; save regs on entry (R13 and R14 altered)
			INCS	R14,R14,#4
			MOVD	@R14,R1
			INCS	R14,R14,#4
			MOVD	@R14,R2
			INCS	R14,R14,#4
			MOVD	@R14,R3
			INCS	R14,R14,#4
			MOVD	@R14,R4
			INCS	R14,R14,#4
			MOVD	@R14,R5
			INCS	R14,R14,#4
			MOVD	@R14,R6
			INCS	R14,R14,#4
			MOVD	@R14,R7
			INCS	R14,R14,#4
			MOVD	@R14,R8
			INCS	R14,R14,#4
			MOVD	@R14,R9
			INCS	R14,R14,#4
			MOVD	@R14,R10
			INCS	R14,R14,#4
			MOVD	@R14,R11
			INCS	R14,R14,#4
			MOVD	@R14,R12
			INCS	R14,R14,#4
			MOVD	@R14,R13
			INCS	R14,R14,#4
			LD		R0,$monend		; save our stack address
			ADD		R0,R0,R13		; R0 = stackptr
			MOVD	@R14,R0
			INCS	R14,R14,#4
			MOVD	@R14,R15

			MOV		R14,R0			; set R14 as stack

			LD		R12,#0x70000000	; Point to UART hardware address
			LDB		R0,#0x30
			ADD		R1,R12,R0		; calc 0x70000030 LED out
			LDB		R0,#0x08
			MOVW	@R1,R0			; set LED4

			JMP	init			; contiue at init

; Reload save regs and execute
; NOTE: This routine will not return, but executed code can restart monitor with LJMP R15.
;
; PC_addr = [in] address to execute

execute:
			LD		R3,$execstr
			LD		R6,$PC_addr
			ADD		R6,R6,R13		; R6 = ptr to PC_addr
			MOVD	R4,@R6			; load current PC_addr for load
			LD		R5,$execstr2
			GETPC	R15,#2
			JMP	prstrhex

			LDB		R0,#0x30
			ADD		R1,R12,R0		; calc 0x70000030 LED out
			LDB		R0,#0x00		; LEDs off
			MOVW	@R1,R0

			LD		R14,$monend		; reset stack
			ADD		R14,R14,R13

			LD		R15,$reg_save	; restore all regs except R13=run PC_addr, R14=stack, R15=restart mon
			ADD		R15,R15,R13

			MOVD	R13,@R6			; load PC_addr in R13

			MOVD	R0,@R15
			INCS	R15,R15,#4
			MOVD	R1,@R15
			INCS	R15,R15,#4
			MOVD	R2,@R15
			INCS	R15,R15,#4
			MOVD	R3,@R15
			INCS	R15,R15,#4
			MOVD	R4,@R15
			INCS	R15,R15,#4
			MOVD	R5,@R15
			INCS	R15,R15,#4
			MOVD	R6,@R15
			INCS	R15,R15,#4
			MOVD	R7,@R15
			INCS	R15,R15,#4
			MOVD	R8,@R15
			INCS	R15,R15,#4
			MOVD	R9,@R15
			INCS	R15,R15,#4
			MOVD	R10,@R15
			INCS	R15,R15,#4
			MOVD	R11,@R15
			INCS	R15,R15,#4
			MOVD	R12,@R15

			GETPC	R15,%monbegin	; must be near start symbol (+/-127)
			LJMP	R13				; execute program
;
; one time init
;
init:
			LD		R1,$monend		; default address to after monitor code
			ADD		R1,R1,R13		; relocate
			LDB		R0,#0xFF
			ADD		R1,R1,R0		; round up to next 256 byte boundary
			NOT		R0,R0			; ~0xff
			AND		R1,R1,R0
			LD		R0,$PC_addr
			ADD		R0,R0,R13
			MOVD	@R0,R1			; save in PC_addr
			LD		R0,$cur_addr
			ADD		R0,R0,R13
			MOVD	@R0,R1			; save in cur_addr

			LD		R3,$bootstr
			GETPC	R15,#2
			JMP	prstring

			MOV		R5,R13			; verify ROM CRC
			LD		R6,$mon_crc
			ADD		R7,R6,R13
			MOVW	R7,@R7
			LSR		R6,R6
			INCS	R6,R6,#-1		; decrement length
			LD		R3,#0xFFFF		; CRC16 init
initcrc:
			MOVW	R4,@R5			; get word from memory
			INCS	R5,R5,#2		; inc ptr

			GETPC	R15,#2
			JMP	crc16word		; crc16
			MOV		R3,R2

			INCS	R6,R6,#-1		; decrement length
			TSTSZ	R6,R6			; length zero?
			JMP	initcrc			; no, jump

			XOR		R0,R3,R7		; CRC match calculated?
			TSTSNZ	R0,R0
			JMP	mainmenu

			GETPC	R15,#2
			JMP	prhex16

			LDB		R3,#'/'
			GETPC	R15,#2
			JMP	putchar

			MOV		R3,R7
			GETPC	R15,#2
			JMP	prhex16

			LD		R3,$loadBADstr
			GETPC	R15,#2
			JMP	prstring

; main menu routine
;
mainmenu:
			LD		R3,$promptstr
			GETPC	R15,#2
			JMP	prstring
menukey:
			GETPC	R15,#2
			JMP	getcharupr		; get uppercase key

			GETPC	R15,%mainmenu	; all these return to mainmenu

			LDB		R0,#'B'
			XOR		R0,R2,R0
			TSTSNZ	R0,R0			; Baud?
			JMP	baudset			;  yes, jump

			LDB		R0,#'D'
			XOR		R0,R2,R0
			TSTSNZ	R0,R0			; Dump?
			JMP	dumpmem			;  yes, jump

			LDB		R0,#'M'
			XOR		R0,R2,R0
			TSTSNZ	R0,R0			; Modify?
			JMP	modmem			;  yes, jump

			LDB		R0,#'G'
			XOR		R0,R2,R0
			TSTSNZ	R0,R0			; Go?
			JMP	gomem			;  yes, jump

			LDB		R0,#'U'
			XOR		R0,R2,R0
			TSTSNZ	R0,R0			; Upload?
			JMP	upload			;  yes, jump

			LDB		R0,#'R'
			XOR		R0,R2,R0
			TSTSNZ	R0,R0			; Registers?
			JMP	dumpregs		;  yes, jump
			
			LDB		R0,#'L'
			XOR		R0,R2,R0
			TSTSNZ	R0,R0			; List?
			JMP	disasm			;  yes, jump

			LDB		R0,#'X'
			XOR		R0,R2,R0
			TSTSNZ	R0,R0			; Easter egg? :-)
			JMP	dumpxark		;  yes, jump
			
			LDB		R0,#0x0D		; CR
			XOR		R0,R2,R0
			TSTSNZ	R0,R0			; continue dump?
			JMP	dumpcont		;  yes, jump

			LD		R3,$menustr
			JMP	prstring		; show help menu
;
; monitor routines
;

; Dump memory
;
; addr = [in] start address
; R0-R1 trashed
dumpmem:
			INCS	R14,R14,#-4		; push return addr
			MOVD	@R14,R15

			LD		R3,$dumpstr
			GETPC	R15,#2
			JMP	prstring

			LD		R9,$cur_addr
			ADD		R9,R9,R13		; R9 = cur_addr ptr
			MOVD	R3,@R9			; default = current addr
			LDB		R4,#0x08		; 8 hex digits
			GETPC	R15,#2
			JMP	gethex
			BITSZ	R4,#0			; was ESC pressed?
			JMP	dumpmem40
			MOV		R6,R2			; R6 = is start addr
			JMP	dumpmem5
; alternate entry point for dump continue
dumpcont:
			INCS	R14,R14,#-4		; push return addr
			MOVD	@R14,R15

			LD		R9,$cur_addr
			ADD		R9,R9,R13		; R9 = cur_addr ptr
			MOVD	R6,@R9			; default = current addr
dumpmem5:
			LDB		R0,#0x80
			ADD		R7,R6,R0		; R7 = is end addr
			LDB		R8,#0x00		; R8 is byte count
dumpmem10:
			LD		R3,$CRstr
			MOV		R4,R6
			LD		R5,$colonstr
			GETPC	R15,#2
			JMP	prstrhex		; print address
dumpmem20:
			MOVB	R3,@R6			; get byte
			INCS	R6,R6,#1		; inc addr
			INCS	R8,R8,#1		; inc count

			GETPC	R15,#2
			JMP	prhex8			; print byte

			XOR		R0,R6,R7
			TSTSNZ	R0,R0			; is addr == end?
			JMP	dumpmem30		; yes, exit loop

			LDB		R3,#' '
			GETPC	R15,#2
			JMP	putchar			; print space
			LDB		R0,#0x0F		; mask to print new line every 16 bytes
			TSTSZ	R8,R0			; are low 3 bits 0?
			JMP	dumpmem20		; no, print next byte
			JMP	dumpmem10		; dump next line
dumpmem30:
			LD		R9,$cur_addr
			ADD		R9,R9,R13		; R9 = cur_addr ptr
			MOVD	@R9,R6			; update addr in memory

;			GETPC	R15,#2
;			JMP	prcrlf			; end text line
dumpmem40:
			MOVD	R15,@R14		; pop return addr
			INCS	R14,R14,#4
			LJMP	R15				; return


; Modify memory range
;
; addr = [in] start address
; R0-R1 trashed
modmem:
			INCS	R14,R14,#-4		; push return addr
			MOVD	@R14,R15

			LD		R3,$modstr
			GETPC	R15,#2
			JMP	prstring

			LD		R9,$cur_addr
			ADD		R9,R9,R13		; R9 = cur_addr ptr
			MOVD	R3,@R9			; default = current addr
			LDB		R4,#0x08		; 8 hex digits
			GETPC	R15,#2
			JMP	gethex
			BITSZ	R4,#0			; was ESC pressed?
			JMP	modmem30

			MOV		R6,R2			; R6 = is start addr
modmem10:
			LD		R3,$CRstr
			MOV		R4,R6
			LD		R5,$colonstr
			GETPC	R15,#2
			JMP	prstrhex		; print address

			MOVB	R3,@R6			; get byte
			GETPC	R15,#2
			JMP	prhex8			; print byte
			
			LDB		R3,#'='
			GETPC	R15,#2
			JMP	putchar			; print '='
			
			MOVB	R3,@R6			; get byte

			LDB		R4,#0x02		; 2 digits
			GETPC	R15,#2
			JMP	gethex
			BITSZ	R4,#0			; ESC flag?
			JMP	modmem30

			MOVB	@R6,R2			; save byte

			INCS	R6,R6,#1		; inc addr
			MOVD	@R9,R6			; update addr in memory

			JMP	modmem10		; mod next line
modmem30:
			MOVD	R15,@R14		; pop return addr
			INCS	R14,R14,#4
			LJMP	R15				; return

; Disassemble memory
;
; addr = [in] start address
; R0-R1 trashed
disasm:
			INCS	R14,R14,#-4		; push return addr
			MOVD	@R14,R15

			LD		R3,$disasmstr
			GETPC	R15,#2
			JMP	prstring

			LD		R9,$cur_addr
			ADD		R9,R9,R13		; R9 = cur_addr ptr
			MOVD	R3,@R9			; default = current addr
			LDB		R4,#0x08		; 8 hex digits
			GETPC	R15,#2
			JMP	gethex
			BITSZ	R3,#0			; was ESC pressed?
			JMP	disasmmem90
			MOV		R6,R2			; R6 = is start addr
			JMP	disasmmem5
; alternate entry point for disasm continue
disasmcont:
			INCS	R14,R14,#-4		; push return addr
			MOVD	@R14,R15

			LD		R9,$cur_addr
			ADD		R9,R9,R13		; R9 = cur_addr ptr
			MOVD	R6,@R9			; default = current addr
disasmmem5:
			LDB		R0,#0x2C
			ADD		R7,R6,R0		; R7 = is end addr
disasmmem10:
			LD		R3,$CRstr
			MOV		R4,R6
			LD		R5,$colonstr
			GETPC	R15,#2
			JMP	prstrhex		; print address

			; lookup opcode

			LD		R8,$disasmtbl
			ADD		R8,R8,R13
disasmmem20:
			MOVW	R3,@R6			; get opcode word
			MOVW	R0,@R8			; get mask
			AND		R3,R3,R0		; and opcode word with mask
			INCS	R8,R8,#2		; ptr to opcode bits
			MOVW	R0,@R8			; get opcode bits
			XOR		R0,R0,R3		; compare with opcode after masking
			TSTSNZ	R0,R0			; is this a match?
			JMP	disasmmem30		; yes, print it
			INCS	R8,R8,#4		; ptr to string
			INCS	R8,R8,#6		; ptr to mask of next entry (+12 total)
			JMP	disasmmem20		; keep looping (will hit "???")

			; print opcode
disasmmem30:
			MOVW	R3,@R6			; get opcode word
			GETPC	R15,#2
			JMP	prhex16			; print word
			LDB		R3,#' '
			GETPC	R15,#2
			JMP	putchar			; print ' '

			INCS	R8,R8,#3		; ptr to length byte
			MOVB	R4,@R8			; get length

			BITSZ	R4,#1			; more than 1?
			JMP	disasmmem32		; yes, jump over spaces

			LD		R3,$space8str
			GETPC	R15,%disasmmem35
			JMP	prstring		; print 8 spaces
disasmmem32:
			INCS	R3,R6,#2
			MOVW	R3,@R3
			GETPC	R15,#2
			JMP	prhex16			; print word
			MOVB	R4,@R8			; get length
			BITSZ	R4,#0			; more than 2?
			JMP	disasmmem33		; yes, jump over spaces

			LD		R3,$space4str
			GETPC	R15,%disasmmem35
			JMP	prstring		; print 4 spaces
disasmmem33:
			INCS	R3,R6,#4
			MOVW	R3,@R3
			GETPC	R15,#2
			JMP	prhex16			; print word
disasmmem35:
			LDB		R3,#' '
			GETPC	R15,#2
			JMP	putchar			; print ' '

			INCS	R8,R8,#1		; ptr to six character opcode string

			MOV		R3,R8			; print six chars
			LDB		R4,#6
			GETPC	R15,#2
			JMP	prstrlen

			LD		R3,$space2str
			GETPC	R15,#2
			JMP	prstring		; print '  '

			INCS	R8,R8,#-2		; ptr to addr mode

			MOVB	R2,@R8			; load addr mode code
			MOVW	R3,@R6			; load opcode word
			MOV		R4,R6			; ptr to opcode

			; addr mode codes:
			; 00 = - 		09 = Z,IX
			; 01 = X        0A = IX,Y
			; 02 = Z        0B = Z,I8
			; 03 = R12      0C = Z,R8
			; 04 = R28      0D = Z,I16
			; 05 = X,Y      0E = Z,I32
			; 06 = Y,I5     0F = Z,Y,X
			; 07 = Z,Y      10 = Z,X,Y
			; 08 = Z,X      11 = Z,Y,I4
			;
			; OOOO yyyy zzzz xxxx

			LDB		R1,#1
			SUBSLT	R2,R2,R1		; is mode < 1? (and decrement mode)
			JMP	disasm_is1		; no, continue checking
			JMP	disassem40
disasm_is1:
			SUBSLT	R2,R2,R1		; is mode < 1? (and decrement mode)
			JMP	disasm_is2		; no, continue checking
; 01 = X
			LDB		R0,#0x0F
			AND		R3,R3,R0
			GETPC	R15,#2
			JMP	printreg
			JMP	disassem40
disasm_is2:
			SUBSLT	R2,R2,R1		; is mode < 1? (and decrement mode)
			JMP	disasm_is3		; no, continue checking
; 02 = Z
			LDB		R0,#0xF0
			AND		R3,R3,R0
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			GETPC	R15,#2
			JMP	printreg
			JMP	disassem40
disasm_is3:
			SUBSLT	R2,R2,R1		; is mode < 1? (and decrement mode)
			JMP	disasm_is4		; no, continue checking
; 03 = R12
			LD		R0,#0x0FFF
			AND		R3,R3,R0
			BITSNZ	R3,#11
			JMP	dam03_noneg
			NOT		R0,R0
			ADD		R3,R3,R0		; sign extend
dam03_noneg:
			LSL		R3,R3			; convert to words
			ADD		R3,R3,R4
			GETPC	R15,#2
			JMP	prhex32
			JMP	disassem40
disasm_is4:
			SUBSLT	R2,R2,R1		; is mode < 1? (and decrement mode)
			JMP	disasm_is5		; no, continue checking
; 04 = R28
			LD		R0,#0x0FFF
			AND		R3,R3,R0
			SWAPW	R3,R3
			INCS	R1,R4,#2
			MOVW	R1,@R1			; get 2nd word
			ADD		R3,R3,R1		; combine to make 28 bit offset
			BITSNZ	R3,#27
			JMP	dam04_noneg
			LD		R0,#0xF0000000
			ADD		R3,R3,R0		; sign extend
dam04_noneg:
			LSL		R3,R3			; convert to words
			ADD		R3,R3,R4
			INCS	R3,R3,#2		; adjust base address
			GETPC	R15,#2
			JMP	prhex32
			JMP	disassem40
disasm_is5:
			SUBSLT	R2,R2,R1		; is mode < 1? (and decrement mode)
			JMP	disasm_is6		; no, continue checking
; 05 = X,Y
dam_XcommaY:
			MOVW	R3,@R6
			LDB		R0,#0x0F
			AND		R3,R3,R0
			GETPC	R15,#2
			JMP	printreg		; X
dam_commaY:
			LDB		R3,#','
			GETPC	R15,#2
			JMP	putchar			; print ','
			MOVW	R3,@R6
			LDB		R0,#0x0F
			SWAPB	R3,R3
			AND		R3,R3,R0
			GETPC	R15,#2
			JMP	printreg		; Y
			JMP	disassem40
disasm_is6:
			SUBSLT	R2,R2,R1		; is mode < 1? (and decrement mode)
			JMP	disasm_is7		; no, continue checking
; 06 = Y,I5
			LDB		R0,#0x0F
			SWAPB	R3,R3
			AND		R3,R3,R0
			GETPC	R15,#2
			JMP	printreg		; Y
			LD		R3,$immstr
			GETPC	R15,#2
			JMP	prstring		; print ',#'
			MOVW	R3,@R6
			LDB		R0,#0x1F
			AND		R3,R3,R0
			GETPC	R15,#2
			JMP	prhex8
			JMP	disassem40
disasm_is7:
			SUBSLT	R2,R2,R1		; is mode < 1? (and decrement mode)
			JMP	disasm_is8		; no, continue checking
; 07 = Z,Y
			LDB		R0,#0xF0
			AND		R3,R3,R0
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			GETPC	R15,%dam_commaY	; return to ,Y
			JMP	printreg		; Z
disasm_is8:
			SUBSLT	R2,R2,R1		; is mode < 1? (and decrement mode)
			JMP	disasm_is9		; no, continue checking
; 08 = Z,X
			LDB		R0,#0xF0
			AND		R3,R3,R0
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			GETPC	R15,#2
			JMP	printreg		; Z
dam_commaX:
			LDB		R3,#','
			GETPC	R15,#2
			JMP	putchar			; print ','
dam_X:
			MOVW	R3,@R6
			LDB		R0,#0x0F
			AND		R3,R3,R0
			GETPC	R15,#2
			JMP	printreg		; X
			JMP	disassem40
disasm_is9:
			SUBSLT	R2,R2,R1		; is mode < 1? (and decrement mode)
			JMP	disasm_isA		; no, continue checking
; 09 = Z,IX
			LDB		R0,#0xF0
			AND		R3,R3,R0
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			GETPC	R15,#2
			JMP	printreg		; Z
			LDB		R3,#','
			GETPC	R15,#2
			JMP	putchar			; print ','
			LDB		R3,#'@'
			GETPC	R15,%dam_X		; return to X
			JMP	putchar			; print '@'
disasm_isA:
			SUBSLT	R2,R2,R1		; is mode < 1? (and decrement mode)
			JMP	disasm_isB		; no, continue checking
; 0A = IX,Y
			LDB		R3,#'@'
			GETPC	R15,%dam_XcommaY ; return to X,Y
			JMP	putchar			; print '@'
disasm_isB:
			SUBSLT	R2,R2,R1		; is mode < 1? (and decrement mode)
			JMP	disasm_isC		; no, continue checking
; 0B = Z,I8
			LDB		R0,#0xF0
			AND		R3,R3,R0
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			GETPC	R15,#2
			JMP	printreg		; Z
			LD		R3,$immstr
			GETPC	R15,#2
			JMP	prstring		; print ',#'
			MOVW	R1,@R6
			LDB		R0,#0x0F
			AND		R3,R1,R0
			LD		R0,#0x0F00
			AND		R1,R1,R0
			LSR		R1,R1
			LSR		R1,R1
			LSR		R1,R1
			LSR		R1,R1
			ADD		R3,R3,R1		; combine nibbles for byte
			GETPC	R15,#2
			JMP	prhex8
			JMP	disassem40
disasm_isC:
			SUBSLT	R2,R2,R1		; is mode < 1? (and decrement mode)
			JMP	disasm_isD		; no, continue checking
; 0C = Z,R8
			LDB		R0,#0xF0
			AND		R3,R3,R0
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			GETPC	R15,#2
			JMP	printreg		; Z
			LDB		R3,#','
			GETPC	R15,#2
			JMP	putchar			; print ','
			MOVW	R1,@R6
			LDB		R0,#0x0F
			AND		R3,R1,R0
			LD		R0,#0x0F00
			AND		R1,R1,R0
			LSR		R1,R1
			LSR		R1,R1
			LSR		R1,R1
			LSR		R1,R1
			ADD		R3,R3,R1		; combine nibbles for byte
			BITSNZ	R3,#7
			JMP	dam0C_noneg
			LDB		R0,#0xFF
			NOT		R0,R0
			ADD		R3,R3,R0
dam0C_noneg:
			ASL		R3,R3
			ADD		R3,R3,R6
			GETPC	R15,%disassem40
			JMP	prhex32
disasm_isD:
			SUBSLT	R2,R2,R1		; is mode < 1? (and decrement mode)
			JMP	disasm_isE		; no, continue checking
; 0D = Z,I16
			LDB		R0,#0xF0
			AND		R3,R3,R0
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			GETPC	R15,#2
			JMP	printreg		; Z
			LD		R3,$immstr
			GETPC	R15,#2
			JMP	prstring		; print ',#'
			INCS	R3,R6,#2
			MOVW	R3,@R3
			GETPC	R15,%disassem40
			JMP	prhex16
disasm_isE:
			SUBSLT	R2,R2,R1		; is mode < 1? (and decrement mode)
			JMP	disasm_isF		; no, continue checking
; 0E = Z,I32
			LDB		R0,#0xF0
			AND		R3,R3,R0
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			GETPC	R15,#2
			JMP	printreg		; Z
			LD		R3,$immstr
			GETPC	R15,#2
			JMP	prstring		; print ',#'
			INCS	R3,R6,#2
			MOVD	R3,@R3
			GETPC	R15,%disassem40
			JMP	prhex32
disasm_isF:
			SUBSLT	R2,R2,R1		; is mode < 1? (and decrement mode)
			JMP	disasm_is10		; no, continue checking
; 0F = Z,Y,X
			LDB		R0,#0xF0
			AND		R3,R3,R0
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			GETPC	R15,#2
			JMP	printreg		; Z
			LDB		R3,#','
			GETPC	R15,#2
			JMP	putchar			; print ','
			MOVW	R3,@R6
			LDB		R0,#0x0F
			SWAPB	R3,R3
			AND		R3,R3,R0
			GETPC	R15,#2
			JMP	printreg		; Y
			JMP	dam_commaX		; print ,X
disasm_is10:
			SUBSLT	R2,R2,R1		; is mode < 1? (and decrement mode)
			JMP	disasm_am11		; no, must be 11
; 10 = Z,X,Y
			LDB		R0,#0xF0
			AND		R3,R3,R0
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			GETPC	R15,#2
			JMP	printreg		; Z
			LDB		R3,#','
			GETPC	R15,#2
			JMP	putchar			; print ','
			JMP	dam_XcommaY 	; print X,Y
disasm_am11:
; 11 = Z,Y,#i4
			LDB		R0,#0xF0
			AND		R3,R3,R0
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			LSR		R3,R3
			GETPC	R15,#2
			JMP	printreg		; Z
			LDB		R3,#','
			GETPC	R15,#2
			JMP	putchar			; print ','
			MOVW	R3,@R6
			LDB		R0,#0x0F
			SWAPB	R3,R3
			AND		R3,R3,R0
			GETPC	R15,#2
			JMP	printreg		; Y
			LD		R3,$immstr
			GETPC	R15,#2
			JMP	prstring		; print ',#'
			MOVW	R3,@R6
			LDB		R0,#0x0F
			AND		R3,R3,R0
			BITSNZ	R3,#3
			JMP	dam11_noneg
			MOV		R5,R3
			LDB		R3,#'-'
			GETPC	R15,#2
			JMP	putchar			; print '-'
			LDB		R0,#0x7
			NOT		R3,R5
			AND		R3,R3,R0
			INCS	R3,R3,#1
dam11_noneg:
			GETPC	R15,%disassem40
			JMP	prhex4
disassem40:
			INCS	R8,R8,#1		; ptr to length
			MOVB	R0,@R8
			LSL		R0,R0			; convert to bytes
			ADD		R6,R6,R0

			SUBSLT	R0,R7,R6		; is end < addr?
			JMP	disasmmem10		; no, disasm next line

			LD		R9,$cur_addr
			ADD		R9,R9,R13		; R9 = cur_addr ptr
			MOVD	@R9,R6			; update addr in memory

disasmmem90:
			MOVD	R15,@R14		; pop return addr
			INCS	R14,R14,#4
			LJMP	R15				; return

; Baud set
;
; R0-R1 trashed
baudset:
			INCS	R14,R14,#-4		; push return addr
			MOVD	@R14,R15

			INCS	R0,R12,#4
			MOVW	R6,@R0			; R7 = initial divisor value

			LD		R3,$baudstr
			GETPC	R15,#2
			JMP	prstring
			
			LDB		R8,#0			; 'U' count
bauds10:
			LD		R3,$baudtestmsg
			GETPC	R15,#2
			JMP	prstring

			MOV		R3,R6
			GETPC	R15,#2
			JMP	prhex16

			GETPC	R15,#2
			JMP	prcrlf

			GETPC	R15,#2
			JMP	getcharupr
			MOV		R5,R2

			INCS	R1,R12,#6		; calc uart divisor address
			MOVW	R6,@R1			; get detected minimum bit-time from UART
			BITSZ	R6,#15			; sanity check was it >= 0x8000?
			JMP	bauds10			; yes, jump and ignore (don't support < ~4800 baud @ 100Mhz)
			INCS	R0,R12,#4
			MOVW	@R0,R6			; update divisor based on measured value

			LDB		R3,#0x00		; send some NULLs
			GETPC	R15,#2
			JMP	putchar
			LDB		R3,#0x00
			GETPC	R15,#2
			JMP	putchar
			
			LDB		R0,#'U'
			XOR		R0,R5,R0
			TSTSZ	R0,R0			; 'O' key?
			JMP	bauds10			; no, loop
			INCS	R8,R8,#1
			BITSNZ	R8,#1
			JMP	bauds10

			LD		R3,$uartstr		; print divisor
			GETPC	R15,#2
			JMP	prstring

			MOV		R3,R6
			GETPC	R15,#2
			JMP	prhex16

			GETPC	R15,#2
			JMP	prcrlf

			MOVD	R15,@R14		; pop return addr
			INCS	R14,R14,#4
			LJMP	R15				; return



; Go program
;
; addr = [in] start address
; R0-R1 trashed
gomem:
			INCS	R14,R14,#-4		; push return addr
			MOVD	@R14,R15

			LD		R3,$gostr
			GETPC	R15,#4
			JMP	prstring

			LD		R5,$PC_addr
			ADD		R5,R5,R13		; R9 = cur_addr ptr
			MOVD	R3,@R5			; default = current addr
			LDB		R4,#0x08		; 8 hex digits
			GETPC	R15,#2
			JMP	gethex
			BITSZ	R4,#0			; ESC?
			JMP	nogo
			MOVD	@R5,R2			; update addr in memory

			JMP	execute
nogo:
			MOVD	R15,@R14		; pop return addr
			INCS	R14,R14,#4
			LJMP	R15				; return

; Upload SWE file to cur_addr
;
; addr = [in] start address
; R0-R1 trashed
upload:
			INCS	R14,R14,#-4		; push return addr
			MOVD	@R14,R15

			LDB		R3,#0x04
			SWAPW	R3,R3			; 0x40000 loops to see if a slow human is at the keyboard
			LDB		R4,#0x01		; loop decrement/compare value
uploadwait:
			MOVW	R0,@R12			; Read data and flags from UART
			BITSZ	R0,#9			; is RX_READY flag set (UART byte available)?
			JMP	upload_beg		; yes, start upload skip next line

			SUBSLT	R3,R3,R4		; decrement count and skip if counter underflows
			JMP	uploadwait		; no, keep looping

			LD		R3,$uploadstr	; no key yet, so assume a human and issue prompts
			GETPC	R15,#2
			JMP	prstring
upload_beg:
			LDB		R11,#0x00		; count of 'U's (1 with no errors for auto-run)
			LDB		R5,#0x00		; retry count
upload_chkU:
			GETPC	R15,#2
			JMP	getchar

			LDB		R0,#'U'
			XOR		R0,R0,R2
			TSTSZ	R0,R0			; equal to 'U'?
			JMP	upload_notU		; jmp if not
			INCS	R11,R11,#1

			JMP	upload_chkU
upload_notU:
			LDB		R0,#'S'
			XOR		R0,R0,R2
			TSTSNZ	R0,R0
			JMP	upload_gotS

			LDB		R0,#0x1B		; ESC
			XOR		R0,R0,R2
			TSTSNZ	R0,R0			; equal to ESC?
			JMP	uploadexit		; jmp if yes

			INCS	R5,R5,#1		; inc retry count
			LDB		R11,#0			; clear auto-run
			BITSNZ	R5,#2			; 4 errors?
			JMP	upload_chkU		; no, loop
			JMP	uploaderr		; yes, bail
upload_gotS:
			GETPC	R15,#2
			JMP	getchar
			LDB		R0,#'w'
			XOR		R0,R0,R2
			TSTSZ	R0,R0			; Is equal to 'w'?
			JMP	uploaderr		; jmp if not

			GETPC	R15,#2
			JMP	readword
			LD		R0,#0x3332		; '32'
			XOR		R0,R0,R2
			TSTSZ	R0,R0			; Is equal to '32'?
			JMP	uploaderr		; jmp if not

			GETPC	R15,#2
			JMP	readword
			LD		R0,#0x7631		; "v1"
			XOR		R0,R0,R2
			TSTSZ	R0,R0			; Is equal to 'v1'?
			JMP	uploaderr		; jmp if not

			LD		R8,$PC_addr
			ADD		R8,R8,R13		; R8 = ptr to PC_addr

			; get load addr
			GETPC	R15,#2
			JMP	readdword		; read load addr dword

			LDB		R3,#0x0D		; echo CR (low-level so doesn't echo two chars at once)
uploadlf:
			MOVW	R0,@R12			; Read data and flags from UART
			BITSNZ	R0,#8			; Test TX_READY flag
			JMP	uploadlf
			MOVW	@R12,R3			; Write a character to the UART

			TSTSZ	R6,R6			; is address zero?
			MOVD	@R8,R6			; no, save PC_addr
			TSTSNZ	R6,R6			; is address zero?
			MOVD	R6,@R8			; yes, load PC_addr

			GETPC	R15,#2			; read size dword
			JMP	readdword

			LD		R0,#0xFFFFFF	; 16MB
			SUBSLT	R0,R6,R0		; sanity test size < 16MB?
			JMP	uploaderr		; jmp if not

			LDB		R3,#0x0A		; echo LF (low-level again)
uploadcr:
			MOVW	R0,@R12			; Read data and flags from UART
			BITSNZ	R0,#8			; Test TX_READY flag
			JMP	uploadcr
			MOVW	@R12,R3			; Write a character to the UART

			MOV		R7,R6			; copy filesize to counter
			MOVD	R8,@R8			; load current PC_addr for load

			; Read data word at a time
get_data:
			GETPC	R15,#2
			JMP	readword
			MOV		R4,R2

			MOVW	@R8,R4			; store word data to RAM
			INCS	R8,R8,#2		; Increment RAM word pointer

			INCS	R7,R7,#-1		; Decrement filesize (wordsize) pointer
			TSTSNZ	R7,R7			; Check if all data transferred
			JMP	uploadfooter	; jmp if done

			LDB		R3,#'.'
			GETPC	R15,%get_data	; return to get_data after putchar
			JMP	putchar
;			JMP	get_data

uploaderr:
			LDB		R11,#0			; clear auto-run
			LD		R3,$loaderr
			GETPC	R15,%uploadexit	; return to uploadexit
			JMP	prstring
;			JMP	uploadexit

uploadfooter:
			GETPC	R15,#2
			JMP	readword

			LD		R0,#0x4E64		; "Nd"
			XOR		R0,R0,R2
			TSTSZ	R0,R0			; Is equal to 'Nd'?
			JMP	uploaderr		; jmp if not

			GETPC	R15,#2			; get CRC from footer
			JMP	readword
			MOV		R7,R2			; R7 = footer CRC

			LD		R3,$loadedstr	; issue load complete
			LD		R4,$PC_addr
			ADD		R4,R4,R13
			MOVD	R4,@R4
			LDB		R5,#0
			GETPC	R15,#2
			JMP	prstrhex

			LDB		R3,#'-'
			GETPC	R15,#2
			JMP	putchar

			LD		R4,$PC_addr
			ADD		R4,R4,R13
			MOVD	R4,@R4
			ADD		R3,R6,R4		; calc end addr
			GETPC	R15,#2
			JMP	prhex32

			LD		R3,$loaded2str
			GETPC	R15,#2
			JMP	prstring

			; verify CRC16 readung back from memory

			LD		R0,$PC_addr
			ADD		R0,R0,R13		; R8 = ptr to PC_addr
			MOVD	R5,@R0

			LD		R3,#0xFFFF		; CRC16 init
uploadcrc:
			MOVW	R4,@R5			; get word from memory
			INCS	R5,R5,#2		; inc ptr

			GETPC	R15,#2
			JMP	crc16word		; crc16
			MOV		R3,R2

			INCS	R6,R6,#-1		; decrement length
			TSTSZ	R6,R6			; length zero?
			JMP	uploadcrc		; no, jump

			MOV		R8,R2
			MOV		R3,R2			; output as new crc
			GETPC	R15,#2
			JMP	prhex16			; print calculated CRC

			LD		R3,$loadOKstr	; load CRC good msg
			GETPC	R15,%uploadexit	; good return addr
			XOR		R0,R8,R7		; test against calculated CRC
			TSTSNZ	R0,R0			; is it equal?
			JMP	uploadcheck		; yes, jump
			LD		R3,$loadBADstr	; load CRC bad msg
			GETPC	R15,%uploaderr	; bad return addr
uploadcheck:
			JMP	prstring

uploadexit:
			INCS	R11,R11,#-1
			TSTSNZ	R11,R11			; auto-run?
			JMP	execute			; yes, execute at PC_addr

			GETPC	R15,#2
			JMP	prcrlf

			MOVD	R15,@R14		; pop return addr
			INCS	R14,R14,#4
			LJMP	R15				; return

; Read 2 bytes from UART and assemble as 16-bit DWORD in R2
;
readword:
			INCS	R14,R14,#-4		; push return addr
			MOVD	@R14,R15

			GETPC	R15,#2			; get MSB
			JMP	getchar
			SWAPB	R1,R2			; swap into R1
			GETPC	R15,#2			; get LSB
			JMP	getchar
			ADD		R2,R1,R2		; combine for word

			MOVD	R15,@R14		; pop return addr
			INCS	R14,R14,#4
			LJMP	R15				; return R2

; Read 4 bytes from UART and assemble as 32-bit DWORD in R6
;
readdword:
			INCS	R14,R14,#-4		; push return addr
			MOVD	@R14,R15

; Get MSB 16-bits
			GETPC	R15,#2
			JMP	readword
			SWAPW	R6,R2

; Get LSB 16-bits
			GETPC	R15,#2
			JMP	readword
			ADD		R6,R6,R2

			MOVD	R15,@R14		; pop return addr
			INCS	R14,R14,#4
			LJMP	R15				; return R6

; Print saved registers
;
; R0-R5 trashed
dumpregs:
			INCS	R14,R14,#-4		; push return addr
			MOVD	@R14,R15

			LD		R3,$regsstr
			GETPC	R15,#2
			JMP	prstring

			LDB		R6,#0x00		; reg index
dumpreg10:
			LDB		R3,#' '
			LDB		R0,#9
			GETPC	R15,#3
			SUBSLT	R0,R0,R6		; if 9 < regnum then
			JMP	putchar			;  skip print space

			MOV		R3,R6
			GETPC	R15,#2
			JMP	printreg2

			LD		R5,$reg_save
			ADD		R5,R5,R13		; calc reg save ptr
			ADD		R0,R6,R6
			ASL		R0,R0
			ADD		R5,R5,R0

			MOVD	R3,@R5			; print reg value
			GETPC	R15,#2
			JMP	prhex32

			INCS	R6,R6,#4		; inc reg num by 4 (for more easily read vertical order)

			GETPC	R15,%dumpreg20	; return to dumpreg20 after prcrlf
			LDB		R0,#16
			SUBSLT	R0,R6,R0		; if regnum < 16 then
			JMP	prcrlf			;  skip return
			LDB		R3,#' '			; otherwise print space
			GETPC	R15,%dumpreg10	; return to dumpreg10 after putchar
			JMP	putchar
;			JMP	dumpreg10
dumpreg20:
			INCS	R6,R6,#1
			LDB		R0,#0x0F
			AND		R6,R6,R0

			LDB		R0,#0x03
			TSTSZ	R6,R0
			JMP	dumpreg10		;  skip loop

			LD		R3,$PCstr
			GETPC	R15,#2
			JMP	prstring
			LD		R0,$PC_addr		; r7 = addr ptr
			ADD		R0,R0,R13
			MOVD	R3,@R0
			GETPC	R15,#2
			JMP	prhex32

			GETPC	R15,#2
			JMP	prcrlf

			LD		R3,$alterstr
			GETPC	R15,#2
			JMP	prstring

			LDB		R3,#0x0C		; default = illegal
			LDB		R4,#0x02		; 8 hex digits
			GETPC	R15,#2
			JMP	gethex

			BITSZ	R4,#0			; ESC flag?
			JMP	alter40

			MOV		R7,R2

			LDB		R0,#0x0C
			XOR		R0,R7,R0
			TSTSNZ	R0,R0
			LDB		R7,#0x16		; treat as R16

			LDB		R0,#0x10		; psuedo convert to dec
			LDB		R1,#0x06
			SUBSLT	R0,R7,R0		; is reg < 0x10
			SUBSLT	R7,R7,R1		; no, subtract 6
			NOP

			LDB		R0,#0x11
			SUBSLT	R0,R7,R0		; is reg < 0x11 (16 + PC)
			JMP	alter40			; no, bail

			LD		R3,$BS2str
			GETPC	R15,#2
			JMP	prstring

			LDB		R3,#' '
			LDB		R0,#9
			GETPC	R15,#3
			SUBSLT	R0,R0,R7		; if 9 < regnum then
			JMP	putchar			;  skip print space

			MOV		R3,R7
			GETPC	R15,#2
			JMP	printreg2

			LD		R1,$reg_save
			ADD		R1,R1,R13		; calc reg save ptr
			ADD		R0,R7,R7
			ASL		R0,R0
			ADD		R7,R1,R0

			MOVD	R3,@R7
			LDB		R4,#0x08		; 8 hex digits
			GETPC	R15,#2
			JMP	gethex

			BITSZ	R4,#0			; ESC flag?
			JMP	alter40

			MOVD	@R7,R2
alter40:
			MOVD	R15,@R14		; pop return addr
			INCS	R14,R14,#4
			LJMP	R15				; return
			
printreg2:
			INCS	R14,R14,#-4		; push return addr
			MOVD	@R14,R15
			GETPC	R15,#15
			JMP	printreg
			LDB		R3,#'='
			GETPC	R15,#15
			JMP	putchar
			MOVD	R15,@R14		; pop return addr
			INCS	R14,R14,#4
			LJMP	R15				; return

; print register
; R3 = [in] register number
;
; R0-4 trashed
printreg:
			INCS	R14,R14,#-4		; push return addr
			MOVD	@R14,R15

			MOV		R4,R3

			LDB		R0,#0x10
			XOR		R0,R4,R0
			TSTSZ	R0,R0
			JMP	printreg10

			LD		R3,$PCstr
			GETPC	R15,%printreg20
			JMP	prstring
printreg10:
			LDB		R3,#'r'
			GETPC	R15,#2
			JMP	putchar

			LDB		R3,#'1'
			LDB		R0,#10
			GETPC	R15,#3
			SUBSLT	R0,R4,R0		; if regnum < 10 then
			JMP	putchar			;  skip print '1'

			MOV		R3,R4
			LDB		R0,#10
			SUBSLT	R1,R4,R0		; if regnum < 10 then
			SUBSLT	R3,R3,R0		;   skip subtract 10 from digit
			NOP

			GETPC	R15,#2
			JMP	prhex4
printreg20:
			MOVD	R15,@R14		; pop return addr
			INCS	R14,R14,#4
			LJMP	R15				; return

; Official Easter-egg
;
;
dumpxark:
			INCS	R14,R14,#-4		; push return addr
			MOVD	@R14,R15

			LD		R3,$Xarkstr
			GETPC	R15,#2
			JMP	prstring
			MOVD	R15,@R14		; pop return addr
			INCS	R14,R14,#4
			LJMP	R15				; return

; Update CRC16 with 16-bit word
; R3 = [in] current CRC16
; R4 = [in] new 16-bit word
;
; R2 = new CRC16 result
; R0-R5 trashed
crc16word:
			INCS	R14,R14,#-4		; push return addr
			MOVD	@R14,R15
			INCS	R14,R14,#-4		; push R5
			MOVD	@R14,R5

			MOV		R5,R4
			SWAPB	R4,R4
			LDB		R0,#0xFF
			AND		R4,R4,R0
			GETPC	R15,#2
			JMP	crc16byte		; crc16 MSB
			MOV		R3,R2
			LDB		R0,#0xFF
			AND		R4,R5,R0

			MOVD	R5,@R14			; pop R5
			INCS	R14,R14,#4
			MOVD	R15,@R14		; pop return addr
			INCS	R14,R14,#4
			; fall through to crc16byte LSB

; Update CRC16 with byte using CRC-16-CCITT (0xFFFF) See: http://stackoverflow.com/a/23726131)
; R3 = [in] current CRC16
; R4 = [in] new byte
;
; R2 = [out] new CRC16 result
; R0-R4 trashed
crc16byte:
			SWAPB	R1,R3
			LDB		R0,#0xFF		; mask to clear all bit low 8 bits
			AND		R1,R1,R0
			XOR		R4,R4,R1		; x^= (crc>>8)
			LSR		R1,R4
			LSR		R1,R1
			LSR		R1,R1
			LSR		R1,R1
			XOR		R4,R4,R1		; x^= (x>>4)
			SWAPB	R2,R3
			NOT		R0,R0			; invert mask to clear low 8 bits
			AND		R2,R2,R0		; crc = (crc<<8)
			XOR		R2,R2,R4		; crc ^= x
			LDB		R0,#0x20
			MUL		R4,R4,R0		; <<5
			XOR		R2,R2,R4		; crc ^= (x<<5)
			LDB		R0,#0x80
			MUL		R4,R4,R0		; <<7
			XOR		R2,R2,R4		; crc ^= (x<<12)
			LD		R0,#0xFFFF
			AND		R2,R2,R0
			LJMP	R15				; return

; Input one hex word / dword
; R3 = [in] default result (ESC, or empty return)
; R4 = [in] max number of digits (4 for word, 8 for dword)
; R2 = [out] result value
; R0-R1 trashed
gethex:
			INCS	R14,R14,#-4		; push return addr
			MOVD	@R14,R15
			INCS	R14,R14,#-4		; push R9
			MOVD	@R14,R9
			INCS	R14,R14,#-4		; push R8
			MOVD	@R14,R8
			INCS	R14,R14,#-4		; push R7
			MOVD	@R14,R7
			INCS	R14,R14,#-4		; push R6
			MOVD	@R14,R6
			INCS	R14,R14,#-4		; push R5
			MOVD	@R14,R5

			LDB		R5,#0			; R5 = current result
			MOV		R6,R3			; R6 = default result
			LDB		R7,#0			; R7 = digit entered count
			MOV		R8,R4			; R8 = max digits

			LDB		R4,#0			; R4 = ESC flag
gethexdig:
			LDB		R9,#0			; clear tab flag
			GETPC	R15,#2
			JMP	getcharupr

			LDB		R0,#0x1B		; ESC
			XOR		R0,R2,R0
			TSTSNZ	R0,R0			; equal?
			JMP	gethexdef		; yes, jump

			LDB		R0,#0x0D		; CR
			XOR		R0,R2,R0
			TSTSNZ	R0,R0			; equal?
			JMP	gethexent		; yes, jump

			LDB		R0,#0x08		; Backspace
			XOR		R0,R2,R0
			TSTSNZ	R0,R0			; equal?
			JMP	gethexbacksp	; yes, jmp

			LDB		R0,#0x09		; TAB
			XOR		R0,R2,R0
			TSTSNZ	R0,R0			; equal?
			JMP	gethextab		; yes, jmp

			MOV		R3,R2			; save ASCII
			LDB		R0,#'0'
			SUBSLT	R2,R2,R0		; convert to nibble
			NOP
			LDB		R0,#0x0A
			LDB		R1,#0x07
			SUBSLT	R0,R2,R0		; is nibble < 0xA?
			SUBSLT	R2,R2,R1		; no, subtract 7 to adjust
			NOP
			LDB		R0,#0x0F		; load nibble mask
			NOT		R0,R0			; invert
			TSTSZ	R2,R0			; any invalid bits?
			JMP	gethexdig		; yes, ignore key

			XOR		R0,R8,R7		; compare against max digits
			TSTSNZ	R0,R0			; already equal?
			JMP	gethexdig		; yes, ignore key

			INCS	R7,R7,#1		; incrment entered digit count

			LSL		R5,R5			; make room for new digit
			LSL		R5,R5
			LSL		R5,R5
			LSL		R5,R5
			ADD		R5,R5,R2		; add in digit

			GETPC	R15,%gethexdig	; return to loop
			JMP	putchar			; print ASCII digit
;			JMP	gethexdig
gethexbacksp:
			TSTSNZ	R7,R7			; zero digits entered?
			JMP	gethexdig		; yes, ignore key

			LSR		R5,R5			; remove rightmost digit
			LSR		R5,R5
			LSR		R5,R5
			LSR		R5,R5

			INCS	R7,R7,#-1		; decrement digit count

			LD		R3,$BSstr
			GETPC	R15,%gethexdig
			JMP	prstring		; visually erase digit
;			JMP	gethexdig
gethexdef:
			LDB		R4,#1			; set ESC flag
			JMP	gethexerase
gethextab:
			LDB		R9,#1			; set tab flag
			MOV		R5,R6			; yes, use default
gethexent:
			TSTSNZ	R7,R7			; zero digits entered?
			MOV		R5,R6			; yes, use default
gethexerase:
			TSTSNZ	R7,R7			; zero digits entered?
			JMP	gethexshow		; yes, jump
			INCS	R7,R7,#-1		; decrement digit count
			LD		R3,$BSstr
			GETPC	R15,%gethexerase ; return to gethexerase
			JMP	prstring		; visually erase digit
;			JMP	gethexerase
gethexshow:
			TSTSZ	R4,R4			; ESC flag?
			JMP	gethexexit
			MOV		R7,R8			; set max digits entered (for tab)
			MOV		R3,R5
			GETPC	R15,%gethexexit
			BITSNZ	R8,#3			; 8 digits?
			JMP	gethexnot32
			JMP	prhex32			; yes, print 32-bit result
gethexnot32:
			BITSZ	R8,#2			; 4 digits?
			JMP	prhex16			; no, print 16-bit result
			JMP	prhex8			; no, print 8-bit result
gethexexit:
			TSTSZ	R9,R9			; is test tab flag set?
			JMP	gethexdig		; yes, jmp

			MOV		R2,R5			; return result

			MOVD	R5,@R14			; pop R5
			INCS	R14,R14,#4
			MOVD	R6,@R14			; pop R6
			INCS	R14,R14,#4
			MOVD	R7,@R14			; pop R7
			INCS	R14,R14,#4
			MOVD	R8,@R14			; pop R8
			INCS	R14,R14,#4
			MOVD	R9,@R14			; pop R9
			INCS	R14,R14,#4
			MOVD	R15,@R14		; pop return addr
			INCS	R14,R14,#4
			LJMP	R15				; return

; Print one 32-bit hex double word
;
; R3 = [in, not altered] input value
; R0-R1 trashed
prhex32:
			INCS	R14,R14,#-4
			MOVD	@R14,R15

			SWAPW	R3,R3
			GETPC	R15,#2
			JMP	prhex16
			SWAPW	R3,R3

			MOVD	R15,@R14
			INCS	R14,R14,#4
			; fall through to prhex16

; Print one 16-bit hex word
;
; R3 = [in, not altered] input value (low word, others ignored)
; R0-R1 trashed
prhex16:
			INCS	R14,R14,#-4
			MOVD	@R14,R15

			SWAPB	R3,R3
			GETPC	R15,#2
			JMP	prhex8
			SWAPB	R3,R3

			MOVD	R15,@R14
			INCS	R14,R14,#4
			; fall through to prhex8

; Print one 8-bit hex byte
;
; R3 = [in, not altered] input value (low byte, others ignored)
; R0-R1 trashed
prhex8:
			LSR		R1,R3
			LSR		R1,R1
			LSR		R1,R1
			LSR		R1,R1
			LDB		R0,#0x0F		; nibble mask
			AND		R1,R1,R0		; clear other bits
			LDB		R0,#'0'			; ASCII '0'
			ADD		R1,R1,R0		; convert to ASCII
			LDB		R0,#':'			; ASCII '9'+1
			SUBSLT	R0,R1,R0		; if ASCII < '9'+1 then
			INCS	R1,R1,#7		;   skip adding ASCII 'A' - '9'+1 adjust
prhex8_10:
			MOVW	R0,@R12			; Read UART flags + data
			BITSNZ	R0,#8			; Test TX_READY flag
			JMP	prhex8_10		; Continue to poll UART if TX not ready
			MOVW	@R12,R1			; Write a character to the UART
prhex4:
			LDB		R0,#0x0F		; nibble mask
			AND		R1,R3,R0		; clear other bits
			LDB		R0,#'0'			; ASCII '0'
			ADD		R1,R1,R0		; convert to ASCII
			LDB		R0,#':'			; ASCII '9'+1
			SUBSLT	R0,R1,R0		; if R2 < '9'+1 then
			INCS	R1,R1,#7		;   skip adding ASCII 'A' - '9'+1 adjust
prhex8_20:
			MOVW	R0,@R12			; Read UART flags + data
			BITSNZ	R0,#8			; Test TX_READY flag
			JMP	prhex8_20		; Continue to poll UART if TX not ready
			MOVW	@R12,R1			; Write a character to the UART

			LJMP	R15				; return
; Print character string to UART (terminated by 0 character)
;
; R3 = [in] string address (relative to R13)
; R4 = [in] 32-bit hex value to print after string
; R5 = [in] optional 2nd string (or 0)
;
; R0-1 trashed
; R12 = UART+0 constant
prstrhex:
			INCS	R14,R14,#-4		; push return addr
			MOVD	@R14,R15

			GETPC	R15,#2
			JMP	prstring

			MOV		R3,R4
			GETPC	R15,#2
			JMP	prhex32

			MOV		R3,R5
			TSTSNZ	R3,R3			; 2nd string?
			JMP	prstrhex10		; No, jump

			GETPC	R15,#2
			JMP	prstring

prstrhex10:
			MOVD	R15,@R14		; pop return addr
			INCS	R14,R14,#4
			LJMP	R15				; return

			
; Print N characters of string
;
; R3 = [in] string address (NOTE: not relative to R13!)
; R4 = characters to print
;
; R0-1 trashed
; R12 = UART+0 constant
prstrlen:
			INCS	R14,R14,#-4		; push return addr
			MOVD	@R14,R15

			MOV		R2,R3
prstrl10:
			MOVB	R3,@R2			; get a byte of our string

			GETPC	R15,#2
			JMP	putchar

			INCS	R2,R2,#1		; increment string pointer
			INCS	R4,R4,#-1		; decerement count
			TSTSZ	R4,R4
			JMP	prstrl10

			MOVD	R15,@R14		; pop return addr
			INCS	R14,R14,#4
			LJMP	R15				; return
			
			
; Print character string to UART (terminated by 0 character)
;
; R3 = [in] string address (relative to R13)
;
; R0-1 trashed
; R12 = UART+0 constant
prstring:
			INCS	R14,R14,#-4		; push return addr
			MOVD	@R14,R15
			INCS	R14,R14,#-4		; push R4
			MOVD	@R14,R4

			ADD		R2,R3,R13		; calculate absolute address of string (Base + offset)
prstr10:
			MOVB	R3,@R2			; Get a byte of our string
			INCS	R2,R2,#1		; Increment string pointer

			TSTSNZ	R3,R3			; Test for null string character
			JMP	prstr20

			GETPC	R15,%prstr10	; return to prstr10 after putchar
			JMP	putchar
;			JMP	prstr10			; loop until zero byte
prstr20:
			MOVD	R4,@R14			; pop R4
			INCS	R14,R14,#4
			MOVD	R15,@R14		; pop return addr
			INCS	R14,R14,#4
			LJMP	R15				; return

; Print CR LF to UART
;
; R0-R1,R3 trashed
; R12 = UART+0 constant
prcrlf:
			LDB		R3,#0x0A
			; fall through to putchar

; Print character to UART
;
; R3 = [in, unaltered] returned char (8-bit)
;
; R0 trashed
; R12 = UART+0 constant
putchar:
			LDB		R0,#0xFF		; byte mask
			AND		R3,R3,R0
			LDB		R0,#0x0A		; '\n'
			XOR		R0,R0,R3
			TSTSZ	R0,R0			; is equal to '\n'?
			JMP	putchar10
putchar5:
			MOVW	R0,@R12			; Read data and flags from UART
			BITSNZ	R0,#8			; Test TX_READY flag
			JMP	putchar5
			LDB		R0,#0x0D
			MOVW	@R12,R0			; Write a character to the UART
putchar10:
			MOVW	R0,@R12			; Read data and flags from UART
			BITSNZ	R0,#8			; Test TX_READY flag
			JMP	putchar10
			MOVW	@R12,R3			; Write CR character to the UART
			LJMP	R15				; return

; Wait for character from UART and convert to uppercase if lowercase
;
; R2 = [out] returned char (8-bit)
;
; R0 trashed
; R12 = UART+0 constant

getcharupr:
			INCS	R14,R14,#-4		; push return addr
			MOVD	@R14,R15

			GETPC	R15,#2
			JMP	getchar

			LDB		R0,#0x60
			SUBSLT	R0,R0,R2		; if char < 96 then
			JMP	getcharupr10	; yes, jump

			LDB		R0,#0x20
			SUBSLT	R2,R2,R0		; if 96 < char then
			NOP
getcharupr10:
			MOVD	R15,@R14		; pop return addr
			INCS	R14,R14,#4
			LJMP	R15				; return

; Wait for character from UART
;
; R2 = [out] returned char (8-bit)
;
; R0 trashed
; R12 = UART+0 constant
getchar:
			MOVW	R2,@R12			; Read data and flags from UART
			BITSNZ	R2,#9			; Test RX_READY flag
			JMP	getchar
			INCS	R0,R12,#2		; calc UART RX clear address
			MOVW	@R0,R0			; Reset UART RX flag
			LDB		R0,#0xFF
			AND		R2,R2,R0		; Get our received character
			LJMP	R15				; return

;
; monitor data
;
bootstr:
			DSZ		"\nSweet32 Monitor/Loader v0.92-beta\n"
promptstr:
			DSZ		"\n> "
menustr:
			DSZ		"?\n\n D - Dump memory\n M - Modify memory\n G - Go (execute)\n R - Registers\n B - Baud rate set\n U - Upload SWE file (or send at prompt)\n"
dumpstr:
			DSZ		"Dump "
baudstr:
			DSZ		"Baud\n"
gostr:
			DSZ		"Go "
modstr:
			DSZ		"Modify "
regsstr:
			DSZ		"Registers\n"
alterstr:
			DSZ		"Modify reg 0-15 (C for pc) "
disasmstr:
			DSZ		"List "
uploadstr:
			DSZ		"Upload\nAwaiting SWE..."
PCstr:
			DSZ		" pc="
loadedstr:
			DSZ		"\nLoaded "
loaded2str:
			DSZ		" CRC="
loaderr:
			DSZ		"\n\x07Upload error :("
loadOKstr:
			DSZ		" OK"
loadBADstr:
			DSZ		" CRC BAD!"
baudtestmsg:
			DSZ		"Switch to new baud rate, type 'U' several times to set. UART="
uartstr:
			DSZ		"New UART speed="
execstr:
			DSZ		"\nExecute "
execstr2:
			DSZ		"...\n\n"
immstr:
			DSZ		",#"
colonstr:
			DSZ		": "
BSstr:
			DSZ		"\x08 \x08"
BS2str:
			DSZ		"\x08\x08  \x08\x08"
space8str:
			DS		"    "
space4str:
			DS		"  "
space2str:
			DSZ		"  "
CRstr:
			DSZ		"\n"
Xarkstr:
			DSZ		"Xark was here. :-)"


; disassembly tables
;
; +0: word, opcode bits
; +2: word, opcode mask
; +4: byte, addr mode code
; +5: byte, word length
; +6: 6 byte ASCII opcode (padded)
; 12 bytes total size
;
; addr mode codes:
; 00 = - 		09 = Z,IX
; 01 = X        0A = IX,Y
; 02 = Z        0B = Z,I8
; 03 = R12      0C = Z,R8
; 04 = R28      0D = Z,I16
; 05 = X,Y      0E = Z,I32
; 06 = Y,I5     0F = Z,Y,X
; 07 = Z,Y      10 = Z,X,Y
; 08 = Z,X      11 = Z,Y,I4
;
			ALIGN	2
disasmtbl:
			DW		0xFFFF
			DW		0x0000
			DW		0x0001					; NOP				1 word
			DS		"nop   "

			DW		0xF000
			DW		0x0000
			DW		0x0F01					; AND    Z,Y,X		1 word
			DS		"and   "

			DW		0xF000
			DW		0x1000
			DW		0x0F01					; ADD    Z,Y,X		1 word
			DS		"add   "

			DW		0xF000
			DW		0x2000
			DW		0x0F01					; XOR    Z,Y,X		1 word
			DS		"xor   "

			DW		0xF0F0
			DW		0x3000
			DW		0x0501					; TSTSNZ X,Y		1 word
			DS		"tstsnz"

			DW		0xF0F0
			DW		0x3040
			DW		0x0501					; TSTSZ  X,Y		1 word
			DS		"tstsz "

			DW		0xF0E0
			DW		0x3080
			DW		0x0601					; BITSNZ Y,#i5		1 word
			DS		"bitsnz"

			DW		0xF0E0
			DW		0x30C0
			DW		0x0601					; BITSZ  Y,#i5		1 word
			DS		"bitsz "

			DW		0xF000
			DW		0x4000
			DW		0x1001					; SUBSLT Z,X,Y		1 word
			DS		"subslt"

			DW		0xF000
			DW		0x5000
			DW		0x0F01					; MUL    Z,Y,X		1 word
			DS		"mul   "

			DW		0xF000
			DW		0x6000
			DW		0x0301					; SJMP   R12		1 word
			DS		"sjmp  "

			DW		0xF000
			DW		0x7000
			DW		0x0B01					; LDB    Z,#i8		1 word
			DS		"ldb   "

			DW		0xF000
			DW		0x8000
			DW		0x0402					; MJMP   R28		2 words
			DS		"mjmp  "

			DW		0xF000
			DW		0x9000
			DW		0x0C01					; GETPC  Z,R8		1 word
			DS		"getpc "

			DW		0xF00F
			DW		0xA000
			DW		0x0701					; MOV	 Z,Y		1 word
			DS		"mov   "

			DW		0xF000
			DW		0xA000
			DW		0x1101					; INCS	 Z,Y,#i4	1 word
			DS		"incs  "

			DW		0xFF0F
			DW		0xB000
			DW		0x0D02					; LDW	 Z,#i16		2 words
			DS		"ldw   "

			DW		0xFF0F
			DW		0xB100
			DW		0x0E03					; LDD	 Z,#i16		3 words
			DS		"ldd   "

			DW		0xFFF0
			DW		0xB200
			DW		0x0101					; SETIV	 X			1 word
			DS		"setiv "

			DW		0xFFFF
			DW		0xB300
			DW		0x0001					; RETI				1 word
			DS		"reti  "

			DW		0xFFF0
			DW		0xB400
			DW		0x0101					; SETCW	 X			1 word
			DS		"setcw "

			DW		0xFFFF
			DW		0xB500
			DW		0x0001					; RETT				1 word
			DS		"rett  "

			DW		0xFF0F
			DW		0xB600
			DW		0x0201					; GETXR	 Z			1 word
			DS		"getxr "

			DW		0xFF0F
			DW		0xB700
			DW		0x0201					; GETTR	 Z			1 word
			DS		"gettr "

			DW		0xFF00
			DW		0xC000
			DW		0x0801					; SWAPB	 Z,X		1 word
			DS		"swapb "

			DW		0xFF00
			DW		0xC100
			DW		0x0801					; SWAPW	 Z,X		1 word
			DS		"swapw "

			DW		0xFF00
			DW		0xC200
			DW		0x0801					; NOT	 Z,X		1 word
			DS		"not   "

			DW		0xFFF0
			DW		0xC300
			DW		0x0101					; LJMP	 X			1 word
			DS		"ljmp  "

			DW		0xFF00
			DW		0xD000
			DW		0x0801					; LSR	 Z,X		1 word
			DS		"lsr   "

			DW		0xFF00
			DW		0xD100
			DW		0x0801					; ASR	 Z,X		1 word
			DS		"asr   "

			DW		0xF0F0
			DW		0xE000
			DW		0x0A01					; MOVW	 @X,Y		1 word
			DS		"movw  "

			DW		0xF0F0
			DW		0xE010
			DW		0x0A01					; MOVD	 @X,Y		1 word
			DS		"movd  "

			DW		0xF0F0
			DW		0xE020
			DW		0x0A01					; MOVB	 @X,Y		1 word
			DS		"movb  "

			DW		0xFF00
			DW		0xF000
			DW		0x0901					; MOVW	 Z,@X		1 word
			DS		"movw  "

			DW		0xFF00
			DW		0xF100
			DW		0x0901					; MOVD	 Z,@X		1 word
			DS		"movd  "

			DW		0xFF00
			DW		0xF200
			DW		0x0901					; MOVSW	 Z,@X		1 word
			DS		"movsw "

			DW		0xFF00
			DW		0xF300
			DW		0x0901					; MOVB	 Z,@X		1 word
			DS		"movb  "

			DW		0x0000
			DW		0x0000
			DW		0x0001					; ???				1 word
			DS		"???   "


			ALIGN	2
mon_crc:
			DW		0xE716			; CRC for monitor code/data
;
; writable data follows

cur_addr:
			DZEROW	2				; current address for monitor Dump, Modify
reg_save:
			DZEROW	32				; 16 x 32 bit saved register buffer
PC_addr:
			DZEROW	2				; current PC address for Regs, Upload and Go
stack:
			DZEROW	62				; 32 x 32 bit stack buffer
			DD		0xC0DEBAD1		; stack top safety check value
monend:
			$END
