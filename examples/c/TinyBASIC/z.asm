; *** Produced by Smaller-C modified for Sweet32 code generation

	GETPC	R4,#0 ; Get codebase address 
	ADD	R0,R0,R0 ; Reserved for 32bit Trace/Debug handler vector
	ADD	R0,R0,R0
	LDD	R14,$Sweet32_stacktop ; Auto Stack pointer setup
	ADD	R14,R14,R4
	MOV	R13,R14
	incs	R14,R14,#-4
	movd	@R14,R15
	MOV	R13,R14
	LDD	R9,#0xFFFFFF00
	MJMP	_main
; ************* UDIV16 routine **************
Divide_U1616:
	LDD	R11,#0x00010000
	LDB	R10,#17
	MOV	R3,R0
	LDB	R0,#0x0
	SWAPW	R2,R2
Division_loop:
	SUBSLT	R12,R3,R2
	SJMP	does_go
	LSR	R2,R2
	LSR	R11,R11
	INCS	R10,R10,#-1
	TSTSNZ	R10,R10
	SJMP	Division_done
	SJMP	Division_loop
does_go:
	MOV	R3,R12
	ADD	R0,R0,R11
	LSR	R2,R2
	LSR	R11,R11
	INCS	R10,R10,#-1
	TSTSZ	R10,R10
	SJMP	Division_loop
Division_done:
	LJMP	R15
; ************* End UDIV16 routine **************

; glb linelen : unsigned char
	align	2
_linelen:
; =
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
	db	0
; glb UART_status : * unsigned short
	align	2
	align	2
_UART_status:
	dzerob	4 
	align	2
; glb UART_eventack : * unsigned short
	align	2
	align	2
_UART_eventack:
	dzerob	4 
	align	2
; glb keywords : [0u] unsigned char
	align	2
_keywords:
; =
; RPN'ized expression: "76 "
; Expanded expression: "76 "
; Expression value: 76
	db	76
; RPN'ized expression: "73 "
; Expanded expression: "73 "
; Expression value: 73
	db	73
; RPN'ized expression: "83 "
; Expanded expression: "83 "
; Expression value: 83
	db	83
; RPN'ized expression: "84 128 + "
; Expanded expression: "212 "
; Expression value: 212
	db	212
; RPN'ized expression: "76 "
; Expanded expression: "76 "
; Expression value: 76
	db	76
; RPN'ized expression: "79 "
; Expanded expression: "79 "
; Expression value: 79
	db	79
; RPN'ized expression: "65 "
; Expanded expression: "65 "
; Expression value: 65
	db	65
; RPN'ized expression: "68 128 + "
; Expanded expression: "196 "
; Expression value: 196
	db	196
; RPN'ized expression: "78 "
; Expanded expression: "78 "
; Expression value: 78
	db	78
; RPN'ized expression: "69 "
; Expanded expression: "69 "
; Expression value: 69
	db	69
; RPN'ized expression: "87 128 + "
; Expanded expression: "215 "
; Expression value: 215
	db	215
; RPN'ized expression: "82 "
; Expanded expression: "82 "
; Expression value: 82
	db	82
; RPN'ized expression: "85 "
; Expanded expression: "85 "
; Expression value: 85
	db	85
; RPN'ized expression: "78 128 + "
; Expanded expression: "206 "
; Expression value: 206
	db	206
; RPN'ized expression: "83 "
; Expanded expression: "83 "
; Expression value: 83
	db	83
; RPN'ized expression: "65 "
; Expanded expression: "65 "
; Expression value: 65
	db	65
; RPN'ized expression: "86 "
; Expanded expression: "86 "
; Expression value: 86
	db	86
; RPN'ized expression: "69 128 + "
; Expanded expression: "197 "
; Expression value: 197
	db	197
; RPN'ized expression: "78 "
; Expanded expression: "78 "
; Expression value: 78
	db	78
; RPN'ized expression: "69 "
; Expanded expression: "69 "
; Expression value: 69
	db	69
; RPN'ized expression: "88 "
; Expanded expression: "88 "
; Expression value: 88
	db	88
; RPN'ized expression: "84 128 + "
; Expanded expression: "212 "
; Expression value: 212
	db	212
; RPN'ized expression: "76 "
; Expanded expression: "76 "
; Expression value: 76
	db	76
; RPN'ized expression: "69 "
; Expanded expression: "69 "
; Expression value: 69
	db	69
; RPN'ized expression: "84 128 + "
; Expanded expression: "212 "
; Expression value: 212
	db	212
; RPN'ized expression: "73 "
; Expanded expression: "73 "
; Expression value: 73
	db	73
; RPN'ized expression: "70 128 + "
; Expanded expression: "198 "
; Expression value: 198
	db	198
; RPN'ized expression: "71 "
; Expanded expression: "71 "
; Expression value: 71
	db	71
; RPN'ized expression: "79 "
; Expanded expression: "79 "
; Expression value: 79
	db	79
; RPN'ized expression: "84 "
; Expanded expression: "84 "
; Expression value: 84
	db	84
; RPN'ized expression: "79 128 + "
; Expanded expression: "207 "
; Expression value: 207
	db	207
; RPN'ized expression: "71 "
; Expanded expression: "71 "
; Expression value: 71
	db	71
; RPN'ized expression: "79 "
; Expanded expression: "79 "
; Expression value: 79
	db	79
; RPN'ized expression: "83 "
; Expanded expression: "83 "
; Expression value: 83
	db	83
; RPN'ized expression: "85 "
; Expanded expression: "85 "
; Expression value: 85
	db	85
; RPN'ized expression: "66 128 + "
; Expanded expression: "194 "
; Expression value: 194
	db	194
; RPN'ized expression: "82 "
; Expanded expression: "82 "
; Expression value: 82
	db	82
; RPN'ized expression: "69 "
; Expanded expression: "69 "
; Expression value: 69
	db	69
; RPN'ized expression: "84 "
; Expanded expression: "84 "
; Expression value: 84
	db	84
; RPN'ized expression: "85 "
; Expanded expression: "85 "
; Expression value: 85
	db	85
; RPN'ized expression: "82 "
; Expanded expression: "82 "
; Expression value: 82
	db	82
; RPN'ized expression: "78 128 + "
; Expanded expression: "206 "
; Expression value: 206
	db	206
; RPN'ized expression: "82 "
; Expanded expression: "82 "
; Expression value: 82
	db	82
; RPN'ized expression: "69 "
; Expanded expression: "69 "
; Expression value: 69
	db	69
; RPN'ized expression: "77 128 + "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "70 "
; Expanded expression: "70 "
; Expression value: 70
	db	70
; RPN'ized expression: "79 "
; Expanded expression: "79 "
; Expression value: 79
	db	79
; RPN'ized expression: "82 128 + "
; Expanded expression: "210 "
; Expression value: 210
	db	210
; RPN'ized expression: "73 "
; Expanded expression: "73 "
; Expression value: 73
	db	73
; RPN'ized expression: "78 "
; Expanded expression: "78 "
; Expression value: 78
	db	78
; RPN'ized expression: "80 "
; Expanded expression: "80 "
; Expression value: 80
	db	80
; RPN'ized expression: "85 "
; Expanded expression: "85 "
; Expression value: 85
	db	85
; RPN'ized expression: "84 128 + "
; Expanded expression: "212 "
; Expression value: 212
	db	212
; RPN'ized expression: "80 "
; Expanded expression: "80 "
; Expression value: 80
	db	80
; RPN'ized expression: "82 "
; Expanded expression: "82 "
; Expression value: 82
	db	82
; RPN'ized expression: "73 "
; Expanded expression: "73 "
; Expression value: 73
	db	73
; RPN'ized expression: "78 "
; Expanded expression: "78 "
; Expression value: 78
	db	78
; RPN'ized expression: "84 128 + "
; Expanded expression: "212 "
; Expression value: 212
	db	212
; RPN'ized expression: "80 "
; Expanded expression: "80 "
; Expression value: 80
	db	80
; RPN'ized expression: "79 "
; Expanded expression: "79 "
; Expression value: 79
	db	79
; RPN'ized expression: "75 "
; Expanded expression: "75 "
; Expression value: 75
	db	75
; RPN'ized expression: "69 128 + "
; Expanded expression: "197 "
; Expression value: 197
	db	197
; RPN'ized expression: "69 "
; Expanded expression: "69 "
; Expression value: 69
	db	69
; RPN'ized expression: "78 "
; Expanded expression: "78 "
; Expression value: 78
	db	78
; RPN'ized expression: "68 128 + "
; Expanded expression: "196 "
; Expression value: 196
	db	196
; RPN'ized expression: "66 "
; Expanded expression: "66 "
; Expression value: 66
	db	66
; RPN'ized expression: "89 "
; Expanded expression: "89 "
; Expression value: 89
	db	89
; RPN'ized expression: "69 128 + "
; Expanded expression: "197 "
; Expression value: 197
	db	197
; RPN'ized expression: "70 "
; Expanded expression: "70 "
; Expression value: 70
	db	70
; RPN'ized expression: "82 "
; Expanded expression: "82 "
; Expression value: 82
	db	82
; RPN'ized expression: "69 "
; Expanded expression: "69 "
; Expression value: 69
	db	69
; RPN'ized expression: "69 128 + "
; Expanded expression: "197 "
; Expression value: 197
	db	197
; RPN'ized expression: "67 "
; Expanded expression: "67 "
; Expression value: 67
	db	67
; RPN'ized expression: "76 "
; Expanded expression: "76 "
; Expression value: 76
	db	76
; RPN'ized expression: "83 128 + "
; Expanded expression: "211 "
; Expression value: 211
	db	211
; RPN'ized expression: "68 "
; Expanded expression: "68 "
; Expression value: 68
	db	68
; RPN'ized expression: "69 "
; Expanded expression: "69 "
; Expression value: 69
	db	69
; RPN'ized expression: "76 "
; Expanded expression: "76 "
; Expression value: 76
	db	76
; RPN'ized expression: "65 "
; Expanded expression: "65 "
; Expression value: 65
	db	65
; RPN'ized expression: "89 128 + "
; Expanded expression: "217 "
; Expression value: 217
	db	217
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
	db	0
; glb func_tab : [0u] unsigned char
	align	2
_func_tab:
; =
; RPN'ized expression: "80 "
; Expanded expression: "80 "
; Expression value: 80
	db	80
; RPN'ized expression: "69 "
; Expanded expression: "69 "
; Expression value: 69
	db	69
; RPN'ized expression: "69 "
; Expanded expression: "69 "
; Expression value: 69
	db	69
; RPN'ized expression: "75 128 + "
; Expanded expression: "203 "
; Expression value: 203
	db	203
; RPN'ized expression: "65 "
; Expanded expression: "65 "
; Expression value: 65
	db	65
; RPN'ized expression: "66 "
; Expanded expression: "66 "
; Expression value: 66
	db	66
; RPN'ized expression: "83 128 + "
; Expanded expression: "211 "
; Expression value: 211
	db	211
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
	db	0
; glb to_tab : [0u] unsigned char
	align	2
_to_tab:
; =
; RPN'ized expression: "84 "
; Expanded expression: "84 "
; Expression value: 84
	db	84
; RPN'ized expression: "79 128 + "
; Expanded expression: "207 "
; Expression value: 207
	db	207
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
	db	0
; glb step_tab : [0u] unsigned char
	align	2
_step_tab:
; =
; RPN'ized expression: "83 "
; Expanded expression: "83 "
; Expression value: 83
	db	83
; RPN'ized expression: "84 "
; Expanded expression: "84 "
; Expression value: 84
	db	84
; RPN'ized expression: "69 "
; Expanded expression: "69 "
; Expression value: 69
	db	69
; RPN'ized expression: "80 128 + "
; Expanded expression: "208 "
; Expression value: 208
	db	208
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
	db	0
; glb relop_tab : [0u] unsigned char
	align	2
_relop_tab:
; =
; RPN'ized expression: "62 "
; Expanded expression: "62 "
; Expression value: 62
	db	62
; RPN'ized expression: "61 128 + "
; Expanded expression: "189 "
; Expression value: 189
	db	189
; RPN'ized expression: "60 "
; Expanded expression: "60 "
; Expression value: 60
	db	60
; RPN'ized expression: "62 128 + "
; Expanded expression: "190 "
; Expression value: 190
	db	190
; RPN'ized expression: "62 128 + "
; Expanded expression: "190 "
; Expression value: 190
	db	190
; RPN'ized expression: "61 128 + "
; Expanded expression: "189 "
; Expression value: 189
	db	189
; RPN'ized expression: "60 "
; Expanded expression: "60 "
; Expression value: 60
	db	60
; RPN'ized expression: "61 128 + "
; Expanded expression: "189 "
; Expression value: 189
	db	189
; RPN'ized expression: "60 128 + "
; Expanded expression: "188 "
; Expression value: 188
	db	188
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
	db	0
; glb okmsg : [0u] unsigned char
	align	2
_okmsg:
; =
; RPN'ized expression: "L1 "
; Expanded expression: "L1 "
	align	2
L1:
	ds	"OK"
	db	0

	db	0
	align	2

; glb sderrormsg : [0u] unsigned char
	align	2
_sderrormsg:
; =
; RPN'ized expression: "L3 "
; Expanded expression: "L3 "
	align	2
L3:
	ds	"Drive fail"
	db	0

	db	0
	align	2

; glb whatmsg : [0u] unsigned char
	align	2
_whatmsg:
; =
; RPN'ized expression: "L5 "
; Expanded expression: "L5 "
	align	2
L5:
	ds	"What? "
	db	0

	db	0
	align	2

; glb redomsg : [0u] unsigned char
	align	2
_redomsg:
; =
; RPN'ized expression: "L7 "
; Expanded expression: "L7 "
	align	2
L7:
	ds	"Redo"
	db	0

	db	0
	align	2

; glb howmsg : [0u] unsigned char
	align	2
_howmsg:
; =
; RPN'ized expression: "L9 "
; Expanded expression: "L9 "
	align	2
L9:
	ds	"How?"
	db	0

	db	0
	align	2

; glb sorrymsg : [0u] unsigned char
	align	2
_sorrymsg:
; =
; RPN'ized expression: "L11 "
; Expanded expression: "L11 "
	align	2
L11:
	ds	"Sorry!"
	db	0

	db	0
	align	2

; glb initmsg : [0u] unsigned char
	align	2
_initmsg:
; =
; RPN'ized expression: "L13 "
; Expanded expression: "L13 "
	align	2
L13:
	ds	"TinyBasic in C V0.03."
	db	0

	db	0
	align	2

; glb valmsg : [0u] unsigned char
	align	2
_valmsg:
; =
; RPN'ized expression: "L15 "
; Expanded expression: "L15 "
	align	2
L15:
	ds	"Sweet32 port by Valentin Angelovski"
	db	0

	db	0
	align	2

; glb memorymsg : [0u] unsigned char
	align	2
_memorymsg:
; =
; RPN'ized expression: "L17 "
; Expanded expression: "L17 "
	align	2
L17:
	ds	" bytes free."
	db	0

	db	0
	align	2

; glb breakmsg : [0u] unsigned char
	align	2
_breakmsg:
; =
; RPN'ized expression: "L19 "
; Expanded expression: "L19 "
	align	2
L19:
	ds	"break!"
	db	0

	db	0
	align	2

; glb unimplimentedmsg : [0u] unsigned char
	align	2
_unimplimentedmsg:
; =
; RPN'ized expression: "L21 "
; Expanded expression: "L21 "
	align	2
L21:
	ds	"Unimplemented"
	db	0

	db	0
	align	2

; glb backspacemsg : [0u] unsigned char
	align	2
_backspacemsg:
; =
; RPN'ized expression: "L23 "
; Expanded expression: "L23 "
	align	2
L23:

	db	8
	ds	" "
	db	8

	db	0

	db	0
	align	2

; glb TEXTMODE : (void) void
; glb outchar : (void) void
; glb inchar : (void) void
; glb line_terminator : (void) void
; glb expression : (void) short
; glb breakcheck : (void) unsigned char
; glb main : (void) void
; glb LINENUM : unsigned short
; glb linenum : unsigned short
	align	2
	align	2
_linenum:
	dzerob	2 
	align	2
; glb txtpos : * unsigned char
	align	2
	align	2
_txtpos:
	dzerob	4 
	align	2
; glb inputpos : * unsigned char
	align	2
	align	2
_inputpos:
	dzerob	4 
	align	2
; glb list_line : * unsigned char
	align	2
	align	2
_list_line:
	dzerob	4 
	align	2
; glb expression_error : unsigned char
	align	2
_expression_error:
	dzerob	1 
	align	2
; glb tempsp : * unsigned char
	align	2
	align	2
_tempsp:
	dzerob	4 
	align	2
; glb stack_limit : * unsigned char
	align	2
	align	2
_stack_limit:
	dzerob	4 
	align	2
; glb program_start : * unsigned char
	align	2
	align	2
_program_start:
	dzerob	4 
	align	2
; glb program_end : * unsigned char
	align	2
	align	2
_program_end:
	dzerob	4 
	align	2
; glb stack : * unsigned char
	align	2
	align	2
_stack:
	dzerob	4 
	align	2
; glb variables_begin : * unsigned char
	align	2
	align	2
_variables_begin:
	dzerob	4 
	align	2
; glb current_line : * unsigned char
	align	2
	align	2
_current_line:
	dzerob	4 
	align	2
; glb sp : * unsigned char
	align	2
	align	2
_sp:
	dzerob	4 
	align	2
; glb table_index : unsigned char
	align	2
_table_index:
	dzerob	1 
	align	2
; glb dataptr : unsigned short
	align	2
	align	2
_dataptr:
	dzerob	2 
	align	2
; RPN'ized expression: "512 "
; Expanded expression: "512 "
; Expression value: 512
; glb program : [512u] unsigned char
	align	2
_program:
	dzerob	512 
	align	2
; glb opcode : unsigned char
	align	2
_opcode:
	dzerob	1 
	align	2
; glb newchar : unsigned char
	align	2
_newchar:
	dzerob	1 
	align	2
; glb setup : () void
	align	2
_setup:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L26
	align	2
L25:
	align	2
L27:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L26:
	mjmp	L25
; glb breakcheck : (void) unsigned char
	align	2
_breakcheck:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L30
	align	2
L29:
; loc     d : (@-4): unsigned
; if
; RPN'ized expression: "UART_status *u 512 & 0 == "
; Expanded expression: "UART_status *(4) *(2) 512 & 0 == "
; Fused expression:    "*(4) UART_status & *ax 512 == ax 0 IF! "
	ldd	R10,$_UART_status
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movw	R0,@R1; mov	ax, [bx]
	ldw	R10,#512
	and	R0,R0,R10 ; and eax, const32
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L33
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0 "
	ldd	R0,#0 ; // mov	eax, const_32
	mjmp	L31
	sjmp	L34
	align	2
L33:
; else
; {
; RPN'ized expression: "UART_eventack *u 1 = "
; Expanded expression: "UART_eventack *(4) 1 =(2) "
; Fused expression:    "*(4) UART_eventack =(172) *ax 1 "
	ldd	R10,$_UART_eventack
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0 ; mov ebx, eax
	ldd	R0,#1 ; // mov	eax, const_32
	movw	@R1,R0
; RPN'ized expression: "d UART_status *u 255 & = "
; Expanded expression: "(@-4) UART_status *(4) *(2) 255 & =(4) "
; Fused expression:    "*(4) UART_status & *ax 255 =(204) *(@-4) ax "
	ldd	R10,$_UART_status
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movw	R0,@R1; mov	ax, [bx]
	ldb	R10,#255
	and	R0,R0,R10 ; and eax, const32
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; if
; RPN'ized expression: "d 8 == "
; Expanded expression: "(@-4) *(4) 8 == "
; Fused expression:    "== *(@-4) 8 IF! "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#8
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L35
; return
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
; Fused expression:    "1 "
	ldd	R0,#1 ; // mov	eax, const_32
	mjmp	L31
	sjmp	L36
	align	2
L35:
; else
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0 "
	ldd	R0,#0 ; // mov	eax, const_32
	mjmp	L31
	align	2
L36:
; }
	align	2
L34:
	align	2
L31:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L30:
	ldd	R10,#4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L29
; glb outchar : (
; prm     c : int
;     ) void
	align	2
_outchar:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L38
	align	2
L37:
; loc     c : (@8): int
; wait_tx:
	align	2
L41:
; if
; RPN'ized expression: "UART_status *u 256 & 0 == "
; Expanded expression: "UART_status *(4) *(2) 256 & 0 == "
; Fused expression:    "*(4) UART_status & *ax 256 == ax 0 IF! "
	ldd	R10,$_UART_status
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movw	R0,@R1; mov	ax, [bx]
	ldw	R10,#256
	and	R0,R0,R10 ; and eax, const32
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L42
; goto wait_tx
	mjmp	L41
	align	2
L42:
; RPN'ized expression: "UART_status *u c = "
; Expanded expression: "UART_status *(4) (@8) *(4) =(2) "
; Fused expression:    "*(4) UART_status =(172) *ax *(@8) "
	ldd	R10,$_UART_status
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0 ; mov ebx, eax
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	movw	@R1,R0
	align	2
L39:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L38:
	mjmp	L37
; glb inchar : (void) unsigned
	align	2
_inchar:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L45
	align	2
L44:
; loc     d : (@-4): unsigned
; wait_rx:
	align	2
L48:
; if
; RPN'ized expression: "UART_status *u 512 & 0 == "
; Expanded expression: "UART_status *(4) *(2) 512 & 0 == "
; Fused expression:    "*(4) UART_status & *ax 512 == ax 0 IF! "
	ldd	R10,$_UART_status
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movw	R0,@R1; mov	ax, [bx]
	ldw	R10,#512
	and	R0,R0,R10 ; and eax, const32
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L49
; goto wait_rx
	mjmp	L48
	align	2
L49:
; RPN'ized expression: "UART_eventack *u 1 = "
; Expanded expression: "UART_eventack *(4) 1 =(2) "
; Fused expression:    "*(4) UART_eventack =(172) *ax 1 "
	ldd	R10,$_UART_eventack
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0 ; mov ebx, eax
	ldd	R0,#1 ; // mov	eax, const_32
	movw	@R1,R0
; RPN'ized expression: "d UART_status *u 255 & = "
; Expanded expression: "(@-4) UART_status *(4) *(2) 255 & =(4) "
; Fused expression:    "*(4) UART_status & *ax 255 =(204) *(@-4) ax "
	ldd	R10,$_UART_status
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movw	R0,@R1; mov	ax, [bx]
	ldb	R10,#255
	and	R0,R0,R10 ; and eax, const32
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; return
; RPN'ized expression: "d "
; Expanded expression: "(@-4) *(4) "
; Fused expression:    "*(4) (@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mjmp	L46
	align	2
L46:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L45:
	ldd	R10,#4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L44
; glb puts : (
; prm     s : * char
;     ) void
	align	2
_puts:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L52
	align	2
L51:
; loc     s : (@8): * char
; while
; RPN'ized expression: "s *u "
; Expanded expression: "(@8) *(4) *(-1) "
	align	2
L55:
; Fused expression:    "*(4) (@8) *(-1) ax "
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
	bitsz	R0,#7
	add	R0,R0,R9 ; extend char sign bit if needed
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L56
; RPN'ized expression: "( s ++p *u outchar ) "
; Expanded expression: " (@8) ++p(4) *(-1)  outchar ()4 "
; Fused expression:    "( ++p(4) *(@8) *(-1) ax , outchar )4 "
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
	bitsz	R0,#7
	add	R0,R0,R9 ; extend char sign bit if needed
	incs	R14,R14,#-4
	movd	@R14,R0
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_outchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	sjmp	L55
	align	2
L56:
	align	2
L53:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L52:
	mjmp	L51
; glb dump : (void) void
	align	2
_dump:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L58
	align	2
L57:
; loc     i : (@-4): int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-4) 0 =(4) "
; Fused expression:    "=(204) *(@-4) 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; while
; RPN'ized expression: "i 510 < "
; Expanded expression: "(@-4) *(4) 510 < "
	align	2
L61:
; Fused expression:    "< *(@-4) 510 IF! "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldw	R10,#510
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12
	sjmp	L62
	XOR	R12,R0,R10
	BITSNZ	R12,#31
	sjmp	LC0
	BITSNZ	R10,#31
	sjmp	LC1
	sjmp	L62
LC0:
	subslt	R12,R0,R10 ; jae	label
	sjmp	L62
LC1:
; {
; RPN'ized expression: "( program i + *u outchar ) "
; Expanded expression: " program (@-4) *(4) + *(1)  outchar ()4 "
; Fused expression:    "( + program *(@-4) *(1) ax , outchar )4 "
	ldd	R0,$_program ; // mov	eax, label
	add	R0,R0,R4
	ldd	R11,#-4 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movd	R10,@R11
	add	R0,R0,R10 ; add eax,[ebp-ofs]
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	incs	R14,R14,#-4
	movd	@R14,R0
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_outchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-4) ++p(4) "
; Fused expression:    "++p(4) *(@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; }
	sjmp	L61
	align	2
