// Sweet32 macro-assembler

#if !defined(INCLUDED_XLASM_H)
#define INCLUDED_XLASM_H

#include <stdint.h>
#include <list>
#include <unordered_map>
#include <string>
#include <stack>
#include <vector>

// Miyu was here (virtually) ->  :3

#if defined(_MSC_VER) || defined(__arm__)
#define	PR_D64	"%lld"
#define	PR_X64	"%llx"
#define ATTRIBUTE(x)
#else
#define	PR_D64	"%ld"
#define	PR_X64	"%lx"
#define ATTRIBUTE(x) __attribute__ (x)
#endif

#if __SIZEOF_POINTER__ == 4
#define PR_DSIZET	"%u"
#define PR_XSIZET	"%x"
#else
#if defined(_MSC_VER)
#define PR_DSIZET	"%llu"
#define PR_XSIZET	"%llx"
#else
#define PR_DSIZET	"%lu"
#define PR_XSIZET	"%lx"
#endif
#endif

#if 1
#define dprintf(x, ...)	printf(x, ## __VA_ARGS__), fflush(stdout);
#else
#define dprintf(x, ...)	(void)0
#endif

void vstrprintf(std::string& str, const char *fmt, va_list va) ATTRIBUTE((format(printf, 2, 0)));
void strprintf(std::string& str, const char *fmt, ...) ATTRIBUTE((format(printf, 2, 3)));

#define MAX_LINE_LENGTH	4096
#define NUM_ELEMENTS(a)	(sizeof(a)/sizeof(a[0]))

extern void		fatal_error(const char *msg, ...) ATTRIBUTE((noreturn)) ATTRIBUTE((format(printf, 1, 2)));

struct xlasm;

// Interface to architecture specific code
struct Ixlarch
{
	struct variant_t
	{
		const std::string	name;
		uint32_t			index;
		uint32_t			max_width;
		bool				big_endian;
		uint32_t			flags;
	};

	virtual const variant_t*				variant_names() = 0;						// list of possible variant names
	virtual bool							set_variant(const std::string& name) = 0;	// set current variant index
	virtual void							init(xlasm *xl) = 0;									// one time init (after variant set)
	virtual	const std::string&				name() = 0;									// name of current variant
	virtual bool							is_big_endian() = 0;						// true if default endian is big-endian for architecture
	virtual uint32_t						max_bit_width() = 0;						// maximum bit width for address/data for architecture (<=64)
	virtual	uint32_t						alignment(size_t size) = 0;					// byte boundary for data type size bytes (1-16, POT)
	virtual int32_t							check_opcode(const std::string& opcode) = 0;		// return opcode index or -1 if not recognized
	virtual int32_t							process_opcode(xlasm *xl, int32_t idx, std::string& opcode, uint32_t cur_token, const std::vector<std::string>& tokens) = 0;
	virtual ~Ixlarch()
	{ }
};

struct xlasm
{
	struct opts_t
	{
		uint32_t		listing:1;
		uint32_t		xref:1;
		uint32_t		big_endian:1;
		uint32_t		suppress_false_conditionals:1;
		uint32_t		suppress_macro_expansion:1;
		uint32_t		suppress_macro_name:1;
		uint32_t		suppress_line_numbers:1;
		uint32_t		:0;
		int32_t			verbose;			// 0, 1, 2 or 3
		uint32_t		listing_bytes;

		opts_t()
		: listing(0)
		, xref(0)
		, big_endian(0)
		, suppress_false_conditionals(0)
		, suppress_macro_expansion(0)
		, suppress_macro_name(0)
		, suppress_line_numbers(0)
		, verbose(1)
		, listing_bytes(32)
		{
		}
	};

	struct source_t
	{
		std::string								name;
		std::vector<std::string>				orig_line;	// unmolested original line (with no newline)
		std::vector<std::vector<std::string> >	src_line;	// broken up into vector of tokens per line
		uint64_t								file_size;
		uint32_t								line_start;

