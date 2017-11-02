tests-plpgsql
testPlpgsqlDeclarationType
	| node |
	node := builder plpgsqlDeclarationType parse: 'varying char(16)[][]'.
	self
		assert: node class equals: PSQLPlpgSQLASTType;
		assert: node identifier identifier equals: 'varying char';
		assert: node size equals: 16;
		assert: node dimensions equals: 2