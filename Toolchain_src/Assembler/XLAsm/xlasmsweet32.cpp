// xlasmsweet32.cpp

#include <assert.h>
#include <algorithm>

#include "xlasm.h"
#include "xlasmexpr.h"
#include "xlasmsweet32.h"

const sweet32::variant_t sweet32::variant_list[] =
{
//		name, 			id,			  				bits		BE		Flags
	{	"Sweet32-BE",	SWEET32_BE,		32,			true,		0		},
	{	"Sweet32-LE",	SWEET32_LE,		32,			false,		0		},
	{	"", 0, 0, false, 0		}
};

// --------------------------------------------------------
// opcode				mnemonic				len cyc	
// -------------------	---------------------	--- ---	
// 0000 yyyy zzzz xxxx	AND		Rz,Ry,Rx		1	1	
// 0001 yyyy zzzz xxxx	ADD		Rz,Ry,Rx		1	1	
// 0010 yyyy zzzz xxxx	XOR		Rz,Ry,Rx		1	1	
// 0011 yyyy 0000 xxxx	TSTSNZ	Rx,Ry			1	1	
// 0011 yyyy 0100 xxxx	TSTSZ	Rx,Ry			1	1	
// 0011 yyyy 100i iiii	BITSNZ	Rx,#uimm5		1	1	
// 0011 yyyy 110i iiii	BITSZ	Rx,#uimm5		1	1	
// 0100 yyyy zzzz xxxx	SUBSLT	Rz,Rx,Ry		1	1	
// 0101 yyyy zzzz xxxx	MUL		Rz,Ry,Rx		1	1	
// 0110 rrrr rrrr rrrr	SJMP	#srel12			1	1	
// 0111 iiii zzzz iiii	LDB		Rz,#uimm8		1	1	
// 1000 rrrr rrrr rrrr+ MJMP	#srel28			2	2	
// 1001 iiii zzzz iiii	GETPC	Rz,#simm8		1	1	
// 1010 yyyy zzzz iiii	INCS	Rz,Rx,#simm4	1	1	
// 1011 0000 zzzz 0000+ LDW		Rz,#uimm16		2	3	
// 1011 0001 zzzz 0000+ LDD		Rz,#simm32		3	4	
// 1011 0010 zzzz xxxx	SETIV	Rx				1	1	
// 1011 0011 zzzz xxxx	RETI					1	1	
// 1011 0100 zzzz xxxx	SETCW	Rx				1	1	
// 1011 0101 zzzz xxxx	RETT					1	1	
// 1011 0110 zzzz xxxx	GETXR	Rz				1	1	
// 1011 0111 zzzz xxxx	GETTR	Rz				1	1	
// 1100 0000 zzzz xxxx	SWAPB	Rz,Rx			1	1	
// 1100 0001 zzzz xxxx	SWAPW	Rz,Rx			1	1	
// 1100 0010 zzzz xxxx	NOT		Rz,Rx			1	1	
// 1100 0011 zzzz xxxx	LJMP	Rx				1	1	
// 1101 0000 zzzz xxxx	LSR		Rz,Rx			1	1	
// 1101 0001 zzzz xxxx	ASR		Rz,Rx			1	1	
// 1110 yyyy 0000 xxxx	MOVW	[Rx],Ry			1	3	
// 1110 yyyy 0001 xxxx	MOVD	[Rx],Ry			1	4	
// 1110 yyyy 0010 xxxx	MOVB	[Rx],Ry		 	1	4
// 1111 0000 zzzz xxxx	MOVW	Rz,[Rx]			1	4	
// 1111 0001 zzzz xxxx	MOVD	Rz,[Rx]			1	5	
// 1111 0010 zzzz xxxx	MOVSW	Rz,[Rx]			1	4	
// 1111 0011 zzzz xxxx	MOVB	Rz,[Rx]			1	4

