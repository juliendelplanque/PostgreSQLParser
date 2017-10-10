tests-accessing
testPositionalParameter
	| node |
	node := builder positionalParameter parse: '$1'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTPositionalParameter;
		assert: node index equals: 1