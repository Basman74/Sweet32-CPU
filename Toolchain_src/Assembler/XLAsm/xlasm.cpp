#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stdarg.h>
#include <ctype.h>
#include <assert.h>
#include <malloc.h>
//#include <direct.h>
#include <algorithm>
#include "xlasm.h"
#include "xlasmexpr.h"
#include "xlasmsweet32.h"

template <typename ToType, typename FromType>
inline static ToType union_cast(const FromType& from)
{
	static_assert(sizeof(ToType) == sizeof(FromType), "must be same size");   // the size of both union_cast types must be the same

	union
	{
		ToType		to;
		FromType	from;
	} u;

	u.from = from;
	return u.to;
};

static bool hasEnding(const std::string &fullString, const std::string &ending)
{
	if (fullString.length() >= ending.length()) {
		return (0 == fullString.compare(fullString.length() - ending.length(), ending.length(), ending));
	}
	else {
		return false;
	}
}

static void rtrim(std::string &str, const std::string &ws)
{
	size_t found;
	found = str.find_last_not_of(ws);
	if (found != std::string::npos)
		str.erase(found + 1);
	else
		str.clear();            // str is all whitespace
}

const xlasm::directive_t xlasm::directives_list[99] =
{
	{ "ARCH",		DIR_ARCH		},
	{ "CPU",		DIR_CPU			},
	{ "ENDIAN",		DIR_ENDIAN		},
	{ "INCLUDE",	DIR_INCLUDE		},
	{ "INCBIN",		DIR_INCBIN		},
	{ "ORG",		DIR_ORG			},
	{ "EQU",		DIR_EQU			},
	{ "=",			DIR_ASSIGN		},
	{ "ASSIGN",		DIR_ASSIGN		},
	{ "UNDEF",		DIR_UNDEFINE	},
	{ "UNSET",		DIR_UNDEFINE	},
	{ "SECTION",	DIR_SECTION		},
	{ "SEGMENT",	DIR_SECTION		},
	{ "TEXT",		DIR_TEXTSECTION	},
	{ "DATA",		DIR_DATASECTION	},
	{ "BSS",		DIR_BSSSECTION	},
	{ "PREVIOUS",	DIR_PREVSECTION	},
	{ "ALIGN",		DIR_ALIGN		},
	{ "SPACEDBL",	DIR_SPACE_DBL	},
	{ "SPACEB",		DIR_SPACE_8		},
	{ "SPACEH",		DIR_SPACE_16	},
	{ "SPACES",		DIR_SPACE_16	},
	{ "SPACEW",		DIR_SPACE_16	},
	{ "SPACEI",		DIR_SPACE_32	},
	{ "SPACED",		DIR_SPACE_32	},
	{ "SPACEL",		DIR_SPACE_64	},
	{ "SPACEF",		DIR_SPACE_FLOAT	},
	{ "SPACE",		DIR_SPACE_8		},
	{ "DZEROB",		DIR_SPACE_8		},
	{ "DZEROW",		DIR_SPACE_16	},
	{ "DZEROD",		DIR_SPACE_32	},
	{ "FILLDBL",	DIR_FILL_DBL	},
	{ "FILLB",		DIR_FILL_8		},
	{ "FILLH",		DIR_FILL_16		},
	{ "FILLS",		DIR_FILL_16		},
	{ "FILLW",		DIR_FILL_16		},
	{ "FILLI",		DIR_FILL_32		},
	{ "FILLD",		DIR_FILL_32		},
	{ "FILLL",		DIR_FILL_64		},
	{ "FILLF",		DIR_FILL_FLOAT	},
	{ "FILL",		DIR_FILL_8		},
	{ "HEX",		DIR_DEF_HEX		},
	{ "CHAR",		DIR_DEF_8		},
	{ "BYTE",		DIR_DEF_8		},
	{ "DB",			DIR_DEF_8		},
	{ "HALF",		DIR_DEF_16		},
	{ "SHORT",		DIR_DEF_16		},
	{ "WORD",		DIR_DEF_16		},
	{ "DWORD",		DIR_DEF_32		},
	{ "DW",			DIR_DEF_16		},
	{ "INT",		DIR_DEF_32		},
	{ "DD",			DIR_DEF_32		},
	{ "LONG",		DIR_DEF_64		},
	{ "FLOAT",		DIR_DEF_FLOAT	},
	{ "DOUBLE",		DIR_DEF_DBL		},
	{ "ASCIIZ",		DIR_DEF_ASCIIZ	},
	{ "DSZ",		DIR_DEF_ASCIIZ	},
	{ "UTF16Z",		DIR_DEF_UTF16Z	},
	{ "UTF16",		DIR_DEF_UTF16	},
	{ "UTF32Z",		DIR_DEF_UTF32Z	},
	{ "UTF32",		DIR_DEF_UTF32	},
	{ "ASCII",		DIR_DEF_ASCII	},
	{ "DS",			DIR_DEF_ASCII	},
	{ "DEFFUNC",	DIR_DEFFN		},
	{ "DEFFN",		DIR_DEFFN		},
	{ "ENDFUNC",	DIR_ENDFN		},
	{ "ENDFN",		DIR_ENDFN		},
	{ "MACRO",		DIR_MACRO		},
	{ "ENDMACRO",	DIR_ENDMACRO	},
	{ "ENDM",		DIR_ENDMACRO	},
	{ "FUNC",		DIR_FUNC		},
	{ "PROC",		DIR_FUNC		},
	{ "ENDF",		DIR_ENDFUNC		},
	{ "ENDP",		DIR_ENDFUNC		},
	{ "VOID",		DIR_VOID		},
	{ "IF",			DIR_IF			},
	{ "IFSTR",		DIR_IFSTR		},
	{ "IFSTRI",		DIR_IFSTRI		},
	{ "ELSEIF",		DIR_ELSEIF		},
	{ "ELSE",		DIR_ELSE		},
	{ "ENDIF",		DIR_ENDIF		},
	{ "END",		DIR_END			},
	{ "$END",		DIR_END			},
	{ "MSG",		DIR_MSG			},
	{ "PRINT",		DIR_MSG			},
	{ "ASSERT",		DIR_ASSERT		},
	{ "WARN",		DIR_WARN		},
	{ "ERROR",		DIR_ERROR		},
	{ "EXIT",		DIR_EXIT		},
};


void fatal_error(const char *msg, ...)
{
	va_list ap;
    va_start(ap, msg);

	printf("FATAL ERROR: ");
	vprintf(msg, ap);
	printf("\n");

	va_end(ap);

	exit(10);
}

int xlasm::assemble(const std::vector<std::string>& in_files, const std::string& out_file, const opts_t& opts)
{

	if (!in_files.size())
	{
		dprintf("No input files.\n");
		return 0;
	}

	// copy option flags
	opt = opts;

	opt.big_endian = arch->is_big_endian();

	// copy source file names
	for (auto it = in_files.begin(); it != in_files.end(); ++it)
		input_names.push_back(*it);

	// copy output file name
	object_filename = out_file;

	// listing file name
	if (opt.listing)
	{
		if (object_filename.size())
			listing_filename = removeExtension(object_filename) + ".lst";
		else
			listing_filename = removeExtension(in_files[0]) + ".lst";

	}

	if (directives.size() == 0)
	{
		for (size_t i = 0; i < NUM_ELEMENTS(directives_list) && directives_list[i].name; i++)
		{
			std::string n(directives_list[i].name);
			directive_index& d = directives[n];
			assert(d == DIR_UNKNOWN);
			d = directives_list[i].index;
		}
	}

	dprintf("Assembling " PR_DSIZET " %s file%s into output \"%s\"", in_files.size(), arch->name().c_str(), in_files.size() == 1 ? "" : "s", object_filename.c_str());
	if (opt.listing)
		dprintf(" with listing \"%s\"", listing_filename.c_str());
	dprintf("\n");

	// Read source files
	int index = 1;
	for (auto it = input_names.begin();  it != input_names.end(); ++it, index++)
	{
		source_t &f = source_files[*it];
		int e = f.read_file(this, *it);
		if (e)
			fatal_error("reading file \"%s\" error: %s", it->c_str(), strerror(e));

		dprintf("File \"%s\" read into memory (" PR_DSIZET " lines, " PR_D64 " bytes).\n", it->c_str(), source_files[*it].orig_line.size(), source_files[*it].file_size);
	}

	do_passes();

	printf("Completed assembly with %d error%s and %d warning%s.\n", error_count, error_count == 1 ? "" : "s", warning_count, warning_count == 1 ? "" : "s");
	if (error_count != 0)
		printf("\a");

	return 0;
}

// interate over all lines of files processing input
int xlasm::do_passes()
{
	add_special_sym(".",				symbol_t::SPECIAL, 0x00);
	add_special_sym(".big_endian",		symbol_t::SPECIAL, 0x00);
	add_special_sym(".BIG_ENDIAN",		symbol_t::SPECIAL, 0x00);
	add_special_sym(".little_endian",	symbol_t::SPECIAL, 0x00);
	add_special_sym(".LITTLE_ENDIAN",	symbol_t::SPECIAL, 0x00);

	// create default sections
	sections["text"].name = "text";
	sections["text"].index = 0;
	sections["data"].name = "data";
	sections["data"].index = 1;
	sections["bss"].name = "bss";
	sections["bss"].flags = section_t::NOLOAD_FLAG;
	sections["bss"].index = 2;
	
	next_section_index = 3;
	
	arch->init(this);

	if (opt.listing)
	{
		listing_file = fopen(listing_filename.c_str(), "wt");

		if (!listing_file)
			fatal_error("Opening listing file \"%s\" error: %s\n", listing_filename.c_str(), strerror(errno));
	}
	
	ctxt.pass = context_t::PASS_1;
	do
	{
		pass_reset();

		ctxt.section = &sections["text"];
		previous_section = ctxt.section;

		// iterate over all files
		for (auto fit = input_names.begin(); fit != input_names.end(); ++fit)
		{
			source_t &f = source_files[*fit];

			process_file(f);
			
			if (force_exit_assembly)
				break;
		}

		ctxt.file = nullptr;
		diag_flush();

		if (ctxt.pass == context_t::PASS_2)
			check_undefined();
		
		if (error_count)
			break;
		if (force_exit_assembly)
			break;
	} while (ctxt.pass != context_t::PASS_2);

	if (opt.listing && opt.xref)
	{
		uint32_t oldpass = ctxt.pass;
		ctxt.pass = context_t::UNKNOWN;
		process_xref();
		ctxt.pass = oldpass;
	}

	if (ctxt.pass == context_t::PASS_2 )
	{
		process_output();
	}

	return 0;
}

static bool comp_section(const xlasm::section_t* lhs, const xlasm::section_t* rhs)
{
	return lhs->index < rhs->index;
}

int xlasm::pass_reset()
{
	if (prev_virtual_line_num)
	{
		if (prev_virtual_line_num != virtual_line_num)
		{
			fatal_error("Number of processed lines (%d) differs from previous pass (%d).", virtual_line_num, prev_virtual_line_num);
		}
	}
	prev_virtual_line_num = virtual_line_num;

	std::vector<section_t*>	secs;
	for (auto it = sections.begin(); it != sections.end(); ++it)
	{
		auto& sec = it->second;
		if (!sec.data.size())
			continue;
			
		secs.push_back(&sec);
	}
	std::sort(std::begin(secs), std::end(secs), comp_section);

	int64_t addr = 0;
	for (auto it = secs.begin(); it != secs.end(); ++it)
	{
		section_t *sec = *it;
		
		if (addr >= sec->load_addr)
			sec->load_addr = addr;
		else
			addr = sec->load_addr;

		addr += sec->data.size();
		
		sec->addr = sec->load_addr;
//		dprintf("Cleared section #%d \"%s\" 0x" PR_X64 "-0x" PR_X64 " (0x" PR_X64 "/" PR_D64 " bytes)\n", sec->index, sec->name.c_str(), sec->load_addr, sec->load_addr+sec->data.size() - (sec->data.size() ? 1 : 0),
//			sec->data.size(), sec->data.size());
		sec->data.clear();
		sec->last_defined_sym = nullptr;
	}

	auto it = symbols.begin();
	while (it != symbols.end())
	{
		auto& sym = it->second;
		if (sym.type == symbol_t::UNDEFINED || sym.type == symbol_t::VARIABLE || sym.type == symbol_t::VARIABLE)
		{
//			dprintf("Erasing symbol \"%s\" (value: 0x" PR_X64 "/" PR_D64 " \"%s\")\n", sym.name.c_str(), sym.value, sym.value, sym.str.c_str());
			it = symbols.erase(it);
		}
		else
			++it;
	}
	
//	dprintf("Erasing " PR_D64 " macros\n", macros.size());
	macros.clear();
	expanded_macros.clear();
	
	line_last_file = nullptr;
	ctxt.conditional = condition_t();
	ctxt.conditional_nesting = 0;
	ctxt.macroexp_ptr = nullptr;
	ctxt.macrodef_ptr = nullptr;

	virtual_line_num = 0;

	if (ctxt.pass == context_t::PASS_1 && prev_virtual_line_num)
		ctxt.pass = context_t::PASS_OPT;

	if (ctxt.pass == context_t::PASS_OPT && pending_hints == 0)
		ctxt.pass = context_t::PASS_2;

	if (pass_count > MAX_PASSES)
	{
		warning("Maximum passes of %d exceeded, skipping optimization of final %d opcodes", MAX_PASSES, pending_hints);
		ctxt.pass = context_t::PASS_2;
	}

	if (ctxt.pass != context_t::PASS_2)
	{
		bytes_optimized = 0;
		cycles_optimized = 0;
	}

	uint32_t nonopt = pending_hints;
	uint32_t appopts = applied_hints;
	pending_hints = 0;
	applied_hints = 0;

	pass_count++;

	switch (ctxt.pass)
	{
		case context_t::PASS_1:
		{
			dprintf("Pass %d (initial)\n", pass_count);
			break;
		}
		case context_t::PASS_OPT:
		{
			dprintf("Pass %d (%d opcodes optimzied, %d pending)\n", pass_count, appopts, nonopt);
			break;
		}
		case context_t::PASS_2:
		{
			std::string saved;
			strprintf(saved, ", optimization saved 0x" PR_X64 "/" PR_D64 " bytes and " PR_D64 " cycles", bytes_optimized, bytes_optimized, cycles_optimized);
			dprintf("Pass %d (final%s)\n", pass_count, (bytes_optimized || cycles_optimized) ? saved.c_str() : "");
			break;
		}
	}

	return 0;
}

