plpgsql
plpgsqlDeclarations
	^ (plpgsqlDeclarationItem trim separatedBy: semicolon trim) , semicolon trim