tests-plpgsql
testPlpgsqlCopyTypeDeclaration
	| node |
	node := builder plpgsqlCopyTypeDeclaration parse: 'user_id users.user_id%TYPE'.
	self
		assert: node class equals: PSQLPlpgSQLASTCopyTypeDeclaration;
		assert: node accessToCopyType attributeIdentifier identifier equals: 'users';
		assert: node accessToCopyType accessed identifier equals: 'user_id'