int xlasm::check_undefined()
{
	for (auto it = symbols.begin(); it != symbols.end(); ++it)
	{
		auto& sym = it->second;
		if (sym.type == symbol_t::UNDEFINED)
		{
			ctxt.file = sym.file_first_referenced;
			ctxt.line = sym.line_first_referenced;
			error("Undefined symbol \"%s\" first referenced here", sym.name.c_str());
		}
	}
	
	return 0;
}

static bool comp_section_addr(const xlasm::section_t* lhs, const xlasm::section_t* rhs)
{
	return lhs->load_addr < rhs->load_addr;
}


void xlasm::update_crc16(uint8_t x)
{
	uint16_t crc = crc16_value;
    x	^= crc>>8;
    x	^= x>>4;
	crc	= (uint16_t)(crc<<8);
	crc ^= x;
	crc ^= x<<5;
	crc ^= x<<12;
	crc16_value = (crc & 0xffff);
}

int xlasm::process_output()
{
	std::vector<section_t*>	secs;
	
	// collect output
	for (auto it = sections.begin(); it != sections.end(); ++it)
	{
		auto& sec = it->second;
		if (!sec.data.size())
			continue;
			
		secs.push_back(&sec);
	}
	
	std::sort(std::begin(secs), std::end(secs), comp_section_addr);
	
	if (!secs.size())
	{
		dprintf("No output generated.\n");
		return 0;
	}
	
	int64_t pad = 0;
	int64_t total_size = 0;
	int64_t	last = secs[0]->load_addr;
	int32_t i = 0;
	for (auto it = secs.begin(); it != secs.end(); ++it, i++)
	{
		section_t *sec = *it;

		if (sec->flags & section_t::NOLOAD_FLAG)
			continue;

		pad += sec->load_addr - last;
	
		if (!object_filename.size())
		{
			dprintf("Output section #%d \"%s\" 0x" PR_X64 "-0x" PR_X64 " (0x" PR_XSIZET "/" PR_DSIZET " bytes)%s\n", i, sec->name.c_str(), sec->load_addr, sec->load_addr+sec->data.size() - (sec->data.size() ? 1 : 0),
				sec->data.size(), sec->data.size(), sec->flags & section_t::NOLOAD_FLAG ? " NOLOAD" : "");
		}
	
		last = sec->load_addr+sec->data.size();
		
		total_size = pad + last;
	}

	FILE *out = nullptr;

	bool swe_fmt = false;
	
	crc16_value = 0xffff;
	
	if (!object_filename.size())
	{
		dprintf("Dry run - no output file: " PR_D64 " bytes (including " PR_D64 " pad bytes between sections).\n", total_size, pad);
	}
	else if (hasEnding(object_filename.c_str(), ".SWE") || hasEnding(object_filename.c_str(), ".swe"))
	{
		if (!(out = fopen(object_filename.c_str(), "wb")))
			fatal_error("opening output file \"%s\", error: %s", object_filename.c_str(), strerror(errno));

		dprintf("Writing SWE file to \"%s\" " PR_D64 " (including " PR_D64 " pad bytes between sections).\n", object_filename.c_str(), total_size, pad);
		swe_fmt = true;
		
		char header[32];
		sprintf(header, "UUSw32v%c", opt.big_endian ? '1' : '2');
		uint32_t swe_addr = (uint32_t)secs[0]->load_addr;
		swe_addr = endian_swap(swe_addr);
		uint32_t swe_size = (uint32_t)((total_size+1)>>1);
		swe_size = endian_swap(swe_size);
		
		if (fwrite(&header, 8, 1, out) != 1)
			fatal_error("writing output file \"%s\", error: %s", object_filename.c_str(), strerror(errno));
		if (fwrite(&swe_addr, 4, 1, out) != 1)
			fatal_error("writing output file \"%s\", error: %s", object_filename.c_str(), strerror(errno));
		if (fwrite(&swe_size, 4, 1, out) != 1)
			fatal_error("writing output file \"%s\", error: %s", object_filename.c_str(), strerror(errno));
	}
	else
	{
		if (!(out = fopen(object_filename.c_str(), "wb")))
			fatal_error("opening output file \"%s\", error: %s", object_filename.c_str(), strerror(errno));

		dprintf("Writing BIN file to \"%s\" " PR_D64 " bytes (including " PR_D64 " pad bytes between sections).\n", object_filename.c_str(), total_size, pad);
	}

	last = secs[0]->load_addr;
	i = 0;
	for (auto it = secs.begin(); it != secs.end(); ++it, i++)
	{
		section_t *sec = *it;
		
		if (sec->flags & section_t::NOLOAD_FLAG)
		{
			dprintf("Skipping section #%d \"%s\" 0x" PR_X64 "-0x" PR_X64 " (0x" PR_XSIZET "/" PR_DSIZET " bytes)%s\n", i, sec->name.c_str(), sec->load_addr, sec->load_addr+sec->data.size() - (sec->data.size() ? 1 : 0),
				sec->data.size(), sec->data.size(), sec->flags & section_t::NOLOAD_FLAG ? " NOLOAD" : "");
			continue;
		}
		
		pad = sec->load_addr - last;
		if (pad)
		{
			dprintf("(writing " PR_D64 " pad bytes)\n", pad);
			while (pad--)
			{
				update_crc16(0);
				if (out)
				{
					fputc(0, out);
					if (ferror(out))
						fatal_error("writing output file \"%s\", error: %s", object_filename.c_str(), strerror(errno));
				}
			}
		}
		
		dprintf("Writing section #%d \"%s\" 0x" PR_X64 "-0x" PR_X64 " (0x" PR_XSIZET "/" PR_DSIZET " bytes)%s\n", i, sec->name.c_str(), sec->load_addr, sec->load_addr+sec->data.size() - (sec->data.size() ? 1 : 0),
			sec->data.size(), sec->data.size(), sec->flags & section_t::NOLOAD_FLAG ? " NOLOAD" : "");
		
		if (out)
		{
			if (fwrite(&sec->data[0], sec->data.size(), 1, out) != 1)
				fatal_error("writing output file \"%s\", error: %s", object_filename.c_str(), strerror(errno));
		}

		for (auto cit = sec->data.begin(); cit != sec->data.end(); ++cit)
			update_crc16(*cit);

		last = sec->load_addr+sec->data.size();
	}
	
	if (swe_fmt)
	{
		if (total_size & 1)
		{
			update_crc16(0);
			if (out)
			{
				fputc(0, out);
				if (ferror(out))
					fatal_error("writing output file \"%s\", error: %s", object_filename.c_str(), strerror(errno));
			}
		}

		if (out)
		{
			if (fprintf(out, "Nd") != 2)
				fatal_error("writing output file \"%s\", error: %s", object_filename.c_str(), strerror(errno));
			uint16_t crc = endian_swap(crc16_value);
			if (fwrite(&crc, 2, 1, out) != 1)
				fatal_error("writing output file \"%s\", error: %s", object_filename.c_str(), strerror(errno));
		}
	}
	
	if (out)
		fclose(out);

	dprintf("Total output size " PR_D64 " bytes, CRC16=0x%04x, effective lines %d.\n", total_size, crc16_value, virtual_line_num);

	return 0;
}


int xlasm::process_file(source_t &f)
{
	int rc = 0;

	// reset context per file (except section and state)
	ctxt.conditional.state = 1;
	ctxt.conditional.wastrue = 1;
	ctxt.conditional_nesting = 0;
	ctxt.line = 0;
	ctxt.file = &f;

	// iterate over all lines in file
	for (ctxt.line = 0; ctxt.line < f.src_line.size(); ctxt.line++)
	{
		if ((rc = process_line()))
			break;
		
		if (error_count >= MAXERROR_COUNT)
		{
			force_exit_assembly = true;
			force_end_file = true;
		}
		
		if (force_end_file || force_exit_assembly)
			break;
	}
	force_end_file = false;

	if (error_count >= MAXERROR_COUNT)
	{
		error("Exiting due to maximum error count (%d)", error_count);
		exit(10);
	}

	if (ctxt.conditional_nesting != 0)
		warning("Ending file inside conditional IF block");

	return rc;
}

int xlasm::process_line()
{
	int rc = 0;

	const std::vector<std::string>& tokens = ctxt.file->src_line[ctxt.line];

	if (opt.verbose > 3)
	{
		std::string tokdbg;
		for (auto it = tokens.begin(); it != tokens.end(); ++it)
		{
			tokdbg += "{";
			tokdbg += *it;
			tokdbg += "}";
			if (it+1 != tokens.end())
				tokdbg += " ";
		}
		notice(0, "LINE TOKENS: %s", tokdbg.c_str());
	}
	
	std::string label;
	std::string command;
	uint32_t cur_token = 0;

	undefined_sym_count = 0;

	if (!suppress_line_list && (ctxt.macroexp_ptr == nullptr || !opt.suppress_macro_expansion))
	{
		line_sec_start = ctxt.section;
		line_sec_addr = line_sec_start->addr;
		line_sec_size = line_sec_start->data.size();
	}

	// parse a label if this line defines one
	if (tokens.size() && tokens[cur_token].back() == ':')
	{
		label.assign(tokens[cur_token].begin(), tokens[cur_token].end()-1);	// remove colon
		cur_token++;
	}

	// if more tokens, look for directive/mnemonic
	if (cur_token < tokens.size())
	{
		auto &tok = tokens[cur_token];

		if (tok[0] == '.')
			command.assign(tok.begin() + 1, tok.end());
		else
			command.assign(tok.begin(), tok.end());

		// make keyword uppercase for comparison and to stand out in error messages
		std::transform(command.begin(), command.end(), command.begin(), ::toupper);

//		dprintf("command = '%s' ", command.c_str());
			
		// check if it is a directive
		directive_index directive_idx = DIR_UNKNOWN;
		auto it = directives.find(command);
		if (it != directives.end())
		{
			directive_idx = it->second;
			cur_token++;
		}
		
//		dprintf("%s\n", directive_idx == DIR_UNKNOWN ? "not found" : " found");

		if (directive_idx != DIR_UNKNOWN || ctxt.macrodef_ptr != nullptr)
		{
			rc = process_directive(directive_idx, command, label, cur_token, tokens);
		}
		else if (ctxt.conditional.state)
		{
			if (macros.count(command) == 1)
			{
				if (label.size())
					process_labeldef(label);

				if (context_stack.size() > MAXMACRO_STACK)
				{
					fatal_error("%s(%d): Exceeded maximum MACRO nesting depth of %d levels", ctxt.file->name.c_str(), ctxt.line+ctxt.file->line_start, MAXMACRO_STACK);
				}

				if (!opt.suppress_macro_expansion)
					process_line_listing();
				context_stack.push(ctxt);
				
				source_t&  m = expand_macro(command, cur_token, tokens);

				process_file(m);
				ctxt = context_stack.top();
				context_stack.pop();
				
				if (!opt.suppress_macro_expansion)
					suppress_line_list = true;

				notice(3, "Resuming after MACRO \"%s\"", command.c_str());
			}
			else
			{
				// check if it is an opcode
				int32_t opcode_idx = arch->check_opcode(command);

				if (opcode_idx != -1)
				{
					if (label.size())
						process_labeldef(label);

					cur_token++;

					rc = arch->process_opcode(this, opcode_idx, command, cur_token, tokens);
				}
				else
				{
					error("Unrecognized opcode or directive \"%s\"", tokens[cur_token].c_str());
				}
			}
		}
	}
	else if (label.size() && ctxt.conditional.state)	// only a label present & conditional true
	{
		process_labeldef(label);
	}
	else if (ctxt.macrodef_ptr != nullptr)
	{
		rc = process_directive(DIR_UNKNOWN, command, label, cur_token, tokens);
	}
	
	process_line_listing();

	if (error_count >= MAXERROR_COUNT)
	{
		force_exit_assembly = true;
		force_end_file = true;
	}
	virtual_line_num++;

	return rc;
}

