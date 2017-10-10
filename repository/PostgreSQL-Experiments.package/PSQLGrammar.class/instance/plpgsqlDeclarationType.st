plpgsql
plpgsqlDeclarationType
	^ collate not , notKeyword not , default not , ':=' asParser not , '=' asParser not , identifierOrKeyword trim plus , (
	(openParenthesis trim , numericConstant trim , closeParenthesis trim) /
	(openBracket trim , closeBracket trim) plus) optional