/*
Copyright (c) 2012-2014, Alexey Frunze
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

The views and conclusions contained in the software and documentation are those
of the authors and should not be interpreted as representing official policies,
either expressed or implied, of the FreeBSD Project.
*/

/*****************************************************************************/
/*                                                                           */
/*                                Smaller C                                  */
/*                                                                           */
/*       A simple and small single-pass C compiler ("small C" class).        */
/*                                                                           */
/*                 Tweaked for the 'Sweet32' minimal-RISC CPU                */
/*                         by Valentin Angelovski                            */
/*                   (work-in-progress date: 28/12/2014)                     */
/*****************************************************************************/

// TBD!!! compress/clean up

#ifdef CAN_COMPILE_32BIT
int Sweet32_executable = 0;
int WinChkStkLabel = 0;
#endif

#define MAX_GLOBALS_TABLE_LEN MAX_IDENT_TABLE_LEN

/*
  Globals table entry format:
    use char:       use: bit 0 = defined, bit 1 = used
    idlen char:     string length (<= 127)
    id char[idlen]: string (ASCIIZ)
*/
char GlobalsTable[MAX_GLOBALS_TABLE_LEN];
int GlobalsTableLen = 0;
unsigned int cond_label = 0;
unsigned int continue_label = 0;

STATIC
void GenAddGlobal(char* s, int use)
{
  int i = 0;
  int l;
  if (OutputFormat != FormatFlat && GenExterns)
  {
    while (i < GlobalsTableLen)
    {
      if (!strcmp(GlobalsTable + i + 2, s))
      {
        GlobalsTable[i] |= use;
        return;
      }
      i += GlobalsTable[i + 1] + 2;
    }
    l = strlen(s) + 1;
    if (GlobalsTableLen + l + 2 > MAX_GLOBALS_TABLE_LEN)
      error("Table of globals exhausted\n");
    GlobalsTable[GlobalsTableLen++] = use;
    GlobalsTable[GlobalsTableLen++] = l;
    memcpy(GlobalsTable + GlobalsTableLen, s, l);
    GlobalsTableLen += l;
  }
}

STATIC
void GenInit(void)
{
  // initialization of target-specific code generator
  SizeOfWord = 2;
  OutputFormat = FormatSegTurbo;
  UseLeadingUnderscores = 1;
}

STATIC
int GenInitParams(int argc, char** argv, int* idx)
{
  (void)argc;
  // initialization of target-specific code generator with parameters

  if (!strcmp(argv[*idx], "-seg16t"))
  {
    // this is the default option for x86
    OutputFormat = FormatSegTurbo; SizeOfWord = 2;
    return 1;
  }
  else if (!strcmp(argv[*idx], "-seg16"))
  {
    OutputFormat = FormatSegmented; SizeOfWord = 2;
    return 1;
  }
  else if (!strcmp(argv[*idx], "-flat16"))
  {
    OutputFormat = FormatFlat; SizeOfWord = 2;
    return 1;
  }
#ifdef CAN_COMPILE_32BIT
  else if (!strcmp(argv[*idx], "-seg32"))
  {
    OutputFormat = FormatSegmented; SizeOfWord = 4;
    return 1;
  }
  else if (!strcmp(argv[*idx], "-flat32"))
  {
    OutputFormat = FormatFlat; SizeOfWord = 4;
    return 1;
  }
  else if (!strcmp(argv[*idx], "-huge"))
  {
    OutputFormat = FormatSegHuge; SizeOfWord = 4;
    return 1;
  }
  else if (!strcmp(argv[*idx], "-sweet32app"))
  {
    Sweet32_executable = 1;
    return 1;
  }
#endif

  return 0;
}

STATIC
void GenInitFinalize(void)
{
  // finalization of initialization of target-specific code generator

  // Change the output assembly format/content according to the options
  if (OutputFormat == FormatSegTurbo)
  {
    FileHeader = "SEGMENT _TEXT PUBLIC CLASS=CODE USE16\n"
                 "SEGMENT _DATA PUBLIC CLASS=DATA\n";
    CodeHeader = "SEGMENT _TEXT";
    CodeFooter = "; SEGMENT _TEXT";
    DataHeader = "SEGMENT _DATA";
    DataFooter = "; SEGMENT _DATA";
  }
  else
  {
    if (OutputFormat == FormatSegmented || OutputFormat == FormatSegHuge)
    {
      CodeHeader = "section .text";
      DataHeader = "section .data";
    }
// Include Sweet32 program header here
//    GETPC\tR15,#0		; Startup code
//	LDD\tR14,#0x1000	; Setup Stack pointer
//	ADDSNC\tR14,R15,R14
//	OR\tR0,R0,R0
//	LDD\tR12,#0xFFFFFFFF
//	LDD\tR9,#0x80000000 

printf2("; *** Produced by Smaller-C modified for Sweet32 code generation"); puts2("");
puts2("");


	if (Sweet32_executable == 1) // Kernel-mode application
	{
		printf2("LDD R8,#0x3810"); puts2("");
		printf2("MOVD @R8,R13"); puts2("");
		printf2("LDD R8,#0x3814"); puts2("");
		printf2("MOVD @R8,R14"); puts2("");
		printf2("\tmov\tR4,R0"); printf2(" ; Load user app program base "); puts2("");
		printf2("\tmov\tR7,R15"); printf2(" ; Load kernel return address "); puts2("");
		printf2("\tmov\tR6,R14"); puts2("");
		printf2("\tmov\tR5,R13"); puts2("");	
		printf2("\tLDD\tR14,$Sweet32_stacktop"); printf2(" ; Auto Stack pointer setup"); puts2("");
		printf2("\tADD\tR14,R14,R4"); puts2("");
		printf2("\tMOV\tR13,R14"); puts2("");
		printf2("\tLDD\tR8,#back2kernel"); puts2("");
		printf2("\tADD\tR8,R8,R4"); puts2("");
		printf2("\tMOVD\t@R14,R8"); puts2("");
		printf2("\tLDD\tR9,#0xFFFFFF00"); puts2("");
		printf2("\tMJMP\t_main"); puts2("");
		printf2("back2kernel:"); puts2("");
		printf2(" ldd R4,#0x10000000"); puts2("");
		printf2(" mov R13,R5"); puts2("");
		printf2(" mov R14,R6"); puts2("");
		printf2(" ljmp R7"); puts2("");
	}
	else
	{
		printf2("\tGETPC\tR4,#0"); printf2(" ; Get codebase address "); puts2("");
		printf2("\tADD\tR0,R0,R0"); printf2(" ; Reserved for 32bit Trace/Debug handler vector"); puts2("");
		printf2("\tADD\tR0,R0,R0"); puts2("");
		//printf2("\tLDD\tR14,#0x4000"); printf2(" ; Setup Stack pointer (Set @ top of Boot RAM area by default)"); puts2("");
		//printf2("\tLDD\tR14,#0x100000"); printf2(" ; Setup Stack pointer (Set @ top of DRAM area by default)"); puts2("");

		printf2("\tLDD\tR14,$Sweet32_stacktop"); printf2(" ; Auto Stack pointer setup"); puts2("");
		printf2("\tADD\tR14,R14,R4"); puts2("");
		printf2("\tMOV\tR13,R14"); puts2("");

		printf2("\tincs\tR14,R14,#-4"); puts2("");
		printf2("\tmovd\t@R14,R15"); puts2("");
		printf2("\tMOV\tR13,R14"); puts2("");

		printf2("\tLDD\tR9,#0xFFFFFF00"); puts2("");
		printf2("\tMJMP\t_main"); puts2("");
	}
	/*
	else // [benis]
	{
		printf2("\tGETPC\tR0,#0"); printf2(" ; Get codebase address "); puts2("");
		printf2("\tLDD\tR1,$Sweet32_stacktop"); printf2(" ; Auto Stack pointer setup"); puts2("");	
		printf2("\tADD\tR1,R1,R0"); puts2("");	

		printf2("\tincs\tR1,R1,#-4;"); puts2("");
		printf2("\tmovd\t@R1,R4"); printf2(" ; Push kernel R4 "); puts2("");
		printf2("\tincs\tR1,R1,#-4;"); puts2("");
		printf2("\tmovd\t@R0,R13"); printf2(" ; Push kernel R13 "); puts2("");
		printf2("\tincs\tR1,R1,#-4;"); puts2("");
		printf2("\tmovd\t@R1,R14"); printf2(" ; Push kernel R14 "); puts2("");
		printf2("\tMOV\tR14,R1"); puts2("");
		printf2("\tMOV\tR13,R1"); puts2("");
		printf2("\tMOV\tR4,R0"); puts2("");	
		printf2("\tLDD\tR9,#0xFFFFFF00"); puts2("");
		printf2("\tMJMP\t_main"); puts2("");	
	}	*/


//;*** Sweet32 unsigned 16/16 division routine ***
//; R0(Dividend)/R2(Divisor) = R0(Quotient):R3(Remainder)

//; R3 = Dividend reg
//; R2 = Divisor reg
//; R0 = Quotient reg
//; R3 = Remainder reg
//; R10 = # of bits to divide by +1
//; R11 = quotient bitwise-OR mask value
//; R12 = Temp reg
//; R15 = Function return address

printf2("; ************* UDIV16 routine **************"); puts2("");
printf2("Divide_U1616:"); puts2("");
printf2("\tLDD\tR11,#0x00010000"); puts2("");
printf2("\tLDB\tR10,#17"); puts2("");
printf2("\tMOV\tR3,R0"); puts2("");
printf2("\tLDB\tR0,#0x0"); puts2("");
printf2("\tSWAPW\tR2,R2"); puts2("");	
printf2("Division_loop:"); puts2("");
printf2("\tSUBSLT\tR12,R3,R2"); puts2("");
printf2("\tSJMP\tdoes_go"); puts2("");
printf2("\tLSR\tR2,R2"); puts2("");
printf2("\tLSR\tR11,R11"); puts2("");
printf2("\tINCS\tR10,R10,#-1"); puts2("");
printf2("\tTSTSNZ\tR10,R10"); puts2("");
printf2("\tSJMP\tDivision_done"); puts2("");
printf2("\tSJMP\tDivision_loop"); puts2("");

printf2("does_go:"); puts2("");
printf2("\tMOV\tR3,R12"); puts2("");
printf2("\tADD\tR0,R0,R11"); puts2("");
printf2("\tLSR\tR2,R2"); puts2("");
printf2("\tLSR\tR11,R11"); puts2("");
printf2("\tINCS\tR10,R10,#-1"); puts2("");
printf2("\tTSTSZ\tR10,R10"); puts2("");
printf2("\tSJMP\tDivision_loop"); puts2("");

printf2("Division_done:"); puts2("");
printf2("\tLJMP\tR15"); puts2("");
printf2("; ************* End UDIV16 routine **************"); puts2("");
	




  }
}

STATIC
void GenStartCommentLine(void)
{
  printf2("; ");
}

STATIC
void GenWordAlignment(void)
{
  printf2("\talign\t2\n");	// **** Sweet32 has a fixed 16-bit alignment requirement!
}

STATIC
void GenLabel(char* Label, int Static)
{
  if (UseLeadingUnderscores)
  {
    if (OutputFormat != FormatFlat && !Static && GenExterns)
      printf2("\tglobal\t_%s\n", Label);
	printf2("\talign\t2\n");
    printf2("_%s:\n", Label);
  }
  else
  {
    if (OutputFormat != FormatFlat && !Static && GenExterns)
      printf2("\tglobal\t$%s\n", Label);
	printf2("\talign\t2\n");  
    printf2("$%s:\n", Label);
  }
  GenAddGlobal(Label, 1);
}

STATIC
void GenPrintLabel(char* Label)
{
  if (UseLeadingUnderscores)
  {
    if (isdigit(*Label))
      printf2("L%s", Label);
    else
      printf2("_%s", Label);
  }
  else
  {
    if (isdigit(*Label))
      printf2("..@L%s", Label);
    else
      printf2("$%s", Label);
  }
}

STATIC
void GenNumLabel(int Label)
{
  if (UseLeadingUnderscores)
  {
    printf2("\talign\t2\n");
    printf2("L%d:\n", Label);
  }
  else
  {
    printf2("\talign\t2\n");
    printf2("..@L%d:\n", Label);
   }
}

STATIC
void GenPrintNumLabel(int label)
{
  if (UseLeadingUnderscores)
    printf2("L%d", label);
  else
    printf2("..@L%d", label);
}

STATIC
void GenZeroData(unsigned Size)
{
	//GenWordAlignment();
  	printf2("\tdzerob\t%u \n", truncUint(Size));
	GenWordAlignment();	
}

STATIC
void GenIntData(int Size, int Val)
{
  Val = truncInt(Val);
  if (Size == 1)
  {
	printf2("\tdb\t%d\n", Val);

  }
  else if (Size == 2)
  {
  printf2("\talign\t2\n");
    printf2("\tdw\t%d\n", Val);
  }
#ifdef CAN_COMPILE_32BIT
  else if (Size == 4)
  {
    printf2("\talign\t2\n");
    printf2("\tdd\t%d\n", Val);
  }
#endif
}

STATIC
void GenStartAsciiString(void)
{
  printf2("\tds\t");
}

STATIC
void GenAddrData(int Size, char* Label, int ofs)
{
  ofs = truncInt(ofs);
#ifdef CAN_COMPILE_32BIT
  if (OutputFormat == FormatSegHuge)
  {
    int lab = LabelCnt++;
    printf2("section .relod\n\tdd\t"); GenPrintNumLabel(lab); puts2("");
    puts2(DataHeader);
    GenNumLabel(lab);
  }
#endif
  if (Size == 1)
    printf2("\tdb\t");
  else if (Size == 2)
    printf2("\tdw\t");
#ifdef CAN_COMPILE_32BIT
  else if (Size == 4)
    printf2("\tdd\t$");
#endif
  GenPrintLabel(Label);
  if (ofs)
    printf2(" %+d", ofs);
  puts2("");
  if (!isdigit(*Label))
    GenAddGlobal(Label, 2);
}

#define X86InstrMov    0x00
#define X86InstrMovSx  0x01
#define X86InstrMovZx  0x02
#define X86InstrXchg   0x03
#define X86InstrLea    0x04
#define X86InstrPush   0x05
#define X86InstrPop    0x06
#define X86InstrInc    0x07
#define X86InstrDec    0x08
#define X86InstrAdd    0x09
#define X86InstrSub    0x0A
#define X86InstrAnd    0x0B
#define X86InstrXor    0x0C
#define X86InstrOr     0x0D
#define X86InstrCmp    0x0E
#define X86InstrTest   0x0F
#define X86InstrMul    0x10
#define X86InstrImul   0x11
#define X86InstrIdiv   0x12
#define X86InstrDiv    0x13
#define X86InstrShl    0x14
#define X86InstrSar    0x15
#define X86InstrShr    0x16
#define X86InstrNeg    0x17
#define X86InstrNot    0x18
#define X86InstrCbw    0x19
#define X86InstrCwd    0x1A
#define X86InstrCdq    0x1B
#define X86InstrSetCc  0x1C
#define X86InstrJcc    0x1D
#define X86InstrJNotCc 0x1E
#define X86InstrLeave  0x1F
#define X86InstrCall   0x20
#define X86InstrRet    0x21
#define X86InstrJmp    0x22
#define X86InstrMJmp   0x23

char* winstrs[] =
{
  "mov",
  "movsx",
  "movzx",
  "xchg",
  "lea",
  "push",
  "pop",
  "inc",
  "dec",
  "add",
  "sub",
  "and",
  "xor",
  "or",
  "cmp",
  "test",
  "umul",
  "imul",
  "idiv",
  "div",
  "shl",
  "sar",
  "shr",
  "neg",
  "not",
  "cbw",
  "cwd",
  "cdq",
  0, // setcc
  0, // jcc
  0, // j!cc
  0, // leave
  "call",
  0, // ret
  "sjmp",
  "mjmp",  
};

STATIC
void GenPrintInstr(int instr, int val)
{
   char* p = "";

  switch (instr)
  {
  case X86InstrLeave: p = (OutputFormat != FormatSegHuge) ? "leave" : "db\t0x66\n\tleave"; break;

  case X86InstrRet: p = (OutputFormat != FormatSegHuge) ? "ret" : "retf"; break;

  case X86InstrJcc:
    switch (val)
    {
    case '<':         p = "jl"; break;
    case tokULess:    p = "jb"; break;
    case '>':         p = "jg"; break;
    case tokUGreater: p = "ja"; break;
    case tokLEQ:      p = "jle"; break;
    case tokULEQ:     p = "jbe"; break;
    case tokGEQ:      p = "jge"; break;
    case tokUGEQ:     p = "jae"; break;
    case tokEQ:       p = "je"; break;
    case tokNEQ:      p = "jne"; break;
    }
    break;
  case X86InstrJNotCc:
    switch (val)
    {
    case '<':         p = "jge"; break;
    case tokULess:    p = "jae"; break;
    case '>':         p = "jle"; break;
    case tokUGreater: p = "jbe"; break;
    case tokLEQ:      p = "jg"; break;
    case tokULEQ:     p = "ja"; break;
    case tokGEQ:      p = "jl"; break;
    case tokUGEQ:     p = "jb"; break;
    case tokEQ:       p = "jne"; break;
    case tokNEQ:      p = "je"; break;
    }
    break;

  case X86InstrSetCc:
    switch (val)
    {
    case '<':         p = "setl"; break;
    case tokULess:    p = "setb"; break;
    case '>':         p = "setg"; break;
    case tokUGreater: p = "seta"; break;
    case tokLEQ:      p = "setle"; break;
    case tokULEQ:     p = "setbe"; break;
    case tokGEQ:      p = "setge"; break;
    case tokUGEQ:     p = "setae"; break;
    case tokEQ:       p = "sete"; break;
    case tokNEQ:      p = "setne"; break;
    }
    break;

  default:
    p = winstrs[instr];
    break;
  }

  switch (instr)
  {
  case X86InstrCbw:
  case X86InstrCwd:
#ifdef CAN_COMPILE_32BIT
  case X86InstrCdq:
#endif
  case X86InstrLeave:
  case X86InstrRet:
    printf2("\t%s", p);
    break;
  default:
    printf2("\t%s\t", p);
    break;
  }
}

#define X86OpRegAByte                   0x00
#define X86OpRegAByteHigh               0x01
#define X86OpRegCByte                   0x02
#define X86OpRegAWord                   0x03
#define X86OpRegBWord                   0x04
#define X86OpRegCWord                   0x05
#define X86OpRegDWord                   0x06
#define X86OpRegAHalfWord               0x07
#define X86OpRegCHalfWord               0x08
#define X86OpRegBpWord                  0x09
#define X86OpRegSpWord                  0x0A
#define X86OpRegAByteOrWord             0x0B
#define X86OpRegCByteOrWord             0x0C
#define X86OpConst                      0x0D
#define X86OpLabel                      0x0E
#define X86OpNumLabel                   0x0F
#define X86OpIndLabel                   0x10
#define X86OpIndLabelExplicitByte       0x11
#define X86OpIndLabelExplicitWord       0x12
#define X86OpIndLabelExplicitHalfWord   0x13
#define X86OpIndLabelExplicitByteOrWord 0x14
#define X86OpIndLocal                   0x15
#define X86OpIndLocalExplicitByte       0x16
#define X86OpIndLocalExplicitWord       0x17
#define X86OpIndLocalExplicitHalfWord   0x18
#define X86OpIndLocalExplicitByteOrWord 0x19
#define X86OpIndRegB                    0x1A
#define X86OpIndRegBExplicitByte        0x1B
#define X86OpIndRegBExplicitWord        0x1C
#define X86OpIndRegBExplicitHalfWord    0x1D
#define X86OpIndRegBExplicitByteOrWord  0x1E

STATIC
int GenSelectByteOrWord(int op, int opSz)
{
  switch (op)
  {
  case X86OpRegAByteOrWord:
    op = X86OpRegAByte;
    if (opSz == SizeOfWord)
      op = X86OpRegAWord;
#ifdef CAN_COMPILE_32BIT
    else if (opSz == 2 || opSz == -2)
      op = X86OpRegAHalfWord;
#endif
    break;
  case X86OpRegCByteOrWord:
    op = X86OpRegCByte;
    if (opSz == SizeOfWord)
      op = X86OpRegCWord;
#ifdef CAN_COMPILE_32BIT
    else if (opSz == 2 || opSz == -2)
      op = X86OpRegCHalfWord;
#endif
    break;
  case X86OpIndLabelExplicitByteOrWord:
    op = X86OpIndLabelExplicitByte;
    if (opSz == SizeOfWord)
      op = X86OpIndLabelExplicitWord;
#ifdef CAN_COMPILE_32BIT
    else if (opSz == 2 || opSz == -2)
      op = X86OpIndLabelExplicitHalfWord;
#endif
    break;
  case X86OpIndLocalExplicitByteOrWord:
    op = X86OpIndLocalExplicitByte;
    if (opSz == SizeOfWord)
      op = X86OpIndLocalExplicitWord;
#ifdef CAN_COMPILE_32BIT
    else if (opSz == 2 || opSz == -2)
      op = X86OpIndLocalExplicitHalfWord;
#endif
    break;
  case X86OpIndRegBExplicitByteOrWord:
    op = X86OpIndRegBExplicitByte;
    if (opSz == SizeOfWord)
      op = X86OpIndRegBExplicitWord;
#ifdef CAN_COMPILE_32BIT
    else if (opSz == 2 || opSz == -2)
      op = X86OpIndRegBExplicitHalfWord;
#endif
    break;
  }
  return op;
}

