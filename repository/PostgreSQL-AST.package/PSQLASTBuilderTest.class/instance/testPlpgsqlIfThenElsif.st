tests-accessing
testPlpgsqlIfThenElsif
	| node |
	node := builder plpgsqlIfThenElsif parse: 'IF x = 1 THEN
	stmt := 1;
ELSE IF x = 2 THEN
	stmt := 2;
ELSIF x = 3 THEN
	stmt := 3;
ELSE
	stmt := stmt +1;
END IF'.
	self
		assert: node class equals: PSQLPlpgSQLASTIf;
		assert: node conditionToStatements size equals: 3;
		assert: node elseStatements size equals: 1