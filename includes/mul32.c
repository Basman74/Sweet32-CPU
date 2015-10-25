unsigned long add(unsigned long x, unsigned long y)
{
  /* An addition of one bit corresponds to the both following logical operations
     for bit result and carry:
        r     = x xor y xor c_in
        c_out = (x and y) or (x and c_in) or (y and c_in)
     However, since we dealing not with bits but words, we have to loop till
     the carry word is stable
  */
  unsigned long t,c=0;
  do {
    t = c;
    c = (x & y) | (x & c) | (y & c);
    c <<= 1;
  } while (c!=t);
  return x^y^c;
}

unsigned long umul32(unsigned long x,unsigned long y)
{
  /* Paper and pencil method for binary positional notation:
     multiply a factor by one (=copy) or zero
     depending on others factor actual digit at position, and  shift 
     through each position; adding up */
  unsigned long r=0;
  while (y != 0) {
    if (y & 1) r = add(r,x);
    y>>=1;
    x<<=1;
  }
  return r;
}