STATIC
void GenPrintOperand(int op, int val)
{
  if (SizeOfWord == 2)
  {
    switch (op)
    {
    case X86OpRegAByte: printf2("al"); break;
    case X86OpRegAByteHigh: printf2("ah"); break;
    case X86OpRegCByte: printf2("cl"); break;
    case X86OpRegAWord: printf2("ax"); break;
    case X86OpRegBWord: printf2("bx"); break;
    case X86OpRegCWord: printf2("cx"); break;
    case X86OpRegDWord: printf2("dx"); break;
    case X86OpRegBpWord: printf2("bp"); break;
    case X86OpRegSpWord: printf2("sp"); break;
    case X86OpConst: printf2("%d", truncInt(val)); break;
    case X86OpLabel: GenPrintLabel(IdentTable + val); break;
    case X86OpNumLabel: GenPrintNumLabel(val); break;
    case X86OpIndLabel: printf2("["); GenPrintLabel(IdentTable + val); printf2("]"); break;
    case X86OpIndLabelExplicitByte: printf2("byte ["); GenPrintLabel(IdentTable + val); printf2("]"); break;
    case X86OpIndLabelExplicitWord: printf2("word ["); GenPrintLabel(IdentTable + val); printf2("]"); break;
    case X86OpIndLocal: printf2("[bp%+d]", truncInt(val)); break;
    case X86OpIndLocalExplicitByte: printf2("byte [bp%+d]", truncInt(val)); break;
    case X86OpIndLocalExplicitWord: printf2("word [bp%+d]", truncInt(val)); break;
    case X86OpIndRegB: printf2("[bx]"); break;
    case X86OpIndRegBExplicitByte: printf2("byte [bx]"); break;
    case X86OpIndRegBExplicitWord: printf2("word [bx]"); break;
    }
  }
#ifdef CAN_COMPILE_32BIT
  else
  {
    char* frame = (OutputFormat == FormatSegHuge) ? "bp" : "R13";
    char* base = (OutputFormat == FormatSegHuge) ? "si" : "ebx";
    switch (op)
    {
    case X86OpRegAByte: printf2("al"); break;
    case X86OpRegAByteHigh: printf2("ah"); break;
    case X86OpRegCByte: printf2("cl"); break;
    case X86OpRegAWord: printf2("R0"); break;
    case X86OpRegBWord: printf2("R1"); break;
    case X86OpRegCWord: printf2("R2"); break;
    case X86OpRegDWord: printf2("R3"); break;
    case X86OpRegAHalfWord: printf2("ax"); break;
    case X86OpRegCHalfWord: printf2("cx"); break;
    case X86OpRegBpWord: printf2("R13"); break;
    case X86OpRegSpWord: printf2("R14"); break;
    case X86OpConst: printf2("%d", truncInt(val)); break;
    case X86OpLabel: GenPrintLabel(IdentTable + val); break;
    case X86OpNumLabel: GenPrintNumLabel(val); break;
    case X86OpIndLabel: GenPrintLabel(IdentTable + val); break;
    case X86OpIndLabelExplicitByte: printf2("byte ["); GenPrintLabel(IdentTable + val); printf2("]"); break;
    case X86OpIndLabelExplicitWord: printf2("dword ["); GenPrintLabel(IdentTable + val); printf2("]"); break;
    case X86OpIndLabelExplicitHalfWord: printf2("word ["); GenPrintLabel(IdentTable + val); printf2("]"); break;
    case X86OpIndLocal: printf2("%d", truncInt(val)); break;
    case X86OpIndLocalExplicitByte: printf2("byte [%s%+d]", frame, truncInt(val)); break;
    case X86OpIndLocalExplicitWord: printf2("dword [%s%+d]", frame, truncInt(val)); break;
    case X86OpIndLocalExplicitHalfWord: printf2("word [%s%+d]", frame, truncInt(val)); break;
    case X86OpIndRegB: printf2("[%s]", base); break;
    case X86OpIndRegBExplicitByte: printf2("byte [%s]", base); break;
    case X86OpIndRegBExplicitWord: printf2("dword [%s]", base); break;
    case X86OpIndRegBExplicitHalfWord: printf2("word [%s]", base); break;
    }
  }
#endif
}

STATIC
void GenPrintOperandSeparator(void)
{
  printf2(", ");
}

STATIC
void GenPrintNewLine(void)
{
  puts2("");
}

STATIC
void GenPrintInstrNoOperand(int instr)
{
  GenPrintInstr(instr, 0);
  GenPrintNewLine();
}

#ifdef CAN_COMPILE_32BIT
STATIC
void GenRegB2Seg(void)
{
  if (OutputFormat == FormatSegHuge)
    puts2("\tmov\tesi, ebx\n\tror\tesi, 4\n\tmov\tds, si\n\tshr\tesi, 28");
}
#endif

STATIC
void GenPrintInstr1Operand(int instr, int instrval, int operand, int operandval)
{
#ifdef CAN_COMPILE_32BIT
  if (OutputFormat == FormatSegHuge && instr == X86InstrPush)
  {
    if (operand == X86OpConst)
    {
      printf2("\tpush\tdword %d\n", truncInt(operandval));
      return;
    }
    else if (operand == X86OpLabel)
    {
      int lab = LabelCnt++;
      printf2("section .relod\n\tdd\t"); GenPrintNumLabel(lab); puts2("");
      puts2(CodeHeader);
      puts2("\tdb\t0x66, 0x68"); // push dword const
      GenNumLabel(lab);
      printf2("\tdd\t"); GenPrintLabel(IdentTable + operandval); puts2("");
      return;
    }
  }
#endif

  GenPrintInstr(instr, instrval);
  GenPrintOperand(operand, operandval);
  GenPrintNewLine();
}

STATIC
void GenPrintInstr2Operands(int instr, int instrval, int operand1, int operand1val, int operand2, int operand2val)
{
  if (operand2 == X86OpConst && truncUint(operand2val) == 0 &&
      (instr == X86InstrAdd || instr == X86InstrSub))
    return;

#ifdef CAN_COMPILE_32BIT
  if (OutputFormat == FormatSegHuge)
  {
    if (instr == X86InstrLea)
    {
      if (operand2 == X86OpIndLocal)
      {
        if (operand1 == X86OpRegAWord)
        {
          puts2("\txor\teax, eax\n\tmov\tax, ss"); // mov r32, sreg leaves top 16 bits undefined on pre-Pentium CPUs
          printf2("\tshl\teax, 4\n\tlea\teax, [ebp+eax%+d]\n", truncInt(operand2val));
          return;
        }
        else if (operand1 == X86OpRegCWord)
        {
          puts2("\txor\tecx, ecx\n\tmov\tcx, ss"); // mov r32, sreg leaves top 16 bits undefined on pre-Pentium CPUs
          printf2("\tshl\tecx, 4\n\tlea\tecx, [ebp+ecx%+d]\n", truncInt(operand2val));
          return;
        }
      }
      errorInternal(106);
    }
    if (instr == X86InstrMov)
    {
      if (operand1 == X86OpRegAWord && operand2 == X86OpLabel)
      {
        int lab = LabelCnt++;
        printf2("section .relod\n\tdd\t"); GenPrintNumLabel(lab); puts2("");
        puts2(CodeHeader);
        puts2("\tdb\t0x66, 0xB8"); // mov eax, const
        GenNumLabel(lab);
        printf2("\tdd\t"); GenPrintLabel(IdentTable + operand2val); puts2("");
        return;
      }
    }
  }
#endif

  if (operand2 == X86OpConst &&
      (operand2val == 1 || operand2val == -1) &&
      (instr == X86InstrAdd || instr == X86InstrSub))
  {
    if ((operand2val == 1 && instr == X86InstrAdd) ||
        (operand2val == -1 && instr == X86InstrSub))
      GenPrintInstr(X86InstrInc, 0);
    else
      GenPrintInstr(X86InstrDec, 0);
    GenPrintOperand(operand1, operand1val);
    GenPrintNewLine();
    return;
  }

  GenPrintInstr(instr, instrval);
  GenPrintOperand(operand1, operand1val);
  GenPrintOperandSeparator();
  GenPrintOperand(operand2, operand2val);
  GenPrintNewLine();
}

STATIC
void GenPrintInstr3Operands(int instr, int instrval,
                            int operand1, int operand1val,
                            int operand2, int operand2val,
                            int operand3, int operand3val)
{
  GenPrintInstr(instr, instrval);
  GenPrintOperand(operand1, operand1val);
  GenPrintOperandSeparator();
  GenPrintOperand(operand2, operand2val);
  GenPrintOperandSeparator();
  GenPrintOperand(operand3, operand3val);
  GenPrintNewLine();
}

STATIC
void GenExtendRegAIfNeeded(int opSz)
{
  if (SizeOfWord == 2)
  {
    if (opSz == -1)
      GenPrintInstrNoOperand(X86InstrCbw);
    else if (opSz == 1)
      GenPrintInstr2Operands(X86InstrMov, 0,
                             X86OpRegAByteHigh, 0,
                             X86OpConst, 0);
  }
#ifdef CAN_COMPILE_32BIT
  else
  {
    if (opSz == -1)
      GenPrintInstr2Operands(X86InstrMovSx, 0,
                             X86OpRegAWord, 0,
                             X86OpRegAByte, 0);
    else if (opSz == 1)
      GenPrintInstr2Operands(X86InstrMovZx, 0,
                             X86OpRegAWord, 0,
                             X86OpRegAByte, 0);
    else if (opSz == -2)
      GenPrintInstr2Operands(X86InstrMovSx, 0,
                             X86OpRegAWord, 0,
                             X86OpRegAHalfWord, 0);
    else if (opSz == 2)
      GenPrintInstr2Operands(X86InstrMovZx, 0,
                             X86OpRegAWord, 0,
                             X86OpRegAHalfWord, 0);
  }
#endif
}

STATIC
void GenJumpUncond(int label)
{
  GenPrintInstr1Operand(X86InstrJmp, 0,
                        X86OpNumLabel, label);
}

void GenJumpUncond2(int label)
{
  GenPrintInstr1Operand(X86InstrMJmp, 0,
                        X86OpNumLabel, label);
}

#ifndef USE_SWITCH_TAB
STATIC
void GenJumpIfEqual(int val, int label)
{
if (val > 65536) 
{
	printf2("\tldd\tR10,#"); GenPrintOperand(X86OpConst, val);  printf2(" ; cmp ax,const"); puts2("");	
}
else if (val > 256) 
{
	printf2("\tldw\tR10,#"); GenPrintOperand(X86OpConst, val);  printf2(" ; cmp ax,const"); puts2("");	
}
else 
{
	printf2("\tldb\tR10,#"); GenPrintOperand(X86OpConst, val);  printf2(" ; cmp ax,const"); puts2("");	
}

	printf2("\txor\tR10,R10,R0");  puts2("");
	printf2("\ttstsnz\tR10,R10"); printf2(" ; je	label"); puts2("");		
	GenJumpUncond(label); 

 // GenPrintInstr2Operands(X86InstrCmp, 0,
 //                        X86OpRegAWord, 0,
  //                       X86OpConst, val);
 // GenPrintInstr1Operand(X86InstrJcc, tokNEQ,
 //                       X86OpNumLabel, label);
}
#endif

STATIC
void GenJumpIfZero(int label)
{
#ifndef NO_ANNOTATIONS
  GenStartCommentLine(); printf2("JumpIfZero\n");
#endif

	printf2("\ttstsnz\tR0,R0"); printf2(" ; test	ax,ax"); puts2("");
	GenJumpUncond(label);  
}

STATIC
void GenJumpIfNotZero(int label)
{
#ifndef NO_ANNOTATIONS
  GenStartCommentLine(); printf2("JumpIfNotZero\n");
#endif

	printf2("\ttstsnz\tR0,R0"); printf2(" ; jne	label"); puts2("");	
	printf2("\tsjmp\tLC%d",cond_label); puts2("");	
	GenJumpUncond(label);  					
	printf2("LC%d:",cond_label); cond_label=cond_label+1; puts2("");
}

STATIC
void GenFxnProlog(void)
{
	printf2("\talign\t2"); puts2("");
	printf2("\tincs\tR14,R14,#-4"); puts2("");
	printf2("\tmovd\t@R14,R13"); puts2("");
	printf2("\tMOV\tR13,R14"); puts2("");
}

STATIC
void GenLocalAlloc(int size)
{
/*
#ifdef CAN_COMPILE_32BIT
  if (SizeOfWord == 4 &&
      OutputFormat != FormatSegHuge &&
      WindowsStack &&
      size >= 4096)
  {
    // When targeting Windows, call equivalent of _chkstk() to
    // correctly grow the stack page by page by probing it
    char s[1 + 2 + (2 + CHAR_BIT * sizeof WinChkStkLabel) / 3];
    char *p = s + sizeof s;

    if (!WinChkStkLabel)
      WinChkStkLabel = LabelCnt++;

    GenPrintInstr2Operands(X86InstrMov, 0,
                           X86OpRegAWord, 0,
                           X86OpConst, size);
    *--p = '\0';
    p = lab2str(p, WinChkStkLabel);
    *--p = '_';
    *--p = '_';
    printf2("\tcall\t");
    GenPrintLabel(p);
    puts2("");
  }
#endif
*/
	printf2("\tldd\tR10,#"); GenPrintOperand(X86OpConst, size);  printf2(" ; sub	esp, const"); puts2("");		
	printf2("\tsubslt\tR14,R14,R10"); puts2("");
	printf2("\tand\tR0,R0,R0"); puts2("");
	
  //GenPrintInstr2Operands(X86InstrSub, 0,
   //                      X86OpRegSpWord, 0,
    //                     X86OpConst, size);
}

STATIC
void GenFxnEpilog(void)
{

		printf2("\tmov\tR14,R13"); puts2("");  // Original translated x86 (restores SP/BP)
		printf2("\tmovd\tR13,@R14"); puts2("");
		printf2("\tincs\tR14,R14,#4"); puts2("");
		
		printf2("\tmovd\tR10,@R14"); puts2("");
		printf2("\tincs\tR14,R14,#4"); puts2("");
		printf2("\tljmp\tR10"); puts2("");

}

#ifdef CAN_COMPILE_32BIT
/*
struct INTREGS
{
  unsigned short gs, fs, es, ds;
  unsigned edi, esi, ebp, esp, ebx, edx, ecx, eax;
  unsigned short ss, ip, cs, flags;
};
void __interrupt isr(struct INTREGS** ppRegs)
{
  // **ppRegs (input/output values of registers) can be modified to
  // handle software interrupts requested via the int instruction and
  // communicate data via registers

  // *ppRegs (directly related to the stack pointer) can be modified to
  // return to a different location & implement preemptive scheduling,
  // e.g. save *ppRegs of the interrupted task somewhere, update *ppRegs
  // with a value from another interrupted task.
}
*/
void GenIsrProlog(void)
{
  // The CPU has already done these:
  //   push flags
  //   push cs
  //   push ip

  puts2("\tpush\tss");
  puts2("\tpushad");
  puts2("\tpush\tds\n"
        "\tpush\tes\n"
        "\tpush\tfs\n"
        "\tpush\tgs");

  // The context has been saved

  puts2("\txor\teax, eax\n\tmov\tax, ss"); // mov r32, sreg leaves top 16 bits undefined on pre-Pentium CPUs
  puts2("\txor\tebx, ebx\n\tmov\tbx, sp"); // top 16 bits of esp can contain garbage as well
  puts2("\tshl\teax, 4\n\tadd\teax, ebx");
  puts2("\tpush\teax"); // pointer to the structure with register values
  puts2("\tsub\teax, 4\n\tpush\teax"); // pointer to the pointer to the structure with register values

  puts2("\tpush\teax"); // fake return address allowing to use the existing bp-relative addressing of locals and params

  puts2("\tpush\tebp\n"
        "\tmov\tebp, esp");
}

void GenIsrEpilog(void)
{
  puts2("\tdb\t0x66\n\tleave");

  puts2("\tpop\teax"); // fake return address

  puts2("\tpop\teax"); // pointer to the pointer to the structure with register values
  puts2("\tpop\tebx"); // pointer to the structure with register values
  puts2("\tror\tebx, 4\n\tmov\tds, bx\n\tshr\tebx, 28"); // ds:bx = pointer to the structure with register values
  puts2("\tmov\tax, [bx+4*10]\n\tmov\tbx, [bx+4*5]\n\tsub\tbx, 4*10"); // ax:bx = proper pointer (with original segment) to the struct...
  puts2("\tmov\tss, ax\n\tmov\tsp, bx"); // restore ss:sp that we had after push gs

  // The context is now going to be restored

  puts2("\tpop\tgs\n"
        "\tpop\tfs\n"
        "\tpop\tes\n"
        "\tpop\tds");
  puts2("\tpopad");
  puts2("\tpop\tss");

  puts2("\tiret");
}
#endif

STATIC
void GenReadIdent(int opSz, int label)
{
	printf2("\tldd\tR10,$"); GenPrintOperand(X86OpLabel, label); puts2("");
	printf2("\tadd\tR10,R10,R4"); puts2("");		
	
 	if (opSz == 4 || opSz == -4)
	{ 	
		printf2("\tmovd\tR0,@R10"); puts2("");	
	}
 	if (opSz == 2)
	{ 
		printf2("\tmovw\tR0,@R10"); puts2("");	
	}	
 	if (opSz == -2)
	{ 
		printf2("\tmovsw\tR0,@R10"); puts2("");	
	}		
 	if (opSz == 1)
	{ 
		printf2("\tmovb\tR0,@R10"); puts2("");	
	}		
 	if (opSz == -1)
	{ 
		printf2("\tmovb\tR0,@R10"); puts2("");
		printf2("\tbitsz\tR0,#7"); puts2("");
		printf2("\tadd\tR0,R0,R9"); printf2(" ; extend char sign bit if needed"); puts2("");	
	}
	
}

STATIC
void GenReadLocal(int opSz, int ofs)
{
	printf2("\tldd\tR10,#%d",ofs); printf2("; mov	eax, [ebp-ofs]"); puts2("");	// Ugly hack to make short ints work!	

	printf2("\tadd\tR10,R10,R13"); puts2("");
	
 	if (opSz == 4 || opSz == -4)
	{ 
		printf2("\tmovd\tR0,@R10"); puts2("");	
	}
 	if (opSz == 2 || opSz == -2)
	{ 
		if (opSz == -2)
		{
			printf2("\tmovsw\tR0,@R10"); puts2("");	
		}
		else
		{
			printf2("\tmovw\tR0,@R10"); puts2("");	
		}
	}
 	if (opSz == 1)
	{ 
		printf2("\tmovb\tR0,@R10"); puts2("");	
	}		
 	if (opSz == -1)
	{ 
		printf2("\tmovb\tR0,@R10"); puts2("");
		printf2("\tbitsz\tR0,#7"); puts2("");
		printf2("\tadd\tR0,R0,R9"); printf2(" ; extend char sign bit if needed"); puts2("");	
	}
}

STATIC
void GenReadIndirect(int opSz)
{

 	printf2("\tmov\tR1,R0"); printf2("; mov	ebx, eax"); puts2("");

#ifdef CAN_COMPILE_32BIT
  GenRegB2Seg();
#endif
 	if (opSz == 4 || opSz == -4)
	{ 
		printf2("\tmovd\tR0,@R1"); printf2("; mov	eax, [ebx]"); puts2("");
	}
 	if (opSz == 2 || opSz == -2)
	{ 
		printf2("\tmovw\tR0,@R1"); printf2("; mov	ax, [bx]"); puts2("");
	}	

 	if (opSz == -2)
	{ 
		printf2("\tmovsw\tR0,@R1"); printf2("; mov	ax, [bx]"); puts2("");
	}	
	
 	if (opSz == 1)
	{ 
		printf2("\tmovb\tR0,@R1"); puts2(""); printf2("; mov	al, [bx]"); puts2("");	
	}		
 	if (opSz == -1)
	{ 
		printf2("\tmovb\tR0,@R1"); puts2("");
		printf2("\tbitsz\tR0,#7"); puts2("");
		printf2("\tadd\tR0,R0,R9"); printf2(" ; extend char sign bit if needed"); puts2("");	
	}	

}

STATIC
void GenReadCRegIdent(int opSz, int label)
{


	printf2("\tldd\tR10,$"); GenPrintOperand(X86OpLabel, label); puts2("");
	printf2("\tadd\tR10,R10,R4"); puts2("");	
	

  if (opSz == -1)
	{
		printf2("\tmovb\tR2,@R10"); puts2("");
		printf2("\tbitsz\tR2,#7"); puts2("");
		printf2("\tadd\tR2,R2,R9"); printf2(" ; extend char sign bit if needed"); puts2("");		
	}
  else if (opSz == 1)
	{
		printf2("\tmovb\tR2,@R10"); puts2(""); printf2("; mov	al, [bx]"); puts2("");	
	}
#ifdef CAN_COMPILE_32BIT
  else if (opSz != SizeOfWord && -opSz != SizeOfWord)
  {
    if (opSz == -2)
	{
		printf2("\tmovsw\tR2,@R10"); puts2("");
	}
     // GenPrintInstr2Operands(X86InstrMovSx, 0,
     //                        X86OpRegCWord, 0,
     //                        X86OpIndLabelExplicitHalfWord, label);
    else if (opSz == 2)
	{
			printf2("\tmovw\tR2,@R10"); puts2("");
	}		
    //  GenPrintInstr2Operands(X86InstrMovZx, 0,
    //                         X86OpRegCWord, 0,
    //                         X86OpIndLabelExplicitHalfWord, label);
  }
#endif
  else
    GenPrintInstr2Operands(X86InstrMov, 0,
                           X86OpRegCWord, 0,
                           X86OpIndLabel, label);
}

