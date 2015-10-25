; macro tests

; no macro arguments
.macro		noargs
			db	0x41
			db	0x42
			db	0x43
.endm
; one macro argument
.macro		onearg		a
			db	\a
			db	\a+1
			db	\a+2
.endm
; one macro argument with default value
.macro		oneargdef	a=1
			db	\a
			db	\a+1
			db	\a+2
.endm
.macro		twoargs		a=1, b=2
			db			\a,\b
.endm
.macro		twoargsdef	a=1,b=2
			db			\a,\b
.endm

; simple macro that invokes another macro
.macro		nested		a=1
			oneargdef	\a
.endm
; more complicated recursion test (invoking itself, but not infinitely)
.macro		recurse		a=1
			.if			(\a) != 0
			db			\a
			recurse		(\a)-1
			.else
			oneargdef	\a
			.endif
.endm
; recursion test using variable (more efficient)
.macro		recursev	a=1
var:		=			\a
			.if			(var) != 0
			db			var
var:		=			var-1
			recursev	var
var:		.undef
			.else
			oneargdef	var
			.endif
.endm

			noargs
			NOARGS
			nOaRgS

			onearg				; WARNING expected
			ONEARG		2
			oNeArG		3
			
			oneargdef
			ONEARGDEF	2
			oNeArGdEf	3
			
			twoargs		3,4
			twoargs		3, 4 
			twoargs		3 ,4 
			twoargs		3 , 4 
			twoargsdef	5,7
			twoargsdef	5, 7
			twoargsdef	5 ,7
			twoargsdef	5 , 7

			nested		3
			
			recurse		3

			recursev	3

