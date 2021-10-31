#include <stdio.h>
#include <stdlib.h>

%%{
	machine foo;

	action ehandle1 {
		printf( "error 1 at char: %c\n", *p );
		fgoto err1;
	}
	action ehandle2 {
		printf( "error 2 at char: %c\n", *p );
		fgoto err2;
	}

	err1 := [^}]* '}' @{ 
		printf( "resuming from error 1\n" );
		fgoto recover1;
	};
	err2 := [^;}]* (
		';' @{
			printf( "resuming from error 2\n" );
			fgoto recover2;
		} |
		'}' @{
			printf( "resuming from error 2\n" );
			fgoto recover1;
		}
	);

	something = ' '*;
	pr = alnum+ ';';
	se = 
		something $!ehandle1
		'{' 
			recover2: pr* $!ehandle2 
		'}';

	main := recover1: se+ '\n';
}%%

%% write data nofinal;

#define BUFSIZE 128

void scanner()
{
	static char buf[BUFSIZE];
	int cs, done = 0;

	%% write init;

	while ( !done ) {
		char *p = buf, *pe;
		int len, space = BUFSIZE;
		
		len = fread( p, 1, space, stdin );

		/* If this is the last buffer, tack on an EOF. */
		if ( len < space )
			done = 1;
			
		pe = p + len;
		%% write exec;

		if ( cs == foo_error ) {
			fprintf(stderr, "PARSE ERROR\n" );
			break;
		}
	}
}

int main()
{
	scanner();
	return 0;
}

