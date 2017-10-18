tests-accessing
testPlpgsqlIndexParameter
	| node |
	node := builder plpgsqlIndexParameter parse: '$1'.
	
	self
		assert: node class equals: PSQLASTIdentifier;
		assert: node identifier equals: '$1'