int xlasm::process_line_listing()
{
	// listing
	int32_t bit_width = arch->max_bit_width();
	
	if (suppress_line_list || (ctxt.macroexp_ptr != nullptr && opt.suppress_macro_expansion) || (!ctxt.conditional.state && opt.suppress_false_conditionals) )
	{
		suppress_line_list = false;
		std::string	outline;
		for (auto it = pre_messages.begin(); it != pre_messages.end(); ++it)
		{
			strprintf(outline, "       ");
			if (bit_width > 32)
				strprintf(outline, "                  ");
			else if (bit_width > 16)
				strprintf(outline, "          ");
			else
				strprintf(outline, "      ");
			
			strprintf(outline, "%s\n", it->c_str());
		}
		pre_messages.clear();
		for (auto it = post_messages.begin(); it != post_messages.end(); ++it)
		{
			strprintf(outline, "       ");
			if (bit_width > 32)
				strprintf(outline, "                  ");
			else if (bit_width > 16)
				strprintf(outline, "          ");
			else
				strprintf(outline, "      ");
			
			strprintf(outline, "%s\n", it->c_str());
		}
		post_messages.clear();
		if (listing_file && outline.size())
			fputs(outline.c_str(), listing_file);
		return 0;
	}
	
	if (ctxt.pass == context_t::PASS_2 && opt.listing && ctxt.file)
	{
		std::string	outline;
		bool show_value = false;
		bool show_section_name = false;
		
		if (!line_last_file || line_last_file->name != ctxt.file->name)
		{
			strprintf(outline, "File: %s\n", ctxt.file->name.c_str());
			line_last_file = ctxt.file;
		}

		for (auto it = pre_messages.begin(); it != pre_messages.end(); ++it)
		{
			strprintf(outline, "       ");
			if (bit_width > 32)
				strprintf(outline, "                  ");
			else if (bit_width > 16)
				strprintf(outline, "          ");
			else
				strprintf(outline, "      ");
			
			strprintf(outline, "%s\n", it->c_str());
		}
		pre_messages.clear();

		if (line_sec_start != ctxt.section)
			show_section_name = true;	

		if (!opt.suppress_line_numbers)
		{
			if (suppress_line_listsource)
				strprintf(outline, "       ");
			else
				strprintf(outline, "%6d ", ctxt.line + ctxt.file->line_start);
		}
		
		int64_t v = 0;
		if (sym_defined != nullptr && sym_defined->type != symbol_t::UNDEFINED && sym_defined->type != symbol_t::STRING)
		{
			v = sym_defined->value;
			show_value = true;
		}
		else if (line_sec_addr != ctxt.section->addr)
		{
			v = ctxt.section->addr + ctxt.section->data.size();
			show_value = true;
		}
		
		if (line_sec_start == ctxt.section && line_sec_addr == ctxt.section->addr && line_sec_size != ctxt.section->data.size())
		{
			if (bit_width > 32)
				strprintf(outline, "%016llX: ", (long long) line_sec_addr+line_sec_size);
			else if (bit_width > 16)
				strprintf(outline, "%08llX: ", (long long)line_sec_addr + line_sec_size);
			else
				strprintf(outline, "%04llX: ", (long long)line_sec_addr + line_sec_size);
		}
		else if (show_value || line_sec_start != ctxt.section || line_sec_addr != ctxt.section->addr)
		{
			if (bit_width > 32)
				strprintf(outline, "%016llX= ", (long long) v);
			else if (bit_width > 16)
				strprintf(outline, "%08llX= ", (long long) v);
			else
				strprintf(outline, "%04llX= ", (long long) v);
		}
		else
		{
			if (bit_width > 32)
				strprintf(outline, "                  ");
			else if (bit_width > 16)
				strprintf(outline, "          ");
			else
				strprintf(outline, "      ");
		}

		if (show_section_name)
		{
			std::string secname;
			strprintf(secname, "[%.22s]", ctxt.section->name.c_str());
			strprintf(outline, "%s", secname.c_str());
		}
		else if (!ctxt.conditional.state)
		{
			strprintf(outline, "%-22.22s", "<false>");
		}
		else
		{
			for (int i = 0; i < 8; i++)
			{
				if (line_sec_start == ctxt.section && line_sec_size+i < ctxt.section->data.size())
				{
					if (ctxt.section->flags & section_t::NOLOAD_FLAG)
						strprintf(outline, "..");
					else
						strprintf(outline, "%02X", ctxt.section->data[line_sec_size+i]);
				}
				else
					strprintf(outline, "  ");
			}
		}

		if (!suppress_line_listsource)
			strprintf(outline, "\t%s", ctxt.file->orig_line[ctxt.line].c_str());
		else
			strprintf(outline, "\t<alignment pad>");
		
		if (opt.listing_bytes > 8 && line_sec_start == ctxt.section && line_sec_size+8 < ctxt.section->data.size())
		{
			for (uint32_t i = 8; i < opt.listing_bytes; i++)
			{
				if (((i - 8) & 0x7) == 0 && line_sec_size+i < ctxt.section->data.size())
				{
					strprintf(outline, "\n       ");
					if (bit_width > 32)
						strprintf(outline, "%016lX: ", line_sec_addr+line_sec_size+i);
					else if (bit_width > 16)
						strprintf(outline, "%08lX: ", line_sec_addr+line_sec_size+i);
					else
						strprintf(outline, "%04lX: ", line_sec_addr+line_sec_size+i);
				}
				if (line_sec_size+i < ctxt.section->data.size())
				{
					if (ctxt.section->flags & section_t::NOLOAD_FLAG)
						strprintf(outline, "..");
					else
						strprintf(outline, "%02X", ctxt.section->data[line_sec_size+i]);
				}
			}
			
			if (line_sec_size + opt.listing_bytes < ctxt.section->data.size())
				strprintf(outline, "+");
		}

		outline += '\n';

		for (auto it = post_messages.begin(); it != post_messages.end(); ++it)
		{
			strprintf(outline, "       ");
			if (bit_width > 32)
				strprintf(outline, "                  ");
			else if (bit_width > 16)
				strprintf(outline, "          ");
			else
				strprintf(outline, "      ");
			
			strprintf(outline, "%s\n", it->c_str());
		}
		post_messages.clear();
	
		if (listing_file)
			fputs(outline.c_str(), listing_file);
	}

	sym_defined = nullptr;
	
	return 0;
}

static bool comp_xref_name(const xlasm::symbol_t* lhs, const xlasm::symbol_t* rhs)
{
	return lhs->name < rhs->name;
}

static bool comp_xref_value(const xlasm::symbol_t* lhs, const xlasm::symbol_t* rhs)
{
	return lhs->value < rhs->value;
}

int xlasm::process_xref()
{
	if (!listing_file)
		return 0;

	std::vector<const symbol_t*>	sym_xref;
	
	for (auto it = symbols.begin(); it != symbols.end(); ++it)
	{
		auto& sym = it->second;
		
		if (sym.type == symbol_t::REGISTER || sym.type == symbol_t::SPECIAL)
			continue;
		
		if (sym.type == symbol_t::STRING)
		{
			expression expr;
			int64_t result = -1;
			expr.evaluate(this, sym.str.c_str(), &result);
			sym.value = result;
		}
		sym_xref.push_back(&sym);
	}

	std::sort(sym_xref.begin(), sym_xref.end(), comp_xref_name);
	
	fprintf(listing_file, "\n\nSymbols (sorted by name):\n\n");
	
	for (auto it = std::begin(sym_xref); it != std::end(sym_xref); ++it)
	{
		std::string outline;
		std::string valstr;
		char typ = '?';
		
		const symbol_t *sym = *it;
		
		switch (sym->type)
		{
			case symbol_t::SPECIAL:		typ = 'I';	break;
			case symbol_t::LABEL:		typ = 'L';	break;
			case symbol_t::VARIABLE:	typ = 'V';	break;
			case symbol_t::STRING:		typ = 'S';	break;
			case symbol_t::REGISTER:	typ = 'R';	break;
			case symbol_t::UNDEFINED:	typ = 'U';	break;
			default:
				break;
		}
		strprintf(valstr, "0x" PR_X64 " / " PR_D64 "", sym->value, sym->value);
		strprintf(outline, "%c %-32.32s = %-32.32s", typ, sym->name.c_str(), valstr.c_str());
		if (sym->type == symbol_t::STRING)
			strprintf(outline, "\"%.64s\"", sym->str.c_str());
		strprintf(outline, "\n");
		
		fputs(outline.c_str(), listing_file);
	}
	
	std::sort(std::begin(sym_xref), std::end(sym_xref), comp_xref_value);
	
	fprintf(listing_file, "\n\nSymbols (sorted by value):\n\n");

	for (auto it = std::begin(sym_xref); it != std::end(sym_xref); ++it)
	{
		std::string outline;
		std::string valstr;
		char typ = '?';
		
		const symbol_t *sym = *it;
		
		switch (sym->type)
		{
			case symbol_t::SPECIAL:		typ = 'I';	break;
			case symbol_t::LABEL:		typ = 'L';	break;
			case symbol_t::VARIABLE:	typ = 'V';	break;
			case symbol_t::STRING:		typ = 'S';	break;
			case symbol_t::REGISTER:	typ = 'R';	break;
			case symbol_t::UNDEFINED:	typ = 'U';	break;
			default:
				break;
		}
		strprintf(valstr, "0x" PR_X64 " / " PR_D64 "", sym->value, sym->value);
		strprintf(outline, "%c %-32.32s = %-32.32s", typ, sym->name.c_str(), valstr.c_str());
		if (sym->type == symbol_t::STRING)
			strprintf(outline, "\"%.64s\"", sym->str.c_str());
		strprintf(outline, "\n");
		
		fputs(outline.c_str(), listing_file);
	}
	
	return 0;
}

