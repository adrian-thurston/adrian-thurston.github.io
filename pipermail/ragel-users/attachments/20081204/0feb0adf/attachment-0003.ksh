#include <stdio.h>
#include <string.h>

%%{
	machine client;

	action call_number {
		printf( "figure out how to print out the call number.\n" );
	}

	action err_code {
		printf( "figure out how to print out the error code.\n" );
	}

	action err_msg {
		printf( "figure out how to print out the error message.\n" );
	}

	# Single Quoted string.
	squotedStr = '\'' . [^'\\] . '\'';

	# Double Quoted string.
	dquotedStr = '"' . [^'\\] . '"';

	arb_string = !(space - '\n') | squotedStr | dquotedStr;

	ok_tk = "OK ";
	callnum = "callnum " . (digit+) %call_number;
	error_tk = "ERROR ";
	errspec = (digit+) %err_code . " " . arb_string %err_msg;
	
	goodcall = ok_tk . callnum;
	badcall = error_tk . callnum . " " . errspec;
	error = error_tk . errspec;

	main := ( goodcall | badcall | error ) . '\n'; 

}%%

%% write data;

#define BUFSIZE 1024

int main( int argc, char **argv )
{
	int a, cs;
	char buf[BUFSIZE];

	%% write init;

	while ( fgets( buf, sizeof(buf), stdin ) != 0 )
	{
		const char *p = buf;
		const char *pe =  p + strlen( buf );

		%% write exec;
	}

	if( cs == client_error )
	{
		printf( "Parse error.\n" );
	}

	return 0;
}