STATIC
void GenReadCRegLocal(int opSz, int ofs)
{

		printf2("\tldd\tR11,#"); GenPrintOperand(X86OpIndLocal, ofs);  printf2(" ; inst ecx,[ebp-ofs]"); puts2("");			
		printf2("\tadd\tR11,R11,R13"); puts2("");

		if(opSz == 1)	{ 
			printf2("\tmovb\tR2,@R11"); puts2("");
		}
		else if(opSz == 2)	{
			printf2("\tmovw\tR2,@R11"); puts2("");
		}
		else if(opSz == -1)	{
			printf2("\tmovb\tR2,@R11"); puts2("");
			printf2("\tbitsz\tR2,#7"); puts2("");
			printf2("\tadd\tR2,R2,R9"); printf2(" ; extend char sign bit if needed"); puts2("");		
		}	
		else if(opSz == -2)	{
			printf2("\tmovsw\tR2,@R11"); puts2("");
		}
		else
		{
			printf2("\tmovd\tR2,@R11"); puts2("");			
		}
				
/*
  if (opSz == -1)
    GenPrintInstr2Operands(X86InstrMovSx, 0,
                           X86OpRegCWord, 0,
                           X86OpIndLocalExplicitByte, ofs);
  else if (opSz == 1)
    GenPrintInstr2Operands(X86InstrMovZx, 0,
                           X86OpRegCWord, 0,
                           X86OpIndLocalExplicitByte, ofs);
#ifdef CAN_COMPILE_32BIT
  else if (opSz != SizeOfWord && -opSz != SizeOfWord)
  {
    if (opSz == -2)
      GenPrintInstr2Operands(X86InstrMovSx, 0,
                             X86OpRegCWord, 0,
                             X86OpIndLocalExplicitHalfWord, ofs);
    else if (opSz == 2)
      GenPrintInstr2Operands(X86InstrMovZx, 0,
                             X86OpRegCWord, 0,
                             X86OpIndLocalExplicitHalfWord, ofs);
  }
#endif
  else
    GenPrintInstr2Operands(X86InstrMov, 0,
                           X86OpRegCWord, 0,
                           X86OpIndLocal, ofs);*/
}

STATIC
void GenReadCRegIndirect(int opSz)
{
  GenPrintInstr2Operands(X86InstrMov, 0,
                         X86OpRegBWord, 0,
                         X86OpRegAWord, 0);
#ifdef CAN_COMPILE_32BIT
  GenRegB2Seg();
#endif
  if (opSz == -1)

	{
		printf2("\tmovb\tR2,@R1"); puts2("");
		printf2("\tbitsz\tR2,#7"); puts2("");
		printf2("\tadd\tR2,R2,R9"); printf2(" ; extend char sign bit if needed"); puts2("");	
	}				   
						   
  else if (opSz == 1)
   // GenPrintInstr2Operands(X86InstrMovZx, 0,
   //                        X86OpRegCWord, 0,
   //                        X86OpIndRegBExplicitByte, 0);
   {
   printf2("\tmovb\tR2,@R1"); puts2("");
   }
#ifdef CAN_COMPILE_32BIT
  else if (opSz != SizeOfWord && -opSz != SizeOfWord)
  {
    if (opSz == -2)
		{
		   printf2("\tmovsw\tR2,@R1"); puts2("");
		 }
     // GenPrintInstr2Operands(X86InstrMovSx, 0,
     //                        X86OpRegCWord, 0,
     //                        X86OpIndRegBExplicitHalfWord, 0);
    else if (opSz == 2)
      //GenPrintInstr2Operands(X86InstrMovZx, 0,
      //                       X86OpRegCWord, 0,
       //                      X86OpIndRegBExplicitHalfWord, 0);
		{
		   printf2("\tmovw\tR2,@R1"); puts2("");
		 }
  }
#endif
  else
  {
	printf2("\tmovd\tR2,@R1"); puts2("");
  }
  //  GenPrintInstr2Operands(X86InstrMov, 0,
  //                         X86OpRegCWord, 0,
  //                         X86OpIndRegB, 0);
}

STATIC
void GenIncDecIdent(int opSz, int label, int tok)
{
  signed short temp=1;
  if (tok != tokInc)
    temp=-1;

			printf2("\tldd\tR11,$"); GenPrintOperand(X86OpIndLabel, label);  printf2(" ; push [memvar_32]"); puts2("");			
			printf2("\tadd\tR11,R11,R4"); puts2("");
			

			if (opSz == 4 || opSz == -4)
			{ 
				printf2("\tmovd\tR12,@R11"); puts2("");	
				printf2("\tincs\tR12,R12,#%d",temp); puts2("");
				printf2("\tmov\tR0,R12"); puts2("");
				printf2("\tmovd\t@R11,R12"); puts2("");	
			}
			if (opSz == 2 || opSz == -2)
			{ 
				printf2("\tmovw\tR12,@R11"); puts2("");	
				printf2("\tincs\tR12,R12,#%d",temp); puts2("");
				printf2("\tmov\tR0,R12"); puts2("");
				printf2("\tmovw\t@R11,R12"); puts2("");	
			}		
			if (opSz == 1 || opSz == -1)
			{ 
				printf2("\tmovb\tR12,@R11"); puts2("");	
				printf2("\tincs\tR12,R12,#%d",temp); puts2("");
				printf2("\tmov\tR0,R12"); puts2("");
				printf2("\tmovb\t@R11,R12"); puts2("");		
			}			
	
  //GenPrintInstr1Operand(X86InstrInc, 0,
  //                      GenSelectByteOrWord(X86OpIndLabelExplicitByteOrWord, opSz), label);
 // GenPrintInstr2Operands(X86InstrMov, 0,
 //                        GenSelectByteOrWord(X86OpRegAByteOrWord, opSz), 0,
 //                        X86OpIndLabel, label);
 // GenExtendRegAIfNeeded(opSz);
}

STATIC
void GenIncDecLocal(int opSz, int ofs, int tok)
{
  signed short temp=1;
  if (tok != tokInc)
    temp=-1;


	printf2("\tldd\tR10,#%d",ofs); printf2("; mov	eax, [ebp-ofs]"); puts2("");	// Ugly hack to make short ints work!	

	
	printf2("\tadd\tR10,R10,R13"); puts2("");
	
	
 	if (opSz == 4 || opSz == -4)
	{ 
		printf2("\tmovd\tR12,@R10"); puts2("");
		printf2("\tincs\tR12,R12,#%d",temp); puts2("");
		printf2("\tmov\tR0,R12"); puts2("");
		printf2("\tmovd\t@R10,R12"); puts2("");	
	}
 	if (opSz == 2 || opSz == -2)
	{ 
		printf2("\tmovw\tR12,@R10"); puts2("");
		printf2("\tincs\tR12,R12,#%d",temp); puts2("");
		printf2("\tmov\tR0,R12"); puts2("");
		printf2("\tmovw\t@R10,R12"); puts2("");	
	}		
	if (opSz == 1 || opSz == -1)
	{ 
		printf2("\tmovb\tR12,@R10"); puts2("");
		printf2("\tincs\tR12,R12,#%d",temp); puts2("");
		printf2("\tmov\tR0,R12"); puts2("");
		printf2("\tmovb\t@R10,R12"); puts2("");	
	}		

}

STATIC
void GenIncDecIndirect(int opSz, int tok)
{
  int instr = X86InstrInc;

  if (tok != tokInc)
    instr = X86InstrDec;

  GenPrintInstr2Operands(X86InstrMov, 0,
                         X86OpRegBWord, 0,
                         X86OpRegAWord, 0);
#ifdef CAN_COMPILE_32BIT
  GenRegB2Seg();
#endif
  GenPrintInstr1Operand(instr, 0,
                        GenSelectByteOrWord(X86OpIndRegBExplicitByteOrWord, opSz), 0);
  GenPrintInstr2Operands(X86InstrMov, 0,
                         GenSelectByteOrWord(X86OpRegAByteOrWord, opSz), 0,
                         X86OpIndRegB, 0);
  GenExtendRegAIfNeeded(opSz);
}

STATIC
void GenPostIncDecIdent(int opSz, int label, int tok)
{
  //int instr = X86InstrInc;

  //if (tok != tokPostInc)
  //  instr = X86InstrDec;
	
  signed short temp=1;
  if (tok != tokPostInc)
    temp=-1;
	
	printf2("\tldd\tR10,$"); GenPrintOperand(X86OpLabel, label); puts2("");
	printf2("\tadd\tR10,R10,R4"); puts2("");
	
	if (opSz == 4 || opSz == -4)
	{
		printf2("\tmovd\tR11,@R10"); puts2("");
		printf2("\tmov\tR0,R11"); puts2("");		
		printf2("\tincs\tR11,R11,#%d",temp); puts2("");
		printf2("\tmovd\t@R10,R11"); puts2("");		
	}
	if (opSz == 2)
	{
		printf2("\tmovw\tR11,@R10"); puts2("");
		printf2("\tmov\tR0,R11"); puts2("");
		printf2("\tincs\tR11,R11,#%d",temp); puts2("");
		printf2("\tmovw\t@R10,R11"); puts2("");		
	}		
	if (opSz == -2)
	{
		printf2("\tmovsw\tR11,@R10"); puts2("");
		printf2("\tmov\tR0,R11"); puts2("");
		printf2("\tincs\tR11,R11,#%d",temp); puts2("");
		printf2("\tmovw\t@R10,R11"); puts2("");		
	}	
	if (opSz == 1)
	{
		printf2("\tmovb\tR11,@R10"); puts2("");
		printf2("\tmov\tR0,R11"); puts2("");
		printf2("\tincs\tR11,R11,#%d",temp); puts2("");
		printf2("\tmovb\t@R10,R11"); puts2("");		
	}	
	if (opSz == -1)
	{
		printf2("\tmovb\tR11,@R10"); puts2("");
		printf2("\tbitsz\tR11,#7"); puts2("");
		printf2("\tadd\tR11,R11,R9"); printf2(" ; extend char sign bit if needed"); puts2("");		
		
		printf2("\tmov\tR0,R11"); puts2("");
		printf2("\tincs\tR11,R11,#%d",temp); puts2("");
		printf2("\tmovb\t@R10,R11"); puts2("");		
	}

}

STATIC
void GenPostIncDecLocal(int opSz, int ofs, int tok)
{
 // int instr = X86InstrInc;

 // if (tok != tokPostInc)
 //   instr = X86InstrDec;

 // int instr = X86InstrInc;
  signed short temp=1;
  if (tok != tokPostInc)
    temp=-1;
	

	printf2("\tldd\tR10,#%d",ofs); printf2("; mov	eax, [ebp-ofs]"); puts2("");	// Ugly hack to make short ints work!	

	
	printf2("\tadd\tR10,R10,R13"); puts2("");
		
	if (opSz == 4 || opSz == -4)
	{
		printf2("\tmovd\tR11,@R10"); puts2("");
		printf2("\tmov\tR0,R11"); puts2("");		
		printf2("\tincs\tR11,R11,#%d",temp); puts2("");
		printf2("\tmovd\t@R10,R11"); puts2("");		
	}

	if (opSz == 2)
	{
		printf2("\tmovw\tR11,@R10"); puts2("");
		printf2("\tmov\tR0,R11"); puts2("");
		printf2("\tincs\tR11,R11,#%d",temp); puts2("");
		printf2("\tmovw\t@R10,R11"); puts2("");		
	}		
	if (opSz == -2)
	{
		printf2("\tmovsw\tR11,@R10"); puts2("");
		printf2("\tmov\tR0,R11"); puts2("");
		printf2("\tincs\tR11,R11,#%d",temp); puts2("");
		printf2("\tmovw\t@R10,R11"); puts2("");		
	}	
	if (opSz == 1)
	{
		printf2("\tmovb\tR11,@R10"); puts2("");
		printf2("\tmov\tR0,R11"); puts2("");
		printf2("\tincs\tR11,R11,#%d",temp); puts2("");
		printf2("\tmovb\t@R10,R11"); puts2("");		
	}	
	if (opSz == -1)
	{
		printf2("\tmovb\tR11,@R10"); puts2("");
		printf2("\tbitsz\tR11,#7"); puts2("");
		printf2("\tadd\tR11,R11,R9"); printf2(" ; extend char sign bit if needed"); puts2("");	
		
		printf2("\tmov\tR0,R11"); puts2("");
		printf2("\tincs\tR11,R11,#%d",temp); puts2("");
		printf2("\tmovb\t@R10,R11"); puts2("");		
	}
	
	
	
	
 // GenPrintInstr2Operands(X86InstrMov, 0,
  //                       GenSelectByteOrWord(X86OpRegAByteOrWord, opSz), 0,
  //                       X86OpIndLocal, ofs);
 // GenExtendRegAIfNeeded(opSz);
 // GenPrintInstr1Operand(instr, 0,
 //                       GenSelectByteOrWord(X86OpIndLocalExplicitByteOrWord, opSz), ofs);
}

STATIC
void GenPostIncDecIndirect(int opSz, int tok)
{
  signed short temp=1;
  if (tok != tokPostInc) temp=-1;
	
	
  GenPrintInstr2Operands(X86InstrMov, 0,
                         X86OpRegBWord, 0,
                         X86OpRegAWord, 0);
						 

	if (opSz == 4 || opSz == -4)
	{
		printf2("\tmovd\tR11,@R1"); puts2("");
		printf2("\tmov\tR0,R11"); puts2("");		
		printf2("\tincs\tR11,R11,#%d",temp); puts2("");
		printf2("\tmovd\t@R1,R11"); puts2("");		
	}

	if (opSz == 2)
	{
		printf2("\tmovw\tR11,@R1"); puts2("");
		printf2("\tmov\tR0,R11"); puts2("");
		printf2("\tincs\tR11,R11,#%d",temp); puts2("");
		printf2("\tmovw\t@R1,R11"); puts2("");		
	}		
	if (opSz == -2)
	{
		printf2("\tmovsw\tR11,@R1"); puts2("");
		printf2("\tmov\tR0,R11"); puts2("");
		printf2("\tincs\tR11,R11,#%d",temp); puts2("");
		printf2("\tmovw\t@R1,R11"); puts2("");		
	}	
	if (opSz == 1)
	{
		printf2("\tmovb\tR11,@R1"); puts2("");
		printf2("\tmov\tR0,R11"); puts2("");
		printf2("\tincs\tR11,R11,#%d",temp); puts2("");
		printf2("\tmovb\t@R1,R11"); puts2("");		
	}	
	if (opSz == -1)
	{
		printf2("\tmovb\tR11,@R1"); puts2("");
		printf2("\tbitsz\tR11,#7"); puts2("");
		printf2("\tadd\tR11,R11,R9"); printf2(" ; extend char sign bit if needed"); puts2("");		
		
		printf2("\tmov\tR0,R11"); puts2("");
		printf2("\tincs\tR11,R11,#%d",temp); puts2("");
		printf2("\tmovb\t@R1,R11"); puts2("");		
	}
							 
						 
#ifdef CAN_COMPILE_32BIT
  GenRegB2Seg();
#endif
 // GenPrintInstr2Operands(X86InstrMov, 0,
 //                        GenSelectByteOrWord(X86OpRegAByteOrWord, opSz), 0,
 //                        X86OpIndRegB, 0);
 // GenExtendRegAIfNeeded(opSz);
 // GenPrintInstr1Operand(instr, 0,
 //                       GenSelectByteOrWord(X86OpIndRegBExplicitByteOrWord, opSz), 0);
}

STATIC
void GenPostAddSubIdent(int opSz, int val, int label, int tok)
{
  int instr = X86InstrAdd;

  if (tok != tokPostAdd)
    instr = X86InstrSub;

  GenPrintInstr2Operands(X86InstrMov, 0,
                         GenSelectByteOrWord(X86OpRegAByteOrWord, opSz), 0,
                         X86OpIndLabel, label);
  GenExtendRegAIfNeeded(opSz);
  GenPrintInstr2Operands(instr, 0,
                         GenSelectByteOrWord(X86OpIndLabelExplicitByteOrWord, opSz), label,
                         X86OpConst, val);
}

STATIC
void GenPostAddSubLocal(int opSz, int val, int ofs, int tok)
{
  int instr = X86InstrAdd;

  if (tok != tokPostAdd)
    instr = X86InstrSub;

  //GenPrintInstr2Operands(X86InstrMov, 0,
  //                       GenSelectByteOrWord(X86OpRegAByteOrWord, opSz), 0,
 //                        X86OpIndLocal, ofs);

						 
	printf2("\tldd\tR10,#"); GenPrintOperand(X86OpIndLocal, ofs); printf2("  ; mov	eax, [ebp-ofs]"); puts2("");
	printf2("\tadd\tR10,R10,R13"); puts2("");
		
	if (opSz == 2)
	{
		printf2("\tmovw\tR0,@R10"); puts2("");	
	}
	else if (opSz == -2)
	{
		printf2("\tmovsw\tR0,@R10"); puts2("");	
	}
	else if (opSz == 1 || opSz == -1)	
	{
		printf2("\tmovb\tR0,@R10"); puts2("");	
	}
	else
	{
		printf2("\tmovd\tR0,@R10"); puts2("");	
	}	
				
				
  //GenPrintInstr2Operands(instr, 0,
  //                       GenSelectByteOrWord(X86OpIndLocalExplicitByteOrWord, opSz), ofs,
  //                       X86OpConst, val);
						
	printf2("\tldd\tR10,#"); GenPrintOperand(X86OpIndLocal, ofs); printf2(" ; add/sub [ebp-ofs], const32"); puts2("");
	printf2("\tadd\tR10,R10,R13"); puts2("");
		
	if (opSz == 2)
	{
		printf2("\tmovw\tR11,@R10"); puts2("");	
	}
	else if (opSz == -2)
	{
		printf2("\tmovsw\tR11,@R10"); puts2("");	
	}
	else if (opSz == 1 || opSz == -1)	
	{
		printf2("\tmovb\tR11,@R10"); puts2("");	
	}
	else
	{
		printf2("\tmovd\tR11,@R10"); puts2("");	
	}	

						
		if (instr == X86InstrAdd){
			printf2("\tldd\tR12,#"); GenPrintOperand(X86OpConst, val);  puts2("");
			printf2("\tadd\tR11,R11,R12"); puts2("");
		}
		if (instr == X86InstrSub){
			printf2("\tldd\tR12,#"); GenPrintOperand(X86OpConst, val); puts2("");
			printf2("\tsubslt\tR11,R11,R12"); puts2("");
			printf2("\tand\tR0,R0,R0"); puts2("");			
		}
				 
	if (opSz == 2)
	{
		printf2("\tmovw\t@R10,R11"); puts2("");	
	}
	else if (opSz == -2)
	{
		printf2("\tmovsw\t@R10,R11"); puts2("");
	}
	else if (opSz == 1 || opSz == -1)	
	{
		printf2("\tmovb\t@R10,R11"); puts2("");	
	}
	else
	{
		printf2("\tmovd\t@R10,R11"); puts2("");
	}	
				 

}

STATIC
void GenPostAddSubIndirect(int opSz, int val, int tok)
{
  int instr = X86InstrAdd;

  if (tok != tokPostAdd)
    instr = X86InstrSub;

  GenPrintInstr2Operands(X86InstrMov, 0,
                         X86OpRegBWord, 0,
                         X86OpRegAWord, 0);
#ifdef CAN_COMPILE_32BIT
  GenRegB2Seg();
#endif
  GenPrintInstr2Operands(X86InstrMov, 0,
                         GenSelectByteOrWord(X86OpRegAByteOrWord, opSz), 0,
                         X86OpIndRegB, 0);
  GenExtendRegAIfNeeded(opSz);
  GenPrintInstr2Operands(instr, 0,
                         GenSelectByteOrWord(X86OpIndRegBExplicitByteOrWord, opSz), 0,
                         X86OpConst, val);
}

#define tokOpNumInt      0x100
#define tokOpNumUint     0x101
#define tokOpIdent       0x102
#define tokOpLocalOfs    0x103
#define tokOpAcc         0x104
#define tokOpIndIdent    0x105
#define tokOpIndLocalOfs 0x106
#define tokOpIndAcc      0x107
#define tokOpStack       0x108
#define tokOpIndStack    0x109

#define tokPushAcc       0x200

STATIC
int GetOperandInfo(int idx, int lvalSize, int* val, int* size, int* delDeref)
{
  int idx0 = idx;

  *delDeref = 0;

  while (stack[idx][0] >= tokOpNumInt && stack[idx][0] <= tokOpIndAcc)
    idx--;

  if (stack[idx][0] == tokUnaryStar)
  {
    if (lvalSize)
    {
      // lvalue dereference is implied for the left operand of =
      // and for operands of ++/--, these operands contain the
      // lvalue address
      *size = lvalSize;
      *val = 0;
      return tokOpIndAcc;
    }

    *size = stack[idx][1]; // take size from tokUnaryStar

    *delDeref = 1;
    *val = stack[idx + 1][1]; // operand "value" is in tokUnaryStar's operand
    return stack[idx + 1][0] + tokOpIndIdent - tokOpIdent; // add indirection
  }

  idx = idx0;

  if (lvalSize)
  {
    // lvalue dereference is implied for the left operand of =
    // and for operands of ++/--
    *size = lvalSize;
    *val = stack[idx][1];

    switch (stack[idx][0])
    {
    case tokIdent:
#ifdef CAN_COMPILE_32BIT
      if (OutputFormat == FormatSegHuge)
        goto l1;
#endif
      return tokOpIndIdent;
    case tokLocalOfs:
      return tokOpIndLocalOfs;

    default:
#ifdef CAN_COMPILE_32BIT
l1:
#endif
      *val = 0;
      return tokOpIndAcc;
    }
  }

  *size = SizeOfWord;
  *val = stack[idx][1];

  switch (stack[idx][0])
  {
  case tokNumInt:
    return tokOpNumInt;
  case tokNumUint:
    return tokOpNumUint;
  case tokIdent:
#ifdef CAN_COMPILE_32BIT
    if (OutputFormat == FormatSegHuge)
      goto l2;
#endif
    return tokOpIdent;
  case tokLocalOfs:
    return tokOpLocalOfs;

  default:
#ifdef CAN_COMPILE_32BIT
l2:
#endif
    *val = 0;
    return tokOpAcc;
  }
}

