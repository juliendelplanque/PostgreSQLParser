tests-plpgsql
testPlpgsqlRowTypeDeclaration
	| node |
	node := builder plpgsqlRowTypeDeclaration parse: 'id table%ROWTYPE'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTRowTypeDeclaration;
		assert: node identifier identifier equals: 'id';
		assert: node tableIdentifier identifier equals: 'table'