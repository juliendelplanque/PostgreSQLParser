tests-accessing
testPlpgsqlAssignmentLeftPart
	| node |
	node := builder plpgsqlAssignmentLeftPart parse: 'truc.machin[id][3]'.
	self
		assert: node class equals: PSQLSubscript;
		assert: node target class equals: PSQLSubscript;
		assert: node target target class equals: PSQLASTAttributeAccess;
		assert: node target target accessed class equals: PSQLASTIdentifier