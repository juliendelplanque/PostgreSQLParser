plpgsql
plpgsqlDeclarationType
	^ super plpgsqlDeclarationType ==> [ :tokens |
		PSQLPlpgSQLASTType new
					identifier: (PSQLASTIdentifier new
										identifier: (tokens sixth joinUsing: ' ');
										yourself);
					size: (tokens seventh ifNotNil: [ :array | array second content asNumber ]);
					dimensions: (tokens eighth ifNotNil: [ :array | array size ]);
					yourself ]