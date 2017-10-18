plpgsql
plpgsqlSimpleCase
	^ super plpgsqlSimpleCase ==> [ :tokens |
		PSQLPlpgSQLASTSimpleCase new
			conditionToStatements: (tokens second collect: [ :subTokens | subTokens second -> subTokens fourth ]);
			elseStatements: (tokens third ifNotNil: #second);
			yourself ]