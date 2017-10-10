accessing
plpgsqlQueryResultsLoop
	^ super plpgsqlQueryResultsLoop ==> [ :tokens |
		PSQLPlpgSQLASTQueryResultsLoop new
			beginLabel: tokens first;
			endLabel: tokens last;
			statements: tokens seventh;
			target: tokens third;
			query: tokens fifth;
			yourself ]