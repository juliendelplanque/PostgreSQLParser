"
I process INSERT/SELECT/UPDATE/DELETE query source code as input and build an AST using PSQLASTNode subclasses.
"
Class {
	#name : #PSQLCRUDQueryASTBuilder,
	#superclass : #PSQLCRUDQueryGrammar,
	#category : #PostgreSQL-AST-Builder
}

{ #category : #accessing }
PSQLCRUDQueryASTBuilder class >> deleteQueryParser [
	^ PSQLDeleteQueryASTBuilder
]

{ #category : #accessing }
PSQLCRUDQueryASTBuilder class >> insertQueryParser [
	^ PSQLInsertQueryASTBuilder
]

{ #category : #accessing }
PSQLCRUDQueryASTBuilder class >> selectQueryParser [
	^ PSQLSelectQueryASTBuilder
]

{ #category : #accessing }
PSQLCRUDQueryASTBuilder class >> updateQueryParser [
	^ PSQLUpdateQueryASTBuilder
]
