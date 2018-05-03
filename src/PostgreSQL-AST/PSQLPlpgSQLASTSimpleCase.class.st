"
I am the node representing a simple case condition.
"
Class {
	#name : #PSQLPlpgSQLASTSimpleCase,
	#superclass : #PSQLPlpgSQLASTConditional,
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTSimpleCase >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTSimpleCase: self
]
