#!/bin/sh

# float_t is not an abi type thus convert it to ABI type float, double or double_t at build time
# this is used for symbols file
set -e
dir="$(mktemp -d)"
trap 'rm -rf -- "$dir"' EXIT
cat > $dir/float.c <<"EOF"
#include <math.h>
#include <stdio.h>

int main()
{
    switch(sizeof(float_t)) {
	case(sizeof(float)):
	    printf("float");
	    return 0;
        case(sizeof(double)):
            printf("double");
            return 0;
        case(sizeof(long double)):
            printf("long double");
	    return 0;
        default:
            printf("????");
            return 1;
    }
}
EOF


gcc -o $dir/float -lm $dir/float.c
$dir/float

