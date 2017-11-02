tests-plpgsql
testPlpgsqlRecordDeclaration
	| node |
	node := builder plpgsqlRecordDeclaration parse: 'identifier RECORD'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTRecordDeclaration;
		assert: node identifier identifier equals: 'identifier'