L62:
	align	2
L59:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L58:
	ldd	R10,#4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L57
; glb process_userinput : (void) short
	align	2
_process_userinput:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L64
	align	2
L63:
; loc     a : (@-4): short
; RPN'ized expression: "a 0 = "
; Expanded expression: "(@-4) 0 =(-2) "
; Fused expression:    "=(204) *(@-4) 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "7 "
; Expanded expression: "7 "
; Expression value: 7
; loc     inputbuf : (@-12): [7u] unsigned char
; loc     neg_input : (@-16): unsigned char
; RPN'ized expression: "neg_input 0 = "
; Expanded expression: "(@-16) 0 =(1) "
; Fused expression:    "=(204) *(@-16) 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,#-16 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "inputpos inputbuf = "
; Expanded expression: "inputpos (@-12) =(4) "
; Fused expression:    "=(204) *inputpos (@-12) "
	ldd	R10,#-12 ; lea	eax, [ebp-ofs]
	add	R0,R10,R13
	ldd	R10,$_inputpos
	add	R10,R10,R4
	movd	@R10,R0
; loc     opcode : (@-20): unsigned char
; for
; RPN'ized expression: "opcode 0 = "
; Expanded expression: "(@-20) 0 =(1) "
; Fused expression:    "=(156) *(@-20) 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,#-20 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
	align	2
L67:
; RPN'ized expression: "opcode 7 < "
; Expanded expression: "(@-20) *(1) 7 < "
; Fused expression:    "< *(@-20) 7 IF! "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	ldb	R10,#7
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12
	sjmp	L70
	XOR	R12,R0,R10
	BITSNZ	R12,#31
	sjmp	LC2
	BITSNZ	R10,#31
	sjmp	LC3
	sjmp	L70
LC2:
	subslt	R12,R0,R10 ; jae	label
	sjmp	L70
LC3:
	sjmp	L69
	align	2
L68:
; RPN'ized expression: "opcode ++p "
; Expanded expression: "(@-20) ++p(1) "
; Fused expression:    "++p(1) *(@-20) "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movb	@R10,R11
	sjmp	L67
	align	2
L69:
; {
; RPN'ized expression: "newchar ( inchar ) = "
; Expanded expression: "newchar  inchar ()0 =(1) "
; Fused expression:    "( inchar )0 =(156) *newchar ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_inchar
	ldd	R10,$_newchar
	add	R10,R10,R4
	movb	@R10,R0
; RPN'ized expression: "( newchar outchar ) "
; Expanded expression: " newchar *(1)  outchar ()4 "
; Fused expression:    "( *(1) newchar , outchar )4 "
	ldd	R10,$_newchar
	add	R10,R10,R4
	movb	R0,@R10
	incs	R14,R14,#-4
	movd	@R14,R0
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_outchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; if
; RPN'ized expression: "newchar 13 == "
; Expanded expression: "newchar *(1) 13 == "
; Fused expression:    "== *newchar 13 IF! "
	ldd	R10,$_newchar
	add	R10,R10,R4
	movb	R0,@R10
	ldb	R10,#13
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L71
; {
; RPN'ized expression: "inputbuf opcode + *u newchar = "
; Expanded expression: "(@-12) (@-20) *(1) + newchar *(1) =(1) "
; Fused expression:    "+ (@-12) *(@-20) =(153) *ax *newchar "
	ldd	R10,#-12 ; lea	eax, [ebp-ofs]
	add	R0,R10,R13
	ldd	R11,#-20 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movb	R2,@R11
	add	R0,R0,R2 ; add eax,[ebp-ofs]
	mov	R1,R0 ; mov ebx, eax
	ldd	R10,$_newchar
	add	R10,R10,R4
	movb	R0,@R10
	movb	@R1,R0
; RPN'ized expression: "newchar 10 = "
; Expanded expression: "newchar 10 =(1) "
; Fused expression:    "=(156) *newchar 10 "
	ldd	R0,#10 ; // mov	eax, const_32
	ldd	R10,$_newchar
	add	R10,R10,R4
	movb	@R10,R0
; RPN'ized expression: "( newchar outchar ) "
; Expanded expression: " newchar *(1)  outchar ()4 "
; Fused expression:    "( *(1) newchar , outchar )4 "
	ldd	R10,$_newchar
	add	R10,R10,R4
	movb	R0,@R10
	incs	R14,R14,#-4
	movd	@R14,R0
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_outchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; goto exit_usrinput
	mjmp	L73
; }
	align	2
L71:
; if
; RPN'ized expression: "newchar 48 < newchar 57 > || newchar 45 != && "
; Expanded expression: "newchar *(1) 48 < [sh||->77] newchar *(1) 57 > ||[77] _Bool [sh&&->76] newchar *(1) 45 != &&[76] "
; Fused expression:    "< *newchar 48 [sh||->77] > *newchar 57 ||[77] _Bool [sh&&->76] != *newchar 45 &&[76] "
	ldd	R10,$_newchar
	add	R10,R10,R4
	movb	R0,@R10
	ldb	R10,#48
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC4
	BITSNZ	R10,#31
	sjmp	LC5
	ldb	R0,#0
LC4:
	subslt	R12,R12,R10 ; jae	label
	ldb	R0,#0
LC5:
; JumpIfNotZero
	tstsnz	R0,R0 ; jne	label
	sjmp	LC6
	sjmp	L77
LC6:
	ldd	R10,$_newchar
	add	R10,R10,R4
	movb	R0,@R10
	ldb	R10,#57
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC7
	BITSNZ	R12,#31
	sjmp	LC8
	ldb	R0,#0
LC7:
	subslt	R12,R10,R12 ; jae	label
	ldb	R0,#0
LC8:
	align	2
L77:
	mov	R12,R0
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
LC9:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L76
	ldd	R10,$_newchar
	add	R10,R10,R4
	movb	R0,@R10
	ldb	R10,#45
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
	align	2
L76:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L74
; return
; RPN'ized expression: "32768 -u "
; Expanded expression: "-32768 "
; Expression value: -32768
; Fused expression:    "-32768 "
	ldd	R0,#-32768 ; // mov	eax, const_32
	mjmp	L65
	align	2
L74:
; RPN'ized expression: "inputbuf opcode + *u newchar = "
; Expanded expression: "(@-12) (@-20) *(1) + newchar *(1) =(1) "
; Fused expression:    "+ (@-12) *(@-20) =(153) *ax *newchar "
	ldd	R10,#-12 ; lea	eax, [ebp-ofs]
	add	R0,R10,R13
	ldd	R11,#-20 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movb	R2,@R11
	add	R0,R0,R2 ; add eax,[ebp-ofs]
	mov	R1,R0 ; mov ebx, eax
	ldd	R10,$_newchar
	add	R10,R10,R4
	movb	R0,@R10
	movb	@R1,R0
; }
	sjmp	L68
	align	2
L70:
; return
; RPN'ized expression: "32768 -u "
; Expanded expression: "-32768 "
; Expression value: -32768
; Fused expression:    "-32768 "
	ldd	R0,#-32768 ; // mov	eax, const_32
	mjmp	L65
; exit_usrinput:
	align	2
L73:
; RPN'ized expression: "inputpos inputbuf = "
; Expanded expression: "inputpos (@-12) =(4) "
; Fused expression:    "=(204) *inputpos (@-12) "
	ldd	R10,#-12 ; lea	eax, [ebp-ofs]
	add	R0,R10,R13
	ldd	R10,$_inputpos
	add	R10,R10,R4
	movd	@R10,R0
; if
; RPN'ized expression: "inputpos *u 45 == "
; Expanded expression: "inputpos *(4) *(1) 45 == "
; Fused expression:    "*(4) inputpos == *ax 45 IF! "
	ldd	R10,$_inputpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#45
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L78
; {
; RPN'ized expression: "neg_input 1 = "
; Expanded expression: "(@-16) 1 =(1) "
; Fused expression:    "=(156) *(@-16) 1 "
	ldd	R0,#1 ; // mov	eax, const_32
	ldd	R10,#-16 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
; RPN'ized expression: "inputpos ++p "
; Expanded expression: "inputpos ++p(4) "
; Fused expression:    "++p(4) *inputpos "
	ldd	R10,$_inputpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; }
	sjmp	L79
	align	2
L78:
; else
; if
; RPN'ized expression: "inputpos *u 48 == "
; Expanded expression: "inputpos *(4) *(1) 48 == "
; Fused expression:    "*(4) inputpos == *ax 48 IF! "
	ldd	R10,$_inputpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#48
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L80
; {
; RPN'ized expression: "inputpos ++p "
; Expanded expression: "inputpos ++p(4) "
; Fused expression:    "++p(4) *inputpos "
	ldd	R10,$_inputpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0 "
	ldd	R0,#0 ; // mov	eax, const_32
	mjmp	L65
; }
	align	2
L80:
	align	2
L79:
; if
; RPN'ized expression: "inputpos *u 47 > inputpos *u 58 < && "
; Expanded expression: "inputpos *(4) *(1) 47 > [sh&&->84] inputpos *(4) *(1) 58 < &&[84] "
; Fused expression:    "*(4) inputpos > *ax 47 [sh&&->84] *(4) inputpos < *ax 58 &&[84] "
	ldd	R10,$_inputpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#47
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC10
	BITSNZ	R12,#31
	sjmp	LC11
	ldb	R0,#0
LC10:
	subslt	R12,R10,R12 ; jae	label
	ldb	R0,#0
LC11:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L84
	ldd	R10,$_inputpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#58
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC12
	BITSNZ	R10,#31
	sjmp	LC13
	ldb	R0,#0
LC12:
	subslt	R12,R12,R10 ; jae	label
	ldb	R0,#0
LC13:
	align	2
L84:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L82
; {
; do
	align	2
L85:
; {
; RPN'ized expression: "a a 10 * inputpos *u + 48 - = "
; Expanded expression: "(@-4) (@-4) *(-2) 10 * inputpos *(4) *(1) + 48 - =(-2) "
; Fused expression:    "* *(@-4) 10 push-ax *(4) inputpos + *sp *ax - ax 48 =(108) *(@-4) ax "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	ldd	R10,#10
	mul	R0,R0,R10 ; mul	eax, 2
	incs	R14,R14,#-4;
	movd	@R14,R0 ; Push	eax 
	ldd	R10,$_inputpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1, R0
	movb	R2,@R1
	movd	R0,@R14 ; // pop	eax
	incs	R14,R14,#4
	add	R0,R0,R2 ; add eax, ecx
	ldb	R10,#48
	subslt	R0,R0,R10
 ; sub eax, const32
	and	R0,R0,R0
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; RPN'ized expression: "inputpos ++p "
; Expanded expression: "inputpos ++p(4) "
; Fused expression:    "++p(4) *inputpos "
	ldd	R10,$_inputpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; }
; while
; RPN'ized expression: "inputpos *u 47 > inputpos *u 58 < && "
; Expanded expression: "inputpos *(4) *(1) 47 > [sh&&->88] inputpos *(4) *(1) 58 < &&[88] "
	align	2
L86:
; Fused expression:    "*(4) inputpos > *ax 47 [sh&&->88] *(4) inputpos < *ax 58 &&[88] "
	ldd	R10,$_inputpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#47
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC14
	BITSNZ	R12,#31
	sjmp	LC15
	ldb	R0,#0
LC14:
	subslt	R12,R10,R12 ; jae	label
	ldb	R0,#0
LC15:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L88
	ldd	R10,$_inputpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#58
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC16
	BITSNZ	R10,#31
	sjmp	LC17
	ldb	R0,#0
LC16:
	subslt	R12,R12,R10 ; jae	label
	ldb	R0,#0
LC17:
	align	2
L88:
; JumpIfNotZero
	tstsnz	R0,R0 ; jne	label
	sjmp	LC18
	sjmp	L85
LC18:
	align	2
L87:
; }
	align	2
L82:
; if
; RPN'ized expression: "neg_input 1 == "
; Expanded expression: "(@-16) *(1) 1 == "
; Fused expression:    "== *(@-16) 1 IF! "
	ldd	R10,#-16; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	ldb	R10,#1
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L89
; RPN'ized expression: "a a -u = "
; Expanded expression: "(@-4) (@-4) *(-2) -u =(-2) "
; Fused expression:    "*(-2) (@-4) -u =(108) *(@-4) ax "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	not	R0,R0 ; neg	eax
	incs	R0,R0,#1
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
	align	2
L89:
; return
; RPN'ized expression: "a "
; Expanded expression: "(@-4) *(-2) "
; Fused expression:    "*(-2) (@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	mjmp	L65
	align	2
L65:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L64:
	ldd	R10,#20 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L63
; glb line_terminator : (void) void
	align	2
_line_terminator:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L92
	align	2
L91:
; RPN'ized expression: "( 10 outchar ) "
; Expanded expression: " 10  outchar ()4 "
; Fused expression:    "( 10 , outchar )4 "
	incs	R14,R14,#-4
	LDD	R10,#10
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_outchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; RPN'ized expression: "( 13 outchar ) "
; Expanded expression: " 13  outchar ()4 "
; Fused expression:    "( 13 , outchar )4 "
	incs	R14,R14,#-4
	LDD	R10,#13
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_outchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	align	2
L93:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L92:
	mjmp	L91
; glb ignore_blanks : (void) void
	align	2
_ignore_blanks:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L96
	align	2
L95:
; while
; RPN'ized expression: "txtpos *u 32 == txtpos *u 9 == || "
; Expanded expression: "txtpos *(4) *(1) 32 == [sh||->101] txtpos *(4) *(1) 9 == ||[101] "
	align	2
L99:
; Fused expression:    "*(4) txtpos == *ax 32 [sh||->101] *(4) txtpos == *ax 9 ||[101] "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#32
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
; JumpIfNotZero
	tstsnz	R0,R0 ; jne	label
	sjmp	LC19
	sjmp	L101
LC19:
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#9
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
	align	2
L101:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L100
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
	sjmp	L99
	align	2
L100:
	align	2
L97:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L96:
	mjmp	L95
; glb scantable : (
; prm     table : * unsigned char
;     ) void
	align	2
_scantable:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L103
	align	2
L102:
; loc     table : (@8): * unsigned char
; loc     i : (@-4): int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-4) 0 =(4) "
; Fused expression:    "=(204) *(@-4) 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "table_index 0 = "
; Expanded expression: "table_index 0 =(1) "
; Fused expression:    "=(156) *table_index 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,$_table_index
	add	R10,R10,R4
	movb	@R10,R0
; while
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
	align	2
L106:
; Fused expression:    "1 "
	ldd	R0,#1 ; // mov	eax, const_32
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L107
; {
; if
; RPN'ized expression: "table 0 + *u 0 == "
; Expanded expression: "(@8) *(4) 0 + *(1) 0 == "
; Fused expression:    "+ *(@8) 0 == *ax 0 IF! "
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#0
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L108
; return
	mjmp	L104
	align	2
L108:
; if
; RPN'ized expression: "txtpos i + *u table 0 + *u == "
; Expanded expression: "txtpos *(4) (@-4) *(4) + *(1) (@8) *(4) 0 + *(1) == "
; Fused expression:    "+ *txtpos *(@-4) push-ax + *(@8) 0 == **sp *ax IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R11,#-4 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movd	R10,@R11
	add	R0,R0,R10 ; add eax,[ebp-ofs]
	incs	R14,R14,#-4;
	movd	@R14,R0 ; Push	eax 
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#0
	add	R0,R0,R10 ; add eax, const32
	mov	R1, R0
	movb	R2,@R1
	movd	R1,@R14 ; // pop	ebx
	incs	R14,R14,#4
	movb	R0,@R1
	MOV	R10,R2 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L110
; {
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-4) ++p(4) "
; Fused expression:    "++p(4) *(@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; RPN'ized expression: "table ++p "
; Expanded expression: "(@8) ++p(4) "
; Fused expression:    "++p(4) *(@8) "
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; }
	sjmp	L111
	align	2
L110:
; else
; {
; if
; RPN'ized expression: "txtpos i + *u 128 + table 0 + *u == "
; Expanded expression: "txtpos *(4) (@-4) *(4) + *(1) 128 + (@8) *(4) 0 + *(1) == "
; Fused expression:    "+ *txtpos *(@-4) + *ax 128 push-ax + *(@8) 0 == *sp *ax IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R11,#-4 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movd	R10,@R11
	add	R0,R0,R10 ; add eax,[ebp-ofs]
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#128
	add	R0,R0,R10 ; add eax, const32
	incs	R14,R14,#-4;
	movd	@R14,R0 ; Push	eax 
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#0
	add	R0,R0,R10 ; add eax, const32
	mov	R1, R0
	movb	R2,@R1
	movd	R0,@R14 ; // pop	eax
	incs	R14,R14,#4
	MOV	R10,R2 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L112
; {
; RPN'ized expression: "txtpos i 1 + += "
; Expanded expression: "txtpos (@-4) *(4) 1 + +=(4) "
; Fused expression:    "+ *(@-4) 1 +=(204) *txtpos ax "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#1
	add	R0,R0,R10 ; add eax, const32
	mov	R2,R0 ; mov ecx, eax
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	add	R0,R0,R2 ; add eax, ecx
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	@R10,R0
; RPN'ized expression: "( ignore_blanks ) "
; Expanded expression: " ignore_blanks ()0 "
; Fused expression:    "( ignore_blanks )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_ignore_blanks
; return
	mjmp	L104
; }
	align	2
L112:
; while
; RPN'ized expression: "table 0 + *u 128 & 0 == "
; Expanded expression: "(@8) *(4) 0 + *(1) 128 & 0 == "
	align	2
L114:
; Fused expression:    "+ *(@8) 0 & *ax 128 == ax 0 IF! "
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#0
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#128
	and	R0,R0,R10 ; and eax, const32
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L115
; RPN'ized expression: "table ++p "
; Expanded expression: "(@8) ++p(4) "
; Fused expression:    "++p(4) *(@8) "
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
	sjmp	L114
	align	2
L115:
; RPN'ized expression: "table ++p "
; Expanded expression: "(@8) ++p(4) "
; Fused expression:    "++p(4) *(@8) "
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; RPN'ized expression: "table_index ++p "
; Expanded expression: "table_index ++p(1) "
; Fused expression:    "++p(1) *table_index "
	ldd	R10,$_table_index
	add	R10,R10,R4
	movb	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movb	@R10,R11
; RPN'ized expression: "( ignore_blanks ) "
; Expanded expression: " ignore_blanks ()0 "
; Fused expression:    "( ignore_blanks )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_ignore_blanks
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-4) 0 =(4) "
; Fused expression:    "=(204) *(@-4) 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; }
	align	2
L111:
; }
	sjmp	L106
	align	2
L107:
	align	2
L104:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L103:
	ldd	R10,#4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L102
; glb pushb : (
; prm     b : unsigned char
;     ) void
	align	2
_pushb:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L117
	align	2
L116:
; loc     b : (@8): unsigned char
; RPN'ized expression: "sp --p "
; Expanded expression: "sp --p(4) "
; Fused expression:    "--p(4) *sp "
	ldd	R10,$_sp
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#-1
	movd	@R10,R11
; RPN'ized expression: "sp *u b = "
; Expanded expression: "sp *(4) (@8) *(1) =(1) "
; Fused expression:    "*(4) sp =(153) *ax *(@8) "
	ldd	R10,$_sp
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0 ; mov ebx, eax
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	movb	@R1,R0
	align	2
L118:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L117:
	mjmp	L116
; glb popb : () unsigned char
	align	2
_popb:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L121
	align	2
L120:
; loc     b : (@-4): unsigned char
; RPN'ized expression: "b sp *u = "
; Expanded expression: "(@-4) sp *(4) *(1) =(1) "
; Fused expression:    "*(4) sp =(153) *(@-4) *ax "
	ldd	R10,$_sp
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
; RPN'ized expression: "sp ++p "
; Expanded expression: "sp ++p(4) "
; Fused expression:    "++p(4) *sp "
	ldd	R10,$_sp
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; return
; RPN'ized expression: "b "
; Expanded expression: "(@-4) *(1) "
; Fused expression:    "*(1) (@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	mjmp	L122
	align	2
L122:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L121:
	ldd	R10,#4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L120
; glb divu10 : (
; prm     n : unsigned
;     ) unsigned
	align	2
_divu10:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L125
	align	2
L124:
; loc     n : (@8): unsigned
; loc     q : (@-4): unsigned
; loc     r : (@-8): unsigned
; RPN'ized expression: "q n 1 >> n 2 >> + = "
; Expanded expression: "(@-4) (@8) *(4) 1 >>u (@8) *(4) 2 >>u + =(4) "
; Fused expression:    ">>u *(@8) 1 push-ax >>u *(@8) 2 + *sp ax =(204) *(@-4) ax "
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	lsr	R0,R0 ; shr eax, 1
	incs	R14,R14,#-4;
	movd	@R14,R0 ; Push	eax 
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	mov	R2,R0 ; mov ecx, eax
	movd	R0,@R14 ; // pop	eax
	incs	R14,R14,#4
	add	R0,R0,R2 ; add eax, ecx
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "q q q 4 >> + = "
; Expanded expression: "(@-4) (@-4) *(4) (@-4) *(4) 4 >>u + =(4) "
; Fused expression:    ">>u *(@-4) 4 + *(@-4) ax =(204) *(@-4) ax "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	mov	R2,R0 ; mov ecx, eax
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	add	R0,R0,R2 ; add eax, ecx
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "q q q 8 >> + = "
; Expanded expression: "(@-4) (@-4) *(4) (@-4) *(4) 8 >>u + =(4) "
; Fused expression:    ">>u *(@-4) 8 + *(@-4) ax =(204) *(@-4) ax "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	mov	R2,R0 ; mov ecx, eax
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	add	R0,R0,R2 ; add eax, ecx
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "q q q 16 >> + = "
; Expanded expression: "(@-4) (@-4) *(4) (@-4) *(4) 16 >>u + =(4) "
; Fused expression:    ">>u *(@-4) 16 + *(@-4) ax =(204) *(@-4) ax "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	mov	R2,R0 ; mov ecx, eax
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	add	R0,R0,R2 ; add eax, ecx
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "q q 3 >> = "
; Expanded expression: "(@-4) (@-4) *(4) 3 >>u =(4) "
; Fused expression:    ">>u *(@-4) 3 =(204) *(@-4) ax "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "r n q 2 << q + 1 << - = "
; Expanded expression: "(@-8) (@8) *(4) (@-4) *(4) 2 << (@-4) *(4) + 1 << - =(4) "
; Fused expression:    "<< *(@-4) 2 + ax *(@-4) << ax 1 - *(@8) ax =(204) *(@-8) ax "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	add	R0,R0,R0 ; shl eax, 1
	add	R0,R0,R0 ; shl eax, 1
	ldd	R11,#-4 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movd	R10,@R11
	add	R0,R0,R10 ; add eax,[ebp-ofs]
	add	R0,R0,R0 ; shl eax, 1
	mov	R2,R0 ; mov ecx, eax
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	subslt	R0,R0,R2
 ; sub eax, ecx
	and	R0,R0,R0
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; return
; RPN'ized expression: "q r 9 > 0 1 ? + "
; Expanded expression: "(@-4) *(4) (@-8) *(4) 9 >u [sh||->128] 0 goto &&[128] 1 &&[129] + "
; Fused expression:    ">u *(@-8) 9 [sh||->128] 0 [goto->129] &&[128] 1 &&[129] + *(@-4) ax "
	ldd	R10,#-8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#9
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#0
	subslt	R12,R12,R10
	ldb	R0,#1
	tstsnz	R12,R12
	ldb	R0,#0
; JumpIfNotZero
	tstsnz	R0,R0 ; jne	label
	sjmp	LC20
	sjmp	L128
LC20:
	ldd	R0,#0 ; // mov	eax, const_32
	sjmp	L129
	align	2
L128:
	ldd	R0,#1 ; // mov	eax, const_32
	align	2
L129:
	mov	R2,R0 ; mov ecx, eax
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	add	R0,R0,R2 ; add eax, ecx
	mjmp	L126
	align	2
L126:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L125:
	ldd	R10,#8 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L124
; glb printnum : (
; prm     n : int
;     ) void
	align	2
_printnum:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L131
	align	2
