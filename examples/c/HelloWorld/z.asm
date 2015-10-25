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

; glb UART_status : * unsigned short
	align	2
	align	2
_UART_status:
; =
; RPN'ized expression: "1879048192 "
; Expanded expression: "1879048192 "
; Expression value: 1879048192
	align	2
	dd	1879048192
; glb UART_eventack : * unsigned short
	align	2
	align	2
_UART_eventack:
; =
; RPN'ized expression: "1879048194 "
; Expanded expression: "1879048194 "
; Expression value: 1879048194
	align	2
	dd	1879048194
; glb putchar : (
; prm     c : int
;     ) void
	align	2
_putchar:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L2
	align	2
L1:
; loc     c : (@8): int
; wait_tx:
	align	2
L5:
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
	sjmp	L6
; goto wait_tx
	mjmp	L5
	align	2
L6:
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
L3:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L2:
	mjmp	L1
; glb getchar : (void) unsigned
	align	2
_getchar:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L9
	align	2
L8:
; loc     d : (@-4): unsigned
; wait_rx:
	align	2
L12:
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
	sjmp	L13
; goto wait_rx
	mjmp	L12
	align	2
L13:
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
	mjmp	L10
	align	2
L10:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L9:
	ldd	R10,#4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L8
; glb puts : (
; prm     s : * char
;     ) void
	align	2
_puts:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L16
	align	2
L15:
; loc     s : (@8): * char
; while
; RPN'ized expression: "s *u "
; Expanded expression: "(@8) *(4) *(-1) "
	align	2
L19:
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
	sjmp	L20
; RPN'ized expression: "( s ++p *u putchar ) "
; Expanded expression: " (@8) ++p(4) *(-1)  putchar ()4 "
; Fused expression:    "( ++p(4) *(@8) *(-1) ax , putchar )4 "
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
	mjmp	_putchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	sjmp	L19
	align	2
L20:
	align	2
L17:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L16:
	mjmp	L15
; glb gets : (
; prm     buf : * char
;     ) * char
	align	2
_gets:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L22
	align	2
L21:
; loc     buf : (@8): * char
; loc     c : (@-4): int
; loc     s : (@-8): * char
; for
; RPN'ized expression: "s buf = "
; Expanded expression: "(@-8) (@8) *(4) =(4) "
; Fused expression:    "=(204) *(@-8) *(@8) "
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
	align	2
L25:
; RPN'ized expression: "c ( getchar ) = 13 != "
; Expanded expression: "(@-4)  getchar ()0 =(4) 13 != "
; Fused expression:    "( getchar )0 =(204) *(@-4) ax != ax 13 IF! "
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_getchar
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
	ldb	R10,#13
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L28
	sjmp	L27
	align	2
L26:
	sjmp	L25
	align	2