STATIC
void GenFuse(int* idx)
{
  int tok;
  int oldIdxRight, oldSpRight;
  int oldIdxLeft, oldSpLeft;
  int opSzRight, opSzLeft;
  int opTypRight, opTypLeft;
  int opValRight, opValLeft;
  int delDerefRight, delDerefLeft;
  int num, lvalSize;

  if (*idx < 0)
    //error("GenFuse(): idx < 0\n");
    errorInternal(100);

  tok = stack[*idx][0];

  --*idx;

  oldIdxRight = *idx;
  oldSpRight = sp;

  switch (tok)
  {
  case tokNumInt:
  case tokNumUint:
  case tokIdent:
  case tokLocalOfs:
    break;

  case tokShortCirc:
  case tokGoto:
    GenFuse(idx);
    break;

  case tokUnaryStar:
    opSzRight = stack[*idx + 1][1];
    GenFuse(idx);
    oldIdxRight -= oldSpRight - sp;

    switch (stack[oldIdxRight][0])
    {
    case tokIdent:
#ifdef CAN_COMPILE_32BIT
      if (OutputFormat == FormatSegHuge)
        goto l1;
#endif
    case tokLocalOfs:
      if (stack[oldIdxRight][0] == tokIdent)
        stack[oldIdxRight + 1][0] = tokOpIdent;
      else
        stack[oldIdxRight + 1][0] = tokOpLocalOfs;
      stack[oldIdxRight + 1][1] = stack[oldIdxRight][1];
      stack[oldIdxRight][0] = tok;
      stack[oldIdxRight][1] = opSzRight;
      break;
    default:
#ifdef CAN_COMPILE_32BIT
l1:
#endif
      ins(oldIdxRight + 2, tokOpAcc);
      break;
    }
    break;

  case tokInc:
  case tokDec:
  case tokPostInc:
  case tokPostDec:
    opSzRight = stack[*idx + 1][1];
    GenFuse(idx);
    oldIdxRight -= oldSpRight - sp;

    switch (stack[oldIdxRight][0])
    {
    case tokIdent:
#ifdef CAN_COMPILE_32BIT
      if (OutputFormat == FormatSegHuge)
        goto l2;
#endif
    case tokLocalOfs:
      if (stack[oldIdxRight][0] == tokIdent)
        stack[oldIdxRight + 1][0] = tokOpIndIdent;
      else
        stack[oldIdxRight + 1][0] = tokOpIndLocalOfs;
      stack[oldIdxRight + 1][1] = stack[oldIdxRight][1];
      stack[oldIdxRight][0] = tok;
      stack[oldIdxRight][1] = opSzRight;
      break;
    default:
#ifdef CAN_COMPILE_32BIT
l2:
#endif
      ins(oldIdxRight + 2, tokOpIndAcc);
      break;
    }
    break;

  case '~':
  case tokUnaryPlus:
  case tokUnaryMinus:
  case tok_Bool:
  case tokVoid:
  case tokUChar:
  case tokSChar:
#ifdef CAN_COMPILE_32BIT
  case tokShort:
  case tokUShort:
#endif
    GenFuse(idx);
    oldIdxRight -= oldSpRight - sp;
    if (tok == tokUnaryPlus)
      del(oldIdxRight + 1, 1);
    break;

  case tokPostAdd:
  case tokPostSub:
    opSzRight = stack[*idx + 1][1];
    num = stack[*idx][1];
    oldIdxRight = --*idx; // skip tokNum
    GenFuse(idx);
    oldIdxRight -= oldSpRight - sp;
    switch (stack[oldIdxRight][0])
    {
    case tokIdent:
#ifdef CAN_COMPILE_32BIT
      if (OutputFormat == FormatSegHuge)
        goto l3;
#endif
    case tokLocalOfs:
      stack[oldIdxRight + 2][0] = tokOpNumInt;
      stack[oldIdxRight + 2][1] = num;
      if (stack[oldIdxRight][0] == tokIdent)
        stack[oldIdxRight + 1][0] = tokOpIndIdent;
      else
        stack[oldIdxRight + 1][0] = tokOpIndLocalOfs;
      stack[oldIdxRight + 1][1] = stack[oldIdxRight][1];
      stack[oldIdxRight][0] = tok;
      stack[oldIdxRight][1] = opSzRight;
      break;
    default:
#ifdef CAN_COMPILE_32BIT
l3:
#endif
      stack[oldIdxRight + 1][0] = tok;
      stack[oldIdxRight + 1][1] = opSzRight;
      stack[oldIdxRight + 2][0] = tokOpIndAcc;
      ins2(oldIdxRight + 3, tokOpNumInt, num);
      break;
    }
    break;

/*
  Operator-operand fusion:

  ac = lft:       ac op= rht:        lft = ac:
  (load)          ("execute")        (store)

  *(id/l)         *(id/l)            *(id/l)
    mov a?,mlft     op a?,mrht         mov mlft,a?
                    ---
                    mov cl,mrht
                    shift ax,cl
                    ---
                    mov c?,mrht
                    cwd
                    idiv cx
                    opt: mov ax,dx

  *ac             *ac                *ac
    mov bx,ax       < mov bx,ax        ; bx preserved
    mov a?,[bx]     < mov c?,[bx]      mov [bx],a?
                    op ax,cx(cl)

  *ac-stack       n/a                *ac-stack
    pop bx                             ; bx preserved
    mov a?,[bx]                        mov [bx],a?

  id/num          id/num
    mov ax,ilft     op ax,irht
                    ---
                    mov cx,irht
                    op ax,cx

  l               l
    lea ax,llft     lea cx,lrht
                    op ax,cx

  ac              ac
    nop             < mov cx,ax
                    op ax,cx

  ac-stack        n/a
    pop ax

  lft (*)ac -> lft (*)ac-stack IFF rht is (*)ac

  Legend:
  - lft/rht - left/right operand
  - num - number
  - id - global/static identifier/location
  - l - local variable location
  - * - dereference operator
  - m - memory operand at address id/l
  - i - immediate/number/constant operand
  - ac - accumulator (al or ax)
  - a? - accumulator (al or ax), depending on operand size
  - b? - bl or bx, depending on operand size
  - >push axlft - need to insert "push ax" at the end of the left operand evaluation

    instruction operand combinations (dst/lft, src/rht):
    - r/m, r/imm
    - r, m

    special instructions:
    - lea r, m
    - shl/sar
    - mul/imul/idiv
    - cbw/cwd
    - movsx/movzx
*/

  case '=':
  case tokAssignAdd:
  case tokAssignSub:
  case tokAssignMul:
  case tokAssignDiv:
  case tokAssignUDiv:
  case tokAssignMod:
  case tokAssignUMod:
  case tokAssignLSh:
  case tokAssignRSh:
  case tokAssignURSh:
  case tokAssignAnd:
  case tokAssignXor:
  case tokAssignOr:
  case '+':
  case '-':
  case '*':
  case '/':
  case tokUDiv:
  case '%':
  case tokUMod:
  case tokLShift:
  case tokRShift:
  case tokURShift:
  case '&':
  case '^':
  case '|':
  case '<':
  case '>':
  case tokLEQ:
  case tokGEQ:
  case tokEQ:
  case tokNEQ:
  case tokULess:
  case tokUGreater:
  case tokULEQ:
  case tokUGEQ:
  case tokLogAnd:
  case tokLogOr:
  case tokComma:
    switch (tok)
    {
    case '=':
    case tokAssignAdd:
    case tokAssignSub:
    case tokAssignMul:
    case tokAssignDiv:
    case tokAssignUDiv:
    case tokAssignMod:
    case tokAssignUMod:
    case tokAssignLSh:
    case tokAssignRSh:
    case tokAssignURSh:
    case tokAssignAnd:
    case tokAssignXor:
    case tokAssignOr:
      lvalSize = stack[*idx + 1][1];
      break;
    default:
      lvalSize = 0;
      break;
    }

    GenFuse(idx);
    oldIdxRight -= oldSpRight - sp;
    opTypRight = GetOperandInfo(oldIdxRight, 0, &opValRight, &opSzRight, &delDerefRight);

    oldIdxLeft = *idx; oldSpLeft = sp;
    GenFuse(idx);
    oldIdxLeft -= oldSpLeft - sp;
    oldIdxRight -= oldSpLeft - sp;
    opTypLeft = GetOperandInfo(oldIdxLeft, lvalSize, &opValLeft, &opSzLeft, &delDerefLeft);

    // operands of &&, || and comma aren't to be fused into &&, || and comma
    if (tok == tokLogAnd || tok == tokLogOr || tok == tokComma)
      break;

    if (opTypLeft != tokOpAcc && opTypLeft != tokOpIndAcc)
    {
      // the left operand will be fully fused into the operator, remove it
      int cnt = oldIdxLeft - *idx;
      del(*idx + 1, cnt);
      oldIdxLeft -= cnt;
      oldIdxRight -= cnt;
    }
    else if (opTypRight == tokOpAcc || opTypRight == tokOpIndAcc)
    {
      // preserve ax after the evaluation of the left operand
      // because the right operand's value ends up in ax as well
      ins(++oldIdxLeft, tokPushAcc);
      oldIdxRight++;
      // adjust the left operand "type"/location
      if (opTypLeft == tokOpAcc)
        opTypLeft = tokOpStack;
      else
        opTypLeft = tokOpIndStack;
      if (delDerefLeft)
      {
        // remove the dereference, fusing will take care of it
        del(oldIdxLeft -= 2, 2);
        oldIdxRight -= 2;
      }
    }
    else if (delDerefLeft)
    {
      // remove the dereference, fusing will take care of it
      del(oldIdxLeft - 1, 2);
      oldIdxLeft -= 2;
      oldIdxRight -= 2;
    }

    if (opTypRight != tokOpAcc && opTypRight != tokOpIndAcc)
    {
      // the right operand will be fully fused into the operator, remove it
      int cnt = oldIdxRight - oldIdxLeft;
      del(oldIdxLeft + 1, cnt);
      oldIdxRight -= cnt;
    }
    else if (delDerefRight)
    {
      // remove the dereference, fusing will take care of it
      del(oldIdxRight - 1, 2);
      oldIdxRight -= 2;
    }

    // store the operand sizes into the operator
    stack[oldIdxRight + 1][1] = (opSzLeft + 8) * 16 + (opSzRight + 8);

    // fuse the operands into the operator
    ins2(oldIdxRight + 2, opTypRight, opValRight);
    ins2(oldIdxRight + 2, opTypLeft, opValLeft);
    break;

  case ')':
    while (stack[*idx][0] != '(')
    {
      GenFuse(idx);
      if (stack[*idx][0] == ',')
        --*idx;
    }
    --*idx;
    break;

  default:
    //error("GenFuse: unexpected token %s\n", GetTokenName(tok));
    errorInternal(101);
  }
}

STATIC
int GenGetBinaryOperatorInstr(int tok)
{
  switch (tok)
  {
  case tokPostAdd:
  case tokAssignAdd:
  case '+':
    return X86InstrAdd;
  case tokPostSub:
  case tokAssignSub:
  case '-':
    return X86InstrSub;
  case '&':
  case tokAssignAnd:
    return X86InstrAnd;
  case '^':
  case tokAssignXor:
    return X86InstrXor;
  case '|':
  case tokAssignOr:
    return X86InstrOr;
  case '<':
  case '>':
  case tokLEQ:
  case tokGEQ:
  case tokEQ:
  case tokNEQ:
  case tokULess:
  case tokUGreater:
  case tokULEQ:
  case tokUGEQ:
    return X86InstrCmp;
  case '*':
  case tokAssignMul:
    return X86InstrMul;
  case '/':
  case '%':
  case tokAssignDiv:
  case tokAssignMod:
    return X86InstrIdiv;
  case tokUDiv:
  case tokUMod:
  case tokAssignUDiv:
  case tokAssignUMod:
    return X86InstrDiv;
  case tokLShift:
  case tokAssignLSh:
    return X86InstrShl;
  case tokRShift:
  case tokAssignRSh:
    return X86InstrSar;
  case tokURShift:
  case tokAssignURSh:
    return X86InstrShr;

  default:
    //error("Error: Invalid operator\n");
    errorInternal(102);
    return 0;
  }
}

