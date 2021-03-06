"
I process PL/pgSQL source code as input and build an AST using PSQLASTNode subclasses.
"
Class {
	#name : #PSQLPlpgSQLASTBuilder,
	#superclass : #PSQLPlpgSQLGrammar,
	#traits : 'PSQLTExpressionDependingBuilder',
	#classTraits : 'PSQLTExpressionDependingBuilder classTrait',
	#category : #'PostgreSQL-AST-Builder'
}

{ #category : #accessing }
PSQLPlpgSQLASTBuilder class >> crudQueryParser [
	^ PSQLCRUDQueryASTBuilder
]

{ #category : #accessing }
PSQLPlpgSQLASTBuilder class >> expressionParser [
	^ PSQLExpressionASTBuilder
]

{ #category : #accessing }
PSQLPlpgSQLASTBuilder class >> selectQueryParser [
	^ PSQLSelectQueryASTBuilder
]

{ #category : #accessing }
PSQLPlpgSQLASTBuilder class >> tokenParser [
	^ PSQLTokenASTBuilder
]

{ #category : #declaration }
PSQLPlpgSQLASTBuilder >> argument [
	^ super argument
		psqlASTBuild: [ :tokens | 
			PSQLASTArgument new
				parameterName: (tokens first ifNotNil: [ :t | t first]);
				parameterValue: tokens second;
				yourself ]
]

{ #category : #conditional }
PSQLPlpgSQLASTBuilder >> exceptionCase [
	^ super exceptionCase
		psqlASTBuild: [ :tokens | 
			PSQLASTExceptionCase new
				exception: tokens first;
				statements: (tokens third reject: #isNil); "When there is no statement in the handler, it is nil so we reject the nils."
				yourself ]
]

{ #category : #declaration }
PSQLPlpgSQLASTBuilder >> plpgsqlAliasDeclaration [
	^ super plpgsqlAliasDeclaration psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTAliasDeclaration new
			identifier: tokens first;
			aliased: tokens fourth;
			yourself ]
]

{ #category : #loop }
PSQLPlpgSQLASTBuilder >> plpgsqlArrayLoop [
	^ super plpgsqlArrayLoop psqlASTBuild: [ :tokens |
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
	^ super plpgsqlAssignmentLeftPart psqlASTBuild: [ :tokens |
			|target|
			target := tokens first.
			tokens second do: [ :subTokens | "First manage attribute access."
				target := PSQLASTAttributeAccess new
								accessed: target;
								attributeIdentifier: subTokens second;
								startPosition: target startPosition;
								endPosition: subTokens second endPosition;
								yourself ].
			tokens third do: [ :subscriptTokens | "Then manage subscripts."
				target := PSQLASTSubscript new
								target: target;
								subscriptExpression: subscriptTokens second;
								startPosition: target startPosition;
								endPosition: subscriptTokens second endPosition;
								yourself ].
			target ]
]

{ #category : #statement }
PSQLPlpgSQLASTBuilder >> plpgsqlAssignmentStatement [
	^ super plpgsqlAssignmentStatement psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTAssignment new
			target: tokens first;
			operator: tokens second;
			toAssign: tokens third;
			yourself ]
]

{ #category : #label }
PSQLPlpgSQLASTBuilder >> plpgsqlBeginLabel [
	^ super plpgsqlBeginLabel psqlASTBuild: [ :tokens | tokens second ]
]

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlBlock [
	^ super plpgsqlBlock psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTBlock new
			label: tokens first;
			declarations: (tokens second ifNotNil: #second);
			statements: (tokens fourth reject: #isNil);
			yourself ]
]

{ #category : #declaration }
PSQLPlpgSQLASTBuilder >> plpgsqlClassicDeclaration [
	^ super plpgsqlClassicDeclaration psqlASTBuild: [ :tokens |
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
	^ super plpgsqlContinueStatement psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTContinue new
			label: tokens second;
			whenExpression: tokens third ;
			yourself ]
]

{ #category : #declaration }
PSQLPlpgSQLASTBuilder >> plpgsqlCopyTypeDeclaration [
	^ super plpgsqlCopyTypeDeclaration
		psqlASTBuild: [ :tokens |
			PSQLPlpgSQLASTCopyTypeDeclaration new
				identifier: tokens first;
				accessToCopyType:
					(PSQLASTAttributeAccess new
						accessed: tokens second;
						attributeIdentifier: tokens fourth;
						startPosition: tokens second startPosition;
						endPosition: tokens fourth endPosition;
						yourself);
				yourself ]
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlCursorClose [
	^ super plpgsqlCursorClose psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTCursorClose new
			cursorIdentifier: tokens second;
			yourself ]
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlCursorDeclaration [
	^ super plpgsqlCursorDeclaration token psqlASTBuild: [ :petitTokens |
		|tokens|
		tokens := petitTokens parsedValue.
		PSQLPlpgSQLASTCursorDeclaration new
			identifier: tokens first;
			scroll: (tokens second
						ifNil: [ true ]
						ifNotNil: [ :subTokens | subTokens first isNil ]);
			arguments: (tokens fourth
							ifNil: [ #() ]
							ifNotNil: [ :subTokens | 
								tokens fourth flattened select: [ :n | n class = PSQLPlpgSQLASTCursorParameter ] ]);
			selectQuery: tokens sixth;
			yourself ]
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlCursorDeclarationParameter [
	^ super plpgsqlCursorDeclarationParameter psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTCursorParameter new
			parameterName: tokens first;
			type: tokens second;
			yourself ]
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlCursorDeclarationParameterType [
	^ super plpgsqlCursorDeclarationParameterType psqlASTBuild: [ :tokens |
		(PSQLASTIdentifier identifier: (tokens joinUsing: ' ')) ]
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlCursorDelete [
	^ super plpgsqlCursorDelete psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTCursorDelete new
			tableIdentifier: tokens third;
			cursorIdentifier: tokens seventh;
			yourself ]
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlCursorFetch [
	^ super plpgsqlCursorFetch
		psqlASTBuild: [ :tokens | 
			PSQLPlpgSQLASTCursorFetch new
				direction: (tokens second ifNotNil: #first);
				isFrom: (tokens second ifNotNil: [ :array | array second asUppercase = 'FROM' ]);
				cursorIdentifier:
					(PSQLASTAttributeAccess new
						accessed: tokens third;
						startPosition: tokens third startPosition;
						endPosition: tokens third endPosition;
						yourself);
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
	^ super plpgsqlCursorMove psqlASTBuild: [ :tokens |
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
	^ super plpgsqlDeclarationType token psqlASTBuild: [ :petitToken |
		|tokens|
		tokens := petitToken parsedValue.
		PSQLPlpgSQLASTType new
					identifier: (PSQLASTIdentifier new
										identifier: (tokens sixth joinUsing: ' ');
										startPosition: petitToken start;
										endPosition: petitToken stop;
										yourself);
					size: (tokens seventh ifNotNil: [ :array | array second content asNumber ]);
					dimensions: (tokens eighth ifNotNil: [ :array | array size ]);
					yourself ]
]

{ #category : #declaration }
PSQLPlpgSQLASTBuilder >> plpgsqlDeclarations [
	^ super plpgsqlDeclarations psqlASTBuild: [ :tokens |
		tokens first reject: [ :item | item = $; ] ]
]

{ #category : #declaration }
PSQLPlpgSQLASTBuilder >> plpgsqlDeclareExceptionHandler [
	^ super plpgsqlDeclareExceptionHandler psqlASTBuild: [ :tokens | 
			Halt now ]
]

{ #category : #conditional }
PSQLPlpgSQLASTBuilder >> plpgsqlExceptionHandler [
	^ super plpgsqlExceptionHandler
		psqlASTBuild: [ :tokens | 
			PSQLASTExceptionHandler new
				declarations: (tokens second ifNotNil: #second);
				statements: tokens fourth;
				exceptionCases: tokens sixth;
				yourself ]
]

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlExitStatement [
	^ super plpgsqlExitStatement
		psqlASTBuild: [ :tokens | 
			PSQLPlpgSQLASTExit new
				label: tokens first;
				booleanExpression: tokens third;
				yourself ]
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlFetchCursorDirection [
	^ super plpgsqlFetchCursorDirection psqlASTBuild: [ :tokens |
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
	^ super plpgsqlForLoop psqlASTBuild: [ :tokens |
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
	^ super plpgsqlIfThen psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTIf new
			conditionToStatements: { 
				(PSQLPlpgSQLASTConditionToStatements condition: tokens second statements: tokens fourth)
					startPosition: tokens second startPosition;
					endPosition: tokens fourth last endPosition;
					yourself };
			yourself ]
]

{ #category : #conditional }
PSQLPlpgSQLASTBuilder >> plpgsqlIfThenElse [
	^ super plpgsqlIfThenElse psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTIf new
			conditionToStatements: { 
				(PSQLPlpgSQLASTConditionToStatements condition: tokens second statements: tokens fourth)
					startPosition: tokens second startPosition;
					endPosition: tokens fourth last endPosition;
					yourself };
			elseStatements: tokens sixth;
			yourself ]
]

{ #category : #conditional }
PSQLPlpgSQLASTBuilder >> plpgsqlIfThenElsif [
	^ super plpgsqlIfThenElsif psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTIf new
			conditionToStatements: { 
				(PSQLPlpgSQLASTConditionToStatements condition: tokens second statements: tokens fourth)
					startPosition: tokens second startPosition;
					endPosition: tokens fourth last endPosition;
					yourself } , (tokens fifth collect: [ :subTokens |
						(PSQLPlpgSQLASTConditionToStatements condition: subTokens second statements: subTokens fourth)
							startPosition: subTokens second startPosition;
							endPosition: subTokens fourth last endPosition;
							yourself ]);
			elseStatements: (tokens sixth ifNotNil: #second);
			yourself ]
]

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlIndexParameter [
	^ super plpgsqlIndexParameter psqlASTBuild: [ :tokens | 
		PSQLASTIdentifier new
			identifier: '$',(String newFrom: tokens second);
			yourself ]
]

{ #category : #label }
PSQLPlpgSQLASTBuilder >> plpgsqlLabel [
	^ super plpgsqlLabel psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTBlockLabel labelContent: tokens identifier ]
]

{ #category : #loop }
PSQLPlpgSQLASTBuilder >> plpgsqlLoopLoop [
	^ super plpgsqlLoopLoop psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTLoop new
			beginLabel: tokens first;
			endLabel: tokens last;
			statements: tokens third;
			yourself ]
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlMoveCursorDirection [
	^ super plpgsqlMoveCursorDirection psqlASTBuild: [ :tokens |
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
	^ super plpgsqlOpenCursorBounded
		psqlASTBuild: [ :tokens | 
			PSQLPlpgSQLASTCursorOpen new
				cursorIdentifier:
					(PSQLASTAttributeAccess new
						accessed: tokens second;
						startPosition: tokens second startPosition;
						endPosition: tokens second endPosition;
						yourself);
				arguments: (tokens third ifNotNil: [ :t | t second reject: #isCharacter ]);
				yourself ]
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlOpenCursorForExecute [
	^ super plpgsqlOpenCursorForExecute
		psqlASTBuild: [ :tokens | 
			PSQLPlpgSQLASTCursorOpenForExecute new
				cursorIdentifier: tokens second;
				scroll:
					(tokens third ifNil: [ true ] ifNotNil: [ :subTokens | subTokens first isNil ]);
				executeStatement: tokens fifth;
				yourself ]
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlOpenCursorForQuery [
	^ super plpgsqlOpenCursorForQuery psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTCursorOpenForQuery new
			cursorIdentifier: tokens second;
			scroll: (tokens third
						ifNil: [ true ]
						ifNotNil: [ :subTokens | subTokens first isNil ]);
			selectQuery: tokens fifth;
			yourself ]
]

{ #category : #cursor }
PSQLPlpgSQLASTBuilder >> plpgsqlPerformStatement [
	^ super plpgsqlPerformStatement
		psqlASTBuild: [ :tokens | 
			PSQLPlpgSQLASTPerform new
				code: tokens second;
				yourself ]
]

{ #category : #loop }
PSQLPlpgSQLASTBuilder >> plpgsqlQueryResultsLoop [
	^ super plpgsqlQueryResultsLoop psqlASTBuild: [ :tokens |
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
	^ super plpgsqlRaiseStatement1 psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTRaiseStatement new
			level: tokens second;
			formatString: tokens third;
			formatExpressions: (tokens fourth reject: [ :item | item = $, or: [ item isArray and: [ item isEmpty ] ] ] thenCollect: [ :array | array first ]);
			usingAssocs: tokens fifth;
			yourself ]
]

{ #category : #raise }
PSQLPlpgSQLASTBuilder >> plpgsqlRaiseStatement2 [
	^ super plpgsqlRaiseStatement2 psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTRaiseStatement new
			level: tokens second;
			conditionName: tokens third;
			usingAssocs: tokens fourth;
			yourself ]
]

{ #category : #raise }
PSQLPlpgSQLASTBuilder >> plpgsqlRaiseStatement3 [
	^ super plpgsqlRaiseStatement3 psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTRaiseStatement new
			level: tokens second;
			sqlState: tokens fourth;
			usingAssocs: tokens fifth;
			yourself ]
]

{ #category : #raise }
PSQLPlpgSQLASTBuilder >> plpgsqlRaiseStatement4 [
	^ super plpgsqlRaiseStatement4 psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTRaiseStatement new
			level: tokens second;
			usingAssocs: tokens third;
			yourself ]
]

{ #category : #raise }
PSQLPlpgSQLASTBuilder >> plpgsqlRaiseStatement5 [
	^ super plpgsqlRaiseStatement5 psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTRaiseStatement new ]
]

{ #category : #raise }
PSQLPlpgSQLASTBuilder >> plpgsqlRaiseUsingOptions [
	^ super plpgsqlRaiseUsingOptions psqlASTBuild: [ :tokens |
		tokens second reject: [ :item  | item = $, ] thenCollect: [ :arr |
			arr first first -> arr first third ] ]
]

{ #category : #declaration }
PSQLPlpgSQLASTBuilder >> plpgsqlRecordDeclaration [
	^ super plpgsqlRecordDeclaration psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTRecordDeclaration new
			identifier: tokens first;
			yourself ]
]

{ #category : #return }
PSQLPlpgSQLASTBuilder >> plpgsqlReturnForm1 [
	^ super plpgsqlReturnForm1 psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTReturnStatement new
			expression: tokens second;
			yourself ]
]

{ #category : #return }
PSQLPlpgSQLASTBuilder >> plpgsqlReturnForm2 [
	^ super plpgsqlReturnForm2 psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTReturnStatement new
			expression: tokens third;
			isReturnNext: true;
			yourself ]
]

{ #category : #return }
PSQLPlpgSQLASTBuilder >> plpgsqlReturnForm3 [
	^ super plpgsqlReturnForm3 psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTReturnStatement new
			query: tokens third;
			yourself ]
]

{ #category : #return }
PSQLPlpgSQLASTBuilder >> plpgsqlReturnForm4 [
	^ super plpgsqlReturnForm4 psqlASTBuild: [ :tokens |
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
	^ super plpgsqlReturnForm5 psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTReturnStatement new ]
]

{ #category : #declaration }
PSQLPlpgSQLASTBuilder >> plpgsqlRowTypeDeclaration [
	^ super plpgsqlRowTypeDeclaration psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTRowTypeDeclaration new
			identifier: tokens first;
			tableIdentifier: tokens second;
			yourself ]
]

{ #category : #conditional }
PSQLPlpgSQLASTBuilder >> plpgsqlSearchedCase [
	^ super plpgsqlSearchedCase psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTSearchedCase new
			searchedExpression: tokens second;
			conditionsToStatements: (tokens third collect: [ :subTokens |
				PSQLPlpgSQLASTCasesToStatements cases: (subTokens second reject: [ :item | item = $, ]) statements: subTokens fourth ]);
			elseStatements: (tokens fourth ifNotNil: #second);
			yourself ]
]

{ #category : #conditional }
PSQLPlpgSQLASTBuilder >> plpgsqlSimpleCase [
	^ super plpgsqlSimpleCase psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTSimpleCase new
			conditionToStatements: (tokens second collect: [ :subTokens |
				(PSQLPlpgSQLASTConditionToStatements condition: subTokens first statements: subTokens third)
					startPosition: subTokens first startPosition;
					endPosition: subTokens third last endPosition;
					yourself ]);
			elseStatements: (tokens third ifNotNil: #second);
			yourself ]
]

{ #category : #statement }
PSQLPlpgSQLASTBuilder >> plpgsqlStatements [
	^ super plpgsqlStatements psqlASTBuild: [ :tokens |
		OrderedCollection new
			add: tokens first;
			addAll: (tokens second collect: #third);
			yourself ]
]

{ #category : #loop }
PSQLPlpgSQLASTBuilder >> plpgsqlWhileLoop [
	^ super plpgsqlWhileLoop psqlASTBuild: [ :tokens |
		PSQLPlpgSQLASTWhileLoop new
			beginLabel: tokens first;
			endLabel: tokens last;
			condition: tokens third;
			statements: tokens fifth;
			yourself ]
]
