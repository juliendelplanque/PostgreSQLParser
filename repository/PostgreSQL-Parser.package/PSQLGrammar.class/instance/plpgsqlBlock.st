plpgsql
plpgsqlBlock
	^ plpgsqlBeginLabel trim optional ,
	(kw declare trim , plpgsqlDeclarations trim) optional ,
	kw begin trim ,
	plpgsqlStatements trim ,
	kw endKeyword trim ,
	plpgsqlEndLabel trim optional , semicolon trim