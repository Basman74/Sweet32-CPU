/* *minmal* stdio.c routines for Sweet32 */
/* Written by Valentin Angelovski (c) 2015  */

#ifdef USE_VGA
#ifndef uint8_t
#define uint8_t unsigned char
#endif
#ifndef uint16_t
#define uint16_t unsigned short
#endif
#ifndef uint32_t
#define uint32_t unsigned long
#endif

uint8_t textattr = 7;
uint32_t textx = 0, texty = 0, screenwidth = 80, screenheight = 25;
uint8_t *vram = 0x20000000;

uint8_t asciishift[128] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x7E, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x51, 0x21, 0x00, 0x00, 0x00, 0x5A, 0x53, 0x41, 0x57, 0x40, 0x00, 0x00, 0x43,
	0x58, 0x44, 0x45, 0x24, 0x23, 0x00, 0x00, 0x20, 0x56, 0x46, 0x54, 0x52, 0x25, 0x00, 0x00, 0x4E,
	0x42, 0x48, 0x47, 0x59, 0x5E, 0x00, 0x00, 0x00, 0x4D, 0x4A, 0x55, 0x26, 0x2A, 0x00, 0x00, 0x3C,
	0x4B, 0x49, 0x4F, 0x29, 0x28, 0x00, 0x00, 0x3E, 0x3F, 0x4C, 0x3A, 0x50, 0x5F, 0x00, 0x00, 0x00,
	0x22, 0x00, 0x7B, 0x2B, 0x00, 0x00, 0x00, 0x00, 0x0D, 0x7D, 0x00, 0x7C, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x21, 0x00, 0x24, 0x26, 0x00, 0x00, 0x00, 0x29, 0x3E,
	0x40, 0x25, 0x5E, 0x2A, 0x1B, 0x00, 0x00, 0x2B, 0x23, 0x2D, 0x2A, 0x28, 0x00, 0x00, 0x00, 0x00
};

uint8_t asciinormal[128] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x60, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x71, 0x31, 0x00, 0x00, 0x00, 0x7A, 0x73, 0x61, 0x77, 0x32, 0x00, 0x00, 0x63,
	0x78, 0x64, 0x65, 0x34, 0x33, 0x00, 0x00, 0x20, 0x76, 0x66, 0x74, 0x72, 0x35, 0x00, 0x00, 0x6E,
	0x62, 0x68, 0x67, 0x79, 0x36, 0x00, 0x00, 0x00, 0x6D, 0x6A, 0x75, 0x37, 0x38, 0x00, 0x00, 0x2C,
	0x6B, 0x69, 0x6F, 0x30, 0x39, 0x00, 0x00, 0x2E, 0x2F, 0x6C, 0x3B, 0x70, 0x2D, 0x00, 0x00, 0x00,
	0x27, 0x00, 0x5B, 0x3D, 0x00, 0x00, 0x00, 0x00, 0x0D, 0x5D, 0x00, 0x5C, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x31, 0x00, 0x34, 0x37, 0x00, 0x00, 0x00, 0x30, 0x2E,
	0x32, 0x35, 0x36, 0x38, 0x1B, 0x00, 0x00, 0x2B, 0x33, 0x2D, 0x2A, 0x39, 0x00, 0x00, 0x00, 0x00
};

uint16_t *PS2_status = 0x70000038, *PS2_eventack = 0x7000003A;
void resetps2(void) {
	uint32_t spin, spin2;
	*PS2_status = 0xFF;
	for (spin=0; spin<1000; spin++) { }
	*PS2_status = 0xF0;
	for (spin=0; spin<1000; spin++) { }
	*PS2_status = 2;
	for (spin=0; spin<5; spin++) {
		for (spin2=0; spin2<1000; spin2++) {
			if (*PS2_status & 0x0800) {
				*PS2_eventack = 0;
				break;
			}
		}
	}
	
}

uint8_t lastkey_wasup = 0; 
uint8_t ignore_key = 0, shift = 0, caps = 0;
uint8_t getchar_now(void) {
	uint8_t key, raw;
	uint16_t spin;
	
	if(*PS2_status & 0x0800) {
		*PS2_eventack = 1;
		raw = *PS2_status & 0xFF;
		if(lastkey_wasup == 0) {	
			if(raw == 0xF0) {
				lastkey_wasup = 1;
				return(0);
			} else {
				switch (raw) {
					case 0x12:
					case 0x59:
						shift = 1;
						return(0);
					case 0x58:
						caps ^= 1;
						*PS2_status = 0xED;
						for (spin=0; spin<3000; spin++) { }
						*PS2_status = caps << 1;
						for (spin=0; spin<3000; spin++) {
							if (*PS2_status & 0x0800) {
								*PS2_eventack = 1;
								break;
							}
						}
						for (spin=0; spin<3000; spin++) {
							if (*PS2_status & 0x0800) {
								*PS2_eventack = 1;
								break;
							}
						}
						return(0);
					default:
						if (!caps) {
							if (shift) key = asciishift[raw - 2];
								else key = asciinormal[raw - 2];	
						} else {
							if (shift) {
								key = asciishift[raw - 2];
								if ((key >= 'A') && (key <= 'Z')) key += 'a' - 'A';
							} else {
								key = asciinormal[raw - 2];
								if ((key >= 'a') && (key <= 'z')) key -= 'a' - 'A';
							}
						}
						break;
				}
				return(key);
			}
		} else {
			switch (raw) {
				case 0x12:
				case 0x59:
					shift = 0;
					break;
			}
			lastkey_wasup = 0;
			return(0);
		}
	}
}

