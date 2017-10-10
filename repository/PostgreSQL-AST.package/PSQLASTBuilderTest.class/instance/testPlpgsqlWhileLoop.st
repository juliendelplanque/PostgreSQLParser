tests-accessing
testPlpgsqlWhileLoop
	| node |
	node := builder plpgsqlWhileLoop parse: 'WHILE amount_owed < 42 LOOP
    amount_owed := amount_owed + 1;
END LOOP'.
	self
		assert: node class equals: PSQLPlpgSQLASTWhileLoop;
		assert: node beginLabel isNil;
		assert: node endLabel isNil;
		assert: node condition class equals: PSQLASTBinaryOperator;
		assert: node statements size equals: 1