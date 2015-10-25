#include "xlasm.h"
#include "xlasmexpr.h"

expression::op_s expression::ops[expression::NUM_OPS] =
{
	  { "u-",	2, 		OP_UMINUS,		100, ASSOC_RIGHT, 1, eval_uminus },
	  { "u+",	2, 		OP_UPLUS,		100, ASSOC_RIGHT, 1, eval_uplus },

	  { "!", 	1,		OP_LOG_UNOT,	 99, ASSOC_RIGHT, 1, eval_ulognot },
	  { "~", 	1,		OP_UNOT,		 99, ASSOC_RIGHT, 1, eval_unot },

	  { ".highw",	6,	OP_UHIGHW,		 98, ASSOC_RIGHT, 1, eval_uhighw },
	  { ".loww",	5,	OP_ULOWW,		 98, ASSOC_RIGHT, 1, eval_uloww },

	  { "**", 		2,	OP_EXPONENT,	 90, ASSOC_RIGHT, 2, eval_exp },

	  { "*", 		1,	OP_MULTIPLY,	 80, ASSOC_LEFT, 2, eval_mul },
	  { "/", 		1,	OP_DIVIDE,		 80, ASSOC_LEFT, 2, eval_div },
	  { "%", 		1,	OP_MODULO,		 80, ASSOC_LEFT, 2, eval_mod },

	  { "+",		1,	OP_ADD,		 	 50, ASSOC_LEFT, 2, eval_add },
	  { "-", 		1,	OP_SUB,		 	 50, ASSOC_LEFT, 2, eval_sub },

	  { "<<", 		2,	OP_SHL,		 	 49, ASSOC_LEFT, 2, eval_shl },
	  { ">>", 		2,	OP_SHR,		 	 49, ASSOC_LEFT, 2, eval_shr },

	  { "<=", 		2,	OP_LOG_LTE,		 49, ASSOC_LEFT, 2, eval_lte },
	  { "<", 		1,	OP_LOG_LT,		 49, ASSOC_LEFT, 2, eval_lt },

	  { ">=", 		2,	OP_LOG_GTE,		 49, ASSOC_LEFT, 2, eval_gte },
	  { ">", 		1,	OP_LOG_GT,		 49, ASSOC_LEFT, 2, eval_gt },

	  { "==", 		2,	OP_LOG_EQ,		 48, ASSOC_LEFT, 2, eval_eq },
	  { "!=", 		2,	OP_LOG_NEQ,		 48, ASSOC_LEFT, 2, eval_neq },

	  { "&", 		1,	OP_AND,			 47, ASSOC_LEFT, 2, eval_and },

	  { "^", 		1,	OP_XOR,			 46, ASSOC_LEFT, 2, eval_xor },

	  { "|", 		1,	OP_OR,			 45, ASSOC_LEFT, 2, eval_or },

	  { "&&", 		2,	OP_LOG_AND,		 44, ASSOC_LEFT, 2, eval_logand },

	  { "||", 		2,	OP_LOG_OR,		 43, ASSOC_LEFT, 2, eval_logor },

	  { "?", 		1,	OP_TERNARY,		 40, ASSOC_RIGHT, 3, nullptr },	// special case for ternary (HACK: also adds LPAREN)

	  { "(", 		1,	OP_LPAREN,		  0, ASSOC_NONE, 0, nullptr },
	  { ")", 		1,	OP_RPAREN,		  0, ASSOC_NONE, 0, nullptr },
};

