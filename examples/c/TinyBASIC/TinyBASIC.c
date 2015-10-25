// TinyBASIC program, Authored by Mike Field
// Ported from the Arduino to the Sweet32 CPU by Valentin Angelovski 


unsigned char 	linelen = 0;
unsigned short *UART_status, *UART_eventack;	

// ASCII Characters
#define CR		'\r'
#define NL		'\n'
#define TAB		'\t'
#define BELL	'\b'
#define SPACE   ' '
#define CTRLC	0x03
#define CTRLH	0x08
#define CTRLS	0x13
#define CTRLX	0x18
#define NULL    0x00



/***********************************************************/
// Keyword table and constants - the last character has 0x80 added to it
const unsigned char keywords[] = {
	'L','I','S','T'+0x80,
	'L','O','A','D'+0x80,
	'N','E','W'+0x80,
	'R','U','N'+0x80,
	'S','A','V','E'+0x80,
	'N','E','X','T'+0x80,
	'L','E','T'+0x80,
	'I','F'+0x80,
	'G','O','T','O'+0x80,
	'G','O','S','U','B'+0x80,
	'R','E','T','U','R','N'+0x80,
	'R','E','M'+0x80,
	'F','O','R'+0x80,
	'I','N','P','U','T'+0x80,
	'P','R','I','N','T'+0x80,
	'P','O','K','E'+0x80,
	'E','N','D'+0x80,
	'B','Y','E'+0x80,
	'F','R','E','E'+0x80,
	'C','L','S'+0x80,
	'D','E','L','A','Y'+0x80,	
	0
};

#define KW_LIST		0
#define KW_LOAD		1
#define KW_NEW		2
#define KW_RUN		3
#define KW_SAVE		4
#define KW_NEXT		5
#define KW_LET		6
#define KW_IF		7
#define KW_GOTO		8
#define KW_GOSUB	9
#define KW_RETURN	10
#define KW_REM		11
#define KW_FOR		12
#define KW_INPUT	13
#define KW_PRINT	14
#define KW_POKE		15
#define KW_END		16
#define KW_BYE		17
#define KW_MEM		18
#define KW_CLS		19
#define KW_DELAY	20
#define KW_DEFAULT	21

struct stack_for_frame {
	char frame_type;
	char for_var;
	short int terminal;
	short int step;
	unsigned char *current_line;
	unsigned char *txtpos;
};

struct stack_gosub_frame {
	char frame_type;
	unsigned char *current_line;
	unsigned char *txtpos;
};

const unsigned char func_tab[] = {
	'P','E','E','K'+0x80,
	'A','B','S'+0x80,
	0
};
#define FUNC_PEEK    0
#define FUNC_ABS	 1
#define FUNC_UNKNOWN 2

const unsigned char to_tab[] = {
	'T','O'+0x80,
	0
};

const unsigned char step_tab[] = {
	'S','T','E','P'+0x80,
	0
};

const unsigned char relop_tab[] = {
	'>','='+0x80,
	'<','>'+0x80,
	'>'+0x80,
	'='+0x80,
	'<','='+0x80,
	'<'+0x80,
	0
};

#define RELOP_GE		0
#define RELOP_NE		1
#define RELOP_GT		2
#define RELOP_EQ		3
#define RELOP_LE		4
#define RELOP_LT		5
#define RELOP_UNKNOWN	6

#define STACK_SIZE (sizeof(struct stack_for_frame)*5)
#define VAR_SIZE sizeof(short int) // Size of variables in bytes



static const unsigned char okmsg[]		= "OK";
static const unsigned char sderrormsg[]	= "Drive fail";
static const unsigned char whatmsg[]	= "What? ";
static const unsigned char redomsg[]	= "Redo";
static const unsigned char howmsg[]		= "How?";
static const unsigned char sorrymsg[]	= "Sorry!";
static const unsigned char initmsg[]	= "TinyBasic in C V0.03.";
static const unsigned char valmsg[]		= "Sweet32 port by Valentin Angelovski";
static const unsigned char memorymsg[]	= " bytes free.";
static const unsigned char breakmsg[]	= "break!";
static const unsigned char unimplimentedmsg[]	= "Unimplemented";
static const unsigned char backspacemsg[]		= "\b \b";

