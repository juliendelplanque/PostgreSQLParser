plpgsql
plpgsqlRaiseStatement5
	^ super plpgsqlRaiseStatement5 ==> [ :tokens |
		PSQLPlpgSQLASTRaiseStatement new ]