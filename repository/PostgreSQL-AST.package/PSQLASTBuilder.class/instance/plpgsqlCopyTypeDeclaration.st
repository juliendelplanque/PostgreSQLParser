plpgsql
plpgsqlCopyTypeDeclaration
	^ super plpgsqlCopyTypeDeclaration ==> [ :tokens |
		PSQLPlpgSQLASTCopyTypeDeclaration new
			identifier: tokens first;
			accessToCopyType: (PSQLASTAttributeAccess new
											attributeIdentifier: tokens second;
											accessed: tokens fourth;
											yourself);
			yourself ]