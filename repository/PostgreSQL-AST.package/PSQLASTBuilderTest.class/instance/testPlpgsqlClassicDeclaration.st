tests-plpgsql
testPlpgsqlClassicDeclaration
	| node |
	node := builder plpgsqlClassicDeclaration parse: 'id integer'.
	self
		assert: node class equals: PSQLPlpgSQLASTClassicDeclaration;
		assert: node identifier identifier equals: 'id';
		assert: node type identifier identifier equals: 'integer'