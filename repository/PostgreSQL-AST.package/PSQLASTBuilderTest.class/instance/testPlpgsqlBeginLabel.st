tests-accessing
testPlpgsqlBeginLabel
	| node |
	node := builder plpgsqlBeginLabel parse: '<<label>>'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTBlockLabel;
		assert: node labelContent equals: 'label'