int xlasm::process_directive(directive_index idx, const std::string& directive, const std::string& label, uint32_t cur_token, const std::vector<std::string>& tokens)
{
	// macro directives first (only if conditional true)
	if (ctxt.conditional.state)
	{
		switch (idx)
		{
			// MACRO ===============================
			case DIR_MACRO:
			{
				if (label.size())
				{
					error("Label definition not permitted on %s", directive.c_str());
				}

				if (ctxt.macrodef_ptr != nullptr)
				{
					error("Nested %s definitions not permitted", directive.c_str());
					return 0;
				}

				if (tokens.size() - cur_token < 1)
				{
					error("Missing %s name", directive.c_str());
					return 0;
				}

				const std::string& name = tokens[cur_token];
				std::string upr_name = name;

				std::transform(upr_name.begin(), upr_name.end(), upr_name.begin(), ::toupper);

				if (!isalpha(upr_name[0]) && !isdigit(upr_name[0]) && upr_name[0] != '_')
				{
					error("Illegal %s name \"%s\"", directive.c_str(), name.c_str());
					return 0;
				}
				
				macro_t &m = macros[upr_name];

				if (m.args.size() != 0)
				{
					error("%s redefinition of \"%s\" not permitted", directive.c_str(), upr_name.c_str());
					return 0;
				}

				notice(3, "Defining %s \"%s\"", directive.c_str(), name.c_str());

				for (auto it = tokens.begin()+cur_token; it != tokens.end(); ++it)
				{
					if (!isalpha((*it)[0]) && !isdigit((*it)[0]) && (*it)[0] != '_')
					{
						error("%s \"%s\" illegal parameter name \"%s\"", directive.c_str(), name.c_str(), it->c_str());
						return 0;
					}

					bool dupe = false;
					for (auto mit = m.args.begin(); mit != m.args.end(); ++mit)
					{
						if (*it == *mit)
						{
							dupe = true;
							break;
						}
					}

					if (dupe)
					{
						error("%s \"%s\" duplicated parameter name \"%s\"", directive.c_str(), name.c_str(), it->c_str());
					}

					m.args.push_back(*it);

					std::string def;

					if (it != tokens.begin()+cur_token && it+1 != tokens.end() && it[1] == "=" && it+2 != tokens.end())
					{
						for (it+=2; it != tokens.end() && *it != ","; ++it)
						{
							if (def.size())
								def += " ";
							def += *it;
						}
					}

					m.def.push_back(removeQuotes(def));

					if (it == tokens.end())
						break;
				}
				m.name = name;
				m.body.line_start = ctxt.line+2;
				m.body.name = ctxt.file->name;

				ctxt.macrodef_ptr = &m;

				return 0;
			}
			break;

			// ENDMACRO ===============================
			case DIR_ENDMACRO:
			{
				if (ctxt.macrodef_ptr == nullptr)
				{
					error("%s encountered without matching MACRO", directive.c_str());
					return 0;
				}

				if (label.size())
				{
					error("Label definition not permitted on %s", directive.c_str());
				}

				if (tokens.size() - cur_token != 0)
					error("" PR_D64 " extra token%s after %s", (tokens.size()-cur_token), (tokens.size()-cur_token)==1 ? "" : "s", directive.c_str());

				notice(3, "%s for MACRO \"%s\" (" PR_D64 " lines)", directive.c_str(), ctxt.macrodef_ptr->name.c_str(), ctxt.macrodef_ptr->body.src_line.size());

				ctxt.macrodef_ptr = nullptr;

				return 0;
			}
			break;

		default:
			break;
		}
	}

	// if defining a macro, save other directives/opcodes for processing when macro is invoked
	if (ctxt.macrodef_ptr != nullptr)
	{
		ctxt.macrodef_ptr->body.src_line.push_back(tokens);
		ctxt.macrodef_ptr->body.file_size += ctxt.file->orig_line[ctxt.line].size();
		return 0;
	}

	// directives processed even if condition false
	switch (idx)
	{
		// IF ===============================
		case DIR_IF:
		{
			if (label.size())
			{
				error("Label definition not permitted on %s", directive.c_str());
			}

			std::string exprstr;
			int64_t result = eval_tokens(directive, exprstr, cur_token, tokens, 1, 0);

			condition_stack.push(ctxt.conditional);

			ctxt.conditional.state = (result != 0) ? 1 : 0;
			ctxt.conditional.wastrue = ctxt.conditional.state;
			ctxt.conditional_nesting++;

			notice(2, "conditional %s (%s) is %s", directive.c_str(), exprstr.c_str(), ctxt.conditional.state ? "true" : "false");

			return 0;
		}

		// IFSTREQ/IFSTRNE/IFSTREQI/IFSTRNEI ===============================
		case DIR_IFSTR:
		case DIR_IFSTRI:
		{
			if (label.size())
			{
				error("Label definition not permitted on %s", directive.c_str());
			}

			if ((tokens.size() - cur_token) != 3)
			{
				error("Directive %s requires two string arguments separated by string operator", directive.c_str());
				break;
			}

			static const char* str_ops[] = { "==", "!=", "<", "<=", ">", ">=", "contains" };

			int str_op = -1;
			for (size_t i = 0; i < (sizeof(str_ops) / sizeof(str_ops[0])); i++)
			{
				if (tokens[cur_token + 1] == str_ops[i])
				{
					str_op = (int)i;
					break;
				}
			}

			if (str_op < 0)
			{
				error("Directive %s requires operator ==, !=, <, <=, >, >= or \"contains\"", directive.c_str());
				break;
			}

			std::string exprstr1;
			if (tokens[cur_token][0] == '\"' || tokens[cur_token][0] == '\'')
			{
				exprstr1 = removeQuotes(tokens[cur_token]);
			}
			else
			{
				symbol_t &sym = symbols[tokens[cur_token]];
				if (sym.type == symbol_t::UNDEFINED)
				{
					if (!sym.name.size())
						sym.name = tokens[cur_token];
//					if (ctxt.pass == context_t::PASS_2)
//						warning("Evaluating undefined string symbol \"%s\" as \"\"", sym.name.c_str());

					if (!sym.file_first_referenced)
					{
						sym.file_first_referenced = ctxt.file;
						sym.line_first_referenced = ctxt.line;
					}
					undefined_sym_count++;
				}
				else if (sym.type == symbol_t::STRING)
					exprstr1 = sym.str;
				else if (ctxt.pass == context_t::PASS_2)
					warning("Evaluating non-string symbol \"%s\" as \"\"", sym.name.c_str());
			}

			std::string exprstr2;
			if (tokens[cur_token + 2][0] == '\"' || tokens[cur_token + 2][0] == '\'')
			{
				exprstr2 = removeQuotes(tokens[cur_token + 2]);
			}
			else
			{
				symbol_t &sym = symbols[tokens[cur_token + 2]];
				if (sym.type == symbol_t::UNDEFINED)
				{
					if (!sym.name.size())
						sym.name = tokens[cur_token + 2];
//					if (ctxt.pass == context_t::PASS_2)
//						warning("Evaluating undefined string symbol \"%s\" as \"\"", sym.name.c_str());

					if (!sym.file_first_referenced)
					{
						sym.file_first_referenced = ctxt.file;
						sym.line_first_referenced = ctxt.line;
					}
					undefined_sym_count++;
				}
				else if (sym.type == symbol_t::STRING)
					exprstr2 = sym.str;
				else if (ctxt.pass == context_t::PASS_2)
					warning("Evaluating non-string symbol \"%s\" as \"\"", sym.name.c_str());
			}

			if (idx == DIR_IFSTRI)
			{
				std::transform(exprstr1.begin(), exprstr1.end(), exprstr1.begin(), ::toupper);
				std::transform(exprstr2.begin(), exprstr2.end(), exprstr2.begin(), ::toupper);
			}

			bool result = false;

			switch (str_op)
			{
			case 0:	// ==
				result = (exprstr1 == exprstr2);
				break;
			case 1:	// !=
				result = (exprstr1 != exprstr2);
				break;
			case 2:	// <
				result = (exprstr1 < exprstr2);
				break;
			case 3:	// <=
				result = (exprstr1 <= exprstr2);
				break;
			case 4:	// >
				result = (exprstr1 > exprstr2);
				break;
			case 5:	// >=
				result = (exprstr1 >= exprstr2);
				break;
			case 6:	// ~=
			case 7:	// contains
				result = (exprstr1.find(exprstr2) != std::string::npos);
				break;
			default:
				assert(false);
				break;
			}

			condition_stack.push(ctxt.conditional);

			ctxt.conditional.state = (result != 0) ? 1 : 0;
			ctxt.conditional.wastrue = ctxt.conditional.state;
			ctxt.conditional_nesting++;

			notice(2, "conditional %s (%s %s %s) is %s", directive.c_str(), exprstr1.c_str(), str_ops[str_op], exprstr2.c_str(), ctxt.conditional.state ? "true" : "false");

			return 0;
		}

		// ELSEIF ===============================
		case DIR_ELSEIF:
		{
			if (label.size())
			{
				error("Label definition not permitted on %s", directive.c_str());
			}

			if (condition_stack.empty())
			{
				error("%s encountered outside IF/ENDIF block", directive.c_str());
				break;
			}

			std::string exprstr;
			int64_t result = eval_tokens(directive, exprstr, cur_token, tokens, 1, 0);

			ctxt.conditional.state = !(ctxt.conditional.wastrue) && (result != 0) ? 1 : 0;
			ctxt.conditional.wastrue |= ctxt.conditional.state;

			notice(2, "conditional %s (%s) is %s", directive.c_str(), exprstr.c_str(), ctxt.conditional.state ? "true" : "false");

			return 0;
		}

		// ELSE ===============================
		case DIR_ELSE:
		{
			if (label.size())
			{
				error("Label definition not permitted on %s", directive.c_str());
			}

			if (tokens.size() - cur_token != 0)
				error("" PR_D64 " extra token%s after %s", (tokens.size()-cur_token), (tokens.size()-cur_token)==1 ? "" : "s", directive.c_str());

			if (condition_stack.empty())
			{
				error("%s encountered outside IF/ENDIF block", directive.c_str());
				break;
			}

			ctxt.conditional.state = !(ctxt.conditional.wastrue) ? 1 : 0;
			ctxt.conditional.wastrue |= ctxt.conditional.state;

			notice(2, "conditional %s is %s", directive.c_str(), ctxt.conditional.state ? "true" : "false");

			return 0;
		}

		// ENDIF ===============================
		case DIR_ENDIF:
		{
			if (label.size())
			{
				error("Label definition not permitted on %s", directive.c_str());
			}

			if (tokens.size() - cur_token != 0)
				error("" PR_D64 " extra token%s after %s", (tokens.size()-cur_token), (tokens.size()-cur_token)==1 ? "" : "s", directive.c_str());

			if (condition_stack.empty())
			{
				error("ENDIF encountered without matching IF");
				return 0;
			}

			bool prev_cond = ctxt.conditional.state;
	
			condition_stack.pop();

			if (condition_stack.empty())
			{
				ctxt.conditional.state = 1;
				ctxt.conditional.wastrue = 1;
			}
			else
				ctxt.conditional = condition_stack.top();

			ctxt.conditional_nesting--;
			
			if (!prev_cond && opt.suppress_false_conditionals)
				suppress_line_list = true;

			notice(2, "conditional %s resumes %s", directive.c_str(), ctxt.conditional.state ? "true" : "false");

			return 0;
		}

		default:
			break;
	}

	// ignore any of the following directives if the conditional assembly condition if false
	if (!ctxt.conditional.state)
	{
		return 0;
	}

	switch (idx)
	{
		// INCLUDE ===============================
		case DIR_ENDIAN:
		{
			if (tokens.size() - cur_token < 1)
			{
				opt.big_endian = arch->is_big_endian();
			}
			else
			{
				char bo = toupper((tokens[cur_token])[0]);
				if (bo == 'L')
				{
					opt.big_endian = 0;
				}
				else if (bo == 'B')
				{
					opt.big_endian = 1;
				}
				else
				{
					error("Unrecognized %s byte-order option \"%c\" (\"B\" big-endian or \"L\" little-endian)", directive.c_str(), bo);
				}
			}
			
			if (opt.big_endian)
				notice(2, "%s set to big-endian (MSB in lowest byte address)", directive.c_str());
			else
				notice(2, "%s set to little-endian (LSB in lowest byte address)", directive.c_str());

			return 0;
		}

		// INCLUDE ===============================
		case DIR_INCLUDE:
		{
			if (label.size())
			{
				error("Label definition not permitted on %s", directive.c_str());
			}

			if (ctxt.macrodef_ptr != nullptr)
			{
				error("%s not permitted in MACRO definition", directive.c_str());

				return 0;
			}

			if (tokens.size() - cur_token > 1)
			{
				error("" PR_D64 " extra token%s after %s filename", (tokens.size()-cur_token-1), (tokens.size()-cur_token-1)==1 ? "" : "s", directive.c_str());
			}
			else if (tokens.size() - cur_token < 1)
			{
				error("missing %s filename", directive.c_str());

				return 0;
			}

			if (context_stack.size() > MAXINCLUDE_STACK)
			{
				fatal_error("%s(%d): Exceeded maximum %s file nesting depth of %d files", ctxt.file->name.c_str(), ctxt.line+ctxt.file->line_start, directive.c_str(), MAXINCLUDE_STACK);
			}

			std::string name = removeQuotes(tokens[cur_token]);
			source_t &f = source_files[name];
			int e = f.read_file(this, name);
			if (e)
				fatal_error("%s(%d): Error reading %s file \"%s\": %s", ctxt.file->name.c_str(), ctxt.line+ctxt.file->line_start, directive.c_str(), name.c_str(), strerror(e));
				
			process_line_listing();

			notice(2, "Including file \"%s\" (" PR_D64 " lines, " PR_D64 " bytes)", name.c_str(), f.orig_line.size(), f.file_size);
			context_stack.push(ctxt);
			process_file(f);
			ctxt = context_stack.top();
			context_stack.pop();
			notice(2, "Resuming after %s of file \"%s\"", directive.c_str(), name.c_str());

			suppress_line_list = true;

			return 0;
		}

		// EQU ===============================
		case DIR_EQU:
		{
			if (!label.size())
			{
				error("Expected symbol definition before %s", directive.c_str());

				return 0;
			}

			std::string exprstr;
			int64_t result = 0;
			
			if (tokens[cur_token][0] != '\"' && tokens[cur_token][0] != '\'')
				result = eval_tokens(directive, exprstr, cur_token, tokens, 1, 0);
			else
				exprstr = removeQuotes(tokens[cur_token]);

			symbol_t& sym = symbols[label];

			if (sym.type == symbol_t::UNDEFINED)
			{
				sym.type			= symbol_t::STRING;
				sym.name			= label;
				sym.str				= exprstr;
				sym.line_defined	= ctxt.line;
				sym.file_defined	= ctxt.file;
				sym.section			= ctxt.section;
				sym.value 			= result;

				notice(3, "Defined symbol \"%s\" %s 0x" PR_X64 "/" PR_D64 "", label.c_str(), directive.c_str(), sym.value, sym.value);
			}
			else
			{
				if (sym.type != symbol_t::STRING || sym.line_defined != ctxt.line || sym.file_defined != ctxt.file)
				{
					error("Duplicate symbol definition: \"%s\" first at %s(%d)", label.c_str(), sym.file_defined->name.c_str(), sym.line_defined);

					return 0;
				}

				sym.str				= exprstr;
				sym.section			= ctxt.section;
				sym.value			= result;
			}
			sym_defined = &sym;

			return 0;
		}

		// ASSIGN (=) ===============================
		case DIR_ASSIGN:
		{
			if (!label.size())
			{
				error("Expected variable definition before %s", directive.c_str());

				return 0;
			}

			std::string exprstr;
			int64_t result = eval_tokens(directive, exprstr, cur_token, tokens, 1, 0);

			symbol_t& sym = symbols[label];

			if (sym.type == symbol_t::UNDEFINED)
			{
				sym.type			= symbol_t::VARIABLE;
				sym.name			= label;
				sym.line_defined	= ctxt.line;
				sym.file_defined	= ctxt.file;
				sym.section			= ctxt.section;
				sym.value 			= result;
			}
			else
			{
				if (sym.type != symbol_t::VARIABLE)
				{
					error("Cannot assign to non-variable: \"%s\" defined at %s(%d)", label.c_str(), sym.file_defined->name.c_str(), sym.line_defined);

					return 0;
				}

				assert(sym.name == label);
				sym.line_defined	= ctxt.line;
				sym.file_defined	= ctxt.file;
				sym.section			= ctxt.section;
				sym.value			= result;
			}

			notice(3, "Assigned variable \"%s\" = 0x" PR_X64 "/" PR_D64 "", label.c_str(), sym.value, sym.value);
			sym_defined = &sym;
		
			return 0;
		}

		// UNDEFINE (UNDEF, UNSET) ===============================
		case DIR_UNDEFINE:
		{
			if (!label.size())
			{
				error("Expected variable definition before %s", directive.c_str());
				return 0;
			}

			if (tokens.size() - cur_token != 0)
				error("" PR_D64 " extra token%s after %s", (tokens.size()-cur_token), (tokens.size()-cur_token)==1 ? "" : "s", directive.c_str());

			symbol_t::sym_t otype = symbols[label].type;
			std::string ntype;

			switch(otype)
			{
				case symbol_t::SPECIAL:
					error("%s used on special symbol \"%s\"", directive.c_str(), label.c_str());
					return 0;
				case symbol_t::REGISTER:
					error("%s used on register symbol \"%s\"", directive.c_str(), label.c_str());
					return 0;
				case symbol_t::UNDEFINED:
					ntype = "undefined";
					break;
				case symbol_t::LABEL:
					ntype = "label";
					break;
				case symbol_t::VARIABLE:
					ntype = "variable";
					break;
				case symbol_t::STRING:
					ntype = "string";
					break;
				default:
					assert(0);
			}
			
			symbols.erase(label);
			notice(3, "%s %s symbol \"%s\"", directive.c_str(), ntype.c_str(), label.c_str());
		
			return 0;
		}

		// ASSERT ===============================
		case DIR_ASSERT:
		{
			if (ctxt.pass != context_t::PASS_2)
				return 0;

			if (label.size())
			{
				error("Label definition not permitted on %s", directive.c_str());
			}

			std::string exprstr;
			int64_t result = eval_tokens(directive, exprstr, cur_token, tokens, 2, 0);

			if (result == 0)
			{
				std::string msg = token_message(cur_token, tokens);
				error("%s failed (%s)%s%s", directive.c_str(), exprstr.c_str(), msg.size() ? ": " : "", msg.c_str());
			}

			return 0;
		}

		// MSG ===============================
		case DIR_MSG:
		{
			if (ctxt.pass != context_t::PASS_2)
				return 0;

			std::string msg = token_message(cur_token, tokens);
			notice(1, "%s %s", directive.c_str(), msg.c_str());
			return 0;
		}

		// WARN ===============================
		case DIR_WARN:
		{
			if (ctxt.pass != context_t::PASS_2)
				return 0;

			std::string msg = token_message(cur_token, tokens);
			warning("%s %s", directive.c_str(), msg.c_str());
			return 0;
		}

		// ERROR ===============================
		case DIR_ERROR:
		{
			if (ctxt.pass != context_t::PASS_2)
				return 0;

			std::string msg = token_message(cur_token, tokens);
			error("%s %s",  directive.c_str(), msg.c_str());
			return 0;
		}

		// EXIT ===============================
		case DIR_EXIT:
		{
			if (ctxt.pass != context_t::PASS_2)
				return 0;

			std::string msg = token_message(cur_token, tokens);
			error("%s %s",  directive.c_str(), msg.c_str());
			
			force_end_file = true;
			force_exit_assembly = true;
			
			return 0;
		}
		
		case DIR_ORG:
		{
			if (label.size())
			{
				error("Label definition not permitted on %s", directive.c_str());
			}

			std::string exprstr;
			int64_t origin = eval_tokens(directive, exprstr, cur_token, tokens, 1, ctxt.section->addr);
			
			if (!ctxt.section->data.size())
				ctxt.section->load_addr = origin;

			ctxt.section->addr = origin - ctxt.section->data.size();

			return 0;
		}

		case DIR_SECTION:
		{
			if (label.size())
			{
				error("Label definition not permitted on %s", directive.c_str());
			}

			if (tokens.size() - cur_token < 1)
			{
				error("%s missing required name", directive.c_str());
				return 0;
			}
			std::string segname = removeQuotes(tokens[cur_token++]);
			uint32_t flags = 0;
			
			bool addr_given = false;
			int64_t addr = 0;
			if (cur_token < tokens.size() && tokens[cur_token] == ",")
			{
				cur_token++;
				if (cur_token >= tokens.size() || tokens[cur_token] != ",")
				{
					std::string exprstr;
					addr = eval_tokens(directive, exprstr, cur_token, tokens, 0, 0);
					addr_given = true;
				}
			}

			if (cur_token < tokens.size() && tokens[cur_token] == ",")
			{
				cur_token++;
				if (cur_token < tokens.size())
				{
					std::string flag_name = tokens[cur_token++];
					std::transform(flag_name.begin(), flag_name.end(), flag_name.begin(), ::tolower);
					
					if (flag_name == "noload")
						flags |= section_t::NOLOAD_FLAG;
				}
				else
					error("%s missing flags after \",\"", directive.c_str());
			}
			
			if (cur_token != tokens.size())
				error("Unexpected additional arguments for %s", directive.c_str());			
			
			section_t &seg = sections[segname];
			
			if ((addr_given || flags != 0) && seg.load_addr != addr && seg.data.size() != 0)
			{
				error("%s can't redefine non-empty section \"%s\"", directive.c_str(), segname.c_str());
				return 0;
			}

			if (!seg.name.size())
			{
				seg.name = segname;
				seg.index = next_section_index++;
				seg.flags = flags;
			}
			
			if (addr_given)
			{
				seg.load_addr = addr;
				seg.addr = addr;
			}

			previous_section = ctxt.section;
			ctxt.section = &seg;

			return 0;
		}

		case DIR_TEXTSECTION:
		case DIR_DATASECTION:
		case DIR_BSSSECTION:
		case DIR_PREVSECTION:
		{
			if (tokens.size() - cur_token != 0)
				error("" PR_D64 " extra token%s after %s", (tokens.size()-cur_token), (tokens.size()-cur_token)==1 ? "" : "s", directive.c_str());
				
			switch (idx)
			{
				case DIR_TEXTSECTION:
					previous_section = ctxt.section;
					ctxt.section = &sections["text"];
					break;
				case DIR_DATASECTION:
					previous_section = ctxt.section;
					ctxt.section = &sections["data"];
					break;
				case DIR_BSSSECTION:
					previous_section = ctxt.section;
					ctxt.section = &sections["bss"];
					break;
				case DIR_PREVSECTION:
					std::swap(previous_section, ctxt.section);
					break;
				default:
					assert(0);
					break;
			}
			if (ctxt.pass == context_t::PASS_2)
				notice(2, "%s switched to section \"%s\"", directive.c_str(), ctxt.section->name.c_str());
		
			return	0;
		}
		
		default:
			break;
	}

	// all directives past here support a "normal" label, so process it here
	if (label.size())
		process_labeldef(label);

	switch (idx)
	{
		// END ===============================
		case DIR_END:
		{
			if (tokens.size() - cur_token != 0)
				error("" PR_D64 " extra token%s after %s", (tokens.size()-cur_token), (tokens.size()-cur_token)==1 ? "" : "s", directive.c_str());

			bool moretokens = false;
			for (auto it = ctxt.file->src_line.begin() + ctxt.line+1; it != ctxt.file->src_line.end(); ++it)
			{
				if (it->size() != 0)
				{
					moretokens = true;
					break;
				}
			}

			if (moretokens)
			{
				notice(1, "%s encountered with remaining non-comment lines (skipping)", directive.c_str());
			}
			
			force_end_file = true;
		}
		break;

		// VOID ===============================
		case DIR_VOID:
		{
			// ignore all arguments and be happy
		}
		break;

		// ALIGN ===============================
		case DIR_ALIGN:
		{
			std::string exprstr;
			int64_t boundary = eval_tokens(directive, exprstr, cur_token, tokens, 1, 0);

			if ((boundary == 0) || (boundary & (boundary-1)))
				error("%s requires a power of two byte boundary (" PR_D64 " fails)", directive.c_str(), boundary);
			else
				align_output(boundary);
		}
		break;

		// space type (reserve space) =====
		case DIR_SPACE_8:
		case DIR_SPACE_16:
		case DIR_SPACE_32:
		case DIR_SPACE_FLOAT:
		case DIR_SPACE_64:
		case DIR_SPACE_DBL:
		{
			std::string exprstr;
			int64_t count = eval_tokens(directive, exprstr, cur_token, tokens, 1, 0);

			uint64_t pot = 1;
			switch (idx)
			{
				case DIR_SPACE_8:		pot = 1;	break;
				case DIR_SPACE_16:		pot = 2;	break;
				case DIR_SPACE_32:		pot = 4;	break;
				case DIR_SPACE_FLOAT:	pot = 4;	break;
				case DIR_SPACE_64:		pot = 8;	break;
				case DIR_SPACE_DBL:		pot = 8;	break;
				default:
					assert(false);
					break;
			}

			if ((count * pot) > MAXFILL_BYTES)
			{
				error("%s exceeded maximum output size safety check of 0x%x/%d bytes", directive.c_str(), MAXFILL_BYTES, MAXFILL_BYTES);
			}

			if (count >= 0)
			{
				align_output(arch->alignment(pot));
				for (int pad = 0; pad < count; pad++)
				{
					switch (pot)
					{
						case 1:		emit((int8_t)0);	break;
						case 2:		emit((int16_t)0);	break;
						case 4:		emit((int32_t)0);	break;
						case 8:		emit((int64_t)0);	break;
						default:
							assert(false);
							break;
					}
				}

				notice(3, "%s reserved total of " PR_D64 "*" PR_D64 " = 0x" PR_X64 "/" PR_D64 " bytes", directive.c_str(), count, pot, pot * count, pot * count);
			}
			else if (count < 0)
			{
				error("Illegal negative %s value " PR_D64 "\n", directive.c_str(), count);
			}
		}
		break;

		// fill type (fill swith value) =====
		case DIR_FILL_8:
		case DIR_FILL_16:
		case DIR_FILL_32:
		case DIR_FILL_FLOAT:
		case DIR_FILL_64:
		case DIR_FILL_DBL:
		{
			std::string exprstr;
			int64_t v64 = 0;
			
			if (idx == DIR_FILL_FLOAT || idx == DIR_FILL_DBL)
			{
				double fv = 0.0;
				if (cur_token >= tokens.size() || sscanf(tokens[cur_token].c_str(), "%lf", &fv) != 1)
					error("%s unable to parse floating point constant: %s", directive.c_str(), tokens[cur_token].c_str());
				
				if (idx == DIR_FILL_FLOAT)
				{
					float f = (float)fv;
					v64 = (int64_t) union_cast<uint32_t>(f);
				}
				else
				{
					v64 = union_cast<int64_t>(fv);
				}
				
				cur_token++;
				if (cur_token < tokens.size() && tokens[cur_token] == ",")
					cur_token++;
			}
			else
			{
				eval_tokens(directive, exprstr, cur_token, tokens, 2, 0);
			}

			exprstr.clear();
			int64_t count = eval_tokens(directive, exprstr, cur_token, tokens, 1, 0);

			uint8_t		v8 = (uint8_t)v64;
			uint16_t	v16 = (uint16_t)v64;
			uint32_t	v32 = (uint32_t)v64;
			uint64_t	pot = 1;

			switch (idx)
			{
				case DIR_FILL_8:		pot = 1;	break;
				case DIR_FILL_16:		pot = 2;	break;
				case DIR_FILL_32:		pot = 4;	break;
				case DIR_FILL_FLOAT:	pot = 4;	break;
				case DIR_FILL_64:		pot = 8;	break;
				case DIR_FILL_DBL:		pot = 8;	break;
				default:
					assert(false);
					break;
			}

			if (ctxt.pass != context_t::PASS_1)
				check_truncation(directive, v64, (uint32_t)(pot<<3), 1);

			if ((count * pot) > MAXFILL_BYTES)
			{
				error("%s exceeded maximum output size safety check of 0x%x/%d bytes", directive.c_str(), MAXFILL_BYTES, MAXFILL_BYTES);
			}
				
			if (count >= 0)
			{
				if (count)
				{
					align_output(arch->alignment(pot));
					for (int64_t i = 0; i < count; i++)
					{
						switch (idx)
						{
							case DIR_FILL_8:		emit(v8);	break;
							case DIR_FILL_16:		emit(v16);	break;
							case DIR_FILL_32:		emit(v32);	break;
							case DIR_FILL_FLOAT:	emit(v32);	break;
							case DIR_FILL_64:		emit(v64);	break;
							case DIR_FILL_DBL:		emit(v64);	break;
							default:
								assert(false);
								break;
						}
					}
				}
				notice(3, "%s filled a total of " PR_D64 "*" PR_D64 " = 0x" PR_X64 "/" PR_D64 " bytes", directive.c_str(), count, pot, pot * count, pot * count);
			}
			else if (count < 0)
			{
				error("Illegal negative %s value " PR_D64 "\n", directive.c_str(), count);
			}
		}
		break;

		// define type (define values) =====
		case DIR_DEF_8:
		case DIR_DEF_16:
		case DIR_DEF_32:
		case DIR_DEF_FLOAT:
		case DIR_DEF_64:
		case DIR_DEF_DBL:
		{
			uint64_t	pot = 1;
			switch (idx)
			{
				case DIR_DEF_8:		pot = 1;	break;
				case DIR_DEF_16:	pot = 2;	break;
				case DIR_DEF_32:	pot = 4;	break;
				case DIR_DEF_FLOAT:	pot = 4;	break;
				case DIR_DEF_64:	pot = 8;	break;
				case DIR_DEF_DBL:	pot = 8;	break;
				default:
					assert(false);
					break;
			}

			align_output(arch->alignment(pot));

			if ((tokens.size() - cur_token) == 0)
			{
				error("%s missing expected argument", directive.c_str());
				break;
			}

			size_t count = 0;
			std::string exprstr;
			do
			{
				exprstr.clear();
				int64_t		v64 = 0;
				if (idx == DIR_DEF_FLOAT || idx == DIR_DEF_DBL)
				{
					double fv = 0.0;
					if (cur_token >= tokens.size() || sscanf(tokens[cur_token].c_str(), "%lf", &fv) != 1)
						error("%s unable to parse floating point constant: %s", directive.c_str(), tokens[cur_token].c_str());
					
					if (idx == DIR_DEF_FLOAT)
					{
						float f = (float)fv;
						v64 = (int64_t) union_cast<uint32_t>(f);
						
					}
					else
					{
						v64 = union_cast<int64_t>(fv);
					}
					
					cur_token++;
				}
				else
				{
					v64 = eval_tokens(directive, exprstr, cur_token, tokens, 0, 0);
				}

				uint8_t		v8 = (uint8_t)v64;
				uint16_t	v16 = (uint16_t)v64;
				uint32_t	v32 = (uint32_t)v64;

				if (ctxt.pass != context_t::PASS_1)
					check_truncation(directive, v64, (uint32_t)(pot<<3), 1);
				switch (idx)
				{
					case DIR_DEF_8:		emit(v8);	break;
					case DIR_DEF_16:	emit(v16);	break;
					case DIR_DEF_32:	emit(v32);	break;
					case DIR_DEF_FLOAT:	emit(v32);	break;
					case DIR_DEF_64:	emit(v64);	break;
					case DIR_DEF_DBL:	emit(v64);	break;
					default:
						assert(false);
						break;
				}
				count++;

				if (cur_token < tokens.size())
				{
					assert(tokens[cur_token] == ",");

					if (cur_token+1 >= tokens.size())
						error("%s missing argument after \",\"", directive.c_str());
				}
			}
			while (++cur_token < tokens.size());

			notice(3, "%s defined a total of " PR_D64 "*" PR_D64 " = 0x" PR_X64 "/0x" PR_D64 " bytes", directive.c_str(), count, pot, pot * count, pot * count);
		}
		break;

		// define hex =======================
		case DIR_DEF_HEX:
		{
			if ((tokens.size() - cur_token) == 0)
			{
				error("%s missing expected argument", directive.c_str());
				break;
			}

			size_t count = 0;
			for (;cur_token < tokens.size(); cur_token++)
			{
				std::string exprstr = removeQuotes(tokens[cur_token]);
				if (exprstr.size() & 1)
				{
					error("%s requires an even number of contiguous hex digits", directive.c_str());
					break;
				}

				for (auto hit = exprstr.begin(); hit != exprstr.end(); hit += 2)
				{
					uint8_t v;
					uint8_t d1 =(uint8_t) toupper(hit[0]);
					uint8_t d2 =(uint8_t) toupper(hit[1]);

					if (isdigit(d1))
						d1 &= 0x0f;
					else
						d1 -= 'A' - 0xa;

					if (d1 > 0xf)
					{
						error("%s encountered non-hex digit '%c'", directive.c_str(), hit[0]);
						return 0;
					}

					if (isdigit(d2))
						d2 &= 0x0f;
					else
						d2 -= 'A' - 0xa;

					if (d2 > 0xf)
					{
						error("%s encountered non-hex digit '%c'", directive.c_str(), hit[1]);
						return 0;
					}
					v = d1<<4 | d2;

					emit(v);
					count++;
				}
			}
			notice(3, "%s defined a total of 0x" PR_X64 "/0x" PR_D64 " bytes", directive.c_str(), count, count);
		}
		break;

		// ASCIIZ/ASCII ==============================
		case DIR_DEF_ASCII:
		case DIR_DEF_ASCIIZ:
		{
			if ((tokens.size() - cur_token) == 0)
			{
				error("%s missing expected argument", directive.c_str());
				break;
			}
			
			for (auto it = tokens.begin()+cur_token; it != tokens.end(); ++it)
			{
				if ((*it)[0] != '\'' && (*it)[0] != '\"')
				{
					error("%s expected quoted string literal: \"%s\"", directive.c_str(), it->c_str());
					break;
				}
				
				std::string rawstring = quotedToRaw(directive, removeQuotes(*it), idx == DIR_DEF_ASCIIZ ? true : false);
				ctxt.section->data.insert(ctxt.section->data.end(), rawstring.begin(), rawstring.end());
				
				++it;

				if (it != tokens.end())
				{
					if  (*it != ",")
						error("%s expected \",\" after string", directive.c_str());
					else if (it+1 == tokens.end())
						error("%s missing argument after \",\"", directive.c_str());
				}
				else
					break;
			}
		}
		break;
		
		// UTF16Z/UTF16 ==============================
		case DIR_DEF_UTF16:
		case DIR_DEF_UTF16Z:
		{
			error("%s not supported pending C++11 codecvt support", directive.c_str());
			return 0;

			if ((tokens.size() - cur_token) == 0)
			{
				error("%s missing expected argument", directive.c_str());
				break;
			}
			
			for (auto it = tokens.begin()+cur_token; it != tokens.end(); ++it)
			{
				if ((*it)[0] != '\'' && (*it)[0] != '\"')
				{
					error("%s expected quoted string literal: \"%s\"", directive.c_str(), it->c_str());
					break;
				}
				
				std::string utf8string = quotedToRaw(directive, removeQuotes(*it), idx == DIR_DEF_UTF16Z ? true : false);
//				std::string_convert<codecvt_utf8_utf16<char16_t>, char16_t> utf16conv;
				std::u16string utf16string;
				if (utf16string.size())
					align_output(arch->alignment(2));
				for (auto cit = utf16string.begin(); cit != utf16string.end(); ++cit)
				{
					uint16_t w = *cit;
					emit(w);
				}
				
				++it;

				if (it != tokens.end())
				{
					if  (*it != ",")
						error("%s expected \",\" after string", directive.c_str());
					else if (it+1 == tokens.end())
						error("%s missing argument after \",\"", directive.c_str());
				}
				else
					break;
			}
		}
		break;

		// UTF32Z/UTF32 ==============================
		case DIR_DEF_UTF32:
		case DIR_DEF_UTF32Z:
		{
			error("%s not supported pending C++11 codecvt support", directive.c_str());
			return 0;
	
			if ((tokens.size() - cur_token) == 0)
			{
				error("%s missing expected argument", directive.c_str());
				break;
			}
			
			for (auto it = tokens.begin()+cur_token; it != tokens.end(); ++it)
			{
				if ((*it)[0] != '\'' && (*it)[0] != '\"')
				{
					error("%s expected quoted string literal: \"%s\"", directive.c_str(), it->c_str());
					break;
				}
				
				std::string utf8string = quotedToRaw(directive, removeQuotes(*it), idx == DIR_DEF_UTF16Z ? true : false);
//				std::wstring_convert<std::codecvt_utf8_utf32<char32_t>, char32_t> utf32conv;
				std::u32string utf32string;
				if (utf32string.size())
					align_output(arch->alignment(4));
				for (auto cit = utf32string.begin(); cit != utf32string.end(); ++cit)
				{
					uint16_t w = *cit;
					emit(w);
				}
				
				++it;

				if (it != tokens.end())
				{
					if  (*it != ",")
						error("%s expected \",\" after string", directive.c_str());
					else if (it+1 == tokens.end())
						error("%s missing argument after \",\"", directive.c_str());
				}
				else
					break;
			}
		}
		break;

		// INCBIN =================================
		case DIR_INCBIN:
		{
			if (tokens.size() - cur_token > 1)
			{
				error("" PR_D64 " extra token%s after %s filename", (tokens.size()-cur_token-1), (tokens.size()-cur_token-1)==1 ? "" : "s", directive.c_str());
			}
			else if (tokens.size() - cur_token < 1)
			{
				error("missing %s filename", directive.c_str());

				return 0;
			}

			std::string name = removeQuotes(tokens[cur_token]);
			
			FILE *fp = fopen(name.c_str(), "r");
			
			if (fp == NULL)
			{
				error("%s opening file \"%s\" error: %s", directive.c_str(), name.c_str(), strerror(errno));
				break;
			}
			
			fseek(fp, 0L, SEEK_END);
			if (ferror(fp))
			{
				error("%s(%d): %s reading file \"%s\" error: %s", ctxt.file->name.c_str(), ctxt.line+ctxt.file->line_start, directive.c_str(), name.c_str(), strerror(errno));
				fclose(fp);
				break;
			}
			size_t sz = ftell(fp);
			fseek(fp, 0L, SEEK_SET);
			if (ferror(fp))
			{
				error("%s(%d): %s reading file \"%s\" error: %s", ctxt.file->name.c_str(), ctxt.line+ctxt.file->line_start, directive.c_str(), name.c_str(), strerror(errno));
				fclose(fp);
				break;
			}
			size_t off = ctxt.section->data.size();
			ctxt.section->data.insert(ctxt.section->data.end(), sz, (uint8_t)0);
			if (fread(&ctxt.section->data[off], sz, 1, fp) != 1)
			{
				error("%s(%d): %s reading file \"%s\" error: %s", ctxt.file->name.c_str(), ctxt.line+ctxt.file->line_start, directive.c_str(), name.c_str(), strerror(errno));
			}
			fclose(fp);
		}
		break;
		
		default:
		{
			notice(0, "[TODO Directive \"%s\"=%d args:" PR_D64 "]", directive.c_str(), idx, tokens.size() - cur_token);
		}
		break;
	}

	return 0;
}

