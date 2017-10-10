plpgsql
plpgsqlBlock
	^ plpgsqlBeginLabel trim optional ,
	(declare trim , plpgsqlDeclarations trim) optional ,
	begin trim ,
	plpgsqlStatements trim ,
	endKeyword trim ,
	plpgsqlEndLabel trim optional , semicolon trim