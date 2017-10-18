tests-plpgsql
testPlpgsqlContinueStatement
	| node |
	node := builder plpgsqlContinueStatement parse: 'CONTINUE WHEN count < 50'.
	self
		assert: node class equals: PSQLPlpgSQLASTContinue;
		assert: node label isNil;
		assert: node whenExpression class equals: PSQLASTBinaryOperator