L27:
; {
; switch
; RPN'ized expression: "c "
; Expanded expression: "(@-4) *(4) "
; Fused expression:    "*(4) (@-4) "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	sjmp	L30
; {
; case
; RPN'ized expression: "8 "
; Expanded expression: "8 "
; Expression value: 8
	align	2
L31:
; if
; RPN'ized expression: "s buf > "
; Expanded expression: "(@-8) *(4) (@8) *(4) >u "
; Fused expression:    ">u *(@-8) *(@8) IF! "
	ldd	R10,#-8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldd	R11,#8 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movd	R10,@R11
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; jxx..
	sjmp	L32
	subslt	R12,R10,R0 ; jbe	label
	sjmp	L32
; {
; RPN'ized expression: "s --p "
; Expanded expression: "(@-8) --p(4) "
; Fused expression:    "--p(4) *(@-8) "
	ldd	R10,#-8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#-1
	movd	@R10,R11
; RPN'ized expression: "( 8 putchar ) "
; Expanded expression: " 8  putchar ()4 "
; Fused expression:    "( 8 , putchar )4 "
	incs	R14,R14,#-4
	LDD	R10,#8
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_putchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; RPN'ized expression: "( 32 putchar ) "
; Expanded expression: " 32  putchar ()4 "
; Fused expression:    "( 32 , putchar )4 "
	incs	R14,R14,#-4
	LDD	R10,#32
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_putchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; RPN'ized expression: "( 8 putchar ) "
; Expanded expression: " 8  putchar ()4 "
; Fused expression:    "( 8 , putchar )4 "
	incs	R14,R14,#-4
	LDD	R10,#8
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_putchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; }
	align	2
L32:
; break
	sjmp	L29
; default
	align	2
L34:
; RPN'ized expression: "s ++p *u c = "
; Expanded expression: "(@-8) ++p(4) (@-4) *(4) =(-1) "
; Fused expression:    "++p(4) *(@-8) =(124) *ax *(@-4) "
	ldd	R10,#-8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movd	@R10,R11
	mov	R1,R0 ; mov ebx, eax
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	movb	@R1,R0
; RPN'ized expression: "( c putchar ) "
; Expanded expression: " (@-4) *(4)  putchar ()4 "
; Fused expression:    "( *(4) (@-4) , putchar )4 "
	ldd	R11,#-4 ; push [ebp-ofs]
	add	R11,R11,R13
	movd	R12,@R11
	incs	R14,R14,#-4;
	movd	@R14,R12
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_putchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; }
	sjmp	L29
	align	2
L30:
	ldb	R10,#8 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L31
	sjmp	L34
	align	2
L29:
; }
	sjmp	L26
	align	2
L28:
; RPN'ized expression: "s *u 0 = "
; Expanded expression: "(@-8) *(4) 0 =(-1) "
; Fused expression:    "*(4) (@-8) =(124) *ax 0 "
	ldd	R10,#-8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mov	R1,R0 ; mov ebx, eax
	ldd	R0,#0 ; // mov	eax, const_32
	movb	@R1,R0
; return
; RPN'ized expression: "buf "
; Expanded expression: "(@8) *(4) "
; Fused expression:    "*(4) (@8) "
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mjmp	L23
	align	2
L23:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L22:
	ldd	R10,#8 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L21
; glb divu10 : (
; prm     n : unsigned
;     ) unsigned
	align	2
_divu10:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L36
	align	2
L35:
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
; Expanded expression: "(@-4) *(4) (@-8) *(4) 9 >u [sh||->39] 0 goto &&[39] 1 &&[40] + "
; Fused expression:    ">u *(@-8) 9 [sh||->39] 0 [goto->40] &&[39] 1 &&[40] + *(@-4) ax "
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
	sjmp	LC0
	sjmp	L39
LC0:
	ldd	R0,#0 ; // mov	eax, const_32
	sjmp	L40
	align	2
L39:
	ldd	R0,#1 ; // mov	eax, const_32
	align	2
L40:
	mov	R2,R0 ; mov ecx, eax
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	add	R0,R0,R2 ; add eax, ecx
	mjmp	L37
	align	2
L37:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L36:
	ldd	R10,#8 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L35
; glb hexnum : (
; prm     n : unsigned
;     ) void
	align	2
_hexnum:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L42
	align	2
L41:
; loc     n : (@8): unsigned
; loc     q : (@-4): unsigned
; loc     x : (@-8): unsigned char
; loc     i : (@-12): unsigned char
; loc     leadzeroflag : (@-16): unsigned char
; RPN'ized expression: "q 268435456 = "
; Expanded expression: "(@-4) 268435456 =(4) "
; Fused expression:    "=(204) *(@-4) 268435456 "
	ldd	R0,#268435456 ; // mov	eax, const_32
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "leadzeroflag 0 = "
; Expanded expression: "(@-16) 0 =(1) "
; Fused expression:    "=(156) *(@-16) 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,#-16 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
; RPN'ized expression: "x 0 = "
; Expanded expression: "(@-8) 0 =(1) "
; Fused expression:    "=(156) *(@-8) 0 "
	ldd	R0,#0 ; // mov	eax, const_32
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
; while
; RPN'ized expression: "x 0 == "
; Expanded expression: "(@-8) *(1) 0 == "
	align	2
L45:
; Fused expression:    "== *(@-8) 0 IF! "
	ldd	R10,#-8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L46
