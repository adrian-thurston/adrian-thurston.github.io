jinclude <stdio.h>

%%{
	machine diff;
	action count_line {}
	action mark {}
	action add_line {}
	action push {}
	action push_zero {}
	action pop_hunk_spec {}
	action copy_to_filespec {}
	action enter_hunk { printf("  enter_hunk\n"); }
	action exit_hunk {  printf("  exit_hunk\n"); }
	action enter_diff { printf("enter_diff\n"); }
	action exit_diff { printf("exit_diff\n"); }
	action empty_diff { printf("  this diff is empty\n"); }
	action binary_diff {}
	action error {}

	nbsp = space - '\n' %count_line;
	lineChar = extend - '\n';
	
	diffLine = 
		( '\\' lineChar* '\n' %count_line ) |
		( ' ' | '-' | '+' ) >mark 
		lineChar* '\n' @add_line %count_line;
	
	separator = '='+ '\n' %count_line;
	
	oldFile = '---' lineChar+ '\n' %count_line;
	newFile = '+++' lineChar+ '\n' %count_line;
	
	range = ( '-' | '+' ) ( digit+ >mark %push ) ( ' ' %push_zero 
			@{ fhold; }  | ',' ( digit+ >mark %push ) );
	
	hunkHeader = '@@' nbsp* range nbsp+ range nbsp* '@@' '\n'
		@pop_hunk_spec %count_line;
	
	hunkBody = diffLine+;
	
	hunk = hunkHeader >enter_hunk hunkBody %exit_hunk %/exit_hunk;
	
	fileName = ( lineChar+ ) >mark %copy_to_filespec;
	
	fileSpec = "Index:" nbsp+ fileName '\n'+ @count_line;
	
	diffHeader = fileSpec separator;
	
	diffBody = hunk*;
	
	binaryDiff = 'C' lineChar+ '\n' %count_line lineChar+ '\n'
		%binary_diff %count_line;
	
	textDiff = oldFile newFile diffBody;
	
	diff = (
		diffHeader %empty_diff %/empty_diff |
		diffHeader ( binaryDiff | textDiff ) ?
	)
	>enter_diff	%exit_diff %/exit_diff;
	
	main := diff* $!error;
}%%

%% write data;

int main()
{
	static char buf[2000000];
	int len = fread( buf, 1, sizeof(buf), stdin );
	printf( "%i\n", len );

	int cs;
	char *p = buf, *pe = buf+len;
	%%{
		write init;
		write exec;
	}%%

	if ( cs < diff_first_final )
		printf(" ERROR \n" );
	else {
		%% write eof;
	}
	return 0;
}

