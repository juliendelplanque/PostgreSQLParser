plpgsql
plpgsqlBlock
	^ plpgsqlBeginLabel trim optional ,
	plpgsqlDeclarations trim optional ,
	begin trim ,
	plpgsqlStatements trim ,
	endKeyword trim ,
	plpgsqlEndLabel trim optional