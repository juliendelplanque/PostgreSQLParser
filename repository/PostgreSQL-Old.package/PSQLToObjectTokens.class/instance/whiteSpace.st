accessing
whiteSpace
	^ super whiteSpace ==> [ :char | PSQLWhiteSpace new contents: char asString ]