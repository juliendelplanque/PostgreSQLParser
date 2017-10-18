tests-plpgsql
testPlpgsqlAliasDeclaration
	| node |
	node := builder plpgsqlAliasDeclaration parse: 'id ALIAS FOR $1'.
	self
		assert: node class equals: PSQLPlpgSQLASTAliasDeclaration;
		assert: node identifier identifier equals: 'id';
		assert: node aliased identifier equals: '$1'.
		
	node := builder plpgsqlAliasDeclaration parse: 'id ALIAS FOR identifier'.
	self
		assert: node class equals: PSQLPlpgSQLASTAliasDeclaration;
		assert: node identifier identifier equals: 'id';
		assert: node aliased identifier equals: 'identifier'