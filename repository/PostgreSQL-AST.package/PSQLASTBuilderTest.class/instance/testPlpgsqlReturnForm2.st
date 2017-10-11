tests-accessing
testPlpgsqlReturnForm2
	| node |
	node := builder plpgsqlReturnForm2 parse: 'RETURN NEXT 1+1'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTReturnStatement;
		assert: node isReturnNext;
		deny: node hasUsingExpressions;
		deny: node isEmptyReturn;
		deny: node isReturnQuery;
		deny: node isReturnQueryExecute;
		deny: node isReturnExpression;
		assert: node expression class equals: PSQLASTBinaryOperator