		source_t()
		: file_size(0)
		, line_start(1)
		{
		}
		int read_file(xlasm*, const std::string& n);
	};
	typedef std::unordered_map<std::string, source_t> source_map_t;

	struct symbol_t;

	struct section_t
	{
		enum
		{
			NOLOAD_FLAG		= (1<<0),
		};
	
		std::string				name;
		uint32_t				flags;
		uint32_t				index;
		int64_t					load_addr;
		int64_t					addr;
		std::vector<uint8_t>	data;
		symbol_t				*last_defined_sym;

		section_t()
		: flags(0)
		, index(0)
		, load_addr(0)
		, addr(0)
		, last_defined_sym(nullptr)
		{ }
	};
	typedef std::unordered_map<std::string, section_t> section_map_t;

	struct symbol_t
	{
		enum sym_t
		{
			UNDEFINED,
			SPECIAL,
			REGISTER,
			LABEL,
//			PROC_LABEL,
			VARIABLE,
			STRING,
			NUM_SYM_TYPES
		};

		sym_t					type;
		std::string				name;
		std::string				str;
		int64_t					value;
		uint64_t				size;
		source_t*				file_defined;
		source_t*				file_first_referenced;
		uint32_t				line_defined;
		uint32_t				line_first_referenced;
		section_t*				section;


		symbol_t()
		: type(UNDEFINED)
		, value(0)
		, size(0)
		, file_defined(nullptr)
		, file_first_referenced(nullptr)
		, line_defined(0)
		, line_first_referenced(0)
		, section(nullptr)
		{ }
	};
	typedef std::unordered_map<std::string, symbol_t> symbol_map_t;

	struct condition_t
	{
		uint8_t	state:1;
		uint8_t wastrue:1;
		uint8_t	:0;

		condition_t()
		: state(0)
		, wastrue(0)
		{ }
	};
	typedef std::stack<condition_t> condition_stack_t;

	struct macro_t
	{
		std::string					name;
		std::vector<std::string>	args;		// args[0] = macro name
		std::vector<std::string>	def;		// default value for args
		source_t					body;
		uint32_t					invoke_count;

		macro_t()
		: invoke_count(0)
		{ }
	};
	typedef std::unordered_map<std::string, macro_t> macro_map_t;

	struct context_t
	{
		enum pass_t
		{
			UNKNOWN,	// unset
			PASS_1,		// define labels and process all input, but undefined symbols are ignored (until end of pass)
			PASS_OPT,	// optimize code for smallest/fastest possible (done repeatedly until optimal or max passes exceeded)
			PASS_2,		// actually generate output (with all symbols defined)
			NUM_PASSES
		};
		uint32_t				pass;
		condition_t				conditional;
		int32_t					conditional_nesting;
		macro_t*				macroexp_ptr;
		macro_t*				macrodef_ptr;
		uint32_t				line;
		source_t*				file;
		section_t*				section;

		context_t()
		: pass(UNKNOWN)
		, conditional_nesting(0)
		, macroexp_ptr(nullptr)
		, macrodef_ptr(nullptr)
		, line(0)
		, file(0)
		, section(0)
		{}
	};
	typedef std::stack<context_t> context_stack_t;

	enum
	{
		MAXERROR_COUNT			= 100,			// aborts after this many errors
		MAXINCLUDE_STACK		= 64,			// include nest depth
		MAXMACRO_STACK			= 1024,			// nested macro depth
		MAXMACROREPS_WARNING	= 255,			// max parameters replacement iterations per line
		MAXFILL_BYTES			= 0x100000L,	// max size output by space or fill directive (safety check)
		MAX_PASSES				= 10			// maximum number of assembler passes before optimization short-circuited
	};