; {
; RPN'ized expression: "i 48 = "
; Expanded expression: "(@-12) 48 =(1) "
; Fused expression:    "=(156) *(@-12) 48 "
	ldd	R0,#48 ; // mov	eax, const_32
	ldd	R10,#-12 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
; repeat_loopi:
	align	2
L47:
; if
; RPN'ized expression: "q n < q n == || "
; Expanded expression: "(@-4) *(4) (@8) *(4) <u [sh||->50] (@-4) *(4) (@8) *(4) == ||[50] "
; Fused expression:    "<u *(@-4) *(@8) [sh||->50] == *(@-4) *(@8) ||[50] "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldd	R11,#8 ; inst eax,[ebp-ofs]
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
	sjmp	LC1
	sjmp	L50
LC1:
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldd	R11,#8 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movd	R10,@R11
	xor	R12,R0,R10
	ldb	R0,#0
	tstsnz	R12,R12
	ldb	R0,#1
	align	2
L50:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L48
; {
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-12) ++p(1) "
; Fused expression:    "++p(1) *(@-12) "
	ldd	R10,#-12; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R11,@R10
	mov	R0,R11
	incs	R11,R11,#1
	movb	@R10,R11
; RPN'ized expression: "n n q - = "
; Expanded expression: "(@8) (@8) *(4) (@-4) *(4) - =(4) "
; Fused expression:    "- *(@8) *(@-4) =(204) *(@8) ax "
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldd	R11,#-4 ; inst eax,[ebp-ofs]
	add	R11,R11,R13
	movd	R10,@R11
	subslt	R0,R0,R10
 ; sub eax,[ebp-ofs]
	and	R0,R0,R0
	ldd	R10,#8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "leadzeroflag 1 = "
; Expanded expression: "(@-16) 1 =(1) "
; Fused expression:    "=(156) *(@-16) 1 "
	ldd	R0,#1 ; // mov	eax, const_32
	ldd	R10,#-16 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
; goto repeat_loopi
	mjmp	L47
; }
	sjmp	L49
	align	2
L48:
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
	sjmp	L51
; {
; if
; RPN'ized expression: "leadzeroflag 0 == "
; Expanded expression: "(@-16) *(1) 0 == "
; Fused expression:    "== *(@-16) 0 IF! "
	ldd	R10,#-16; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L53
; RPN'ized expression: "( i putchar ) "
; Expanded expression: " (@-12) *(1)  putchar ()4 "
; Fused expression:    "( *(1) (@-12) , putchar )4 "
	ldd	R10,#-12; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	incs	R14,R14,#-4
	movd	@R14,R0
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_putchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	align	2
L53:
; RPN'ized expression: "x 1 = "
; Expanded expression: "(@-8) 1 =(1) "
; Fused expression:    "=(156) *(@-8) 1 "
	ldd	R0,#1 ; // mov	eax, const_32
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
; }
	align	2
L51:
; if
; RPN'ized expression: "i 57 > "
; Expanded expression: "(@-12) *(1) 57 > "
; Fused expression:    "> *(@-12) 57 IF! "
	ldd	R10,#-12; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	ldb	R10,#57
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12
	sjmp	L55
	XOR	R12,R0,R10
	BITSNZ	R12,#31
	sjmp	LC2
	BITSNZ	R0,#31
	sjmp	LC3
	sjmp	L55
LC2:
	subslt	R12,R10,R0 ; jle	label
	sjmp	L55
LC3:
; RPN'ized expression: "i i 7 + = "
; Expanded expression: "(@-12) (@-12) *(1) 7 + =(1) "
; Fused expression:    "+ *(@-12) 7 =(156) *(@-12) ax "
	ldd	R10,#-12; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	ldb	R10,#7
	add	R0,R0,R10 ; add eax, const32
	ldd	R10,#-12 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
	align	2
L55:
; if
; RPN'ized expression: "leadzeroflag "
; Expanded expression: "(@-16) *(1) "
; Fused expression:    "*(1) (@-16) "
	ldd	R10,#-16; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L57
