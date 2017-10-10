plpgsql
plpgsqlDeclarations
	^ (plpgsqlDeclarationItem trim separatedBy: semicolon) , semicolon trim