// Newer, less stack-dependent code generator,
// generates more compact code (~30% less) than the stack-based generator
#ifndef CG_STACK_BASED
STATIC
void GenExpr1(void)
{
  int s = sp - 1;
  int i;
  int ptok = 0;
  
  if (stack[s][0] == tokIf || stack[s][0] == tokIfNot)
    s--;
  GenFuse(&s);

#ifndef NO_ANNOTATIONS
  printf2("; Fused expression:    \"");
  for (i = 0; i < sp; i++)
  {
    int tok = stack[i][0];
    switch (tok)
    {
    case tokNumInt:
    case tokOpNumInt:
      printf2("%d", truncInt(stack[i][1]));
      break;
    case tokNumUint:
    case tokOpNumUint:
      printf2("%uu", truncUint(stack[i][1]));
      break;
    case tokIdent:
    case tokOpIdent:
      {
        char* p = IdentTable + stack[i][1];
        if (isdigit(*p))
          printf2("L");
        printf2("%s", p);
      }
      break;
    case tokOpIndIdent:
      printf2("*%s", IdentTable + stack[i][1]);
      break;
    case tokShortCirc:
      if (stack[i][1] >= 0)
        printf2("[sh&&->%d]", stack[i][1]);
      else
        printf2("[sh||->%d]", -stack[i][1]);
      break;
    case tokGoto:
        printf2("[goto->%d]", stack[i][1]);
      break;
    case tokLocalOfs:
    case tokOpLocalOfs:
      printf2("(@%d)", truncInt(stack[i][1]));
      break;
    case tokOpIndLocalOfs:
      printf2("*(@%d)", truncInt(stack[i][1]));
      break;
    case tokUnaryStar:
      printf2("*(%d)", stack[i][1]);
      break;
    case '(': case ',':
      printf2("%c", tok);
      break;
    case ')':
      printf2(")%d", stack[i][1]);
      break;
    case tokOpAcc:
      printf2("ax");
      break;
    case tokOpIndAcc:
      printf2("*ax");
      break;
    case tokOpStack:
      printf2("*sp");
      break;
    case tokOpIndStack:
      printf2("**sp");
      break;
    case tokPushAcc:
      printf2("push-ax");
      break;
    case tokIf:
      printf2("IF");
      break;
    case tokIfNot:
      printf2("IF!");
      break;
    default:
      printf2("%s", GetTokenName(tok));
      switch (tok)
      {
      case tokLogOr: case tokLogAnd:
        printf2("[%d]", stack[i][1]);
        break;
      case '=':
      case tokInc: case tokDec:
      case tokPostInc: case tokPostDec:
      case tokAssignAdd: case tokAssignSub:
      case tokPostAdd: case tokPostSub:
      case tokAssignMul: case tokAssignDiv: case tokAssignMod:
      case tokAssignUDiv: case tokAssignUMod:
      case tokAssignLSh: case tokAssignRSh: case tokAssignURSh:
      case tokAssignAnd: case tokAssignXor: case tokAssignOr:
        printf2("(%d)", stack[i][1]);
        break;
      }
      break;
    }
    printf2(" ");
  }
  printf2("\"\n");
#endif

  for (i = 0; i < sp; i++)
  {
    int tok = stack[i][0];
    int v = stack[i][1];
    int instr;
	char temp;
	
    switch (tok)
    {
    case tokNumInt:
    case tokNumUint:
      // Don't load operand into ax when ax is going to be pushed next, push it directly
      if (!(i + 1 < sp && stack[i + 1][0] == ','))
	  {
	  	  printf2("\tldd\tR0,#"); GenPrintOperand(X86OpConst, v); printf2(" ; // mov	eax, const_32"); puts2(""); 
	  }
     //   GenPrintInstr2Operands(X86InstrMov, 0,
    //                           X86OpRegAWord, 0,
    //                           X86OpConst, v);
      break;
    case tokIdent:
      // Don't load operand into ax when ax is going to be pushed next, push it directly
      if (!(i + 1 < sp && (stack[i + 1][0] == ',' || stack[i + 1][0] == ')')))
	  {
		printf2("\tldd\tR0,$"); GenPrintOperand(X86OpLabel, v); puts2(""); 
		printf2("\tadd\tR0,R0,R4"); puts2(""); 
	  }

        //GenPrintInstr2Operands(X86InstrMov, 0,
        //                       X86OpRegAWord, 0,
        //                       X86OpLabel, v);
      break;
    case tokLocalOfs:
     // GenPrintInstr2Operands(X86InstrLea, 0,
     //                        X86OpRegAWord, 0,
     //                        X86OpIndLocal, v);
	 
		printf2("\tldd\tR10,#"); GenPrintOperand(X86OpIndLocal, v); puts2(""); 
		printf2("\tadd\tR10,R13,R10"); puts2(""); 	// Add BP with offset to obtain final 32bit address. 
		printf2("\tmov\tR0,R10"); puts2(""); 	 		
	 
      break;

    case '~':
	  printf2("\tnot\tR0,R0");  printf2(" ; not	eax"); puts2(""); 
      break;
    case tokUnaryMinus:
		printf2("\tnot\tR0,R0");  printf2(" ; neg	eax"); puts2(""); 
		printf2("\tincs\tR0,R0,#1");  puts2(""); 

     // GenPrintInstr1Operand(X86InstrNeg, 0,
     //                       X86OpRegAWord, 0);
      break;
    case tok_Bool:
			printf2("\tmov\tR12,R0"); puts2("");	
			printf2("\tldb\tR0,#0"); puts2("");
			printf2("\ttstsz\tR12,R12"); puts2("");
			printf2("\tldb\tR0,#1"); puts2("");	
			printf2("LC%d:",cond_label); cond_label=cond_label+1; puts2("");			
	 break;
     // GenPrintInstr2Operands(X86InstrTest, 0,
    //                         X86OpRegAWord, 0,
     //                        X86OpRegAWord, 0);
    //  GenPrintInstr1Operand(X86InstrSetCc, tokNEQ,
     //                       X86OpRegAByte, 0);  
      // fallthrough
    case tokSChar:
      if (SizeOfWord == 2)
        GenPrintInstrNoOperand(X86InstrCbw);
#ifdef CAN_COMPILE_32BIT
      else
        //GenPrintInstr2Operands(X86InstrMovSx, 0,
        //                       X86OpRegAWord, 0,
        //                       X86OpRegAByte, 0);
#endif
      break;
    case tokUChar:
	//	printf2("\tldb\tR10,#255"); puts2("");	
	//	printf2("\tand\tR0,R0,R10"); puts2("");

      //GenPrintInstr2Operands(X86InstrAnd, 0,
      //                       X86OpRegAWord, 0,
      //                       X86OpConst, 0xFF);
      break;
#ifdef CAN_COMPILE_32BIT
    case tokShort:
     // GenPrintInstr2Operands(X86InstrMovSx, 0,
      //                       X86OpRegAWord, 0,
      //                       X86OpRegAHalfWord, 0);
      break;
    case tokUShort:
      //GenPrintInstr2Operands(X86InstrMovZx, 0,
      //                       X86OpRegAWord, 0,
       //                      X86OpRegAHalfWord, 0);
      break;
#endif

    case tokShortCirc:
      if (v >= 0)
        GenJumpIfZero(v); // &&
      else
        GenJumpIfNotZero(-v); // ||
      break;
    case tokGoto:
      GenJumpUncond(v);
      break;
    case tokLogAnd:
    case tokLogOr:
      GenNumLabel(v);
      break;

    case tokPushAcc:
      // TBD??? handle similarly to ','???
		printf2("\tincs\tR14,R14,#-4;"); puts2("");
		printf2("\tmovd\t@R14,R0"); printf2(" ; Push\teax "); puts2("");


	  
     // GenPrintInstr1Operand(X86InstrPush, 0,
     //                       X86OpRegAWord, 0);
							
      break;

    case ',':
      // push operand directly if it hasn't been loaded into ax
      if (stack[i - 2][0] == tokUnaryStar && stack[i - 2][1] == SizeOfWord)
      {
        switch (stack[i - 1][0])
        {
        case tokOpIdent:
		
			printf2("\tldd\tR11,$"); GenPrintOperand(X86OpIndLabel, stack[i - 1][1]);  printf2(" ; push [memvar_32]"); puts2("");			
			printf2("\tadd\tR11,R11,R4"); puts2("");
			printf2("\tmovd\tR12,@R11"); puts2("");		 
			printf2("\tincs\tR14,R14,#-4;"); puts2("");
			printf2("\tmovd\t@R14,R12"); puts2("");	
			
          //GenPrintInstr1Operand(X86InstrPush, 0,
          //                      X86OpIndLabelExplicitWord, stack[i - 1][1]);
          break;
        case tokOpLocalOfs:
         // GenPrintInstr1Operand(X86InstrPush, 0,
         //                       X86OpIndLocalExplicitWord, stack[i - 1][1]);

			printf2("\tldd\tR11,#"); GenPrintOperand(X86OpIndLocal, stack[i - 1][1]);  printf2(" ; push [ebp-ofs]"); puts2("");			
			printf2("\tadd\tR11,R11,R13"); puts2("");
			printf2("\tmovd\tR12,@R11"); puts2("");		 
			printf2("\tincs\tR14,R14,#-4;"); puts2("");
			printf2("\tmovd\t@R14,R12"); puts2("");	
		 
          break;
        case tokOpAcc:
          GenPrintInstr2Operands(X86InstrMov, 0,
                                 X86OpRegBWord, 0,
                                 X86OpRegAWord, 0);
#ifdef CAN_COMPILE_32BIT
          GenRegB2Seg();
#endif

			printf2("\tmovd\tR12,@R1"); puts2("");
			printf2("\tincs\tR14,R14,#-4;"); puts2("");
			printf2("\tmovd\t@R14,R12"); puts2("");
         // GenPrintInstr1Operand(X86InstrPush, 0,
         //                       X86OpIndRegBExplicitWord, 0);
          break;
        }
      }
      else
      {
        switch (stack[i - 1][0])
        {
        case tokNumInt:
        case tokNumUint:		
			printf2("\tincs\tR14,R14,#-4"); puts2("");
			printf2("\tLDD\tR10,#"); GenPrintOperand(X86OpConst, stack[i - 1][1]); puts2("");
			printf2("\tmovd\t@R14,R10"); puts2("");	
	
       //   GenPrintInstr1Operand(X86InstrPush, 0,
       //                         X86OpConst, stack[i - 1][1]);
          break;
        case tokIdent:
			printf2("\tincs\tR14,R14,#-4"); puts2("");		 //  push	Addr_Label 
			printf2("\tLDD\tR10,$"); GenPrintOperand(X86OpLabel, stack[i - 1][1]); puts2("");
			printf2("\tadd\tR10,R10,R4"); puts2("");	
			printf2("\tmovd\t@R14,R10"); puts2("");			
		
       //   GenPrintInstr1Operand(X86InstrPush, 0,
       //                         X86OpLabel, stack[i - 1][1]);
          break;
        default:
			printf2("\tincs\tR14,R14,#-4"); puts2("");
			printf2("\tmovd\t@R14,R0"); puts2("");			
         // GenPrintInstr1Operand(X86InstrPush, 0,
         //                       X86OpRegAWord, 0);
          break;
        }
      }
      break;

    case tokUnaryStar:
      // Don't load operand into ax when ax is going to be pushed next, push it directly
      if (!(v == SizeOfWord && i + 2 < sp && stack[i + 2][0] == ','))
      {
        switch (stack[i + 1][0])
        {
        case tokOpIdent:
          GenReadIdent(v, stack[i + 1][1]);
          break;
        case tokOpLocalOfs:
          GenReadLocal(v, stack[i + 1][1]);
          break;
        case tokOpAcc:
          GenReadIndirect(v);
          break;
        }
      }
      i++;
      break;

    case tokInc:
    case tokDec:
      switch (stack[i + 1][0])
      {
      case tokOpIndIdent:
        GenIncDecIdent(v, stack[i + 1][1], tok);
        break;
      case tokOpIndLocalOfs:
        GenIncDecLocal(v, stack[i + 1][1], tok);
        break;
      case tokOpIndAcc:
        GenIncDecIndirect(v, tok);
        break;
      }
      i++;
      break;

    case tokPostInc:
    case tokPostDec:
      switch (stack[i + 1][0])
      {
      case tokOpIndIdent:
        GenPostIncDecIdent(v, stack[i + 1][1], tok);
        break;
      case tokOpIndLocalOfs:
        GenPostIncDecLocal(v, stack[i + 1][1], tok);
        break;
      case tokOpIndAcc:
        GenPostIncDecIndirect(v, tok);
        break;
      }
      i++;
      break;

    case tokPostAdd:
    case tokPostSub:
      switch (stack[i + 1][0])
      {
      case tokOpIndIdent:
        GenPostAddSubIdent(v, stack[i + 2][1], stack[i + 1][1], tok);
        break;
      case tokOpIndLocalOfs:
        GenPostAddSubLocal(v, stack[i + 2][1], stack[i + 1][1], tok);
        break;
      case tokOpIndAcc:
        GenPostAddSubIndirect(v, stack[i + 2][1], tok);
        break;
      }
      i += 2;
      break;

    case '=':
    case tokAssignAdd:
    case tokAssignSub:
    case tokAssignMul:
    case tokAssignDiv:
    case tokAssignUDiv:
    case tokAssignMod:
    case tokAssignUMod:
    case tokAssignLSh:
    case tokAssignRSh:
    case tokAssignURSh:
    case tokAssignAnd:
    case tokAssignXor:
    case tokAssignOr:
    case '+':
    case '-':
    case '*':
    case '/':
    case tokUDiv:
    case '%':
    case tokUMod:
    case tokLShift:
    case tokRShift:
    case tokURShift:
    case '&':
    case '^':
    case '|':
    case '<':
    case '>':
    case tokLEQ:
    case tokGEQ:
    case tokEQ:
    case tokNEQ:
    case tokULess:
    case tokUGreater:
    case tokULEQ:
    case tokUGEQ:
      // save the right operand from ax in cx, so it's not
      // overwritten by the left operand in ax
      if (tok != '=')
      {
        if (stack[i + 2][0] == tokOpAcc)
        {
         // GenPrintInstr2Operands(X86InstrMov, 0, 
         //                        X86OpRegCWord, 0,
         //                        X86OpRegAWord, 0);
			 printf2("\tmov\tR2,R0"); printf2(" ; mov ecx, eax"); puts2("");		
        }
        else if (stack[i + 2][0] == tokOpIndAcc)
        {
          GenReadCRegIndirect(v % 16 - 8);
        }
      }

      // load the left operand into ax (or the right operand if it's '=')

      if (tok == '=')
      {
        if (stack[i + 1][0] == tokOpIndAcc)
		{
         // GenPrintInstr2Operands(X86InstrMov, 0,
         //                        X86OpRegBWord, 0,
         //                        X86OpRegAWord, 0);
			 printf2("\tmov\tR1,R0"); printf2(" ; mov ebx, eax"); puts2("");		
		}
        // "swap" left and right operands
        i++;
        v = v / 16 + v % 16 * 16;
      }

      switch (stack[i + 1][0])
      {
      case tokOpNumInt:
      case tokOpNumUint:
	  printf2("\tldd\tR0,#"); GenPrintOperand(X86OpConst, stack[i + 1][1]); printf2(" ; // mov	eax, const_32"); puts2(""); 
    //    GenPrintInstr2Operands(X86InstrMov, 0,
    //                           X86OpRegAWord, 0,
    //                           X86OpConst, stack[i + 1][1]);
        break;
      case tokOpIdent:
		printf2("\tldd\tR0,$"); GenPrintOperand(X86OpLabel, stack[i + 1][1]); printf2(" ; // mov	eax, label"); puts2(""); 
		printf2("\tadd\tR0,R0,R4"); puts2("");		
    //    GenPrintInstr2Operands(X86InstrMov, 0,
     //                          X86OpRegAWord, 0,
     //                          X86OpLabel, stack[i + 1][1]);
        break;
      case tokOpLocalOfs:
      //  GenPrintInstr2Operands(X86InstrLea, 0,
      //                         X86OpRegAWord, 0,
      //                         X86OpIndLocal, stack[i + 1][1]);

			printf2("\tldd\tR10,#"); GenPrintOperand(X86OpIndLocal, stack[i + 1][1]);  printf2(" ; lea	eax, [ebp-ofs]"); puts2("");		
			printf2("\tadd\tR0,R10,R13"); puts2("");
	  
        break;
      case tokOpAcc:
        break;
      case tokOpIndIdent:
        GenReadIdent(v / 16 - 8, stack[i + 1][1]);
        break;
      case tokOpIndLocalOfs:
        GenReadLocal(v / 16 - 8, stack[i + 1][1]);
        break;
      case tokOpIndAcc:
        GenReadIndirect(v / 16 - 8);
        break;
      case tokOpStack:
			printf2("\tmovd\tR0,@R14"); printf2(" ; // pop	eax"); puts2(""); 
			printf2("\tincs\tR14,R14,#4"); puts2("");	
        break;
      case tokOpIndStack:
			printf2("\tmovd\tR1,@R14"); printf2(" ; // pop	ebx"); puts2(""); 
			printf2("\tincs\tR14,R14,#4"); puts2("");		  
     //   GenPrintInstr1Operand(X86InstrPop, 0,
    //                          X86OpRegBWord, 0);
#ifdef CAN_COMPILE_32BIT
        GenRegB2Seg();
#endif

		if((v / 16 - 8) == 1)	{ 
			printf2("\tmovb\tR0,@R1"); puts2("");
		}
		else if((v / 16 - 8) == 2)	{
			printf2("\tmovw\tR0,@R1"); puts2("");
		}
		else if((v / 16 - 8) == -1)	{
			printf2("\tmovb\tR0,@R1"); puts2("");
			printf2("\tbitsz\tR0,#7"); puts2("");
			printf2("\tadd\tR0,R0,R9"); printf2(" ; extend char sign bit if needed"); puts2("");			
		}	
		else if((v / 16 - 8) == -2)	{
			printf2("\tmovsw\tR0,@R1"); puts2("");
		}
		else
		{
			printf2("\tmovd\tR0,@R1"); puts2("");			
		}		
		
     //   GenPrintInstr2Operands(X86InstrMov, 0,
      //                         GenSelectByteOrWord(X86OpRegAByteOrWord, v / 16 - 8), 0,
      //                         X86OpIndRegB, 0);
      //  GenExtendRegAIfNeeded(v / 16 - 8);
        break;
      }

      if (tok == '=')
      {
        // "unswap" left and right operands
        i--;
        v = v / 16 + v % 16 * 16;

        if (stack[i + 1][0] == tokOpIndStack)
		{
			printf2("\tmovd\tR1,@R14"); printf2(" ; // pop	ebx"); puts2(""); // GenPrintOperand(X86OpLabel, stack[i + 1][1]); 
			printf2("\tincs\tR14,R14,#4"); puts2("");		
		}
        //  GenPrintInstr1Operand(X86InstrPop, 0,
        //                        X86OpRegBWord, 0);
      }

      // operator
      switch (tok)
      {
      case tokAssignAdd:
      case tokAssignSub:
      case tokAssignAnd:
      case tokAssignXor:
      case tokAssignOr:
      case '+':
      case '-':
      case '&':
      case '^':
      case '|':
      case '<':
      case '>':
      case tokLEQ:
      case tokGEQ:
      case tokEQ:
      case tokNEQ:
      case tokULess:
      case tokUGreater:
      case tokULEQ:
      case tokUGEQ:
        instr = GenGetBinaryOperatorInstr(tok);

        switch (stack[i + 2][0])
        {
        case tokOpNumInt:
        case tokOpNumUint:
		if((stack[i + 2][1] > -1) && (stack[i + 2][1] < 65536))
		{
			if(stack[i + 2][1] < 256)
			{
				printf2("\tldb\tR10,#"); GenPrintOperand(X86OpConst, stack[i + 2][1]);  puts2("");
			}
			else
			{
				printf2("\tldw\tR10,#"); GenPrintOperand(X86OpConst, stack[i + 2][1]);  puts2("");
			}
		}
		else
		{
			printf2("\tldd\tR10,#"); GenPrintOperand(X86OpConst, stack[i + 2][1]);  puts2("");			
		}
		
		if (instr == X86InstrAdd){
			printf2("\tadd\tR0,R0,R10"); printf2(" ; add eax, const32"); puts2("");		
		}
		if (instr == X86InstrSub){
			printf2("\tsubslt\tR0,R0,R10"); puts2("");	printf2(" ; sub eax, const32"); puts2("");			
			printf2("\tand\tR0,R0,R0"); puts2("");		
		}
		if (instr == X86InstrAnd){
			printf2("\tand\tR0,R0,R10"); printf2(" ; and eax, const32"); puts2("");	
		}
		if (instr == X86InstrOr){
			printf2("\txor\tR12,R0,R10"); printf2(" ; or eax, const32"); puts2("");	
			printf2("\tand\tR15,R0,R10"); puts2("");	
			printf2("\txor\tR0,R12,R15"); puts2("");		
		}
		if (instr == X86InstrXor){
			printf2("\txor\tR0,R0,R10"); printf2(" ; xor eax, const32"); puts2("");
		}
		if (instr == X86InstrCmp){
			//printf2("\tnot\tR10,R10"); 
			printf2(" ; ************************ cmp eax, const32"); puts2("");
		}
		
          //GenPrintInstr2Operands(instr, 0,
           //                      X86OpRegAWord, 0,
           //                      X86OpConst, stack[i + 2][1]);
          break;
        case tokOpIdent:
          GenPrintInstr2Operands(instr, 0,
                                 X86OpRegAWord, 0,
                                 X86OpLabel, stack[i + 2][1]);
          break;
        case tokOpLocalOfs:
          GenPrintInstr2Operands(X86InstrLea, 0,
                                 X86OpRegCWord, 0,
                                 X86OpIndLocal, stack[i + 2][1]);
          GenPrintInstr2Operands(instr, 0,
                                 X86OpRegAWord, 0,
                                 X86OpRegCWord, 0);
          break;
        case tokOpAcc:
        case tokOpIndAcc:
          // right operand in cx already
       //   GenPrintInstr2Operands(instr, 0,
        //                         X86OpRegAWord, 0,
        //                         X86OpRegCWord, 0);
		//						 
		if (instr == X86InstrAdd){
			printf2("\tadd\tR0,R0,R2"); printf2(" ; add eax, ecx"); puts2("");		
		}
		else if (instr == X86InstrSub){
			printf2("\tsubslt\tR0,R0,R2"); puts2("");	printf2(" ; sub eax, ecx"); puts2("");			
			printf2("\tand\tR0,R0,R0"); puts2("");		
		}
		else if (instr == X86InstrAnd){
			printf2("\tand\tR0,R0,R2"); printf2(" ; and eax, ecx"); puts2("");	
		}
		else if (instr == X86InstrOr){
			printf2("\txor\tR12,R0,R2"); printf2(" ; or eax, ecx"); puts2("");	
			printf2("\tand\tR15,R0,R2"); puts2("");	
			printf2("\txor\tR0,R12,R15"); puts2("");				
		}
		else if (instr == X86InstrXor){
			printf2("\txor\tR0,R0,R2"); printf2(" ; xor eax, ecx"); puts2("");
		}

		else if (instr == X86InstrCmp){
			printf2("\tMOV\tR10,R2"); printf2(" ; emulated 'cmp' eax, ecx"); puts2("");		
		}	
		else 
			printf("ERROR 505");
			
          break;
        case tokOpIndIdent:
          if (v % 16 - 8 != SizeOfWord)
          {
            GenReadCRegIdent(v % 16 - 8, stack[i + 2][1]);
           // GenPrintInstr2Operands(instr, 0,
           //                        X86OpRegAWord, 0,
           //                        X86OpRegCWord, 0);
								   
				if (instr == X86InstrAdd){
					printf2("\tadd\tR0,R0,R2"); printf2(" ; add eax, const32"); puts2("");		
				}
				else if (instr == X86InstrSub){
					printf2("\tsubslt\tR0,R0,R2"); puts2("");	printf2(" ; sub eax, const32"); puts2("");			
					printf2("\tand\tR0,R0,R0"); puts2("");		
				}
				else if (instr == X86InstrAnd){
					printf2("\tand\tR0,R0,R2"); printf2(" ; and eax, const32"); puts2("");	
				}
				else if (instr == X86InstrOr){
					printf2("\txor\tR12,R0,R2"); printf2(" ; or eax, const32"); puts2("");	
					printf2("\tand\tR15,R0,R2"); puts2("");	
					printf2("\txor\tR0,R12,R15"); puts2("");		
				}
				else if (instr == X86InstrXor){
					printf2("\txor\tR0,R0,R2"); printf2(" ; xor eax, const32"); puts2("");
				}
				else if (instr == X86InstrCmp){
					printf2("\tMOV\tR10,R2"); printf2(" ; emulated 'cmp' eax, ecx"); puts2("");		
				}								   
				else 
					printf2("ERROR 606");
								   
								   
          }
          else
          {	

			printf2("\tldd\tR10,$"); GenPrintOperand(X86OpIndLabel, stack[i + 2][1]);  puts2("");
			printf2("\tadd\tR10,R10,R4");  puts2("");
			printf2("\tmovd\tR11,@R10");  puts2("");
			
			if (instr == X86InstrAdd){		  

				printf2("\tadd\tR0,R0,R11");  puts2("");
			}
			else if (instr == X86InstrSub){
				printf2("\tsubslt\tR0,R0,R11"); puts2("");	printf2(" ; sub eax, const32"); puts2("");			
				printf2("\tand\tR0,R0,R0"); puts2("");		
			}			
		  
			else if (instr == X86InstrAnd){
				printf2("\tand\tR0,R0,R11"); printf2(" ; and eax, const32"); puts2("");	
			}
			else if (instr == X86InstrOr){
				printf2("\txor\tR12,R0,R11"); printf2(" ; or eax, const32"); puts2("");	
				printf2("\tand\tR15,R0,R11"); puts2("");	
				printf2("\txor\tR0,R12,R15"); puts2("");		
			}
			else if (instr == X86InstrXor){
				printf2("\txor\tR0,R0,R11"); printf2(" ; xor eax, const32"); puts2("");
			}
			else if (instr == X86InstrCmp){
				printf2("\tMOV\tR10,R11"); printf2(" ; emulated 'cmp' eax, ecx"); puts2("");		
			}			  
			else 
				printf2("ERROR 607");
		//	if ((instr != X86InstrSub) && (instr != X86InstrAdd)) puts2("UNCLE BENIS!");	
			
          //  GenPrintInstr2Operands(instr, 0,
          //                         X86OpRegAWord, 0,
          //                         X86OpIndLabel, stack[i + 2][1]);
          }
          break;
        case tokOpIndLocalOfs:
          if (v % 16 - 8 != SizeOfWord)
          {
           // GenReadCRegLocal(v % 16 - 8, stack[i + 2][1]);
           // GenPrintInstr2Operands(instr, 0,
           //                        X86OpRegAWord, 0,
           //                        X86OpRegCWord, 0);
				printf2("\tldd\tR11,#"); GenPrintOperand(X86OpIndLocal, stack[i + 2][1]);  printf2(" ; inst eax,[ebp-ofs]"); puts2("");			
				printf2("\tadd\tR11,R11,R13"); puts2("");

				if((v % 16 - 8) == 1)	{ 
					printf2("\tmovb\tR2,@R11"); puts2("");
				}
				else if((v % 16 - 8) == 2)	{
					printf2("\tmovw\tR2,@R11"); puts2("");
				}
				else if((v % 16 - 8) == -1)	{
					printf2("\tmovb\tR2,@R11"); puts2("");
					printf2("\tbitsz\tR2,#7"); puts2("");
					printf2("\tadd\tR2,R2,R9"); printf2(" ; extend char sign bit if needed"); puts2("");		
				}	
				else if((v % 16 - 8) == -2)	{
					printf2("\tmovsw\tR2,@R11"); puts2("");
				}
				else
				{
					printf2("ERROR 608! %d", (v % 16 - 8)); puts2("");				
				}
				
				if (instr == X86InstrAdd){
					printf2("\tadd\tR0,R0,R2"); printf2(" ; add eax,[ebp-ofs]"); puts2("");		
				}
				else if (instr == X86InstrSub){
					printf2("\tsubslt\tR0,R0,R2"); puts2("");	printf2(" ; sub eax,[ebp-ofs]"); puts2("");			
					printf2("\tand\tR0,R0,R0"); puts2("");		
				}
				else if (instr == X86InstrAnd){
					printf2("\tand\tR0,R0,R2"); printf2(" ; and eax,[ebp-ofs]"); puts2("");	
				}
				else if (instr == X86InstrOr){
					printf2("\txor\tR12,R0,R2"); printf2(" ; or eax, [ebp-ofs]"); puts2("");	
					printf2("\tand\tR15,R0,R2"); puts2("");	
					printf2("\txor\tR0,R12,R15"); puts2("");				
				}
				else if (instr == X86InstrXor){
					printf2("\txor\tR0,R0,R2"); printf2(" ; xor eax, ecx"); puts2("");
				}
				else if (instr == X86InstrCmp){
					printf2("\tMOV\tR10,R2"); printf2(" ; emulated 'cmp' eax, ecx"); puts2("");		
				}		
				else
				{
					printf2("ERROR 609");
					GenPrintInstr2Operands(instr, 0, X86OpRegAWord, 0, X86OpIndLocal, stack[i + 2][1]); 
				}		   
		   
          }
          else
          {
           // GenPrintInstr2Operands(instr, 0,
           //                        X86OpRegAWord, 0,
           //                        X86OpIndLocal, stack[i + 2][1]); 
								   
				printf2("\tldd\tR11,#"); GenPrintOperand(X86OpIndLocal, stack[i + 2][1]);  printf2(" ; inst eax,[ebp-ofs]"); puts2("");			
				printf2("\tadd\tR11,R11,R13"); puts2("");
				printf2("\tmovd\tR10,@R11"); puts2("");
				if (instr == X86InstrAdd){
					printf2("\tadd\tR0,R0,R10"); printf2(" ; add eax,[ebp-ofs]"); puts2("");		
				}
				else if (instr == X86InstrSub){
					printf2("\tsubslt\tR0,R0,R10"); puts2("");	printf2(" ; sub eax,[ebp-ofs]"); puts2("");			
					printf2("\tand\tR0,R0,R0"); puts2("");		
				}
				else if (instr == X86InstrAnd){
					printf2("\tand\tR0,R0,R10"); printf2(" ; and eax,[ebp-ofs]"); puts2("");	
				}
				else if (instr == X86InstrOr){
					printf2("\txor\tR12,R0,R10"); printf2(" ; or eax, [ebp-ofs]"); puts2("");	
					printf2("\tand\tR15,R0,R10"); puts2("");	
					printf2("\txor\tR0,R12,R15"); puts2("");				
				}
				else if (instr == X86InstrXor){
					printf2("\txor\tR0,R0,R10"); printf2(" ; xor eax, ecx"); puts2("");
				}
				else
				{
					if (instr != X86InstrCmp) 
					{
						printf2("ERROR 610");
						GenPrintInstr2Operands(instr, 0, X86OpRegAWord, 0, X86OpIndLocal, stack[i + 2][1]); 
					}
				}
          }
          break;
        }

        if (i + 3 < sp && (stack[i + 3][0] == tokIf || stack[i + 3][0] == tokIfNot))
        {
          switch (tok)
          {
          case '<':
          case tokULess:
          case '>':
          case tokUGreater:
          case tokLEQ:
          case tokULEQ:
          case tokGEQ:
          case tokUGEQ:
          case tokEQ:
          case tokNEQ:
            if (stack[i + 3][0] == tokIf)
			{
				ptok = tok;

				puts2("\t; ** if_token found!");
			}
			else
			{
				switch (tok)
				{
				case '<':         ptok = tokGEQ; break;
				case tokULess:    ptok = tokUGEQ; break;
				case '>':         ptok = tokLEQ; break;
				case tokUGreater: ptok = tokULEQ; break;
				case tokLEQ:      ptok = '>'; break;
				case tokULEQ:     ptok = tokUGreater; break;
				case tokGEQ:      ptok = '<'; break;
				case tokUGEQ:     ptok = tokULess; break;
				case tokEQ:       ptok = tokNEQ; break;
				case tokNEQ:      ptok = tokEQ; break;
				}
				puts2("\t; ** if_!_token found!");					
			}


             // GenPrintInstr1Operand(X86InstrJcc, tok,
             //                       X86OpNumLabel, stack[i + 3][1]);
            //else
			//{
				if(ptok == '<' || ptok == tokULess)
				{
					if(ptok == tokULess)
					{
						printf2("\tXOR\tR12,R0,R10"); puts2("");
						printf2("\ttstsnz\tR12,R12"); puts2("");
						printf2("\tsjmp\tLC%d",cond_label); puts2("");	
						printf2("\tsubslt\tR12,R10,R0"); printf2(" ; jb	label"); puts2("");
						GenJumpUncond(stack[i + 3][1]); 						
						printf2("LC%d:",cond_label);  puts2("");	
						cond_label=cond_label+1;		

					}
					else
					{			
						printf2("\txor\tR12,R0,R10");  puts2("");
						printf2("\ttstsnz\tR12,R12"); printf2(" ; jne	label"); puts2("");	
						printf2("\tsjmp\tAC%d",continue_label); puts2("");	

						//printf2("\tXOR\tR12,R0,R10"); puts2("");
						printf2("\tBITSNZ\tR12,#31"); puts2("");
						printf2("\tsjmp\tLC%d",cond_label); puts2("");	
						printf2("\tBITSNZ\tR0,#31"); puts2("");						
						printf2("\tsjmp\tLC%d",cond_label+1); puts2("");	
						GenJumpUncond(stack[i + 3][1]);  // Condition = true
					printf2("LC%d:",cond_label);  puts2("");	
						printf2("\tsubslt\tR12,R10,R0"); printf2(" ; jl	label"); puts2("");
						GenJumpUncond(stack[i + 3][1]);  // Condition = true
					printf2("LC%d:",cond_label+1);  puts2("");
						cond_label=cond_label+2;
					}
					printf2("AC%d:",continue_label); continue_label += 1; puts2("");
				}
				
				if(ptok == '>' || ptok == tokUGreater)
				{
					if(ptok == tokUGreater)
					{
						printf2("\tXOR\tR12,R0,R10"); puts2("");
						printf2("\ttstsnz\tR12,R12"); puts2("");
						printf2("\tsjmp\tLC%d",cond_label); puts2("");	
						printf2("\tsubslt\tR12,R0,R10"); printf2(" ; ja	label"); puts2("");
						GenJumpUncond(stack[i + 3][1]); 						
						printf2("LC%d:",cond_label);  puts2("");	
						cond_label=cond_label+1;	
					}
					else
					{
						printf2("\txor\tR12,R0,R10");  puts2("");
						printf2("\ttstsnz\tR12,R12"); printf2(" ; jne	label"); puts2("");	
						printf2("\tsjmp\tAC%d",continue_label); puts2("");	
					
						//printf2("\tXOR\tR12,R0,R10"); puts2("");
						printf2("\tBITSNZ\tR12,#31"); puts2("");
						printf2("\tsjmp\tLC%d",cond_label); puts2("");	
						printf2("\tBITSNZ\tR10,#31"); puts2("");						
						printf2("\tsjmp\tLC%d",cond_label+1); puts2("");	
						GenJumpUncond(stack[i + 3][1]);  // Condition = true
					printf2("LC%d:",cond_label);  puts2("");	
						printf2("\tsubslt\tR12,R0,R10"); printf2(" ; jg	label"); puts2("");
						GenJumpUncond(stack[i + 3][1]);  // Condition = true
					printf2("LC%d:",cond_label+1);  puts2("");
						cond_label=cond_label+2;
					}	
					printf2("AC%d:",continue_label); continue_label += 1; puts2("");
				}
				
				if(ptok == tokNEQ)
				{
					printf2("\txor\tR12,R0,R10");  puts2("");
					printf2("\ttstsz\tR12,R12"); printf2(" ; jne	label"); puts2("");					
					GenJumpUncond(stack[i + 3][1]);  
				}	
				if(ptok == tokEQ)
				{
					printf2("\txor\tR12,R0,R10");  puts2("");
					printf2("\ttstsnz\tR12,R12"); printf2(" ; je	label"); puts2("");					
					GenJumpUncond(stack[i + 3][1]);  
				}	

				if(ptok == tokGEQ || ptok == tokUGEQ)	
				{

					if(ptok == tokUGEQ)
					{
						printf2("\txor\tR12,R0,R10");  puts2("");
						printf2("\ttstsnz\tR12,R12"); printf2(" ; jxx.."); puts2("");	
						GenJumpUncond(stack[i + 3][1]); 
						printf2("\tsubslt\tR12,R0,R10"); printf2(" ; jge	label"); puts2("");
						GenJumpUncond(stack[i + 3][1]);
					}
					else
					{
						printf2("\txor\tR12,R0,R10");  puts2("");
						printf2("\ttstsnz\tR12,R12"); puts2("");	
						GenJumpUncond(stack[i + 3][1]); 
						
						printf2("\tXOR\tR12,R0,R10"); puts2("");
						printf2("\tBITSNZ\tR12,#31"); puts2("");
						printf2("\tsjmp\tLC%d",cond_label); puts2("");	
						printf2("\tBITSNZ\tR10,#31"); puts2("");						
						printf2("\tsjmp\tLC%d",cond_label+1); puts2("");	
						GenJumpUncond(stack[i + 3][1]);  // Condition = true
					printf2("LC%d:",cond_label);  puts2("");	
						printf2("\tsubslt\tR12,R0,R10"); printf2(" ; jae	label"); puts2("");
						GenJumpUncond(stack[i + 3][1]);  // Condition = true
					printf2("LC%d:",cond_label+1);  puts2("");
						cond_label=cond_label+2;
					}	
					
					//printf2("AC%d:",continue_label); continue_label += 1; puts2("");	
					
				}
				
				if(ptok == tokLEQ || ptok == tokULEQ)	
				{

					if(ptok == tokULEQ) 
					{
						printf2("\txor\tR12,R0,R10");  puts2("");
						printf2("\ttstsnz\tR12,R12"); printf2(" ; jxx.."); puts2("");	
						GenJumpUncond(stack[i + 3][1]); 
						printf2("\tsubslt\tR12,R10,R0"); printf2(" ; jbe	label"); puts2("");
						GenJumpUncond(stack[i + 3][1]);  
					}
					else
					{		
						printf2("\txor\tR12,R0,R10");  puts2("");
						printf2("\ttstsnz\tR12,R12"); puts2("");	
						GenJumpUncond(stack[i + 3][1]); 
						
						printf2("\tXOR\tR12,R0,R10"); puts2("");
						printf2("\tBITSNZ\tR12,#31"); puts2("");
						printf2("\tsjmp\tLC%d",cond_label); puts2("");	
						printf2("\tBITSNZ\tR0,#31"); puts2("");						
						printf2("\tsjmp\tLC%d",cond_label+1); puts2("");	
						GenJumpUncond(stack[i + 3][1]);  // Condition = true
					printf2("LC%d:",cond_label);  puts2("");	
						printf2("\tsubslt\tR12,R10,R0"); printf2(" ; jle	label"); puts2("");
						GenJumpUncond(stack[i + 3][1]);  // Condition = true
					printf2("LC%d:",cond_label+1);  puts2("");
						cond_label=cond_label+2;
					}
				
					//printf2("AC%d:",continue_label); continue_label += 1; puts2("");	
					
				}
				
				
			//}
			//GenPrintInstr1Operand(X86InstrJNotCc, tok,
            //                        X86OpNumLabel, stack[i + 3][1]);

            break;
          }
        }
        else
        {
		
          switch (tok)
          {
          case '<':	;	 // ############# FIXME!! #############
					printf2("\tmov\tR12,R0");  printf2(" ; cmp   eax, const32 (continued)"); puts2("");
					printf2("\tldb\tR0,#1"); puts2("");		
					printf2("\tXOR\tR15,R12,R10"); puts2("");
					printf2("\tBITSNZ\tR15,#31"); puts2("");
					printf2("\tsjmp\tLC%d",cond_label); puts2("");	
					printf2("\tBITSNZ\tR10,#31"); puts2("");
					printf2("\tsjmp\tLC%d",cond_label+1); puts2("");	
					printf2("\tldb\tR0,#0"); puts2("");	
				printf2("LC%d:",cond_label);  puts2("");	
					printf2("\tsubslt\tR12,R12,R10"); printf2(" ; jae	label"); puts2("");
					printf2("\tldb\tR0,#0"); puts2("");	
				printf2("LC%d:",cond_label+1);  puts2("");
					cond_label=cond_label+2;
            break;	
          case tokULess:	
				printf2("\tmov\tR12,R0");  printf2(" ; cmp   eax, const32 (continued)"); puts2("");
				printf2("\tldb\tR0,#0"); puts2("");
				printf2("\tsubslt\tR12,R10,R12"); puts2("");
				printf2("\tldb\tR0,#1"); puts2("");	
				printf2("\ttstsnz\tR12,R12"); puts2("");		
				printf2("\tldb\tR0,#0"); puts2("");			
            break;
          case '>':
					printf2("\tmov\tR12,R0");  printf2(" ; cmp   eax, const32 (continued)"); puts2("");
					printf2("\tldb\tR0,#1"); puts2("");		
					printf2("\tXOR\tR15,R12,R10"); puts2("");
					printf2("\tBITSNZ\tR15,#31"); puts2("");
					printf2("\tsjmp\tLC%d",cond_label); puts2("");	
					printf2("\tBITSNZ\tR12,#31"); puts2("");
					printf2("\tsjmp\tLC%d",cond_label+1); puts2("");	
					printf2("\tldb\tR0,#0"); puts2("");	
				printf2("LC%d:",cond_label);  puts2("");	
					printf2("\tsubslt\tR12,R10,R12"); printf2(" ; jae	label"); puts2("");
					printf2("\tldb\tR0,#0"); puts2("");	
				printf2("LC%d:",cond_label+1);  puts2("");
					cond_label=cond_label+2;

				break;
          case tokUGreater:
				printf2("\tmov\tR12,R0");  printf2(" ; cmp   eax, const32 (continued)"); puts2("");
				printf2("\tldb\tR0,#0"); puts2("");
				printf2("\tsubslt\tR12,R12,R10"); puts2("");
				printf2("\tldb\tR0,#1"); puts2("");	
				printf2("\ttstsnz\tR12,R12"); puts2("");		
				printf2("\tldb\tR0,#0"); puts2("");	
            break;
          case tokLEQ: // ############# FIXME!! #############
					printf2("\tmov\tR12,R0");  printf2(" ; cmp   eax, const32 (continued)"); puts2("");
					printf2("\tldb\tR0,#1"); puts2("");		
					printf2("\tXOR\tR15,R12,R10"); puts2("");
					printf2("\tTSTSNZ\tR15,R15"); puts2(""); // Check if zero
					printf2("\tsjmp\tLC%d",cond_label+1); puts2("");	
					printf2("\tBITSNZ\tR15,#31"); puts2("");
					printf2("\tsjmp\tLC%d",cond_label); puts2("");	
					printf2("\tBITSNZ\tR10,#31"); puts2("");
					printf2("\tsjmp\tLC%d",cond_label+1); puts2("");	
					printf2("\tldb\tR0,#0"); puts2("");	
				printf2("LC%d:",cond_label);  puts2("");	
					printf2("\tsubslt\tR12,R12,R10"); printf2(" ; jae	label"); puts2("");
					printf2("\tldb\tR0,#0"); puts2("");	
				printf2("LC%d:",cond_label+1);  puts2("");
					cond_label=cond_label+2;		  
            break;
          case tokULEQ:
				printf2("\tmov\tR12,R0");  printf2(" ; cmp   eax, const32 (continued)"); puts2("");
				printf2("\tldb\tR0,#0"); puts2("");
				printf2("\tXOR\tR15,R12,R10"); puts2("");
				printf2("\tTSTSNZ\tR15,R15"); puts2(""); // Check if zero
				printf2("\tldb\tR0,#1"); puts2("");	
				printf2("\tsubslt\tR12,R10,R12"); puts2("");
				printf2("\tldb\tR0,#1"); puts2("");	
			break;
          case tokGEQ: // ############# FIXME!! #############
					printf2("\tmov\tR12,R0");  printf2(" ; cmp   eax, const32 (continued)"); puts2("");
					printf2("\tldb\tR0,#1"); puts2("");		
					printf2("\tXOR\tR15,R12,R10"); puts2("");
					printf2("\tTSTSNZ\tR15,R15"); puts2(""); // Check if zero
					printf2("\tsjmp\tLC%d",cond_label+1); puts2("");	
					printf2("\tBITSNZ\tR15,#31"); puts2("");
					printf2("\tsjmp\tLC%d",cond_label); puts2("");	
					printf2("\tBITSNZ\tR12,#31"); puts2("");
					printf2("\tsjmp\tLC%d",cond_label+1); puts2("");	
					printf2("\tldb\tR0,#0"); puts2("");	
				printf2("LC%d:",cond_label);  puts2("");	
					printf2("\tsubslt\tR12,R10,R12"); printf2(" ; jae	label"); puts2("");
					printf2("\tldb\tR0,#0"); puts2("");	
				printf2("LC%d:",cond_label+1);  puts2("");
					cond_label=cond_label+2;

            break;
          case tokUGEQ:
				printf2("\tmov\tR12,R0");  printf2(" ; cmp   eax, const32 (continued)"); puts2("");
				printf2("\tldb\tR0,#0"); puts2("");
				printf2("\tXOR\tR15,R12,R10"); puts2("");
				printf2("\tTSTSNZ\tR15,R15"); puts2(""); // Check if zero
				printf2("\tldb\tR0,#1"); puts2("");	
				printf2("\tsubslt\tR12,R12,R10"); puts2("");
				printf2("\tldb\tR0,#1"); puts2("");	
			break;
          case tokEQ:
			printf2("\txor\tR12,R0,R10"); puts2("");
			printf2("\tldb\tR0,#0"); puts2("");
			printf2("\ttstsnz\tR12,R12"); puts2("");		
			printf2("\tldb\tR0,#1"); puts2("");	
            break;
          case tokNEQ:
			printf2("\txor\tR12,R0,R10"); puts2("");
			printf2("\tldb\tR0,#0"); puts2("");
			printf2("\ttstsz\tR12,R12"); puts2("");		
			printf2("\tldb\tR0,#1"); puts2("");	
            break;
        //    GenPrintInstr1Operand(X86InstrSetCc, tok,
         //                         X86OpRegAByte, 0);
            if (SizeOfWord == 2)
              GenPrintInstrNoOperand(X86InstrCbw);
#ifdef CAN_COMPILE_32BIT
            else
       //       GenPrintInstr2Operands(X86InstrMovZx, 0,
       //                              X86OpRegAWord, 0,
       //                              X86OpRegAByte, 0);
	       puts2("");
#endif
            break;
          }
        }
        break;

      case '*':
      case tokAssignMul:
        instr = GenGetBinaryOperatorInstr(tok);

        switch (stack[i + 2][0])
        {
        case tokOpNumInt:
        case tokOpNumUint:
        //  GenPrintInstr3Operands(X86InstrImul, 0,
        //                         X86OpRegAWord, 0,
        //                         X86OpRegAWord, 0,
        //                         X86OpConst, stack[i + 2][1]); n
				printf2("\tldd\tR10,#"); GenPrintOperand(X86OpConst, stack[i + 2][1]);  puts2("");	
			 
				printf2("\tmul\tR0,R0,R10");  printf2(" ; mul	eax, 2"); puts2("");			
						 
								 
          break;
        case tokOpIdent:
          GenPrintInstr3Operands(X86InstrImul, 0,
                                 X86OpRegAWord, 0,
                                 X86OpRegAWord, 0,
                                 X86OpLabel, stack[i + 2][1]);
          break;
        case tokOpLocalOfs:
          GenPrintInstr2Operands(X86InstrLea, 0,
                                 X86OpRegCWord, 0,
                                 X86OpIndLocal, stack[i + 2][1]);
          GenPrintInstr1Operand(instr, 0,
                                X86OpRegCWord, 0);
          break;
        case tokOpAcc:
        case tokOpIndAcc:
		
		if (v % 16 - 8 != SizeOfWord)
          {
		
          // right operand in cx already
          //GenPrintInstr1Operand(instr, 0,
          //                      X86OpRegCWord, 0);
		  
			if(instr == X86InstrMul)
			{
				printf2("\tmul\tR0,R0,R2");  printf2(" ; mulu	ecx"); puts2(""); // ### TEMPORARY!! ###
			}
			else
			{
				GenPrintInstr1Operand(instr, 0,
                                  X86OpRegCWord, 0);	  
			}		  
		  		
		}
		else
		{
			printf2("\tmul\tR0,R0,R2");  printf2(" ; mulu	ecx"); puts2(""); // ### TEMPORARY!! ###
		}
		//	printf2("ERROR 612");

          break;
        case tokOpIndIdent:
          if (v % 16 - 8 != SizeOfWord)
          {
           // GenReadCRegIdent(v % 16 - 8, stack[i + 2][1]);
          //  GenPrintInstr1Operand(instr, 0,
          //                        X86OpRegCWord, 0);
			if(instr == X86InstrMul)
			{
				printf2("\tmul\tR0,R0,R2");  printf2(" ; mulu	ecx"); puts2(""); // ### TEMPORARY!! ###
			}
			else
			{
				GenPrintInstr1Operand(instr, 0,
                                  X86OpRegCWord, 0);	  
			}	
									  
          }
          else
          {
            GenPrintInstr1Operand(instr, 0,
                                  X86OpIndLabelExplicitWord, stack[i + 2][1]);
          }
          break;
        case tokOpIndLocalOfs:
          if (v % 16 - 8 != SizeOfWord)
          {
            GenReadCRegLocal(v % 16 - 8, stack[i + 2][1]);
			
			if(instr == X86InstrMul)
			{
				printf2("\tmul\tR0,R0,R2");  printf2(" ; mulu	ecx"); puts2(""); // ### TEMPORARY!! ###
			}
			else
			{
				GenPrintInstr1Operand(instr, 0,
                                  X86OpRegCWord, 0);	  
				printf2("ERROR 612");
								  }
          }
          else
          {
            GenPrintInstr1Operand(instr, 0,
                                  X86OpIndLocalExplicitWord, stack[i + 2][1]);
          }
          break;
        }
        break;

      case '/':
      case tokUDiv:
      case '%':
      case tokUMod:
      case tokAssignDiv:
      case tokAssignUDiv:
      case tokAssignMod:
      case tokAssignUMod:
        instr = GenGetBinaryOperatorInstr(tok);

        switch (tok)
        {
        case '/':
        case '%':
        case tokAssignDiv:
        case tokAssignMod:
       //   if (SizeOfWord == 2)
       //     GenPrintInstrNoOperand(X86InstrCwd);
#ifdef CAN_COMPILE_32BIT
       //   else
       //     GenPrintInstrNoOperand(X86InstrCdq);
#endif
          break;
        default:
      /*    GenPrintInstr2Operands(X86InstrMov, 0,
                                 X86OpRegDWord, 0,
                                 X86OpConst, 0);*/
          break;
        }

        switch (stack[i + 2][0])
        {
        case tokOpNumInt:
        case tokOpNumUint:
		
          /*GenPrintInstr2Operands(X86InstrMov, 0,
                                 X86OpRegCWord, 0,
                                 X86OpConst, stack[i + 2][1]);
		
          GenPrintInstr1Operand(instr, 0,
                                X86OpRegCWord, 0);*/
			if(instr == X86InstrDiv)
			{
				printf2("\tldd\tR2,#"); GenPrintOperand(X86OpConst, stack[i + 2][1]);  puts2("");					
				printf2("\tgetpc   R15,#3"); puts2("");
				printf2("\tmjmp\tDivide_U1616"); puts2("");	
			}
			else
			{
				puts2("ERROR 330");
			}
          break;
        case tokOpIdent:
          GenPrintInstr2Operands(X86InstrMov, 0,
                                 X86OpRegCWord, 0,
                                 X86OpLabel, stack[i + 2][1]);
          GenPrintInstr1Operand(instr, 0,
                                X86OpRegCWord, 0);
          break;
        case tokOpLocalOfs:
          GenPrintInstr2Operands(X86InstrLea, 0,
                                 X86OpRegCWord, 0,
                                 X86OpIndLocal, stack[i + 2][1]);
          GenPrintInstr1Operand(instr, 0,
                                X86OpRegCWord, 0);
          break;
        case tokOpAcc:
        case tokOpIndAcc:
          // right operand in cx already
          //GenPrintInstr1Operand(instr, 0,
          //                      X86OpRegCWord, 0);

		  if(instr == X86InstrIdiv)
		  {
				printf2("\tgetpc   R15,#3"); puts2("");
				printf2("\tMJMP\tDivide_U1616"); puts2("");			  
		  }
		  else
		  {
			puts2("ERROR 696");
		  }
          break;
        case tokOpIndIdent:
          if (v % 16 - 8 != SizeOfWord)
          {
            GenReadCRegIdent(v % 16 - 8, stack[i + 2][1]);
            GenPrintInstr1Operand(instr, 0,
                                  X86OpRegCWord, 0);
          }
          else
          {
            GenPrintInstr1Operand(instr, 0,
                                  X86OpIndLabelExplicitWord, stack[i + 2][1]);
          }
          break;
        case tokOpIndLocalOfs:
          if (v % 16 - 8 != SizeOfWord)
          {

			if(instr == X86InstrIdiv)
			{

				GenReadCRegLocal(v % 16 - 8, stack[i + 2][1]);	
				
				// TODO: *** Prepare signed values for use with an unsigned divide routine
				
				printf2("\tgetpc   R15,#3"); puts2("");
				printf2("\tmjmp\tDivide_U1616"); puts2("");	
			}
			else
			{
				puts2("ERROR 331");
			}			
			
			
			
            //GenPrintInstr1Operand(instr, 0,
            //                      X86OpRegCWord, 0);
          }
          else
          {
            GenPrintInstr1Operand(instr, 0,
                                  X86OpIndLocalExplicitWord, stack[i + 2][1]);
          }
        }

        if (tok == '%' || tok == tokAssignMod ||
            tok == tokUMod || tok == tokAssignUMod)
          GenPrintInstr2Operands(X86InstrMov, 0,
                                 X86OpRegAWord, 0,
                                 X86OpRegDWord, 0);
        break;

      case tokLShift:
      case tokRShift:
      case tokURShift:
      case tokAssignLSh:
      case tokAssignRSh:
      case tokAssignURSh:
        instr = GenGetBinaryOperatorInstr(tok);

        switch (stack[i + 2][0])
        {
        case tokOpNumInt:
        case tokOpNumUint:
         // GenPrintInstr2Operands(instr, 0,
         //                        X86OpRegAWord, 0,
         //                        X86OpConst, stack[i + 2][1]);
		 
		 for(temp = 0; temp < stack[i + 2][1]; temp++)
		 {
			if(tok == tokRShift || tok == tokAssignRSh)
			{
				printf2("\tasr\tR0,R0"); printf2(" ; sar eax, 1"); puts2("");
			} 
			if(tok == tokURShift || tok == tokAssignURSh)
			{
				printf2("\tlsr\tR0,R0"); printf2(" ; shr eax, 1"); puts2("");
			}
			if(tok == tokLShift || tok == tokAssignLSh)
			{
				printf2("\tadd\tR0,R0,R0"); printf2(" ; shl eax, 1"); puts2("");			
			}
	
		}
          break;
        case tokOpIdent:
          GenPrintInstr2Operands(instr, 0,
                                 X86OpRegAWord, 0,
                                 X86OpLabel, stack[i + 2][1]);
          break;
        case tokOpLocalOfs:
          GenPrintInstr2Operands(X86InstrLea, 0,
                                 X86OpRegCWord, 0,
                                 X86OpIndLocal, stack[i + 2][1]);
          GenPrintInstr2Operands(instr, 0,
                                 X86OpRegAWord, 0,
                                 X86OpRegCByte, 0);
          break;
        case tokOpAcc:
        case tokOpIndAcc:
          // right operand in cx already
          //GenPrintInstr2Operands(instr, 0,
          //                       X86OpRegAWord, 0,
          //                       X86OpRegCByte, 0);
		  
			printf2("LC%d:",cond_label);  puts2("");
			printf2("\ttstsnz\tR2,R2"); puts2(""); 		// is ecx = 0?
			printf2("\tsjmp\tLC%d",cond_label+1); puts2("");
			
			if(tok == tokRShift)
			{
				printf2("\tasr\tR0,R0"); printf2(" ; sar eax, 1"); puts2("");
			} 
			else if(tok == tokURShift)
			{
				printf2("\tlsr\tR0,R0"); printf2(" ; shr eax, 1"); puts2("");
			}
			else if(tok == tokLShift)
			{
				printf2("\tadd\tR0,R0,R0"); printf2(" ; shl eax, 1"); puts2("");			
			}	
			else
			{
				puts2("SHIFT ERROR!!");
			}
			printf2("\tincs\tR2,R2,#-1"); puts2(""); 	// decrement ecx	
			printf2("\tsjmp\tLC%d",cond_label); puts2("");	// Repeat variable shift op
			printf2("LC%d:",cond_label+1); cond_label=cond_label+2; puts2("");			  
		  
          break;
        case tokOpIndIdent:
         // GenPrintInstr2Operands(X86InstrMov, 0,
         //                        X86OpRegCByte, 0,
        //                         X86OpIndLabel, stack[i + 2][1]);
        //  GenPrintInstr2Operands(instr, 0,
        //                         X86OpRegAWord, 0,
        //                         X86OpRegCByte, 0);
        //  break;
        case tokOpIndLocalOfs:
		
			printf2("\tldd\tR11,#"); GenPrintOperand(X86OpIndLocal, stack[i + 2][1]);  printf2(" ; inst eax,[ebp-ofs]"); puts2("");			
			printf2("\tadd\tR11,R11,R13"); puts2("");
			printf2("\tmovb\tR2,@R11"); puts2("");	// Get variable shift value		
			printf2("LC%d:",cond_label);  puts2("");
			printf2("\ttstsnz\tR2,R2"); puts2(""); 		// is ecx = 0?
			printf2("\tsjmp\tLC%d",cond_label+1); puts2("");
			
			if(tok == tokRShift)
			{
				printf2("\tasr\tR0,R0"); printf2(" ; sar eax, 1"); puts2("");
			} 
			else if(tok == tokURShift)
			{
				printf2("\tlsr\tR0,R0"); printf2(" ; shr eax, 1"); puts2("");
			}
			else if(tok == tokLShift)
			{
				printf2("\tadd\tR0,R0,R0"); printf2(" ; shl eax, 1"); puts2("");			
			}	
			else
			{
				puts2("SHIFT ERROR!!");
			}
			printf2("\tincs\tR2,R2,#-1"); puts2(""); 	// decrement ecx	
			printf2("\tsjmp\tLC%d",cond_label); puts2("");	// Repeat variable shift op
			printf2("LC%d:",cond_label+1); cond_label=cond_label+2; puts2("");			
			
		
       //   GenPrintInstr2Operands(X86InstrMov, 0,
       //                          X86OpRegCByte, 0,
       //                          X86OpIndLocal, stack[i + 2][1]);
       //   GenPrintInstr2Operands(instr, 0,
       //                          X86OpRegAWord, 0,
       //                          X86OpRegCByte, 0);
          break;
        }
        break;

      case '=':
        break;

      default:
        //error("Error: Internal Error: GenExpr1() a: unexpected token %s\n", GetTokenName(tok));
        errorInternal(103);
        break;
      }

      // store ax into the left operand, if needed
      switch (tok)
      {
      case tokAssignRSh:
	  		printf2("\tasr\tR0,R0"); printf2(" ; sar eax, 1"); puts2("");
			goto next_case;
      case '=':
      case tokAssignAdd:
      case tokAssignSub:
      case tokAssignMul:
      case tokAssignDiv:
      case tokAssignUDiv:
      case tokAssignMod:
      case tokAssignUMod:
      case tokAssignLSh:
      case tokAssignURSh:
      case tokAssignAnd:
      case tokAssignXor:  
      case tokAssignOr:
next_case:
        switch (stack[i + 1][0])
        {
        case tokOpIndIdent:
       //   GenPrintInstr2Operands(X86InstrMov, 0,
       //                          X86OpIndLabel, stack[i + 1][1],
       //                          GenSelectByteOrWord(X86OpRegAByteOrWord, v / 16 - 8), 0);

		//  printf2("FUCK"); puts2("");	

			printf2("\tldd\tR10,$"); GenPrintOperand(X86OpIndLabel, stack[i + 1][1]); puts2("");
			printf2("\tadd\tR10,R10,R4"); puts2("");			
			
			if(((v / 16 - 8) == 4) || ((v / 16 - 8) == -4))
				{ printf2("\tmovd\t@R10,R0"); puts2(""); }										 
			if(((v / 16 - 8) == 2) || ((v / 16 - 8) == -2))
				{ printf2("\tmovw\t@R10,R0"); puts2(""); }
			if(((v / 16 - 8) == 1) || ((v / 16 - 8) == -1))
				{ printf2("\tmovb\t@R10,R0"); puts2(""); }
          break;
        case tokOpIndLocalOfs:
			printf2("\tldd\tR10,#"); GenPrintOperand(X86OpIndLocal, stack[i + 1][1]);  printf2(" ; mov	[ebp-ofs], eax"); puts2("");		
			printf2("\tadd\tR10,R10,R13"); puts2("");
			if(((v / 16 - 8) == 4) || ((v / 16 - 8) == -4))
				{ printf2("\tmovd\t@R10,R0"); puts2("");  }										 
			if(((v / 16 - 8) == 2) || ((v / 16 - 8) == -2))
				{ printf2("\tmovw\t@R10,R0"); puts2("");  }
			if(((v / 16 - 8) == 1) || ((v / 16 - 8) == -1))
				{ printf2("\tmovb\t@R10,R0"); puts2("");  }
			 
          // GenPrintInstr2Operands(X86InstrMov, 0,
          //                       X86OpIndLocal, stack[i + 1][1],
          //                       GenSelectByteOrWord(X86OpRegAByteOrWord, v / 16 - 8), 0);
          break;
        case tokOpIndAcc:
        case tokOpIndStack:
#ifdef CAN_COMPILE_32BIT
          GenRegB2Seg();
#endif
			
		if(((v / 16 - 8) == 4) || ((v / 16 - 8) == -4))	{ printf2("\tmovd\t@R1,R0"); puts2(""); }
		if(((v / 16 - 8) == 2) || ((v / 16 - 8) == -2))	{ printf2("\tmovw\t@R1,R0"); puts2(""); }
		if(((v / 16 - 8) == 1) || ((v / 16 - 8) == -1)) { printf2("\tmovb\t@R1,R0"); puts2(""); }

         // GenPrintInstr2Operands(X86InstrMov, 0,
         //                        X86OpIndRegB, 0,
         //                        GenSelectByteOrWord(X86OpRegAByteOrWord, v / 16 - 8), 0);
          break;
        }
        // the result of the expression is of type of the
        // left lvalue operand, so, "truncate" it if needed
        //GenExtendRegAIfNeeded(v / 16 - 8);
      }
      i += 2;
      break;

    case ')':
      // DONE: "call ident"
      if (stack[i - 1][0] == tokIdent)
      {
#ifdef CAN_COMPILE_32BIT
        if (OutputFormat == FormatSegHuge)
        {
          int lab = LabelCnt++;
          puts2("\tdb\t0x9A"); // call far seg:ofs
          printf2("section .relot\n\tdd\t"); GenPrintNumLabel(lab); puts2("");
          puts2(CodeHeader);
          GenNumLabel(lab);
          printf2("\tdd\t"); GenPrintLabel(IdentTable + stack[i - 1][1]); puts2("");
        }
        else // fallthrough
#endif
	printf2("\tincs	R14,R14,#-4"); printf2("; // Call *label"); puts2(""); 
	printf2("\tgetpc   R15,#4"); puts2("");
	printf2("\tmovd	@R14,R15"); puts2("");
	printf2("\tmjmp\t"); GenPrintOperand(X86OpLabel, stack[i - 1][1]); puts2("");
	
      //    GenPrintInstr1Operand(X86InstrCall, 0,
          //                      X86OpLabel, stack[i - 1][1]);
      }
      else
      {
#ifdef CAN_COMPILE_32BIT
        if (OutputFormat == FormatSegHuge)
        {
          int lab = (LabelCnt += 3) - 3;
          puts2("\tdb\t0x9A"); // call far seg:ofs (only to generate return address)
          printf2("section .relot\n\tdd\t"); GenPrintNumLabel(lab); puts2("");
          puts2(CodeHeader);
          GenNumLabel(lab);
          printf2("\tdd\t"); GenPrintNumLabel(lab + 1); puts2("");
          GenNumLabel(lab + 1);
          printf2("\tadd\tword [esp], "); GenPrintNumLabel(lab + 2); printf2(" - "); GenPrintNumLabel(lab + 1); puts2(""); // adjust return address
          puts2("\tshl\teax, 12\n\trol\tax, 4\n\tpush\teax\n\tretf");
          GenNumLabel(lab + 2);
        }
        else // fallthrough
#endif
		printf2("\tincs	R14,R14,#-4"); printf2("; // Call  eax"); puts2(""); 
		printf2("\tgetpc   R15,#3"); puts2("");
		printf2("\tmovd	@R14,R15"); puts2("");
		printf2("\tljmp\tR0"); puts2("");
	
      }
      if (v)
        GenLocalAlloc(-v);
      break;

    case '(':
    case tokIf:
    case tokIfNot:
      break;

    case tokVoid:
    case tokComma:
      break;

    default:
      //error("Error: Internal Error: GenExpr1() b: unexpected token %s\n", GetTokenName(tok));
      errorInternal(104);
      break;
    }
  }
}
#else // #ifndef CG_STACK_BASED
// Original, primitive stack-based code generator
// DONE: test 32-bit code generation
STATIC
void GenExpr0(void)
{
  int i;
  int gotUnary = 0;

  for (i = 0; i < sp; i++)
  {
    int tok = stack[i][0];
    int v = stack[i][1];

#ifndef NO_ANNOTATIONS
    switch (tok)
    {
    case tokNumInt: printf2("; %d\n", truncInt(v)); break;
    case tokNumUint: printf2("; %uu\n", truncUint(v)); break;
    case tokIdent: printf2("; %s\n", IdentTable + v); break;
    case tokLocalOfs: printf2("; local ofs\n"); break;
    case ')': printf2("; ) fxn call\n"); break;
    case tokUnaryStar: printf2("; * (read dereference)\n"); break;
    case '=': printf2("; = (write dereference)\n"); break;
    case tokShortCirc: printf2("; short-circuit "); break;
    case tokGoto: printf2("; sh-circ-goto "); break;
    case tokLogAnd: printf2("; short-circuit && target\n"); break;
    case tokLogOr: printf2("; short-circuit || target\n"); break;
    case tokIf: case tokIfNot: break;
    default: printf2("; %s\n", GetTokenName(tok)); break;
    }
#endif

    switch (tok)
    {
    case tokNumInt:
    case tokNumUint:
      if (gotUnary)
        GenPrintInstr1Operand(X86InstrPush, 0,
                              X86OpRegAWord, 0);
      GenPrintInstr2Operands(X86InstrMov, 0,
                             X86OpRegAWord, 0,
                             X86OpConst, v);
      gotUnary = 1;
      break;

    case tokIdent:
      if (gotUnary)
        GenPrintInstr1Operand(X86InstrPush, 0,
                              X86OpRegAWord, 0);
      GenPrintInstr2Operands(X86InstrMov, 0,
                             X86OpRegAWord, 0,
                             X86OpLabel, v);
      gotUnary = 1;
      break;

    case tokLocalOfs:
      if (gotUnary)
        GenPrintInstr1Operand(X86InstrPush, 0,
                              X86OpRegAWord, 0);
      GenPrintInstr2Operands(X86InstrLea, 0,
                             X86OpRegAWord, 0,
                             X86OpIndLocal, v);
      gotUnary = 1;
      break;

    case ')':
#ifdef CAN_COMPILE_32BIT
      if (OutputFormat == FormatSegHuge)
      {
        int lab = (LabelCnt += 3) - 3;
        puts2("\tdb\t0x9A"); // call far seg:ofs (only to generate return address)
        printf2("section .relot\n\tdd\t"); GenPrintNumLabel(lab); puts2("");
        puts2(CodeHeader);
        GenNumLabel(lab);
        printf2("\tdd\t"); GenPrintNumLabel(lab + 1); puts2("");
        GenNumLabel(lab + 1);
        printf2("\tadd\tword [esp], "); GenPrintNumLabel(lab + 2); printf2(" - "); GenPrintNumLabel(lab + 1); puts2(""); // adjust return address
        puts2("\tshl\teax, 12\n\trol\tax, 4\n\tpush\teax\n\tretf");
        GenNumLabel(lab + 2);
      }
      else // fallthrough
#endif
        GenPrintInstr1Operand(X86InstrCall, 0,
                              X86OpRegAWord, 0);
      if (v)
        GenLocalAlloc(-v);
      break;

    case tokUnaryStar:
      GenReadIndirect(v);
      break;

    case tokUnaryPlus:
      break;
    case '~':
		printf2("\tnot\tR0,R0");  printf2(" ; not	eax"); puts2(""); 
      break;
    case tokUnaryMinus:
		printf2("\tnot\tR0,R0");  printf2(" ; neg	eax"); puts2(""); 
		printf2("\tincs\tR0,R0,#1");  puts2(""); 
      //GenPrintInstr1Operand(X86InstrNeg, 0,
      //                      X86OpRegAWord, 0);
      break;

    case '+':
    case '-':
    case '*':
    case '&':
    case '^':
    case '|':
      {
        int instr = GenGetBinaryOperatorInstr(tok);
        GenPrintInstr1Operand(X86InstrPop, 0,
                              X86OpRegBWord, 0);
        if (tok == '-')
          GenPrintInstr2Operands(X86InstrXchg, 0,
                                 X86OpRegAWord, 0,
                                 X86OpRegBWord, 0);
        if (tok != '*')
          GenPrintInstr2Operands(instr, 0,
                                 X86OpRegAWord, 0,
                                 X86OpRegBWord, 0);
        else
          GenPrintInstr1Operand(instr, 0,
                                X86OpRegBWord, 0);
      }
      break;

    case '/':
    case tokUDiv:
    case '%':
    case tokUMod:
      GenPrintInstr1Operand(X86InstrPop, 0,
                            X86OpRegBWord, 0);
      GenPrintInstr2Operands(X86InstrXchg, 0,
                             X86OpRegAWord, 0,
                             X86OpRegBWord, 0);
      if (tok == '/' || tok == '%')
      {
        if (SizeOfWord == 2)
          GenPrintInstrNoOperand(X86InstrCwd);
#ifdef CAN_COMPILE_32BIT
        else
          GenPrintInstrNoOperand(X86InstrCdq);
#endif
        GenPrintInstr1Operand(X86InstrIdiv, 0,
                              X86OpRegBWord, 0);
      }
      else
      {
        GenPrintInstr2Operands(X86InstrMov, 0,
                               X86OpRegDWord, 0,
                               X86OpConst, 0);
        GenPrintInstr1Operand(X86InstrDiv, 0,
                              X86OpRegBWord, 0);
      }
      if (tok == '%' || tok == tokUMod)
        GenPrintInstr2Operands(X86InstrMov, 0,
                               X86OpRegAWord, 0,
                               X86OpRegDWord, 0);
      break;

    case tokLShift:
    case tokRShift:
    case tokURShift:
      {
        int instr = GenGetBinaryOperatorInstr(tok);
        GenPrintInstr1Operand(X86InstrPop, 0,
                              X86OpRegCWord, 0);
        GenPrintInstr2Operands(X86InstrXchg, 0,
                               X86OpRegAWord, 0,
                               X86OpRegCWord, 0);
        GenPrintInstr2Operands(instr, 0,
                               X86OpRegAWord, 0,
                               X86OpRegCByte, 0);
      }
      break;

    case tokInc:
      GenIncDecIndirect(v, tok);
      break;
    case tokDec:
      GenIncDecIndirect(v, tok);
      break;
    case tokPostInc:
      GenPostIncDecIndirect(v, tok);
      break;
    case tokPostDec:
      GenPostIncDecIndirect(v, tok);
      break;

    case tokPostAdd:
    case tokPostSub:
      {
        int instr = GenGetBinaryOperatorInstr(tok);
        GenPrintInstr1Operand(X86InstrPop, 0,
                              X86OpRegBWord, 0);
#ifdef CAN_COMPILE_32BIT
        GenRegB2Seg();
#endif
        GenPrintInstr2Operands(X86InstrMov, 0,
                               X86OpRegCWord, 0,
                               X86OpRegAWord, 0);
        GenPrintInstr2Operands(X86InstrMov, 0,
                               GenSelectByteOrWord(X86OpRegAByteOrWord, v), 0,
                               X86OpIndRegB, 0);
        GenPrintInstr2Operands(instr, 0,
                               X86OpIndRegB, 0,
                               GenSelectByteOrWord(X86OpRegCByteOrWord, v), 0);
        GenExtendRegAIfNeeded(v);
      }
      break;

    case tokAssignAdd:
    case tokAssignSub:
    case tokAssignMul:
    case tokAssignAnd:
    case tokAssignXor:
    case tokAssignOr:
      {
        int instr = GenGetBinaryOperatorInstr(tok);
        GenPrintInstr1Operand(X86InstrPop, 0,
                              X86OpRegBWord, 0);
#ifdef CAN_COMPILE_32BIT
        GenRegB2Seg();
#endif
        if (tok != tokAssignMul)
        {
          GenPrintInstr2Operands(instr, 0,
                                 X86OpIndRegB, 0,
                                 GenSelectByteOrWord(X86OpRegAByteOrWord, v), 0);
          GenPrintInstr2Operands(X86InstrMov, 0,
                                 GenSelectByteOrWord(X86OpRegAByteOrWord, v), 0,
                                 X86OpIndRegB, 0);
        }
        else
        {
          GenPrintInstr1Operand(instr, 0,
                                GenSelectByteOrWord(X86OpIndRegBExplicitByteOrWord, v), 0);
          GenPrintInstr2Operands(X86InstrMov, 0,
                                 X86OpIndRegB, 0,
                                 GenSelectByteOrWord(X86OpRegAByteOrWord, v), 0);
        }
        GenExtendRegAIfNeeded(v);
      }
      break;

    case tokAssignDiv:
    case tokAssignUDiv:
    case tokAssignMod:
    case tokAssignUMod:
      GenPrintInstr1Operand(X86InstrPop, 0,
                            X86OpRegBWord, 0);
#ifdef CAN_COMPILE_32BIT
      GenRegB2Seg();
#endif
      GenPrintInstr2Operands(X86InstrMov, 0,
                             X86OpRegCWord, 0,
                             X86OpRegAWord, 0);
      GenPrintInstr2Operands(X86InstrMov, 0,
                             GenSelectByteOrWord(X86OpRegAByteOrWord, v), 0,
                             X86OpIndRegB, 0);
      GenExtendRegAIfNeeded(v);
      if (tok == tokAssignDiv || tok == tokAssignMod)
      {
        if (SizeOfWord == 2)
          GenPrintInstrNoOperand(X86InstrCwd);
#ifdef CAN_COMPILE_32BIT
        else
          GenPrintInstrNoOperand(X86InstrCdq);
#endif
        GenPrintInstr1Operand(X86InstrIdiv, 0,
                              X86OpRegCWord, 0);
      }
      else
      {
        GenPrintInstr2Operands(X86InstrMov, 0,
                               X86OpRegDWord, 0,
                               X86OpConst, 0);
        GenPrintInstr1Operand(X86InstrDiv, 0,
                              X86OpRegCWord, 0);
      }
      if (tok == tokAssignMod || tok == tokAssignUMod)
        GenPrintInstr2Operands(X86InstrMov, 0,
                               X86OpRegAWord, 0,
                               X86OpRegDWord, 0);
      GenPrintInstr2Operands(X86InstrMov, 0,
                             X86OpIndRegB, 0,
                             GenSelectByteOrWord(X86OpRegAByteOrWord, v), 0);
      GenExtendRegAIfNeeded(v);
      break;

    case tokAssignLSh:
    case tokAssignRSh:
    case tokAssignURSh:
      {
        int instr = GenGetBinaryOperatorInstr(tok);
        GenPrintInstr1Operand(X86InstrPop, 0,
                              X86OpRegBWord, 0);
#ifdef CAN_COMPILE_32BIT
        GenRegB2Seg();
#endif
        GenPrintInstr2Operands(X86InstrMov, 0,
                               X86OpRegCWord, 0,
                               X86OpRegAWord, 0);
        GenPrintInstr2Operands(instr, 0,
                               GenSelectByteOrWord(X86OpIndRegBExplicitByteOrWord, v), 0,
                               X86OpRegCByte, 0);
        GenPrintInstr2Operands(X86InstrMov, 0,
                               GenSelectByteOrWord(X86OpRegAByteOrWord, v), 0,
                               X86OpIndRegB, 0);
        GenExtendRegAIfNeeded(v);
      }
      break;

    case '=':
      GenPrintInstr1Operand(X86InstrPop, 0,
                            X86OpRegBWord, 0);
#ifdef CAN_COMPILE_32BIT
      GenRegB2Seg();
#endif
      GenPrintInstr2Operands(X86InstrMov, 0,
                             X86OpIndRegB, 0,
                             GenSelectByteOrWord(X86OpRegAByteOrWord, v), 0);
      GenExtendRegAIfNeeded(v);
      break;

    case '<':
    case tokULess:
    case '>':
    case tokUGreater:
    case tokLEQ:
    case tokULEQ:
    case tokGEQ:
    case tokUGEQ:
    case tokEQ:
    case tokNEQ:
      GenPrintInstr1Operand(X86InstrPop, 0,
                            X86OpRegBWord, 0);
      GenPrintInstr2Operands(X86InstrCmp, 0,
                             X86OpRegBWord, 0,
                             X86OpRegAWord, 0);
      GenPrintInstr1Operand(X86InstrSetCc, tok,
                            X86OpRegAByte, 0);
      if (SizeOfWord == 2)
        GenPrintInstrNoOperand(X86InstrCbw);
#ifdef CAN_COMPILE_32BIT
      else
        GenPrintInstr2Operands(X86InstrMovZx, 0,
                               X86OpRegAWord, 0,
                               X86OpRegAByte, 0);
#endif
      break;

    case tok_Bool:
      GenPrintInstr2Operands(X86InstrTest, 0,
                             X86OpRegAWord, 0,
                             X86OpRegAWord, 0);
      GenPrintInstr1Operand(X86InstrSetCc, tokNEQ,
                            X86OpRegAByte, 0);
      // fallthrough
    case tokSChar:
      if (SizeOfWord == 2)
        GenPrintInstrNoOperand(X86InstrCbw);
#ifdef CAN_COMPILE_32BIT
      else
       // GenPrintInstr2Operands(X86InstrMovSx, 0,
       //                        X86OpRegAWord, 0,
       //                        X86OpRegAByte, 0);
#endif
      break;
    case tokUChar:
      GenPrintInstr2Operands(X86InstrAnd, 0,
                             X86OpRegAWord, 0,
                             X86OpConst, 0xFF);
      break;

    case tokShortCirc:
#ifndef NO_ANNOTATIONS
      if (v >= 0)
        printf2("&&\n");
      else
        printf2("||\n");
#endif
      if (v >= 0)
        GenJumpIfZero(v); // &&
      else
        GenJumpIfNotZero(-v); // ||
      gotUnary = 0;
      break;
    case tokGoto:
#ifndef NO_ANNOTATIONS
      printf2("goto\n");
#endif
      GenJumpUncond(v);
      gotUnary = 0;
      break;
    case tokLogAnd:
    case tokLogOr:
      GenNumLabel(v);
      break;

    case tokVoid:
      gotUnary = 0;
      break;

    case tokComma:
    case ',':
    case '(':
      break;

    case tokIf:
      GenJumpIfNotZero(stack[i][1]);
      break;
    case tokIfNot:
      GenJumpIfZero(stack[i][1]);
      break;

    default:
      //error("Error: Internal Error: GenExpr0(): unexpected token %s\n", GetTokenName(tok));
      errorInternal(105);
      break;
    }
  }
}
#endif // #ifndef CG_STACK_BASED

