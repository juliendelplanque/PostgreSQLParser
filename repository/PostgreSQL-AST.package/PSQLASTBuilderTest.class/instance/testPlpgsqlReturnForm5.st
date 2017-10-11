tests-accessing
testPlpgsqlReturnForm5
	| node |
	node := builder plpgsqlReturnForm5 parse: 'RETURN'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTReturnStatement;
		assert: node isEmptyReturn;
		deny: node hasUsingExpressions;
		deny: node isReturnExpression;
		deny: node isReturnQuery;
		deny: node isReturnQueryExecute;
		deny: node isReturnNext