int xlasm::process_labeldef(std::string label)
{
	symbol_t& sym = symbols[label];

	if (sym.type == symbol_t::UNDEFINED)
	{
		sym.type			= symbol_t::LABEL;
		sym.name			= label;
		sym.line_defined	= ctxt.line;
		sym.file_defined	= ctxt.file;
		sym.section			= ctxt.section;
	}
	else
	{
		if (sym.line_defined != ctxt.line || sym.file_defined != ctxt.file)
		{
			error("Duplicate label definition: \"%s\" first at %s(%d)", label.c_str(), sym.file_defined->name.c_str(), sym.line_defined);
		}
	}

	sym.value = ctxt.section->addr + ctxt.section->data.size();
	ctxt.section->last_defined_sym = &sym;
	sym_defined = &sym;
	notice(3, "Defined label \"%s\" = 0x" PR_X64 "/" PR_D64 "", label.c_str(), sym.value, sym.value);

	return 0;
}

int xlasm::align_output(uint64_t pot)
{
	assert((pot != 0) && !(pot & (pot-1)));

	size_t off = ctxt.section->addr + ctxt.section->data.size();
	size_t newoff = (off + pot-1) & ~(pot-1);
	size_t delta = newoff - off;

	if (delta)
	{
		for (int pad = (int)delta; pad > 0;)
		{
			if (pad & (1<<0))
			{
				emit((int8_t)0);
				pad -= sizeof (int8_t);
			}
			else if (pad & (1<<1))
			{
				emit((int16_t)0);
				pad -= sizeof (int16_t);
			}
			else if (pad & (1<<2))
			{
				emit((int32_t)0);
				pad -= sizeof (int32_t);
			}
			else
			{
				emit((int64_t)0);
				pad -= sizeof (int64_t);
			}
		}

		notice(3, "" PR_D64 " byte%s alignment padding inserted", delta, delta != 1 ? "s" : "");

		if (ctxt.section->last_defined_sym)
		{
			symbol_t& lsym = *ctxt.section->last_defined_sym;

			if ((lsym.type != symbol_t::UNDEFINED && lsym.type != symbol_t::STRING) &&
				lsym.section == ctxt.section && lsym.value == (int64_t)off)
			{
				warning("" PR_D64 " byte%s alignment padding inserted after label \"%s\" definition", delta, delta != 1 ? "s" : "", lsym.name.c_str());
			}
		}
		
		suppress_line_listsource = true;
		process_line_listing();
		suppress_line_listsource = false;
		line_sec_size = line_sec_start->data.size();
	}

	return 0;
}

