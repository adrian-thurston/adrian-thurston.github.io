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
			# Consume spaces.
			[ \t]+;

			# Consume line continuations
			'\r'? '\n' [ \t]+;

			# An end of header. Holds the \n so the end pattern can match.
			'\r'? '\n' => { 
				cerr << "returning from ws (done) " << (p-str) << endl;
				fhold; fret;
			};

			# Any other character, hold it and return. */
			any => {
				cerr << "returning from ws (cont)" << endl; 
				fhold; fret;
			};
		*|;

		# A word is any non-whitespace.
		word = [^ \t\r\n]+;

		# Whitespace machine: holds the character and jumps to the whitespace
		# scanner for processing.
		ws = [ \t\r\n] @{ 
			cerr << "going to whitespace " << (p-str) << endl; 
			fhold; fcall ws_scan;
		};

		# A newline immediately after coming back from the whitespace scanner
		# signifies the end of a header.
		ws_end = ws '\n';

		header = [a-z]+ ':' ws? word (ws word)* ws_end;

		main := header+ 0;

		# Initialize and execute.
		write init;
		write exec;
	}%%

	if ( cs < sipws_first_final )
		cerr << "sipws: there was an error at position " << (p-str) << endl;
};


#define BUFSIZE 1024

int main()
{
	sipws( 
		"hr: asdf ljfa ljd\n"
		"	cont\n"
		"new:asiei\n"
	);
	return 0;
}
