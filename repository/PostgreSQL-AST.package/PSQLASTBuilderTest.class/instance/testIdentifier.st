tests-accessing
testIdentifier
	| node |
	node := builder identifier parse: 'id'.
	
	self
		assert: node class equals: PSQLASTIdentifier;
		assert: node identifier equals: 'id'