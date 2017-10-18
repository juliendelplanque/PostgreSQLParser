plpgsql
plpgsqlReturnForm3
	^ super plpgsqlReturnForm3 ==> [ :tokens |
		PSQLPlpgSQLASTReturnStatement new
			query: tokens third;
			yourself ]