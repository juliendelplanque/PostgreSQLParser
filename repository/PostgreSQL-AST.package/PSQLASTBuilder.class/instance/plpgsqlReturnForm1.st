plpgsql
plpgsqlReturnForm1
	^ super plpgsqlReturnForm1 ==> [ :tokens |
		PSQLPlpgSQLASTReturnStatement new
			expression: tokens second;
			yourself ]