#include <stdlib.h>
#include <stdio.h>
#include <string.h>

%%{
	machine cond_test;
	write data;
}%%

void cond_test( char *str )
{
	char c = 0, *p = str, *pe = p + strlen(str);
	int cs;

	%%{
		action store { c = *p; }
		action match { c == *p }

		main := any @store any* :> any when match '\n';

		write init;
		write exec;
	}%%

	if ( cs < cond_test_first_final )
		printf( "cond_test: there was an error\n" );
};


#define BUFSIZE 1024

int main()
{
	char buf[BUFSIZE];
	while ( fgets( buf, sizeof(buf), stdin ) != 0 )
		cond_test( buf );
	return 0;
}
