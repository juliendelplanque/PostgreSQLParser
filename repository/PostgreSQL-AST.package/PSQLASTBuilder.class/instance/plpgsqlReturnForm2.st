accessing
plpgsqlReturnForm2
	^ super plpgsqlReturnForm2 ==> [ :tokens |
		PSQLPlpgSQLASTReturnStatement new
			expression: tokens third;
			isReturnNext: true;
			yourself ]