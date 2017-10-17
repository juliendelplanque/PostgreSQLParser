tests-accessing
testPlpgsqlAssignmentStatement
	| node |
	node := builder plpgsqlAssignmentStatement parse: 'truc.machin[id][3] := 42'.
	self
		assert: node class equals: PSQLPlpgSQLASTAssignment;
		assert: node operator equals: ':=';
		assert: node target class equals: PSQLSubscript;
		assert: node toAssign class equals: PSQLASTNumericConstant