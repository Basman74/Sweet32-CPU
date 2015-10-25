// xlasexpr.h - modified "shunt" expression parser
// Supports most C operators and precedence.

/* The authors of this work have released all rights to it and placed it
in the public domain under the Creative Commons CC0 1.0 waiver
(http://creativecommons.org/publicdomain/zero/1.0/).

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Retrieved from: http://en.literateprograms.org/Shunting_yard_algorithm_(C)?oldid=18970
*/

// Hacked significantly by Xark - so blame him for any problems. :-)

#if !defined(INCLUDED_XLASMEXPR_H)
#define INCLUDED_XLASMEXPR_H

#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <stdint.h>
#include <string.h>
#include <stdarg.h>

#include <string>

#if 0
#define exp_dprintf(...)	dprintf
#else
#define exp_dprintf(...)	(void)0
#endif

class expression
{
	enum
	{
		MAXOPSTACK	= 64,
		MAXNUMSTACK	= 64
	};

	enum
	{
		ASSOC_NONE = 0,
		ASSOC_LEFT,
		ASSOC_RIGHT
	};

	enum op_t
	{
		OP_UMINUS,
		OP_UPLUS,
		OP_UNOT,
		OP_LOG_UNOT,
		OP_UHIGHW,
		OP_ULOWW,
		OP_EXPONENT,
		OP_MULTIPLY,
		OP_DIVIDE,
		OP_MODULO,
		OP_ADD,
		OP_SUB,
		OP_SHL,
		OP_SHR,
		OP_AND,
		OP_OR,
		OP_XOR,
		OP_LOG_AND,
		OP_LOG_OR,
		OP_LOG_EQ,
		OP_LOG_NEQ,
		OP_LOG_LT,
		OP_LOG_LTE,
		OP_LOG_GT,
		OP_LOG_GTE,
		OP_TERNARY,
		OP_LPAREN,
		OP_RPAREN,
		NUM_OPS,
		OP_DUMMY
	};

	struct op_s
	{
		const char *op_str;
		uint32_t	str_len;
		op_t 		op;
		int64_t 	prec;
		int64_t 	assoc;
		int64_t 	unary;
		int64_t		(*eval)(expression* exp, int64_t a1, int64_t a2);
	};

	static op_s ops[NUM_OPS];

	xlasm		*xl;
	struct op_s *opstack[MAXOPSTACK];
	int32_t nopstack;
	int64_t numstack[MAXNUMSTACK];
	int32_t nnumstack;
	int32_t brace_balance;
	int32_t errorcode;

	static int64_t eval_uminus(expression *, int64_t a1, int64_t)		{	exp_dprintf("- %ld = %ld\n", a1, -a1); return -a1;			}
	static int64_t eval_uplus(expression *, int64_t a1, int64_t)		{	exp_dprintf("+ %ld = %ld\n", a1, +a1); return +a1;			}
	static int64_t eval_unot(expression *, int64_t a1, int64_t)			{	exp_dprintf("~ %ld = %ld\n", a1, ~a1); return ~a1;			}
	static int64_t eval_ulognot(expression *, int64_t a1, int64_t)		{	exp_dprintf("! %ld = %ld\n", a1, (int64_t)(!a1)); return !a1;			}
	static int64_t eval_uhighw(expression *, int64_t a1, int64_t)		{	exp_dprintf("highw %ld = %ld\n", a1, (a1>>16)&0xffff); return (a1>>16) & 0xffff;	}
	static int64_t eval_uloww(expression *, int64_t a1, int64_t)		{	exp_dprintf("loww %ld = %ld\n", a1, a1&0xffff); return a1 & 0xffff;			}

	static int64_t eval_exp(expression *exp, int64_t a1, int64_t a2)	{	exp_dprintf("%ld ** %ld = %ld\n", a1, a2, a2 < 0 ? 0 : (a2 == 0 ? 1 : a1 * eval_exp(a1, a2 - 1)));
																			return a2 < 0 ? 0 : (a2 == 0 ? 1 : a1 * eval_exp(exp, a1, a2 - 1));		}
	static int64_t eval_mul(expression *, int64_t a1, int64_t a2)		{	exp_dprintf("%ld * %ld = %ld\n", a1, a2, a1 * a2); return a1 * a2;		}

	static int64_t eval_add(expression *, int64_t a1, int64_t a2)		{	exp_dprintf("%ld + %ld = %ld\n", a1, a2, a1 + a2); return a1 + a2;		}
	static int64_t eval_sub(expression *, int64_t a1, int64_t a2)		{	exp_dprintf("%ld + %ld = %ld\n", a1, a2, a1 - a2); return a1 - a2;		}

