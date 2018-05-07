"
I process SELECT and SELECT INTO query source code as input and build an AST using PSQLASTNode subclasses.
"
Class {
	#name : #PSQLSelectQueryASTBuilder,
	#superclass : #PSQLSelectQueryGrammar,
	#category : #'PostgreSQL-AST-Builder'
}

{ #category : #accessing }
PSQLSelectQueryASTBuilder class >> fromClauseParser [
	^ PSQLFromClauseASTBuilder
]

{ #category : #accessing }
PSQLSelectQueryASTBuilder class >> sharedParser [
	^ PSQLSharedASTBuilder
]

{ #category : #accessing }
PSQLSelectQueryASTBuilder class >> sqlParser [
	^ PSQLExpressionASTBuilder
]

{ #category : #accessing }
PSQLSelectQueryASTBuilder class >> tokenParser [
	^ PSQLTokenASTBuilder
]

{ #category : #'select command' }
PSQLSelectQueryASTBuilder >> allOrDistinctClause [
	^ super allOrDistinctClause psqlASTBuild: [ :tokens |
		tokens isString
			ifTrue: [ PSQLASTAllClause new ]
			ifFalse: [ |node|
				node := PSQLASTDistinctClause new.
				tokens second ifNotNil: [ 
					node
						expressions: (tokens second third reject: [ :item | item = $, ] thenCollect: #first) ].
				node ] ]
]

{ #category : #'select command' }
PSQLSelectQueryASTBuilder >> columnsAndAliasesSelected [
	^ super columnsAndAliasesSelected psqlASTBuild: [ :tokens |
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

{ #category : #'select command' }
PSQLSelectQueryASTBuilder >> fetchClause [
	^ super fetchClause psqlASTBuild: [ :tokens |
		PSQLASTFetchClause new
			isFirst: tokens second asUppercase = 'FIRST';
			count: tokens third;
			yourself ]
]

{ #category : #'select command' }
PSQLSelectQueryASTBuilder >> forClause [
	^ super forClause psqlASTBuild: [ :tokens |
		PSQLASTForClause new
			isUpdate: tokens second asUppercase = 'UPDATE';
			ofTables: (tokens third ifNotNil: [ :array |
				array second reject: [ :item | item = $, ] thenCollect: #first ]);
			isNoWait: tokens fourth isNotNil;
			yourself ]
]

{ #category : #'select command' }
PSQLSelectQueryASTBuilder >> groupByClause [
	^ super groupByClause psqlASTBuild: [ :tokens |
		PSQLASTGroupByClause new
			expressions: (tokens third reject: [ :item | item = $, ] thenCollect: #first);
			yourself ]
]

{ #category : #'select command' }
PSQLSelectQueryASTBuilder >> havingClause [
	^ super havingClause psqlASTBuild: [ :tokens |
		PSQLASTHavingClause new
			expressions: (tokens second reject: [ :item | item = $, ] thenCollect: #first);
			yourself ]
]

{ #category : #'select command' }
PSQLSelectQueryASTBuilder >> intoClause [
	^ super intoClause psqlASTBuild: [ :tokens |
		PSQLASTIntoClause new
			type: (tokens second ifNotNil: #asUppercase);
			hasTable: tokens third isNotNil;
			newTable: tokens fourth;
			yourself ]
]

{ #category : #'select command' }
PSQLSelectQueryASTBuilder >> limitClause [
	^ super limitClause psqlASTBuild: [ :tokens |
		PSQLASTLimitClause new
			limit: (tokens second isString ifTrue: [ PSQLASTAllClause new ] ifFalse: [ tokens second ]);
			yourself ]
]

{ #category : #'select command' }
PSQLSelectQueryASTBuilder >> offsetClause [
	^ super offsetClause psqlASTBuild: [ :tokens |
		PSQLASTOffsetClause new
			offset: tokens second;
			yourself ]
]

{ #category : #'select command' }
PSQLSelectQueryASTBuilder >> selectCommand [
	^ super selectCommand psqlASTBuild: [ :tokens |
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
PSQLSelectQueryASTBuilder >> selectIntoCommandAlternative [
	^ super selectIntoCommandAlternative psqlASTBuild: [ :tokens |
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
PSQLSelectQueryASTBuilder >> selectIntoCommandClassic [
	^ super selectIntoCommandClassic psqlASTBuild: [ :tokens |
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

{ #category : #'select command' }
PSQLSelectQueryASTBuilder >> unionIntersectExceptClause [
	^ super unionIntersectExceptClause psqlASTBuild: [ :tokens |
		({
			'UNION' -> PSQLASTUnionClause.
			'INTERSECT' -> PSQLASTIntersectClause.
			'EXCEPT' -> PSQLASTExceptClause
		} asDictionary at: tokens first asUppercase) new
			isDistinct: (tokens second isNil or: [ tokens second asUppercase = 'DISTINCT' ]);
			selectQuery: tokens third;
			yourself ]
]

{ #category : #'select command' }
PSQLSelectQueryASTBuilder >> whereClause [
	^ super whereClause psqlASTBuild: [ :tokens |
		PSQLASTSelectWhereClause new
			condition: tokens second;
			yourself ]
]
