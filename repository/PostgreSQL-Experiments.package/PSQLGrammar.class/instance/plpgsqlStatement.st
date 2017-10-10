plpgsql
plpgsqlStatement
	^ (plpgsqlPerformStatement / plpgsqlExecuteStatement / plpgsqlExitStatement / plpgsqlContinueStatement / plpgsqlRaiseStatement / plpgsqlAssertStatement / plpgsqlAssignmentStatement / plpgsqlIntoQueryStatement / plpgsqlResultValueStatement / plpgsqlNullStatement / plpgsqlControlStructure / plpgsqlUnhandledStatement) , semicolon trim