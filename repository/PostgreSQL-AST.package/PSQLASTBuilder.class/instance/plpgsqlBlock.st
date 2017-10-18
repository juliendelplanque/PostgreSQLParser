plpgsql
plpgsqlBlock
	^ super plpgsqlBlock ==> [ :tokens |
		PSQLPlpgSQLASTBlock new
			label: tokens first;
			declarations: (tokens second ifNotNil: #second);
			statements: tokens fourth;
			yourself ]