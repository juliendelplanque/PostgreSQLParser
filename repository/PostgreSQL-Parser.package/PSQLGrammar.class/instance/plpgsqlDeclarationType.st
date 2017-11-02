plpgsql
plpgsqlDeclarationType
	^ kw collate not , kw notKeyword not , kw default not , ':=' asParser not , '=' asParser not , identifierOrKeyword trim plus , 
	(openParenthesis trim , numericConstant trim , closeParenthesis trim) optional ,
	(openBracket trim , closeBracket trim) plus optional