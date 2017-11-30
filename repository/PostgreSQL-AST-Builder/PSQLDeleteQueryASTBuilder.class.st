"
I process DELETE query source code as input and build an AST using PSQLASTNode subclasses.
"
Class {
	#name : #PSQLDeleteQueryASTBuilder,
	#superclass : #PSQLDeleteQueryGrammar,
	#category : #PostgreSQL-AST-Builder
}

{ #category : #accessing }
PSQLDeleteQueryASTBuilder class >> sharedParser [
	^ PSQLSharedASTBuilder
]

{ #category : #accessing }
PSQLDeleteQueryASTBuilder class >> sqlParser [
	^ PSQLExpressionASTBuilder
]

{ #category : #accessing }
PSQLDeleteQueryASTBuilder class >> tokenParser [
	^ PSQLTokenASTBuilder
]

{ #category : #'delete command' }
PSQLDeleteQueryASTBuilder >> deleteCommand [
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

{ #category : #'delete command' }
PSQLDeleteQueryASTBuilder >> usingClause [
	^ super usingClause ==> [ :tokens |
		tokens second ]
]
