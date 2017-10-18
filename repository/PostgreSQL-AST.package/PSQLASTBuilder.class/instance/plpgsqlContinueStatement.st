plpgsql
plpgsqlContinueStatement
	^ super plpgsqlContinueStatement ==> [ :tokens |
		PSQLPlpgSQLASTContinue new
			label: tokens second;
			whenExpression: tokens third second;
			yourself ]