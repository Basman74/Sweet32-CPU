#if !defined(INCLUDED_XLASMSWEET32_H)
#define INCLUDED_XLASMSWEET32_H

#include <stdio.h>
#include <string.h>

#include <string>
#include <vector>
#include <unordered_map>

#include "xlasm.h"

struct sweet32 : public Ixlarch
{
	const variant_t*				variant_names();						// list of variant names
	bool							set_variant(const std::string& name);	// set variant index
	void							init(xlasm *xl);						// init before assembly (add reg name symbols etc.)
	const std::string&				name();									// get current variant name
	bool							is_big_endian();						// true if default endian is big-endian for architecture
	uint32_t						max_bit_width();						// maximum bit width for address/data for architecture (<=64)
	uint32_t						alignment(size_t size);					// byte boundary for data type size bytes (1-16, POT)
	int32_t							check_opcode(const std::string& opcode);// return opcode index or -1 if not recognized
	int32_t							process_opcode(xlasm *xl, int32_t idx, std::string& opcode, uint32_t cur_token, const std::vector<std::string>& tokens);

	sweet32()
		: cur_variant(nullptr)
		, prev_opcode_skip(false)
		, prev_opcode_skip_idx(-1)
		, prev_opcode_skip_sec(nullptr)
		, prev_opcode_skip_addr(0)
	{ }

	enum
	{
		SWEET32_BE,
		SWEET32_LE
	};

	static const variant_t variant_list[];

	enum op_t
	{
		OP_NOP,
		OP_AND,
		OP_ADD,
		OP_LSL,
		OP_ASL,
		OP_XOR,
		OP_TSTSNZ,
		OP_TSTSZ,
		OP_BITSNZ,
		OP_BITSZ,
		OP_SUBSLT,
		OP_MUL,
		OP_SJMP,
		OP_LDB,
		OP_MJMP,
		OP_GETPC,
		OP_MOV,
		OP_INCS,
		OP_LDW,
		OP_LDD,
		OP_SETIV,
		OP_RETI,
		OP_SETCW,
		OP_RETT,
		OP_GETXR,
		OP_GETTR,
		OP_SWAPB,
		OP_SWAPW,
		OP_NOT,
		OP_LJMP,
		OP_LSR,
		OP_ASR,
		OP_MOVW_LD,
		OP_MOVD_LD,
		OP_MOVB_LD,
		OP_MOVW_ST,
		OP_MOVD_ST,
		OP_MOVSW_LD,
		OP_MOVB_ST,
		OP_LD,				// will be LDB, LDW or LDD
		OP_JMP,				// will be SJMP or MJMP
	};

	enum operand
	{
		L,
		N,
		Z,
		X,
		Y,
		I4,
		I5,
		I8,
		I16,
		I32,
		R8,
		R12,
		R28,
		IY,
		IX
	};
	
	struct op_tbl
	{
		op_t		op_idx;
		uint32_t	bits;
		uint32_t	mask;
		const char*	name;
		operand		a[3];
		int32_t		len;	// negative for "worse case" (might be less from SQUEEZE pass)
		uint32_t	flags;
		uint32_t	cyc;
	};

	typedef std::unordered_map<std::string, op_t> opcode_map_t;

	enum { num_ops	= 41 };
	
	const variant_t	*cur_variant;

	opcode_map_t		opcodes;
	static const op_tbl	ops[num_ops];

	bool				prev_opcode_skip;
	int32_t				prev_opcode_skip_idx;
	xlasm::section_t*	prev_opcode_skip_sec;
	int64_t				prev_opcode_skip_addr;
};

#endif // !defined(INCLUDED_XLASMSWEET32_H)