void TEXTMODE(void);
void outchar(void); 
void inchar(void); 
static void line_terminator(void);
static short int expression(void);
static unsigned char breakcheck(void);
void main(void); 


typedef unsigned short LINENUM;
LINENUM linenum;

unsigned char *txtpos,*inputpos,*list_line;
unsigned char expression_error;
unsigned char *tempsp;


unsigned char *stack_limit;
unsigned char *program_start;
unsigned char *program_end;
unsigned char *stack; // Software stack for things that should go on the CPU stack
unsigned char *variables_begin;
unsigned char *current_line;
unsigned char *sp;

#define STACK_GOSUB_FLAG 'G'
#define STACK_FOR_FLAG 'F'
unsigned char table_index;
unsigned short dataptr;
unsigned char program[512]; // Allocate 8KBytes of system RAM for TinyBASIC use
unsigned char opcode;
unsigned char newchar;





// TinyBASIC program, Authored by Mike Field
// Ported from the Arduino to the 8051 (and enhanced) by 
// Valentin Angelovski.
// Source modified to compile under the fleatiny kernel using SDCC.

// Enhancements added to the original source code:
// INPUT, CLS, DELAY and FREE statements are supported!
// Still quirks to be worked out with the parser, but it otherwise
// works - enjoy! :-)

/***********************************************************/
void setup()
{

}

/***********************************************************/
static unsigned char breakcheck(void) 
{
unsigned int d;

	if(!(*UART_status & 0x0200)) return 0;
	else
	{
		*UART_eventack = 1;
		d = *UART_status & 0x000000FF;
		if (d == CTRLH) return 1;	
		else return 0;
	}
}

/***********************************************************/
void outchar(int c)
{
  wait_tx:
	if(!(*UART_status & 0x0100)) goto wait_tx;
	*UART_status = c;
}


unsigned int inchar(void)
{
unsigned int d;

  wait_rx:
	if(!(*UART_status & 0x0200)) goto wait_rx;
	*UART_eventack = 1;
	d = *UART_status & 0x000000FF;
	return(d);
}

void puts(char* s)
{
while (*s) outchar(*s++);
}
 
void dump(void)
{
int i=0;
	while(i < 510)
	{
		outchar(program[i]);
		i++;
	}
}

short int process_userinput(void) 
{
	short int a = 0;
	unsigned char inputbuf[7];
	unsigned char neg_input = 0;	
	inputpos = inputbuf;
	unsigned char opcode;
	
	for(opcode=0;opcode<7;opcode++)
	{
		newchar = inchar();
		outchar(newchar);	// Echo user input to the screen
		if(newchar == CR) 
		{
			inputbuf[opcode] = newchar;
			newchar = NL;
			outchar(newchar);	// Add linefeed following carrige return
			goto exit_usrinput;
		}
		if((newchar < '0' || newchar > '9') && newchar != '-') return -32768; //Data entered was not a number!
		inputbuf[opcode] = newchar;
		
	}
	return -32768; //Too many digits! return error..

exit_usrinput:	
	inputpos = inputbuf;

	if(*inputpos == '-')	// Zero entered
	{
		neg_input = 1;
		inputpos++;
	}
	else
	
	
	if(*inputpos == '0')	// Zero entered
	{
		inputpos++;
		return 0;
	}

	if(*inputpos > '/' && *inputpos < ':')
	{
		do 	{
			a = a*10 + *inputpos - '0';
			inputpos++;
		} while(*inputpos > '/' && *inputpos < ':');
	}
	if(neg_input == 1) a = -a;
	return a;
}


/***************************************************************************/
static void line_terminator(void)
{
  	outchar(NL);
	outchar(CR);
}


/***************************************************************************/
static void ignore_blanks(void)
{
	while(*txtpos == SPACE || *txtpos == TAB)
		txtpos++;
}