	enum directive_index
	{
		DIR_UNKNOWN,
		DIR_ARCH,
		DIR_CPU,
		DIR_ENDIAN,
		DIR_INCLUDE,
		DIR_INCBIN,
		DIR_ORG,
		DIR_EQU,
		DIR_UNDEFINE,
		DIR_SECTION,
		DIR_TEXTSECTION,
		DIR_DATASECTION,
		DIR_BSSSECTION,
		DIR_PREVSECTION,
		DIR_ASSIGN,
		DIR_ALIGN,
		DIR_SPACE_8,
		DIR_SPACE_16,
		DIR_SPACE_32,
		DIR_SPACE_64,
		DIR_SPACE_FLOAT,
		DIR_SPACE_DBL,
		DIR_FILL_8,
		DIR_FILL_16,
		DIR_FILL_32,
		DIR_FILL_64,
		DIR_FILL_FLOAT,
		DIR_FILL_DBL,
		DIR_DEF_HEX,
		DIR_DEF_8,
		DIR_DEF_16,
		DIR_DEF_32,
		DIR_DEF_64,
		DIR_DEF_FLOAT,
		DIR_DEF_DBL,
		DIR_DEF_ASCII,
		DIR_DEF_ASCIIZ,
		DIR_DEF_UTF16,
		DIR_DEF_UTF16Z,
		DIR_DEF_UTF32,
		DIR_DEF_UTF32Z,
		DIR_MACRO,
		DIR_ENDMACRO,
		DIR_FUNC,
		DIR_ENDFUNC,
		DIR_VOID,
		DIR_DEFFN,
		DIR_ENDFN,
		DIR_ASSERT,
		DIR_IF,
		DIR_IFSTR,
		DIR_IFSTRI,
		DIR_ELSE,
		DIR_ELSEIF,
		DIR_ENDIF,
		DIR_END,
		DIR_MSG,
		DIR_WARN,
		DIR_EXIT,
		DIR_ERROR,
	};

	struct directive_t
	{
		const char*		name;
		directive_index	index;
	};
	static const directive_t	directives_list[99];
	typedef std::unordered_map<std::string, directive_index> directive_map_t;

	typedef std::unordered_map<uint32_t, uint32_t> hint_map_t;

	Ixlarch*				arch;

	opts_t					opt;				// assembly options
	context_t				ctxt;				// current assembly context
	context_stack_t			context_stack;		// context stack for include files and macros
	section_map_t			sections;			// output sections
	source_map_t			source_files;		// map of source files (tokenized at read time)
	macro_map_t				macros;				// defined macros
	source_map_t			expanded_macros;	// source fragments from expanded macros
	symbol_map_t			symbols;			// labels and other symbols
	condition_stack_t		condition_stack;	// stack for conditional assembly
	directive_map_t			directives;			// fast lookup of directives
	hint_map_t				line_hint;			// "hint" for this virtual-line (for squeeze pass)
	std::list<std::string>	input_names;		// list of input filenames (assembled into one output)
	std::string				object_filename;	// output filename
	std::string				listing_filename;	// listing filename
	std::list<std::string>	pre_messages;
	std::list<std::string>	post_messages;


	int64_t					bytes_optimized;
	int64_t					cycles_optimized;
	uint32_t				applied_hints;
	uint32_t				pending_hints;
	FILE*					listing_file;
	uint32_t				next_section_index;
	uint32_t				error_count;
	uint32_t				warning_count;
	uint32_t				virtual_line_num;
	uint32_t				prev_virtual_line_num;
	uint32_t				pass_count;
	source_t*				last_diag_file;
	uint32_t				last_diag_line;
	int64_t					undefined_sym_count;
	symbol_t*				sym_defined;
	source_t*				line_last_file;
	section_t*				previous_section;
	section_t*				line_sec_start;
	int64_t					line_sec_addr;
	size_t					line_sec_size;
	uint16_t				crc16_value;
	bool					suppress_line_list;
	bool					suppress_line_listsource;
	bool					force_end_file;
	bool					force_exit_assembly;

