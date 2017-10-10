tests-accessing
testPlpgsqlForLoop
	| node |
	node := builder plpgsqlForLoop parse: '<<forlabel>>
FOR i IN 1 .. 10 LOOP
    NULL;
END LOOP forlabel'.
	self
		assert: node class equals: PSQLPlpgSQLASTForLoop;
		assert: node beginLabel class equals: PSQLPlpgSQLASTBlockLabel;
		assert: node endLabel class equals: PSQLPlpgSQLASTBlockLabel;
		assert: node statements size equals: 1;
		assert: node target class equals: PSQLASTIdentifier;
		assert: node fromExpression class equals: PSQLASTNumericConstant;
		assert: node toExpression class equals: PSQLASTNumericConstant