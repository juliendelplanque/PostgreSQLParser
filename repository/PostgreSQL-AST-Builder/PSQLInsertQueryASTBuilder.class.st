"
I process INSERT query source code as input and build an AST using PSQLASTNode subclasses.
"
Class {
	#name : #PSQLInsertQueryASTBuilder,
	#superclass : #PSQLInsertQueryGrammar,
	#category : #PostgreSQL-AST-Builder
}

{ #category : #accessing }
PSQLInsertQueryASTBuilder class >> sharedParser [
	^ PSQLSharedASTBuilder
]

{ #category : #accessing }
PSQLInsertQueryASTBuilder class >> sqlParser [
	^ PSQLASTBuilder
]

{ #category : #accessing }
PSQLInsertQueryASTBuilder class >> valuesCommandParser [
	^ PSQLValuesASTBuilder
]

{ #category : #'insert command' }
PSQLInsertQueryASTBuilder >> conflictAction [
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
PSQLInsertQueryASTBuilder >> defaultValues [
	^ super defaultValues ==> [ :tokens |
		PSQLASTDefaultValues new ]
]

{ #category : #helpers }
PSQLInsertQueryASTBuilder >> identifier [
	^ (self dependencyAt: PSQLASTBuilder) identifier
]

{ #category : #helpers }
PSQLInsertQueryASTBuilder >> identifierOrKeyword [
	^ (self dependencyAt: PSQLASTBuilder) identifierOrKeyword
]

{ #category : #helpers }
PSQLInsertQueryASTBuilder >> identifierWithOptionalFieldAccess [
	^ (self dependencyAt: PSQLASTBuilder) identifierWithOptionalFieldAccess
]

{ #category : #'insert command' }
PSQLInsertQueryASTBuilder >> insertCommand [
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

{ #category : #'insert command' }
PSQLInsertQueryASTBuilder >> onConflictClause [
	^ super onConflictClause ==> [ :tokens |
		PSQLASTOnConflictClause new
			target: tokens third;
			action: tokens fourth;
			yourself ]
]