/***************************************************************************/
static void scantable(unsigned char *table) 
{
	int i = 0;
	table_index = 0;
	while(1)
	{
		// Run out of table entries?
		if(table[0] == 0)
            return;

		// Do we match this character?
		if(txtpos[i] == table[0])
		{
			i++;
			table++;
		}
		else
		{
			// do we match the last character of keywork (with 0x80 added)? If so, return
			if(txtpos[i]+0x80 == table[0])
			{
				txtpos += i+1;  // Advance the pointer to following the keyword
				ignore_blanks();
				return;
			}

			// Forward to the end of this keyword
			while((table[0] & 0x80) == 0)
				table++;

			// Now move on to the first character of the next word, and reset the position index
			table++;
			table_index++;
			ignore_blanks();
			i = 0;
		}
	}
}

/***************************************************************************/
static void pushb(unsigned char b) 
{
	sp--;
	*sp = b;
}

/***************************************************************************/
static unsigned char popb() 
{
	unsigned char b;
	b = *sp;
	sp++;
	return b;
}

static unsigned divu10(unsigned n) {
    unsigned q, r;
    q = (n >> 1) + (n >> 2);
    q = q + (q >> 4);
    q = q + (q >> 8);
    q = q + (q >> 16);
    q = q >> 3;
    r = n - (((q << 2) + q) << 1);
    return q + (r > 9 ? 1 : 0);
}

static void printnum(int n) {
    unsigned int q;
	int r;
    unsigned char x, i, leadzeroflag;	

	q = 1000000000;
	leadzeroflag = 0;
	x = 0;
	
	if(n & 0x80000000) 
	{
		outchar('-');
		r = -n;
	}
	else
	{
		r = n;	
	}
	
	while(x == 0)
	{
	i = 0x30;	
	repeat_loopi:
		if((q < r) || (q == r))
		{
			i++;
			r = r - q;
			leadzeroflag = 1;
			goto repeat_loopi;
		}
		else
		{
			if(q == 1) 
			{
				if(!leadzeroflag) outchar(i);
				x = 1;
			}

			if(leadzeroflag) outchar(i);
			q = divu10(q);
			
		}
	}
}

/***************************************************************************/
static unsigned short testnum(void) 
{
	unsigned short num = 0;
	ignore_blanks();
	
	while(*txtpos> '/' && *txtpos < ':' )
	{
		// Trap overflows
		if(num > 6552)
		{
			num = 0xFFFF;
			break;
		}

		num = num *10 + *txtpos - '0';
		txtpos++;
	}
	return	num;
}

/***************************************************************************/
static void printmsgNoNL(const unsigned char *msg) 
{
	while(*msg)
	{
		outchar(*msg);
		msg++;
	}
}

/***************************************************************************/
static unsigned char print_quoted_string(void) 
{
	int i=0;
	unsigned char delim = *txtpos;
	if(delim != '"' && delim != '\'')
		return 0;
	txtpos++;

	// Check we have a closing delimiter
	while(txtpos[i] != delim)
	{
		if(txtpos[i] == NL)
			return 0;
		i++;
	}

	// Print the characters
	while(*txtpos != delim)
	{
		outchar(*txtpos);
		txtpos++;
	}
	txtpos++; // Skip over the last delimiter

	return 1;
}

/***************************************************************************/
static void printmsg(const unsigned char *msg) 
{
	printmsgNoNL(msg);
    line_terminator();
}

/***************************************************************************/
static void getln(char prompt) 
{ 
	unsigned char inbuf_charcount = 0;	
	outchar(prompt);
	txtpos = program_end+sizeof(LINENUM);
	dataptr=0;
	while(1)
	{

		opcode = inchar();
		switch(opcode)
		{
			case NL:
				break;
			case CR:
                line_terminator();
				// Terminate all strings with a NL
				txtpos[0] = NL;
				return;
			case CTRLH:
				if(txtpos == program_end)
					break;
				txtpos--;
				goto skip_whitespace;
			default:
				// We need to leave at least one space to allow us to shuffle the line into order
				if(txtpos == variables_begin-2)
					outchar(BELL);
				else
				{
					if((opcode == ' ') && (inbuf_charcount == 0)) {inbuf_charcount--; goto skip_whitespace;}
					
					txtpos[0] = opcode;
					txtpos++;
				skip_whitespace:
					outchar(opcode);
				}
		}
		inbuf_charcount++;
	}
}

