plpgsql
plpgsqlAliasDeclaration
	^ super plpgsqlAliasDeclaration ==> [ :tokens |
		PSQLPlpgSQLASTAliasDeclaration new
			identifier: tokens first;
			aliased: tokens fourth;
			yourself ]