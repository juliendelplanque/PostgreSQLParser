Class {
	#name : #PSQLASTBuilder,
	#superclass : #PSQLGrammar,
	#category : 'PostgreSQL-AST-Builder'
}

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

{ #category : #'insert command' }
PSQLASTBuilder >> conflictAction [
	^ super conflictAction ==> [ :tokens |
		tokens size = 2
			ifTrue: [ PSQLASTConflictAction new "DO NOTHING" ]
			ifFalse: [ 
				PSQLASTConflictAction new
					setClause: tokens third;
					condition: (tokens fourth ifNotNil: #second);
					yourself ] ]
]

{ #category : #'insert command' }
PSQLASTBuilder >> defaultValues [
	^ super defaultValues ==> [ :tokens |
		PSQLASTDefaultValues new ]
]

{ #category : #'delete command' }
PSQLASTBuilder >> deleteCommand [
	^ super deleteCommand ==> [ :tokens |
		PSQLASTDeleteQuery new
			withClause: tokens first;
			isOnlySpecified: tokens fourth isNotNil;
			tableName: tokens fifth;
			areDescendantTablesIncluded: tokens sixth isNotNil;
			alias: (tokens seventh ifNotNil: #second);
			usingList: tokens eighth;
			whereClause: tokens ninth;
			returningClause: tokens last;
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

{ #category : #'insert command' }
PSQLASTBuilder >> insertCommand [
	^ super insertCommand ==> [ :tokens |
		PSQLASTInsertQuery new
			withClause: tokens first;
			tableName: tokens fourth;
			alias: (tokens fifth ifNotNil: #second);
			columns: (tokens sixth ifNotNil: [ :subTokens | subTokens second reject: [ :item | item = $, ] ]);
			valuesClause: tokens seventh;
			onConflictClause: tokens eighth;
			returningClause: tokens ninth;
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

{ #category : #'insert command' }
PSQLASTBuilder >> onConflictClause [
	^ super onConflictClause ==> [ :tokens |
		PSQLASTOnConflictClause new
			target: tokens third;
			action: tokens fourth;
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

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlAliasDeclaration [
	^ super plpgsqlAliasDeclaration ==> [ :tokens |
		PSQLPlpgSQLASTAliasDeclaration new
			identifier: tokens first;
			aliased: tokens fourth;
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlArrayLoop [
	^ super plpgsqlArrayLoop ==> [ :tokens |
		PSQLPlpgSQLASTArrayLoop new
			beginLabel: tokens first;
			endLabel: tokens last;
			target: tokens third;
			sliceNumber: (tokens fourth ifNotNil: [ :arr | arr second ]);
			arrayExpression: tokens seventh;
			statements: tokens ninth;
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlAssignmentLeftPart [
	^ super plpgsqlAssignmentLeftPart ==> [ :tokens |
			|target|
			target := tokens first.
			tokens second do: [ :subTokens | "First manage attribute access."
				target := PSQLASTAttributeAccess new
								accessed: target;
								attributeIdentifier: subTokens second;
								yourself ].
			tokens third do: [ :subscriptTokens | "Then manage subscripts."
				target := PSQLASTSubscript new
								target: target;
								subscriptExpression: subscriptTokens second;
								yourself ].
			target ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlAssignmentStatement [
	^ super plpgsqlAssignmentStatement ==> [ :tokens |
		PSQLPlpgSQLASTAssignment new
			target: tokens first;
			operator: tokens second;
			toAssign: tokens third;
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlBeginLabel [
	^ super plpgsqlBeginLabel ==> [ :tokens | tokens second ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlBlock [
	^ super plpgsqlBlock ==> [ :tokens |
		PSQLPlpgSQLASTBlock new
			label: tokens first;
			declarations: (tokens second ifNotNil: #second);
			statements: tokens fourth;
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlClassicDeclaration [
	^ super plpgsqlClassicDeclaration ==> [ :tokens |
		PSQLPlpgSQLASTClassicDeclaration new
			identifier: tokens first;
			isConstant: tokens second isNotNil;
			type: tokens third;
			isNotNull: tokens fourth isNotNil;
			defaultExpression: (tokens fifth ifNotNil: #second);
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlContinueStatement [
	^ super plpgsqlContinueStatement ==> [ :tokens |
		PSQLPlpgSQLASTContinue new
			label: tokens second;
			whenExpression: tokens third second;
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlCopyTypeDeclaration [
	^ super plpgsqlCopyTypeDeclaration ==> [ :tokens |
		PSQLPlpgSQLASTCopyTypeDeclaration new
			identifier: tokens first;
			accessToCopyType: (PSQLASTAttributeAccess new
											attributeIdentifier: tokens second;
											accessed: tokens fourth;
											yourself);
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlDeclarationType [
	^ super plpgsqlDeclarationType ==> [ :tokens |
		PSQLPlpgSQLASTType new
					identifier: (PSQLASTIdentifier new
										identifier: (tokens sixth joinUsing: ' ');
										yourself);
					size: (tokens seventh ifNotNil: [ :array | array second content asNumber ]);
					dimensions: (tokens eighth ifNotNil: [ :array | array size ]);
					yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlForLoop [
	^ super plpgsqlForLoop ==> [ :tokens |
		PSQLPlpgSQLASTForLoop new
			beginLabel: tokens first;
			endLabel: tokens last;
			statements: (tokens at: 11);
			target: tokens third;
			fromExpression: tokens sixth;
			toExpression: tokens eighth;
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlIfThen [
	^ super plpgsqlIfThen ==> [ :tokens |
		PSQLPlpgSQLASTIf new
			conditionToStatements: { tokens second -> tokens fourth };
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlIfThenElse [
	^ super plpgsqlIfThenElse ==> [ :tokens |
		PSQLPlpgSQLASTIf new
			conditionToStatements: { tokens second -> tokens fourth };
			elseStatements: tokens sixth;
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlIfThenElsif [
	^ super plpgsqlIfThenElsif ==> [ :tokens |
		PSQLPlpgSQLASTIf new
			conditionToStatements: { tokens second -> tokens fourth } , (tokens fifth collect: [ :subTokens | subTokens second -> subTokens fourth ]);
			elseStatements: (tokens sixth ifNotNil: #second);
			yourself ]
]

{ #category : #accessing }
PSQLASTBuilder >> plpgsqlIndexParameter [
	^ super plpgsqlIndexParameter ==> [ :tokens | 
		PSQLASTIdentifier new
			identifier: '$',(String newFrom: tokens second);
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlLabel [
	^ super plpgsqlLabel ==> [ :tokens |
		PSQLPlpgSQLASTBlockLabel labelContent: tokens identifier ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlLoopLoop [
	^ super plpgsqlLoopLoop ==> [ :tokens |
		PSQLPlpgSQLASTLoop new
			beginLabel: tokens first;
			endLabel: tokens last;
			statements: tokens third;
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlQueryResultsLoop [
	^ super plpgsqlQueryResultsLoop ==> [ :tokens |
		PSQLPlpgSQLASTQueryResultsLoop new
			beginLabel: tokens first;
			endLabel: tokens last;
			statements: tokens seventh;
			target: tokens third;
			query: tokens fifth;
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlRaiseStatement1 [
	^ super plpgsqlRaiseStatement1 ==> [ :tokens |
		PSQLPlpgSQLASTRaiseStatement new
			level: tokens second;
			formatString: tokens third;
			formatExpressions: (tokens fourth reject: [ :item | item = $, or: [ item isArray and: [ item isEmpty ] ] ]);
			usingAssocs: tokens fifth;
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlRaiseStatement2 [
	^ super plpgsqlRaiseStatement2 ==> [ :tokens |
		 ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlRaiseStatement3 [
	^ super plpgsqlRaiseStatement3 ==> [ :tokens |
		 ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlRaiseStatement4 [
	^ super plpgsqlRaiseStatement4 ==> [ :tokens |
		 ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlRaiseStatement5 [
	^ super plpgsqlRaiseStatement5 ==> [ :tokens |
		PSQLPlpgSQLASTRaiseStatement new ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlRaiseUsingOptions [
	^ super plpgsqlRaiseUsingOptions ==> [ :tokens |
		tokens second reject: [ :item  | item = $, ] thenCollect: [ :arr |
			arr first first -> arr first third ] ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlRecordDeclaration [
	^ super plpgsqlRecordDeclaration ==> [ :tokens |
		PSQLPlpgSQLASTRecordDeclaration new
			identifier: tokens first;
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlReturnForm1 [
	^ super plpgsqlReturnForm1 ==> [ :tokens |
		PSQLPlpgSQLASTReturnStatement new
			expression: tokens second;
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlReturnForm2 [
	^ super plpgsqlReturnForm2 ==> [ :tokens |
		PSQLPlpgSQLASTReturnStatement new
			expression: tokens third;
			isReturnNext: true;
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlReturnForm3 [
	^ super plpgsqlReturnForm3 ==> [ :tokens |
		PSQLPlpgSQLASTReturnStatement new
			query: tokens third;
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlReturnForm4 [
	^ super plpgsqlReturnForm4 ==> [ :tokens |
		|stmt|
		stmt := PSQLPlpgSQLASTReturnStatement new
					queryExecute: tokens fourth;
					yourself.
		tokens fifth ifNotNil: [ 
			stmt usingExpressions: (tokens fifth second reject: [ :item | item = $, ]) ].
		stmt ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlReturnForm5 [
	^ super plpgsqlReturnForm5 ==> [ :tokens |
		PSQLPlpgSQLASTReturnStatement new ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlRowTypeDeclaration [
	^ super plpgsqlRowTypeDeclaration ==> [ :tokens |
		PSQLPlpgSQLASTRowTypeDeclaration new
			identifier: tokens first;
			tableIdentifier: tokens second;
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlSearchedCase [
	^ super plpgsqlSearchedCase ==> [ :tokens |
		PSQLPlpgSQLASTSearchedCase new
			searchedExpression: tokens second;
			conditionsToStatements: (tokens third collect: [ :subTokens |
				(subTokens second reject: [ :item | item = $, ]) -> subTokens fourth ]);
			elseStatements: (tokens fourth ifNotNil: #second);
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlSimpleCase [
	^ super plpgsqlSimpleCase ==> [ :tokens |
		PSQLPlpgSQLASTSimpleCase new
			conditionToStatements: (tokens second collect: [ :subTokens | subTokens second -> subTokens fourth ]);
			elseStatements: (tokens third ifNotNil: #second);
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlStatements [
	^ super plpgsqlStatements ==> [ :tokens |
		OrderedCollection new
			add: tokens first;
			addAll: (tokens second collect: #third);
			yourself ]
]

{ #category : #plpgsql }
PSQLASTBuilder >> plpgsqlWhileLoop [
	^ super plpgsqlWhileLoop ==> [ :tokens |
		PSQLPlpgSQLASTWhileLoop new
			beginLabel: tokens first;
			endLabel: tokens last;
			condition: tokens third;
			statements: tokens fifth;
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

{ #category : #'update command' }
PSQLASTBuilder >> updateCommand [
	^ super updateCommand ==> [ :tokens |
		PSQLASTUpdateQuery new
			withClause: tokens first;
			hasOnly: tokens third isNotNil;
			tableName: tokens fourth;
			areDescendantTablesIncluded: tokens fifth isNotNil;
			alias: (tokens sixth ifNotNil: #second);
			setClause: tokens seventh;
			fromClause: tokens eighth;
			whereClause: tokens ninth;
			returningClause: tokens last;
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

{ #category : #'delete command' }
PSQLASTBuilder >> usingClause [
	^ super usingClause ==> [ :tokens |
		tokens second ]
]

{ #category : #'values command' }
PSQLASTBuilder >> valuesCommand [
	^ super valuesCommand ==> [ :tokens |
		tokens second
			reject: [ :item | item = $, ]
			thenCollect: [ :item | 
				item first second
					reject: [ :subitem | subitem = $, ]
					thenCollect: [ :subItem |
						subItem first = 'DEFAULT'
							ifTrue: [ PSQLASTDefaultValue new ]
							ifFalse: [ subItem first ] ] ] ]
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
