plpgsql
plpgsqlStatement
	^ (plpgsqlPerformStatement / plpgsqlExecuteStatement / plpgsqlExitStatement / plpgsqlContinueStatement / plpgsqlAssignmentStatement / plpgsqlIntoQueryStatement / plpgsqlResultValueStatement / plpgsqlNullStatement / plpgsqlControlStructure) , semicolon trim