L130:
; loc     n : (@8): int
; loc     q : (@-4): unsigned
; loc     r : (@-8): int
; loc     x : (@-12): unsigned char
; loc     i : (@-16): unsigned char
; loc     leadzeroflag : (@-20): unsigned char
; RPN'ized expression: "q 1000000000 = "
; Expanded expression: "(@-4) 1000000000 =(4) "
; Fused expression:    "=(204) *(@-4) 1000000000 "
	ldd	R0,#1000000000 ; // mov	eax, const_32
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "leadzeroflag 0 = "
; Expanded expression: "(@-20) 0 =(1) "
; Fused expression:    "=(156) *(@-20) 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,#-20 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
; RPN'ized expression: "x 0 = "
; Expanded expression: "(@-12) 0 =(1) "
; Fused expression:    "=(156) *(@-12) 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,#-12 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
; if
; RPN'ized expression: "n 2147483648u & "
; Expanded expression: "(@8) *(4) 2147483648u & "
; Fused expression:    "& *(@8) 2147483648u "
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldd	R10,#-2147483648
	and	R0,R0,R10 ; and eax, const32
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L134
; {
; RPN'ized expression: "( 45 outchar ) "
; Expanded expression: " 45  outchar ()4 "
; Fused expression:    "( 45 , outchar )4 "
	incs	R14,R14,#-4
	LDD	R10,#45
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_outchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; RPN'ized expression: "r n -u = "
; Expanded expression: "(@-8) (@8) *(4) -u =(4) "
; Fused expression:    "*(4) (@8) -u =(204) *(@-8) ax "
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	not	R0,R0 ; neg	eax
	incs	R0,R0,#1
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; }
	sjmp	L135
	align	2
L134:
; else
; {
; RPN'ized expression: "r n = "
; Expanded expression: "(@-8) (@8) *(4) =(4) "
; Fused expression:    "=(204) *(@-8) *(@8) "
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; }
	align	2
L135:
; while
; RPN'ized expression: "x 0 == "
; Expanded expression: "(@-12) *(1) 0 == "
	align	2
L136:
; Fused expression:    "== *(@-12) 0 IF! "
	ldd	R10,#-12; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L137
; {
; RPN'ized expression: "i 48 = "
; Expanded expression: "(@-16) 48 =(1) "
; Fused expression:    "=(156) *(@-16) 48 "
	ldd	R0,#48 ; // mov	eax, const_32
	ldd	R10,#-16 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
; repeat_loopi:
	align	2
L138:
; if
; RPN'ized expression: "q r < q r == || "
; Expanded expression: "(@-4) *(4) (@-8) *(4) <u [sh||->141] (@-4) *(4) (@-8) *(4) == ||[141] "
; Fused expression:    "<u *(@-4) *(@-8) [sh||->141] == *(@-4) *(@-8) ||[141] "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldd	R11,#-8 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movd	R10,@R11
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#0
	subslt	R12,R10,R12
	ldb	R0,#1
	tstsnz	R12,R12
	ldb	R0,#0
; JumpIfNotZero
	tstsnz	R0,R0 ; jne	label
	sjmp	LC21
	sjmp	L141
LC21:
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldd	R11,#-8 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movd	R10,@R11
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
	align	2
L141:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L139
; {
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-16) ++p(1) "
; Fused expression:    "++p(1) *(@-16) "
	ldd	R10,#-16; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movb	@R10,R11
; RPN'ized expression: "r r q - = "
; Expanded expression: "(@-8) (@-8) *(4) (@-4) *(4) - =(4) "
; Fused expression:    "- *(@-8) *(@-4) =(204) *(@-8) ax "
	ldd	R10,#-8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldd	R11,#-4 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movd	R10,@R11
	subslt	R0,R0,R10
 ; sub eax,[ebp-ofs]
	and	R0,R0,R0
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "leadzeroflag 1 = "
; Expanded expression: "(@-20) 1 =(1) "
; Fused expression:    "=(156) *(@-20) 1 "
	ldd	R0,#1 ; // mov	eax, const_32
	ldd	R10,#-20 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
; goto repeat_loopi
	mjmp	L138
; }
	sjmp	L140
	align	2
L139:
; else
; {
; if
; RPN'ized expression: "q 1 == "
; Expanded expression: "(@-4) *(4) 1 == "
; Fused expression:    "== *(@-4) 1 IF! "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#1
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L142
; {
; if
; RPN'ized expression: "leadzeroflag 0 == "
; Expanded expression: "(@-20) *(1) 0 == "
; Fused expression:    "== *(@-20) 0 IF! "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L144
; RPN'ized expression: "( i outchar ) "
; Expanded expression: " (@-16) *(1)  outchar ()4 "
; Fused expression:    "( *(1) (@-16) , outchar )4 "
	ldd	R10,#-16; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	incs	R14,R14,#-4
	movd	@R14,R0
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_outchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	align	2
L144:
; RPN'ized expression: "x 1 = "
; Expanded expression: "(@-12) 1 =(1) "
; Fused expression:    "=(156) *(@-12) 1 "
	ldd	R0,#1 ; // mov	eax, const_32
	ldd	R10,#-12 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
; }
	align	2
L142:
; if
; RPN'ized expression: "leadzeroflag "
; Expanded expression: "(@-20) *(1) "
; Fused expression:    "*(1) (@-20) "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L146
; RPN'ized expression: "( i outchar ) "
; Expanded expression: " (@-16) *(1)  outchar ()4 "
; Fused expression:    "( *(1) (@-16) , outchar )4 "
	ldd	R10,#-16; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	incs	R14,R14,#-4
	movd	@R14,R0
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_outchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	align	2
L146:
; RPN'ized expression: "q ( q divu10 ) = "
; Expanded expression: "(@-4)  (@-4) *(4)  divu10 ()4 =(4) "
; Fused expression:    "( *(4) (@-4) , divu10 )4 =(204) *(@-4) ax "
	ldd	R11,#-4 ; push [ebp-ofs]
	add	R11,R11,R13
	movd	R12,@R11
	incs	R14,R14,#-4;
	movd	@R14,R12
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_divu10
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; }
	align	2
L140:
; }
	sjmp	L136
	align	2
L137:
	align	2
L132:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L131:
	ldd	R10,#20 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L130
; glb testnum : (void) unsigned short
	align	2
_testnum:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L149
	align	2
L148:
; loc     num : (@-4): unsigned short
; RPN'ized expression: "num 0 = "
; Expanded expression: "(@-4) 0 =(2) "
; Fused expression:    "=(204) *(@-4) 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "( ignore_blanks ) "
; Expanded expression: " ignore_blanks ()0 "
; Fused expression:    "( ignore_blanks )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_ignore_blanks
; while
; RPN'ized expression: "txtpos *u 47 > txtpos *u 58 < && "
; Expanded expression: "txtpos *(4) *(1) 47 > [sh&&->154] txtpos *(4) *(1) 58 < &&[154] "
	align	2
L152:
; Fused expression:    "*(4) txtpos > *ax 47 [sh&&->154] *(4) txtpos < *ax 58 &&[154] "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#47
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC22
	BITSNZ	R12,#31
	sjmp	LC23
	ldb	R0,#0
LC22:
	subslt	R12,R10,R12 ; jae	label
	ldb	R0,#0
LC23:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L154
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#58
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC24
	BITSNZ	R10,#31
	sjmp	LC25
	ldb	R0,#0
LC24:
	subslt	R12,R12,R10 ; jae	label
	ldb	R0,#0
LC25:
	align	2
L154:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L153
; {
; if
; RPN'ized expression: "num 6552 > "
; Expanded expression: "(@-4) *(2) 6552 > "
; Fused expression:    "> *(@-4) 6552 IF! "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movw	R0,@R10
	ldw	R10,#6552
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12
	sjmp	L155
	XOR	R12,R0,R10
	BITSNZ	R12,#31
	sjmp	LC26
	BITSNZ	R0,#31
	sjmp	LC27
	sjmp	L155
LC26:
	subslt	R12,R10,R0 ; jle	label
	sjmp	L155
LC27:
; {
; RPN'ized expression: "num 65535 = "
; Expanded expression: "(@-4) 65535 =(2) "
; Fused expression:    "=(172) *(@-4) 65535 "
	ldd	R0,#65535 ; // mov	eax, const_32
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; break
	sjmp	L153
; }
	align	2
L155:
; RPN'ized expression: "num num 10 * txtpos *u + 48 - = "
; Expanded expression: "(@-4) (@-4) *(2) 10 * txtpos *(4) *(1) + 48 - =(2) "
; Fused expression:    "* *(@-4) 10 push-ax *(4) txtpos + *sp *ax - ax 48 =(172) *(@-4) ax "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movw	R0,@R10
	ldd	R10,#10
	mul	R0,R0,R10 ; mul	eax, 2
	incs	R14,R14,#-4;
	movd	@R14,R0 ; Push	eax 
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1, R0
	movb	R2,@R1
	movd	R0,@R14 ; // pop	eax
	incs	R14,R14,#4
	add	R0,R0,R2 ; add eax, ecx
	ldb	R10,#48
	subslt	R0,R0,R10
 ; sub eax, const32
	and	R0,R0,R0
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; }
	sjmp	L152
	align	2
L153:
; return
; RPN'ized expression: "num "
; Expanded expression: "(@-4) *(2) "
; Fused expression:    "*(2) (@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movw	R0,@R10
	mjmp	L150
	align	2
L150:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L149:
	ldd	R10,#4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L148
; glb printmsgNoNL : (
; prm     msg : * unsigned char
;     ) void
	align	2
_printmsgNoNL:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L158
	align	2
L157:
; loc     msg : (@8): * unsigned char
; while
; RPN'ized expression: "msg *u "
; Expanded expression: "(@8) *(4) *(1) "
	align	2
L161:
; Fused expression:    "*(4) (@8) *(1) ax "
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L162
; {
; RPN'ized expression: "( msg *u outchar ) "
; Expanded expression: " (@8) *(4) *(1)  outchar ()4 "
; Fused expression:    "( *(4) (@8) *(1) ax , outchar )4 "
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	incs	R14,R14,#-4
	movd	@R14,R0
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_outchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; RPN'ized expression: "msg ++p "
; Expanded expression: "(@8) ++p(4) "
; Fused expression:    "++p(4) *(@8) "
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; }
	sjmp	L161
	align	2
L162:
	align	2
L159:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L158:
	mjmp	L157
; glb print_quoted_string : (void) unsigned char
	align	2
_print_quoted_string:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L164
	align	2
L163:
; loc     i : (@-4): int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-4) 0 =(4) "
; Fused expression:    "=(204) *(@-4) 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; loc     delim : (@-8): unsigned char
; RPN'ized expression: "delim txtpos *u = "
; Expanded expression: "(@-8) txtpos *(4) *(1) =(1) "
; Fused expression:    "*(4) txtpos =(201) *(@-8) *ax "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; if
; RPN'ized expression: "delim 34 != delim 39 != && "
; Expanded expression: "(@-8) *(1) 34 != [sh&&->169] (@-8) *(1) 39 != &&[169] "
; Fused expression:    "!= *(@-8) 34 [sh&&->169] != *(@-8) 39 &&[169] "
	ldd	R10,#-8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	ldb	R10,#34
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L169
	ldd	R10,#-8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	ldb	R10,#39
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
	align	2
L169:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L167
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0 "
	ldd	R0,#0 ; // mov	eax, const_32
	mjmp	L165
	align	2
L167:
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; while
; RPN'ized expression: "txtpos i + *u delim != "
; Expanded expression: "txtpos *(4) (@-4) *(4) + *(1) (@-8) *(1) != "
	align	2
L170:
; Fused expression:    "+ *txtpos *(@-4) != *ax *(@-8) IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R11,#-4 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movd	R10,@R11
	add	R0,R0,R10 ; add eax,[ebp-ofs]
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldd	R11,#-8 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movb	R2,@R11
	MOV	R10,R2 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L171
; {
; if
; RPN'ized expression: "txtpos i + *u 10 == "
; Expanded expression: "txtpos *(4) (@-4) *(4) + *(1) 10 == "
; Fused expression:    "+ *txtpos *(@-4) == *ax 10 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R11,#-4 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movd	R10,@R11
	add	R0,R0,R10 ; add eax,[ebp-ofs]
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L172
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0 "
	ldd	R0,#0 ; // mov	eax, const_32
	mjmp	L165
	align	2
L172:
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-4) ++p(4) "
; Fused expression:    "++p(4) *(@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; }
	sjmp	L170
	align	2
L171:
; while
; RPN'ized expression: "txtpos *u delim != "
; Expanded expression: "txtpos *(4) *(1) (@-8) *(1) != "
	align	2
L174:
; Fused expression:    "*(4) txtpos != *ax *(@-8) IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldd	R11,#-8 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movb	R2,@R11
	MOV	R10,R2 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L175
; {
; RPN'ized expression: "( txtpos *u outchar ) "
; Expanded expression: " txtpos *(4) *(1)  outchar ()4 "
; Fused expression:    "( *(4) txtpos *(1) ax , outchar )4 "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	incs	R14,R14,#-4
	movd	@R14,R0
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_outchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; }
	sjmp	L174
	align	2
L175:
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; return
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
; Fused expression:    "1 "
	ldd	R0,#1 ; // mov	eax, const_32
	mjmp	L165
	align	2
L165:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L164:
	ldd	R10,#8 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L163
; glb printmsg : (
; prm     msg : * unsigned char
;     ) void
	align	2
_printmsg:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L177
	align	2
L176:
; loc     msg : (@8): * unsigned char
; RPN'ized expression: "( msg printmsgNoNL ) "
; Expanded expression: " (@8) *(4)  printmsgNoNL ()4 "
; Fused expression:    "( *(4) (@8) , printmsgNoNL )4 "
	ldd	R11,#8 ; push [ebp-ofs]
	add	R11,R11,R13
	movd	R12,@R11
	incs	R14,R14,#-4;
	movd	@R14,R12
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_printmsgNoNL
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; RPN'ized expression: "( line_terminator ) "
; Expanded expression: " line_terminator ()0 "
; Fused expression:    "( line_terminator )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_line_terminator
	align	2
L178:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L177:
	mjmp	L176
; glb getln : (
; prm     prompt : char
;     ) void
	align	2
_getln:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L181
	align	2
L180:
; loc     prompt : (@8): char
; loc     inbuf_charcount : (@-4): unsigned char
; RPN'ized expression: "inbuf_charcount 0 = "
; Expanded expression: "(@-4) 0 =(1) "
; Fused expression:    "=(204) *(@-4) 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "( prompt outchar ) "
; Expanded expression: " (@8) *(-1)  outchar ()4 "
; Fused expression:    "( *(-1) (@8) , outchar )4 "
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	bitsz	R0,#7
	add	R0,R0,R9 ; extend char sign bit if needed
	incs	R14,R14,#-4
	movd	@R14,R0
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_outchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; loc     <something> : unsigned short
; RPN'ized expression: "txtpos program_end <something184> sizeof + = "
; Expanded expression: "txtpos program_end *(4) 2u + =(4) "
; Fused expression:    "+ *program_end 2u =(204) *txtpos ax "
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#2
	add	R0,R0,R10 ; add eax, const32
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	@R10,R0
; RPN'ized expression: "dataptr 0 = "
; Expanded expression: "dataptr 0 =(2) "
; Fused expression:    "=(172) *dataptr 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,$_dataptr
	add	R10,R10,R4
	movw	@R10,R0
; while
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
	align	2
L185:
; Fused expression:    "1 "
	ldd	R0,#1 ; // mov	eax, const_32
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L186
; {
; RPN'ized expression: "opcode ( inchar ) = "
; Expanded expression: "opcode  inchar ()0 =(1) "
; Fused expression:    "( inchar )0 =(156) *opcode ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_inchar
	ldd	R10,$_opcode
	add	R10,R10,R4
	movb	@R10,R0
; switch
; RPN'ized expression: "opcode "
; Expanded expression: "opcode *(1) "
; Fused expression:    "*(1) opcode "
	ldd	R10,$_opcode
	add	R10,R10,R4
	movb	R0,@R10
	sjmp	L188
; {
; case
; RPN'ized expression: "10 "
; Expanded expression: "10 "
; Expression value: 10
	align	2
L189:
; break
	sjmp	L187
; case
; RPN'ized expression: "13 "
; Expanded expression: "13 "
; Expression value: 13
	align	2
L190:
; RPN'ized expression: "( line_terminator ) "
; Expanded expression: " line_terminator ()0 "
; Fused expression:    "( line_terminator )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_line_terminator
; RPN'ized expression: "txtpos 0 + *u 10 = "
; Expanded expression: "txtpos *(4) 0 + 10 =(1) "
; Fused expression:    "+ *txtpos 0 =(156) *ax 10 "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#0
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0 ; mov ebx, eax
	ldd	R0,#10 ; // mov	eax, const_32
	movb	@R1,R0
; return
	mjmp	L182
; case
; RPN'ized expression: "8 "
; Expanded expression: "8 "
; Expression value: 8
	align	2
L191:
; if
; RPN'ized expression: "txtpos program_end == "
; Expanded expression: "txtpos *(4) program_end *(4) == "
; Fused expression:    "== *txtpos *program_end IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	R11,@R10
	MOV	R10,R11 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L192
; break
	sjmp	L187
	align	2
L192:
; RPN'ized expression: "txtpos --p "
; Expanded expression: "txtpos --p(4) "
; Fused expression:    "--p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#-1
	movd	@R10,R11
; goto skip_whitespace
	mjmp	L194
; default
	align	2
L195:
; if
; RPN'ized expression: "txtpos variables_begin 2 - == "
; Expanded expression: "txtpos *(4) variables_begin *(4) 2 - == "
; Fused expression:    "- *variables_begin 2 == *txtpos ax IF! "
	ldd	R10,$_variables_begin
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#2
	subslt	R0,R0,R10
 ; sub eax, const32
	and	R0,R0,R0
	mov	R2,R0 ; mov ecx, eax
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	MOV	R10,R2 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L196
; RPN'ized expression: "( 8 outchar ) "
; Expanded expression: " 8  outchar ()4 "
; Fused expression:    "( 8 , outchar )4 "
	incs	R14,R14,#-4
	LDD	R10,#8
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_outchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	sjmp	L197
	align	2
L196:
; else
; {
; if
; RPN'ized expression: "opcode 32 == inbuf_charcount 0 == && "
; Expanded expression: "opcode *(1) 32 == [sh&&->200] (@-4) *(1) 0 == &&[200] "
; Fused expression:    "== *opcode 32 [sh&&->200] == *(@-4) 0 &&[200] "
	ldd	R10,$_opcode
	add	R10,R10,R4
	movb	R0,@R10
	ldb	R10,#32
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L200
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	ldb	R10,#0
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
	align	2
L200:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L198
; {
; RPN'ized expression: "inbuf_charcount --p "
; Expanded expression: "(@-4) --p(1) "
; Fused expression:    "--p(1) *(@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R11,@R10
	mov	R0,R11
	incs	R11,R11,#-1
	movb	@R10,R11
; goto skip_whitespace
	mjmp	L194
; }
	align	2
L198:
; RPN'ized expression: "txtpos 0 + *u opcode = "
; Expanded expression: "txtpos *(4) 0 + opcode *(1) =(1) "
; Fused expression:    "+ *txtpos 0 =(153) *ax *opcode "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#0
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0 ; mov ebx, eax
	ldd	R10,$_opcode
	add	R10,R10,R4
	movb	R0,@R10
	movb	@R1,R0
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; skip_whitespace:
	align	2
L194:
; RPN'ized expression: "( opcode outchar ) "
; Expanded expression: " opcode *(1)  outchar ()4 "
; Fused expression:    "( *(1) opcode , outchar )4 "
	ldd	R10,$_opcode
	add	R10,R10,R4
	movb	R0,@R10
	incs	R14,R14,#-4
	movd	@R14,R0
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_outchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; }
	align	2
L197:
; }
	sjmp	L187
	align	2
L188:
	ldb	R10,#10 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L189
	ldb	R10,#13 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L190
	ldb	R10,#8 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L191
	sjmp	L195
	align	2
L187:
; RPN'ized expression: "inbuf_charcount ++p "
; Expanded expression: "(@-4) ++p(1) "
; Fused expression:    "++p(1) *(@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movb	@R10,R11
; }
	sjmp	L185
	align	2
L186:
	align	2
L182:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L181:
	ldd	R10,#4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L180
; glb findline : (void) * unsigned char
	align	2
_findline:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L202
	align	2
L201:
; loc     line : (@-4): * unsigned char
; RPN'ized expression: "line program_start = "
; Expanded expression: "(@-4) program_start *(4) =(4) "
; Fused expression:    "=(204) *(@-4) *program_start "
	ldd	R10,$_program_start
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; while
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
	align	2
L205:
; Fused expression:    "1 "
	ldd	R0,#1 ; // mov	eax, const_32
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L206
; {
; if
; RPN'ized expression: "line program_end == "
; Expanded expression: "(@-4) *(4) program_end *(4) == "
; Fused expression:    "== *(@-4) *program_end IF! "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	R11,@R10
	MOV	R10,R11 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L207
; return
; RPN'ized expression: "line "
; Expanded expression: "(@-4) *(4) "
; Fused expression:    "*(4) (@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mjmp	L203
	align	2
L207:
; if
; loc         <something> : * unsigned short
; RPN'ized expression: "line (something211) 0 + *u linenum >= "
; Expanded expression: "(@-4) *(4) 0 + *(2) linenum *(2) >= "
; Fused expression:    "+ *(@-4) 0 >= *ax *linenum IF! "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#0
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movw	R0,@R1; mov	ax, [bx]
	ldd	R10,$_linenum
	add	R10,R10,R4
	movw	R2,@R10
	MOV	R10,R2 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; jne	label
	sjmp	AC0
	BITSNZ	R12,#31
	sjmp	LC28
	BITSNZ	R0,#31
	sjmp	LC29
	sjmp	L209
LC28:
	subslt	R12,R10,R0 ; jl	label
	sjmp	L209
LC29:
AC0:
; return
; RPN'ized expression: "line "
; Expanded expression: "(@-4) *(4) "
; Fused expression:    "*(4) (@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mjmp	L203
	align	2
L209:
; loc         <something> : unsigned short
; RPN'ized expression: "line line <something212> sizeof + *u += "
; Expanded expression: "(@-4) (@-4) *(4) 2u + *(1) +=(4) "
; Fused expression:    "+ *(@-4) 2u +=(201) *(@-4) *ax "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#2
	add	R0,R0,R10 ; add eax, const32
	mov	R1, R0
	movb	R2,@R1
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	add	R0,R0,R2 ; add eax, ecx
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; }
	sjmp	L205
	align	2
L206:
	align	2
L203:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L202:
	ldd	R10,#4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L201
; glb toUppercaseBuffer : (void) void
	align	2
_toUppercaseBuffer:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L214
	align	2
L213:
; loc     c : (@-4): * unsigned char
; loc     <something> : unsigned short
; RPN'ized expression: "c program_end <something217> sizeof + = "
; Expanded expression: "(@-4) program_end *(4) 2u + =(4) "
; Fused expression:    "+ *program_end 2u =(204) *(@-4) ax "
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#2
	add	R0,R0,R10 ; add eax, const32
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; loc     quote : (@-8): unsigned char
; RPN'ized expression: "quote 0 = "
; Expanded expression: "(@-8) 0 =(1) "
; Fused expression:    "=(204) *(@-8) 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; while
; RPN'ized expression: "c *u 10 != "
; Expanded expression: "(@-4) *(4) *(1) 10 != "
	align	2
