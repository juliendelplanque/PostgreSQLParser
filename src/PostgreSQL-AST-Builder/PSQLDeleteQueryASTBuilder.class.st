"
I process DELETE query source code as input and build an AST using PSQLASTNode subclasses.
"
Class {
	#name : #PSQLDeleteQueryASTBuilder,
	#superclass : #PSQLDeleteQueryGrammar,
	#traits : 'PSQLTExpressionDependingBuilder',
	#classTraits : 'PSQLTExpressionDependingBuilder classTrait',
	#category : #'PostgreSQL-AST-Builder'
}

{ #category : #accessing }
PSQLDeleteQueryASTBuilder class >> sharedParser [
	^ PSQLSharedASTBuilder
]

{ #category : #accessing }
PSQLDeleteQueryASTBuilder class >> tokenParser [
	^ PSQLTokenASTBuilder
]

{ #category : #accessing }
PSQLDeleteQueryASTBuilder >> deleteCommand [
	^ super deleteCommand psqlASTBuild: [ :tokens |
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

{ #category : #accessing }
PSQLDeleteQueryASTBuilder >> usingClause [
	^ super usingClause
		psqlASTBuild: [ :tokens | 
			PSQLASTUsingClause new
				list:
					(tokens second
						collect: [ :item | 
							item second
								ifNil: [ item first ]
								ifNotNil: [ :alias | 
									alias
										definition: item first;
										yourself ] ]);
				yourself ]
]