uint8_t getchar(void) {
	uint8_t key;
	
getchar_spin:
	key = getchar_now();
	if (!key) goto getchar_spin;
	
	return key;
}

uint8_t kbhit(void) {
	if (*PS2_status & 0x0800) {
		return(1);
	} else {
		return(0);
	}
}

uint32_t mul32(uint32_t xm, uint32_t ym) {
	uint32_t res = 0, i;
	
	for (i=0; i<ym; i++) {
		res += xm;
	}
	return(res);
}

void gotoxy(uint32_t x, uint32_t y) {
	uint8_t *ptr;
	textx = x;
	texty = y;
	ptr = 0x70000052;
	*ptr = (uint8_t)textx;
	ptr = 0x70000054;
	*ptr = (uint8_t)texty;
}

void cls(void) {
	uint32_t i;
	uint8_t *ptr;
	for (i=0; i<0x1000; ) {
		ptr = (void *)((uint32_t)vram + i); i++;
		*ptr = 0;
		ptr = (void *)((uint32_t)vram + i); i++;
		*ptr = textattr;
	}
	gotoxy(0, 0);
}

void scrollscreen(void) {
	uint32_t i;
	uint8_t *ptr, *ptr2;
	for (i=0; i<3840; i++) {
		ptr = (void *)((uint32_t)vram + i);
		ptr2 = (void *)((uint32_t)vram + i + 160);
		*ptr = *ptr2;
	}
	for (i=3840; i<0x1000; ) {
		ptr = (void *)((uint32_t)vram + i); i++;
		*ptr = 0;
		ptr = (void *)((uint32_t)vram + i); i++;
		*ptr = textattr;
	}
}

void putchar(uint8_t c) {
	uint32_t i, mul1, mul2; //these mul1/mul2 needed because as of the time i write this, the compiler throws x86 push into the asm if i use the globals
	uint8_t *ptr;
	
	mul1 = screenwidth;
	mul2 = texty;
	i = mul32(mul1, mul2) << 1;
	i += textx << 1;
	switch (c) {
		case 13: //CR
			textx = 0;
			break;
		case 10: //LF
			texty++;
			break;
		case 8: //backspace
			if (textx > 0) textx--;
			break;
		default:
			ptr = (uint8_t *)((uint32_t)vram + i); i++;
			*ptr = c;
			ptr = (uint8_t *)((uint32_t)vram + i);
			*ptr = textattr;
			textx++;
			break;
	}
	
	if (textx == screenwidth) {
		textx = 0;
		texty++;
	}
	
	if (texty == screenheight) {
		texty--;
		scrollscreen();
	}
	ptr = 0x70000052;
	*ptr = (uint8_t)textx;
	ptr = 0x70000054;
	*ptr = (uint8_t)texty;
}
#else
unsigned short *UART_status = 0x70000000, *UART_eventack = 0x70000002;

/***********************************************************/
void putchar(int c)
{
  wait_tx:
	if(!(*UART_status & 0x0100)) goto wait_tx;
	*UART_status = c;
}


unsigned int getchar(void)
{
unsigned int d;

  wait_rx:
	if(!(*UART_status & 0x0200)) goto wait_rx;
	*UART_eventack = 1;
	d = *UART_status & 0x000000FF;
	return(d);
}
#endif

void puts(char* s)
{
while (*s) putchar(*s++);
}
 
char *gets(char *buf)
{
	int c;
	char *s;

	for (s = buf; (c = getchar()) != '\r';) {
		switch (c) {
			case 8:
				if (s > buf) {
					s--;
					putchar(8); putchar(32); putchar(8);
				}
				break;
			default:
				*s++ = c;
				putchar(c);
		}
	}
	*s = 0;
	return (buf);
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


static void hexnum(unsigned int n) {
    unsigned int q;
    unsigned char x, i, leadzeroflag;	

	q = 0x10000000;
	leadzeroflag = 0;
	x = 0;
	

	while(x == 0)
	{
	i = 0x30;	
	repeat_loopi:
		if((q < n) || (q == n))
		{
			i++;
			n = n - q;
			leadzeroflag = 1;
			goto repeat_loopi;
		}
		else
		{
			if(q == 1) 
			{
				if(!leadzeroflag) putchar(i);
				x = 1;
			}
			if(i > 0x39) i = i + 7;
			if(leadzeroflag) putchar(i);
			q = q >> 4;
			
		}
	}
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
		putchar('-');
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
				if(!leadzeroflag) putchar(i);
				x = 1;
			}

			if(leadzeroflag) putchar(i);
			q = divu10(q);
			
		}
	}
}


int printf ( char fmt[], ... )
{
  int *ap, x, c ;
  ap = &fmt ; /* argument pointer */
  ap++; /* ap now points to first optional argument */

  while((*fmt) != 0) {

    if((*fmt) == '%') {
	  *fmt++;
	  x = *ap++;
      switch(*fmt++) {
      /* decimal */
      case 'd':
      case 'i':
		printnum(x);
		break;
	  /* string */
      case 's':
		puts(x);
		break;
	  /* Hex */
      case 'X':	  
      case 'x':
		hexnum(x);
		break;	
	  /* ASCII char */
      case 'c':
		putchar(x & 0xFF);
		break;
      }	  
    }

	else
		putchar((*fmt++));
  }
	return(0);
}