	static int64_t eval_shl(expression *, int64_t a1, int64_t a2)		{	exp_dprintf("%ld << %ld = %ld\n", a1, a2, a1 << a2); return a1 << a2;	}
	static int64_t eval_shr(expression *, int64_t a1, int64_t a2)		{	exp_dprintf("%ld >> %ld = %ld\n", a1, a2, a1 >> a2); return a1 >> a2;	}

	static int64_t eval_eq(expression *, int64_t a1, int64_t a2)		{	exp_dprintf("%ld == %ld = %ld\n", a1, a2, (int64_t)(a1 == a2)); return a1 == a2;	}
	static int64_t eval_neq(expression *, int64_t a1, int64_t a2)		{	exp_dprintf("%ld + %ld != %ld\n", a1, a2, (int64_t)(a1 != a2)); return a1 != a2;	}

	static int64_t eval_lt(expression *, int64_t a1, int64_t a2)		{	exp_dprintf("%ld < %ld = %ld\n", a1, a2, (int64_t)(a1 < a2)); return a1 < a2;		}
	static int64_t eval_lte(expression *, int64_t a1, int64_t a2)		{	exp_dprintf("%ld + %ld <= %ld\n", a1, a2, (int64_t)(a1 <= a2)); return a1 <= a2;	}

	static int64_t eval_gt(expression *, int64_t a1, int64_t a2)		{	exp_dprintf("%ld > %ld = %ld\n", a1, a2, (int64_t)(a1 > a2)); return a1 > a2;		}
	static int64_t eval_gte(expression *, int64_t a1, int64_t a2)		{	exp_dprintf("%ld + %ld >= %ld\n", a1, a2, (int64_t)(a1 >= a2)); return a1 >= a2;	}

	static int64_t eval_and(expression *, int64_t a1, int64_t a2)		{	exp_dprintf("%ld + %ld & %ld\n", a1, a2, a1 & a2); return a1 & a2;		}
	static int64_t eval_or(expression *, int64_t a1, int64_t a2)		{	exp_dprintf("%ld + %ld | %ld\n", a1, a2, a1 | a2); return a1 | a2;		}
	static int64_t eval_xor(expression *, int64_t a1, int64_t a2)		{	exp_dprintf("%ld + %ld ^ %ld\n", a1, a2, a1 ^ a2); return a1 ^ a2;		}

	static int64_t eval_logand(expression *, int64_t a1, int64_t a2)	{	exp_dprintf("%ld + %ld && %ld\n", a1, a2, (int64_t)(a1 && a2)); return a1 && a2;	}
	static int64_t eval_logor(expression *, int64_t a1, int64_t a2)		{	exp_dprintf("%ld + %ld || %ld\n", a1, a2, (int64_t)(a1 || a2)); return a1 || a2;	}

	static int64_t eval_cond(expression *, int64_t a1, int64_t a2, int64_t a3)
	{
			exp_dprintf("%ld ? %ld : %ld = %ld\n", a1, a2, a3, a1 ? a2 : a3);
			return a1 ? a2 : a3;
	}

	static int64_t eval_div(expression *exp, int64_t a1, int64_t a2)
	{
		if (!a2)
		{
			exp->eval_error(0x100, "Division by zero");
			return 0;
		}
		exp_dprintf("%ld / %ld = %ld\n", a1, a2, a1 / a2);
		return a1 / a2;
	}

	static int64_t eval_mod(expression *exp, int64_t a1, int64_t a2)
	{
		if (!a2)
		{
			exp->eval_error(0x101, "Modulo by zero");
			return 0;
		}
		exp_dprintf("%ld %% %ld = %ld\n", a1, a2, a1 % a2);
		return a1 % a2;
	}

	op_s *getop(const char *&chptr)
	{
		// HACK: To keep ternary operator (?:) working correctly, an invisible is added LPAREN after '?'
		//       this hack makes the ':' act as the matching RPAREN.
		if (chptr[0] == ':')
		{
			op_s *op = &ops[(sizeof (ops) / sizeof (ops[0]))-1];	// RPAREN
			assert(op->op == OP_RPAREN);

			return op;
		}

		// don't search unary -/+
		for (uint32_t i = 2; i < (sizeof (ops) / sizeof (ops[0])); ++i)
		{
			if (ops[i].op_str[0] == chptr[0] && (ops[i].op_str[1] == '\0' || strncmp(ops[i].op_str, chptr, ops[i].str_len) == 0))
			{
				if (ops[i].op != OP_LOG_UNOT || chptr[1] != '=')	// special case ! vs !=
				{
					chptr += ops[i].str_len-1;
					return ops + i;
				}
			}
		}
		return nullptr;
	}

