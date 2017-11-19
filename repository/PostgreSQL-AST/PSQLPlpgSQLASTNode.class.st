"
I am an abstract AST node of a PL/pgSQL procedure.
"
Class {
	#name : #PSQLPlpgSQLASTNode,
	#superclass : #PSQLASTNode,
	#category : #PostgreSQL-AST
}

{ #category : #printing }
PSQLPlpgSQLASTNode >> innerPrintOn: aStream [
	"To override if needed."
]

{ #category : #printing }
PSQLPlpgSQLASTNode >> printOn: aStream [
	super printOn: aStream.
	aStream
		<< $(.
	self innerPrintOn: aStream.
	aStream
		<< $)
]