int64_t xlasm::eval_tokens(const std::string& cmd, std::string& exprstr, uint32_t& cur_token, const std::vector<std::string>& tokens, int expected_args, int64_t defval)
{
	int64_t result = defval;

	exprstr.clear();
	if ((tokens.size() - cur_token) == 0)
	{
		error("Missing expected argument%s after %s", expected_args == 1 ? "" : "s", cmd.c_str());

		return result;
	}
	else
	{
		for (auto it = tokens.begin()+cur_token; it != tokens.end(); ++it, cur_token++)
		{
			if (*it == ",")
				break;

			if (exprstr.size())
				exprstr += " ";

			// ignore '$' if the first character of an expression (for compatibility with BASIC assembler)
			if (it[0][0] == '$')
				exprstr.insert(exprstr.end(), it->begin() + 1, it->end());
			else
				exprstr += *it;
		}

		if (expected_args > 1 && cur_token < tokens.size() && tokens[cur_token] == ",")
			cur_token++;
	}

	expression expr;

	if (!exprstr.size() || !expr.evaluate(this, exprstr.c_str(), &result))
	{
		warning("%s treating failed argument evaluation as " PR_D64 " (expr: %s)", cmd.c_str(), defval, exprstr.size() ? exprstr.c_str() : "none");
		result = defval;
	}

	if (expected_args == 1 && tokens.size() != (size_t)cur_token)
	{
		error("Unexpected additional argument(s) for %s", cmd.c_str());
	}

	return result;
}

