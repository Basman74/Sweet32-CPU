; directive tests
;
; case insensitive, optionally preceded with "."

;

;	{ "ARCH",		DIR_ARCH		},
;			ARCH	TODO						; switch CPU architecture

;	{ "CPU",		DIR_CPU			},
;			CPU		TODO						; switch specific CPU implementation

;	{ "ORG",		DIR_ORG			},

			ORG		0x1000					; first ORG of a section with no data sets start address
begin:
			dd		.
			.ORG	0x1010
			DD		.						; subsequent ORG just changes "logical" address
			.org	.+0x10
			DD		.						; subsequent ORG just changes "logical" address
		
;	{ "ENDIAN",		DIR_ENDIAN		},

			DD		0x03020100
			ENDIAN								; default endian for architecture/CPU
			.DD		0x03020100
			endian	little-endian				; switch to little endian (LSB at lowest address)
			DD		0x03020100
			dw		0x0100
			DB		0x42
			ENDIAN	big-endian					; switch to big endian (MSB at lowest address)
			DD		0x03020100
			.DW		0x0100
			db		0x42
			.ENDIAN								; restore default endian
			DD		0x03020100
		
;	{ "INCLUDE",	DIR_INCLUDE		},

include_count: = 0									; initialize to avoid warning

			INCLUDE		test_include.asm
			.include	"test_include.asm"	; quotes needed if whitespace in name

;	{ "INCBIN",		DIR_INCBIN		},
table1:		INCBIN	binary.bin				; directly includes binary file into output
table2:		.incbin	"binary.bin"				; quotes needed if whitespace in name
;	{ "EQU",		DIR_EQU			},

constant:	EQU		0x01234567						; EQU set labels can not be redefined (actually a string assignment, so gets re-evaluated on use)
equasion:	.EQU	(constant << 4) | 0x8			; supports all C operators and precedence
opertest:	equ		(1+1)+(2*2)+(4/4)+(5**5)
logtest:	equ		0xaaaa|0x5555^0xffff<<1>>1
ternaryf:	.equ	6 == 9 ? 0 : 1					; including ternary operator (conditional)
ternaryt:	equ		6 != 9 ? 1 : 0
//somestr:	equ		"Hello"

			ASSERT	constant==0x01234567,"constant=",constant
			ASSERT	equasion==0x12345678,"equasion=",equasion
			ASSERT	opertest==0xc3c,"opertest=",opertest
			ASSERT	logtest==0xaaaa,"logtest=",logtest
			ASSERT	ternaryf,"ternaryf=",ternaryf
			ASSERT	ternaryt,"ternaryt=",ternaryt

;	{ "SECTION",	DIR_SECTION		},

			SECTION	"layout",0x2000,NOLOAD
			
			DD		0x01020304					; won't be in output due to NOLOAD
			
			.previous
			SECTION	"real",0x2000
			
			dd		0xdeadbeef
			.previous

;	{ "SEGMENT",	DIR_SECTION		},
			.previous
			SEGMENT	"real"
			
			dd		0xc0edbabe
			
			.segment "layout"
			dd		$0x0

;	{ "TEXT",		DIR_TEXTSECTION	},

			.text
			
			hex		42
			
;	{ "DATA",		DIR_DATASECTION	},

			.data
			
			ASCIIZ	"DATASECT"
			
;	{ "BSS",		DIR_BSSSECTION	},
			.bss
			
			ASCIIZ	"NOT IN BINARY"
			
;	{ "PREVIOUS",	DIR_PREVSECTION	},

			previous
			.PREVIOUS
			PREVIOUS

			
;	{ "=",			DIR_ASSIGN		},



