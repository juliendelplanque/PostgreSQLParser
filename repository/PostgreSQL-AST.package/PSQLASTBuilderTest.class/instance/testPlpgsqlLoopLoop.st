tests-accessing
testPlpgsqlLoopLoop
	| node |
	node := builder plpgsqlLoopLoop parse: 'LOOP
    amount_owed := amount_owed + 1;
END LOOP'.
	self
		assert: node class equals: PSQLPlpgSQLASTLoop;
		assert: node beginLabel isNil;
		assert: node endLabel isNil;
		assert: node statements size equals: 1