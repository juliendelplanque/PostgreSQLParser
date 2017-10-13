tests-accessing
testPlpgsqlRaiseUsingOptions
	| assocs |
	assocs := builder plpgsqlRaiseUsingOptions parse: 'USING opt = 1 + 1, opt2 = ''test'''.
	
	self
		assert: assocs size equals: 2;
		assert: assocs first head class equals: PSQLASTIdentifier;
		assert: assocs first tail class equals: PSQLASTBinaryOperator;
		assert: assocs second head class equals: PSQLASTIdentifier;
		assert: assocs second tail class equals: PSQLASTStringConstant