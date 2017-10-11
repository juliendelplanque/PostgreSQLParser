tests-accessing
testPlpgsqlReturnForm1
	| node |
	node := builder plpgsqlReturnForm1 parse: 'RETURN 1+1'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTReturnStatement;
		assert: node isReturnExpression;
		deny: node hasUsingExpressions;
		deny: node isEmptyReturn;
		deny: node isReturnQuery;
		deny: node isReturnQueryExecute;
		deny: node isReturnNext;
		assert: node expression class equals: PSQLASTBinaryOperator