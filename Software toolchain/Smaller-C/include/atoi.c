long atol(char *string) {
    long result = 0;
    unsigned long digit;
    int sign;

    /*
     * Skip any leading blanks.
     */

    //while (*string = ' ') {
	//string += 1;
    //}

    /*
     * Check for a sign.
     */

    if (*string == '-') {
	sign = 1;
	string += 1;
    } else {
	sign = 0;
	if (*string == '+') {
	    string += 1;
	}
    }

    for ( ; ; string += 1) {
	digit = *string - '0';
	if (digit > 9) {
	    break;
	}
	result = umul32(10, result) + digit;
    }

    if (sign) {
	return ~result + 1;
    }
    return result;
}
