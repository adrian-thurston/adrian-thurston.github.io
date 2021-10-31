#include <iostream>
#include <stdlib.h>
#include <stdio.h>

using namespace std;

%%{
	machine sipws;
	write data;
}%%

void sipws( char *str )
{
	char *p = str, *pe = str + strlen(str) + 1;
	int cs;
	int stack[1];
	int top, act;
	char *tokstart, *tokend;

	%%{
		ws_scan := |*
			# The whitespace pattern. 
			( ( "\r"? "\n" )? [ \t] )+ => {
				cerr << "captured ws, returning " << (p-str) << endl;
				fret;
			};

			# Default for returning.
			any => {
				cerr << "did not match whitespace, returning" << endl; 
				fhold; fret;
			};
		*|;

		# A word is any graphical character [!-~].
		word = graph+;

		# Whitespace machine: holds the character and jumps to the whitespace
		# scanner for processing.
		ws = [ \t\r\n] @{ 
			cerr << "attempting whitespace" << (p-str) << endl; 
			fhold; fcall ws_scan;
		};

		# crlf cannot be matched by the whitespace machine.
		crlf = '\r'? '\n';

		header = [a-z]+ ':' ws? word (ws word)* ws? crlf;

		main := header+ 0;

		# Initialize and execute.
		write init;
		write exec;
	}%%

	if ( cs < sipws_first_final )
		cerr << "sipws: there was an error at position " << (p-str) << endl;
};

int main()
{
	sipws( 
		"hr: asdf ljfa ljd\n"
		"	cont\n"
		"new:asiei\n"
	);
	return 0;
}