L218:
; Fused expression:    "*(4) (@-4) != *ax 10 IF! "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L219
; {
; if
; RPN'ized expression: "c *u quote == "
; Expanded expression: "(@-4) *(4) *(1) (@-8) *(1) == "
; Fused expression:    "*(4) (@-4) == *ax *(@-8) IF! "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldd	R11,#-8 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movb	R2,@R11
	MOV	R10,R2 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L220
; RPN'ized expression: "quote 0 = "
; Expanded expression: "(@-8) 0 =(1) "
; Fused expression:    "=(156) *(@-8) 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
	sjmp	L221
	align	2
L220:
; else
; if
; RPN'ized expression: "c *u 34 == c *u 39 == || "
; Expanded expression: "(@-4) *(4) *(1) 34 == [sh||->224] (@-4) *(4) *(1) 39 == ||[224] "
; Fused expression:    "*(4) (@-4) == *ax 34 [sh||->224] *(4) (@-4) == *ax 39 ||[224] "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#34
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
; JumpIfNotZero
	tstsnz	R0,R0 ; jne	label
	sjmp	LC30
	sjmp	L224
LC30:
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#39
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
	align	2
L224:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L222
; RPN'ized expression: "quote c *u = "
; Expanded expression: "(@-8) (@-4) *(4) *(1) =(1) "
; Fused expression:    "*(4) (@-4) =(153) *(@-8) *ax "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
	sjmp	L223
	align	2
L222:
; else
; if
; RPN'ized expression: "quote 0 == c *u 96 > && c *u 123 < && "
; Expanded expression: "(@-8) *(1) 0 == [sh&&->228] (@-4) *(4) *(1) 96 > &&[228] _Bool [sh&&->227] (@-4) *(4) *(1) 123 < &&[227] "
; Fused expression:    "== *(@-8) 0 [sh&&->228] *(4) (@-4) > *ax 96 &&[228] _Bool [sh&&->227] *(4) (@-4) < *ax 123 &&[227] "
	ldd	R10,#-8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	ldb	R10,#0
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L228
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#96
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC31
	BITSNZ	R12,#31
	sjmp	LC32
	ldb	R0,#0
LC31:
	subslt	R12,R10,R12 ; jae	label
	ldb	R0,#0
LC32:
	align	2
L228:
	mov	R12,R0
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
LC33:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L227
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#123
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC34
	BITSNZ	R10,#31
	sjmp	LC35
	ldb	R0,#0
LC34:
	subslt	R12,R12,R10 ; jae	label
	ldb	R0,#0
LC35:
	align	2
L227:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L225
; RPN'ized expression: "c *u c *u 65 + 97 - = "
; Expanded expression: "(@-4) *(4) (@-4) *(4) *(1) 65 + 97 - =(1) "
; Fused expression:    "*(4) (@-4) push-ax *(4) (@-4) + *ax 65 - ax 97 =(156) **sp ax "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	incs	R14,R14,#-4;
	movd	@R14,R0 ; Push	eax 
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#65
	add	R0,R0,R10 ; add eax, const32
	ldb	R10,#97
	subslt	R0,R0,R10
 ; sub eax, const32
	and	R0,R0,R0
	movd	R1,@R14 ; // pop	ebx
	incs	R14,R14,#4
	movb	@R1,R0
	align	2
L225:
	align	2
L223:
	align	2
L221:
; RPN'ized expression: "c ++p "
; Expanded expression: "(@-4) ++p(4) "
; Fused expression:    "++p(4) *(@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; }
	sjmp	L218
	align	2
L219:
	align	2
L215:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L214:
	ldd	R10,#8 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L213
; glb printline : () void
	align	2
_printline:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L230
	align	2
L229:
; loc     tempptr : (@-4): * unsigned char
; loc     line_num : (@-8): unsigned short
; loc     tempptr : (@-12): * unsigned short
; loc     <something> : * unsigned short
; RPN'ized expression: "tempptr list_line (something233) = "
; Expanded expression: "(@-12) list_line *(4) =(4) "
; Fused expression:    "=(204) *(@-12) *list_line "
	ldd	R10,$_list_line
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,#-12 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "line_num tempptr *u = "
; Expanded expression: "(@-8) (@-12) *(4) *(2) =(2) "
; Fused expression:    "*(4) (@-12) =(170) *(@-8) *ax "
	ldd	R10,#-12; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movw	R0,@R1; mov	ax, [bx]
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; loc     <something> : unsigned short
; RPN'ized expression: "list_line list_line <something234> sizeof + 1 + = "
; Expanded expression: "list_line list_line *(4) 3u + =(4) "
; Fused expression:    "+ *list_line 3u =(204) *list_line ax "
	ldd	R10,$_list_line
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#3
	add	R0,R0,R10 ; add eax, const32
	ldd	R10,$_list_line
	add	R10,R10,R4
	movd	@R10,R0
; RPN'ized expression: "( line_num printnum ) "
; Expanded expression: " (@-8) *(2)  printnum ()4 "
; Fused expression:    "( *(2) (@-8) , printnum )4 "
	ldd	R10,#-8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movw	R0,@R10
	incs	R14,R14,#-4
	movd	@R14,R0
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_printnum
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; RPN'ized expression: "( 32 outchar ) "
; Expanded expression: " 32  outchar ()4 "
; Fused expression:    "( 32 , outchar )4 "
	incs	R14,R14,#-4
	LDD	R10,#32
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_outchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; while
; RPN'ized expression: "list_line *u 10 != "
; Expanded expression: "list_line *(4) *(1) 10 != "
	align	2
L235:
; Fused expression:    "*(4) list_line != *ax 10 IF! "
	ldd	R10,$_list_line
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L236
; {
; RPN'ized expression: "( list_line *u outchar ) "
; Expanded expression: " list_line *(4) *(1)  outchar ()4 "
; Fused expression:    "( *(4) list_line *(1) ax , outchar )4 "
	ldd	R10,$_list_line
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	incs	R14,R14,#-4
	movd	@R14,R0
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_outchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; RPN'ized expression: "list_line ++p "
; Expanded expression: "list_line ++p(4) "
; Fused expression:    "++p(4) *list_line "
	ldd	R10,$_list_line
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; }
	sjmp	L235
	align	2
L236:
; RPN'ized expression: "list_line ++p "
; Expanded expression: "list_line ++p(4) "
; Fused expression:    "++p(4) *list_line "
	ldd	R10,$_list_line
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; RPN'ized expression: "( line_terminator ) "
; Expanded expression: " line_terminator ()0 "
; Fused expression:    "( line_terminator )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_line_terminator
	align	2
L231:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L230:
	ldd	R10,#12 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L229
; glb expr4 : (void) short
	align	2
_expr4:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L238
	align	2
L237:
; loc     a : (@-4): short
; RPN'ized expression: "a 0 = "
; Expanded expression: "(@-4) 0 =(-2) "
; Fused expression:    "=(204) *(@-4) 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; loc     f : (@-8): unsigned char
; if
; RPN'ized expression: "txtpos *u 48 == "
; Expanded expression: "txtpos *(4) *(1) 48 == "
; Fused expression:    "*(4) txtpos == *ax 48 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#48
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L241
; {
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0 "
	ldd	R0,#0 ; // mov	eax, const_32
	mjmp	L239
; }
	align	2
L241:
; if
; RPN'ized expression: "txtpos *u 48 > txtpos *u 58 < && "
; Expanded expression: "txtpos *(4) *(1) 48 > [sh&&->245] txtpos *(4) *(1) 58 < &&[245] "
; Fused expression:    "*(4) txtpos > *ax 48 [sh&&->245] *(4) txtpos < *ax 58 &&[245] "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#48
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC36
	BITSNZ	R12,#31
	sjmp	LC37
	ldb	R0,#0
LC36:
	subslt	R12,R10,R12 ; jae	label
	ldb	R0,#0
LC37:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L245
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#58
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC38
	BITSNZ	R10,#31
	sjmp	LC39
	ldb	R0,#0
LC38:
	subslt	R12,R12,R10 ; jae	label
	ldb	R0,#0
LC39:
	align	2
L245:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L243
; {
; do
	align	2
L246:
; {
; RPN'ized expression: "a a 10 * txtpos *u + 48 - = "
; Expanded expression: "(@-4) (@-4) *(-2) 10 * txtpos *(4) *(1) + 48 - =(-2) "
; Fused expression:    "* *(@-4) 10 push-ax *(4) txtpos + *sp *ax - ax 48 =(108) *(@-4) ax "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	ldd	R10,#10
	mul	R0,R0,R10 ; mul	eax, 2
	incs	R14,R14,#-4;
	movd	@R14,R0 ; Push	eax 
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1, R0
	movb	R2,@R1
	movd	R0,@R14 ; // pop	eax
	incs	R14,R14,#4
	add	R0,R0,R2 ; add eax, ecx
	ldb	R10,#48
	subslt	R0,R0,R10
 ; sub eax, const32
	and	R0,R0,R0
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; }
; while
; RPN'ized expression: "txtpos *u 47 > txtpos *u 58 < && "
; Expanded expression: "txtpos *(4) *(1) 47 > [sh&&->249] txtpos *(4) *(1) 58 < &&[249] "
	align	2
L247:
; Fused expression:    "*(4) txtpos > *ax 47 [sh&&->249] *(4) txtpos < *ax 58 &&[249] "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#47
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC40
	BITSNZ	R12,#31
	sjmp	LC41
	ldb	R0,#0
LC40:
	subslt	R12,R10,R12 ; jae	label
	ldb	R0,#0
LC41:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L249
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#58
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC42
	BITSNZ	R10,#31
	sjmp	LC43
	ldb	R0,#0
LC42:
	subslt	R12,R12,R10 ; jae	label
	ldb	R0,#0
LC43:
	align	2
L249:
; JumpIfNotZero
	tstsnz	R0,R0 ; jne	label
	sjmp	LC44
	sjmp	L246
LC44:
	align	2
L248:
; return
; RPN'ized expression: "a "
; Expanded expression: "(@-4) *(-2) "
; Fused expression:    "*(-2) (@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	mjmp	L239
; }
	align	2
L243:
; if
; RPN'ized expression: "txtpos 0 + *u 64 > txtpos 0 + *u 91 < && "
; Expanded expression: "txtpos *(4) 0 + *(1) 64 > [sh&&->252] txtpos *(4) 0 + *(1) 91 < &&[252] "
; Fused expression:    "+ *txtpos 0 > *ax 64 [sh&&->252] + *txtpos 0 < *ax 91 &&[252] "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#0
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#64
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC45
	BITSNZ	R12,#31
	sjmp	LC46
	ldb	R0,#0
LC45:
	subslt	R12,R10,R12 ; jae	label
	ldb	R0,#0
LC46:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L252
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#0
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#91
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC47
	BITSNZ	R10,#31
	sjmp	LC48
	ldb	R0,#0
LC47:
	subslt	R12,R12,R10 ; jae	label
	ldb	R0,#0
LC48:
	align	2
L252:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L250
; {
; if
; RPN'ized expression: "txtpos 1 + *u 65 < txtpos 1 + *u 90 > || "
; Expanded expression: "txtpos *(4) 1 + *(1) 65 < [sh||->255] txtpos *(4) 1 + *(1) 90 > ||[255] "
; Fused expression:    "+ *txtpos 1 < *ax 65 [sh||->255] + *txtpos 1 > *ax 90 ||[255] "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#1
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#65
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC49
	BITSNZ	R10,#31
	sjmp	LC50
	ldb	R0,#0
LC49:
	subslt	R12,R12,R10 ; jae	label
	ldb	R0,#0
LC50:
; JumpIfNotZero
	tstsnz	R0,R0 ; jne	label
	sjmp	LC51
	sjmp	L255
LC51:
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#1
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#90
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC52
	BITSNZ	R12,#31
	sjmp	LC53
	ldb	R0,#0
LC52:
	subslt	R12,R10,R12 ; jae	label
	ldb	R0,#0
LC53:
	align	2
L255:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L253
; {
; loc             <something> : * short
; RPN'ized expression: "a variables_begin (something256) txtpos *u 65 - + *u = "
; Expanded expression: "(@-4) variables_begin *(4) txtpos *(4) *(1) 65 - 2 * + *(-2) =(-2) "
; Fused expression:    "*(4) txtpos - *ax 65 * ax 2 + *variables_begin ax =(102) *(@-4) *ax "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#65
	subslt	R0,R0,R10
 ; sub eax, const32
	and	R0,R0,R0
	ldd	R10,#2
	mul	R0,R0,R10 ; mul	eax, 2
	mov	R2,R0 ; mov ecx, eax
	ldd	R10,$_variables_begin
	add	R10,R10,R4
	movd	R0,@R10
	add	R0,R0,R2 ; add eax, ecx
	mov	R1,R0; mov	ebx, eax
	movw	R0,@R1; mov	ax, [bx]
	movsw	R0,@R1; mov	ax, [bx]
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; return
; RPN'ized expression: "a "
; Expanded expression: "(@-4) *(-2) "
; Fused expression:    "*(-2) (@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	mjmp	L239
; }
	align	2
L253:
; RPN'ized expression: "( func_tab scantable ) "
; Expanded expression: " func_tab  scantable ()4 "
; Fused expression:    "( func_tab , scantable )4 "
	incs	R14,R14,#-4
	LDD	R10,$_func_tab
	add	R10,R10,R4
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_scantable
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; if
; RPN'ized expression: "table_index 2 == "
; Expanded expression: "table_index *(1) 2 == "
; Fused expression:    "== *table_index 2 IF! "
	ldd	R10,$_table_index
	add	R10,R10,R4
	movb	R0,@R10
	ldb	R10,#2
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L257
; goto expr4_error
	mjmp	L259
	align	2
L257:
; RPN'ized expression: "f table_index = "
; Expanded expression: "(@-8) table_index *(1) =(1) "
; Fused expression:    "=(153) *(@-8) *table_index "
	ldd	R10,$_table_index
	add	R10,R10,R4
	movb	R0,@R10
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
; if
; RPN'ized expression: "txtpos *u 40 != "
; Expanded expression: "txtpos *(4) *(1) 40 != "
; Fused expression:    "*(4) txtpos != *ax 40 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#40
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L260
; goto expr4_error
	mjmp	L259
	align	2
L260:
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; RPN'ized expression: "a ( expression ) = "
; Expanded expression: "(@-4)  expression ()0 =(-2) "
; Fused expression:    "( expression )0 =(108) *(@-4) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expression
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; if
; RPN'ized expression: "txtpos *u 41 != "
; Expanded expression: "txtpos *(4) *(1) 41 != "
; Fused expression:    "*(4) txtpos != *ax 41 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#41
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L262
; goto expr4_error
	mjmp	L259
	align	2
L262:
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; switch
; RPN'ized expression: "f "
; Expanded expression: "(@-8) *(1) "
; Fused expression:    "*(1) (@-8) "
	ldd	R10,#-8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	sjmp	L265
; {
; case
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
	align	2
L266:
; return
; RPN'ized expression: "program a + *u "
; Expanded expression: "program (@-4) *(-2) + *(1) "
; Fused expression:    "+ program *(@-4) *(1) ax "
	ldd	R0,$_program ; // mov	eax, label
	add	R0,R0,R4
	ldd	R11,#-4 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movsw	R2,@R11
	add	R0,R0,R2 ; add eax,[ebp-ofs]
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	mjmp	L239
; case
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
	align	2
L267:
; if
; RPN'ized expression: "a 0 < "
; Expanded expression: "(@-4) *(-2) 0 < "
; Fused expression:    "< *(@-4) 0 IF! "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12
	sjmp	L268
	XOR	R12,R0,R10
	BITSNZ	R12,#31
	sjmp	LC54
	BITSNZ	R10,#31
	sjmp	LC55
	sjmp	L268
LC54:
	subslt	R12,R0,R10 ; jae	label
	sjmp	L268
LC55:
; return
; RPN'ized expression: "a -u "
; Expanded expression: "(@-4) *(-2) -u "
; Fused expression:    "*(-2) (@-4) -u "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	not	R0,R0 ; neg	eax
	incs	R0,R0,#1
	mjmp	L239
	align	2
L268:
; return
; RPN'ized expression: "a "
; Expanded expression: "(@-4) *(-2) "
; Fused expression:    "*(-2) (@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	mjmp	L239
; }
	sjmp	L264
	align	2
L265:
	ldb	R10,#0 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L266
	ldb	R10,#1 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L267
	align	2
L264:
; }
	align	2
L250:
; if
; RPN'ized expression: "txtpos *u 40 == "
; Expanded expression: "txtpos *(4) *(1) 40 == "
; Fused expression:    "*(4) txtpos == *ax 40 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#40
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L270
; {
; loc         a : (@-12): short
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; RPN'ized expression: "a ( expression ) = "
; Expanded expression: "(@-12)  expression ()0 =(-2) "
; Fused expression:    "( expression )0 =(108) *(@-12) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expression
	ldd	R10,#-12 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; if
; RPN'ized expression: "txtpos *u 41 != "
; Expanded expression: "txtpos *(4) *(1) 41 != "
; Fused expression:    "*(4) txtpos != *ax 41 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#41
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L272
; goto expr4_error
	mjmp	L259
	align	2
L272:
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; return
; RPN'ized expression: "a "
; Expanded expression: "(@-12) *(-2) "
; Fused expression:    "*(-2) (@-12) "
	ldd	R10,#-12; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	mjmp	L239
; }
	align	2
L270:
; expr4_error:
	align	2
L259:
; RPN'ized expression: "expression_error 1 = "
; Expanded expression: "expression_error 1 =(1) "
; Fused expression:    "=(156) *expression_error 1 "
	ldd	R0,#1 ; // mov	eax, const_32
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	@R10,R0
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0 "
	ldd	R0,#0 ; // mov	eax, const_32
	mjmp	L239
	align	2
L239:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L238:
	ldd	R10,#12 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L237
; glb expr3 : (void) short
	align	2
_expr3:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L275
	align	2
L274:
; loc     a : (@-4): short
; loc     b : (@-8): short
; RPN'ized expression: "a ( expr4 ) = "
; Expanded expression: "(@-4)  expr4 ()0 =(-2) "
; Fused expression:    "( expr4 )0 =(108) *(@-4) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expr4
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; while
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
	align	2
L278:
; Fused expression:    "1 "
	ldd	R0,#1 ; // mov	eax, const_32
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L279
; {
; if
; RPN'ized expression: "txtpos *u 42 == "
; Expanded expression: "txtpos *(4) *(1) 42 == "
; Fused expression:    "*(4) txtpos == *ax 42 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#42
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L280
; {
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; RPN'ized expression: "b ( expr4 ) = "
; Expanded expression: "(@-8)  expr4 ()0 =(-2) "
; Fused expression:    "( expr4 )0 =(108) *(@-8) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expr4
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; RPN'ized expression: "a b = "
; Expanded expression: "(@-4) (@-8) *(-2) =(-2) "
; Fused expression:    "=(102) *(@-4) *(@-8) "
	ldd	R10,#-8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; }
	sjmp	L281
	align	2
L280:
; else
; if
; RPN'ized expression: "txtpos *u 47 == "
; Expanded expression: "txtpos *(4) *(1) 47 == "
; Fused expression:    "*(4) txtpos == *ax 47 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#47
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L282
; {
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; RPN'ized expression: "b ( expr4 ) = "
; Expanded expression: "(@-8)  expr4 ()0 =(-2) "
; Fused expression:    "( expr4 )0 =(108) *(@-8) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expr4
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; RPN'ized expression: "a b = "
; Expanded expression: "(@-4) (@-8) *(-2) =(-2) "
; Fused expression:    "=(102) *(@-4) *(@-8) "
	ldd	R10,#-8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; }
	sjmp	L283
	align	2
L282:
; else
; return
; RPN'ized expression: "a "
; Expanded expression: "(@-4) *(-2) "
; Fused expression:    "*(-2) (@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	mjmp	L276
	align	2
L283:
	align	2
L281:
; }
	sjmp	L278
	align	2
L279:
	align	2
L276:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L275:
	ldd	R10,#8 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L274
; glb expr2 : (void) short
	align	2
_expr2:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L285
	align	2
L284:
; loc     a : (@-4): short
; loc     b : (@-8): short
; if
; RPN'ized expression: "txtpos *u 45 == txtpos *u 43 == || "
; Expanded expression: "txtpos *(4) *(1) 45 == [sh||->290] txtpos *(4) *(1) 43 == ||[290] "
; Fused expression:    "*(4) txtpos == *ax 45 [sh||->290] *(4) txtpos == *ax 43 ||[290] "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#45
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
; JumpIfNotZero
	tstsnz	R0,R0 ; jne	label
	sjmp	LC56
	sjmp	L290
LC56:
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#43
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
	align	2
L290:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L288
; RPN'ized expression: "a 0 = "
; Expanded expression: "(@-4) 0 =(-2) "
; Fused expression:    "=(108) *(@-4) 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
	sjmp	L289
	align	2
L288:
; else
; RPN'ized expression: "a ( expr3 ) = "
; Expanded expression: "(@-4)  expr3 ()0 =(-2) "
; Fused expression:    "( expr3 )0 =(108) *(@-4) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expr3
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
	align	2
L289:
; while
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
	align	2
L291:
; Fused expression:    "1 "
	ldd	R0,#1 ; // mov	eax, const_32
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L292
; {
; if
; RPN'ized expression: "txtpos *u 45 == "
; Expanded expression: "txtpos *(4) *(1) 45 == "
; Fused expression:    "*(4) txtpos == *ax 45 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#45
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L293
; {
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; RPN'ized expression: "b ( expr3 ) = "
; Expanded expression: "(@-8)  expr3 ()0 =(-2) "
; Fused expression:    "( expr3 )0 =(108) *(@-8) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expr3
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; RPN'ized expression: "a b -= "
; Expanded expression: "(@-4) (@-8) *(-2) -=(-2) "
; Fused expression:    "-=(102) *(@-4) *(@-8) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	ldd	R11,#-8 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movsw	R2,@R11
	subslt	R0,R0,R2
 ; sub eax,[ebp-ofs]
	and	R0,R0,R0
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; }
	sjmp	L294
	align	2
L293:
; else
; if
; RPN'ized expression: "txtpos *u 43 == "
; Expanded expression: "txtpos *(4) *(1) 43 == "
; Fused expression:    "*(4) txtpos == *ax 43 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#43
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L295
; {
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; RPN'ized expression: "b ( expr3 ) = "
; Expanded expression: "(@-8)  expr3 ()0 =(-2) "
; Fused expression:    "( expr3 )0 =(108) *(@-8) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expr3
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; RPN'ized expression: "a b += "
; Expanded expression: "(@-4) (@-8) *(-2) +=(-2) "
; Fused expression:    "+=(102) *(@-4) *(@-8) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	ldd	R11,#-8 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movsw	R2,@R11
	add	R0,R0,R2 ; add eax,[ebp-ofs]
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; }
	sjmp	L296
	align	2
L295:
; else
; return
; RPN'ized expression: "a "
; Expanded expression: "(@-4) *(-2) "
; Fused expression:    "*(-2) (@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	mjmp	L286
	align	2
L296:
	align	2
L294:
; }
	sjmp	L291
	align	2
L292:
	align	2
L286:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L285:
	ldd	R10,#8 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L284
; glb expression : (void) short
	align	2
_expression:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L298
	align	2
L297:
; loc     a : (@-4): short
; loc     b : (@-8): short
; RPN'ized expression: "a ( expr2 ) = "
; Expanded expression: "(@-4)  expr2 ()0 =(-2) "
; Fused expression:    "( expr2 )0 =(108) *(@-4) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expr2
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; if
; RPN'ized expression: "expression_error "
; Expanded expression: "expression_error *(1) "
; Fused expression:    "*(1) expression_error "
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	R0,@R10
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L301
; return
; RPN'ized expression: "a "
; Expanded expression: "(@-4) *(-2) "
; Fused expression:    "*(-2) (@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	mjmp	L299
	align	2
L301:
; RPN'ized expression: "( relop_tab scantable ) "
; Expanded expression: " relop_tab  scantable ()4 "
; Fused expression:    "( relop_tab , scantable )4 "
	incs	R14,R14,#-4
	LDD	R10,$_relop_tab
	add	R10,R10,R4
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_scantable
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; if
; RPN'ized expression: "table_index 6 == "
; Expanded expression: "table_index *(1) 6 == "
; Fused expression:    "== *table_index 6 IF! "
	ldd	R10,$_table_index
	add	R10,R10,R4
	movb	R0,@R10
	ldb	R10,#6
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L303
; return
; RPN'ized expression: "a "
; Expanded expression: "(@-4) *(-2) "
; Fused expression:    "*(-2) (@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	mjmp	L299
	align	2
L303:
; switch
; RPN'ized expression: "table_index "
; Expanded expression: "table_index *(1) "
; Fused expression:    "*(1) table_index "
	ldd	R10,$_table_index
	add	R10,R10,R4
	movb	R0,@R10
	sjmp	L306
; {
; case
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
	align	2
L307:
; RPN'ized expression: "b ( expr2 ) = "
; Expanded expression: "(@-8)  expr2 ()0 =(-2) "
; Fused expression:    "( expr2 )0 =(108) *(@-8) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expr2
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; if
; RPN'ized expression: "a b >= "
; Expanded expression: "(@-4) *(-2) (@-8) *(-2) >= "
; Fused expression:    ">= *(@-4) *(@-8) IF! "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	ldd	R11,#-8 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movsw	R2,@R11
	MOV	R10,R2 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; jne	label
	sjmp	AC1
	BITSNZ	R12,#31
	sjmp	LC57
	BITSNZ	R0,#31
	sjmp	LC58
	sjmp	L308
LC57:
	subslt	R12,R10,R0 ; jl	label
	sjmp	L308
LC58:
AC1:
; return
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
; Fused expression:    "1 "
	ldd	R0,#1 ; // mov	eax, const_32
	mjmp	L299
	align	2
L308:
; break
	sjmp	L305
; case
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
	align	2
L310:
; RPN'ized expression: "b ( expr2 ) = "
; Expanded expression: "(@-8)  expr2 ()0 =(-2) "
; Fused expression:    "( expr2 )0 =(108) *(@-8) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expr2
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; if
; RPN'ized expression: "a b != "
; Expanded expression: "(@-4) *(-2) (@-8) *(-2) != "
; Fused expression:    "!= *(@-4) *(@-8) IF! "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	ldd	R11,#-8 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movsw	R2,@R11
	MOV	R10,R2 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L311
; return
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
; Fused expression:    "1 "
	ldd	R0,#1 ; // mov	eax, const_32
	mjmp	L299
	align	2
L311:
; break
	sjmp	L305
; case
; RPN'ized expression: "2 "
; Expanded expression: "2 "
; Expression value: 2
	align	2
L313:
; RPN'ized expression: "b ( expr2 ) = "
; Expanded expression: "(@-8)  expr2 ()0 =(-2) "
; Fused expression:    "( expr2 )0 =(108) *(@-8) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expr2
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; if
; RPN'ized expression: "a b > "
; Expanded expression: "(@-4) *(-2) (@-8) *(-2) > "
; Fused expression:    "> *(@-4) *(@-8) IF! "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	ldd	R11,#-8 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movsw	R2,@R11
	MOV	R10,R2 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12
	sjmp	L314
	XOR	R12,R0,R10
	BITSNZ	R12,#31
	sjmp	LC59
	BITSNZ	R0,#31
	sjmp	LC60
	sjmp	L314
LC59:
	subslt	R12,R10,R0 ; jle	label
	sjmp	L314
LC60:
; return
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
; Fused expression:    "1 "
	ldd	R0,#1 ; // mov	eax, const_32
	mjmp	L299
	align	2
L314:
; break
	sjmp	L305
; case
; RPN'ized expression: "3 "
; Expanded expression: "3 "
; Expression value: 3
	align	2
L316:
; RPN'ized expression: "b ( expr2 ) = "
; Expanded expression: "(@-8)  expr2 ()0 =(-2) "
; Fused expression:    "( expr2 )0 =(108) *(@-8) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expr2
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; if
; RPN'ized expression: "a b == "
; Expanded expression: "(@-4) *(-2) (@-8) *(-2) == "
; Fused expression:    "== *(@-4) *(@-8) IF! "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	ldd	R11,#-8 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movsw	R2,@R11
	MOV	R10,R2 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L317
; return
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
; Fused expression:    "1 "
	ldd	R0,#1 ; // mov	eax, const_32
	mjmp	L299
	align	2
L317:
; break
	sjmp	L305
; case
; RPN'ized expression: "4 "
; Expanded expression: "4 "
; Expression value: 4
	align	2
L319:
; RPN'ized expression: "b ( expr2 ) = "
; Expanded expression: "(@-8)  expr2 ()0 =(-2) "
; Fused expression:    "( expr2 )0 =(108) *(@-8) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expr2
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; if
; RPN'ized expression: "a b <= "
; Expanded expression: "(@-4) *(-2) (@-8) *(-2) <= "
; Fused expression:    "<= *(@-4) *(@-8) IF! "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	ldd	R11,#-8 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movsw	R2,@R11
	MOV	R10,R2 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; jne	label
	sjmp	AC2
	BITSNZ	R12,#31
	sjmp	LC61
	BITSNZ	R10,#31
	sjmp	LC62
	sjmp	L320
LC61:
	subslt	R12,R0,R10 ; jg	label
	sjmp	L320
LC62:
AC2:
; return
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
; Fused expression:    "1 "
	ldd	R0,#1 ; // mov	eax, const_32
	mjmp	L299
	align	2
L320:
; break
	sjmp	L305
; case
; RPN'ized expression: "5 "
; Expanded expression: "5 "
; Expression value: 5
	align	2
L322:
; RPN'ized expression: "b ( expr2 ) = "
; Expanded expression: "(@-8)  expr2 ()0 =(-2) "
; Fused expression:    "( expr2 )0 =(108) *(@-8) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expr2
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; if
; RPN'ized expression: "a b < "
; Expanded expression: "(@-4) *(-2) (@-8) *(-2) < "
; Fused expression:    "< *(@-4) *(@-8) IF! "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	ldd	R11,#-8 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movsw	R2,@R11
	MOV	R10,R2 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12
	sjmp	L323
	XOR	R12,R0,R10
	BITSNZ	R12,#31
	sjmp	LC63
	BITSNZ	R10,#31
	sjmp	LC64
	sjmp	L323
LC63:
	subslt	R12,R0,R10 ; jae	label
	sjmp	L323
LC64:
; return
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
; Fused expression:    "1 "
	ldd	R0,#1 ; // mov	eax, const_32
	mjmp	L299
	align	2
L323:
; break
	sjmp	L305
; }
	sjmp	L305
	align	2
L306:
	ldb	R10,#0 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L307
	ldb	R10,#1 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L310
	ldb	R10,#2 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L313
	ldb	R10,#3 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L316
	ldb	R10,#4 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L319
	ldb	R10,#5 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L322
	align	2
L305:
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0 "
	ldd	R0,#0 ; // mov	eax, const_32
	mjmp	L299
	align	2
L299:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L298:
	ldd	R10,#8 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L297
; glb main : (void) void
	align	2
_main:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L326
	align	2
L325:
; loc     start : (@-4): * unsigned char
; loc     newEnd : (@-8): * unsigned char
; loc     linelen : (@-12): unsigned char
; loc     tempint : (@-16): unsigned
; RPN'ized expression: "UART_status 1879048192 = "
; Expanded expression: "UART_status 1879048192 =(4) "
; Fused expression:    "=(204) *UART_status 1879048192 "
	ldd	R0,#1879048192 ; // mov	eax, const_32
	ldd	R10,$_UART_status
	add	R10,R10,R4
	movd	@R10,R0
; RPN'ized expression: "UART_eventack 1879048194 = "
; Expanded expression: "UART_eventack 1879048194 =(4) "
; Fused expression:    "=(204) *UART_eventack 1879048194 "
	ldd	R0,#1879048194 ; // mov	eax, const_32
	ldd	R10,$_UART_eventack
	add	R10,R10,R4
	movd	@R10,R0
; RPN'ized expression: "opcode 0 = "
; Expanded expression: "opcode 0 =(1) "
; Fused expression:    "=(156) *opcode 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,$_opcode
	add	R10,R10,R4
	movb	@R10,R0
; RPN'ized expression: "program_start program = "
; Expanded expression: "program_start program =(4) "
; Fused expression:    "=(204) *program_start program "
	ldd	R0,$_program ; // mov	eax, label
	add	R0,R0,R4
	ldd	R10,$_program_start
	add	R10,R10,R4
	movd	@R10,R0
; RPN'ized expression: "program_end program_start = "
; Expanded expression: "program_end program_start *(4) =(4) "
; Fused expression:    "=(204) *program_end *program_start "
	ldd	R10,$_program_start
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	@R10,R0
; RPN'ized expression: "sp program program sizeof + = "
; Expanded expression: "sp program 512u + =(4) "
; Fused expression:    "+ program 512u =(204) *sp ax "
	ldd	R0,$_program ; // mov	eax, label
	add	R0,R0,R4
	ldw	R10,#512
	add	R0,R0,R10 ; add eax, const32
	ldd	R10,$_sp
	add	R10,R10,R4
	movd	@R10,R0
; loc     <something> : struct stack_for_frame
; RPN'ized expression: "stack_limit program program sizeof + <something329> sizeof 5 * - = "
; Expanded expression: "stack_limit program 432u + =(4) "
; Fused expression:    "+ program 432u =(204) *stack_limit ax "
	ldd	R0,$_program ; // mov	eax, label
	add	R0,R0,R4
	ldw	R10,#432
	add	R0,R0,R10 ; add eax, const32
	ldd	R10,$_stack_limit
	add	R10,R10,R4
	movd	@R10,R0
; loc     <something> : short
; RPN'ized expression: "variables_begin stack_limit 27 <something330> sizeof * - = "
; Expanded expression: "variables_begin stack_limit *(4) 54u - =(4) "
; Fused expression:    "- *stack_limit 54u =(204) *variables_begin ax "
	ldd	R10,$_stack_limit
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#54
	subslt	R0,R0,R10
 ; sub eax, const32
	and	R0,R0,R0
	ldd	R10,$_variables_begin
	add	R10,R10,R4
	movd	@R10,R0
; RPN'ized expression: "( initmsg printmsg ) "
; Expanded expression: " initmsg  printmsg ()4 "
; Fused expression:    "( initmsg , printmsg )4 "
	incs	R14,R14,#-4
	LDD	R10,$_initmsg
	add	R10,R10,R4
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_printmsg
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; RPN'ized expression: "( valmsg printmsg ) "
; Expanded expression: " valmsg  printmsg ()4 "
; Fused expression:    "( valmsg , printmsg )4 "
	incs	R14,R14,#-4
	LDD	R10,$_valmsg
	add	R10,R10,R4
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_printmsg
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; RPN'ized expression: "( variables_begin program_end - printnum ) "
; Expanded expression: " variables_begin *(4) program_end *(4) -  printnum ()4 "
; Fused expression:    "( - *variables_begin *program_end , printnum )4 "
	ldd	R10,$_variables_begin
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	R11,@R10
	subslt	R0,R0,R11
 ; sub eax, const32
	and	R0,R0,R0
	incs	R14,R14,#-4
	movd	@R14,R0
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_printnum
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; RPN'ized expression: "( memorymsg printmsg ) "
; Expanded expression: " memorymsg  printmsg ()4 "
; Fused expression:    "( memorymsg , printmsg )4 "
	incs	R14,R14,#-4
	LDD	R10,$_memorymsg
	add	R10,R10,R4
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_printmsg
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; warmstart:
	align	2
L331:
; RPN'ized expression: "current_line 0 = "
; Expanded expression: "current_line 0 =(4) "
; Fused expression:    "=(204) *current_line 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,$_current_line
	add	R10,R10,R4
	movd	@R10,R0
; RPN'ized expression: "sp program program sizeof + = "
; Expanded expression: "sp program 512u + =(4) "
; Fused expression:    "+ program 512u =(204) *sp ax "
	ldd	R0,$_program ; // mov	eax, label
	add	R0,R0,R4
	ldw	R10,#512
	add	R0,R0,R10 ; add eax, const32
	ldd	R10,$_sp
	add	R10,R10,R4
	movd	@R10,R0
; RPN'ized expression: "( okmsg printmsg ) "
; Expanded expression: " okmsg  printmsg ()4 "
; Fused expression:    "( okmsg , printmsg )4 "
	incs	R14,R14,#-4
	LDD	R10,$_okmsg
	add	R10,R10,R4
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_printmsg
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; prompt:
	align	2
L332:
; RPN'ized expression: "( 62 getln ) "
; Expanded expression: " 62  getln ()4 "
; Fused expression:    "( 62 , getln )4 "
	incs	R14,R14,#-4
	LDD	R10,#62
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_getln
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; RPN'ized expression: "( toUppercaseBuffer ) "
; Expanded expression: " toUppercaseBuffer ()0 "
; Fused expression:    "( toUppercaseBuffer )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_toUppercaseBuffer
; loc     <something> : unsigned short
; RPN'ized expression: "txtpos program_end <something333> sizeof + = "
; Expanded expression: "txtpos program_end *(4) 2u + =(4) "
; Fused expression:    "+ *program_end 2u =(204) *txtpos ax "
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#2
	add	R0,R0,R10 ; add eax, const32
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	@R10,R0
; while
; RPN'ized expression: "txtpos *u 10 != "
; Expanded expression: "txtpos *(4) *(1) 10 != "
	align	2
L334:
; Fused expression:    "*(4) txtpos != *ax 10 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L335
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
	sjmp	L334
	align	2
L335:
; RPN'ized expression: "tempint txtpos = "
; Expanded expression: "(@-16) txtpos *(4) =(4) "
; Fused expression:    "=(204) *(@-16) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,#-16 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; if
; RPN'ized expression: "tempint 1 & 0 == "
; Expanded expression: "(@-16) *(4) 1 & 0 == "
; Fused expression:    "& *(@-16) 1 == ax 0 IF! "
	ldd	R10,#-16; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#1
	and	R0,R0,R10 ; and eax, const32
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L336
; {
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; RPN'ized expression: "txtpos *u 10 = "
; Expanded expression: "txtpos *(4) 10 =(1) "
; Fused expression:    "*(4) txtpos =(156) *ax 10 "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0 ; mov ebx, eax
	ldd	R0,#10 ; // mov	eax, const_32
	movb	@R1,R0
; }
	align	2
L336:
; {
; loc         dest : (@-20): * unsigned char
; RPN'ized expression: "dest variables_begin 1 - = "
; Expanded expression: "(@-20) variables_begin *(4) 1 - =(4) "
; Fused expression:    "- *variables_begin 1 =(204) *(@-20) ax "
	ldd	R10,$_variables_begin
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#1
	subslt	R0,R0,R10
 ; sub eax, const32
	and	R0,R0,R0
	ldd	R10,#-20 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; while
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
	align	2
L338:
; Fused expression:    "1 "
	ldd	R0,#1 ; // mov	eax, const_32
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L339
; {
; RPN'ized expression: "dest *u txtpos *u = "
; Expanded expression: "(@-20) *(4) txtpos *(4) *(1) =(1) "
; Fused expression:    "*(4) (@-20) push-ax *(4) txtpos =(153) **sp *ax "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	incs	R14,R14,#-4;
	movd	@R14,R0 ; Push	eax 
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	movd	R1,@R14 ; // pop	ebx
	incs	R14,R14,#4
	movb	@R1,R0
; if
; loc             <something> : unsigned short
; RPN'ized expression: "txtpos program_end <something342> sizeof + == "
; Expanded expression: "txtpos *(4) program_end *(4) 2u + == "
; Fused expression:    "+ *program_end 2u == *txtpos ax IF! "
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#2
	add	R0,R0,R10 ; add eax, const32
	mov	R2,R0 ; mov ecx, eax
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	MOV	R10,R2 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L340
; break
	sjmp	L339
	align	2
L340:
; RPN'ized expression: "dest --p "
; Expanded expression: "(@-20) --p(4) "
; Fused expression:    "--p(4) *(@-20) "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#-1
	movd	@R10,R11
; RPN'ized expression: "txtpos --p "
; Expanded expression: "txtpos --p(4) "
; Fused expression:    "--p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#-1
	movd	@R10,R11
; }
	sjmp	L338
	align	2
L339:
; RPN'ized expression: "txtpos dest = "
; Expanded expression: "txtpos (@-20) *(4) =(4) "
; Fused expression:    "=(204) *txtpos *(@-20) "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	@R10,R0
; }
; RPN'ized expression: "linenum ( testnum ) = "
; Expanded expression: "linenum  testnum ()0 =(2) "
; Fused expression:    "( testnum )0 =(172) *linenum ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_testnum
	ldd	R10,$_linenum
	add	R10,R10,R4
	movw	@R10,R0
; RPN'ized expression: "( ignore_blanks ) "
; Expanded expression: " ignore_blanks ()0 "
; Fused expression:    "( ignore_blanks )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_ignore_blanks
; if
; RPN'ized expression: "linenum 0 == "
; Expanded expression: "linenum *(2) 0 == "
; Fused expression:    "== *linenum 0 IF! "
	ldd	R10,$_linenum
	add	R10,R10,R4
	movw	R0,@R10
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L343
; goto direct
	mjmp	L345
	align	2
L343:
; if
; RPN'ized expression: "linenum 65535 == "
; Expanded expression: "linenum *(2) 65535 == "
; Fused expression:    "== *linenum 65535 IF! "
	ldd	R10,$_linenum
	add	R10,R10,R4
	movw	R0,@R10
	ldw	R10,#65535
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L346
; goto qhow
	mjmp	L348
	align	2
L346:
; RPN'ized expression: "linelen 0 = "
; Expanded expression: "(@-12) 0 =(1) "
; Fused expression:    "=(156) *(@-12) 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,#-12 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
; while
; RPN'ized expression: "txtpos linelen + *u 10 != "
; Expanded expression: "txtpos *(4) (@-12) *(1) + *(1) 10 != "
	align	2
L349:
; Fused expression:    "+ *txtpos *(@-12) != *ax 10 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R11,#-12 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movb	R2,@R11
	add	R0,R0,R2 ; add eax,[ebp-ofs]
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L350
; RPN'ized expression: "linelen ++p "
; Expanded expression: "(@-12) ++p(1) "
; Fused expression:    "++p(1) *(@-12) "
	ldd	R10,#-12; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movb	@R10,R11
	sjmp	L349
	align	2
L350:
; RPN'ized expression: "linelen ++p "
; Expanded expression: "(@-12) ++p(1) "
; Fused expression:    "++p(1) *(@-12) "
	ldd	R10,#-12; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movb	@R10,R11
; loc     <something> : unsigned short
; loc     <something> : char
; RPN'ized expression: "linelen <something351> sizeof <something352> sizeof + += "
; Expanded expression: "(@-12) 3u +=(1) "
; Fused expression:    "+=(156) *(@-12) 3u "
	ldd	R10,#-12; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	ldb	R10,#3
	add	R0,R0,R10 ; add eax, const32
	ldd	R10,#-12 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
; RPN'ized expression: "txtpos 3 -= "
; Expanded expression: "txtpos 3 -=(4) "
; Fused expression:    "-=(204) *txtpos 3 "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#3
	subslt	R0,R0,R10
 ; sub eax, const32
	and	R0,R0,R0
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	@R10,R0
; loc     <something> : * unsigned short
; RPN'ized expression: "txtpos (something353) *u linenum = "
; Expanded expression: "txtpos *(4) linenum *(2) =(2) "
; Fused expression:    "*(4) txtpos =(170) *ax *linenum "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0 ; mov ebx, eax
	ldd	R10,$_linenum
	add	R10,R10,R4
	movw	R0,@R10
	movw	@R1,R0
; loc     <something> : unsigned short
; RPN'ized expression: "txtpos <something354> sizeof + *u linelen = "
; Expanded expression: "txtpos *(4) 2u + (@-12) *(1) =(1) "
; Fused expression:    "+ *txtpos 2u =(153) *ax *(@-12) "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#2
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0 ; mov ebx, eax
	ldd	R10,#-12; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	movb	@R1,R0
; RPN'ized expression: "start ( findline ) = "
; Expanded expression: "(@-4)  findline ()0 =(4) "
; Fused expression:    "( findline )0 =(204) *(@-4) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_findline
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; if
; loc     <something> : * unsigned short
; RPN'ized expression: "start program_end != start (something357) *u linenum == && "
; Expanded expression: "(@-4) *(4) program_end *(4) != [sh&&->358] (@-4) *(4) *(2) linenum *(2) == &&[358] "
; Fused expression:    "!= *(@-4) *program_end [sh&&->358] *(4) (@-4) == *ax *linenum &&[358] "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	R11,@R10
	MOV	R10,R11 ; emulated 'cmp' eax, ecx
	xor	R12,R0,R10
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L358
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movw	R0,@R1; mov	ax, [bx]
	ldd	R10,$_linenum
	add	R10,R10,R4
	movw	R2,@R10
	MOV	R10,R2 ; emulated 'cmp' eax, ecx
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
	align	2
L358:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L355
; {
; loc         dest : (@-20): * unsigned char
; loc         from : (@-24): * unsigned char
; loc         tomove : (@-28): unsigned
; loc         <something> : unsigned short
; RPN'ized expression: "from start start <something359> sizeof + *u + = "
; Expanded expression: "(@-24) (@-4) *(4) (@-4) *(4) 2u + *(1) + =(4) "
; Fused expression:    "+ *(@-4) 2u + *(@-4) *ax =(204) *(@-24) ax "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#2
	add	R0,R0,R10 ; add eax, const32
	mov	R1, R0
	movb	R2,@R1
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	add	R0,R0,R2 ; add eax, ecx
	ldd	R10,#-24 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "dest start = "
; Expanded expression: "(@-20) (@-4) *(4) =(4) "
; Fused expression:    "=(204) *(@-20) *(@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldd	R10,#-20 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "tomove program_end from - = "
; Expanded expression: "(@-28) program_end *(4) (@-24) *(4) - =(4) "
; Fused expression:    "- *program_end *(@-24) =(204) *(@-28) ax "
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R11,#-24 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movd	R10,@R11
	subslt	R0,R0,R10
 ; sub eax,[ebp-ofs]
	and	R0,R0,R0
	ldd	R10,#-28 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; while
; RPN'ized expression: "tomove 0 > "
; Expanded expression: "(@-28) *(4) 0 >u "
	align	2
L360:
; Fused expression:    ">u *(@-28) 0 IF! "
	ldd	R10,#-28; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; jxx..
	sjmp	L361
	subslt	R12,R10,R0 ; jbe	label
	sjmp	L361
; {
; RPN'ized expression: "dest *u from *u = "
; Expanded expression: "(@-20) *(4) (@-24) *(4) *(1) =(1) "
; Fused expression:    "*(4) (@-20) push-ax *(4) (@-24) =(153) **sp *ax "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	incs	R14,R14,#-4;
	movd	@R14,R0 ; Push	eax 
	ldd	R10,#-24; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	movd	R1,@R14 ; // pop	ebx
	incs	R14,R14,#4
	movb	@R1,R0
; RPN'ized expression: "from ++p "
; Expanded expression: "(@-24) ++p(4) "
; Fused expression:    "++p(4) *(@-24) "
	ldd	R10,#-24; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; RPN'ized expression: "dest ++p "
; Expanded expression: "(@-20) ++p(4) "
; Fused expression:    "++p(4) *(@-20) "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; RPN'ized expression: "tomove --p "
; Expanded expression: "(@-28) --p(4) "
; Fused expression:    "--p(4) *(@-28) "
	ldd	R10,#-28; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#-1
	movd	@R10,R11
; }
	sjmp	L360
	align	2
L361:
; RPN'ized expression: "program_end dest = "
; Expanded expression: "program_end (@-20) *(4) =(4) "
; Fused expression:    "=(204) *program_end *(@-20) "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	@R10,R0
; }
	align	2
L355:
; if
; loc     <something> : unsigned short
; loc     <something> : char
; RPN'ized expression: "txtpos <something364> sizeof <something365> sizeof + + *u 10 == "
; Expanded expression: "txtpos *(4) 3u + *(1) 10 == "
; Fused expression:    "+ *txtpos 3u == *ax 10 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#3
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L362
; goto prompt
	mjmp	L332
	align	2
L362:
; while
; RPN'ized expression: "linelen 0 > "
; Expanded expression: "(@-12) *(1) 0 > "
	align	2
L366:
; Fused expression:    "> *(@-12) 0 IF! "
	ldd	R10,#-12; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12
	sjmp	L367
	XOR	R12,R0,R10
	BITSNZ	R12,#31
	sjmp	LC65
	BITSNZ	R0,#31
	sjmp	LC66
	sjmp	L367
LC65:
	subslt	R12,R10,R0 ; jle	label
	sjmp	L367
LC66:
; {
; loc         tomove : (@-20): unsigned
; loc         from : (@-24): * unsigned char
; loc         dest : (@-28): * unsigned char
; loc         space_to_make : (@-32): unsigned
; RPN'ized expression: "space_to_make txtpos program_end - = "
; Expanded expression: "(@-32) txtpos *(4) program_end *(4) - =(4) "
; Fused expression:    "- *txtpos *program_end =(204) *(@-32) ax "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	R11,@R10
	subslt	R0,R0,R11
 ; sub eax, const32
	and	R0,R0,R0
	ldd	R10,#-32 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; if
; RPN'ized expression: "space_to_make linelen > "
; Expanded expression: "(@-32) *(4) (@-12) *(1) >u "
; Fused expression:    ">u *(@-32) *(@-12) IF! "
	ldd	R10,#-32; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldd	R11,#-12 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movb	R2,@R11
	MOV	R10,R2 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; jxx..
	sjmp	L368
	subslt	R12,R10,R0 ; jbe	label
	sjmp	L368
; RPN'ized expression: "space_to_make linelen = "
; Expanded expression: "(@-32) (@-12) *(1) =(4) "
; Fused expression:    "=(201) *(@-32) *(@-12) "
	ldd	R10,#-12; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	ldd	R10,#-32 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
	align	2
L368:
; RPN'ized expression: "newEnd program_end space_to_make + = "
; Expanded expression: "(@-8) program_end *(4) (@-32) *(4) + =(4) "
; Fused expression:    "+ *program_end *(@-32) =(204) *(@-8) ax "
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R11,#-32 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movd	R10,@R11
	add	R0,R0,R10 ; add eax,[ebp-ofs]
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "tomove program_end start - = "
; Expanded expression: "(@-20) program_end *(4) (@-4) *(4) - =(4) "
; Fused expression:    "- *program_end *(@-4) =(204) *(@-20) ax "
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R11,#-4 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movd	R10,@R11
	subslt	R0,R0,R10
 ; sub eax,[ebp-ofs]
	and	R0,R0,R0
	ldd	R10,#-20 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "from program_end = "
; Expanded expression: "(@-24) program_end *(4) =(4) "
; Fused expression:    "=(204) *(@-24) *program_end "
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,#-24 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "dest newEnd = "
; Expanded expression: "(@-28) (@-8) *(4) =(4) "
; Fused expression:    "=(204) *(@-28) *(@-8) "
	ldd	R10,#-8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldd	R10,#-28 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; while
; RPN'ized expression: "tomove 0 > "
; Expanded expression: "(@-20) *(4) 0 >u "
	align	2
L370:
; Fused expression:    ">u *(@-20) 0 IF! "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; jxx..
	sjmp	L371
	subslt	R12,R10,R0 ; jbe	label
	sjmp	L371
; {
; RPN'ized expression: "from --p "
; Expanded expression: "(@-24) --p(4) "
; Fused expression:    "--p(4) *(@-24) "
	ldd	R10,#-24; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#-1
	movd	@R10,R11
; RPN'ized expression: "dest --p "
; Expanded expression: "(@-28) --p(4) "
; Fused expression:    "--p(4) *(@-28) "
	ldd	R10,#-28; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#-1
	movd	@R10,R11
; RPN'ized expression: "dest *u from *u = "
; Expanded expression: "(@-28) *(4) (@-24) *(4) *(1) =(1) "
; Fused expression:    "*(4) (@-28) push-ax *(4) (@-24) =(153) **sp *ax "
	ldd	R10,#-28; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	incs	R14,R14,#-4;
	movd	@R14,R0 ; Push	eax 
	ldd	R10,#-24; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	movd	R1,@R14 ; // pop	ebx
	incs	R14,R14,#4
	movb	@R1,R0
; RPN'ized expression: "tomove --p "
; Expanded expression: "(@-20) --p(4) "
; Fused expression:    "--p(4) *(@-20) "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#-1
	movd	@R10,R11
; }
	sjmp	L370
	align	2
L371:
; for
; RPN'ized expression: "tomove 0 = "
; Expanded expression: "(@-20) 0 =(4) "
; Fused expression:    "=(204) *(@-20) 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,#-20 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
	align	2
L372:
; RPN'ized expression: "tomove space_to_make < "
; Expanded expression: "(@-20) *(4) (@-32) *(4) <u "
; Fused expression:    "<u *(@-20) *(@-32) IF! "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldd	R11,#-32 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movd	R10,@R11
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; jxx..
	sjmp	L375
	subslt	R12,R0,R10 ; jge	label
	sjmp	L375
	sjmp	L374
	align	2
L373:
; RPN'ized expression: "tomove ++p "
; Expanded expression: "(@-20) ++p(4) "
; Fused expression:    "++p(4) *(@-20) "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
	sjmp	L372
	align	2
L374:
; {
; RPN'ized expression: "start *u txtpos *u = "
; Expanded expression: "(@-4) *(4) txtpos *(4) *(1) =(1) "
; Fused expression:    "*(4) (@-4) push-ax *(4) txtpos =(153) **sp *ax "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	incs	R14,R14,#-4;
	movd	@R14,R0 ; Push	eax 
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	movd	R1,@R14 ; // pop	ebx
	incs	R14,R14,#4
	movb	@R1,R0
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; RPN'ized expression: "start ++p "
; Expanded expression: "(@-4) ++p(4) "
; Fused expression:    "++p(4) *(@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; RPN'ized expression: "linelen --p "
; Expanded expression: "(@-12) --p(1) "
; Fused expression:    "--p(1) *(@-12) "
	ldd	R10,#-12; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R11,@R10
	mov	R0,R11
	incs	R11,R11,#-1
	movb	@R10,R11
; }
	sjmp	L373
	align	2
L375:
; RPN'ized expression: "program_end newEnd = "
; Expanded expression: "program_end (@-8) *(4) =(4) "
; Fused expression:    "=(204) *program_end *(@-8) "
	ldd	R10,#-8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	@R10,R0
; }
	sjmp	L366
	align	2
L367:
; goto prompt
	mjmp	L332
; qhow:
	align	2
L348:
; RPN'ized expression: "( howmsg printmsg ) "
; Expanded expression: " howmsg  printmsg ()4 "
; Fused expression:    "( howmsg , printmsg )4 "
	incs	R14,R14,#-4
	LDD	R10,$_howmsg
	add	R10,R10,R4
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_printmsg
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; goto prompt
	mjmp	L332
; qwhat:
	align	2
L376:
; RPN'ized expression: "( whatmsg printmsgNoNL ) "
; Expanded expression: " whatmsg  printmsgNoNL ()4 "
; Fused expression:    "( whatmsg , printmsgNoNL )4 "
	incs	R14,R14,#-4
	LDD	R10,$_whatmsg
	add	R10,R10,R4
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_printmsgNoNL
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; if
; RPN'ized expression: "current_line 0 != "
; Expanded expression: "current_line *(4) 0 != "
; Fused expression:    "!= *current_line 0 IF! "
	ldd	R10,$_current_line
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L377
; {
; loc         tmp : (@-20): unsigned char
; RPN'ized expression: "tmp txtpos *u = "
; Expanded expression: "(@-20) txtpos *(4) *(1) =(1) "
; Fused expression:    "*(4) txtpos =(201) *(@-20) *ax "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldd	R10,#-20 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; if
; RPN'ized expression: "txtpos *u 10 != "
; Expanded expression: "txtpos *(4) *(1) 10 != "
; Fused expression:    "*(4) txtpos != *ax 10 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L379
; RPN'ized expression: "txtpos *u 94 = "
; Expanded expression: "txtpos *(4) 94 =(1) "
; Fused expression:    "*(4) txtpos =(156) *ax 94 "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0 ; mov ebx, eax
	ldd	R0,#94 ; // mov	eax, const_32
	movb	@R1,R0
	align	2
L379:
; RPN'ized expression: "list_line current_line = "
; Expanded expression: "list_line current_line *(4) =(4) "
; Fused expression:    "=(204) *list_line *current_line "
	ldd	R10,$_current_line
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,$_list_line
	add	R10,R10,R4
	movd	@R10,R0
; RPN'ized expression: "( printline ) "
; Expanded expression: " printline ()0 "
; Fused expression:    "( printline )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_printline
; RPN'ized expression: "txtpos *u tmp = "
; Expanded expression: "txtpos *(4) (@-20) *(1) =(1) "
; Fused expression:    "*(4) txtpos =(153) *ax *(@-20) "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0 ; mov ebx, eax
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	movb	@R1,R0
; }
	align	2
L377:
; RPN'ized expression: "( line_terminator ) "
; Expanded expression: " line_terminator ()0 "
; Fused expression:    "( line_terminator )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_line_terminator
; goto prompt
	mjmp	L332
; qsorry:
	align	2
L381:
; RPN'ized expression: "( sorrymsg printmsg ) "
; Expanded expression: " sorrymsg  printmsg ()4 "
; Fused expression:    "( sorrymsg , printmsg )4 "
	incs	R14,R14,#-4
	LDD	R10,$_sorrymsg
	add	R10,R10,R4
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_printmsg
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; goto warmstart
	mjmp	L331
; run_next_statement:
	align	2
L382:
; while
; RPN'ized expression: "txtpos *u 58 == "
; Expanded expression: "txtpos *(4) *(1) 58 == "
	align	2
L383:
; Fused expression:    "*(4) txtpos == *ax 58 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#58
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L384
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
	sjmp	L383
	align	2
L384:
; RPN'ized expression: "( ignore_blanks ) "
; Expanded expression: " ignore_blanks ()0 "
; Fused expression:    "( ignore_blanks )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_ignore_blanks
; if
; RPN'ized expression: "txtpos *u 10 == "
; Expanded expression: "txtpos *(4) *(1) 10 == "
; Fused expression:    "*(4) txtpos == *ax 10 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L385
; goto execnextline
	mjmp	L387
	align	2
L385:
; goto interperateAtTxtpos
	mjmp	L388
; direct:
	align	2
L345:
; loc     <something> : unsigned short
; RPN'ized expression: "txtpos program_end <something389> sizeof + = "
; Expanded expression: "txtpos program_end *(4) 2u + =(4) "
; Fused expression:    "+ *program_end 2u =(204) *txtpos ax "
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#2
	add	R0,R0,R10 ; add eax, const32
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	@R10,R0
; if
; RPN'ized expression: "txtpos *u 10 == "
; Expanded expression: "txtpos *(4) *(1) 10 == "
; Fused expression:    "*(4) txtpos == *ax 10 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L390
; goto prompt
	mjmp	L332
	align	2
L390:
; interperateAtTxtpos:
	align	2
L388:
; if
; RPN'ized expression: "( breakcheck ) "
; Expanded expression: " breakcheck ()0 "
; Fused expression:    "( breakcheck )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_breakcheck
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L392
; {
; RPN'ized expression: "( breakmsg printmsg ) "
; Expanded expression: " breakmsg  printmsg ()4 "
; Fused expression:    "( breakmsg , printmsg )4 "
	incs	R14,R14,#-4
	LDD	R10,$_breakmsg
	add	R10,R10,R4
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_printmsg
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; goto warmstart
	mjmp	L331
; }
	align	2
L392:
; RPN'ized expression: "( keywords scantable ) "
; Expanded expression: " keywords  scantable ()4 "
; Fused expression:    "( keywords , scantable )4 "
	incs	R14,R14,#-4
	LDD	R10,$_keywords
	add	R10,R10,R4
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_scantable
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; switch
; RPN'ized expression: "table_index "
; Expanded expression: "table_index *(1) "
; Fused expression:    "*(1) table_index "
	ldd	R10,$_table_index
	add	R10,R10,R4
	movb	R0,@R10
	sjmp	L395
; {
; case
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
	align	2
L396:
; goto list
	mjmp	L397
; case
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
	align	2
L398:
; RPN'ized expression: "( dump ) "
; Expanded expression: " dump ()0 "
; Fused expression:    "( dump )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_dump
; goto load_sd_basicprg
	mjmp	L399
; case
; RPN'ized expression: "2 "
; Expanded expression: "2 "
; Expression value: 2
	align	2
L400:
; if
; RPN'ized expression: "txtpos 0 + *u 10 != "
; Expanded expression: "txtpos *(4) 0 + *(1) 10 != "
; Fused expression:    "+ *txtpos 0 != *ax 10 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#0
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L401
; goto qwhat
	mjmp	L376
	align	2
L401:
; RPN'ized expression: "program_end program_start = "
; Expanded expression: "program_end program_start *(4) =(4) "
; Fused expression:    "=(204) *program_end *program_start "
	ldd	R10,$_program_start
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	@R10,R0
; goto prompt
	mjmp	L332
; case
; RPN'ized expression: "3 "
; Expanded expression: "3 "
; Expression value: 3
	align	2
L403:
; RPN'ized expression: "current_line program_start = "
; Expanded expression: "current_line program_start *(4) =(4) "
; Fused expression:    "=(204) *current_line *program_start "
	ldd	R10,$_program_start
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,$_current_line
	add	R10,R10,R4
	movd	@R10,R0
; goto execline
	mjmp	L404
; case
; RPN'ized expression: "4 "
; Expanded expression: "4 "
; Expression value: 4
	align	2
L405:
; goto save_sd_basicprg
	mjmp	L406
; case
; RPN'ized expression: "5 "
; Expanded expression: "5 "
; Expression value: 5
	align	2
L407:
; goto next
	mjmp	L408
; case
; RPN'ized expression: "6 "
; Expanded expression: "6 "
; Expression value: 6
	align	2
L409:
; goto assignment
	mjmp	L410
; case
; RPN'ized expression: "7 "
; Expanded expression: "7 "
; Expression value: 7
	align	2
L411:
; RPN'ized expression: "expression_error 0 = "
; Expanded expression: "expression_error 0 =(1) "
; Fused expression:    "=(156) *expression_error 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	@R10,R0
; RPN'ized expression: "dataptr ( expression ) = "
; Expanded expression: "dataptr  expression ()0 =(2) "
; Fused expression:    "( expression )0 =(172) *dataptr ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expression
	ldd	R10,$_dataptr
	add	R10,R10,R4
	movw	@R10,R0
; if
; RPN'ized expression: "expression_error txtpos *u 10 == || "
; Expanded expression: "expression_error *(1) _Bool [sh||->414] txtpos *(4) *(1) 10 == ||[414] "
; Fused expression:    "*(1) expression_error _Bool [sh||->414] *(4) txtpos == *ax 10 ||[414] "
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	R0,@R10
	mov	R12,R0
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
LC67:
; JumpIfNotZero
	tstsnz	R0,R0 ; jne	label
	sjmp	LC68
	sjmp	L414
LC68:
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
	align	2
L414:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L412
; goto qhow
	mjmp	L348
	align	2
L412:
; if
; RPN'ized expression: "dataptr 0 != "
; Expanded expression: "dataptr *(2) 0 != "
; Fused expression:    "!= *dataptr 0 IF! "
	ldd	R10,$_dataptr
	add	R10,R10,R4
	movw	R0,@R10
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L415
; goto interperateAtTxtpos
	mjmp	L388
	align	2
L415:
; goto execnextline
	mjmp	L387
; case
; RPN'ized expression: "8 "
; Expanded expression: "8 "
; Expression value: 8
	align	2
L417:
; RPN'ized expression: "expression_error 0 = "
; Expanded expression: "expression_error 0 =(1) "
; Fused expression:    "=(156) *expression_error 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	@R10,R0
; RPN'ized expression: "linenum ( expression ) = "
; Expanded expression: "linenum  expression ()0 =(2) "
; Fused expression:    "( expression )0 =(172) *linenum ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expression
	ldd	R10,$_linenum
	add	R10,R10,R4
	movw	@R10,R0
; if
; RPN'ized expression: "expression_error txtpos *u 10 != || "
; Expanded expression: "expression_error *(1) _Bool [sh||->420] txtpos *(4) *(1) 10 != ||[420] "
; Fused expression:    "*(1) expression_error _Bool [sh||->420] *(4) txtpos != *ax 10 ||[420] "
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	R0,@R10
	mov	R12,R0
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
LC69:
; JumpIfNotZero
	tstsnz	R0,R0 ; jne	label
	sjmp	LC70
	sjmp	L420
LC70:
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
	align	2
L420:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L418
; goto qhow
	mjmp	L348
	align	2
L418:
; RPN'ized expression: "current_line ( findline ) = "
; Expanded expression: "current_line  findline ()0 =(4) "
; Fused expression:    "( findline )0 =(204) *current_line ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_findline
	ldd	R10,$_current_line
	add	R10,R10,R4
	movd	@R10,R0
; goto execline
	mjmp	L404
; case
; RPN'ized expression: "9 "
; Expanded expression: "9 "
; Expression value: 9
	align	2
L421:
; goto gosub
	mjmp	L422
; case
; RPN'ized expression: "10 "
; Expanded expression: "10 "
; Expression value: 10
	align	2
L423:
; goto gosub_return
	mjmp	L424
; case
; RPN'ized expression: "11 "
; Expanded expression: "11 "
; Expression value: 11
	align	2
L425:
; goto execnextline
	mjmp	L387
; case
; RPN'ized expression: "12 "
; Expanded expression: "12 "
; Expression value: 12
	align	2
L426:
; goto forloop
	mjmp	L427
; case
; RPN'ized expression: "13 "
; Expanded expression: "13 "
; Expression value: 13
	align	2
L428:
; case
; RPN'ized expression: "14 "
; Expanded expression: "14 "
; Expression value: 14
	align	2
L429:
; goto print
	mjmp	L430
; case
; RPN'ized expression: "15 "
; Expanded expression: "15 "
; Expression value: 15
	align	2
L431:
; goto poke
	mjmp	L432
; case
; RPN'ized expression: "16 "
; Expanded expression: "16 "
; Expression value: 16
	align	2
L433:
; if
; RPN'ized expression: "txtpos 0 + *u 10 != "
; Expanded expression: "txtpos *(4) 0 + *(1) 10 != "
; Fused expression:    "+ *txtpos 0 != *ax 10 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#0
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L434
; goto qwhat
	mjmp	L376
	align	2
L434:
; RPN'ized expression: "current_line program_end = "
; Expanded expression: "current_line program_end *(4) =(4) "
; Fused expression:    "=(204) *current_line *program_end "
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,$_current_line
	add	R10,R10,R4
	movd	@R10,R0
; goto execline
	mjmp	L404
; case
; RPN'ized expression: "17 "
; Expanded expression: "17 "
; Expression value: 17
	align	2
L436:
; return
	mjmp	L327
; case
; RPN'ized expression: "18 "
; Expanded expression: "18 "
; Expression value: 18
	align	2
L437:
; goto memreport
	mjmp	L438
; case
; RPN'ized expression: "19 "
; Expanded expression: "19 "
; Expression value: 19
	align	2
L439:
; goto execnextline
	mjmp	L387
; case
; RPN'ized expression: "20 "
; Expanded expression: "20 "
; Expression value: 20
	align	2
L440:
; {
; loc             value : (@-20): short
; RPN'ized expression: "expression_error 0 = "
; Expanded expression: "expression_error 0 =(1) "
; Fused expression:    "=(156) *expression_error 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	@R10,R0
; RPN'ized expression: "value ( expression ) = "
; Expanded expression: "(@-20)  expression ()0 =(-2) "
; Fused expression:    "( expression )0 =(108) *(@-20) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expression
	ldd	R10,#-20 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; if
; RPN'ized expression: "expression_error value 255 > value 0 < || || "
; Expanded expression: "expression_error *(1) _Bool [sh||->443] (@-20) *(-2) 255 > [sh||->444] (@-20) *(-2) 0 < ||[444] _Bool ||[443] "
; Fused expression:    "*(1) expression_error _Bool [sh||->443] > *(@-20) 255 [sh||->444] < *(@-20) 0 ||[444] _Bool ||[443] "
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	R0,@R10
	mov	R12,R0
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
LC71:
; JumpIfNotZero
	tstsnz	R0,R0 ; jne	label
	sjmp	LC72
	sjmp	L443
LC72:
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	ldb	R10,#255
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC73
	BITSNZ	R12,#31
	sjmp	LC74
	ldb	R0,#0
LC73:
	subslt	R12,R10,R12 ; jae	label
	ldb	R0,#0
LC74:
; JumpIfNotZero
	tstsnz	R0,R0 ; jne	label
	sjmp	LC75
	sjmp	L444
LC75:
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	ldb	R10,#0
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC76
	BITSNZ	R10,#31
	sjmp	LC77
	ldb	R0,#0
LC76:
	subslt	R12,R12,R10 ; jae	label
	ldb	R0,#0
LC77:
	align	2
L444:
	mov	R12,R0
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
LC78:
	align	2
L443:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L441
; goto qwhat
	mjmp	L376
	align	2
L441:
; if
; RPN'ized expression: "txtpos *u 58 == "
; Expanded expression: "txtpos *(4) *(1) 58 == "
; Fused expression:    "*(4) txtpos == *ax 58 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#58
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L445
; {
; RPN'ized expression: "( line_terminator ) "
; Expanded expression: " line_terminator ()0 "
; Fused expression:    "( line_terminator )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_line_terminator
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; goto run_next_statement
	mjmp	L382
; }
	align	2
L445:
; if
; RPN'ized expression: "txtpos *u 10 == "
; Expanded expression: "txtpos *(4) *(1) 10 == "
; Fused expression:    "*(4) txtpos == *ax 10 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L447
; {
; goto execnextline
	mjmp	L387
; }
	align	2
L447:
; goto qwhat
	mjmp	L376
; }
; case
; RPN'ized expression: "21 "
; Expanded expression: "21 "
; Expression value: 21
	align	2
L449:
; goto assignment
	mjmp	L410
; default
	align	2
L450:
; break
	sjmp	L394
; }
	sjmp	L394
	align	2
L395:
	ldb	R10,#0 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L396
	ldb	R10,#1 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L398
	ldb	R10,#2 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L400
	ldb	R10,#3 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L403
	ldb	R10,#4 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L405
	ldb	R10,#5 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L407
	ldb	R10,#6 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L409
	ldb	R10,#7 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L411
	ldb	R10,#8 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L417
	ldb	R10,#9 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L421
	ldb	R10,#10 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L423
	ldb	R10,#11 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L425
	ldb	R10,#12 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L426
	ldb	R10,#13 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L428
	ldb	R10,#14 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L429
	ldb	R10,#15 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L431
	ldb	R10,#16 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L433
	ldb	R10,#17 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L436
	ldb	R10,#18 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L437
	ldb	R10,#19 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L439
	ldb	R10,#20 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L440
	ldb	R10,#21 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L449
	sjmp	L450
	align	2
L394:
; execnextline:
	align	2
L387:
; if
; RPN'ized expression: "current_line 0 == "
; Expanded expression: "current_line *(4) 0 == "
; Fused expression:    "== *current_line 0 IF! "
	ldd	R10,$_current_line
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L451
; goto prompt
	mjmp	L332
	align	2
L451:
; loc     <something> : unsigned short
; RPN'ized expression: "current_line current_line <something453> sizeof + *u += "
; Expanded expression: "current_line current_line *(4) 2u + *(1) +=(4) "
; Fused expression:    "+ *current_line 2u +=(201) *current_line *ax "
	ldd	R10,$_current_line
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#2
	add	R0,R0,R10 ; add eax, const32
	mov	R1, R0
	movb	R2,@R1
	ldd	R10,$_current_line
	add	R10,R10,R4
	movd	R0,@R10
	add	R0,R0,R2 ; add eax, ecx
	ldd	R10,$_current_line
	add	R10,R10,R4
	movd	@R10,R0
; execline:
	align	2
L404:
; if
; RPN'ized expression: "current_line program_end == "
; Expanded expression: "current_line *(4) program_end *(4) == "
; Fused expression:    "== *current_line *program_end IF! "
	ldd	R10,$_current_line
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	R11,@R10
	MOV	R10,R11 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L454
; goto warmstart
	mjmp	L331
	align	2
L454:
; loc     <something> : unsigned short
; loc     <something> : char
; RPN'ized expression: "txtpos current_line <something456> sizeof + <something457> sizeof + = "
; Expanded expression: "txtpos current_line *(4) 3u + =(4) "
; Fused expression:    "+ *current_line 3u =(204) *txtpos ax "
	ldd	R10,$_current_line
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#3
	add	R0,R0,R10 ; add eax, const32
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	@R10,R0
; goto interperateAtTxtpos
	mjmp	L388
; input:
	align	2
L458:
; {
; }
; forloop:
	align	2
L427:
; {
; loc         var : (@-20): unsigned char
; loc         initial : (@-24): short
; loc         step : (@-28): short
; loc         terminal : (@-32): short
; RPN'ized expression: "( ignore_blanks ) "
; Expanded expression: " ignore_blanks ()0 "
; Fused expression:    "( ignore_blanks )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_ignore_blanks
; if
; RPN'ized expression: "txtpos *u 65 < txtpos *u 90 > || "
; Expanded expression: "txtpos *(4) *(1) 65 < [sh||->461] txtpos *(4) *(1) 90 > ||[461] "
; Fused expression:    "*(4) txtpos < *ax 65 [sh||->461] *(4) txtpos > *ax 90 ||[461] "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#65
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC79
	BITSNZ	R10,#31
	sjmp	LC80
	ldb	R0,#0
LC79:
	subslt	R12,R12,R10 ; jae	label
	ldb	R0,#0
LC80:
; JumpIfNotZero
	tstsnz	R0,R0 ; jne	label
	sjmp	LC81
	sjmp	L461
LC81:
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#90
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC82
	BITSNZ	R12,#31
	sjmp	LC83
	ldb	R0,#0
LC82:
	subslt	R12,R10,R12 ; jae	label
	ldb	R0,#0
LC83:
	align	2
L461:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L459
; goto qwhat
	mjmp	L376
	align	2
L459:
; RPN'ized expression: "var txtpos *u = "
; Expanded expression: "(@-20) txtpos *(4) *(1) =(1) "
; Fused expression:    "*(4) txtpos =(153) *(@-20) *ax "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldd	R10,#-20 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; RPN'ized expression: "( ignore_blanks ) "
; Expanded expression: " ignore_blanks ()0 "
; Fused expression:    "( ignore_blanks )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_ignore_blanks
; if
; RPN'ized expression: "txtpos *u 61 != "
; Expanded expression: "txtpos *(4) *(1) 61 != "
; Fused expression:    "*(4) txtpos != *ax 61 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#61
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L462
; goto qwhat
	mjmp	L376
	align	2
L462:
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; RPN'ized expression: "( ignore_blanks ) "
; Expanded expression: " ignore_blanks ()0 "
; Fused expression:    "( ignore_blanks )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_ignore_blanks
; RPN'ized expression: "expression_error 0 = "
; Expanded expression: "expression_error 0 =(1) "
; Fused expression:    "=(156) *expression_error 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	@R10,R0
; RPN'ized expression: "initial ( expression ) = "
; Expanded expression: "(@-24)  expression ()0 =(-2) "
; Fused expression:    "( expression )0 =(108) *(@-24) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expression
	ldd	R10,#-24 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; if
; RPN'ized expression: "expression_error "
; Expanded expression: "expression_error *(1) "
; Fused expression:    "*(1) expression_error "
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	R0,@R10
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L464
; goto qwhat
	mjmp	L376
	align	2
L464:
; RPN'ized expression: "( to_tab scantable ) "
; Expanded expression: " to_tab  scantable ()4 "
; Fused expression:    "( to_tab , scantable )4 "
	incs	R14,R14,#-4
	LDD	R10,$_to_tab
	add	R10,R10,R4
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_scantable
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; if
; RPN'ized expression: "table_index 0 != "
; Expanded expression: "table_index *(1) 0 != "
; Fused expression:    "!= *table_index 0 IF! "
	ldd	R10,$_table_index
	add	R10,R10,R4
	movb	R0,@R10
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L466
; goto qwhat
	mjmp	L376
	align	2
L466:
; RPN'ized expression: "terminal ( expression ) = "
; Expanded expression: "(@-32)  expression ()0 =(-2) "
; Fused expression:    "( expression )0 =(108) *(@-32) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expression
	ldd	R10,#-32 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; if
; RPN'ized expression: "expression_error "
; Expanded expression: "expression_error *(1) "
; Fused expression:    "*(1) expression_error "
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	R0,@R10
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L468
; goto qwhat
	mjmp	L376
	align	2
L468:
; RPN'ized expression: "( step_tab scantable ) "
; Expanded expression: " step_tab  scantable ()4 "
; Fused expression:    "( step_tab , scantable )4 "
	incs	R14,R14,#-4
	LDD	R10,$_step_tab
	add	R10,R10,R4
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_scantable
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; if
; RPN'ized expression: "table_index 0 == "
; Expanded expression: "table_index *(1) 0 == "
; Fused expression:    "== *table_index 0 IF! "
	ldd	R10,$_table_index
	add	R10,R10,R4
	movb	R0,@R10
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L470
; {
; RPN'ized expression: "step ( expression ) = "
; Expanded expression: "(@-28)  expression ()0 =(-2) "
; Fused expression:    "( expression )0 =(108) *(@-28) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expression
	ldd	R10,#-28 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; if
; RPN'ized expression: "expression_error "
; Expanded expression: "expression_error *(1) "
; Fused expression:    "*(1) expression_error "
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	R0,@R10
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L472
; goto qwhat
	mjmp	L376
	align	2
L472:
; }
	sjmp	L471
	align	2
L470:
; else
; RPN'ized expression: "step 1 = "
; Expanded expression: "(@-28) 1 =(-2) "
; Fused expression:    "=(108) *(@-28) 1 "
	ldd	R0,#1 ; // mov	eax, const_32
	ldd	R10,#-28 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
	align	2
L471:
; RPN'ized expression: "( ignore_blanks ) "
; Expanded expression: " ignore_blanks ()0 "
; Fused expression:    "( ignore_blanks )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_ignore_blanks
; if
; RPN'ized expression: "txtpos *u 10 != txtpos *u 58 != && "
; Expanded expression: "txtpos *(4) *(1) 10 != [sh&&->476] txtpos *(4) *(1) 58 != &&[476] "
; Fused expression:    "*(4) txtpos != *ax 10 [sh&&->476] *(4) txtpos != *ax 58 &&[476] "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L476
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#58
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
	align	2
L476:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L474
; goto qwhat
	mjmp	L376
	align	2
L474:
; if
; RPN'ized expression: "expression_error 0 == txtpos *u 10 == && "
; Expanded expression: "expression_error *(1) 0 == [sh&&->479] txtpos *(4) *(1) 10 == &&[479] "
; Fused expression:    "== *expression_error 0 [sh&&->479] *(4) txtpos == *ax 10 &&[479] "
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	R0,@R10
	ldb	R10,#0
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L479
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
	align	2
L479:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L477
; {
; loc             f : (@-36): * struct stack_for_frame
; if
; loc             <something> : struct stack_for_frame
; RPN'ized expression: "sp <something482> sizeof + stack_limit < "
; Expanded expression: "sp *(4) 16u + stack_limit *(4) <u "
; Fused expression:    "+ *sp 16u <u ax *stack_limit IF! "
	ldd	R10,$_sp
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#16
	add	R0,R0,R10 ; add eax, const32
	ldd	R10,$_stack_limit
	add	R10,R10,R4
	movd	R11,@R10
	MOV	R10,R11 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; jxx..
	sjmp	L480
	subslt	R12,R0,R10 ; jge	label
	sjmp	L480
; goto qsorry
	mjmp	L381
	align	2
L480:
; loc             <something> : struct stack_for_frame
; RPN'ized expression: "sp <something483> sizeof -= "
; Expanded expression: "sp 16u -=(4) "
; Fused expression:    "-=(204) *sp 16u "
	ldd	R10,$_sp
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#16
	subslt	R0,R0,R10
 ; sub eax, const32
	and	R0,R0,R0
	ldd	R10,$_sp
	add	R10,R10,R4
	movd	@R10,R0
; loc             <something> : * struct stack_for_frame
; RPN'ized expression: "f sp (something484) = "
; Expanded expression: "(@-36) sp *(4) =(4) "
; Fused expression:    "=(204) *(@-36) *sp "
	ldd	R10,$_sp
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,#-36 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; loc             <something> : * short
; RPN'ized expression: "variables_begin (something485) var 65 - + *u initial = "
; Expanded expression: "variables_begin *(4) (@-20) *(1) 65 - 2 * + (@-24) *(-2) =(-2) "
; Fused expression:    "- *(@-20) 65 * ax 2 + *variables_begin ax =(102) *ax *(@-24) "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	ldb	R10,#65
	subslt	R0,R0,R10
 ; sub eax, const32
	and	R0,R0,R0
	ldd	R10,#2
	mul	R0,R0,R10 ; mul	eax, 2
	mov	R2,R0 ; mov ecx, eax
	ldd	R10,$_variables_begin
	add	R10,R10,R4
	movd	R0,@R10
	add	R0,R0,R2 ; add eax, ecx
	mov	R1,R0 ; mov ebx, eax
	ldd	R10,#-24; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	movw	@R1,R0
; RPN'ized expression: "f frame_type -> *u 70 = "
; Expanded expression: "(@-36) *(4) 0 + 70 =(-1) "
; Fused expression:    "+ *(@-36) 0 =(124) *ax 70 "
	ldd	R10,#-36; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#0
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0 ; mov ebx, eax
	ldd	R0,#70 ; // mov	eax, const_32
	movb	@R1,R0
; RPN'ized expression: "f for_var -> *u var = "
; Expanded expression: "(@-36) *(4) 1 + (@-20) *(1) =(-1) "
; Fused expression:    "+ *(@-36) 1 =(121) *ax *(@-20) "
	ldd	R10,#-36; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#1
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0 ; mov ebx, eax
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	movb	@R1,R0
; RPN'ized expression: "f terminal -> *u terminal = "
; Expanded expression: "(@-36) *(4) 2 + (@-32) *(-2) =(-2) "
; Fused expression:    "+ *(@-36) 2 =(102) *ax *(@-32) "
	ldd	R10,#-36; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#2
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0 ; mov ebx, eax
	ldd	R10,#-32; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	movw	@R1,R0
; RPN'ized expression: "f step -> *u step = "
; Expanded expression: "(@-36) *(4) 4 + (@-28) *(-2) =(-2) "
; Fused expression:    "+ *(@-36) 4 =(102) *ax *(@-28) "
	ldd	R10,#-36; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#4
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0 ; mov ebx, eax
	ldd	R10,#-28; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	movw	@R1,R0
; RPN'ized expression: "f txtpos -> *u txtpos = "
; Expanded expression: "(@-36) *(4) 12 + txtpos *(4) =(4) "
; Fused expression:    "+ *(@-36) 12 =(204) *ax *txtpos "
	ldd	R10,#-36; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#12
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0 ; mov ebx, eax
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	movd	@R1,R0
; RPN'ized expression: "f current_line -> *u current_line = "
; Expanded expression: "(@-36) *(4) 8 + current_line *(4) =(4) "
; Fused expression:    "+ *(@-36) 8 =(204) *ax *current_line "
	ldd	R10,#-36; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#8
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0 ; mov ebx, eax
	ldd	R10,$_current_line
	add	R10,R10,R4
	movd	R0,@R10
	movd	@R1,R0
; goto run_next_statement
	mjmp	L382
; }
	align	2
L477:
; }
; goto qhow
	mjmp	L348
; gosub:
	align	2
L422:
; RPN'ized expression: "expression_error 0 = "
; Expanded expression: "expression_error 0 =(1) "
; Fused expression:    "=(156) *expression_error 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	@R10,R0
; RPN'ized expression: "linenum ( expression ) = "
; Expanded expression: "linenum  expression ()0 =(2) "
; Fused expression:    "( expression )0 =(172) *linenum ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expression
	ldd	R10,$_linenum
	add	R10,R10,R4
	movw	@R10,R0
; if
; RPN'ized expression: "expression_error 0 == txtpos *u 10 == && "
; Expanded expression: "expression_error *(1) 0 == [sh&&->488] txtpos *(4) *(1) 10 == &&[488] "
; Fused expression:    "== *expression_error 0 [sh&&->488] *(4) txtpos == *ax 10 &&[488] "
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	R0,@R10
	ldb	R10,#0
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L488
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
	align	2
L488:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L486
; {
; loc         f : (@-20): * struct stack_gosub_frame
; if
; loc         <something> : struct stack_gosub_frame
; RPN'ized expression: "sp <something491> sizeof + stack_limit < "
; Expanded expression: "sp *(4) 12u + stack_limit *(4) <u "
; Fused expression:    "+ *sp 12u <u ax *stack_limit IF! "
	ldd	R10,$_sp
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#12
	add	R0,R0,R10 ; add eax, const32
	ldd	R10,$_stack_limit
	add	R10,R10,R4
	movd	R11,@R10
	MOV	R10,R11 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; jxx..
	sjmp	L489
	subslt	R12,R0,R10 ; jge	label
	sjmp	L489
; goto qsorry
	mjmp	L381
	align	2
L489:
; loc         <something> : struct stack_gosub_frame
; RPN'ized expression: "sp <something492> sizeof -= "
; Expanded expression: "sp 12u -=(4) "
; Fused expression:    "-=(204) *sp 12u "
	ldd	R10,$_sp
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#12
	subslt	R0,R0,R10
 ; sub eax, const32
	and	R0,R0,R0
	ldd	R10,$_sp
	add	R10,R10,R4
	movd	@R10,R0
; loc         <something> : * struct stack_gosub_frame
; RPN'ized expression: "f sp (something493) = "
; Expanded expression: "(@-20) sp *(4) =(4) "
; Fused expression:    "=(204) *(@-20) *sp "
	ldd	R10,$_sp
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,#-20 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "f frame_type -> *u 71 = "
; Expanded expression: "(@-20) *(4) 0 + 71 =(-1) "
; Fused expression:    "+ *(@-20) 0 =(124) *ax 71 "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#0
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0 ; mov ebx, eax
	ldd	R0,#71 ; // mov	eax, const_32
	movb	@R1,R0
; RPN'ized expression: "f txtpos -> *u txtpos = "
; Expanded expression: "(@-20) *(4) 8 + txtpos *(4) =(4) "
; Fused expression:    "+ *(@-20) 8 =(204) *ax *txtpos "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#8
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0 ; mov ebx, eax
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	movd	@R1,R0
; RPN'ized expression: "f current_line -> *u current_line = "
; Expanded expression: "(@-20) *(4) 4 + current_line *(4) =(4) "
; Fused expression:    "+ *(@-20) 4 =(204) *ax *current_line "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#4
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0 ; mov ebx, eax
	ldd	R10,$_current_line
	add	R10,R10,R4
	movd	R0,@R10
	movd	@R1,R0
; RPN'ized expression: "current_line ( findline ) = "
; Expanded expression: "current_line  findline ()0 =(4) "
; Fused expression:    "( findline )0 =(204) *current_line ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_findline
	ldd	R10,$_current_line
	add	R10,R10,R4
	movd	@R10,R0
; goto execline
	mjmp	L404
; }
	align	2
L486:
; goto qhow
	mjmp	L348
; next:
	align	2
L408:
; RPN'ized expression: "( ignore_blanks ) "
; Expanded expression: " ignore_blanks ()0 "
; Fused expression:    "( ignore_blanks )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_ignore_blanks
; if
; RPN'ized expression: "txtpos *u 65 < txtpos *u 90 > || "
; Expanded expression: "txtpos *(4) *(1) 65 < [sh||->496] txtpos *(4) *(1) 90 > ||[496] "
; Fused expression:    "*(4) txtpos < *ax 65 [sh||->496] *(4) txtpos > *ax 90 ||[496] "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#65
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC84
	BITSNZ	R10,#31
	sjmp	LC85
	ldb	R0,#0
LC84:
	subslt	R12,R12,R10 ; jae	label
	ldb	R0,#0
LC85:
; JumpIfNotZero
	tstsnz	R0,R0 ; jne	label
	sjmp	LC86
	sjmp	L496
LC86:
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#90
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC87
	BITSNZ	R12,#31
	sjmp	LC88
	ldb	R0,#0
LC87:
	subslt	R12,R10,R12 ; jae	label
	ldb	R0,#0
LC88:
	align	2
L496:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L494
; goto qhow
	mjmp	L348
	align	2
L494:
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; RPN'ized expression: "( ignore_blanks ) "
; Expanded expression: " ignore_blanks ()0 "
; Fused expression:    "( ignore_blanks )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_ignore_blanks
; if
; RPN'ized expression: "txtpos *u 58 != txtpos *u 10 != && "
; Expanded expression: "txtpos *(4) *(1) 58 != [sh&&->499] txtpos *(4) *(1) 10 != &&[499] "
; Fused expression:    "*(4) txtpos != *ax 58 [sh&&->499] *(4) txtpos != *ax 10 &&[499] "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#58
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L499
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
	align	2
L499:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L497
; goto qwhat
	mjmp	L376
	align	2
L497:
; gosub_return:
	align	2
L424:
; RPN'ized expression: "tempsp sp = "
; Expanded expression: "tempsp sp *(4) =(4) "
; Fused expression:    "=(204) *tempsp *sp "
	ldd	R10,$_sp
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,$_tempsp
	add	R10,R10,R4
	movd	@R10,R0
; while
; RPN'ized expression: "tempsp program program sizeof + 1 - < "
; Expanded expression: "tempsp *(4) program 511u + <u "
	align	2
L500:
; Fused expression:    "+ program 511u <u *tempsp ax IF! "
	ldd	R0,$_program ; // mov	eax, label
	add	R0,R0,R4
	ldw	R10,#511
	add	R0,R0,R10 ; add eax, const32
	mov	R2,R0 ; mov ecx, eax
	ldd	R10,$_tempsp
	add	R10,R10,R4
	movd	R0,@R10
	MOV	R10,R2 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; jxx..
	sjmp	L501
	subslt	R12,R0,R10 ; jge	label
	sjmp	L501
; {
; switch
; RPN'ized expression: "tempsp 0 + *u "
; Expanded expression: "tempsp *(4) 0 + *(1) "
; Fused expression:    "+ *tempsp 0 *(1) ax "
	ldd	R10,$_tempsp
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#0
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	sjmp	L503
; {
; case
; RPN'ized expression: "71 "
; Expanded expression: "71 "
; Expression value: 71
	align	2
L504:
; if
; RPN'ized expression: "table_index 10 == "
; Expanded expression: "table_index *(1) 10 == "
; Fused expression:    "== *table_index 10 IF! "
	ldd	R10,$_table_index
	add	R10,R10,R4
	movb	R0,@R10
	ldb	R10,#10
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L505
; {
; loc                 f : (@-20): * struct stack_gosub_frame
; loc                 <something> : * struct stack_gosub_frame
; RPN'ized expression: "f tempsp (something507) = "
; Expanded expression: "(@-20) tempsp *(4) =(4) "
; Fused expression:    "=(204) *(@-20) *tempsp "
	ldd	R10,$_tempsp
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,#-20 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "current_line f current_line -> *u = "
; Expanded expression: "current_line (@-20) *(4) 4 + *(4) =(4) "
; Fused expression:    "+ *(@-20) 4 =(204) *current_line *ax "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#4
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movd	R0,@R1; mov	eax, [ebx]
	ldd	R10,$_current_line
	add	R10,R10,R4
	movd	@R10,R0
; RPN'ized expression: "txtpos f txtpos -> *u = "
; Expanded expression: "txtpos (@-20) *(4) 8 + *(4) =(4) "
; Fused expression:    "+ *(@-20) 8 =(204) *txtpos *ax "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#8
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movd	R0,@R1; mov	eax, [ebx]
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	@R10,R0
; loc                 <something> : struct stack_gosub_frame
; RPN'ized expression: "sp <something508> sizeof += "
; Expanded expression: "sp 12u +=(4) "
; Fused expression:    "+=(204) *sp 12u "
	ldd	R10,$_sp
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#12
	add	R0,R0,R10 ; add eax, const32
	ldd	R10,$_sp
	add	R10,R10,R4
	movd	@R10,R0
; goto run_next_statement
	mjmp	L382
; }
	align	2
L505:
; loc             <something> : struct stack_gosub_frame
; RPN'ized expression: "tempsp <something509> sizeof += "
; Expanded expression: "tempsp 12u +=(4) "
; Fused expression:    "+=(204) *tempsp 12u "
	ldd	R10,$_tempsp
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#12
	add	R0,R0,R10 ; add eax, const32
	ldd	R10,$_tempsp
	add	R10,R10,R4
	movd	@R10,R0
; break
	sjmp	L502
; case
; RPN'ized expression: "70 "
; Expanded expression: "70 "
; Expression value: 70
	align	2
L510:
; if
; RPN'ized expression: "table_index 5 == "
; Expanded expression: "table_index *(1) 5 == "
; Fused expression:    "== *table_index 5 IF! "
	ldd	R10,$_table_index
	add	R10,R10,R4
	movb	R0,@R10
	ldb	R10,#5
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L511
; {
; loc                 f : (@-20): * struct stack_for_frame
; loc                 <something> : * struct stack_for_frame
; RPN'ized expression: "f tempsp (something513) = "
; Expanded expression: "(@-20) tempsp *(4) =(4) "
; Fused expression:    "=(204) *(@-20) *tempsp "
	ldd	R10,$_tempsp
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,#-20 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; if
; RPN'ized expression: "txtpos 1 -u + *u f for_var -> *u == "
; Expanded expression: "txtpos *(4) -1 + *(1) (@-20) *(4) 1 + *(-1) == "
; Fused expression:    "+ *txtpos -1 push-ax + *(@-20) 1 == **sp *ax IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,#-1
	add	R0,R0,R10 ; add eax, const32
	incs	R14,R14,#-4;
	movd	@R14,R0 ; Push	eax 
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#1
	add	R0,R0,R10 ; add eax, const32
	mov	R1, R0
	movb	R2,@R1
	bitsz	R2,#7
	add	R2,R2,R9 ; extend char sign bit if needed
	movd	R1,@R14 ; // pop	ebx
	incs	R14,R14,#4
	movb	R0,@R1
	MOV	R10,R2 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L514
; {
; loc                     varaddr : (@-24): * short
; loc                     <something> : * short
; RPN'ized expression: "varaddr variables_begin (something516) txtpos 1 -u + *u + 65 - = "
; Expanded expression: "(@-24) variables_begin *(4) txtpos *(4) -1 + *(1) 2 * + 130 - =(4) "
; Fused expression:    "+ *txtpos -1 * *ax 2 + *variables_begin ax - ax 130 =(204) *(@-24) ax "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,#-1
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldd	R10,#2
	mul	R0,R0,R10 ; mul	eax, 2
	mov	R2,R0 ; mov ecx, eax
	ldd	R10,$_variables_begin
	add	R10,R10,R4
	movd	R0,@R10
	add	R0,R0,R2 ; add eax, ecx
	ldb	R10,#130
	subslt	R0,R0,R10
 ; sub eax, const32
	and	R0,R0,R0
	ldd	R10,#-24 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "varaddr *u varaddr *u f step -> *u + = "
; Expanded expression: "(@-24) *(4) (@-24) *(4) *(-2) (@-20) *(4) 4 + *(-2) + =(-2) "
; Fused expression:    "*(4) (@-24) push-ax *(4) (@-24) push-ax + *(@-20) 4 + **sp *ax =(108) **sp ax "
	ldd	R10,#-24; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	incs	R14,R14,#-4;
	movd	@R14,R0 ; Push	eax 
	ldd	R10,#-24; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	incs	R14,R14,#-4;
	movd	@R14,R0 ; Push	eax 
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#4
	add	R0,R0,R10 ; add eax, const32
	mov	R1, R0
	movsw	R2,@R1
	movd	R1,@R14 ; // pop	ebx
	incs	R14,R14,#4
	movsw	R0,@R1
	add	R0,R0,R2 ; add eax, ecx
	movd	R1,@R14 ; // pop	ebx
	incs	R14,R14,#4
	movw	@R1,R0
; if
; RPN'ized expression: "f step -> *u 0 > varaddr *u f terminal -> *u <= && f step -> *u 0 < varaddr *u f terminal -> *u >= && || "
; Expanded expression: "(@-20) *(4) 4 + *(-2) 0 > [sh&&->521] (@-24) *(4) *(-2) (@-20) *(4) 2 + *(-2) <= &&[521] _Bool [sh||->519] (@-20) *(4) 4 + *(-2) 0 < [sh&&->520] (@-24) *(4) *(-2) (@-20) *(4) 2 + *(-2) >= &&[520] _Bool ||[519] "
; Fused expression:    "+ *(@-20) 4 > *ax 0 [sh&&->521] *(4) (@-24) push-ax + *(@-20) 2 <= **sp *ax &&[521] _Bool [sh||->519] + *(@-20) 4 < *ax 0 [sh&&->520] *(4) (@-24) push-ax + *(@-20) 2 >= **sp *ax &&[520] _Bool ||[519] "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#4
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movw	R0,@R1; mov	ax, [bx]
	movsw	R0,@R1; mov	ax, [bx]
	ldb	R10,#0
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC89
	BITSNZ	R12,#31
	sjmp	LC90
	ldb	R0,#0
LC89:
	subslt	R12,R10,R12 ; jae	label
	ldb	R0,#0
LC90:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L521
	ldd	R10,#-24; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	incs	R14,R14,#-4;
	movd	@R14,R0 ; Push	eax 
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#2
	add	R0,R0,R10 ; add eax, const32
	mov	R1, R0
	movsw	R2,@R1
	movd	R1,@R14 ; // pop	ebx
	incs	R14,R14,#4
	movsw	R0,@R1
	MOV	R10,R2 ; emulated 'cmp' eax, ecx
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	TSTSNZ	R15,R15
	sjmp	LC92
	BITSNZ	R15,#31
	sjmp	LC91
	BITSNZ	R10,#31
	sjmp	LC92
	ldb	R0,#0
LC91:
	subslt	R12,R12,R10 ; jae	label
	ldb	R0,#0
LC92:
	align	2
L521:
	mov	R12,R0
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
LC93:
; JumpIfNotZero
	tstsnz	R0,R0 ; jne	label
	sjmp	LC94
	sjmp	L519
LC94:
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#4
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movw	R0,@R1; mov	ax, [bx]
	movsw	R0,@R1; mov	ax, [bx]
	ldb	R10,#0
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC95
	BITSNZ	R10,#31
	sjmp	LC96
	ldb	R0,#0
LC95:
	subslt	R12,R12,R10 ; jae	label
	ldb	R0,#0
LC96:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L520
	ldd	R10,#-24; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	incs	R14,R14,#-4;
	movd	@R14,R0 ; Push	eax 
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#2
	add	R0,R0,R10 ; add eax, const32
	mov	R1, R0
	movsw	R2,@R1
	movd	R1,@R14 ; // pop	ebx
	incs	R14,R14,#4
	movsw	R0,@R1
	MOV	R10,R2 ; emulated 'cmp' eax, ecx
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	TSTSNZ	R15,R15
	sjmp	LC98
	BITSNZ	R15,#31
	sjmp	LC97
	BITSNZ	R12,#31
	sjmp	LC98
	ldb	R0,#0
LC97:
	subslt	R12,R10,R12 ; jae	label
	ldb	R0,#0
LC98:
	align	2
L520:
	mov	R12,R0
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
LC99:
	align	2
L519:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L517
; {
; RPN'ized expression: "txtpos f txtpos -> *u = "
; Expanded expression: "txtpos (@-20) *(4) 12 + *(4) =(4) "
; Fused expression:    "+ *(@-20) 12 =(204) *txtpos *ax "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#12
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movd	R0,@R1; mov	eax, [ebx]
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	@R10,R0
; RPN'ized expression: "current_line f current_line -> *u = "
; Expanded expression: "current_line (@-20) *(4) 8 + *(4) =(4) "
; Fused expression:    "+ *(@-20) 8 =(204) *current_line *ax "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#8
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movd	R0,@R1; mov	eax, [ebx]
	ldd	R10,$_current_line
	add	R10,R10,R4
	movd	@R10,R0
; goto run_next_statement
	mjmp	L382
; }
	align	2
L517:
; loc                     <something> : struct stack_for_frame
; RPN'ized expression: "sp tempsp <something522> sizeof + = "
; Expanded expression: "sp tempsp *(4) 16u + =(4) "
; Fused expression:    "+ *tempsp 16u =(204) *sp ax "
	ldd	R10,$_tempsp
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#16
	add	R0,R0,R10 ; add eax, const32
	ldd	R10,$_sp
	add	R10,R10,R4
	movd	@R10,R0
; goto run_next_statement
	mjmp	L382
; }
	align	2
L514:
; }
	align	2
L511:
; loc             <something> : struct stack_for_frame
; RPN'ized expression: "tempsp <something523> sizeof += "
; Expanded expression: "tempsp 16u +=(4) "
; Fused expression:    "+=(204) *tempsp 16u "
	ldd	R10,$_tempsp
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#16
	add	R0,R0,R10 ; add eax, const32
	ldd	R10,$_tempsp
	add	R10,R10,R4
	movd	@R10,R0
; break
	sjmp	L502
; default
	align	2
L524:
; goto warmstart
	mjmp	L331
; }
	sjmp	L502
	align	2
L503:
	ldb	R10,#71 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L504
	ldb	R10,#70 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L510
	sjmp	L524
	align	2
L502:
; }
	sjmp	L500
	align	2
L501:
; goto qhow
	mjmp	L348
; assignment:
	align	2
L410:
; {
; loc         value : (@-20): short
; loc         var : (@-24): * short
; if
; RPN'ized expression: "txtpos *u 65 < txtpos *u 90 > || "
; Expanded expression: "txtpos *(4) *(1) 65 < [sh||->527] txtpos *(4) *(1) 90 > ||[527] "
; Fused expression:    "*(4) txtpos < *ax 65 [sh||->527] *(4) txtpos > *ax 90 ||[527] "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#65
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC100
	BITSNZ	R10,#31
	sjmp	LC101
	ldb	R0,#0
LC100:
	subslt	R12,R12,R10 ; jae	label
	ldb	R0,#0
LC101:
; JumpIfNotZero
	tstsnz	R0,R0 ; jne	label
	sjmp	LC102
	sjmp	L527
LC102:
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#90
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC103
	BITSNZ	R12,#31
	sjmp	LC104
	ldb	R0,#0
LC103:
	subslt	R12,R10,R12 ; jae	label
	ldb	R0,#0
LC104:
	align	2
L527:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L525
; goto qhow
	mjmp	L348
	align	2
L525:
; loc         <something> : * short
; RPN'ized expression: "var variables_begin (something528) txtpos *u + 65 - = "
; Expanded expression: "(@-24) variables_begin *(4) txtpos *(4) *(1) 2 * + 130 - =(4) "
; Fused expression:    "*(4) txtpos * *ax 2 + *variables_begin ax - ax 130 =(204) *(@-24) ax "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldd	R10,#2
	mul	R0,R0,R10 ; mul	eax, 2
	mov	R2,R0 ; mov ecx, eax
	ldd	R10,$_variables_begin
	add	R10,R10,R4
	movd	R0,@R10
	add	R0,R0,R2 ; add eax, ecx
	ldb	R10,#130
	subslt	R0,R0,R10
 ; sub eax, const32
	and	R0,R0,R0
	ldd	R10,#-24 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; RPN'ized expression: "( ignore_blanks ) "
; Expanded expression: " ignore_blanks ()0 "
; Fused expression:    "( ignore_blanks )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_ignore_blanks
; if
; RPN'ized expression: "txtpos *u 61 != "
; Expanded expression: "txtpos *(4) *(1) 61 != "
; Fused expression:    "*(4) txtpos != *ax 61 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#61
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L529
; goto qwhat
	mjmp	L376
	align	2
L529:
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; RPN'ized expression: "( ignore_blanks ) "
; Expanded expression: " ignore_blanks ()0 "
; Fused expression:    "( ignore_blanks )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_ignore_blanks
; RPN'ized expression: "expression_error 0 = "
; Expanded expression: "expression_error 0 =(1) "
; Fused expression:    "=(156) *expression_error 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	@R10,R0
; RPN'ized expression: "value ( expression ) = "
; Expanded expression: "(@-20)  expression ()0 =(-2) "
; Fused expression:    "( expression )0 =(108) *(@-20) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expression
	ldd	R10,#-20 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; if
; RPN'ized expression: "expression_error "
; Expanded expression: "expression_error *(1) "
; Fused expression:    "*(1) expression_error "
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	R0,@R10
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L531
; goto qwhat
	mjmp	L376
	align	2
L531:
; if
; RPN'ized expression: "txtpos *u 10 != txtpos *u 58 != && "
; Expanded expression: "txtpos *(4) *(1) 10 != [sh&&->535] txtpos *(4) *(1) 58 != &&[535] "
; Fused expression:    "*(4) txtpos != *ax 10 [sh&&->535] *(4) txtpos != *ax 58 &&[535] "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L535
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#58
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
	align	2
L535:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L533
; goto qwhat
	mjmp	L376
	align	2
L533:
; RPN'ized expression: "var *u value = "
; Expanded expression: "(@-24) *(4) (@-20) *(-2) =(-2) "
; Fused expression:    "*(4) (@-24) =(102) *ax *(@-20) "
	ldd	R10,#-24; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mov	R1,R0 ; mov ebx, eax
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	movw	@R1,R0
; }
; goto run_next_statement
	mjmp	L382
; poke:
	align	2
L432:
; {
; loc         value : (@-20): short
; loc         address : (@-24): * unsigned char
; RPN'ized expression: "expression_error 0 = "
; Expanded expression: "expression_error 0 =(1) "
; Fused expression:    "=(156) *expression_error 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	@R10,R0
; RPN'ized expression: "value ( expression ) = "
; Expanded expression: "(@-20)  expression ()0 =(-2) "
; Fused expression:    "( expression )0 =(108) *(@-20) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expression
	ldd	R10,#-20 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; if
; RPN'ized expression: "expression_error "
; Expanded expression: "expression_error *(1) "
; Fused expression:    "*(1) expression_error "
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	R0,@R10
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L536
; goto qwhat
	mjmp	L376
	align	2
L536:
; loc         <something> : * unsigned char
; RPN'ized expression: "address value (something538) = "
; Expanded expression: "(@-24) (@-20) *(-2) =(4) "
; Fused expression:    "=(198) *(@-24) *(@-20) "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	ldd	R10,#-24 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "( ignore_blanks ) "
; Expanded expression: " ignore_blanks ()0 "
; Fused expression:    "( ignore_blanks )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_ignore_blanks
; if
; RPN'ized expression: "txtpos *u 44 != "
; Expanded expression: "txtpos *(4) *(1) 44 != "
; Fused expression:    "*(4) txtpos != *ax 44 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#44
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L539
; goto qwhat
	mjmp	L376
	align	2
L539:
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; RPN'ized expression: "( ignore_blanks ) "
; Expanded expression: " ignore_blanks ()0 "
; Fused expression:    "( ignore_blanks )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_ignore_blanks
; RPN'ized expression: "expression_error 0 = "
; Expanded expression: "expression_error 0 =(1) "
; Fused expression:    "=(156) *expression_error 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	@R10,R0
; RPN'ized expression: "value ( expression ) = "
; Expanded expression: "(@-20)  expression ()0 =(-2) "
; Fused expression:    "( expression )0 =(108) *(@-20) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expression
	ldd	R10,#-20 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; if
; RPN'ized expression: "expression_error "
; Expanded expression: "expression_error *(1) "
; Fused expression:    "*(1) expression_error "
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	R0,@R10
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L541
; goto qwhat
	mjmp	L376
	align	2
L541:
; if
; RPN'ized expression: "txtpos *u 10 != txtpos *u 58 != && "
; Expanded expression: "txtpos *(4) *(1) 10 != [sh&&->545] txtpos *(4) *(1) 58 != &&[545] "
; Fused expression:    "*(4) txtpos != *ax 10 [sh&&->545] *(4) txtpos != *ax 58 &&[545] "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L545
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#58
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
	align	2
L545:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L543
; goto qwhat
	mjmp	L376
	align	2
L543:
; }
; goto run_next_statement
	mjmp	L382
; list:
	align	2
L397:
; RPN'ized expression: "linenum ( testnum ) = "
; Expanded expression: "linenum  testnum ()0 =(2) "
; Fused expression:    "( testnum )0 =(172) *linenum ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_testnum
	ldd	R10,$_linenum
	add	R10,R10,R4
	movw	@R10,R0
; if
; RPN'ized expression: "txtpos 0 + *u 10 != "
; Expanded expression: "txtpos *(4) 0 + *(1) 10 != "
; Fused expression:    "+ *txtpos 0 != *ax 10 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#0
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L546
; goto qwhat
	mjmp	L376
	align	2
L546:
; RPN'ized expression: "list_line ( findline ) = "
; Expanded expression: "list_line  findline ()0 =(4) "
; Fused expression:    "( findline )0 =(204) *list_line ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_findline
	ldd	R10,$_list_line
	add	R10,R10,R4
	movd	@R10,R0
; while
; RPN'ized expression: "list_line program_end != "
; Expanded expression: "list_line *(4) program_end *(4) != "
	align	2
L548:
; Fused expression:    "!= *list_line *program_end IF! "
	ldd	R10,$_list_line
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	R11,@R10
	MOV	R10,R11 ; emulated 'cmp' eax, ecx
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L549
; RPN'ized expression: "( printline ) "
; Expanded expression: " printline ()0 "
; Fused expression:    "( printline )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_printline
	sjmp	L548
	align	2
L549:
; goto warmstart
	mjmp	L331
; memreport:
	align	2
L438:
; RPN'ized expression: "( variables_begin program_end - printnum ) "
; Expanded expression: " variables_begin *(4) program_end *(4) -  printnum ()4 "
; Fused expression:    "( - *variables_begin *program_end , printnum )4 "
	ldd	R10,$_variables_begin
	add	R10,R10,R4
	movd	R0,@R10
	ldd	R10,$_program_end
	add	R10,R10,R4
	movd	R11,@R10
	subslt	R0,R0,R11
 ; sub eax, const32
	and	R0,R0,R0
	incs	R14,R14,#-4
	movd	@R14,R0
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_printnum
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; RPN'ized expression: "( memorymsg printmsg ) "
; Expanded expression: " memorymsg  printmsg ()4 "
; Fused expression:    "( memorymsg , printmsg )4 "
	incs	R14,R14,#-4
	LDD	R10,$_memorymsg
	add	R10,R10,R4
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_printmsg
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; goto prompt
	mjmp	L332
; load_sd_basicprg:
	align	2
L399:
; goto prompt
	mjmp	L332
; save_sd_basicprg:
	align	2
L406:
; goto prompt
	mjmp	L332
; print:
	align	2
L430:
; if
; RPN'ized expression: "txtpos *u 58 == "
; Expanded expression: "txtpos *(4) *(1) 58 == "
; Fused expression:    "*(4) txtpos == *ax 58 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#58
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L550
; {
; RPN'ized expression: "( line_terminator ) "
; Expanded expression: " line_terminator ()0 "
; Fused expression:    "( line_terminator )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_line_terminator
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; goto run_next_statement
	mjmp	L382
; }
	align	2
L550:
; if
; RPN'ized expression: "txtpos *u 10 == "
; Expanded expression: "txtpos *(4) *(1) 10 == "
; Fused expression:    "*(4) txtpos == *ax 10 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L552
; {
; goto execnextline
	mjmp	L387
; }
	align	2
L552:
; while
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
	align	2
L554:
; Fused expression:    "1 "
	ldd	R0,#1 ; // mov	eax, const_32
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L555
; {
; RPN'ized expression: "( ignore_blanks ) "
; Expanded expression: " ignore_blanks ()0 "
; Fused expression:    "( ignore_blanks )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_ignore_blanks
; if
; RPN'ized expression: "( print_quoted_string ) "
; Expanded expression: " print_quoted_string ()0 "
; Fused expression:    "( print_quoted_string )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_print_quoted_string
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L556
; {
; }
	sjmp	L557
	align	2
L556:
; else
; if
; RPN'ized expression: "txtpos *u 34 == txtpos *u 39 == || "
; Expanded expression: "txtpos *(4) *(1) 34 == [sh||->560] txtpos *(4) *(1) 39 == ||[560] "
; Fused expression:    "*(4) txtpos == *ax 34 [sh||->560] *(4) txtpos == *ax 39 ||[560] "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#34
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
; JumpIfNotZero
	tstsnz	R0,R0 ; jne	label
	sjmp	LC105
	sjmp	L560
LC105:
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#39
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
	align	2
L560:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L558
; goto qwhat
	mjmp	L376
	sjmp	L559
	align	2
L558:
; else
; {
; if
; RPN'ized expression: "table_index 14 == "
; Expanded expression: "table_index *(1) 14 == "
; Fused expression:    "== *table_index 14 IF! "
	ldd	R10,$_table_index
	add	R10,R10,R4
	movb	R0,@R10
	ldb	R10,#14
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L561
; {
; loc                 e : (@-20): short
; RPN'ized expression: "expression_error 0 = "
; Expanded expression: "expression_error 0 =(1) "
; Fused expression:    "=(156) *expression_error 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	@R10,R0
; RPN'ized expression: "e ( expression ) = "
; Expanded expression: "(@-20)  expression ()0 =(-2) "
; Fused expression:    "( expression )0 =(108) *(@-20) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_expression
	ldd	R10,#-20 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; if
; RPN'ized expression: "expression_error "
; Expanded expression: "expression_error *(1) "
; Fused expression:    "*(1) expression_error "
	ldd	R10,$_expression_error
	add	R10,R10,R4
	movb	R0,@R10
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L563
; goto qwhat
	mjmp	L376
	align	2
L563:
; RPN'ized expression: "( e printnum ) "
; Expanded expression: " (@-20) *(-2)  printnum ()4 "
; Fused expression:    "( *(-2) (@-20) , printnum )4 "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	incs	R14,R14,#-4
	movd	@R14,R0
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_printnum
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; }
	sjmp	L562
	align	2
L561:
; else
; {
; loc                 var : (@-20): unsigned char
; loc                 e : (@-24): short
; RPN'ized expression: "( ignore_blanks ) "
; Expanded expression: " ignore_blanks ()0 "
; Fused expression:    "( ignore_blanks )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_ignore_blanks
; RPN'ized expression: "( 63 outchar ) "
; Expanded expression: " 63  outchar ()4 "
; Fused expression:    "( 63 , outchar )4 "
	incs	R14,R14,#-4
	LDD	R10,#63
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_outchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; if
; RPN'ized expression: "txtpos *u 65 < txtpos *u 90 > || "
; Expanded expression: "txtpos *(4) *(1) 65 < [sh||->567] txtpos *(4) *(1) 90 > ||[567] "
; Fused expression:    "*(4) txtpos < *ax 65 [sh||->567] *(4) txtpos > *ax 90 ||[567] "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#65
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC106
	BITSNZ	R10,#31
	sjmp	LC107
	ldb	R0,#0
LC106:
	subslt	R12,R12,R10 ; jae	label
	ldb	R0,#0
LC107:
; JumpIfNotZero
	tstsnz	R0,R0 ; jne	label
	sjmp	LC108
	sjmp	L567
LC108:
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#90
 ; ************************ cmp eax, const32
	mov	R12,R0 ; cmp   eax, const32 (continued)
	ldb	R0,#1
	XOR	R15,R12,R10
	BITSNZ	R15,#31
	sjmp	LC109
	BITSNZ	R12,#31
	sjmp	LC110
	ldb	R0,#0
LC109:
	subslt	R12,R10,R12 ; jae	label
	ldb	R0,#0
LC110:
	align	2
L567:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L565
; goto qwhat
	mjmp	L376
	align	2
L565:
; RPN'ized expression: "var txtpos *u = "
; Expanded expression: "(@-20) txtpos *(4) *(1) =(1) "
; Fused expression:    "*(4) txtpos =(153) *(@-20) *ax "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldd	R10,#-20 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; RPN'ized expression: "( ignore_blanks ) "
; Expanded expression: " ignore_blanks ()0 "
; Fused expression:    "( ignore_blanks )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_ignore_blanks
; if
; RPN'ized expression: "txtpos *u 10 != txtpos *u 58 != && "
; Expanded expression: "txtpos *(4) *(1) 10 != [sh&&->570] txtpos *(4) *(1) 58 != &&[570] "
; Fused expression:    "*(4) txtpos != *ax 10 [sh&&->570] *(4) txtpos != *ax 58 &&[570] "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L570
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#58
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
	align	2
L570:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L568
; goto qwhat
	mjmp	L376
	align	2
L568:
; retry_userinput:
	align	2
L571:
; RPN'ized expression: "e ( process_userinput ) = "
; Expanded expression: "(@-24)  process_userinput ()0 =(-2) "
; Fused expression:    "( process_userinput )0 =(108) *(@-24) ax "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_process_userinput
	ldd	R10,#-24 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movw	@R10,R0
; if
; RPN'ized expression: "e 32768 -u != "
; Expanded expression: "(@-24) *(-2) -32768 != "
; Fused expression:    "!= *(@-24) -32768 IF! "
	ldd	R10,#-24; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	ldd	R10,#-32768
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L572
; loc                 <something> : * short
; RPN'ized expression: "variables_begin (something574) var 65 - + *u e = "
; Expanded expression: "variables_begin *(4) (@-20) *(1) 65 - 2 * + (@-24) *(-2) =(-2) "
; Fused expression:    "- *(@-20) 65 * ax 2 + *variables_begin ax =(102) *ax *(@-24) "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	ldb	R10,#65
	subslt	R0,R0,R10
 ; sub eax, const32
	and	R0,R0,R0
	ldd	R10,#2
	mul	R0,R0,R10 ; mul	eax, 2
	mov	R2,R0 ; mov ecx, eax
	ldd	R10,$_variables_begin
	add	R10,R10,R4
	movd	R0,@R10
	add	R0,R0,R2 ; add eax, ecx
	mov	R1,R0 ; mov ebx, eax
	ldd	R10,#-24; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movsw	R0,@R10
	movw	@R1,R0
	sjmp	L573
	align	2
L572:
; else
; {
; RPN'ized expression: "( redomsg printmsg ) "
; Expanded expression: " redomsg  printmsg ()4 "
; Fused expression:    "( redomsg , printmsg )4 "
	incs	R14,R14,#-4
	LDD	R10,$_redomsg
	add	R10,R10,R4
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_printmsg
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; RPN'ized expression: "( 63 outchar ) "
; Expanded expression: " 63  outchar ()4 "
; Fused expression:    "( 63 , outchar )4 "
	incs	R14,R14,#-4
	LDD	R10,#63
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_outchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; goto retry_userinput
	mjmp	L571
; }
	align	2
L573:
; goto run_next_statement
	mjmp	L382
; }
	align	2
L562:
; }
	align	2
L559:
	align	2
L557:
; if
; RPN'ized expression: "txtpos *u 44 == "
; Expanded expression: "txtpos *(4) *(1) 44 == "
; Fused expression:    "*(4) txtpos == *ax 44 IF! "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#44
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L575
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
	sjmp	L576
	align	2
L575:
; else
; if
; RPN'ized expression: "txtpos 0 + *u 59 == txtpos 1 + *u 10 == txtpos 1 + *u 58 == || && "
; Expanded expression: "txtpos *(4) 0 + *(1) 59 == [sh&&->579] txtpos *(4) 1 + *(1) 10 == [sh||->580] txtpos *(4) 1 + *(1) 58 == ||[580] _Bool &&[579] "
; Fused expression:    "+ *txtpos 0 == *ax 59 [sh&&->579] + *txtpos 1 == *ax 10 [sh||->580] + *txtpos 1 == *ax 58 ||[580] _Bool &&[579] "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#0
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#59
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L579
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#1
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
; JumpIfNotZero
	tstsnz	R0,R0 ; jne	label
	sjmp	LC111
	sjmp	L580
LC111:
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	ldb	R10,#1
	add	R0,R0,R10 ; add eax, const32
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#58
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
	align	2
L580:
	mov	R12,R0
	ldb	R0,#0
	tstsz	R12,R12
	ldb	R0,#1
LC112:
	align	2
L579:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L577
; {
; RPN'ized expression: "txtpos ++p "
; Expanded expression: "txtpos ++p(4) "
; Fused expression:    "++p(4) *txtpos "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
; break
	sjmp	L555
; }
	sjmp	L578
	align	2
L577:
; else
; if
; RPN'ized expression: "txtpos *u 10 == txtpos *u 58 == || "
; Expanded expression: "txtpos *(4) *(1) 10 == [sh||->583] txtpos *(4) *(1) 58 == ||[583] "
; Fused expression:    "*(4) txtpos == *ax 10 [sh||->583] *(4) txtpos == *ax 58 ||[583] "
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#10
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
; JumpIfNotZero
	tstsnz	R0,R0 ; jne	label
	sjmp	LC113
	sjmp	L583
LC113:
	ldd	R10,$_txtpos
	add	R10,R10,R4
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
; mov	al, [bx]
	ldb	R10,#58
 ; ************************ cmp eax, const32
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
	align	2
L583:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L581
; {
; RPN'ized expression: "( line_terminator ) "
; Expanded expression: " line_terminator ()0 "
; Fused expression:    "( line_terminator )0 "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_line_terminator
; break
	sjmp	L555
; }
	sjmp	L582
	align	2
L581:
; else
; goto qwhat
	mjmp	L376
	align	2
L582:
	align	2
L578:
	align	2
L576:
; }
	sjmp	L554
	align	2
L555:
; goto run_next_statement
	mjmp	L382
; Fused expression:    "0 "
	ldd	R0,#0 ; // mov	eax, const_32
	align	2
L327:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L326:
	ldd	R10,#36 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L325

; Syntax/declaration table/stack:
; Bytes used: 3232/70144

	dzerob	3232 
	align	2
Sweet32_stacktop:

; Macro table:
; Macro __SMALLER_C__ = `0x0100`
; Macro __SMALLER_C_32__ = ``
; Macro __SMALLER_C_SCHAR__ = ``
; Macro CR = `'\r'`
; Macro NL = `'\n'`
; Macro TAB = `'\t'`
; Macro BELL = `'\b'`
; Macro SPACE = `' '`
; Macro CTRLC = `0x03`
; Macro CTRLH = `0x08`
; Macro CTRLS = `0x13`
; Macro CTRLX = `0x18`
; Macro NULL = `0x00`
; Macro KW_LIST = `0`
; Macro KW_LOAD = `1`
; Macro KW_NEW = `2`
; Macro KW_RUN = `3`
; Macro KW_SAVE = `4`
; Macro KW_NEXT = `5`
; Macro KW_LET = `6`
; Macro KW_IF = `7`
; Macro KW_GOTO = `8`
; Macro KW_GOSUB = `9`
; Macro KW_RETURN = `10`
; Macro KW_REM = `11`
; Macro KW_FOR = `12`
; Macro KW_INPUT = `13`
; Macro KW_PRINT = `14`
; Macro KW_POKE = `15`
; Macro KW_END = `16`
; Macro KW_BYE = `17`
; Macro KW_MEM = `18`
; Macro KW_CLS = `19`
; Macro KW_DELAY = `20`
; Macro KW_DEFAULT = `21`
; Macro FUNC_PEEK = `0`
; Macro FUNC_ABS = `1`
; Macro FUNC_UNKNOWN = `2`
; Macro RELOP_GE = `0`
; Macro RELOP_NE = `1`
; Macro RELOP_GT = `2`
; Macro RELOP_EQ = `3`
; Macro RELOP_LE = `4`
; Macro RELOP_LT = `5`
; Macro RELOP_UNKNOWN = `6`
; Macro STACK_SIZE = `(sizeof(struct stack_for_frame)*5)`
; Macro VAR_SIZE = `sizeof(short int)`
; Macro STACK_GOSUB_FLAG = `'G'`
; Macro STACK_FOR_FLAG = `'F'`
; Bytes used: 671/4096


; Identifier table:
; Ident linelen
; Ident UART_status
; Ident UART_eventack
; Ident keywords
; Ident stack_for_frame
; Ident frame_type
; Ident for_var
; Ident terminal
; Ident step
; Ident current_line
; Ident txtpos
; Ident <something>
; Ident stack_gosub_frame
; Ident func_tab
; Ident to_tab
; Ident step_tab
; Ident relop_tab
; Ident okmsg
; Ident sderrormsg
; Ident whatmsg
; Ident redomsg
; Ident howmsg
; Ident sorrymsg
; Ident initmsg
; Ident valmsg
; Ident memorymsg
; Ident breakmsg
; Ident unimplimentedmsg
; Ident backspacemsg
; Ident TEXTMODE
; Ident outchar
; Ident inchar
; Ident line_terminator
; Ident expression
; Ident breakcheck
; Ident main
; Ident LINENUM
; Ident linenum
; Ident inputpos
; Ident list_line
; Ident expression_error
; Ident tempsp
; Ident stack_limit
; Ident program_start
; Ident program_end
; Ident stack
; Ident variables_begin
; Ident sp
; Ident table_index
; Ident dataptr
; Ident program
; Ident opcode
; Ident newchar
; Ident setup
; Ident c
; Ident puts
; Ident s
; Ident dump
; Ident process_userinput
; Ident ignore_blanks
; Ident scantable
; Ident table
; Ident pushb
; Ident b
; Ident popb
; Ident divu10
; Ident n
; Ident printnum
; Ident testnum
; Ident printmsgNoNL
; Ident msg
; Ident print_quoted_string
; Ident printmsg
; Ident getln
; Ident prompt
; Ident findline
; Ident toUppercaseBuffer
; Ident printline
; Ident expr4
; Ident expr3
; Ident expr2
; Bytes used: 824/12288

; Next label number: 584
; Compilation succeeded.