STATIC
unsigned GenStrData(int generatingCode, unsigned requiredLen)
{
  int i;
  unsigned total = 0;

  // insert string literals into the code
  for (i = 0; i < sp; i++)
  {
    int tok = stack[i][0];
    char* p = IdentTable + stack[i][1];
    if (tok == tokIdent && isdigit(*p))
    {
      int label = atoi(p);
      int quot = 0;
      unsigned len;

      p = FindString(label);
      len = *p++ & 0xFF;

      // If this is a string literal initializing an array of char,
      // truncate or pad it as necessary.
      if (requiredLen)
      {
        if (len >= requiredLen)
        {
          len = requiredLen; // copy count
          requiredLen = 0; // count to be zeroed out
        }
        else
        {
          requiredLen -= len; // count to be zeroed out
        }
      }
      // Also, calculate its real size for incompletely typed arrays.
      total = len + requiredLen;

      if (generatingCode)
      {
        if (OutputFormat == FormatFlat)
        {
          GenJumpUncond(label + 1);
        }
        else
        {
          puts2(CodeFooter);
          puts2(DataHeader);
        }
      }

      GenNumLabel(label);

	  
      while (len--)
      {
        // quote ASCII chars for better readability
		if(*p >= 0x20 && *p <= 0x7E && *p != '\"' && quot == 0) 
		{
			GenStartAsciiString();
            quot = 1;
            printf2("\"");
		}
		
        if(*p >= 0x20 && *p <= 0x7E && *p != '\"' &&  quot == 1)
        {
          printf2("%c", *p);
        }
		
		if(*p < 0x20 || *p > 0x7E)
		{
			if(quot == 1)
			{
	            quot = 0;
				printf2("\"");
			}
				
			printf2("\n\tdb\t%u\n", *p & 0xFF);	

        }
        p++;
      }
	  
	  if(quot == 1)
			{
	            quot = 0;
				printf2("\"");
			}
      printf2("\n\tdb\t0\n\talign\t2\n");  // End-of-string data
      
	  if (quot)
      {
        printf2("\"");
        if (requiredLen)
          printf2(",");
      }
      while (requiredLen)
      {
        printf2("0");
        if (--requiredLen)
          printf2(",");
      }
      puts2("");

      if (generatingCode)
      {
        if (OutputFormat == FormatFlat)
        {
          GenNumLabel(label + 1);
        }
        else
        {
          puts2(DataFooter);
          puts2(CodeHeader);
        }
      }
    }
  }

  return total;
}

