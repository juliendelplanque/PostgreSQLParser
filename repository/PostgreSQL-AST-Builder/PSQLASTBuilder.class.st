"
I build an AST using PSQLASTNode subclasses from source code given as input.
"
Class {
	#name : #PSQLASTBuilder,
	#superclass : #PSQLGrammar,
	#category : #PostgreSQL-AST-Builder
}

{ #category : #accessing }
PSQLASTBuilder class >> deleteQueryParser [
	^ PSQLDeleteQueryASTBuilder
]

{ #category : #accessing }
PSQLASTBuilder class >> insertQueryParser [
	^ PSQLInsertQueryASTBuilder
]

{ #category : #accessing }
PSQLASTBuilder class >> selectQueryParser [
	^ PSQLSelectQueryASTBuilder
]

{ #category : #accessing }
PSQLASTBuilder class >> updateQueryParser [
	^ PSQLUpdateQueryASTBuilder
]

{ #category : #accessing }
PSQLASTBuilder class >> valuesCommandParser [
	^ PSQLValuesASTBuilder
]

{ #category : #expression }
PSQLASTBuilder >> aggregateExpressionParserForm1With: expressionParser [
	^ (super aggregateExpressionParserForm1With: expressionParser) ==> [ :tokens |
			PSQLASTAggregateFunctionCall new
				functionIdentifier: tokens first;
				expressions: (tokens third reject: [ :item | item = $, ]);
				orderByClause: tokens fourth;
				yourself ]
]

{ #category : #expression }
PSQLASTBuilder >> aggregateExpressionParserForm2With: expressionParser [
	^ (super aggregateExpressionParserForm2With: expressionParser) ==> [ :tokens |
			PSQLASTAggregateFunctionCall new
				functionIdentifier: tokens first;
				isAll: tokens third asUppercase = 'ALL';
				isDistinct: tokens third asUppercase = 'DISTINCT'; 
				expressions: (tokens fourth reject: [ :item | item = $, ]);
				orderByClause: tokens fifth;
				yourself ]
]

{ #category : #expression }
PSQLASTBuilder >> aggregateExpressionParserForm3With: expressionParser [
	^ (super aggregateExpressionParserForm3With: expressionParser) ==> [ :tokens |
			PSQLASTAggregateFunctionCall new
				functionIdentifier: tokens first;
				expressions: { tokens third };
				orderByClause: tokens fourth;
				yourself ]
]

{ #category : #expression }
PSQLASTBuilder >> asOperator [
	^ super asOperator ==> [ :tokens | tokens second ]
]

{ #category : #accessing }
PSQLASTBuilder >> asterik [
	^ super asterik ==> [ :tokens |
		PSQLASTWildCard new ]
]

{ #category : #'accessing - blocks' }
PSQLASTBuilder >> binaryOperatorBlock [
	^ [ :exp1 :op :exp2 |
			PSQLASTBinaryOperator new
				operator: op;
				left: exp1;
				right: exp2;
				yourself ]
]

{ #category : #accessing }
PSQLASTBuilder >> columnReference [
	^ super columnReference ==> [ :tokens |
		tokens first ifNotNil: [ 
			PSQLASTAttributeAccess new
				accessed: tokens first first;
				attributeIdentifier: tokens second;
				yourself ]
			ifNil: [ 
				tokens second ] ]
]

{ #category : #expression }
PSQLASTBuilder >> commaSubscriptWith: expressionParser [
	^ (super commaSubscriptWith: expressionParser) ==> [ :tokens |
		PSQLASTArrayConstructor new
			items: ((tokens copyFrom: 2 to: tokens size - 1) first reject: [ :object | object = $, ] thenCollect: #first);
			yourself ]
]

{ #category : #expression }
PSQLASTBuilder >> compositeValueWith: anExpressionParser [
	^ (super compositeValueWith: anExpressionParser)
		==> [ :tokens |
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
PSQLASTBuilder >> conditionalExpression [
	^ super conditionalExpression ==> [ :tokens |
		PSQLASTConditionalExpression new
			conditionsToExpressions: (tokens second collect: [ :item | item second -> item fourth ]);
			elseExpression: tokens third second;
			yourself ]
]

{ #category : #accessing }
PSQLASTBuilder >> escapeStringConstant [
	^ super escapeStringConstant ==> [ :tokens |
		PSQLASTStringConstant new
			content: (String newFrom: tokens flattened allButFirst allButLast);
			yourself ]
]

{ #category : #expression }
PSQLASTBuilder >> expressionParserTermFor: expressionParser [
	^ (super expressionParserTermFor: expressionParser) ==> [ :tokens |
		tokens second isNil
			ifTrue: [ tokens first ]
			ifFalse: [ 
				PSQLASTBinaryOperator new
					operator: '::';
					left: tokens first;
					right: (PSQLASTIdentifier new identifier: (tokens second second joinUsing: ' '); yourself) ] ]
]

{ #category : #expression }
PSQLASTBuilder >> functionCall [
	^ super functionCall ==> [ :tokens |
		PSQLASTFunctionCall new
			functionIdentifier: tokens first;
			argumentsList: (tokens third ifNotNil: [ :list | list reject: [ :item | item = $, ] ] ifNil: [ #() ]);
			argumentsDictionary: Dictionary new;
			yourself ]
]

{ #category : #expression }
PSQLASTBuilder >> functionCallParserWith: expressionParser [
	^ (super functionCallParserWith: expressionParser)
		==> [ :tokens |
			PSQLASTFunctionCall new
				functionIdentifier: tokens first;
				argumentsList: (tokens second second reject: [ :item | item = $, or: [ item isEmpty or: [ item first isArray ] ] ] thenCollect: #first);
				argumentsDictionary: (tokens second second reject: [ :item | item = $, or: [ item isEmpty or: [ item first isArray not ] ] ] thenCollect: [ :array | array first first -> array first third ]) asDictionary;
				yourself ]
]

{ #category : #accessing }
PSQLASTBuilder >> identifier [
	^ super identifier ==> [ :tokens | 
		PSQLASTIdentifier new
			identifier: tokens second;
			yourself ]
]

{ #category : #accessing }
PSQLASTBuilder >> identifierOrKeyword [
	^ super identifierOrKeyword ==> [ :tokens | String newFrom: tokens flattened ]
]

{ #category : #accessing }
PSQLASTBuilder >> identifierWithOptionalFieldAccess [
	^ super identifierWithOptionalFieldAccess ==> [ :tokens |
		tokens second
			ifNil: [ tokens first ]
			ifNotNil: [ 
				PSQLASTAttributeAccess new
					accessed: tokens first;
					attributeIdentifier: tokens second second;
					yourself ] ]
]

{ #category : #accessing }
PSQLASTBuilder >> isNotNull [
	^ super isNotNull ==> [ :tokens | tokens joinUsing: ' ' ]
]

{ #category : #accessing }
PSQLASTBuilder >> isNull [
	^ super isNull ==> [ :tokens | tokens joinUsing: ' ' ]
]

{ #category : #accessing }
PSQLASTBuilder >> numericConstant [
	^ super numericConstant ==> [ :tokens |
		PSQLASTNumericConstant new
			content: (String newFrom: (tokens flattened reject: #isNil));
			yourself ]
]

{ #category : #shared }
PSQLASTBuilder >> orderByClause [
	^ super orderByClause ==> [ :tokens |
		PSQLASTOrderByClause new
			items: (tokens third reject: [ :item | item = $, ] thenCollect: [ :array |
				|item|
				item := array first.
				PSQLASTOrderByClauseItem new
					expression: item first;
					isAsc: (item second ifNotNil: [ item second asUppercase = 'ASC' ]);
					isNullsFirst: (item third ifNotNil: [ item third second asUppercase = 'FIRST' ]);
					yourself ]);
			yourself ]
]

{ #category : #expression }
PSQLASTBuilder >> parenthesedExpressionParserWith: expressionParser [
	^ (super parenthesedExpressionParserWith: expressionParser)
			==> [ :tokens | 
				PSQLASTParenthesedExpression new
					expression: tokens second;
					yourself ]
]

{ #category : #accessing }
PSQLASTBuilder >> positionalParameter [
	^ super positionalParameter ==> [ :tokens | 
		PSQLPlpgSQLASTPositionalParameter new
			index: (String newFrom: tokens second) asNumber;
			yourself ]
]

{ #category : #'accessing - blocks' }
PSQLASTBuilder >> postfixOperatorBlock [
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
PSQLASTBuilder >> prefixOperatorBlock [
	^ [ :op :exp |
			PSQLASTPrefixOperator new
				operator: op;
				expression: exp;
				yourself ]
]

{ #category : #shared }
PSQLASTBuilder >> returningClause [
	^ super returningClause ==> [ :tokens |
		PSQLASTReturningClause new
			returnedList: (tokens second reject: [ :token | token = $, ]);
			yourself ]
]

{ #category : #shared }
PSQLASTBuilder >> setClause [
	^ super setClause ==> [ :tokens |
		PSQLASTSetClause new
			items: (tokens second reject: [ :item | item = $, ]);
			yourself ]
]

{ #category : #shared }
PSQLASTBuilder >> setItem1 [
	^ super setItem1 ==> [ :tokens |
		PSQLASTSetClauseItemType1 new
			left: tokens first;
			right: (tokens third isString
						ifFalse: [ tokens third ]
						ifTrue: [ PSQLASTDefaultValue new ]) ]
]

{ #category : #shared }
PSQLASTBuilder >> setItem2 [
	^ super setItem2 ==> [ :tokens |
		PSQLASTSetClauseItemType2 new
			left: (tokens second reject: [ :item | item = $, ] thenCollect: #first);
			right: (tokens sixth 
						reject: [ :item | item = $, ]
						thenCollect: [ :item | item first isString ifTrue: [ PSQLASTDefaultValue new ] ifFalse: [ item first ] ]);
			yourself ]
]

{ #category : #shared }
PSQLASTBuilder >> setItem3 [
	^ super setItem3 ==> [ :tokens |
		PSQLASTSetClauseItemType3 new
			left: (tokens second reject: [ :item | item = $, ] thenCollect: #first);
			right: tokens sixth;
			yourself ]
]

{ #category : #accessing }
PSQLASTBuilder >> simpleStringConstant [
	^ super simpleStringConstant ==> [ :tokens |
		PSQLASTStringConstant new
			content: (String newFrom: tokens flattened allButFirst allButLast);
			yourself ]
]

{ #category : #shared }
PSQLASTBuilder >> updateDeleteWhereClause [
	^ super updateDeleteWhereClause ==> [ :tokens |
		|node|
		node := PSQLASTUpdateDeleteWhereClause new.
		tokens second isArray
			ifTrue: [ node currentOfCursor: tokens second third ]
			ifFalse: [ node condition: tokens second ].
		node ]
]

{ #category : #shared }
PSQLASTBuilder >> withClause [
	^ super withClause ==> [ :tokens |
		PSQLASTWithClause new
			isRecursive: tokens second isNotNil;
			queries: (tokens third reject: [ :item | item = $, ]);
			yourself ]
]

{ #category : #shared }
PSQLASTBuilder >> withQuery [
	^ super withQuery ==> [ :tokens |
		(PSQLASTTableAlias new
			identifier: tokens first;
			columnAliases: (tokens second ifNotNil: [ :array | array second reject: [ :token | token = $, ] ]  ifNil: [ #() ]);
			yourself) -> tokens fifth ]
]
