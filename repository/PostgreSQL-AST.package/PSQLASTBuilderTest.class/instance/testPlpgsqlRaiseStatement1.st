tests-accessing
testPlpgsqlRaiseStatement1
	| node |
	node := builder plpgsqlRaiseStatement1 parse: 'RAISE EXCEPTION ''Nonexistent ID --> %'', user_id
      USING HINT = ''Please check your user ID'''.
	
	self
		assert: node class equals: PSQLPlpgSQLASTRaiseStatement;
		assert: node level equals: 'EXCEPTION';
		assert: node formatString class equals: PSQLASTStringConstant;
		assert: node formatString content equals: 'Nonexistent ID --> %';
		assert: node formatExpressions size equals: 1;
		assert: node usingAssocs size equals: 1