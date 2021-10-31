%%{
	machine modem;

	action init {}
	action ccaOn {}
	action ccaOff {}
	action txOn {}
	action txOff {}
	action rxOn {}
	action rxOff {}
	action dozeOn {}
	action dozeOff {}
	action hibOn {}
	action hibOff {}

	modem =
		(
			[^CTRDH]*
			(
				'C' @ccaOn   (any-'c')*'c' @ccaOff |
				'T' @txOn    (any-'t')*'t' @txOff |
				'R' @rxOn    (any-'r')*'r' @rxOff |
				'D' @dozeOn  (any-'A')*'A' @dozeOff |
				'H' @hibOn   (any-'A')*'A' @hibOff
			)
		)*;

	main := (
		'O' @init 
		( modem | any* )
	)?;

}%%
