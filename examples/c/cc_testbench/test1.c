// 'Quick and dirty' testbench code :-) 
// Source provided as-is. Use at your own risk.

#include "stdio.h"

static const unsigned char initmsg[]	= "This is a string datatype!";

void main(void) 
{
	
	unsigned char *start;
	unsigned char *newEnd;
	unsigned char linelen;
	unsigned int tempint2,tempint3,t4;
	int tempint;
	unsigned short x,y;
	unsigned int c,d;
	
    signed int a = 120;   
    signed int b = -123;  	
	
	short addz,abbz;
	
	addz = -1;
	abbz = 1;
	
	printf("Testing addz >= 0..\r\n");
	while(addz >= 0)
	{
		addz = -1;		
	}
	
	printf("Testing addz <= 0..\r\n");
	while(abbz <= 0)
	{
		addz = -1;		
	}	

	printf("Testing addz > 1..\r\n");
	while(abbz > 1)
	{
		addz = -1;		
	}
	
	printf("Testing addz < -1..\r\n");
	while(addz < -1)
	{
		addz = -1;		
	}		

	
	printf("signed comparison tests:\r\n");	
	if(addz > addz) printf("Error#1\r\n");	
	if(addz < addz) printf("Error#2\r\n");		
	if(addz > -1) printf("Error#3\r\n");	
	if(addz < -1) printf("Error#4\r\n");	
	if(addz != addz) printf("Error#5\r\n");		
	if(addz != -1) printf("Error#6\r\n");	

	if(addz >= addz) printf("Error#7\r\n");		
	if(addz <= addz) printf("Error#8\r\n");	
	if(addz >= 2) printf("Error#9\r\n");	
	if(addz <= -2) printf("Error#10\r\n");	
		
	
	printf("unsigned comparison tests:\r\n");	
	
	//temp1 = sd_init(); // Init SD card 

	t4 = 34;
	tempint = 34;	
	
	if(tempint == 34) printf("If you only see this string, ALL TESTS PASSED..\r\n");		
	
	if((tempint > t4)) printf("Error#1\r\n");	
	if((tempint < t4)) printf("Error#2\r\n");		
	if((tempint > 34)) printf("Error#3\r\n");	
	if((tempint < 34)) printf("Error#4\r\n");	
	if((tempint != t4)) printf("Error#5\r\n");		
	if((tempint != 34)) printf("Error#6\r\n");	

	if((tempint >= t4)) printf("Error#7\r\n");		
	if((tempint <= t4)) printf("Error#8\r\n");	
	if((tempint >= 35)) printf("Error#9\r\n");	
	if((tempint <= 33)) printf("Error#10\r\n");

	if((tempint >= 12) && (tempint <= 22)) printf("T1\r\n");		
	if((tempint >= 56) || (tempint <= 35)) printf("T2\r\n");		
	
	printf("AND= %X\r\n",(a&b));
	printf("OR= %X\r\n",(a|b));	
	printf("XOR= %X\r\n",(a^b));
	printf("NOT= %X\r\n",~a);	
	printf("NEG= %X\r\n",-a);	
	
	printf("signed boolean comparison tests:\r\n");	

		printf("A = B: ");
        	printf("(a>b) = ");
		putchar( a > b ? '1' : '0');
		putchar(' ');
        	printf("(a<b) = ");
		putchar( a < b ? '1' : '0');
		putchar(' ');		
        	printf("(a>=b) = ");
		putchar( a >= b ? '1' : '0');
		putchar(' ');
        	printf("(a<=b) = ");
		putchar( a <= b ? '1' : '0');
		putchar(' ');
        	printf("(a!=b) = ");
		putchar( a != b ? '1' : '0');
		putchar(' ');
        	printf("(a==b) = ");
		putchar( a == b ? '1' : '0');
		putchar(' ');
		putchar(0x0D);
		putchar(0x0A);		
		a=-22;
		b=123;
		printf("A = B: ");
        	printf("(a>b) = ");
		putchar( a > b ? '1' : '0');
		putchar(' ');
        	printf("(a<b) = ");
		putchar( a < b ? '1' : '0');
		putchar(' ');		
        	printf("(a>=b) = ");
		putchar( a >= b ? '1' : '0');
		putchar(' ');
        	printf("(a<=b) = ");
		putchar( a <= b ? '1' : '0');
		putchar(' ');
        	printf("(a!=b) = ");
		putchar( a != b ? '1' : '0');
		putchar(' ');
        	printf("(a==b) = ");
		putchar( a == b ? '1' : '0');
		putchar(' ');
		putchar(0x0D);
		putchar(0x0A);		
		a=120;
		b=120;
		printf("A = B: ");
        	printf("(a>b) = ");
		putchar( a > b ? '1' : '0');
		putchar(' ');
        	printf("(a<b) = ");
		putchar( a < b ? '1' : '0');
		putchar(' ');		
        	printf("(a>=b) = ");
		putchar( a >= b ? '1' : '0');
		putchar(' ');
        	printf("(a<=b) = ");
		putchar( a <= b ? '1' : '0');
		putchar(' ');
        	printf("(a!=b) = ");
		putchar( a != b ? '1' : '0');
		putchar(' ');
        	printf("(a==b) = ");
		putchar( a == b ? '1' : '0');
		putchar(' ');
		putchar(0x0D);
		putchar(0x0A);	 	
		a=123;
		b=120;
		printf("A = B: ");
        	printf("(a>b) = ");
		putchar( a > b ? '1' : '0');
		putchar(' ');
        	printf("(a<b) = ");
		putchar( a < b ? '1' : '0');
		putchar(' ');		
        	printf("(a>=b) = ");
		putchar( a >= b ? '1' : '0');
		putchar(' ');
        	printf("(a<=b) = ");
		putchar( a <= b ? '1' : '0');
		putchar(' ');
        	printf("(a!=b) = ");
		putchar( a != b ? '1' : '0');
		putchar(' ');
        	printf("(a==b) = ");
		putchar( a == b ? '1' : '0');
		putchar(' ');
		putchar(0x0D);
		putchar(0x0A);		
		a=-123;
		b=-120;
		printf("A = B: ");
        	printf("(a>b) = ");
		putchar( a > b ? '1' : '0');
		putchar(' ');
        	printf("(a<b) = ");
		putchar( a < b ? '1' : '0');
		putchar(' ');		
        	printf("(a>=b) = ");
		putchar( a >= b ? '1' : '0');
		putchar(' ');
        	printf("(a<=b) = ");
		putchar( a <= b ? '1' : '0');
		putchar(' ');
        	printf("(a!=b) = ");
		putchar( a != b ? '1' : '0');
		putchar(' ');
        	printf("(a==b) = ");
		putchar( a == b ? '1' : '0');
		putchar(' ');
		putchar(0x0D);
		putchar(0x0A);	



		

		x = 111;
		y = 111;	

	printf("\r\n unsigned boolean comparison tests:\r\n");	

		printf("A = B: ");
        	printf("(a>b) = ");
		putchar( x > y ? '1' : '0');
		putchar(' ');
        	printf("(a<b) = ");
		putchar( x < y ? '1' : '0');
		putchar(' ');		
        	printf("(a>=b) = ");
		putchar( x >= y ? '1' : '0');
		putchar(' ');
        	printf("(a<=b) = ");
		putchar( x <= y ? '1' : '0');
		putchar(' ');
        	printf("(a!=b) = ");
		putchar( x != y ? '1' : '0');
		putchar(' ');
        	printf("(a==b) = ");
		putchar( x == y ? '1' : '0');
		putchar(' ');
		putchar(0x0D);
		putchar(0x0A);		
		x = 3456;
		y = 45;	
		printf("A = B: ");
        	printf("(a>b) = ");
		putchar( x > y ? '1' : '0');
		putchar(' ');
        	printf("(a<b) = ");
		putchar( x < y ? '1' : '0');
		putchar(' ');		
        	printf("(a>=b) = ");
		putchar( x >= y ? '1' : '0');
		putchar(' ');
        	printf("(a<=b) = ");
		putchar( x <= y ? '1' : '0');
		putchar(' ');
        	printf("(a!=b) = ");
		putchar( x != y ? '1' : '0');
		putchar(' ');
        	printf("(a==b) = ");
		putchar( x == y ? '1' : '0');
		putchar(' ');
		putchar(0x0D);
		putchar(0x0A);		
		x = 345;
		y = 4500;	
		printf("A = B: ");
        	printf("(a>b) = ");
		putchar( x > y ? '1' : '0');
		putchar(' ');
        	printf("(a<b) = ");
		putchar( x < y ? '1' : '0');
		putchar(' ');		
        	printf("(a>=b) = ");
		putchar( x >= y ? '1' : '0');
		putchar(' ');
        	printf("(a<=b) = ");
		putchar( x <= y ? '1' : '0');
		putchar(' ');
        	printf("(a!=b) = ");
		putchar( x != y ? '1' : '0');
		putchar(' ');
        	printf("(a==b) = ");
		putchar( x == y ? '1' : '0');
		putchar(' ');
		putchar(0x0D);
		putchar(0x0A);	 	


	tempint = -12345678;
	tempint2 = 0xFFFFFFFF;
	tempint3 = 4;
	x = 3456;
	y = 45;

	tempint = tempint >> 16;
	
	tempint2 = tempint2 >> 16;
	
	c = x + y;
	
printf("Addition math: %d + %d = %d\r\n",x,y,c);	

	c = x - y;
	
printf("Subtract math: %d - %d = %d\r\n",x,y,c);	

	c = x * y;

printf("Multiply math: %d x %d = %d\r\n",x,y,c);	

	c = x / y;
	d = x % y;

printf("Division math: %d / %d = %d with %d remainder\r\n",x,y,c,d);	

// Clear screen
//puts("x\ny\nz\n");
printf("UART status = %d \t%X \t%s\r\n",tempint,tempint2,initmsg);
puts("Put string #1 here!\r\nPut string #2 here!\r\n");
lala: goto lala;
}
	
	