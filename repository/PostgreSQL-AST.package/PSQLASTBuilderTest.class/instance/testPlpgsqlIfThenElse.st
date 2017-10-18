tests-accessing
testPlpgsqlIfThenElse
	| node |
	node := builder plpgsqlIfThenElse parse: 'IF x = 1 THEN
	stmt := 1;
ELSE
	stmt := stmt +1;
END IF'.
	self
		assert: node class equals: PSQLPlpgSQLASTIf;
		assert: node conditionToStatements size equals: 1;
		assert: node conditionToStatements first head class equals: PSQLASTBinaryOperator;
		assert: node conditionToStatements first tail size equals: 1;
		assert: node elseStatements size equals: 1