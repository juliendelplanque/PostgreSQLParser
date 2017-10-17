accessing - blocks
postfixOperatorBlock
	^ [ :exp :op |
			(op isArray and: [ op size = 4 and: [ op first = $[ and: [ op last = $] ] ] ])
				ifFalse: [ 
					PSQLASTPostfixOperator new
						operator: op;
						expression: exp;
						yourself ]
				ifTrue: [ 
					PSQLSubscript new
						target: exp;
						subscriptExpression: op second;
						yourself ] ]