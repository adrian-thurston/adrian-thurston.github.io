#include <stdio.h>
#include <string.h>

%%{
	machine foo;
	getkey ( ( data[p>>3] >> (p & 0x7) ) & 0x1 );

	main := 0* 1* 0*;
}%%

%% write data;

int main( int argc, char **argv )
{
	if ( argc < 2 ) {
		printf("expecting at least one argument\n");
		return 1;
	}

	char *data = argv[1];
	long length = strlen( data );

	int p = 0;
	int pe = length << 3;
	int eof = pe;

	int cs;

	%% write init;
	%% write exec;

	if ( cs == foo_error )
		printf("FAILED\n");
}
