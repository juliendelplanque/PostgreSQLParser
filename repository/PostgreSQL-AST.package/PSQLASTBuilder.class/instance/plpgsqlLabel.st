accessing
plpgsqlLabel
	^ super plpgsqlLabel ==> [ :tokens |
		PSQLPlpgSQLASTBlockLabel labelContent: tokens ]