; RPN'ized expression: "( i putchar ) "
; Expanded expression: " (@-12) *(1)  putchar ()4 "
; Fused expression:    "( *(1) (@-12) , putchar )4 "
	ldd	R10,#-12; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	incs	R14,R14,#-4
	movd	@R14,R0
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_putchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	align	2
L57:
; RPN'ized expression: "q q 4 >> = "
; Expanded expression: "(@-4) (@-4) *(4) 4 >>u =(4) "
; Fused expression:    ">>u *(@-4) 4 =(204) *(@-4) ax "
	ldd	R10,#-4; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	lsr	R0,R0 ; shr eax, 1
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; }
	align	2
L49:
; }
	sjmp	L45
	align	2
L46:
	align	2
L43:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L42:
	ldd	R10,#16 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L41
; glb printnum : (
; prm     n : int
;     ) void
	align	2
_printnum:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L60
	align	2
L59:
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
	sjmp	L63
; {
; RPN'ized expression: "( 45 putchar ) "
; Expanded expression: " 45  putchar ()4 "
; Fused expression:    "( 45 , putchar )4 "
	incs	R14,R14,#-4
	LDD	R10,#45
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_putchar
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
	sjmp	L64
	align	2
L63:
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
L64:
; while
; RPN'ized expression: "x 0 == "
; Expanded expression: "(@-12) *(1) 0 == "
	align	2
L65:
; Fused expression:    "== *(@-12) 0 IF! "
	ldd	R10,#-12; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L66
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
L67:
; if
; RPN'ized expression: "q r < q r == || "
; Expanded expression: "(@-4) *(4) (@-8) *(4) <u [sh||->70] (@-4) *(4) (@-8) *(4) == ||[70] "
; Fused expression:    "<u *(@-4) *(@-8) [sh||->70] == *(@-4) *(@-8) ||[70] "
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
	sjmp	LC4
	sjmp	L70
LC4:
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
L70:
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L68
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
	mjmp	L67
; }
	sjmp	L69
	align	2
L68:
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
	sjmp	L71
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
	sjmp	L73
; RPN'ized expression: "( i putchar ) "
; Expanded expression: " (@-16) *(1)  putchar ()4 "
; Fused expression:    "( *(1) (@-16) , putchar )4 "
	ldd	R10,#-16; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	incs	R14,R14,#-4
	movd	@R14,R0
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_putchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	align	2
L73:
; RPN'ized expression: "x 1 = "
; Expanded expression: "(@-12) 1 =(1) "
; Fused expression:    "=(156) *(@-12) 1 "
	ldd	R0,#1 ; // mov	eax, const_32
	ldd	R10,#-12 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movb	@R10,R0
; }
	align	2
L71:
; if
; RPN'ized expression: "leadzeroflag "
; Expanded expression: "(@-20) *(1) "
; Fused expression:    "*(1) (@-20) "
	ldd	R10,#-20; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
; JumpIfZero
	tstsnz	R0,R0 ; test	ax,ax
	sjmp	L75
; RPN'ized expression: "( i putchar ) "
; Expanded expression: " (@-16) *(1)  putchar ()4 "
; Fused expression:    "( *(1) (@-16) , putchar )4 "
	ldd	R10,#-16; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movb	R0,@R10
	incs	R14,R14,#-4
	movd	@R14,R0
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_putchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	align	2
L75:
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
L69:
; }
	sjmp	L65
	align	2
L66:
	align	2
L61:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L60:
	ldd	R10,#20 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L59
; glb printf : (
; prm     fmt : * char
; prm     ...
;     ) int
	align	2
_printf:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L78
	align	2
L77:
; loc     fmt : (@8): * char
; loc     ap : (@-4): * int
; loc     x : (@-8): int
; loc     c : (@-12): int
; RPN'ized expression: "ap fmt &u = "
; Expanded expression: "(@-4) (@8) =(4) "
; Fused expression:    "=(204) *(@-4) (@8) "
	ldd	R10,#8 ; lea	eax, [ebp-ofs]
	add	R0,R10,R13
	ldd	R10,#-4 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; RPN'ized expression: "ap ++p "
