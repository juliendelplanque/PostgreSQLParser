"
I process PL/pgSQL source code as input and build an AST using PSQLASTNode subclasses.
"
Class {
	#name : #PSQLPlpgSQLASTBuilder,
	#superclass : #PSQLPlpgSQLGrammar,
	#category : #PostgreSQL-AST-Builder
}

{ #category : #accessing }
PSQLPlpgSQLASTBuilder class >> crudQueryParser [
	^ PSQLCRUDQueryASTBuilder
]

{ #category : #accessing }
PSQLPlpgSQLASTBuilder class >> selectQueryParser [
	^ PSQLSelectQueryASTBuilder
]

{ #category : #accessing }
PSQLPlpgSQLASTBuilder class >> sqlParser [
	^ PSQLExpressionASTBuilder
]

{ #category : #accessing }
PSQLPlpgSQLASTBuilder class >> tokenParser [
	^ PSQLTokenASTBuilder
]

{ #category : #declaration }
PSQLPlpgSQLASTBuilder >> plpgsqlAliasDeclaration [
	^ super plpgsqlAliasDeclaration ==> [ :tokens |
		PSQLPlpgSQLASTAliasDeclaration new
			identifier: tokens first;
			aliased: tokens fourth;
			yourself ]
]

{ #category : #loop }
PSQLPlpgSQLASTBuilder >> plpgsqlArrayLoop [
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

{ #category : #statement }
PSQLPlpgSQLASTBuilder >> plpgsqlAssignmentLeftPart [
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

{ #category : #statement }
PSQLPlpgSQLASTBuilder >> plpgsqlAssignmentStatement [
	^ super plpgsqlAssignmentStatement ==> [ :tokens |
		PSQLPlpgSQLASTAssignment new
			target: tokens first;
			operator: tokens second;
			toAssign: tokens third;
			yourself ]
]

{ #category : #label }
PSQLPlpgSQLASTBuilder >> plpgsqlBeginLabel [
	^ super plpgsqlBeginLabel ==> [ :tokens | tokens second ]
]

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlBlock [
	^ super plpgsqlBlock ==> [ :tokens |
		PSQLPlpgSQLASTBlock new
			label: tokens first;
			declarations: (tokens second ifNotNil: #second);
			statements: tokens fourth;
			yourself ]
]

{ #category : #declaration }
PSQLPlpgSQLASTBuilder >> plpgsqlClassicDeclaration [
	^ super plpgsqlClassicDeclaration ==> [ :tokens |
		PSQLPlpgSQLASTClassicDeclaration new
			identifier: tokens first;
			isConstant: tokens second isNotNil;
			type: tokens third;
			isNotNull: tokens fourth isNotNil;
			defaultExpression: (tokens fifth ifNotNil: #second);
			yourself ]
]

{ #category : #statement }
PSQLPlpgSQLASTBuilder >> plpgsqlContinueStatement [
	^ super plpgsqlContinueStatement ==> [ :tokens |
		PSQLPlpgSQLASTContinue new
			label: tokens second;
			whenExpression: tokens third second;
			yourself ]
]

{ #category : #declaration }
PSQLPlpgSQLASTBuilder >> plpgsqlCopyTypeDeclaration [
	^ super plpgsqlCopyTypeDeclaration ==> [ :tokens |
		PSQLPlpgSQLASTCopyTypeDeclaration new
			identifier: tokens first;
			accessToCopyType: (PSQLASTAttributeAccess new
											attributeIdentifier: tokens second;
											accessed: tokens fourth;
											yourself);
			yourself ]
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlCursorClose [
	^ super plpgsqlCursorClose ==> [ :tokens |
		PSQLPlpgSQLASTCursorClose new
			cursorIdentifier: tokens second;
			yourself ]
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlCursorDeclaration [
	^ super plpgsqlCursorDeclaration ==> [ :tokens |
		PSQLPlpgSQLASTCursorDeclaration new
			identifier: tokens first;
			scroll: (tokens second
						ifNil: [ true ]
						ifNotNil: [ :subTokens | subTokens first isNil ]);
			arguments: (tokens fourth
							ifNil: [ #() ]
							ifNotNil: [ :subTokens | 
								(subTokens second reject: [ :item | item = $, ])
									collect: [ :item | 
										PSQLASTColumnDefinition new
											columnName: item first first;
											type: (PSQLASTIdentifier identifier: (item first second joinUsing: ' '));
											yourself
										 ] ]);
			selectQuery: tokens sixth;
			yourself ]
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlCursorDelete [
	^ super plpgsqlCursorDelete ==> [ :tokens |
		PSQLPlpgSQLASTCursorDelete new
			tableIdentifier: tokens third;
			cursorIdentifier: tokens seventh;
			yourself ]
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlCursorFetch [
	^ super plpgsqlCursorFetch ==> [ :tokens |
		PSQLPlpgSQLASTCursorFetch new
			direction: (tokens second ifNotNil: #first);
			isFrom: (tokens second ifNotNil: [ :array | array second asUppercase = 'FROM' ]);
			cursorIdentifier: tokens third;
			targets: (tokens fifth reject: [ :item | item = $, ]);
			yourself ]
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlCursorForLoop [
	self flag: 'TODO'.
	^ super plpgsqlCursorForLoop
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlCursorMove [
	^ super plpgsqlCursorMove ==> [ :tokens |
		PSQLPlpgSQLASTCursorMove new
			direction: (tokens second ifNotNil: #first);
			isFrom: (tokens second ifNotNil: [ :array | array second asUppercase = 'FROM' ]);
			cursorIdentifier: tokens third;
			yourself ]
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlCursorUpdate [
	self flag: 'TODO'.
	^ super plpgsqlCursorUpdate
]

{ #category : #declaration }
PSQLPlpgSQLASTBuilder >> plpgsqlDeclarationType [
	^ super plpgsqlDeclarationType ==> [ :tokens |
		PSQLPlpgSQLASTType new
					identifier: (PSQLASTIdentifier new
										identifier: (tokens sixth joinUsing: ' ');
										yourself);
					size: (tokens seventh ifNotNil: [ :array | array second content asNumber ]);
					dimensions: (tokens eighth ifNotNil: [ :array | array size ]);
					yourself ]
]

{ #category : #declaration }
PSQLPlpgSQLASTBuilder >> plpgsqlDeclarations [
	^ super plpgsqlDeclarations ==> [ :tokens |
		tokens first reject: [ :item | item = $; ] ]
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlFetchCursorDirection [
	^ super plpgsqlFetchCursorDirection ==> [ :tokens |
		tokens isArray
			ifFalse: [
				PSQLPlpgSQLASTCursorFetchDirection new
					name: tokens;
					yourself ]
			ifTrue: [ 
				PSQLPlpgSQLASTCursorFetchDirection new
					name: tokens first;
					count: (tokens second first
								ifNil: [ tokens second second content asNumber ]
								ifNotNil: [ tokens second second content asNumber negated ]);
					yourself ] ]
]

{ #category : #loop }
PSQLPlpgSQLASTBuilder >> plpgsqlForLoop [
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

{ #category : #conditional }
PSQLPlpgSQLASTBuilder >> plpgsqlIfThen [
	^ super plpgsqlIfThen ==> [ :tokens |
		PSQLPlpgSQLASTIf new
			conditionToStatements: { tokens second -> tokens fourth };
			yourself ]
]

{ #category : #conditional }
PSQLPlpgSQLASTBuilder >> plpgsqlIfThenElse [
	^ super plpgsqlIfThenElse ==> [ :tokens |
		PSQLPlpgSQLASTIf new
			conditionToStatements: { tokens second -> tokens fourth };
			elseStatements: tokens sixth;
			yourself ]
]

{ #category : #conditional }
PSQLPlpgSQLASTBuilder >> plpgsqlIfThenElsif [
	^ super plpgsqlIfThenElsif ==> [ :tokens |
		PSQLPlpgSQLASTIf new
			conditionToStatements: { tokens second -> tokens fourth } , (tokens fifth collect: [ :subTokens | subTokens second -> subTokens fourth ]);
			elseStatements: (tokens sixth ifNotNil: #second);
			yourself ]
]

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlIndexParameter [
	^ super plpgsqlIndexParameter ==> [ :tokens | 
		PSQLASTIdentifier new
			identifier: '$',(String newFrom: tokens second);
			yourself ]
]

{ #category : #label }
PSQLPlpgSQLASTBuilder >> plpgsqlLabel [
	^ super plpgsqlLabel ==> [ :tokens |
		PSQLPlpgSQLASTBlockLabel labelContent: tokens identifier ]
]

{ #category : #loop }
PSQLPlpgSQLASTBuilder >> plpgsqlLoopLoop [
	^ super plpgsqlLoopLoop ==> [ :tokens |
		PSQLPlpgSQLASTLoop new
			beginLabel: tokens first;
			endLabel: tokens last;
			statements: tokens third;
			yourself ]
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlMoveCursorDirection [
	^ super plpgsqlMoveCursorDirection ==> [ :tokens |
		tokens isArray
			ifFalse: [
				PSQLPlpgSQLASTCursorMoveDirection new
					name: tokens;
					yourself ]
			ifTrue: [ 
				PSQLPlpgSQLASTCursorMoveDirection new
					name: tokens first;
					count: (tokens second isArray
								ifTrue: [ 
									tokens second first
										ifNil: [ tokens second second content asNumber ]
										ifNotNil: [ tokens second second content asNumber negated ] ]
								ifFalse: [ 'ALL' ]);
					yourself ] ]
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlOpenCursorBounded [
	self flag: 'TODO'.
	^ super plpgsqlOpenCursorBounded
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlOpenCursorForExecute [
	self flag: 'TODO'.
	^ super plpgsqlOpenCursorForExecute
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlOpenCursorForQuery [
	^ super plpgsqlOpenCursorForQuery ==> [ :tokens |
		PSQLPlpgSQLASTCursorOpenForQuery new
			cursorIdentifier: tokens second;
			scroll: (tokens third
						ifNil: [ true ]
						ifNotNil: [ :subTokens | subTokens first isNil ]);
			selectQuery: tokens fifth;
			yourself ]
]

{ #category : #loop }
PSQLPlpgSQLASTBuilder >> plpgsqlQueryResultsLoop [
	^ super plpgsqlQueryResultsLoop ==> [ :tokens |
		PSQLPlpgSQLASTQueryResultsLoop new
			beginLabel: tokens first;
			endLabel: tokens last;
			statements: tokens seventh;
			target: tokens third;
			query: tokens fifth;
			yourself ]
]

{ #category : #raise }
PSQLPlpgSQLASTBuilder >> plpgsqlRaiseStatement1 [
	^ super plpgsqlRaiseStatement1 ==> [ :tokens |
		PSQLPlpgSQLASTRaiseStatement new
			level: tokens second;
			formatString: tokens third;
			formatExpressions: (tokens fourth reject: [ :item | item = $, or: [ item isArray and: [ item isEmpty ] ] ]);
			usingAssocs: tokens fifth;
			yourself ]
]

{ #category : #raise }
PSQLPlpgSQLASTBuilder >> plpgsqlRaiseStatement2 [
	^ super plpgsqlRaiseStatement2 ==> [ :tokens |
		PSQLPlpgSQLASTRaiseStatement new
			level: tokens second;
			conditionName: tokens third;
			usingAssocs: tokens fourth;
			yourself ]
]

{ #category : #raise }
PSQLPlpgSQLASTBuilder >> plpgsqlRaiseStatement3 [
	^ super plpgsqlRaiseStatement3 ==> [ :tokens |
		PSQLPlpgSQLASTRaiseStatement new
			level: tokens second;
			sqlState: tokens fourth;
			usingAssocs: tokens fifth;
			yourself ]
]

{ #category : #raise }
PSQLPlpgSQLASTBuilder >> plpgsqlRaiseStatement4 [
	self flag: 'TODO'.
	^ super plpgsqlRaiseStatement4
]

{ #category : #raise }
PSQLPlpgSQLASTBuilder >> plpgsqlRaiseStatement5 [
	^ super plpgsqlRaiseStatement5 ==> [ :tokens |
		PSQLPlpgSQLASTRaiseStatement new ]
]

{ #category : #raise }
PSQLPlpgSQLASTBuilder >> plpgsqlRaiseUsingOptions [
	^ super plpgsqlRaiseUsingOptions ==> [ :tokens |
		tokens second reject: [ :item  | item = $, ] thenCollect: [ :arr |
			arr first first -> arr first third ] ]
]

{ #category : #declaration }
PSQLPlpgSQLASTBuilder >> plpgsqlRecordDeclaration [
	^ super plpgsqlRecordDeclaration ==> [ :tokens |
		PSQLPlpgSQLASTRecordDeclaration new
			identifier: tokens first;
			yourself ]
]

{ #category : #return }
PSQLPlpgSQLASTBuilder >> plpgsqlReturnForm1 [
	^ super plpgsqlReturnForm1 ==> [ :tokens |
		PSQLPlpgSQLASTReturnStatement new
			expression: tokens second;
			yourself ]
]

{ #category : #return }
PSQLPlpgSQLASTBuilder >> plpgsqlReturnForm2 [
	^ super plpgsqlReturnForm2 ==> [ :tokens |
		PSQLPlpgSQLASTReturnStatement new
			expression: tokens third;
			isReturnNext: true;
			yourself ]
]

{ #category : #return }
PSQLPlpgSQLASTBuilder >> plpgsqlReturnForm3 [
	^ super plpgsqlReturnForm3 ==> [ :tokens |
		PSQLPlpgSQLASTReturnStatement new
			query: tokens third;
			yourself ]
]

{ #category : #return }
PSQLPlpgSQLASTBuilder >> plpgsqlReturnForm4 [
	^ super plpgsqlReturnForm4 ==> [ :tokens |
		|stmt|
		stmt := PSQLPlpgSQLASTReturnStatement new
					queryExecute: tokens fourth;
					yourself.
		tokens fifth ifNotNil: [ 
			stmt usingExpressions: (tokens fifth second reject: [ :item | item = $, ]) ].
		stmt ]
]

{ #category : #return }
PSQLPlpgSQLASTBuilder >> plpgsqlReturnForm5 [
	^ super plpgsqlReturnForm5 ==> [ :tokens |
		PSQLPlpgSQLASTReturnStatement new ]
]

{ #category : #declaration }
PSQLPlpgSQLASTBuilder >> plpgsqlRowTypeDeclaration [
	^ super plpgsqlRowTypeDeclaration ==> [ :tokens |
		PSQLPlpgSQLASTRowTypeDeclaration new
			identifier: tokens first;
			tableIdentifier: tokens second;
			yourself ]
]

{ #category : #conditional }
PSQLPlpgSQLASTBuilder >> plpgsqlSearchedCase [
	^ super plpgsqlSearchedCase ==> [ :tokens |
		PSQLPlpgSQLASTSearchedCase new
			searchedExpression: tokens second;
			conditionsToStatements: (tokens third collect: [ :subTokens |
				(subTokens second reject: [ :item | item = $, ]) -> subTokens fourth ]);
			elseStatements: (tokens fourth ifNotNil: #second);
			yourself ]
]

{ #category : #conditional }
PSQLPlpgSQLASTBuilder >> plpgsqlSimpleCase [
	^ super plpgsqlSimpleCase ==> [ :tokens |
		PSQLPlpgSQLASTSimpleCase new
			conditionToStatements: (tokens second collect: [ :subTokens | subTokens second -> subTokens fourth ]);
			elseStatements: (tokens third ifNotNil: #second);
			yourself ]
]

{ #category : #statement }
PSQLPlpgSQLASTBuilder >> plpgsqlStatements [
	^ super plpgsqlStatements ==> [ :tokens |
		OrderedCollection new
			add: tokens first;
			addAll: (tokens second collect: #third);
			yourself ]
]

{ #category : #loop }
PSQLPlpgSQLASTBuilder >> plpgsqlWhileLoop [
	^ super plpgsqlWhileLoop ==> [ :tokens |
		PSQLPlpgSQLASTWhileLoop new
			beginLabel: tokens first;
			endLabel: tokens last;
			condition: tokens third;
			statements: tokens fifth;
			yourself ]
]