	void push_opstack(struct op_s *op)
	{
		if (nopstack > MAXOPSTACK - 1)
		{
			eval_error(0x103, "Operator stack overflow");
			nopstack--;
		}
		opstack[nopstack++] = op;
	}

	struct op_s *pop_opstack()
	{
		if (!nopstack)
		{
//			eval_error(0x104, "Operator stack empty");
			nopstack++;
			opstack[0] = nullptr;

		}
		return opstack[--nopstack];
	}

	void push_numstack(int64_t num)
	{
		if (nnumstack > MAXNUMSTACK - 1)
		{
			eval_error(0x105, "Number stack overflow");
			nnumstack--;
		}
		numstack[nnumstack++] = num;
	}

	int64_t pop_numstack()
	{
		if (!nnumstack)
		{
			eval_error(0x106, "Syntax error, not enough arguments");
			++nnumstack;
			numstack[0] = 0;
		}
		return numstack[--nnumstack];
	}

	void shunt_op(struct op_s *op)
	{
		struct op_s *pop;
		int64_t n1, n2, n3;

		exp_dprintf("operator %s\n", op->op_str);

		if (op->op == OP_LPAREN)
		{
			brace_balance++;
			push_opstack(op);
			return;
		}
		else if (op->op == OP_RPAREN)
		{
			brace_balance--;
			while (nopstack > 0 && opstack[nopstack - 1]->op != OP_LPAREN)
			{
				pop = pop_opstack();
				if (!pop)
					return;

				if (pop->unary == 1)
				{
					n1 = pop_numstack();
					push_numstack(pop->eval(this, n1, 0));
				}
				else if (pop->unary == 2)
				{
					n1 = pop_numstack();
					n2 = pop_numstack();
					push_numstack(pop->eval(this, n2, n1));
				}
				else if (pop->unary == 3)
				{
					n1 = pop_numstack();
					n2 = pop_numstack();
					n3 = pop_numstack();
					push_numstack(eval_cond(this, n3, n2, n1));
				}
			}

			if (!(pop = pop_opstack()) || pop->op != OP_LPAREN)
			{
				eval_error(0x107, "Closing parenthesis ')' with no opening '('");
			}
			return;
		}

		if (op->assoc == ASSOC_RIGHT)
		{
			while (nopstack && op->prec < opstack[nopstack - 1]->prec)
			{
				pop = pop_opstack();
				if (!pop)
					return;

				if (pop->unary == 1)
				{
					n1 = pop_numstack();
					push_numstack(pop->eval(this, n1, 0));
				}
				else if (pop->unary == 2)
				{
					n1 = pop_numstack();
					n2 = pop_numstack();
					push_numstack(pop->eval(this, n2, n1));
				}
				else if (pop->unary == 3)
				{
					n1 = pop_numstack();
					n2 = pop_numstack();
					n3 = pop_numstack();
					push_numstack(eval_cond(this, n3, n2, n1));
				}
			}
		}
		else if (op->assoc == ASSOC_LEFT)
		{
			while (nopstack && op->prec <= opstack[nopstack - 1]->prec)
			{
				pop = pop_opstack();
				if (!pop)
					return;

				if (pop->unary == 1)
				{
					n1 = pop_numstack();
					push_numstack(pop->eval(this, n1, 0));
				}
				else if (pop->unary == 2)
				{
					n1 = pop_numstack();
					n2 = pop_numstack();
					push_numstack(pop->eval(this, n2, n1));
				}
				else if (pop->unary == 3)
				{
					n1 = pop_numstack();
					n2 = pop_numstack();
					n3 = pop_numstack();
					push_numstack(eval_cond(this, n3, n2, n1));
				}
			}
		}

		push_opstack(op);
	}

public:
	void eval_error(int error, const char *fmt, ...) ATTRIBUTE((format(printf, 3, 4)))
	{
		char	experr[4096] = { 0 };
		
		errorcode = error;

		if (xl->ctxt.pass != xlasm::context_t::PASS_2 || !xl->ctxt.file)
			return;
		
		va_list args;
		va_start(args, fmt);
		sprintf(experr, "E%03X: ", errorcode);
		vsprintf(experr + strlen(experr), fmt, args);
		va_end(args);

		xl->error("%s", experr);
	}

