lex start
{
	ignore /space+/
	literal '*', '(', ')'
	token id /[a-zA-Z_]+/
}

lex alt
{
	ignore /space+/
	token alt /[a-zA-Z_]+/
}

def item 
	[id]
|	['(' item* ')']

def start 
	[item*]

start Input = parse start( stdin )

match Input [ItemList: item*]

alt* L = construct alt*[]

for I: item in rev_repeat( ItemList ) {
	if match I [Id: id] {
		alt A = parse alt(Id)
		L = construct alt*[A L]
	}
}

print_xml( L )
