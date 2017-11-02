plpgsql
plpgsqlRowTypeDeclaration
	^ super plpgsqlRowTypeDeclaration ==> [ :tokens |
		PSQLPlpgSQLASTRowTypeDeclaration new
			identifier: tokens first;
			tableIdentifier: tokens second;
			yourself ]