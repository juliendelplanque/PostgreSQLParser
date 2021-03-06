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
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTWhileLoop >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTWhileLoop: self
]

{ #category : #accessing }
PSQLPlpgSQLASTWhileLoop >> condition [
	^ condition
]

{ #category : #accessing }
PSQLPlpgSQLASTWhileLoop >> condition: anObject [
	condition := anObject
]

{ #category : #testing }
PSQLPlpgSQLASTWhileLoop >> isWhileLoop [
	^ true
]
