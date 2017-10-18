plpgsql
plpgsqlIfThenElsif
	^ super plpgsqlIfThenElsif ==> [ :tokens |
		PSQLPlpgSQLASTIf new
			conditionToStatements: { tokens second -> tokens fourth } , (tokens fifth collect: [ :subTokens | subTokens second -> subTokens fourth ]);
			elseStatements: (tokens sixth ifNotNil: #second);
			yourself ]