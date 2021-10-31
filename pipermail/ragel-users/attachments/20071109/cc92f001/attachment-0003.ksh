#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h> 
#include <fcntl.h>
#include <stdio.h>
#include <iostream>
#include <string>
#include <map>
#include <pthread.h>
#include <string.h>
#include <assert.h>

using std::ostream;
using std::cout;
using std::cerr;
using std::endl;
using std::map;
using std::multimap;
using std::string;
using std::pair;

const long numThreads = 8;

struct SubString
{
	SubString( char *data, long len ) 
		: data(data), len(len) {}

	char *data;
	long len;

	bool operator<(const SubString &ss2) const
	{
		if ( len < ss2.len )
			return true;
		else if ( len == ss2.len && memcmp( data, ss2.data, len ) < 0 )
			return true;
		return false;
	}
};

ostream &operator<<(ostream &o, const SubString &ss)
{
	o.write( ss.data, ss.len );
	o.flush();
}

typedef map<SubString, long> HitMap;
typedef pair<SubString, long> HitMapEl;
typedef SubString HitMapKey;

typedef multimap<long, HitMapKey> RevMap;
typedef pair<long, HitMapKey> RevMapEl;

struct ThreadData
{
	pthread_t thread;
	void *result;
	char *data;
	long len;
	HitMap hitMap;
};

%%{
	machine wf;

	# Reset consumes to the end of line and then 
	# jumps back to the search pattern. 
	action reset { fhold; fgoto reset; }
	reset := [^\n]* '\n' @{ fgoto main; };

	action start_match { start = p; }
	action match {
		/* Match in start .. p. Try to insert an initial count. If it fails
		 * then increment. */
		HitMapKey s( start, p-start );
		pair<HitMap::iterator, bool> res = td->hitMap.insert( HitMapEl(s, 1) );
		if ( !res.second )
			res.first->second += 1;

		fgoto reset;
	}

	search_pat = 
		[^\n]* :>> ( 'GET /ongoing/When/' [0-9]{3}'x/' );

	name_pat = 
		( [0-9]{4} '/' [0-9]{2} '/' [0-9]{2} [^ .]+ ' ' )
			>start_match @match;

	main := ( search_pat name_pat ) $err(reset);
}%%

%% write data;

void *execute_block( void *arg )
{
	ThreadData *td = (ThreadData*)arg;
	char *start = 0;
	char *p = td->data, *pe = td->data + td->len;
	int cs;

	%% write init;
	%% write exec;

	return 0;
}

void partition( char *data, unsigned long len, ThreadData *td )
{
	long try_size = len / numThreads;
	long last = 0;

	for ( long b = 0; b < numThreads-1; b++ ) {
		/* Set the start. */
		td[b].data = data+last;

		/* Guess an end position and move forward until we go past a newline. */
		char *end = td[b].data + try_size;
		while ( *end++ != '\n' );

		/* Store the length. */
		td[b].len = end - td[b].data;
		last += td[b].len;
	}

	/* Last one just to the end of the file. */
	td[numThreads-1].data = data + last;
	td[numThreads-1].len = len - last;
}

void execute( char *data, unsigned long len )
{
	ThreadData td[numThreads];

	partition( data, len, td );

	for ( int b = 0; b < numThreads; b++ ) {
		int result = pthread_create( &td[b].thread, 0, execute_block, &td[b] );
		if ( result != 0 )
			cerr << "pthread_create of process " << b << " failed" << endl;
	}

	for ( int b = 0; b < numThreads; b++ )
		pthread_join( td[b].thread, &td[b].result );
	
	/* Merge the maps. */
	for ( int b = 1; b < numThreads; b++ ) {
		for ( HitMap::iterator i = td[b].hitMap.begin(); i != td[b].hitMap.end(); i++ ) {
			pair<HitMap::iterator, bool> p = td[0].hitMap.insert( *i );
			if ( !p.second )
				p.first->second += i->second;
		}
	}

	/* Build the reverse map. */
	RevMap revMap;	
	for ( HitMap::iterator i = td[0].hitMap.begin(); i != td[0].hitMap.end(); i++ )
		revMap.insert( RevMapEl( i->second, i->first ) );

	/* Print the top results. */
	long count = 0;
	const long numResults = 10;
	for ( RevMap::reverse_iterator i = revMap.rbegin(); 
			i != revMap.rend() && count < numResults; i++, count++ )
	{
		cout << (*i).first << " => " << (*i).second << endl;
	}
}

int main( int argc, char **argv )
{
	int fd;
	char *src;
	struct stat statbuf;

	if ( argc != 2 ) {
		cerr << "usage: wf <file>" << endl;
		return -1;
	}
	
	/* Open the input file. */
	fd = open( argv[1], O_RDONLY);
	if ( fd < 0 ) {
		cerr << "cannot open input file" << endl;
		return -1;
	}

	/* Stat the input file to get its size. */
	if ( fstat( fd, &statbuf ) < 0 ) {
		cerr << "fstat failed" << endl;
		return -1;
	}

	/* Mmap the input file. */
	src = (char*) mmap (0, statbuf.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
	if ( src == (caddr_t) -1 ) {
		cerr << "mmap call failed" << endl;
		return -1;
	}

	execute( src, statbuf.st_size );
	return 0;
}
