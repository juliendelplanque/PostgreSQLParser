accessing
plpgsqlSearchedCase
	^ super plpgsqlSearchedCase ==> [ :tokens |
		PSQLPlpgSQLASTSearchedCase new
			searchedExpression: tokens second;
			conditionsToStatements: (tokens third collect: [ :subTokens |
				(subTokens second reject: [ :item | item = $, ]) -> subTokens fourth ]);
			elseStatements: (tokens fourth ifNotNil: #second);
			yourself ]