accessing
plpgsqlAssignmentStatement
	^ super plpgsqlAssignmentStatement ==> [ :tokens |
		PSQLPlpgSQLASTAssignment new
			target: tokens first;
			operator: tokens second;
			toAssign: tokens third;
			yourself ]