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

{ #category : #'select command' }
PSQLASTBuilder >> allOrDistinctClause [
	^ super allOrDistinctClause ==> [ :tokens |
		tokens isString
			ifTrue: [ PSQLASTAllClause new ]
			ifFalse: [ |node|
				node := PSQLASTDistinctClause new.
				tokens second ifNotNil: [ 
					node
						expressions: (tokens second third reject: [ :item | item = $, ] thenCollect: #first) ].
				node ] ]
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

{ #category : #shared }
PSQLASTBuilder >> columnDefinition [
	^ super columnDefinition ==> [ :tokens |
		PSQLASTColumnDefinition new
			columnName: tokens first;
			type: (PSQLASTIdentifier new
						identifier: ((tokens second flattened collect: [ :item | 
							item isCharacter
								ifTrue: [ ' ' ]
								ifFalse: [ item identifier ] ]) joinUsing: '');
						yourself);
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

{ #category : #'select command' }
PSQLASTBuilder >> columnsAndAliasesSelected [
	^ super columnsAndAliasesSelected ==> [ :tokens |
		tokens reject: [ :item | item = $, ] thenCollect: [ :item |
			item first isArray
				ifTrue: [
					item first first
						ifNotNil: [ 
							PSQLASTAttributeAccess new 
								accessed: item first first first;
								attributeIdentifier: item first second;
								yourself ]
						ifNil: [ item first second ] ]
				ifFalse: [ 
					item first ] ] ]
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

{ #category : #'select command' }
PSQLASTBuilder >> fetchClause [
	^ super fetchClause ==> [ :tokens |
		PSQLASTFetchClause new
			isFirst: tokens second asUppercase = 'FIRST';
			count: tokens third;
			yourself ]
]

{ #category : #'select command' }
PSQLASTBuilder >> forClause [
	^ super forClause ==> [ :tokens |
		PSQLASTForClause new
			isUpdate: tokens second asUppercase = 'UPDATE';
			ofTables: (tokens third ifNotNil: [ :array |
				array second reject: [ :item | item = $, ] thenCollect: #first ]);
			isNoWait: tokens fourth isNotNil;
			yourself ]
]

{ #category : #shared }
PSQLASTBuilder >> fromClause [
	^ super fromClause ==> [ :tokens |
		PSQLASTFromClause new
			items: (tokens second reject: [ :item | item = $, ] thenCollect: #first);
			yourself ]
]

{ #category : #shared }
PSQLASTBuilder >> fromItems [
	^ super fromItems ==> [ :tokens |
		tokens second
			ifEmpty: [ tokens first ]
			ifNotEmpty: [ 
				tokens second
					inject: tokens first
					into: [ :fromItem :current |
						current
							leftFromItem: fromItem;
							yourself ] ] ]
]

{ #category : #shared }
PSQLASTBuilder >> fromItems1 [
	^ super fromItems1 ==> [ :tokens |
		PSQLASTFromClauseItemType1 new
			hasOnly: tokens first isNotNil;
			tableName: tokens second;
			areDescendantTablesIncluded: tokens third isNotNil;
			alias: (tokens fourth ifNotNil: #second);
			columnAliases: (tokens fourth ifNotNil: [ :subTokens |
				subTokens third ifNotNil: [ :subsubTokens | subsubTokens second reject: [ :item | item = $, ] ] ifNil: [ #() ] ])
			yourself ]
]

{ #category : #shared }
PSQLASTBuilder >> fromItems2 [
	^ super fromItems2 ==> [ :tokens |
		PSQLASTFromClauseItemType2 new
			hasLateral: tokens first isNotNil;
			valuesOrSelect: tokens third;
			alias: tokens sixth;
			columnAliases: (tokens seventh ifNotNil: [ :subTokens |
				subTokens second reject: [ :item | item = $, ] ]);
			yourself ]
]

{ #category : #shared }
PSQLASTBuilder >> fromItems3 [
	^ super fromItems3 ==> [ :tokens |
		PSQLASTFromClauseItemType3 new
			withQueryName: tokens first;
			alias: (tokens second ifNotNil: #second);
			columnAliases: (tokens second ifNotNil: [ :subTokens |
				(subTokens third ifNotNil: #second) reject: [ :item | item = $, ] ]);
			yourself ]
]

{ #category : #shared }
PSQLASTBuilder >> fromItems4 [
	^ super fromItems4 ==> [ :tokens |
		PSQLASTFromClauseItemType4 new
			hasLateral: tokens first isNotNil;
			functionCall: tokens second;
			alias: tokens fourth;
			columnDefinitions: (tokens sixth ifNotNil: [ :subTokens |
				subTokens reject: [ :item | item = $, ] thenCollect: #first ]);
			yourself ]
]

{ #category : #shared }
PSQLASTBuilder >> fromItems5 [
	^ super fromItems5 ==> [ :tokens |
		PSQLASTFromClauseItemType5 new
			hasLateral: tokens first isNotNil;
			functionCall: tokens second;
			columnDefinitions: (tokens fifth ifNotNil: [ :subTokens |
				subTokens reject: [ :item | item = $, ] thenCollect: #first ]);
			yourself ]
]

{ #category : #shared }
PSQLASTBuilder >> fromItems6 [
	^ super fromItems6 ==> [ :tokens |
		|node|
		node := PSQLASTFromClauseItemType6 new
			hasNatural: tokens first isNotNil;
			joinType: tokens second;
			rightFromItem: tokens third;
			yourself.
		tokens fourth ifNotNil: [ :subTokens |
			subTokens first asLowercase = 'on'
				ifTrue: [ node joinCondition: subTokens second ]
				ifFalse: [ node usingList: (subTokens third reject: [ :item | item = $, ]) ] ].
		node ]
]

{ #category : #shared }
PSQLASTBuilder >> fromItems7 [
	^ super fromItems7 ==> [ :tokens |
		PSQLASTFromClauseItemType7 new
			hasLateral: tokens first isNotNil;
			functionCall: tokens second;
			hasWithOrdinality: tokens third isNotNil;
			alias: (tokens fourth ifNotNil: #second);
			columnAliases: (tokens fourth ifNotNil: [ :subTokens |
				(subTokens third ifNotNil: #second)
					reject: [ :item | item = $, ] thenCollect: #first ]);
			yourself ]
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

{ #category : #'select command' }
PSQLASTBuilder >> groupByClause [
	^ super groupByClause ==> [ :tokens |
		PSQLASTGroupByClause new
			expressions: (tokens third reject: [ :item | item = $, ] thenCollect: #first);
			yourself ]
]

{ #category : #'select command' }
PSQLASTBuilder >> havingClause [
	^ super havingClause ==> [ :tokens |
		PSQLASTHavingClause new
			expressions: (tokens second reject: [ :item | item = $, ] thenCollect: #first);
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

{ #category : #'select command' }
PSQLASTBuilder >> intoClause [
	^ super intoClause ==> [ :tokens |
		PSQLASTIntoClause new
			type: (tokens second ifNotNil: #asUppercase);
			hasTable: tokens third isNotNil;
			newTable: tokens fourth;
			yourself ]
]

{ #category : #accessing }
PSQLASTBuilder >> isNotNull [
	^ super isNotNull ==> [ :tokens | tokens joinUsing: ' ' ]
]

{ #category : #accessing }
PSQLASTBuilder >> isNull [
	^ super isNull ==> [ :tokens | tokens joinUsing: ' ' ]
]

{ #category : #shared }
PSQLASTBuilder >> joinType [
	^ super joinType ==> [ :tokens |
		(tokens flattened reject: #isNil) joinUsing: ' ' ]
]

{ #category : #'select command' }
PSQLASTBuilder >> limitClause [
	^ super limitClause ==> [ :tokens |
		PSQLASTLimitClause new
			limit: (tokens second isString ifTrue: [ PSQLASTAllClause new ] ifFalse: [ tokens second ]);
			yourself ]
]

{ #category : #accessing }
PSQLASTBuilder >> numericConstant [
	^ super numericConstant ==> [ :tokens |
		PSQLASTNumericConstant new
			content: (String newFrom: (tokens flattened reject: #isNil));
			yourself ]
]

{ #category : #'select command' }
PSQLASTBuilder >> offsetClause [
	^ super offsetClause ==> [ :tokens |
		PSQLASTOffsetClause new
			offset: tokens second;
			yourself ]
]

{ #category : #'select command' }
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

{ #category : #shared }
PSQLASTBuilder >> parenthesedFromItems [
	^ super parenthesedFromItems ==> [ :tokens |
		tokens second "Just remove parentheses" ]
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

{ #category : #'select command' }
PSQLASTBuilder >> selectCommand [
	^ super selectCommand ==> [ :tokens |
		PSQLASTSelectQuery new
			withClause: tokens first;
			allOrDistinctClause: tokens third;
			columnsAndAliasesSelected: tokens fourth;
			fromClause: tokens fifth;
			whereClause: tokens sixth;
			groupByClause: tokens seventh;
			havingClause: tokens eighth;
			windowClause: tokens ninth;
			unionIntersectExceptClause: (tokens at: 10);
			orderByClause: (tokens at: 11);
			limitClause: (tokens at: 12);
			offsetClause: (tokens at: 13);
			fetchClause: (tokens at: 14);
			forClause: (tokens at: 15);
			yourself ]
]

{ #category : #'select command' }
PSQLASTBuilder >> selectIntoCommandAlternative [
	^ super selectIntoCommandAlternative ==> [ :tokens |
		PSQLASTAlternativeSelectIntoQuery new
			withClause: tokens first;
			intoClause: (PSQLASTIntoClause new
								newTable: tokens fourth;
								hasTable: false;
								yourself);
			columnsAndAliasesSelected: tokens fifth;
			fromClause: tokens sixth;
			whereClause: tokens seventh;
			groupByClause: tokens eighth;
			havingClause: tokens ninth;
			windowClause: (tokens at: 10);
			unionIntersectExceptClause: (tokens at: 11);
			orderByClause: (tokens at: 12);
			limitClause: (tokens at: 13);
			offsetClause: (tokens at: 14);
			fetchClause: (tokens at: 15);
			forClause: (tokens at: 16);
			yourself ]
]

{ #category : #'select command' }
PSQLASTBuilder >> selectIntoCommandClassic [
	^ super selectIntoCommandClassic ==> [ :tokens |
		PSQLASTSelectIntoQuery new
			withClause: tokens first;
			allOrDistinctClause: tokens third;
			columnsAndAliasesSelected: tokens fourth;
			intoClause: tokens fifth;
			fromClause: tokens sixth;
			whereClause: tokens seventh;
			groupByClause: tokens eighth;
			havingClause: tokens ninth;
			windowClause: (tokens at: 10);
			unionIntersectExceptClause: (tokens at: 11);
			orderByClause: (tokens at: 12);
			limitClause: (tokens at: 13);
			offsetClause: (tokens at: 14);
			fetchClause: (tokens at: 15);
			forClause: (tokens at: 16);
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

{ #category : #'select command' }
PSQLASTBuilder >> unionIntersectExceptClause [
	^ super unionIntersectExceptClause ==> [ :tokens |
		({
			'UNION' -> PSQLASTUnionClause.
			'INTERSECT' -> PSQLASTIntersectClause.
			'EXCEPT' -> PSQLASTExceptClause
		} asDictionary at: tokens first asUppercase) new
			isDistinct: (tokens second isNil or: [ tokens second asUppercase = 'DISTINCT' ]);
			selectQuery: tokens third;
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

{ #category : #'select command' }
PSQLASTBuilder >> whereClause [
	^ super whereClause ==> [ :tokens |
		PSQLASTSelectWhereClause new
			condition: tokens second;
			yourself ]
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
