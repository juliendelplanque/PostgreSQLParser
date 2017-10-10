parsing
parse: aString
	| objectTokens commentsAndStatements |
	objectTokens := PSQLToObjectTokens parse: aString.
	commentsAndStatements := OrderedCollection new.
	((objectTokens reject: #isWhiteSpace) splitOn: [ :token | token isSemicolon ]) do: [ :splitted |
		|firstNonComment|
		firstNonComment := splitted findFirst: [ :token | token isComment not ].
		(firstNonComment = 0)
			ifTrue: [ commentsAndStatements addAll: splitted ]
			ifFalse: [ 
				commentsAndStatements
					addAll: (splitted copyFrom: 1 to: firstNonComment - 1);
					add: (PSQLStatement tokens: (splitted copyFrom: firstNonComment to: splitted size)) ] ].
	^ PSQLDBSchema commentsAndStatements: commentsAndStatements