	bool evaluate(xlasm *xl_, std::string expression, int64_t *result)
	{
		struct op_s startop = { "X", 1, OP_DUMMY, 0, ASSOC_NONE, 0, nullptr };	/* Dummy operator to mark TOS */
		struct op_s *op = nullptr;
		int64_t n1, n2, n3;
		struct op_s *lastop = &startop;

		xl = xl_;
		errorcode = 0;
		brace_balance = 0;
		nopstack = 0;
		memset(&opstack, 0, sizeof (opstack));
		nnumstack = 0;
		memset(&numstack, 0, sizeof (numstack));
		*result = 0;	// default

//		printf("evaluate(\"%s\")\n", expression.c_str());

		const char *expr;
		for (expr = expression.c_str(); *expr && !errorcode; ++expr)
		{
			if ((op = getop(expr)))
			{
				if (lastop && (lastop == &startop || lastop->op != OP_RPAREN))
				{
					// special cases to avoid ambiguity
					if (op->op == OP_SUB)
					{
						op = &ops[0];	// unary minus
						assert(op->op == OP_UMINUS);
					}
					if (op->op == OP_ADD)
					{
						op = &ops[1];	// unary plus
						assert(op->op == OP_UPLUS);
					}
					else if (op->op != OP_LPAREN && op->unary > 1)
					{
						eval_error(0x108, "Illegal use of operator '%s' at: %.32s", op->op_str, expr);
						return false;
					}
				}
				shunt_op(op);
				if (op->op == OP_TERNARY)		// insert invisible LPAREN after ? (and : becomes RPAREN)
				{
					op = &ops[(sizeof (ops) / sizeof (ops[0]))-2];	// LPAREN
					assert(op->op == OP_LPAREN);
					shunt_op(op);
				}
				lastop = op;

				continue;
			}

			if (isdigit(*expr) || *expr == '\'')
			{
				const char *oexpr = expr;
				int64_t v = 0;
				if (expr[0] == '\'')
				{
					if (expr[2] != '\'' || !isprint(expr[1]))
					{
						eval_error(0x10C, "Character literal syntax error at: %.32s", expr);
						return false;
					}
					v = expr[1];
					expr += 3;
				}
				else if (expr[0] == '0' && expr[1] == 'b')	// need binary!
				{
					expr += 2;
					while (*expr == '0' || *expr == '1')
					{
						v = (v<<1) | (*expr & 1);
						expr++;
					}
				}
				else
				{
					v = strtoul(const_cast<char *>(expr), const_cast<char **>(&expr), 0);
				}

				push_numstack(v);
				lastop = nullptr;

				// for loop will still increment, so back off one
				if (oexpr != expr)
				{
					exp_dprintf("literal=%ld (0x%lx) [%ld chars]\n", v, v, expr - oexpr);
					expr--;
				}
				else
				{
					eval_error(0x10C, "Literal syntax error at: %.32s", expr);
					return false;
				}

				continue;
			}

			if (isalpha(*expr) || *expr == '.' || *expr == '_')
			{
				char symname[64] = {0};
				uint32_t symlen = 1;
				const char *sptr = expr+1;
				while (symlen < sizeof(symname) && *sptr && (isalpha(*sptr) || isdigit(*sptr) || *sptr == '.' || *sptr == '_'))
				{
					symlen++;
					sptr++;
				}
				strncpy(symname, expr, symlen);

				exp_dprintf("parsed sym '%s'\n", symname);

				int64_t v = xl->symbol_value(xl, symname);

				push_numstack(v);
				lastop = nullptr;

				expr += symlen-1;
				continue;
			}

			if (!isspace(*expr))
			{
				eval_error(0x10A, "Expression syntax error at: %.32s", expr);
				return false;
			}
		}

		if (brace_balance > 0)
		{
			eval_error(0x10C, "Open parenthesis '(' with no closing ')'");
			return false;
		}

		while (!errorcode && nopstack)
		{
			op = pop_opstack();
			if (!op)
				break;

			if (op->unary == 1)
			{
				n1 = pop_numstack();
				push_numstack(op->eval(this, n1, 0));
			}
			else if (op->unary == 2)
			{
				n1 = pop_numstack();
				n2 = pop_numstack();
				push_numstack(op->eval(this, n2, n1));
			}
			else if (op->unary == 3)
			{
				assert(op->op == OP_TERNARY);
				n1 = pop_numstack();
				n2 = pop_numstack();
				n3 = pop_numstack();
				push_numstack(eval_cond(this, n3, n2, n1));	// special case for ?: ternary op
			}
		}
		if (!errorcode && nnumstack != 1)
		{
			eval_error(0x10B, "Multiple values (%d) after evaluation, should be only one.", nnumstack);
			return false;
		}

		*result = numstack[0];

		return errorcode ? false : true;
	}
};
#endif	// !defined(INCLUDED_XLASMEXPR_H)
