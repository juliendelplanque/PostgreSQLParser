accessing
plpgsqlIfThenElse
	^ super plpgsqlIfThenElse ==> [ :tokens |
		PSQLPlpgSQLASTIf new
			conditionToStatements: { tokens second -> tokens fourth };
			elseStatements: tokens sixth;
			yourself ]