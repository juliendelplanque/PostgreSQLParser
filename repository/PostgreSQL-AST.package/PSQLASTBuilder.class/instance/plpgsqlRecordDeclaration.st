plpgsql
plpgsqlRecordDeclaration
	^ super plpgsqlRecordDeclaration ==> [ :tokens |
		PSQLPlpgSQLASTRecordDeclaration new
			identifier: tokens first;
			yourself ]