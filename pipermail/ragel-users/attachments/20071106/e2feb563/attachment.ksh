#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h> 
#include <fcntl.h>
#include <stdio.h>

%%{
	machine wf;

	# Reset consumes to the end of line and then 
	# jumps back to the search pattern. 
	action reset { fgoto reset; }
	reset := [^\n]* '\n' @{ fgoto main; };

	action start_match { start = p; }
	action match {
		/* Match in start .. p. */
		//fwrite( start, 1, p-start, stdout );
		//fputc( '\n', stdout );
		fgoto reset;
	}

	name_pat = [0-9]{4} '/' [0-9]{2} '/' [0-9]{2} [^ .]+ ' ';
	name := name_pat >start_match @match $err(reset);

	action try_name { fgoto name; }

	search_pat = [^\n]* :> ( 'GET /ongoing/When/' [0-9]{3}'x/' );
	main := search_pat @try_name $err(reset);
}%%

%% write data;

void execute( char *data, unsigned long len )
{
	char *p = data;
	char *pe = data + len;
	char *start = 0;
	int cs;

	%% write init;
	%% write exec;
}

int main( int argc, char **argv )
{
	int fd;
	char *src;
	struct stat statbuf;

	if ( argc != 2 ) {
		fprintf( stderr, "usage: wf <file>\n" );
		return -1;
	}
	
	/* Open the input file. */
	fd = open( argv[1], O_RDONLY);
	if ( fd < 0 ) {
		fprintf( stderr, "cannot open input file\n" );
		return -1;
	}

	/* Stat the input file to get its size. */
	if ( fstat( fd, &statbuf ) < 0 ) {
		fprintf( stderr, "fstat failed\n" );
		return -1;
	}

	/* Mmap the input file. */
	src = mmap (0, statbuf.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
	if ( src == (caddr_t) -1 ) {
		fprintf( stderr, "mmap call failed\n" );
		return -1;
	}

	execute( src, statbuf.st_size );
	return 0;
}