const sweet32::op_tbl	sweet32::ops[sweet32::num_ops] =
{
	{ OP_NOP,		0x0000,	0xffff,	"NOP",		{ N, N,	N },	1, 0, 1	},
	{ OP_AND,		0x0000, 0xf000, "AND",		{ Z, Y, X },	1, 0, 1 },
	{ OP_ADD,		0x1000, 0xf000, "ADD",		{ Z, Y, X },	1, 0, 1 },
	{ OP_LSL,		0x1000, 0xf000, "LSL",		{ Z, Y, N },	1, 0, 1 },	// alias for add rd,ra,ra
	{ OP_ASL,		0x1000,	0xf000,	"ASL",		{ Z, Y,	N },	1, 0, 1	},	// alias for add rd,ra,ra
	{ OP_XOR,		0x2000, 0xf000, "XOR",		{ Z, Y, X },	1, 0, 1 },
	{ OP_TSTSNZ,	0x3000, 0xf0f0, "TSTSNZ",	{ Y, X, N },	1, 1, 1 },
	{ OP_TSTSZ,		0x3040, 0xf0f0, "TSTSZ",	{ Y, X, N },	1, 1, 1 },
	{ OP_BITSNZ,	0x3080, 0xf0e0, "BITSNZ",	{ Y, I5, N },	1, 1, 1 },
	{ OP_BITSZ,		0x30C0, 0xf0e0, "BITSZ",	{ Y, I5, N },	1, 1, 1 },
	{ OP_SUBSLT,	0x4000, 0xf000, "SUBSLT",	{ Z, X, Y },	1, 1, 1 },
	{ OP_MUL,		0x5000, 0xf000, "MUL",		{ Z, Y, X },	1, 0, 1 },
	{ OP_SJMP,		0x6000, 0xf000, "SJMP",		{ R12, N, N },	1, 0, 1 },
	{ OP_LDB,		0x7000, 0xf000, "LDB",		{ Z, I8, N },	1, 0, 1 },
	{ OP_MJMP,		0x8000, 0xf000, "MJMP",		{ R28, N, N },	2, 0, 2 },
	{ OP_GETPC,		0x9000, 0xf000, "GETPC",	{ Z, R8, N },	1, 0, 1 },
	{ OP_MOV,		0xa000, 0xf00f, "MOV",		{ Z, Y, N },	1, 0, 1 },
	{ OP_INCS,		0xa000, 0xf000, "INCS",		{ Z, Y, I4 },	1, 0, 1 },
	{ OP_LDW,		0xb000, 0xff0f, "LDW",		{ Z, I16, N },	2, 0, 3 },
	{ OP_LDD,		0xb100, 0xff0f, "LDD",		{ Z, I32, N },	3, 0, 4 },
	{ OP_SETIV,		0xb200, 0xfff0, "SETIV",	{ X, N, N },	1, 0, 1 },
	{ OP_RETI,		0xb300, 0xffff, "RETI",		{ N, N, N },	1, 0, 1 },
	{ OP_SETCW,		0xb400, 0xfff0, "SETCW",	{ X, N, N },	1, 0, 1 },
	{ OP_RETT,		0xb500, 0xffff, "RETT",		{ N, N, N },	1, 0, 1 },
	{ OP_GETXR,		0xb600, 0xff0f, "GETXR",	{ Z, N, N },	1, 0, 1 },
	{ OP_GETTR,		0xb700, 0xff0f, "GETTR",	{ Z, N, N },	1, 0, 1 },
	{ OP_SWAPB,		0xc000, 0xff00, "SWAPB",	{ Z, X, N },	1, 0, 1 },
	{ OP_SWAPW,		0xc100, 0xff00, "SWAPW",	{ Z, X, N },	1, 0, 1 },
	{ OP_NOT,		0xc200, 0xff00, "NOT",		{ Z, X, N },	1, 0, 1 },
	{ OP_LJMP,		0xc300, 0xfff0, "LJMP",		{ X, N, N },	1, 0, 1 },
	{ OP_LSR,		0xd000, 0xff00, "LSR",		{ Z, X, N },	1, 0, 1 },
	{ OP_ASR,		0xd100, 0xff00, "ASR",		{ Z, X, N },	1, 0, 1 },
	{ OP_MOVW_LD,	0xe000, 0xf0f0, "MOVW",		{ IX, Y, N },	1, 0, 3 },
	{ OP_MOVD_LD,	0xe010, 0xf0f0, "MOVD",		{ IX, Y, N },	1, 0, 4 },
	{ OP_MOVB_LD,	0xe020, 0xf0f0, "MOVB",		{ IX, Y, N },	1, 0, 4 },
	{ OP_MOVW_ST,	0xf000, 0xff00, "movw",		{ Z, IX, N },	1, 0, 4 },	// lowercase to force match on reg=>mem version (and use this index if args are reg<=mem)
	{ OP_MOVD_ST,	0xf100, 0xff00, "movd",		{ Z, IX, N },	1, 0, 5 },	// lowercase to force match on reg=>mem version (and use this index if args are reg<=mem)
	{ OP_MOVSW_LD,	0xf200, 0xff00, "MOVSW",	{ Z, IX, N },	1, 0, 4 },
	{ OP_MOVB_ST,	0xf300, 0xff00, "movb",		{ Z, IX, N },	1, 0, 4 },	// lowercase to force match on reg=>mem version (and use this index if args are reg<=mem)
	{ OP_LD,		0xb100, 0xff0f, "LD",		{ Z, I32, N }, -3, 0, 4 },
	{ OP_JMP,		0x8000, 0xf000, "JMP",		{ R28, N, N }, -2, 0, 2 }
};

