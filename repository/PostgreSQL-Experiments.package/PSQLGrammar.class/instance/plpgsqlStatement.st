plpgsql
plpgsqlStatement
	^ (plpgsqlPerformStatement / plpgsqlExecuteStatement / plpgsqlAssignmentStatement / plpgsqlIntoQueryStatement / plpgsqlResultValueStatement / plpgsqlControlStructure / plpgsqlNullStatement) , semicolon trim