"
I build an AST from a PostgreSQL expression using PSQLASTNode subclasses from source code given as input.
"
Class {
	#name : #PSQLExpressionASTBuilder,
	#superclass : #PSQLExpressionGrammar,
	#category : #'PostgreSQL-AST-Builder'
}

{ #category : #accessing }
PSQLExpressionASTBuilder class >> selectQueryParser [
	^ PSQLSelectQueryASTBuilder
]

{ #category : #accessing }
PSQLExpressionASTBuilder class >> sharedParser [
	^ PSQLSharedASTBuilder
]

{ #category : #accessing }
PSQLExpressionASTBuilder class >> tokenParser [
	^ PSQLTokenASTBuilder
]

{ #category : #expression }
PSQLExpressionASTBuilder >> aggregateExpressionParserForm1With: expressionParser [
	^ (super aggregateExpressionParserForm1With: expressionParser) psqlASTBuild: [ :tokens |
			PSQLASTAggregateFunctionCall new
				functionIdentifier: tokens first;
				expressions: (tokens third reject: [ :item | item = $, ]) flatten;
				orderByClause: tokens fourth;
				yourself ]
]

{ #category : #expression }
PSQLExpressionASTBuilder >> aggregateExpressionParserForm2With: expressionParser [
	^ (super aggregateExpressionParserForm2With: expressionParser) psqlASTBuild: [ :tokens |
			PSQLASTAggregateFunctionCall new
				functionIdentifier: tokens first;
				isAll: tokens third asUppercase = 'ALL';
				isDistinct: tokens third asUppercase = 'DISTINCT'; 
				expressions: (tokens fourth reject: [ :item | item = $, ]);
				orderByClause: tokens fifth;
				yourself ]
]

{ #category : #expression }
PSQLExpressionASTBuilder >> aggregateExpressionParserForm3With: expressionParser [
	^ (super aggregateExpressionParserForm3With: expressionParser) psqlASTBuild: [ :tokens |
			PSQLASTAggregateFunctionCall new
				functionIdentifier: tokens first;
				expressions: { tokens third };
				orderByClause: tokens fourth;
				yourself ]
]

{ #category : #expression }
PSQLExpressionASTBuilder >> asOperator [
	^ super asOperator psqlASTBuild: [ :tokens | tokens second ]
]

{ #category : #'accessing - blocks' }
PSQLExpressionASTBuilder >> binaryOperatorBlock [
	^ [ :exp1 :op :exp2 |
			PSQLASTBinaryOperator new
				operator: op;
				left: exp1;
				right: exp2;
				yourself ]
]

{ #category : #helpers }
PSQLExpressionASTBuilder >> columnReference [
	^ super columnReference psqlASTBuild: [ :tokens |
		tokens first ifNotNil: [ 
			PSQLASTAttributeAccess new
				accessed: tokens first first;
				attributeIdentifier: tokens second;
				yourself ]
			ifNil: [ 
				tokens second ] ]
]

{ #category : #expression }
PSQLExpressionASTBuilder >> commaSubscriptWith: expressionParser [
	^ (super commaSubscriptWith: expressionParser) psqlASTBuild: [ :tokens |
		PSQLASTArrayConstructor new
			items: ((tokens copyFrom: 2 to: tokens size - 1) first reject: [ :object | object = $, ] thenCollect: #first);
			yourself ]
]

{ #category : #expression }
PSQLExpressionASTBuilder >> compositeValueWith: anExpressionParser [
	^ (super compositeValueWith: anExpressionParser)
		psqlASTBuild: [ :tokens |
			|node|
			node := PSQLASTCompositeValue new
						items: (tokens second reject: [ :item | item = $, ] thenCollect: #first);
						yourself.
			tokens fourth ifNotNil: [ 
				node := PSQLASTBinaryOperator new
							operator: '::';
							left: node;
							right: (PSQLASTIdentifier new identifier: ((tokens fourth second reject: [ :item | item first = Character space ] thenCollect: [ :item | (item first reject: #isNil) first ]) joinUsing: ' '); yourself) ].
			node ]
]

{ #category : #expression }
PSQLExpressionASTBuilder >> conditionalExpression [
	self flag: #TODO. "REQUIRE refactor following when expression refactor"
	^ super conditionalExpression psqlASTBuild: [ :tokens |
		PSQLASTConditionalExpression new
			conditionsToExpressions: (tokens second collect: [ :item | item first -> item third ]);
			elseExpression: tokens third second;
			yourself ]
]

{ #category : #accessing }
PSQLExpressionASTBuilder >> expression [
	^ super expression psqlASTBuild: #yourself
]

{ #category : #expression }
PSQLExpressionASTBuilder >> expressionParserTermFor: expressionParser [
	^ (super expressionParserTermFor: expressionParser) psqlASTBuild: [ :tokens |
		tokens second isNil
			ifTrue: [ tokens first ]
			ifFalse: [ 
				PSQLASTBinaryOperator new
					operator: '::';
					left: tokens first;
					right: (PSQLASTIdentifier new identifier: (tokens second second joinUsing: ' '); yourself) ] ]
]

{ #category : #expression }
PSQLExpressionASTBuilder >> functionCall [
	^ super functionCall psqlASTBuild: [ :tokens |
		PSQLASTFunctionCall new
			functionIdentifier: tokens first;
			argumentsList: (tokens third ifNotNil: [ :list | list reject: [ :item | item = $, ] ] ifNil: [ #() ]);
			argumentsDictionary: Dictionary new;
			yourself ]
]

{ #category : #expression }
PSQLExpressionASTBuilder >> functionCallParserWith: expressionParser [
	^ (super functionCallParserWith: expressionParser)
		psqlASTBuild: [ :tokens |
			PSQLASTFunctionCall new
				functionIdentifier: tokens first;
				argumentsList: (tokens second second reject: [ :item | item = $, or: [ item isEmpty or: [ item first isArray ] ] ] thenCollect: #first);
				argumentsDictionary: (tokens second second reject: [ :item | item = $, or: [ item isEmpty or: [ item first isArray not ] ] ] thenCollect: [ :array | array first first -> array first third ]) asDictionary;
				yourself ]
]

{ #category : #expression }
PSQLExpressionASTBuilder >> isNotNull [
	^ super isNotNull psqlASTBuild: [ :tokens | tokens joinUsing: ' ' ]
]

{ #category : #expression }
PSQLExpressionASTBuilder >> isNull [
	^ super isNull psqlASTBuild: [ :tokens | tokens joinUsing: ' ' ]
]

{ #category : #expression }
PSQLExpressionASTBuilder >> nullExpression [
	^ super nullExpression psqlASTBuild: [ :tokens | PSQLASTNull new ]
]

{ #category : #expression }
PSQLExpressionASTBuilder >> parenthesedExpressionParserWith: expressionParser [
	^ (super parenthesedExpressionParserWith: expressionParser)
			psqlASTBuild: [ :tokens | 
				PSQLASTParenthesedExpression new
					expression: tokens second;
					yourself ]
]

{ #category : #'accessing - blocks' }
PSQLExpressionASTBuilder >> postfixOperatorBlock [
	^ [ :exp :op |
			(op isArray and: [ op size = 4 and: [ op first = $[ and: [ op last = $] ] ] ])
				ifFalse: [ 
					PSQLASTPostfixOperator new
						operator: op;
						expression: exp;
						yourself ]
				ifTrue: [ 
					PSQLASTSubscript new
						target: exp;
						subscriptExpression: op second;
						yourself ] ]
]

{ #category : #'accessing - blocks' }
PSQLExpressionASTBuilder >> prefixOperatorBlock [
	^ [ :op :exp |
			PSQLASTPrefixOperator new
				operator: op;
				expression: exp;
				yourself ]
]

{ #category : #expression }
PSQLExpressionASTBuilder >> whenExpression [
	^ super whenExpression
		psqlASTBuild: [ :tokens | 
			PSQLASTWhenExpression new
				expression: tokens second;
				yourself ]
]
