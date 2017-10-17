tests-expression
testExpressionParserTermFor
	| node |
	node := builder expression parse: '''a String'''.
	self
		assert: node class equals: PSQLASTStringConstant.
		
	node := builder expression parse: '''a String''::text varying'.
	self
		assert: node class equals: PSQLASTBinaryOperator;
		assert: node left class equals: PSQLASTStringConstant;
		assert: node operator equals: '::';
		assert: node right class equals: PSQLASTIdentifier