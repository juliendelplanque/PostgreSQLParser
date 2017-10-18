plpgsql
plpgsqlRaiseStatement1
	^ super plpgsqlRaiseStatement1 ==> [ :tokens |
		PSQLPlpgSQLASTRaiseStatement new
			level: tokens second;
			formatString: tokens third;
			formatExpressions: (tokens fourth reject: [ :item | item = $, or: [ item isArray and: [ item isEmpty ] ] ]);
			usingAssocs: tokens fifth;
			yourself ]