; Expanded expression: "(@-4) 4 +=p(4) "
; Fused expression:    "+=p(4) *(@-4) 4 "
	ldd	R10,#-4  ; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldd	R10,#-4 ; add/sub [ebp-ofs], const32
	add	R10,R10,R13
	movd	R11,@R10
	ldd	R12,#4
	add	R11,R11,R12
	movd	@R10,R11
; while
; RPN'ized expression: "fmt *u 0 != "
; Expanded expression: "(@8) *(4) *(-1) 0 != "
	align	2
L81:
; Fused expression:    "*(4) (@8) != *ax 0 IF! "
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
	bitsz	R0,#7
	add	R0,R0,R9 ; extend char sign bit if needed
	ldb	R10,#0
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsnz	R12,R12 ; je	label
	sjmp	L82
; {
; if
; RPN'ized expression: "fmt *u 37 == "
; Expanded expression: "(@8) *(4) *(-1) 37 == "
; Fused expression:    "*(4) (@8) == *ax 37 IF! "
	ldd	R10,#8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	mov	R1,R0; mov	ebx, eax
	movb	R0,@R1
	bitsz	R0,#7
	add	R0,R0,R9 ; extend char sign bit if needed
	ldb	R10,#37
 ; ************************ cmp eax, const32
	; ** if_!_token found!
	xor	R12,R0,R10
	tstsz	R12,R12 ; jne	label
	sjmp	L83
; {
; RPN'ized expression: "fmt ++p *u "
; Expanded expression: "(@8) ++p(4) *(-1) "
; Fused expression:    "++p(4) *(@8) *(-1) ax "
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
; RPN'ized expression: "x ap ++p *u = "
; Expanded expression: "(@-8) (@-4) 4 +=p(4) *(4) =(4) "
; Fused expression:    "+=p(4) *(@-4) 4 =(204) *(@-8) *ax "
	ldd	R10,#-4  ; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldd	R10,#-4 ; add/sub [ebp-ofs], const32
	add	R10,R10,R13
	movd	R11,@R10
	ldd	R12,#4
	add	R11,R11,R12
	movd	@R10,R11
	mov	R1,R0; mov	ebx, eax
	movd	R0,@R1; mov	eax, [ebx]
	ldd	R10,#-8 ; mov	[ebp-ofs], eax
	add	R10,R10,R13
	movd	@R10,R0
; switch
; RPN'ized expression: "fmt ++p *u "
; Expanded expression: "(@8) ++p(4) *(-1) "
; Fused expression:    "++p(4) *(@8) *(-1) ax "
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
	sjmp	L86
; {
; case
; RPN'ized expression: "100 "
; Expanded expression: "100 "
; Expression value: 100
	align	2
L87:
; case
; RPN'ized expression: "105 "
; Expanded expression: "105 "
; Expression value: 105
	align	2
L88:
; RPN'ized expression: "( x printnum ) "
; Expanded expression: " (@-8) *(4)  printnum ()4 "
; Fused expression:    "( *(4) (@-8) , printnum )4 "
	ldd	R11,#-8 ; push [ebp-ofs]
	add	R11,R11,R13
	movd	R12,@R11
	incs	R14,R14,#-4;
	movd	@R14,R12
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_printnum
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; break
	sjmp	L85
; case
; RPN'ized expression: "115 "
; Expanded expression: "115 "
; Expression value: 115
	align	2
L89:
; RPN'ized expression: "( x puts ) "
; Expanded expression: " (@-8) *(4)  puts ()4 "
; Fused expression:    "( *(4) (@-8) , puts )4 "
	ldd	R11,#-8 ; push [ebp-ofs]
	add	R11,R11,R13
	movd	R12,@R11
	incs	R14,R14,#-4;
	movd	@R14,R12
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_puts
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; break
	sjmp	L85
; case
; RPN'ized expression: "88 "
; Expanded expression: "88 "
; Expression value: 88
	align	2
L90:
; case
; RPN'ized expression: "120 "
; Expanded expression: "120 "
; Expression value: 120
	align	2
L91:
; RPN'ized expression: "( x hexnum ) "
; Expanded expression: " (@-8) *(4)  hexnum ()4 "
; Fused expression:    "( *(4) (@-8) , hexnum )4 "
	ldd	R11,#-8 ; push [ebp-ofs]
	add	R11,R11,R13
	movd	R12,@R11
	incs	R14,R14,#-4;
	movd	@R14,R12
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_hexnum
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; break
	sjmp	L85
; case
; RPN'ized expression: "99 "
; Expanded expression: "99 "
; Expression value: 99
	align	2
L92:
; RPN'ized expression: "( x 255 & putchar ) "
; Expanded expression: " (@-8) *(4) 255 &  putchar ()4 "
; Fused expression:    "( & *(@-8) 255 , putchar )4 "
	ldd	R10,#-8; mov	eax, [ebp-ofs]
	add	R10,R10,R13
	movd	R0,@R10
	ldb	R10,#255
	and	R0,R0,R10 ; and eax, const32
	incs	R14,R14,#-4
	movd	@R14,R0
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_putchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; break
	sjmp	L85
; }
	sjmp	L85
	align	2
L86:
	ldb	R10,#100 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L87
	ldb	R10,#105 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L88
	ldb	R10,#115 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L89
	ldb	R10,#88 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L90
	ldb	R10,#120 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L91
	ldb	R10,#99 ; cmp ax,const
	xor	R10,R10,R0
	tstsnz	R10,R10 ; je	label
	sjmp	L92
	align	2
L85:
; }
	sjmp	L84
	align	2
L83:
; else
; RPN'ized expression: "( fmt ++p *u putchar ) "
; Expanded expression: " (@8) ++p(4) *(-1)  putchar ()4 "
; Fused expression:    "( ++p(4) *(@8) *(-1) ax , putchar )4 "
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
	mjmp	_putchar
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	align	2
L84:
; }
	sjmp	L81
	align	2
