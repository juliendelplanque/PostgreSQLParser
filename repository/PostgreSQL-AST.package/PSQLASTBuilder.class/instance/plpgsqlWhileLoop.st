accessing
plpgsqlWhileLoop
	^ super plpgsqlWhileLoop ==> [ :tokens |
		PSQLPlpgSQLASTWhileLoop new
			beginLabel: tokens first;
			endLabel: tokens last;
			condition: tokens third;
			statements: tokens fifth;
			yourself ]