xlasm::source_t& xlasm::expand_macro(std::string& name, uint32_t cur_token, const std::vector<std::string>& tokens)
{
	macro_t& m = macros[name];
	
	name = m.name;	// use name defined with (not uppercase)
	std::vector<std::string> parms;

	// TODO: Fixup token parsing, e.g., {"A "B C,x} drops C
	std::string parm;
	size_t idx = 1;
	auto it = tokens.begin()+cur_token+1;
	while (it != tokens.end())
	{
		if (idx >= m.args.size())
		{
			error("MACRO \"%s\" unexpected parameter: \"%s\"", name.c_str(), it->c_str());
			break;
		}

		parm.clear();

		for (; it != tokens.end() && *it != ","; ++it)
		{
			if (parm.size())
				parm += " ";
			parm += *it;
		}

		if (!parm.size())
		{
			if (!m.def[idx].size())
				warning("MACRO \"%s\" parameter \"%s\" unset with no default value", name.c_str(), m.args[idx].c_str());
			parm = m.def[idx];
		}
		else
		{
			parm = removeQuotes(parm);
		}

		parms.push_back(parm);

		idx++;
		
		if (it != tokens.end() && *it == ",")
			++it;
	}

	for (;idx < m.args.size(); idx++)
	{
		if (!m.def[idx].size())
			warning("MACRO \"%s\" parameter \"%s\" unset with no default value", name.c_str(), m.args[idx].c_str());
		parms.push_back(m.def[idx]);
	}

	std::string key = m.name;
	if (parms.size())
		key += " ";

	idx = 1;
	for (auto it = parms.begin(); it != parms.end(); ++it, idx++)
	{
		key += m.args[idx];
		key += "={";
		key += *it;
		key += "}";
		if (it+1 != parms.end())
			key += ",";
	}

	source_t &s = expanded_macros[key];
	
	m.invoke_count++;

	// has this particular macro/parameter combination been expanded already?
	if (!s.name.size())
	{
		s.name = m.body.name;
		s.file_size = m.body.file_size;
		s.line_start = m.body.line_start;

		s.src_line = m.body.src_line;
		
		std::string	unique_str;
		strprintf(unique_str, "_%s_%d", m.name.c_str(), m.invoke_count);
		m.args.push_back("@");
		parms.push_back(unique_str);

		bool spammed = false;
		for (auto lit = s.src_line.begin(); lit != s.src_line.end(); ++lit)
		{
			for (auto tit = lit->begin(); tit != lit->end(); ++tit)
			{
				bool hasquotes = false;
				if (tit->size() > 0 && ((*tit)[0] == '\"' ||(*tit)[0] == '\''))
					hasquotes = true;

				uint32_t reps;
				for(reps = 0; reps < MAXMACROREPS_WARNING; reps++)
				{
					size_t found_idx = ~0U;
					size_t max_length = 0;

					for (auto kit = m.args.begin()+1; kit != m.args.end(); ++kit)
					{
						if (max_length < kit->size() && (tit->find("\\" + *kit) != std::string::npos) && (!hasquotes || tit->find("\\\\" + *kit) == std::string::npos))
						{
							max_length = kit->size();
							found_idx = kit - m.args.begin();
						}
					}

					if (found_idx != ~0U)
					{
						assert(found_idx != 0 && found_idx < m.args.size());
						std::string	pn = "\\" + m.args[found_idx];
						size_t p = tit->find(pn);

						if (p != std::string::npos)
						{
							tit->erase(p, pn.length());
							if (hasquotes)
								tit->insert(p, reQuote(parms[found_idx-1]));
							else
								tit->insert(p, parms[found_idx-1]);
						}
						else
							assert(0);
					}
					else
						break;
				}
				if (reps >= MAXMACROREPS_WARNING && !spammed)
				{
					error("MACRO \"%s\" > %d parameter substitution iterations (likely recursive)", name.c_str(), MAXMACROREPS_WARNING);
					spammed = true;
				}
			}

			std::string fake_line;

			if (!opt.suppress_macro_name)
				fake_line = "<" + name  + ">\t";

			idx = 0;
			for (auto tit = lit->begin(); tit != lit->end(); ++tit, idx++)
			{
				if (idx == 0 && tit->back() != ':')
					fake_line += "\t\t";
				fake_line += *tit;
				if (tit+1 != lit->end() && idx < 1)
					fake_line += "\t\t";
			}
			s.orig_line.push_back(fake_line);
		}
		
		m.args.pop_back();		// erase unqiue_str arg
	}

	ctxt.macroexp_ptr = &m;
	notice(3, "Expanding MACRO \"%s\"", key.c_str());

	return s;
}

int64_t xlasm::symbol_value(xlasm *xl, const char *name)
{
	int64_t	result = 0;
	std::string sym_name(name);

	symbol_t& sym = xl->symbols[sym_name];

	if (sym.type == symbol_t::UNDEFINED)
	{
		if (!sym.name.size())
			sym.name = name;
		if (xl->ctxt.pass == xlasm::context_t::PASS_2)
			xl->warning("Evaluating undefined symbol \"%s\" as " PR_D64 "", name, result);

		if (!sym.file_first_referenced)
		{
			sym.file_first_referenced = xl->ctxt.file;
			sym.line_first_referenced = xl->ctxt.line;
		}
		xl->undefined_sym_count++;
	}
	else if (sym.type == symbol_t::SPECIAL)
	{
		return xl->special_symbol(sym_name);
	}
	else if (sym.type == symbol_t::STRING)
	{
		expression expr;

		if (sym.str.size())
		{
			if (!expr.evaluate(xl, sym.str.c_str(), &result) && (xl->ctxt.pass == xlasm::context_t::PASS_2))
				xl->warning("Evaluating failed expression of symbol \"%s\" as 0x" PR_X64 "/" PR_D64 " (expr: %s)", name, result, result, sym.str.c_str());
		}
		else
		{
			if (xl->ctxt.pass == xlasm::context_t::PASS_2)
				xl->warning("Evaluating empty string in symbol \"%s\" as 0x" PR_X64 "/" PR_D64 "", name, result, result);
		}
	}
	else
	{
		result = sym.value;
	}

	return result;
}

int64_t xlasm::special_symbol(const std::string& sym_name)
{
	if (sym_name == ".")
		return ctxt.section->addr + ctxt.section->data.size();
	else if (sym_name == ".big_endian")
		return opt.big_endian == 1;
	else if (sym_name == ".little_endian")
		return opt.big_endian == 0;
	return 0;
}

std::string xlasm::token_message(uint32_t cur_token, const std::vector<std::string>& tokens)
{
	std::string msg;
	
	for (auto it = tokens.begin()+cur_token; it != tokens.end(); ++it)
	{
		if ((*it)[0] == ',')
			continue;

		if ((*it)[0] == '\"' || (*it)[0] == '\'')
		{
			msg += removeQuotes(*it);
		}
		else
		{
			int64_t result = 0;
			expression expr;
			std::string rstr;

			if (it->size() && expr.evaluate(this, it->c_str(), &result))
				strprintf(msg, "0x" PR_X64 "/" PR_D64 "", result, result);
			else
				strprintf(msg, "<expr error>");
		}
	}
	
	return msg;
}

std::string xlasm::quotedToRaw(const std::string cmd, const std::string &str, bool null_terminate)
{
	std::string rawstr;

	bool escape = false;
	for (auto it = str.begin(); it != str.end(); ++it)
	{
		if (it[0] == '\\' && !escape)
		{
			escape = true;
			continue;
		}
			
		if (escape)
		{
			switch (it[0])
			{
				case '\'':	rawstr += '\'';	break;	// 0x27
				case '\"':	rawstr += '\"';	break;	// 0x22
				case '?':	rawstr += '\?';	break;	// 0x3f
				case '\\':	rawstr += '\\';	break;	// 0x5c
				case 'a':	rawstr += '\a';	break;	// 0x07
				case 'b':	rawstr += '\b';	break;	// 0x08
				case 'f':	rawstr += '\f';	break;	// 0x0c
				case 'n':	rawstr += '\n';	break;	// 0x0a
				case 'r':	rawstr += '\r';	break;	// 0x0d
				case 't':	rawstr += '\t';	break;	// 0x09
				case 'v':	rawstr += '\v';	break;	// 0x0b
				case '0':	rawstr += '\0';	break;	// 0x00
				case 'x':
				{
					if (it+2 >= str.end())
					{
						error("%s hex literal incomplete (requires two hex digits after \"\\x\").", cmd.c_str());
						return 0;
					}

					uint8_t d1 =(uint8_t) toupper(it[1]);
					uint8_t d2 =(uint8_t) toupper(it[2]);
					
					char v = 0;

					if (isdigit(d1))
						d1 &= 0x0f;
					else
						d1 -= 'A' - 0xa;

					if (d1 > 0xf)
					{
						error("%s encountered non-hex digit in hex literal '%c'", cmd.c_str(), it[1]);
						return 0;
					}

					if (isdigit(d2))
						d2 &= 0x0f;
					else
						d2 -= 'A' - 0xa;

					if (d2 > 0xf)
					{
						error("%s encountered non-hex digit in hex literal '%c'", cmd.c_str(), it[2]);
						return 0;
					}
					it += 2;
					v = (char)((d1<<4) | d2);
					
					rawstr += v;
				}
				break;
				default:
				{
					if (ctxt.pass == context_t::PASS_2)
						warning("%s unrecognized character escape code '%c'", cmd.c_str(), it[0]);
					rawstr += *it;
					break;
				}
			}
		}
		else
		{
			rawstr += *it;
		}
			
		escape = false;
	}
	
	if (null_terminate)
		rawstr += '\0';
	
    return rawstr;
}

std::string xlasm::removeExtension(const std::string &filename)
{
    size_t lastdot = filename.find_last_of(".");
    if (lastdot == std::string::npos)
		return filename;
    return filename.substr(0, lastdot);
}

std::string xlasm::removeQuotes(const std::string &quotedstr)
{
	std::string newstr;
	int trim = 0;
	if (quotedstr[0] == '\'' || quotedstr[0] == '\"')
		trim = 1;
	newstr.assign(quotedstr.begin()+trim, quotedstr.end()-trim);
    return newstr;
}

std::string xlasm::reQuote(const std::string &str)
{
	std::string newstr;
	for (auto it = str.begin(); it != str.end(); ++it)
	{
		if (*it == '\'')
			newstr += "\\\'";
		else if (*it == '\"')
			newstr += "\\\"";
		else
			newstr += *it;
	}
    return newstr;
}

int xlasm::source_t::read_file(xlasm* xa, const std::string& n)
{
	if (file_size)
	{
//		dprintf("File '%s' has already been loaded\n", name.c_str());
		assert(name == n);
		return 0;
	}

	name = n;

	FILE *fp = fopen(name.c_str(), "r");
	if (!fp)
	{
		return errno;
	}

	char line_buff[MAX_LINE_LENGTH] = { 0 };
	std::string nline;

	while (!ferror(fp) && fgets(line_buff, sizeof (line_buff)-1, fp) != nullptr)
	{
		nline = line_buff;
		file_size += nline.size();
		rtrim(nline, " \r\n");
		orig_line.push_back(nline);
	}

	if (!feof(fp))
	{
		int e = errno;
		fclose(fp);
		return e;
	}
	fclose(fp);

	// do preliminary processing on input file to make it more regular WRT whitespace and removing comments
	std::vector<std::string>	cooked_tokens;
	std::string					token;
	int ln = 0;
	for (std::vector<std::string>::iterator it = orig_line.begin(); it != orig_line.end(); ++it, ln++)
	{
		char inquotes = 0;
		bool escape = false;
		bool whitespace = false;

		cooked_tokens.clear();
		token.clear();

		if (it->c_str()[0] != '#')
		{
			char c = 0, oldc = 0;
			for (std::string::iterator sit = it->begin(); sit != it->end(); ++sit)
			{
				oldc = c;
				c = *sit;

				if (!inquotes)
				{
					// end at comment start
					if (c == ';')
						break;

					// C++ style comment start
					if (c == '/' && (sit+1 != it->end() && sit[1] == '/'))
						break;

					bool ws = (isspace(c) || c < ' ');

					// if not in quotes and this is not the first whitespace character, discard it
					if (ws && !whitespace)
					{
						whitespace = true;
						continue;
					}
					else if (whitespace && ws)
					{
						// eat extra whitespace
						continue;
					}
					else if (whitespace && !ws)
					{
						// replace whitespace run with a single space between label and opcode, but remove from operand
						whitespace = false;
						if (c != ':')
						{
							if (token.size())
								cooked_tokens.push_back(token);
							token.clear();
						}
					}

					if (c == ',')
					{
						if (token.size())
							cooked_tokens.push_back(token);
						cooked_tokens.push_back(",");	// make comma a separate token
						token.clear();

						continue;
					}

					if (c == '=' && (oldc != '<' && oldc != '>' && oldc != '=' && oldc != '!') && (sit+1 == it->end() || sit[1] != '=')  )
					{
						if (token.size())
							cooked_tokens.push_back(token);
						cooked_tokens.push_back("=");	// make assignment a separate token
						token.clear();

						continue;
					}
				}

				// if this character wasn't escaped (by backslash)
				if (!escape)
				{
					// if it was a quote then toggle inquotes flag as needed (inside string or character literals)
					if (c == '\"' || c == '\'')
					{
						if (inquotes && inquotes == c)	// is this a matching closing quote?
						{
							inquotes = 0;
							token += c;
							cooked_tokens.push_back(token);
							token.clear();

							continue;
						}
						else if (!inquotes)				// is this a new opening quote?
						{
							inquotes = c;
						}
					}
					else if (c == '\\')		// Flag when previous character was an escape (backslash)
					{
						escape = inquotes != 0;	// only valid in quotes
					}
				}
				else
				{
					escape = false;
				}

				token += c;			// add character to "cooked" source line tokens
			}
		}

		if (inquotes)
		{
			token += inquotes;
			source_t *old_file = xa->ctxt.file;
			uint32_t old_line = xa->ctxt.line;
			xa->ctxt.file = this;
			xa->ctxt.line = ln;
			xa->warning("Missing ending quote added.\n");
			xa->ctxt.file = old_file;
			xa->ctxt.line = old_line;
		}

		if (token.size())
			cooked_tokens.push_back(token);

		// dprintf("" PR_D64 "=", cooked_tokens.size());
		// for (auto it = cooked_tokens.begin(); it != cooked_tokens.end(); ++it)
		// {
			// dprintf("[%s] ", it->c_str());
		// }
		// dprintf("\n");

		src_line.push_back(cooked_tokens);
	}

	return 0;
}

