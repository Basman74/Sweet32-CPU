; LD optimized load test
; The LD will turn into the following paired op(s)
;

foobar:		EQU	"foobarino"

			.ifstr	"foo" == "bar"
			ERROR
			.endif

			.ifstr	foobar == "foobarino"
			VOID
			.endif
			
			.ifstr	"A" < "B"
			VOID
			.endif
			
			.ifstr	"A" > "B"
			ERROR
			.endif
			
			.ifstr	foobar contains "foo"
			VOID
			.endif

			.ifstri	"FooBar" contains "fOO"
			VOID
			.endif

			.ifstr	foobar contains "car"
			ERROR
			.endif

			.ifstri	foobar contains "Car"
			ERROR
			.endif

			
begin:
			LD		R10,#0x12
			LDB		R10,#0x12

			LD		R10,#0x1F0
			LDB		R10,#0xF8
			ADD		R10,R10,R10

			LD		R10,#0x101
			LDB		R10,#0xFF
			INCS	R10,R10,#2

			LD		R10,#0x1234
			LDW		R10,#0x1234

			LD		R10,#0x1200
			LDB		R10,#0x12
			SWAPB	R10,R10

			LD		R10,#0x12345678
			LDD		R10,#0x12345678

			LD		R10,#0x120000
			LDB		R10,#0x12
			SWAPW	R10,R10

			LD		R10,#-1
			LDB		R10,#0
			NOT		R10,R10

			LDB		R10,#bar-foo
			LD		R10,#bar-foo

			LD		R10,#foo-bar
			LDB		R10,#~(foo-bar)
			NOT		R10,R10
			
			JMP		begin
			JMP		.+0x1000
			JMP		.+0x1000200
			
			BITSZ	R0,#1
			NOP
			
			BITSNZ	R0,#1
			JMP		.+0x200
			
			GETPC	R0,.+254
			GETPC	R0,.-256
			
			.bss

			.if		(bar-foo) == 1
			db		0x42
			.else
			db		0x10,0x10,0x10,0x10
			.endif
	
foo:		SPACE	1
bar:		SPACE	1

