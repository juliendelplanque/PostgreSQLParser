"
I process UPDATE query source code as input and build an AST using PSQLASTNode subclasses.
"
Class {
	#name : #PSQLUpdateQueryASTBuilder,
	#superclass : #PSQLUpdateQueryGrammar,
	#category : #PostgreSQL-AST-Builder
}

{ #category : #accessing }
PSQLUpdateQueryASTBuilder class >> fromClauseParser [
	^ PSQLFromClauseASTBuilder
]

{ #category : #accessing }
PSQLUpdateQueryASTBuilder class >> sharedParser [
	^ PSQLSharedASTBuilder
]

{ #category : #accessing }
PSQLUpdateQueryASTBuilder class >> sqlParser [
	^ PSQLASTBuilder
]

{ #category : #accessing }
PSQLUpdateQueryASTBuilder >> start [
	^ updateCommand end
]

{ #category : #'update command' }
PSQLUpdateQueryASTBuilder >> updateCommand [
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