STATIC
void GenExpr(void)
{
  if (OutputFormat != FormatFlat && GenExterns)
  {
    int i;
    for (i = 0; i < sp; i++)
      if (stack[i][0] == tokIdent && !isdigit(IdentTable[stack[i][1]]))
        GenAddGlobal(IdentTable + stack[i][1], 2);
  }
  GenStrData(1, 0);
#ifndef CG_STACK_BASED
  GenExpr1();
#else
  GenExpr0();
#endif
}

STATIC
void GenFin(void)
{
  if (StructCpyLabel)
  {
    char s[1 + 2 + (2 + CHAR_BIT * sizeof StructCpyLabel) / 3];
    char *p = s + sizeof s;

    *--p = '\0';
    p = lab2str(p, StructCpyLabel);
    *--p = '_';
    *--p = '_';

    if (OutputFormat != FormatFlat)
      puts2(CodeHeader);

    GenLabel(p, 1);
    GenFxnProlog();

    if (SizeOfWord == 2)
    {
      puts2("\tmov\tdi, [bp+8]\n"
            "\tmov\tsi, [bp+6]\n"
            "\tmov\tcx, [bp+4]\n"
            "\tcld\n"
            "\trep\tmovsb\n"
            "\tmov\tax, [bp+8]");
    }
#ifdef CAN_COMPILE_32BIT
    else if (OutputFormat != FormatSegHuge)
    {
	
	
		printf2("\tldb\tR12,#16"); printf2(" ; mov edi, [ebp+16]"); puts2("");
		printf2("\tadd\tR15,R13,R12"); puts2(""); 
		printf2("\tmovd\tR11,@R15"); puts2("");  

		printf2("\tincs\tR15,R15,#-4"); printf2(" ; mov esi, [ebp+12]"); puts2("");
		printf2("\tmovd\tR10,@R15"); puts2(""); 

		printf2("\tincs\tR15,R15,#-4"); printf2(" ; mov ecx, [ebp+8]"); puts2("");
		printf2("\tmovd\tR2,@R15"); puts2(""); 

		printf2("LC%d:",cond_label);  puts2("");    // Outer MOVSP loop

		printf2("\ttstsnz\tR2,R2"); puts2(""); 				// is ecx = 0?
		printf2("\tsjmp\tLC%d",cond_label+1); puts2("");	// Exit loop if yes

		printf2("\tmovb\tR15,@R10"); printf2(" ; cld, rep movsb"); puts2(""); // Move byte from @esi->@edi
		printf2("\tmovb\t@R11,R15"); puts2("");	
		printf2("\tincs\tR10,R10,#1"); puts2(""); 	// increment esi
		printf2("\tincs\tR11,R11,#1"); puts2("");	// increment edi
		printf2("\tincs\tR2,R2,#-1"); puts2(""); 	// decrement ecx
		printf2("\tsjmp\tLC%d",cond_label); puts2("");	// attempt to move another byte..

		printf2("LC%d:",cond_label+1); cond_label=cond_label+2; puts2(""); // All done! :-)

		printf2("ldb\tR12,#16");  printf2(" ; mov eax, [ebp+16]"); puts2("");
		printf2("add\tR15,R13,R12"); puts2("");
		printf2("movd\tR0,@R15"); puts2("");	

	
	
 /*     puts2("\tmov\tedi, [ebp+16]\n"
            "\tmov\tesi, [ebp+12]\n"
            "\tmov\tecx, [ebp+8]\n"
            "\tcld\n"
            "\trep\tmovsb\n"
            "\tmov\teax, [ebp+16]");*/
    }
    else
    {
      int lbl = (LabelCnt += 2) - 2;

      puts2("\tmov\tedi, [ebp+16]\n"
            "\tror\tedi, 4\n"
            "\tmov\tes, di\n"
            "\tshr\tedi, 28\n"
            "\tmov\tesi, [ebp+12]\n"
            "\tror\tesi, 4\n"
            "\tmov\tds, si\n"
            "\tshr\tesi, 28");
      puts2("\tmov\tebx, [ebp+8]\n"
            "\tcld");

      GenNumLabel(lbl); // L1:

      puts2("\tmov\tecx, 32768\n"
            "\tcmp\tebx, ecx");

      printf2("\tjc\t"); GenPrintNumLabel(lbl + 1); // jc L2

      puts2("\n"
            "\tsub\tebx, ecx\n"
            "\trep\tmovsb\n"
            "\tand\tdi, 15\n"
            "\tmov\tax, es\n"
            "\tadd\tax, 2048\n"
            "\tmov\tes, ax\n"
            "\tand\tsi, 15\n"
            "\tmov\tax, ds\n"
            "\tadd\tax, 2048\n"
            "\tmov\tds, ax");

      printf2("\tjmp\t"); GenPrintNumLabel(lbl); // jmp L1
      puts2("");

      GenNumLabel(lbl + 1); // L2:

      puts2("\tmov\tcx, bx\n"
            "\trep\tmovsb\n"
            "\tmov\teax, [ebp+16]");
    }
#endif

    GenFxnEpilog();

    if (OutputFormat != FormatFlat)
      puts2(CodeFooter);
  }

#ifdef USE_SWITCH_TAB
  if (SwitchJmpLabel)
  {
    char s[1 + 2 + (2 + CHAR_BIT * sizeof SwitchJmpLabel) / 3];
    char *p = s + sizeof s;

    *--p = '\0';
    p = lab2str(p, SwitchJmpLabel);
    *--p = '_';
    *--p = '_';

    if (OutputFormat != FormatFlat)
      puts2(CodeHeader);

    GenLabel(p, 1);
    GenFxnProlog();

    if (SizeOfWord == 2)
    {
      int lbl = (LabelCnt += 3) - 3;
      puts2("\tmov\tbx, [bp + 4]\n"
            "\tmov\tsi, [bx + 2]\n"
            "\tmov\tcx, [bx]");
      printf2("\tjcxz\t"); GenPrintNumLabel(lbl + 2); // jcxz L3
      puts2("\n\tmov\tax, [bp + 6]");
      GenNumLabel(lbl); // L1:
      puts2("\tadd\tbx, 4\n"
            "\tcmp\tax, [bx]");
      printf2("\tjne\t"); GenPrintNumLabel(lbl + 1); // jne L2
      puts2("\n\tmov\tsi, [bx + 2]");
      printf2("\tjmp\t"); GenPrintNumLabel(lbl + 2); // jmp L3
      puts2("");
      GenNumLabel(lbl + 1); // L2:
      printf2("\tloop\t"); GenPrintNumLabel(lbl); // loop L1
      puts2("");
      GenNumLabel(lbl + 2); // L3:
      puts2("\tmov\t[bp + 2], si\n"
            "\tleave\n"
            "\tret\t4");
    }
#ifdef CAN_COMPILE_32BIT
    else if (OutputFormat != FormatSegHuge)
    {
      int lbl = (LabelCnt += 3) - 3;
      puts2("\tmov\tebx, [ebp + 8]\n"
            "\tmov\tesi, [ebx + 4]\n"
            "\tmov\tecx, [ebx]");
      printf2("\tjecxz\t"); GenPrintNumLabel(lbl + 2); // jecxz L3
      puts2("\n\tmov\teax, [ebp + 12]");
      GenNumLabel(lbl); // L1:
      puts2("\tadd\tebx, 8\n"
            "\tcmp\teax, [ebx]");
      printf2("\tjne\t"); GenPrintNumLabel(lbl + 1); // jne L2
      puts2("\n\tmov\tesi, [ebx + 4]");
      printf2("\tjmp\t"); GenPrintNumLabel(lbl + 2); // jmp L3
      puts2("");
      GenNumLabel(lbl + 1); // L2:
      printf2("\tloop\t"); GenPrintNumLabel(lbl); // loop L1
      puts2("");
      GenNumLabel(lbl + 2); // L3:
      puts2("\tmov\t[ebp + 4], esi\n"
            "\tleave\n"
            "\tret\t8");
    }
    else
    {
      int lbl = (LabelCnt += 3) - 3;
      puts2("\tmov\tebx, [bp + 8]\n"
            "\tror\tebx, 4\n"
            "\tmov\tds, ebx\n"
            "\tshr\tebx, 28\n"
            "\tmov\tsi, [bx + 4]\n"
            "\tmov\tcx, [bx]"); // use only 16 bits of case counter
      printf2("\tjcxz\t"); GenPrintNumLabel(lbl + 2); // jcxz L3
      puts2("\n\tmov\teax, [bp + 12]");
      GenNumLabel(lbl); // L1:
      // No segment reload inside the loop, hence the number of cases is limited to ~8190
      puts2("\tadd\tbx, 8\n"
            "\tcmp\teax, [bx]");
      printf2("\tjne\t"); GenPrintNumLabel(lbl + 1); // jne L2
      puts2("\n\tmov\tsi, [bx + 4]");
      printf2("\tjmp\t"); GenPrintNumLabel(lbl + 2); // jmp L3
      puts2("");
      GenNumLabel(lbl + 1); // L2:
      printf2("\tloop\t"); GenPrintNumLabel(lbl); // loop L1
      puts2("");
      GenNumLabel(lbl + 2); // L3:
      // Preserve CS on return
      puts2("\tmov\tax, [bp + 6]\n"
            "\tshl\tax, 4\n"
            "\tsub\tsi, ax\n"
            "\tmov\t[bp + 4], si\n"
            "\tdb\t0x66\n"
            "\tleave\n"
            "\tretf\t8");
    }
#endif

    // Not using GenFxnEpilog() here because we need to remove the parameters
    // from the stack
//    GenFxnEpilog();

    if (OutputFormat != FormatFlat)
      puts2(CodeFooter);
  }
#endif

#ifdef CAN_COMPILE_32BIT
  if (WinChkStkLabel)
  {
    // When targeting Windows, simulate _chkstk() to
    // correctly grow the stack page by page by probing it
    char s[1 + 2 + (2 + CHAR_BIT * sizeof WinChkStkLabel) / 3];
    char *p = s + sizeof s;
    int lbl = LabelCnt++;

    *--p = '\0';
    p = lab2str(p, WinChkStkLabel);
    *--p = '_';
    *--p = '_';

    if (OutputFormat != FormatFlat)
      puts2(CodeHeader);

    GenLabel(p, 1);
    puts2("\tlea\tebx, [esp+4]\n"
          "\tmov\tecx, ebx\n"
          "\tsub\tecx, eax\n"
          "\tand\tebx, -4096\n"
          "\tand\tecx, -4096");
    GenNumLabel(lbl); // L1:
    puts2("\tsub\tebx, 4096\n"
          "\tmov\tal, [ebx]\n"
          "\tcmp\tebx, ecx");
    printf2("\tjne\t"); GenPrintNumLabel(lbl); // jne L1
    puts2("\n\tret");

    if (OutputFormat != FormatFlat)
      puts2(CodeFooter);
  }
#endif

  if (OutputFormat != FormatFlat && GenExterns)
  {
    int i = 0;

    puts2("");
    while (i < GlobalsTableLen)
    {
      if (GlobalsTable[i] == 2)
      {
        printf2("\textern\t");
        GenPrintLabel(GlobalsTable + i + 2);
        puts2("");
      }
      i += GlobalsTable[i + 1] + 2;
    }
  }
}