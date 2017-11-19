"
I am the AST node for a WHILE loop.
Additionally to my parent's properties I hold a condition.
"
Class {
	#name : #PSQLPlpgSQLASTWhileLoop,
	#superclass : #PSQLPlpgSQLASTLoop,
	#instVars : [
		'condition'
	],
	#category : #PostgreSQL-AST
}

{ #category : #accessing }
PSQLPlpgSQLASTWhileLoop >> condition [
	^ condition
]

{ #category : #accessing }
PSQLPlpgSQLASTWhileLoop >> condition: anObject [
	condition := anObject
]