/***************************************************************************/
static unsigned char *findline(void) 
{
	unsigned char *line = program_start;
	while(1)
	{
		if(line == program_end)
			return line;

		if(((LINENUM *)line)[0] >= linenum)

			return line;

		// Add the line length onto the current address, to get to the next line;
		line += line[sizeof(LINENUM)];
	}
}

/***************************************************************************/
static void toUppercaseBuffer(void)  
{
	unsigned char *c = program_end+sizeof(LINENUM);
	unsigned char quote = 0;

	while(*c != NL)
	{
		// Are we in a quoted string?
		if(*c == quote)
			quote = 0;
		else if(*c == '"' || *c == '\'')
			quote = *c;
		else if(quote == 0 && *c > '`' && *c < '{')
			*c = *c + 'A' - 'a';
		c++;
	}
}

/***************************************************************************/
void printline() 
{
	unsigned char *tempptr;
	LINENUM line_num;
	
	LINENUM * tempptr = (LINENUM *) list_line; 
	line_num = *tempptr;
    list_line = list_line + sizeof(LINENUM) + 1;

	// Output the line */
	printnum(line_num);
	outchar(' ');
	while(*list_line != NL)
    {
		outchar(*list_line);
		list_line++;
	}
	list_line++;
	line_terminator();
}

/***************************************************************************/
static short int expr4(void) 
{
	short int a = 0;
	unsigned char f;	
		
	if(*txtpos == '0')
	{
		txtpos++;
		return 0;
	}

	if(*txtpos > '0' && *txtpos < ':')
	{
		do 	{
			a = a*10 + *txtpos - '0';
			txtpos++;
		} while(*txtpos > '/' && *txtpos < ':');
		return a;
	}

	// Is it a function or variable reference?
	if(txtpos[0] > '@' && txtpos[0] < '[')
	{
		// Is it a variable reference (single alpha)
		if(txtpos[1] < 'A' || txtpos[1] > 'Z')
		{
			a = ((short int *)variables_begin)[*txtpos - 'A'];
			txtpos++;
			return a;
		}

		// Is it a function with a single parameter
		scantable(func_tab);
		if(table_index == FUNC_UNKNOWN) goto expr4_error;
		f = table_index;	


		if(*txtpos != '(')
			goto expr4_error;

		txtpos++;
		a = expression();
		if(*txtpos != ')')
				goto expr4_error;
		txtpos++;
		switch(f)
		{
			case FUNC_PEEK:
				return program[a];
			case FUNC_ABS:
				if(a < 0) 
					return -a;
				return a;
		}
	}

	if(*txtpos == '(')
	{
		short int a;
		txtpos++;
		a = expression();
		if(*txtpos != ')')
			goto expr4_error;

		txtpos++;
		return a;
	}

expr4_error:
	expression_error = 1;
	return 0;

}

/***************************************************************************/
static short int expr3(void) 
{
	short int a,b;

	a = expr4();
	while(1)
	{
		if(*txtpos == '*')
		{
			txtpos++;
			b = expr4();
			a = b; //	a *= b;
		}
		else if(*txtpos == '/')
		{
			txtpos++;
			b = expr4();
		//	if(b != 0)
			a = b; //		a /= b;
		//	else
		//		expression_error = 1;
		}
		else
			return a;
	}
}

/***************************************************************************/
static short int expr2(void) 
{ 
	short int a,b;

	if(*txtpos == '-' || *txtpos == '+')
		a = 0;
	else
		a = expr3();

	while(1)
	{
		if(*txtpos == '-')
		{
			txtpos++;
			b = expr3();
			a -= b;
		}
		else if(*txtpos == '+')
		{
			txtpos++;
			b = expr3();
			a += b;
		}
		else
			return a;
	}
}
/***************************************************************************/
static short int expression(void) 
{
	short int a,b;

	a = expr2();
	// Check if we have an error
	if(expression_error)	return a;

	scantable(relop_tab);
	if(table_index == RELOP_UNKNOWN)
		return a;
	
	switch(table_index)
	{
	case RELOP_GE:
		b = expr2();
		if(a >= b) return 1;
		break;
	case RELOP_NE:
		b = expr2();
		if(a != b) return 1;
		break;
	case RELOP_GT:
		b = expr2();
		if(a > b) return 1;
		break;
	case RELOP_EQ:
		b = expr2();
		if(a == b) return 1;
		break;
	case RELOP_LE:
		b = expr2();
		if(a <= b) return 1;
		break;
	case RELOP_LT:
		b = expr2();
		if(a < b) return 1;
		break;
	}
	return 0;
}



