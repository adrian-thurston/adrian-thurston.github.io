public class ClientParser
{
%%{
	machine client;

	action call_number {
		System.out.println( "figure out how to print out the call number." );
	}

	action err_code {
		System.out.println( "figure out how to print out the error code." );
	}

	action err_msg {
		System.out.println( "figure out how to print out the error message." );
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

	public static void main( String[] p_args )
	{
		ClientParser l_parse = new ClientParser();
		
		l_parse.parse( p_args[0] );
	}

	public void parse( String p_line )
	{
		//These are all required by ragel
		int cs;
		int p = 0;
		char [] data = p_line.toCharArray();
		int pe = data.length;

		%% write init;
		%% write exec;

		if( cs == client_error )
		{
			System.out.println( "Parse error." );
		}
	}
}
