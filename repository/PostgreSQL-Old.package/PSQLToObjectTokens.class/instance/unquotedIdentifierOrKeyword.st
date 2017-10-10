accessing
unquotedIdentifierOrKeyword
	^ super unquotedIdentifierOrKeyword ==> [ :items | (String newFrom: items flattened) asLowercase ]