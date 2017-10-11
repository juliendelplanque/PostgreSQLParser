tests-accessing
testPlpgsqlReturnForm4Bis
	| node |
	node := builder plpgsqlReturnForm4 parse: 'RETURN QUERY EXECUTE ''SELECT flightid
                   FROM flight
                  WHERE % >=  %'' USING id, 2'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTReturnStatement;
		assert: node isReturnQueryExecute;
		assert: node queryExecute class equals: PSQLASTStringConstant;
		assert: node queryExecute content equals: 'SELECT flightid
                   FROM flight
                  WHERE % >=  %';
		assert: node hasUsingExpressions;
		assert: node usingExpressions size equals: 2;
		deny: node isEmptyReturn;
		deny: node isReturnNext;
		deny: node isReturnQuery;
		deny: node isReturnExpression