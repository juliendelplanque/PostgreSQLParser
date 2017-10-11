tests-accessing
testPlpgsqlReturnForm3
	| node |
	node := builder plpgsqlReturnForm3 parse: 'RETURN QUERY SELECT * FROM table'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTReturnStatement;
		assert: node isReturnQuery;
		deny: node hasUsingExpressions;
		deny: node isEmptyReturn;
		deny: node isReturnNext;
		deny: node isReturnQueryExecute;
		deny: node isReturnExpression;flag:#todo"
		assert: node query class equals: "