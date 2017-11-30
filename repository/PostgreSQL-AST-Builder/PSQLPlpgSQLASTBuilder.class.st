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

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlAliasDeclaration [
	^ super plpgsqlAliasDeclaration ==> [ :tokens |
		PSQLPlpgSQLASTAliasDeclaration new
			identifier: tokens first;
			aliased: tokens fourth;
			yourself ]
]

{ #category : #plpgsql }
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

{ #category : #plpgsql }
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

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlAssignmentStatement [
	^ super plpgsqlAssignmentStatement ==> [ :tokens |
		PSQLPlpgSQLASTAssignment new
			target: tokens first;
			operator: tokens second;
			toAssign: tokens third;
			yourself ]
]

{ #category : #plpgsql }
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

{ #category : #plpgsql }
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

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlContinueStatement [
	^ super plpgsqlContinueStatement ==> [ :tokens |
		PSQLPlpgSQLASTContinue new
			label: tokens second;
			whenExpression: tokens third second;
			yourself ]
]

{ #category : #plpgsql }
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

{ #category : #plpgsql }
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

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlDeclarations [
	^ super plpgsqlDeclarations ==> [ :tokens |
		tokens first reject: [ :item | item = $; ] ]
]

{ #category : #plpgsql }
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

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlIfThen [
	^ super plpgsqlIfThen ==> [ :tokens |
		PSQLPlpgSQLASTIf new
			conditionToStatements: { tokens second -> tokens fourth };
			yourself ]
]

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlIfThenElse [
	^ super plpgsqlIfThenElse ==> [ :tokens |
		PSQLPlpgSQLASTIf new
			conditionToStatements: { tokens second -> tokens fourth };
			elseStatements: tokens sixth;
			yourself ]
]

{ #category : #plpgsql }
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

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlLabel [
	^ super plpgsqlLabel ==> [ :tokens |
		PSQLPlpgSQLASTBlockLabel labelContent: tokens identifier ]
]

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlLoopLoop [
	^ super plpgsqlLoopLoop ==> [ :tokens |
		PSQLPlpgSQLASTLoop new
			beginLabel: tokens first;
			endLabel: tokens last;
			statements: tokens third;
			yourself ]
]

{ #category : #plpgsql }
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

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlRaiseStatement1 [
	^ super plpgsqlRaiseStatement1 ==> [ :tokens |
		PSQLPlpgSQLASTRaiseStatement new
			level: tokens second;
			formatString: tokens third;
			formatExpressions: (tokens fourth reject: [ :item | item = $, or: [ item isArray and: [ item isEmpty ] ] ]);
			usingAssocs: tokens fifth;
			yourself ]
]

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlRaiseStatement2 [
	^ super plpgsqlRaiseStatement2 ==> [ :tokens |
		 ]
]

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlRaiseStatement3 [
	^ super plpgsqlRaiseStatement3 ==> [ :tokens |
		 ]
]

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlRaiseStatement4 [
	^ super plpgsqlRaiseStatement4 ==> [ :tokens |
		 ]
]

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlRaiseStatement5 [
	^ super plpgsqlRaiseStatement5 ==> [ :tokens |
		PSQLPlpgSQLASTRaiseStatement new ]
]

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlRaiseUsingOptions [
	^ super plpgsqlRaiseUsingOptions ==> [ :tokens |
		tokens second reject: [ :item  | item = $, ] thenCollect: [ :arr |
			arr first first -> arr first third ] ]
]

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlRecordDeclaration [
	^ super plpgsqlRecordDeclaration ==> [ :tokens |
		PSQLPlpgSQLASTRecordDeclaration new
			identifier: tokens first;
			yourself ]
]

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlReturnForm1 [
	^ super plpgsqlReturnForm1 ==> [ :tokens |
		PSQLPlpgSQLASTReturnStatement new
			expression: tokens second;
			yourself ]
]

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlReturnForm2 [
	^ super plpgsqlReturnForm2 ==> [ :tokens |
		PSQLPlpgSQLASTReturnStatement new
			expression: tokens third;
			isReturnNext: true;
			yourself ]
]

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlReturnForm3 [
	^ super plpgsqlReturnForm3 ==> [ :tokens |
		PSQLPlpgSQLASTReturnStatement new
			query: tokens third;
			yourself ]
]

{ #category : #plpgsql }
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

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlReturnForm5 [
	^ super plpgsqlReturnForm5 ==> [ :tokens |
		PSQLPlpgSQLASTReturnStatement new ]
]

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlRowTypeDeclaration [
	^ super plpgsqlRowTypeDeclaration ==> [ :tokens |
		PSQLPlpgSQLASTRowTypeDeclaration new
			identifier: tokens first;
			tableIdentifier: tokens second;
			yourself ]
]

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlSearchedCase [
	^ super plpgsqlSearchedCase ==> [ :tokens |
		PSQLPlpgSQLASTSearchedCase new
			searchedExpression: tokens second;
			conditionsToStatements: (tokens third collect: [ :subTokens |
				(subTokens second reject: [ :item | item = $, ]) -> subTokens fourth ]);
			elseStatements: (tokens fourth ifNotNil: #second);
			yourself ]
]

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlSimpleCase [
	^ super plpgsqlSimpleCase ==> [ :tokens |
		PSQLPlpgSQLASTSimpleCase new
			conditionToStatements: (tokens second collect: [ :subTokens | subTokens second -> subTokens fourth ]);
			elseStatements: (tokens third ifNotNil: #second);
			yourself ]
]

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlStatements [
	^ super plpgsqlStatements ==> [ :tokens |
		OrderedCollection new
			add: tokens first;
			addAll: (tokens second collect: #third);
			yourself ]
]

{ #category : #plpgsql }
PSQLPlpgSQLASTBuilder >> plpgsqlWhileLoop [
	^ super plpgsqlWhileLoop ==> [ :tokens |
		PSQLPlpgSQLASTWhileLoop new
			beginLabel: tokens first;
			endLabel: tokens last;
			condition: tokens third;
			statements: tokens fifth;
			yourself ]
]