L82:
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0 "
	ldd	R0,#0 ; // mov	eax, const_32
	mjmp	L79
	align	2
L79:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L78:
	ldd	R10,#12 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
	mjmp	L77
; glb main : (void) void
	align	2
_main:
	align	2
	incs	R14,R14,#-4
	movd	@R14,R13
	MOV	R13,R14
	mjmp	L94
	align	2
L93:
; RPN'ized expression: "( L97 printf ) "
; Expanded expression: " L97  printf ()4 "
	sjmp	L98
	align	2
L97:
	ds	"Hello World!!! "
	db	13

	db	10

	db	0

	db	0
	align	2

	align	2
L98:
; Fused expression:    "( L97 , printf )4 "
	incs	R14,R14,#-4
	LDD	R10,$L97
	add	R10,R10,R4
	movd	@R14,R10
	incs	R14,R14,#-4; // Call *label
	getpc   R15,#4
	movd	@R14,R15
	mjmp	_printf
	ldd	R10,#-4 ; sub	esp, const
	subslt	R14,R14,R10
	and	R0,R0,R0
; Fused expression:    "0 "
	ldd	R0,#0 ; // mov	eax, const_32
	align	2
L95:
	mov	R14,R13
	movd	R13,@R14
	incs	R14,R14,#4
	movd	R10,@R14
	incs	R14,R14,#4
	ljmp	R10
	align	2
L94:
	mjmp	L93

; Syntax/declaration table/stack:
; Bytes used: 600/70144

	dzerob	600 
	align	2
Sweet32_stacktop:

; Macro table:
; Macro __SMALLER_C__ = `0x0100`
; Macro __SMALLER_C_32__ = ``
; Macro __SMALLER_C_SCHAR__ = ``
; Macro _STDIO_H_ = ``
; Bytes used: 75/4096


; Identifier table:
; Ident UART_status
; Ident UART_eventack
; Ident putchar
; Ident c
; Ident getchar
; Ident <something>
; Ident puts
; Ident s
; Ident gets
; Ident buf
; Ident divu10
; Ident n
; Ident hexnum
; Ident printnum
; Ident printf
; Ident fmt
; Ident main
; Bytes used: 130/12288

; Next label number: 99
; Compilation succeeded.