const sweet32::variant_t* sweet32::variant_names()
{
	return variant_list;
}

bool sweet32::set_variant(const std::string& name)
{
	std::string uppername = name;
	std::transform(uppername.begin(), uppername.end(), uppername.begin(), ::toupper);

	for (size_t i = 0; variant_list[i].max_width; ++i)
	{
		std::string upperarch = variant_list[i].name;
		std::transform(upperarch.begin(), upperarch.end(), upperarch.begin(), ::toupper);
		
		if (upperarch == uppername)
		{
			cur_variant = &variant_list[i];
			
			return true;
		}
	}
	
	return false;
}

void sweet32::init(xlasm *xl)
{
	xl->add_special_sym("R0",	xlasm::symbol_t::REGISTER, 0x00);
	xl->add_special_sym("R1",	xlasm::symbol_t::REGISTER, 0x01);
	xl->add_special_sym("R2",	xlasm::symbol_t::REGISTER, 0x02);
	xl->add_special_sym("R3",	xlasm::symbol_t::REGISTER, 0x03);
	xl->add_special_sym("R4",	xlasm::symbol_t::REGISTER, 0x04);
	xl->add_special_sym("R5",	xlasm::symbol_t::REGISTER, 0x05);
	xl->add_special_sym("R6",	xlasm::symbol_t::REGISTER, 0x06);
	xl->add_special_sym("R7",	xlasm::symbol_t::REGISTER, 0x07);
	xl->add_special_sym("R8",	xlasm::symbol_t::REGISTER, 0x08);
	xl->add_special_sym("R9",	xlasm::symbol_t::REGISTER, 0x09);
	xl->add_special_sym("R10",	xlasm::symbol_t::REGISTER, 0x0a);
	xl->add_special_sym("R11",	xlasm::symbol_t::REGISTER, 0x0b);
	xl->add_special_sym("R12",	xlasm::symbol_t::REGISTER, 0x0c);
	xl->add_special_sym("R13",	xlasm::symbol_t::REGISTER, 0x0d);
	xl->add_special_sym("R14",	xlasm::symbol_t::REGISTER, 0x0e);
	xl->add_special_sym("R15",	xlasm::symbol_t::REGISTER, 0x0f);

	xl->add_special_sym("BP",	xlasm::symbol_t::REGISTER, 0x0d);	// alias
	xl->add_special_sym("SP",	xlasm::symbol_t::REGISTER, 0x0e);	// alias
	xl->add_special_sym("RA",	xlasm::symbol_t::REGISTER, 0x0f);	// alias

	if (opcodes.size() == 0)
	{
		for (uint32_t i = 0; i < num_ops && ops[i].name; i++)
		{
			std::string n(ops[i].name);
			op_t& op = opcodes[n];
			op = ops[i].op_idx;
		}
	}
}

