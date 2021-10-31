#line 1 "rwf.rl"
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

#line 92 "rwf.rl"



#line 70 "rwf.cpp"
static const int wf_start = 1;
static const int wf_first_final = 37;
static const int wf_error = 0;

static const int wf_en_reset = 36;
static const int wf_en_main = 1;

#line 95 "rwf.rl"

void *execute_block( void *arg )
{
	ThreadData *td = (ThreadData*)arg;
	char *start = 0;
	char *p = td->data, *pe = td->data + td->len;
	int cs;

	
#line 88 "rwf.cpp"
	{
	cs = wf_start;
	}
#line 104 "rwf.rl"
	
#line 94 "rwf.cpp"
	{
	if ( p == pe )
		goto _out;
	switch ( cs )
	{
st1:
	if ( ++p == pe )
		goto _out1;
case 1:
	switch( (*p) ) {
		case 10: goto tr1;
		case 71: goto st2;
	}
	goto st1;
tr1:
#line 69 "rwf.rl"
	{ p--; {goto st36;} }
	goto st0;
#line 113 "rwf.cpp"
st0:
	goto _out0;
st2:
	if ( ++p == pe )
		goto _out2;
case 2:
	switch( (*p) ) {
		case 10: goto tr1;
		case 69: goto st3;
		case 71: goto st2;
	}
	goto st1;
st3:
	if ( ++p == pe )
		goto _out3;
case 3:
	switch( (*p) ) {
		case 10: goto tr1;
		case 71: goto st2;
		case 84: goto st4;
	}
	goto st1;
st4:
	if ( ++p == pe )
		goto _out4;
case 4:
	switch( (*p) ) {
		case 10: goto tr1;
		case 32: goto st5;
		case 71: goto st2;
	}
	goto st1;
st5:
	if ( ++p == pe )
		goto _out5;
case 5:
	switch( (*p) ) {
		case 10: goto tr1;
		case 47: goto st6;
		case 71: goto st2;
	}
	goto st1;
st6:
	if ( ++p == pe )
		goto _out6;
case 6:
	switch( (*p) ) {
		case 10: goto tr1;
		case 71: goto st2;
		case 111: goto st7;
	}
	goto st1;
st7:
	if ( ++p == pe )
		goto _out7;
case 7:
	switch( (*p) ) {
		case 10: goto tr1;
		case 71: goto st2;
		case 110: goto st8;
	}
	goto st1;
st8:
	if ( ++p == pe )
		goto _out8;
case 8:
	switch( (*p) ) {
		case 10: goto tr1;
		case 71: goto st2;
		case 103: goto st9;
	}
	goto st1;
st9:
	if ( ++p == pe )
		goto _out9;
case 9:
	switch( (*p) ) {
		case 10: goto tr1;
		case 71: goto st2;
		case 111: goto st10;
	}
	goto st1;
st10:
	if ( ++p == pe )
		goto _out10;
case 10:
	switch( (*p) ) {
		case 10: goto tr1;
		case 71: goto st2;
		case 105: goto st11;
	}
	goto st1;
st11:
	if ( ++p == pe )
		goto _out11;
case 11:
	switch( (*p) ) {
		case 10: goto tr1;
		case 71: goto st2;
		case 110: goto st12;
	}
	goto st1;
st12:
	if ( ++p == pe )
		goto _out12;
case 12:
	switch( (*p) ) {
		case 10: goto tr1;
		case 71: goto st2;
		case 103: goto st13;
	}
	goto st1;
st13:
	if ( ++p == pe )
		goto _out13;
case 13:
	switch( (*p) ) {
		case 10: goto tr1;
		case 47: goto st14;
		case 71: goto st2;
	}
	goto st1;
st14:
	if ( ++p == pe )
		goto _out14;
case 14:
	switch( (*p) ) {
		case 10: goto tr1;
		case 71: goto st2;
		case 87: goto st15;
	}
	goto st1;
st15:
	if ( ++p == pe )
		goto _out15;
case 15:
	switch( (*p) ) {
		case 10: goto tr1;
		case 71: goto st2;
		case 104: goto st16;
	}
	goto st1;
st16:
	if ( ++p == pe )
		goto _out16;
case 16:
	switch( (*p) ) {
		case 10: goto tr1;
		case 71: goto st2;
		case 101: goto st17;
	}
	goto st1;
st17:
	if ( ++p == pe )
		goto _out17;
case 17:
	switch( (*p) ) {
		case 10: goto tr1;
		case 71: goto st2;
		case 110: goto st18;
	}
	goto st1;
st18:
	if ( ++p == pe )
		goto _out18;
case 18:
	switch( (*p) ) {
		case 10: goto tr1;
		case 47: goto st19;
		case 71: goto st2;
	}
	goto st1;
st19:
	if ( ++p == pe )
		goto _out19;
case 19:
	switch( (*p) ) {
		case 10: goto tr1;
		case 71: goto st2;
	}
	if ( 48 <= (*p) && (*p) <= 57 )
		goto st20;
	goto st1;
st20:
	if ( ++p == pe )
		goto _out20;
case 20:
	switch( (*p) ) {
		case 10: goto tr1;
		case 71: goto st2;
	}
	if ( 48 <= (*p) && (*p) <= 57 )
		goto st21;
	goto st1;
st21:
	if ( ++p == pe )
		goto _out21;
case 21:
	switch( (*p) ) {
		case 10: goto tr1;
		case 71: goto st2;
	}
	if ( 48 <= (*p) && (*p) <= 57 )
		goto st22;
	goto st1;
st22:
	if ( ++p == pe )
		goto _out22;
case 22:
	switch( (*p) ) {
		case 10: goto tr1;
		case 71: goto st2;
		case 120: goto st23;
	}
	goto st1;
st23:
	if ( ++p == pe )
		goto _out23;
case 23:
	switch( (*p) ) {
		case 10: goto tr1;
		case 47: goto st24;
		case 71: goto st2;
	}
	goto st1;
st24:
	if ( ++p == pe )
		goto _out24;
case 24:
	if ( 48 <= (*p) && (*p) <= 57 )
		goto tr25;
	goto tr1;
tr25:
#line 72 "rwf.rl"
	{ start = p; }
	goto st25;
st25:
	if ( ++p == pe )
		goto _out25;
case 25:
#line 354 "rwf.cpp"
	if ( 48 <= (*p) && (*p) <= 57 )
		goto st26;
	goto tr1;
st26:
	if ( ++p == pe )
		goto _out26;
case 26:
	if ( 48 <= (*p) && (*p) <= 57 )
		goto st27;
	goto tr1;
st27:
	if ( ++p == pe )
		goto _out27;
case 27:
	if ( 48 <= (*p) && (*p) <= 57 )
		goto st28;
	goto tr1;
st28:
	if ( ++p == pe )
		goto _out28;
case 28:
	if ( (*p) == 47 )
		goto st29;
	goto tr1;
st29:
	if ( ++p == pe )
		goto _out29;
case 29:
	if ( 48 <= (*p) && (*p) <= 57 )
		goto st30;
	goto tr1;
st30:
	if ( ++p == pe )
		goto _out30;
case 30:
	if ( 48 <= (*p) && (*p) <= 57 )
		goto st31;
	goto tr1;
st31:
	if ( ++p == pe )
		goto _out31;
case 31:
	if ( (*p) == 47 )
		goto st32;
	goto tr1;
st32:
	if ( ++p == pe )
		goto _out32;
case 32:
	if ( 48 <= (*p) && (*p) <= 57 )
		goto st33;
	goto tr1;
st33:
	if ( ++p == pe )
		goto _out33;
case 33:
	if ( 48 <= (*p) && (*p) <= 57 )
		goto st34;
	goto tr1;
st34:
	if ( ++p == pe )
		goto _out34;
case 34:
	switch( (*p) ) {
		case 32: goto tr1;
		case 46: goto tr1;
	}
	goto st35;
st35:
	if ( ++p == pe )
		goto _out35;
case 35:
	switch( (*p) ) {
		case 32: goto tr36;
		case 46: goto tr1;
	}
	goto st35;
tr36:
#line 73 "rwf.rl"
	{
		/* Match in start .. p. Try to insert an initial count. If it fails
		 * then increment. */
		HitMapKey s( start, p-start );
		pair<HitMap::iterator, bool> res = td->hitMap.insert( HitMapEl(s, 1) );
		if ( !res.second )
			res.first->second += 1;

		{goto st36;}
	}
	goto st37;
st37:
	if ( ++p == pe )
		goto _out37;
case 37:
#line 449 "rwf.cpp"
	goto tr1;
st36:
	if ( ++p == pe )
		goto _out36;
case 36:
	if ( (*p) == 10 )
		goto tr38;
	goto st36;
tr38:
#line 70 "rwf.rl"
	{ {goto st1;} }
	goto st38;
st38:
	if ( ++p == pe )
		goto _out38;
case 38:
#line 466 "rwf.cpp"
	goto st0;
	}
	_out1: cs = 1; goto _out; 
	_out0: cs = 0; goto _out; 
	_out2: cs = 2; goto _out; 
	_out3: cs = 3; goto _out; 
	_out4: cs = 4; goto _out; 
	_out5: cs = 5; goto _out; 
	_out6: cs = 6; goto _out; 
	_out7: cs = 7; goto _out; 
	_out8: cs = 8; goto _out; 
	_out9: cs = 9; goto _out; 
	_out10: cs = 10; goto _out; 
	_out11: cs = 11; goto _out; 
	_out12: cs = 12; goto _out; 
	_out13: cs = 13; goto _out; 
	_out14: cs = 14; goto _out; 
	_out15: cs = 15; goto _out; 
	_out16: cs = 16; goto _out; 
	_out17: cs = 17; goto _out; 
	_out18: cs = 18; goto _out; 
	_out19: cs = 19; goto _out; 
	_out20: cs = 20; goto _out; 
	_out21: cs = 21; goto _out; 
	_out22: cs = 22; goto _out; 
	_out23: cs = 23; goto _out; 
	_out24: cs = 24; goto _out; 
	_out25: cs = 25; goto _out; 
	_out26: cs = 26; goto _out; 
	_out27: cs = 27; goto _out; 
	_out28: cs = 28; goto _out; 
	_out29: cs = 29; goto _out; 
	_out30: cs = 30; goto _out; 
	_out31: cs = 31; goto _out; 
	_out32: cs = 32; goto _out; 
	_out33: cs = 33; goto _out; 
	_out34: cs = 34; goto _out; 
	_out35: cs = 35; goto _out; 
	_out37: cs = 37; goto _out; 
	_out36: cs = 36; goto _out; 
	_out38: cs = 38; goto _out; 

	_out: {}
	}
#line 105 "rwf.rl"

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
