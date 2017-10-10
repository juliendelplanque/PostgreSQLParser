plpgsql
plpgsqlStatement
	^ (plpgsqlPerformStatement / plpgsqlExecuteStatement / plpgsqlExitStatement / plpgsqlContinueStatement / plpgsqlRaiseStatement / plpgsqlAssignmentStatement / plpgsqlIntoQueryStatement / plpgsqlResultValueStatement / plpgsqlNullStatement / plpgsqlControlStructure) , semicolon trim