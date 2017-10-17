accessing
plpgsqlIfThen
	^ super plpgsqlIfThen ==> [ :tokens |
		PSQLPlpgSQLASTIf new
			conditionToStatements: { tokens second -> tokens fourth };
			yourself ]