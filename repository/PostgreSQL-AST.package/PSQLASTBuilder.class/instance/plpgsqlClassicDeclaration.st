plpgsql
plpgsqlClassicDeclaration
	^ super plpgsqlClassicDeclaration ==> [ :tokens |
		PSQLPlpgSQLASTClassicDeclaration new
			identifier: tokens first;
			isConstant: tokens second isNotNil;
			type: tokens third;
			isNotNull: tokens fourth isNotNull;
			defaultExpression: (tokens fifth ifNotNil: #second);
			yourself ]