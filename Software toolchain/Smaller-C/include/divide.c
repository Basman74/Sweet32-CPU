
unsigned long udiv32(unsigned long dividend,
		     unsigned long divisor )
{
  unsigned long quotient, remain;
  
  unsigned long t, num_bits;
  unsigned long q, bit, d;
  long i;

  remain = 0;
  quotient = 0;

  if (divisor == 0)
    return 0;

  if (divisor > dividend) {
    remain = dividend;
    return 0;
  }

  if (divisor == dividend) {
    quotient = 1;
    return quotient;
  }

  num_bits = 32;

  while (remain < divisor) {
    bit = (dividend & 0x80000000) >> 31;
    remain = (remain << 1) | bit;
    d = dividend;
    dividend = dividend << 1;
    num_bits--;
  }


  /* The loop, above, always goes one iteration too far.
     To avoid inserting an "if" statement inside the loop
     the last iteration is simply reversed. */

  dividend = d;
  remain = remain >> 1;
  num_bits++;

  for (i = 0; i < num_bits; i++) {
    bit = (dividend & 0x80000000) >> 31;
    remain = (remain << 1) | bit;
    t = remain - divisor;
    q = !((t & 0x80000000) >> 31);
    dividend = dividend << 1;
    quotient = (quotient << 1) | q;
    if (q) {
       remain = t;
     }
  }
  return quotient;
}  /* unsigned_divide */

unsigned long udiv32_2(unsigned long dividend,
		     unsigned long divisor )
{
  unsigned long quotient, remain;
  
  unsigned long t, num_bits;
  unsigned long q, bit, d;
  long i;

  remain = 0;
  quotient = 0;

  if (divisor == 0)
    return 0;

  if (divisor > dividend) {
    remain = dividend;
    return 0;
  }

  if (divisor == dividend) {
    quotient = 1;
    return quotient;
  }

  num_bits = 32;

  while (remain < divisor) {
    bit = (dividend & 0x80000000) >> 31;
    remain = (remain << 1) | bit;
    d = dividend;
    dividend = dividend << 1;
    num_bits--;
  }


  /* The loop, above, always goes one iteration too far.
     To avoid inserting an "if" statement inside the loop
     the last iteration is simply reversed. */

  dividend = d;
  remain = remain >> 1;
  num_bits++;

  for (i = 0; i < num_bits; i++) {
    bit = (dividend & 0x80000000) >> 31;
    remain = (remain << 1) | bit;
    t = remain - divisor;
    q = !((t & 0x80000000) >> 31);
    dividend = dividend << 1;
    quotient = (quotient << 1) | q;
    if (q) {
       remain = t;
     }
  }
  return quotient;
}  /* unsigned_divide */


unsigned long umod32(unsigned long dividend,
		     unsigned long divisor )
{
  unsigned long quotient, remain;
  
  unsigned long t, num_bits;
  unsigned long q, bit, d;
  long i;

  remain = 0;
  quotient = 0;

  if (divisor == 0)
    return 0;

  if (divisor > dividend) {
    remain = dividend;
    return remain;
  }

  if (divisor == dividend) {
    quotient = 1;
    return 0;
  }

  num_bits = 32;

  while (remain < divisor) {
    bit = (dividend & 0x80000000) >> 31;
    remain = (remain << 1) | bit;
    d = dividend;
    dividend = dividend << 1;
    num_bits--;
  }


  /* The loop, above, always goes one iteration too far.
     To avoid inserting an "if" statement inside the loop
     the last iteration is simply reversed. */

  dividend = d;
  remain = remain >> 1;
  num_bits++;

  for (i = 0; i < num_bits; i++) {
    bit = (dividend & 0x80000000) >> 31;
    remain = (remain << 1) | bit;
    t = remain - divisor;
    q = !((t & 0x80000000) >> 31);
    dividend = dividend << 1;
    quotient = (quotient << 1) | q;
    if (q) {
       remain = t;
     }
  }
  return remain;
}  /* unsigned_divide */



unsigned long ABS(unsigned long x) {
	if (x < 0) return 0 - x; else return x;
}


unsigned long sdiv32(long dividend,
		   long divisor )
{
  unsigned long quotient, remain;
  long squotient, sremain;
  
  unsigned long dend, dor;

  dend = ABS(dividend);
  dor  = ABS(divisor);
  quotient = udiv32( dend, dor);
  remain = udiv32( dend, dor);

  /* the sign of the remain is the same as the sign of the dividend
     and the quotient is negated if the signs of the operands are
     opposite */
  squotient = quotient;
  if (dividend < 0) {
    sremain = 0 - remain;
    if (divisor > 0)
      squotient = 0 - quotient;
  }
  else { /* positive dividend */
    sremain = remain;
    if (divisor < 0)
      squotient = 0 - quotient;
  }
  return squotient;
} /* signed_divide */



unsigned long smod32(long dividend,
		   long divisor )
{
  unsigned long quotient, remain;
  long squotient, sremain;
  
  unsigned long dend, dor;

  dend = ABS(dividend);
  dor  = ABS(divisor);
  quotient = udiv32( dend, dor);
  remain = udiv32( dend, dor);

  /* the sign of the remain is the same as the sign of the dividend
     and the quotient is negated if the signs of the operands are
     opposite */
  squotient = quotient;
  if (dividend < 0) {
    sremain = 0 - remain;
    if (divisor > 0)
      squotient = 0 - quotient;
  }
  else { /* positive dividend */
    sremain = remain;
    if (divisor < 0)
      squotient = 0 - quotient;
  }
  return sremain;
} /* signed_divide */
