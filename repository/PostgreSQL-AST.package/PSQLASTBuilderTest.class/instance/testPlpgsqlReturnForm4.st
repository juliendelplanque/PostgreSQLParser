tests-accessing
testPlpgsqlReturnForm4
	| node |
	node := builder plpgsqlReturnForm4 parse: 'RETURN QUERY EXECUTE ''SELECT flightid
                   FROM flight
                  WHERE flightdate >= $1
                    AND flightdate < ($1 + 1)'''.
	
	self
		assert: node class equals: PSQLPlpgSQLASTReturnStatement;
		assert: node isReturnQueryExecute;
		assert: node queryExecute class equals: PSQLASTStringConstant;
		assert: node queryExecute content equals: 'SELECT flightid
                   FROM flight
                  WHERE flightdate >= $1
                    AND flightdate < ($1 + 1)';
		deny: node hasUsingExpressions;
		deny: node isEmptyReturn;
		deny: node isReturnNext;
		deny: node isReturnQuery;
		deny: node isReturnExpression