const std::string &sweet32::name()
{
	static const std::string none("none");

	if (!cur_variant)
		return none;
	
	return cur_variant->name;
}

bool sweet32::is_big_endian()
{
	if (!cur_variant)
		return true;

	return cur_variant->big_endian;
}

uint32_t sweet32::max_bit_width()
{
	if (!cur_variant)
		return 0;

	return cur_variant->max_width;
}

uint32_t sweet32::alignment(size_t size)
{
	// current assumes all sweet32 have 16 bit data bus width
	uint32_t r = 1;
		
	switch (size)
	{
		case 1:
			r = 1;
			break;
		case 2:
			r = 1;	// not enforced alignment
			break;
		case 4:
			r = 2;
			break;
		case 8:
			r = 2;
			break;
		case 16:
			r = 2;
			break;
		default:
			dprintf("size = " PR_DSIZET "\n", size);
			assert(0);
			break;
	}

	return r;
}

// return opcode index or -1 if not recognized
int32_t sweet32::check_opcode(const std::string& opcode)
{
	assert(cur_variant);

	int32_t index = -1;
	auto it = opcodes.find(opcode);

	if (it != opcodes.end())
	{
		index = it->second;
	}
	
	return index;
}

int32_t sweet32::process_opcode(xlasm *xl, int32_t idx, std::string& opcode, uint32_t cur_token, const std::vector<std::string>& tokens)
{
	assert(cur_variant);

	// make keyword uppercase to stand out in error messages
	std::transform(opcode.begin(), opcode.end(), opcode.begin(), ::toupper);

	xl->align_output(2);
	
#if 0
	std::string tokdbg;
	for (auto it = tokens.begin()+cur_token; it != tokens.end(); ++it)
	{
		tokdbg += "{";
		tokdbg += *it;
		tokdbg += "}";
		if (it+1 != tokens.end())
			tokdbg += " ";
	}
	dprintf("TOKENS %s: %s\n", opcode.c_str(), tokdbg.c_str());
#endif

	int64_t PC = xl->ctxt.section->addr + xl->ctxt.section->data.size();
	uint16_t opval = ops[idx].bits;
	uint16_t X_reg = 0;
	uint16_t Y_reg = 0;
	uint16_t Z_reg = 0;
	uint16_t imm_op = 0;
	uint32_t imm_word = 0;
	int64_t	result = 0;
	int64_t jmp_offset = 0;
	std::string operstr;
	int oper_num = 0;
	int	r;
	for (auto it = tokens.begin()+cur_token; it != tokens.end() && oper_num < 3 && ops[idx].a[oper_num] != N; ++it, cur_token++)
	{
		result = 0;

		if (*it != ",")
		{
			if (operstr.size())
				operstr += " ";

			operstr += *it;
		}

		// special case for MOVx mem,reg vs MOVx reg,mem
		if (oper_num == 0 && (opval & 0xF000) == 0xE000 && operstr[0] != '@' && operstr[0] != '[')
		{
			switch (opval)
			{
				case 0xE000:			// MOVW	@Rx,Ry -> MOVW Rz,@Rx
					opval = 0xF000;
					idx += 3;
					break;

				case 0xE010:			// MOVD	@Rx,Ry -> MOVD Rz,@Rx
					opval = 0xF100;
					idx += 3;
					break;

				case 0xE020:			// MOVB	@Rx,Ry -> MOVB Rz,@Rx
					opval = 0xF300;
					idx += 4;
					break;

				default:
					assert(0);
					break;
			}
		}

		if (*it == "," || it+1 == tokens.end())
		{
			 operand operand_type = ops[idx].a[oper_num];

//			dprintf("oper[%d]=%s\n", oper_num, operstr.c_str());

			switch (operand_type)
			{
				case N:
					break;

				case Z:
					r = xl->lookup_reg(opcode, operstr);
					if (r >= 0)
						Z_reg = r << 4;
					break;

				case X:
					r = xl->lookup_reg(opcode, operstr);
					if (r >= 0)
						X_reg = r;
					break;

				case Y:
					r = xl->lookup_reg(opcode, operstr);
					if (r >= 0)
					{
						Y_reg = r << 8;
						
						if (opcode == "LSL" || opcode == "ASL")
							X_reg = r;
					}
						
					break;

				case IY:
				{
					std::string ir;

					if (operstr[0] == '@')
						ir.assign(operstr.begin()+1, operstr.end());
					else if (operstr[0] == '[')
					{
						if (operstr.back() != ']')
							xl->error("%s missing matching bracket for '['", opcode.c_str());
						ir.assign(operstr.begin()+1, operstr.end()-1);
					}
					else
					{
						xl->error("Indirect register expected for opcode %s", opcode.c_str());
						break;
					}

					r = xl->lookup_reg(opcode, ir);
					if (r >= 0)
						Y_reg = r << 8;
				}
				break;

				case IX:
				{
					std::string ir;

					if (operstr[0] == '@')
						ir.assign(operstr.begin()+1, operstr.end());
					else if (operstr[0] == '[')
					{
						if (operstr.back() != ']')
							xl->error("%s missing matching bracket for '['", opcode.c_str());
						ir.assign(operstr.begin()+1, operstr.end()-1);
					}
					else
					{
						xl->error("Indirect register expected for opcode %s", opcode.c_str());
						break;
					}

					r = xl->lookup_reg(opcode, ir);
					if (r >= 0)
						X_reg = r;
				}
				break;

				case I4:
				case I5:
				case I8:
				case I16:
				case I32:
				{
					bool rel = false;
					expression expr;
					std::string exprstr;

					if (operstr[0] == '%')
						rel = true;
					if (operstr[0] == '#' || operstr[0] == '$' || operstr[0] == '%')
						exprstr.assign(operstr.begin()+1, operstr.end());

					if (!exprstr.size() || !expr.evaluate(xl, exprstr.c_str(), &result))
					{
						xl->error("Immediate value expected for opcode %s", opcode.c_str());
						break;
					}
					if (rel)
						result = result - PC;

					switch (operand_type)
					{
						case I4:
							if (xl->ctxt.pass == xlasm::context_t::PASS_2)
								xl->check_truncation_signed(opcode, result, 4, 2);	// INCS is signed
							imm_op = result & 0xf;
							break;
						case I5:
							if (xl->ctxt.pass == xlasm::context_t::PASS_2)
								xl->check_truncation_unsigned(opcode, result, 5, 2);
							imm_op = result & 0x1f;
							break;
						case I8:
							if (xl->ctxt.pass == xlasm::context_t::PASS_2)
								xl->check_truncation_unsigned(opcode, result, 8, 2);
							imm_op = ((result & 0xf0) << 4) | (result & 0xf);
							break;
						case I16:
							if (xl->ctxt.pass == xlasm::context_t::PASS_2)
								xl->check_truncation_unsigned(opcode, result, 16, 2);
							imm_word = result & 0xffff;
							break;
						case I32:
							if (xl->ctxt.pass == xlasm::context_t::PASS_2)
								xl->check_truncation(opcode, result, 32, 2);
							imm_word = (uint32_t)result;
							break;
						default:
							assert(0);
							break;
					}
				}
				break;

				case R8:
				{
					expression expr;
					std::string exprstr;
					bool rel = true;
					size_t skip = 0;

					if (operstr[0] == '#')
						rel = false;
					if (operstr[0] == '#' || operstr[0] == '$' || operstr[0] == '%')
						skip = 1;
					exprstr.assign(operstr.begin()+skip, operstr.end());
					bool eval_ok = expr.evaluate(xl, exprstr.c_str(), &result);

					if (!exprstr.size() || (xl->ctxt.pass == xlasm::context_t::PASS_2 && !eval_ok))
					{
						xl->error("PC relative offset expected for opcode %s", opcode.c_str());
						break;
					}
					if (rel)
					{
						if (xl->ctxt.pass == xlasm::context_t::PASS_2 && result & 1)
							xl->warning("%s reference to odd address 0x" PR_X64 "", opcode.c_str(), result);
						result = (result - PC)>>1;
					}
					if (xl->ctxt.pass == xlasm::context_t::PASS_2)
						xl->check_truncation_signed(opcode, result, 8, 2);
					imm_op = ((result & 0xf0) << 4) | (result & 0xf);
				}
				break;

				case R12:
				case R28:
				{
					expression expr;

					if (!operstr.size() || !expr.evaluate(xl, operstr.c_str(), &result))
					{
						xl->error("Destination address expected for opcode %s", opcode.c_str());
						break;
					}
					if (result & 1)
						xl->warning("%s reference to odd address 0x" PR_X64 "", opcode.c_str(), result);

					result = (result - PC)&~1;
					jmp_offset = result;			// save for JMP optimization

					if (operand_type == R28)
						result -= 2;
					
					if (xl->ctxt.pass == xlasm::context_t::PASS_2)
						xl->check_truncation_signed(opcode, (result>>1), (operand_type == R12) ? 12 : 28, 2);
					result >>= 1;
					if (operand_type == R12)
						imm_op = result & 0xfff;
					else
					{
						imm_op = (result >> 16) & 0xfff;
						imm_word = result & 0xffff;
					}
				}
				break;

				default:
					assert(0);
					break;
			}

			operstr.clear();
			oper_num++;
		}
	}

	if (oper_num < 3 && ops[idx].a[oper_num] != N)
	{
		xl->error("Missing required operand #%d for opcode %s", oper_num+1, opcode.c_str());
	}
	if (tokens.size() != cur_token)
	{
		xl->error("Unexpected additional operand(s) for opcode %s", opcode.c_str());
	}

	uint32_t len = 0;
	// negative len indicates "optimizable" opcode
	if (ops[idx].len < 0)
	{
		uint32_t& hint = xl->line_hint[xl->virtual_line_num];

		len = (uint32_t) -ops[idx].len;

		if (xl->undefined_sym_count == 0)
		{
			uint32_t plen = len;
			uint32_t pcyc = ops[idx].cyc;
			uint32_t cyc = pcyc;

			if (idx == OP_LD)
			{
				if (!xl->check_truncation_unsigned(opcode, result, 8, 0))
				{
					opval = 0x7000;	// LDB
					imm_op = ((result & 0xf0) << 4) | (result & 0xf);
					len = 1;
					cyc = 1;
				}
				else if ((result & 0xff00) == result)
				{
					result = result >> 8;
					opval = 0x7000;												// LDB	 Rz,#result>>8
					imm_op = ((result & 0xf0) << 4) | (result & 0xf);
					imm_word = 0xC000 | Z_reg | (Z_reg >> 4);					// SWAPB Rz,Rz
					len = 2;
					cyc = 2;
				}
				else if ((result & 0x1fe) == result)
				{
					result = result >> 1;
					opval = 0x7000;												// LDB	Rz,#result>>1
					imm_op = ((result & 0xf0) << 4) | (result & 0xf);
					imm_word = 0x1000 | (Z_reg << 4) | Z_reg | (Z_reg >> 4);	// ADD	Rz,Rz,Rz
					len = 2;
					cyc = 2;
				}
				else if ((result - 0xff) >= 0 && (result - 0xff) < 8)
				{
					uint32_t inc = (uint32_t)(result - 0xff);
					result = 0xff;
					opval = 0x7000;												// LDB	Rz,#0xff
					imm_op = ((result & 0xf0) << 4) | (result & 0xf);
					// 1010 yyyy zzzz iiii	INCS	Rz,Rx,#simm4	1	1	
					imm_word = 0xA000 | (Z_reg << 4) | Z_reg | inc;				// INCS	Rz,Rz,#result-0xff
					len = 2;
					cyc = 2;
				}
				else if (!xl->check_truncation_unsigned(opcode, result, 16, 0))
				{
					opval = 0xb000;												// LDW	Rz,#result
					imm_word = result & 0xffff;
					len = 2;
					cyc = 3;
				}
				else if ((result & 0x00ff0000) == result)
				{
					result = result >> 16;
					opval = 0x7000;												// LDB	 Rz,#result>>16
					imm_op = ((result & 0xf0) << 4) | (result & 0xf);
					imm_word = 0xC100 | Z_reg | (Z_reg >> 4);					// SWAPW Rz,Rz
					len = 2;
					cyc = 2;
				}
				else if ((result & 0xffffff00) == 0xffffff00)
				{
					result = ~result;
					opval = 0x7000;												// LDB	Rz,#~result
					imm_op = ((result & 0xf0) << 4) | (result & 0xf);
					imm_word = 0xC200 | Z_reg | (Z_reg >> 4);					// NOT	Rz,Rz
					len = 2;
					cyc = 2;
				}
				else
				{
					len = 3;
				}
			}
			else if (idx == OP_JMP)
			{
				if (!xl->check_truncation_signed(opcode, (jmp_offset>>1), 12, 0))
				{
					opval = 0x6000;
					imm_op = (jmp_offset>>1) & 0xfff;
					len = 1;
					cyc = 1;
				}
				else
				{
					len = 2;
				}
			}

			if (len != plen)
			{
				xl->applied_hints++;
				xl->bytes_optimized += ((int)plen - (int)len)<<1;
				xl->cycles_optimized += (int)pcyc - (int)cyc;
			}
			hint = len;
		}
		
		if (hint != len)
			xl->pending_hints++;
	}
	else
	{
		len = ops[idx].len;
	}

	assert(len >= 1 && len <= 3);

	opval = opval | X_reg | Y_reg | Z_reg | imm_op;

	if (prev_opcode_skip && (xl->ctxt.section != prev_opcode_skip_sec || xl->ctxt.section->addr != prev_opcode_skip_addr))
		prev_opcode_skip = false;

	xl->emit((int16_t)opval);

	if (len == 2)
	{
		xl->emit((int16_t)imm_word);
	}
	else if (len == 3)
	{
		xl->emit((int32_t)imm_word);
	}

	if (idx == OP_TSTSNZ || idx == OP_TSTSZ || idx == OP_BITSNZ || idx == OP_BITSZ || idx == OP_SUBSLT)
	{
		prev_opcode_skip = true;
		prev_opcode_skip_idx = idx;
		prev_opcode_skip_sec = xl->ctxt.section;
		prev_opcode_skip_addr = xl->ctxt.section->addr;
	}
	else
	{
		if (xl->ctxt.pass == xlasm::context_t::PASS_2 && prev_opcode_skip && len != 1)
			xl->warning("Instruction %s with length of %d words placed inside instruction %s skip slot.", opcode.c_str(), len, ops[prev_opcode_skip_idx].name);

		prev_opcode_skip = false;
		prev_opcode_skip_idx = -1;
		prev_opcode_skip_sec = nullptr;
		prev_opcode_skip_addr = 0;
	}

	return 0;
}

