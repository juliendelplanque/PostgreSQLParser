plpgsql
plpgsqlForLoop
	^ super plpgsqlForLoop ==> [ :tokens |
		PSQLPlpgSQLASTForLoop new
			beginLabel: tokens first;
			endLabel: tokens last;
			statements: (tokens at: 11);
			target: tokens third;
			fromExpression: tokens sixth;
			toExpression: tokens eighth;
			yourself ]