void xlasm::diag_showline()
{
	if (!last_diag_file)
		return;
	printf("%s(%d): %s\n", last_diag_file->name.c_str(), last_diag_line+last_diag_file->line_start, last_diag_file->orig_line[last_diag_line].c_str());
	fflush(stdout);
	last_diag_file = nullptr;
}

void xlasm::diag_flush()
{
	if (last_diag_file && (last_diag_file != ctxt.file || last_diag_line != ctxt.line))
	{
		diag_showline();
	}

	fflush(stdout);

	last_diag_file = ctxt.file;
	last_diag_line = ctxt.line;
}

void xlasm::error(const char *msg, ...)
{
	va_list ap;
	va_start(ap, msg);

	diag_flush();
	
	printf("%s(%d): ", ctxt.file->name.c_str(), ctxt.line+ctxt.file->line_start);
	printf("ERROR: ");
	if (ctxt.macroexp_ptr)
		printf("[in MACRO \"%s\"] ", ctxt.macroexp_ptr->name.c_str());
	vprintf(msg, ap);
	printf("\n");

	if (ctxt.pass == context_t::PASS_2)
	{
		std::string outmsg;
		
		strprintf(outmsg, "ERROR: ");
		if (ctxt.macroexp_ptr)
			strprintf(outmsg, "[in MACRO \"%s\"] ", ctxt.macroexp_ptr->name.c_str());
		vstrprintf(outmsg, msg, ap);
		
		pre_messages.push_back(outmsg);
	}

	va_end(ap);
	fflush(stdout);

	error_count++;
}

void xlasm::warning(const char *msg, ...)
{
	if (ctxt.pass != context_t::PASS_2)
		return;

	va_list ap;
	va_start(ap, msg);

	diag_flush();

	if (ctxt.file)
		printf("%s(%d): ", ctxt.file->name.c_str(), ctxt.line+ctxt.file->line_start);
	printf("WARNING: ");
	if (ctxt.macroexp_ptr)
		printf("[in MACRO \"%s\"] ", ctxt.macroexp_ptr->name.c_str());
	vprintf(msg, ap);
	printf("\n");

	if (ctxt.pass == context_t::PASS_2)
	{
		std::string outmsg;

		strprintf(outmsg, "WARNING: ");
		if (ctxt.macroexp_ptr)
			strprintf(outmsg, "[in MACRO \"%s\"] ", ctxt.macroexp_ptr->name.c_str());
		vstrprintf(outmsg, msg, ap);

		pre_messages.push_back(outmsg);
	}
	
	va_end(ap);
	fflush(stdout);

	warning_count++;
}

void xlasm::notice(int level, const char *msg, ...)
{
	if (ctxt.pass != context_t::PASS_2)
		return;
	
	if (level > opt.verbose)
		return;

	va_list ap;
	va_start(ap, msg);

	diag_flush();

	if (ctxt.file)
		printf("%s(%d): ", ctxt.file->name.c_str(), ctxt.line+ctxt.file->line_start);
	printf("NOTE: ");
	if (ctxt.macroexp_ptr)
		printf("[in MACRO \"%s\"] ", ctxt.macroexp_ptr->name.c_str());
	vprintf(msg, ap);
	printf("\n");

	if (ctxt.pass == context_t::PASS_2)
	{
		std::string outmsg;

		strprintf(outmsg, "NOTE: ");
		if (ctxt.macroexp_ptr)
			strprintf(outmsg, "[in MACRO \"%s\"] ", ctxt.macroexp_ptr->name.c_str());
		vstrprintf(outmsg, msg, ap);

		post_messages.push_back(outmsg);
	}

	va_end(ap);
	fflush(stdout);

	last_diag_file = nullptr;
}

template <typename T>
void xlasm::emit(T v)
{
	union
	{
		T			v;
		uint8_t		b[sizeof(T)];
	} u;

	assert(sizeof(T) <= 16);

	u.v = v;
	if (opt.big_endian)
	{
		for (size_t i = sizeof(T)-1; i != (size_t)-1; i--)
			ctxt.section->data.push_back(u.b[i]);
	}
	else
	{
		for (size_t i = 0; i < sizeof(T); i++)
			ctxt.section->data.push_back(u.b[i]);
	}
}

template <typename T>
T xlasm::endian_swap(T v)
{
	union
	{
		T			v;
		uint8_t		b[sizeof(T)];
	} u, o;

	assert(sizeof(T) <= 16);

	if (opt.big_endian)
	{
		u.v = v;
		size_t j =0;
		for (size_t i = sizeof(T)-1; i != (size_t)-1; i--)
			o.b[j++] = u.b[i];
		
		return o.v;
	}
	else
	{
		return v;
	}
}

uint32_t xlasm::bits_needed_signed(int64_t v)
{
	bool	 s = (v & (1LL<<63)) != 0;
	
	for (int b = 62; b > 0; b--)
		if (((v & (1LL<<b)) != 0) != s)
			return b+2;

	return 1;
}

uint32_t xlasm::bits_needed_unsigned(int64_t v)
{
	for (int b = 63; b > 0; b--)
		if ((v & (1LL<<b)) != 0)
			return b+1;

	return 1;
}
bool xlasm::check_truncation(const std::string& cmd, int64_t v, uint32_t b, int errwarnflag)
{
	assert(b >= 1 && b <= 64);
	
	if (b == 64)
		return false;
		
	int64_t	minv = -(1LL << (b-1));
	int64_t	maxv = (1LL << (b))-1;
	if (v < minv || v > maxv)
	{
		if (errwarnflag == 1)
			error("%s out of range for %d-bit value (0x" PR_X64 " / " PR_D64 ")", cmd.c_str(), b, v, v);
		else if (errwarnflag == 2)
			error("%s out of range for %d-bit value (0x" PR_X64 " / " PR_D64 ")", cmd.c_str(), b, v, v);
		return true;
	}

	return false;
}

bool xlasm::check_truncation_signed(const std::string& cmd, int64_t v, uint32_t b, int errwarnflag)
{
	assert(b >= 1 && b <= 64);
	
	if (b == 64)
		return false;
		
	int64_t	minv = -(1LL << (b-1));
	int64_t	maxv = (1LL << (b-1))-1;
	if (v < minv || v > maxv)
	{
		if (errwarnflag == 1)
			error("%s out of range for %d-bit signed value (0x" PR_X64 " / " PR_D64 ")", cmd.c_str(), b, v, v);
		else if (errwarnflag == 2)
			error("%s out of range for %d-bit signed value (0x" PR_X64 " / " PR_D64 ")", cmd.c_str(), b, v, v);
		return true;
	}

	return false;
}

bool xlasm::check_truncation_unsigned(const std::string& cmd, int64_t v, uint32_t b, int errwarnflag)
{
	assert(b >= 1 && b <= 64);

	if (b == 64)
		return false;
		
	uint64_t maxv = (1LL << (b))-1;
	uint64_t tv = (uint64_t)v;
	
	if (tv > maxv)
	{
		if (errwarnflag == 1)
			error("%s out of range for %d-bit unsigned value (0x" PR_X64 " / " PR_D64 ")", cmd.c_str(), b, v, v);
		else if (errwarnflag == 2)
			error("%s out of range for %d-bit unsigned value (0x" PR_X64 " / " PR_D64 ")", cmd.c_str(), b, v, v);
		return true;
	}

	return false;
}


void xlasm::add_special_sym(const char *name, symbol_t::sym_t type, int64_t value)
{
	std::string n(name);
	symbol_t& sym = symbols[n];
	assert(sym.name.size() == 0);

	sym.name = n;
	sym.type = type;
	sym.value = value;
}

int32_t xlasm::lookup_reg(const std::string& opcode, std::string& n)
{
	std::transform(n.begin(), n.end(), n.begin(), ::toupper);

	auto it = symbols.find(n);
	if (it == symbols.end())
	{
		error("Unrecognized register \"%s\" for %s opcode", n.c_str(), opcode.c_str());
		return -1;
	}

	const symbol_t& sym = it->second;

	if (sym.type != symbol_t::REGISTER)
	{
		error("Unrecognized register \"%s\" for %s opcode", n.c_str(), opcode.c_str());
		return -1;
	}

	return (int32_t)sym.value;
}

void vstrprintf(std::string& str, const char *fmt, va_list va)
{
	size_t start = str.size();
	str.insert(str.end(), 1024, 0);

	vsnprintf(&str[start], 1023, fmt, va);
	size_t end = str.find('\0', start);
	assert(end != std::string::npos);
	str.erase(end);	
}

void strprintf(std::string& str, const char *fmt, ...)
{
	va_list ap;
	va_start(ap, fmt);
	
	vstrprintf(str, fmt, ap);
	
	va_end(ap);
}

int main(int argc, char **argv)
{
	std::string					archname("Sweet32-LE");
	std::vector<std::string>	source_files;
	std::string					object_file;
	xlasm::opts_t				opts;

//	char cwdpath[512] = { 0 };
//	printf("cwd = %s\n", _getcwd(cwdpath, sizeof(cwdpath)-1));

	for (int i = 1; i < argc; i++)
	{
		if (argv[i][0] == '-')
		{
			switch (argv[i][1])
			{
				case 'a':
					if (argv[i][2] != 0)
						archname = &argv[i][2];
					else if (i+1 < argc)
						archname = argv[++i];
					else
						fatal_error("Expected architecture name after -a option");
					break;

				case 'b':
					if (argv[i][2] != 0)
					{
						if (sscanf(&argv[i][2], "%u", &opts.listing_bytes) != 1)
							fatal_error("Expected number after -b listing bytes option (8 per line)");
					}
					else if (i+1 < argc)
					{
						if (sscanf(argv[++i], "%u", &opts.listing_bytes) != 1)
							fatal_error("Expected number after -b listing bytes option (8 per line)");
					}
					else
					{
						fatal_error("Expected number after -b listing bytes option (8 per line)");
					}
					
						
					opts.listing_bytes = (opts.listing_bytes + 7) & ~7;
					if (opts.listing_bytes < 8)
						opts.listing_bytes = 8;
					break;

				case 'c':
					opts.suppress_false_conditionals = 1;
					break;

				case 'm':
					opts.suppress_macro_expansion = 1;
					break;

				case 'n':
					opts.suppress_macro_name = 1;
					break;

				case 'l':
					opts.listing = 1;
					break;

				case 'o':
					if (argv[i][2] != 0)
						object_file = &argv[i][2];
					else if (i+1 < argc)
						object_file = argv[++i];
					else
						fatal_error("Expected filename after -o output file option");
					break;

				case 'q':
					opts.verbose = 0;
					break;

				case 'v':
					opts.verbose++;
					break;

				case 'x':
					opts.xref = 1;
					break;

				default:
					fatal_error("Unrecognized option -%c", argv[i][1]);
					break;
			}

			continue;
		}
		source_files.push_back(std::string(argv[i]));
	}

	if (opts.verbose > 1)
	{
		if (opts.verbose == 2)
			printf("Verbose status messages enabled.\n");
		else if (opts.verbose > 2)
			printf("Verbose status and debugging messages enabled.\n");
	}

	sweet32	arch;

	if (!archname.size() || !arch.set_variant(archname))
	{
		printf("Supported architectures:\n\n");
		
		const sweet32::variant_t *names = arch.variant_names();
		
		for (int i = 0; names[i].max_width != 0; ++i)
		{
			printf("\t\"%s\"\t\t%d-bit\t%s\n", names[i].name.c_str(), names[i].max_width, names[i].big_endian ? "big-endian" : "little-endian");
		}
		printf("\n");
		
		if (!archname.size())
			fatal_error("Architecture must be specified with -a option.");
		else
			fatal_error("Unrecognized architecture \"%s\".", archname.c_str());
	}


	if (!source_files.size())
//		fatal_error("No source file(s) specified");
		source_files.push_back(std::string("big_out.asm"));
		
	xlasm	xl(&arch);

	int rc = xl.assemble(source_files, object_file, opts);

	return rc;
}

// EOF
