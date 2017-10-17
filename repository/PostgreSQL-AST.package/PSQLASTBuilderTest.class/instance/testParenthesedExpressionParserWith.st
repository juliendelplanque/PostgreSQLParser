tests-expression
testParenthesedExpressionParserWith
	| node |
	node := builder expression parse: '(id+1)'.
	self
		assert: node class equals: PSQLParenthesedExpression;
		assert: node expression class equals: PSQLASTBinaryOperator