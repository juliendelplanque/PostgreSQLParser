plpgsql
plpgsqlStatement
	^ (plpgsqlPerformStatement / plpgsqlExecuteStatement / plpgsqlExitStatement / plpgsqlContinueStatement / plpgsqlAssignmentStatement / plpgsqlIntoQueryStatement / plpgsqlResultValueStatement / plpgsqlControlStructure / plpgsqlNullStatement) , semicolon trim