lex start
	token comma / ',' /
	token newline / '\n' /
	token aas /'a'*/
	token bbs /'b'*/
end

def line
	[aas comma bbs newline]
|	[newline]

def lines
	[line lines]
|	[line]
|	[]

parse Content: lines[ stdin ]

if ( Content ) {
	for Line: line in Content {
		print( Line.aas, "*", Line.bbs, "\n" )
	}
} else {
	print( "Nope\n" )
}