	// initialize all non-constructed members architecture
	xlasm(Ixlarch* architecture)
	: arch(architecture)
	, bytes_optimized(0)
	, cycles_optimized(0)
	, applied_hints(0)
	, pending_hints(0)
	, listing_file(0)
	, next_section_index(0)
	, error_count(0)
	, warning_count(0)
	, virtual_line_num(0)
	, prev_virtual_line_num(0)
	, pass_count(0)
	, last_diag_file(nullptr)
	, last_diag_line(0)
	, undefined_sym_count(0)
	, sym_defined(nullptr)
	, line_last_file(nullptr)
	, previous_section(nullptr)
	, line_sec_start(nullptr)
	, line_sec_addr(0)
	, line_sec_size(0)
	, crc16_value(0)
	, suppress_line_list(false)
	, suppress_line_listsource(false)
	, force_end_file(false)
	, force_exit_assembly(false)
	{ }

	// external interface, gathers input and options 
	int assemble(const std::vector<std::string>& in_files, const std::string& out_file, const opts_t& opts);

	// internal functions
	int do_passes();								// read input files into memory, iterate over files for all assembler passes
	int process_file(source_t& f);					// iterate over source lines in a source_t
	int process_line();								// process a single line from source_t
	int process_line_listing();
	int process_xref();
	int process_output();
	int process_labeldef(std::string opcode);		// define a "normal" label (i.e., set to current output address)
	int process_directive(directive_index idx, const std::string& directive, const std::string& label, uint32_t cur_token, const std::vector<std::string>& tokens);
//	int process_opcode(int32_t idx, std::string& opcode, uint32_t cur_token, const std::vector<std::string>& tokens);


	// helper functions
	int			pass_reset();
	int			check_undefined();
	source_t&	expand_macro(std::string& name, uint32_t cur_token, const std::vector<std::string>& tokens);
	int64_t		eval_tokens(const std::string& cmd, std::string &exprstr, uint32_t& cur_token, const std::vector<std::string>& tokens, int expected_args, int64_t defval);
	bool 		check_truncation(const std::string& cmd, int64_t v, uint32_t b, int errwarnflag = 1);
	bool 		check_truncation_signed(const std::string& cmd, int64_t v, uint32_t b, int errwarnflag = 1);
	bool 		check_truncation_unsigned(const std::string& cmd, int64_t v, uint32_t b, int errwarnflag = 1);
	uint32_t	bits_needed_signed(int64_t v);
	uint32_t	bits_needed_unsigned(int64_t v);
	std::string removeExtension(const std::string &filename);
	std::string removeQuotes(const std::string &quotedstr);
	std::string reQuote(const std::string &str);
	std::string quotedToRaw(const std::string cmd, const std::string &str, bool null_terminate);
	int			align_output(uint64_t pot);
	int32_t		lookup_reg(const std::string& opcode, std::string& regname);
	int64_t		special_symbol(const std::string& sym_name);
	void 		add_special_sym(const char *name, symbol_t::sym_t type, int64_t value);
	void 		diag_flush();
	void 		diag_showline();
	void		update_crc16(uint8_t x);
	template <typename T> void emit(T v); // emit 1/2/4/8 bytes to current section (with proper endian)
	template <typename T> T endian_swap(T v);

	void 		error(const char *msg, ...) ATTRIBUTE((format(printf, 2, 3)));
	void 		warning(const char *msg, ...) ATTRIBUTE((format(printf, 2, 3)));
	void 		notice(int level, const char *msg, ...) ATTRIBUTE((format(printf, 3, 4)));
	std::string token_message(uint32_t cur_token, const std::vector<std::string>& tokens);

	static int64_t	symbol_value(xlasm* xl, const char *name);	// expression evaluation symbol lookup
};

#endif	// !defined(INCLUDED_XLASM_H)
