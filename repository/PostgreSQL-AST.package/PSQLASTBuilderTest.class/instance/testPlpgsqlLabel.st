tests-accessing
testPlpgsqlLabel
	| node |
	node := builder plpgsqlLabel parse: 'label'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTBlockLabel;
		assert: node labelContent equals: 'label'