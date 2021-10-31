/*
 * Convert a string to an integer.
 */

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

%%{
	machine atoi;

	action see_neg {
		neg = true;
	}

	action add_digit { 
		val = val * 10 + (fc - '0');
	}

	include "atoi-machine.rl";

	write data;
}%%

long long atoi( char *str )
{
	char *p = str, *pe = str + strlen( str );
	int cs;
	long long val = 0;
	bool neg = false;

	%% write init;
	%% write exec;

	if ( neg )
		val = -1 * val;

	if ( cs < atoi_first_final )
		fprintf( stderr, "atoi: there was an error\n" );

	return val;
};


#define BUFSIZE 1024

int main()
{
	char buf[BUFSIZE];
	while ( fgets( buf, sizeof(buf), stdin ) != 0 ) {
		long long value = atoi( buf );
		printf( "%lld\n", value );
	}
	return 0;
}

