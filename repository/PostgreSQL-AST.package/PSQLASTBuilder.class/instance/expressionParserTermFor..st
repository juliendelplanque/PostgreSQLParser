expression
expressionParserTermFor: expressionParser
	^ (super expressionParserTermFor: expressionParser) ==> [ :tokens |
		tokens second isNil
			ifTrue: [ tokens first ]
			ifFalse: [ 
				PSQLASTBinaryOperator new
					operator: '::';
					left: tokens first;
					right: (PSQLASTIdentifier new identifier: (tokens second second joinUsing: ' '); yourself) ] ]