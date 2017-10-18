plpgsql
plpgsqlLoopLoop
	^ super plpgsqlLoopLoop ==> [ :tokens |
		PSQLPlpgSQLASTLoop new
			beginLabel: tokens first;
			endLabel: tokens last;
			statements: tokens third;
			yourself ]