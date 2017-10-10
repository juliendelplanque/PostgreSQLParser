tests-accessing
testPlpgsqlQueryResultsLoop
	| node |
	node := builder plpgsqlQueryResultsLoop parse: 'FOR mviews IN SELECT * FROM cs_materialized_views ORDER BY sort_key LOOP
	var := mviews;
END LOOP'.
	self
		assert: node class equals: PSQLPlpgSQLASTQueryResultsLoop;
		assert: node beginLabel isNil;
		assert: node endLabel isNil;
		assert: node target class equals: PSQLASTIdentifier;
		assert: node statements size equals: 1;
		flag: #'TODO test the query'