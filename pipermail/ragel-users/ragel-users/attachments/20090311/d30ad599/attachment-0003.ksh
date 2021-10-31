%%{
	machine atoi;

	main := ( '-'@see_neg | '+' )? ( digit @add_digit )+ 
		( '-'@see_neg | '+' )? ( digit @add_digit )+ '\n';
}%%
