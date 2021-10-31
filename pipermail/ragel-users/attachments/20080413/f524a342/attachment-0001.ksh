// This program normally outputs:
//  foo
//  bar
//  foo
//  bar
//
// Process with ragel -G2 to see the difference.

#include <iostream>
using namespace std;

//#define WORKAROUND 1

%%{
	machine test;
	variable eof peof;

	action foo {
		r = "foo";
		fnext bar;
	  #if WORKAROUND
		{ int cs = -1; fbreak; }
	  #else
		fbreak;
	  #endif
	}
	action bar {
		r = "bar";
		fnext foo;
	  #if WORKAROUND
		{ int cs = -1; fbreak; }
	  #else
		fbreak;
	  #endif
	}

	bar := |* "bar" => bar; *|;
	foo := |* "foo" => foo; *|;

	write data;
}%%

int main()
{
	const char data[] = "foobarfoobar";
	const char* p  = data;
	const char* pe = data + sizeof(data) - 1;
	const char* peof = pe;
	const char* ts = NULL;
	const char* te = NULL;
	int act;
	int cs;

	%%write init;

	for (const char* r = NULL; p != pe; r = NULL) {
		%%write exec;

		if (!r) {
			cout << "(null)" << endl;
			break;
		}
		cout << r << endl;
	}

	return 0;
}