variable:	= 0								; optional, but will issue warning
variable:	= variable + 1					; = (or ASSIGN'd) variables can be reassigned without error
variable:	= variable + 1					; note .= is not legal

;	{ "ASSIGN",		DIR_ASSIGN		},

variable:	.assign variable + 1
variable:	.ASSIGN	variable + 1
variable:	assign variable + 1
variable:	ASSIGN	variable + 1

			ASSERT	variable == 6, "Expected 6, got ", variable

;	{ "ALIGN",		DIR_ALIGN		},

			DB		0x42
			align	2
			ASSERT	(.%2)==0, "Not 2 byte boundary"
			DB		0x42
			align	4
			ASSERT	(.%4)==0, "Not 4 byte boundary"
			DB		$0x42
			align	8
			ASSERT	(.%8)==0, "Not 8 byte boundary"
			DB		0x42
			align	16
			ASSERT	(.%16)==0, "Not 16 byte boundary"

;	{ "SPACEDBL",	DIR_SPACE_DBL	},
sizechk:		=		.

			.spacedbl	1
			.SPACEDBL	1
			spacedbl	2
			SPACEDBL	2
	
			ASSERT	.-sizechk == (6*8)	; 8 bytes each

;	{ "SPACEB",		DIR_SPACE_8		},
sizechk:		=		.

			.spaceb	1
			.SPACEB	1
			spaceb	2
			SPACEB	2
	
			ASSERT	.-sizechk == (6)		; 1 byte each

;	{ "SPACEH",		DIR_SPACE_16	},
sizechk:		=		.

			.spaceh	1
			.SPACEH	1
			spaceh	2
			SPACEH	2
	
			ASSERT	.-sizechk == (6*2)	; 2 bytes each

;	{ "SPACES",		DIR_SPACE_16	},
sizechk:		=		.

			.spaces	1
			.SPACES	1
			spaces	2
			SPACES	2
	
			ASSERT	.-sizechk == (6*2)	; 2 bytes each

;	{ "SPACEW",		DIR_SPACE_16	},
sizechk:		=		.

			.spacew	1
			.SPACEW	1
			spacew	2
			SPACEW	2
	
			ASSERT	.-sizechk == (6*2)	; 2 bytes each

;	{ "SPACEI",		DIR_SPACE_32	},
sizechk:		=		.

			.spacei	1
			.SPACEI	1
			spacei	2
			SPACEI	2
	
			ASSERT	.-sizechk == (6*4)	; 4 bytes each

;	{ "SPACED",		DIR_SPACE_32	},
sizechk:		=		.

			.spaced	1
			.SPACED	1
			spaced	2
			SPACED	2
	
			ASSERT	.-sizechk == (6*4)	; 4 bytes each

;	{ "SPACEL",		DIR_SPACE_64	},
sizechk:		=		.

			.spacel	1
			.SPACEL	1
			spacel	2
			SPACEL	2
	
			ASSERT	.-sizechk == (6*8)	; 8 bytes each

;	{ "SPACEF",		DIR_SPACE_FLOAT	},
sizechk:		=		.

			.spacef	1
			.SPACEF	1
			spacef	2
			SPACEF	2
	
			ASSERT	.-sizechk == (6*4)	; 4 bytes each

;	{ "SPACE",		DIR_SPACE_8		},
sizechk:		=		.

			.space	1
			.SPACE	1
			space	2
			SPACE	2
	
			ASSERT	.-sizechk == (6)		; 1 byte each

;	{ "DZEROB",		DIR_SPACE_8		},
sizechk:		=		.

			.dzerob	1
			.DZEROB	1
			dzerob	2
			DZEROB	2
	
			ASSERT	.-sizechk == (6)		; 1 byte each

;	{ "DZEROW",		DIR_SPACE_16	},
sizechk:		=		.

			.dzerow	1
			.DZEROW	1
			dzerow	2
			DZEROW	2
	
			ASSERT	.-sizechk == (6*2)	; 2 bytes each

;	{ "DZEROD",		DIR_SPACE_32	},
sizechk:		=		.

			.dzerod	1
			.DZEROD	1
			dzerod	2
			DZEROD	2
	
			ASSERT	.-sizechk == (6*4)	; 4 bytes each

;	{ "FILLB",		DIR_FILL_8		},
sizechk:		=		.

			.fillb	-1,1
			.FILLB	0x12,1
			fillb	0x34,2
			FILLB	0x42,2
	
			ASSERT	.-sizechk == (6)		; 1 byte each

;	{ "FILLH",		DIR_FILL_16		},
sizechk:		=		.

			.fillh	-1,1
			.FILLH	0x1234,1
			fillh	0x5678,2
			FILLH	0xABCD,2
	
			ASSERT	.-sizechk == (6*2)	; 2 bytes each

;	{ "FILLS",		DIR_FILL_16		},
sizechk:		=		.

			.fills	-1,1
			.FILLS	0x1234,1
			fills	0x5678,2
			FILLS	0xABCD,2
	
			ASSERT	.-sizechk == (6*2)	; 2 bytes each

;	{ "FILLW",		DIR_FILL_16		},
sizechk:		=		.

			.fillw	-1,1
			.FILLW	0x1234,1
			fillw	0x5678,2
			FILLW	0xABCD,2
	
			ASSERT	.-sizechk == (6*2)	; 2 bytes each

;	{ "FILLI",		DIR_FILL_32		},
sizechk:		=		.

			.filli	-1,1
			.FILLI	0x12345678,1
			filli	0x56789abc,2
			FILLI	0xFEDCBA98,2
	
			ASSERT	.-sizechk == (6*4)	; 4 bytes each


;	{ "FILLD",		DIR_FILL_32		},
sizechk:		=		.

			.filld	-1,1
			.FILLD	0x12345678,1
			filld	0x56789abc,2
			FILLD	0xFEDCBA98,2
	
			ASSERT	.-sizechk == (6*4)	; 4 bytes each

;	{ "FILLL",		DIR_FILL_64		},
sizechk:		=		.

			.filll	-1,1
			.FILLL	0x123456789abcdef,1
			filll	0x123456789abcdef,2
			FILLL	0xfedcba9876543210,2
	
			ASSERT	.-sizechk == (6*8)	; 8 bytes each


;	{ "FILL",		DIR_FILL_8		},
sizechk:		=		.

			.fill	-1,1
			.FILL	0x12,1
			fill	0x34,2
			FILL	0x42,2
	
			ASSERT	.-sizechk == (6)	; 1 byte each

;	{ "FILLF",		DIR_FILL_FLOAT		},
sizechk:		=		.

			.fillf	1.0,1
			.FILLF	-1.0,1
			fillf	2.0,2
			FILLF	3.141535897,2
	
			ASSERT	.-sizechk == (6*4)	; 4 bytes each

;	{ "FILLDBL",	DIR_FILL_DBL		},
sizechk:		=		.

			.filldbl 1.0,1
			.FILLDBL -1.0,1
			filldbl	2.0,2
			FILLDBL	3.1415926535897932,2
	
			ASSERT	.-sizechk == (6*8)	; 8 bytes each

;	{ "HEX",		DIR_DEF_HEX		},
sizechk:		=		.

			.hex	0102030405060708
			.HEX	AABBCCDDEEFF0123
			hex		01020304
			HEX		deadbeef

			ASSERT	.-sizechk == (24)

;	{ "CHAR",		DIR_DEF_8		},
sizechk:		=		.

			.char	'A','B',1,2,3,4,5,6
			.CHAR	-1,-2,-3,-4,-5,-6,-7,-8
			char	0
			CHAR	0x42
			
			ASSERT	.-sizechk == (18)

;	{ "BYTE",		DIR_DEF_8		},
sizechk:		=		.

			.byte	'A','B',1,2,3,4,5,6
			.BYTE	-1,-2,-3,-4,-5,-6,-7,-8
			byte	0
			BYTE	0x42
			
			ASSERT	.-sizechk == (18)

;	{ "DB",			DIR_DEF_8		},
sizechk:		=		.

			.db		'A','B',1,2,3,4,5,6
			.DB		-1,-2,-3,-4,-5,-6,-7,-8
			db		0
			DB		0x42
			
			ASSERT	.-sizechk == (18)

;	{ "HALF",		DIR_DEF_16		},
sizechk:		=		.

			.half	'A','B',1,2,3,4,5,6
			.HALF	-1,-2,-3,-4,-5,-6,-7,-8
			half	0x0123
			HALF	0x4567
			
			ASSERT	.-sizechk == (18*2)

;	{ "SHORT",		DIR_DEF_16		},
sizechk:		=		.

			.short	'A','B',1,2,3,4,5,6
			.SHORT	-1,-2,-3,-4,-5,-6,-7,-8
			short	0x0123
			SHORT	0x4567
			
			ASSERT	.-sizechk == (18*2)

;	{ "WORD",		DIR_DEF_16		},
sizechk:		=		.

			.word	'A','B',1,2,3,4,5,6
			.WORD	-1,-2,-3,-4,-5,-6,-7,-8
			word	0x0123
			WORD	0x4567
			
			ASSERT	.-sizechk == (18*2)

;	{ "DWORD",		DIR_DEF_32		},
sizechk:		=		.

			.dword	'A','B',1,2,3,4,5,6
			.DWORD	-1,-2,-3,-4,-5,-6,-7,-8
			dword	0x01234567
			DWORD	0x89ABCDEF
			
			ASSERT	.-sizechk == (18*4)

;	{ "DW",			DIR_DEF_16		},
sizechk:		=	.

			.dw	'A','B',1,2,3,4,5,6
			.DW	-1,-2,-3,-4,-5,-6,-7,-8
			dw	0x0123
			DW	0x4567
			
			ASSERT	.-sizechk == (18*2)

;	{ "INT",		DIR_DEF_32		},
sizechk:		=		.

			.int	'A','B',1,2,3,4,5,6
			.INT	-1,-2,-3,-4,-5,-6,-7,-8
			int	0x01234567
			INT	0x89ABCDEF
			
			ASSERT	.-sizechk == (18*4)

;	{ "DD",			DIR_DEF_32		},
sizechk:		=	.

			.dd	'A','B',1,2,3,4,5,6
			.DD	-1,-2,-3,-4,-5,-6,-7,-8
			dd	0x01234567
			DD	0x89ABCDEF
			
			ASSERT	.-sizechk == (18*4)

;	{ "LONG",		DIR_DEF_64		},
sizechk:		=	.

			.long	'A','B',1,2,3,4,5,6
			.LONG	-1,-2,-3,-4,-5,-6,-7,-8
			long	0x0123456789ABCDEF
			LONG	0xFDECBA9876543210
			
			ASSERT	.-sizechk == (18*8)

;	{ "FLOAT",		DIR_DEF_FLOAT	},
sizechk:		=		.

			.float	1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7
			.FLOAT	-1.1,-2.2,-3.3,-4.4,-5.5,-6.6,-7.7,-8.8
			float	3.141535897
			FLOAT	-3.141535897

			ASSERT	.-sizechk == (18*4)

;	{ "DOUBLE",		DIR_DEF_DBL		},
sizechk:		=		.

			.double	1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7
			.DOUBLE	-1.1,-2.2,-3.3,-4.4,-5.5,-6.6,-7.7,-8.8
			double	3.141535897
			DOUBLE	-3.141535897

			ASSERT	.-sizechk == (18*8)

;	{ "ASCIIZ",		DIR_DEF_ASCIIZ	},
sizechk:		=		.

			.asciiz	"01234567", "", "\tBC\n"
			.ASCIIZ	"76543210", "", "\x01\x02\x03\x04"
			asciiz	"0123"
			ASCIIZ	"\"21\""
			
			ASSERT	.-sizechk == (40)
			
;	{ "DSZ",		DIR_DEF_ASCIIZ	},
sizechk:		=		.

			.dsz	"01234567", "", "\tBC\n"
			.DSZ	"76543210", "", "\x01\x02\x03\x04"
			dsz	"0123"
			DSZ	"\"21\""
			
			ASSERT	.-sizechk == (40)
			
;	{ "UTF16Z",		DIR_DEF_UTF16Z	},
; TODO (Need C++11 codecvt support)
;	{ "UTF16",		DIR_DEF_UTF16	},
; TODO (Need C++11 codecvt support)
;	{ "UTF32Z",		DIR_DEF_UTF32Z	},
; TODO (Need C++11 codecvt support)
;	{ "UTF32",		DIR_DEF_UTF32	},
; TODO (Need C++11 codecvt support)

;	{ "ASCII",		DIR_DEF_ASCII	},
sizechk:		=		.

			.ascii	"01234567", "", "\tBC\n"
			.ASCII	"76543210", "", "\x01\x02\x03\x04"
			ascii	"0123"
			ASCII	"\"21\""
			
			ASSERT	.-sizechk == (32)
			
;	{ "DS",			DIR_DEF_ASCII	},
sizechk:		=		.

			.ds		"01234567", "", "\tBC\n"
			.DS		"76543210", "", "\x01\x02\x03\x04"
			ds		"0123"
			DS		"\"21\""
			
			ASSERT	.-sizechk == (32)
			
;	{ "DEFFUNC",	DIR_DEFFN		},
; TODO (idea was to define function for expressions...may not be needed)
;	{ "DEFFN",		DIR_DEFFN		},
; TODO (idea was to define function for expressions...may not be needed)
;	{ "ENDFUNC",	DIR_ENDFN		},
; TODO (idea was to define function for expressions...may not be needed)
;	{ "ENDFN",		DIR_ENDFN		},
; TODO (idea was to define function for expressions...may not be needed)

;	{ "MACRO",		DIR_MACRO		},
; SEE macro_test.asm file
;	{ "ENDMACRO",	DIR_ENDMACRO	},
; SEE macro_test.asm file
;	{ "ENDM",		DIR_ENDMACRO	},
; SEE macro_test.asm file

;	{ "FUNC",		DIR_FUNC		},
; TODO (define function  begin/end for optimization etc.)
;	{ "PROC",		DIR_FUNC		},
; TODO (define function  begin/end for optimization etc.)
;	{ "ENDF",		DIR_ENDFUNC		},
; TODO (define function  begin/end for optimization etc.)
;	{ "ENDP",		DIR_ENDFUNC		},
; TODO (define function  begin/end for optimization etc.)

;	{ "VOID",		DIR_VOID		},

			.void	1o33,3.234..23..3,		; similar to a comment, ignores rest of line (useful in macros)
			.VOID	12.2,2,3,2,4,2111===
			void	0/0/0/0/0/0
			VOID	;;;;

;	{ "IF",			DIR_IF			},
;	{ "ELSE",		DIR_ELSE		},
;	{ "ENDIF",		DIR_ENDIF		},

			if	1==1
			MSG	"1 does equal 1"
			else
			ERROR	"1 does not equal 1"
			endif
			
			IF 	6==9
			ERROR	"skip me"
			.endif
			
			if 	6==6
			MSG	"don't skip"
			.ENDIF

;	{ "ELSEIF",		DIR_ELSEIF		},

condition:	=	1
			
			.IF	condition==1
			MSG	"cond 1"
			.elseif condition==2
			MSG		"cond 2"
			.ELSEIF condition==3
			MSG	"cond 3"
			.else
			MSG	"default cond"
			ENDIF
			
condition:	=	3
			
			.IF	condition==1
			MSG	"cond 1"
			.elseif	condition==2
			MSG		"cond 2"
			.ELSEIF	condition==3
			MSG	"cond 3"
			.else
			MSG	"default cond"
			ENDIF
			
condition:	=	7

			if	condition==1
			MSG	"cond 1"
			elseif	condition==2
			MSG	"cond 2"
			elseif	condition==3
			MSG	"cond 3"
			else
			MSG	"default cond"
			endif

;	{ "MSG",		DIR_MSG			},

			.msg	"So far size = ", .-begin	; WARNING expected
			.MSG	"This is a message during assembly. condition=",condition
			MSG	"This is a message during assembly. condition=",condition
			msg	"This is a message during assembly. condition=",condition

;	{ "PRINT",		DIR_MSG			},

			.print	"This is a message during assembly. condition=",condition
			.PRINT	"This is a message during assembly. condition=",condition
			print	"This is a message during assembly. condition=",condition
			PRINT	"This is a message during assembly. condition=",condition

;	{ "ASSERT",		DIR_ASSERT		},

;			.assert	6==9, "This should assert, 6==9 is ", 6==9		; ERROR expected
			.ASSERT	6==6, "This shoud not assert"
;			assert	(.&1), "output address even .=", .				; ERROR expected
			assert	!(.&1), "output address odd .=", .

;	{ "WARN",		DIR_WARN		},

			.warn	"Test warning. condition=",condition			; WARNING expected
			.WARN	"Test warning. condition=",condition			; WARNING expected
			warn	"Test warning. condition=",condition			; WARNING expected
			WARN	"Test warning. condition=",condition			; WARNING expected

;	{ "ERROR",		DIR_ERROR		},

;			.error	"Test error. condition=",condition				; ERROR expected
;			.ERROR	"Test error. condition=",condition				; ERROR expected
;			error	"Test error. condition=",condition				; ERROR expected
;			ERROR	"Test error. condition=",condition				; ERROR expected

;	{ "END",		DIR_END			},

			END				; ends current assembly file (this will cause the rest of this file to be ignored...)
			.END
			$END				; $END also accepted

;	{ "EXIT",		DIR_EXIT		},

			EXIT	"assembly exit forced, .=", .			; terminates assembly (producing no output)