void main(void) 
{
	
	unsigned char *start;
	unsigned char *newEnd;
	unsigned char linelen;
	unsigned int tempint;
	
	//temp1 = sd_init(); // Init SD card 
	
	UART_status = 0x70000000; // UART access
	UART_eventack = 0x70000002; 
// Clear screen

// Print welcome message

opcode=0;
//	while (1)
//	{
//		newchar = welcome_msg[opcode];
//		if(newchar == 0) goto exit_welcome;
//		VRAM[opcode] = newchar + 10;
//		opcode++;
//	}
//	exit_welcome:
	
//	cursor_xpos = 0;
//	cursor_ypos = 2;


	
	program_start = program;
	program_end = program_start;
	sp = program+sizeof(program);  // Needed for printnum
	stack_limit = program+sizeof(program)-STACK_SIZE;
	variables_begin = stack_limit - 27*VAR_SIZE;
	printmsg(initmsg);
	printmsg(valmsg);
	printnum(variables_begin-program_end);
	printmsg(memorymsg);

warmstart:
	// this signifies that it is running in 'direct' mode.
	current_line = 0;
	sp = program+sizeof(program);  
	printmsg(okmsg);

prompt:
	getln('>');
	

	toUppercaseBuffer();
	

	txtpos = program_end+sizeof(unsigned short);
	// Find the end of the freshly entered line
	while(*txtpos != NL)
		txtpos++;
	tempint = txtpos;
	if(!(tempint & 1)) 
	{
		txtpos++;
		*txtpos = NL;
	}
	
	// Move it to the end of program_memory
	{
		unsigned char *dest;
		dest = variables_begin-1;
		while(1)
		{
			*dest = *txtpos;
			if(txtpos == program_end+sizeof(unsigned short))
				break;
			dest--;
			txtpos--;
		}
		txtpos = dest;
	}

	// Now see if we have a line number
	linenum = testnum();

	ignore_blanks();
	if(linenum == 0)
		goto direct;

	if(linenum == 0xFFFF)
		goto qhow;

	// Find the length of what is left, including the (yet-to-be-populated) line header
	linelen = 0;
	while(txtpos[linelen] != NL)
		linelen++;
	linelen++; // Include the NL in the line length
	
	linelen += sizeof(unsigned short)+sizeof(char); // Add space for the line number and line length

	// Now we have the number, add the line header.
	txtpos -= 3;
	*((unsigned short *)txtpos) = linenum;
	txtpos[sizeof(LINENUM)] = linelen;


	// Merge it into the rest of the program
	start = findline();

	// If a line with that number exists, then remove it
	if(start != program_end && *((LINENUM *)start) == linenum)
	{
		unsigned char *dest, *from;
		unsigned int tomove;

		from = start + start[sizeof(LINENUM)];
		dest = start;

		tomove = program_end - from;
		while( tomove > 0)
		{
			*dest = *from;
			from++;
			dest++;
			tomove--;
		}	
		program_end = dest;
	}

	if(txtpos[sizeof(LINENUM)+sizeof(char)] == NL) // If the line has no txt, it was just a delete
		goto prompt;


	// Make room for the new line, either all in one hit or lots of little shuffles
	while(linelen > 0)
	{	
		unsigned int tomove;
		unsigned char *from,*dest;
		unsigned int space_to_make;
	
		space_to_make = txtpos - program_end;

		if(space_to_make > linelen)
			space_to_make = linelen;
		newEnd = program_end+space_to_make;
		tomove = program_end - start;


		// Source and destination - as these areas may overlap we need to move bottom up
		from = program_end;
		dest = newEnd;
		while(tomove > 0)
		{
			from--;
			dest--;
			*dest = *from;
			tomove--;
		}

		// Copy over the bytes into the new space
		for(tomove = 0; tomove < space_to_make; tomove++)
		{
			*start = *txtpos;
			txtpos++;
			start++;
			linelen--;
		}
		program_end = newEnd;
	}
	goto prompt;

//unimplemented:
//	printmsg(unimplimentedmsg);
//	goto prompt;

qhow:	
	printmsg(howmsg);
	goto prompt;

qwhat:	
	printmsgNoNL(whatmsg);
	if(current_line != NULL)
	{
           unsigned char tmp = *txtpos;
		   if(*txtpos != NL)
				*txtpos = '^';
           list_line = current_line;
           printline();
           *txtpos = tmp;
	}
    line_terminator();
	goto prompt;

qsorry:	
	printmsg(sorrymsg);
	goto warmstart;

run_next_statement:
	while(*txtpos == ':')
		txtpos++;
	ignore_blanks();
	if(*txtpos == NL)
		goto execnextline;
	goto interperateAtTxtpos;

direct: 
	txtpos = program_end+sizeof(LINENUM);
	if(*txtpos == NL)
		goto prompt;

interperateAtTxtpos:
        if(breakcheck())
        {
          printmsg(breakmsg);
          goto warmstart;
        }

	scantable(keywords);

	switch(table_index)
	{
		case KW_LIST:
			goto list;
		case KW_LOAD:
			dump();
			goto load_sd_basicprg;	
			
		case KW_NEW:
			if(txtpos[0] != NL)
				goto qwhat;
			program_end = program_start;
			goto prompt;
		case KW_RUN:
			current_line = program_start;
			goto execline;
		case KW_SAVE:
			goto save_sd_basicprg;			
		case KW_NEXT:
			goto next;
		case KW_LET:
			goto assignment;
		case KW_IF:
			expression_error = 0;
			dataptr = expression();
			if(expression_error || *txtpos == NL)
				goto qhow;
			if(dataptr != 0)
				goto interperateAtTxtpos;
			goto execnextline;

		case KW_GOTO:
			expression_error = 0;
			linenum = expression();
			if(expression_error || *txtpos != NL)
				goto qhow;
			current_line = findline();
			goto execline;

		case KW_GOSUB:
			goto gosub;
		case KW_RETURN:
			goto gosub_return; 
		case KW_REM:	
			goto execnextline;	// Ignore line completely
		case KW_FOR:
			goto forloop; 
		case KW_INPUT:
			//goto input; 
		case KW_PRINT:
			goto print;
		case KW_POKE:
			goto poke;
		case KW_END:
			// This is the easy way to end - set the current line to the end of program attempt to run it
			if(txtpos[0] != NL)
				goto qwhat;
			current_line = program_end;
			goto execline;
		case KW_BYE:
			// Leave the basic interperater
			return;
		case KW_MEM: //Report free RAM available to user
			goto memreport;		
		case KW_CLS: //Clears the Videotext buffer
			//clear_textbuffer();		
			//cursor_xpos = 0;
			//cursor_ypos = 0;
			goto execnextline;	
		case KW_DELAY:
		{
			short int value;
				// Work out where to put it
				expression_error = 0;
				value = expression();
				if((expression_error) || ((value>255) || (value<0)))goto qwhat;
				//tick_timer = (unsigned char)value;
				//delayloop:
				//if(tick_timer > 0) goto delayloop;
				if(*txtpos == ':' )
				{
					line_terminator();
					txtpos++;
					goto run_next_statement;
				}
				if(*txtpos == NL)
				{
					goto execnextline;
				}
				goto qwhat;
			}
		case KW_DEFAULT:
			goto assignment;
		default:
			break;
	}
	
execnextline:
	if(current_line == NULL)		// Processing direct commands?
		goto prompt;
	current_line +=	 current_line[sizeof(LINENUM)];

execline:
  	if(current_line == program_end) // Out of lines to run
		goto warmstart;
	txtpos = current_line+sizeof(LINENUM)+sizeof(char);
	goto interperateAtTxtpos;

input:
	{

	}
forloop:
	{
		unsigned char var;
		short int initial, step, terminal;
		ignore_blanks();
		if(*txtpos < 'A' || *txtpos > 'Z')
			goto qwhat;
		var = *txtpos;
		txtpos++;
		ignore_blanks();
		if(*txtpos != '=')
			goto qwhat;
		txtpos++;
		ignore_blanks();

		expression_error = 0;
		initial = expression();
		if(expression_error)
			goto qwhat;
	
		scantable(to_tab);
		if(table_index != 0)
			goto qwhat;
	
		terminal = expression();
		if(expression_error)
			goto qwhat;
	
		scantable(step_tab);
		if(table_index == 0)
		{
			step = expression();
			if(expression_error)
				goto qwhat;
		}
		else
			step = 1;
		ignore_blanks();
		if(*txtpos != NL && *txtpos != ':')
			goto qwhat;


		if(!expression_error && *txtpos == NL)
		{
			struct stack_for_frame *f;
			if(sp + sizeof(struct stack_for_frame) < stack_limit)
				goto qsorry;

			sp -= sizeof(struct stack_for_frame);
			f = (struct stack_for_frame *)sp;
			((short int *)variables_begin)[var-'A'] = initial;
			f->frame_type = STACK_FOR_FLAG;
			f->for_var = var;
			f->terminal = terminal;
			f->step     = step;
			f->txtpos   = txtpos;
			f->current_line = current_line;
			goto run_next_statement;
		}
	}
	goto qhow;

gosub:
	expression_error = 0;
	linenum = expression();
	if(!expression_error && *txtpos == NL)
	{
		struct stack_gosub_frame *f;
		if(sp + sizeof(struct stack_gosub_frame) < stack_limit)
			goto qsorry;

		sp -= sizeof(struct stack_gosub_frame);
		f = (struct stack_gosub_frame *)sp;
		f->frame_type = STACK_GOSUB_FLAG;
		f->txtpos = txtpos;
		f->current_line = current_line;
		current_line = findline();
		goto execline;
	}
	goto qhow;

next:
	// Fnd the variable name
	ignore_blanks();
	if(*txtpos < 'A' || *txtpos > 'Z')
		goto qhow;
	txtpos++;
	ignore_blanks();
	if(*txtpos != ':' && *txtpos != NL)
		goto qwhat;
	
gosub_return:
	// Now walk up the stack frames and find the frame we want, if present
	tempsp = sp;
	while(tempsp < program+sizeof(program)-1)
	{
		switch(tempsp[0])
		{
			case STACK_GOSUB_FLAG:
				if(table_index == KW_RETURN)
				{
					struct stack_gosub_frame *f = (struct stack_gosub_frame *)tempsp;
					current_line	= f->current_line;
					txtpos			= f->txtpos;
					sp += sizeof(struct stack_gosub_frame);
					goto run_next_statement;
				}
				// This is not the loop you are looking for... so Walk back up the stack
				tempsp += sizeof(struct stack_gosub_frame);
				break;
			case STACK_FOR_FLAG:
				// Flag, Var, Final, Step
				if(table_index == KW_NEXT)
				{
					struct stack_for_frame *f = (struct stack_for_frame *)tempsp;
					// Is the the variable we are looking for?
					if(txtpos[-1] == f->for_var)
					{
						short int *varaddr = ((short int *)variables_begin) + txtpos[-1] - 'A'; 
						*varaddr = *varaddr + f->step;
						// Use a different test depending on the sign of the step increment
						if((f->step > 0 && *varaddr <= f->terminal) || (f->step < 0 && *varaddr >= f->terminal))
						{
							// We have to loop so don't pop the stack
							txtpos = f->txtpos;
							current_line = f->current_line;
							goto run_next_statement;
						}
						// We've run to the end of the loop. drop out of the loop, popping the stack
						sp = tempsp + sizeof(struct stack_for_frame);
						goto run_next_statement;
					}
				}
				// This is not the loop you are looking for... so Walk back up the stack
				tempsp += sizeof(struct stack_for_frame);
				break;
			default:
				//printf("Stack is stuffed!\n");
				goto warmstart;
		}
	}
	// Didn't find the variable we've been looking for
	goto qhow;

assignment:
	{
		short int value;
		short int *var;

		if(*txtpos < 'A' || *txtpos > 'Z')
			goto qhow;
		var = (short int *)variables_begin + *txtpos - 'A';
		txtpos++;

		ignore_blanks();

		if (*txtpos != '=')
			goto qwhat;
		txtpos++;
		ignore_blanks();
		expression_error = 0;
		value = expression();
		if(expression_error)
			goto qwhat;
		// Check that we are at the end of the statement
		if(*txtpos != NL && *txtpos != ':')
			goto qwhat;
		*var = value;
	}
	goto run_next_statement;
poke:
	{
		short int value;
		unsigned char *address;

		// Work out where to put it
		expression_error = 0;
		value = expression();
		if(expression_error)
			goto qwhat;
		address = (unsigned char *)value;

		// check for a comma
		ignore_blanks();
		if (*txtpos != ',')
			goto qwhat;
		txtpos++;
		ignore_blanks();

		// Now get the value to assign
		expression_error = 0;
		value = expression();
		if(expression_error)
			goto qwhat;
		//printf("Poke %p value %i\n",address, (unsigned char)value);
		// Check that we are at the end of the statement
		if(*txtpos != NL && *txtpos != ':')
			goto qwhat;
	}
	goto run_next_statement;

list:
	linenum = testnum(); // Retuns 0 if no line found.

	// Should be EOL
	if(txtpos[0] != NL)
		goto qwhat;

	// Find the line
	list_line = findline();
	while(list_line != program_end)
          printline();
	goto warmstart;

memreport:	
	printnum(variables_begin-program_end);
	printmsg(memorymsg);	
	goto prompt;

load_sd_basicprg: // ### Work-in-progress!
//	sd_sector_read = 1;
//	newchar = sd_iosector(0); // Read sector 0
//	if(newchar != 0)printmsg(sderrormsg);	
	goto prompt;	
	
save_sd_basicprg: // ### Work-in-progress!
//	sd_sector_read = 0;
//	newchar = sd_iosector(0); // Read sector 0
//	if(newchar != 0)printmsg(sderrormsg);	
	goto prompt;		
	
print:
	// If we have an empty list then just put out a NL
	if(*txtpos == ':' )
	{
        line_terminator();
		txtpos++;
		goto run_next_statement;
	}
	if(*txtpos == NL)
	{
		goto execnextline;
	}

	while(1)
	{
		ignore_blanks();
		if(print_quoted_string())
		{
			;
		}
		else if(*txtpos == '"' || *txtpos == '\'')
			goto qwhat;
		else
		{
			if(table_index == KW_PRINT)
			{
				short int e;
				expression_error = 0;
				e = expression();
				if(expression_error)
					goto qwhat;
				printnum(e);
			}
			else
			{
				unsigned char var;
				short int e;
				ignore_blanks();
				outchar('?');	// Send query character to user
				if(*txtpos < 'A' || *txtpos > 'Z')
					goto qwhat;
				var = *txtpos;
				txtpos++;
				ignore_blanks();
				if(*txtpos != NL && *txtpos != ':') goto qwhat;
				retry_userinput:
				e = process_userinput();
				if(e != -32768) ((short int *)variables_begin)[var-'A'] = e;
				else
				{
					printmsg(redomsg);
					outchar('?');	// Send query character to user
					goto retry_userinput;
				}
				goto run_next_statement;
			}
		}

		// At this point we have three options, a comma or a new line
		if(*txtpos == ',')
			txtpos++;	// Skip the comma and move onto the next
		else if(txtpos[0] == ';' && (txtpos[1] == NL || txtpos[1] == ':'))
		{
			txtpos++; // This has to be the end of the print - no newline
			break;
		}
		else if(*txtpos == NL || *txtpos == ':')
		{
			line_terminator();	// The end of the print statement
			break;
		}
		else
			goto qwhat;	
	}
	goto run_next_statement;
}
	
	