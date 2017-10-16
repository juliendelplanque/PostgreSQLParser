expression
compositeValueWith: anExpressionParser
	^ (super compositeValueWith: anExpressionParser)
		==> [ :tokens |
			|node|
			node := PSQLCompositeValue new
						items: (tokens second reject: [ :item | item = $, ] thenCollect: #first);
						yourself.
			tokens fourth ifNotNil: [ 
				node := PSQLASTBinaryOperator new
							operator: '::';
							left: node;
							right: (PSQLASTIdentifier new identifier: ((tokens fourth second reject: [ :item | item first = Character space ] thenCollect: [ :item | (item first reject: #isNil) first ]) joinUsing: ' '); yourself) ].
			node ]